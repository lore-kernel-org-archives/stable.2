Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958641;
	b=aryLEz2CSmm4XBQTLyPlFuisXWymUZdtqGHB/syJtrNcfI9wvuKGlw4KUEYJMK2rkK03
	 QgrwXbc9EDs+MS/STMYm4rqgM+ZLNnAHoPbBujMLAQ7llb8TqZJL8R2Hjz4IHZQGzss5G
	 W0H5jah1ImxCO7doswaiEvrtJe4Hx9rU8MA512Ab5iKb+89IiG/Lk3acNEdu5Gmb1Ph9d
	 Gzs7ZBaDm0Eg6512/M2xCd2xm/+mdHID/PyfyqI1gfIvb+e1xv9WjyGnbDkSgp/c/iNVs
	 Q2gvBeELR7z25kWbDEjBJYhA8ph1cLNnetc9vAipD6UXUpT6uhOOAA2c/BEypUC6HEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958641;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=fd+a7G3xSvwgjKwhNsGK6E9dV+lpCpxwKCjbHoMr1A0=;
	b=2lyvTAMIyAfVisFK+IXP+57zbON/vxbyPW1CyjB8J2yB2F+smQwTlEmwKqLC6P3FkrY6
	 8aU9YvHEyvgi3vzNXVuSL2/x0kr+zCnCRSuVcibPAjH1BER5lYdsTKvHYu0BwLvCqdxwk
	 VlihMRRuL6cv83eMbMsPC6T6caQ5zQp7oJs1BBYF67/0A71hVcaMq76vTVBhPHr009kIg
	 ADT0sk4PaoG/O+EPRcENqdhSsYcqC+suSBOrbg5gsYeX+/2QoF4dbXhOA2sNM1UWOLaCX
	 iHpbTBrsYAckVMqBIu+dt3AkqjEY5yJhprulbTzlgZkjxpk38m0PMUq/wXDQcA+Upeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BtZv4RIg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=eR2FCeKe;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561096082BD7;
	Fri,  6 Nov 2026 09:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 561096082BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BtZv4RIg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=eR2FCeKe
Date: Fri, 06 Nov 2026 09:50:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793958639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fd+a7G3xSvwgjKwhNsGK6E9dV+lpCpxwKCjbHoMr1A0=;
	b=BtZv4RIgB5yQFHKQeXOQGxj4HuscSCrtoYL1rVndWqRIXnRvmWfyD2tIRWGYUaSXwgw18+
	zSc6b1aMh6leerHrXNxrzZGS2+ooj/DVxQYsYyZmzi3RnQVPWvG0Iac4uTXm5w4JyJp+yD
	IdC/bYWO8Gnm1ugHulCuGiD16YHYi3Blq/1ItntkN9bEk5zxj259etT+kCe76RtDjPrw4h
	j267gLbS9r0S3ms1U5+LT6XflsL+5cH9/EtFXagRiDeHPMdajZhNZDiCv7s96L9RktuuWG
	v+htK5UocljLedfOsb7Qkp7nRVxkDnv/+BXkioB+iWduC+wPvroQxec4WMmCOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793958639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fd+a7G3xSvwgjKwhNsGK6E9dV+lpCpxwKCjbHoMr1A0=;
	b=eR2FCeKe32U5idp4hFE3/LLRj1MtmW5hiN9OyXf9U6D9Hf8ulsTAPAtGBssRV7Pq0k++Xb
	db1GrYR0PryTQ8BQ==
From: "tip-bot2 for Daehyeon Ko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Clear throttle state when leaving the
 fair class
Cc: Daehyeon Ko <4ncienth@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Aaron Lu <ziqianlu@bytedance.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261022235234.150957-1-4ncienth@gmail.com>
References: <20261022235234.150957-1-4ncienth@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179395863813.1009794.9427104434880401809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c282051fc2cae2ea54770ebe435dbea090272c25
Gitweb:        https://git.kernel.org/tip/c282051fc2cae2ea54770ebe435dbea0902=
72c25
Author:        Daehyeon Ko <4ncienth@gmail.com>
AuthorDate:    Fri, 23 Oct 2026 08:52:33 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Nov 2026 10:04:04 +01:00

sched/fair: Clear throttle state when leaving the fair class

Task-based CFS bandwidth throttling removes a task's fair sched_entity
while the scheduler core still considers the task queued. p->throttled
carries the fair-specific state across dequeue/enqueue operations.

DEQUEUE_CLASS removes the task from cfs_rq->throttled_limbo_list
but retains the bit. If the last finite CFS quota is disabled while
the task runs in another class, it is absent from the unthrottle walk and
the bit survives.
Returning to fair while cfs_bandwidth_used() is false then performs a real
fair enqueue with p->throttled still set.

After bandwidth is re-enabled, a class-change dequeue treats the
stale bit as limbo state and skips __dequeue_task(). p->se.on_rq therefore
remains set, and put_prev_task_fair() places the entity in the EEVDF tree
while the task moves to RT. On exit, the fair picker can select the
TASK_DEAD task. __schedule() then returns to do_task_dead(),
which hits BUG().

Keep p->throttled across migrations and group moves, but clear it on
DEQUEUE_CLASS because fair-specific state must not outlive fair-class
membership. A later return to fair uses the normal enqueue path. That path
still respects a throttled cfs_rq.

A KASAN, LOCKDEP and DEBUG_LIST v7.3 kernel reproduced the do_task_dead()
BUG in 3/3 root and 3/3 delegated uid-1000 runs with CapPrm=3DCapEff=3D0 and
RLIMIT_RTPRIO=3D1. The fix passed both matrices plus a 3/3 class-switch
control with bandwidth continuously enabled, without a scheduler warning,
KASAN report, lockdep splat or crash.

An AI coding assistant analyzed the state mismatch and drafted the initial
reproducer, fix candidate and this changelog. The source paths, trigger,
controls and results were rechecked against the cited revisions.

Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261022235234.150957-1-4ncienth@gmail.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfc9822..ad41453 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6964,8 +6964,8 @@ static void dequeue_throttled_task(struct task_struct *=
p, int flags)
 	WARN_ON_ONCE(p->se.on_rq);
 	list_del_init(&p->throttle_node);
=20
-	/* task blocked after throttled */
-	if (flags & DEQUEUE_SLEEP) {
+	/* Task blocked after throttling or is leaving the fair class: */
+	if (flags & (DEQUEUE_SLEEP | DEQUEUE_CLASS)) {
 		p->throttled =3D false;
 		return;
 	}
