Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680820;
	b=dGAIvr8CP/ZFxZBxbPTKkL5G/WrrTssaolfLhgBa86VjEnyCGPmycd3Cy7mJD1vq6Gs3
	 5gU1ASveNDOD1krfpDXN0OYVhbh5WsF5yBzKHppovW53tsjqgIHZP1CHAW5k65IG0DXe1
	 gchGgb062ksXXgjPcK68g3giTrln1ZAsdg3A75zvKWwwFrU9QYG4/OKfobgrL81iO9kwN
	 u3HLhXCrQr8pywOk3jhdfDOX0Y9ATUtq6ODBg/GW3fdAR464UB4uFBAlK59UqcHruIx47
	 6eYRO6mSzecVuQVC7O/RJTMHVmLFkxNmjaKp7PFe7NdWCkeAH9kLPxMnonYILY5eiYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680820;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iFwi5qpkew6tI3QMUCNW5Meq/06eZIGab6fUqENe3iE=;
	b=G/+BaxYCiCeuxydE4zL3gJ43eX8TaLF9c/nEnV5XZzL08RHu895kJu3tm5buqMlDwUx0
	 G5NDstIujimYZQye+1sTkra1i6/AZmN8PU2KglqRCtJG0D133DYgUcZPy2cEizUmK3yW+
	 MU6whRMXXuDE4DpeEBpn/sG8n3gapU57Al2C+0LhujHX/qyVVHUgnU0n2s2DNA/HcTFao
	 GA411g4e+caxqgWm8pO3q6YNggNXFE7kEVPcOGrZd7pfJYK3MwMYn1a3myPH9wfgp/Ze3
	 obGXxbbcPyJpXzTRYM+irrWKJqqT3hhbMDLhnHhHvStfhdSuqkpjdFZelFKkS1128Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uk0Q6M2T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD4606A328
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uk0Q6M2T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6811F000C2;
	Thu, 22 Oct 2026 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680819;
	bh=iFwi5qpkew6tI3QMUCNW5Meq/06eZIGab6fUqENe3iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uk0Q6M2TNtTBY7y+IWpgnyKF1uc2edogBN2Pdm/DCpQP/27Ef2l7huMBcVw7PEj8F
	 WOtb6SuhWIWkrLyxLQwL/2EFAkX8dKetKJekBzmnnSUyzfXDNId2e8T29rcT0dAOeL
	 TcIi5ctEMSiMObK2OMLGUTH+1fPstNqKx7fKc0whwhv9w8ItKTL1UDpUrVolhrxkZ5
	 amo1zBwvF2+ucJyR9qV0JFgUCqNKC5ebsWaqC6FDggHX8P8XzLXDvLSbdsa3RDccS1
	 7cwatQFT7VcZLZMSNJrrkpYd5Bd6I9casAWgQtFq+Z12/pQLLGNKn+dXHmFjsNt2l7
	 jbM/8qLCj9ddg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@linux.microsoft.com>,
	AutonomousCodeSecurity@microsoft.com,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] io_uring/cancel: don't spin on local work the task can't run
Date: Thu, 22 Oct 2026 10:53:38 -0400
Message-ID: <20261022145316.1675229-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102128-glutton-blaming-7e9e@gregkh>
References: <2026102128-glutton-blaming-7e9e@gregkh>
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
[ sashal: replaced io_local_work_pending() with a direct !llist_empty() check on work_llist ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/io_uring.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d4973d0d4e434..e74f49546961f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3491,12 +3491,11 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
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

