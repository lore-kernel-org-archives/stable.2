Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257E50C280
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904556; cv=none; b=A1/oDrFDasr8wyxrXnCq/7hz2FqgOkH8DrY6qWBltld+pez5z3+uhskuOPOntVNiVza8wpweNkjXHnxcgrufcr2qxT8dGq3z0Tmrd4DgU+i2MGXsJJV+fKxU2B+GUxPlWqUM3OUYahlWXEyIQtSdM3jII0+nKQdtqFCizFBUc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904556; c=relaxed/simple;
	bh=px0ujM1DwKDe7sxllM4xWDvksOsk0k2yKEabK/At1vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLpSnvbj5NrJdpNJ28ZdGY6Tww2KfM5k7RyyJrX5ZWLqZmQyued/E4m3NvsZ98/+iNUFCyXrd2X+b1okIe4mcl/DZgbyaaDt5cLR1NBzi/48q77CKNngX5qMm66rWhxO0dV1vUM150qAPIBPX15CVRwEUg9QZL69xBCRNCiG69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxhQPYba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxhQPYba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D87E1F000FF;
	Tue, 13 Oct 2026 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904555;
	bh=333zJYP0b0KpVeLIrIKyG2Z0+bLBtLZpal1F4KzdKRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lxhQPYbasXKf2BorQDVvJjF7m2T6OSdJrV4YwVhFcOuguCAIhQB6s4UWUzlikoidI
	 ZFDiUgFNWusvqi6I917E82k7/JMhC0wbHD3vW3NTm+gZee3b8Fhdi0751eFSYqK5je
	 PlIfa9iekZj+o7Hqvr+2sxGaqTowH2kX+S37jomzRnSuDbyAaAiqKdKnmOjMVdT7ox
	 47KeGf+e7IPOyk3zVJIGku4Tg+Mjei+xjOX8F5srmWdTWyIyyq3uv8bksWiQj2oI9O
	 373lo/nQZIfETNFtw/ufiS/Ep4jNf03f2gRWPpcXC0oVNARiZarJpFx/iTZ+NRX4mv
	 RJXQ8bOXvl8Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] pmdomain: rockchip: propagate subdomain add errors
Date: Tue, 13 Oct 2026 11:15:53 -0400
Message-ID: <20261013151544.125933-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101216-brunt-lubricant-e88b@gregkh>
References: <2026101216-brunt-lubricant-e88b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 4c0d69d677cf5b0065ebbb3ceb8ba66fddbec630 ]

rockchip_pm_add_subdomain() ignored the return value of its recursive
call, so a failure deeper in the hierarchy was silently dropped and
probe still succeeded with an incomplete domain tree.

Fixes: 6be05b5ec161 ("soc: rockchip: power-domain: add support for sub-power domains")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/rockchip/pm_domains.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 0868b7d406fba..2b22ffea4bbeb 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -617,7 +617,9 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 				parent_domain->name, child_domain->name);
 		}
 
-		rockchip_pm_add_subdomain(pmu, np);
+		error = rockchip_pm_add_subdomain(pmu, np);
+		if (error)
+			return error;
 	}
 
 	return 0;
-- 
2.53.0

