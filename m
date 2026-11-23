Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427070;
	b=jc3L0pGyMdVfpB8TA83yqsASW92slW289QMrylMUu4BUz/ONDuQaC+5tPt9Oe0MzIuRx
	 yua6/UZvarm5eQijy9bDH5BuhGbq10nocEcpgvktmow8V80ocWV6E8to4PwB+JEro5crG
	 roElAUQfTSZxHMe3a67xi9f3jL3Q7fnZe5wOoYq6hWwUA9/Ehn816hNgkXgcjZs0zLVM2
	 ezcCSKucL5ADIl/NZZT5yD8provb+7Yck+9NKX+ccFWUXGcoC9GbZYQh7kOjUvDP2qbQX
	 cX2cUoSjsfrWDdXhwcNQg8djFBMN8ExtVHbffFOEh7LM7FvnH09w9gd7sodb1yW1BOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427070;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=P1YdagB8hNpjP5rymuaQgzSg7M4glBGk0VAYN0plbK8=;
	b=wdD735AS1knhx+cidh5MknoAdht8uTqjondq9XbZA1NX1aWMCz2q4z2/YIJfSifffrAc
	 CAFZMrq0Mx/nLCQJ4hdnrKGD70BBLKxOzUH8vVjUmuTbYpsCTK9fFD3EWBlUOPI1k6JA2
	 hVhxJCm1Mgu4E5oCOqRAa1OnD3KOoVpNIDG/04mvFwrIf6d6dYMT+U53YL/fo05L8flT2
	 4b50hsQHPQ2B/dHspHMm0PtJqhjHs0ZGfbLvsfOlOPaqfWwavrFeefBccsw0umbJTdskN
	 jNiAH8iPMZA2ZSYg7Na+2Vf3TrJ7M0mtnVpgYMRvw+VQ02ZPt0bcXu8tX2fzo5RqyIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mWzRJBuh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WG3xBGn5;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE57606A331;
	Mon, 23 Nov 2026 09:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDE57606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=mWzRJBuh;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WG3xBGn5
Date: Mon, 23 Nov 2026 09:44:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795427068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1YdagB8hNpjP5rymuaQgzSg7M4glBGk0VAYN0plbK8=;
	b=mWzRJBuhgB9361LXEV+f88c6NXNoAFNnDL+BjBCl8u5V7YhMiOpm3f2SXy+nYqw4BDp+rT
	V5imyPR2M3mN4m2vFGOji/S/afi4FdhaKJUgjUwNfsohtRZ3pGLYDEBMR0j8BYXPssUm0/
	Ih+6SChHQCij9yTnLhBf2rPXBylaTSQFIjLMi+ATaBZG/gVPSbXtIA6c7mEz/RBtYkLMae
	VRvEAwyX13CIzJVW924KQv/trS4jaw92RiKyy1M3gunW1BUdUkxjJ4Wni+ByyjY05q4eAM
	gmaNzxCz2LCj8gYc6H/RJBLQSsTdAq7JPGP+gZJwmnprKSH2U0GzG1ZRevXCWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795427068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1YdagB8hNpjP5rymuaQgzSg7M4glBGk0VAYN0plbK8=;
	b=WG3xBGn5YFapbxJAwG6Qui1aO+5/eehYTRyqZtLxH9Ytpn/6SQ9ON9ijVtHu6FH646xT9l
	OtikvA85MiM3fzCQ==
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
Message-ID: <179542706629.92412.731576680350374623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b704f052aa943903be7140fa8bd805b1de9d5afb
Gitweb:        https://git.kernel.org/tip/b704f052aa943903be7140fa8bd805b1de9=
d5afb
Author:        Ibrahim Elshahed <lshahed@amazon.de>
AuthorDate:    Fri, 20 Nov 2026 10:58:20=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 23 Nov 2026 10:38:26 +01:00

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
