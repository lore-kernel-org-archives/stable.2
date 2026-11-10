Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312573;
	b=3SbPci6FJk8G5d0TAiS+7UPEtpLwZ+W8mvAE5ryt9qojnc615dTT3zQFfmq6OajLF+cA
	 U68d4qrIlJti6bArht57NFRG/hbuEmIG22wGYa2zme9P0Rt6MQOOvaFm/N0L+h431ShNe
	 fnDxLzCge+qYs6lyrHaiOgH+SKvYb2/QG4KPHnkTY9vfTWNPKRQjV6/sqda0/8nVfTtvE
	 SNeZsrJxbpN9t7a6/60v+oaNfaqHR4ZSb06ZdGKqN+4bJZp/Bl61W212765v7YsOxyB4n
	 22dLyxf0mI3s28KpQXQC9jo2IduvJeD4YTN0prcEFp1ThDW7bd9bkL2yh+AGXPP2TLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312573;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aV3VSNyDCeETB2bpZR+os+CQdyhbOMKDiVhW06T9l24=;
	b=ypTZ8Zhej5qsiG8Thko3BthdLjk03iUmdOM4nxRIwcD79NuUq6IcIll//sl9QGNZ0aKl
	 PALg5/hECRWFBqQI71dG/w0CLl9eUjYLpqP//fT7ArYSsuCfCORPyWEcveB7DzI4fFkA3
	 0OIKtjDo3FtQ5xp52OyKevV54Y0uSEo9negBJGqAQZGHa10C447t+ISGoLdvuNqgnRvyr
	 V/VRjwhGX1d0G1kGP7LLzjHe7Dmb6ckMCoWEv6Nrf4nexZOh9/gJvynP4nhBfwsp5ulot
	 +q+ha/+NhnM9iwWSv82JuMnJ6aZpNoZz2XdOc04p8lsPi1YRVx2zwEAlXXdl+zfbT1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mb4doQLr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECE6606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mb4doQLr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C171F0089F;
	Tue, 10 Nov 2026 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312572;
	bh=aV3VSNyDCeETB2bpZR+os+CQdyhbOMKDiVhW06T9l24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mb4doQLrjPY8WcY+IPQXSox+S3883EENGgfeDQXPgbDadGHdJFNwCqXduc2zPgP5y
	 I4rH0KR1LWBo1ROvJooBoW6/yRy0znmiXmjibkUbtPRVsX6cRSSueLoqB+JWpLMAQW
	 4sYE/m4Qywx1QmhfnQvahznkS1z6fwyM1Gsbcufydo6NilgEOl/txbs/LduQF8p1gw
	 OFSWbmvQOcHs4R+1UJe5azX/wlWaAIsPkuroK0f2AGdUZyVi1FF9we4n4PUnTLnKL/
	 bNwWzdnASIX3FcsPR7ndQfyf78QOC/aXxCDL13Q5wACVVACWbbmcdv2XA7Ij96zrzK
	 r/TlfGV0CGBNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Cesari <fabio.cesari@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Tue, 10 Nov 2026 07:09:31 -0500
Message-ID: <20261110120903.984792-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061538-failed-5.10-0e30d15b1564@kernel.org>
References: <20261107061538-failed-5.10-0e30d15b1564@kernel.org>
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

From: Fabio Cesari <fabio.cesari@gmail.com>

[ Upstream commit 0e30d15b15647df786e60022650613e16dd70645 ]

isl29028_read_raw() and isl29028_write_raw() take a runtime PM reference
with pm_runtime_resume_and_get() but return directly on their error
paths without dropping it. The usage count never balances again and the
device stops entering autosuspend for good. In isl29028_read_raw() this
needs a regmap access to fail; in isl29028_write_raw() one rejected
sysfs write is enough, for example

  echo 200 > in_proximity_sampling_frequency

which is outside the [1:100] range and returns -EINVAL with the
reference still held.

Take the reference with PM_RUNTIME_ACQUIRE_AUTOSUSPEND() instead, so it
is released on every return path.

This also stops the return value of pm_runtime_put_autosuspend() from
reaching userspace. That value only says whether the device could be
suspended right away, so -EAGAIN or -EPERM turns a successful access
into a failure, and with CONFIG_PM=n the stub returns -ENOSYS on every
access.

Fixes: 2db5054ac28d ("staging: iio: isl29028: add runtime power management support")
Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: stable@vger.kernel.org
Assisted-by: LLM coccinelle
Signed-off-by: Fabio Cesari <fabio.cesari@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: used explicit isl29028_set_pm_runtime_busy() calls instead of scoped runtime PM guards ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/isl29028.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 15cf67b5e8549..8aa84e06eb51e 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -409,14 +409,9 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->lock);
 
-	if (ret < 0)
-		return ret;
+	isl29028_set_pm_runtime_busy(chip, false);
 
-	ret = isl29028_set_pm_runtime_busy(chip, false);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 static int isl29028_read_raw(struct iio_dev *indio_dev,
@@ -425,7 +420,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 {
 	struct isl29028_chip *chip = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(chip->regmap);
-	int ret, pm_ret;
+	int ret;
 
 	ret = isl29028_set_pm_runtime_busy(chip, true);
 	if (ret < 0)
@@ -478,17 +473,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->lock);
 
-	if (ret < 0)
-		return ret;
-
-	/**
-	 * Preserve the ret variable if the call to
-	 * isl29028_set_pm_runtime_busy() is successful so the reading
-	 * (if applicable) is returned to user space.
-	 */
-	pm_ret = isl29028_set_pm_runtime_busy(chip, false);
-	if (pm_ret < 0)
-		return pm_ret;
+	isl29028_set_pm_runtime_busy(chip, false);
 
 	return ret;
 }
-- 
2.53.0

