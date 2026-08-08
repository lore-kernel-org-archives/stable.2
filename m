Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E2313E21
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786201207; cv=none; b=rVmUpj82hTPX9QAVJXLaDIQLqs+uJfQQtvMOnKctq/cM2p7h0jTI+Xvz9+4dhHEgNSN2pHwNenmkFhaXgSpFuF2AkakUyecee+7KRrExxw35AEPWOD0xGpmsiK4P4b32swo08oFjKk+Y5NE7enojhXLSex68suwivmJN0QZ/97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786201207; c=relaxed/simple;
	bh=GfW2YEBWG6q+0lA0pPenck81sZPjv90TsJei2jwNBls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7IK0kCWqHs110OedSFTbLbvlCSvmwGughGlHB1Cgwb5i5jzmA2koeaa6uMz+nS9ZLYRUyvs3xXlTsSWZRU3v2H98KV27qvteejQyE8zNpx4ES84tOFPypfqCbel/KCqxGmarJin2hr3t2W5EGgnvbSD2IItznlpeAgI9shqqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAFbbBrr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAFbbBrr"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e041ea211so512884a91.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786201205; x=1786806005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oOONO+kZ83xynxRyUTPEoSdvpl1Q3Luqgq4ZyfoVH8o=;
        b=jAFbbBrrja3AI2d3/h4bTqZuDrqhui73COWcWo83t7STmUinCVT1pq6QKlsoBDCq0e
         CZV9DdSilcSi+fAAWxZo+bFn9lvhTbsvJqw3GA83wyoBPvhAaGhASgpNKpjf9Djrf6s5
         wEA3QcvXj4/e/glGutvvTPUaHIv7yciB7GjyFdTX3x/A6Q1YbIhaQLhfRGur8ilZFp4E
         8w1y5HlPItpIJWt23yYDTwH+LBMlPDyGp1A2bsXFO78wagnpJQmIAkSVaGTKiWv7t3S8
         gKiPH4pyDolzsREzb8xHvrJODvyD/zwoYbtNyZ20+dCf+sh6O/7XLPUZWXUVvnFfMcYJ
         e8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786201205; x=1786806005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oOONO+kZ83xynxRyUTPEoSdvpl1Q3Luqgq4ZyfoVH8o=;
        b=itV74aKQqrHyq7jhrLBEJ6H/3d2yA9NyuoCvDJ2liTsXzDJ8vF6+dvH7wj3drcBm/h
         iILw0WA/Y9eoYIPbqS5hp7pgV2YRuTTSb2gdydYmY8VttepOVPddjG6JQPdKcDVOBa5a
         LSxVc79xx2Eh0dd8el8YXowUkK7dHaYS9ku3eHrFOi9ZMOVCGpWxfx0d027imvm+6Rw5
         AUYBpUYSGCY9gV8JGHBpsJjF1kyoRlxdtoFPZ2NSf7wbicqhXcgBklH4IHWy/aihHA+Z
         SKC2jWoQ8QJshvFDOgsvmCREFeIp748CsOCox9Qid2sxN9zL5X1tna33X2mvfTqt05NQ
         ZZdQ==
X-Gm-Message-State: AOJu0YwTLOvPvKjzR+IQb/PIDSnq1wfb2yxL2tCgHgpH3ckULGIX00GP
	KMjRhPY22khk8bORO3vhQpZsIlldlPFIdvv3eYkThbGDBXQwdr9Yz+qw
X-Gm-Gg: AR+sD12ic/ko4ZVaGuckXKWoc2HM8DRGRFgwc1vrcz047o6uR7NXgK4bxGKhGzwUlIo
	Mgy+bXSV5VFweIBFjtnvZ0S6BwB5I1x/FMl/YnqtmzUmCa3Tfre1/WIu4ud6J/jrowu2cKBdFEY
	JceBi7dlJhbTBQIoTbO/lbOjVNWPHqLnN0WXCcqOQRoME6gC/920ecOJPeMvODss7QBQKXJC5UK
	pi2NloyPhXIRspzag21MUcL2pZOB0Uu+jx9YY1yerCUpy+H+cmhuh4W9yV85m7+BHuYJaY/iFjT
	ThBaHq1dDvQ3/EDwvscJm5lHrXzrBWjVQ452qZatjBUihaV93CqEGqeA1nRW3jvx7vcMwdci9WA
	lqU6+QqfpYlIyYI8rL2mLvp95kyhrFtlIyRDr2O6Yz35+qJvfPoOz8BC49/pvz/yNWRYIcEhPrV
	sdDV3OMq0kGpjZZaqa30b1s2y27/CSM1xKw082A7rJd4w=
X-Received: by 2002:a17:90b:528c:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-3903c5993cemr32295133a91.5.1786201204670;
        Sat, 08 Aug 2026 08:00:04 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6f13dsm6447642a91.1.2026.08.08.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:00:04 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: intel-quicki2c: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 22:57:48 +0800
Message-ID: <20260808145748.2926096-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quicki2c_probe() calls pm_runtime_use_autosuspend(), but
quicki2c_remove() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 5f420e8215c6 ("HID: intel-thc-hid: intel-quicki2c: Add PM implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
index 46d3e9a01999..4126c2408d98 100644
--- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
+++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
@@ -774,6 +774,7 @@ static void quicki2c_remove(struct pci_dev *pdev)
 	quicki2c_hid_remove(qcdev);
 	quicki2c_dma_deinit(qcdev);
 
+	pm_runtime_dont_use_autosuspend(qcdev->dev);
 	pm_runtime_get_noresume(qcdev->dev);
 
 	quicki2c_dev_deinit(qcdev);
-- 
2.43.0

