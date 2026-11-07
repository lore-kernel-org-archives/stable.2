Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048655;
	b=qGVvptHJDrVwFT59BAgAT+xBVc/CsKQxi0RUccADTCGlhtyjxJMDHhVB7CIntuPUopkT
	 HeTBzENko/uwHBeDDQZBNmztkBprkRdEmr3XPdpCWuSdK+IlFMEqorMpZXbrLF0Nmuxge
	 eZ5SK9M5QpdfdBseuYIYbxvp3OJNG5ZcIBn9EdmwShPm25TEWBvfrDdfK03Qmo1br84kh
	 68eXl8+bm7Kt4tZzuOnhz0h7z/OPHiaG//vZsNQplxrzmiVKrEbtJyEuv+LTzyrwI+yL4
	 jrMiEbt1rk3Rutm0U+cx32isp1b853JmwplwIJpqSnJ7Gol0lggA6xoCpPvtlTStiTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048655;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vda89gFRZFOTfA0xyW03A+290ivaeN21o0fUPaPoi9g=;
	b=pgDXW7pMNSXnDCthKvqq2r93fd5VU6rNHPHVSDKF/pyfIFcvNPZUvnOM7bUX8nsXqtwG
	 dgmIBl8knyZkn31Hcdvf6dCrF6o3O4GANumJHjRmlG6HvlJv9LISHF+/ypnh2qcqkTdBI
	 LPCgE3QL1Vgj+wrcX9tKoOY1DueYbq/bm/+ffPJ2DRtsmhRvQ+T6eXMsCfwOxb5R2UV2o
	 hfMfRp+btGQsqwFSGpusIMbJLvoI4SEV8Y+9MFIfC5D0f+81FVpvCAhGfZ8Oh/ZjuHIHd
	 vCt3hvyzUTBacxrRieenRPPll5eHm7iGI+mq46US8SYTy9RFw5FJfPJzFVx1uh5WcGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaC+1WP3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC7606A33F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaC+1WP3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62ED1F0089F;
	Sat,  7 Nov 2026 10:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048655;
	bh=vda89gFRZFOTfA0xyW03A+290ivaeN21o0fUPaPoi9g=;
	h=From:To:Cc:Subject:Date;
	b=kaC+1WP3rsnyBetCx/6MmC+40pvkS+qpHBWWH+HDHpOowbFJZ/xdd4mR8cXn1hZZI
	 c6mxGznNNj8l4z+/t48WZPmjH6x0/8Nt/sZUw4Xm7GCIeHs/BbVZbxQzl6HdhPpxTk
	 WtkJBOorIdmkQcLI3AtHFLModTiuoad77s1VVy8br+Wdb8nuk3JUOeTsqJyrV8UCrL
	 VzJGA29Yz2CLCeBq+IRaVWF8mGSgXxFz5FbIAx+6DnP4E3qY4sVJCfR1u2OJA1SIH5
	 nD0dHZDUXvGfo+msFk6Gwikd7p7XJXGpTBpevhzJ8JniYt3tpYpzbGLb1J5k5dst2x
	 zEuD+cJQYP17g==
From: Sasha Levin <sashal@kernel.org>
To: me@timdoug.com,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: generic-adc-battery: fix status with no supplier" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:50:53 -0500
Message-ID: <20261107055053-failed-6.1-8ae5a3f40045@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8ae5a3f40045ff486826ed6b6a83e39a0f380073
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055053-failed-6.1-8ae5a3f40045@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8ae5a3f40045ff486826ed6b6a83e39a0f380073 Mon Sep 17 00:00:00 2001
From: Tim Douglas <me@timdoug.com>
Date: Mon, 12 Oct 2026 22:21:53 -0400
Subject: [PATCH] power: supply: generic-adc-battery: fix status with no
 supplier

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
---
 drivers/power/supply/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index f3ca3ebb25333..c8ad3f11e8081 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -130,7 +130,7 @@ static void gab_work(struct work_struct *work)
 	adc_bat = container_of(delayed_work, struct gab, bat_work);
 	status = adc_bat->status;
 
-	if (!power_supply_am_i_supplied(adc_bat->psy))
+	if (power_supply_am_i_supplied(adc_bat->psy) <= 0)
 		adc_bat->status =  POWER_SUPPLY_STATUS_DISCHARGING;
 	else if (gab_charge_finished(adc_bat))
 		adc_bat->status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-- 
2.53.0




