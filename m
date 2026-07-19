Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0025E469
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468757; cv=none; b=qftqTcHd1GQKG3oPQuPtAf70IsUVaGfepb5kuHW6/YZeIBAui1n4hIGeZ0uPBbMk4/PAsqQ9E92/il+0ShENSYZ+feZz0URBB8dosRNtMp4r8SLCbPLa5gxZQV20KtabkPluYC+54jFt48M5P8n4D5Lc919kMzGK+at++sJoS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468757; c=relaxed/simple;
	bh=HdRWMDNHAY/1DNB/r6jypsZWpFLvymAg4PDDPQWnpLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flTiYyqKZrinP9sW8/MN7gPvFBQoo74/0JfQiJwUy3rMeAPb3ti//8+rHoSB8jktriGaoLjgcbaAqTM7Sz+AO7xtok+3uoI+Tbi9oeMjQIbteuPHbAg6QPuE+syUBJEo1ZCGnd95h8nNFREgz4ZCnXY8A8IS5EmLmgCNUpwdCkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2dQpZ7S; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2dQpZ7S"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92eafc94c9cso729477685a.0
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784468754; x=1785073554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fUjpB13ZraCNWfDz5FRaI+O6Cdjio58+qHZz/ymdnU4=;
        b=k2dQpZ7STbAlZ7ufDwFgDao9MHHvgEVSsczlYQNx28T9Vrark3vWsC1x4DFCrRvGEv
         WyB5GF90K3pJMVLH3ayHGKJhzYQ4d8jXXqZj3xwcyXiwlgIziMYCHnodQEngBRacCkYI
         LZCN/K2loOhJZc+e/V//tU7Ifcd6tZjHXh+/KyoE/Pny2zipESWiQWiisKFPMLKt/dL5
         4mej44YI6/eTWV3fB/l7CMEynQbCNsQWJr/rpaX8PcVMcatUUALI8CGrun1Pg3Pd1gMi
         r4gZXH5mo35vY/6hB3mN8JVApucvs1Ef5qbeLxNeH4CqBY+IT2LUMl0CSdqnMwDo421c
         snZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784468754; x=1785073554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fUjpB13ZraCNWfDz5FRaI+O6Cdjio58+qHZz/ymdnU4=;
        b=Qbl8iJVFkY0WPSDmlySroxeRC+FmKF94No38ALTOcanwoPc7mc6dBZNHyEwIp0yZNS
         0SKg2qH2OOs4eWiS04iJUWFjtxoUINOOron2BLRs3KYejUApOXfpe8cexctz6bnzT9y8
         LZb0gAM1Q9Yq1fxQYcgG7J4WEkxRDLA2wgzPHg+zLUZgHx/bvPZqQeJ+aSK8Y96OWl1g
         7DhG8YjaCu0ytIuk//ccpv2/IuETE0M1QHDwBIvEBeOxbu2Z42ZghFFtgOhZ0aL8S5ur
         6M+ypuglUW0Dij4WFB6CSUvkzpScMxoLnzcJuoEUsO0BJ+gHxjUKWnFmuNCK7kCFClwT
         2kkQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsK2jnHIJn6tutwSJIbMzE3GuUFqrUcov1MdTG61hs/d/Zh8bqSO3JgAYvkJ2hppAd4E8iQJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC68FLJruR5Qe05ZBqdI/PQwTBdpNV1ITB+mlKGzUTrac2REmO
	TAWYP0yGLknPfxrFsFHW0p5wB+K23eqhkdWO5+ISAmD0AebdXAD5dycK
X-Gm-Gg: AfdE7cm4tkenrboRdBxYFluddmeu1qoiHLapPfY3qz8mtuSCwiddMWWIpbXUlA+kX2V
	FY2iVdPQFSg+clMTPOuQMYEtBDQkxktoWAdFx58lDiMDXdMxKh/qEkvs7YIwZW4WsgvzB8yRJeD
	/4xkg/nI1k53q7hi0LdstzmYtGkDqP8rnl1MVbvm/nwrsImA5z20BCCuuPtc8kAJXhjc6ewcOyp
	9iCAqtVQhrxPnyyIE30JoF3anGTTmvUgN5OmDc0jpLLCdqRQbHEvS3Tw4A9OaGKqWaSfyCR2s5o
	K8GJqsD+lGEfucqc+de4dcQsHPL0I+rQ09hXRX/oqEQ0+r3Qjwa3ZqWyBQz1neiCt41zE6ZUgdW
	ZlBN90MJqXpZVwaTYMf2+bpZoYQM8Qw8WEuDnfOn/DtJrD8l8C1yfHsMm7MIn+/AHJq44cJVXJT
	FifnOljGdSeeE1QVqrBD8E9j9IwmeoRAw01W7ZDN0D2ARtF3E4cfWvWow2zD1+xxX/Pdw++D+ow
	Hx8kLvL6j9jdHD11/hEBs4BUKN3qVM/xmeaf6mgNiDr
X-Received: by 2002:a05:620a:471f:b0:92e:c117:5ee7 with SMTP id af79cd13be357-930b431472fmr944154585a.83.1784468753879;
        Sun, 19 Jul 2026 06:45:53 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b531d937sm646694885a.21.2026.07.19.06.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 06:45:53 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>,
	George Salisbury <gsalisbury@apnic.net>,
	stable@vger.kernel.org
Subject: [PATCH] ublk: wait on ublk_dev_ready() instead of ub->completion
Date: Sun, 19 Jul 2026 08:45:40 -0500
Message-ID: <20260719134540.120269-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.55.0
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
---
 drivers/block/ublk_drv.c | 47 +++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c2c11f2a01e7..4ca6ec738c93 100644
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
@@ -327,7 +327,6 @@ struct ublk_device {
 
 	struct ublk_params	params;
 
-	struct completion	completion;
 	u32			nr_queue_ready;
 	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
@@ -3054,12 +3053,12 @@ static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id,
 	if (ublk_dev_ready(ub)) {
 		/*
 		 * All queues ready - clear device-level canceling flag
-		 * and complete the recovery/initialization.
+		 * and wake ublk_dev_ready() waiters.
 		 */
 		mutex_lock(&ub->cancel_mutex);
 		ub->canceling = false;
 		mutex_unlock(&ub->cancel_mutex);
-		complete_all(&ub->completion);
+		wake_up_var(&ub->nr_queue_ready);
 	}
 }
 
@@ -4273,7 +4272,6 @@ static int ublk_init_queues(struct ublk_device *ub)
 			goto fail;
 	}
 
-	init_completion(&ub->completion);
 	return 0;
 
  fail:
@@ -4417,6 +4415,26 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 	return ub->ublksrv_tgid == ublksrv_pid;
 }
 
+/*
+ * Wait until all queues have fetched their I/O commands, and return with
+ * ub->mutex held and readiness guaranteed: then every queue's ->canceling
+ * is cleared. Ready may regress between wakeup and mutex_lock() (F_BATCH
+ * UNPREP, daemon death), so re-check it under the mutex and wait again.
+ */
+static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
+{
+	while (true) {
+		if (wait_var_event_interruptible(&ub->nr_queue_ready,
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
@@ -4499,15 +4517,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		};
 	}
 
-	if (wait_for_completion_interruptible(&ub->completion) != 0)
+	if (ublk_wait_dev_ready_and_lock(ub))
 		return -EINTR;
 
-	if (!ublk_validate_user_pid(ub, ublksrv_pid))
-		return -EINVAL;
-
-	mutex_lock(&ub->mutex);
-	/* device may become not ready in case of F_BATCH */
-	if (!ublk_dev_ready(ub)) {
+	if (!ublk_validate_user_pid(ub, ublksrv_pid)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -5071,7 +5084,6 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub)
 		goto out_unlock;
 	}
 	pr_devel("%s: start recovery for dev id %d\n", __func__, ub->ub_number);
-	init_completion(&ub->completion);
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
@@ -5087,16 +5099,17 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
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

