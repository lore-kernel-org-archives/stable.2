Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2BF3DEAD7
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550632; cv=none; b=Hc8Vd7gr/mB2fUgPxxAHg21HY62LWEtn9gtpP5ztBZZx+6ddZD+jh2XPtltG62UJTCZL9UfY5o1dBGEHANVEGiPaTc/KfxoBcEraYY+6l9mNebrDN2nhol6orc//oM6JF4CYgc2GlUvZmQxDGJtOMwpLKJPHIeVc9Ur0w8Rh+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550632; c=relaxed/simple;
	bh=ILGgGBJIjFFiPwTQaTOvL/nQywIa0UNzzJZhVum0lV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTwUXHERxoT7bkpusO1VY/XRPJMSBV9POOwrQLWFfml1TAu/E8zNZLqYA9wGw5s9RN9UGjgTO1otRHmK7L73wRbS9nydF7ethD2vQCtacCRRq5T/EVp/QcW4fYmuBtcH0oDF4hWgsYGhk18MpTkgN/PxMFU3ZfUu2yx4/R+yOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTq0NYKY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTq0NYKY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cab973140bso39612255ad.3
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787550630; x=1788155430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4eujiq6V03TrGWMcsHjzyrL4w51Ezbmmle/EXKToc6k=;
        b=XTq0NYKY+cVGL+TLnihE+3Wgqf/0DrID52UVCjcKGSZKotDyE4CdPIWgUyYpU4TFLz
         Z42HRTTq6rzg695RC0yM6IlbS579zyeg3KISxdeHHxLe6BQ888WpSo9FAJ4k/crSIKUp
         VpCS484WFEBP4r80vGRVzrqj2x9FnUc6BylT9AuNjKq3iqJWj8GUZUMQogPAXJ4XwEfS
         0v2D2piz2YudAy1Vf0UDp6VafWPdnoLTIaKemGF+FxSZbycxFnBNZFOHw4DB4b3DLLsR
         +tLNC2DcAOTQe4n9WWIBU+NoehX+4PIg1ceJl2EKRyJCXMdcyldNUIiDGXyUASQtK5ZB
         I/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787550630; x=1788155430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4eujiq6V03TrGWMcsHjzyrL4w51Ezbmmle/EXKToc6k=;
        b=CdDuzE//UP9caVtcPoZDhBqhSwbCLbqkwat6XYHilWHA+o7RWul2hi1Mg96eGe8DFb
         66g8JcPMI0+/h79J3rjlhz9uKEzI72O0nRt9U+aXZfUsnsYA7QGQgQJytd0rIY80pm4O
         o3b13QRhQwFjcmtcSOS8pzQz+3qSaEg8GWjDrAMcFpBZrc/3mdcq2fUNQiv+UIWVsOZS
         V+/G1egdRP2mUvH7EHo3nKZl5B/9ORI7cxcexH9sMMpqGVdboYdnR3HEu3G//Rcb3z9S
         Ebsnq1ifd859K++iLzcNv/VpjvVDh/a2bf/ZVXhGY5KJf7OVcknN3dycHTtURGVJVQjH
         FfJA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+UqiXpwcrhdWYEr3HAjPAdiFqcjDUTiUCVhB9UoGVWv2m1Ym0lRsBCegUuhJyJHIdLEzr4E4=@vger.kernel.org
X-Gm-Message-State: AFuF++l8o1yi1WyQI8UeftHFRvsEiqw0bqi2d6zmJdb09B7dfysnQ57i
	qu8K045gT3CYoqZeswFCzicopDvPtMYih90eXw3r1n7d47GlFSoyoDQF
X-Gm-Gg: AR+sD12FCnSLbJwQ3XhUZhsCaK1bKpqiuTDAenBahwOTjI8hQri5IAYXJrvu7R0AJM2
	MNzoSg9jmJy2wjUkno2kgd5LwLpIQsYxQmUWYnArznDsAcblN0pCwzAPkNBuyAHb+OiFmr6rvNh
	t1PPj3yjmAs7sVGZGuOsZt8630UBNXbYlxVse/cP7VXc5iqhXhBJw8rcnjBpuIba9BIINKJ+3xe
	ujE/g/PsxdjYtbZhfOjv8dGZIGtnIDaqXpWPFJE6+dkfPs6Hc7IUnCx8gb2x8YA8xSRDsziq2PI
	MgOpwV+vEwpm3BvHP2FTlETMLjumefeaIeTnh2rA8RIrssC9AvNIHHMCSbfO4Tl0DrF3tOLxtmc
	7j3Tbiz2rJ+y6YvU4Jp9faYu4fSlXQBTJDx6eNoUCEbA8x69ccAOwSkjvUrB8496TMK4IhgkY4R
	L6hO7yONZReGMUdPPocEnnAp3Xoa/wi4VSfibRun+RvMseRRuo1VhHyny3m461YZa7W6Xvgpzwh
	4taFkJdmRXpLzA8lwuDMGJoCWw58PPRRWqNFDIinjWlBlTpFR92F1CmYrAsMNIr3RL+3OrT6QMD
	toBZKfGjbRvNX8kmNdEH6L+eiC64aQ==
X-Received: by 2002:a17:902:e804:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2d670bee7a0mr271595585ad.8.1787550630113;
        Sun, 23 Aug 2026 22:50:30 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768c9876sm13955655ad.68.2026.08.23.22.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 22:50:29 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Input: synaptics-rmi4 - reject a PDT that grows between scans
Date: Mon, 24 Aug 2026 13:50:12 +0800
Message-ID: <2c26d7ce8c6b7371ab55607f53443961220e4b24.1787549234.git.98lawweijie@gmail.com>
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

rmi_driver_probe() walks the Page Description Table three times, and each
walk reads the table back from the device:

  1. rmi_initial_reset   - issue the reset command in the F01 entry
  2. rmi_count_irqs      - total the interrupt sources
  3. rmi_create_function - create the functions and set their irq bits

Scan 2 fixes data->irq_count, data->num_of_irq_regs and the size of every
per-function irq_mask[].  Scan 3 then accumulates fn->irq_pos and does

	for (i = 0; i < fn->num_of_irqs; i++)
		set_bit(fn->irq_pos + i, fn->irq_mask);

without checking the result against the count that sized the bitmap.
Nothing makes the device answer the third scan the way it answered the
second, so a device that reports one function with one interrupt source
on scan 2 and a long list of functions on scan 3 walks set_bit() past the
end of the flexible array at the tail of every struct rmi_function:

  BUG: KASAN: slab-out-of-bounds in rmi_create_function+0x560/0x930 [rmi_core]
  Write of size 8 at addr ffff888110c92b58 by task kworker/1:2/129
  Workqueue: events uhid_device_add_worker
   kasan_report+0xc6/0x100
   kasan_check_range+0x105/0x1b0
   rmi_create_function+0x560/0x930 [rmi_core]
   rmi_scan_pdt+0x190/0x3f0 [rmi_core]
   rmi_init_functions+0xb8/0x320 [rmi_core]
   rmi_driver_probe+0x31e/0xbf0 [rmi_core]

one report per corrupted function object.  The same unvalidated
fn->irq_pos is used again by the set_bit() and irq_create_mapping() in
rmi_create_function_irq().

Validate the position before using it and fail the probe instead.  The
check is exact, not conservative: when both scans see the same table,
fn->irq_pos + fn->num_of_irqs is the running total that produced
data->irq_count, so it never fires for a device that behaves.

Reproduced with an emulated RMI4 device driven over /dev/uhid, and again
over dummy_hcd plus raw-gadget, on v6.12.69 booted slub_debug=FZPU and on
v6.12.105 built with CONFIG_KASAN=y.  After this change the same device
gets

  rmi4_physical rmi4-03: F40: interrupt count changed between PDT
      scans (pos 1 + 6 > 1)
  rmi4_physical rmi4-03: Function creation failed with code -22.

and a device that answers both scans consistently still probes normally.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..c0e91a372eff 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -899,6 +899,24 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	fn->irq_pos = *current_irq_count;
 	*current_irq_count += fn->num_of_irqs;
 
+	/*
+	 * irq_mask[] was sized from the interrupt count collected by the
+	 * earlier rmi_count_irqs() scan of the PDT.  Nothing guarantees that
+	 * this scan sees the same table -- the PDT is read back from the
+	 * device every time -- so a device that grows its interrupt counts
+	 * between the two scans would push these set_bit() calls past the end
+	 * of the flexible array.  Refuse the function instead.
+	 */
+	if (fn->num_of_irqs > RMI_FN_MAX_IRQS ||
+	    fn->irq_pos + fn->num_of_irqs > data->irq_count) {
+		dev_err(dev,
+			"F%02X: interrupt count changed between PDT scans (pos %u + %u > %d)\n",
+			pdt->function_number, fn->irq_pos, fn->num_of_irqs,
+			data->irq_count);
+		put_device(&fn->dev);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < fn->num_of_irqs; i++)
 		set_bit(fn->irq_pos + i, fn->irq_mask);
 
-- 
2.43.0

