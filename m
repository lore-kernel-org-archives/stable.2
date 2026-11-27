Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788435;
	b=wENtPyz2PsOkANWrwt109ORtX4lpqQ9wdPjm6aUmzp6iHFLrxcOwny6b3TW9ppYr+Jfa
	 mBdsUYJEtJ8G96x3f4e97OPTEb5aVRMephmAXOFs/yC6hPmDH0zjya5UT6+zFUBP202Fn
	 r3Gqu02Ys9AXZPC+46rKMsz9s+je98VnfbQ4Acl4U3fR5KoYuhlFP80MtAbADDOtdBhJa
	 06idiUBUiI9iiQxmUsFCCLg/tFnRGID5KUuYBuYnX+cuFmLDAe+yPA6shl/7JCd0TEWUo
	 NVke1A7cG1YOrEQB7QQOH7zb8usVPsMXY/Np64FbPDou0alfzVmcKkJfxxYSWMx4HYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788435;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9JkqinfSMfohhM6v4SQaMJO8qtgVh5xpR5FOEHTs9mw=;
	b=yApdAofOHQBvqGZLylgK0wxozmX2hEmXZpF2ToWM6wIef8oYmM0YeWpGWOnJuJpaGmL1
	 J6uAEmMy8cbXU6ofZpnuYBSgnEV7MsjuiVPGufS93L4Td6yN51quPnW98R6i6KZTloLrG
	 VITUQv8rczkgQm3tzyIUihikHtYTSQ40tS0F0tKzO65Qt77IadYdu2DGvcm2pWbz2QHmD
	 dam6Rklc5BDhDAU3LPlUePvfjAhbOJxzveCwqBdygAgR8l5qFRQ6+LDIQKfGdTOHuShzK
	 c9wMA8qSv8H1xxXE68X1la3v8YfeB7HrhnbwLwYNgua8v8P2EDTFKucAtaZjYoTxgcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpySxzod;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B911606A31C;
	Fri, 27 Nov 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpySxzod
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365FC1F00898;
	Fri, 27 Nov 2026 14:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788434;
	bh=9JkqinfSMfohhM6v4SQaMJO8qtgVh5xpR5FOEHTs9mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IpySxzoddjUy4NNC8EJm3UGGIeX+bXdXflKEKUOzmLQYbmTjOfrujWrXRF+UixXx+
	 XR7XLVsYp8j4MXQdXaW8tLv+Br6T/BoB+bqrYkOXotaKqun+hI4GWMWo5Xr9PnU6/K
	 mc3oSxTenHFH9N3xWqUP35+161Yqn4lBL8eaY9kRA6JYB/0VKtPlItA9zWK53f6f8i
	 pevvtVbLBoYEhuA5nq01iQ+WlGvuzQLU4rQhKk7Yk9zo0MZZeDE65sPUtC9wfpewNA
	 OSrySLJVlz2OST71OUpeKgwPrh0JoyFMdWFFOQ/TXwTwaBYfVSCvKFrXgdlNGvTFVI
	 UL0s1o8XertvA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Haojian Zhuang <haojian.zhuang@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 09/12] pinctrl: single: Reject invalid register width in pcs_probe()
Date: Fri, 27 Nov 2026 14:04:57 +0000
Message-ID: <20261127140602.2790001-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
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

If the "pinctrl-single,register-width" property specifies an unsupported
width (anything other than 8, 16, or 32), pcs_probe() hits the default
branch in the switch statement and continues without initialising
pcs->read or pcs->write, leading to a divide-by-zero in
pcs_allocate_pin_table() or a NULL function pointer dereference when
accessing registers.

Validate pcs->width immediately after reading the property and return
-EINVAL from the default branch in pcs_probe().

Fixes: 8b8b091bf07f ("pinctrl: Add one-register-per-pin type device tree based pinctrl driver")
Closes: https://sashiko.dev/#/bug/linux-a0303b6e-d0c6-4292-aeeb-fa8a21861827
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
v2 => v3:
 - Add Reviewed-by tag from Alexander Sverdlin.
 - Rebase onto pinctrl/for-next.

 drivers/pinctrl/pinctrl-single.c | 34 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 52734bd7b7f0..6f5113dcdb4b 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1827,6 +1827,23 @@ static int pcs_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	switch (pcs->width) {
+	case 8:
+		pcs->read = pcs_readb;
+		pcs->write = pcs_writeb;
+		break;
+	case 16:
+		pcs->read = pcs_readw;
+		pcs->write = pcs_writew;
+		break;
+	case 32:
+		pcs->read = pcs_readl;
+		pcs->write = pcs_writel;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	ret = of_property_read_u32(np, "pinctrl-single,function-mask",
 				   &pcs->fmask);
 	if (!ret) {
@@ -1876,23 +1893,6 @@ static int pcs_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcs);
 
-	switch (pcs->width) {
-	case 8:
-		pcs->read = pcs_readb;
-		pcs->write = pcs_writeb;
-		break;
-	case 16:
-		pcs->read = pcs_readw;
-		pcs->write = pcs_writew;
-		break;
-	case 32:
-		pcs->read = pcs_readl;
-		pcs->write = pcs_writel;
-		break;
-	default:
-		break;
-	}
-
 	pcs->desc.name = DRIVER_NAME;
 	pcs->desc.pctlops = &pcs_pinctrl_ops;
 	pcs->desc.pmxops = &pcs_pinmux_ops;
-- 
2.56.1.839.g22a8290db9-goog

