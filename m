Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146E356772
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975188; cv=none; b=jl5oy/OF5LYw+2vHDlyqz9ifeIWTA0KIwy0ygy+5QIwz+GZpoWO8E12kNRUryXHG9XL2VZqEtY1ldLJ7CURCpUbPilGfIy7DAuzP3JPVOpQCz612c6gmr/ZUR36K+d8xz4BDLA0BEzGhGoivWZs3q4y0zBDASNCyQgQrBSjF7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975188; c=relaxed/simple;
	bh=y9Tx4O4Kh7/Qy6StTSTQcuqiwyc11VYYBjAz6Es0UOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISXRJwM88+vnO9UGLi51WUjv7FDM7bL7fjLzJKdYid+8FlCKA3xDtDy1e/kLhOgyv8hhUpXeSRSRMjb3btsfyc+EY+267LUs4URLAyNMDFplmqAo/0t7hhJLNp4QjXd/C1eNh2ZtJGFpT01T5fTjvtjOtxYbECW7l3po6bm4pmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1adx/O+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1adx/O+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1062D1F00A3A;
	Mon, 13 Jul 2026 20:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975187;
	bh=SbryL8lRD5vxlaZlIgmZu6POLaVLtYTK41V1nV9Zq3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1adx/O+/hHHn1e+wgrXxL/veH+1YvHl9in/y42Ovc0JH3L+4T3tjkH0r9fy+vCSK
	 ZBAmGmdenDfU0QYfQDF6GCa8FXO7IXrSw5+EQT2ads8e5qOIKRwEAag+39vcujWFRA
	 LlB2VirLK61sFXIdZZ2pixyxh4J8jjJKvOTPoV6PNR8G5skHfgl3aEj84giAwXN4rt
	 wHkWnjm88qy2oW2HkD1Z4hXVupXTdYErtINruXI8fFViY6GCEi5juACqVSxFjuI4Pq
	 FLKI/kutfJDdjfjRZiNwSZaFh68Pm5v4ZM6X1WVjVDPgKrThHEHS3h1zL5SPrdD72B
	 IlSqSSOH2AMFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/8] iio: invensense: remove redundant initialization of variable period
Date: Mon, 13 Jul 2026 16:39:39 -0400
Message-ID: <20260713203942.2144352-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713203942.2144352-1-sashal@kernel.org>
References: <2026071317-shortwave-thrift-0c90@gregkh>
 <20260713203942.2144352-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit b58b13f156c00c2457035b7071eaaac105fe6836 ]

The variable period is being initialized with a value that is never
read, it is being re-assigned a new value later on before it is read.
The initialization is redundant and can be removed.

Cleans up clang scan build warning:
Value stored to 'period' during its initialization is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://lore.kernel.org/r/20240106153202.54861-1-colin.i.king@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: affe3f077d7a ("iio: imu: inv_icm42600: fix timestamping by limiting FIFO reading")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
index 033d3788dcf73b..77ab578ee1698d 100644
--- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
+++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
@@ -105,7 +105,7 @@ void inv_sensors_timestamp_interrupt(struct inv_sensors_timestamp *ts,
 	struct inv_sensors_timestamp_interval *it;
 	int64_t delta, interval;
 	const uint32_t fifo_mult = fifo_period / ts->chip.clock_period;
-	uint32_t period = ts->period;
+	uint32_t period;
 	int32_t m;
 	bool valid = false;
 
-- 
2.53.0

