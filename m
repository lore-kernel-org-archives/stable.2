Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917B4B2CBB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951553; cv=none; b=nNkK6qdcl5iTdquv0aHVmwwvyTLLOBR5iocrs/m82q8unSA5qUVsKfoZTKH7Vl8xwUCdUA9FYjl6UpOu1P60275BvfgeYuhk5agXo7Qu3CQEuh+49B2yQZ4xrMtKdDmMtDGqc9Brs3QOjOB4wlZk4DJkiHWu8gM5uJHCZlLVyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951553; c=relaxed/simple;
	bh=FAzslEOBIjBc1ilJ7hytF2OASVx4TrRszAeXUOePBxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4N+2JdYglkPgNWwk0YdadK7VXr9m3WMSfwLgit0Naf99vIlMS5D3ZwQZ4spLbtgksfjTERoHeNw2L/QoemwVsKQN4vfUfQWjYj42CCQm2Zh98txDKBMMXmKdpb81Pd8M7B3HlZaOckGCVHfa3TNeMvqN4kcMHyeEvwP1Do3kZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0Zobi3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0Zobi3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BED1F00A3A;
	Wed,  9 Sep 2026 10:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951546;
	bh=wQdlX4MXxz0Bd54TLipY/uhfJWJKTr9H5kr7/0FEHUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S0Zobi3I1p3Pdzfd51rlWd/piCT6pFkUHHOnC64kwheQ61BU7eRR6Un24KFIuzUI1
	 vO4TIXHYiI82X9124yZ8y4FwY+BPbyNJseTX0iIKr5oIyiWpL+BwCxsPpmI+0ACvEI
	 XvUswczXAyKvGhsK+b30e+jX0JjBquyMCnF71L3U4pfFLev3oWwxa8TGHbStYSIN3o
	 hk3dEpciQLdS/l1na07IALtMYQf1x38ynfU1+kblC8Z4OJCtZzp/WeH6t/zeznGjv6
	 xZkpDNqPO2O10vY/rI0FkQ939zQSI+2PbseJ7wk3sDei1HesRLLu8GAOx0Yo8/s+D+
	 d8Jy/9qISjMHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] power: supply: lp8788-charger: fix use-after-free on remove
Date: Wed,  9 Sep 2026 06:59:03 -0400
Message-ID: <20260909105903.1646806-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909105903.1646806-1-sashal@kernel.org>
References: <2026090352-shoptalk-president-e8c6@gregkh>
 <20260909105903.1646806-1-sashal@kernel.org>
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
index 98c15b7abfb88..cf797bf7f6484 100644
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

