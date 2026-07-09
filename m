Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0E3AB283
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623843; cv=none; b=YXaiuRh4FrRNGkH62WYYfsPl2s+EwxxzXDTdLTlrl6+X9bicj4ukkSIJ1YsnXrdx03RxQ2KbNSMAV9cJSMw6h30WoVLq1G0AqoZE/JqFNdZfC4joNSDt9A4yt0KlmqN+YoFUe4DVtetW0r8Pi9XA1mTDjFlptagg0HKUJWH/1Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623843; c=relaxed/simple;
	bh=CxPMzaITnPkkWGGN055P4Bv2uTyYJu0CR569f0T/KzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmZyb2nP06OB6PmaJCijz+POvdv5yCUfBqW4TWDyFps+JyMtqP2GPb6NAwAQCCa5JQhytNGvTjcljdl6xSoEqBEzr0qlQ4IEHP7DyfLCk9PVBL50q+3+nBiwULwNjt3kLLUEjEA0WzwsOEG/Ri72uUigTBZbf4RxWgwTmSRaiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=j4a/Alaz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breiti.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b="j4a/Alaz"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493ed9d8c5cso1012195e9.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1783623840; x=1784228640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1cFyhFd1WTGzP7I6nzPK+Il5As21ayHbm0nJT4NpM4=;
        b=j4a/Alaz0eV+smwIF91VVKlFveTQf33JpVT5EiMVUUw62ZBpMzPmhVPpVVG+t4bHQF
         qEimVUkIiuLykCTQ+e5U2oqBoZa+SjbPm+1nKWQVlMXwlpgBrj1FpPCj+UDWwo9HLM+L
         7m4Fbrh9y+47DoMXX4/3Uo0fDLUSVB+G8baFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623840; x=1784228640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1cFyhFd1WTGzP7I6nzPK+Il5As21ayHbm0nJT4NpM4=;
        b=Pm4BbVs7NU5RIXeCZUCfpphsGA3l1g7HgbeaOh/k1YRV+50sKkBjnL9H/TVHAAwXMi
         D3q3sGkZmRFewWHsNNur4TxO1Yy3mMjovNPlCzYCQ4yAbsK1q3U77XHeYWxQwe19v03n
         To2yPQppswvBOLKx26oZCYB52LYS6g3E5uYBHpcPvefRjXmu76mJYs2AxW76MMj0gTk5
         oPd7kGQ43HBZmvl9raSTkGe8Hpid4A6GY8EsRsUvX9PF+WfRY/Sy+tRCk/YLEKxWm0vu
         /pnE1plcubFVHFTS5O2j1wUAQZA44j7LZ76aXt/IbSwmKXsiwsiU3OKdpnBKevtXdsd5
         7yPg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0dQKvU1FhdIK11w3hhgHRz6j4wJl+MatnoeYtl0A9w9EEEAusH6MCsUsyiVdBSr+jYejcw2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvRd24k1HvGih+iOd4Yyvxpqq4/YRxTMLDjQZSrcFMoa8dGsX
	9B6z/DRRAS5aX64xCx9yZxlE4Iq5URUWySAK7YvB6O/wjtilw5xdWfNkro0xgmFjgA==
X-Gm-Gg: AfdE7cnOHG7egDY0HWuEEW78I832Is1t2HoOhwzlK7FbLYzAdjC3yg93DEcG7cOZiwe
	NM2JxhmLUAfRPenKArNK+8TxiR/FoxnfXPnEXkKGTswlzTt7whlLtkQfUXFzJz3hebR8/dT4Pq0
	Ec2GYzRwuCs0TVsXBQHIzLVxUuYZNh7uCmxnzU+2vrCOA8wOt8g0Qnd4Wr4sBjWSdusxHKpQZjw
	drUa6VkfojFA13J9aJYJR++Sd6NM1J9KLGWS9uBAENQZhALoeINhrlyl1hjFSJYzq9EhzV3l/pC
	xmA5M7SmjXTuaUDEdHzKjSTgzvvGsLNbCmd73Bp3w+EstmbAnTxbqRT/7Px5ndOMca3rYuyZ3vK
	BPKqkabZbUMYVmS/86D9eK9YvE7ezPcYekHeaZGlxoXOhyHHeyl8MTfhx/IVcKNxpskdGJIwDj3
	Sqbaox7xxbTd5BmMG55GeX/eehOCcgA0inlPzetEIv7dpfGrvAqA==
X-Received: by 2002:a05:600c:4e0e:b0:490:e60b:6860 with SMTP id 5b1f17b1804b1-493e6892ea6mr77245815e9.7.1783623839625;
        Thu, 09 Jul 2026 12:03:59 -0700 (PDT)
Received: from framework.casa.breiti.cc ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3c42sm81810125e9.1.2026.07.09.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:03:59 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Markus Breitenberger <bre@keba.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: intel: gate SerDes reconfig on rate
Date: Thu,  9 Jul 2026 21:03:29 +0200
Message-ID: <20260709190329.124432-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Breitenberger <bre@keba.com>

intel_mac_finish() is registered as the phylink mac_finish()
callback for the Elkhart Lake SGMII ports. phylink calls it at
the end of every major link reconfiguration, including the
initial one during probe.

The callback selects the PMC ModPHY LCPLL programming for the
requested MAC-side interface and then power-cycles the SerDes.
On Elkhart Lake that ModPHY is also used by the on-die AHCI
SATA PHY. Reapplying the programming during the initial
boot-time link-up disturbs the shared analog block while it is
still driving SATA, so the SATA link fails to train:

  ata1: SATA link down (SStatus 1 SControl 300)

The disk carrying the root filesystem is never detected and the
system hangs at rootwait. Ethernet itself comes up normally,
which makes the failure look unrelated to the network driver.

Before mac_finish() runs, the legacy SerDes power-up path has
already programmed SERDES_GCR0 for the current interface. The
1G and 2.5G ModPHY tables selected by mac_finish() correspond
to the SerDes lane rate, so read that rate back from SERDES_GCR0
and skip the PMC reprogramming and SerDes power-cycle when it
already matches the selected interface.

This keeps the disruptive reprogramming out of the boot path
when the SerDes is configured correctly, while preserving the
previous behavior when a real SGMII/1000BASE-X to 2500BASE-X
rate change is needed. If the register read fails, reconfigure
as before.

Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Markus Breitenberger <bre@keba.com>
---
v2:
  - Read the current SerDes lane rate from SERDES_GCR0 instead of
    comparing against cached phy_interface state.
  - Rework the commit message to clarify the SerDes power-up path and
    the rate readback check.
  - Keep the previous reconfiguration behavior if the SERDES_GCR0 read
    fails.

v1: https://lore.kernel.org/netdev/20260706061954.94842-1-bre@breiti.cc/

 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index b8d467ba6d72..fa0113597c97 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -525,6 +525,31 @@ static int intel_set_reg_access(const struct pmc_serdes_regs *regs, int max_regs
 	return ret;
 }
 
+/* Return true if the SerDes lane rate must change to serve @interface.
+ * If the current rate cannot be determined, reconfigure as before.
+ */
+static bool intel_serdes_needs_reconfig(struct stmmac_priv *priv,
+					struct intel_priv_data *intel_priv,
+					phy_interface_t interface)
+{
+	u32 cur_rate, want_rate;
+	int data;
+
+	if (!intel_priv->mdio_adhoc_addr)
+		return true;
+
+	data = mdiobus_read(priv->mii, intel_priv->mdio_adhoc_addr,
+			    SERDES_GCR0);
+	if (data < 0)
+		return true;
+
+	cur_rate = (data & SERDES_RATE_MASK) >> SERDES_RATE_PCIE_SHIFT;
+	want_rate = interface == PHY_INTERFACE_MODE_2500BASEX ?
+			SERDES_RATE_PCIE_GEN2 : SERDES_RATE_PCIE_GEN1;
+
+	return cur_rate != want_rate;
+}
+
 static int intel_mac_finish(struct net_device *ndev,
 			    void *intel_data,
 			    unsigned int mode,
@@ -536,6 +561,9 @@ static int intel_mac_finish(struct net_device *ndev,
 	int max_regs = 0;
 	int ret = 0;
 
+	if (!intel_serdes_needs_reconfig(priv, intel_priv, interface))
+		return 0;
+
 	ret = intel_tsn_lane_is_available(ndev, intel_priv);
 	if (ret < 0) {
 		netdev_info(priv->dev, "No TSN lane available to set the registers.\n");
-- 
2.55.0

