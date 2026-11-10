Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320914;
	b=5EspThKc1fdC8/lmdrNgWDVsyNUAq5wCF92JK1sR2iH1/6bAVA/plTPnheVNev8sjoeB
	 GgYOo9uuEpRBz2Vts6etxxJheCd7UTuXBbkEnnCEZ3Vmjz32lXaUUIfRoFuU6RhAKDw0z
	 T2AVyL1YQOa/F7OZn+JaqNgj7B569CcO0hBrKnAWVEKaNdoDkjGSQ1ZfDfOWGNtRXrl0X
	 zkoHhlYqhg75qAkKwhBoBk/7TAFTA+bdPrGCeOcMuw9Gu/fBcNWFc/iUdpBuNx/mmC62m
	 +cc5l9B4c7Hvi2eoxCLqzJOdiqutUFcTcwWsKa9X7obajJMhkxEsE0bg4Jq0hm3B6RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MqraL4pYI3WOLZfdxQ0WEo828k6jsvlr5I93mDDDZtw=;
	b=JhemThMzn+Ydh9uZWChX+IN3DIdK3oof+o2vDrkj8XULD4IIcWMSr0pAE1yR+pRTWNHd
	 0nsqukTPMlmIKntzp+ocIO4CWmdVFdv2WmHc4sKwRe4akG2lxoXr3i5Oc7jam0DUM8lji
	 CAgbZr6bo9ftqVtZk75uDaCcHvczZrWTZ+X4FF3uofeARdfc8KC/wlnJLO4/pH+4dvioA
	 eboRisRIHfG0OhO2PjgoQkYQaEc8b/iC890LfDFbExbbN2OUKQwv7FEAqePNuS2WfIfeW
	 IIzUeHD+vwT5cxqMa3rRaFQGo4wUQFAggM/ONdg4bLIgxuERYccpFb0gFytNbuIrLdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=af9z43iA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14560727EC
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=af9z43iA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89A21F008AB;
	Tue, 10 Nov 2026 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320913;
	bh=MqraL4pYI3WOLZfdxQ0WEo828k6jsvlr5I93mDDDZtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=af9z43iAMUfFYd3blh/i3lSx+H5ZhDPUPAaDRtT2K8Kj3IrM8B80A1pxbuYGO+WmS
	 qw4I3fk43Ni6Mbr8JrtMwJuFmk78usTsdq0F1m8H6QZHX4j/RkexnirF+yjVTme1++
	 MPTy1tEJ/z4UP2tXnFeFUO4K6rdfYzy4+YHMZSPUq8JFzPVVQ5N5FSPH9+Tz6eutmn
	 d1fY8b9HpzHczCj5MEVsKZMYa75KN0FYMhU4Njq6C1jaEEuZqWPJPkSof4hnB/xGkF
	 pPmTeSaBRNAcd3GktsllNbeMetfZQDsz/yF5y//TC6PKJthooPB+k43XXUxQXvT0om
	 FqCAak97yrUAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ublk: keep a canceled FETCH round canceling until the server is gone
Date: Tue, 10 Nov 2026 09:28:31 -0500
Message-ID: <20261110142814.1876003-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051205-failed-6.18-4c454b5b2634@kernel.org>
References: <20261107051205-failed-6.18-4c454b5b2634@kernel.org>
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

From: Ming Lei <tom.leiming@gmail.com>

[ Upstream commit 4c454b5b2634d982caf797fbe477770c3edfc983 ]

A cancel completes a fetched io command and sets io->cmd to NULL, but
the io still counts as ready. Only ubq->canceling stops ublk_queue_rq()
from using the NULL io->cmd. Two paths clear that flag too early:

  partial FETCH round                 recovery, two queues
  -------------------                 --------------------
  task A: FETCH tags 0-2              q0 ready: q0->canceling = false
  task A exits:                       q0 task exits:
    start_cancel(): mark queues         start_cancel(): ub->canceling
    tags 0-2: io->cmd = NULL              is still set -> q0 not marked
  task B: FETCH tag 3                   q0: io->cmd = NULL
    queue ready: canceling = false    q1 ready
  START_DEV                           END_USER_RECOVERY
  read -> ublk_queue_cmd(NULL)        read on q0 -> ublk_queue_cmd(NULL)

A FETCH round runs from the open of /dev/ublkcN until
ublk_reset_ch_dev() resets the queues. A canceled command can't be
fetched again in the same round. So the ready check only needs one
fact: did this round see a cancel? ub->canceling already records it:
ublk_start_cancel() sets it under cancel_mutex before any command is
taken. It is only cleared too early, when all queues are ready.

Fix:

 - clear ub->canceling only in ublk_reset_ch_dev()
 - when a queue gets ready, clear ubq->canceling only if ub->canceling
   is not set, and check it under cancel_mutex

The check and the marking are ordered by cancel_mutex:

  check first:   queue cleared -> start_cancel() marks it again
                 -> command taken
  cancel first:  check sees ub->canceling -> queue stays canceling

While ub->canceling is set, no queue clears its flag. So the "all
queues marked" shortcut in ublk_start_cancel() is correct again.

UBLK_F_BATCH_IO follows the same rule. It does not dispatch through
io->cmd, so it never hit the oops, but a round which lost a fetch
command is treated the same way: it has to start over.

Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
Fixes: 3f3850785594 ("ublk: fix batch I/O recovery -ENODEV error")
Cc: stable@vger.kernel.org # v6.17+: needs cancel_mutex
Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/linux-block/20260928-b4-ublk-cancel-stop-v1-0-4a4360232a46@toxicpanda.com/
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Link: https://patch.msgid.link/20261011063555.1142277-2-tom.leiming@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ sashal: Adapted per-queue readiness handling to the existing device-wide ublk_reset_io_flags() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6b2035c46daa3..c0e4f94cc43b0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -233,6 +233,11 @@ struct ublk_device {
 	u32			nr_io_ready;
 	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
+	/*
+	 * A cancel started in this FETCH round. Set by ublk_set_canceling(),
+	 * cleared only by ublk_reset_ch_dev() when a new round starts. While
+	 * it is set, no queue clears its ->canceling.
+	 */
 	bool canceling;
 	pid_t 	ublksrv_tgid;
 	struct delayed_work	exit_work;
@@ -1637,6 +1642,11 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
 
+	/* a new FETCH round starts, the queues stay canceling until ready */
+	mutex_lock(&ub->cancel_mutex);
+	ub->canceling = false;
+	mutex_unlock(&ub->cancel_mutex);
+
 	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_io_ready = 0;
@@ -2152,8 +2162,15 @@ static void ublk_reset_io_flags(struct ublk_device *ub)
 
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_get_queue(ub, i)->fail_io = false;
+	/*
+	 * A cancel in this FETCH round took a command which still counts as
+	 * ready, so the queues have to stay canceling. ub->canceling is set
+	 * under cancel_mutex before any command is taken: either we see it
+	 * here, or the cancel marks these queues again later.
+	 */
 	mutex_lock(&ub->cancel_mutex);
-	ublk_set_canceling(ub, false);
+	if (!ub->canceling)
+		ublk_set_canceling(ub, false);
 	mutex_unlock(&ub->cancel_mutex);
 }
 
@@ -2173,9 +2190,8 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq,
 	ub->nr_io_ready++;
 	if (ublk_dev_ready(ub)) {
 		/*
-		 * now we are ready for handling ublk io request, clear
-		 * device-level canceling flag and wake ublk_dev_ready()
-		 * waiters
+		 * Reset queue flags unless this round saw a cancel, and
+		 * wake ublk_dev_ready() waiters.
 		 */
 		ublk_reset_io_flags(ub);
 		wake_up_var(&ub->nr_io_ready);
@@ -2996,9 +3012,10 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 
 /*
  * Wait until all queues have fetched their I/O commands, and return with
- * ub->mutex held and readiness guaranteed: then every queue's ->canceling
- * is cleared. Ready may regress between wakeup and mutex_lock() (daemon
- * death), so re-check it under the mutex and wait again.
+ * ub->mutex held and readiness guaranteed. The queues stay canceling if
+ * this round saw a cancel, see ublk_reset_io_flags(). Ready may regress
+ * between wakeup and mutex_lock() (daemon death), so re-check it under
+ * the mutex and wait again.
  */
 static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
 {
-- 
2.53.0

