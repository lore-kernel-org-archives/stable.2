Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C391799F
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114975; cv=none; b=IbmVIyWEyBY16acWrX9uB0hjSNzonrJS8qQnvxXtcZwkZOrQiRL3I08FPeWkUXw/mpzHgeXm/3bejs9HAdcqRRZBdH+gVuZnRTpZYfxWq44mCirtpoMdj2IpGSE6TfTQTvL+llAQUEX5ctsHaiAyNDlnjFRUi7VY0alIkPSPO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114975; c=relaxed/simple;
	bh=aRtEQAy4GVQvegihDE6wZ5Gw13ScymCzctZU1CsrUYA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pLkF1BfkBIti1k4eQucqZAzk+7o3tyx1yNytm7oT79e7Ek4KHWN/QOBB1f9jixXANDl257dOsnzmbquZdi2cfKuQURgJH3ayiRo7o+0I0l5F+c2Lpnc+iTXLHmMsTspAuaBxW1hO+FhxVrETYpskz/pbNPqqpsbbOgEPIsn8VNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OSWxdsGh; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSWxdsGh"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304d0d0b28eso9295715eec.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781114972; x=1781719772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EPx3tvDq4YvY5VSxzLI8mRkaH+YOFS7tBuKwHIzp208=;
        b=OSWxdsGhQ0Qxg6EpidHYo867tTfuig5jGG/we+CFw6C8nR3U/BfdGe5sIiBJIUca2j
         YWgcoJ/62ytJDQ/2YaFMEJ3/PRKD+RWTI8t5MSfEMK3FyaE9AXb41FupRaS14TmRUyaQ
         6oh7p7feOCChU/1PgDfa3AT3GSwtuYO1yxe7jPkhQ6INOdkjwsNPShfGq5aJerAjZQNq
         FYmyI78AR8iw3lKWcwMbeVQadZPtm36Q5HIV5G/u40iiB2tVzg5HARXcpXPx7GtKXzK3
         oL/lJ7uPQPbRnh0uVaav1WOfzlBL36AV7MthTltVAphMSM33L4wNqz/ohtiv48OA+iGf
         qGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114972; x=1781719772;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPx3tvDq4YvY5VSxzLI8mRkaH+YOFS7tBuKwHIzp208=;
        b=Kx2iD1uzkrCtbJVDhJIKrhcYVxTZqrHbSJGv7FOfUYYdwZymEGZETVk3v2ByIwikXG
         FcT/abUa2YSYnCmEhJwOd1CHkCDRCySfZoUkQrV2N3dJQYNzO1vfdrYzmDvzCpuQ0lm6
         08dSYIxRy6dbAZi27k4zIfNN2Heg8DyEpgx3R+g+T0Co+oB29veLotxAFTW2idmjltoQ
         at0V4zXi2Im4UecEktbWaHznPfrjyY3mPpTWyzPyxR8Snj5ri7/15moHFIxhYz45Q550
         xLlNBrwROhRvDU7w0J322ugQSJOVKvIYrYIi/YF0IlZa237VWCaSaSjvusS+2QCj5UCl
         ACYA==
X-Gm-Message-State: AOJu0YwMGa88neBnWbe1AV0zC2dV9B27C44484kGPg+2Z/IJrTQi6nRe
	vMbHIuCTI7ONmP0EKBCecVTfzZXglD79yGDCNi3sRvm1LJS5sP5vo3SqqyOd9U8ldPCYG+dgLV3
	un8QXOaj0m7jCjfCXl9JabXrXPk2kbNmEJKTi/ETRcEpUiiivWiA5PXuSkvmxKhXBZ4jW+QkIPD
	aFKCWHT9WKkgmcvMz5LkPI8JjmVpeklrudL+m8jHyAZKxYyxA=
X-Received: from dybnl13.prod.google.com ([2002:a05:7300:cf8d:b0:304:2d1f:6ca6])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:300a:b0:2ed:e15:c922 with SMTP id 5a478bee46e88-3077b857123mr15207222eec.30.1781114971505;
 Wed, 10 Jun 2026 11:09:31 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:09:23 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260610180928.3093023-1-cmllamas@google.com>
Subject: [PATCH 6.6.y 1/2] usb: gadget: f_ncm: Fix net_device lifecycle with device_move
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Jianqiang kang <jianqkang@sina.cn>, Neill Kapron <nkapron@google.com>, kernel-team@android.com, 
	Kuen-Han Tsai <khtsai@google.com>, stable <stable@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Sasha Levin <sashal@kernel.org>, raub camaioni <raubcameo@gmail.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 
	Felipe Balbi <balbi@ti.com>, "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Kuen-Han Tsai <khtsai@google.com>

[ Upstream commit ec35c1969650e7cb6c8a91020e568ed46e3551b0 ]

The network device outlived its parent gadget device during
disconnection, resulting in dangling sysfs links and null pointer
dereference problems.

A prior attempt to solve this by removing SET_NETDEV_DEV entirely [1]
was reverted due to power management ordering concerns and a NO-CARRIER
regression.

A subsequent attempt to defer net_device allocation to bind [2] broke
1:1 mapping between function instance and network device, making it
impossible for configfs to report the resolved interface name. This
results in a regression where the DHCP server fails on pmOS.

Use device_move to reparent the net_device between the gadget device and
/sys/devices/virtual/ across bind/unbind cycles. This preserves the
network interface across USB reconnection, allowing the DHCP server to
retain their binding.

Introduce gether_attach_gadget()/gether_detach_gadget() helpers and use
__free(detach_gadget) macro to undo attachment on bind failure. The
bind_count ensures device_move executes only on the first bind.

[1] https://lore.kernel.org/lkml/f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net/
[2] https://lore.kernel.org/linux-usb/795ea759-7eaf-4f78-81f4-01ffbf2d7961@ixit.cz/

Fixes: 40d133d7f542 ("usb: gadget: f_ncm: convert to new function interface with backward compatibility")
Cc: stable <stable@kernel.org>
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20260309-f-ncm-revert-v2-7-ea2afbc7d9b2@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Use no_free_ptr() since retain_and_null_ptr() is unavailable in Linux 6.6. ]
Signed-off-by: Jianqiang kang <jianqkang@sina.cn>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/usb/gadget/function/f_ncm.c   | 35 ++++++++++++++++++---------
 drivers/usb/gadget/function/u_ether.c | 22 +++++++++++++++++
 drivers/usb/gadget/function/u_ether.h | 26 ++++++++++++++++++++
 drivers/usb/gadget/function/u_ncm.h   |  2 +-
 4 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 9e9601f12b88..d8ab1adec63e 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1425,6 +1425,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct f_ncm_opts	*ncm_opts;
 
 	struct usb_os_desc_table	*os_desc_table __free(kfree) = NULL;
+	struct net_device		*net __free(detach_gadget) = NULL;
 	struct usb_request		*request __free(free_usb_request) = NULL;
 
 	if (!can_support_ecm(cdev->gadget))
@@ -1438,16 +1439,18 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 			return -ENOMEM;
 	}
 
-	mutex_lock(&ncm_opts->lock);
-	gether_set_gadget(ncm_opts->net, cdev->gadget);
-	if (!ncm_opts->bound)
-		status = gether_register_netdev(ncm_opts->net);
-	mutex_unlock(&ncm_opts->lock);
-
-	if (status)
-		return status;
-
-	ncm_opts->bound = true;
+	scoped_guard(mutex, &ncm_opts->lock)
+		if (ncm_opts->bind_count == 0) {
+			if (!device_is_registered(&ncm_opts->net->dev)) {
+				gether_set_gadget(ncm_opts->net, cdev->gadget);
+				status = gether_register_netdev(ncm_opts->net);
+			} else
+				status = gether_attach_gadget(ncm_opts->net, cdev->gadget);
+
+			if (status)
+				return status;
+			net = ncm_opts->net;
+		}
 
 	ncm_string_defs[1].s = ncm->ethaddr;
 
@@ -1547,6 +1550,9 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 	ncm->notify_req = no_free_ptr(request);
 
+	ncm_opts->bind_count++;
+	no_free_ptr(net);
+
 	DBG(cdev, "CDC Network: IN/%s OUT/%s NOTIFY/%s\n",
 			ncm->port.in_ep->name, ncm->port.out_ep->name,
 			ncm->notify->name);
@@ -1593,7 +1599,7 @@ static void ncm_free_inst(struct usb_function_instance *f)
 	struct f_ncm_opts *opts;
 
 	opts = container_of(f, struct f_ncm_opts, func_inst);
-	if (opts->bound)
+	if (device_is_registered(&opts->net->dev))
 		gether_cleanup(netdev_priv(opts->net));
 	else
 		free_netdev(opts->net);
@@ -1655,9 +1661,12 @@ static void ncm_free(struct usb_function *f)
 static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_ncm *ncm = func_to_ncm(f);
+	struct f_ncm_opts *ncm_opts;
 
 	DBG(c->cdev, "ncm unbind\n");
 
+	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
+
 	hrtimer_cancel(&ncm->task_timer);
 
 	kfree(f->os_desc_table);
@@ -1673,6 +1682,10 @@ static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
 
 	kfree(ncm->notify_req->buf);
 	usb_ep_free_request(ncm->notify, ncm->notify_req);
+
+	ncm_opts->bind_count--;
+	if (ncm_opts->bind_count == 0)
+		gether_detach_gadget(ncm_opts->net);
 }
 
 static struct usb_function *ncm_alloc(struct usb_function_instance *fi)
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 62e2018d0357..49ff3fc62f74 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -896,6 +896,28 @@ void gether_set_gadget(struct net_device *net, struct usb_gadget *g)
 }
 EXPORT_SYMBOL_GPL(gether_set_gadget);
 
+int gether_attach_gadget(struct net_device *net, struct usb_gadget *g)
+{
+	int ret;
+
+	ret = device_move(&net->dev, &g->dev, DPM_ORDER_DEV_AFTER_PARENT);
+	if (ret)
+		return ret;
+
+	gether_set_gadget(net, g);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gether_attach_gadget);
+
+void gether_detach_gadget(struct net_device *net)
+{
+	struct eth_dev *dev = netdev_priv(net);
+
+	device_move(&net->dev, NULL, DPM_ORDER_NONE);
+	dev->gadget = NULL;
+}
+EXPORT_SYMBOL_GPL(gether_detach_gadget);
+
 int gether_set_dev_addr(struct net_device *net, const char *dev_addr)
 {
 	struct eth_dev *dev;
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index 34be220cef77..c85a1cf3c115 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -150,6 +150,32 @@ static inline struct net_device *gether_setup_default(void)
  */
 void gether_set_gadget(struct net_device *net, struct usb_gadget *g);
 
+/**
+ * gether_attach_gadget - Reparent net_device to the gadget device.
+ * @net: The network device to reparent.
+ * @g: The target USB gadget device to parent to.
+ *
+ * This function moves the network device to be a child of the USB gadget
+ * device in the device hierarchy. This is typically done when the function
+ * is bound to a configuration.
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ */
+int gether_attach_gadget(struct net_device *net, struct usb_gadget *g);
+
+/**
+ * gether_detach_gadget - Detach net_device from its gadget parent.
+ * @net: The network device to detach.
+ *
+ * This function moves the network device to be a child of the virtual
+ * devices parent, effectively detaching it from the USB gadget device
+ * hierarchy. This is typically done when the function is unbound
+ * from a configuration but the instance is not yet freed.
+ */
+void gether_detach_gadget(struct net_device *net);
+
+DEFINE_FREE(detach_gadget, struct net_device *, if (_T) gether_detach_gadget(_T))
+
 /**
  * gether_set_dev_addr - initialize an ethernet-over-usb link with eth address
  * @net: device representing this link
diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
index 5408854d8407..297e5087872f 100644
--- a/drivers/usb/gadget/function/u_ncm.h
+++ b/drivers/usb/gadget/function/u_ncm.h
@@ -18,7 +18,7 @@
 struct f_ncm_opts {
 	struct usb_function_instance	func_inst;
 	struct net_device		*net;
-	bool				bound;
+	int				bind_count;
 
 	struct config_group		*ncm_interf_group;
 	struct usb_os_desc		ncm_os_desc;
-- 
2.54.0.1136.gdb2ca164c4-goog

