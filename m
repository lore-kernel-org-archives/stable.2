Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792833952;
	b=SgUYmDGciUofWn1YM2dg9Z+mYhQfj/LgirAAT8haRM3uehODJNIsgrRWxGlm2+E0lQGW
	 pVHPFrhe+ITQCqJTouli92HSXcm/sH7GfHslk/K3ZsTjodtG9XU10f1iZs6R0+ndnQe7G
	 EDXa6Q3VEr0D2/P3SIw5p+dYZVEvqEeK3eNhy6ClIVZyesGKMwdvR+3yOq1DUVIRHUenc
	 Ro7PTo9mOnJucls9GQa1HFW9cKp3JtU1+YNlkheDcW7WnW9+z10pXcoYNgE+lfGlNxX74
	 uzWZAn4XoybE3uHFjbG4UnCn8j4oD7wlKTGho7dvsi/Hg6/YiXOGWLW4hEp0LKsTKFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792833952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3nhKWaJ5D+aOCAZvNBWBLJ3p5M4hCjWtJQgkUM/vpx0=;
	b=k6vxb7dBWiIduTNSYgL6cWs3/y9CEhIxd3Z3GxeS92WVYChvLmdcMOxDacYDCNOd5hzy
	 k5I7Hia5VQSyIurjoDnW6oPNYmmLhiEoRraO1j4DJsxkFrhYlOjWl4bHJXGVe3BBSg/zE
	 Ls5lTeh7n7nQn+hXhyiSw30HgkenRBUfpunp1FyA48nGg0QD8TgcRTu5LQsulv/F3F5LW
	 Djd9NEeSADB2QATV0j3qTkhObtxs3f+sNnLb+3kpSAZCGIyfApe9usvLGRvlWOGZOgV8k
	 Ozi3Av9kr3KyXS/0aY5D1w7PQBtxit0PxJg5XbDl7aqlpOodkxi2K4BYMETQ/5NABnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kgN4gfDg;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C1606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 09:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C57C1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kgN4gfDg
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e831e86ebfso9635215ad.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 02:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792833951; x=1793438751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3nhKWaJ5D+aOCAZvNBWBLJ3p5M4hCjWtJQgkUM/vpx0=;
        b=kgN4gfDg9n0s1aPOB2JQR06ZJxbegNNjnQ392ZReYj6CUIKnIGDKx/oWtUtAABPffZ
         nG0koz/vtrHVRIVXFTIMsvhbPOUMoRwodOPMPPtiJXMIxKAgHpmUj6mkx8Ivq3AyfKsW
         120PRgiEWrZoONHKEDXSBs7nFJhhZBzmhXQ2DgdEWLGgl9woM0PmSBZ+lPSCGMbl/W+T
         gmWmvUFbzkOe6FH4hQhC+ydrsP1xvaBZMGQefnAAqksH7E6OFI+2iTzu/a/MgZKn+yH+
         mO34bD8NodyBUiI8rNlGEGzyWWjgMWNNtZvMG00yawpk7mEqzdd7y1elczTqo05018Mj
         N8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792833951; x=1793438751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3nhKWaJ5D+aOCAZvNBWBLJ3p5M4hCjWtJQgkUM/vpx0=;
        b=N56y15P3fekXo5BFbScKrZtHICrfKQcXl3873NBFRfwQ7obybZyoafxC+SrA6B63iU
         u9QcuyCiKi1goKw+CC6jkhoZunSssUAoJNu45e/WIIgDYw9LfJ/w4uQPNnpWThMANXFZ
         44zxSgYnzYf5RrxN0siyTlp11w80LFxHRvbdt8DUSW5ZGgAHAmKDaoe/kHYSCDdCIRxW
         kJdLbXWUxAzwA5fL8lXCCjOZZTyZQUk3ROCtmGasn9G8A91o4IVbuUxoNBDIeAwlJxcA
         /ZZ3CwFf1XUe0pTRS8LgurfKFzWVEcU4noRb/mHrJ5kCTNUxdGe3Ns21YJO+FsJOCrZS
         pkmg==
X-Gm-Message-State: AFq9FYIZbcEUos4gyBsfGFrpb78s3J8mrIyXZcYmChwBEj6A9y6TtY/u
	9m/WOFPXc0g23MX/HakQFHeg7POBGqSelouuymM+1Ltaj/C03M8FAG9vbknb3Q==
X-Gm-Gg: AYBFou2GqJr8HdPDcCkn60TdevfQLMgabN40Y8ESXtQBnVxy9+8UhXFDVc8aef3b2zA
	8KJTJ8OH3Kj4uGlHqMI6PoWslzA1wAkTRRkkNz8wvSsgE/LA1674MeyF0F4LPNjLKJKptBRJ/vr
	OhAzSILVQiyLwk9LRsjO49wL4H7gkr3Dee9YVcTZqqeUs7XRn6YwjrMc69cKVVspqiZJbAq/VKG
	7pYV+tAuG9iV6HHmSkwLdTTRR8N9aDHZkHsEr0n8628fhxl5o3FhvKuAzMfrxxYai/S3NKARIMl
	0lA6efDN6IyhDfhb4OyCd7oVhSNkmQfVOMjYXlZJIBXW9ZAlQMJWxR75N1+N+v9bdvLA9TdiUYJ
	B4q1AWk/jk/j2R1meTKrdXUVh4Xi8Ce6DhPbOqDXo8kYQQWWRBXPINdmxnpiSFvgAYNjVIFrbMZ
	/8YhPSWtoaRaqf1ANejZnpfxKk2/sl7f2sWrEjB4v1GdqRIzEAT5/xzN5aNbvZeiCIQbwN6ObLg
	2fvDccW6784PnScbFoot0lmhY2toVYKD2+Oq84y5eJNYAjHAZi1IWzuwj7oTYhZqo9EQtTHFrTK
	Qt4YoMgtx7NwoWNWuLCPdy7OnEwVbJXLBAu4PE0t3TrMwAg=
X-Received: by 2002:a17:90b:5290:b0:3aa:fc22:8aad with SMTP id 98e67ed59e1d1-3adeae86217mr1366513a91.54.1792833951066;
        Sat, 24 Oct 2026 02:25:51 -0700 (PDT)
Received: from eric-hp.. (36-226-42-202.dynamic-ip.hinet.net. [36.226.42.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb24a83sm2304846a91.17.2026.10.24.02.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 02:25:50 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: stable@vger.kernel.org
Cc: Kuba Piecuch <jpiecuch@google.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 7.2.y] sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks off DSQs
Date: Sat, 24 Oct 2026 17:25:13 +0800
Message-ID: <20261024092515.22657-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2026102109-rejoice-reboot-d810@gregkh>
References: <2026102109-rejoice-reboot-d810@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuba Piecuch <jpiecuch@google.com>

A task can be found on a non-local DSQ while the CPU which dispatched it
is still running ops.dequeue() and hasn't cleared SCX_OPSS_DISPATCHING.
The DSQ consume and move paths don't wait for the dispatch to finish and
can operate on the task concurrently with the dispatcher.

Call scx_wait_dispatching() in scx_move_local_task_to_local_dsq(),
unlink_dsq_and_switch_rq_lock() and move_task_between_dsqs() before they
operate on the task. In scx_move_local_task_to_local_dsq(), wait before
scx_resolve_local_dsq() as it may update p->scx.flags.

Fixes: ebf1ccff79c4 ("sched_ext: Fix ops.dequeue() semantics")
Fixes: cb86607ada73 ("sched_ext: Don't run ops.dequeue() with a DSQ lock held")
Cc: stable@vger.kernel.org # v7.1+
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 2935062be77113c1c4565ca9d0c72180449aafee)
[ Inlined scx_wait_dispatching(), which 7.2.y doesn't have, into
  move_local_task_to_local_dsq(), unlink_dsq_and_lock_src_rq() and
  move_task_between_dsqs(), as was done for the reenqueue paths in
  7.2.y. 7.2.y has no scx_resolve_local_dsq(), so
  move_local_task_to_local_dsq() waits before linking the task. ]
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext/ext.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 8d4992e7e012..8d595c6c9c20 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2288,6 +2288,8 @@ static void move_local_task_to_local_dsq(struct scx_sched *sch,
 	lockdep_assert_rq_held(dst_rq);
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
+	if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+		wait_ops_state(p, SCX_OPSS_DISPATCHING);
 
 	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
@@ -2458,8 +2460,13 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
 	raw_spin_rq_lock(src_rq);
 
 	/* task_rq couldn't have changed if we're still the holding cpu */
-	return likely(p->scx.holding_cpu == cpu) &&
-		!WARN_ON_ONCE(src_rq != task_rq(p));
+	if (likely(p->scx.holding_cpu == cpu) && !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+			wait_ops_state(p, SCX_OPSS_DISPATCHING);
+		return true;
+	}
+
+	return false;
 }
 
 static bool consume_remote_task(struct rq *this_rq,
@@ -2507,6 +2514,9 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 	lockdep_assert_held(&src_dsq->lock);
 	lockdep_assert_rq_held(src_rq);
 
+	if (unlikely(atomic_long_read_acquire(&p->scx.ops_state) == SCX_OPSS_DISPATCHING))
+		wait_ops_state(p, SCX_OPSS_DISPATCHING);
+
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (src_rq != dst_rq &&
-- 
2.56.0

