Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311684;
	b=1xyldWJfajwQTrUQeB+jWOxF+IVGNrQTKEFgrJ4VOhwIXo70QHpUymrcWSqPj1oJWZsT
	 IWcVRnbYxrVSvvDOuf2JBnRdtYBDYr1s9UxMYEZximqwB5kEHCfYIvlcmROtIU0hi2BfU
	 ajMTUQnzGETqIiA3wopduMIq0Me3hKixkNwffdofduxSNU9ZEkYugLVdBTwOcXxekZTBM
	 VL+wqZBV7nyW8w4e3eRXBPh0Tjr24WUIiUNpTYbxBtM3SHT7UX12lcp+Jwpmoc6fDhw3f
	 HTZY/D6Ul/gMLACh+r2w1lDKhyyJAG5Wtb4RI7fApu5DX0jSz+ogDFcIxLItn7i9poQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311684;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0AkHWQs/s12LhSmIYCr9Lb8bSowvJ03t/csfOF2vZK4=;
	b=RSmYgs3wt4LlM4MZe4b2qYD494H21BU4LY4wzqENI+1p1x35tYbsk0aElr5hEbHyUUZg
	 YMC+c4zrXVJBgI+le4NmQK4WZx4ATORvpxNi3FF7HC0CNzJiih+CmIMkCUArr3yEd0HKb
	 h4RfkVsVKXBn3rKSE4TreIs6EdnRQJTSrKLsRtwzS/EEXdvjdWVbzQixLGQCW7lbkB+ID
	 UFzOy6SempTH7GNUcbhmJnghz3FjIkre+12Ukvn07Vs+B03GVsn/QDr0neRdZRmbTxNLZ
	 cFodpn+JNfNhKutIfg7zXeoncxe8NCJMPjAz34VeLXo2UIltwNPqKtUfjRLxp4kSSKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyNhXxaT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659F606A998
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZyNhXxaT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18A81F0089F;
	Tue, 10 Nov 2026 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311683;
	bh=0AkHWQs/s12LhSmIYCr9Lb8bSowvJ03t/csfOF2vZK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZyNhXxaTe+TSgzggMyOT2BAd7ydL0JVhUUq0hs0dptSGDk8oSHjgsoei8pZe/GZcp
	 RMLf6mH6g1FzBR4NGyPkGHXMVJzV5Ix5+QFE7GmSu53+53zbB9SHalzw4ZmmmZoeGM
	 Jh+KcclGHdc0wGBBZQY9YFVMz7yFdcqIegtIXA72uAb47ez0p/qnsoE2iM8YmuBli4
	 objQa1XqJ4lK54czvHzeV3EFNZFe2K8LZmO1KVdYNimJbwPaYSzBk9toRd+iEoRICu
	 x1u/SgGDHcMrkB9Vby80oB68UGKASnsf6e+DuFAt/W7+rf1JkKY0kV5D8Wd6vtjYXK
	 4ecOblga3+wZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Cesari <fabio.cesari@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Tue, 10 Nov 2026 06:54:41 -0500
Message-ID: <20261110115429.856283-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051659-failed-6.12-0e30d15b1564@kernel.org>
References: <20261107051659-failed-6.12-0e30d15b1564@kernel.org>
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
[ sashal: replaced unavailable PM_RUNTIME_ACQUIRE_AUTOSUSPEND() guards with explicit cleanup through the existing isl29028_set_pm_runtime_busy() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/isl29028.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index a23b2af287d5e..12708bc351508 100644
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

