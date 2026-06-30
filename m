Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36840D577;
	Tue, 30 Jun 2026 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808491; cv=none; b=D4H4N9uD40vC5m8kUTgYyLdfzDGLMZnxWyEB2MjbLTrTja1ALfWCx3+hb5vRMuvLgZho+7TyY7LwZQzkLB9gdKL/iIyyGbxwvCD+YI3qi0lK/x1DQJBUzqE03cHDvc/AXEHmt+xMSRndxMHWMFInXsZD/b3unRG1Vp7S9sMsQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808491; c=relaxed/simple;
	bh=/2j0DDj3iEHsHxquIQWouGW2wWlUANGgq7bRDSng2TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjmBVzgfindhW9uYzkb0OCBD57btD2MqPw2q9bEZQuDAmqDiQAm9ijIrpgvgq7YdRAT/4dwU+KZ/4MOydoVdlUoPcnw/72RJTd5t5VkcHfhvXNJcTASZt9G7a+ugKmQ76/Lms2J//HWMg3OFXGfw/3O5TYFaNeOJzWMrSMZ6iJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oYguo7QO; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oYguo7QO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=YT
	EgbRAg6lomNr0DN2FzVbDdc7M+qSJOungF1DxvSAE=; b=oYguo7QOEwbf96iwNz
	+eUJ/03thBALJVsRjOoN4Dgejdf7XRhRCyYFPa+vhSa9N3mr/iaCnm6Dp4jfw8VP
	EBlFQrB46BMybzmv/BXTYqCM32YmT8rydSzmbRNCxHstblneBlLPvX7VVXkhkvm7
	jRbipk0Rq37Z+4JhT2XUn9Bxs=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3D8V4f0NqibrcGg--.35590S4;
	Tue, 30 Jun 2026 16:34:05 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: sre@kernel.org,
	hansg@kernel.org,
	marex@denx.de
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH] power: supply: bq25890: Fix power_supply reference leak
Date: Tue, 30 Jun 2026 16:33:52 +0800
Message-ID: <20260630083352.1841720-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3D8V4f0NqibrcGg--.35590S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW7Gr4UKw1UZryxuryUWrg_yoW8tFy8pF
	4rCF98Kr48XF4fAw4ktw1v9Fyak34xCFy3Ar1xGw1vvw13Jr1DXry8JF9aqry8Cr97GFs2
	yw43tr4fCFnxGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRkhLbUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC0x1qdWpDf31P5wAA3S

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
index c1c12a447178..b50be3fca77c 100644
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

