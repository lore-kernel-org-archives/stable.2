Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3961F09AD
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359192; cv=none; b=M6ABamLSsmlQ9gm7NtfL/ZMD1ieqcZOc72VSfsW9cPjj8df0wqx68c6Pmzb3J2YFxkc6lQ8pQx2Fekv/4fIsuL5cFIrecYWWDPjXmE2h9CA2wj6igd5XtTAnSjqdd6Q9btWN+Tsf2aNePyj6xCb7EG4pEDkP8IykxD3/K6+8N1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359192; c=relaxed/simple;
	bh=qPSsm/ypXd4m8X4vGxVJSRYFWKtBNcsAOeJPt2P4MyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=by8Xo5G5RWWjH1Q47Iww+l9kVuQNNjuFysdZqXEKvKJ5YyyBEzYEwR1BNYyZMvhgQsqrOsSntrqZOgrmEzlrmAEzf/xbjZim356/eiG9Jeo2OCmhPU48Vh5J3oSwzOCe3X+nzAsO5wNTO84kqgL31tmdgmMYnEz2YDsToEPHsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC9eJVQX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC9eJVQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F3C1F0089B;
	Wed,  7 Oct 2026 07:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791359190;
	bh=drgWJxIFU6jVjy+EcxN9kandeNGcy1T0AsUWtnjQJfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PC9eJVQXiKcS/yzHQABGeXdtL5mII+NeZlMstrIY1AdIvgCwinN4EDlPb283vch/w
	 y+JhrlpjNijy3mT4h7H7gLUKopYVRF83N+qX9RpkYvYh4YAC8ucTWkiITtDP09W792
	 kd6Ks6nFvrqFmSLYHsYyFd0RVsVnKQJ5ZXwyHpO3dRLe1TqBpEz63NFE8xs/Vdd6P0
	 YP7Ml5jjK7DkorbfCktNKj1zdMHTBjjmDLRJY9yrDliqZbPmwHeoaGULJJy7OhcAvO
	 PTVbw8wW7MAiDaHIEqLYjBrSoDMdJu/GFSUPzw3nXI/72BPEbcLdTkRdCD6xi7iTK6
	 f4LdYTuGzsCdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cong Nguyen <congnt264@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: adc: max1363: sign-extend bipolar differential channel reads
Date: Wed,  7 Oct 2026 03:46:27 -0400
Message-ID: <20261007073730.1743032-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100625-acuteness-caloric-811f@gregkh>
References: <2026100625-acuteness-caloric-811f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Nguyen <congnt264@gmail.com>

[ Upstream commit 91908c0a78baddc8572aa3ab69e62ee2eb496ba4 ]

MAX1363 differential channels are bipolar, but max1363_read_single_chan()
masks the raw value to the ADC resolution without sign-extending it.
Negative differential readings are therefore reported to userspace as
large positive values (e.g. -1 as 4095 on a 12-bit part).

Sign-extend the masked value from the resolution bit for differential
channels. Single-ended channels are unipolar and are left unchanged.

Fixes: d1325cf45077 ("Staging: IIO: max1363 ADC driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/max1363.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 875f5ff202082..bbb2336006a98 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -408,6 +408,14 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 		}
 		data = rxbuf[0];
 	}
+
+	/*
+	 * Differential channels are bipolar and the device returns the sample
+	 * in two's complement, so sign-extend it from the resolution bit.
+	 */
+	if (chan->differential)
+		data = sign_extend32(data, st->chip_info->bits - 1);
+
 	*val = data;
 
 error_ret:
-- 
2.53.0

