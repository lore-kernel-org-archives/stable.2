Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785549;
	b=CjJvTyJDyUVVuM5hGZRcegOScgCSwUm56ohnHizS1/5sfmrc/67o7gonSnX0BFJHP1A9
	 3VYsU0pCYMz5u61FH20qTMw2gsg7/ebCV4iSST6gq/SgJiympIRq1hAfHtPb79obT+gcD
	 1OOrmJpN3gadHoaSSju3jwCWZBzEY1glLYTdQE+p/Ms9eeee9ZX+IO2MLpkbkq8lVkrzi
	 G5Kt4/SMnPxHIY/dTonVtsoqlDeG1jxFWVt9zRfeMXN0HrETQKU3nEiT2LRLtT1e/Zvgw
	 FLKGbcneRu54LSPD8o+zYD26bxuaDg5out+8khIgxxLF1g+AQHZFoEqKXrSqkh0KnXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JgDO3SFp1m6M1lz5CdRvRXPq4mg7jU8g8yshNtlwqpA=;
	b=QjYhhuR/jdfKEuRukPJg8mQp9ca4Q9azyKi4uG7fWisF90VQXx27NcoTBHfgIADPHs3j
	 aDEl4pa5iL7vhIxTJFtYtsMhyQ1b3bF/L5VrdReWF0skssVMtgpDQhciCCEFSLJobZoCI
	 X4fNkKUKzNHnhqOpaaRoExS0H6hsZBpNsxI4WMRlKEXg2bAfdJFfi/L0q6UWt0/PiztJC
	 zdIb9IWtH+l1ynrLJuDIiSIAXyZW9p3ReuqVG3W+TFM9A7jWFgjkHcfBG8vyoJ9LovYdp
	 /+jNqsFmzvTQ/IAWJr7zzTncrpC0ByIpNyVbcrOnQpPL6kQ229/c9qEEV0ICR9VrktQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e99B5ETi;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C10606BED0
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C10606BED0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e99B5ETi
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so6875215e9.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785546; x=1793390346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JgDO3SFp1m6M1lz5CdRvRXPq4mg7jU8g8yshNtlwqpA=;
        b=e99B5ETi4RBzE2GcWHPMXnk1i+Y/rXnacXMKRYTFPrTq1wjfb7kd7insXYo5/dJsey
         gtIsw+nWx6Oj3qXvDpEoFxMtSagGOMbOBnFrqYegfEquvHFGjNvZiyMeghOHB+TzGYl1
         WL5R17K12izNfs/nsUbAnF02sTdTbYmHcHSlTtBMusfGfiEFglfZ2Yp/U/t05do/HS9d
         HUcjb/oswYgOkagKFFZIAYubrUBtvJKX+fFpcta+eWmF49NUdE3DiY/06cao3BzcWGZa
         YGZ8dvAlnRCuP5xgGkYJtEMi2WQPJnHnEH/WRYWGWr0wzC1t9u+KiQXuzg2bKsaqS3yb
         RDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785546; x=1793390346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JgDO3SFp1m6M1lz5CdRvRXPq4mg7jU8g8yshNtlwqpA=;
        b=THgxxSQlb1GgVMhEIL8a4Ezqz/z3PcIvvepV7q9bDl9+Kx/zZStf7RV8Vt/OElUSyo
         AQCu6Pi/wR2BmuBZUdMTgPS2LPSigHzjCOlCrV+CgKkfm46bzr4D5kLhwIAZQEB20G9W
         Hzl8idxNUdY9AL/e+WdrrIxyfi0TfT+3JfV1kzmaT+p4Yh8Wq6K5C+MCOkrlTUz6yh9j
         q9mwVgrd4rU339ZyTTZQlijZOcfDWEPY4caZo4XpHalyCfkjl3ci3JuuCNicHNolHRAV
         Uxw4z3H1YAFxuyBcvn/UwrqGCIdJJPjl/kOd8WuKjbvhn0/u5D5FuhAEOt6MvR6ht+Je
         vcLg==
X-Forwarded-Encrypted: i=1; AKwUvBy9vCQRemWmgFPryFcNjgAxFeBGsOUAse4S0CaOxq6jaDJcNOBTKWjkOKyLBilNv/uG2ZVMzoY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhEvdnCwHYny6OVaHNnPwXUibyDDdIfjDd/bsveDReBfS7m4dp
	ktgNgbPEQLyui4ZqZDQShR42YjORZJA6gB1zfAIvtv6d422qiw4Me4Q=
X-Gm-Gg: AYBFou2rw8rk6qh98K/LqATyiS9TQlOu4NXKd267xqMpPB6lGSIKpIsqy3KQHzMJNP8
	EfjCrCIS6QfoNzosvTssIUkqn1W6OH1COHkIvOX+8Fh6PB954jA7jFF8K8M6Imh7KfZB7U5ycJh
	pRJdROkDtKhuVN/B/G18siKe5J1RNVNJtu68L2fNAubgy8TM0egBI1bsaN2rDFI5dLQitALs/qV
	C5wmiM1fug0aO/Wjfb/dLy801zavG/1lSmeltx+DfDxMZ46wwe23iIfayzrjCTleHWtRHniXzUA
	goDHnYzRwrE3qTmXaF+/0a7TH3XYVFVQzT8BcXPMJNwHX1RWxQ3I57opPyb8TQI2yUL+1d3kv4x
	Y//8fTo6RUXREK7i1AINNJ7VkrAX+5K6+U/Uu6vqoKwGqruVmhvYDDv94uL2f5y1TL5hmquWkCp
	8ahAYG3fjKhbTXUma4+Da2gALJhFpItY0YdaA8kMRyV+graDlsbLSUHl0sj1OGfSRaQNjixr4zF
	fw0nJnV8JUg2TCcIAk4zKFK
X-Received: by 2002:a05:600c:3f16:b0:4a2:526b:d417 with SMTP id 5b1f17b1804b1-4a2526bd79fmr22530685e9.7.1792785546492;
        Fri, 23 Oct 2026 12:59:06 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2ed5a2sm5021145e9.15.2026.10.23.12.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 12:59:04 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Lin Ma <linma@zju.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] media: dvbdev: fix dangling minor pointer in dvb_register_device() error paths
Date: Fri, 23 Oct 2026 19:59:04 +0000
Message-ID: <20261023195904.3557984-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

dvb_register_device() stores the dvb_device in the global dvb_minors[]
array via dvb_device_get() and releases minor_rwsem before calling
dvb_register_media_device() and device_create(). If either of these
fails, the error paths call kfree() on dvbdev without clearing the
dvb_minors[minor] entry and without going through dvb_device_put().
This leaves a stale pointer in the array that dvb_device_open() can
dereference under minor_rwsem, and bypasses the reference count
established by dvb_device_get().

Fix both error paths by:

1. Clearing dvb_minors[minor] under minor_rwsem and calling
   dvb_device_put() to release the array reference.
2. Replacing the direct kfree() with dvb_device_put() to release
   the initial reference and allow the release callback to free
   the object when the count reaches zero.

This mirrors the cleanup sequence in dvb_unregister_device().

Fixes: 0fc044b2b5e2 ("media: dvbdev: adopts refcnt to avoid UAF")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/media/dvb-core/dvbdev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a6..c931c467d4c52 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -551,6 +551,10 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	if (ret) {
 		pr_err("%s: dvb_register_media_device failed to create the mediagraph\n",
 		       __func__);
+		down_write(&minor_rwsem);
+		dvb_minors[minor] = NULL;
+		dvb_device_put(dvbdev);
+		up_write(&minor_rwsem);
 		if (new_node) {
 			list_del(&new_node->list_head);
 			kfree(dvbdevfops);
@@ -558,7 +562,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		}
 		dvb_media_device_free(dvbdev);
 		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
+		dvb_device_put(dvbdev);
 		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
@@ -570,6 +574,10 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	if (IS_ERR(clsdev)) {
 		pr_err("%s: failed to create device dvb%d.%s%d (%pe)\n",
 		       __func__, adap->num, dnames[type], id, clsdev);
+		down_write(&minor_rwsem);
+		dvb_minors[minor] = NULL;
+		dvb_device_put(dvbdev);
+		up_write(&minor_rwsem);
 		if (new_node) {
 			list_del(&new_node->list_head);
 			kfree(dvbdevfops);
@@ -577,7 +585,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		}
 		dvb_media_device_free(dvbdev);
 		list_del(&dvbdev->list_head);
-		kfree(dvbdev);
+		dvb_device_put(dvbdev);
 		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
-- 
2.47.3

