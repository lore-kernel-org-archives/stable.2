Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959201EEA31
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783991794; cv=none; b=iSzQMlMy8+3XkF1QvJ99yBPWeUDv56MLbmQ7/MMX80I9KF2DZsEI677yQ6+v6W/ShYgpLLbYlK/nhIK12sLHg5xwGsyIbSsQlzswfsjN/KJiOxI6uodvtuXf08sU5GyOyogKmKiwZV071CKeq8Q5EklA5c9+Eq3QNiVBiJu05/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783991794; c=relaxed/simple;
	bh=y9Tx4O4Kh7/Qy6StTSTQcuqiwyc11VYYBjAz6Es0UOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAzA8ZChRSLMiliVg2aRFmB+CJMiujOdlZ65wzpUWsacrwKJ86VsE50nENcjo+s9f3f+T/Z3anoGd9Yu7Sx0AUhE66oFbJhUMeR0DIkYy5QZswuOYJH7b3CYYGNOjj4y7XwuE3dDf9LrA1YgvAwnGFgYtGDLi8UtjeGoKa87q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqsgD0cc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqsgD0cc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14061F00A3D;
	Tue, 14 Jul 2026 01:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783991793;
	bh=SbryL8lRD5vxlaZlIgmZu6POLaVLtYTK41V1nV9Zq3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TqsgD0ccbhCTzCYeyZ5GwlBkHoOQy4TTLVAZconK542Wh02GpXfD3z2HQC/nqgOfz
	 A2ZY/Aj5ykdQ49aBnMN6SZwVGuLeFpC+n5rYMoz/QCCiIvZ4mOHJBBVvoWiInYweeM
	 npFOGR5Ny6R5n1nije8FbvvxVGgDT4Me+tia/BgDfOPze9DDagWfrKHadWLTkKITcH
	 KKM8n1OvocDcU+74Rt7GlXCI+laIT0ocqYGQp1RsD0rH9MybIEVocl1uKtW4Z7K8L2
	 fVFFh7N6ueFMlyQgroXOSiowZk/n6ibOsp72dMCaWecnRDfGZhKz0ABvu1oTXFBqfw
	 Of/xST8ZFDVTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/8] iio: invensense: remove redundant initialization of variable period
Date: Mon, 13 Jul 2026 21:16:24 -0400
Message-ID: <20260714011627.2188779-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714011627.2188779-1-sashal@kernel.org>
References: <2026071317-refill-huntress-d0e2@gregkh>
 <20260714011627.2188779-1-sashal@kernel.org>
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

