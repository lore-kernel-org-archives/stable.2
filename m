Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312175;
	b=DatHnmFZGlIsmYNUm91aOJkKEWy6ZoW0SQTbR6jnaUH4O+NKHlFT2+pNzj7OQNXTWDQZ
	 YPTJhSVwaiPPsPVJPmfHqyMuKGL1EMJbdHMoEuvRfh61KGL+CFQc4m3Mf5yN8v7sqHSe6
	 Ddf2lfjY04qoPhu1+CUDM+dMJ9H9KFhm/HwGSgH305pviakCRlR8s3VdtNLC8IrQbMRur
	 gwtQRXXDQXOhdhOSa6kr00Fyze/X3KsYt8yxzxfF+DbuZH45PvNvbP+rsGJqLgWDOCwUl
	 poLJdwZ7HzC2/FR2us2RdxAt9k9Y45Zv8YzErp96H0TqqdReaTNgqHnKoysNF7h7SvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312175;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dHuPs2iS61yyq06O+XCy8ckViPC+lnDYLOEXVTYj+js=;
	b=4TML3xBzQOkD6NBv1N0amRhPOsdo+lpyI+CP8JxCq8t/b3bHSi92b35+beTANiT3YRGW
	 uR2SycRrX80Qi5HzmiV9hKXs3CfFkSyfrgfpjW+GN7NLlZGiFC8nfc+V36Z/y3kvfrw0x
	 TYehRm9kX5A95g4bHWRiRwEBr+unO798n/+hWTYqYYuvz/T+17smh5ACyEFJ4PJmMQUEB
	 iqxDDLt2Dy1ZioknIg8DS90m03m80wtyHR5J7moPORSa246N9DUbn3LS+Lio+O1Vn0j98
	 J+k1tEqpcUx+xEDmFtnnWO3s7m9UDZsB8pdaMdEL6lS+za/68bPCAIOhFuu4OEKU5cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApXvXmRj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A0606A33A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApXvXmRj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D0E1F008A3;
	Tue, 10 Nov 2026 12:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312175;
	bh=dHuPs2iS61yyq06O+XCy8ckViPC+lnDYLOEXVTYj+js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ApXvXmRj56HLFswUaCjLGavobP5wMKZJFQV3dWxavklX9jdoqvizvEHinLcFEH6fN
	 n5nG76dPkcL6QmbQWD9QZGeiOiKjOobTLV9Lue2TnrE97dzuTi6BjZrIFJxBk9oxPe
	 7vQzKAM7QIES3hnlodISP7urRk2V2Gdj88CVSuU5HamrHqqD8Rjk6F0P7fPrJNvmmL
	 b/EtQ54tsbv1OpAnwbLNcApyXMXpElQXnIYvXwGHFudA7JjHrQ5qkexXd6yayFmDD5
	 KTCo83UTxjhkOmvClmy4B5ajNVkayA+lOYVffC+grSNaDeXuYjMQ6wsA+uo9yBE61k
	 zliqr7XQZk5Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: i2c: ov5647: fix power cleanup on remove
Date: Tue, 10 Nov 2026 07:02:53 -0500
Message-ID: <20261110120233.954446-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055958-failed-5.15-6e81cfc38548@kernel.org>
References: <20261107055958-failed-5.15-6e81cfc38548@kernel.org>
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
[ sashal: adjusted context for the int-returning ov5647_remove() with existing mutex cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov5647.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 9d28f1c81d444..35a8b03e3b94e 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1460,6 +1460,10 @@ static int ov5647_remove(struct i2c_client *client)
 	v4l2_ctrl_handler_free(&sensor->ctrls);
 	v4l2_device_unregister_subdev(sd);
 	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev)) {
+		ov5647_power_off(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 	mutex_destroy(&sensor->lock);
 
 	return 0;
-- 
2.53.0

