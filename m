Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048114;
	b=fUf5gA4McUWWWfsNGWfLqi53qsgqIlROOcsocr54CVbkKZht3OKexZMfv+FujWREjBgP
	 LIAn8cDtRejhEB2ue/YVX9F7H5ToBB7YS7AfW7+AA6hBicUdrgUoL29sum4W8XMZ5Izp1
	 jXeqtGtfELWlt41Qqow8S9F8m9QteblwLCY93Uc/3k/IwyBi94CDewID2Bfxisziq8vFm
	 s4ZQh5p69g8yU8vjY/hKIW6ocuS/9nIQmX24sYmLz/mkMGglvShxwj2NZJYyzBAa9M+zV
	 PlDzQ46ome3v3X+xir5HQZlY6yOS+8JpGoEzDDCS3/KP3PxOj/ml2iEy8FqhXv6EYsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048114;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b8vmB5SVeNN7o7Z9NVl38OmysH6f2H3dVZE9DljM6P8=;
	b=RX6KDfl+/6OEWJPOivnqkEBCpMhGGd625y0jXAmpRjeta/nYBhB4l1SP8AyTuzHh6MKq
	 gvewTsHkSfdHPZgXTAIOM2Xfcg4XO/trnpaAssjfhWePo7j7Z9LzvL6LRm9b+j8S8LJTy
	 0rrsOpP0Xv59dKE6pdSlFD60QoKSAYoGbwPdNY44ayYAC/siHeLYyZb+c5lWJSk4PhM94
	 WSOBB6ZUi1ZIsFsLLuDDoC5HPg6J+HbO61Pk7piQUEUloElALabHnoTdeowf4mKoWaxHS
	 heRK5OVmwAO/m73DQwooEDTGZWu6ZrKpFqod94S7xn8ANN8w7GhA8L1pMzWrJ4hbM/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwAlngUB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18842606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwAlngUB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DA91F0089F;
	Sat,  7 Nov 2026 10:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048113;
	bh=b8vmB5SVeNN7o7Z9NVl38OmysH6f2H3dVZE9DljM6P8=;
	h=From:To:Cc:Subject:Date;
	b=PwAlngUBfl83NgJEgvJ/rCg6y8x+sPwOVWS9ANbZb0efXP6/7Sq5Rh1ivT3tYoLHH
	 WKFsEzbArtgimV4K7crX15KyFyDT22o5ZjuDXto4oNZSARDyU9Px4xFFobEqsfK72W
	 28QN0KnVJXz/OOZx9MPCyKRXGD3kwhPidRP8jt6VbwionE9OcTVUpVoHHenf84ksXg
	 pnnXtr5H1WLMg0nFL2eDwo3S9OEF5gRwbasZ0zKYDHyZFDHseU+YIjVCT3om+YfLnm
	 ++tKFnhIEMmXEb5Qf9qICUMl/sS1YSWSGHKybYn28+Px8nQ4JBeECEOJYwsTac28pi
	 YHDvxK+AgjWEA==
From: Sasha Levin <sashal@kernel.org>
To: fabio.cesari@gmail.com,
	joshua.crofts1@gmail.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: light: isl29028: fix runtime PM reference leak on error paths" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:52 -0500
Message-ID: <20261107054152-failed-6.1-0e30d15b1564@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0e30d15b15647df786e60022650613e16dd70645
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054152-failed-6.1-0e30d15b1564@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




