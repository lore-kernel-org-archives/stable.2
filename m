Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892099;
	b=39PMlprral/wouCYj+HEA+rFdAD5ghbbM4Y1VhV11v3uWE38vrsO2ykfgM/bPln8GxMy
	 6LW76o2oTnAz3IHxS+YhtUnfBlNaueFYXZZJ0l8uhwXWpCmQ63bAUvmIFzBXp3ANP9Tkr
	 jiE7i7UrOB2ylmzgB2TLGe9Mn9VaF7tgeut/EdqiZE+uX53+2R7j6JWNmUWMK5dAaWe6E
	 136Q76StcdIejQ6RtFk0ZFUP0AFzWFM3tZ1u8MRmh+TZOpxwy8ygpozLElzZDkAOOap1H
	 ShwbzGVZlQIoofrBJqiTC052mS2T752jgH9n8ZMW4Pir+0t4bn/bQnPChsH5BmylcFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=BP/T5caNyFQqrbvx80KyGJgS3Pl0WpQ0WItoit3D5n4=;
	b=axrtedkHnck5nHPCPuPnFmgwDd36K2LnDyxf60Znmgxp00c7v8hk1p/2LsbhmIN6g6Jb
	 4E3r7iDGY79ODQEwXqP7Dy42EQhFB6gQG94f88Q+FFAeGCvEG3YgsRr5gAjWMY5sdb0Le
	 bsdsw2FhnOdF9Rvb0CeOw44H24cOouyHJvdtAlrfFoOZfqni0aW9AuUFqSe1IacGpSc85
	 HbnnhM2i3W5NzO6TxtaljFKBzcrcCW+H7Dfl0UqYbZXctwkzdD6hUC3o33rirHrDM+Zjc
	 qWILvDlE8KGTrFlPB+sH2epx6IEsLJvw5qr4Jm2pWLud7W1DlaoR/MMOPMGC/FlV6qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dEzswU2F;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F5606A336
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D03F5606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dEzswU2F
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3aaf955db5fso3192825a91.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792892098; x=1793496898; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BP/T5caNyFQqrbvx80KyGJgS3Pl0WpQ0WItoit3D5n4=;
        b=dEzswU2Fcsi1HV/1C1T/dd4ptCo42oLxLfLaX5mdu4t50ngB7DU/MikWO9wmPQj6hH
         wDUjsaOuZILakJWz6SJ3xNZCNmaVOroWsYUI0BdPbphSAX4n5KQs2LEcJzxhbWG/vmg/
         JsaGpOiIsL68Yedj1JC3z2zz5qupKclpqFwpYMmmbVLaSjFk18tmQ/jScKl4xe2CLsFA
         eU+M6DvthyaXWW+EldMi2NBn1+nYccZERagA7tSuxh5bnXFk8m69l/JToSc7HbFV4eHp
         UctyADqbeG7sOpmRZAm98fcpI53RaKdQ4FyL6pbMHXBTEbA1fnu7Mi4VbAoQYn3SqQNH
         tamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792892098; x=1793496898;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BP/T5caNyFQqrbvx80KyGJgS3Pl0WpQ0WItoit3D5n4=;
        b=fjHR2OEVE1ZqCCLJT7p7yUgu0tifGO4a5sGsCvgk8aO+tvkm9OG3h4EoVvK8pNfUNZ
         XlL5P+M37Y+sPHuurjABMmyY4hKQCnJ8MsvIP19woMepcsvxs5IYxA8T+wB0gvDOmWbs
         wP0aqE4HdvQdaFwE4TBpV9sQ6cQ83vdfwwWlRZNf/hNGWFPEV/yq960TImECrNCKVp1U
         KRnrWn1MOqUEsUxqEOHOoMc05xA9uvE41LnobNCQzqvePc0yl+sNhKn3nDwS0RnX8Sdi
         D0Qaz63JIzgzac6akQe8GwVk+IGeSI4pq9EPKfxnQAPuNEvEdbge1B5gibVG+2IO+B53
         G7Ow==
X-Forwarded-Encrypted: i=1; AKwUvBwQxXqHdySnde5bE0RmNZLBr2gJbPVcMjMD+4yvoXa3mMJdYYc2WmkILl4TCgmMFkVMHqZ6OoY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVg5TSqsH4vU3flefA1e2H4Q2gTyfgjcXpywIEX8YbQISm8NO1
	cxwo4tyelD01agkQrDfXNLD5OydqG7bjHB8vt1Yxhpv5LZKCl51G6gQ89GUoBVG/XdzAiWzFFmD
	e1RhXOTb3daQ6uO0bBQjKEQ==
X-Received: from pjvf5.prod.google.com ([2002:a17:90a:da85:b0:3ac:16a7:52de])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b8f:b0:3ac:450a:f9d4 with SMTP id 98e67ed59e1d1-3adeb16364bmr3012759a91.64.1792892097936;
 Sat, 24 Oct 2026 18:34:57 -0700 (PDT)
Date: Sun, 25 Oct 2026 09:34:46 +0800
In-Reply-To: <20261025013446.345974-1-stanleyjhu@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025013446.345974-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025013446.345974-6-stanleyjhu@google.com>
Subject: [PATCH 5/5] scsi: ufs: hwmon, debugfs: Propagate runtime PM resume errors
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Can Guo <can.guo@oss.qualcomm.com>, 
	Peter Wang <peter.wang@mediatek.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ufs_hwmon_read(), ufs_hwmon_write(), and ufs_debugfs_get_user_access()
ignore the return value of ufshcd_rpm_get_sync():

1. A hwmon sensor access, a debugfs exception-event write, or a debugfs
   TX equalization retrain request runs when W-LUN runtime resume
   fails, when power.runtime_error is set, or when W-LUN runtime PM is
   disabled while suspended.
2. ufshcd_rpm_get_sync() fails with a negative errno while leaving the
   device unresumed.
3. The caller still issues temperature or exception-event query UPIUs,
   or retrains TX equalization, on the suspended target.

Convert all three call sites to ufshcd_rpm_resume_and_get() and release
hba->host_sem before returning the error, ahead of
__acquire(ufs_debugfs) in ufs_debugfs_get_user_access(). This covers
ee_usr_mask_set(), ufs_debugfs_restart_ee(), and ufs_tx_eq_ctrl_write(),
which all use ufs_debugfs_get_user_access().

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
2.56.0.307.g5fe7bd680c-goog

