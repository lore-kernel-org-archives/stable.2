Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48112FD696;
	Thu, 18 Jun 2026 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773708; cv=none; b=Lbedkaw4h0OTRwFHdk5JmDQKLCs5PAa0nu4BcB6r2RdVr2x81Q0eKiEvrpMWU1I+TK9Ox4+Nxc+MiapzLW8A8WQEx5kMWKVxjz8H4+pJ1+LUZqINRy0pxNilaZFtvF7FE2HWNZCEtkkCKPdTwmXam2FOmZcL/AzBrT8dq70C250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773708; c=relaxed/simple;
	bh=d70WQx/n/AVuK7JXgawnfxZsw9Rdcp0QKyX9m4DWYmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMdTWNQaCGBns7bXqSuD8wAG/TqR1Qdu9xlFoDdfZjJVXS4oDbHtwwhzfiuH83r8Q3oHz0R9bWBnYTZJapDfsxwY4Od+aqPPv1AffziDSALFQTi366tj/16muI+A6VjEsCn+0pRhltt+tkFiGj6WMBoeKEhZnPslUt2+SV95N78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oBrr+YUW; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oBrr+YUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=U9
	LYbpliEyA7kvkqFWLXwY8GVKQIfZ2rB1s2So+u1ns=; b=oBrr+YUWD7lwiohoK+
	fwZUUc1NrlgsaVOGSpvOxzsMwWJa/90GA+BUSM8O2c1YdptOQlBVLUsr/psGyzeX
	Ov5SzusWUHKsS3I30lZZqlXxj4y/dIrAZ/s7h0Ui/xB61vH+sm0u754lL7pPWjAv
	W1xBUrcbicKjCOp+pgYcUwCLk=
Received: from ubuntu.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnMQdWtTNqaIBlCw--.16948S4;
	Thu, 18 Jun 2026 17:07:38 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: sre@kernel.org,
	marex@denx.de,
	hansg@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: bq25890: Fix power_supply reference leak
Date: Thu, 18 Jun 2026 17:07:26 +0800
Message-ID: <20260618090726.2863439-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnMQdWtTNqaIBlCw--.16948S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW7Gr4UKw1UZryxuryUWrg_yoW8tFy8pF
	Z5CF98Kr48XF4fAw4ktw1v9Fyak34xCFy3Ar1xGw1vqw13Jr1DXry8JFZaqry8Gr97GFs2
	yw43tr4xCFnxGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRkhLbUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC0xrq9WoztVoUGAAA3s

bq25890_fw_probe() acquires a reference to a secondary charger via
power_supply_get_by_name(). This helper internally calls
class_find_device() which gets a reference on the found device.
However, the driver does not release this reference on error paths.
The devm cleanup callback also does not put the reference, so normal
driver unload leaks it as well.

Fix the leak by adding a power_supply_put() call in the new error
label of bq25890_fw_probe() and in the devm cleanup routine.

Found by code review.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
Cc: stable@vger.kernel.org
Fixes: d54bf877fd87 ("power: supply: bq25890: Add support for having a secondary charger IC")
---
 drivers/power/supply/bq25890_charger.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 868e86e1749b..85318a06b66c 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1411,7 +1411,8 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 	if (ret == 0) {
 		if (val > 100) {
 			dev_err(bq->dev, "Error linux,iinlim-percentage %u > 100\n", val);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto err_put_charger;
 		}
 		bq->iinlim_percentage = val;
 	} else {
@@ -1426,12 +1427,19 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 
 	ret = bq25890_fw_read_u32_props(bq);
 	if (ret < 0)
-		return ret;
+		goto err_put_charger;
 
 	init->ilim_en = device_property_read_bool(bq->dev, "ti,use-ilim-pin");
 	init->boostf = device_property_read_bool(bq->dev, "ti,boost-low-freq");
 
 	return 0;
+
+err_put_charger:
+	if (bq->secondary_chrg) {
+		power_supply_put(bq->secondary_chrg);
+		bq->secondary_chrg = NULL;
+	}
+	return ret;
 }
 
 static void bq25890_non_devm_cleanup(void *data)
@@ -1440,6 +1448,11 @@ static void bq25890_non_devm_cleanup(void *data)
 
 	cancel_delayed_work_sync(&bq->pump_express_work);
 
+	if (bq->secondary_chrg) {
+		power_supply_put(bq->secondary_chrg);
+		bq->secondary_chrg = NULL;
+	}
+
 	if (bq->id >= 0) {
 		mutex_lock(&bq25890_id_mutex);
 		idr_remove(&bq25890_id, bq->id);
-- 
2.43.0

