Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86143F23D0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903129; cv=none; b=iLasVclUXoSzJfsrfIuRBoA7D/SHTTohosUKeFl0740WFUM3kFewRr2oNx5e9tXjQSybtGct9SnYCeFZLYshLsXQgn3FhobkNOPwxZu5bMpdfehOCb7F66HMcpxc+gy3m2YgDP9AV8gn2yr/gebe8bz6GJX78bPVaTs35oaPfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903129; c=relaxed/simple;
	bh=oX9jJI8/2N4SqubxZSKiXm7VvkyhhvXe56qG3+Vddg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4uY+JOJ5yyn7Vvmx0BEcYs66z2CQSWoVL9kYDLNP7hphGsCtG+43tSlKL5+eGcClqY6hClyDg2hWzXbakd1VQyxXHKI/lu1/fT3rmRjl9ryAHt4TlJiKl/XUHpkLkxHEOVdMNsQBD56r9xtwCSA4jYlsP9wvEFDBFPSSWBw7Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSVOq67G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSVOq67G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDB11F00898;
	Tue, 13 Oct 2026 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903128;
	bh=eyovda/6rHWHN7cwM1p3TVX8fpHmiy0QM31XXkwbV5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kSVOq67G3Bw76JinNc/DE5vFoZOKvwFJ8CG/cp2OmTCe04MsorgZT2dmEVKjBGdLi
	 yVlRYW3BuWRhA7ga4uCMsjJ5rWDQJTW2S+xUtFIA9CJiHs+p4yk/BKd35NNI53gzLW
	 RU7eh4yiTSfHtq2z+co8sl7yfKP6Dm8nqq6HpTbW6olnqKy6DpwX98i0kDtkIe5Wmb
	 muulvnBtW7KqPZsnWNjWw5Kmgwz1/R4fXz+MPU22eVKSzgqFMeRvY9jvxJbYBfiiKV
	 JBIgFwsTkezPBomaWJtK1L4hwvc+VfyJtZyyZKxH4HNdt9I+ighvcHcTre71KCoFrs
	 S6f9EgDz6s5Hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: rockchip: don't ignore clock lookup errors on attach
Date: Tue, 13 Oct 2026 10:52:06 -0400
Message-ID: <20261013145148.74024-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101247-marshy-gerbil-50c3@gregkh>
References: <2026101247-marshy-gerbil-50c3@gregkh>
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
index 5ba582ffaa1a2..1a21848609e89 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -507,7 +507,19 @@ static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
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

