Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351480;
	b=rpUENKggZldc1PfTzgOEV/Djm24wA0kskW1tyCQ8S4CF1v5frRVbo85Dr4YOTN32Qxpw
	 TeQZEdedd+2z1iWabyJ1Qt3y/l4NfzbNWP4ADnADMLb6oAyc1yZybmBMwPhgl8qqTjz1U
	 oHxnVMzwU1slqUGCNFCvhfSfhGFpcWXpg6Hm1ZrnM6GOVGb3luYlXkW5Q+qqaAYofuqRD
	 giI11uYB0eFuRa59JF88D7URfeZ26Kf48BV2p52A2aF2c9yWzm2VxdxSglJ4peBECofxt
	 GHpezVWZnEhR7YlX3zQ0Ir2dObN5PYX86OYPUBuRv2ixr3DB1X8thhzFe/boGJ9mEqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L6nv61R6YnuFJ3iEtYY8mAt5Drq0jLWf8PuriPYZseQ=;
	b=O0M4cMMcZlbGWGSJYiA/nuhMybrcPg1AmTFvG7/2EwbnS2GbQJLOEOu+SfwIl9kRFeqV
	 jy1f7rLBWRrAd45ElTBAiF5NEExDAb5mRvUUbL0MmR7MveRTSBNPPVLQK9o/3ONggjopr
	 LBzhGejAdSp2OqVavADR4+JvmHU4l4fx9A3uIhRvtGgybOf7O0BDwtTixFQIDA9vVzOmH
	 AqgYWGncA0m/oiW6XVghJW601N+AKh8BesAGhdz75e5hoMhJxvB1nkw3bwlogr/PXASKq
	 ZvX+TUf4TeXjnxiWQPp2qxvMR3FHle0YbCq1ZnbfYAFAcm6iCOuXdoxSNhaxgpQrM3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d59HIQom;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F9606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d59HIQom
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13661F0093E;
	Tue, 10 Nov 2026 22:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794351480;
	bh=L6nv61R6YnuFJ3iEtYY8mAt5Drq0jLWf8PuriPYZseQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d59HIQomg5R/l2U+MHZwwU/3ePTpWa1ENxLaKJAXn9bQlIuJLyN2O02CDsl2H/3J3
	 DwxdjdqdLK5QQKx+KZpvIZgprqLPYPY6/muo6AmBLfXlB/MnDv847DtW/K26wVrhOk
	 z29LMV32B4Cp3pM4tM0BJua+0wDWk1FRZQ3nF/smVw0UgilucKqdpCQuYXXQHlhyyA
	 WULGGxG6dImT1FhQYgErn3Bzfhc9+T7icn3oCTr2rAVjavnQfpZVU5zsEn/ycghysb
	 Bykf+mWxn2CSqIh4psLA8hwTJMwe8mXfzE2XozGJSNuVOO8lxnS/3iz8ANU5BqMI65
	 Ss8/L0sQ2aeDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Douglas <me@timdoug.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 7/7] power: supply: generic-adc-battery: fix status with no supplier
Date: Tue, 10 Nov 2026 17:57:53 -0500
Message-ID: <20261110225738.4066560-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110225738.4066560-1-sashal@kernel.org>
References: <20261107055053-failed-6.1-8ae5a3f40045@kernel.org>
 <20261110225738.4066560-1-sashal@kernel.org>
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

From: Tim Douglas <me@timdoug.com>

[ Upstream commit 8ae5a3f40045ff486826ed6b6a83e39a0f380073 ]

power_supply_am_i_supplied() returns -ENODEV when no registered power
supply supplies the battery. generic-adc-battery's gab_work() tests this
return value as a boolean, so -ENODEV takes the supplied branch and
reports CHARGING, or NOT_CHARGING if the charge-finished GPIO is asserted,
instead of DISCHARGING.

This was noticed while bringing up an out-of-tree Linux port to the
WikiReader: the driver reported CHARGING on a device powered by two AAA
batteries with no charging hardware.

Only a positive return value indicates an online supplier, so treat zero
and negative returns as discharging.

Fixes: 46cecd130d55 ("power: supply: Fix power_supply_am_i_supplied to return -ENODEV when apropriate")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Douglas <me@timdoug.com>
Link: https://patch.msgid.link/20261013022153.6707-1-me@timdoug.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index cac0ac5caa142..e7f45ce38ce2c 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -129,7 +129,7 @@ static void gab_work(struct work_struct *work)
 	adc_bat = container_of(delayed_work, struct gab, bat_work);
 	status = adc_bat->status;
 
-	if (!power_supply_am_i_supplied(adc_bat->psy))
+	if (power_supply_am_i_supplied(adc_bat->psy) <= 0)
 		adc_bat->status =  POWER_SUPPLY_STATUS_DISCHARGING;
 	else if (gab_charge_finished(adc_bat))
 		adc_bat->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-- 
2.53.0

