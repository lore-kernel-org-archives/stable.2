Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A647A895
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907499; cv=none; b=RqyjIjt/pEmvKqCXNTCQydnzCR3vuPibbQ3m4N2F37oAulaHz8yEsj1Th+PcctaX7K4UKD1fUXb3MzWB3pPWOQNgFtY4Ofgwv/cNZcT8qcIPBXiWwTz1E9JYeSXlsY6OPqx80WJYkB1hJ7iYIaMf7/qerksYpDjmFoi9bFegONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907499; c=relaxed/simple;
	bh=iIJVup16cVbabW2BGhDe0i6tmyF710pK5J+ArAwbJdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfpAQFVDVIeG9xf6qWMKEtUYuJ6hqqVzY7gPUfdAeaGNCYi84R04jBQGMqVxzZLE5AtfeIw27ieb6t8k8G7AUoypf45DiW4enWZYxD2227l+ay9uo/YBcaMxRFab8FC3bZ7bg65EaqK/sapzAOQuZ4s2zGddVlWjo9xVopSivMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7CpZkVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7CpZkVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD301F000FF;
	Tue, 13 Oct 2026 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907498;
	bh=oez4A2F3Qi9Pdy42vZ2246yDRPaXmUILX0cQj+pNmLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7CpZkVsdDY2ZEbgHGCGVCuiZ1Vd8ebUzuPrFg/2jFFqgkqHw9Tbua155Lx8PXb+y
	 31t3LwCAfneTjZHMnKywozu4650lCpcQEH6MeRWRS9LveqjRi+3sv1/+m9Jp4zOdsg
	 jMXsf4r09pOqhWH4mENl011st3JPZLxvBUoKaxPTVo8hZcYgg6DHyGrRXem+dW2eJ4
	 FOBGtMYZ3jD/ksv1l01x8syi27w3BQBNX24FnHQmMG+JsHBJ0JoVW9E455CoiYbzIc
	 NP+co6Liha7oFiWWBT6INPVjA++YxZnAxH7412LW0NYbeOoC/wKquoymU6vqagBvr9
	 zIdEV4SdMR9BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] pmdomain: rockchip: propagate subdomain add errors
Date: Tue, 13 Oct 2026 12:04:56 -0400
Message-ID: <20261013160440.222189-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101216-thousand-footsore-3cfc@gregkh>
References: <2026101216-thousand-footsore-3cfc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
[ sashal: Adapted to the Rockchip power-domain driver’s older location in the SoC subsystem. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/rockchip/pm_domains.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 54eb6cfc5d5b1..bf20400b076da 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -606,7 +606,9 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
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

