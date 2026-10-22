Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680606;
	b=MjMHpssuZPWLPsnCLen6Pjvv4wX8nAnARYVkVCYq7lMa0N/CEIq3AqETY8QEgybBey1Z
	 mEZjIFklQoNLgTs/yq6N2KMDxwF7xlKO9yPdTQQwmhE7esBXPjCR64d1GD/oShoUg4DL1
	 LiZzhZ5kDtdW2RWjAu8KHoMNjBmfdI7LRyNQ6ScpESgR3BtkzrJwVFTIKSLwZMmu20Mee
	 BjKDO2p3/rCLtYOLTzenz2pI99xUGj9Flo/kZuW2Z57qR1Hk/O3J5FWoNljOOfB4s5vTA
	 IOFURputEweJKeiyJdVrsvopwmXwECR0AqVOoHpwvnA3kXesHRSO7+WzNTFtwOK2TPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0nxzWjWTncpXKqMiUQkEcupUXgWcJgw0HwU/2CIau6I=;
	b=VgNUDs4AMiI10FXiT794MTHttqY5g0CtnQ3/VGmkO451+//g7VNyY4ShvSNypfqLwaou
	 8bzY7EgakTUbFh9y+Izb9ynH8waaCoktCWg+G1OGX3fZFXQT4iu48KonVWLBdHJ7+XWBJ
	 KrvRpLZJHo16YY/+3jgXzZZmYQdfy6PUxn6rATQIqat+6pw7WWv5+r+oqAeBw/V2/YtFe
	 XxfBXvaxCvzpM/d0E5PmkdE6ClGFvFXjeqWMidKwh9yt0vxYeSqKH1GrdhmOJChOTMaxI
	 74p11sHG9mzqi46jQcMWgJQUcrGwhZS39YF5dRxg1B+x7yASaLaYMmkdXLmfaN6HobA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IegnJPI5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CE5606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IegnJPI5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E411D1F000C1;
	Thu, 22 Oct 2026 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680605;
	bh=0nxzWjWTncpXKqMiUQkEcupUXgWcJgw0HwU/2CIau6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IegnJPI56vm8KFSwf70GBi3SOvkws8wlmGj1j8PF3NEny7oHK06brPzBBnXV7y5Ey
	 GtKuMwHT1D7WSkEUBVTayGvCeQzKedd/5eKFnFftktQWMBsaUvJqtgOU1QuzOfIU34
	 psnBpjbul04771rvRgPqC9AR+FFNwGPXBg4hPjfgklqq/T0lgeG2QUbHcv2eZgj0bQ
	 0X0yXp1s8kHqvlfQKyXUcsNEoTnkqONF/GO88ktiOG2EZuBtUqL1HPpl5hEa52dCsm
	 a1Os6ue7HdT8ZxR5c4a3/wXDtteYnxV1a9Q2JGhuOSQkHSxrx6jGw2KCp3YY0ZFB7Z
	 Sm8fThYRYkuBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>,
	AutonomousCodeSecurity@microsoft.com,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] io_uring/cancel: don't spin on local work the task can't run
Date: Thu, 22 Oct 2026 10:50:03 -0400
Message-ID: <20261022144856.1619302-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102128-salvation-quack-0ba4@gregkh>
References: <2026102128-salvation-quack-0ba4@gregkh>
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
[ sashal: Used !llist_empty(&node->ctx->work_llist) instead of the unavailable io_local_work_pending() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 0076c7599c947..68a21552a186f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3190,12 +3190,11 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 		prepare_to_wait(&tctx->wait, &wait, TASK_INTERRUPTIBLE);
 		io_run_task_work();
 		io_uring_drop_tctx_refs(current);
+		/* only skip the sleep for local work this task may run */
 		xa_for_each(&tctx->xa, index, node) {
-			if (!llist_empty(&node->ctx->work_llist)) {
-				WARN_ON_ONCE(node->ctx->submitter_task &&
-					     node->ctx->submitter_task != current);
+			if (!llist_empty(&node->ctx->work_llist) &&
+			    io_allowed_defer_tw_run(node->ctx))
 				goto end_wait;
-			}
 		}
 		/*
 		 * If we've seen completions, retry without waiting. This
-- 
2.53.0

