Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D613921D1
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653896; cv=none; b=fld8xkWrYJ/3GOpAcE0o+mm7DHp0VsbrPeOfMat58z7aTARu3zZOFXVuXdw54msdTkhd3PEDcGg5Fe6ee7iysLSP7N875l66uGEszGKIwz0r/JINU33C72W/v8AJfWao8EtK+/5xuglySGCRxe6oAJHDLbhol9feBn5CnH4VHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653896; c=relaxed/simple;
	bh=5Qst+fEDdPGOCnJplTLsK3KM3kldbXRhvdfi7PyEUGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY+e1MdqFq91j3Srdpmd115fx+JUVN928qHYOPPZmQdEqAOwcQGFJVByTF86zylVC7jbM5Vy6q1d1Dxwx9oNIwziG+2kXpuI49jrs0fCsCxwy395ij6+0WzX9v9q9cYZnR8g/drGvQN19AAxAWv4jrmjX8CPlubL1/TZ8r1sSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbnyx3IE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbnyx3IE"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso6461416a91.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787653894; x=1788258694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZmdPCfrDSnXxF0kcCEHUxTythGR7yfzC5LrWzS97vcQ=;
        b=fbnyx3IELw1sQW8IkUSKoebvmTSY4BrCLbud3OkzPHBeLIjRWtQ4QlvQQop7J7GoUk
         QW336LGz12ZngVa6kYTUK5fRFynzM11g8aI4uPafGKi3WL3B5+vsjogy81DsizxVLDtv
         QuXLsCf3sUnRnDM59xfeh8AuLq/YkKWymDBTCCA2wX91AScrHB2t+G0ZhcS4S1HhDThI
         zANLCpuyBnLuaWLWhzUIu8GTdS4w8RVqJvzacR/narx3UwzoQyVZIURfXQsQINLmXcoZ
         p4zRTJeIz2naMyHq1WrbgpV2XMAXvy0fBE/P1zUUR+/X2+izO4bqER7QGR3sNxgUq+KU
         RP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787653894; x=1788258694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZmdPCfrDSnXxF0kcCEHUxTythGR7yfzC5LrWzS97vcQ=;
        b=FkQXl6fVcIJJRtcpAUG6Il+Kle2yGSZveEMpZARxhBj0BgCFA5ByO3NXwlF8dcZ3YB
         Y+f6DWSRRA0UTprRMvUw7NoQiP51ou3vQjpCW79Fdlf6JFS6Ov+EcMTE8I021ZpGbOQD
         xMy7WLCmQUmW6WuOqiEZVpAYlxjqz1NmQT/JKuU/p4EQ0xr1tvMD9Q6FieQ6qlgJsYf9
         cZDQDD4n4O1QcWBdYhJisS3bCoKU8tDAcRxXwqYQ1XmYhkKOxPeFJCFg5NLiczcV8Lzb
         Cw6fXr1xaAwGcgwoiZBSXSycmP2K0R3LbSBxYpzu9X2qMYJ886GqumFWACF4qY29gvst
         DNxw==
X-Forwarded-Encrypted: i=1; AHgh+Rp7EpYNWa0R3Gyatp9yvBYDlT6VGEs0Uxqklj2aIqeoGN0vOdVP4AksGHp7L/CYJpc2GBdwky8=@vger.kernel.org
X-Gm-Message-State: AFuF++knoZOARJAFlEU02N6ywfIo9bW9k/NchD27nsri2/rmtro76S5q
	X04zu0yh4X2qQGhb0hLVzXrFzU751xLY7OdzdpUpQL/IfdqaYTBNJ2Te
X-Gm-Gg: AR+sD12K9LuH3L+zTSKYywxlpbq0bEsxbR81BProrm2XkT9b38Slh4A/Q174k813Dp9
	QsZrbjy9zPOGI37rIRgFSdoUeZ29tWvIJqsKJS5uTbQTWduDMZsSb1oDWFhU77VviNiAxheN472
	0IdYG3AJJXIwCR7W6BrablEhQ1Z39rKJ20n69BsBJst/FVaK7Xp+lzXWuYb9Tb2dXhsAZp5Ak+3
	6XqVg7PlewqFU/NkuESUm+BLW/+MAkWOI2V1IIqZ/Vbo7DVJ6TMzTkgmqlvUmQQovcq+NRQhzKM
	3WFE6zwUCO0yd6MpG0BZrUFCM6Z6nO/+gjvH7bOCfxlB4YX/6dDozXX+y7mXFPi9BDWRa/Y6Rf0
	M7UJ+NbZJSNRdIGxLIk9ptcYnYFc+EheLUWL/mDwwQa4wDkAdC7PwtvVCx6BqSIB0kp69sT5rAo
	LtpJF79qRcWS7iH7OFaB57/1XuT/g1YqceScHwt7RDrkDUzO3a1N1+eruUdL5RlcAQ6Gm4lvSWS
	Fz7LaQbRt7L1q3eGNZedP95edlornzaVrcex1ZfkY5FNgF08JRRE7knu+Vv9+32SbPIshNWAOCe
	1HueD2AXKkgLONg+p6jaJXSl
X-Received: by 2002:a17:90a:1c17:b0:396:5f7f:52f5 with SMTP id 98e67ed59e1d1-3965f7f5486mr1616456a91.3.1787653893954;
        Tue, 25 Aug 2026 03:31:33 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645d31e8csm3244968a91.9.2026.08.25.03.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:31:33 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] Input: synaptics-rmi4 - reject a PDT that grows between scans
Date: Tue, 25 Aug 2026 18:31:23 +0800
Message-ID: <20260825103123.12216-3-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825103123.12216-1-98lawweijie@gmail.com>
References: <20260825103123.12216-1-98lawweijie@gmail.com>
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

Validate the counts before the function is allocated and fail the probe
instead.  The check is exact, not conservative: when both scans see the
same table, the running interrupt total plus the new function's count is
exactly what produced data->irq_count, so it never fires for a device
that behaves.

Placing the check before rmi_alloc_function() is deliberate.  Since
commit 58d42ec10b73 ("Input: rmi4 - refactor function allocation and
registration") that function has already run device_initialize() and
dev_set_name() on fn->dev, so disposing of a rejected function with
kfree() would leak the name string and skip kobject cleanup on those
trees, while put_device() on the same path broke on the pre-refactor
trees that stable backports target: a kobject that device_initialize()
never touched warns and its saturated refcount keeps the object
allocated for good.  Rejecting before the allocation needs no cleanup
on any tree.

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
Assisted-by: Claude:claude-opus-5
Assisted-by: GLM:glm-5.3
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
Changes in v4:
 - No code change: adds the Assisted-by tags required by
   Documentation/process/coding-assistants.rst.

Changes in v3:
 - Validate before rmi_alloc_function() instead of freeing after it; no
   disposal is needed on any tree this way.  See the cover letter.

Changes in v2:
 - Dispose of the rejected function with kfree() instead of
   put_device().  See the cover letter.

 drivers/input/rmi4/rmi_driver.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 5d49a9021c7d..f66be55677a9 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -885,6 +885,25 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	rmi_dbg(RMI_DEBUG_CORE, dev, "Initializing F%02X.\n",
 			pdt->function_number);
 
+	/*
+	 * irq_mask[] was sized from the interrupt count collected by the
+	 * earlier rmi_count_irqs() scan of the PDT, and irq[] holds
+	 * RMI_FN_MAX_IRQS entries.  Nothing guarantees that this scan sees
+	 * the same table -- the PDT is read back from the device every
+	 * time -- so a device that grows its interrupt counts between the
+	 * two scans would push the set_bit() calls below past the end of
+	 * the flexible array.  Refuse the function instead, before anything
+	 * is allocated for it.
+	 */
+	if (pdt->interrupt_source_count > RMI_FN_MAX_IRQS ||
+	    *current_irq_count + pdt->interrupt_source_count > data->irq_count) {
+		dev_err(dev,
+			"F%02X: interrupt count changed between PDT scans (pos %u + %u > %d)\n",
+			pdt->function_number, *current_irq_count,
+			pdt->interrupt_source_count, data->irq_count);
+		return -EINVAL;
+	}
+
 	fn = rmi_alloc_function(rmi_dev, pdt->function_number);
 	if (!fn) {
 		dev_err(dev, "Failed to allocate memory for F%02X\n",
-- 
2.43.0

