Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9D3630AC
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700569; cv=none; b=CiLDW9hw2daSeXgNEINovPAY3ounF/a2/TAKRMMMOPt2PXKzxuPgykpYfB29xBharPBgM+roRNaFUXkQEmCQrC+9uMCZG4C6iJSbLnFyZ5tW9U7a7IlUF12IKyp/gye+WpxV8ZVVcXMNUZ7cix7bPdUilQ74B4lWvlgnwYS7dNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700569; c=relaxed/simple;
	bh=2r9suteqFeF/YPgNBegydTt1hCPTuGjcUCKvFYoN0P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsnYscolBDuQHgLldZmz/A1pwS3bppi9IAi02LDkxoxX9VVh9EKPb+ToGKIyC82gj+ozEb5SfFjuPa/7RuZRfIh9RdL8Bkco5EngExXB9tNgxGdyvLrJpOSMFHr6tcnUyzYX5R48Ll5K0XaQyhl80QvmItOULrom1wL0rtxwMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+5iojxb; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+5iojxb"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-81ba09a5d23so969964a34.3
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700566; x=1792305366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=25e6yVwl6D8uo4gZk7ovRW1/iEoEiYywdpFO+LHDP3o=;
        b=g+5iojxbGL1/QPAa3kckSOQzaq8d3dKYsACOamPNJ4GkyLp67ZquBnRYhoEiYxJQks
         d4ZMiTCHzPXS5e+mx8e5SiUDrodbiP56Sr5voxDdFelK9n+HKMkAvdKbz8rObM8bl3mL
         CJox0Bgvzio7U91zp9Dhaze47Nn9qQgdacnMcA28e9BDgV4X6woUFOOHS79tzF5frqdM
         BO52ty40c8Hyw0F8tfLrJ7RmysbOM7psabfhGkSw9RVrr5ujGB4t3TzK4vxd8XM23Gda
         4h+GM2EVmvrq9ZLZwYRSnBQllTrkGvZS6gVUYkqm34SYD+4Nty6uxJ35G+8LeCSlv4iU
         nTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700566; x=1792305366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=25e6yVwl6D8uo4gZk7ovRW1/iEoEiYywdpFO+LHDP3o=;
        b=QyIFnJmWfE8UvNwibVNF8x7auQC8PAJRyEm8nSul7uCrB7HHdBaW1jhI+zwxyVSnPR
         seYK3ybj9lgi4j94gcQOFw2Mry4yo9Ab3x6cb0J8Q7oNk9r6gtX8d/7PjcsUu5T6AJpv
         CHVebwzKYVC537s1DfieuqDp86FCu7R/AlCwXxZY4gZT+ycLgegAqyYXpTZMkjYY50Jk
         IDVc3d6cDOpFM0PsMxJlmoAqu5j+nWD5+SHorU76A6PqCZV7YOKd64uDDdjD4DZce1os
         uUtOGwWTE3Tif6WN5ovCrOnm8WC+PMq4itCriO5ChPfOZvVJ4o3IwR0sV30O/s6XsGH1
         KL3g==
X-Forwarded-Encrypted: i=1; AKwUvByrSLLgP0cdXCJAa+g6tK96Cq7hnC9VxUGXtv0C6cfDzWp9wtBAq8EErF0CbLAcEvdVFmmY0co=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZvpJpDcTFQbH9KjPgHdRmFiy5meqp5FTHVSfx/sqlUW0DXmoi
	omKJi02A0Kp9o4b8BRNRyJR0YDCf365R01IpYUlNZQ3x9ap74v1Tm7OH5ALWoDwO
X-Gm-Gg: AYBFou0Za4shc1pQbQPxwS0ETtlW4MydB96fWECcV94VkD5GtQlxTOV2A1ahagTuVcn
	NWLN0V6jfttBml5Vgo4VhzZodUOMYxZpUkOLj7L06zaZoLQI759ZuAinQ85vvh2rnlWC3oVERUb
	9PP1JR63vxVExRJTozRDFdOHf/+/xsqzBefAYf1abuq5pNB8RTzP030oMQTl0TFIE367eBhVHEl
	JBJPp6aHKxXw75Fh6V3zGU3Y6XUWDi5Tp5lMV0HBOLXoDyT82D4MD+Sx0wpuD4Vh85hzmUNCee2
	umZPWOCsC2JlrnsiCQ/sUlXipoffNU3c7hx9wIGi+DkXx63w/sdO1IxtkqUjAABvEeOjQUuKuEM
	Gyt2Gqtw/Hhs3kj5fGD8uLTlBn1xjuI4e1HSOQ7uPgMeyNM56Qq2DptjMEitkt6hhXsTMPRfUKC
	BKnlPG2IuI8rHsPfXZ99b+Wmmgl+9Vka86WnUbBUc07HX1dHp4kdFNbImTQaGmaboFaZC/9aX+/
	OaqUkpRt6AObMO/0obWAH4c8S2vnWluhlWDw88PjIEDqQqOelC3FZ0mEVFnrmOIujNfaoQcI8Tm
	pMynZ/ah7Yl8W07Mgc8AIzDgXgU=
X-Received: by 2002:a05:6830:44ac:b0:81b:ac5b:ea17 with SMTP id 46e09a7af769-830967e2adbmr6407060a34.16.1791700566499;
        Sat, 10 Oct 2026 23:36:06 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:06 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Li RongQing <lirongqing@baidu.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 01/12] ublk: keep a canceled FETCH round canceling until the server is gone
Date: Sun, 11 Oct 2026 01:35:44 -0500
Message-ID: <20261011063555.1142277-2-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/block/ublk_drv.c | 54 ++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b32872421951..b202d97f0dc2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -334,6 +334,11 @@ struct ublk_device {
 	u16			nr_queue_ready;
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
@@ -2415,6 +2420,11 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 		spin_unlock(&ubq->cancel_lock);
 	}
 
+	/* a new FETCH round starts, the queues stay canceling until ready */
+	mutex_lock(&ub->cancel_mutex);
+	ub->canceling = false;
+	mutex_unlock(&ub->cancel_mutex);
+
 	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queue_ready = 0;
@@ -3024,11 +3034,19 @@ static void ublk_reset_io_flags(struct ublk_queue *ubq, struct ublk_io *io)
 }
 
 /* reset per-queue io flags */
-static void ublk_queue_reset_io_flags(struct ublk_queue *ubq)
+static void ublk_queue_reset_io_flags(struct ublk_device *ub,
+				      struct ublk_queue *ubq)
 {
-	spin_lock(&ubq->cancel_lock);
-	ubq->canceling = false;
-	spin_unlock(&ubq->cancel_lock);
+	/*
+	 * A cancel in this FETCH round took a command which still counts as
+	 * ready, so the queue has to stay canceling. ub->canceling is set
+	 * under cancel_mutex before any command is taken: either we see it
+	 * here, or the cancel marks this queue again later.
+	 */
+	mutex_lock(&ub->cancel_mutex);
+	if (!ub->canceling)
+		ubq->canceling = false;
+	mutex_unlock(&ub->cancel_mutex);
 	ubq->fail_io = false;
 }
 
@@ -3050,24 +3068,17 @@ static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id,
 		ub->nr_queue_ready++;
 
 		/*
-		 * Reset queue flags as soon as this queue is ready.
-		 * This clears the canceling flag, allowing batch FETCH commands
-		 * to succeed during recovery without waiting for all queues.
+		 * Reset queue flags as soon as this queue is ready. Unless
+		 * this round saw a cancel, this clears the canceling flag,
+		 * allowing batch FETCH commands to succeed during recovery
+		 * without waiting for all queues.
 		 */
-		ublk_queue_reset_io_flags(ubq);
+		ublk_queue_reset_io_flags(ub, ubq);
 	}
 
-	/* Check if all queues are ready */
-	if (ublk_dev_ready(ub)) {
-		/*
-		 * All queues ready - clear device-level canceling flag
-		 * and wake ublk_dev_ready() waiters.
-		 */
-		mutex_lock(&ub->cancel_mutex);
-		ub->canceling = false;
-		mutex_unlock(&ub->cancel_mutex);
+	/* All queues ready - wake ublk_dev_ready() waiters */
+	if (ublk_dev_ready(ub))
 		wake_up_var(&ub->nr_queue_ready);
-	}
 }
 
 static inline int ublk_check_cmd_op(u32 cmd_op)
@@ -4433,9 +4444,10 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 
 /*
  * Wait until all queues have fetched their I/O commands, and return with
- * ub->mutex held and readiness guaranteed: then every queue's ->canceling
- * is cleared. Ready may regress between wakeup and mutex_lock() (F_BATCH
- * UNPREP, daemon death), so re-check it under the mutex and wait again.
+ * ub->mutex held and readiness guaranteed. The queues stay canceling if
+ * this round saw a cancel, see ublk_queue_reset_io_flags(). Ready may
+ * regress between wakeup and mutex_lock() (F_BATCH UNPREP, daemon death),
+ * so re-check it under the mutex and wait again.
  */
 static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
 {
-- 
2.55.0

