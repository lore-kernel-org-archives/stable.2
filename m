Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728DD41CB2E;
	Mon, 14 Sep 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379484; cv=none; b=tTkf3iQ/rKOr8Sgu40HVHfsbaOty6ZHh3xor9ZM4xRK7FlZ8+9JG1zJphg/oBLVnbRoEM1jrx+bbSi5J8qzxQhSDduLEn4GgEaRMlvs0dx2cuRUmTlvBKRk9rnjQbSU2rvfr+bDUJsW1237OcRjm1Yy0AMaDWVFFmMbFPS+H5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379484; c=relaxed/simple;
	bh=8BCaZdYq61JSIUsOMSYMjfA9ubrpUWHHUd4Rb1x1cIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cawHZ2gbIfpXavVW0C8GHLm8w8ltj/5MAuyunfuQQ9UiJQmAXoPmRUBTApQbpdvUtyGTkXL5AGiZzUaMlx0RuO6rOF2NPbnB5fceq2AnKmx8VczRfzAirDwRv6QQGT1vdvWwjdAijBa/Fmne0w89xsqt1O61EN7w+b0cRccZVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SrQ3Z3De; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SrQ3Z3De"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cZ
	7qRsvM0rK8gijokvP/+6QqwVeMaIOvetKgBTJ481w=; b=SrQ3Z3DeaVSkV/ax49
	0FBE1jr+XyM1+iJUNopOfeF1kecIsNYZcrBfKEks4QPH9CEG0O7dvV2ipLkMTVtk
	PQfQOfMKY8/Y6hUTuF/zuPasUvFT8/rw84ThcDSwYfVsk2B1YoNobZqvkv0rwXxy
	F5BnE5lInvXIyQm3Lj3oZOxfM=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBXdB9Sw6dqGhJgAg--.50136S4;
	Mon, 14 Sep 2026 17:50:34 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: srini@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	vkoul@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: wcd9335: Fix device reference leak in wcd9335_slim_status()
Date: Mon, 14 Sep 2026 17:50:09 +0800
Message-ID: <20260914095009.12049-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXdB9Sw6dqGhJgAg--.50136S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrWUtF1UKrWDZrW3Xr1rCrg_yoW8WF15p3
	yqkFZIkrWrKr4fCF1YyFWUJa4Y9FW2kw4fJr18t348KFs8Ja4Sy3y8t34jvFW3trZ5C3W3
	JF9rZa4kGr45Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGjg7UUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9gqPmmqnw2oR6AAA30

wcd9335_slim_status() obtains the SLIM interface device with
of_slim_get_device(), which uses device_find_child() internally and
returns the device with a reference held.  As the device_find_child()
documentation says: you will need to drop the reference with
put_device() after use. The reference is stored in wcd->slim_ifc_dev
and never dropped, so the SLIM interface device cannot be released.
Fix it by using devm_add_action_or_reset() or put_device() respectively.

Found by code review.

Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 sound/soc/codecs/wcd9335.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 40de279a9750..9332082092c7 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5096,6 +5096,13 @@ static int wcd9335_slim_probe(struct slim_device *slim)
 	return 0;
 }
 
+static void wcd9335_put_device_action(void *data)
+{
+	struct device *dev = data;
+
+	put_device(dev);
+}
+
 static int wcd9335_slim_status(struct slim_device *sdev,
 			       enum slim_device_status status)
 {
@@ -5120,6 +5127,11 @@ static int wcd9335_slim_status(struct slim_device *sdev,
 		return -EINVAL;
 	}
 
+	ret = devm_add_action_or_reset(dev, wcd9335_put_device_action,
+			&wcd->slim_ifc_dev->dev);
+	if (ret)
+		return ret;
+
 	slim_get_logical_addr(wcd->slim_ifc_dev);
 
 	wcd->regmap = regmap_init_slimbus(sdev, &wcd9335_regmap_config);
-- 
2.43.0

