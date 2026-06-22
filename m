Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CB36402A;
	Mon, 22 Jun 2026 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113067; cv=none; b=QNRrQjXYNMisDAFeKW5tUKsO4Iu2no9vJNPA7CQ5KIwLPjlBthNy+MstPHUo+RQ9zgknfQfFgxPZQALpJIMsS5luOesqdFvuJQMXDK+lN+GRi4rhGgOZUXlmbYEWeQQbSmyjrvdhHo57fevYGVw2XQjs3fAdLwnQ9weaeWkSr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113067; c=relaxed/simple;
	bh=HPMebhS2P+G92lPxZjODBqeOxlkYH5DWbJzEAQJ7lcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSSk6UJkb7OLjwgrmVHs1GVz5lKUXPbhh3UW9zd7RUCFyt6aaEep3h/5xg3tWMJmsTjdG2KifqN4Yad8ScHdhdJnNPpU8vL/GrVVQHoPiVsQjEpcKlwgLMl2iUXqcDTfsi7Fe+7EjVxGGYHkSyKL/rop+PBYQXv2ytWhhdF1UQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nRhbwPlV; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nRhbwPlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+c
	f/A4UeA0F/7hv2AzCTD6d8afN1OpaUd9SuJG8i3o4=; b=nRhbwPlViUtCerD1OE
	VJN+Y9z2nbLwoys5MSxP63EMaDY8+x51sAnUkcBhsRv4nv25PLnXUb9DSujcL2l/
	y4vhb+SxtUI5b9bJfcwp+mnv8/n4Qg4mxa6Jvt5wVoZ8oCB5xJKZoERbrIUxBipp
	HS047jxTHH7RoM32ro4o6TbEw=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3lCH64jhqA3vzEQ--.42584S4;
	Mon, 22 Jun 2026 15:23:47 +0800 (CST)
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
Date: Mon, 22 Jun 2026 15:23:37 +0800
Message-ID: <20260622072337.693659-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3lCH64jhqA3vzEQ--.42584S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW7Gr4UKw1UZryxuryUWrg_yoW8tFy8pF
	4rCF98Kr48XF4fAw4ktw1v9ryak34xCFy3Ar1xGw1vvw13Jr1DXry8JF9aqry8Gr97GFs2
	yw43tr4fCFnxGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piXdjtUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC0wOhrGo44wNBTgAA3g

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
index c1c12a447178..874ca620b465 100644
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

