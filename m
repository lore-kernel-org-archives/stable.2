Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA05354B1A0;
	Thu, 17 Sep 2026 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654633; cv=none; b=owX/tQ3dYKrasOraARZoi0wPcvCzDF0vZd3SQYReITfe5sJsWTMh1qqW7bkNqQpv3OVW4/I+Liw1GWmEN/7oPREFCKUIzDE1+cIAu6hjtqZ/Q25+PH2iZVU5jALtN+funYYQJSQyl1MKR0s41H43V6FwadrbZNjGKuMuwQJB9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654633; c=relaxed/simple;
	bh=2WnnEmewoLe5dI3cEg6bhhhxIK6FnYemkKTPRE0ZUOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MD22imN7xXDxyonIq+mzD/o1mrZzJ/uRo+M1Gh2N0EGt8QAeOI0aGS4/C3c5uu14Klw3LL95BCgGVweMgN13PDof/iAmr+MweZCQcSErMIEveP815/yyQ56yspaBEvZCn2viO5aiVaZbuMMl8H3Jnsrz9YoViFy/AccqPpUSbXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3Hzpj9qtqyj+CCA--.4599S2;
	Thu, 17 Sep 2026 22:17:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hansg@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	marex@denx.de,
	sre@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: bq25890: Fix secondary_chrg leak in bq25890_fw_probe()
Date: Thu, 17 Sep 2026 14:17:06 +0000
Message-Id: <20260917141706.2156408-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Hzpj9qtqyj+CCA--.4599S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw18Aryxuw45ArW5Cr47CFg_yoW8XF43pF
	ZYkF9Ikr48XFWUA3WDtr1vgry3Ca4UCry3Ar1xG3s7Xw13J3WDXFyrJrWfXry8Cr9aka10
	qa9Iyrn7ArnxGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lc7Cj
	xVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x
	0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxUwwIDUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMNA2qrrRneCgAAsr

bq25890_fw_probe() takes a reference on the secondary charger power
supply with power_supply_get_by_name(), but returns without releasing
it when linux,iinlim-percentage is out of range or when
bq25890_fw_read_u32_props() fails. Drop the reference on both error
paths to avoid leaking it.

Fixes: d54bf877fd87 ("power: supply: bq25890: Add support for having a secondary charger IC")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/power/supply/bq25890_charger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 868e86e1749b..0e8ebab1723e 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1411,6 +1411,7 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 	if (ret == 0) {
 		if (val > 100) {
 			dev_err(bq->dev, "Error linux,iinlim-percentage %u > 100\n", val);
+			power_supply_put(bq->secondary_chrg);
 			return -EINVAL;
 		}
 		bq->iinlim_percentage = val;
@@ -1425,8 +1426,10 @@ static int bq25890_fw_probe(struct bq25890_device *bq)
 		return 0;
 
 	ret = bq25890_fw_read_u32_props(bq);
-	if (ret < 0)
+	if (ret < 0) {
+		power_supply_put(bq->secondary_chrg);
 		return ret;
+	}
 
 	init->ilim_en = device_property_read_bool(bq->dev, "ti,use-ilim-pin");
 	init->boostf = device_property_read_bool(bq->dev, "ti,boost-low-freq");
-- 
2.34.1

