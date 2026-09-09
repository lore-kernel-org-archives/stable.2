Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C19D5476E0
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953465; cv=none; b=HT23XFYk9QIGDFZB/pipW65Ig8D80EddNdsRbe2yrK/1inILEmfmfbPm2GpmfyehqRrIs2GfoCaM1p062k7/HjhNaAqn8R5f2scDgrT+CZAq+JoljuRx3WCO3kucTQ+3rNuIFRdnZ9cPqIuq793eN4Jg7hfdKcs61K4FnXZRtv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953465; c=relaxed/simple;
	bh=h/4IPZtOVxD8JDAoh/PFCeSkSjA05tN6PZ9/B1Y69jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGjvw00W5xW+A4jnYZWgRt6f7iF+jwqVL2zOLFL4UeZcG6SlGtXXRDa5Kelcl8ryzJpXw6iefTS1ceZmNZczNp85GONwu6toh5HaHemORufKbCYnTpPpil4mlB09n35OXnTIaLlp8/v/Jvw5NXu7Qtzo5cy406Rv1FoulLOrco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3TXGGHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3TXGGHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A581F00ADB;
	Wed,  9 Sep 2026 11:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953464;
	bh=xlLunvNwrBcDR+UJ0Vloh86Pf64mAtJmFWljqZmq3pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C3TXGGHQfsM3zx3PZpJvDhaMV24ZlHD7pXfG01RBgAFVGCK/LkFQIA9N02TVbiZNC
	 TGSWuFcHCV/VgBpWL6JhUr12/EDDfM3PTXMabsLdAmbF+Svb76R+L5KAIRE7lVvVhM
	 8vAORisR5AWAo8jGC01Z9X7tVvpbNAifSFbPfwJ/t6lBGrC7t8PyzuD9kdwe5H3HKv
	 GU+1vER2GfM+vFgu+y/XGBGV0OAYLuiibbidLyxaNrTDKIdoq9rSYoHmd/xKyWkeWz
	 ItnMJ0REN9zOyaClBoPMq9Ext+pa85O47tNtQYnAICcBsX3iNLkBsFVgvJT0mtdWmb
	 YfsleQt6mp9mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pan Chuang <panchuang@vivo.com>,
	Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()
Date: Wed,  9 Sep 2026 07:31:00 -0400
Message-ID: <20260909113101.1863047-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090321-blissful-lily-9edf@gregkh>
References: <2026090321-blissful-lily-9edf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pan Chuang <panchuang@vivo.com>

[ Upstream commit aa5f4decedfb4fc5cd0fe49ab256ad4304d192e4 ]

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260709033428.362970-7-panchuang@vivo.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 75b1e88d3425 ("power: supply: ab8500_fg: fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_fg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 9dd99722667ae..d7d402e6a407f 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3178,8 +3178,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 				  ab8500_fg_irq[i].name, di);
 
 		if (ret != 0) {
-			dev_err(dev, "failed to request %s IRQ %d: %d\n",
-				ab8500_fg_irq[i].name, irq, ret);
 			destroy_workqueue(di->fg_wq);
 			return ret;
 		}
-- 
2.53.0

