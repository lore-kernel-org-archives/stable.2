Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862544;
	b=lzvfV6FSQSaSZrPSgSO0qsxktDx9JA3rINbBGhp98ja+zkXBIsHonDb5Fno6KjyvOe2z
	 15rFDaEPaGpozTykc1AMi6nSgQ3+FePaapyAEejIO9Eamg6+G64eD/UPkZMmn7NIqcneu
	 uPofS+3td5Yy93bYhfSXy/Kbw3K8I7frlEVBwrhofTKIHIf2Hz6MJsp+3enwP/m5B2GrC
	 YmBA6EMudf1nlGOUmbjNq1QGMi4I4EiJDaqsxnyF11TnszcZCnxzMvRx+evXnSbuxcbT2
	 Uybgw1HiWtqADKHub4tL9ABaWeElIc70xPrU+xceg9NI3Om1hT7U624GAv0C9cuuWwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862544;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JpiHRtIiEHYG0g+BY20ZAPvVQUUBUsrr7vJkSH72tOE=;
	b=CgW6G2Wb7dqHUESHZMwxSLUgu8S4OQmVgNZ0LrYk8xADsWeh5oq1XWa88rBO/2oCUFLG
	 Qu4ChQcUSeQZUiRPDpTsEYRLyahqr741i6OOoA1shLLWfX+WITRUorJbj/X/kZM13Ly8Q
	 31iQpSImxUeU/fFRzKjdw4sHRLM4Qxt9naiKdhdl45qRgZIU9tf+Fqunj6Edc+KqobW/V
	 5rPQXwN60fZrvfRmJySIQ7ZCzs7cy7vICvnq66E2MA8y+wMfmJnjLj7smGypUkhPiuc6G
	 ZRDfHQWZqUttYnpw9/A0YwPaUGMWQlLjK00joXnhmwwk0cNIoHD9kVwa3WwToXqA2SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bW0xtvpI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1003606A323;
	Mon, 16 Nov 2026 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bW0xtvpI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750B11F000C6;
	Mon, 16 Nov 2026 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794862544;
	bh=JpiHRtIiEHYG0g+BY20ZAPvVQUUBUsrr7vJkSH72tOE=;
	h=From:Date:Subject:To:Cc;
	b=bW0xtvpIH1XUubxCLTSIEBtaQQyg+fazIdPDGXNY86c6zXktXDVmhyTfNLzAD8ugJ
	 u7+PX310dxqG31Pa+RI6ES1tR1fMO9R/yB+kY9guEXM+bfXCX5sAOylgNs2DFW1O2r
	 xpF6M+teOaYzJxeAJrWYxV7K+qNXN+lI/8Y5XZrWuxV/bgfPbL64yX02JjWvNuaSvu
	 jPjQKVWLcyBmQzjx+xO84EgpwnSE9brLjB3WmyzZ/NaDyk376RjAw0j31GSmzCtmA3
	 yFHdwji3ujdLpw8aDC69snJEadkHi7IGopqf+JzF7PclgB5jCHsQZxIX0oGkq6KdEP
	 sysGAj3aF5kSA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 16 Nov 2026 13:55:26 -0700
Subject: [PATCH v2] sched/topology: Avoid unsequenced accesses to jiffies
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
Message-Id: <20261116-topology-wunsequenced-v2-1-54611119172b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/4WNQQ6CMBBFr0JmbY1TtKIr72FYQJlClbTYFpSQ3
 l2KB3D5kvffX8CT0+Thmi3gaNJeW7MC32Ugu8q0xHSzMvADF4h4ZMEOtrftzN6j8fQayUhqGBY
 Km7y+oDhLWLeDI6U/W/de/tiP9YNkSLFkdNoH6+bteMLk/fuYkCEThahyoUigOt2e5Az1e+taK
 GOMX9uN8PXNAAAA
X-Change-ID: 20261114-topology-wunsequenced-18f1d3b9167c
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3664; i=nathan@kernel.org;
 h=from:subject:message-id; bh=kYoFFxXOitrN11C8It6IfIw2VCFnijveRC0lPF68XnM=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFm/c09tmnxCc8eMrmxHnqOuzdsizu91Zdxc/OrjhPgDu
 0xFJY1YOkpZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEli5nZNhnP/3XDyt+/+aX
 fFai6m+4eC54Zt254f1q8sH5mh25d8UY/oddPMc1oWNaZs7T+6e6WzTVUv5fly875sKqnOi45v/
 E52wA
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

Add a local variable to hold the value of jiffies before the designated
initializer so that there are no unsequenced side effects while using a
consistent value, clearing up the warning.

Cc: stable@vger.kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/2190
Fixes: 2b4cfe64dee0 ("sched/numa: Initialize newidle balance stats in sd_numa_init()")
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
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
base-commit: d7e670601af6c564ccf6d3b2ddf70ee4f41a6d1c
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261114-topology-wunsequenced-18f1d3b9167c

Best regards,
--  
Cheers,
Nathan

