Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868113B71A6;
	Wed, 16 Sep 2026 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541368; cv=none; b=rdluJ390R3tDuqJWEG3U2attMst19VvQvd9GsTYiHKH6gV32fKGCRWCJyEfT5mK6+BYpiRmVAAO0oD1pxS7JaAnyAE2tlzOHTXuHpWSzSNzlmZNg7g6Ky5EsGRPyo1x3bzq16jxTvWkVnwXVXlYeg0uCKU3gGARoVioSMjbMA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541368; c=relaxed/simple;
	bh=V3Rj/M78ML+IWwjxMcdUUHa6J8+PSKaEAADtfuMo2nA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LhNl83cOHNJgJ8RXZBrXgYpIspAZoJEESRLxjGPOLPRsKmH3wkibK9jHQH524lc46pguXdKpmmGR5t3hxjRLXP2uEvJqsRK8ZTTbpIVdA9fiJP7yPi61ZX2CeWHzAHpXssYBR4znenmt2155DLCOz+09yxSxki2xQbwuW//WuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxaLbePl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxaLbePl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B9D1F00898;
	Wed, 16 Sep 2026 06:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541367;
	bh=1VI25TIA+v045MXYLKFuFbXECJEiH9DMpshxlJnPhx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BxaLbePlfgZ9bI/SsmQbs09Ai4QVyZjOAXsUdb5aySNjjq/F1EBUFcEFyjd77lywV
	 POR53imz9hQ0wQG1UZZzQMviiceNrj7KBxv42w8PgZ/HTzECd+I4FotHl49ygr1+pb
	 IZoC0pZbz+kBtebukdASTaxIFXGLrKS263Xl5DfXEX+9Q/l3BtYD4A9nYjlLqUnhVm
	 LTm6yEdg6Jc0jZMsNeZHpDlA7W9ba/UjFc15uJ0pleyIAB+ADh/ziqFbLXANHgmgbK
	 wjnLlhnNpwVk0EGu7eMbck8nvZYkVCigyKkhKJhxeyltx1GT9trlra8rMkqhV/r33S
	 DdvmVqfPWKNUA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:23 +0200
Subject: [PATCH 01/15] power: supply: ab8500_fg: Accept status from
 supplied power
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-1-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Commit dc77721ea4aa ("power: supply: ab8500: Set typing and props")
changed the charging algorithm power supply type from battery to unknown
so userspace would not mistake it for a second battery. The fuel gauge,
however, processes status changes only from battery-type supplies. It
therefore never learns that charging started and keeps running its
discharge state machine.

The power supply relationship already limits the callback to supplies
naming the fuel gauge in supplied_to. Accept status from any such supply
while retaining the battery type checks for battery-specific properties.

The Samsung-GT-I8160-Codina and Samsung-GT-I8160_HD-Codina product trees
keep the charging algorithm typed as a battery. The
Samsung-GT-I8530-Gavini, Samsung-GT-S7710-Skomer,
Samsung-SGH-I407-Kyle and Samsung-SGH-T599-Codina-TMO alternative
fuel-gauge drivers instead pass cable state directly. Both approaches
preserve the charging state handoff that was lost in mainline.

Fixes: dc77721ea4aa ("power: supply: ab8500: Set typing and props")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_fg.c | 60 ++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index e6b5efdf5dc9..016ed35e90f9 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2205,42 +2205,36 @@ static int ab8500_fg_get_ext_psy_data(struct power_supply *ext, void *data)
 
 		switch (prop) {
 		case POWER_SUPPLY_PROP_STATUS:
-			switch (ext->desc->type) {
-			case POWER_SUPPLY_TYPE_BATTERY:
-				switch (ret.intval) {
-				case POWER_SUPPLY_STATUS_UNKNOWN:
-				case POWER_SUPPLY_STATUS_DISCHARGING:
-				case POWER_SUPPLY_STATUS_NOT_CHARGING:
-					if (!di->flags.charging)
-						break;
-					di->flags.charging = false;
-					di->flags.fully_charged = false;
-					if (di->bm->capacity_scaling)
-						ab8500_fg_update_cap_scalers(di);
-					queue_work(di->fg_wq, &di->fg_work);
+			switch (ret.intval) {
+			case POWER_SUPPLY_STATUS_UNKNOWN:
+			case POWER_SUPPLY_STATUS_DISCHARGING:
+			case POWER_SUPPLY_STATUS_NOT_CHARGING:
+				if (!di->flags.charging)
 					break;
-				case POWER_SUPPLY_STATUS_FULL:
-					if (di->flags.fully_charged)
-						break;
-					di->flags.fully_charged = true;
-					di->flags.force_full = true;
-					/* Save current capacity as maximum */
-					di->bat_cap.max_mah = di->bat_cap.mah;
-					queue_work(di->fg_wq, &di->fg_work);
-					break;
-				case POWER_SUPPLY_STATUS_CHARGING:
-					if (di->flags.charging &&
-						!di->flags.fully_charged)
-						break;
-					di->flags.charging = true;
-					di->flags.fully_charged = false;
-					if (di->bm->capacity_scaling)
-						ab8500_fg_update_cap_scalers(di);
-					queue_work(di->fg_wq, &di->fg_work);
+				di->flags.charging = false;
+				di->flags.fully_charged = false;
+				if (di->bm->capacity_scaling)
+					ab8500_fg_update_cap_scalers(di);
+				queue_work(di->fg_wq, &di->fg_work);
+				break;
+			case POWER_SUPPLY_STATUS_FULL:
+				if (di->flags.fully_charged)
 					break;
-				}
+				di->flags.fully_charged = true;
+				di->flags.force_full = true;
+				/* Save current capacity as maximum */
+				di->bat_cap.max_mah = di->bat_cap.mah;
+				queue_work(di->fg_wq, &di->fg_work);
 				break;
-			default:
+			case POWER_SUPPLY_STATUS_CHARGING:
+				if (di->flags.charging &&
+				    !di->flags.fully_charged)
+					break;
+				di->flags.charging = true;
+				di->flags.fully_charged = false;
+				if (di->bm->capacity_scaling)
+					ab8500_fg_update_cap_scalers(di);
+				queue_work(di->fg_wq, &di->fg_work);
 				break;
 			}
 			break;

-- 
2.55.0

