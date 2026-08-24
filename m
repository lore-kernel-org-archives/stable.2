Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E13DDDA3
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550629; cv=none; b=Zby7Uva0gliijvWRGt3cihXBIMcQnF1o5CF3Y1bvHYyJAsBXGWglYbc4uc3+ykBGZtMA3RxHqFqxxfvV+iTicqztnUy8TmiN+xYexCMAyrBs1HfDLe1K6Paoz+SZDsNwoDqXBd49+sV/2lywc/kt2uTkZNXTAxPX4nRmSeX3JKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550629; c=relaxed/simple;
	bh=WZE0UAjryG3LKGmJlWlrF4NVV/WeS+t9+KyPhRYEdqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIVLVBzNT6AiVaS+ZaeNLOhwh8D4KDKFECWoDAnnfrTfbRriztuWWwu8d7QhaDplLcUYxVm5o91maFnN6OVPKEwF77TZC5MYoQg4n4kq7A24m30yZUJNi4IWDQu9xVG0dSFpS4zCu4wBPMA+9aORPEyc5Yshvl8GAukxqJJbWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3Yq0NfM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3Yq0NfM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso42473525ad.2
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 22:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787550627; x=1788155427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EB3wFOXHlXyIKQOwKFQXlogVT9fQ7bqKTlFugd3hmJ4=;
        b=b3Yq0NfM2W2WY7nw9PUixGDdTxFA0LFPnu80kJG80gTDj/3QER/9SFE4pmwbyr+xow
         pKgoYMwOw4AcbIlVCsyhVja9KyUTKH68ZG+jreIKFpv5abtQ+b27BNy8IJnrRT/vkk50
         EYx1ePF054OKarryHm5qsxneeCWjYe2vigG0PObtBlGzZezGMztYRx6HzDaSeWvZAHYK
         /dBIv1UK9xwCkc3mPef2BNlEcmv84mO3FKkV8AkHu/8Iom/+oVLnkWuPRps1qDInLH0M
         dIOFICiRiFRp/oCUj1p2PIA9NAiLiGZdR5FcmDqrDm27k1HaQfjR2bY+p2xe+UFQJ0G4
         rFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787550627; x=1788155427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EB3wFOXHlXyIKQOwKFQXlogVT9fQ7bqKTlFugd3hmJ4=;
        b=Cxx+5Lzr0PBZQbU674beL6bOce/J/U5qi2NZuj/x/5O05UdaEnM9oicdjOW555ZpLE
         sskQl9S9wXgKFf1N6EBk0vxRid+F7BAKdLqdIzRypAGqZGu0GuSDWKIEPUq1bd6DIe7l
         D/HpJBtbYtCbCMg2Zt18rhkBTyQ6az8qbq+BVMI8HyVMPKAV279Lsd+jTnNKiaFw/WQO
         E3iiRSPuO2oOjEU17UMhnksClp/Yks9g/idTlWAt1QZ+ARWrUhgg+l5JcLyZGIHoDZWY
         UE7MY0tp2O4A7KVj+9BguGtlMK1+6jkaaeGXPrD93dpiy083GzOJND/DKv+MBUtt2UbS
         hQiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/FGW+Q2NLXv9ZyeQlKCcHgHx5U6bnBU6YDUZ+RNdGB6G65eRGC6Yoap5ISGaCdwgaCAHn5h8=@vger.kernel.org
X-Gm-Message-State: AFuF++l09e1Ry2I+ovQf57t3HmSEvbyiJiNASqCIgv5Z27mXc989Wv3g
	aAWgZ461RFp5/Ecyh63mnR/Y2AbjTqEFGX4N6EowyvPBfES5ujzKJoc6
X-Gm-Gg: AR+sD12d/EjOA51zXePGPllZ0zidrKqF5jSew3iVRVqlbCfLZ89yA5JQriVwHD+KWfl
	KYTq1PQxjD9oypxWt1z0r65IAUZY/IoU7aJeFBcxo8T126eB7r/nBY+n2zu8QNEI2fr0mBAaitI
	fBOxOU4zRSLAvG0ASDqPVSKG7OXCJ9d+cmG5Z5hsGWhiV7SwLFxroT23qzMHtR4Z7+PAotCtbvA
	1QAN5GKjL8/pjIgMu1KmCBxXlTRsKTykC6MFUqGlq5ZHlxzFr+5b4fr7MVzu2q61EfQrsdMJZnt
	90+VfhQO4Nm6YGCLcwnSc8ozMqoX8b+5tsuZjtYCoPTdh+wqvCvE2FjIbOKgXL68A7w/6tYhyST
	RkaSvry9PbfseKQC6UxUhoK2NeZPG/yWMD/YOSsOov7MTNrXtL4bh3DrmLByYA6OavY/PdimvAl
	S8NoEGEgVju8BQpeulYU1JKwP3iBjbN08GavHsKmOVKA77px+Q+tnCzoJ3Ti2szLdjLur9az1j1
	hd5HI+HBz2YSHhozrS91IB/Njj63Iu32rj0RJuEV2ialfzCbJIENEyL/hCh21LAi1DEUB5+O8ui
	JquYFKXYI3+OnrHC7lTroYw5
X-Received: by 2002:a17:903:354b:b0:2ca:f21a:a6c5 with SMTP id d9443c01a7336-2d64ada70cemr430814115ad.1.1787550627273;
        Sun, 23 Aug 2026 22:50:27 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768c9876sm13955655ad.68.2026.08.23.22.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:50:26 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
Date: Mon, 24 Aug 2026 13:50:11 +0800
Message-ID: <4a48122167e32a6755d9ee7033f29bf7c78be796.1787549234.git.98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787549234.git.98lawweijie@gmail.com>
References: <cover.1787549234.git.98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmi_read_pdt_entry() takes the interrupt source count straight out of the
Page Description Table entry the device supplies:

	entry->interrupt_source_count = buf[4] & RMI_PDT_INT_SOURCE_COUNT_MASK;

RMI_PDT_INT_SOURCE_COUNT_MASK is 0x07, so the value can be 7, and
rmi_create_function() copies it verbatim into fn->num_of_irqs.  But
struct rmi_function declares

	int irq[RMI_FN_MAX_IRQS];

with RMI_FN_MAX_IRQS == 6, and both rmi_create_function_irq() and
rmi_unregister_function() index that array up to fn->num_of_irqs.  A
device declaring 7 interrupt sources for a function that has a handler --
F01 always does -- makes the driver write irq[6], which is the storage of
the following member, unsigned int irq_pos.  The function's position in
the interrupt bitmap then holds a Linux virq number, and that value feeds
set_bit(fn->irq_pos, ...) in rmi_f11_probe()/rmi_f12_probe() and the
irq_dispose_mapping() loop on teardown.

UBSAN reports every store in the loop body and the read on the unregister
path:

  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:183:10
  index 6 is out of range for type 'int [6]'
  Workqueue: events uhid_device_add_worker
   dump_stack_lvl+0x64/0x80
   __ubsan_handle_out_of_bounds+0xc8/0x100
   rmi_function_probe+0x1c1/0x210 [rmi_core]
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:186:28
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:187:35
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:189:32
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:191:54
  UBSAN: array-index-out-of-bounds in drivers/input/rmi4/rmi_bus.c:282:30

Size the array to match the three bit field that feeds it.  Clamping
num_of_irqs instead would silently drop an interrupt source a device is
allowed to declare, and would desynchronise irq_pos for every function
created after it.

Reproduced with an emulated RMI4 device that publishes a single F01 PDT
entry with interrupt_source_count = 7, driven over /dev/uhid and again
over dummy_hcd plus raw-gadget, on v6.12.69 and v6.12.105 with
CONFIG_UBSAN_BOUNDS=y.  No reports after this change, and the same device
now probes normally.

Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
 drivers/input/rmi4/rmi_bus.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 90122df21f74..faf2ebb00d52 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -12,10 +12,13 @@
 struct rmi_device;
 
 /*
- * The interrupt source count in the function descriptor can represent up to
- * 6 interrupt sources in the normal manner.
+ * The interrupt source count in the function descriptor is a three bit field
+ * (RMI_PDT_INT_SOURCE_COUNT_MASK), so a device can legitimately declare up to
+ * 7 interrupt sources for a single function.  irq[] must be able to hold all
+ * of them: rmi_create_function_irq() and rmi_unregister_function() both walk
+ * it up to fn->num_of_irqs.
  */
-#define RMI_FN_MAX_IRQS	6
+#define RMI_FN_MAX_IRQS	7
 
 /**
  * struct rmi_function - represents the implementation of an RMI4
-- 
2.43.0

