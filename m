Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311122;
	b=XMlf3wWXQytUlVorn3Cq07fSpwb83FQuRXUPRpPfqfzGQNCxd4xySzG+ebuYzm4FbUv/
	 uzuBK4H8NXC3PI8LbmICzaVGPKj+EgsqoPDiBtLgLCgs2OnDj6jJ2xB61ysjB829HtrOb
	 iTwYkr0oBdBGsx2jixEK/PVeIXexulFeFAlTLUinXufXK4IOtL02lVg6Yq+X8sPXVnyDO
	 8qkEK19HGPeyGWpHtKWqUuezlSjoXAF5Eom/Ywp2qr47wNXSnua/oyUKqrn9itZzAT2vq
	 jn8hDqfjDEQgA0/86cwCdD/n4Ztc8JOvvZjEPoom2qQVbL5Hi5ZLK+PQncLhO4E8Stg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311122;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cua3FrsxiAvFdY3/fbWCBzaLljV4it3/AwUIUqeblkU=;
	b=IAkcFlKCtvOvtLugJLVYLrbSWfmv2o52ibr3LWu0mBLaV6+XA7ftPhdDXkWPpZnR5cbN
	 Ee8y4ihCMXaijtm6UWDp49sk4OqfpL0Enso22Et3xZinpodQCRhn5t62qkjj+OHo1wRxc
	 PFHB1fs+nkS/lK1Rh5LEfKixvWMeV7EeY7Q5I2kYceg8rdhsy3ycnsibJRw1aahR8uM5c
	 +CF1FWG0JrZYgO39TDzg+lnv9SWL94hoEAVByN3Jza0w+bWFaC2mnghSSxG/z3fjCc1x0
	 7rcelZZcYdupBZt3bEZUeRuBwDmJV1C8trqGCSEOsVPRZHbDhrBbEgHjUXXoVx8WZwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WE93QzJi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E14606A334
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WE93QzJi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0E81F008A3;
	Tue, 10 Nov 2026 11:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311121;
	bh=cua3FrsxiAvFdY3/fbWCBzaLljV4it3/AwUIUqeblkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WE93QzJibjsz4a8ccq24A5gnl+CO50gwHwclmFRXctOiImMDCFV5khfVQ5ezXxt3a
	 TqIsnnCQNAg/qLmXMH4kdl2m4Uc7DCZNMTpVHY00VFKfRvj/oqCRp2FvHslAUqqq4e
	 wKn9TDEe1VNh8Y+2U0qANHvbQ7ZIF4DBxVTRPaUChfgdATOf9Ri4q4xXZo49kWqI5u
	 Trhzq05hSG3cXf2HfKCd37CXo/t42nuGM+mgVUbTE2geyhEG8JK875tyMBE2Eg/7Lv
	 V7/+jbu2TKB1pOvBv5/4s8l7h6UqT0zP5ZDpwnSxl50MiYFdeDqr4s440seAv4gfn8
	 bpXH15s1oBddQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Cesari <fabio.cesari@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Tue, 10 Nov 2026 06:45:18 -0500
Message-ID: <20261110114512.606630-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110114512.606630-1-sashal@kernel.org>
References: <20261107050644-failed-6.18-0e30d15b1564@kernel.org>
 <20261110114512.606630-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/isl29028.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 7590efcf8dedb..408b32d096a86 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -342,8 +342,9 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
 		return ret;
 
 	mutex_lock(&chip->lock);
@@ -392,14 +393,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->lock);
 
-	if (ret < 0)
-		return ret;
-
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 static int isl29028_read_raw(struct iio_dev *indio_dev,
@@ -408,10 +402,11 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 {
 	struct isl29028_chip *chip = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(chip->regmap);
-	int ret, pm_ret;
+	int ret;
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
 		return ret;
 
 	mutex_lock(&chip->lock);
@@ -461,18 +456,6 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->lock);
 
-	if (ret < 0)
-		return ret;
-
-	/**
-	 * Preserve the ret variable if the call to
-	 * pm_runtime_put_autosuspend() is successful so the reading
-	 * (if applicable) is returned to user space.
-	 */
-	pm_ret = pm_runtime_put_autosuspend(dev);
-	if (pm_ret < 0)
-		return pm_ret;
-
 	return ret;
 }
 
-- 
2.53.0

