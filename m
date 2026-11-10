Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352236;
	b=XTT96B70uvE0PYx32lCzrB3Pt4nH/GS1FQp/b/WGDml+i/WkQltg7M84/fdDCgHb2iXw
	 /EC0xzoimG6/GYdgA4VOZxTyRipzMk4UColo6caEt7/CZPg/kOb+5bnnTnmzEo7eNTfcf
	 GUq54MEsiwm/ncw+Na6dvcAf7Y5v5izazmYXoLkAyRnQbfEKDHOb43QXh4vbKVsXFQws1
	 sZPjaTmHNKqDcqgqRDNgP0+5YFPJ1fxjTuPgX3Z3gIHuN7vH5ZOGDt27IzEnHPNoQgCUN
	 NoYSzbZvm10mQz0vEsTk6Ug7/wyr803K6thdn/2xXKsqzi/0nF4G6JYyjZ/TEprMqTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352236;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L6nv61R6YnuFJ3iEtYY8mAt5Drq0jLWf8PuriPYZseQ=;
	b=h+SXMSXG03ZQPmc6MLOr52DornHwc09jcKXN1rqTfTPmqy3iyW/TubNyV77YjaxAVVmI
	 CPaNgB0ZQOQeZMh6rtTDqgWNirXA5udjF45mSrJrP0J+XVf7zI5Mqx6Zr8Y2Arqko/fN/
	 oOxqUpqSes5MR/McnwlnJVRQnW8zWU4ZMpSizBog6niiQ8rXlex4ZLfyxCv2QcXCHUn3N
	 SjVgK5FQiTFmgSI4c20UpPBLyJnCUXvRN2x5r/pPBxvc46+fCjorXDjbgvFNADApGK1Yu
	 qyXDlHDP/auO9kMX1+TrtOpAZkwF8RQ6GvUzIlkeiFmWVf6Sil0cs2CxBRFl5oTdgEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0ddfh7k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D3606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0ddfh7k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E4B1F0093E;
	Tue, 10 Nov 2026 23:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352236;
	bh=L6nv61R6YnuFJ3iEtYY8mAt5Drq0jLWf8PuriPYZseQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T0ddfh7knULZsBKUA40gPhXpYl+A5WIAdJnrOE/gHrfnnKcRVL66DFupLFZoC+0dr
	 06QUMDq6jdHaxSw1ENvR9wsDvO9t8iDA1bRIqFIPohVdLKVLi4yw+TrJ4IyB7EzYnL
	 6bvC98Ps3U68QqvLRdvDvShqPuZxicVeV8jfeFgtoSfZ0Nr+c2FkpayqKsv59J4mpU
	 Y/f0ZU/LmKnDVELbZrthF/df5uo3Rd6pfcTI72fHcYMP4KlK/JSRRQXhc0PiaUxls8
	 CeJ3vR0aYazNNz+LQQAE0zITgII36qkQ7u0wiyVCP7WQeyMhvn5VmL9EwsgtHj5qjt
	 eqFzbhtel7Szw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Douglas <me@timdoug.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 7/7] power: supply: generic-adc-battery: fix status with no supplier
Date: Tue, 10 Nov 2026 18:10:30 -0500
Message-ID: <20261110231006.55369-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110231006.55369-1-sashal@kernel.org>
References: <20261107060802-failed-5.15-8ae5a3f40045@kernel.org>
 <20261110231006.55369-1-sashal@kernel.org>
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

