Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996EF353A88
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971198; cv=none; b=NhTZcNZIk5Eq3CkN1Jl8k1I+t+e1lrQ5+2FLjdGgd7Q6qR7ziWFkBA7YV+ALKohjX5WUekruT79E5FtJPK95ewyO7hUt13f+0iDd/TIStAqGQ7Qf8YjH95rs95d6ZkRlQLXyO10ICYMOuzuyIMHX30yAQeNlojyKqqlvHxaqPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971198; c=relaxed/simple;
	bh=8ZajXJaLsj3U7aSMJ8PzX4Ml/FbnffFDQ+omnmoE8Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyXObRNi1Vz0Iju1t1nPCTr08Gj6Z+8o4OZGrsr1bzaf+ClqKWrGSRMIV2ZdW73exhJK3uK8287fO/vJnm1DFBcv1O1MVzT7+v8lcffIBHKdyTqRidkeSRSocJBkx9B+gktNmAvFFqCMAIM3sDcFeJm/q42+kD9McnMZ/f3DAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUgsILxD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUgsILxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF161F000E9;
	Mon, 13 Jul 2026 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971197;
	bh=QCE72gH/mt07Y6rVbdgTmgaSmYp1LHcxIxbCe/gBiVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TUgsILxDdyOdfVVRvKOeBNT6jWaNXXwOQNoedD2DiJkXH5vCqD/5k4ChlxE8nXacx
	 mANWfXsA8WwhFWBsckbtUNk6aQNP5FaEEJJrYexglUnVyLCwFSYcix49+O7fNfW4Fn
	 YHNB5y91umQVHS1nufaJ+NdvNTwdagZ8sYmZBndSZSraenTpNbtFkqxBh2H55JaZqm
	 vf/6UVnzgxS+1E982BwiBwrRuD1cukdpZ8a1kJON06JZGl64v2OS+IlXi0Oiov5Lgf
	 /c7H0zO0KOtVy62AbO4lIoMgWswqWGmbtZAeuYYRs3vlxi+i7adDJwBSzd7cwhk8eK
	 PNE/7go/8kNwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] iio: pressure: Remove redundant pm_runtime_mark_last_busy() calls
Date: Mon, 13 Jul 2026 15:33:14 -0400
Message-ID: <20260713193315.2035880-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071351-alphabet-sleep-d297@gregkh>
References: <2026071351-alphabet-sleep-d297@gregkh>
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

