Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BECD364058
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684284; cv=none; b=QTuD+IZM3xpbDBX+8ZuqJqP58svWyGFf/vWY3+mU5QXQZhZF1jxsJsiRCqSsKwgb+0r7ZtmgGw72pZYsHBWie4QPCi4o5WYRNbnBVtUcMFYPDAO1/88sxEBG7DlBUjKONnjMNqXdmoXANDNJplmgQmUIYMScO2FyYI2nBhT4LK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684284; c=relaxed/simple;
	bh=+yuRW1lnggzQjPUFCP1a89BenIZNBnY0CuXmbkJJ9pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptTm/uqKFQyIEDXhpj7qndQ3ZWCLudHsNlThGtr0Otyu4aCftfhnWxlHSfpiBX4KoIHgYSMeKuN5IODDQBMPRZOvJyCRnh9UsxGVaqqlZ7YjGWGo0qMxM3R51Np/ZBWLJ2yBnm3u4ur53ckbXpLTWYmwYi2/xQwrkUKeCoCWHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaEnI6gX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaEnI6gX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6D01F00893;
	Fri,  5 Jun 2026 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684280;
	bh=D0mnS9R8rES/Mu89SFIw3QDL6Lgi0q46pPT0WD3CoOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jaEnI6gXRT3KV8yGpMczMzqP1IEYWRXkzqjUjEYh1Eoea3Qw996wZg7Lwyy1vWGYt
	 hdviEVqV/U//3qORRUr2L4GmJxDkpfSRKPnvMCfnPds0VycwIj0J08l55WTh5D4XUu
	 +P9DyZL1xloDrWJeyEQAw6nm6RAi5953nwgxzCSiiMb0X++wqJoernozD+XhyouynJ
	 wak7s39JFuh6aUF3sEtDGLaot2jOw4LsB4EKxiAVK6IqMTynQ/89ECMyNfTUob9yeP
	 5qJJVI89oBOWnlU/rVxJ3Waox+LXCdDrCzh1MDNhFRhftHCiwSDUOtc5KEkoOT/PbK
	 BD1Cfnn+/KfVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: dwc3: xilinx: fix error handling in zynqmp init error paths
Date: Fri,  5 Jun 2026 14:31:18 -0400
Message-ID: <20260605183118.2054817-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060416-treadmill-placard-7b53@gregkh>
References: <2026060416-treadmill-placard-7b53@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

[ Upstream commit c1a0ecbf32c4b397353204e2ec94c5bb9f3300ed ]

Fix error handling and resource cleanup i.e remove invalid
phy_exit() after failed phy_init(), route failures through
proper cleanup paths and return 0 explicitly on success.

Fixes: 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
Cc: stable@vger.kernel.org
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Link: https://patch.msgid.link/20260519115529.2980421-1-radhey.shyam.pandey@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 8070c55c217036..cbc95df4798b21 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -171,15 +171,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	ret = phy_init(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = reset_control_deassert(apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	/* Set PIPE Power Present signal in FPD Power Present Register*/
@@ -191,27 +189,25 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	ret = reset_control_deassert(crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = reset_control_deassert(hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = phy_power_on(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
-		goto err;
-	}
+	if (ret < 0)
+		goto err_phy_exit;
 
 skip_usb3_phy:
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
-		return dev_err_probe(dev, PTR_ERR(reset_gpio),
-				     "Failed to request reset GPIO\n");
+		ret = PTR_ERR(reset_gpio);
+		goto err_phy_power_off;
 	}
 
 	if (reset_gpio) {
@@ -231,6 +227,12 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		writel(reg, priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
 	}
 
+	return 0;
+
+err_phy_power_off:
+	phy_power_off(priv_data->usb3_phy);
+err_phy_exit:
+	phy_exit(priv_data->usb3_phy);
 err:
 	return ret;
 }
-- 
2.53.0

