Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8594779A1
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130826; cv=none; b=BnU1BPrl0gmDo8wLtcVwpVs9xffeAIh0azNN4LWk0LkrMitXKHZS2yOAPYHv7E4mib2SysH364a4iDzjFK2kABhKW1g+SO8JgsdJwzvs3siseAK1uNDm6IXb4Sk63cYwuhQuTvjkllge9NzJe/ygW7sv5gJVN8APx2hfstf6FsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130826; c=relaxed/simple;
	bh=/r9ISEypNUgxoR1aUhPMOFroNJaJzOX36m/yzkiG5QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9l0cr70cBaiAtv2Fa+t3rgaaTS+RFDewNtn+RR/emIr8EZClWyAEgkbQFCL93LypF9GZQhAAf7cabkox6nWVH16qAXU3Wmlez/DrTSTFIEmoS7FqxbHgvILVKZ38UerS/PZH837yVIm/ytDebPHLjureyj97xUnB1JvG1tnWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2uN4bpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2uN4bpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F511F00898;
	Fri, 11 Sep 2026 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130823;
	bh=Su1aXEi6C7FFZqAp7a54otYNLPfoPqozqOIDTrDP4qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M2uN4bplJ+ydBvDEeg7ueJss8sMpW+pkuAwlZUFeHer2ZTzMqh9mGejLxE/jNpy/d
	 glmzmHESCTpeWGkskfNnrvnAXxa3FfNp6wZvH6SKGACu1S3oIwgAuhX/zAaZJTW56E
	 F7Rbu8jk/oNTI1o7MomFyVis0fKasrcCV5GAfglUKUtjVUuLx/FJzqY5rRWbKynNWQ
	 TewUqiOnYOYgmc0TFnLOQtbAzDpobFFt3tfdY36LHfWpYE8fu77VEd4HX+Nn2gNPmg
	 1K6S0cnzWGJT9QNhNQ8A2HOfpz3S2RoF619l7jA7RUUCmFenoxWd9Og9X1/uqbL6up
	 RRw7CAZ4W9HvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] media: imx355: Avoid calling imx355_power_off twice in error path
Date: Fri, 11 Sep 2026 08:47:00 -0400
Message-ID: <20260911124700.642910-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911124700.642910-1-sashal@kernel.org>
References: <2026090912-crazily-password-6b21@gregkh>
 <20260911124700.642910-1-sashal@kernel.org>
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
index e3758e3d78032..a3703336468c6 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -1792,12 +1792,13 @@ static int imx355_probe(struct i2c_client *client)
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

