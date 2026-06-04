Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985AD1E766F
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588162; cv=none; b=bsYyVxiS9xTkabeA8rd2lEOEA5l6MnI7oMWgVgYuEMYwG4g4pV5Ws6jjs7cm2xwSnC56w451nUpXxtcM1pztjwynM+lkxy1iKJT4ACSjOUQo4Hz9aY0EJNGJlSG4rRifCaGqC0Z3XiosN6S8AuBe48PPAGFCMcDrLfE8ERV1kyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588162; c=relaxed/simple;
	bh=8u6m/9eLWN8gXRSPguUzJdw0TSU8sGSSJpIDtMAFtJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2M5X8CWUPmKn3kceiraHJFKySpAwSPi6NND8yS6b2vpXtCMbG8bNvQFwiA3LxVxJXQ1JvIXgfHYJ5V1lAczFA9pt7bOUkAuIxE+24oR2pQaJfHtjgqzEgrtt80G7bhwkDOJ3saanAR854t+oxWus9KsRjo4jM5IypGvvmw4e98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVCAmAaW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVCAmAaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65E71F00893;
	Thu,  4 Jun 2026 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588161;
	bh=t7lTW4ZMdX08vbaEe+j2c59+aWdl82ZP05AaI4aE0eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OVCAmAaW0sWXTiCBTALpZ4eaTXuoIONuhsNq5E8bJsWz23aVlth9maGn3nQ+Pgkqg
	 pGiFzvJrPP6IJG2gEJZ7PIZyyhZj8VqSRFjThvYJpQJm/S2GKhZOCMJLutkRSktf6+
	 JNnA8F/d4ICYIOWjaNWuDBzzR7O3FbtuzsKKdaiL/KDDTbzvw4DGTYuI1lKt7lNSk3
	 1aNvSfx6Vxj1yIMGADVRHMENfrpU8Tdu2pU79L/CqrSWtv1O6QQ2OjkeV1xzXPqr2y
	 1OmOyFv2nSxb6KV/mOus88RmUY2Ng8XfTIZ1WFMnvoThzav6rHzSYjx5a6XMDJFmSW
	 zv5W1iJ8RFzOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: dac: ad5686: acquire lock when doing powerdown control
Date: Thu,  4 Jun 2026 11:49:19 -0400
Message-ID: <20260604154919.3732423-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060429-struggle-judiciary-4ace@gregkh>
References: <2026060429-struggle-judiciary-4ace@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

[ Upstream commit 5237c3175cae5ab05f18878cec3301a04403859e ]

Protect access of pwr_down_mode and pwr_down_mask fields with existing
mutex lock. Each channel exposes their own attributes for controlling
powerdown modes and powerdown state. This fixes potential race conditions
as those the write functions perform non-atomic read-modify-write
operations to those pwr_down_* fields. This issue exists since the ad5686
driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad5686.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 3f10bb872c7924..ca7c67f5146249 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -30,6 +30,8 @@ static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
 }
 
@@ -39,6 +41,8 @@ static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
 	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
 
@@ -57,7 +61,9 @@ static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", !!(st->pwr_down_mask &
+	guard(mutex)(&st->lock);
+
+	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
 				       (0x3 << (chan->channel * 2))));
 }
 
@@ -77,6 +83,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&st->lock);
+
 	if (readin)
 		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
 	else
-- 
2.53.0

