Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795591425;
	b=Nzsh+2TgEWeF0rH0lk9MI5j1OE8n0rL5MLU+U7AwqS2lN68lmEnJKqvQWEZkYhWbAm9E
	 t0vdbFs2OHkcY8NOUKxnqhMpEk1hUsfP0QEoFB6iv48li9Kiw7Uo1ZbBoQrERoS2g8gYw
	 vNBmz9Jqqs7kuzbt+tGlqyqZixUptTfVSFAhnx0Fn43RAvMduj6xkDYz5O8nud9zd8bAs
	 7g8+iAsoOjCAGHOuF+aBwq+kYBF/oLXVZ6ORitAxEDpFrNXddLd4V1Y/Q8VMipNZzeybT
	 z9jLHAbfx9mMSOmucFTt2uUOkRD0hS292Ri1XI9nyPM9cpVr9Ci0fF52YH9MTv9N+Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795591425;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=D4hQqs/THsstMireSiNbtWwkdm1S+C6Al/QHsnfgvp8=;
	b=V7bRJPkdpukLv3VxshDMq1jG8Qc8imjOrLZHhqiaDCW+GVY0ajfZMTw21Gugf78ZJReI
	 EYgymOXkNfZGH5Y/Pj8UayKUejLMUFu+DRTVNBfT5NuTH/0CABzwuqsCzaiO4Fnv9H2GI
	 C+pVxt31KQ1Y1kKX6D++vb460DGdfW3qr36cQxweCxfQM1faMwqrWJs38/260OV3eO5Th
	 y1XGoEyIQkVLJyYzDaIBusaIN3Un3YTc9DbDgrQPgNS3B9XYCb6oCR9lvGh820YfcW19e
	 WoZCZvqHw/SUrMiiS12EzQFFOcujJwdjIjFTI7kv/H00UlnvvM43qNx5vZz4UTsUlzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f86ejfOO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC2606A321;
	Wed, 25 Nov 2026 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f86ejfOO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7DB1F000D1;
	Wed, 25 Nov 2026 07:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795591424;
	bh=D4hQqs/THsstMireSiNbtWwkdm1S+C6Al/QHsnfgvp8=;
	h=From:Date:Subject:To:Cc;
	b=f86ejfOOziL4fFH3VmCeyvqll5Ueu6l3fTyJ37ryObA4oQhdP1+hn75H4YbimZcd6
	 W/ro9RqVhpsWsjNyC7RVCq2kzQfxaEdOI1ecGapTH12hIq+X5alPuz1np3YhHe+SPD
	 hHyqSmmhocTbMTLpgprlV6GXOXlfCpYLui7ydFzesp11KviJABE8BtKUAVpbjODL1I
	 azOE38uAzJ9z0NphGSD8RNVtoxGCIH1UwpWCICTj0knmEhkf2NdnaNND50svePKqN/
	 cy+foArCkU+1lNS+JrZ5X5JxczBeuOgwGqC8o3Vy9nY2f5B/n8MbsCSoZeoIekPQq4
	 oEsT6T54fe77A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 25 Nov 2026 00:23:35 -0700
Subject: [PATCH v3] sched/topology: Avoid unsequenced accesses to jiffies
 in sd_init()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-topology-wunsequenced-v3-1-efa3db7e0bf8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/3XMyw6CMBCF4Vcxs3YMUy4GV76HcUHLAFVscQqoI
 by7oBs3Lv/knG+CwGI5wGEzgfBog/VuiXi7AdMUrma05dKgIpURqRR73/nW1y98DC7wfWBnuMS
 EdByxybTJU1i+nXBlnx/3dP52GPSFTb9i66ISf8O+ES5+fMr++KNCwjRZJ5TTXunjlcVxu/NSw
 zy/AT/TvZPHAAAA
X-Change-ID: 20261125-topology-wunsequenced-41b30ec6bc95
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4331; i=nathan@kernel.org;
 h=from:subject:message-id; bh=o1fjDvu1A47hKkh4BWahgRn/rkAmZDlCQAcoQ6eKA8A=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDNlsPT+n33Tb+3/jPZH0G4kG+Y4abyp97npOP/ss/IY2f
 0SEXpVBRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjIxL+MDMcieSxzz1UWxOs8
 4FGW4EiK6qj72jz7TJMl/+pPc6NsFjL8s3ojzKUfnOe157rqgc9JCRtecl9+1uF0capKiJzZnFd
 ZbAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent improvement in clang to warn on unsequenced accesses to
volatile variables [1], an instance appears in sd_init(), which can
break the build with CONFIG_WERROR=y / W=e:

  In file included from kernel/sched/build_utility.c:86:
  kernel/sched/topology.c:2008:29: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
   1998 |                 .last_balance           = jiffies,
        |                                           ~~~~~~~
   1999 |                 .balance_interval       = sd_weight,
   2000 |
   2001 |                 /* 50% success rate */
   2002 |                 .newidle_call           = 512,
   2003 |                 .newidle_success        = 256,
   2004 |                 .newidle_ratio          = 512,
   2005 |                 .newidle_stamp          = now,
   2006 |
   2007 |                 .max_newidle_lb_cost    = 0,
   2008 |                 .last_decay_max_lb_cost = jiffies,
        |                                           ^

Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
6.5.2, unsequenced side effects on the same scalar object are undefined
behavior. Per C11 6.7.9.23, the evaluation of the initialization list
expressions in a designated initializer is indeterminately sequenced
relative to each other, meaning any side effects in the initialization
list are unsequenced.

Clang's warning is ultimately pointing out that jiffies may have two
separate values in this initializer because it is volatile and accessed
twice and the order of these accesses is not specified. This could
result in unexpected or inconsistent behavior depending on the code
author's intent and whether they realized the variable was volatile or
not.

As two separate accesses is not necessary here, add a local variable to
hold the value of jiffies before the designated initializer so that a
consistent value is used for initializing both members, clearing up the
warning.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2190
Fixes: 2b4cfe64dee0 ("sched/numa: Initialize newidle balance stats in sd_numa_init()")
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v3:
- Improve commit message to give more context into warning
- Carry forward Nick's review tag
- Link to v2: https://patch.msgid.link/20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org

Changes in v2:
- Use a local variable with one access to jiffies before designated
  initializer (Nick)
- Link to v1: https://patch.msgid.link/20261114-topology-wunsequenced-v1-1-686a36fe61f5@kernel.org
---
 kernel/sched/topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99878da03bce..60fad1690894 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1956,6 +1956,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	int sd_id, sd_weight, sd_flags = 0;
 	struct cpumask *sd_span;
 	u64 now = sched_clock();
+	unsigned long j;
 
 	sd_span = sched_domain_span(sd);
 	cpumask_and(sd_span, cpu_map, tl->mask(tl, cpu));
@@ -1973,6 +1974,7 @@ sd_init(struct sched_domain_topology_level *tl,
 #endif
 	sd_flags |= asym_cpu_capacity_classify(sd_span, cpu_map);
 
+	j = jiffies;
 	*sd = (struct sched_domain){
 		.min_interval		= sd_weight,
 		.max_interval		= 2*sd_weight,
@@ -1994,7 +1996,7 @@ sd_init(struct sched_domain_topology_level *tl,
 					| sd_flags
 					,
 
-		.last_balance		= jiffies,
+		.last_balance		= j,
 		.balance_interval	= sd_weight,
 
 		/* 50% success rate */
@@ -2004,7 +2006,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		.newidle_stamp		= now,
 
 		.max_newidle_lb_cost	= 0,
-		.last_decay_max_lb_cost	= jiffies,
+		.last_decay_max_lb_cost	= j,
 		.child			= child,
 		.name			= tl->name,
 	};

---
base-commit: 3dd8c790a7b7027abdd568e36db5e82ffaea7c77
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261125-topology-wunsequenced-41b30ec6bc95

Best regards,
--  
Cheers,
Nathan

