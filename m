Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2885208C6
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907505; cv=none; b=kuME30/F5nm1AX8Z81kv98WTrVBQq2jH5xSqcDaMuQqbCIqVGHatDPWrY8ITBJQVwJ6AUmgCVNESoVNyBDlF+Cmsc3GjvBmcJXvay2lHciZFRU/fkAqZUV8edSpJEk2vGvDyg/5AyP/t4I7FSQ0Ao3aArFh1cDGa7RlsAoKf0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907505; c=relaxed/simple;
	bh=D2agpoYidEnuJnL9AEmgVoBMmk45jFjypt/UOWxbIQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISCMO3RIX+Zl2S4hL5rQj91y7v2N2i6Ic+1zMBWNjxOgOYQOm7TxLBSXWXidLj0riyA88Fb+HFXci7OgdA4jdTq0b+kdDnuWZL5ZGuYtjmJhyFoYb3Lk2QWeJirWEXr0ovGrVFzQWrKiaRZOaW45EYHCAHzid5RJ3Zk/hsRPCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcbat8Uc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcbat8Uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F421F000FF;
	Tue, 13 Oct 2026 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907503;
	bh=WJTKsgvS0zEjh/0Wv97L2QciFRLn20kEnhpbPU862aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fcbat8UcwZ45ttl5xkNr9ZipTBvcaZaTV/THnZ4b5+beUTLyrvBJYU4XUyOglfldS
	 BX+McrEE6S2wL6M1BdwKVPsWOhBFpw8uvgsoYmd+KWvNlQcaF1NIHH2ki0yWHhBEGW
	 NoAqM4a8u3I/sQkIMA44DR0l0Vy9Hq1jWE2KYzvIqEPcUkjGc25CEw+Cmxr/D1JNkQ
	 wbNUcGteB6q8QkYCQslSnolAScD82+dmYvPpa4LgwT7Cp3BS/UlznMOcbjgXPNxxP9
	 wUnFpKK+O0IzEJwal295tBq680g0FPoFjBeNj6/Z+HR3M6hAC35SO3so6PFpUrVjce
	 ybTT4BhtRZWiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] pmdomain: rockchip: don't ignore clock lookup errors on attach
Date: Tue, 13 Oct 2026 12:05:02 -0400
Message-ID: <20261013160443.206626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101248-refract-surgical-1e71@gregkh>
References: <2026101248-refract-surgical-1e71@gregkh>
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
[ sashal: adjusted the patch to the Rockchip power-domain driver's older source location ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/rockchip/pm_domains.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 54eb6cfc5d5b1..4ae9f91eedbf1 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -356,7 +356,19 @@ static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
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

