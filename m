Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E813B38B8
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 06:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638241; cv=none; b=ipuOUptucggLIaXkbr12snW57BfN2sfeDm+HVWd1MhM1K27ISBBxDiMkw40Yu7vHqwHjW4/zBeM2/VeWhPmJq+ye7xanX2opKMUDn3PASdzRq5Tcb5WKdm/lP31klp7hFzsrwl8nQuwsoCNocN7mCZTvXLAjiG1xeq5ahpwFcXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638241; c=relaxed/simple;
	bh=rcJ76BI70FS7sW5RbzoZTkgt+KpJV9f2V/JttM8vlBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JB2TqrRPuuBcCsQVfE40Qgdhh++KDBO6ZOQj7HxzR7UqW1EhIPkiqNQlkPH7WOVrLqWDqyqno10zaTu02z6GAmCnr3Q9Bx+17GPhM5ZxGouHv6BXq5tPLjWNEgrjBOcYj3CjBri3ht7ktHcmHyZvQSvbbMuVkzjKIdgeCLxW1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl7CLEqo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl7CLEqo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6d28aa26cso8069615ad.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 23:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787638239; x=1788243039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6bumZFW7wx8mN2lBfLuzrWtTAkjtdW9StYLJpSBfIE=;
        b=Bl7CLEqoOtX8YvduOcDGHFiXBk6fP3jzosjWJsXZ2Cjbee0Pn/jQWzlDshy9mgqRAN
         b+fXS7k/SF0PrYXh9YfnUit6Fu+bn9de7s/S+CeFnhOi1rhvgHce+Z0NpIjtDZl9KZBp
         omeeiVIpTiorIaL3v06BlrYprUiYauD60XJO4UhryqjIgTxOm39hJ3ywbD8jjyJ0SEWl
         v3oiPEQqtxVu7kqwahmDk+mo/bu0YU9ffDRbGLayTesEYO+thuY7J7Esg5ZQFf/OVbbF
         w4ABqeuM7voOLvNEjOgi1o/NJY5IFUrHQ8fSCVQ3iNnecF1Gd5WZUnvqflot0jhgfhRK
         gjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787638239; x=1788243039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P6bumZFW7wx8mN2lBfLuzrWtTAkjtdW9StYLJpSBfIE=;
        b=T9z/SVfGAAkNDk3bk/eeZfaOGPD2ldZ2Lbb6cOvtFCQiNgarLTkgo6njMPvRpbUGHG
         vKcNQDjLoJHRMxM8fktg3V850VtAYyq/vdqqtIvkaG5OTVs5EZjU9/tWVSCxVyxSTKr2
         a7aCyH/9dDcaJUEHgEjtJtZQl8dcF1s57Gf3LvHuVAkTz6/vYvEWLL9iKcnQXB6A9EJ0
         7qr3tuS504AxpkSzUseMRTB3dLV1HPkZukuhOufnErgcOcBrNmFtLQsbzFdtFH98gcXb
         3K71CQVZmFWcGcSujA9LrnbYQ+pad6UNGyrkFRQrNMCx29A8aDfW97KtH2Wh06Hw3dJC
         vmsw==
X-Forwarded-Encrypted: i=1; AHgh+RpMv75lCOirKLsxNu8uCIijPYmzMYWq9BV9K5Jpwz2T+A9xSkJ3RPs+C7CCGypfePn+BQ6Icfg=@vger.kernel.org
X-Gm-Message-State: AFuF++kv4cEahGcrkHfAB6EhU4FUT8Gonc5wDQzxI9PEngCqW48jl3HD
	F0xsgrHia5ETaD1MuRnHgfDdJu1GAxBQZ6ObgQg202Fn4SbL1bKpPMFt
X-Gm-Gg: AR+sD10NGEbgHGW0aLFkoxTca1eCXsHjcelhmq7u6U9R7LbGFp+kWxMuUznm7UD32wp
	KT9YE/AMBv/3DvDVxIfZ4HppKSSZt5yY2J5dQeac5APIq6ZVjParxSM7Eaqk9ToHy06Qe5L4Jl+
	Zp3xWH40y978E6t7kg2xBPQyeuM8RalQjE0tOu6X3bsV1fQ6dugHsAmwhwN+ytFmy3ssxPbcCul
	Jtzw2z8obtMSSuaOl82RYKuLo43LTG75Vrgze/JJEo4aCivyrOJ1jlEEHzw6ACURcVAmwaxk3Sb
	yX5772F3f0xfk4cbFMEdcVIJ7qD3my2SiasjCWIZSlVhb/DBODMj0VWHogHKPgpt89et3slqzkf
	qQ00SyBtabUqUKMylRrqr/0lyxrf3gelfz6mn5SVvFtIYRtsrR0FNWEP1Wp+T/GRJ4t024eCEIG
	px4a+6rttCNsq+CUvY4D12eiZs/TgJuT7fCyP8/GPAcw8ZZJw37Z+XvIHZgr5ADPjeG9a+4j86L
	jK0A4mEg2NzuSc5Dokgar9mOtrktZkVPoxKI/L5DVXcRp4T6BZ+1inVJMFD84lSSgT5rM4y8sne
	3NTnMiCylBKLcQSNbVrW/XeoM5QrhdzVOCY=
X-Received: by 2002:a17:903:1843:b0:2d3:78c2:1f19 with SMTP id d9443c01a7336-2d6dcbb1806mr83496075ad.9.1787638239035;
        Mon, 24 Aug 2026 23:10:39 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676408147sm23954825ad.0.2026.08.24.23.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 23:10:38 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wei Jie Law <98lawweijie@gmail.com>,
	Andrew Duggan <aduggan@synaptics.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] Input: synaptics-rmi4 - reject a PDT that grows between scans
Date: Tue, 25 Aug 2026 14:10:27 +0800
Message-ID: <20260825061027.105062-3-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825061027.105062-1-98lawweijie@gmail.com>
References: <20260825061027.105062-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

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
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
---
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

