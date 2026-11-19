Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=64.215.233.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114421;
	b=NGwHjM9dmb9FQUFOf8JNaqc3vYJUItcg7IXP7NlBTrOZru/p9/QrjM8UuPGcKaidQ7OG
	 l/vCoBpeqmH6ijJlMEmV31JC/ySjryyteIPe6iZKB2TVvmFcTIv8+J95mzaQEgBJ0zyJo
	 HSWxCtZMcgSNVgXXN/ekIaW7LErF7ES/tGyqNOOQwbRivZ1n7/rm62M8DxTPLt5T1HVMA
	 3iIGnLVaQIbYpi5R6/vAwuLVwTrtAqIfZjm9iT8VgCGfe19JIQcBuOHu7T2PjXhL/KCCL
	 44d2sXfjiq0Ep2h8qceb4EnHzq6rZHrsdLuKWGxI6YPfJ5uUq3jvgA0o+jra/ObEVnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114421;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sEQbdvJYwkDv3aKZeq8vEM5NNA7CQxGMnYKt6TroBE4=;
	b=vY5o06N8HblWNGzoN0L55YSw0hZLZ+0SGViRdYeabiuWKurBVfEZ4ux40PZltMz2lnyl
	 0KmVO5offZbks+gEaAawxfS2FDDAzzAITqKfb8tPagyTpkwyuXoAI47cFjfkhOq0jRZAb
	 M8cOyiFqHcm3wjpr+Z8o17VZ/CaJSZdSKzGvWjuwt/bcuCfoANe87ZnEAeeP26YUBjawJ
	 Mxrc7Dgm0rYHqFeoxtClLtA7SQKOqMqbZTV9qY00NxK72uGQkcvbt4E2nUnXVXL/OiNB1
	 bDnNjU5nTU3nh22EB8Ub/WGG3PMvIakCMGhisTK7WgWC5Ojh9bhYT7KTlCWtrvo74Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=janestreet.com;
	spf=pass smtp.mailfrom=janestreet.com;
	dkim=pass header.d=janestreet.com header.i=@janestreet.com header.a=rsa-sha256 header.s=waixah header.b="zz5/C9Zz";
	arc=none smtp.remote-ip=64.215.233.18
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8A606A32A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 18:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1F8A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.a=rsa-sha256 header.s=waixah header.b=zz5/C9Zz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1795114419;
  bh=sEQbdvJYwkDv3aKZeq8vEM5NNA7CQxGMnYKt6TroBE4=;
  h=From:To:Cc:Subject:Date;
  b=zz5/C9Zzf7Sci/c12ncohRgl6pmWjT70XYZ1gIEorEaANHXfdBsHFdqh1dCiUcoPM
  tWs6Xi4eNSNK5qgE+Irpw5KyU13kRWC6ThJ2WlqAy3W19fgBWJTkqM145pGvS0CU5l
  KL+UVGhChWCUiiSGvfM4Zhatdy2oe33k5qaCCHuFVPRCG/4qHNFtT/ljTFMNImJZ8a
  CeTkYG/IEMQsV5VOzk1fDGYdgQwt1/MirTo8G8OEIsRdAtbz+qW5vNSpNQ6iWRzLBX
  U1K39U/CJFeM26HqjuvH0gVbJvBXxUX5XLzZwPf71bjSooTyL/TYRYMiegLfLXs6uV
  JFMpcJ9Bqrq5w==
From: Eric Hagberg <ehagberg@janestreet.com>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun@linux.alibaba.com>,
 	Jan Kara <jack@suse.cz>,
 	Christian Brauner <brauner@kernel.org>,
 	Tejun Heo <tj@kernel.org>,
 	linux-fsdevel@vger.kernel.org,
 	Eric Hagberg <ehagberg@janestreet.com>
Subject: [PATCH 6.12.y] writeback: use a per-sb counter to drain inode wb switches at umount
Date: Thu, 19 Nov 2026 13:53:31 -0500
Message-ID: <20261119185336.1149309-1-ehagberg@janestreet.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun@linux.alibaba.com>

commit 31c1d19ead2c26a63859a2757d8b786765ba9cdd upstream.

Tracking in-flight inode wb switches with a single global counter
(isw_nr_in_flight) plus a synchronize_rcu() based wait in
cgroup_writeback_umount() forces every umount to take a global hit
whenever any other superblock on the system has wb switches in flight,
even if the superblock being unmounted has none of its own.

Replace the global synchronize_rcu()/flush_workqueue() pair with a
per-sb counter, s_isw_nr_in_flight, plus three small helpers:

  - cgroup_writeback_pin(sb)   - increment counter
  - cgroup_writeback_unpin(sb) - decrement and wake drainer if last
  - cgroup_writeback_drain(sb) - wait for counter to reach zero

The wiring is:

  - inode_prepare_wbs_switch() pins before checking SB_ACTIVE and
    grabbing the inode; failure paths unpin before returning.  A
    lockless SB_ACTIVE check at the top of the function lets us skip
    the atomic_inc/smp_mb dance once SB_ACTIVE has been cleared (it
    is monotonic and never set back).
  - process_inode_switch_wbs() unpins after the matching iput().
  - cgroup_writeback_umount() drains the per-sb counter via
    wait_var_event().

The smp_mb() pair between inode_prepare_wbs_switch() and
cgroup_writeback_umount() keeps the SB_ACTIVE / counter ordering:
either the umounter sees a non-zero counter and waits, or the
switcher sees SB_ACTIVE cleared and aborts before grabbing the
inode.

The global isw_nr_in_flight is left in place, since it is still used
to throttle in-flight switches via WB_FRN_MAX_IN_FLIGHT.

The rcu_read_lock() extension in inode_switch_wbs() and
cleanup_offline_cgwb() that the race fix added is no longer needed
and is reverted; the synchronize_rcu() that the race fix added to
cgroup_writeback_umount() is dropped as well.

The following numbers were measured on a 16 vCPU QEMU guest with 4
background superblocks each churning "create memcg -> write 1 MiB ->
rmdir memcg" to keep the global isw_nr_in_flight non-zero.  Latencies
are wall-clock around umount(8); only the target sb's umount is
measured.

Target sb runs its own cgwb churn:

                              p50      p95      p99      max
  global synchronize_rcu()   67.6 ms  88.3 ms  88.3 ms  96.8 ms
  per-sb counter (this)       7.9 ms  10.0 ms  10.0 ms  10.1 ms

Idle target umount latency under cross-sb cgwb-switch pressure:

                              p50      p95      p99      max
  global synchronize_rcu()   62.7 ms  95.4 ms 108.1 ms 108.6 ms
  per-sb counter (this)       5.3 ms   6.9 ms   7.4 ms   7.4 ms
  no-pressure baseline        4.9 ms   5.9 ms   6.3 ms   6.7 ms

8 concurrent umounts of idle sbs under the same pressure:

                              p50      p95      max
  global synchronize_rcu()   61.3 ms  99.5 ms 113.7 ms
  per-sb counter (this)       8.1 ms   9.1 ms   9.5 ms

In-kernel cgroup_writeback_umount() time across the same run
(bpftrace, ~340 calls covering all scenarios):

  global synchronize_rcu()    12371 ms total (~36 ms / call)
  per-sb counter (this)        1.37 ms total ( ~4 us / call)

Suggested-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/r/177910456953.488929.2169908940676707307.b4-review@b4
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
Link: https://patch.msgid.link/20260521095016.2791354-4-libaokun@linux.alibaba.com
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ ehagberg: Backported to 6.12.y. struct super_block lives in
  include/linux/fs.h here, so add the field there. 6.12.y predates the
  inode_state_read()/inode_state_set() accessors and the
  trace_inode_switch_wbs_queue() tracepoint, so adjust context
  accordingly. Also adjust context in cleanup_offline_cgwb() for
  "writeback: keep cleanup_offline_cgwb()'s scan out of syncs".
  No functional change from upstream. ]
Signed-off-by: Eric Hagberg <ehagberg@janestreet.com>
---
Hi,

Please consider 31c1d19ead2c ("writeback: use a per-sb counter to
drain inode wb switches at umount") for 6.12.y.

The first two patches of this series are already in 6.12.y:

  cba38ec4cbd3 ("writeback: fix race between cgroup_writeback_umount()
                and inode_switch_wbs()")
  e90a6d668e26 ("writeback: drop now-unnecessary rcu_barrier() in
                cgroup_writeback_umount()")

With those applied, cgroup_writeback_umount() calls synchronize_rcu()
and flush_workqueue() whenever any superblock on the system has an
inode wb switch in flight, so every umount on a host with cgroup
writeback churn elsewhere pays for it. This patch is the third patch
of the same series. It replaces the global wait with a per-sb counter,
so a umount only waits for switches on its own superblock.

On a bare-metal 32-CPU Intel Xeon Gold 6346 host, with the reproducer
below (cgroup writeback churn on 4 other ext4 filesystems), umount
latency in ms:

                  vanilla 6.12.118     6.12.118 + this patch
  scenario        p50    p95    max     p50    p95    max
  baseline        1.6    2.9    3.1     1.7    3.5    4.2
  idle           32.2   45.7   49.6     2.9    3.6    3.9
  busy           26.2   40.5   45.4     8.8    9.6    9.8
  concurrent     29.2   42.6   47.3     2.5    4.9    5.3

  baseline:   idle target fs, no background load
  idle:       idle target fs, background load on other filesystems
  busy:       target fs ran its own churn for 2s, then umount
  concurrent: 8 idle target filesystems unmounted in parallel

The load was comparable on both kernels: 7169 vs 6943 churn
iterations, 8448 vs 8268 inode_switch_wbs events. The same reproducer
on vanilla 6.18.64 gives an idle p50 of 30.8 ms without the patch and
2.2 ms with it; I'm sending that backport separately.

The backport only adjusts context; there is no functional change from
upstream:
  - struct super_block is in include/linux/fs.h, not
    include/linux/fs/super_types.h.
  - 6.12.y has no inode_state_read()/inode_state_set() accessors or
    trace_inode_switch_wbs_queue() tracepoint; context adjusted.
  - Context in cleanup_offline_cgwb() adjusted for "writeback: keep
    cleanup_offline_cgwb()'s scan out of syncs", already in 6.12.y.

The reproducer needs root, cgroup v2 with the memory and io
controllers, loop devices, e2fsprogs and perl, and runs for about two
minutes. It keeps the filesystem images on tmpfs, so flushes of the
backing store don't add to the measured latency:

-- 8< -- isw-umount-bench.sh --
#!/bin/bash
# SPDX-License-Identifier: GPL-2.0
#
# isw-umount-bench.sh: measure umount(8) latency while other
# filesystems have cgroup writeback (inode wb) switches in flight.
#
# Before 31c1d19ead2c ("writeback: use a per-sb counter to drain inode
# wb switches at umount"), cgroup_writeback_umount() does
# synchronize_rcu() + flush_workqueue() whenever any superblock on the
# system has a wb switch in flight, so an idle filesystem's umount
# waits for unrelated activity.  With the patch it only waits for
# switches on its own superblock.
#
# Background load: NR_BG ext4 filesystems on loop devices, each in a
# loop of "mkdir memcg; write from it with O_SYNC; rmdir memcg".  Each
# iteration:
#  - drops the page cache of a shared file and rewrites it, so the new
#    folios are charged to the new memcg and writeback sees a foreign
#    owner (foreign inode switches);
#  - writes a new file, whose inode attaches to the new memcg's wb; when
#    the memcg is removed, cleanup_offline_cgwb() switches it away.
# The last KEEP_FILES new files are kept so their inodes stay attached.
#
# Scenarios (latency is wall-clock around umount(8) of the target):
#   baseline    idle target, no background load
#   idle        idle target, background load running
#   busy        target ran its own churn for BUSY_SECS, then umount
#   concurrent  NR_CONC idle targets unmounted in parallel, with load
#
# Requires root, cgroup v2 with the memory and io controllers,
# CONFIG_CGROUP_WRITEBACK, loop devices, e2fsprogs, util-linux, perl.
# Creates and removes its loop devices, mounts and cgroups.
#
# Usage: isw-umount-bench.sh [parent-dir]   (default /dev/shm; fs
# images go in a fresh subdirectory that is removed afterwards).  Keep
# the images on tmpfs: on a disk-backed filesystem, the umount's
# journal commit and flush queue behind the background O_SYNC writes
# to the other images, which adds latency unrelated to the kernel
# behaviour being measured.
# Tunables (environment): ITERS, BUSY_ITERS, CONC_ROUNDS, NR_BG,
#   NR_CONC, BUSY_SECS, WARMUP_SECS, FS_MB, KEEP_FILES.

set -u

ITERS=${ITERS:-50}
BUSY_ITERS=${BUSY_ITERS:-20}
CONC_ROUNDS=${CONC_ROUNDS:-10}
NR_BG=${NR_BG:-4}
NR_CONC=${NR_CONC:-8}
BUSY_SECS=${BUSY_SECS:-2}
WARMUP_SECS=${WARMUP_SECS:-5}
FS_MB=${FS_MB:-256}
KEEP_FILES=${KEEP_FILES:-16}

CGROOT=/sys/fs/cgroup
CGPARENT=$CGROOT/isw-bench.$$
TRACEFS=/sys/kernel/tracing
TRACEINST=$TRACEFS/instances/isw-bench.$$

WORK=$(mktemp -d "${1:-/dev/shm}/isw-bench.XXXXXX") ||
	{ echo "error: mktemp failed" >&2; exit 1; }
LOOPS=()
CHURN_PIDS=()

die() { echo "error: $*" >&2; exit 1; }

# ---- setup / teardown ------------------------------------------------

check_env() {
	[ "$(id -u)" = 0 ] || die "must run as root"
	[ "$(stat -fc %T $CGROOT)" = cgroup2fs ] ||
		die "$CGROOT is not cgroup v2"
	for c in memory io; do
		grep -qw $c $CGROOT/cgroup.controllers ||
			die "cgroup controller '$c' not available"
	done
	for t in mkfs.ext4 losetup perl; do
		command -v $t >/dev/null || die "$t not found"
	done
}

setup_cgroups() {
	echo "+memory +io" > $CGROOT/cgroup.subtree_control ||
		die "cannot enable memory+io in $CGROOT"
	mkdir $CGPARENT || die "mkdir $CGPARENT"
	echo "+memory +io" > $CGPARENT/cgroup.subtree_control ||
		die "cannot enable memory+io in $CGPARENT"
}

# make_fs NAME: create an ext4 fs on a loop device, set DEV to it
make_fs() {
	local img=$WORK/$1.img
	truncate -s ${FS_MB}M $img || die "truncate $img"
	DEV=$(losetup -f --show $img) || die "losetup $img"
	LOOPS+=("$DEV")
	mkfs.ext4 -q -F $DEV || die "mkfs.ext4 $DEV"
	mkdir -p $WORK/mnt/$1
}

cleanup() {
	trap - EXIT INT TERM
	stop_churn
	for m in $WORK/mnt/*; do
		mountpoint -q $m && umount $m
	done
	for d in "${LOOPS[@]}"; do losetup -d $d; done
	if [ -d $CGPARENT ]; then
		rmdir $CGPARENT/* 2>/dev/null
		rmdir $CGPARENT
	fi
	[ -d $TRACEINST ] && rmdir $TRACEINST
	rm -rf $WORK
}

# ---- load generation -------------------------------------------------

# churn MNT TAG STOPFILE: create memcg, write from it, remove memcg;
# repeat until STOPFILE exists.  Iteration count goes to iters.TAG.
churn() {
	local mnt=$1 tag=$2 stop=$3 n=0 cg
	while [ ! -e $stop ]; do
		cg=$CGPARENT/$tag-$n
		mkdir $cg || return
		sh -c 'echo $$ > "$1/cgroup.procs" || exit 1
		# drop cached (clean) folios so the rewrite recharges
		dd if=/dev/null of="$2/burner" oflag=nocache \
			conv=notrunc,fdatasync count=0 status=none
		dd if=/dev/zero of="$2/burner" bs=4k count=256 \
			conv=notrunc oflag=sync status=none
		exec dd if=/dev/zero of="$2/f$3" bs=4k count=256 \
			oflag=sync status=none' sh $cg $mnt $n
		until rmdir $cg 2>/dev/null; do sleep 0.01; done
		rm -f $mnt/f$((n - KEEP_FILES))
		n=$((n + 1))
		echo $n > $WORK/iters.$tag
	done
}

# Total iterations so far across the background churn loops.
churn_iters() {
	cat $WORK/iters.bg* 2>/dev/null |
		awk '{ n += $1 } END { print n + 0 }'
}

start_churn() {
	local i
	rm -f $WORK/stop-bg
	for i in $(seq 0 $((NR_BG - 1))); do
		churn $WORK/mnt/bg$i bg$i $WORK/stop-bg &
		CHURN_PIDS+=($!)
	done
}

stop_churn() {
	touch $WORK/stop-bg
	[ ${#CHURN_PIDS[@]} -gt 0 ] && wait "${CHURN_PIDS[@]}"
	CHURN_PIDS=()
}

# ---- measurement -----------------------------------------------------

# time_umount MNT: umount MNT, print elapsed microseconds
time_umount() {
	perl -MTime::HiRes=time -e '
		my $t = time;
		system("umount", $ARGV[0]) == 0 or exit 1;
		printf "%d\n", (time - $t) * 1e6;' "$1"
}

# Count inode_switch_wbs events (entries + overruns) in our instance.
switch_count() {
	[ -d $TRACEINST ] || { echo n/a; return; }
	cat $TRACEINST/per_cpu/cpu*/stats |
		awk '/^(entries|overrun):/ { n += $2 } END { print n }'
}

setup_trace() {
	local ev=events/writeback/inode_switch_wbs/enable
	[ -e $TRACEFS/$ev ] || return
	mkdir $TRACEINST 2>/dev/null || return
	echo 1 > $TRACEINST/$ev
}

reset_trace() {
	[ -d $TRACEINST ] && echo > $TRACEINST/trace
}

# stats NAME FILE: print n/p50/p95/p99/max in ms (nearest rank)
stats() {
	sort -n $2 | awk -v name=$1 '
		{ v[NR] = $1 }
		function p(q,  i) {
			i = int(q * NR + 0.999999); if (i < 1) i = 1
			return v[i] / 1000
		}
		END {
			printf "%-11s %5d %8.1f %8.1f %8.1f %8.1f\n",
				name, NR, p(.5), p(.95), p(.99),
				v[NR] / 1000
		}'
}

p50() { sort -n $1 | awk '{ v[NR] = $1 } END {
	i = int(.5 * NR + 0.999999); print v[i] }'; }

run_idle() {	# run_idle OUTFILE
	local i
	for i in $(seq $ITERS); do
		mount ${TARGET} $WORK/mnt/target || die "mount target"
		sleep 0.2
		time_umount $WORK/mnt/target >> $1 ||
			die "umount target"
	done
}

run_busy() {	# run_busy OUTFILE
	local i pid
	for i in $(seq $BUSY_ITERS); do
		mount ${TARGET} $WORK/mnt/target || die "mount target"
		rm -f $WORK/stop-t
		dd if=/dev/zero of=$WORK/mnt/target/burner bs=4k \
			count=256 status=none
		churn $WORK/mnt/target t $WORK/stop-t &
		pid=$!
		sleep $BUSY_SECS
		touch $WORK/stop-t
		wait $pid
		time_umount $WORK/mnt/target >> $1 ||
			die "umount target"
	done
}

run_concurrent() {	# run_concurrent OUTFILE
	local i pids
	for _ in $(seq $CONC_ROUNDS); do
		for i in $(seq 0 $((NR_CONC - 1))); do
			mount ${CONC[$i]} $WORK/mnt/c$i ||
				die "mount c$i"
		done
		sleep 0.2
		pids=()
		for i in $(seq 0 $((NR_CONC - 1))); do
			time_umount $WORK/mnt/c$i > $WORK/c$i.out &
			pids+=($!)
		done
		# Only these: a bare wait would also wait for the
		# background churn loops, which never exit.
		wait "${pids[@]}"
		cat $WORK/c*.out >> $1
	done
}

# ---- main ------------------------------------------------------------

trap cleanup EXIT INT TERM
check_env
setup_cgroups
setup_trace

for i in $(seq 0 $((NR_BG - 1))); do
	make_fs bg$i
	mount $DEV $WORK/mnt/bg$i || die "mount bg$i"
	dd if=/dev/zero of=$WORK/mnt/bg$i/burner bs=4k count=256 \
		status=none
done
make_fs target
TARGET=$DEV
CONC=()
for i in $(seq 0 $((NR_CONC - 1))); do
	make_fs c$i
	CONC+=("$DEV")
done

echo "kernel: $(uname -r)  cpus: $(nproc)  bg fs: $NR_BG"

phase() { echo "[$(date +%T)] $*" >&2; }

phase "baseline ($ITERS umounts, no load)"
run_idle $WORK/baseline.us

phase "starting background load, warming up ${WARMUP_SECS}s"
start_churn
sleep $WARMUP_SECS
reset_trace
iters0=$(churn_iters)
phase "idle ($ITERS umounts)"
run_idle $WORK/idle.us
phase "busy ($BUSY_ITERS x ${BUSY_SECS}s churn + umount)"
run_busy $WORK/busy.us
phase "concurrent ($CONC_ROUNDS rounds x $NR_CONC umounts)"
run_concurrent $WORK/concurrent.us
phase "stopping background load"
switches=$(switch_count)
iters=$(( $(churn_iters) - iters0 ))
stop_churn

echo
echo "umount latency (ms)"
printf "%-11s %5s %8s %8s %8s %8s\n" scenario n p50 p95 p99 max
for s in baseline idle busy concurrent; do
	stats $s $WORK/$s.us
done
echo
echo "background churn iterations while loaded: $iters"
echo "inode_switch_wbs events while loaded: $switches"
if [ "$switches" != n/a ] && [ "$switches" -lt "$iters" ]; then
	echo "WARNING: fewer wb switches than churn iterations; the" \
	     "load is not exercising cgroup writeback as intended," \
	     "so the latencies above are not meaningful"
fi
awk -v b="$(p50 $WORK/baseline.us)" -v i="$(p50 $WORK/idle.us)" \
	'BEGIN { printf "idle/baseline p50 ratio: %.1fx\n", i / b }'
-- >8 --

Thanks,
Eric

 fs/fs-writeback.c  | 97 ++++++++++++++++++++++------------------------
 include/linux/fs.h |  8 ++++
 2 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 3b67018..04e6fd5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -488,6 +488,23 @@ skip_switch:
 	return switched;
 }
 
+static inline void cgroup_writeback_pin(struct super_block *sb)
+{
+	atomic_inc(&sb->s_isw_nr_in_flight);
+}
+
+static inline void cgroup_writeback_unpin(struct super_block *sb)
+{
+	if (atomic_dec_and_test(&sb->s_isw_nr_in_flight))
+		wake_up_var(&sb->s_isw_nr_in_flight);
+}
+
+static inline void cgroup_writeback_drain(struct super_block *sb)
+{
+	wait_var_event(&sb->s_isw_nr_in_flight,
+		       !atomic_read(&sb->s_isw_nr_in_flight));
+}
+
 static void process_inode_switch_wbs(struct bdi_writeback *new_wb,
 				     struct inode_switch_wbs_context *isw)
 {
@@ -546,8 +563,12 @@ relock:
 		wb_put_many(old_wb, nr_switched);
 	}
 
-	for (inodep = isw->inodes; *inodep; inodep++)
+	for (inodep = isw->inodes; *inodep; inodep++) {
+		struct super_block *sb = (*inodep)->i_sb;
+
 		iput(*inodep);
+		cgroup_writeback_unpin(sb);
+	}
 	wb_put(new_wb);
 	kfree(isw);
 	atomic_dec(&isw_nr_in_flight);
@@ -590,16 +611,19 @@ void inode_switch_wbs_work_fn(struct work_struct *work)
 static bool inode_prepare_wbs_switch(struct inode *inode,
 				     struct bdi_writeback *new_wb)
 {
+	/* Avoid the atomic_inc/smp_mb dance once SB_ACTIVE is gone. */
+	if (!(inode->i_sb->s_flags & SB_ACTIVE))
+		return false;
+
 	/*
-	 * Paired with smp_mb() in cgroup_writeback_umount().
-	 * isw_nr_in_flight must be increased before checking SB_ACTIVE and
-	 * grabbing an inode, otherwise isw_nr_in_flight can be observed as 0
-	 * in cgroup_writeback_umount() and the isw_wq will be not flushed.
+	 * Pairs with smp_mb() in cgroup_writeback_umount(): the umounter either
+	 * sees a non-zero counter and waits, or we see SB_ACTIVE clear below.
 	 */
+	cgroup_writeback_pin(inode->i_sb);
 	smp_mb();
 
 	if (IS_DAX(inode))
-		return false;
+		goto out_unpin;
 
 	/* while holding I_WB_SWITCH, no one else can update the association */
 	spin_lock(&inode->i_lock);
@@ -607,13 +631,17 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 	    inode->i_state & (I_WB_SWITCH | I_FREEING | I_WILL_FREE) ||
 	    inode_to_wb(inode) == new_wb) {
 		spin_unlock(&inode->i_lock);
-		return false;
+		goto out_unpin;
 	}
 	inode->i_state |= I_WB_SWITCH;
 	__iget(inode);
 	spin_unlock(&inode->i_lock);
 
 	return true;
+
+out_unpin:
+	cgroup_writeback_unpin(inode->i_sb);
+	return false;
 }
 
 static void wb_queue_isw(struct bdi_writeback *wb,
@@ -652,19 +680,12 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 
 	atomic_inc(&isw_nr_in_flight);
 
-	/*
-	 * Paired with synchronize_rcu() in cgroup_writeback_umount():
-	 * holding rcu_read_lock across inode_prepare_wbs_switch()
-	 * (covering the SB_ACTIVE check and the inode grab) and
-	 * wb_queue_isw() ensures synchronize_rcu() cannot return until
-	 * the work is queued, so the subsequent flush_workqueue() will
-	 * wait for the switch.
-	 */
-	rcu_read_lock();
 	/* find and pin the new wb */
+	rcu_read_lock();
 	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
 	if (memcg_css && !css_tryget(memcg_css))
 		memcg_css = NULL;
+	rcu_read_unlock();
 	if (!memcg_css)
 		goto out_free;
 
@@ -679,11 +700,9 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	isw->inodes[0] = inode;
 
 	wb_queue_isw(new_wb, isw);
-	rcu_read_unlock();
 	return;
 
 out_free:
-	rcu_read_unlock();
 	atomic_dec(&isw_nr_in_flight);
 	if (new_wb)
 		wb_put(new_wb);
@@ -764,14 +783,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 	 * moved ones. Exclude syncs as process_inode_switch_wbs() does.
 	 */
 	down_read(&wb->bdi->wb_switch_rwsem);
-	/*
-	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
-	 * Holding rcu_read_lock across the SB_ACTIVE check, the inode grab
-	 * and wb_queue_isw() ensures synchronize_rcu() cannot return until
-	 * the work is queued, so the subsequent flush_workqueue() will wait
-	 * for the switch.
-	 */
-	rcu_read_lock();
 	spin_lock(&wb->list_lock);
 	/*
 	 * In addition to the inodes that have completed writeback, also switch
@@ -790,7 +801,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
-		rcu_read_unlock();
 		atomic_dec(&isw_nr_in_flight);
 		wb_put(new_wb);
 		kfree(isw);
@@ -798,7 +808,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 	}
 
 	wb_queue_isw(new_wb, isw);
-	rcu_read_unlock();
 
 	return restart;
 }
@@ -1211,39 +1220,27 @@ out_bdi_put:
 }
 
 /**
- * cgroup_writeback_umount - flush inode wb switches for umount
+ * cgroup_writeback_umount - wait for in-flight inode wb switches on @sb
  * @sb: target super_block
  *
- * This function is called when a super_block is about to be destroyed and
- * flushes in-flight inode wb switches.  An inode wb switch goes through
- * RCU and then workqueue, so the two need to be flushed in order to ensure
- * that all previously scheduled switches are finished.  As wb switches are
- * rare occurrences and synchronize_rcu() can take a while, perform
- * flushing iff wb switches are in flight.
+ * Wait until every inode wb switch that already passed the SB_ACTIVE
+ * check on this superblock has been completed by the worker.  Since
+ * SB_ACTIVE is cleared before this is called, no new switches can start
+ * for @sb, so s_isw_nr_in_flight will monotonically drop to zero.
  */
 void cgroup_writeback_umount(struct super_block *sb)
 {
-
 	if (!(sb->s_bdi->capabilities & BDI_CAP_WRITEBACK))
 		return;
 
 	/*
-	 * SB_ACTIVE should be reliably cleared before checking
-	 * isw_nr_in_flight, see generic_shutdown_super().
+	 * Pairs with smp_mb() in inode_prepare_wbs_switch(): we either observe
+	 * a non-zero counter and wait, or the switcher sees SB_ACTIVE clear
+	 * (cleared by generic_shutdown_super()) and bails before grabbing the
+	 * inode.
 	 */
 	smp_mb();
-
-	if (atomic_read(&isw_nr_in_flight)) {
-		/*
-		 * Paired with rcu_read_lock() in inode_switch_wbs() and
-		 * cleanup_offline_cgwb().  synchronize_rcu() waits for any
-		 * in-flight switcher that already passed the SB_ACTIVE check
-		 * to finish queueing its work, so flush_workqueue() below
-		 * will then drain it.
-		 */
-		synchronize_rcu();
-		flush_workqueue(isw_wq);
-	}
+	cgroup_writeback_drain(sb);
 }
 
 static int __init cgroup_writeback_init(void)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 67b57ce..fc63611 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1443,6 +1443,14 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+
+#ifdef CONFIG_CGROUP_WRITEBACK
+	/*
+	 * Number of in-flight inode wb switches for this sb.  Drained by
+	 * cgroup_writeback_umount() before tear-down.
+	 */
+	atomic_t		s_isw_nr_in_flight;
+#endif
 } __randomize_layout;
 
 static inline struct user_namespace *i_user_ns(const struct inode *inode)
-- 
2.43.7

