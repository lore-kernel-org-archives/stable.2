Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313377;
	b=V49aE/QQxaEAKwTVIgFz1Z5FAf8B131yEnKPOVBE60sZr5DCXwQnWXgx2WyuT4XzWlFU
	 NxJQhpZ+mNrd4bCL3be+YEQA088PbQMszMgWc0n2cQ//ut9kgUvyT7aHfHxNP5TB+X8fC
	 9YcprCXcde8HzJSBCmwwjvxCNOLWRWJmnUUQWgmcHppQbmZApe8Tkb24IWZJMGbfgJGbj
	 bxhE0ndlCurfN/WA5baR46QOPgb9J3aweV1UyODJ3Kb78iVXXyrGFb/TzWHi6+89pFSFh
	 HtnBJbaGGODtYei6yolWir/C+dfObIG6D6MABzXsTsuapRWKhjDbBDr/ajQwkyeh+PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313377;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xvoZ8fElsiKwvkFKnhFjm1+p5ICD3n0EeMSajqR6phQ=;
	b=UyYC8r5QFxaF+rPwAltw4SCskcNTfIsdC4IDxbgGWVXYRAd17XH6hiNCCxve6gtgVCg1
	 V/rP1TQlK901Snw11BVowTEo7ujqWnTGLESlDRsEOSc++VPFD/KRDA0kD2/kioiiUNHJV
	 0jKmVlo99Xa87GIfgreXZ83jcum5KyHrlng8hXiE/fcvbyOcycBY+CE/wyW/bX253v2xt
	 53GOG6azY/1rLUXwqk3Yn00mLs2qQD3JTEhgNI9YfnDKuBY+Tdct0kGAf/6qBfVq9b+3D
	 +vzMLrozM2v4iGYc/2SrXZOdb3D3sCuhQcfH5gKVCKWxUFgFXuJi+aFp3gRRApeG5FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKIufm8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A0606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKIufm8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589CC1F0089F;
	Tue, 10 Nov 2026 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313377;
	bh=xvoZ8fElsiKwvkFKnhFjm1+p5ICD3n0EeMSajqR6phQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EKIufm8sZHeFkBZCLbjC6wH8Nh5w/cr9Mzj+BWoWdtLNKgmt8NUgPq2/l/1OV3KSy
	 np5TnGn0ZPWIC8ijJQZzJF+uHb0kBq8WR2L20x9dqvqQBUVESzCdYdHRIO6xV90LqF
	 afmMN7/yOb2xxFhWZkL9R7Ciu/jZYEi8LoG6whIlqfZn9hb9glKizjk5hhrmklsLys
	 IYNc6VOM5rnB7nzAA0Rio87c2oB1Lmrw8B8VHgNhkAJ5mIU9E9vYATkppiZVofwmZv
	 yq7gpzfLAMFHS8ajbMiklgJ8OupOLoqqLHQ0HKQCuY7z9XfxuoMoeee01Acx79E90A
	 Zjk+rslLzJsuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] iio: adc: ad7192: Revert "properly check spi_get_device_match_data()"
Date: Tue, 10 Nov 2026 07:22:54 -0500
Message-ID: <20261110122248.1149789-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053031-failed-6.6-7f7a119a370e@kernel.org>
References: <20261107053031-failed-6.6-7f7a119a370e@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 0309e66abea141f3ec339b064b8f8b8003d2a634 ]

This reverts commit b7f99fa1b64af2f696b13cec581cb4cd7d3982b8.

The added code is currently a dead code. Moreover, the driver is not
designed to have any defaults effectively making driver data a mandatory
information to work with. Taking all together, revert unneeded change.

Discussion at #1 concluded in agreeing a new policy on this for IIO.

Link: https://lore.kernel.org/linux-iio/20260217080514.1288115-1-andriy.shevchenko@linux.intel.com/ #1
Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 7f7a119a370e ("iio: adc: ad7192: reject devices without match data")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7192.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index fa6810aa6a4a7..ecaf87af539b0 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1039,9 +1039,6 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret / 1000;
 
 	st->chip_info = spi_get_device_match_data(spi);
-	if (!st->chip_info)
-		return -ENODEV;
-
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-- 
2.53.0

