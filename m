Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892095;
	b=X7NTjjUmbDH8oF+sI0Yv/0fBhyNO7mMGvejq96j77166vHV+/XSeBxIwtaMCSUe8Mqkb
	 Z1gwbI/wm3s+3OkC2efAK2xW6l4DT+F/5CnPkZESRI9aBRGIBHzgWYK83zW6lfpswSHgh
	 7XXXSEo3qbbNPoYtyQfd+F9u1Ovdedd/tWJQm4JF/DOdVxkG1Tuytwt3L+c40METkDCnS
	 HdIF+yqDRGzD0RToD2ZXVIqrBlPNR1nzzoZOL5oBqSlxIdA0zKEfLDlOfnOQu/u0sl3tr
	 iAExfh56HFe4qTI7Ix6Pl4otB/dqKrq8HP87jkJr53vy9D5epZYr6WcPt3GYKXvns+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=d8zTOCpdfLCFup0LtTUT8GHUquWtW5OhPtS3dNMqHJw=;
	b=KHedV0zYu17y9Sh07h6KAwztGiVDvs212vpNp4fcnTSBc8t7TZp9WsR2gMd5F0ttz1jm
	 nk9/yNS53kWFe0/+3+5wANGQY0OBkfRbBH7qya3LTLwZI3mErmx5WA+Zb04bHO25OqWPx
	 W7G6qzQ7vMIh7E6ZVmvEjdjGb+fRBLDR6+YSEbEW774vq+Ja19ZsEccwcf3kHEwmkb50J
	 M0Ojq5RZPEhX7eJ/TppZIbTfAX7t3f3vIaGInsck0ryNRxj2baRiZdIapPqrO0rwoGA+6
	 jodZWQ+Tww40LK5xOoHxZTn27wq8gBA3AaE81wGmRjAVjGKDMJhmqIY8dQT3aXH1yrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=INVTu4vU;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AF9606A320
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7AF9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=INVTu4vU
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89e6ddd4554so1246820b3a.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792892094; x=1793496894; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8zTOCpdfLCFup0LtTUT8GHUquWtW5OhPtS3dNMqHJw=;
        b=INVTu4vUwpEyC7ZtxvJsKVU2+nOgKLbSmZQV5fHfLi1+JJ898E1aLK08xff6wcILew
         LSG5Nk78eLrG9Y1U1tpmffPRoP1gn9jCLfbXSA0sMUN/r6Yzm1+pZyvghn3Vj2IIkzIY
         JgT5Y1kG1vcwJgXPaKd5+3cYPLiIBWsZ6fNFtHZtbMiWuKlQiVB2o2LXJ1HNlj0BmVsm
         ejI6O0J2ETi9brA+6Bf3P7RCRBJRcPhdzwkQ295uNPiJBrGd0Hzu39yZ2v3FNO/Mhc4O
         MVnCVqHltB160meoyBF8A0z8uTl8lnlx4mL/523peD9igjcf18omkXV2CoNFnFXIr8qg
         sr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792892094; x=1793496894;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d8zTOCpdfLCFup0LtTUT8GHUquWtW5OhPtS3dNMqHJw=;
        b=1tIcgcCgPg+O8aPpA7uCZhz2QhJ2ORFzqLVUDyHOjC2NzLDPMA8LBbY3JEYzm9wiqF
         5kO0uAUcEf4e+Aun8Y33tP6KIbRmxhY26NGwwwb1t99x+0l4zvrLq6XGlDC4yg285c9Y
         BQC83Tsqd5DJfOnDNefkOMjvUpbPC7L0uZ/EcV6h0VEH3r9psKdYrlI5Mdpe7djgoSFM
         snYTFcqn+52/xDf+C0K6IVLXjfQbZ1tRrka1USd/8dcV8PYGx79jfuCXz/6hCDBKhFLZ
         rB9IIOzi6JqikZgLxuOxERKNRdI60Y07bPXG5DPizt0VhngCSHG0D2uZbxj0y55U1VxG
         Hntw==
X-Forwarded-Encrypted: i=1; AKwUvBx7XGp91ca1Trr+DjEHc034Rqcmbb1MCiVzcGM0jbvZD5VeH4wjfj11PAc2fERkefQM1Uv4cNI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfvmY1ciQKR01X6rI5nqEUMPcuPtuaEApC/8/nRr7ICOuqf2pl
	4cCeaMN8oEnKOVKudzsr9IICxh04za1qbfEYIggpOuN1cWgWE+tZ1o0aCHOMbN8o/XEzZe2l54p
	S5VQwMxMHnzGId72z2r3Blw==
X-Received: from pjblj15.prod.google.com ([2002:a17:90b:344f:b0:3a4:fb9f:4a65])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4ac9:b0:3a7:db88:3491 with SMTP id 98e67ed59e1d1-3adeabe4324mr2618939a91.33.1792892093846;
 Sat, 24 Oct 2026 18:34:53 -0700 (PDT)
Date: Sun, 25 Oct 2026 09:34:44 +0800
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
Message-ID: <20261025013446.345974-4-stanleyjhu@google.com>
Subject: [PATCH 3/5] scsi: ufs: sysfs: Propagate runtime PM resume errors
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>, Can Guo <can.guo@oss.qualcomm.com>, 
	Peter Wang <peter.wang@mediatek.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stanley Jhu <stanleyjhu@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

All 14 ufshcd_rpm_get_sync() callers in ufs-sysfs.c ignore its return
value:

1. A user-space sysfs read or write runs when W-LUN runtime resume
   fails, when power.runtime_error is set from a failed runtime
   suspend, or when W-LUN runtime PM is disabled while not active.
2. ufshcd_rpm_get_sync() returns a negative errno without waking the
   device or host controller.
3. ufshcd_read_hci_reg() reads an HCI MMIO register on an unresumed
   controller, and the remaining handlers issue query UPIUs over a
   suspended or broken link.

Switch all 14 sysfs callers to ufshcd_rpm_resume_and_get() and return
the error after releasing any held buffer and hba->host_sem.

Fixes: aef80fd1da32 ("scsi: ufs: sysfs: Resume the proper SCSI device")
Fixes: b9d104465a6c ("scsi: ufs: Prepare to add HCI capabilities sysfs")
Fixes: 600edc6620a4 ("scsi: ufs: sysfs: Make max_number_of_rtt read-write")
Fixes: 6c4148ce7cc1 ("scsi: ufs: wb: Add explicit flush sysfs attribute")
Fixes: 500d4b742e0c ("scsi: ufs: core: Add WB buffer resize support")
Fixes: ae7795a8c258 ("scsi: ufs: core: Add HID support")
Fixes: 1fd2e77b8897 ("scsi: ufs: core: Add device level exception support")
Cc: stable@vger.kernel.org # needs "scsi: ufs: core: Introduce ufshcd_rpm_resume_and_get() helper"
Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 drivers/ufs/core/ufs-sysfs.c | 67 ++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index cf49ad0258e1..19b62cf52410 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -250,13 +250,19 @@ EXPORT_SYMBOL_GPL(ufshcd_us_to_ahit);
 
 static int ufshcd_read_hci_reg(struct ufs_hba *hba, u32 *val, unsigned int reg)
 {
+	int ret;
+
 	down(&hba->host_sem);
 	if (!ufshcd_is_user_access_allowed(hba)) {
 		up(&hba->host_sem);
 		return -EBUSY;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_rpm_resume_and_get(hba);
+	if (ret) {
+		up(&hba->host_sem);
+		return ret;
+	}
 	ufshcd_hold(hba);
 	*val = ufshcd_readl(hba, reg);
 	ufshcd_release(hba);
@@ -350,7 +356,9 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 		goto out;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	res = ufshcd_rpm_resume_and_get(hba);
+	if (res)
+		goto out;
 	res = ufshcd_wb_toggle(hba, wb_enable);
 	ufshcd_rpm_put_sync(hba);
 out:
@@ -421,7 +429,9 @@ static ssize_t enable_wb_buf_flush_store(struct device *dev,
 		goto out;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	res = ufshcd_rpm_resume_and_get(hba);
+	if (res)
+		goto out;
 	res = ufshcd_wb_toggle_buf_flush(hba, enable_wb_buf_flush);
 	ufshcd_rpm_put_sync(hba);
 
@@ -490,7 +500,9 @@ static ssize_t wb_resize_enable_store(struct device *dev,
 		goto out;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	res = ufshcd_rpm_resume_and_get(hba);
+	if (res)
+		goto out;
 	res = ufshcd_wb_set_resize_en(hba, mode);
 	ufshcd_rpm_put_sync(hba);
 
@@ -598,7 +610,9 @@ static ssize_t device_lvl_exception_id_show(struct device *dev,
 	if (hba->dev_info.wspecversion < 0x410)
 		return -EOPNOTSUPP;
 
-	ufshcd_rpm_get_sync(hba);
+	err = ufshcd_rpm_resume_and_get(hba);
+	if (err)
+		return err;
 	err = ufshcd_query_attr_qword(hba, UPIU_QUERY_OPCODE_READ_ATTR,
 				      QUERY_ATTR_IDN_DEV_LVL_EXCEPTION_ID,
 				      0, 0, &exception_id);
@@ -1101,7 +1115,9 @@ static ssize_t ufs_sysfs_read_desc_param(struct ufs_hba *hba,
 		goto out;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_rpm_resume_and_get(hba);
+	if (ret)
+		goto out;
 	ret = ufshcd_read_desc_param(hba, desc_id, desc_index,
 				param_offset, desc_buf, param_size);
 	ufshcd_rpm_put_sync(hba);
@@ -1482,7 +1498,12 @@ static ssize_t _name##_show(struct device *dev,				\
 		up(&hba->host_sem);					\
 		return -ENOMEM;						\
 	}								\
-	ufshcd_rpm_get_sync(hba);					\
+	ret = ufshcd_rpm_resume_and_get(hba);				\
+	if (ret) {							\
+		kfree(desc_buf);					\
+		up(&hba->host_sem);					\
+		return ret;						\
+	}								\
 	ret = ufshcd_query_descriptor_retry(hba,			\
 		UPIU_QUERY_OPCODE_READ_DESC, QUERY_DESC_IDN_DEVICE,	\
 		0, 0, desc_buf, &desc_len);				\
@@ -1548,7 +1569,9 @@ static ssize_t _name##_show(struct device *dev,				\
 	}								\
 	if (ufshcd_is_wb_flags(QUERY_FLAG_IDN##_uname))			\
 		index = ufshcd_wb_get_query_index(hba);			\
-	ufshcd_rpm_get_sync(hba);					\
+	ret = ufshcd_rpm_resume_and_get(hba);				\
+	if (ret)							\
+		goto out;						\
 	ret = ufshcd_query_flag(hba, UPIU_QUERY_OPCODE_READ_FLAG,	\
 		QUERY_FLAG_IDN##_uname, index, &flag);			\
 	ufshcd_rpm_put_sync(hba);					\
@@ -1608,7 +1631,9 @@ static ssize_t max_number_of_rtt_show(struct device *dev,
 		return -EBUSY;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_rpm_resume_and_get(hba);
+	if (ret)
+		goto out;
 	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
 		QUERY_ATTR_IDN_MAX_NUM_OF_RTT, 0, 0, &rtt);
 	ufshcd_rpm_put_sync(hba);
@@ -1648,7 +1673,9 @@ static ssize_t max_number_of_rtt_store(struct device *dev,
 		goto out;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_rpm_resume_and_get(hba);
+	if (ret)
+		goto out;
 
 	memflags = memalloc_noio_save();
 	shost_for_each_device(sdev, hba->host)
@@ -1700,7 +1727,11 @@ static int wb_read_resize_attrs(struct ufs_hba *hba,
 	}
 
 	index = ufshcd_wb_get_query_index(hba);
-	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_rpm_resume_and_get(hba);
+	if (ret) {
+		up(&hba->host_sem);
+		return ret;
+	}
 	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
 			idn, index, 0, attr_val);
 	ufshcd_rpm_put_sync(hba);
@@ -1760,7 +1791,9 @@ static ssize_t _name##_show(struct device *dev,				\
 	}								\
 	if (ufshcd_is_wb_attrs(QUERY_ATTR_IDN##_uname))			\
 		index = ufshcd_wb_get_query_index(hba);			\
-	ufshcd_rpm_get_sync(hba);					\
+	ret = ufshcd_rpm_resume_and_get(hba);				\
+	if (ret)							\
+		goto out;						\
 	if (ufshcd_is_qword_attr(QUERY_ATTR_IDN##_uname))		\
 		ret = ufshcd_query_attr_qword(hba,			\
 			UPIU_QUERY_OPCODE_READ_ATTR,			\
@@ -1848,7 +1881,11 @@ static int hid_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		return -EBUSY;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_rpm_resume_and_get(hba);
+	if (ret) {
+		up(&hba->host_sem);
+		return ret;
+	}
 	ret = ufshcd_query_attr(hba, opcode, idn, 0, 0, attr_val);
 	ufshcd_rpm_put_sync(hba);
 
@@ -2121,7 +2158,9 @@ static ssize_t dyn_cap_needed_attribute_show(struct device *dev,
 		goto out;
 	}
 
-	ufshcd_rpm_get_sync(hba);
+	ret = ufshcd_rpm_resume_and_get(hba);
+	if (ret)
+		goto out;
 	ret = ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_READ_ATTR,
 		QUERY_ATTR_IDN_DYN_CAP_NEEDED, lun, 0, &value);
 	ufshcd_rpm_put_sync(hba);
-- 
2.56.0.307.g5fe7bd680c-goog

