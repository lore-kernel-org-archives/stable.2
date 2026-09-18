Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644C53EB104
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 03:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701226; cv=none; b=TatyqkTNca9hmStV2YrVjBnBk7UU0ySpLFKnYoijBGnDdCoDRjOLBGbU1j0iKvz+g62AsOhoH1UzCU+lLUbv/pGkC8dOfQx/iyzBC3ERg2obqmvq9AQsMYEdWvVF/h7Rc+bH9jmr3eCFdjfRvRKXDyVETwyW6o9XxEb4FOLvWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701226; c=relaxed/simple;
	bh=NjLc/8TORdZon0fRfkIxyX9z0eAz0zc3Bki0New4I28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYoAzVA7wUNocyIjloAuouMn3oAxoBymYLU9ARR580JZ+YdDcJl/qKa/TvepabbWBk+Yr4LAukR865Vvs70T8Lmanfkgeh1LgQCwpyibOWo/EABjY9n1ouTIdVGp+IYU9CvHR6WY8oQfoaSOg5nNQ4qteujelwem3vpyK3qKIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heqx2FWO; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heqx2FWO"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91a931f66so1642065ad.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789701217; x=1790306017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CKFxldesfAj8FdEDKAwfFPd/txX/9A+5mA0y6fZJndM=;
        b=heqx2FWOCghTSUMFUuasFLqTjgj0Sje9zetpQa8ncnWz6V2wvd65Rh7qgmgBGz1nWO
         gUTZzX/gMOe0LGEXiwZhUTfvhxBIWaeReKmd7YPV6d8+/lH7HOmBhdUZ9txV9IF/zszv
         JOchZmu/UKMP17vLBQ0ZtG3RUcTs6cmwCXPwA80/nVMefrkRGp+/wwthR7Zzxqkc81zN
         DV1puxp+UAIRfvUn/jhMx1e4eVde7SQrLm2/nZqJ72nRdb7IY681wy4UK7UCNj9RzRm2
         5YBXKKQCqjzH09ZAIRzE6o9GctHIxMYHhpMtSDqsj6fqIxMi5Fx4dd/1N2f2gyEBRZe0
         mkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789701217; x=1790306017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CKFxldesfAj8FdEDKAwfFPd/txX/9A+5mA0y6fZJndM=;
        b=lluPCf1su8NaefG9kVBgzep14NwCF1rqUJtWMeVS0h5sFpUTCVo9ky/S1K790f09+I
         GVpZA7uO01Fe33dtcYFsP9dezxndQwmVIlE4QV0aYfgZkzhrT2mEPAOse8LQ08yEWYMQ
         /Lkx4Rhj8H0cXqL9Ez0x9Z+b7R/teF2jQc2F6WLP56jHi/Sm7ZCthfkPstQQGsdNLU4i
         2ggod1AVonWC1go/1WSVPHRkxnioO+RLU+FV0oEYnMmNVR2GvoNSs8Ld4q3BIga0s/Pt
         yKcY7WnqcDQKmPU4AnAHCQAyd03Ljt9sWcgzrzY8fx8L9eMPbPc4ebEc+HpZldOK1+8J
         KqbQ==
X-Gm-Message-State: AFuF++ndzOXZpwJuS33kl46+vL/ELVLB3uU9wJw7YsFE1hZd9LKjHDFA
	dbou57YlalEeDoicOvdBaYTL2TbGZBMZ5GSheNVpLYbSyNzYsOlF+xSY
X-Gm-Gg: AYBFou3/WVErjTNrLt4QtqbYw0LnkVuRCQhLAw/pXguAgspwfi8Az0oaouuFoJWvZDA
	tVX3qwinONbFkQ/ClSm1Dhmk+/BRylQVufEJvyE37gg797CQR+Zcl3Tqlyo7EKmnu5cZFgK4UiN
	JM0phdMgjl48InyiB1BrV7kuaNcpewsrSROMoRSdrMLeUXPnAE78tIo3PK0w1moZRRVF9jd5oM5
	RZaJADIXxRHzGJR0BvERQREOLPl9lw9vcTAQBmGqAsfGTIuSGMEufwkNn9dDNT97tk800u5IIyl
	paRtTU1BPeVSjg3KR4tnPtThuRWTNDl8IgREgjSefTtEFOAekqxxmPYfmtOJt58fNoOWP4dOEqo
	IXkOarRQh+rLI/xeYE5Xy+WdLbTH3wniOrRt3jCFr64c2iQ2BmZ3Jc3oc4s6U9Yb7EM1X850s0x
	AnqZ0cd3fztYdMAHS0tm/QiT0R/27IDkR+nGuZS+vRfAMqU7wSe7oalg==
X-Received: by 2002:a17:90b:54c4:b0:39e:4c7f:7308 with SMTP id 98e67ed59e1d1-39e55071981mr2385940a91.31.1789701217262;
        Thu, 17 Sep 2026 20:13:37 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a0e860asm827971a91.1.2026.09.17.20.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:13:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Miaoqian Lin <linmq006@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] pmdomain: imx: gpc: remove all initialized power domains
Date: Fri, 18 Sep 2026 11:13:22 +0800
Message-ID: <20260918031323.3376849-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_gpc_old_dt_init() initializes all power domains described by
of_id_data->num_domains. Its probe failure path removes all of these
domains, but imx_gpc_remove() only removes the PU and ARM domains.

On SoCs with more than two domains, such as i.MX6SL and i.MX6SX, the
additional DISPLAY and PCI generic power domains can remain registered
after the GPC driver is removed.

Remove all initialized power domains in reverse order. Keep releasing
the PU clocks immediately after the PU domain has been successfully
removed.

This issue was found by manual code inspection.

Fixes: 5a42d1198901 ("soc: imx: gpc: fix imx6sl gpc power domain regression")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/pmdomain/imx/gpc.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index abca5f449a22..5766e3b40470 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -502,8 +502,10 @@ static int imx_gpc_probe(struct platform_device *pdev)
 
 static void imx_gpc_remove(struct platform_device *pdev)
 {
+	const struct imx_gpc_dt_data *of_id_data =
+		device_get_match_data(&pdev->dev);
 	struct device_node *pgc_node;
-	int ret;
+	int i, ret;
 
 	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
 
@@ -519,19 +521,18 @@ static void imx_gpc_remove(struct platform_device *pdev)
 	if (!pgc_node) {
 		of_genpd_del_provider(pdev->dev.of_node);
 
-		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to remove PU power domain (%pe)\n",
-				ERR_PTR(ret));
-			return;
-		}
-		imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
+		for (i = of_id_data->num_domains - 1; i >= 0; i--) {
+			ret = pm_genpd_remove(&imx_gpc_domains[i].base);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"Failed to remove %s power domain (%pe)\n",
+					imx_gpc_domains[i].base.name,
+					ERR_PTR(ret));
+				return;
+			}
 
-		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to remove ARM power domain (%pe)\n",
-				ERR_PTR(ret));
-			return;
+			if (i == GPC_PGC_DOMAIN_PU)
+				imx_pgc_put_clocks(&imx_gpc_domains[i]);
 		}
 	}
 
-- 
2.43.0

