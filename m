Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711994;
	b=ZvIRSXXQs9deNLWPzyiRzOjUwCRwh8yz0Ie1R+VO5nNgPmpTHArGnjL+15BLA9WcQ8Mi
	 MgpW9ttIEgAuNltKoSzuvwgAJ/JkUTxn1MaInJienV4z5JR627J1CThpt937pE7zwfA+T
	 Bc32iluJm76qATPR5SMGzVCVQ8LHyCLjCZKBxhiDJGd6yGpq9QmPl/S7RGhiyzHO+Rubd
	 OP6F9hKpB2WceYuSrHNntjxZ+XE74yjzMeWh5VQBmMUypV80ZIMAv4un+9PukOCc72KpK
	 sHRyfzkUg5WKELhVmr1xtlnh5ZOz9z0myJrlN2/oel+fA5puSN3Mn12PlDE4Goj0zlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711994;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S3NEW/3fxMD8AD6pW8o5bcgUJy+AE298FtyZq2CWk4s=;
	b=s/ztLqUQ3IwCve2PXrqhuAlVwdFlqphxjJWuyptb18xFGzNfWOnvB2dEoD/irpbjEi9x
	 1haaBmJ/TtirYw9mi+qqi6pd/KHQTHN84Q98ukv1zrh/oRW7FOAiZAZ6oXSMW/fhMjPgj
	 Eo1X22BI6PpkEnfnK8O3Lu8KZVkrYBs8az57qZU67QzjKt7Tv6i/HdC/pNvLM490RuNmQ
	 FBMSXZ6IqQQ35dKBMaxzUXB1SXBep7CFe6FpBin1WUiM5hR2A7UBXn+uYFGJnoAiVEofs
	 qevLkyA4dH2Xps6S/7Y/mVGjV/yk3Rz7C75YuldhmsKfQ/5KZyXG05xWJwF7nL+iRcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5syVGL4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58292606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5syVGL4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C56B1F000C4;
	Thu, 26 Nov 2026 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711993;
	bh=S3NEW/3fxMD8AD6pW8o5bcgUJy+AE298FtyZq2CWk4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j5syVGL4YqLMpnrv4Xo+QGX2oBPUi/qJYpKyTkl2oWBlnu6VTbqzrF41HidTIP+ga
	 DhxCgrdOURuv0TJQr03DFwV2Estj5sMtpctLTczDkb8HU5X7Pt7A2eiqY4NRcDMLdK
	 o/tllf/Ys1DT1l+yayv+0tBTwc+MJ5I+5PTMi800A5c9pI+skFkDmo1BdywkonLRNl
	 7fSOEvYUXvFusl1rg3uF4iQ/1V0YaIhJBpbSJWkFi4zSxaX6g6A6qh16OMMHVKKnon
	 tm8SfSdxj+qrgdFb28Vb1vzwMeHFH7+OzV9PZv/3kmlwOsiL9Jhk3PXtPdFEv/VO58
	 RZbEqq88oKkbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: dwc3: xilinx: re-assert resets on ZynqMP init error paths
Date: Thu, 26 Nov 2026 11:53:11 -0500
Message-ID: <20261126165253.2651112-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112503-errant-undocked-dddf@gregkh>
References: <2026112503-errant-undocked-dddf@gregkh>
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

[ Upstream commit f33f0dd2eb014bffda02ecfd182de3ddab058596 ]

If reset deassert or PHY setup fails partway through
dwc3_xlnx_init_zynqmp(), re-assert the resets that were already
released before unwinding the PHY.

Only undo the reset cycle the function actually performed. The cycle is
skipped when no usb3-phy is present, because asserting the core resets
can break a USB3 configuration that is live but missing from the device
tree, so the error path skips it for the same reason. Asserting an
already asserted reset is harmless, so one block covers however far the
deasserts progressed.

Save the ZynqMP reset handles in driver private data so later probe
teardown can re-assert released resets.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable <stable@kernel.org>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260928120015.3152461-3-radhey.shyam.pandey@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Dropped the struct field additions and the priv_data->usb3_phy guard, using the local reset handles and usb3_phy in a new err_reset_assert label instead. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index df545763a591d..457508b231203 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -183,18 +183,18 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	ret = reset_control_deassert(crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err_phy_exit;
+		goto err_reset_assert;
 	}
 
 	ret = reset_control_deassert(hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err_phy_exit;
+		goto err_reset_assert;
 	}
 
 	ret = phy_power_on(usb3_phy);
 	if (ret < 0)
-		goto err_phy_exit;
+		goto err_reset_assert;
 
 skip_usb3_phy:
 	/*
@@ -210,6 +210,15 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 
 	return 0;
 
+err_reset_assert:
+	/*
+	 * Undo the reset cycle performed above.  Asserting an already
+	 * asserted reset is harmless, so one block covers however far the
+	 * deasserts got.
+	 */
+	reset_control_assert(hibrst);
+	reset_control_assert(crst);
+	reset_control_assert(apbrst);
 err_phy_exit:
 	phy_exit(usb3_phy);
 err:
-- 
2.53.0

