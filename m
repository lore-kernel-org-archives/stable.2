Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C23546C1
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971199; cv=none; b=BNpoGnSARdUUY52OG0fRCR/TTQN716e9yc8KfTy5zHZ7f60UyUeK4Ycigv5CnCkBZd/A5nY2tsWRQBVEzjO2GyQRKsu9TgrgqX4XBphQQjvNjB7lqgLLZmvcYftAkJ8/5GTI/dWASPJEaTQALlcFTr5AYvW/ZPqNAwi2DcW8M7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971199; c=relaxed/simple;
	bh=MJq1fm2luXJMkmYln+5H20kq8NZO8TMdz0aFrJd223g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h65BTeHHHp3TnFigbGRQqo0gOJ4aJSGj1B4FdGR2IKcRO6PPVK8ZbK8OIFnWhhkscGs8EaTIOKRt1F+D0ndlGQ6/kWw/E6JKMTjN7EigBuCOT4mLlZe+8C+qp54wWaFbmLin0AjcuynRHSwsm/R3xjpeTcq5zt4ZUeQ6xzITksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glhkZHdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glhkZHdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C07A1F00A3A;
	Mon, 13 Jul 2026 19:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971198;
	bh=502MmbbA0DROJE9Ngx7Tv7g9FElr0jhMz0k7+z3BM5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=glhkZHdWH8oMilA/L9VO+zv4TS9VxAlmv5YEdHCmI2fD/IWXRdZYeXCrLGToFEEjv
	 5rsuQStcsRBNnDluBhPI2IzPVZVV6sqxAb54uGdEfld25qaup3Mw4IiBBgIxGp4uRm
	 AV7zNH/ukdadusOyvoZG/AHvDSWwDoB5lOB625cr973SD1GGA2GuEwlA68158cI6YT
	 MViVgP48NyV8oOBTV91U/8vtqeK27ruZxQFmVDRbg3FKZWRozuU3Sd0kEPCZWMIVAZ
	 8l5XC6VkbEdXuwqwsDPWeNEb3nVYVJyywH69/n2WNx73RkNuDUBksEagfrv34seFMm
	 aMtIi7WExvscA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] iio: pressure: mpl115: fix runtime PM leak on read error
Date: Mon, 13 Jul 2026 15:33:15 -0400
Message-ID: <20260713193315.2035880-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713193315.2035880-1-sashal@kernel.org>
References: <2026071351-alphabet-sleep-d297@gregkh>
 <20260713193315.2035880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biren Pandya <birenpandya@gmail.com>

[ Upstream commit fbe67ff37a6fd855a6c097f84f3738bd13d0a898 ]

mpl115_read_raw() takes a runtime PM reference with pm_runtime_get_sync()
before reading the processed pressure or raw temperature, but on the read
error path it returns without calling pm_runtime_put_autosuspend(). Each
failed read therefore leaks a runtime PM reference and prevents the device
from autosuspending.

Drop the reference before checking the return value so both the success
and error paths are balanced.

Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Assisted-by: Claude:claude-opus-4-8 coccinelle
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/mpl115.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 18c2488e182cdc..11ee879f4da440 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -106,18 +106,18 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 		*val = ret >> 6;
 
 		return IIO_VAL_INT;
-- 
2.53.0

