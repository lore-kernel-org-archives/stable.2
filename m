Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361367;
	b=fvS+aHSFhHtvLb8j4B4mNBu/MZRhYNpNDd+7sOiOKEv2xo0jYJABd7s0JjfSE6TZOUeC
	 Fk/WnBxhMFr0zOJhA23jE8tk6UQiirgvWsSj8LkrKjQckIBKfdZOwbKz3LhTozzTX9lG5
	 97qD6SokjquMjJNIKDBjPk+fl7yavNqdtVFugwQJFqI1bpVNs9+IH06f+ayh5ac6KdJRw
	 O3hXtehymC9xDF/qlPhIoqAVoBA5YiHhhwQizccv+6NH6VerwUqKZ5vY5f2PUdsRkwEP9
	 GU7fg9je79G07YaND8uko9RcDXGz8cpGI6CFt25CuovRUD3k+KSiHIZrh8HxTR3+QAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361367;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LWulNEi7OnC7ab/AWpVRlKXxCTgfElN1f2n9XM4xApg=;
	b=XUdNBL1piQAg0jVIpth8WUvRvNGGU6EJyrPg1qn0iV7jfVjFW+B1z3YMYahfX1MkUXOX
	 UJFqPQ8s/OvegQYusALCHFnbovdN7l+G0EaJXCqBL4FvxQYkaNoJp+zfaVjFqLuYyfGZB
	 mGqZuCEUl0V3cSwbBmx+2VnTRbn4bktnUSo6uUFk27ObcUAipTPd9CLMljOfJ/5uAma6s
	 AfzTj1l9vyca1d9JuP0qtxOMA8q1V2pJ8cu5QJo3v4e3bsyVEsDcykAqy6JrTxWfMVcL3
	 iTc3buT+4zX2kV+Xi6dJ8tHbQ9l3SIIR40zuNJLqm2Q/wB+GW4nWkmwrKTKdzsATeEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Npu08he3;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860AF606A31A;
	Fri, 30 Oct 2026 11:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 860AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Npu08he3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=LWulNEi7OnC7ab/AWpVRlKXxCTgfElN1f2n9XM4xApg=; b=Npu08he3rfSFuPQTQZVoSbVBzX
	4zwwSs5VKNB4bLEGYG+nrMdxNfImqgujMZeA4sL5AM+IYJ8+789qh/u2xjg+7scbv0Mh8gFYhxIp2
	WMEcDjP+iY+UIoZ/ZkuTWJdYdvsjtnoTRhOM7yK9EEA+zA8OS/EZz3U84RgOOJlVRgCT6jOpQbGUX
	SWJmHu8ST5oQMO3nQKyv1B/yZm24kqlWm7G2ZAXNVb6CAxWI8rATod5dHLfY4WutTimw62tESxlRd
	lnNAPsO98aYz37M9xiyCSZi6vL+rMC5+EuQQECq4DyfmNgAmW887H19DhYwIWFinyF0FriIfc9Yh/
	xCYPOcuA==;
From: Heiko Stuebner <heiko@sntech.de>
To: linusw@kernel.org
Cc: heiko@sntech.de,
	chenjh@rock-chips.com,
	linux-gpio@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: rk805: fix ordering of gpio and pinctrl registration
Date: Fri, 30 Oct 2026 12:55:40 +0100
Message-ID: <20261030115540.3660242-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The call to gpiochip_add_pin_range() binds the gpio-chip and pinctrl
together. devm_gpiochip_add_data() sets up the devm action to tear it
down again - and this includes removing the pin-range.

As devm teardown is running in opposite order, when
pinctrl_remove_gpio_range() is reached from gpiochip_remove_pin_ranges()
that pin-controller is already gone, leading to something like:

[    9.703366] Unable to handle kernel paging request at virtual address dead000000000108
[...]
[    9.703553] [dead000000000108] address between user and kernel address ranges
[    9.703573] Internal error: Oops: 0000000096000044 [#1]  SMP
[...]
[   23.237380] Call trace:
[   23.240120]  pinctrl_remove_gpio_range+0x28/0x60 (P)
[   23.245687]  gpiochip_remove_pin_ranges+0x5c/0x8c
[   23.250955]  gpiochip_remove+0x144/0x1c0
[   23.255350]  devm_gpio_chip_release+0x10/0x1c
[   23.260239]  devm_action_release+0x14/0x20
[   23.264834]  devres_release_all+0xb0/0x120
[   23.269430]  device_unbind_cleanup+0x2c/0x84
[   23.274221]  device_release_driver_internal+0x1ec/0x224
[   23.280072]  device_release_driver+0x18/0x24
[   23.284862]  bus_remove_device+0xe4/0x19c
[   23.289359]  device_del+0x14c/0x40c
[   23.293273]  platform_device_del+0x28/0x94
[   23.297871]  platform_device_unregister+0x18/0x3c
[   23.303149]  mfd_remove_devices_fn+0x130/0x14c
[...]

Fix this by reordering gpio and pinctrl addition.

Fixes: ea479996c79b ("pinctrl: Add pinctrl driver for the RK805 PMIC")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/pinctrl/pinctrl-rk805.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index 22f576337faa..8e04da3ef0f3 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -663,13 +663,6 @@ static int rk805_pinctrl_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Add gpio chip */
-	ret = devm_gpiochip_add_data(&pdev->dev, &pci->gpio_chip, pci);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Couldn't add gpiochip\n");
-		return ret;
-	}
-
 	/* Add pinctrl */
 	pci->pctl = devm_pinctrl_register(&pdev->dev, &pci->pinctrl_desc, pci);
 	if (IS_ERR(pci->pctl)) {
@@ -677,6 +670,13 @@ static int rk805_pinctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(pci->pctl);
 	}
 
+	/* Add gpio chip */
+	ret = devm_gpiochip_add_data(&pdev->dev, &pci->gpio_chip, pci);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Couldn't add gpiochip\n");
+		return ret;
+	}
+
 	/* Add pin range */
 	ret = gpiochip_add_pin_range(&pci->gpio_chip, dev_name(&pdev->dev),
 				     0, 0, pci->gpio_chip.ngpio);
-- 
2.47.3

