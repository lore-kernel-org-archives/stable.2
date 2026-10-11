Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00569409613
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791707865; cv=none; b=gzZgH594BhoEp0Z9G1rwQieIsgvaJ/Na1qTEJZIfpjIeJQr8SJlcsyAP5rXa/pyTI/dw8gaNcz6B0J707UOtQMtL5EGnvgIFI1VIN2XL2gn0DLWawNm4Ck14AabM/ixZ3wRNNmpg1nkEA5/hw8rSFfp7KMXtzlLbuVWvHaXhDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791707865; c=relaxed/simple;
	bh=AG9KYqEAuBrC5cVUj2Gtfc/xyb1PbumNIgtY38YvP4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6e7HZiuFVh4JidD1eCp+gGgRtKaLVDcw+/i8yGucbfrf6HwKhkqZE0ahw/Jtwdsk716mqJhHiXq7zKojNjZGrbBn5X3fzVgqxST65g43L44ba8CMbiMluxKqCZOXWlH4VhdSHqc6JR8N9+LYQmiQJU3T6r4IJvc4rNWuWRmAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD/Eceub; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD/Eceub"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-16ad92569b5so867500c88.1
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791707863; x=1792312663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NH/6OaijL4k70kWtU4gX45/jYXFxMDPWyBg48ckR6HQ=;
        b=VD/Eceubty7HZmzF7szOIhfPW2i0IHPoLQl+yd3Kwsv1N6/e5BpZ6hOpzJ/RWdjoN2
         NoT1Qn55IZjvioHjTj1mGHithnErd/mSz/pPwYy0WYY/UsofLCPxjCQ8+qeqkjxvo/xW
         xjupnpW8mHBSvg6OUhHhEq7N/hStF1IZgOzOgO69EQerRunRpiZeErTLTbcnraGkdX+y
         AFZxOz6Q5cWLugEcb8LL9u6Si0GYiSfwN69KUZ9rllvKCSHon/E+OrE+IZAnrK27h/IG
         iHYruQrskayMaPbFJaGArCky2bpkd8Zr/d1L/A9nUXIaTL7hiiVpLwq8BQnijsDTe69q
         g6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791707863; x=1792312663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NH/6OaijL4k70kWtU4gX45/jYXFxMDPWyBg48ckR6HQ=;
        b=1w/wucs4klHWPRvWdWbWeQU8xtQwV1gluPnJuomHpgMpBOBdTMOySzIJiXJX4Hf8iu
         wA8+5JgA34YMRj9nh2yAAooX2dS9yDGQG8eF6xXFn2EwjgBLfpEVX+KZcqeksGAt/PqV
         TO+KoqrL2rjpBM/aD+1jbinal7HwBbQ2Un9Df5TN7vtf60llJOps1/CxkzAfJ/J+uphT
         UGubhT9wdhcQi41T2v8edOdv2K0cmvMLPfeRNCq1NlXpR8XvWJwqEjYT8D0l0EVuKgW1
         pRMFfQnW8KGtOepGD3Qns07Iw5k/nnKuNQqxHMIhRpceoqfI7XN4SPdG5D7OB//pjzIf
         poZg==
X-Forwarded-Encrypted: i=1; AKwUvBwbjqV4NZ3AGaabpKPIdsCXz24L0flVNs01XdFzZ7T+pqhL6nNxVhaRfL1yglnk8BIQosEcHOE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8qJoy6sr/n++fNYU0uP9YP56jrENjIQ+nvLQ8oGzzkqKjfVJw
	O600a+P9/jZWpCsK9EyxQdRLVecK1stVo/6ejhoU2Mr1jv4kD4awy28R
X-Gm-Gg: AYBFou1k+ZKh+Zpzk3MPxqYNpHwPKnfXCKOosue6cX3es1WSMH4WrtZWXLAAvvfVaKW
	tJEfC82sSvWJ62/n8Beqq+HIGTLisVnwTS06PKhgPdNIoEJkLacegZSulAHAkOk6zwGNAZHXMYi
	0TwKnU10bbtmUbI1hWXMFPKXoQE/ou/JtWr3oau2KFB+umrrSfAfWxiYkFutb/mjXut4KfyPvDi
	0eaLJTGLdbOO3htcxP1xULwGc3xoTwQo9zWwnVjE0+XDo7/XfpGPYwnryDrvFeglxABqj3hFYqH
	b+vm/dHvXWzqmJWFsR9RhEWhoB7lj5R8gpOHc6v4GWUZLYZZcn7kEYoOj+kPs53hEwp/KRfoQko
	RpbUc+zglKrp2aVkvXs7AUaSAIlP10m1Es5zlxcDSGYJTelnY8T0eQP6r8VNyohzSHvx3IrVn4e
	Y6SdJTUYNihcCo9yyvSmFuX+tAYfA5i/vsibrWrwJm99jzoTTmtjtGC2jT4pX1nH4SXBb60qhC/
	M8Q6GvbET5k/GXaRXh8vgqgMbnRiUvWM0wW0oKLh9fn6b5hAbJCnymuwpUdoJpWOsrbiVsYQuvs
	EF7r/Sc=
X-Received: by 2002:a05:701b:4183:10b0:144:e535:3ef6 with SMTP id a92af1059eb24-16a5ec48a2bmr9056982c88.41.1791707862819;
        Sun, 11 Oct 2026 01:37:42 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a42407e7sm20186473c88.15.2026.10.11.01.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 01:37:42 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v5 2/2] Input: synaptics-rmi4 - reject a PDT that grows between scans
Date: Sun, 11 Oct 2026 16:37:28 +0800
Message-ID: <20261011083730.223083-3-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011083730.223083-1-98lawweijie@gmail.com>
References: <20261011083730.223083-1-98lawweijie@gmail.com>
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
Assisted-by: LLM
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 443ba4106352..b2ed5991b197 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -898,6 +898,25 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
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

