Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816541;
	b=dNpMp5ZGY9qb6em5Ay4LJGSr/0lVkUYD/RbqaSo6wkxggtxM92L7sHPkai/xe3TK4ENn
	 Xeui3RzZ7NmP03KR3ipYF+5aTdoEFNzd1WPGAFy0zCdppj5+SSWRryIzSvEpI5EAYrwWz
	 uAZ97DrhEo0c1sUPo5ksIAyeeIuVWWNXOfvqjKkK16xd+FOSz049fmN77aZk9Z9Lp8PQL
	 LZfwJE41+/hQMLzo3pJ9iyTfRgKTe0TS4Cp04Ft5fr+2g9qGHJXxMic0lY5QShu2yJR90
	 nRBixSdWJ6d9YZycl9zrHbYzk0a9LvcgRxUzFSY5p5KXZ5Mj2XIdlg1XFbfPhSdIrfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816541;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HnbwHNu5OUt5MQDUWWcT/tHLU7WeOckZAd9SLi21PU4=;
	b=zPZuNCTChV8Rcr44XumLApNkmavsFE4OfI+Pl+QeTee58z+jv9+RXEOGLFXxAiXZ3T2B
	 rf6RHTv/2lx0DdPLHpW6l8omZsZZE7xHGajqFzI7nussF8xfspg9djS3L5ATa9Rr7JjOx
	 2loT4cP8k2UtT8/LINp+YNslHZqOBA0+g6Eb8MwBEfA20MS5A2rWtXEPbjddWD9DxYpmJ
	 +zv2LKF7EoJLz/SfXFysgRrBbsYyx4dLRHDSJ2Aggfm8wZuJs/oZfee0qA8Jexut6tvMQ
	 kwFWvm0Y+l6PZOMO2V7j2ChfVoHEk2s/vn4KkRjls34VL3gTSV6QhveT/QOzMFHMzew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtnUimFH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8146082BF3;
	Wed,  4 Nov 2026 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtnUimFH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7421F000C1;
	Wed,  4 Nov 2026 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816541;
	bh=HnbwHNu5OUt5MQDUWWcT/tHLU7WeOckZAd9SLi21PU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FtnUimFHnm/0a0johYozbVDkxutKUnQ/wDYFrOIsuXpekhqlSlmRQ37CqmCw6xpKL
	 gpOC0mSRu1GUx+nYN3VBbnPbVAsgBQipxgvSUlsbDRSwO3BOLOPsM0Ky4fx5G8UIz7
	 ZuGutBzvTwU0KnbqijGf3/5YsUzDgIvG82R43OsSWGXPV16rddWm/ZbaweWyZ4sCn3
	 ARiGUxgKITi96vok+z2sCAXRgPYuN5BTXCg3zXlnTOKeht/QDiZHo6fx2T3+r5kb89
	 y7UVSPWo1L6wkfDO0y7yERnT4yCQ0lQnx96SbBFLD/UQHteRR3LQWD02Qn5hal4pTp
	 YYVL3nIT2ySSQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/10] regulator: arizona-micsupp: Cancel check_cp_work on device teardown
Date: Wed,  4 Nov 2026 18:20:54 +0000
Message-ID: <20261104182148.1176116-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104182148.1176116-1-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
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

micsupp->check_cp_work is initialised with raw INIT_WORK() and is never
cancelled when the regulator device is unbound or when registration
fails after set_machine_constraints() has run, allowing a pending work
item to dereference micsupp after devres frees it.

Initialise check_cp_work with devm_work_autocancel() before registering
the regulator so the work item is cancelled after regulator teardown and
before micsupp is freed.

Fixes: e6ed90581bfa ("regulator: arizona-micsupp: Enable SYSCLK for charge pump")
Closes: https://sashiko.dev/#/bug/linux-3f85eadb-7493-4aea-9e4d-ce319b6e0688
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/arizona-micsupp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index be7208bc7409..70b939d3e704 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -10,6 +10,7 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/bitops.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -255,7 +256,10 @@ static int arizona_micsupp_common_init(struct platform_device *pdev,
 	struct regulator_config config = { };
 	int ret;
 
-	INIT_WORK(&micsupp->check_cp_work, arizona_micsupp_check_cp);
+	ret = devm_work_autocancel(&pdev->dev, &micsupp->check_cp_work,
+				   arizona_micsupp_check_cp);
+	if (ret)
+		return ret;
 
 	micsupp->init_data.consumer_supplies = &micsupp->supply;
 	micsupp->supply.dev_name = dev_name(micsupp->dev);
-- 
2.56.0.385.gac671c819a-goog

