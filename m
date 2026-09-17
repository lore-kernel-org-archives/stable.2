Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9A4E3769
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 19:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673942; cv=pass; b=n1zNI664pWHvLbmSpFOZ4yShhuTaVCmg4/dE9Dvxmz+RPE9jkeg8TaSLnoKtE80HgX4hzmVlwaHPN7i1kXuiF/Umzc+D3rRmQ7ky6AqxTuN8ffgmQzseMNshbDmLCOeCNbSQl6gIzHHoMdd8tj/nsh3uVeuOeWdOL0YQdwUwnuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673942; c=relaxed/simple;
	bh=+JojRhYj4z2/5FlQFeoDBjlhoDkwm7cc/v/3Femf6qc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sCxIjNJp49DUSfMRfYDnvsTz3W0Z+nMQ4jB4SRG17a6m4ePewLBvoDiQlGehSTKAmt4yiU5hl3lc2It7yxQXfpk+RU14U1tzN6xiBkwTaZUfzbuJ3qlz8+maK36fIbpCrfjiOfZeivLjr3/h9GM3NX7KAA+vXQB9GAF5yw1AW4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmSOc+kR; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmSOc+kR"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ff2313so86899766b.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789673939; cv=none;
        d=google.com; s=arc-20260327;
        b=F8NstGjHpAHPa8iubegEQHrUhdJdzaXFMTqezVnLz/el2SsFt5YsPASrt+E2aOnthW
         Ve0sEFjDFMYfASXM+KMaNlqeKaVYm53dR0E0TECXA1eVk4eSu9EnBQ9dWw+fU3F+Zo6N
         GKKh8WgMrR7WhjOs8k5Tx/xmXWa9o18Fz/ICWWTR8j2a6wbiFe+ev2GoqHwvM60rEieF
         oTmBbUcb1aep3pJ8T9RHeqK1XGYEM9xKzpi+NxVUw3MRMWekGF9VLTIic58H2cK6Z+wG
         AdL2MYe6LsGedCPDkI3QAbXBTu4CDKyUPDH5BYRC7a3mXqqx8VB2mzDwLOONZHStXek6
         45ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uvw66+vhRNvfqBiFRqBkRHWchTeyF82H8c57GCkb5nk=;
        fh=4gj89SuzUsjG4vjqX35Jh/RTFiuKIwsbjJ6TsH9b53U=;
        b=mUQ9Cw+Wy/ENBnqyJIRE/EKnmMZpcp7afnJ3i48zjr27HjjcEugUSaTqmUNlSVqiTr
         qMmX0qlU2fmFQxaTCVencBFLe0n/wgi0OlOMyFf4vUnDwxg2O2/bkWOVLRMT9LNL/XU0
         61pv3lEQyK8KCxeTIuhyzTygRDGMTaJ4+Qu9ZRYVqJDEjcne3JBf4zy8IEKUarKR1kX0
         XwPHgzpoXObZI6UDmu8HrmD5JRna0hIno6hqDnTJwWAYeSQcyClf/mpnueC3816GQGAn
         lLwtZReWWI5l9ja7Mp+DxY5pOf051aoHtLWVS2m198NxwAJnJI3RzOI5A8v/zV5LWhkQ
         Chkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789673939; x=1790278739; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvw66+vhRNvfqBiFRqBkRHWchTeyF82H8c57GCkb5nk=;
        b=EmSOc+kRXc8qqZT8+0dd2nGlKeC1VIHFK6KXrpCLXmjRKVioiWwHTB4VQLI68OdB20
         gnaFlMBpVgf/XHyGV8o9YqswhmGnUnJEYFcBvXf6eunw+FZ+iDSCiFgVJr/+iaYMPHWM
         ESrE5juA6oNwr+OJ0j1yqCvyWVUI7vgIU975MZE+vAlSlFrGe86YCOCcuM48C51eh5Lx
         PKPCLhUfPo1KQgdE3CYE9aX8YVtloh1jq32++B6HYtrnqp/JQzlR5MT8x8NadKBOO5an
         gL1GhwJIuXoHH5GLRL2O+mpZs/yx1oWmp06cGN/fWJV7C5BIRBymobceL8b3znLUfwqM
         tW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673939; x=1790278739;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uvw66+vhRNvfqBiFRqBkRHWchTeyF82H8c57GCkb5nk=;
        b=TboyyleGmQC4ApjcW6r1laPRh4CQUXaZDmd0v6bvBd3M9hx6+0kG97EuKz07a+LVPP
         Drls1U0JbRMZGb21vPRdubfFzzsUTfjxvsWDIMunNsjjhTovmCDcEZGNNXxWznDl+clH
         TiIXXMA/nMyFdvZTu9mEt3EuEUnbVndW4wmuOd0c5pKOo+Ng/ci/dlK5dAyhOThP7qJ/
         p1l9ezdI4MuBfCOaJAnF8lsYSfzCcQdYI3x7elVEQkRfAfn/bPRRy7Kp2bgyGyJ6sZeF
         DQFA2k7WVePNLq1yUbivxHqIK6GwW4UAVCfIkXM2tm73fZNfX0xYwu8nwtVbjYRhE3zH
         gGAw==
X-Forwarded-Encrypted: i=1; AKwUvBwsjg2Frg7yDhu1TcRds5zRgnzPh85w5CCgwx6Jrkedo+iCavkuscT5p5AJzOLycTU2OfiySC0=@vger.kernel.org
X-Gm-Message-State: AFuF++kyk7BSYyjNRKDns7/LGw0KDXUq7806McXp5HrzWOOwnmAqbyUo
	3mL+VQAjAxLmZ108M58alxxiF57fIX4IArcRqwKPWUSBgkSrngLnu3EhtKRo3luaFJXyt34fiLP
	TMdUh+GZHSECpRo8f0vUR2fDtJl7Qhg==
X-Gm-Gg: AYBFou1L2ypGpXiay49zHD9xBY6UDt47Qfiu2sQUK+Qe+qpDXxM4QiTBG8MRkgK5bxv
	KRCEbkpj9hJF3zsmIoDJSm2BqYw//ytQtAWH5sFjh5U4WmOUEftOmKafF/6ZhvGwQo7TL700zHh
	SNLx1yUF3rSfbXQHdjHdrVpuA9LhvxoEAzMizgfIC9dx7grRDAfDTdlup52IayLvyH0tVxyIzLB
	HSc9HszF7RMPTYE/iIxg3PgrGEc8a4bodZKaWJElSkpfXq6CdoAD9f0P4InRcZJ7VMcYZyCuF6F
	+Ose2nS7c5Um5sKq4oCmjVBZWp+saZFA1gO0FiN44XO+rPeQFK4ze5xW4tx/V1THrSgb2lGPp20
	wxVgVkbK1OoEtIE93aEFMOO99smfoJWnByUDmNd7FkUeBZN0boHYeOVC0uMm3bjf+
X-Received: by 2002:a17:907:e895:b0:c29:d0a8:79d3 with SMTP id
 a640c23a62f3a-c2a16555ca6mr12782666b.14.1789673938518; Thu, 17 Sep 2026
 12:38:58 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 17 Sep 2026 14:38:56 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 17 Sep 2026 14:38:56 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 17 Sep 2026 14:38:56 -0500
X-Gm-Features: AcwNN1VE7wb6WhBCZTA5cbiH9rHwbsomzIyYk4514CYjmv-1kzjg1ciyy8BsNrk
Message-ID: <CAGEsz8GQR2vJ8ddedaLg=Yq_RoeTxgoXTQ4-QS8mJpDXNn36qA@mail.gmail.com>
Subject: [PATCH] usb: gadget: pch_udc: Disable VBUS work before removing the gadget
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The GPIO IRQ can queue irq_work_fall and irq_work_rise, and the PCI IRQ
can also queue irq_work_fall. Neither work is drained during removal, so
its callback can access the gadget driver or controller state after
teardown has started, or the device structure after it has been freed.

Disable and drain both works before unregistering the gadget. Disabling
also prevents the IRQ handlers from requeuing them while their IRQs are
still registered. Initialize both works unconditionally before requesting
the GPIO IRQ so removal can disable them even without a GPIO IRQ.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: dd63180b758d ("usb: gadget: pch_udc: Detecting VBUS through GPIO")
Fixes: 637b78eb31e0 ("usb: gadget: pch_udc: Detecting VBUS through
GPIO with interrupt")
Cc: stable@vger.kernel.org # 6.10+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/usb/gadget/udc/pch_udc.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
index 99b3ce28210f..20018c09f6f3 100644
--- a/drivers/usb/gadget/udc/pch_udc.c
+++ b/drivers/usb/gadget/udc/pch_udc.c
@@ -1372,6 +1372,8 @@ static int pch_vbus_gpio_init(struct pch_udc_dev *dev)

 	dev->vbus_gpio.port = NULL;
 	dev->vbus_gpio.intr = 0;
+	INIT_WORK(&dev->vbus_gpio.irq_work_fall, pch_vbus_gpio_work_fall);
+	INIT_WORK(&dev->vbus_gpio.irq_work_rise, pch_vbus_gpio_work_rise);

 	/* Retrieve the GPIO line from the USB gadget device */
 	gpiod = devm_gpiod_get_optional(d, NULL, GPIOD_IN);
@@ -1380,7 +1382,6 @@ static int pch_vbus_gpio_init(struct pch_udc_dev *dev)
 	gpiod_set_consumer_name(gpiod, "pch_vbus");

 	dev->vbus_gpio.port = gpiod;
-	INIT_WORK(&dev->vbus_gpio.irq_work_fall, pch_vbus_gpio_work_fall);

 	irq_num = gpiod_to_irq(gpiod);
 	if (irq_num > 0) {
@@ -1389,8 +1390,6 @@ static int pch_vbus_gpio_init(struct pch_udc_dev *dev)
 			"vbus_detect", dev);
 		if (!err) {
 			dev->vbus_gpio.intr = irq_num;
-			INIT_WORK(&dev->vbus_gpio.irq_work_rise,
-				pch_vbus_gpio_work_rise);
 		} else {
 			pr_err("%s: can't request irq %d, err: %d\n",
 				__func__, irq_num, err);
@@ -2982,6 +2981,9 @@ static void pch_udc_remove(struct pci_dev *pdev)
 {
 	struct pch_udc_dev	*dev = pci_get_drvdata(pdev);

+	disable_work_sync(&dev->vbus_gpio.irq_work_fall);
+	disable_work_sync(&dev->vbus_gpio.irq_work_rise);
+
 	usb_del_gadget_udc(&dev->gadget);

 	/* gadget driver must not be registered */

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.47.1
