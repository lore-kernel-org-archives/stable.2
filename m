Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312632;
	b=l2U6n6O6HBALwMkJ0kQf2pbPLjPrRKQfMkRLLuShBU5PwW/EJ4IQKuoYuS+fBL+jF6lp
	 4Y1iJr2FWzP/aBTBfcqphMWQtwSVyUkEQw939VxOaYcWTNpgErIpjY2XCYPB1l/cb+KuP
	 ojDlgIsjXC2h+yJJ8yaGULQq1ves4RGHM9HV3QZmW8k8a3vOFubznMUjqlGED37D/t4Zg
	 GcDbLY/yTUZ4INz3Xz4yHZIpcEQA2pF86nIj+uQe1L0jlgl2GMwYMcW9YUds/nPTI+23a
	 8BMF1kWca/uVKh+QS8eBAWTl3MPim4H3O3Pt6ZilSUT2uJtmYiahv3FvkdL+LCEiUNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312632;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YlRrfyuE+6f7gdC28HC5UAKJt2tWPNlcyG1lgSoZDZA=;
	b=axsR+yhjv0KSBdvWCs21U/gu98FXpcLA+C55EN2w9hUa+CjBGTvpPt9X/dWUNd2iYafm
	 4YP7CLTz6wYahn1yh9Ui/CidUs87LbQ+7MkFth8CTe+a7dQ7FSvlzHKwtc5KAIJIrD/4f
	 iWWPjxuIgJbAG2Dvq12Fti2bdNl4ZN2O4WIyyPzxALElzsbbU4YZK1KCwkQEMvHrmqhp5
	 KBYDcPNE7driuzIto5NuGI6Zl9H+DQMDriMwZw+nz4w+tPUNJ8vDZsfPOdLyJbj8Gzoys
	 9SvQ4+j4fGaKRvvPlealypncmjSZNbstPs54/RXKet84VExYpQ4lira9jlySLFd7WMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlcZXoyr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F6F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WlcZXoyr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580F11F0089F;
	Tue, 10 Nov 2026 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312632;
	bh=YlRrfyuE+6f7gdC28HC5UAKJt2tWPNlcyG1lgSoZDZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WlcZXoyrYZkKxeuiDKC5rN1gyxj8XBoEXcH2vZkK3zJW1b+o0e6D32te2+ODn88KB
	 BNkfNaf6aOMnrw2Ou8KIhHnJ6UkVdn/95vqZoPsXNWZ9MmwI4qP0ZlKuxRxk9C4Xh2
	 b1nzb4sVaBc7Iy4z6WLsB3zR/V4Sk0ussqnKCboztKoYlTQriQHOInJOsaW+481K42
	 0jdh1OZsWMM/ZtJiQ5GQwKp7QVrTCu+fQT9bK4C5fCTnCBGkkmDE8S2Rq3qJWAQMxE
	 JlDGnhWIXi3+sjbC9q+UT0KF8JrE8PhwO9msWyhQqdaWv+ngG71J/gvWXTDN/ZJ65c
	 n0zH3ms8WfM2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] iio: adc: ad7192: Revert "properly check spi_get_device_match_data()"
Date: Tue, 10 Nov 2026 07:10:28 -0500
Message-ID: <20261110121017.969666-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050733-failed-6.18-7f7a119a370e@kernel.org>
References: <20261107050733-failed-6.18-7f7a119a370e@kernel.org>
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
index 530e1d307860e..8b1664f6b102c 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1402,9 +1402,6 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
-	if (!st->chip_info)
-		return -ENODEV;
-
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.53.0

