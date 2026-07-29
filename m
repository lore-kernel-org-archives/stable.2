Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53E4CA284
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336529; cv=none; b=DYwsPXckx0YSbqmCrVELDfwpIwqBCM/C6lDi82OWyqdwBS3D9TX58Jd1Zvu9VpxPETQBpbJCfe2/skhJi014WW/cX0faHsKpmBFU394GZYTNZJtWfkzF7fcmftgzbP1EJXUk6xTI8Q215KCq9F5X86TC/hbACjzferqAEpN3Ves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336529; c=relaxed/simple;
	bh=EFeljYUYULY/unXLtkmpPngEEZUifKl4vRFqpOCfQPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIZIJaHxsZ/NhfF8CwfGr6xdoje4wgLQTQ7MmzSz09lNmRhmBoGp7TCk9Stb1QL6f5yWWMzIAsvpPfYYaFmi/TiZ3bV4zJNMqdE3hgbpTLG5sh+1SHhvvTq0e2hvL1dpU1Maexd5Rfcn9dQnyGWKrU9g12/usVATEBaB01euCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MO963tK7; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO963tK7"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81e9f7491ffso16670577b3.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785336526; x=1785941326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+d1+lcN9nUQwDq0plTzKXR0JqkkFWWJ/qp+bjZmBRc=;
        b=MO963tK70bVJWM6LMnCKU6likA5SoDf0d/X4tT64DLQGsMsy0KX38SS2vtQ5+QvEMT
         i3/I6J36AcgkW3h8Bmih7wUtb2jEMlP13iolU2WZpmyB3SQHICo/K0fAi5FA4KxDHdFT
         x/iSnzlRPawHgRkY6Nav9wQoj7xcIedH6Nh0iXY9IZBcHFYMlUr8bLvYGE5l7CDd4T+y
         UEXYltq24UmIJYXxEX8UbLbo6SDLKjW7UDySLMaDcj0YRpdkednYxEtcr46/lBDXuGwF
         a0kirxiVilKb70oUPCKCtFW1lu9cPx4cBUlM8aGPwP+BvA6zCFVLsLG0t4NixQChSADQ
         YTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336526; x=1785941326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5+d1+lcN9nUQwDq0plTzKXR0JqkkFWWJ/qp+bjZmBRc=;
        b=BiCrlx1/AVRKMSEDTxh6GC44fgzoXNPaYYBHxkjr4dS1cEAGtsmUjzRB8DrG8S8/26
         xJA2bd5J35vpx97uzP39ITPiHhHKj5C1MOP4q70ozD78RNqMYipd19EYpjzkTsR112Cg
         oMn4Fhrw8X5aSVQZinYsAjxceyx4oCDlt35gWmuJQBjOExwrorEQELnvmarO4yWIHKuL
         Zmhb3S78lNC/+GKly57mTy3LhZNctxUiaJgYSlmkUGzUykU+Jne3lI2/hE3qDh4wsJdT
         oEpwH5XI2jPGGIwHhVdWv+nIC+AqpltIGv5P5qKiYDEdK3DBuI+pBdJAyVvpVxDb905C
         w8EA==
X-Gm-Message-State: AOJu0YwFpqatvp9ku6ju8FbM8LFgf3J14PrIU6i1tnRY/etkOBNzLeDT
	DYUgtXnBgzxGv+niLnsy16bwek0/xm6RKaEQ0iCui0EQfzeSMz6ajhP9PKwW5nCV
X-Gm-Gg: AR+sD11oTnRZOUVi+vWAH0RV+RW3+PaMWkLX0T9C4+SmP3I3IBDSpsUeyjhd7VdjdPm
	+PV3fhmuH6VaUcx9KMNlZRD+WHZ2MttzIDqlwtwFdcwT51vnmd143ArIFF0E8GLfvqL+LqBvmx2
	9wWpco1cK6By5brIwbcbLrkXXkzM/ykop0htOkUD35hm/FRqC/rbn02R/POUE15FVzJvdikWXWD
	4kjknHteOaM6Hx3iOxSaoU94aQNrKxNJ6GMcXc0pI797K4xSlMuITmNlWgHQ6j/dkimQYmaCHXG
	u/RQNiZPmQbrHzJ7CMjVXAlu1EDt2frM+6eO/40C2/YEspkaQqT6gphpL05QEvNLtSS7/M5+k4u
	9PSl1FrJ0fHfAfrqU/28DmEGcJua5c/eP2JOw/S5V7LBff99ngcdD0h7nNHcpFQcDPJoznmRhr7
	o2TknwrK31wTaL9jN79Jc/Z3Ve/PL5TxikUVZofc9v7JQiulj4qpdsl++GLu63zgc5nPw82uOZh
	kylZnaaMMuPK0OpTTspdTSHX6Pq50RjdVkSn6+Gj5omNsg29BsGEZv/gqTeCo3IliziKWNPNe83
	vGni2VgBmH8PQpmq
X-Received: by 2002:a05:690c:4b0b:b0:7db:ccda:a409 with SMTP id 00721157ae682-81f991858eemr33391167b3.9.1785336526262;
        Wed, 29 Jul 2026 07:48:46 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa2957751sm18917187b3.35.2026.07.29.07.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:48:45 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: stable@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	George Salisbury <gsalisbury@apnic.net>
Subject: [PATCH 6.18.y] ublk: wait on ublk_dev_ready() instead of ub->completion
Date: Wed, 29 Jul 2026 09:48:06 -0500
Message-ID: <20260729144826.2214402-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072957-overdue-curing-588b@gregkh>
References: <2026072957-overdue-curing-588b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ub->completion is only re-armed by a successful START_USER_RECOVERY. If
the ublk server sends END_USER_RECOVERY without one - e.g. its START
failed with -EBUSY and the error was ignored - the wait is satisfied by
the stale completion of the previous recovery cycle, and the device is
marked LIVE and the requeue list kicked while the FETCH stream is still
running and ubq->canceling is still set. The kick redispatches a
previously requeued request, __ublk_queue_rq_common() sees ->canceling
and parks it again via __ublk_abort_rq(), and after the last FETCH
clears ->canceling nothing ever kicks the requeue list again: the
request is stranded there while holding its tag. If it is the flush
machinery's flush_rq, every subsequent fsync piles up in uninterruptible
sleep and teardown hangs on tag draining. This matches a report of a
lost PREFLUSH with ext4 on top of ublk after daemon crash recovery.

ub->completion is an edge-triggered latch used as a proxy for the level
condition "every queue has fetched all I/O commands", which can regress
(F_BATCH's UNPREP, daemon death) and whose re-arm can be skipped. Drop
it and wait on the real condition instead: the new helper
ublk_wait_dev_ready_and_lock() waits on ublk_dev_ready() via
wait_var_event_interruptible(), woken from ublk_mark_io_ready(), then
re-checks it under ub->mutex, waiting again on regression, and returns
with the mutex held and readiness guaranteed.

Readiness becomes true in the same ub->mutex critical section that
clears the last queue's ->canceling, so END_USER_RECOVERY marks the
device LIVE and kicks the requeue list strictly after ->canceling
clears. The wait stays interruptible, so a server whose daemon died can
still be signalled out. For ublk_ctrl_start_dev() this replaces the
fail-fast -EINVAL on an F_BATCH ready->UNPREP regression with waiting
until the device is ready again.

Reported-by: George Salisbury <gsalisbury@apnic.net>
Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Link: https://patch.msgid.link/20260719134540.120269-1-tom.leiming@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

(cherry picked from commit 432a9b2780c0a01caf547bd1fc2fcf28aeb8d173)
[ 6.18.y tracks readiness per fetched I/O command in ->nr_io_ready rather
  than per queue in ->nr_queue_ready, so wait and wake on that counter;
  ->canceling is cleared by ublk_reset_io_flags(), which stays in
  ublk_mark_io_ready(). UBLK_F_BATCH_IO does not exist here, so
  ublk_ctrl_start_dev() has no F_BATCH readiness re-check to replace, and
  readiness can only regress via ublk_reset_ch_dev() on daemon death. ]
---
 drivers/block/ublk_drv.c | 52 ++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c339222513b0..cb31e96f01cd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/major.h>
 #include <linux/wait.h>
+#include <linux/wait_bit.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/swap.h>
@@ -26,7 +27,6 @@
 #include <linux/compat.h>
 #include <linux/mutex.h>
 #include <linux/writeback.h>
-#include <linux/completion.h>
 #include <linux/highmem.h>
 #include <linux/sysfs.h>
 #include <linux/miscdevice.h>
@@ -230,7 +230,6 @@ struct ublk_device {
 
 	struct ublk_params	params;
 
-	struct completion	completion;
 	u32			nr_io_ready;
 	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
@@ -2150,9 +2149,13 @@ static void ublk_mark_io_ready(struct ublk_device *ub)
 
 	ub->nr_io_ready++;
 	if (ublk_dev_ready(ub)) {
-		/* now we are ready for handling ublk io request */
+		/*
+		 * now we are ready for handling ublk io request, clear
+		 * device-level canceling flag and wake ublk_dev_ready()
+		 * waiters
+		 */
 		ublk_reset_io_flags(ub);
-		complete_all(&ub->completion);
+		wake_up_var(&ub->nr_io_ready);
 	}
 }
 
@@ -2829,7 +2832,6 @@ static int ublk_init_queues(struct ublk_device *ub)
 			goto fail;
 	}
 
-	init_completion(&ub->completion);
 	return 0;
 
  fail:
@@ -2966,6 +2968,26 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 	return ub->ublksrv_tgid == ublksrv_pid;
 }
 
+/*
+ * Wait until all queues have fetched their I/O commands, and return with
+ * ub->mutex held and readiness guaranteed: then every queue's ->canceling
+ * is cleared. Ready may regress between wakeup and mutex_lock() (daemon
+ * death), so re-check it under the mutex and wait again.
+ */
+static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
+{
+	while (true) {
+		if (wait_var_event_interruptible(&ub->nr_io_ready,
+						 ublk_dev_ready(ub)))
+			return -EINTR;
+
+		mutex_lock(&ub->mutex);
+		if (ublk_dev_ready(ub))
+			return 0;
+		mutex_unlock(&ub->mutex);
+	}
+}
+
 static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
@@ -3031,13 +3053,13 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		lim.max_segments = ub->params.seg.max_segments;
 	}
 
-	if (wait_for_completion_interruptible(&ub->completion) != 0)
+	if (ublk_wait_dev_ready_and_lock(ub))
 		return -EINTR;
 
-	if (!ublk_validate_user_pid(ub, ublksrv_pid))
-		return -EINVAL;
-
-	mutex_lock(&ub->mutex);
+	if (!ublk_validate_user_pid(ub, ublksrv_pid)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 	if (ub->dev_info.state == UBLK_S_DEV_LIVE ||
 	    test_bit(UB_STATE_USED, &ub->state)) {
 		ret = -EEXIST;
@@ -3549,7 +3571,6 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 		goto out_unlock;
 	}
 	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
-	init_completion(&ub->completion);
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
@@ -3565,16 +3586,17 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
 		 header->dev_id);
 
-	if (wait_for_completion_interruptible(&ub->completion))
+	if (ublk_wait_dev_ready_and_lock(ub))
 		return -EINTR;
 
 	pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
 		 header->dev_id);
 
-	if (!ublk_validate_user_pid(ub, ublksrv_pid))
-		return -EINVAL;
+	if (!ublk_validate_user_pid(ub, ublksrv_pid)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
-	mutex_lock(&ub->mutex);
 	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 
-- 
2.55.0

