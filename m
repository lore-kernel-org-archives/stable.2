Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CA35676A
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971432; cv=none; b=LwyeDNiOfeuODe28bHu3kHuI+0xWjkkbyE/YVUTJBZgxpFDk/y7M7uGO1r9qnTk088tYTwk/Jk3rcAUbMXVq6TQifvbvXtIC3AtZ33a6j/aO3MISaTmj/EuBLkAyvYv5A8A1cNyM6nZe0w7/52ZiWxqTjgSfGvtvD9KWcn4w2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971432; c=relaxed/simple;
	bh=8ZajXJaLsj3U7aSMJ8PzX4Ml/FbnffFDQ+omnmoE8Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrSYxdjZdYwBo9cCmOElgqsQY7hnKmlh2SObpRflB14YBuyCUShiQN9sRo5jAdxRXQ+BomR/R3mMg4qWOZYIninRgPPH8HWyLf7vCiCk2EWx/y19lUku7Z0sQAKBlOGtDDvyKGZayKy+DClcTZBn/CDCtssh2M+0TZt58FimLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W48XrTpE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W48XrTpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380881F00A3E;
	Mon, 13 Jul 2026 19:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971430;
	bh=QCE72gH/mt07Y6rVbdgTmgaSmYp1LHcxIxbCe/gBiVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W48XrTpEcQDLaCVd9X+shewmVVIf2zem7q274IUNTN/CDe/rg81ohsDmzo71q0ONv
	 6QH8HGGuhIF/xOB51bHgb7HWsUfYrLyp0PQOa7ZYnqYCUo8Ne1kEPd/cLYz7jsBgSN
	 gSNaTIO3bjiGiSR+UTlbI5Ga8koYouFRWMxO4RXnByUyvKXJWJQE/fxHO21ZBt6Tch
	 yRBWVs8U93FI5+xeTPzQr4+SwxLv0MzVl2ozWSLh7eeV4t5XFBPA6DR7RkYx6JxkuF
	 02TkWnFibZGUNpnWcrNP5Lr551TXVVh7zKrLQ6OmROi6CzIhnpujQFscgmSmaBmfjQ
	 u2T7ypqdtdY0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] iio: pressure: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 13 Jul 2026 15:37:07 -0400
Message-ID: <20260713193708.2054715-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071315-trespass-legible-97d4@gregkh>
References: <2026071315-trespass-legible-97d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit dfb68a8ebb2e8d9af6e356ae0806bfd8e854ab44 ]

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Link: https://patch.msgid.link/20250825135401.1765847-11-sakari.ailus@linux.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: fbe67ff37a6f ("iio: pressure: mpl115: fix runtime PM leak on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/bmp280-core.c | 5 -----
 drivers/iio/pressure/icp10100.c    | 1 -
 drivers/iio/pressure/mpl115.c      | 2 --
 drivers/iio/pressure/zpa2326.c     | 2 --
 4 files changed, 10 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 9e46aa65acef77..088b13ac2d9d1b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -747,7 +747,6 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 
 	pm_runtime_get_sync(data->dev);
 	ret = bmp280_read_raw_impl(indio_dev, chan, val, val2, mask);
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
 	return ret;
@@ -922,7 +921,6 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 
 	pm_runtime_get_sync(data->dev);
 	ret = bmp280_write_raw_impl(indio_dev, chan, val, val2, mask);
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
 	return ret;
@@ -1951,7 +1949,6 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 
 	pm_runtime_get_sync(data->dev);
 	ret = bmp580_nvmem_read_impl(priv, offset, val, bytes);
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
 	return ret;
@@ -2026,7 +2023,6 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 
 	pm_runtime_get_sync(data->dev);
 	ret = bmp580_nvmem_write_impl(priv, offset, val, bytes);
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
 	return ret;
@@ -2634,7 +2630,6 @@ static int bmp280_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
 
-	pm_runtime_mark_last_busy(data->dev);
 	pm_runtime_put_autosuspend(data->dev);
 
 	return 0;
diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
index 3e0bf5d31ad7a4..ff6b36b5927c1f 100644
--- a/drivers/iio/pressure/icp10100.c
+++ b/drivers/iio/pressure/icp10100.c
@@ -265,7 +265,6 @@ static int icp10100_get_measures(struct icp10100_state *st,
 			(be16_to_cpu(measures[1]) >> 8);
 	*temperature = be16_to_cpu(measures[2]);
 
-	pm_runtime_mark_last_busy(&st->client->dev);
 error_measure:
 	pm_runtime_put_autosuspend(&st->client->dev);
 	return ret;
diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 02ea38c8a3e431..18c2488e182cdc 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -108,7 +108,6 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 		ret = mpl115_comp_pressure(data, val, val2);
 		if (ret < 0)
 			return ret;
-		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
 
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -118,7 +117,6 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 		ret = mpl115_read_temp(data);
 		if (ret < 0)
 			return ret;
-		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
 		*val = ret >> 6;
 
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 8fae58db1d6393..4146396755b64f 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -699,7 +699,6 @@ static void zpa2326_suspend(struct iio_dev *indio_dev)
 
 	zpa2326_sleep(indio_dev);
 
-	pm_runtime_mark_last_busy(parent);
 	pm_runtime_put_autosuspend(parent);
 }
 
@@ -710,7 +709,6 @@ static void zpa2326_init_runtime(struct device *parent)
 	pm_runtime_enable(parent);
 	pm_runtime_set_autosuspend_delay(parent, 1000);
 	pm_runtime_use_autosuspend(parent);
-	pm_runtime_mark_last_busy(parent);
 	pm_runtime_put_autosuspend(parent);
 }
 
-- 
2.53.0

