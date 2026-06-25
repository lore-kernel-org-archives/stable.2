Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B440D595
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373031; cv=none; b=BcFExLLO1Z3bwnCdSsB5i8Y7k+c8gAXxOIj6fpO8GCis4cyR50fe3K+ehYbln23BoJ2pG3RnIh39AmshtVOcWJ/bSxVKu6/OUFckiUKKdIj5bsRX/rnWAmrVu50/l4gLoHFIdRwH2axyiW88OTAsFwvyx5LEZaZ+t0gb34rIfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373031; c=relaxed/simple;
	bh=qtJs5dSr3uuTMIQk1NnKl6/UfaB5TXjmnhl+hP/Hr7g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cGJSr0d1LFFCX/NdrG2ASdlfnPuRIAyEWobMpJSSLmSPI4jfq77UyHRVuDNodpMYvCy2ZLyULbdPWFgnuQThkz9HY3PMaBiWVeSN15V35cN9FJeGnuDPdzJLk7Q1tN38pMU0YD87FvmDLN698l12o0A2CyB2fpBT2X/Ltn9ulX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iz7ihivv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iz7ihivv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6afd85980so17143145ad.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782373029; x=1782977829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SX67yclkzmmBDtonEZbrN41wbSvn/f3i0oeJKvB35j4=;
        b=iz7ihivvHe+m5LhI42QTz5PTm0Z1wHKHdZWM4dWgwh959HCOEg8cRSjq87jDzrlezW
         QyehaGQvQMHlwkdolhkPc6tEN5Minv2bz/YpyVJj16hl7omHonCP7KIMxjsYP9RUTkKC
         FHO7iaCEzBJWk4bmKuG3YdGhCV3i8KqomLHQjvk+iKDKu2lCPgWdXbfCigujL/qyzJ2j
         ZirMBnbldM2xPJU0tO6ytoGUUl4DyMzCzK578JwADJZkLgP3o/igWrKz8nqd/Pnv2lBc
         Qu6NZpXawaUZSrladjJ9O4RPlWJ8AkOis4AJg+vun6+rrHIBOr7Ek8Z8bPrgHyxucioI
         qiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373029; x=1782977829;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SX67yclkzmmBDtonEZbrN41wbSvn/f3i0oeJKvB35j4=;
        b=gkAU4h8RV83o0/I730V0TxzBmyVMyQ8Tpz1p+p0Q6+liQt1lZOF045d9OJLva63Ytz
         DrhQroJ3ulqc3AUl1x4U9qHLWrloK4e4gX4tJgafJE5AtJOq8nXyIALhACLPLdfrkBoG
         oAexBUMkz7cWSdWZoZQ//dXggvoditm2jA1spKYQWtioHXtYPWoM3YDvPShuRrZ0ApKV
         mjpp1qECLLMrX1rOFEJdqDooK14k66CvWyeDCjtSfg1Jd3OIDyPHsRr6pak/aj7RlrfQ
         Wwwj/JOHp1BKn88hmLVB28a6ZpR2v9Y4zP98IpYnRr7xndkM4zB15XqKFQ9dG0kNIJaK
         /iqg==
X-Forwarded-Encrypted: i=1; AHgh+RoAsWjTJY7xDlCrU5LtgBoXEfFr/Ioc+WeBaFrIED349yodUxVK6CGmSlNXgmgilSKkIsi6FOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgqYErN6gmrq4Fjtz0TqoZXugNGnwIJJxRxv0aO/EbGeke0uF
	RrLBsKoepX4JqkPphJqMVIbkpL1CvrCXuq3/OoqWH7MSCrWpuS+C6Mkhom+xTxYHO0o9sVURXqf
	L5UfqOw==
X-Received: from plbmp16.prod.google.com ([2002:a17:902:fd10:b0:2be:fea6:e21a])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c8:b0:2b0:608d:d8a8
 with SMTP id d9443c01a7336-2c7fc7098e9mr14432455ad.1.1782373028838; Thu, 25
 Jun 2026 00:37:08 -0700 (PDT)
Date: Thu, 25 Jun 2026 15:37:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625073705.803880-1-hhhuuu@google.com>
Subject: [PATCH v3] usb: gadget: udc: Fix use-after-free in gadget_match_driver
From: Jimmy Hu <hhhuuu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jimmy Hu <hhhuuu@google.com>
Content-Type: text/plain; charset="UTF-8"

The udc structure acts as the management structure for the gadget,
but their lifecycles are decoupled. A race condition exists where
usb_del_gadget() frees the udc memory (e.g., via mode-switch work)
while gadget_match_driver() concurrently accesses the freed udc memory
(e.g., via configfs), causing a Use-After-Free (UAF) that triggers a
NULL pointer dereference when the freed memory is zeroed:

[39430.908615][ T1171] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[39430.911397][ T1171] pc : __pi_strcmp+0x20/0x140
[39430.911441][ T1171] lr : gadget_match_driver+0x34/0x60
...
[39430.911890][ T1171]  usb_gadget_register_driver_owner+0x50/0xf8
[39430.911910][ T1171]  gadget_dev_desc_UDC_store+0xf4/0x140
[39430.931308][ T1171]  configfs_write_iter+0xec/0x134

[39430.957058][ T1171] Workqueue: events_freezable __dwc3_set_mode
[39430.957287][ T1171]  dwc3_gadget_exit+0x34/0x8c
[39430.957304][ T1171]  __dwc3_set_mode+0xc0/0x664

Fix this by ensuring the udc structure remains allocated until the
gadget is released. To achieve this, introduce a new
usb_gadget_release() routine to the core. When the gadget is added,
usb_add_gadget() stores the gadget's release routine in the udc
structure and takes a reference to the udc. When the gadget is
released, usb_gadget_release() drops the reference to the udc and
then calls the gadget's release routine.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
V2 -> V3:
- Fix column alignment in struct usb_udc.
- Remove redundant NULL check in usb_gadget_release().
- Add comments explaining the lifecycle override and error path cleanup.

V1 -> V2: Rework the fix using a new release routine in the core.

v2: https://lore.kernel.org/all/20260624030154.393004-1-hhhuuu@google.com/
v1: https://lore.kernel.org/all/20260526070635.839701-1-hhhuuu@google.com/

 drivers/usb/gadget/udc/core.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 60340ff9edbf..f6da12b553a0 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -31,8 +31,9 @@ static const struct bus_type gadget_bus_type;
 /**
  * struct usb_udc - describes one usb device controller
  * @driver: the gadget driver pointer. For use by the class code
- * @dev: the child device to the actual controller
  * @gadget: the gadget. For use by the class code
+ * @gadget_release: the gadget's release routine
+ * @dev: the child device to the actual controller
  * @list: for use by the udc class driver
  * @vbus: for udcs who care about vbus status, this value is real vbus status;
  * for udcs who do not care about vbus status, this value is always true
@@ -53,6 +54,7 @@ static const struct bus_type gadget_bus_type;
 struct usb_udc {
 	struct usb_gadget_driver	*driver;
 	struct usb_gadget		*gadget;
+	void				(*gadget_release)(struct device *dev);
 	struct device			dev;
 	struct list_head		list;
 	bool				vbus;
@@ -1362,6 +1364,17 @@ static void usb_udc_nop_release(struct device *dev)
 	dev_vdbg(dev, "%s\n", __func__);
 }
 
+static void usb_gadget_release(struct device *dev)
+{
+	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
+	struct usb_udc *udc = gadget->udc;
+	/* Cache the gadget's release routine to prevent UAF */
+	void (*release)(struct device *dev) = udc->gadget_release;
+
+	put_device(&udc->dev);
+	release(dev);
+}
+
 /**
  * usb_initialize_gadget - initialize a gadget and its embedded struct device
  * @parent: the parent device to this udc. Usually the controller driver's
@@ -1418,6 +1431,14 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_init(&udc->connect_lock);
 
 	udc->started = false;
+	/*
+	 * Align decoupled lifecycles: take a UDC reference to ensure it
+	 * remains allocated until the gadget is released, requiring an
+	 * override of the gadget's release routine to drop it.
+	 */
+	udc->gadget_release = gadget->dev.release;
+	gadget->dev.release = usb_gadget_release;
+	get_device(&udc->dev);
 
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
@@ -1462,6 +1483,12 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_lock(&udc_lock);
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
+	/*
+	 * Revert the override and drop the UDC reference to prevent
+	 * leaking the UDC if the gadget was statically allocated.
+	 */
+	gadget->dev.release = udc->gadget_release;
+	put_device(&udc->dev);
 
  err_put_udc:
 	put_device(&udc->dev);

base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
-- 
2.55.0.rc0.799.gd6f94ed593-goog

