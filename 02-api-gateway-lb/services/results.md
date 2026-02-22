
## Normal behaviour (round robbin)

for i in {1..9}; do

    curl -s -D - http://localhost:8080/users -o /dev/null | grep -i x-instance
  done

X-Instance-Id: users-instance-1
X-Instance-Id: users-instance-2
X-Instance-Id: users-instance-3
X-Instance-Id: users-instance-1
X-Instance-Id: users-instance-2
X-Instance-Id: users-instance-3
X-Instance-Id: users-instance-1
X-Instance-Id: users-instance-2
X-Instance-Id: users-instance-3


## One instance down
 for i in {1..9}; do
    curl -s -D - http://localhost:8080/users -o /dev/null | grep -i x-instance
  done

X-Instance-Id: users-instance-1
X-Instance-Id: users-instance-3
X-Instance-Id: users-instance-3
X-Instance-Id: users-instance-1
X-Instance-Id: users-instance-3
X-Instance-Id: users-instance-1
X-Instance-Id: users-instance-3
X-Instance-Id: users-instance-1
X-Instance-Id: users-instance-3
