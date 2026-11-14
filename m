Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621368;
	b=Ijw8tk9/8T8gVvBugfP/8Jq/ev82g5oCk2vN/lmdAZldsZoFgNoJoC6mxNygVfIPHfth
	 f0IqGtryHfK/FDNGUjx/eSvh7RUZQmYjPhM5r9ODKpALgqNCFxAlMEmlYGL0odGESfp5k
	 QUMLBDP7M0ZPmtvir7g9bR6Fpj4uttsMKOFjJBV3EEljJ+0LzE2hqnSxralMUP1xKEvEv
	 xtZycGRuKTVOmHhDCKLPmpdWRKekxi8YBgv0iHQVAwlzdy/qt7KBSiHHvo71oIkXB+zay
	 BRF4dYcFQvDf4WRoV8QBBY09qBJHW3OyqXF7tI1ifWKZfxgYTuxAgDsxc5Absfwt+6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h1I4zZU44SQT59N5skU0UP5Zl+f6sTdiRU3S4l9F4sg=;
	b=aF7C0yEtF1RV3qFLrfabTiBDmaIfhpa3lJdSpDFAfHEnPMGftozdaM1rRwucur2vCGAo
	 e74GveQe92y51i0jidufpR1vcOrxxyYnjJQFzPsWIZp2EWPWzRCVBJbjE8U7pokRlEZ40
	 EAHLznbkAQUf5xBkmle2E2vcpxgHPcbcdMWAGInl33MVT0J6JKIQSft+ULx+PkGB3u6ns
	 JWGu2OGL67yVR6Ac+FaEMaBogklf1rSNfaAprFu7SyT/eavQc88dHRAUGW34XNtYNvubx
	 xvQVccrj5vhrWJq5m9prmYys//HIeoA0tfLX+U8Nmdrknx+fu313TNk+saLO0WUETXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Q/mCPAHY";
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A7606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 01:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E4A7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q/mCPAHY
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cddc597d062so1320771a12.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794621367; x=1795226167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1I4zZU44SQT59N5skU0UP5Zl+f6sTdiRU3S4l9F4sg=;
        b=Q/mCPAHYooolHhRJp5/geLYcgGPDZgaBv1P5WFHF/TOjZk84J9un/OCiHPIocR47Az
         5h8lro8V4Eh0W+o9Ta7pL/0ZENwV4nwrvDhsgQhFfdQE2pUr4KO548hfUjNEv5V9GyCw
         N2v4kiQMUVe9JmorJpdTAm2bvi2e8W8B+O79iI/AmlGPErD+0xGLhv4sAhPKnINHm0wN
         TrbEFS3WonVLhaukPuhGnZkfpzyHQLeXsYNP2DJr3fbktlN5teDMJ1D/70A3vyi0weZP
         BNeKWAnhDOtj5mNUdhEn5BrVUCTpM3wW3Wby971UFMSXDT+HL3nStVvY+GTz6T8QA+Se
         yI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794621367; x=1795226167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1I4zZU44SQT59N5skU0UP5Zl+f6sTdiRU3S4l9F4sg=;
        b=dbhfzF0r3/gBa5H4PfJK9ZjAXcxx+XtOHSbomNeM5NmUFNY8aQmovFEif2RPPudbmy
         mLSgi7uMQIyE7t3tUGXiWa8r2jh3r09NFcwE1ML35DRi49WH/DonmIOLt//22I3+1lWY
         VohPUmI7rvzCo+C98kGIodQAnVnRrThs78ZvVmRTZZ5TyTbGATOwkK7FwUD0u6I8pgOs
         LnowenKz3YbJMqvbjTH5oic5Ocy/yYeylAzLrXRqvtNLTubqpAKZRYM4royanRBzcJ6y
         8cSJrCM9WPzOApR6X2xUwcgyxH45fn1vqMnBxCgAiW8c1rbDJEtVjLp6wbc6c3BXf6Gu
         sBNw==
X-Forwarded-Encrypted: i=1; AL+hErFYBYi/LaW8jDebY9S8Y8qP2xkbH+Kh5NkNAeIjNrZA5coT9APbBSFB4/Yn++piw6pAsueXWdA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hXOcO8cJExWbJHJI4fLyk8LT87/N5x+xyEcigpNTGpwAeasuk
	+EA66h9tvjusi/x0SQ8js6JQM+y9my5L+31f7Vw2qQ27zxdkDmTmEmX+
X-Gm-Gg: AYBFou0V/hJTco0xvFkgDfEnd7pT1Hi0vN7xXCjYKba8PDGcufoeeotzT6Zxnn46AoD
	qkogzMGcUWZBkhKrsdUYWZfOf6oF2XiB0Ho2TeVSLoq602geMpGN8a5hPS+zILpm3GNtNdLO5D+
	eQlFNkQXr+C4FoWbktMzefrHZIqJvbKgW7L7o66FeF1hhBrB6H0heWi9Lkl4dIF9Jy8PYJR1ZHc
	hUSllgsnjp8r3H5sF1TfgEIN3rnxs2McqBLIfH9dRzvPAbg09DuH8Q1MBy2c9trbdIE/mIKhC5X
	HfaEREfimnUBVjVLiZs8M+MtWfBNEJaS0NK44GDhwyhtLn8U5CpSqLAFdr/sRBkXXRSuxUjdawK
	rZKcH4uNQ//qqX8Ur25VFPUqjzICPepqNmerFjDI7fNmXfmmgfghIsReJasL/9na9O5HCrbYVUM
	lR0IhXkJa32dOLLH09sog7CL8zOZ1aImyDltGYfv8ohzOa4FIH8Yg24bEXaRzOH6i9g+01ioR+j
	5hYgmdbUhtb82+WKHjWbknptV4uU7orgBkevwPbZNgiCl++GKaZIu/BxkjzDxSLMfyAndb3a5Cc
	Ca1IG8/cWIeZ3Wj9ZqlNq1HhqqWY
X-Received: by 2002:a17:90b:33c7:b0:3ac:4291:f569 with SMTP id 98e67ed59e1d1-3b1b089e2cfmr4020163a91.8.1794621366556;
        Fri, 13 Nov 2026 17:56:06 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b110c0sm3084124a91.3.2026.11.13.17.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 17:56:06 -0800 (PST)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	horms@kernel.org,
	0x1207@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: stmmac: re-enable on-chip parity checkers for XGMAC ASP 0x2
Date: Sat, 14 Nov 2026 09:55:54 +0800
Message-Id: <20261114015554.2187341-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC
Core 3.20") made dwxgmac3_safety_feat_config() bail out early for
asp == 0x2, assuming that configuration has no parity protection.

Per the DWC_xgmac databook, the ASP field of MAC_HW_Feature3 selects:

  0x1 (AS_EPPE):  all automotive safety features, with ECC and parity
                  ports on the external application interface
  0x2 (AS_NEPPE): all automotive safety features, without ECC or
                  parity ports on the external application interface
  0x3 (AS_PPE):   all automotive safety features, with parity ports
                  on the external application interface

The reset value of the field is defined as:

  (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 1) ? "3"
  : (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 0) ? "2"
  : (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 2) ? "1" : "0"

so ASP 0x2 implies DWCXG_ASP_ALL = 1, where the internal FSM state
parity and timeout (MAC_FSM_Control) and the on-chip data-path parity
(MTL_DPP_CONTROL) features exist; only the ports on the external
application interface are absent.  The early return therefore skips
enabling safety checkers that are present in the hardware.

Drop 0x2 from the condition so the FSM and data-path parity checkers
are enabled again.

Also update the safety feature descriptions printed by
stmmac_dma_cap_show() to spell out that ASP 0x1/0x2/0x3 differ only
in the ECC or parity ports on the external application interface; the
previous wording, "All Safety Features without ECC or Parity",
suggests the on-chip checkers are absent from an ASP 0x2 device.

Keep the early return for ASP 0x4 (EASP), which selects only ECC
protection for external memory and has no on-chip parity features.

Tested on XGMAC 3.10 and 3.40 cores.

Fixes: 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC Core 3.20")
Cc: stable@vger.kernel.org
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1a88cbaed70c..6b2bfc241109 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -859,10 +859,10 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
 	value |= XGMAC_TCEIE; /* TSO Memory Correctable Error */
 	writel(value, ioaddr + XGMAC_DMA_ECC_INT_ENABLE);
 
-	/* 0x2: Without ECC or Parity Ports on External Application Interface
-	 * 0x4: Only ECC Protection for External Memory feature is selected
+	/* 0x4: Only ECC Protection for External Memory feature is
+	 * selected, without any on-chip parity protection
 	 */
-	if (asp == 0x2 || asp == 0x4)
+	if (asp == 0x4)
 		return 0;
 
 	/* 4. Enable Parity and Timeout for FSM */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 25894771e9e9..24f887df88fa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6741,9 +6741,9 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 	};
 	static const char * const dwxgmac_safety_feature_desc[] = {
 		"No",
-		"All Safety Features with ECC and Parity",
-		"All Safety Features without ECC or Parity",
-		"All Safety Features with Parity Only",
+		"All Safety Features with ECC and Parity Ports on External Application Interface",
+		"All Safety Features without ECC or Parity Ports on External Application Interface",
+		"All Safety Features with Parity Ports on External Application Interface",
 		"ECC Only",
 		"UNDEFINED",
 		"UNDEFINED",
-- 
2.34.1

