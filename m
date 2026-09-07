Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BD48823A
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 12:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783540; cv=none; b=sUoz9SNH/rqbhdVSHeBbVC6d3UrdljnR7Ao+WykEh3qCx6ZNs5IeBwv5OxWdCnejRVH36qlnybYVxI1jYwpNj2ONZFUM4BMDydGkINmbimRqGz7we+SfiTeVQWnPBSI+Dr7xj+PumyQEi0vlA4o/xvHA+OZhPaBPZ1dZDZixyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783540; c=relaxed/simple;
	bh=SotKMOP7zUiJtWG7JbcS2nlpcvhlbdHg0Kyg5p16B38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ju3SDgPKQTTmZ16N+I4obIgnNev0uj+2fzcjoHXK01RlbHCh+HwR/IacElYTzGEuNVUePM/iiHVvYv0LyPVMGInCRNu7X4sc2BtEMdOdESRdgTfumGjzVq//Hq559O7xZGHLthJnIdo9LzJMt6ULSEvO32iijEnI13ImxDA/Yb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYKNzjDD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYKNzjDD"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso2533055b3a.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788783538; x=1789388338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uaPh5i+FuZkrfBsWH4a7+TIG5RJ95lzG5o9AQinurAE=;
        b=lYKNzjDDVFcFjjDNpDdLwVhpUlCJIHtjzCGxANz0NAUupP1e7S8/aarYcc+MB+b0V2
         cfUFHmg8oyYsnOY/H1aR9EQK12mLjAvHu/0NLU3S3pkIoTYB+XJQOjd3/ZMMePQCMXFV
         curP0VaUbz5bJASZ4AjfAEReQ5R4Mhn17rJMJLxuaf6B1/WpPI1kDLa97VMdKwO1hPs5
         lHU+dmaOQQcc8pdDlEN9Ih9I25zIawxL24V3a4MyLhnV68kLJEHJnFlVNFSCHEEu+j4n
         UH4Xgp8+dLB5ZLFx/xVEPB4PMaM5Wevi7ynndlqqxpKyZmuqfQHVjAyMLP8BT/fICL6x
         +wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788783538; x=1789388338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uaPh5i+FuZkrfBsWH4a7+TIG5RJ95lzG5o9AQinurAE=;
        b=ledT2f+LLh/FRhvsZg9qi0bAuCWJH0ti+QUgJ6ij0BcdWiaDqsVHSSZiIOOeo+9kG6
         CKReIYvEy4xJ4x2xjmnzlEHJdMWc+D+ovpZPEJ056sUVGwsKAeHEbL5iCRlASvp2ouHW
         4jRUQ5HCdrvUnDzYJbczsdyPKBlmVL68l7eVDA2lj2y/ujbW0kO3x6tVZTG+hg5xaczd
         SRzdwBC0l0AgUCvpt/Q0EkF40pKJYRovlAKCe7gMBkA9Oyw8hH2+0bMudbAY5JlOVoiG
         ygtsJ3RcGBt7JGSi+cKP2BYh6MhV70yWFNYx+n+dBr/9y498JjockdvmbIvjQmvJuYdD
         r2dQ==
X-Forwarded-Encrypted: i=1; AKwUvBySUUuCS2J96h8RwUqVzmlJlqDWDuhhY3d8m0p/Ud9H9UfQzgna8Pe5mPTGN++Rq022rehXmdA=@vger.kernel.org
X-Gm-Message-State: AFuF++kON+eNB+nLiYHM9wsmuXvk0Aza/eo6lHtwSrDcBdTyGyatBuMa
	FkYsmWNXf5fe6wcx4kDzLfjDmKSAbJrf/8SAnXZrt9wXiimLkG8dERrM
X-Gm-Gg: AYBFou2PGHMQYhnEnnwNHB7djBbOvkmRq11WdkLiq5tkeaM0pejA6vccphLO3rKZvFU
	KjatbW0Rc9Mp91xU1Btg5LXAwQmyZ80NNqQD92JoHfHR9aRlWJpwAHoyQa1wLB2UW/rdYMsFGaS
	BQiLYlmFFKGwfJZKTTebpp2wzUViWyTMD5duqJNMxhcGSXgoEajtFwRR9zqnHrg6gDoldWifuNM
	MWokTO5rt2THfSXVQV71wzDq8kZT8M2ou0NIPmBAKwffTjNFoDzdgA/t8tgZimehxfk0Jln/57V
	r7gBdwiARPgIXdQXjMSL4yxdZaAuqPXQJhUZRwSN5QuONf127WnLhL3kcKL6/eubu5//6EUXWqi
	xgp1/9FG0+V8NN0tjgkxgFk7dVt8Dx0B597AYHG83U7sljRdX4fHJsYV884zpmwI8wZutcXBigZ
	TyofsHWyUcTiJgP8YCX13WvwgyRRRJHHJrPHmTuM/0wIJAN2XJPepTz8LHTZ2wigNoSHkt/b2oH
	01vvbeSvHXYvqss8WODl3vRr+Iz8tAMm5RiGXqh4fXWUWG3HGfT3HRA/Ez88jH873ImxNKkjxnv
	eZxjoyk=
X-Received: by 2002:a05:6a21:3a41:b0:3d3:adbf:7782 with SMTP id adf61e73a8af0-3da3a16baebmr39641411637.23.1788783538104;
        Mon, 07 Sep 2026 05:18:58 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc45545210csm3958174a12.21.2026.09.07.05.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:18:57 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: laurent.pinchart@ideasonboard.com,
	hansg@kernel.org,
	mchehab@kernel.org
Cc: Wei Jie Law <98lawweijie@gmail.com>,
	guennadi.liakhovetski@linux.intel.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ribalda@chromium.org
Subject: [PATCH v2] media: uvcvideo: Fix NULL deref on events for uninitialized controls
Date: Mon,  7 Sep 2026 20:18:43 +0800
Message-ID: <20260907121844.2592492-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

A null-ptr-deref exists in v6.12.105 and upstream. KASAN crash log:

  KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
  Workqueue: events uvc_ctrl_status_event_work
  RIP: 0010:uvc_ctrl_status_event+0x105/0x280
   uvc_ctrl_status_event_work+0x82/0x240
   process_one_work+0x66f/0x10b0

XU controls are initialized lazily, on the first UVCIOC_CTRL_MAP or
UVCIOC_CTRL_QUERY.  Until then ctrl->info is all zeroes, so
info.mappings is not a valid list head, list_empty() returns false, and
uvc_ctrl_status_event() walks it from a NULL next pointer.

Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
Assisted-by: Claude:claude-opus-5
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

---
Changes in v2:
- dropped comments in code based on review received
- add Reviewed-by from Ricardo Ribalda
- drop the former [2/2] patch as it is a duplicate (out-of-bounds read in
  uvc_ctrl_status_event()): already handled by
  https://lore.kernel.org/linux-media/20260813-uvc-status-11-v1-1-2cf43e9590b0@chromium.org/

v1: https://lore.kernel.org/all/20260907062819.2519878-2-98lawweijie@gmail.com/
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 3ca108b83f1d..ea28c4e819bd 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2209,7 +2209,7 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
-	if (list_empty(&ctrl->info.mappings))
+	if (!ctrl->initialized || list_empty(&ctrl->info.mappings))
 		return false;
 
 	w->data = data;
-- 
2.43.0

