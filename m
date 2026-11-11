Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355798;
	b=XldYeV6D3jQzzo8rWvRosSBD0NmSxfFqEbI2zywb0jg/y8AU0VUEXLFX90o5ppPL2Bm7
	 yb3I5gi8yAp1Qcb/TBMWbVhDWe83RASHtCVzV7hXSfxrvZ5M2XimKGHt6bF8g0gZK37oT
	 /GYTLcWmQTRD+EVjB+M+glxGobn2Jg39FRwSoHPixNo5WKCC7cczZQDNDOmFljMtGMz7T
	 1nmfpCQqilZRYOi/qovImiAZyQoQLLdYlaGQodhg+/+IVzTWHtnmnWKkE4Jaagb6txtWj
	 Z1M5Asf58RgiABy0niWCCWCn9W48k+TD9cfkSQjsPz+ZigJxdqRMdi7t0Oqz2LEMGRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MLdzUK2vEZTApjKW/rbA7AxGrWvvhzjdP4njznUa0TU=;
	b=v16RxT2O9Ip6T0tSUdUOEWOTlqP3Hycl6lff6zE3vtd6GQT5UnDNTMM5yfah9LRQ9UpD
	 eE1wRQ3VeCfrTE4Rp/uBWu54RJcNnxsXVH5oEK+UA1IZK1yRyG+8zjmA1HJhT2N3Cm3Ty
	 IOq7TiO7Wh38waMAxq3jGLeiZ06HvBWoIgon4waOiRwuGpRgzpNT97z1wQl2XfU7Ga+1t
	 PQs0yxgA2zCbCjZAOkbetPvHuQcM82phLHWguZiGc6PMmkgXyAn2pVn2pxMXlylIVt2tJ
	 7rZsuvVFAiwnxPoG8jj4/XWTFenFh4mkbl7tpxjFb3A0ZkgAk+sqRLx4e4RdFKwaYbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnDQcfVy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD3606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnDQcfVy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044EF1F0089F;
	Wed, 11 Nov 2026 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355798;
	bh=MLdzUK2vEZTApjKW/rbA7AxGrWvvhzjdP4njznUa0TU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZnDQcfVytFKdWYbIq+VWiCGZTiDzarvR/QPcqsOBQ3rFhXXXcbQGFmOTSNetPsDJ+
	 2jLgmgaM0DExbIzFZM9KG79mu6dxlsIHhKhuxX8rw3xGh42dEVlPcIO+EXgnEWQY8+
	 qgABeqTpMk2mPT91PJrksXmgFUM3gyxPOiSPhDp2JRSa5vK3erCCvF+JWWEmMIcXAe
	 9oIUvrbe1GCgm0yOP/JbOkJk7Iki1f/Uz3jHbKECoNMFEvUhNDfgEeT5Wy7lS/jIhX
	 S4d8sTRfqkdTGarlib09jjp+6XlynckbxAI2vxj508tUNwF693rFF68uLLSId7bVOi
	 IF6q2sDJysUnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Douglas <me@timdoug.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] power: supply: generic-adc-battery: fix status with no supplier
Date: Tue, 10 Nov 2026 19:09:56 -0500
Message-ID: <20261111000941.99043-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062452-failed-5.10-8ae5a3f40045@kernel.org>
References: <20261107062452-failed-5.10-8ae5a3f40045@kernel.org>
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
[ sashal: Adapted the direct supplier check to a > 0 comparison in the existing is_plugged assignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 09bb4ff291cb0..8bf37e06e3f62 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -212,7 +212,7 @@ static void gab_work(struct work_struct *work)
 	adc_bat = container_of(delayed_work, struct gab, bat_work);
 	status = adc_bat->status;
 
-	is_plugged = power_supply_am_i_supplied(adc_bat->psy);
+	is_plugged = power_supply_am_i_supplied(adc_bat->psy) > 0;
 	adc_bat->cable_plugged = is_plugged;
 
 	if (!is_plugged)
-- 
2.53.0

