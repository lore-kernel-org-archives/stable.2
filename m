Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387771;
	b=lpeoWki73VFVXEmRIuSnlNVSzGcKLPOW+7nrEL2ARTJtZLQVUC2xrmWAnuKI6Sgf5PgG
	 fM7NaMTjHp+1Dod75tZcGrk24WAYxJDBnXKj4RPhj1qBnign7mZg7K/UoTrG+YljCfK1y
	 6BqtMnYcnGty3JwQnVLOVIi82+tUugv2RNKIkVkKqbSdQSLrahoOPp2sFWz/VOpc2+y1U
	 KKZcO9Itws+ZTSyMaxe4F1kWv3JqbLZy/k2ZCg3YmiTCDu50W172rRG66QesEmtoWOH1p
	 6vxFGsg7Eu6M0gUkvQW4lJPCvarMs4Fw7vW3EQQ2M3iTq/olx1K/jziO6Taf4xBy6AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387771;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Ai6BNNCmBo9LRNnUL5kPH9AVz4boKtQ/jMDNrrKMIbQ=;
	b=Hv0fnkM4HUDoUgjZjEvhFc7XFYzRgDWR3jpNPDVf1YBd8K/ARZEJLe1gcaidbtAqB0ZO
	 TNYsqotWeSl1Wfh14YwhQpoed00l9rhK7Ix/OVVpncUafD474LQLgHEcq5rG9c+UkjtEv
	 z37tJqTbNzvCQpwxUc887vboGWztq1BYUDXG2BVKUCXJyBKXLeVILTLNiIIMHTKDWLcw7
	 ZbstNywP1KfKMeK7Iqw7rCVL/pFDf6UJmU2c58mlODBPDHdOUTQDhyxQGDfWdBx4c2CuL
	 E84t1KKLGIfuLiPF0mfmJbR8T4XkoYlgecoK0H0Ita0CLFkjHeZ5Xce78TEwk/Jsmbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="vx/hbiph";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iWD3i2pe;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A41606A335;
	Sun, 22 Nov 2026 22:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9A41606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vx/hbiph;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=iWD3i2pe
Date: Sun, 22 Nov 2026 22:49:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795387769;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai6BNNCmBo9LRNnUL5kPH9AVz4boKtQ/jMDNrrKMIbQ=;
	b=vx/hbiphOJ2JXZbOzrvX8STDF1s/YOiFFPVXonNCw5sjY7/lYg0ESbV0pEY17+zaQjwvNh
	CeAgOOvcUZbLuslpjt8IcC2EuUwb+2EL/YsFOnktGoFukEAkVGk8fsL8xcNVzVCAtLxtiJ
	tBgrKWrb5JB/d9BSrJbN1UbDFnCwn034yVsLsLazEQA6K5ukcNOpMXt6uAma86GLieZMYj
	THYev2gt3bGUWBpa2Wzt9A6Qi9w22udErpinJaIGReu4D6kAhnfVQD9W+m35T/Xt3NHvQi
	C4uHZCs/glxHe07Mk0ute0891AobTgfLMUZZdrmTwd89MT4OA12EO5zSwjZTQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795387769;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai6BNNCmBo9LRNnUL5kPH9AVz4boKtQ/jMDNrrKMIbQ=;
	b=iWD3i2pelAK8c6i0y5j6f0SmBHT9nVqYnDnVJ4C0bnI1K756cNKwK6u6n0V4AC4KswuMKK
	DUfhi3bbqTPmcPDg==
From: "tip-bot2 for Fernand Sieber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Don't charge core-sched forced
 idle to the DL servers
Cc: Fernand Sieber <sieberf@amazon.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261112161548.78189-5-sieberf@amazon.com>
References: <20261112161548.78189-5-sieberf@amazon.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179538776739.92412.2067882575359995790.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     051820698aae32c571a66720327f793e2077c0fa
Gitweb:        https://git.kernel.org/tip/051820698aae32c571a66720327f793e207=
7c0fa
Author:        Fernand Sieber <sieberf@amazon.com>
AuthorDate:    Thu, 12 Nov 2026 18:15:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 22 Nov 2026 16:16:35 +01:00

sched/deadline: Don't charge core-sched forced idle to the DL servers

A deferred DL server is charged the idle time of its rq, on the premise
that the time was available to the server's class and went unused. Core
scheduling breaks that premise: a CPU is forced idle when a SMT sibling
runs a task with an incompatible cookie, so that time was available to
no class at all.

update_curr_dl_se() then runs the server's runtime out while it is
throttled and calls replenish_dl_new_period(), pushing the activation a
full period out. dl_defer_idle does not help, as idle_rq() is false on a
forced-idle CPU: nr_running is not 0. Every period of forced idle pushes
the activation again, the zero-laxity timer never fires, and the class
the server reserves for gets nothing.

Reproduction on 2 cores x 2 threads with the default fair server
(50 ms / 1 s): a SCHED_FIFO spinner with a core-sched cookie on CPU0 and
an uncookied CFS spinner on CPU1 force-idle CPU1, and the CFS task gets
under 0.1% of a CPU instead of the reserved 5%. The ext server starves
sched_ext tasks the same way, and there a plain CFS spinner on the
sibling is enough.

Don't charge forced idle. A server still only loses runtime to real
execution or real idle, and one whose class has nothing to run still
stops through dl_defer_idle once the rq is idle for real; with core
scheduling off nothing changes. Getting the reserved bandwidth back also
needs the server's pick to win the core-wide selection, which the
preceding sched/core patches fix.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20261112161548.78189-5-sieberf@amazon.com
---
 kernel/sched/idle.c  |  7 +++++++
 kernel/sched/sched.h | 15 +++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index e0c10a5..717d566 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -573,6 +573,13 @@ static void update_curr_idle(struct rq *rq)
=20
 	se->exec_start =3D now;
=20
+	/*
+	 * Forced idle was not time available to any class on this rq, so
+	 * don't let the deferred servers consume their runtime on it.
+	 */
+	if (forced_idle_rq(rq))
+		return;
+
 	dl_server_update_idle(&rq->fair_server, delta_exec);
 #ifdef CONFIG_SCHED_CLASS_EXT
 	dl_server_update_idle(&rq->ext_server, delta_exec);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4e6696..804c703 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1522,6 +1522,16 @@ static inline bool sched_core_disabled(void)
 }
=20
 /*
+ * True while core scheduling keeps @rq idle because a SMT sibling runs a ta=
sk
+ * with an incompatible cookie, even though @rq has runnable tasks of its ow=
n.
+ */
+static inline bool forced_idle_rq(struct rq *rq)
+{
+	return sched_core_enabled(rq) && rq->core->core_forceidle_count &&
+	       rq->nr_running;
+}
+
+/*
  * Be careful with this function; not for general use. The return value isn't
  * stable unless you actually hold a relevant rq->__lock.
  */
@@ -1655,6 +1665,11 @@ static inline bool sched_core_disabled(void)
 	return true;
 }
=20
+static inline bool forced_idle_rq(struct rq *rq)
+{
+	return false;
+}
+
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	return &rq->__lock;
