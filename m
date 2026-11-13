Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794559327;
	b=kEvixUXe+ZQJ3ztzv83TSVh+oKq+9h5YFjPcEbj0dhtn/N0iyNm5HmOFdIhtRwo6pKGQ
	 gnHG+txbdR2wNVbfYE6Tz2ISs91vObpadrxT/FD72JvhgUer0Z5zck8OD4OvXAl/Io1uQ
	 5cfw3TkH2JLSATciPUHkkTN6hTOVa62Wk9SwlYYHJwYtdHPKOO4k+No25iq1+lSwraL4v
	 AHwrJ68OXU9X0qCzEkpg492iNtWPciplvu3shFpDJSgSgFRrlvVwV8aoXiLSNBHZQ9Z0J
	 Su4UrMhKl3S5X2aKdxvsXP2b/7X6W2WxtdaUc9/6OwRoNOG7mFCfudx7MFkk+FFESIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559327;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CZQ974KYbgXTwV3k+XNhiOl05mnd5+zfgXjeJNb39S8=;
	b=KPWasuuAASYFHQpL77IZ4jIp4rQ3ulMfzT1X7uITKAgq2jMPqg5kG3UXItirnk0I1E6t
	 npbeAJDIHYLijRDLpwgLda2KmZGRrfcEa7mzsxc8zksltWZ1/dVcCiGRTfy8sjLJgQ9Ua
	 6Sn5mpOGL6lJyg8KYQE32ecfG7h1x4cTzvVspZFwSrc4GO+Gqod5vL5pd2BebDnp2UmR9
	 k3skgz7DQEejxSARxY83dAxXiBaZTh4sEhUd0mad5NsKQDgvwfQ9tapDvpmgGDPZ0A54K
	 ddKQ5W+LKP2Vh2phLx8ylZ2u2THkChzE28JoYqCso84TbpvCy9uCDOGv7ik1iAN9kMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUcRyxKK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28279606A8A3;
	Fri, 13 Nov 2026 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UUcRyxKK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794559327;
	b=pN+GPX9ZMLAzsxYYCxsBWDRw+ln+ZkEtt7rB+fraS2aTL8Bq4exighvWr9Cycb6t+lKm
	 rSvtxt4xV2XaD56b3F5Ftzvl2SnRFT066Digo1jiP6ktUyxhUNIeioScBl4l0+obGRgaD
	 mb9aGZCiec5eMyUPpPGXbU8AqRI7djMvviitq+lot0llBki20w0NGRKqF5clnaM1ajRJ9
	 NaAFXN0RAzjCxBSmLGRZ4xSgw8xXXzoQ/m63lKSoxsm/EroWg5P/hb2sEhHwJXj9B/g2a
	 gy9jte2uYCuMFtln7XOe56nH1+1zGz2MbXtGLzAK99LEARo1n08HtlJ0rVMzNg2UDhw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794559327;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CZQ974KYbgXTwV3k+XNhiOl05mnd5+zfgXjeJNb39S8=;
	b=O0LJyEFvggKIBI3ZHH0cH9BSs0uKkXcqImyy3n9/66LEgeN1dPxVZA3UJcQigf08ff7p
	 TLJ1ib98aEL0EmkTMlegaGffZRxox1J1crzuL5OQ3TAa3gjsQD3gYqZP82nTpnwv30UFQ
	 F7SUCY2BWCUU+LYALk7gVlNgewAFa6xXl2eo5eCH8DlhftCAY4mpQIXj2pyg1wUbc2TuH
	 AUwXDLKOYqUY4tGs0xt461MgoUg0m6PBl+F2TzE4WYnLsBNc7SwsTsuiHIG30d5N0tThK
	 PFD6C5GbTIaJlj9SamU0ztHKkZ8q/t5vYgjVP1IKceam63k4BIy7uQxj8gV1yBO9XsQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 476F21F000C6;
	Fri, 13 Nov 2026 08:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794559327;
	bh=CZQ974KYbgXTwV3k+XNhiOl05mnd5+zfgXjeJNb39S8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UUcRyxKKJtWuaEWt1nHQ/ODlcyaFOFz/6/WBroKFwrdXfFuzpAo/3AXl8WnwnSl+E
	 Jaz5tRL4ccyM0J8zXsByYCu91IEJro3MVhu4w7iiqYB2rdQdvwgkn+1KUMeST2QUUF
	 NkbYqSxlIhE+n/6Cx+S1vmazwD/kyVDSBF/6e6EpSKzsrcUCmWCcXc7nxj1W7OHzgh
	 UTQJ0syi+XRcFhjvKxALN1hX9U+kiwOyCxcDuEU+ige2qHNXXYJ8/B8PGw7RqnNeL/
	 rURh/wP/hj5JiNHv8pIqYuJD258/gP3l7P2z9eO4gOuS+TkMDrFh9NFBGR1bdSyV24
	 uZennvAtxVYsg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C9C44476BC;
	Fri, 13 Nov 2026 08:42:05 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 08:42:06 +0000
Subject: [PATCH v3 2/3] pmdomain: rockchip: don't report probe deferral as
 an error
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
Message-Id: <20261113-pmdomain-rockchip-v3-2-b7039ca30b87@gmail.com>
References: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
In-Reply-To: <20261113-pmdomain-rockchip-v3-0-b7039ca30b87@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yao Zi <me@ziyao.cc>, Igor Pecovnik <igor@armbian.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559325; l=3789;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=eOrDJPTLfEW1xbio4U0pPlpSLvwzZMxXL5lZvNK4rA8=;
 b=AvrffsDE4+u4FUgmu9CMr1tECJc0bIbqCoCD2K9p6N1N1bi/AXG7SFl4ybD9NpWPQemr2V/0g
 HchCHMTmjCcBFjqy5Qwe7WxEjYDrjH/Imgb2c6N7PQvDg62lUbS3/3R
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

A domain clock that is not available yet is printed as an error by
rockchip_pm_add_one_domain() and again by its callers, on every probe
attempt. A pm_qos syscon that defers turns into -ENODEV and fails the
probe.

Use dev_err_probe() where the errors happen, keep the syscon error code,
and drop the callers' messages.

Yao Zi sent a patch for the clock message earlier [1] and agreed to drop
it for this one.

Link: https://lore.kernel.org/r/20261105001257.1368266-3-me@ziyao.cc [1]
Fixes: 7c696693a4f5 ("soc: rockchip: power-domain: Add power domain driver")
Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
Fixes: 074c6a422d86 ("soc: rockchip: power-domain: support qos save and restore")
Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 37 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index df3f43d0c01b..a0b47d8c4b2a 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -849,17 +849,20 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	for (i = 0; i < pd->num_clks; i++) {
 		pd->clks[i].clk = of_clk_get(node, i);
 		if (IS_ERR(pd->clks[i].clk)) {
-			error = PTR_ERR(pd->clks[i].clk);
-			dev_err(pmu->dev,
-				"%pOFn: failed to get clk at index %d: %d\n",
-				node, i, error);
+			error = dev_err_probe(pmu->dev,
+					      PTR_ERR(pd->clks[i].clk),
+					      "%pOFn: failed to get clk at index %d\n",
+					      node, i);
 			goto err_put_clocks;
 		}
 	}
 
 	error = clk_bulk_prepare(pd->num_clks, pd->clks);
-	if (error)
+	if (error) {
+		dev_err_probe(pmu->dev, error,
+			      "%pOFn: failed to prepare clocks\n", node);
 		goto err_put_clocks;
+	}
 
 	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
 						 NULL);
@@ -884,13 +887,18 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		for (j = 0; j < pd->num_qos; j++) {
 			qos_node = of_parse_phandle(node, "pm_qos", j);
 			if (!qos_node) {
-				error = -ENODEV;
+				error = dev_err_probe(pmu->dev, -ENODEV,
+						      "%pOFn: failed to get pm_qos %d\n",
+						      node, j);
 				goto err_unprepare_clocks;
 			}
 			pd->qos_regmap[j] = syscon_node_to_regmap(qos_node);
 			of_node_put(qos_node);
 			if (IS_ERR(pd->qos_regmap[j])) {
-				error = -ENODEV;
+				error = dev_err_probe(pmu->dev,
+						      PTR_ERR(pd->qos_regmap[j]),
+						      "%pOFn: failed to get pm_qos %d regmap\n",
+						      node, j);
 				goto err_unprepare_clocks;
 			}
 		}
@@ -1034,11 +1042,8 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 		parent_domain = pmu->genpd_data.domains[idx];
 
 		error = rockchip_pm_add_one_domain(pmu, np);
-		if (error) {
-			dev_err(pmu->dev, "failed to handle node %pOFn: %d\n",
-				np, error);
+		if (error)
 			return error;
-		}
 
 		error = of_property_read_u32(np, "reg", &idx);
 		if (error) {
@@ -1128,18 +1133,12 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node_scoped(np, node) {
 		error = rockchip_pm_add_one_domain(pmu, node);
-		if (error) {
-			dev_err(dev, "failed to handle node %pOFn: %d\n",
-				node, error);
+		if (error)
 			goto err_out;
-		}
 
 		error = rockchip_pm_add_subdomain(pmu, node);
-		if (error < 0) {
-			dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
-				node, error);
+		if (error < 0)
 			goto err_out;
-		}
 	}
 
 	if (error) {

-- 
2.55.0


