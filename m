Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795539173;
	b=jWJ8IX7cjLoGffZQWZWt2l2r3Sb6YR8IzLdjPO2FkQKb1G3Yn32Jc6qeMezqpkVinj2g
	 VbJdsrUCtlHHHZ6ddut+bVE2wfCI+lNgQBTGkMxJyrT4ntKvGRpDW8mW6ZNImzXWxSo3P
	 PAJt1oCMIZIwRf0mwKwKTYWNLI6nvNr5NwJeRhhCXRtKEDmqKykHfteuPHdF7JHsc/Bcz
	 MHuBICrmViFhVmKBNf0L7a2oH2hq2LrmaAAOoeuCYoprDjJC4e2Mj+mEkf0ntB1u2MqK1
	 58iMwnU4Kbm+1dYguRGp5pyZ77T9+Ht/5i4t7pmlSvLC212NwFO67mWjKWol1T0ouQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795539173;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=23A2BUHFe6VM/AwKx+Mlw+Ey/1Aj8HnIQKPlokLPThU=;
	b=LSf9NAZAQDjHEJgb4lNievt4+nunCstz7Tm2sjZxtsBXXTOMUEHDDvGw9ByHwxcfmvFz
	 CsnnPqAaqnM18WLiMNa92M3gsKdknebQEz/ke6GW6Mkh8w9MfJLPKQGcJeynZIJ6UqPkM
	 apWc9Me9Bn9cVdx5mmGCC8A9X/iZsvIXI9jk6bQDZsM6TpzqmmLMAGCKntBsqsoKzBqKY
	 MCxOdHetTW1KV7Y+sZG3XVDLWVoNqVgJYdkcXsIDmLHSyrvTkcvRiyhJwvKXFrDpC7okn
	 Z+RNPBMhK5RAylA4KXUG9QXfThE3mlzmek3XQayKLFWr3ZG5jvf6n0leM04HnoqvspA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Q89+Bx1d;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DCB606A33C;
	Tue, 24 Nov 2026 16:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93DCB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Q89+Bx1d
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 482F81A1747;
	Tue, 24 Nov 2026 16:52:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 145B7601E1;
	Tue, 24 Nov 2026 16:52:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2773511E69A92;
	Tue, 24 Nov 2026 17:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795539168; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=23A2BUHFe6VM/AwKx+Mlw+Ey/1Aj8HnIQKPlokLPThU=;
	b=Q89+Bx1dKfy6o0XbZ1DlKpum+JP7/pbKVmb9zHWssO0BWeE+AkB4iUYy5CeZor7+Nl2QXd
	Msj1dmVBTxWbhw5t4LlO/2+E1lu8hLFtDYOhDJxL9WmHa4efStWNuJ+6TP6Jq2NfygLK6k
	8+m8vElm2Ed9pvjtZ7DFzAszzjIYEioFdpRAlM8qUoDko0zb+PWr4jMWWOQ4VMTkZYQnP0
	UMgQRzh8nrL2PPTiQQrAtj0AbVhNikqKrsF6HekXdRMu1LGVBvYX83g1d43vtATUKJMcSq
	hKDgdQYFH4qFrF5nch39LPU+1rf3SsxF99GKFasUzXgD5vDFd2yp3zP9WJSbaA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 24 Nov 2026 17:51:34 +0100
Subject: [PATCH v13 09/10] clk: nuvoton: ma35d1: Fix CCAP muxes bus width
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-perso-ma35d1-upstream-clk-v13-9-c920f4a9f0ce@bootlin.com>
References: <20261124-perso-ma35d1-upstream-clk-v13-0-c920f4a9f0ce@bootlin.com>
In-Reply-To: <20261124-perso-ma35d1-upstream-clk-v13-0-c920f4a9f0ce@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 openbmc@lists.ozlabs.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Both CCAP muxes are registered with a single bit bus width which is
obviously wrong since there are 4 possible parents. Fix the mux field
width.

Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index 06bbd63f2ccf..82a4aadeff6b 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -427,13 +427,13 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 	hws[EMAC1_GATE] = ma35d1_clk_gate(dev, "emac1_gate", "epll_div2",
 					  clk_base + REG_CLK_SYSCLK0, 28);
 
-	hws[CCAP0_MUX] = ma35d1_clk_mux(dev, "ccap0_mux", clk_base + REG_CLK_CLKSEL0, 12, 1, hws,
+	hws[CCAP0_MUX] = ma35d1_clk_mux(dev, "ccap0_mux", clk_base + REG_CLK_CLKSEL0, 12, 2, hws,
 					ccap_parent_idx, ARRAY_SIZE(ccap_parent_idx));
 	hws[CCAP0_DIV] = ma35d1_clk_divider(dev, "ccap0_div", "ccap0_mux",
 					    clk_base + REG_CLK_CLKDIV1, 8, 4);
 	hws[CCAP0_GATE] = ma35d1_clk_gate(dev, "ccap0_gate", "ccap0_div",
 					  clk_base + REG_CLK_SYSCLK0, 29);
-	hws[CCAP1_MUX] = ma35d1_clk_mux(dev, "ccap1_mux", clk_base + REG_CLK_CLKSEL0, 14, 1, hws,
+	hws[CCAP1_MUX] = ma35d1_clk_mux(dev, "ccap1_mux", clk_base + REG_CLK_CLKSEL0, 14, 2, hws,
 					ccap_parent_idx, ARRAY_SIZE(ccap_parent_idx));
 	hws[CCAP1_DIV] = ma35d1_clk_divider(dev, "ccap1_div", "ccap1_mux",
 					    clk_base + REG_CLK_CLKDIV1,

-- 
2.56.0

