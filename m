Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841986;
	b=jz6/8HHUM4BuvxAPAb/kAaYUizVSq1sKWzkG3pB9U+y2IBk6eSBcz1BQDlwgtngPLmxB
	 7A4lzAkYO/902llRnb7XHVy1htPIT4BrwIjc2XbkmS4C2YCxXQV4AEENol40R7X1AkzgP
	 U1aTRUEQs+PEHDb9Ejm/6+bl/ickp7qBMtFbPxTxjxRY6lxPSldE/kEbcU+7sXD/bokYS
	 qTBF5jQolxbpabu2lfPr6JhVgIQ1+SoExWadtQxl9t48Sb09c1+XQEoGpnid9B4uOM12i
	 veQ0Tgn0Z4kcb8yjgq1GOkznXbtde+8gJdBZzGDpPpUMsOTSn69ls6pCIy1YsRf1QLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841986;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=C1zJjXY9ZXW9YbbwW2wiDwmIjIKQhRl4bxooQnSA6Mo=;
	b=GUWenf3SXAJZKvzULjef643606ZaPWCG8oYBJDBlWl5BGH1/aQ9kNypPdX0TDNAZNXU7
	 jTNSbyUCfBN15ikDrPdkD0THxYwHbk5ktfLbgQfy09Rc7uOFEg/dfdE0fcB0NxvdIlXv0
	 5zbwWf/TaBN7z6bPZel1JN1SXUGUR6jzyutEC7tUvoSeR6ziR6lLOGclU5f4vzxew5nMb
	 ASpCgztz8ofuSe15dQJYHvqKmSumObJySrjdxRKfJ9a1iGS6XIdMF1XG/q8tDR1mGaySm
	 2iW6gK0SluKaYr0EQWs6mLlPPnNgpK5zHIQFqvAFEDvEwoZYe4vcY+IX/iXJtQoq1wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="b7/Xev27";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9XlrSP71;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121A606A31F;
	Sat, 24 Oct 2026 11:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7121A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=b7/Xev27;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9XlrSP71
Date: Sat, 24 Oct 2026 11:39:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792841983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1zJjXY9ZXW9YbbwW2wiDwmIjIKQhRl4bxooQnSA6Mo=;
	b=b7/Xev27rniK1Ob12tL7M0PHAp23ibCtDVjS9H9OMbGMQSStVeFAEZA9gj9Od+V8+dQxhe
	F2qTJUAs9fh89J1TZDYvnL5wJuUcx0X7Wd1PkAdFhojHWrJmaQLJMb/h6t79JUI6ZmRHVp
	cHOCitKEJt2uGUtEaVez04GrNTHI0rGtlLHnpYpgZX+2a0tc7osdVlwO3PQI9EfE3xgO4J
	1fnodIKzEoEgGqnGYkmojhNMBF4ZX+c1fgjy3nEe9RCgGsQj7NO5VAw0v4oELrbMB0T606
	GC5EyMz1YtFUEaevqTRQMjC4oe2uKJl1luUD5vX0MXrq/YkgazfKs689ExDWXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792841983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1zJjXY9ZXW9YbbwW2wiDwmIjIKQhRl4bxooQnSA6Mo=;
	b=9XlrSP71hUSw9JMPbAZTcx8jbbD29gYJ7oMbscwjojEqHYfVM58qNInyBVtgYdiTEBpu7Z
	aGe9bveBokOEkpDw==
From: "tip-bot2 for Tim Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/cache: Honor asym packing over cache aware
 scheduling on hybrid systems
Cc: Klaus Kusche <klaus.kusche@computerix.info>,
	Kayra Cizmeci <kayracizmeci@gmail.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ricardo Neri <ricardo.neri@intel.com>, Chen Yu <yu.c.chen@intel.com>,
	stable@vger.kernel.org, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 7.2.x@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb29badede27bb6bfb4a759e06754cb19657f0778=2E1791308?=
 =?utf-8?q?631=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3Cb29badede27bb6bfb4a759e06754cb19657f0778=2E17913086?=
 =?utf-8?q?31=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179284198232.4109677.752653731564503349.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ee92b7ef4c1e271b3c1ea2a8b13034bdc62422a7
Gitweb:        https://git.kernel.org/tip/ee92b7ef4c1e271b3c1ea2a8b13034bdc62=
422a7
Author:        Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Wed, 07 Oct 2026 10:25:30 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 23 Oct 2026 19:09:54 +02:00

sched/cache: Honor asym packing over cache aware scheduling on hybrid systems

A regression was reported on an AMD Ryzen AI HX 370 running a cache
intensive Clang full-LTO link. The little cores run at a much lower
frequency (3.3 GHz vs 5.1 GHz) and have only half of the L3 cache
(8 MB vs 16 MB), so pinning such a task to the little-core LLC
hurts twice, and full-LTO builds slow down dramatically compared to
pre-cache-aware-scheduling kernels.

Asym packing and cache aware scheduling express conflicting placement
strategies. Asym packing wants a task to run on the highest priority CPU,
whereas cache aware scheduling wants to co-locate the tasks of a process
on one LLC regardless of the priority of CPUs in that LLC.

When asym packing tries to migrate task to an idle core that has higher
priority than source cpu, let asym packing win.  Moving tasks to a higher
performing idle core will buy more performance than cache co-location.

Prioritize asym packing over LLC balancing for regular and active load
balancing.

Fixes: 23b2b5ccc45c ("sched/cache: Introduce helper functions to enforce LLC =
migration policy")
Closes: https://lore.kernel.org/lkml/2180ea5a-eb28-4152-8d4d-cd00b0c24b2e@com=
puterix.info/
Reported-by: Klaus Kusche <klaus.kusche@computerix.info>
Suggested-by: Kayra Cizmeci <kayracizmeci@gmail.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
Tested-by: Klaus Kusche <klaus.kusche@computerix.info>
Tested-by: Ricardo Neri <ricardo.neri@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Cc: stable@vger.kernel.org
Cc: stable@vger.kernel.org # 7.2.x
Link: https://patch.msgid.link/b29badede27bb6bfb4a759e06754cb19657f0778.17913=
08631.git.tim.c.chen@linux.intel.com
---
 kernel/sched/fair.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f23644..d750f2f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10942,6 +10942,8 @@ static inline bool task_misfits_asym_cpu(struct lb_en=
v *env, struct task_struct=20
 	return false;
 }
=20
+static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_=
cpu);
+
 /*
  * Check if task p can migrate from source LLC to
  * destination LLC in terms of cache aware load balance.
@@ -10966,6 +10968,10 @@ static enum llc_mig can_migrate_llc_task(struct lb_e=
nv *env,
 	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
 		return mig_unrestricted;
=20
+	/* Prioritize asym packing to idle core over cache awareness */
+	if (env->idle && sched_asym(env->sd, dst_cpu, src_cpu))
+		return mig_unrestricted;
+
 	/* skip cache aware load balance for too many threads */
 	if (invalid_llc_nr(grp, p, dst_cpu) ||
 	    exceed_llc_capacity(grp, dst_cpu)) {
@@ -12163,6 +12169,14 @@ static inline bool llc_balance(struct lb_env *env, s=
truct sg_lb_stats *sgs,
 		return false;
=20
 	/*
+	 * On asym packing domains, if the destination CPU
+	 * has higher priority than all CPUs in the source group,
+	 * prioritize asym packing.
+	 */
+	if (sgs->group_asym_packing)
+		return false;
+
+	/*
 	 * Skip cache aware tagging if nr_balanced_failed is sufficiently high.
 	 * Threshold of cache_nice_tries is set to 1 higher than nr_balance_failed
 	 * to avoid excessive task migration at the same time.
@@ -13577,12 +13591,12 @@ static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd =3D env->sd;
=20
-	if (alb_break_llc(env))
-		return 0;
-
 	if (asym_active_balance(env))
 		return 1;
=20
+	if (alb_break_llc(env))
+		return 0;
+
 	if (imbalanced_active_balance(env))
 		return 1;
=20
