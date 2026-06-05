Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB82EEE73
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666804; cv=none; b=Xve4VpkNAmuL692DOWjkg1Kcqc9w080I5ydBiJU9bOHF1EkXjA8/xXtXaXCv+cuUetSnLJlmGfG9nPh3Ht0Zk1A/tmoEPAl9x8hCEoihag9jEW3HSbNPZgc2hv+HUlBpdvgGOE10jj8DnEUa1Ce6mb5VQtkclEx9LxgcHA2ytQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666804; c=relaxed/simple;
	bh=rK577MQMWB+IYQdIg5itb7LOHhaThEqc1QeMbNkq3vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYPpc0gxnevYNTp3u8eihGPXLHgDMa21WL3x4KfWxR8kePAyMvxCFJ5o5t0kKfS+VIx88fWZVFMciCLU2LC01agw823f6H6Cmap/wcQwdJpU23EtZDHvq9lycD8rTPyfq+HVmxSgVQ9KX/xaobH9epk5JfPUfaxLf+qAiQtG40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzyLFqqE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzyLFqqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8331F00893;
	Fri,  5 Jun 2026 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780666802;
	bh=isquO3Vi+wC9DfzICXrvCK7s0lhJsmYtwL+CWzNqNY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dzyLFqqElra8HAWDNYNcNQooj8nGm+93IObQ1t87c0rFC72ml5uQtBXS1w/sqGcQ/
	 P5rBCtVUgkDEazm2i+O8VY0nmrsfcPyElLfXNfyi69B239H8ZxpBqfuCjmyIKUD35c
	 eJ3BqtO3B9/2a+BPL/D3OIT8dvxPcuJi/eak/CIaQTjXtq56ZNJeDnFbVUmO65aH5f
	 EFN3W2YRvg4XhvQdmidtzGH/SC0jO25rg3KROwggDjrwgKkW0w+mu1RF+yuaUx9xyM
	 yo+Tg+sU5+hIxjVp3j0Jh67qbwqHaMnnaYGI8KGurWv1bZ9KlAWGNQgRGZUjwMTMsB
	 hDRP7rv17XDlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] usb: dwc3: xilinx: fix error handling in zynqmp init error paths
Date: Fri,  5 Jun 2026 09:39:59 -0400
Message-ID: <20260605133959.760692-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060414-tropics-tamer-a0df@gregkh>
References: <2026060414-tropics-tamer-a0df@gregkh>
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
 drivers/usb/dwc3/dwc3-xilinx.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 1e28d6f50ed07a..c2b8573c256770 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -190,15 +190,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -210,27 +208,25 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
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
@@ -240,6 +236,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+
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

