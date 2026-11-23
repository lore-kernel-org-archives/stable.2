Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427073;
	b=YCJ1jPxT+KunTZ+lDRDiGCCD255JlP4pQZbzk7H5U3207zZi2Ehr93ZO7KGYvBu1+p0N
	 eZlBb1Xwy/uHUvIkgmFLSl0YL0NxW6+O6BcrEw3g3WfHO4vkTQqLCiffS9d+6gdvYZFIR
	 cd4NXpSDL13lU9lTonNmh6cgMhKvYieDvNYyg2OuG+A2KPJwwmfMbRC5zJHZjvfmF+5XE
	 9ibBKmPGH8UpDny9HeD2c70mfU02aJFFtQB1p2kl0dt6TPqCl8l+6DGJYo+HT7rpi84/5
	 zpq+CySX3TnSsc28038vitJMRMGSOxqeOVYo8RAY48bnvHxhRmzluiegLrq8LMDSv8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427073;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=eVFaz5Wk3v9VSOPauvwk3pvcBxmvB9me3nh7V6xDTgw=;
	b=JCRXZ7XwWNv9xf6Tqvhd+CBT7kQKTEXILyi5N963LpVcTa2FSUPAWyze+xYsY9AhBex7
	 cVSOPeLCVUNZhve82KJkpb1tV2UI5dQKh5XDQWwjEV/WJZEd1LajIqlZtwVb6V6u+PB81
	 KFxFbk1JJsqogsHktH72rd+wLRQuA5KC7FMMjDwP7lvVF+brIn+wqFIWB/g/MV9oMiXym
	 65Oylx7KHzjhvpLEDEsixcUZ06LNw3Z7qCM4hVZL1ElOyx0vkGmwFSftZgAws2y6PT9Ea
	 OfxMTmbPxPNmRGhkCuHhOSqrPOyxs75frV1uI9RpJIKJrmcgs2gibODxuHpcFfGUFrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0kopUjVy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5lRfN8P2;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92A606A333;
	Mon, 23 Nov 2026 09:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E92A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=0kopUjVy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5lRfN8P2
Date: Mon, 23 Nov 2026 09:44:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795427071;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVFaz5Wk3v9VSOPauvwk3pvcBxmvB9me3nh7V6xDTgw=;
	b=0kopUjVycCSPFzAT/3jkUbPXciFjDMhiUymARV71Yn3GjbNQ7zAvcw+U/1HCwVDvY5l+9H
	wV+ZahTeVK/jfgNCn4AJP7torG+/XE2TxHb2lXW45652g/eYN56L/7K0oqzoJnFR3NQT1y
	4d1cyEr9v35ZAmJvtrcEZu3UFjdfRsjnaLC9vvc8Mg5J0yqP5yzAVZ+WkDYzk4LhvA8YJS
	SX8FH83vWAdwW0m10SOksYj0ZhJVs3IIcXmI3EtzyPH8Xip4BIXnhAy+3OEwE8tEMj9FfL
	wom3nw3eiur4AliPlRX7K0inLoXKrfONUuUZw5sqx8/4QyrC5rfK8jp6b1dUeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795427071;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eVFaz5Wk3v9VSOPauvwk3pvcBxmvB9me3nh7V6xDTgw=;
	b=5lRfN8P20jJBNsk/85lypyUqwk/4Alg6Q+NQq40/57UPr8jhjf8ldeL/DttsV+gDWWVgWb
	ecDkSIXrG+gIfzBA==
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
Message-ID: <179542706960.92412.5489131520729394753.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     f4626e1c3c14306453e89bfc7799bd295f38b402
Gitweb:        https://git.kernel.org/tip/f4626e1c3c14306453e89bfc7799bd295f3=
8b402
Author:        Fernand Sieber <sieberf@amazon.com>
AuthorDate:    Thu, 12 Nov 2026 18:15:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 23 Nov 2026 10:38:26 +01:00

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
