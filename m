Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F345678DB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973080; cv=none; b=IEhceqayaqcf9Ic8qTVE8dsvHfgEHZgfWB6FJIg/RE7AKFii5U1h66Is33zuKQZOEMTJUor9DSgs3OBRuwrpz7yq7Tjg5sQtQZoU3x+HRQ80wsSaI/CWmi/u96szEwdNLp1sofIwSeJcHuSkwGuNzV6CmJJIMpggbNKAUzv28uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973080; c=relaxed/simple;
	bh=SCP+sJYeUlqDE+NnlkAi0pTNH89BQDCFhmlzZV9evIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cel7U3mp22I99XXfytfzHE8wsEM+IzJfaCERIZfvFhhqBPu7XcShs0m0pEzNnuZ8HD2xB/8s9GXYNgTTPX7QryS0fHsjHkVUto7IrhLCsMoT5fVAXnD8F5n5xvR9k63oF87M6I57rWcvfNSzxfax3BzJhbwyr21lk5gQ2Dgi/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofmWXhmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofmWXhmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3506C1F000FF;
	Wed,  9 Sep 2026 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973078;
	bh=x3WGdzMrc9wPdmkd+/vpGzsnsO6cQIPJhuQpVqJd39E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofmWXhmE4XfDaEcemZa2t3ooHi+ach6EgVWjn1+EowAVplWjtaipqrlzRaIRP5st8
	 OD66P98xP4A9lbPggHyIuIqDpaalj0vzDak1U+Jb0VVo5EMwy+BZjknbnO9HyT05KX
	 Gy2dE+lOJd4PIGzyTtSPcS9oPjLz3mMNaoQ6qsxHwsbn8/GkUoVVwksEmaVPWPsTlH
	 6ZuNNJnuCSdFZeX1BznuaWNlBsVojxPUmCfxKTb70ofq5Drle7xPo73amy0hypmfsp
	 iYCjks3ASDIGUP4jQQnAKlY1kk+aeP2+2XbNPqNpHbF7PYhFQAtI9n15YDGnhrt5+G
	 npxdbdDzRFGPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] power: supply: bq24257: fix use-after-free on remove
Date: Wed,  9 Sep 2026 12:57:54 -0400
Message-ID: <20260909165754.3145389-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909165754.3145389-1-sashal@kernel.org>
References: <2026090327-map-reptilian-66d3@gregkh>
 <20260909165754.3145389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit 9d34c9d660c3d0931d2cc749c46c47cf31f96e48 ]

The STAT-pin interrupt is devm-managed, so it stays armed until the devm
cleanup that runs after remove() returns. remove() cancels
bq->iilimit_setup_work while the threaded handler can still fire; that
handler reschedules the work and dereferences bq, so the work runs
against freed memory once devm frees bq.

Make the delayed work device-managed with devm_delayed_work_autocancel(),
registered before the interrupt request. The devm cleanup then releases
the interrupt first, so the handler can no longer reschedule the work,
and cancels the work before bq is freed. The explicit
cancel_delayed_work_sync() in remove() is no longer needed and is dropped.

Found by static analysis.

Fixes: 2219a935963e ("power_supply: Add TI BQ24257 charger driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260731143554.334179-1-fanwu01@zju.edu.cn
Link: https://patch.msgid.link/20260801051958.354528-1-fanwu01@zju.edu.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq24257_charger.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 96cb3290bcaa1..5c331bba3b35b 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -18,6 +18,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -1020,10 +1021,6 @@ static int bq24257_probe(struct i2c_client *client,
 	if (bq->chip == BQ24250)
 		bq->iilimit_autoset_enable = false;
 
-	if (bq->iilimit_autoset_enable)
-		INIT_DELAYED_WORK(&bq->iilimit_setup_work,
-				  bq24257_iilimit_setup_work);
-
 	/*
 	 * The BQ24250 doesn't have a dedicated Power Good (PG) pin so let's
 	 * not probe for it and instead use a SW-based approach to determine
@@ -1064,6 +1061,14 @@ static int bq24257_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	if (bq->iilimit_autoset_enable) {
+		ret = devm_delayed_work_autocancel(dev,
+						   &bq->iilimit_setup_work,
+						   bq24257_iilimit_setup_work);
+		if (ret)
+			return ret;
+	}
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					bq24257_irq_handler_thread,
 					IRQF_TRIGGER_FALLING |
@@ -1081,9 +1086,6 @@ static int bq24257_remove(struct i2c_client *client)
 {
 	struct bq24257_device *bq = i2c_get_clientdata(client);
 
-	if (bq->iilimit_autoset_enable)
-		cancel_delayed_work_sync(&bq->iilimit_setup_work);
-
 	bq24257_field_write(bq, F_RESET, 1); /* reset to defaults */
 
 	return 0;
-- 
2.53.0

