Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F624DD15
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270123; cv=none; b=Oaf9rVez4gaxrUo7CS52l7p40BvGuTRLQjOhc9J4TEauq5udsiGel+TCw0pRvCc/XxnGwrqvAyhcCm3PMDVG3j9a1906zGy43RmWnIO1d+lJruXwoHOjNCcJZzDt2YTUAc+7d5mGcSYIywml2tIanaZxqF9FU35q9wTf7wCPkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270123; c=relaxed/simple;
	bh=uJ1TyACt1StjplqJEiWjSNJE5Lljer9Eg9YfoITBpmU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cEfN/q58v9RzN+5bFVhEWE5ffOEGhXjvJ5jk0AezCZdDzgPvweUWf8ZaOWjjhDM5p32EIqQL8OoEVlaAiuWB9QrWMoEAHAiy8l5YGEKnpyk7KxO3jPPVLg59SIK2qlMXKNYrhJPVuZDTO5xfUuLhlIgCgNfGGQa3Vv6uqB5zJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEwzoXj8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEwzoXj8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2c98c1be2so3222495ad.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 20:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782270121; x=1782874921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P0nPpdTf0BpLFBau1M4FC7hfdf3tJ5Qvc7OfGDfoZuM=;
        b=WEwzoXj8EuBtBtcf4f8OBIX2MFBg/fmOaLhTk871UhhJZ0Uj0cpfOeHCY/cEtMBs79
         uR/88HenoBK8vP1BtHq7Nqemb9FfGtU6VgnSFFQm2puf9Mo7tjDEaX9hfwXaMfWpb107
         T2UFhJoul/YoZvMYgNeiLtd+rY1CBeWZdgu1n2RxPoWYWyMW5S84frYSJwviproTWF5s
         55OxyIU2fWcWkeoB4XJ8nqiAwyAVcvkeM4eEvK7mDRBmDFd3/YnfvBrS7VmDr9jgZLsZ
         7lb9fLocKUyxOQo8vRYSE65wkVmA/l0uuVXXRjKZhj3WTRFxE+us8NSzjFVqaDgbv7Nr
         g2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782270121; x=1782874921;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0nPpdTf0BpLFBau1M4FC7hfdf3tJ5Qvc7OfGDfoZuM=;
        b=Hj0oa+2BaXTxKf8aIzNnKrH6pUqg8XNQBHS8YjRtoQjvDMbOWDQdvHLcRfkSDhe03n
         lBTam48ZE1bC2eL5s00UGcHLjOEktwQw0mDZMmLWXaSnppyY6RucHqIagGXMR0gbewAP
         svyt/86/Nbv6DJkgatZkSkmSayYWsVFQ1Q7pc+Nt66BnZOj2OzcVLBHez88IPxZ2USB/
         yqi9EksXfSyCSq67aDRioUZVMLLxAiD36eAV4j4cUmSw3l1tN1L+Nd43Z+grEBSh3xmw
         p/PDTNOnOsCe8OT5Ehj3NrL2Ne8/KRx8s37W9G3OxVc6Qox87fnDVJ+Jkz+BKUs+Y6X1
         /F2w==
X-Forwarded-Encrypted: i=1; AHgh+RpRVUMBmhVuoT5AoZ1UGLw4OPe0DunvgbxldTSOq4Iw7o+tuT+eBgTPhdjChf6eubDZn784RNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoOp/Gm1w9GekjAhOiJwD/n47abn/K8bG6HGw5l/BIZDHIJqLr
	TiCxpuIhETTkhCyQOti6wNcF1IEDh2FxKZrZyFxZz4Oxe6fHHO0z8Q4sU5jr42JIoYhNfjLZo91
	L1C63PA==
X-Received: from plhz11.prod.google.com ([2002:a17:902:d9cb:b0:2c6:a4ed:efee])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c411:b0:2c6:c431:63f3
 with SMTP id d9443c01a7336-2c7e158c8f1mr16473485ad.32.1782270120735; Tue, 23
 Jun 2026 20:02:00 -0700 (PDT)
Date: Wed, 24 Jun 2026 11:01:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624030154.393004-1-hhhuuu@google.com>
Subject: [PATCH v2] usb: gadget: udc: Fix use-after-free in gadget_match_driver
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

Fix this by ensuring the udc structure remains allocated during the
match. To achieve this, introduce a new usb_gadget_release() routine
to the core. When the gadget is added, usb_add_gadget() stores the
gadget's release routine in the udc structure and takes a reference
to the udc. When the gadget is released, usb_gadget_release() drops
the reference to the udc and then calls the gadget's release routine.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
V1 -> V2: Rework the fix using a new release routine in the core.

v1: https://lore.kernel.org/all/20260526070635.839701-1-hhhuuu@google.com/

 drivers/usb/gadget/udc/core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 60340ff9edbf..f8ce8694c101 100644
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
+	void					(*gadget_release)(struct device *dev);
 	struct device			dev;
 	struct list_head		list;
 	bool				vbus;
@@ -1362,6 +1364,18 @@ static void usb_udc_nop_release(struct device *dev)
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
+	if (release)
+		release(dev);
+}
+
 /**
  * usb_initialize_gadget - initialize a gadget and its embedded struct device
  * @parent: the parent device to this udc. Usually the controller driver's
@@ -1418,6 +1432,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_init(&udc->connect_lock);
 
 	udc->started = false;
+	udc->gadget_release = gadget->dev.release;
+	gadget->dev.release = usb_gadget_release;
+	get_device(&udc->dev);
 
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
@@ -1462,6 +1479,8 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_lock(&udc_lock);
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
+	gadget->dev.release = udc->gadget_release;
+	put_device(&udc->dev);
 
  err_put_udc:
 	put_device(&udc->dev);

base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
-- 
2.55.0.rc0.799.gd6f94ed593-goog

