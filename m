Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387767;
	b=N3/6Ps/Tvq2RI481t1bE0VqAqKNLhJiJbadUhdlpgfe/tgtyWYjFQGrD/bVF42itD/gq
	 jWHjyEFagXz2xL2BvT9ijCvRO05IRMynbe5quY0Nxwxn2G5+Q4iCZjrMiYsDtW2HuXwtH
	 iiAiJtPAt7Cb8TFxScJVeINnLVpCUEQEEG1kIiLtjC3fg/FKlqwKSvibkzt3XbhZoIAfR
	 8HjfC/3EB0KL5TyroDDSAmJfl+ZtjB73yE2C5ofX+3kTuqavbsWGWJz6VKkhaNow9V8RK
	 8DsgzmkGno9PgDBPKsX6rKPPA2tREXd62+zjwJ+oQ4GRAYj5vQoX0fOxSGs4C93SiVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387767;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=7bInOB84iOvIqCu3pV7xrrTsYWTiv0cJwYHK7Ub539E=;
	b=t1YJ9iHpzL6D+P7ziPVoH6v3giHZ+FkawMdE7BK61xpEZL0+O/TkiL9sDXHFrkiSGnyL
	 2ygYK4Yqf9j/oVrqwqJL/oQH6xIh6S9J40iuJqZJt2fqp0SaGeBKzRfgOoAsYT/krtYq4
	 TSUbd4kr0Sk3qZLouoUIKhrWmKojZxrxKzSY/2h9260kUt02WuCi4mm+4j0pwInFY0yJQ
	 0CknkgKBnD1iFsIR4DniwulvTo4speVmmMkITUZk3JmZbUdP8Q/opRSewU1EPiTmFhneC
	 jv+8ybfDHcxt4pPMUEzwMf3+AF6vQDTLEJvq2K+0eJeXy/W9Ldrt363MbIEXiaWH9/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YAiBo0AG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=X0lW7hcD;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23414606A680;
	Sun, 22 Nov 2026 22:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23414606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YAiBo0AG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=X0lW7hcD
Date: Sun, 22 Nov 2026 22:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795387765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bInOB84iOvIqCu3pV7xrrTsYWTiv0cJwYHK7Ub539E=;
	b=YAiBo0AGIdJNd66CD4O4cqiNJUW0/DA8qJQir35INhKIt1DsYvTkbRTbtfTqtuQm7N5m0V
	Hh9JexCJLIZjst1Igc+TX2wXvtrDBHeAxoRDaqz5epqWcosISrB/lb4WnLrx4Nul5Ob6Ag
	chzbXpYxnQbkOjNr/vtpQjVyTqbix6IXJo7wDluIEMDBjTegv+i3pwgrzFXm3Z/pgc/CNg
	r8BGp4TFJHjeQMsdFPZ12uLJNyAHYxoeWditbbTk6sUD50gKEvukk7j7G9prT0ibAmePht
	qKpRJ7i3/GdKOyOiUkZrp9a0zxrorfqz+W1VzBK165InB8/l4roxkOrmpDM+6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795387765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bInOB84iOvIqCu3pV7xrrTsYWTiv0cJwYHK7Ub539E=;
	b=X0lW7hcDH5VKNxe3G5MnDxlLz5GeN78tTUCRm15LQ7Qj4wrD+vHx9Y2zZo31pRlfaGpAfa
	g3PUIdvxayY2goAA==
From: "tip-bot2 for Ibrahim Elshahed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/core: Clear a stale rq->core_pick after dequeue
Cc: Roman Kagan <rkagan@amazon.de>, Ibrahim Elshahed <lshahed@amazon.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261120105822.7770-2-lshahed@amazon.de>
References: <20261120105822.7770-2-lshahed@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179538776425.92412.13832952462447135009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     bf437249e07b84fcee0fe192cc8591592d336355
Gitweb:        https://git.kernel.org/tip/bf437249e07b84fcee0fe192cc8591592d3=
36355
Author:        Ibrahim Elshahed <lshahed@amazon.de>
AuthorDate:    Fri, 20 Nov 2026 10:58:20=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 22 Nov 2026 16:16:44 +01:00

sched/core: Clear a stale rq->core_pick after dequeue

A core-wide selection leaves the task chosen for each sibling in that
sibling's rq->core_pick until pick_next_task() on the sibling consumes
it. If the task is dequeued before the sibling consumes it, for example
migrated away, the pointer stays until the sibling's next
pick_next_task() overwrites it. Until then
__sched_core_account_forceidle() keeps charging forced idle time to a
task that no longer runs there and, with schedstats enabled, to its
cgroup, even after the task has exited.

Clear rq->core_pick and rq->core_dl_server in sched_core_dequeue() once
the pending pick is dequeued, and don't wait for pick_next_task() to
overwrite them.

Fixes: 4feee7d12603 ("sched/core: Forced idle accounting")
Co-developed-by: Roman Kagan <rkagan@amazon.de>
Signed-off-by: Roman Kagan <rkagan@amazon.de>
Signed-off-by: Ibrahim Elshahed <lshahed@amazon.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261120105822.7770-2-lshahed@amazon.de
---
 kernel/sched/core.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 42b99be..4b1d36c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -329,6 +329,15 @@ void sched_core_dequeue(struct rq *rq, struct task_struc=
t *p, int flags)
 	}
=20
 	/*
+	 * @p left this rq, so it can no longer be the pick a sibling made.
+	 * This also avoids forced idle accounting charging it once it is gone.
+	 */
+	if (rq->core_pick =3D=3D p) {
+		rq->core_pick =3D NULL;
+		rq->core_dl_server =3D NULL;
+	}
+
+	/*
 	 * Migrating the last task off the cpu, with the cpu in forced idle
 	 * state. Reschedule to create an accounting edge for forced idle,
 	 * and re-examine whether the core is still in forced idle state.
