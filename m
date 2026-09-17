Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3744A13A6;
	Thu, 17 Sep 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636684; cv=none; b=iY/norJFEyeSB3K+mw9o+7W62/E1rjNysDxKP4P1ZVQySLAvK0nxq6vVj5R4SL5KKxvC9r2fAmewYst58WHshSJKF+22Fgh5Dy9ma4PQh4fjySuJXXpVQpmXHhdEIZeHGmXQ9ExKCTLr06K2rilfvm+tikQ8fbCjgdor5WZSyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636684; c=relaxed/simple;
	bh=te/fE1/4OvwEnuyl6ZC8l75gKxQO4sF0WSk/gVTYDMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ss87OKHCEOe7Fb7Dh1Hc5J40Q1UA31WR5mn5oD7Lhc8o1jwXwPUnCmEJFgSWRe12arxUhn+GoWslP3ZQm8bBwg7aMbkLv46Q1Hq/qmoZid8AAMYKAGCMW+UcILNw63doEqWzUFRCvt3DngG7Xl8H1ERdB6dgF8JU6vEd4Qujm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtWatflM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtWatflM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9531F00893;
	Thu, 17 Sep 2026 09:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789636682;
	bh=hwwG9dEkssApKuUMYk1+Umj3gb1TMW62tCAHaD7Xzp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QtWatflMw9JiFnRUXdSAc7swvK4m4NId/J7Z624S4xfFaNesuZMGlGsXtHYU2w4+s
	 rYlZlMcCrn7JUPaTQrDVdNgVyzlhMzi3J+g22RarfHlFPwpiMTHl0tT2B7HOJ0ag0W
	 Ks0Cz7FzJwV6cSTEpsWIuzkvfKJpKWoT0+jslfXUfe9P6SB+oEoEFFsTt19Pmcofqh
	 OZKkoB9KWaZ1jUUXlYNPDy4L6EozDmVfI+KCZE8BCUDKRJBjWNuwnde+XppfBqrdx6
	 qFItvM2FBlBxHHyzlSpTmRszC3RvBm8UIb1JitSeh0WiccX1N2H6EmDRrwrmU9RTlU
	 MXcf8yyfIDgNw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 11:17:32 +0200
Subject: [PATCH v2 5/7] io-wq: order the exit bit against worker creation
 task work
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-work-coredump-fixes-v2-5-f3787fcda051@kernel.org>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
In-Reply-To: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743; i=brauner@kernel.org;
 h=from:subject:message-id; bh=te/fE1/4OvwEnuyl6ZC8l75gKxQO4sF0WSk/gVTYDMg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3mDy36CneMHryFdy5z1fKNrdVJl99bXqkuaK/lKml
 SxbH6U/7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIVQTD/1K++zll+1wELhcX
 1NXdKa+WKOjdvmHbsR6H+JdTF/6on8/I0LxY6FLR3SMWT1K3FhksVGD89EgnPilY9+8RN5ecBxv
 NuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

io_wq_exit_workers() cancels task work for queued worker creation with
task_work_cancel_match(). That has a plain load of task->task_works.

io_queue_worker_create() adds the new entry and tests IO_WQ_BIT_EXIT to
cancel it if the workqueue is already on its way out.

That must be ordered. task_work_add() has a full barrier via cmpxchg().
But io_wq_exit_start() sets the bit with set_bit() which doesn't have
any memory ordering.

So afaict, on weakly ordered architectures the exiting task may load
task_works before the store of the bit is visible. The other side tests
the bit before the store is visible as well. So the entry remains queued
with worker_refs and the exiting task waits on worker_done indefinitely.

If the task still has rings then io_uring_del_tctx_node() provides the
barrier via test_and_set_bit() in io_wq_set_exit_on_idle(). When it
has closed all rings though that barrier is gone.

Add the barrier after the set_bit().

Fixes: 71a85387546e ("io-wq: check for wq exit after adding new worker task_work")
Cc: stable@vger.kernel.org
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 io_uring/io-wq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 2ca223e47d41..2a980e86dd94 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1324,6 +1324,8 @@ static bool io_task_work_match(struct callback_head *cb, void *data)
 void io_wq_exit_start(struct io_wq *wq)
 {
 	set_bit(IO_WQ_BIT_EXIT, &wq->state);
+	/* Pairs with task_work_add() in io_queue_worker_create(). */
+	smp_mb__after_atomic();
 }
 
 static void io_wq_cancel_tw_create(struct io_wq *wq)

-- 
2.53.0

