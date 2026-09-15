Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910CE3905E6;
	Tue, 15 Sep 2026 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467776; cv=none; b=WCBZnqMlmRYbE6g9ePrmk9Nick0Es/2bj282A2aOVZYrW8FPvC+Q2knPwMTu9/EeptMo/FFgJqTN3TCOWJMHvm63JoJwFqq+jGK9GAn0x2epFF2YqUt/pWqvN8Ck5YYKtsFYKnoQwUmF4URE8PMeJpaaCuOjRvNj/9XOw6MZ4NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467776; c=relaxed/simple;
	bh=MjzCX6zOhzcQjz2NOdlaMSrcmoP3nbxniZfVygaRpEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pyx0/KN/rp9Ysy2H7Mwl15U4bluKb55fivSU+KUkhFsuhiDSBwa2x+eopkHBvONF7X4svG4PcHdZlopM4gEvBrBqggFrLoGTaXO7CaO/SBZ/K0YBOHaWlxfJ+9lae6V3oOcTspEJ2PEiDzewbWCQH5z0eeh+LJpNz6Aii3MzMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbzyPScn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbzyPScn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C811F000FF;
	Tue, 15 Sep 2026 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789467775;
	bh=NohqK+vBGRV5AB3jeYvXV60w+u0B7UHNh0tws2uLU00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AbzyPScn8nAMnhi+fskQF6J4dEpANu5vd9+2v4fNNKHC+q5rnZjIAnPN+REx7s+V0
	 xPz22EIpxiaqg7aXrL6IEg3Ft1Vk+Cms77R5ZZStul7va2lVluue7eZkH25MR53ku0
	 8yx/oenO9X44xdF98z5HPJ2mBDQq/hp4x1o915TbB0iulZGWjHLlaaXgpxS4d1V5vq
	 qJIkm5nKJi7n4/R6eYZEKF+kw655HiX5GKZZmlrIRIxy+1BYokx2lzdkYuwXan4RWd
	 4LqBRf5guYpWT9ZuCWKGzrlBJSpx7x9A3N7KE/VDcVd63r4WlZ+8Yt4Yk1hfyzhpOk
	 6k0n0Hp2I3Vyg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 12:22:21 +0200
Subject: [PATCH 6/6] io-wq: order the exit bit against worker creation task
 work
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-coredump-fixes-v1-6-f354ca41780c@kernel.org>
References: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
In-Reply-To: <20260915-work-coredump-fixes-v1-0-f354ca41780c@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MjzCX6zOhzcQjz2NOdlaMSrcmoP3nbxniZfVygaRpEs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStlMmIEly/4/baJRVbr8x+0all6lMovOuWlIvhstVrn
 655cTHLsqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiOR8YGV5ubfn/pDVSP20v
 20o+tvm7I6Y/rFRVtdOWdVs25WF+4mOG/ylf2xe91Mvx5C6raXq7tiEnNOfV/J+THicbvbAzTX3
 OygwA
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

