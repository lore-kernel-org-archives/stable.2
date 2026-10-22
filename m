Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679450;
	b=t+rFDvyoLV8Ol8H3cA39/JnjI6XH6CqHNwHMdQGGqN2dXlBHsUZRZ+gcSi26ncpcqmWN
	 I/fPqlnUittT9PJvi8zBlICIhiEgJBIs178D7KyzMClse/FLMoaD/SSGZiZ8712gOfRCs
	 ffayUOrQ9ERoEf4aNPU/tsGWsJFZzwGIh+8h30LFXHzUpZQPw+6XmFwOAMNTbyts9eqc0
	 OSNuoJYmKrRlyWBDHJTQPSx9NNS+uDmsVuVB2LKVUsjAnDcu1Sw2He4OcfX7BmQCpHsrL
	 /Mof+DojmYVcYOS49kp1oDjMSxG7vOVCzpUNFJxmymWell/uIx5yHkFyBtXtHdkftaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679450;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U5BY3g+2RrZe3zLHbNmwGUZXz1Su7FvCdHLlDmk+Pes=;
	b=fbEBtBr3GJCuaLkbQQPHpMhTwF3oihQfG9veuSOcexPIs51FQo9ZDKfcyoD4jMS/3CKw
	 qqHPOp4Cu4BYjGjR8DRbzM8X+SuRe5kXqCIlCoBLlOPLdfcL+GcaXqqE2392jYGAr8bo8
	 yiLjNt68G1AoNl6DrbfwYjYMtLyaNK3Nkrik1reAcEhquBJcIK/SUKI6c7hphWrjnG4Qm
	 47QpKEF6019W1UxW6uK0oNyaG73gWAhfogLxawLFJuyinMe0flbD25OZypGGfY6gmEcEA
	 BfvrSg/JPJ06Onf1HnPifk+tMlNS4Xh7lf5q/WQFPbNnzhvj/BWTtUSCq/tGvI9J/Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="frCyiz/B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC51606A321
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frCyiz/B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07091F000C2;
	Thu, 22 Oct 2026 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679450;
	bh=U5BY3g+2RrZe3zLHbNmwGUZXz1Su7FvCdHLlDmk+Pes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=frCyiz/BNFnjxRXw51MfK44IAjS67rzt46HgZ3h7pDuCZs2XTmAeXtunjNSLSP3EP
	 Bc8Jsmtp0sy3e+DR0QcHU73LhoYXeTY4awUtZXHi3T6BH8NOthutBTqf1jXGS8kQzL
	 WUUK8LWvW3QYAx6yT5xpdz5/bCcfb/dYfzW07jzgCiuxxGeg99waQAtxwvfv26OnXw
	 aVB/KzUWu1cnxOBcxK5K9v3RrtVfiHJjNRoIPkqKHbiaz1AP6SL7FwvPiQCvyuJFoy
	 so9KOhZ7PC4C7qTII2bq0lqNr52i92/sJubSjcyNx5RhZjuuoILf0cxuGu2b8mN0zH
	 Yenq1aRvWt7Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>,
	AutonomousCodeSecurity@microsoft.com,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] io_uring/cancel: don't spin on local work the task can't run
Date: Thu, 22 Oct 2026 10:30:46 -0400
Message-ID: <20261022143039.1598352-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022143039.1598352-1-sashal@kernel.org>
References: <2026102127-pettiness-citation-cb83@gregkh>
 <20261022143039.1598352-1-sashal@kernel.org>
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

From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>

[ Upstream commit fddcf4c5321b3ea5f72166c3fd36a9d1c34f80c7 ]

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

Fix by skipping the sleep only when io_allowed_defer_tw_run() allows the
task to run the work. This is reasonable since work it cannot run cannot
complete any of its requests either, so nothing is lost by sleeping.
Drop the WARN_ON_ONCE() since handing a disabled ring to another thread
is a supported scenario, not a bug state.

Fixes: 360cd42c4e95 ("io_uring: optimise io_req_local_work_add")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft.com>
Link: https://patch.msgid.link/20261008191602.45101-1-cenzhang@linux.microsoft.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/cancel.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index ca12ac10c0ae9..299071d284418 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -625,12 +625,11 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
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
2.53.0

