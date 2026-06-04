Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D442E1C4E
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600680; cv=none; b=uEAEG1HEYnU4cmJnNcOuGd+A8hEdUVJ8T9KVCtrhVMb5ct6fSkTtciEkewE0UhtU8V1rqM13LsLSUQcD2KPLxuw53bWrf3iki3l4+gn7A+uYAGQYacz/YTXi8raFsDXiO6x5h9a+xU+zBIrX2KQ9knB9CdHbeR3T4p+N3LC1OV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600680; c=relaxed/simple;
	bh=8+ODXaYGes1crVWUsFFjQ4w5kCdSO7aBuqCewiInp9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTBSm9ZRkwPsiTerel2doz55Beq0n5JDBV7D+0z4ZUV+jnXxJHzgz2s5lZL9FksDAW+UkYQrNgHw02DsbeuPEJYDg3tPMrfFqW2IBbblnk36TrWW7LX2wW8gvkfZ61qCBdzy4FomedPUrGIfhMG7L9MfbJnAQ3rwg2edI1v7+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU1LqvQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU1LqvQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5701F00893;
	Thu,  4 Jun 2026 19:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600679;
	bh=G+GgSsVCssvM2JphOmGvihicKpSu8PI4BjzlvLN81Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BU1LqvQ7DOgJnGFf9s24o/1X7eo1g7CdGjLs0rvRLVpWU+UQoLQ3mvy0tWmnkA3L5
	 w/BZxY0nSRfz402mN0KOVMOuQV+3irL/TAB466MAuvv5e+SHeJIEetyiEiJzJy4pU9
	 EknpWdOPhz+qrd2lm8/9SvdFIbFWNU6gJv5U2USGnZ7Skde76qXiRvydHs6TMN3fBc
	 GTPK8hmlpUb+nZDvIXj1lR+2pPp4RQTw00qFfYfSFESr0Uoe/IMOWq5Lky4LiN5KjO
	 eKn2EA9SdNxFm94Kjy2AtQQzN+16fy8Tp0pJ1pfbuMWTGXQqfTRfe/V9o7Y5bTJnVh
	 DTSxv7wBU6fkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] iio: chemical: scd30: Use guard(mutex) to allow early returns
Date: Thu,  4 Jun 2026 15:17:49 -0400
Message-ID: <20260604191751.743012-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060456-grimacing-crop-73d8@gregkh>
References: <2026060456-grimacing-crop-73d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 5feb5532870fbced5d6f450b8061a33f461b88ca ]

Auto cleanup based release of the lock allows for simpler code flow in a
few functions with large multiplexing style switch statements and no
common operations following the switch.

Suggested-by: David Lechner <dlechner@baylibre.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250209180624.701140-3-jic23@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 5aba4f94b225 ("iio: chemical: scd30: fix division by zero in write_raw")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/chemical/scd30_core.c | 63 ++++++++++++++-----------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 682fca39d14d63..180c29bf99cf36 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
  */
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -198,112 +199,104 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 			  int *val, int *val2, long mask)
 {
 	struct scd30_state *state = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 	u16 tmp;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 	case IIO_CHAN_INFO_PROCESSED:
 		if (chan->output) {
 			*val = state->pressure_comp;
-			ret = IIO_VAL_INT;
-			break;
+			return IIO_VAL_INT;
 		}
 
 		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
-			break;
+			return ret;
 
 		ret = scd30_read(state);
 		if (ret) {
 			iio_device_release_direct_mode(indio_dev);
-			break;
+			return ret;
 		}
 
 		*val = state->meas[chan->address];
 		iio_device_release_direct_mode(indio_dev);
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = 1;
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = scd30_command_read(state, CMD_MEAS_INTERVAL, &tmp);
 		if (ret)
-			break;
+			return ret;
 
 		*val = 0;
 		*val2 = 1000000000 / tmp;
-		ret = IIO_VAL_INT_PLUS_NANO;
-		break;
+		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = scd30_command_read(state, CMD_TEMP_OFFSET, &tmp);
 		if (ret)
-			break;
+			return ret;
 
 		*val = tmp;
-		ret = IIO_VAL_INT;
-		break;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
 	}
-	mutex_unlock(&state->lock);
-
-	return ret;
 }
 
 static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
 			   int val, int val2, long mask)
 {
 	struct scd30_state *state = iio_priv(indio_dev);
-	int ret = -EINVAL;
+	int ret;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val)
-			break;
+			return -EINVAL;
 
 		val = 1000000000 / val2;
 		if (val < SCD30_MEAS_INTERVAL_MIN_S || val > SCD30_MEAS_INTERVAL_MAX_S)
-			break;
+			return -EINVAL;
 
 		ret = scd30_command_write(state, CMD_MEAS_INTERVAL, val);
 		if (ret)
-			break;
+			return ret;
 
 		state->meas_interval = val;
-		break;
+		return 0;
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_PRESSURE:
 			if (val < SCD30_PRESSURE_COMP_MIN_MBAR ||
 			    val > SCD30_PRESSURE_COMP_MAX_MBAR)
-				break;
+				return -EINVAL;
 
 			ret = scd30_command_write(state, CMD_START_MEAS, val);
 			if (ret)
-				break;
+				return ret;
 
 			state->pressure_comp = val;
-			break;
+			return 0;
 		default:
-			break;
+			return -EINVAL;
 		}
-		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		if (val < 0 || val > SCD30_TEMP_OFFSET_MAX)
-			break;
+			return -EINVAL;
 		/*
 		 * Manufacturer does not explicitly specify min/max sensible
 		 * values hence check is omitted for simplicity.
 		 */
-		ret = scd30_command_write(state, CMD_TEMP_OFFSET / 10, val);
+		return scd30_command_write(state, CMD_TEMP_OFFSET / 10, val);
+	default:
+		return -EINVAL;
 	}
-	mutex_unlock(&state->lock);
-
-	return ret;
 }
 
 static int scd30_write_raw_get_fmt(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
-- 
2.53.0

