Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F6B332EC5
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136033; cv=none; b=Pw8TGfbaAOQspXKeqJS1Dlx/jEsgiCd8XP/QAwTxMXwT76eicVhjGJDBkNqx5Aa3oxyIxccnoORajajf5b4tRt79uGwvJ9VJsTqtqQv6yJJxwPcd48TEvtVwUEgyXopazGO4RNOw3y2mrOvZFMcH7GzzFjJfznS5ESBd1OxOnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136033; c=relaxed/simple;
	bh=DIQyLRFQwUe4O03mMTe35v1nHxi74UoYEWApL3rpJWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0AsfwhYXbUdftWEG4rpiaAes0kLO3Y6vffFII/1G1iYPv6gWc67ObNX+RRZedYuY/1OI34dIKqA4AiwUdwxcbsy0QfB7PPXn02ocf5IxInnh7UNmQcI5diqAbB3mVC1t/jz971OrRIvTs7of2X8Y7va56yU70dw/m2AwKZ4sX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on253ddA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on253ddA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BE81F008AB;
	Fri, 11 Sep 2026 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136032;
	bh=OoF0f23Cm0m+ZxN31JOnIckI2EmeBNmwLf4/0qi538M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=on253ddAkbAxLmWcdgdx+m2VFufegGH0M0dJnG3EQt/egu8NUrtyjyJd6wZamaGBC
	 4aWW8nzjN0Xe21JTY6KKTkuBE1k7trYh1jKt/keSVGCWagNR/siDTk/rRh+Y0GtmjV
	 P0oX7egvOmPGIm9CzZj+AXuwcxXSF244JE8cTIY5WA+JkLPmt4KiZOfs6jikhSHGpm
	 97d47ETPIuhhNbXft4b2PBh176U4U6gUfi/hQxuztMJC8D5luYanKiI3SA4z01IAKq
	 +3R736A74ilK5MHf8ftm8XJe6XldiWv6YQZChybQ2NNKgNFZIZaLFUkvAmcw3AQ87G
	 MjAWyzZ/9g5WA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] media: imx355: Avoid calling imx355_power_off twice in error path
Date: Fri, 11 Sep 2026 10:13:49 -0400
Message-ID: <20260911141349.763256-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911141349.763256-1-sashal@kernel.org>
References: <2026090913-pedigree-concerned-351d@gregkh>
 <20260911141349.763256-1-sashal@kernel.org>
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
index d5c3232e3ee7e..1f401d37c9c0e 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -1788,12 +1788,13 @@ static int imx355_probe(struct i2c_client *client)
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

