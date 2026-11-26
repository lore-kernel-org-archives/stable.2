Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711873;
	b=OH6JK5fJ7Rrp2YDB1tm1IthAdy1AmjOBMU+sS9Jec4UnHbNgQCiuUc3shanpt2fO4WHM
	 sz7/I6k6jkpWOwpg3IVUrov54jcVeSJD4xEkNZ6Y6K0JysZF2kPQzsJnfdtk79pM1IuIP
	 X+Ju3e/vTFXL8Sf/g29z80nGAv9867n4xCWAVbdSsScrrHy2KrUGNAC5r0HxhzOp6gsjM
	 Qw/kpr5bjKKKqbezJ+whBaD9q6UDzcFEpl7jbKJq1ZuIUozSS1O00QlVpuUdC5XVk5W6I
	 1KzveHCFOQxrEGI23zw4q2PcEImJP/effVbchdq9k0golHmHYMgT3YzLPyI9UscAkmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711873;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U3lViUySiCWjAmyDouvBxMLaL8kzcrr7NIjRbn5kDkA=;
	b=FRUOi2Z4fgFuKWYcU9TopGtv5BbR9G4qzkdXQFlxwSHJ0R9TKQrT1xu78Q0KF0Oq15M0
	 VwaLWZIslM8Qzbha+PEFXDZDdgVdKH2Qdl4xwLnAYxDNswCCFXArkOg6SSJFd7IXg7GC4
	 IUYMJSzQyFpUuHYFEvJZ12SAOIeNcNoY3NCuIaK3FkgWUfWQ6FhNEV/3FPJp92yF8scFG
	 QL52DnQz7MKNoh4rx5WoGswazxIRT5rTrlKZsJ+IkgBkLTgj6rBYR9A0FlmOo8LUX8HJs
	 +xpE5JccUWCQzsBdTyMr7HTau+okGwa6fZQUgg/Amp/nNssaOOjGXQ7IkLWuBiMxy2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bE2d6s/w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B03606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bE2d6s/w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE7B1F000D0;
	Thu, 26 Nov 2026 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711873;
	bh=U3lViUySiCWjAmyDouvBxMLaL8kzcrr7NIjRbn5kDkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bE2d6s/wo59VrW43WLFpggMu0VAALqk920Fb1N3FYxYjp6RkzRab0mroN8eGfWu2a
	 jsFWXVGJK7BT93GG8nsbpye+VK4R+RBr9c3/CQRPLTK0MDNbC2RSgAH7/2Xuv/1mot
	 TrdM/5R0JSEHoxH4bN1Ws2mPlxYKbUuLnFkHS2gb/Hicf3Y9oq0Xe1JP2y3CG8dMF6
	 CEzU4swgVZnuVe0cu5bU7EpkYP7P038XI7oJhqDIgwJ/iypUHU1rINFJ/DR0pbzxFB
	 JLUGmb3X5rWPljLA0cBHRoPnZ9GBjaUdO8vDf0+WkjEdX5nVDJUwrE0bs7x2/4qoD8
	 oHS9BRYV/2eug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	stable <stable@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] usb: dwc3: xilinx: unwind ZynqMP platform init on probe failure and remove
Date: Thu, 26 Nov 2026 11:51:08 -0500
Message-ID: <20261126165025.2602010-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126165025.2602010-1-sashal@kernel.org>
References: <2026112512-disfigure-marmalade-b2e1@gregkh>
 <20261126165025.2602010-1-sashal@kernel.org>
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

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

[ Upstream commit 6c6508e742b47539224eb18cb23f7ed5d401dcb6 ]

dwc3_xlnx_init_zynqmp() leaves the controller out of reset with the PHY
powered on, but nothing undoes that if probe fails later or when the
driver is removed. The resets stay deasserted and the PHY stays on with
no driver bound.

Register the teardown with devm_add_action_or_reset() once init has
completed, so it runs on probe failure without the driver having to
track how far init progressed. The teardown only undoes the reset cycle
init performed, so it carries the same usb3-phy guard: with no PHY the
resets were never asserted, and asserting them could break a USB3
configuration that is live but missing from the device tree.

The resets have to be asserted while the clocks are still running, so
both the probe error path and remove() run the teardown explicitly
before gating the clocks rather than leaving it to devres, which would
otherwise run it afterwards. devm_release_action() unlinks the action
before calling it, so devres cannot run it a second time.

Running it from remove() also covers .shutdown, which shares
dwc3_xlnx_remove(): device_shutdown() does not call
devres_release_all(), so a teardown left to devres would never run
there.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable <stable@kernel.org>
Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260928120015.3152461-4-radhey.shyam.pandey@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 44 +++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 103a9e6ef35c4..63b3ef205085e 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -99,6 +99,39 @@ static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
 	return 0;
 }
 
+static void dwc3_xlnx_zynqmp_teardown(void *data)
+{
+	struct dwc3_xlnx *priv_data = data;
+
+	phy_power_off(priv_data->usb3_phy);
+
+	/*
+	 * Undo only the reset cycle init performed.  As on the init error
+	 * path, the unconditional deasserts are not paired with an assert
+	 * here: with no usb3-phy, resetting the core could break a USB3
+	 * configuration that is live but missing from the device tree.
+	 */
+	if (priv_data->usb3_phy) {
+		reset_control_assert(priv_data->usb_hibrst);
+		reset_control_assert(priv_data->usb_crst);
+		reset_control_assert(priv_data->usb_apbrst);
+	}
+
+	phy_exit(priv_data->usb3_phy);
+}
+
+/*
+ * Run the platform teardown explicitly, so the resets are asserted while the
+ * clocks are still running.  devm_release_action() unlinks the action before
+ * calling it, so devres will not run it a second time.
+ */
+static void dwc3_xlnx_release_teardown(struct device *dev,
+				       struct dwc3_xlnx *priv_data)
+{
+	if (devm_is_action_added(dev, dwc3_xlnx_zynqmp_teardown, priv_data))
+		devm_release_action(dev, dwc3_xlnx_zynqmp_teardown, priv_data);
+}
+
 static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
@@ -225,7 +258,8 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		writel(reg, priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
 	}
 
-	return 0;
+	return devm_add_action_or_reset(dev, dwc3_xlnx_zynqmp_teardown,
+					priv_data);
 
 err_phy_power_off:
 	phy_power_off(priv_data->usb3_phy);
@@ -352,6 +386,7 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 
 err_clk_put:
+	dwc3_xlnx_release_teardown(dev, priv_data);
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
 
 	return ret;
@@ -364,6 +399,13 @@ static void dwc3_xlnx_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(dev);
 
+	/*
+	 * This is also what makes .shutdown behave the same as .remove:
+	 * device_shutdown() does not call devres_release_all(), so a teardown
+	 * left to devres would never run on the shutdown path.
+	 */
+	dwc3_xlnx_release_teardown(dev, priv_data);
+
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
 	priv_data->num_clocks = 0;
 
-- 
2.53.0

