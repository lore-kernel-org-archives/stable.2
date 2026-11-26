Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710163;
	b=Pl59Spjy8pkW2FE437gsEParTw0uzMJpi82dMOBRpzFqTakcoqfoiTCEQT1jHNYZEw70
	 AAa0Y5fXhnp3zGYnP/0GWovYJd32xj/A2PjBXrCtjJNNpRutnNn/yPXQFqa+NxSoTekLo
	 wx/hkHa4mIkhpqbkwADV/ELvuyi/Od0fnlikTURmE/5SuNDcswWo3NKlW75NkVXH0cUYg
	 lus/5q6YVfQptdMvvtQrssj737ELGukiAQNUQY9g2BlrHZqW8dr2s42jh3MR8Vlg6CV1p
	 QXFoxkWkRtK+kq+Pe5CqUi01fifhK6L1DhXbqtP240qeya64EJ9bm1x3fgsp/ZxCTqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710163;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qTvU7rkUGbGdvltyw5tSbE02iSjjJKSnz80k2vmse+c=;
	b=1A1gEIO24ccpBawTwuaNiRnmiIexkDzsGjnT/UCs/1KPKQduyBRjvTGE5KHc3O+rpiO1
	 BTt+BZYNOr4CtipEBdkAxYHI5bevJvBypnS2QKxRm8l0TcyYajwMSYNDr+VGOoyMQqOqv
	 Edy8PWATIQFtlmuku4pLK8k3UiLZLJ9NBOQHSlMMeOv8i+BRM59fZuD3EhLF4Obx0TScb
	 YyOehOiXbQhoWbBPl2IWxCu9YX870CEtn86DZXXWlnwCMAqBnsL4khEpBRaeq0bhtt5VX
	 FD8v3nD04FCuIJ/wS4FDrI10C0pXVyZT0d4873TgH8onnbAEUOfPOArl6nVf7fFS4pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3IpSNM5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A40606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3IpSNM5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745D81F000CA;
	Thu, 26 Nov 2026 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710162;
	bh=qTvU7rkUGbGdvltyw5tSbE02iSjjJKSnz80k2vmse+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3IpSNM5wd6X7vDHLN1aKcKiraYDesfIlr4MuvRLnGHY3xGUzE4h9GnghU2erTuYA
	 NhSwX1CSstQrWZxMPlw0ZpfFn4AY1UTI0ipJxibIN5LtKZFpCrjucQaQ7GC3Dn7bFG
	 0K6NCyYTzINScb0lb7St+Iw8cpF3ZUoRv/Kivm5mLGnELX6x5TtIYshbEnDfKZAzyk
	 v0JoJ/bJcDhKHtW6aE6vsHlJA3GxkGl+8DCoJZJJDd9jkuxHJ33dvqdEcFDGaBMwGx
	 00dVgxHN/Ega6w6r+Osoa7MxxCRggC40Dnw2i8ps/LAfHMWXEn5EdjkA0N0txFEgW2
	 F2fkghyY7IRdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	stable <stable@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] usb: dwc3: xilinx: unwind ZynqMP platform init on probe failure and remove
Date: Thu, 26 Nov 2026 11:22:40 -0500
Message-ID: <20261126162217.2560814-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-unused-sip-a40c@gregkh>
References: <2026112511-unused-sip-a40c@gregkh>
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
Depends on <20261126161055.2530202-1-sashal@kernel.org>

 drivers/usb/dwc3/dwc3-xilinx.c | 44 +++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 7e25ccd42be4f..05fc5d3ab8899 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -120,6 +120,39 @@ static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
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
@@ -236,7 +269,8 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 
 	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
 
-	return 0;
+	return devm_add_action_or_reset(dev, dwc3_xlnx_zynqmp_teardown,
+					priv_data);
 
 err_phy_power_off:
 	phy_power_off(priv_data->usb3_phy);
@@ -363,6 +397,7 @@ static int dwc3_xlnx_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(dev);
 
 err_clk_put:
+	dwc3_xlnx_release_teardown(dev, priv_data);
 	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data->clks);
 
 	return ret;
@@ -375,6 +410,13 @@ static void dwc3_xlnx_remove(struct platform_device *pdev)
 
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

