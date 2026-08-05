Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59D1B3925
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896359; cv=none; b=te/60OCr/oIqnH3fznnxZiIj5uElulaASnOGunKRWx5fc030CJmLxPcjy2qiQEm5laiVHk+9lh74d413WHxlqKoi44Tqp+tFpKOZ3VnYavRpK/gzNitVA/iTpD5LFYmVkikcKtss/x6FuQwSD3oJqr3UqtWRdtqnek8+CHUJRZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896359; c=relaxed/simple;
	bh=nUuZ2skQfOzg/qCPaXxIP7ZQgcAg/Aar9NHePDlidY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NRhTBJaxYSX1agM0sZY5bFgGPVmhbnqc/rSwmiPeT55yBlx6bYMn5qHzTm8n4dDAyhDx3PM3XD3EcCMdbIf4FTJP5Ypchw6QNg/SceiAji1xBuj7/WNkZcFAL0MIr0obOKsfz5YH69S1WLolnJMJJRd9EApoX6KolXyLq3KGwTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aDNGcD5H; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aDNGcD5H"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso544015a91.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 19:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785896356; x=1786501156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLX43ezAvQWWJkXB9Urrmu7vcoPvWM7hSUWS7Iz4D28=;
        b=aDNGcD5HoyVE6TmgPFOr4MlJCpJRlb5Gg9QsTgUq2iJG3lN3Whe67iY3X9WbgBbp+e
         mutgoztQol7SuecW2F79J9FM7t29ab5dj0RhpG7jw6oHbs8I5HuIWqbRC67jSEtppL+N
         vDixLNEL/+wjMRb60CLa5qgae2yLENFUWCOQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896356; x=1786501156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLX43ezAvQWWJkXB9Urrmu7vcoPvWM7hSUWS7Iz4D28=;
        b=lTP5kONy7A5nvcy1HPcDkuLWlazaxJnqAyJTM0uShmuOisNL5UKQd/XIlRhdu82lhW
         igW6/HplGcLBqhRTvOQXHt+Z/Naa84wVzF6JhRAJd8oXYtaS6cc6tufozRcHZdb2OqbO
         6WosIf6+YHRkTie4yOsHnImGAHlFUChv9Y9pMfBC72REA3MKz/gCtU7m4vrgvLjmh858
         BnY4ec/+O8o4l3rHq6sigvImujGzq6cDoFdmBKFlZyjs7YWCSFf6KZJg4ebOEYEISWf+
         zI1PwqJZ2IR9Spy2jLvO801hSE42dsb4vQHeAvamx3NXewNa07JK7FGlAF71MoJrLIG0
         hEsA==
X-Forwarded-Encrypted: i=1; AHgh+RouqdCbNqs4zGGl78Y1abB013AQdhrISHkkn7KgNsk+EATpDLMo/REklIarnAnXpsbDFhGF8Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWjZKPlRiZRyYyhaTFLf0qKUJaiSAN/RRxAlPqp7WyxGgzO9b
	KpLo0+6rx9Yis6+OFdQHku4sXZcvl2Rg+hK8SiZNyEgtOtOZaM9/JFQCzx2HXVDfAA==
X-Gm-Gg: AR+sD10tDrKF51q5tIq3nARmmn+mfMYK8rdjboUkAXB652KFgWrcemrHEhelbgRZKSa
	tj3X6CwCABfiI42TK5mdvdWgZ33jlBZ4QJdJzOo9U8gaqttftAxsvSO+lLfdCBGh25cujcH2ySi
	EMlDis6rXkC4tLMIAj7+k7eaPewbs0b6rTaw0aEn3LX01kQGKP7dvNg0vI6UjswzwJR4ICbsJ0H
	sAQeDvv2Hx2sA9GSmt/LCNZdIE3EUdLwvIoXg2EkbFoh/snnvmn4HC0lQpQ4H6EU5pg++Fv5PoK
	1nfCpeB224CqaEheePZVGflL78fyKl26K/DeXdcWo9yvQ/QL+s8K7IGOXyjfCFU25q1NmDGkP60
	nJDmuNmT4/DPtz/2DAr/zZTjc3l7YVFDkQOiAjeCyRBTkjCv+3Bdkr3XsuDedTzwOwVSQLNZmEq
	CRaogIvKGoFopd3uQxdhHDBNlj1ffQJ8wRV1j9uW4urVXuxeE5OmGTy1nN5+0v6u13w33+ufZrx
	/zfnlmn+sxFBX4QAM19hU8qrmLImfC0reWLmetrSlVg7WtTGigE
X-Received: by 2002:a17:90b:4d91:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-3903c53799cmr2986763a91.1.1785896356174;
        Tue, 04 Aug 2026 19:19:16 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903d1971besm543489a91.0.2026.08.04.19.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:19:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH] zram: freeze device queue before device reset
Date: Wed,  5 Aug 2026 11:18:44 +0900
Message-ID: <20260805021854.1057715-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device reset does not take into account in-flight async IO
requests so we can free meta table and reset device concurrently
with those requests being executed. The block layer guidelines
indicate that queue state should be protected by blk_mq_freeze_queue()
during teardown.  Freeze zram queue before device reset.

Fixes: cd67e10ac699 ("zram: promote zram from staging")
Link: https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 56183c827e1b..3b9dfcae9317 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -19,6 +19,7 @@
 #include <linux/bio.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/buffer_head.h>
 #include <linux/device.h>
 #include <linux/highmem.h>
@@ -2842,6 +2843,9 @@ static void zram_destroy_comps(struct zram *zram)
 
 static void zram_reset_device(struct zram *zram)
 {
+	unsigned int memflags;
+
+	memflags = blk_mq_freeze_queue(zram->disk->queue);
 	guard(rwsem_write)(&zram->dev_lock);
 
 	zram->limit_pages = 0;
@@ -2855,6 +2859,7 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
+	blk_mq_unfreeze_queue(zram->disk->queue, memflags);
 }
 
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
-- 
2.55.0.571.g244d577d93-goog

