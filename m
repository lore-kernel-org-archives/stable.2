Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FAF4A205D;
	Mon, 21 Sep 2026 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998323; cv=none; b=cV8SaGP4n2n4bmuTE4bv5chC0VXM4+S9NXn/wSI9CsEHrH0FfP/Y1zjs2DdWH/4i3lHKlQCq3UlLwUS/RHMyWnfgCnV/8dZM1ZpxaaL5HeEjER+L/DwWOBYwumL9ExcrC3bbA8AldKrd5sqBXEM5VhZEzspdu0z1VGjGtecuoKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998323; c=relaxed/simple;
	bh=I9adUaO6/vXVSqyRv9Gsx8nEfE1O6rVs+YV8BhcfEiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJfn9RKy5JiVa0kgClWcfJIXguk7zldWS5DTkNfmVlhmvXsYaG/0m8IvRNkgZYpr2L6xAjIU2LpGB+vgHKDf2YiipXKOsxacjI0yY+TXusLotgFaG1Q0bluWfq/p+59QJjBdedQKMRcx9W5T8VN/7ZO2bj6yj3dbyAWwvWTf1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc/OMmgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc/OMmgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980F81F0089A;
	Mon, 21 Sep 2026 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998321;
	bh=noSJaKaApwlaS+y/XuQ2BeJGsLJq4q/TgrRJwetkGmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Nc/OMmgden9Sch3xPcq/Wfepqx+lMcRh1nuCXA+s9LMLaVFSV0phw7q8Zj6y7OU4L
	 2WbojhpIW3mZ0pq2DERzhAdb6SFlujeGUbZGx24FVE9ffsxkrg0fxK/C5JcDQ/OrTx
	 qMwm3hJKuOUCStf87mu11kfTKwRMpjybHFFWwk5UyOIgG6iQozyegxl+kjMXNOji3X
	 zF3MVcCgkuiWZb1Uywq3wpuksX+ImSv3wxCGYrFUPG8iIee4CcyS/79j67gIpttSbV
	 IivPci76szJLZSCEow7zDddBANUG7uNjKY4dIabC/qBHISBY7FgNf2bQfQ1u4VU5Kp
	 YjGIcYnvhWWlg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:53 +0200
Subject: [PATCH v3 04/17] io-wq: order the exit bit against worker creation
 task work
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-4-8e4adb1619e6@kernel.org>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
In-Reply-To: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; i=brauner@kernel.org;
 h=from:subject:message-id; bh=I9adUaO6/vXVSqyRv9Gsx8nEfE1O6rVs+YV8BhcfEiY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLkz983aprOS14L4z3Xc9c88/XbC/L3cqw2aPQJTV
 O06lU+adZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkxz5GhsnTPmz+ZxKvmcjL
 lLt6XdO+Fx8jH11xVzxzK4F99V49X2uG/+4ZlRoRKXNOWKYs/KASJ/p9ewEL35H5TDt4ngbfydh
 3mh8A
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
Acked-by: Oleg Nesterov <oleg@redhat.com>
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

