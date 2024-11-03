# Notes
# Gathers data similar to `kubectl cluster-info dump` but with additional types that are catered for, including CRD's

# Get non-namespaced resource details 
for i in `kc api-resources --verbs=list  --namespaced=false -o name`; do kc get -o json $i > $i.json; done

# Get namespaced resource details 
for i in `kc api-resources --verbs=list  --namespaced=true -o name`; do for n in `kc get ns -o name | sed "s:namespace/::" `; do mkdir -p $n; kc get -n $n -o json $i > $n/$i.json; done; done
