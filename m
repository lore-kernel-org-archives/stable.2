Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362B243951
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891495; cv=none; b=qnrUCkmtyi/lcdjxM74iSVhmKCi+Q6iVJ1byJ5kyUxWLoMUuPO3bqUVYPn9KaMx8wsDbfxj0XdJzuNlVAbw0fYYU7VWLvGiJTtp2EtKzmqY9Ec9RSz7pHaJ8SQrE0STQsjo8Q2bMoaH4ITIK0rTD2+sWHRCPzVy5GWnZ7fsiz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891495; c=relaxed/simple;
	bh=v4Jt0YAZ2NPwc2cHceK6SwAk6AD/gvtXpkL2Hc376CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhavEHbpcm0RV2ldhI1XWsRi3hUA3lTOJme/RZjnVAxcvKo4KmZJSZJYUkZVxL0e63NN+suWzKv3V8D3BrR/43+7/E6Yn206dKAoQ4SOjLvZol+j3flQhDoJictbGgxHdv9b+xCd4jNwh20NCwzPwNgQGyfVkSuwYY5lMQ9iccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az4gOe0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az4gOe0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0119B1F00A3D;
	Wed,  5 Aug 2026 00:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891493;
	bh=0MRMtpFi0q8iHrpxzsfHAC9exQzwWV8vqIY3V9cX5tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=az4gOe0PNlvcfy5UzYNhzK5Pc4qsSVh8o/IhgfmWYsdm8HIs6WT5EJM07XTRx2SqF
	 FOs44qGnswUT6KE4pFbRLoyGbUcyBN9YW22LJ6leTcmXUtOssmCcnfELYz6D1Q8Qsk
	 ueCEViQHI4/Fn9QXnRYgumOJF5m/lzPdaKBLq2f5Kh+lGAMhODICxJptzVOncJn3dP
	 hWdU1yZ8xp5A1+rRP9Wr1mUyp8UbHWKcrPaqm9t1UKx6nywxSlFsFVnFx40UnCoun/
	 m02TwLIhNJjV6qQ7a2fY8nv6qTIvReiitMBE+B4BTu0nybRXyQZZ7N/wV+CJ/wEFoX
	 yhjD1YwqFtFww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Plowman <david.plowman@raspberrypi.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Jai Luthra <jai.luthra@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] media: i2c: imx219: Correct the minimum vblanking value
Date: Tue,  4 Aug 2026 20:58:08 -0400
Message-ID: <20260805005810.3988269-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805005810.3988269-1-sashal@kernel.org>
References: <2026072956-fresh-handoff-8044@gregkh>
 <20260805005810.3988269-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Plowman <david.plowman@raspberrypi.com>

[ Upstream commit e3b82d49bf676f3c873e642038765eac32ab6d39 ]

The datasheet for this sensor documents the minimum vblanking as being
32 lines. It does fix some problems with occasional black lines at the
bottom of images (tested on Raspberry Pi).

Signed-off-by: David Plowman <david.plowman@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Stable-dep-of: 2c4f1ba73543 ("media: imx219: Fix maximum frame length in lines")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 2ed73ce1a646a..84c3de60216b0 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -51,7 +51,7 @@
 #define IMX219_REG_VTS			0x0160
 #define IMX219_FLL_MAX			0xffff
 
-#define IMX219_VBLANK_MIN		4
+#define IMX219_VBLANK_MIN		32
 
 /* HBLANK control - read only */
 #define IMX219_PPL_DEFAULT		3448
-- 
2.53.0

