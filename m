Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37503DD525
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791700586; cv=none; b=borpBUP70xcz3m7Jg7DlqRL1hTOrWHQMRGNTRzPUG9p+Jwz/ssImbiXTMrOYZjo1Kb+JhUq7541xGko7Xz3s8XPOdulKP6mcmhoECo/zf0iLBCHXaG6hGbCLZF1BR/B1JDJ9ILZBYsAbIkyiZxfVA/9fXe1gVGPiOaF9bc2ebg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791700586; c=relaxed/simple;
	bh=MJdZAqQoRvDESjCWOSGLRoKTNHYvmiaDqWUgdsbaPRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGK8wdSmNQiJihez7DECrNehRvA6NMP8gsZhortZrjdwtIMpZBOlm3pnItcFDRVNmfrnB7buALwePnLwOdryyuwkaM9yri/DNtaa0pwRaEBLNgM9k6ZwC7uNxpi5V5mtm50JhsyAV1l9pvWXUX3r4J0pDpZ0ATFVhHgnk2tXsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlIXZa9C; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlIXZa9C"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-81c5aac8478so702865a34.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 23:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791700584; x=1792305384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fxxBxgxHonrxwrz6achWv2sTpl8log3r+s+LcLjZPzI=;
        b=OlIXZa9CnCYmUzAUeMOBo4kDKW9zihMJYy9u9sSaC1l0mUwYmW6sLvX4zm3mYOZ5l3
         4r41LNDXwJgkD+cS5Op7im3cGBYP/bfDw9BSFfoDUbwKdij2y8tMme2P4YJ2nntkHq5K
         Gx9WkDsvSt2Qr+o3nz9CuTpgNba1N2exiW6WtdfBFv/SEe9t0de81wr1bnxOu8U1eFI5
         gbkjEZ3aRGxWJcVqUhPi3cDzWdLnQ2ZzidGrzdFHCosmGRUpNHRxlk385t6Iapa/5dk1
         w0H13+yFN0FCWBYVTSe3ca/QmnOQmTpsJMb9ZV8YgRYDs4CcFoXtTlmLBRKE09TxBCYy
         2oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791700584; x=1792305384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fxxBxgxHonrxwrz6achWv2sTpl8log3r+s+LcLjZPzI=;
        b=m/aynsn/NX6nWe8ldQNeNyxUyvbawdAEwsNJlfjn5TKL460giTSMPCPMkgQ/sVBXlU
         6VnXZJLQHuvnEc/AJNhhI2YeNLogKsCIn4u0t3Fh4WXwWYECO7JNMASZqBxLTmAiOcWS
         MFRbAMfuZAG8seATNLjzOYCmfFB1S45ayok/IrgvI/g+CewEQ0ht/kL7Du33eO/wF1H0
         k7u4sHL0jwOBU4oZcxz9Nvwl/OuUThnmrkTOuIPQcgKywphexoJchq/T8Uo3bQLO/Cl2
         H0smN56Q8MrAoHAQoN/19LL6U3K1s4Tfvb1CpGyJskJxP7tTwzoyrZzPtWNZzU2mTV/e
         LyFQ==
X-Forwarded-Encrypted: i=1; AKwUvByujmJDM1zfMPv42ffcJCFcv2HsG0HeyqoGUdWW6ntLptOWkk/HJAVNHNarWk+3eySQmGKQIyk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6ejQMfZ3ezy5NRPm98xRvLi492zC4s592ugOXy+ReBYrSK3a0
	ErXQraBzgrSVxDB2O82/T/h3zFq0IdtZnrgG/rkO1mGRXAThHdia/cKO
X-Gm-Gg: AYBFou0ses1QFKDTcQAZ0tu8y7ZoQ1u6ba05dEckucNJu/Kd6qCqTMW254aMQFqCrI7
	aPcDGO7m5RfHGJ4Vzw7bl/kx5myt0DSueFoyOFZ649fX7YZ7s2mu0rtT70R1PAd8Z5qQvV1qgwB
	4fWMfcyIx1ijO14/M6fOUy64eR9I5iYJhrSRpQlWrvz2OZHY6vriXlDIyFoNV613FWyHQvmHDZa
	Gph5Y0v5jS/lssFsr5A5bOYv+UlwiJW2yrGdELCYoS4WgGzSvPhI9OBzQSsQjZe/63d7QOPVDZJ
	FD8RrbI+k8jgF4KAwjLmiHKI6YWidJJ29IbSEXZBqJ1j+Y5P6CMIjnIxoqD868MtWOZo2oR0xP/
	UQJp4m/1u+dDAdm9PLGGPT4xWklKYUF/rGqhNL4faNmJHVeqCHXH9rMpPpxlbXFyEVnWQYpPK4H
	Dih4OFXLnZ5HOJtzw1s7FXEEpcGaczFgyC4cDpJIXiwKI9NRmV3v/6tZEbxKvlHDu3+J+oIwwu/
	kvbsluN0uWF0gM9XomOl3f8qvA+1YRtTBHordwBzPsrcNzCq/PZXU4hIRxFoLUrL8XTfDBCPADj
	kjuQq1iNpFHV1qY1dy6Rh3FRdR5t3jRNW6VLZA==
X-Received: by 2002:a05:6830:81da:b0:802:68c:1b51 with SMTP id 46e09a7af769-8309525d6bfmr6756378a34.11.1791700583716;
        Sat, 10 Oct 2026 23:36:23 -0700 (PDT)
Received: from fedora-laptop.tail348456.ts.net ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a515aa9sm6593164a34.25.2026.10.10.23.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:36:23 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: linux-block@vger.kernel.org
Cc: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Li RongQing <lirongqing@baidu.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 05/12] ublk: reset the FETCH round under ub->mutex
Date: Sun, 11 Oct 2026 01:35:48 -0500
Message-ID: <20261011063555.1142277-6-tom.leiming@gmail.com>
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

The release work resets the FETCH round without ub->mutex, while
START_DEV checks it under ub->mutex:

  START_DEV (ub->mutex)               release work
  all queues ready? yes
  ublksrv_tgid matches? yes
                                      ublk_reset_ch_dev():
                                        io->cmd = NULL, nr_queue_ready = 0
  go live: a request then reaches ublk_queue_cmd() with a NULL io->cmd

Do the reset under ub->mutex. Then START_DEV sees the round either ready
or reset. The work already takes ub->mutex when there is a disk, after
it has aborted the requests; nothing holding ub->mutex waits for it.

Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
Cc: stable@vger.kernel.org
Tested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk_drv.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 35202789cf98..b65b33c1996d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2556,8 +2556,10 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 	 * reset, so that a new server can fetch and start the device.
 	 */
 	disk = ublk_get_disk(ub);
-	if (!disk)
+	if (!disk) {
+		mutex_lock(&ub->mutex);
 		goto reset;
+	}
 
 	/*
 	 * All uring_cmd are done now, so abort any request outstanding to
@@ -2589,7 +2591,7 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 
 	/* double check after grabbing lock */
 	if (!ub->ub_disk)
-		goto unlock;
+		goto reset;
 
 	/*
 	 * Transition the device to the nosrv state. What exactly this
@@ -2615,12 +2617,14 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 				WRITE_ONCE(ublk_get_queue(ub, i)->fail_io, true);
 		}
 	}
-unlock:
-	mutex_unlock(&ub->mutex);
-	ublk_put_disk(disk);
 reset:
-	/* all uring_cmd has been done now, reset device & ubq */
+	/*
+	 * All uring_cmd has been done now, reset device & ubq. Under
+	 * ub->mutex, so START_DEV sees the round either ready or reset.
+	 */
 	ublk_reset_ch_dev(ub);
+	mutex_unlock(&ub->mutex);
+	ublk_put_disk(disk);
 	clear_bit(UB_STATE_OPEN, &ub->state);
 
 	/* put the reference grabbed in ublk_ch_release() */
-- 
2.55.0

