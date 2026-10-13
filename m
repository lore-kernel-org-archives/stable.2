Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ABB3C584E
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903120; cv=none; b=piPaMwlo34AGYjpSZNIi7VGbNMr/mzweoamsQRxmMIg+embtSKfijWFGery76htIH7YBuEt9qGpiEoaVl/S8vUBvtO9r33eqx/JdlkLKRg0lnYc9bUmpGllblbBfeP5uGgTCIWLcc6/Q8mByqwxzx5gQC5etZpoZuCBWlratgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903120; c=relaxed/simple;
	bh=Gb/O6sHErbsF/NW2oEPQBArcNNBQyWiWc2yMAUy1CfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCAV5EKbb1v2/2I4YhDQxFnRZf9SM4RSJnS1I2v3LGO4Y7DOANR37HXD/hzNphHQ5R6RpJVBTNDfQDWfxMjtBjRcshD0pB/xKAuYwjBnhyjwfLU4hq3OsxQcVoT3+n5geyxhWiJ1ViY0E32Y82G9psOFgAajCcfJ/buekeXVYSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgD8rShc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgD8rShc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267091F000FF;
	Tue, 13 Oct 2026 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903118;
	bh=yimjiOEWrji31MVD/woKIbJxTQy7bH/d9XPRAaFw8wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WgD8rShcSK90mLBVKdZwqPLNp/mnQfPrlx87OIp7e4EtcEe1r6B/J1lo7Ry/XrzDd
	 Om63BNDvCtMzVHcCte2hXKlTe6uRzdgnzCdI89u+tHLZRYiY2t+F/SbWDh9q3+kxmO
	 /0nlahj2UwQ+KfRdYbOETEj6D9YZRzNweLREHP0SKHuvf0s+ovkSXuERDWDZLxMsLY
	 8UfJphDHyLEOPlEcgeMp19/fmIa2yT+IHe31Cvd0rChN9SSG5n5UWlG+dxf4uIxMzq
	 Zx/VoRJTSUW/M96fSsT/omzVSYzMqs6sLzFKErCzcVSCrFd1VXXdxDYfjh2qHEzsBa
	 aVwRaklmrxyfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: rockchip: fix clock leak on domain probe failure
Date: Tue, 13 Oct 2026 10:51:56 -0400
Message-ID: <20261013145147.77618-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101258-reforest-facedown-1968@gregkh>
References: <2026101258-reforest-facedown-1968@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit d8b3847770661b7109146e6479eeadcdab9cecf0 ]

When of_clk_get() failed in the middle of the loop, the references of
the clocks acquired so far were leaked instead of being released by
the error path.

Fixes: d909072d0521 ("soc: rockchip: power-domain: use clk_bulk APIs")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/rockchip/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 5ba582ffaa1a2..32ea21cd39133 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -589,7 +589,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			dev_err(pmu->dev,
 				"%pOFn: failed to get clk at index %d: %d\n",
 				node, i, error);
-			return error;
+			goto err_put_clocks;
 		}
 	}
 
-- 
2.53.0

