Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257702;
	b=wIOxvpXv9QvsI58YGIRvt3OXqgnzddonIdmPdWn4MVfu7GpCWyiwA4nvD5RKbKSY+QiI
	 z8mtqPBPO7gEAYZ3k3Xqo3kpID6xTqLhjDYFw+XU3AI32fOCeATv8+x/PRD1g5imw9Ak7
	 X0jRE5ve91CvZEHtuEhDJJaKSEnenlRQQjK1roOP6wKn4ji84aPgKwlxmSlAXXQ3wY3Q3
	 gWW+wz7OmIH34OfGEgQ6askvhkflmEONvdAKPC/D4nnsqpkV36VN06la7lEWGx6kP0MCp
	 GONlR/xi3M7RSG1+lqu/kCXCr3ZOVMHsjIl24pKWyZ25OCdP/MzwbSJt/XOzLUI6fnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=ke87La0xWSgmTiEL3IFuQIhdbuC7AYi2feZJeeO6Kt4=;
	b=y5mMdsxhFzOkmj7FHlVQ28tK1HvH5YNiLkXI3QBvEa5k8HjzuIqAPViEBLnp7FL2b5um
	 Yx0Q6rUsCMTx0TrxSFAdhUjbu+FZHF2DGQk5oJVtMdfX6ltqrMghc3dLxQNpqN7oe29vM
	 /Ydn7eXLMfup/LbYEfPhRYpyku4r7iPVWByhpa8hLAZz9EP+BZRSpJ3TI080t/dNeMy0U
	 JP0ZbYXWwFZ4oBeKoOWa5W6IXA9KWRF63ylazEBOQztcpCHxiqlgqc5Ov++tz8h1Ru3Fk
	 8REwbfLo/fLA98QJb7BSqub2ugXny+LMB7s7M5zRWiADBXGp8NkWdbNcGis1hdTZ7mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M20GFEY0;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C791606A31D
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C791606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M20GFEY0
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a065e2933fso2276050b3a.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793257701; x=1793862501; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ke87La0xWSgmTiEL3IFuQIhdbuC7AYi2feZJeeO6Kt4=;
        b=M20GFEY02HFSlOhygrjlm7JH+ts5qe+9RbS8DxnrFLxry8ev9Lw11ID2dfeTYsjyBY
         qVSyuWqH7hAygkevW54cuMwSIRjF7pe1C0jZKZDcPKzyfLYnXKZAJtiL4vg1+VFey012
         j9Hpe/FqeqKAnoq7Grxue+mDvoCWyUns7Fg3gJAHodzyVDay3ahfl63+/h4mUoZuYo7b
         QeKf3mv7FFNFn8ZpTi3F+19xC7Fe+q5wn773h7jQb5HE9PI2Im8fJNHd5QmtR5STJbxT
         iSex4RNsKfYxh1RZf05woqvVdj+XfC3Xo7F5DJyMHONeX+Jk2DkfGvqp6B7DHe/EeC2h
         gbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257701; x=1793862501;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke87La0xWSgmTiEL3IFuQIhdbuC7AYi2feZJeeO6Kt4=;
        b=CENTvLozlK5De/m1NPoSjdUqW1z8CPb64HQWkni5Oha4M0NrJytIBtL+NN42k8G1+X
         1VsTIf0vg0VvsZuj7wqh8g+26uD3cGyadmDEaMVZvJfQ8HGJgk+4CiuGmu/fSRGdl240
         WPZCPPh5Wm1Bem3lrbzQictq6GGC4meBbdfu0pj8ydt0AcFYz9O0YMHBEnhq66+X23U4
         G8zpo8xcgP9FxdZjK5FiRBLvd3nteiQod5qUDLIcxl5omrzDpVI73ohW/wg7G6nT/auA
         TlQwls+cSASXMiy+DCdbh1JfLleJwueEl553A6gpS8ZaFPcY5L18GDnGgyGm2x97VROv
         jVmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPl4QiWlXwBJfZ3cSaGLdzDvQn3etUBSfcw9rPNek2F156/0chMq7iRcWk3hg0y5/bmLyDAjQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfz8xS1kksHil8dySfRXJmNV26bPourVhzi4lfF5/YxsSHPT2g
	Q49TQkL8EAbxhZH99qy6ZHbYN+jnM/btLwdjgaNmLaugHEfXFSaAKuLPdimx8ddI+QOKXP9l/Oq
	LXhTxqiYaAqJePQKgCKsuvQ==
X-Received: from pfblo10.prod.google.com ([2002:a05:6a00:3d0a:b0:88a:f8c3:9c75])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1c84:b0:8a0:1435:fda0 with SMTP id d2e1a72fcca58-8a6e7dc9390mr4068412b3a.51.1793257700500;
 Thu, 29 Oct 2026 00:08:20 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:08:18 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261029040001.2100001-1-stanleyjhu@google.com>
Subject: [PATCH] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when
 already active
From: Stanley Jhu <stanleyjhu@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Praveen Talari <praveen.talari@oss.qualcomm.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Bart Van Assche <bvanassche@acm.org>, 
	linux-block@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
suspend callback failures"), a failed runtime resume leaves
dev->power.runtime_error at 0 with runtime_status set to RPM_SUSPENDED,
so later runtime resume requests run sdev_runtime_resume() again:

1. A runtime suspend increments q->pm_only from 0 to 1 and sets
   q->rpm_status to RPM_SUSPENDED.
2. The first runtime resume fails in the driver callback, and
   blk_post_runtime_resume() sets q->rpm_status to RPM_ACTIVE and calls
   blk_clear_pm_only(), decrementing q->pm_only from 1 to 0 so recovery
   commands can enter the queue (intended since
   commit 6e1fcab00a23 ("scsi: block: pm: Always set request queue
   runtime active in blk_post_runtime_resume()")).
3. A retried runtime resume calls blk_pre_runtime_resume(), which
   overwrites q->rpm_status from RPM_ACTIVE to RPM_RESUMING, so
   blk_post_runtime_resume() sees old_status != RPM_ACTIVE and calls
   blk_clear_pm_only() a second time without a matching
   blk_set_pm_only().
4. q->pm_only underflows from 0 to -1 (triggering WARN_ON_ONCE in
   blk_clear_pm_only()), blocking non-PM requests in blk_queue_enter()
   and __bio_queue_enter() while the device is RPM_ACTIVE, and the next
   runtime suspend increments q->pm_only from -1 to 0, letting non-PM
   requests dispatch while RPM_SUSPENDED. This hits the UFS device
   well-known LUN by default and SCSI disks with
   manage_runtime_start_stop enabled (ATA and FireWire sbp2 defaults).

Set q->rpm_status to RPM_RESUMING in blk_pre_runtime_resume() only when
q->rpm_status is not already RPM_ACTIVE, so blk_post_runtime_resume()
skips blk_clear_pm_only() on retries.

Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
Cc: stable@vger.kernel.org # v7.3+
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 block/blk-pm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 8d3e052f91da..31598dd03a3f 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -142,7 +142,8 @@ EXPORT_SYMBOL(blk_post_runtime_suspend);
  *
  * Description:
  *    Update the queue's runtime status to RESUMING in preparation for the
- *    runtime resume of the device.
+ *    runtime resume of the device, or keep RPM_ACTIVE if a previous failed
+ *    runtime resume already reactivated the queue.
  *
  *    This function should be called near the start of the device's
  *    runtime_resume callback.
@@ -153,7 +154,9 @@ void blk_pre_runtime_resume(struct request_queue *q)
 		return;
 
 	spin_lock_irq(&q->queue_lock);
-	q->rpm_status = RPM_RESUMING;
+	/* Keep RPM_ACTIVE if a prior failed resume reactivated the queue. */
+	if (q->rpm_status != RPM_ACTIVE)
+		q->rpm_status = RPM_RESUMING;
 	spin_unlock_irq(&q->queue_lock);
 }
 EXPORT_SYMBOL(blk_pre_runtime_resume);
-- 
2.56.0.313.g2479322e68-goog

