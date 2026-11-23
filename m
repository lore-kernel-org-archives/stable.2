Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427075;
	b=CXKqD9JhB5zCkt7DGx+p5PhWzzD7Z8PQA/s4NWoqqUOYN3oEZhTSV/8k+hAhrgeUg97U
	 QbI1WddEg73DFQFs5/WsY23UjON5KRP7OHb9TUu4GNgw039URp+IsE9M4cAibsDONB99H
	 bur5rw5fnMSbLxD56tnzKykG2bySs5BlSxMCOu3aMoTM0NwJXpz1Y+ItGvNoPxCozGktI
	 HtUPyjIjvJljjYwEtePs1evl9mVnXH82Lp00cX3II5DEY81FHWwDN4qTCOB8FxionSwBs
	 IF3IcB/OiUIaYrk3EItFsLRHIIb6Qxl8m9GGvjJU3ODdniMqSqYp8YBE2dXZC5dC2IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427075;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Xrhu7KV8asVauCgr98upjmtIgU45fuuoWC50qK4gNu0=;
	b=LLejIBEPjhT72k4XIrpOs82cTamv5HchM6ZywCuYsrsbhX4YtUbVRjJaI5tzIxZ0vp67
	 OMKn57fg+m2LKy/1uN3PORshTMzLGrqFMj97z0RkrInJ6UGWa3a+/IpIruU92/wPtCaZp
	 HkBcrR2KyGHzjudj1d5ZaI1dCnBQVjK1uQKZcDeToja51R8QFiBo1VYzooqY1M8VqivdN
	 Mx4PBWK5sZ316WmRcOVff6TIxn25BXKFdBkD8DxaR0ROlspLnHK84zepxriQ/ToCciWfh
	 Jvtf21XK5+3Ys+qpPNn4PwgYNYXxuk/Pn4+9p/UbVNasCj3owKQnp5RBqOG2ixeXYPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="gxk/xeLC";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UExWG5l+;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECA606A31F;
	Mon, 23 Nov 2026 09:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDECA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=gxk/xeLC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=UExWG5l+
Date: Mon, 23 Nov 2026 09:44:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795427073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xrhu7KV8asVauCgr98upjmtIgU45fuuoWC50qK4gNu0=;
	b=gxk/xeLCNomoj6RcVBkU4Q1Xknwa3ylvbW/lG9QWBXWcwQeOJWrA5lb5xUqxCop3iu7Cyl
	hLl+xYYd5g0909IMxqt2ZnTTmdssez2Q+QbeG19Sc9e6ZDlIwhApaCKJJLI5pCIWpVtwGd
	r968mskonj1N9MyJ0lQfw8s5e8OIWfFzdiQdrIj/6f8Y8CM9kofjcDB6aAjQLBi0wi8WEN
	aJaWNcbjFA9q+rZBnJrf/pDbqQrnHp2faMaX1c/j8vlOnfkEMKe5aLq2BSGw99yjFvQQLb
	MtkQ7jjvK9oQn8b/QY6F2HQ8RYBksvQXNT7Bl1SAt6Htt8OgaxzMWzF3apUccA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795427073;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xrhu7KV8asVauCgr98upjmtIgU45fuuoWC50qK4gNu0=;
	b=UExWG5l++tGsqj5cycC/sP/pTBnGcgvTktGMOms2M+LRwNqMgEKiyOoUs6HHTsIn6toHZx
	yGxKY9aQ6HtjwJBw==
From: "tip-bot2 for Fernand Sieber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Clear stale rq->dl_server when
 core-sched replaces a pick
Cc: Fernand Sieber <sieberf@amazon.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261112161548.78189-2-sieberf@amazon.com>
References: <20261112161548.78189-2-sieberf@amazon.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179542707142.92412.17060348178534470717.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d2583cb031135d3e2f6eeec9049fc2066fd3655c
Gitweb:        https://git.kernel.org/tip/d2583cb031135d3e2f6eeec9049fc2066fd=
3655c
Author:        Fernand Sieber <sieberf@amazon.com>
AuthorDate:    Thu, 12 Nov 2026 18:15:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 23 Nov 2026 10:38:26 +01:00

sched/deadline: Clear stale rq->dl_server when core-sched replaces a pick

With core scheduling and the fair server, the forced-idle accounting
warns from an idle core:

  WARNING: kernel/sched/core_sched.c:263 at __sched_core_account_forceidle+0x=
1d6/0x1f0, CPU#0: swapper/0/0

The core is in forced idle with no sibling running a task. The reason
is a stale rq->dl_server causing the idle task to incorrectly be
considered as carried by the deadline server. The idle task then wins
over a runnable sibling task and the whole core is idle despite having
runnable tasks.

The timeline below describes the issue:

  Setup. CPU0 and CPU1 are SMT siblings.
  - CPU1 runs R, a SCHED_FIFO task with cookie X.
  - CPU0 has C, a CFS task with no cookie, which has been starved.
    So CPU0's fair server is due to step in.

  t0, CPU0 picks for the core.
  - pick_task(rq0) goes through the deadline class, which picks the
    fair server, which picks C. As a side effect it sets
    rq0->dl_server =3D &rq0->fair_server.
  - pick_task(rq1) picks R.

  t1, ranking. C->dl_server is only set once C is switched in, so C
  ranks as CFS. R (RT) beats C (CFS), so the core cookie becomes X.

  t2, matching. CPU0's pick C has cookie 0, not X, so it is replaced.
  There is no cookie-X task on CPU0, so the replacement is idle, and
  CPU0 is forced idle.
  - The code sets rq0->core_pick =3D idle and rq0->core_dl_server =3D NULL.
  - The bug: it leaves rq0->dl_server pointing at CPU0's fair server,
    even though idle didn't come through any server.

  t3, CPU0 switches. CPU0 is the selecting CPU, so next =3D idle, and
  put_prev_set_next_task() hands the stale rq0->dl_server to it. Now
  idle->dl_server is CPU0's fair server.

  t4, C leaves. Load balancing moves C to another core, so CPU0 has
  nothing runnable. The stale link stays on idle.

  t5, the next core-wide selection (when CPU1 reschedules, say on a
  wakeup).
  - CPU0's pick is idle, and the ranking sees idle->dl_server set, so
    it ranks idle as a deadline task.
  - idle now beats R, and the core cookie becomes idle's cookie, 0.
  - CPU1's R has cookie X, not 0, so CPU1 is forced idle.

  t6, result. The whole core is idle. R is runnable but can't run, and
  nothing runs on either CPU. That's the WARN in
  __sched_core_account_forceidle(): forced idle with no sibling running
  a task. It lasts until CPU0 goes through a full schedule that resets
  its server link.

With this patch, step t2 also does rq0->dl_server =3D NULL. At t3 idle
gets no server, and at t5 it ranks as plain idle, so R wins and keeps
running on CPU1.

Fixes: bd9bbc96e835 ("sched: Rework dl_server")
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20261112161548.78189-2-sieberf@amazon.com
---
 kernel/sched/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 515b9d0..42b99be 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6453,10 +6453,15 @@ restart:
 				p =3D sched_core_find(rq_i, cookie);
 			if (!p)
 				p =3D idle_sched_class.pick_task(rq_i, rf);
+
+			/*
+			 * Neither a core tree pick nor idle comes through a
+			 * DL server; drop the one the replaced pick left.
+			 */
+			rq_i->core_dl_server =3D rq_i->dl_server =3D NULL;
 		}
=20
 		rq_i->core_pick =3D p;
-		rq_i->core_dl_server =3D NULL;
=20
 		if (p =3D=3D rq_i->idle) {
 			if (rq_i->nr_running) {
