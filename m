Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D26395243;
	Thu,  8 Oct 2026 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486980; cv=none; b=ahjfE5SDELihtAntuueYNIPxxTqalJskb/Xr7EfX3Asi7S+S+6g7xWrP0tRq+qEzt5Asfta+h9CldDA/n/FIoi/mk57iVyAfSsGWJXLt/QvPsYHpoJizTU+C+F/RI6jNudiVEh744OoeMz4YxmBr/huk7MLvzj+nfbhrlnmoxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486980; c=relaxed/simple;
	bh=AE1EJmh/iQjqIWdsMtJQQMK0DqBYTnvBsHdaPuAdfxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C12ZoKP5J4ZiYmhMjGj1XOlfiRHzUgB9ID3nC74zgHQDCKo43vqQd1K43zhQvKS2pJJgOtOS7JITQUFhsrK3cGO2Mxy3IFE8nRVQ3OKIHXm+Y3GNzJX6oZHJIhwDLEYUA91c+N5o21s5hLCcZEWDkiniKP8o4nNMehjQGQWFcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gy//8RkZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gy//8RkZ"
Received: from mac.lan (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id EB8B120B7166;
	Thu,  8 Oct 2026 12:15:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB8B120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791486920;
	bh=gO7aKFhmwTvmBkYb+fgLFRiuUC2NVPYTrYp5wtxfFvY=;
	h=From:To:Cc:Subject:Date:From;
	b=gy//8RkZb3KBxlmSwEH1aO0P8o956uKWpGXmaG6KELOZhxxFNz+HFycglwOaSF/+Z
	 nkE8kTfhdF6YiyAUX/rLa5L1S2NVmyB1Vvo5XDiiV1j6PIxiE8oIonXxDpzyS0WXUc
	 c9DN44cH31VhAsGAXCCH8u3iQcoQdatufRZCI6WE=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH] io_uring/cancel: don't spin on local work the task can't run
Date: Thu,  8 Oct 2026 15:16:02 -0400
Message-ID: <20261008191602.45101-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>

io_uring_cancel_generic() refuses to sleep while any ring on the exiting
task's tctx has local work pending. It assumes the task is that ring's
submitter and that the next io_uring_try_cancel_requests() pass will run
the work. This does not hold for a ring that was still
IORING_SETUP_R_DISABLED when the task got its tctx node from
io_uring_create() or io_ringfd_register(). The submitter is set later by
IORING_REGISTER_ENABLE_RINGS, possibly from another task, and only the
submitter may run local work on an IORING_SETUP_DEFER_TASKRUN ring. To
the exiting task the work stays pending forever, the loop never reaches
schedule(), and the task trips the WARN_ON_ONCE() once and then spins in
do_exit().

An unprivileged user can set this up at will by creating a disabled
ring, having a child enable it and stop, posting to the ring with
IORING_OP_MSG_RING and exiting with a request in flight that only the
child can complete. The exiting thread burns a CPU until the child runs
or dies, and with panic_on_warn set the WARN panics the kernel.

Fix by skipping the sleep only when io_allowed_defer_tw_run() allows
the task to run the work. This is reasonable since work it cannot run
cannot complete any of its requests either, so nothing is lost by
sleeping. Drop the WARN_ON_ONCE() since handing a disabled ring to
another thread is a supported scenario, not a bug state.

Fixes: 360cd42c4e95 ("io_uring: optimise io_req_local_work_add")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
---
 io_uring/cancel.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 7d7820eab878..4f706aff14fc 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -634,12 +634,11 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 		prepare_to_wait(&tctx->wait, &wait, TASK_INTERRUPTIBLE);
 		io_run_task_work();
 		io_uring_drop_tctx_refs(current);
+		/* only skip the sleep for local work this task may run */
 		xa_for_each(&tctx->xa, index, node) {
-			if (io_local_work_pending(node->ctx)) {
-				WARN_ON_ONCE(node->ctx->submitter_task &&
-					     node->ctx->submitter_task != current);
+			if (io_local_work_pending(node->ctx) &&
+			    io_allowed_defer_tw_run(node->ctx))
 				goto end_wait;
-			}
 		}
 		/*
 		 * If we've seen completions, retry without waiting. This
-- 
2.55.0

