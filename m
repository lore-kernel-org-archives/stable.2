Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257729;
	b=NSjH6SZPJTA3rjwrVJOfEI94wTVxU1baRAoPt3CQRP624IugWi1bnDB0AwDd0TMeEQEI
	 ouJJslCTkC+PQDchPx33bhW7ZqVGl4I0RGrL/cuLj8LkbXF4QQwsdSMZVEzCXJn0HnB75
	 vPkw2mrqjEdPresm8UNQxTh0xTGI4uk1ErpKQlC3NDYdx1SaDS0T+kvNgV+PypO7pLQy8
	 0yqzI38MYF6wvqhPx5ofHe8BWbZ3dGRBoVprBGB2dgHnnoxNUU+0XIcMSvroZ1Cb78ggv
	 w4LDe7z84U2QSJNmUX/5OwdyVabvWkSp3QWaRLvKXfTLMKGDJT/ykKIDYZhJHLYBSHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=OUHh2HUdQSxCBT9nC/OJRX/Gk1BuioTlk1cPR0j3PlM=;
	b=g++5W87Hezj0y07S9/2qK+Fs6LZvMUFFclzkrm5idltOOwivOCFtqq6RxHn/M4fbOjZL
	 rlDdbH9/VAyDuP8NgAjo4taGK+2FJ4xeocrNGD3Lr1ZBTE1bSBaY/CNBNTdorzqq2i7jI
	 +B3DfyJF/o3FoEepy5d/y0X8KD623IChZ/RsXjq+F8u8IcV+Fpx4W1F6LeohIpzxdxUrw
	 +IHQUDILXM/QI7J5eOU28saBDG4QjNGeAxDe5+Ag6cJ+qu3WlZGz6yXJ/oxwalH1r3wbM
	 Mg5sAvjbeiuvokObktSCBaD/LRJIiYHEdos30cKHlQkckJSM+jqh9/eYXfPKZdQDUbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="kim7JW/L";
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7C606A329
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20E7C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stanleyjhu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kim7JW/L
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so1201085a12.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 00:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793257728; x=1793862528; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OUHh2HUdQSxCBT9nC/OJRX/Gk1BuioTlk1cPR0j3PlM=;
        b=kim7JW/LDGp2QutHDDt9F6eqPg26MqB001UqHg0Btvgzp/Dam0nbMk6iEHtOiSl72G
         QQyUPIIlnp/KPV0wO+Ny9RaEBNjzpBovvdbVdBsWgW0Ie1nGB9Degckp8glu0rtooddC
         z2hgH1anig0hMgoK5BI4oMSiXuP/21+85jloDOvL37VJxlYtNynk0xm0TxqqUUthzgm9
         ikE0zHzynRUoI31MZ0zGTrOeFNYP/9l6QVtpjdPV+hiHtzA9QHrml3HiZhx+xia/QSrB
         iFJm5LQAZcx58cdQvmYjQAWuc5WU+/nmz+egBSntKIZacU91HYPca71jWWdrdwAPMc3o
         MEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257728; x=1793862528;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OUHh2HUdQSxCBT9nC/OJRX/Gk1BuioTlk1cPR0j3PlM=;
        b=y1V4sJMJ2cgVvShkkyYcv4/8UC3ToVyhUJ4jucSckJd95dQ1c9NYjP9/FRGuWgtOX2
         9xoZgsctFXWrPIn1x/nRq9QvdxvEw1cfFHd8LTObafTg5zhbeQ7wTavKcKOdU/JoJR3P
         m6/l26XZ6Ri0TYbV8RBAfko+K11JaPN0lRun+ZDuJ2cAjcw5H4wwTsaQHeXXlMXtS6c5
         IiSGgcoMlgUfzO2k3dOvrRFUy0+0cIrAlj7xcbzGTqxtDKIIlX9zt5LAY7dqgvikgStl
         RKPNOozsQ9SpY2YI4MB968Iny5nRpIE/DSmS7NFhrD8LENVVI60L1eBs5mPjBrt3+i7B
         61TA==
X-Forwarded-Encrypted: i=1; AKwUvBwbuhDom5X4Y0EtqdM1S2ZT8hs7MMNHjNHczGpYyDmbiqhl8PWcSjifniirQSaT6EGRYWYL5+c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuukWP4QaQUYLf2MzZzFMScbZ8ohkjcg5KkvkUS8uRrQz1bbAX
	nHw2DbWVAEEu2cHa3nln1MdW3ksn3slkvstW/F9ShQMZm684q3ES5fxS90n5ZMsZ3dCbmBERtPx
	kdHO88+Ol0D5j2Vs9UlUekQ==
X-Received: from pfog22.prod.google.com ([2002:aa7:8756:0:b0:89e:bd5e:725d])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:8003:b0:3de:b95:d50f with SMTP id adf61e73a8af0-3e902333d3bmr2967719637.24.1793257728425;
 Thu, 29 Oct 2026 00:08:48 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:08:38 +0800
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
Message-ID: <20261029040003.2100003-4-stanleyjhu@google.com>
Subject: [PATCH v2 3/5] scsi: ufs: sysfs: Propagate runtime PM resume errors
From: Stanley Jhu <stanleyjhu@google.com>
To: "Martin K . Petersen" <mkp@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bean Huo <beanhuo@micron.com>
Cc: Can Guo <can.guo@oss.qualcomm.com>, Peter Wang <peter.wang@mediatek.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Jhu <stanleyjhu@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

All 14 ufshcd_rpm_get_sync() callers in ufs-sysfs.c resume the UFS
device W-LUN and ignore the return value. For example, for a UFS
descriptor read:

1. The W-LUN is runtime suspended.
2. User space reads a UFS descriptor attribute in sysfs.
3. ufs_sysfs_read_desc_param() calls ufshcd_rpm_get_sync().
4. The W-LUN runtime resume fails and the W-LUN stays suspended.
5. ufshcd_rpm_get_sync() returns a negative errno, which is ignored.
6. ufs_sysfs_read_desc_param() sends a query UPIU while the W-LUN is
   still suspended.

The other sysfs callers follow the same sequence. They send other
query UPIUs, or read a host register in ufshcd_read_hci_reg().

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
2.56.0.313.g2479322e68-goog

