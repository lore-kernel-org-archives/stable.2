Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4B2FD7D3
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746843; cv=none; b=qW8jM+HF4iCFdYE2F1tMWWGKM9hsDSaFP57pxceJnqUrziVzjzFl9qCT/9+Jw+mC+t/uGALkQQ4R+Fo9OO101ESyH8jUkGxkl3b1Xn7gn03nDQ7FoBs50mrSRd0f4czJekGvl6wO79sVVA3Bd1JNJtVLtfMAGBQusKeDusUrjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746843; c=relaxed/simple;
	bh=D1fdGjESKvw/uq/JSBCiUbhtq7cGQdHsYD/kdEJes6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGJf8JmN1Ya2u1N0eFVhaldioppuDNcC9SiIwjwjhk/IRnrMRYi8eePOT0brATBVxhJLsfoHT3nbiWwbWS26QQ/WbTIThbDo1uM6BEJiAERccgb6f5v1WVoC0RduHDeVtJWKehbc6bdV5MLQGL2xpxhh8FFteIU19ki9R8ppuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnTqPvWA; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnTqPvWA"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e5c9211d2so121980485a.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 15:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786746840; x=1787351640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h5fkXF8XZbOD5FyQfrGiQUBRfaoJPe5kBpNFpnd/1aE=;
        b=DnTqPvWAEJi+kXs6BriotKPW5QjR9ih4WjIX7obXWdmbm7c+hzePUdBRrUJz4dV9Zk
         YkP9q4RHTc//NHNXTBtpQBr9mLIPz6S/u9pecnaJIiUQqCWu/JBBZDzgIBlabkw6ptH4
         siKv3UFfwWZjrOnXK9YAm33qubxa1/i/oiXX0Qh4Ivh4c0Z8jXRFX3tjwTBjrVwuIFIK
         rhhJNVETJOnc9c+cOTGdtUAHLvMITaHj9uQNgCoqKtoCo4nNd+YFsxf1U+V+Kd48yDPD
         kFVN7VX6eTC9vJOtBzfHTlLaqKEF2EGkWMKU9OXfYFX/XVsQ/ypa73meJN8BKtdFyV5t
         YIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786746840; x=1787351640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h5fkXF8XZbOD5FyQfrGiQUBRfaoJPe5kBpNFpnd/1aE=;
        b=rH38vHiMfIP+ViUqz1cWD1UKw2DUY+8J0mz1982UiZ+XZf0tlBTxDfmRwZYTfFqAeF
         VN+Uhy2fYjM7BtQwVBwjvBJXRkP8mdkxfeMSPSHkxgx8k0T/7KvQzF3NFgFNj0747Xkn
         F4xqkVbOkSqFLUtCflxCSe7lZE65EE1IOEE3gVmBjINdnPatRC22IKiLsSaxYqvopDwV
         lha8mXDneWJhXYVcZXsHA4c4NjiF4gSeQRzKSBXCQ8jYpGnvs8HHFY++0+SU0qnQY51F
         0783AULlFA+vAhboP/ZhsW6CeMYzp2CtEEAHAeahVG3G85K8D9QkafwMpUH+L9/L+zkm
         UGZw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2C1axd0Hihb/gIYHFYbZu/Tn7UoLQbs9IBGmtKcMw/KTu1BM2kv6ab0XYgDU3gobSXtOfn3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YytCrQN6MLHRfQH00VJ7xMA52ME7oG1xBwp5x5fwu1cJXYoBGyc
	JCZVD/l1M1AlMKOW++zIwA1OQwl7UjXhhORBbuLE+mRE6MLm1Rjbpmvf
X-Gm-Gg: AR+sD11wNI8vYmmtWiKPGQuxbVd+VTckLMpQeU8MZfg0aQwZL4yIHyz2YEcFKiieWBC
	rPsoW+FMxEUUQwgN6ba8zzgmZ/nu/bhfsLlFS0lJ6uxgm8NT32JxJmrcyH8FSPXH/Wz1jc7vBfU
	Iw0dfMbcmpT9V8J15vzDx9gK9pslBI0YgOrgtmUlVv8SL7XwrHCVW0aLxlK/N7BVRi/6ZUJKPeB
	4Kra0zL7v1+vr7G9cO8bjccquMO1+zgS9vRYy6/gGjBbvsDOP1fV7ivhNb2rAtEkW8DpRKjIv4D
	qVfh2FImT7JnRwgXnZi64Ih9LV4tCTTw25aYL7VCmaYO8VF+6nAN+TniAXxtN//UzAiHC280kGj
	uf+kxbb6vVxTM/GolpF7eHm5ot29KDEM8MOIOOMmb9fYpUL3zfw7Z1qdVRmTD0O6YShhF7Qinyi
	804GwcK7Q6aZAuUAQN8znXGPDKiYwi4iXi5hWCtm0UUg6wGWudgTpOtko4U1srFEABRyyBYbdqw
	WlbUcLf9PxY3Ykilw==
X-Received: by 2002:a05:620a:44c7:b0:915:8055:3f91 with SMTP id af79cd13be357-936d239f8a7mr962648385a.43.1786746840408;
        Fri, 14 Aug 2026 15:34:00 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce24d0b5sm371029785a.45.2026.08.14.15.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:34:00 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk
Cc: yukuai3@huawei.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] blk-cgroup: fix use-after-free in blkg_conf_open_bdev
Date: Fri, 14 Aug 2026 18:33:20 -0400
Message-ID: <20260814223320.4118614-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blkg_conf_open_bdev() holds rq_qos_mutex while checking whether the disk is
still live. On the dead-disk error path, it drops the bdev reference before
unlocking the mutex.

Once that reference is dropped, a concurrent put_disk() can release the
remaining device reference and free the bdev. The subsequent mutex_unlock()
then dereferences bdev->bd_queue from the freed object.

Unlock rq_qos_mutex while the local bdev reference still pins the object.
Drop the reference only after the final bdev access.

Fixes: a13bd91be223 ("block/rq_qos: protect rq_qos apis with a new lock")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 block/blk-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index d9676126c5b5..8628ab6adfa9 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -799,8 +799,8 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 
 	mutex_lock(&bdev->bd_queue->rq_qos_mutex);
 	if (!disk_live(bdev->bd_disk)) {
-		blkdev_put_no_open(bdev);
 		mutex_unlock(&bdev->bd_queue->rq_qos_mutex);
+		blkdev_put_no_open(bdev);
 		return -ENODEV;
 	}
 
-- 
2.43.0

