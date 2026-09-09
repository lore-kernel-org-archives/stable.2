Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A295427E9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952923; cv=none; b=SNqrKRFGLwkH9DVbr/dJj+pqwY2u3CnD5t81+VLYJTWTUYJj6s+MEsl2SsjU7/pFDmJb+U3tvSOrI+ZG1uwnZb4I8DdtQv2gSprLPxCJkyvC6/SIQkCIGw9nRFgJU2mXnjU1jNrPAETBC/cRYGjnpid8lOiiC/doAkVWtAE6KEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952923; c=relaxed/simple;
	bh=l+vPXRxm5sXZIKNEnzZmxqdEYDW4PC8TT2TDeuZCs3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oalu3ny/5g2l9BL6UeYzmWM1m3FKJmacOyrEAWMzeBk6j4i2F2J56XX2TA+xvEXy0jKGOOLZCxstoX9PjHOO7rSWb5X5MZ/FRBq3AepOtQqANjDdgs4K/HEWMgStHCVOAtqKZGMEAuMCEkMkXocRadZOiIaBWnSKhH0PFp4e3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzVjbFXE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzVjbFXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775EB1F00AC4;
	Wed,  9 Sep 2026 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952921;
	bh=75QD3h7gOcbE9IpaP7R4wa5g4nTaax4x9q5Z8vvtHds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XzVjbFXEocV1445MG8r7045K4c29MAZWVrozTb2hhuMJXXeI2foNIHekp4RCEOtPe
	 aqujB2TXBxEes+hhA4IULKkw0NcA/AUHeqV0hGypAm3Wj5cCtjPNHrQi3JZE9MKVwE
	 vvCMPhKUOaaOrBIfFABxvyJC5AGix8ZHI0d8pKIk+N6bRuF2AxgyXd3j8a5+HufMsE
	 V9cOmtiqrYO078DeFLj72PUpNowlITheq8ZqCmEcsb55viRzNoSdix1sLZUI5SKI7L
	 jaC1oL2K9qIYaZWVK/yLc5EtTgdOdR2MdoEiPY63AIJNaiab2egRWsSo6D7M8NNiIy
	 vd6ckvxFHkp/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 8/8] power: supply: lp8788-charger: fix use-after-free on remove
Date: Wed,  9 Sep 2026 07:21:53 -0400
Message-ID: <20260909112153.1816689-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909112153.1816689-1-sashal@kernel.org>
References: <2026090353-unadorned-buffed-09ad@gregkh>
 <20260909112153.1816689-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 831c29a12d560f8a3225f43050b3fbb5dfd79c66 ]

lp8788_charger_remove() flushes charger_work before unregistering the
IRQs. An IRQ thread can queue charger_work after flush_work() has
returned. The work can then run after devres frees pchg and dereference
it in lp8788_charger_event().

Unregister the IRQs first. free_irq() waits for any running threaded
handler, so no handler can queue more work afterwards. Then use
cancel_work_sync() to cancel pending work or wait for running work to
finish.

This issue was found by an in-house static analysis tool.

Fixes: 98a276649358 ("power_supply: Add new lp8788 charger driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260802035442.421697-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/lp8788-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index 54f663ba95700..3cd2238fc5d8d 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -711,8 +711,8 @@ static void lp8788_charger_remove(struct platform_device *pdev)
 {
 	struct lp8788_charger *pchg = platform_get_drvdata(pdev);
 
-	flush_work(&pchg->charger_work);
 	lp8788_irq_unregister(pdev, pchg);
+	cancel_work_sync(&pchg->charger_work);
 }
 
 static struct platform_driver lp8788_charger_driver = {
-- 
2.53.0

