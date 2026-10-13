Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B205517BBD
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904339; cv=none; b=SDz9D/DLDThYBj5XO/uzBvhU9RWsQyyeDEdi42Fa0IAEQhVfkrAQGnEeAPeohnSbEz1T+VQekbTszrlQPyBOdIt6KHuXm+6Wo9MXG6jNjNtvb9s06QBS/QS3g4cO15XD/WH7uqv/gPQfRZB5YW8XY5AzRTaNxqtHQ3XvQjEJJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904339; c=relaxed/simple;
	bh=ukDRXurCrXU5H7z7Ls01PTWKkLDnRK4vWc61HRL4x2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmEZW68t5+4QeINt8Z6susbSkZHNS2HGa8Tb7kcBi+en5/ZXZrNPAy3BiMHPIBGcQY/Rdm22RgkVZj7dNmjOcGyJk5+t6FFex4vTixN8S8978XzLpNbSwP+DRSIWOWAWxaOwl/W0QtDamMyDvNLmPYBoTaWW5bcrOiVs/ljiawA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BybIAiZO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BybIAiZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797841F00893;
	Tue, 13 Oct 2026 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904338;
	bh=go0YMhGT7UkBfqQXM32nQjMWDOzt3GmFbsVwtic+sPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BybIAiZOZ8hJrB7brNzjlclyDbEPrBX6Scsvsl+CV+okxJ+M+DC3r0WmDwap53Szg
	 GLjApZ1mCby1D5HYxtMCyozmIPAuBwYHDdkJOSKjKxLTL8hbUrqiqmvN/C70ApD3c5
	 DjrkgU7IGWIzxjKQb45nry2+D+XV2cmry9b7UrjIvLHojovLMAWJohfYKlnGZIRPRe
	 5EsAfSY8kRxFaNE3sTPOi88iTHFTwh4KoAiPY9qHMDg6Ab/dmV97WGm4/boy+kKNp0
	 3oOWgLn7sx6krYb7YOP6yGfaJaCDnS++BoTdeghyRiiZyn2QR17unpnC8DfezkcCzm
	 5c3qObJqO/E4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] pmdomain: rockchip: don't ignore clock lookup errors on attach
Date: Tue, 13 Oct 2026 11:12:16 -0400
Message-ID: <20261013151209.103610-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101247-chapter-smitten-cd41@gregkh>
References: <2026101247-chapter-smitten-cd41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 4c66c423593e26273ea0d644906ed007630c6f6d ]

rockchip_pd_attach_dev() treated every of_clk_get() error as the end
of the clock list, so a clock that exists but is not available yet
(e.g. -EPROBE_DEFER) was silently skipped and the device ended up
without pm_clk management.  Only -ENOENT means there are no more
clocks.

Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/rockchip/pm_domains.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 0868b7d406fba..974f8a15e83db 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -364,7 +364,19 @@ static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
 	}
 
 	i = 0;
-	while ((clk = of_clk_get(dev->of_node, i++)) && !IS_ERR(clk)) {
+	while (1) {
+		clk = of_clk_get(dev->of_node, i++);
+		if (IS_ERR(clk)) {
+			error = PTR_ERR(clk);
+			if (error == -ENOENT)
+				break;
+
+			dev_err(dev, "failed to get clock %d: %d\n", i - 1,
+				error);
+			pm_clk_destroy(dev);
+			return error;
+		}
+
 		dev_dbg(dev, "adding clock '%pC' to list of PM clocks\n", clk);
 		error = pm_clk_add_clk(dev, clk);
 		if (error) {
-- 
2.53.0

