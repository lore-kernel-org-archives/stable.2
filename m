Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257733;
	b=S5FfpHIbmIzQ/QkZR83q/xg1rSHFI7PzHawjPCDw5FJL0E/NtrZs+kO7x9KMRzTWXqnV
	 CU3q9qRf21pR8WlN5NDdz6mEs80w9PjebMOwLGpnMTkoWu8PBTtn1oeZtLnksS+CZ+447
	 ZhHDpq2x4yJpU23g7C2tlUCERwZjIBi5jFleGN8l86t5VmxWm/FKvwQCYVi3hXDJZsJRG
	 UbmRpykbub6YuiL869G5jZJXL0+BHdUbLxeYvfHx60BM9epp7mgGnia4SIaawrNaJhzL6
	 rDZBWRQBncoafCk2LDx9iy1P3R3o6rrrOVxkvvkRpruhtjwmEDmLaiSaDvAMj7yQROA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+XRLrEYHQ+G7RcA+eWZjFkx5+X6g7uz3KPyk8Z30478=;
	b=EmVi8/JBiisch7ombDq6PsYz2SoG1BrcMQrLQdin84Vte8jfRsx6rE0mrwSjNYdlONQI
	 E248vPbcjbSXMSsFi10c/cLxGadyVqZJljixI7lWe/L47IaQpJhCUjEF/NXNoFvZPsOFi
	 KCSTx4UD6IidkGhK4SsdlE4hn9dwbIkwdMP+8dIBlbhD5WQS5da5T7m9mEM8O89sepcGW
	 nbT9sF7r46GADIeQpzzL0Xh0KfSUOZ8VhrPOQCikRgWlt97i9jofK6unzGCipc4Czj53g
	 al0Z9SJ/g7X0DzaQqYczLTRSizBAV/Fuy1fQuVB1KKFoaqRcidh44jPyNy4sVvVaajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Nz7ICX+C;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC260A261F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EDC260A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Nz7ICX+C
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so3897782eec.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793257733; x=1793862533; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+XRLrEYHQ+G7RcA+eWZjFkx5+X6g7uz3KPyk8Z30478=;
        b=Nz7ICX+CnrO1zUfWGNfcl4E142+f6VdgYRfiOQMlE/ZTbJva6EwUkpQL2bwzLE8UHn
         bvPtTppJwQr6ORH3uBBXhYPiHzQBxVC3tOEVCJ1lC5iIzkbBehc50hHa4z4eK7ica2Zy
         cBwohBi4I0UbnFrA7bp9AulGbVqXAVWB4k+TuaQ0b627cDMzNiejytNSrLm2Xf6ZCZoU
         NGeEXsWsLVnzBE6WC862Zkp4rHwZuDDcdRJQHBJOsr3NcUoCEjEJr0HIaAoGjo6r6iga
         P4CIQAwbbDNal4FjsG5JYQFvWc5T5xFEXK1x7Tno6/z+1w37FdJDP0JHzdniFyI9hxrk
         C9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257733; x=1793862533;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+XRLrEYHQ+G7RcA+eWZjFkx5+X6g7uz3KPyk8Z30478=;
        b=w3YSUS787pjUMdTxO3SrZ/EBk3tkuUNot33ZOYLtJ4QWrqli9U5Od5cIMdm1ypkWYV
         xlUPTgelqeOmWdRJSiW/wLOG4m4cRoobBm58dljbcmMa1e/fIGgl0IlT1OB3eNaD3cpQ
         RqaoREpv+AZD4UW/T4YZ92p0d9DcOP36+bEW4qzNQy24fUqzKwtDJEqY6aavpTunuz72
         Fugqgd31xXcgzQDCM+g/Awg+dkpo2q25WaYAp5lc/xWStMQ3wyDfYwPeTD7vTicSMVlD
         wOfMt3MR/p5bmCox4+3N7B/ixrzx3K9rQYls32Yp+K0PvYE5d5Wte7Rag96oCT4JlTUI
         kp3Q==
X-Forwarded-Encrypted: i=1; AKwUvByBsZyGiR057XIdtFgXPQIQ+NQn/kVmD9ldfvI2wGXGBh9aOfUGyH2t+pGjMmYaOcokaH14b34=@vger.kernel.org
X-Gm-Message-State: AFq9FYJEfZ8Wco3usIZ0Kyr8o1/tENsyapObLLOQcRwJQpMYJdecUSgn
	P69V3eG3qt9WMz7mDc6+Xvl6ZP9w2LByntcMGTB7bX9BUNOvid9B8AAuUCnJeUpMtQmlyjE+2dT
	g997mGxiwv8CXic1K6hT0sg==
X-Received: from dycoy6.prod.google.com ([2002:a05:7301:fc06:b0:35a:f5b8:c8c])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1407:b0:35e:6eae:c01a with SMTP id 5a478bee46e88-36a203febbdmr7364243eec.19.1793257732293;
 Thu, 29 Oct 2026 00:08:52 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:08:40 +0800
In-Reply-To: <20261029040003.2100003-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029040003.2100003-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261029040003.2100003-6-stanleyjhu@google.com>
Subject: [PATCH v2 5/5] scsi: ufs: hwmon, debugfs: Propagate runtime PM resume errors
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>
Cc: Can Guo <can.guo@oss.qualcomm.com>, Peter Wang <peter.wang@mediatek.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufs_hwmon_read(), ufs_hwmon_write(), and ufs_debugfs_get_user_access()
resume the UFS device W-LUN with ufshcd_rpm_get_sync() and ignore its
return value. For example, for a hwmon temperature read:

1. The W-LUN is runtime suspended.
2. User space reads temp1_input of the UFS hwmon device.
3. ufs_hwmon_read() calls ufshcd_rpm_get_sync().
4. The W-LUN runtime resume fails and the W-LUN stays suspended.
5. ufshcd_rpm_get_sync() returns a negative errno, which is ignored.
6. ufs_hwmon_read() sends an attribute query UPIU while the W-LUN is
   still suspended.

ufs_hwmon_write() and the debugfs writers that use
ufs_debugfs_get_user_access() (exception_event_mask and tx_eq_ctrl)
follow the same sequence.

Convert all three call sites to ufshcd_rpm_resume_and_get() and
release hba->host_sem before returning the error, ahead of
__acquire(ufs_debugfs) in ufs_debugfs_get_user_access().

Fixes: b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
Fixes: e88e2d32200a ("scsi: ufs: core: Probe for temperature notification support")
Fixes: adbabdcf0db0 ("scsi: ufs: core: Add support to retrain TX Equalization via debugfs")
Cc: stable@vger.kernel.org # needs "scsi: ufs: core: Introduce ufshcd_rpm_resume_and_get() helper"
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufs-debugfs.c |  8 +++++++-
 drivers/ufs/core/ufs-hwmon.c   | 12 ++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufs-debugfs.c b/drivers/ufs/core/ufs-debugfs.c
index 9f83628f3e2c..44a1a9692324 100644
--- a/drivers/ufs/core/ufs-debugfs.c
+++ b/drivers/ufs/core/ufs-debugfs.c
@@ -70,12 +70,18 @@ token_context_lock(ufs_debugfs);
 static int ufs_debugfs_get_user_access(struct ufs_hba *hba)
 	__cond_acquires(0, ufs_debugfs)
 {
+	int err;
+
 	down(&hba->host_sem);
 	if (!ufshcd_is_user_access_allowed(hba)) {
 		up(&hba->host_sem);
 		return -EBUSY;
 	}
-	ufshcd_rpm_get_sync(hba);
+	err = ufshcd_rpm_resume_and_get(hba);
+	if (err) {
+		up(&hba->host_sem);
+		return err;
+	}
 	__acquire(ufs_debugfs);
 	return 0;
 }
diff --git a/drivers/ufs/core/ufs-hwmon.c b/drivers/ufs/core/ufs-hwmon.c
index aa0b60a0ee8a..2b9673d92573 100644
--- a/drivers/ufs/core/ufs-hwmon.c
+++ b/drivers/ufs/core/ufs-hwmon.c
@@ -61,7 +61,11 @@ static int ufs_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32
 		return -EBUSY;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	err = ufshcd_rpm_resume_and_get(hba);
+	if (err) {
+		up(&hba->host_sem);
+		return err;
+	}
 
 	switch (attr) {
 	case hwmon_temp_enable:
@@ -113,7 +117,11 @@ static int ufs_hwmon_write(struct device *dev, enum hwmon_sensor_types type, u32
 		return -EBUSY;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	err = ufshcd_rpm_resume_and_get(hba);
+	if (err) {
+		up(&hba->host_sem);
+		return err;
+	}
 
 	if (val == 1)
 		err = ufshcd_update_ee_usr_mask(hba, MASK_EE_URGENT_TEMP, 0);
-- 
2.56.0.313.g2479322e68-goog

