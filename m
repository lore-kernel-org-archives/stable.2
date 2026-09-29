Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CA653D9CF;
	Tue, 29 Sep 2026 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693174; cv=none; b=c2zWoLDkeIMisiPnDlzJJN+V9SJz5jBuODDRLGzr9XWcvZ69rNWesZG2OzOEpVA4RFwqxkesP2idDVj1b2UyBl+Fvatq+Ut/K44xGVtp0GfjLyo7PG7QHyvjG2hhJzMaZ+KCxpjysLejM8+dH3mcP4A+UJYRyr+SKajFfI5XBaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693174; c=relaxed/simple;
	bh=PbF6FYUsXr1GAxyOcL5U4vrn1m4QFMz4MRJj3LbX9HI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rtxs0p2omsMTCe38Vv3816NK+XYkeZDaV9YXe3fCPnQ1tRnEN08C6N83UcgSKHGe1PPXL5hGmXXgpO21B470UBUNCdrbhx+K4Mzb1iyC2qfxR15KGXQZNTiAm3yabOGj7PVAjwPEkss3CuHCN/cQmmdJ70idd/twsOVaXfrVf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QvKie7nf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QvKie7nf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 462DE1A1066;
	Tue, 29 Sep 2026 14:46:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 18BA4601BD;
	Tue, 29 Sep 2026 14:46:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA9DC103282F2;
	Tue, 29 Sep 2026 16:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790693158; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=g/MvsTZBQVv82eCENlE54GLFRNRWl+Z3gRhZz1fyUG8=;
	b=QvKie7nfVAzjaDRHyzr4WFhvS2O7e2j8VPpNC4TMQYd9gkTABiLjOSjOYs67p6QbsVSRPK
	Kf5UohPLxwALG4uhro/dO8Lo9ZYO/AMxtIStAGh1VOzRLwOzVyChQIwRqn2FZhkm99JOd+
	2jo/US6/KdWkOUfB9uLytM8+goCm67oaPq0pKxsJPXpZoor66TjaZP5TY3ajiKlP6EXV1P
	FcrcxbFjxU/RfM/eBVdOGUOuO0x4M56uf36HggWtFpkFdLAjAWMp/D3l/5dRwIv0zQR6Td
	4OfB+aKBPybYldN7X9l7hkU07S30LUcvfLlqfAyhYKLwU6BaFd3d20Gn7VF5qA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 29 Sep 2026 16:44:51 +0200
Subject: [PATCH v5 8/9] clk: nuvoton: ma35d1: get HXT/LXT from DT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-perso-ma35d1-upstream-clk-v5-8-68533e935ee4@bootlin.com>
References: <20260929-perso-ma35d1-upstream-clk-v5-0-68533e935ee4@bootlin.com>
In-Reply-To: <20260929-perso-ma35d1-upstream-clk-v5-0-68533e935ee4@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chi-Fang Li <cfli0@nuvoton.com>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
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

HXT and LXT are crystal oscillator inputs of the clock controller, they
are described in the DT. Get them with devm_clk_get_optional() and point
the internal clock table at the clk_hw's found this way, instead of
registering fixed rate clocks in their place.

Old DTs reference the HXT fixed-clock without naming it and do not
describe LXT at all. In this case, fall back to the fixed rate clocks
that were used so far, to keep booting.

Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/clk/nuvoton/clk-ma35d1.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/nuvoton/clk-ma35d1.c b/drivers/clk/nuvoton/clk-ma35d1.c
index ceebcbd8c18b..81a412b1706e 100644
--- a/drivers/clk/nuvoton/clk-ma35d1.c
+++ b/drivers/clk/nuvoton/clk-ma35d1.c
@@ -4,6 +4,7 @@
  * Author: Chi-Fang Li <cfli0@nuvoton.com>
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -124,6 +125,21 @@ static struct clk_hw *ma35d1_clk_fixed(const char *name, int rate)
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
 
+static struct clk_hw *ma35d1_clk_xtal(struct device *dev, const char *name,
+				      unsigned long rate)
+{
+	struct clk *clk = devm_clk_get_optional(dev, name);
+
+	if (IS_ERR(clk))
+		return ERR_CAST(clk);
+
+	if (!clk)
+		/* Old DTs do not describe the crystal inputs. */
+		return ma35d1_clk_fixed(name, rate);
+
+	return __clk_get_hw(clk);
+}
+
 static struct clk_hw *ma35d1_clk_mux(struct device *dev, const char *name,
 				     void __iomem *reg, u8 shift, u8 width,
 				     struct clk_hw **hws,
@@ -240,10 +256,10 @@ static int ma35d1_clocks_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	hws[HXT] = ma35d1_clk_fixed("hxt", 24000000);
+	hws[HXT] = ma35d1_clk_xtal(dev, "hxt", 24000000);
 	hws[HXT_GATE] = ma35d1_clk_gate(dev, "hxt_gate", "hxt",
 					clk_base + REG_CLK_PWRCTL, 0);
-	hws[LXT] = ma35d1_clk_fixed("lxt", 32768);
+	hws[LXT] = ma35d1_clk_xtal(dev, "lxt", 32768);
 	hws[LXT_GATE] = ma35d1_clk_gate(dev, "lxt_gate", "lxt",
 					clk_base + REG_CLK_PWRCTL, 1);
 	hws[HIRC] = ma35d1_clk_fixed("hirc", 12000000);

-- 
2.55.0

