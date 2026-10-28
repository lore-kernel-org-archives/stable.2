Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163021;
	b=ZUDKd4aiD9Anrh8cjjwl68ODjUwc/sPlZ1AeDK2YBqzPRsZDNVSX7s43KtOLJsEiWAu6
	 hqnKBRCNquG9FBU2LO5gp0fqvQmSPAqkz4t/rSgrqFKyFKncBqkpgfyJQhz1HtQm39zH9
	 IMNrmNq3wxPF0Dqn+vLiLLX1KzVJ53FF4Ugn2SQAdzpdaddE7xS8/TtxgLf0Fro7Nogzb
	 KMd6oj9aIVxeyoVzd3gDBg4zh70qLGIo1qBi/IBpnXuG2mozxXMDvDNH5TiqyorIK7elh
	 VSvY17h/6GCgZOLZ9jyczdevaEqBF1VyVvmSQLbNL9utrHGObykozEWY8wve+2vDEew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163021;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=rDYEf1rgU50wwns+nROrVWSna2CJr+Uqr/UDhhZJLnY=;
	b=kRa2A59Db1XSG8TBVG4pgHyRbgtD8DpGnn4eqjGmOxY/rzcPLS03R6DCerNCNpYB0GNA
	 aGZE81lfXaKiPRzlzXEvX+R2+YU72fbLByDvpodM7V5NSAtsPKQiEAblWJ//9G0bnlfQ6
	 e0U8D8lZryD5Owc04g5yriYpITxc+pn5rkC4+rS3pCLWhB0269Qg+hBM3U/FZ7OQPQYL6
	 1XbWokKFY6xmm3QEW0JXsCSQ6XypmeF6MnLvGO1VeR+o0f7NWXWilG9zIA2ZM78wXPsB5
	 wRHFrRGS/7bAmE2MOdfFh3idEqHH8SFLkPrjpkzC9DWjVenFVgFnRXOZR0pURdzO40g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CM6Tu6vo;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD583606A31D;
	Wed, 28 Oct 2026 04:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD583606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CM6Tu6vo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rD
	YEf1rgU50wwns+nROrVWSna2CJr+Uqr/UDhhZJLnY=; b=CM6Tu6voCiMqEZkdMK
	n7zLsi3k708RxER9P3vtiNxMZWGgpowvFCDcj+wTpKOTT/AbDhPBd14fmapJRyEy
	aeYwVjsfUw9ekbgg2lT1yJNcF/bYZ5XzuMWVmp0OMfIptT0jEasU777aFtdnQx4D
	AIc3R4Zsnl1YhiwOsluDGWen0=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3_977fuFqVrksDg--.35683S2;
	Wed, 28 Oct 2026 12:50:04 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] regulator: arizona-micsupp: freeze charge-pump state work
Date: Wed, 28 Oct 2026 12:50:01 +0800
Message-Id: <20261028045001.99474-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_977fuFqVrksDg--.35683S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWxGrW5XF45ZFW5Kry3urg_yoW8WFy7pF
	s5WrZ2kF4vyrW8W3yUCF9rtas8WrnrK39rGFW8Jw1IvwnxCF97ury7Xa45tFn5Cr95GFya
	yFWjy3WfGF1ruaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9FxUUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhzxLGrhfvyWXwAA3P

The charge-pump state worker accesses the device through regmap and then
updates DAPM state. It is currently queued on system_wq, so it can run
after the backing bus has suspended.

Queue the worker on system_freezable_wq so hardware access is deferred
until devices have resumed.

Fixes: e6ed90581bfa ("regulator: arizona-micsupp: Enable SYSCLK for charge pump")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/regulator/arizona-micsupp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index be7208bc7409..ae99173b8236 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -78,7 +78,7 @@ static int arizona_micsupp_enable(struct regulator_dev *rdev)
 	ret = regulator_enable_regmap(rdev);
 
 	if (ret == 0)
-		schedule_work(&micsupp->check_cp_work);
+		queue_work(system_freezable_wq, &micsupp->check_cp_work);
 
 	return ret;
 }
@@ -90,7 +90,7 @@ static int arizona_micsupp_disable(struct regulator_dev *rdev)
 
 	ret = regulator_disable_regmap(rdev);
 	if (ret == 0)
-		schedule_work(&micsupp->check_cp_work);
+		queue_work(system_freezable_wq, &micsupp->check_cp_work);
 
 	return ret;
 }
@@ -102,7 +102,7 @@ static int arizona_micsupp_set_bypass(struct regulator_dev *rdev, bool ena)
 
 	ret = regulator_set_bypass_regmap(rdev, ena);
 	if (ret == 0)
-		schedule_work(&micsupp->check_cp_work);
+		queue_work(system_freezable_wq, &micsupp->check_cp_work);
 
 	return ret;
 }
-- 
2.34.1

