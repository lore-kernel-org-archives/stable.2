Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311249;
	b=AkPoy1uHQyt195oknIlVnpWVTfXsY1j/0LYdCPI/arfZclLobtF8l9VP/tAXtx5EkQjq
	 JA/syTY2HSs6mnVj1Rj/AhG/EHqS43+2eueykAiQ7yzXw3WQv5W7Cp0EPLonHYs6Bx1JV
	 tw0t0bRE0wDa7vzscnOvQAXkIxD9p8jAQl6HKr58/Podym9Pgsl+wpB6Hp6oFlk06cOgy
	 jk7rjEl3d+oJ458GyItfYJ+kX+4AOK0QrFpQQ494vOGrEOCmDstoW6UiCEy4zp8rxaXKc
	 +rd4I9FZDyWk5Fx2lVgXU0KZK13x5DgLdlLl04GoMW2+8gpZngWvVf0j0jsbwm5LDgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311249;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WdbAvBnzad3RXmfLCFHmEZ4sAGrZKhbza7Me1GPWbcQ=;
	b=ioKNsxFnl6/KpxdfdsTOPDqaytlnz4LCyUsRq00H28FTZwIbC8kcco863JNTAX+Ozn++
	 oyDVhpDMl4WQYbwcAIejcNPGTOKf+4GYM8h1GsNZ19mMj/Q3ho2U00tu1MTnaVN6OSSJc
	 iNkAWQo8HZ2Mosz70PTkwgQcGiYCtmLao+7vuZLbVZ8osJvboAih7Naaxr/B/soOepckC
	 2NM03egiscBTeM+fqH/QbD/3ZQ7P6VpXRg+4ssXgQAL3vslF5ieR4BXDYG7UL22GdTY0T
	 pPq5y7OSNJYwpz/eq5fcaHUxcEJLz7/JIh7MHLGrZtAE0lUmCFBa4xTs2qE0aOzVTmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XqMZNP//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EF60A5BE7
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqMZNP//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03601F008A4;
	Tue, 10 Nov 2026 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311248;
	bh=WdbAvBnzad3RXmfLCFHmEZ4sAGrZKhbza7Me1GPWbcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XqMZNP//DNMmBtgTvCoUL2LFASL75I+RAuif3EQsRjGZ4aHr9jurrnaCc4sn+j+BQ
	 uo194m94wZhz39RN0AQHcuBWjhnvXfUmqDMQHIHKVh1RAiKrqYXxacojJ8cH/dhpzR
	 2wyxIQ1buKcEtEJnBsDfsdqinUrMlwVnvsXRpVO3CPUa2JwLbtB/rTKtet6L7kBpxD
	 5sb2PuLr6v7d1GYBJiSNS7JsiGKVZ9XUKJqQwGypFHJu77w52PLRi8TmCXDrk8Cxfg
	 PuU+LbliyqhSVenUBp93Pl8d9g16KPFtsmZU2AcDoZT/7iSgS+UBJLkhC30aZeA5Ww
	 5SW0RqRf+4oqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] media: i2c: ov5647: fix power cleanup on remove
Date: Tue, 10 Nov 2026 06:47:26 -0500
Message-ID: <20261110114705.606262-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050714-failed-6.18-6e81cfc38548@kernel.org>
References: <20261107050714-failed-6.18-6e81cfc38548@kernel.org>
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
[ sashal: Retained mutex_destroy(&sensor->lock) in ov5647_remove() because the driver still uses its private mutex. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5647.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 5fb10e02ba6e2..36460440059ab 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1480,6 +1480,10 @@ static void ov5647_remove(struct i2c_client *client)
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

