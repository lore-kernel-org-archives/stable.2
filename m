Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B213DBA0
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966411; cv=none; b=fCbRKTmq9ceYJRxcSE0onIxiou7rZQc3GBTz320fxX9ZOlo6pr2CPPFDm3hS/+ZCYSyaY/etdBtVMvA5xaLjSnZ/P4xwBxenY+kpQi2SEXPCcvWmCemWR0jfpodx6aoshXFU8iusIw/t2TIer6eI7P/CEjGiXoLYFUHzjOacX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966411; c=relaxed/simple;
	bh=s6yg6Id2DxDNmXho1lrHc6YBmSddikKGx3ZIN6EyEXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ps30fHvcD6Lzqe3JyMOkrUVnrTEHc9ApuJcZKFAjeNfxn4Dm/AEe83/6ptVDRQn7VNOzEwM9Aky5bzZs0PkJxbrgyD27M2YKDvIfPmoxU9XrvLdxsph8EV9j9aQ6mbwl651XfxXv0uJeq0a713Y/lf4sZNEMLq70VAFubv32yp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR83AyLz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR83AyLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E3C1F00A3A;
	Mon, 13 Jul 2026 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966410;
	bh=k8mmaq32H5+jT7Dp8ApIMkini6h8tUrLJqNznUhmrGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FR83AyLzwZwR4GNOB8JfE/1Cm879LbBmqGfNbolviv7c14lGEvlvFpxyBsGc4Xq04
	 q/yfDbv40igLOv5R9VG3DMM4her4BHpa9j2PF053WN0O0CKgiYCtPZQmnanbYRCURn
	 iDo9se2pQIDp8CK9IEbekghd1L2y+L9WL0p9dSfQPtV54OveEZtWO2jwd9K+a3Ux1W
	 pttzjLKvxL8KitX9AFyxtsrvPvjUYSkfD2t6xxy8b9cKDe+yjvueA2XJkOhwtBZ311
	 N8tj/wtbey88Rq9i1pBKABYLCt3kM+sNIDsf6NcaIA0mMD3jf1toRoHmWKDAwrZR/5
	 Zb5NDW9QE1Ejw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samuel Moelius <samuel.moelius@trailofbits.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: adc: ad7380: select REGMAP
Date: Mon, 13 Jul 2026 14:13:28 -0400
Message-ID: <20260713181328.1932706-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071354-cannabis-broadness-e866@gregkh>
References: <2026071354-cannabis-broadness-e866@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Samuel Moelius <samuel.moelius@trailofbits.com>

[ Upstream commit 6697091b386a4e2830bdd38512c87a4befff2b32 ]

The AD7380 driver uses generic regmap types and APIs. However, its
Kconfig entry does not select REGMAP.

As a result, AD7380 can be enabled from an allnoconfig-derived config
with SPI_MASTER=y while REGMAP remains unset, causing ad7380.o to fail
to build.

Fixes: b095217c104b ("iio: adc: ad7380: new driver for AD7380 ADCs")
Signed-off-by: Samuel Moelius <samuel.moelius@trailofbits.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 216f3c9ce183e7..57fc8f0de7b0c8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -188,6 +188,7 @@ config AD7298
 config AD7380
 	tristate "Analog Devices AD7380 ADC driver"
 	depends on SPI_MASTER
+	select REGMAP
 	select IIO_BUFFER
 	select IIO_TRIGGER
 	select IIO_TRIGGERED_BUFFER
-- 
2.53.0

