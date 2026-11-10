Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312335;
	b=HaNh3ukhbINkmBbBlyXRrUEWX6gUN9Br3BasnASDNelC8G9TQGoIo5lk4g2fod/naZNs
	 /0/gBgPTZmnxtpw8AFuaLIPyE7As2HLMSVnj+CuAsjucztfhhFDMDO7eJDQSJ0b5ZMiRB
	 R+5SRddDahszVrLCNifJxGAPPSsQqIO7FjHcdNDccGWT9ZEeW8KJDCiVl9oe/qcsfH9hH
	 mkpCtiedlQ0hVwrt+D1282raUQT9a/OUkqExk1zg4HreqwFWXjUO+viECObx9TSSANVpP
	 ieg9OGCfTU9JjRNQGg/J6jcOr+jKEgaO6yed0UUU1RQkyLTQMFDTNhqwDJLjPp2O6vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312335;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U2DQa9f8ebeOvYcY7c//jTjB1zTLJ/zgVqYMBE02cO8=;
	b=dNuxVcyqSXPheAL3FRwLPmwtNVBsVywE1P7IyAujsDd5bMBOQ4pf4KunDwV6GbW/tDxu
	 OUu+QgQonXR02CudyxgsI2NZJmWG0YilD5t6xTevXveFvK4AfTGToKoD7VBzScj87ZsBz
	 HcMEPY76YRO7D8UrQPjiPzI70sUS7ILjXXVqC1FivpzfB5cT2PH0aERYDgaJ4eyPug2lu
	 SL9ZJPbj+pJGHbJEixfcx4SB30iQf2SoRfIsdNUYwQ9EWOYHOxHKKrPUAek0Hywjtuonu
	 x1nQ7w7rr9eTFNzpnLAPYp0WYz1nOQ9hS+QmKXKs4qeT6+Alrjya6WYZJAMkSzBrbMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bROo25Mj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8EC606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bROo25Mj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1C11F008A5;
	Tue, 10 Nov 2026 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312335;
	bh=U2DQa9f8ebeOvYcY7c//jTjB1zTLJ/zgVqYMBE02cO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bROo25Mjadt0L41m7CP2cq90gjeN9tHJCM5ivq7Ohe6d1uhnQe5jUMtlmfj36QzW7
	 csGmuCfLdZ+5dL7+vfQgIaBIJLICofVxt/r1HrWeYxvFYqjmSK/CPxy50fthBeWAS0
	 L/abZe1r6rtxTwS0NNc0c0lYrNUkcYUQH+V/pH3XP0+5fHPyhA1Eufzf3HQ9qYXZdH
	 7cvorNpQhp6COtygV4GwzwGPV5h0lLOnNBp0i+gRiL+k4Rivb2UzcTJZtSd1Q7zdEu
	 pU+YFo/pU0Pyddea4KMfK7LhZde+oBKRfVF4rGfJmkfLYR9fJDeG3Etlhf+x13EVU8
	 eAglz+mphsQ6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Cesari <fabio.cesari@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Tue, 10 Nov 2026 07:05:33 -0500
Message-ID: <20261110120522.968367-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055841-failed-5.15-0e30d15b1564@kernel.org>
References: <20261107055841-failed-5.15-0e30d15b1564@kernel.org>
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
index f4e1f7de1e421..7d377b6a2b838 100644
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

