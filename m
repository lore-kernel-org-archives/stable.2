Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6146EC73
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125990; cv=none; b=ZpLeebG4zgcdFgfd3du+Kw2KIIZJjBK44IRwpYPupAxkE4HDe7ElRjQ69C1Wk97HJgRmIdOBe6Ez3GFaVJhNaPnJG+Yiv2Wkg8ozVWsqsz/Mkb1sKy6mvatmEejS5vktUrInyJ8aB4jeoF40YFata4QtGnT34FcSDWdqRKpvrMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125990; c=relaxed/simple;
	bh=+DQi+NOBd4Up/hc+FbLvtisEq/GM7klA+r/y0q7Oj98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSL9oT2CmDH0Tkb2XotOSebxV9lcnWJviHDOnAHk4tqLEijDcTRIthEPra4WRt75omB/AbyPYn8FzDMhq00nlVyRV/R1TzXBKwxsLf0vZjk9rQktNjGgJztpFYeqKDXw2AsVE40qMX5EymPa8wuCVZTDZ8Q/NaUQJ37CCx070Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1mGr90y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1mGr90y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488501F00893;
	Fri, 11 Sep 2026 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125980;
	bh=4hx2zJ+z3DudEK5BneXvggNtULunODzYNUWQkMyv7es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o1mGr90yXnILLsK3W+3yX72zIIp549atc3kqcFgt+wHsfxJIp7jNdXrqPtZDZqpwq
	 JOIwPOX6n9Txm7NOf+Bqar4XE6bcC81QBdBPwfvddbcOZy/ElNV+rzJfYvF2CNh/QO
	 GCJbkgJsC21qfb7Fy/O7CoKbUR4B60rHdh3em68Gn30D+1Tna3nlGtX5LVoAoQvnTy
	 r7fanGXKHZmhUTdJqEYxSRQCJFVrOe8slYHgyJiUROMvKtA7hi1N42JRwVs9y8g5pD
	 WKjpQGSTVfpNXZeLTw6/K1fv88hh5CIRvPSIcnZ4111nV3xbrOe+JcfIDkZaDZZB09
	 /USx2F2ZMH5uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] media: imx355: Avoid calling imx355_power_off twice in error path
Date: Fri, 11 Sep 2026 07:26:17 -0400
Message-ID: <20260911112617.381156-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911112617.381156-1-sashal@kernel.org>
References: <2026090912-lid-cattail-734c@gregkh>
 <20260911112617.381156-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

[ Upstream commit ee737bc3ccae7dc713ccaa83ffa46080c6031b3e ]

If v4l2_async_register_subdev_sensor failed, then the sensor had
already been powered down by pm_runtime_idle, but the error path
then also explicitly called imx355_power_off as well. That left
an imbalance in the regulator and clock calls.

Call pm_runtime_idle only after v4l2_async_register_subdev_sensor
succeeds to avoid this.

Fixes: efa5fe19c0a9 ("media: imx355: Enable runtime PM before registering async sub-device")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx355.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
index 2315393f32e7e..6cfd543817c5c 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -1737,12 +1737,13 @@ static int imx355_probe(struct i2c_client *client)
 	 */
 	pm_runtime_set_active(imx355->dev);
 	pm_runtime_enable(imx355->dev);
-	pm_runtime_idle(imx355->dev);
 
 	ret = v4l2_async_register_subdev_sensor(&imx355->sd);
 	if (ret < 0)
 		goto error_media_entity_runtime_pm;
 
+	pm_runtime_idle(imx355->dev);
+
 	return 0;
 
 error_media_entity_runtime_pm:
-- 
2.53.0

