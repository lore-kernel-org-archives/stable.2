Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515BA415F24
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574468; cv=none; b=PZLAzDZGXJogiRIPZ+6Phs2ExqabhgM0eHkLPhqDaB9fjsPA3wHiP3Mg9VRH+XSCNDKvh+elBH9HBuIuxtsH8hG1qy4pCyPGwKANxlg9g3VL2jygfMHLFCuqyZeSoxagQR9kq1s24IBtJPC/Prr5YMhl908LOusqiQyjEKDlPtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574468; c=relaxed/simple;
	bh=C9ljMPmOgKzzGRi9lsltS32itRvLvS7A9iFne2T9euI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSkIOtrPFG4twRnuDv9/nYkAYbALAeH6AWzZssjS99H+AXo5PL9WM4kQeKEsrtOMvQRUyzaX0jqikuRxOXKhcHSIpqFxIqaq3/4OQMGZB+2NW4vvam7n30P9Lji1moxaY21fOO2kukmp+laJVAMtzO1GFcImdMAdBZQJ8MXsq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD6InFZZ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD6InFZZ"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90a6b298887so18536906d6.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787574466; x=1788179266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCP4SoxE8UtElbaGnJtG7fQSm7CuB0xZVB5xSM21nbM=;
        b=LD6InFZZwRepGmXD353W2OKtohFRJRAvrHrV58XM7gacs5SvtttuOzL+H+RVQp109V
         tJm3v+7g694vBv/u4szLqSq+AThHROGsaVctI3BPxC34vEv0v1QwszhNHC2i9BN+1VBo
         mPmcr+xLSQjhejXnA1cNPllAsSAN6MIYCGB79b1XFeoBlcG421iO21S0rc0RmnmNPUXm
         nAdlqScKD0qdGVVp6Nc/okrGRBJG/SnUHz2H/hRwuu/UifZcVHScgWunYMUXfjPG3mIn
         zOcYLX4bIouePG+fv1s3vu0cfj6MBueFbvAY2FOsAWcZZH0Qa8ESosuwbbOte5ZrE6B9
         cetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574466; x=1788179266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCP4SoxE8UtElbaGnJtG7fQSm7CuB0xZVB5xSM21nbM=;
        b=O5SMP3z5kTvioj1grSOHRTswdt6+b3D5abyiXiu04Dh1V4Vmmc2pyvbbxmDig33hii
         Z/PGSRsdsdVEVEThqogZ/Hc2QFG06h6SsSfFRak6e+Taa1Q4mNhSH45aL2rP3IKWS+EB
         wZejh+rs+YtENeB7NZzV4dCrvI8z2S0mJbBe1XdxeeXbDSUQytKNG4A7PTSf7yLpCpMp
         /LHOqqG2Gnz+2ss5sgD58o4m8/WbW+7CDadrjbHm+LDcIhps1hMqWf11t5HDZ3oLV9sY
         CyEyMSyH4HJdAzkv1Z9ws+9WqOESvaJMXbLiAXhYMUgViK+qTx1TWWiiJAYKcjtdeXu5
         dwpQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUBia6u4HvKIP7vnXo+3hjGlwO+MifLl07glDqwVLdMs3C/V8c4V0DmCrueJjBepfZ2jrtiag=@vger.kernel.org
X-Gm-Message-State: AFuF++k/NCvf2mF2Y6ovr1ioDzhlp7t51DWDocbek2wcBW5TTRIG5x6+
	+cJ+7kCvrxg71IsSmLVQmKzoid8lDh+UPMD/yoxZvqJzFOckx3Yh6IB4
X-Gm-Gg: AR+sD13kVQKIF3gTF+zKBXlx3SJ2zjEw8s0TMcKRRGukygsxXNltJpRSNYMG+a4hMSG
	MK9wRSZ9TWwZMSSDn4BgGtkp0FxyL7ur9rvokrRwbEv3LodxWaUDGucADe6AsCoQiRrfuSGA4X0
	ymHh1JxbO7+f6D1tHUX1Qt3BP9RrVEkQwXfXsvuHwDs9Q/Rwu+1ulCcfP3FurKC/SLAml/HVa12
	ldChw8Do7ab8jMEkTnMFAHFXwJpetYZSb40OX26wFRTVhflgj0i/LrDig2vrnSYYqm2g5kSW/kp
	OSaSCRmgyApmRyyovyaunu5n0z6dXIehQRwb0miZTza2jytSHjumof6WDqlpt7p/HWArfvEunde
	rVkuG2u6J3YhPaOul5KfG+nZhHV8P8zkffWM1aD/xjfhBvCUYp9ribjOkX8CygDCj0GN2UjzET+
	0XnsQvPMJGCDK/l1PJVIA96i2MbrTK9FVm5M36u5NR7Ma0UaLpsGdUz3ZE0Tw4tUYMOcosCBCFM
	xr6hHPyyQ52kkMa641RF5X6bFufPx9tTsQucJPDA1kfqMphIzsG0Z3bZga+Ora+kE6hVHmHwW5l
	JRgvAF8vJHhcown2F3ppJkDzpG7/ejV/W7g=
X-Received: by 2002:a05:6214:508c:b0:90c:576a:db55 with SMTP id 6a1803df08f44-90c8fa36499mr169713346d6.21.1787574466014;
        Mon, 24 Aug 2026 05:27:46 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a4f093sm60745276d6.37.2026.08.24.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 05:27:45 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] Input: synaptics-rmi4 - reject a PDT that grows between scans
Date: Mon, 24 Aug 2026 20:27:33 +0800
Message-ID: <20260824122733.76321-3-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824122733.76321-1-98lawweijie@gmail.com>
References: <20260824122733.76321-1-98lawweijie@gmail.com>
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
The rejection happens before rmi_register_function(), i.e. before
device_initialize() has touched fn->dev, so the partially built function
is disposed of with kfree(): put_device() on a kobject that was never
initialised warns and then leaves the object behind, because the
saturated refcount stops the release from ever running.

Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v2:
 - Dispose of the rejected function with kfree() instead of
   put_device().  See the cover letter.

 drivers/input/rmi4/rmi_driver.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..8dcf088a7a81 100644
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
+		kfree(fn);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < fn->num_of_irqs; i++)
 		set_bit(fn->irq_pos + i, fn->irq_mask);
 
-- 
2.43.0

