Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311896;
	b=sE3GEVo4Hs0U2HqgYVf4tJVusYPzUQk09cmMOE9bv3vmB9cEAHgvwToPBmhMisa+1xnu
	 hI9x+LfkmrkP1yuGspwbqIN2NuJqJkgi95yd2bfoZCS5pvmTZ06Tqke/2y6fEj3bo6jGW
	 tJDSgTdvi+3g3dbfO2EfSljAA2IYFSERuELCHbptK+8L4XdTuc1at5cKdFqqTJCE8/tKe
	 +LfO8UhD10unYbnWgxEuwPg7uM0jOZ2lQ79JVSolmrfEHb2eiMwxWIcTcO8LyeqNXLVmr
	 rpdFnaMnP+0BIaErgZCBrOALGCXy/drh+DAXJF4qa2GSDt3UX0RDD05bMnfnoQN6X5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PAEGabVRQ8b5qn5JBErgRoF0nZf2Ha2/DuZBdZe6s+A=;
	b=KsAOiykyMKiVuOhuXrCAWTjziD79FZB9s3YncjJ+Ezr1dnZcFcGsYSv38JQbQWev2y65
	 umJOunPwkKaNZEAHYwroVrQwS6oaZpYtzEEbnlNvw0LVbC/msX5S3uQwcm8N4pZ3zGEed
	 h9JostD+AlKGYnM1gdJ8rpYjmK1MigzBWYjy5qX7cRlPN9xez0z+Y3NzJG3cb4QbSCQB1
	 zxagQzd3Ikyur/McWuP11XEAMLrpZUAaU2S03J3D4d9KC9+pQfGpRl4cyl+wYr3dUFgKy
	 FRz05SsBRBfZN2FCqytkgrJidI+8ccd53Z5g1iEwxlt4jWSWp66xKeTtWWmeEwumsKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTUWdKge;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E0606A337
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nTUWdKge
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9115A1F008A6;
	Tue, 10 Nov 2026 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311896;
	bh=PAEGabVRQ8b5qn5JBErgRoF0nZf2Ha2/DuZBdZe6s+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nTUWdKgeJ19hjnAEk5EDqwwzDvECCaMB7iykVDqWYSgq81CO3xS26c42Rw0x3MbDx
	 fN6QiB1I5KD+5CR6CvKXdIZKbrrS73HVzy7Jsf7EVK009zptdU7ZHdYhYKXI1ZwuAx
	 vPlEOXCUcZzUyz0xHZPkUpJcX8Yb5de+d/4nqu5zyxq1LEQ2/v+hp0R2vLOtqetjZY
	 LpWjD7cVKF/LBlWoS8ZTmyqvlSIPl1Q0ghzWKCT0ebVN4GppmlvYXr1wPTNu/ku7P/
	 MNq5BWfn6oWY2eCc/gUSjQsKJiGQZLqyrz4GqiMbgTDsvEPcB3h1v2LlG44g2egpVR
	 lqyRxnoEHPlVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: i2c: ov5647: fix power cleanup on remove
Date: Tue, 10 Nov 2026 06:58:14 -0500
Message-ID: <20261110115754.938132-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054246-failed-6.1-6e81cfc38548@kernel.org>
References: <20261107054246-failed-6.1-6e81cfc38548@kernel.org>
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
[ sashal: adjusted context for the existing mutex_destroy() call in ov5647_remove() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5647.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 869f4d3840f12..ff3752d53f27a 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1460,6 +1460,10 @@ static void ov5647_remove(struct i2c_client *client)
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

