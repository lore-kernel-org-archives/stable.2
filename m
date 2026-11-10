Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311881;
	b=MhX9sKQ3KLL7DIErIuLeTO23Emq+r4GlZOmACoLQNNjhqP3hRxfkHBOI4gqKqN8lRhes
	 3pV2lyelIYTEKROiLts73yexFXvCfz1SD/owc+h/FvFeIAUyyQ6ScHPUuYb7HhrPaOjwi
	 1mJG14NkEwBgxI47ozdycPRfwImQQ0NBXwxPNp7rEnXrrog9q0esdQH/weoW34MxIT4Oh
	 zDzg1MC1e3VvgAi6cDxlp687PZLtxTAqCAtuwOv6eFOkRdnmVIBVooBu3/de0I0yuXrJ1
	 BxHFhzTyv7n5wN1enMtkcXmIgIfw1OJg6WZ3ILc7gfPJee/0yS3cxK7U9UUOUKd4rrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311881;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MRlcBsYEXfLTOLgnYBNwCH31rRgWf3VIsXtcqykQo3Q=;
	b=maFxWBYSjUJG8RAh/c7cq/sww2otPofZome2i7i1Nb9DWv4iTfsfwYQLSOz+TFUlafM3
	 tkXG4v+DKSE8Tf2EemYvAUAfA7Q8gJ6fzTx+RdgMBjRAUF+qvObXQf+glQanOn8jT0604
	 6WjjxBNE2CSN873v7A0OPtj5O6Yh5hsfqua/iIFSI61Py2TTnYLE/GC3bPPeVmzoltZc2
	 GAS+r9Dr37tPBilNuitgSTwsqes8QyxyLmpIBHTOzN1HB6KeQ2I+ni5sVVsTbQAsxUceu
	 xn/jxQ6uW9AuiVbz4YjYuewf8cF3+qXk/HpOD5LE5CMRJRKeufx0uHTnqHrQkYHJdMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7WZbjpJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93DB606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7WZbjpJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62161F0089F;
	Tue, 10 Nov 2026 11:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311880;
	bh=MRlcBsYEXfLTOLgnYBNwCH31rRgWf3VIsXtcqykQo3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G7WZbjpJ+lEmTcO/XsFbMuwTmnfEWUc4dBB+y/rj7kgAckqiLyKrpEunF9fuhcN78
	 Cb/vWJ41CHFdx7mm/C9NiNAazx88xEV/W2kd4amvPvn61AM1xH1aTBEXY796hmJX0w
	 yUW7iaT3ChVKjdh/2Rgi3ptFlPSXncwdhDsuwl2jboUQipEw/MdgHcbwJzOVrcw761
	 Yr+nHaG/14hHPLnIciCiAC8e9G20nMXjfqnce4vUqCQuUOjtjTJSskgkTQlUsnj3Pv
	 Ixy8kgv+MO5PkkN0f4uDd9KFw8TY+WrGg9v3jo+vx+jm5wVFbMJnatyGQaCEZN4N45
	 m52Kb1LqGfcfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Cesari <fabio.cesari@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Tue, 10 Nov 2026 06:57:58 -0500
Message-ID: <20261110115747.940255-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052910-failed-6.6-0e30d15b1564@kernel.org>
References: <20261107052910-failed-6.6-0e30d15b1564@kernel.org>
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
[ sashal: replaced scoped runtime PM guards with explicit isl29028_set_pm_runtime_busy() calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/isl29028.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 90099e467b707..15b4cd3555434 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -407,14 +407,9 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 
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
@@ -423,7 +418,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 {
 	struct isl29028_chip *chip = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(chip->regmap);
-	int ret, pm_ret;
+	int ret;
 
 	ret = isl29028_set_pm_runtime_busy(chip, true);
 	if (ret < 0)
@@ -476,17 +471,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 
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

