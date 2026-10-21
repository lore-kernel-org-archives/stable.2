Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595581;
	b=XsOSVxMi7NK+VwQt+iNvYjA9m6FIffjhT2qPURP1i6eVa1H5Q9PZ3h8jAob8tTkRw4us
	 VUPdpkbZ0WxQbvHA3LmousOF1LVFipQTG4l7JCeBDU48XXgOg3PPFj7NiFxaQJCviSQV5
	 RVuP+/bWAM/68IHQva1Tv6qMrZSMjvw71CwhxGdkqoHYwoUETjhsMrLsu/kxEzgjoKLqr
	 AbNHPBX1NNeHlOFqXmWgHyymf1tHJndVpGsNl9vbNAqC8vXG3o8hk4aDbSEAvOYgmbQ9x
	 D4ytw+DB8oee+Z2FR05n7l4gx4uNbJWvkmkSK0vAnD0i4Bn0e3xZ+WYTLf8dvkBv/yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595581;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jEw/KdOfOErUW2SuDHV0LcQht8o2qarpcFTEkJy1enA=;
	b=EM5dgEuNGGwX6p9H2J0Jo+3bhC0qV5U4gGgnPWh0upLihTudgIn7/70drksvYq73IycM
	 2dBTnaJwvhdaQMLUG33qQHi9wTLStVF3xUj9vKhogqP+ZOCrQzXOrrwG4PygeERO/51jz
	 nSsGf8UKa8AK3ddmO9r9284/9Ui0dgOpsqm7tB1EI+veUbznnnSELw9ueEtLptpghu0Zp
	 xG/m/llu2ToCe6hoW1bqVIrrGdWCb0V3OusQb8dUDieR6UWKrOWYL78SjlXfI+LHdACIV
	 yWh6Jl3uFx4/Tct53STyat0iUGVy8xx+KgwK4/GNkxfb6e3m2eVzrdIvouq44aV5XLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zgI5k8R8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70968606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zgI5k8R8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A141F000C1;
	Wed, 21 Oct 2026 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792595581;
	bh=jEw/KdOfOErUW2SuDHV0LcQht8o2qarpcFTEkJy1enA=;
	h=Subject:To:Cc:From:Date;
	b=zgI5k8R8xtqTP8J0jrQUPnaV/0+iVDCaW8aH36qTvjS0jvuOEiY5nDPE7ltOQogiQ
	 JCBRuJ0TbNxfTCfnjwLWSDIMMWl58awLSWEDAugijBrLOS8VL773KCZfBOH8ff2sUI
	 2hSXX2lhHgwSrdGo78J2vE+QMJTRfqrC8uGNubnk=
Subject: FAILED: patch "[PATCH] io_uring/cancel: don't spin on local work the task can't run" failed to apply to 6.12-stable tree
To: cenzhang@linux.microsoft.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:10:28 +0200
Message-ID: <2026102128-salvation-quack-0ba4@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fddcf4c5321b3ea5f72166c3fd36a9d1c34f80c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102128-salvation-quack-0ba4@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

