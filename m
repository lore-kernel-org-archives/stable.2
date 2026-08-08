Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D83B27DB
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786177915; cv=none; b=G2EbIVBidqYCVJofeTuVaRrsL8ZGOPqVr5HZtiDHDG5TgE2TKKORmOp7+LHb6ZHJ0hdTEGjgJPhMlR6bP42tmzUbPNFyVAWaTCGEf9rXevm+ywZYgQdSSH/RIbv/v/EadI3VhX3NwJar4wlEyKZrMMd5bbsz3+zTuIQ3b4CExbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786177915; c=relaxed/simple;
	bh=db+z0vzvh2BQdKuvYbDdNDQvp3bZssbayao5QvGWyjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrNY3Dc7W0Ov9d0LnI7XHPvDzyIWwQ56nivqRrHQwUz0bdUNKNNWeeCQk4NEeAtT8TtDjM5kZLx4C6oICGEihPfFqUYXsv5reTncCrGFeGRSDtiOrFSzSvv7algKlGacGLmwi6B3akzy+5aOFlKMi2IOncheZ2tswKBSTFnyv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCN67prM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCN67prM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso284846a91.1
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786177913; x=1786782713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VKPZin59jcLEgsj7vGd6U8AiKKUkanMgykS2/LGEdhs=;
        b=MCN67prM4Elkqg3Xn2YbkpLf71DQrzNvLmM0vC3rYlnzOzh2My3Mt22B4ogxxvkW8x
         54W5i+7CEQ5qfEDdG+NgzFEdAlVDv9ShS/dbSsGCinc6ywL4/PdDqX9VC3KWUGVvPvRQ
         8B1WTIOCnzvSGwS4AgGgiH15AggrJvRRiJw9t/DnqldlcUg4GYxdtCVg0EVUKzHrNixo
         0qJptRckdkscUYpxZhl15GhGtkxPzo+ybKHN91j5Z+Ek9ahlNDRk1wLQZ6bf/IHAI8TI
         PzXAiGS6ziWRbE2n6knUeK1PK0ubq8M4HqplZJkI6gMrv9avzGj+2aZidrRcanRiElg2
         C9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786177913; x=1786782713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKPZin59jcLEgsj7vGd6U8AiKKUkanMgykS2/LGEdhs=;
        b=f311ZGumHXsJA5yKL+XqIDYTCEMcvmIe+PGlj2mN+d1q71qhXc5FmIU1dAkrSAIFGT
         0GPwSoVb0UkKv7/oyZU/TYBEsu22FIWcWYz6ZFlmFH1f48C0DWZu/XsgXroJwHyI69RQ
         F3gaO+N+cQdc027M/zrU/w4m38PpPGgTqeenTh9q6j81Wgefa4G8L2Ko2jFK/05+pxaa
         baCvY36BjW7FUunXh6i+/O4QRI8Io43VV0NhooZytUXTUiacU7tBuhN46VO9IGJpgoQh
         50An4qIsDBOonS14ilGj4SnWgv//DUJXIQA+wFDOhKV0b35ZD88vBrOenSSFSyLRh6c9
         85fg==
X-Forwarded-Encrypted: i=1; AHgh+RoZLxr6biapwEj6UrD/KFycarC9J2KSViyaAgm1FE/F5EEU3ZOXK/PV22a5Q88roOjyngSOsFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5pHXrM5xep3YpzFvA10Ps299XLfkfCIDfLSCTAdgce6VUhXy6
	PSTSCe3c74cZuFPfPwZlltOTvn6PCatB4rxZ3ayot3Avv3FZ44SQX0lY
X-Gm-Gg: AR+sD111DXVU9jGmV3JFT3j19a60D/olHitM9pH1nLOKuVN7tXskX9mcdPs+PapS2LK
	ZiBA75woRbs8NH/kH+W3VrFj2yl2Spj/H8CFk3iBKYh3NPaW/t6kZAHPF+O8TQ+geuUsEXC3FU1
	QuKjwT0qLT/375ntNc5NwOEXHjiwZ4U1n7YBx8Qk7ZDQVbJegwUTZbr4Z1YhliWvwX7T6SwJ9/g
	gL8l1GhZt8ayu0yCThz0DWG5HTIZOjoFFg/HYUWB4uaNPfo6twKlktFI0pqjQ0E2nSK2PfkqBBp
	kYMVxpKehjAZ4z1+oJVTu99xEoCM6qlfISKklVxyQjbQUo+fdvXa5kNuidoaJOYTlp3yOWYwFHf
	J0jNsFknsr6bH6/khPmmuaR4vkhW8M2t7pD/ei8gHgnKklWUItkj7gG2JIF1an4xoxDpdI5D/ky
	wQgtim8JuCNVgfZYmAXUoNT+oHWoNtD5SMoy4IqOif5KI=
X-Received: by 2002:a17:90b:1d4f:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-3903c5381d6mr27967961a91.5.1786177913049;
        Sat, 08 Aug 2026 01:31:53 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de9f6asm7623040a91.7.2026.08.08.01.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:31:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] clk: imx: scu: fix autosuspend cleanup on probe failure
Date: Sat,  8 Aug 2026 16:29:33 +0800
Message-ID: <20260808082933.2692878-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_clk_scu_probe() calls pm_runtime_use_autosuspend() for non-CPU
clocks, but its probe failure paths do not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during cleanup, this reference is not dropped and usage_count remains
unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
failure paths before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/clk/imx/clk-scu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 9b33df9967ec..6d29fcc2306d 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -542,6 +542,7 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
 		ret = pm_runtime_resume_and_get(dev);
 		if (ret) {
 			pm_genpd_remove_device(dev);
+			pm_runtime_dont_use_autosuspend(dev);
 			pm_runtime_disable(dev);
 			return ret;
 		}
@@ -550,6 +551,9 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
 	hw = __imx_clk_scu(dev, clk->name, clk->parents, clk->num_parents,
 			   clk->rsrc, clk->clk_type);
 	if (IS_ERR(hw)) {
+		if (!(clk->rsrc == IMX_SC_R_A35 || clk->rsrc == IMX_SC_R_A53 ||
+		      clk->rsrc == IMX_SC_R_A72))
+			pm_runtime_dont_use_autosuspend(dev);
 		pm_runtime_disable(dev);
 		return PTR_ERR(hw);
 	}
-- 
2.43.0

