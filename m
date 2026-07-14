Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663A35E1AC
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043693; cv=none; b=crUKMkxPmecniV/1jeF89O+8oeioAEoND0rsRlSAD82hcCnaOzpxz1OgctHHwGtRRLuKnZqrkZOI0OF7I7BHAKtg91/cql0WTNeZDdxynCZ+03XqoUyuij03ERGIvgoKGvSKQqWt0fbM05uQDPFxHP70usWNjLf4qBqS0YfNmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043693; c=relaxed/simple;
	bh=qevuPbC3ipAlHnx/CLyUvELDYmFet0ftlCCOj1w52vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G6ZMeZrYhFdVzRDknM4S2s/eZWOjzqw8tuNi1zIlEZATcJ94LoWCldYWVYV+/2vPWvf71utOO3wjwJS/4+Y97kIu9OnXFCAqJUzHQK20mgoTq9NIZWn1eO+d3SMk1B4GmYYCAFVytlYwc9ZnQSyDdE23ud1fG1oH1K0rm+hkeFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=Ab4w3J1F; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="Ab4w3J1F"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-475417f010dso2104011f8f.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1784043690; x=1784648490; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7GNTtKuo/BgF6mYC1Y9daW/AtQJUyZsBrVhnEirUr/Y=;
        b=Ab4w3J1F7s3c8n1zSfVFZ4ImbQEWglgsK/Xcmgz5pN4UgjWLODem6f85NjnFsi+ELe
         HFqYhOsqtt4YfVZpQFgEOjwejQYIiG8MVAWWsYPg78s6m754qkyUzMnt9bEJVCjQEJUq
         nRD/OeFbvOI4kdibl5rorrgmQOsoimqbB13FyJQkkleygKHDpVpW1MCrB4wf5OeTBhLZ
         9BHIErzTynkYvPv/Pa19IrPL8XiYWWBp/8KLGfpVUmJxcBgs18290Rddn+/bapQy6Nme
         OQSgJDFKy2fINBMEW5xqnjUjC0HxtFnXv7JTTeRZhup56maMWhCtR/SGFZS+0+pDl3vI
         tH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784043690; x=1784648490;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7GNTtKuo/BgF6mYC1Y9daW/AtQJUyZsBrVhnEirUr/Y=;
        b=GjqdImTGQEcWQFQMuxBujkzWt/Hwlp0A5qgsbmpUB3w6vn1FwsXEmuQ9pilC87HrC0
         NDW0N1ww76FvasgxhK17rUEsnSTOmjMyEng8TQ3cX+ENft3vkX97Pj0BhuRqnZDTLpL4
         Y1JXIVFm6C1IF+snRUMOleYyGimYUHhlvb+sAMdPGIlGLoN+bzT5SEStxwlV/nUznjyu
         NAyv8GigL+Y9cxdAZ0vCFUsoeyxyKMnLs9Y4DndLQJ4DyEaEC2hAp/IfGU3gpSqXf7uR
         2e2JsfW7Aeli4gda0/q3m6Rj3W6/LN6YtSXQuEjTIe3MsGi0sWf1hITEP7q0fubjHYj4
         neKw==
X-Forwarded-Encrypted: i=1; AHgh+Rpa4tngjrqYL+bGJIvEZspac22IGIai1Vst7T1v7cb1xiNJ2+uj2MIc31/ZyUX2QNDNC6TKsls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrsMXBpdwpPJd2wEi66mtx6bMbOLE+1cd/aBeOoePsxARpq/IV
	XfPQQ8atxEZq2V2B+I0jnLWoix842Qd5Q1we7p2fXHq+xWYCdIE1Q8Ot9kfryJa8Z0A=
X-Gm-Gg: AfdE7ck0OKhWGq9FPjEcp3dgyo6K8nUsvo+A2TxYEMRUdtQrUhtfWTs4qWPdVQwn4zX
	9NjrIKpRW7Ha/S6V5+5AbiGhgEKWZSiICSxLK9HCZ6hr1V4czyOax42n4zwL/yKOTixOyGnqMbo
	f7JErItM7DgfgaynG0ycyXsrLY2umYqiXYjt7IKWsBFV+TPJQW7FHe/ywmzYCrnSasr4akVo1H2
	49q9QpPAdXA53HFiGPbHpKUHdZAJWDWUQgjYGMCbxcUrmegZvGEa45mr2+8u4GJpy/KOrZZRUwU
	28vTH/NYv1+2G0jgNrm0KCThNdTMQWWEm+ZNkO6iaka/1fKy+N/lUwHeOVX3FMfXJp275rl80ES
	goPRdz03InLXhloCyHWvrT/HOq/CtcUCBxiGdpIo6fg/+GCszlcrnBoxASZzEVi2Wjs6qXFFCBA
	3s/++SXEiukoQWPQOFsEb39NdmcGXLDf/au1J8rpTYjJB9uFYsgiaJ3OMu6Y9OUwXK1zbFqlLGN
	7Q=
X-Received: by 2002:a05:6000:71a:b0:465:81cb:bb20 with SMTP id ffacd0b85a97d-47f2dcadd2amr15226174f8f.9.1784043690339;
        Tue, 14 Jul 2026 08:41:30 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae. [92.99.174.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635aa34sm8423240f8f.15.2026.07.14.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:41:30 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 14 Jul 2026 19:41:20 +0400
Subject: [PATCH] phy: rockchip: naneng-combphy: Always configure SSC spread
 direction
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-naneng-ssc-fix-v1-1-1c40a58061ae@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0MT3bzEvNS8dN3i4mTdtMwK3RQjSwtjA5NUCxMzSyWgpoKiVKAw2MD
 oWAi/uDQpKzW5BGSKUm0tACiDjh1yAAAA
X-Change-ID: 20260714-naneng-ssc-fix-d298304e8469
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604; i=alchark@flipper.net;
 h=from:subject:message-id; bh=qevuPbC3ipAlHnx/CLyUvELDYmFet0ftlCCOj1w52vw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFRaxYI1zXUFp7/tEFLfUjJytz+9Y3OxVs9w5hb3Zdn
 LTDmel9x0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFOt8ILhn3aXaFhPz/bVMU8Sly72e5w51a8sv+OI37nVl/MvnT3yZxIjw9+o30K
 3T7cvC9U526nROT/Gcd2ej+JfDLdb/j2kINCwigUA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Commit 0b31f297557f ("phy: rockchip: naneng-combphy: Consolidate SSC
configuration") moved the SSC spread spectrum direction setup into the
new rk_combphy_common_cfg_ssc() helper. That helper returns early when
the 'rockchip,enable-ssc' property is absent, whereas the equivalent
RK3568_PHYREG32 direction writes previously ran unconditionally in the
per-type switch statements, independent of whether SSC modulation was
actually enabled.

As no in-tree board sets 'rockchip,enable-ssc', this changed the behavior
at least for USB3 on RK3576, which now fails to bring up the link.
USB 2.0 still enumerates, but USB 3.0 does not, and the SuperSpeed root
port floods the log every second with:

  usb usb2-port1: Cannot enable. Maybe the USB cable is bad?

This was observed on two different RK3576 devices with a CoreChips SL6341
USB 2.0/3.0 hub connected to the USB DRD controller running in host mode.

Perform the SSC direction writes for PCIe/USB3 (and SATA) before the
enable_ssc check so that they always run, as they did before the
consolidation.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/CAKTNdwH_ZMQa-97h+tqdsWqXKtorkFF9wHAMn60-8ZGKuze_Mg@mail.gmail.com/
Fixes: 0b31f297557f ("phy: rockchip: naneng-combphy: Consolidate SSC configuration")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 2b0f152f5470..7843356a4dd4 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -452,9 +452,6 @@ static void rk_combphy_common_cfg_ssc(struct rockchip_combphy_priv *priv, unsign
 	struct device_node *np = priv->dev->of_node;
 	u32 val;
 
-	if (!priv->enable_ssc)
-		return;
-
 	/* Set SSC downward spread spectrum for PCIe and USB3 */
 	if (priv->type == PHY_TYPE_PCIE || priv->type == PHY_TYPE_USB3) {
 		val = FIELD_PREP(RK3568_PHYREG32_SSC_MASK, RK3568_PHYREG32_SSC_DOWNWARD);
@@ -471,6 +468,9 @@ static void rk_combphy_common_cfg_ssc(struct rockchip_combphy_priv *priv, unsign
 					 RK3568_PHYREG32);
 	}
 
+	if (!priv->enable_ssc)
+		return;
+
 	/* Enable SSC */
 	val = readl(priv->mmio + RK3568_PHYREG8);
 	val |= RK3568_PHYREG8_SSC_EN;

---
base-commit: cc2b5f627e8ccbae1188ef2d8be3e451d7f933a5
change-id: 20260714-naneng-ssc-fix-d298304e8469

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

