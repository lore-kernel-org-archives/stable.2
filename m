Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1123F86EE
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913171; cv=none; b=FfjMGpYk3XgMykf626kQaJCVfXsZ/5LdjPhfhmJY+Ybt4qyAUEcL3gSUuK4CWHn/p+gng5MyJuV63+kyK2p3Tyq+hpgrFUH+aKltthiOQtE1G3XQftR8sqJISxl2z6r0UgXo/5Z2hcb2NNwUSSK2jy1G7Uj86IDp7bI/Tbl7w6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913171; c=relaxed/simple;
	bh=iyApOAEOY5TBYSjFOREEdHmk6S6q7HtfO2z37dB4gIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+M9bDvTRunjyqX2CaNUC8IkCTn3JFFImEHNkwYRZ5ya7ZPPzQLrxoDD7HqYxmccaesOw8kTeK21QHA9faueYrV+SiQJ/zZ4o3YCU+eCxAs0MtonNn4k6r946sd+++RUuCcsP7TNTvUDH9rE1kwDxhxltpd1nY/15NvzGcG0wxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n40xO7D+; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n40xO7D+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782913166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omlfr8grDNGfvojgouDHF79/mYKrbd83gvLmW6Qk2F8=;
	b=n40xO7D+m9+wraOUGGIAVuBeNYupi4LNm/E4/olVXZEEsNdfCuUS0bVcMpiaME0TygCPj1
	E1jpPHZt8YqW9W2ZKM/FLEB1l5RcDIht6YNwcUT3nHqj5jNo26uAsOfojwaSBUyHcYSIsl
	ToB+EJbUqt4TfXKcaKgDmDYGOGR3j0Y=
From: Junjie Cao <junjie.cao@linux.dev>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	caojunjie650@gmail.com,
	junjie.cao@linux.dev,
	Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH 1/2] backlight: aw99706: Fix DT property names to match binding
Date: Wed,  1 Jul 2026 21:39:17 +0800
Message-ID: <20260701133918.33487-1-junjie.cao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The driver reads four tuning properties without the unit suffixes that
the binding mandates: "awinic,sw-freq" instead of "awinic,sw-freq-hz",
"awinic,sw-ilmt" instead of "awinic,sw-ilmt-microamp", "awinic,iled-max"
instead of "awinic,iled-max-microamp", and "awinic,uvlo-thres" instead
of "awinic,uvlo-thres-microvolt".

As a result, device_property_read_u32() never finds these properties in
a binding-conformant device tree and silently falls back to the compiled-in
defaults for switching frequency, switching current limit, max LED current,
and UVLO threshold.

Fix by aligning the property name strings in aw99706_dt_props[] with the
binding. No value/range changes are needed since both sides already use
the same units and enumerations.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 drivers/video/backlight/aw99706.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index 938f352aaab7..abacf5a6c8ae 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -130,23 +130,23 @@ static const struct aw99706_dt_prop aw99706_dt_props[] = {
 		AW99706_CFG0_REG, AW99706_DIM_MODE_MASK, 1,
 	},
 	{
-		"awinic,sw-freq", aw99706_dt_property_lookup,
+		"awinic,sw-freq-hz", aw99706_dt_property_lookup,
 		aw99706_sw_freq_tbl, ARRAY_SIZE(aw99706_sw_freq_tbl),
 		AW99706_CFG1_REG, AW99706_SW_FREQ_MASK, 750000,
 	},
 	{
-		"awinic,sw-ilmt", aw99706_dt_property_lookup,
+		"awinic,sw-ilmt-microamp", aw99706_dt_property_lookup,
 		aw99706_sw_ilmt_tbl, ARRAY_SIZE(aw99706_sw_ilmt_tbl),
 		AW99706_CFG1_REG, AW99706_SW_ILMT_MASK, 3000000,
 	},
 	{
-		"awinic,iled-max", aw99706_dt_property_iled_max_convert,
+		"awinic,iled-max-microamp", aw99706_dt_property_iled_max_convert,
 		NULL, 0,
 		AW99706_CFG2_REG, AW99706_ILED_MAX_MASK, 20000,
 
 	},
 	{
-		"awinic,uvlo-thres", aw99706_dt_property_lookup,
+		"awinic,uvlo-thres-microvolt", aw99706_dt_property_lookup,
 		aw99706_ulvo_thres_tbl, ARRAY_SIZE(aw99706_ulvo_thres_tbl),
 		AW99706_CFG2_REG, AW99706_UVLOSEL_MASK, 2200000,
 	},
-- 
2.43.0

