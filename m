Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312161;
	b=pWCTWy2vHZ8IYKeIl/hY+pKfOPBK9Lg6LTh1Vc/2ft/4iHavxA8D9lCBHf4EXG2TCcGW
	 RXaVocF4eucXqPGbn5CGt1jmiZVaCfRd2YZuUKe1nVGbkX1lPYf8S7kQauIt9qCwKVpuX
	 /5i/fva1LWxzIcABLJdVShz5Fyg7BLA8tSice85SZHUg2TsSohRT1muKAncnAOMqoqE9+
	 CY56zMcf4aKCfzt/wUqmJotrHIKAWQ8ewAVswdYr3DH9aQDrQTtOWlwhA5hDxzYhqIWss
	 kL3V/CIydv/sBz+4y2Mhe3FD3u3gY4C8CaeIc7KIy4g4eOp0oJ98JLUIt5U+6ztGp2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312161;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kwS7W83YqiSqb/Dxsud1EXkLvzP0BBlNJfdUOT31lgk=;
	b=d0pcTzcE18k7r+fCF5Q7eqxqvvFuAUXu+d0c9xdm2danvq5JepXc+HzSjgnHAm2Ql37w
	 ALfI/HXR7DN3oSD+LxnC7H78/+O3LcW66PDhVajgwoy+iPpQzkO26ERTtrbmtWzGK8Fn2
	 /m7/4c0jplUjC+SWFs3Hvxdqn/jETnLy2Qx1BO2GoEmYRDsv8aEmT11Kji9VTcnmg8bXr
	 SZv3dvNTXitlmOCz7DP6qW5BH4FQPTlLOTP3fWBccmWf9s5JMAdhm6wJnKrf3e1Au3Z9S
	 2wgIDszW1VEr3DfROfoG/S4ekc1WK99ekIhxfUQ/gTQ+NYl1gIJ/7IZA+OCxLtAQ/8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv4H3fc9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E547606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv4H3fc9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1011F0089F;
	Tue, 10 Nov 2026 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312161;
	bh=kwS7W83YqiSqb/Dxsud1EXkLvzP0BBlNJfdUOT31lgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zv4H3fc9C48tspDmzmCQTLdJyOzmfFdn94/6JvyhT6tQgWT2DJ8sApF6CYp7VeTVy
	 EBXN1BW10pd8bGRlVIGGI0ntEIktABRZBaQUdexnnI+RFpucx80XzQM3L02xgDAklV
	 vv9aj/4MJpApWgW0C/QfhP1Fh1okg7llrBzTdLV3q4olnWnbg7GBg22ATqZ0Sgt+h0
	 eeyeaPo6kQkl346Tq3+xcmWwQhwdP6KdkYxYGyygUblERi6gEVwK6/OSmDPjfjGXrL
	 fB5WneYLhp8SUPoOjlt4QFz2T6lhpGvodQWK5/i5I+/6Pv4FqdA+j9O2CIoxgfmxgD
	 9YLi424Dj6qaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Cesari <fabio.cesari@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Tue, 10 Nov 2026 07:02:39 -0500
Message-ID: <20261110120222.953482-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054152-failed-6.1-0e30d15b1564@kernel.org>
References: <20261107054152-failed-6.1-0e30d15b1564@kernel.org>
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
[ sashal: adapted scoped runtime PM guards to explicit isl29028_set_pm_runtime_busy() cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/isl29028.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index ce82ecff59d76..190ad36f74ad9 100644
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

