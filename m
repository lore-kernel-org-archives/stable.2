Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF6435AC03
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907512; cv=none; b=fPMa9cvSeB4UE/HpIKTX/PdoCJv+YkT/O1XmxQqdKYY8OT7gHFsv0/ukJ0K1uxHkXKyst62yFWujUWU5Xix3hNS6QKTQKenhdh9ifxPr7GdUEvltrwH4Cuuo7fN7xRZ+E1Wk8HRrNfFvklQ6xJI/eganxwsr5IwbvQzb5QEtIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907512; c=relaxed/simple;
	bh=rLDH+K1hDcDEG08uLxtPVPfs6Bs+c1JMmOTfJqYoW98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdRk2ZkbizD91foYDCgyLecmKY6SG+twdIfzLscAFHSWN1YuFqp2aLO7lxsLehBATCcCiNFdhSDFGNbRv6Ox+2o75wkeZ/10xD5FftFX8BIeqmcex+I21SWwo30PiMxXndNIq0c2nE5Z21cXXYKyx/1Y010Mj5eSxekXOuCRct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGPbe8dJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGPbe8dJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9477B1F000FF;
	Tue, 13 Oct 2026 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791907510;
	bh=tO9imPMT67wQdHKoJw9tsEpMSZEvQjhoK+DFetTBnrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fGPbe8dJL2DswHCTQbwG61LdUUEhQ44GYybQ2FfDTfReMx/T1koC1bAvhTW9k+nqi
	 XCnZWRjY3Jc9R7pqnA+LoWVyAn0tYgJ/JW23wQ+VR4Xj8HYaf6n4CDiazOOrJWJt2k
	 zju5ml1a0hdgFIYXIEknD6OXfaRim7VLudxq6GCwu5oPfBJ6SjHiiX/1kxnpnPJbDV
	 311JtmbWEDaNjRyXAfFA9Cypp1GR0kfvvoXR/LHIFNeLfULUS/KHiQkkCm6kAkBcbT
	 8YVDMyr3TAdY9aBBszljqcJH/6DjTtUBi5HrVqPQs0jxmL7kpSkKCvfRlea6WiSYQH
	 JA4I68VrTKRmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] pmdomain: rockchip: fix clock leak on domain probe failure
Date: Tue, 13 Oct 2026 12:05:08 -0400
Message-ID: <20261013160442.207289-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101258-shelter-salvaging-8f8b@gregkh>
References: <2026101258-shelter-salvaging-8f8b@gregkh>
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
[ sashal: adjusted for the Rockchip power-domain driver residing in the SoC subsystem. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/rockchip/pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 54eb6cfc5d5b1..19034afd2d7c9 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -435,7 +435,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			dev_err(pmu->dev,
 				"%pOFn: failed to get clk at index %d: %d\n",
 				node, i, error);
-			return error;
+			goto err_put_clocks;
 		}
 	}
 
-- 
2.53.0

