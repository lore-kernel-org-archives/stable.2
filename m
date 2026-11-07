Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050694;
	b=vVHYVgoXv5aC8pZ3R7RbM7k3mDKWtIdGJs7OaOCXfs2Izba3Li2aeOz+9bw+dSvM61mW
	 j+y6aS5OnL2Ym8UiJwNmNecwS8rD1JsIAMMS6BexBbuh3bJoJMkoo6PktX6n7KCh8NhX6
	 c56XL2H80KbtNZ5Y+AJ8mz0MAyZZEVhmm2f2HKlS4VzemYigDWSyXfqn7PBKnDbtaf4sM
	 GYnei9yYRudP8M99b6bGHleQc81MeC6r07PyF7wH7mg74tJeNHL9++hZKcpVm+JDERbk1
	 jB+z0TpWVzZ82HELi6+5NmJaxA9l26jG1+A+N7XF1FYqqCyjyMevVUFMdEa3LrMQmKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050694;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tnc2aikfNdaUlzbO+hJftDNs+fWAYQHN7USVtbAGP2U=;
	b=hnDDOp+FWNr1kBQ9S2hxmxFsq2CvEQjPWwEwZ2s92GtT/ATqG45roGoio0CdzQt1daT6
	 ZQQKpyWsdoU2dRqkA4pXuX9Mmd/+PBCQeBR8DYHVlZ9hDsvO6nyJQ7b2femUEJPJcwVRf
	 G2vG0Y3K3p3zKwfXNieGbzyiDa7yVbASeiCxfgHzcE63YGjjJPSZdYLR/Tgk6q3L7gEHS
	 SohXrctzLDvjFlBwDKFEGzlb7OAqpoIf/K+KuG+ICKFOjxvllNNsZ05AHTFBAsT8SL1le
	 tk+Y3Em6N9eTJpJlw9rRyrbwd2jspXnGUBRCMvXu/CeLG6VntmKLh0lYbVlUK5GYzcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iB9Zqn3/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACE606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iB9Zqn3/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAA61F0089F;
	Sat,  7 Nov 2026 11:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050693;
	bh=tnc2aikfNdaUlzbO+hJftDNs+fWAYQHN7USVtbAGP2U=;
	h=From:To:Cc:Subject:Date;
	b=iB9Zqn3/5t1wXLBvTd/lBMgkx7IBM2CLNuzcMC6eiD4RYg27tumqZEVx91rWYZ0zY
	 WkZLcLOBpyk+nEOgP9rO0E82w9cxI2FljZ6J4+Om/LF9k42z7nzWEqOIWkvh0jcqWR
	 xoZoM8WeQhCd3xuN7F5tTHlqno0eOiMPLyoL8q3cblTMEHlULMBLj+tqqVzkQypeC0
	 js/SC5h3dCG2TLxAPWxO3KyU4uY3IoDj2osxePoR7ZzUwyGpi+5HmDhWnN2RIYor7S
	 QKepajzKM9dwRNgdWszlCpx/v7pVMSElSy+HAToSPNBBC3qPCRXJ3iJNJzJh40ctPS
	 H/gTuicJNwgEA==
From: Sasha Levin <sashal@kernel.org>
To: me@timdoug.com,
	sebastian.reichel@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] power: supply: generic-adc-battery: fix status with no supplier" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:24:52 -0500
Message-ID: <20261107062452-failed-5.10-8ae5a3f40045@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8ae5a3f40045ff486826ed6b6a83e39a0f380073
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062452-failed-5.10-8ae5a3f40045@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




