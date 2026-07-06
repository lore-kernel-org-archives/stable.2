Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7A53DC4CB
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318834; cv=none; b=FIlzA6eReqnltC2LzzDabIaB/N27yGM9fAyyAAY84zrsfUVuTSsDiMm3R+jgNQdubCMHu0ypZAvOyZIo38+7SUAMvwRMXVXeYFXj6Tb2EFSmzBdbYMooxrEHj6BTrgU9cVI5dL/XdljlMNXRzLrQ8zMgjz14q6+B199789plDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318834; c=relaxed/simple;
	bh=LWglcUmKJJujYCrUKRMCU+qSUx0o9x0XMXsedC1YP84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozgH3ycYNq9nyOgrrzC1hdI3QtR+sPBYy8EtiV9lcb/Ds3kdmKM0lZqtso8v3EQm9PMaVU+D3RtKabjL2e3dEppzFUR4C6NFUrCJTAfuvCMcDZc7BJ6qigedprYQDqZKQTES8aq9yv6iPQHhjyDcmaqDvw9+HEUdq7yXtafkCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=JJ3ONEMS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breiti.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b="JJ3ONEMS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4720d22c94aso2582236f8f.1
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 23:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1783318820; x=1783923620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aKPxjwYIwY+lwdwsN7x/+EZw5Zz00YN/j9XJOtJ8WiY=;
        b=JJ3ONEMSNC36xwlbXZlm8bhWbiCOuqrA/XFHSWEIpMdypYW8vsvIgBeXITQISRzI2j
         yv3oEnex9UFF5me6ecsVB/dBBD+YlwsUGIiDC8HUMZl4L5aXlXpllkx2Itt0t038Bk4k
         wk8IpS9P8UQ44U5VF0CSiY7+gO5eWXxl1uAmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783318820; x=1783923620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aKPxjwYIwY+lwdwsN7x/+EZw5Zz00YN/j9XJOtJ8WiY=;
        b=ELCffeRu0IsqZISzMpoBOrgFPZfrWT43bgeUpdZl722l1ma3mMj1z1t/nJfxryMt30
         oJZHLjHzOQ8oOTFNAIB9ssrAoLSfAjJaP6SuUqfctjzT58K5yPFq9ktn7gu3G41jLVbR
         fzydYtBOnjRg5JfXLDJutZuJRGAY83dlOLxYUwHk8KCmWNL2ouZ8PaCVTKQMRsPunjeK
         JA6jc+11tDdylkql/MV0zlv3ov5VzslDENE95X7yFUU6McJY8F/c/34J00O6TGZDg4Wv
         eZiwxd917xaAI6ZpgmKEdWfpgwDrNXl42UmY5BgmOo4ASpftj3HwMlz8ivi8vzS/7tNm
         yJmg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0/+/x9b0xe7+zkT/HvAx5YG3R9gnHgICa0ua8QSCvqAdmKin0PObDdYJ9bGNPAoHcNy26kHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUScyR4G+wCOvIErQOo1ijb76Z3FcuUvbaNtwxa5oZ29UHhD3Y
	g8CoT/ARHthhGSGm0hHzqtFlMRpRpQ5OOhrU/L0FBh3VC/Op2jg6QJ1czMGq1Shdog==
X-Gm-Gg: AfdE7cmHvpp1a/rYAYFR5cjZSaUoVZjlY/2haQiaIPqJHmo17cy4A6I+SiOWlabBFDZ
	HjpNBQ7Jbk1A/J2RfypdRjh9K8NqrqwtK5uBX83GQOaf8BKHiZ/8b03bLik8ME7v5c/o0BEWHmM
	uLluEDv2qPtzGFcr+FCQgU2twxgX5yUxzWs3XcZRK9GcoqLWPIbPslFsu2/uyGFXE6NRgAsdrZ7
	FJ2fx7ECUfQovzf5hKA5xEWNNf1k75bQcZNEPTiRCWA10l92+SyPujRJJUPnyp7EhXCO2s1ZzJ7
	ZEMRdOxR1ktKGTdHtvoffE+fiGIU5pfJddBbk9MPUELKprex/EGoFyVeEAMLLI30PV3Jc/P1xju
	kkOMZ0XWc+0ilrzOFFk4HvMbz+L0WF8xfEv5diuzUkSxcSyoJgFxdkV38eRAsHpR0C+vEBcl0Oq
	Jygcm2GHE0ng+8Gy8cIrOOdXOjZgYSI+JvRC4W+ckfy7qz4Q37CQ==
X-Received: by 2002:a5d:5d03:0:b0:476:e67a:dfa7 with SMTP id ffacd0b85a97d-47aaa4222c9mr11073751f8f.7.1783318818209;
        Sun, 05 Jul 2026 23:20:18 -0700 (PDT)
Received: from framework.casa.breiti.cc ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm22194047f8f.9.2026.07.05.23.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 23:20:17 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Markus Breitenberger <bre@breiti.cc>,
	stable@vger.kernel.org,
	Markus Breitenberger <bre@keba.com>
Subject: [PATCH net] net: stmmac: intel: don't reconfigure SerDes on unchanged mode
Date: Mon,  6 Jul 2026 08:19:54 +0200
Message-ID: <20260706061954.94842-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Breitenberger <bre@keba.com>

intel_mac_finish() is registered as the phylink mac_finish() callback
for the Elkhart Lake SGMII ports. phylink calls mac_finish() at the end
of every major link reconfiguration, including the initial one during
probe, before any interface mode has actually changed.

The callback reprograms the shared ModPHY LCPLL through the PMC IPC and
then power-cycles the SerDes. On Elkhart Lake that ModPHY is also used
by the on-die AHCI SATA PHY. Running the reconfiguration during the
initial boot-time link-up disturbs the shared analog block while it is
still driving SATA, so the SATA link fails to train:

  ata1: SATA link down (SStatus 1 SControl 300)

The disk carrying the root filesystem is never detected and the system
hangs at rootwait. Ethernet itself comes up normally, which makes the
failure look unrelated to the network driver.

Firmware already programs the ModPHY for the configured interface, so
the reconfiguration is redundant unless the interface mode really
changes. Return early when the requested mode equals the current one.
This avoids touching the shared ModPHY (and the SATA PHY) during boot
while preserving runtime SGMII to 2500BASE-X switching, which still
sees a genuine mode change and reconfigures as before.

Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Markus Breitenberger <bre@keba.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index b8d467ba6d72..9a162831ca40 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -536,6 +536,15 @@ static int intel_mac_finish(struct net_device *ndev,
 	int max_regs = 0;
 	int ret = 0;
 
+	/* mac_finish() runs at the end of every major link reconfiguration,
+	 * including the initial one at probe, where the interface mode has
+	 * not actually changed. Reprogramming and power-cycling the SerDes is
+	 * only needed on a real mode change and is otherwise needlessly
+	 * disruptive, so skip it when the mode is unchanged.
+	 */
+	if (priv->plat->phy_interface == interface)
+		return 0;
+
 	ret = intel_tsn_lane_is_available(ndev, intel_priv);
 	if (ret < 0) {
 		netdev_info(priv->dev, "No TSN lane available to set the registers.\n");
-- 
2.55.0

