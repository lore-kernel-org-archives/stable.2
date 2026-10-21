Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595579;
	b=gYtuP2zGSbobucpcAUi0urIhwKwWbclcNnzIvRDBGJPBfSkYli5jP5k1I3llPGL3ED9J
	 QPYOmD+21HMeTAapPoxgrgvmMPFr+dd3czUVDrNQ2N1iptS38EhnaqJJZtZkuF9Mptx8b
	 AhuK+GTmSmkf9H9FElcEb/gew+23YWGsqmRZLbsEpsB9fhjMsQsy35L9Oi4Au2WoxHnj+
	 CatjVRuGU1O4N1tuF9RfzbStJpmymipnA3sGt6vMqx36/ymEiRitvfhFZQYlFBBR8rYig
	 XNrrDgsfCm3JMcfp7NJ26Pgoz2zn9X4erlWLuffK8DUXN8+cvZ25eWf7TPxMV1y1U6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595579;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eIymGksw5s6JqbYM+1LeODvPahD6TLeDfB+RhaldHY8=;
	b=LTEXECGMrawoqhdTJ5Kb6a3uN/Y5zWYLauMb3tp/3Q3udZM8gP7AVFiOS7tWGxHdvPz7
	 5VfEakXiHo1ZO5JPgViDGCcr4KQDU4jdJI51Fx5rL7oRiygW200v7q2gxaDHhQl6AT/Kp
	 IFtKfNI8/2JYJxMnOiz+dIfPypE9A0Mb4F8qVCS3mjx1v3qgznngEXK3aRgAMKxhtLcvo
	 2W7rlKyn4HNjEZVi08t8R/5a58b1a81NusdIht7yYWS7o7fRMTJCSb5IfKIZCE7E91ckJ
	 dOhOrBKitxlk1hf3zCbO21UAAnQUyOFoE5IpnrGpgsEgE7962PMX2WNDL6YDQ3W4Bng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="B/2vKP2Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D98606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=B/2vKP2Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009CC1F000C1;
	Wed, 21 Oct 2026 15:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792595578;
	bh=eIymGksw5s6JqbYM+1LeODvPahD6TLeDfB+RhaldHY8=;
	h=Subject:To:Cc:From:Date;
	b=B/2vKP2QiUWanh9xji52g3ijrvcqMpZKDeZMWFIKWe09WH7W+MlLZicEe0QCzfMUd
	 VJVaDQRq3kBj/b3ziqt0off339wfT0rlGTrfBp3YCGucDeHBD5sS2GBVhZlPbVRwlI
	 rBQ+SOuWe4GK+ZdL+byAHT5Hqe8qCNCDAlwTKdnM=
Subject: FAILED: patch "[PATCH] io_uring/cancel: don't spin on local work the task can't run" failed to apply to 6.6-stable tree
To: cenzhang@linux.microsoft.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:10:28 +0200
Message-ID: <2026102128-glutton-blaming-7e9e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fddcf4c5321b3ea5f72166c3fd36a9d1c34f80c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102128-glutton-blaming-7e9e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fddcf4c5321b3ea5f72166c3fd36a9d1c34f80c7 Mon Sep 17 00:00:00 2001
From: "Cen Zhang (Microsoft Security FORGE Labs)"
 <cenzhang@linux.microsoft.com>
Date: Thu, 8 Oct 2026 15:16:02 -0400
Subject: [PATCH] io_uring/cancel: don't spin on local work the task can't run

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

