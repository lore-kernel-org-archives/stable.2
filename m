Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716431;
	b=jk3Cj2Arz59jNmtCdf4KPQjfolItE0XLRVbQNtFVk6Y8aWWFZ2HRpUXDiTKEojlQOrsl
	 anP4OaOrxn/ABSEmB8Ri4QFP6QHxPeyc3FSO3aiHyrPI4VXe1vMZByoRN3dePVxQNHlOq
	 48z3mypRYAu03qQtRjohAaf4LhoovOETt7Z7a/tMoOq/OgWGgi/pSTkNs0Dev3MVWNdeI
	 BjwLdiPThO+n4193+2dH6qxKAmEbA0LNEq1u5zwnRniw0CsXGgH5+YhWrQeBNqid9xsA9
	 kETB+oA0RYshlP3r/cHEwBHw9rCK0XJW+4Yq5PD7vA49B4BcbqhKlsnGielb9wSQ3pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716431;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bvlsH/sbn+K2R4f7czn8STf5Bd21I+JO8/DeovfDxJ0=;
	b=RcjXFYbWy9B2orSsU+Kjoeg6HcxVGvekfSZlTGlU304BEQBGmiAtzB74vZRHS3ZfF2j6
	 n8f7+ACNXFM9HuB01+QUoegxsOoSnwu8eqYSSewKjoURKHmzrtjV3mFuY7Fi2qUi+qyOf
	 eY/f4zakB5n1TVe+FGs5U6ArWxp6z6atOAY5PbJMpAKRMCswZeRPtwwSQojBkpYgxDVbb
	 egKdruega0FrFBqbJ+DFJ7CMnEpnrVTxJl5Zo9JR0RQ7A782BVFhngjQ8e/C7tU4fm9eg
	 3J/FpXqKBYS7HQdnYCwzKDMLHlXyBQGOHsYD7ARfCEah7UgGVJE6HOBSmjD5spTTP0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU4MYkLZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353EB606A323;
	Sun, 15 Nov 2026 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU4MYkLZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C1D1F000C4;
	Sun, 15 Nov 2026 04:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794716430;
	bh=bvlsH/sbn+K2R4f7czn8STf5Bd21I+JO8/DeovfDxJ0=;
	h=From:Date:Subject:To:Cc;
	b=hU4MYkLZXw12HdHIP9yihXb3opRHpFwJbEwjWtexlAp1zvjAnPuUNqwutAW4UCHGR
	 pTnK3vGMRfTlQnQkFWxMEUNy46wtoRU6D1EpfMhnJ+F9TjdeGHq4+b0Acweqxjzpq0
	 GyjHEHELZe/Q+TWGc00FxF8pcC3bvk4tqkYYmyWPiGHohG5H/9ZBctmu48kVj5Vost
	 JDEyw90VdlqEiv8qKBSRLi+VychXiy/EdEQlwhUoWzrtega0T0LjoADqKQwFStHDjN
	 8hXN/UvNsuVBo8GXbePb/+OWdXGD4e4f6PSjmAyRrktOFh1A5Ln8B9zVJEdiujiN5E
	 zvB7qoPaG4vSQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 14 Nov 2026 21:19:52 -0700
Subject: [PATCH] sched/topology: Avoid unsequenced accesses to jiffies in
 sd_init()
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
Message-Id: <20261114-topology-wunsequenced-v1-1-686a36fe61f5@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMyw6CMBBG4Vchs7YJgwbUVzEspP3BMabFDvUSw
 rtbYfktzplJEQVK52KmiJeoBJ/Bu4Ls7eoHGHHZVJVVzcwHM4UxPMLwNe/kFc8Eb+EMH3t2++7
 EdWMpt2NEL5/1e2k3a+rusNN/RsvyAyaiFcp5AAAA
X-Change-ID: 20261114-topology-wunsequenced-18f1d3b9167c
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@kernel.org>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3032; i=nathan@kernel.org;
 h=from:subject:message-id; bh=dsqEYcSriLtcVQdAiw5Q3eG9QiLqh3XfUg5g6y/H4E0=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFk/jdlCmL04GOb9d/taLZbaX1D3Vf+7TWoJc9K8E2yyU
 xckq6t2lLIwiHExyIopslQ/Vj1uaDjnLOONU5Ng5rAygQxh4OIUgImwTGFkeFHD/MPbMWll7wex
 OdsKFk3+KNUgEKiU4RLT6PeHzyf4HiPDHmbTg3HBn3ZOL/88+be3yM9VIQzfIu9cuhX0RGJ5xnQ
 jbgA=
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

Move the initialization of these fields outside the designated
initializer to place sequence points between the accesses to jiffies,
clearing up the warning.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2190
Fixes: 2b4cfe64dee0 ("sched/numa: Initialize newidle balance stats in sd_numa_init()")
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99878da03bce..f5975079f453 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1994,7 +1994,6 @@ sd_init(struct sched_domain_topology_level *tl,
 					| sd_flags
 					,
 
-		.last_balance		= jiffies,
 		.balance_interval	= sd_weight,
 
 		/* 50% success rate */
@@ -2004,10 +2003,11 @@ sd_init(struct sched_domain_topology_level *tl,
 		.newidle_stamp		= now,
 
 		.max_newidle_lb_cost	= 0,
-		.last_decay_max_lb_cost	= jiffies,
 		.child			= child,
 		.name			= tl->name,
 	};
+	sd->last_balance = jiffies;
+	sd->last_decay_max_lb_cost = jiffies;
 
 	WARN_ONCE((sd->flags & (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY)) ==
 		  (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY),

---
base-commit: d7e670601af6c564ccf6d3b2ddf70ee4f41a6d1c
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261114-topology-wunsequenced-18f1d3b9167c

Best regards,
--  
Cheers,
Nathan

