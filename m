Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049124;
	b=oNVgQyp7/LxFlksnFnTVcWC8MzGtrb1m65sai5PRFuBmkDWKDR4hG+TskAhbwFPrb6J8
	 GZNMa2oBv3jnMLd6Q5kfmQCXXMvUkNKb0CQrfcO+PWD88wKSqwJMgBnc5Kb/LmEzRj7F1
	 yjAKsXujqe7jEvoKyGjgRrNHNED5BdP/SAXxzS+yoQI9XzftTg/nYcTBIIQgPNZhahaYX
	 FYpnWFmPCTEYm+lAZINAO2lji/ZL6zS/0w/XnKTJU/QAzrNCgGaJvmeiHW2lgbqxw5e6O
	 32JNrs+4Cb26lRHMOpDgsKireprOnmPSTj9r6pLTwTT1KWzU0S8T98QJqV5AqaHo6Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049124;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Mk3GjcXo7dUTVbrLjQYFiclW216sPq6irm3lUJ6aIII=;
	b=TCFQRJTm2eE4WZRQCj0RXO7etQwi8uAakIr7R1PeEfF8QFkqMMfo5qtdGkkgi8HH7jf1
	 Jc4WLOC3MBF8leOgrMHpVXxjgjP+w9fFCgkAgSuLpg0wd5XJCn79bDhiAOlsY7b2Zeux3
	 6aTXKm4x+tc9aqdaN8RFHMBGmrfwmk+dBW2ceSxzMgHnlsbAw/hxEi8ovmwKP7TKWiEoX
	 7+/IV25LVCagZT6iZPwYZfjaoyy4y5JFzWMEy3bcLHnJeu0VbKtRgJJoj5hSWrCyKY1q0
	 Jdoo5+f7k73ImDjBOQg7ske6Pyxe3QpLBtyeitMHBNwPY9ZysiNLtU7T95jY56trSUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQlgRcpH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11C606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQlgRcpH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147F81F0089F;
	Sat,  7 Nov 2026 10:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049123;
	bh=Mk3GjcXo7dUTVbrLjQYFiclW216sPq6irm3lUJ6aIII=;
	h=From:To:Cc:Subject:Date;
	b=WQlgRcpHQPWImQicOHvwybvVGDwYKygIrEv3Ta6hpMgzWDsYKzHh9yCmbaKskYhFx
	 5838ntxJoJJLM4HG2YOpy6l9UYtK5sKM2m8oYXUFyuEKK/2JIIEs0pGppPA5phap87
	 WjM97nFgtmTQy4poyM/OtEIydw/K62Z49Vy/cwwCuF/r1pWmeSBeiXT88wahPNQQy5
	 9GFmJ583y/pHiQKfCxQPe4jRk787dzq3Nu2wT5fjtTlU3jwS5oAVC9vnr+jfWsM0Gd
	 jb+jnMShGnCTsO7aABX14oe4GdOX804cM44tFIhxhnk/FRCIQnLeilurgTIfEzrq3+
	 KJFrhGHheK7Pw==
From: Sasha Levin <sashal@kernel.org>
To: fabio.cesari@gmail.com,
	joshua.crofts1@gmail.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: light: isl29028: fix runtime PM reference leak on error paths" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:41 -0500
Message-ID: <20261107055841-failed-5.15-0e30d15b1564@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0e30d15b15647df786e60022650613e16dd70645
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055841-failed-5.15-0e30d15b1564@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0e30d15b15647df786e60022650613e16dd70645 Mon Sep 17 00:00:00 2001
From: Fabio Cesari <fabio.cesari@gmail.com>
Date: Thu, 10 Sep 2026 08:24:35 +0200
Subject: [PATCH] iio: light: isl29028: fix runtime PM reference leak on error
 paths

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
---
 drivers/iio/light/isl29028.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 33deb1726689e..e481ac908fc13 100644
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




