Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311660;
	b=nIajWARELQ0UxiFOpky/fpxifUob6uD1opqwSEB60NDy9iWlY41hGMWR2M/vINAwBXmi
	 wloA4gTIq5Y92PiFxXLnEoGoEmECLis22rwbNmA8P6J8Yef8qN3ZFg2Wrcp37TAKgeWRH
	 a2W4yRQyMxdcviYp0CwvRicWyRlMtfEfdO2gJEmbFL7h8BjA/2jDIv/mComVh9kRNy7jP
	 5tgEjkDPYRSEORnhhF8sYRGq5OrfW43+kjFzhy1CA+Y/tEbDRYIq23oZRhzHaMHlcN8Ac
	 7EMAmI/cy/zQ84SHVLV820oYluIXwNGFtCiKdmilnZ3LrfGDlNHIIXemq58rkUtc93g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rcO+2gyEy8Y3ctFvDzXjDpLJroC5SVpKsfFxQDULnSM=;
	b=pKGGX8BaWdnBDJLu5+tCEx/vfNmdCLhAtP28oI/uSjLXXlluwRr9K2a7Jn4Vaitnfajo
	 /bTPVsITGANsWEqLVZM25LpQUWCwW2oAVo7CQlf0pXvdIpZQI4lMpjkhA/k5IQi0th+OY
	 uj62/EmVMV933HUJ4gs7tYjfEar144EenRHHJqHDB9LiStuaOyywCnKGMqWMpUsY3ImXO
	 NhSIVL0mzkjY8NO7791z09fDkTxDLNfnutsXpgg0WOcZHwW+3eYUmruLSdMan04kNitbG
	 XNXKRdkqIDWK71lPpQ3EgqonXu8pEgBufI3LGv/Lv264RjX6qziPf8POIlXVZMj2PyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ye/3TF0G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44DF606A989
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ye/3TF0G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B937E1F008A1;
	Tue, 10 Nov 2026 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311659;
	bh=rcO+2gyEy8Y3ctFvDzXjDpLJroC5SVpKsfFxQDULnSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ye/3TF0GQWbP+1c88Fo6hOVElyipdON0g/Zi7qWkdmFK4yKigft2dz+cCgQCatzYS
	 EWSoqECGZ13a4U2SeEQ1pULrndzw0xi1DJixGT5xAirw3dmNpc8X2lLKq0mb2Jp/PZ
	 19kZjejb4EJpY7M7gRkHwW/eOdFE6unyvh/YyZuJhGqbHGlE74ORppVhUjtZ9LSxS6
	 uQagCBVz1cT/1pj5cye/jiguktvKbAkHpimyqBcJlWGMtYQshsddfCrHhccc0/jDul
	 YGjtcW7B1yBWrSyws5wnuTVH53RgtL/fWJNjcPhdt/KMWoorBlTHjXVRBWih6CKIGz
	 6dLYibkM45dDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] media: i2c: ov5647: fix power cleanup on remove
Date: Tue, 10 Nov 2026 06:54:17 -0500
Message-ID: <20261110115401.923018-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053005-failed-6.6-6e81cfc38548@kernel.org>
References: <20261107053005-failed-6.6-6e81cfc38548@kernel.org>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 6e81cfc38548109021ab761b94ecdd01f8753154 ]

ov5647_remove() disables runtime PM without powering off the sensor if
it is still runtime active. pm_runtime_disable() does not invoke the
runtime suspend callback, so the sensor can remain powered on.

If the device is not already runtime suspended, call ov5647_power_off()
and mark the runtime PM state as suspended.

This issue was found by manual code inspection.

Fixes: 089b7c70f0d8 ("media: ov5647: Use pm_runtime infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
[ sashal: adjusted context for the existing mutex_destroy() call at the end of ov5647_remove() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5647.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index b8033fb7aa30e..66add3d6e3908 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1490,6 +1490,10 @@ static void ov5647_remove(struct i2c_client *client)
 	v4l2_ctrl_handler_free(&sensor->ctrls);
 	v4l2_device_unregister_subdev(sd);
 	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev)) {
+		ov5647_power_off(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 	mutex_destroy(&sensor->lock);
 }
 
-- 
2.53.0

