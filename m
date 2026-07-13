Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A68335BB4
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967613; cv=none; b=bg0e2Pecm56WeQ3oZes036dWyJLXpmZFZux9tSYx1oG05ZBMx76p8+fMo29M+u3UHsVnZ1uLf1YCUsEPJJa0SnG14IxX1kh1WOzdlb4qFK4KShIKWPFUJmN75xai15AENeFaZZ7odWEobgjDmcjYMVfMAujs9b84FS8J4Tw+UBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967613; c=relaxed/simple;
	bh=BD7RgtT7LVUzyH5B2yO7qKo7Aoo/3KiO9wN/6gozsds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gg84uuaX+EkWutair0fm3f3Jw0l46PcUCjsCs+nuEURtTQ5bRnF8lwMyMMg+WZw57TbGjgPaDI5XPmsYfaleznPq4vIiuR+83PTZicQgK75mVnDnAM8F16GaAYFo0af6+2yDRmqW6WW70XQ6+Zov2afxYqEfDLYk03oQC4vL2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLR4KFr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLR4KFr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B809A1F000E9;
	Mon, 13 Jul 2026 18:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783967612;
	bh=tFdcY9/unnw9ZqBEebLvoO7DAa0kXmsT+Ii4u6E1bDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mLR4KFr7cIZQKoCRmraLEOVeOrpI1yZdI1PqALLrlDGa6ht2yW9PIBg6SJ+pCgMgy
	 oQxy1W40eOda9bVb1GUoz7puj5HnCIvjD5Pez11oSVQ9R8zxj3YLux2vf5yZAv1Fqy
	 HT4hDOjLtLXIynw0XIIKe43t3CB6Q5m5pNLE/OV/t2pNV8jCOBCxPMT1q8bJHZdb9h
	 AdhoDX9zkVcYbvRbLvs2wBbp1plTCW9UmEHHX9nOv9+GD8Sh2nuCozNaKXYKjQWORr
	 28UTk6d5GG4uvPI2BwMMowgRf7PejDCgkGJNsPXlQQ3TNNh6qpeQB1kv+UKQKv6Ncc
	 ghjx5j5f6VpVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y] iio: pressure: mpl115: fix runtime PM leak on read error
Date: Mon, 13 Jul 2026 14:33:29 -0400
Message-ID: <20260713183329.1950423-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071330-evasion-badland-cd54@gregkh>
References: <2026071330-evasion-badland-cd54@gregkh>
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
index 830a5065c008f8..16e112b796ba9e 100644
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

