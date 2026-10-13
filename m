Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A83F871B
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903489; cv=none; b=WQUD6mPaMMZUI8wKjbMJLlDCAKK5Kk/3mEnsIDfNQv8n4BTOWNi+1iciihs0xwsaeBBLClk7RCCsEYGJbzWnWvtmjp2lfWhBawiu2yN2+iGXGfKlfTO9nZD8I5SSMAOOEPyrZsH5LjLImxYQATd6tShNlYQ3UaZ+xwxXGcVelUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903489; c=relaxed/simple;
	bh=5ao+Z54WuUjvwffl1JtYs+tlY1IzYp6LHZDIokv4Fok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hj9TNVnVOosF3qTfNaaR/Zi44aNmOMTIfSrYIDJZpivXgA7B/T3ZfhTfUIZEdoxHrI0gtMjg6mCKofkZveTexsVBE4f6ly2xZ76Tm2WDZ9p3VINHwF1kdfEKaGU0DX9NTsRXgaM2WXyJHGUJH2Cq0ke3sQ7EnCljG2ZduObeAms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYUhliXA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYUhliXA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDAD1F000FF;
	Tue, 13 Oct 2026 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791903488;
	bh=aYCmv95XbVCTstzIU/OwARGkP9It/K/B4aFkPuzhBJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KYUhliXAjy/946Ch76JVtzGvGQB2O4Rnimt3isYd5EOMcoOuwNU01K4+HE5CEXIP+
	 ienyMBzP9Z91wTGC7KpMKHlA4FQwi9NEZO87KFPA9QWlepfa8Ds2N07JVKdTXUarzo
	 6pBkkQu6ImPqMg/gYw1k6KwHgFfbVZmadg+LyaS273uqQyeBCq7V4mjZBmRF358DKB
	 udZ63ckL1iUrJXKaw3apZcF5mAvYyUMxOlGq3fcC9YTPkGmqt+q45WZ7dmhJMaoGmW
	 P4tCNzpt/UYTqesnw5YM9H+oWjnVjphnq+Xhg3Vrw336fMBssmKKwp11s5nPIavAWS
	 DGKvth+MToFzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: rockchip: propagate subdomain add errors
Date: Tue, 13 Oct 2026 10:58:06 -0400
Message-ID: <20261013145757.103437-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101216-quantum-murky-3a7f@gregkh>
References: <2026101216-quantum-murky-3a7f@gregkh>
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
index 5ba582ffaa1a2..0a22bd2324e6a 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -755,7 +755,9 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
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

