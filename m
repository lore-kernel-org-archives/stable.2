Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E740517BCB
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904345; cv=none; b=QDXHF/xPFilD87vFtRvQiSUp0tFQmQIuIj4kJBC1ye9B9C8v1GE6rnpBY8urvyFYT96FF7kfmiI8bIqBg3Xvr4ZVgdjEg3ohnneNfIV0cuCx52qdGakjP6ZhK6G6ytNlU6t+cY50OyE84JxbId+1ZCI1GEQm9iHpVegClXzmTvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904345; c=relaxed/simple;
	bh=Q0dOKPsVJizLh4TgJUMaqb8iRXWfabyQf8dzB5ht60Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDAnBtsfc4bLv8pnHcSLEVYWq12jh/Adk1dhBCBwR4tRxA4jedvxOIxsWImQNYhkDhUSahT0r3EVPBtLdTAsqiPK76YHhMxrDiSKCDHUEab0jLy3xO+OU3j48yxS6la6MEqIDb5PNDfbuEbX46a8I+bkBJLVtdKtLaz9dxTJTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epjw8Sg6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epjw8Sg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760421F00893;
	Tue, 13 Oct 2026 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791904344;
	bh=f/fBz9AACAm605LLkT3iSyIwpWKlaSfTFglyAjyP6v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=epjw8Sg6Xw6fC9RHi8xsuTi85j6ghcWyA31UKCtZUMGteONskrTQSFICkm8hWiMGy
	 PEcJowkYD2jk9z3ai/2eNRGdR1Kkf34C9f+2UobmynvyBLG7o3sfqOp5cZ2+J0XC6e
	 M7hqgrTFuGnUqBB256s7HYu3tILxm8J+8fiNXQYRMRqQI7WmORIDqQ5C3RGU3FXE5s
	 BEO7Jb95ei7fwPEroYMwf7lqrQH3tDB2u3CqkbNB0Ro0MdBUXmrbFmZCRYX3MQlJuO
	 2qKK7vqLhqOCoWXMktnXp7ShzYp48NGK9AWQ2RomjnJxas4/AwRcuQowqEI2V8pdL4
	 GM0P6JA9Sg+rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] pmdomain: rockchip: fix clock leak on domain probe failure
Date: Tue, 13 Oct 2026 11:12:22 -0400
Message-ID: <20261013151209.102419-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101258-outdoors-settle-2eb1@gregkh>
References: <2026101258-outdoors-settle-2eb1@gregkh>
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
index 0868b7d406fba..67f78378d7f13 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -443,7 +443,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 			dev_err(pmu->dev,
 				"%pOFn: failed to get clk at index %d: %d\n",
 				node, i, error);
-			return error;
+			goto err_put_clocks;
 		}
 	}
 
-- 
2.53.0

