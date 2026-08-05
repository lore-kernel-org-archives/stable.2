Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A01E98E3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890278; cv=none; b=aTIU4C6HaTzcdvACM5stivzHBpBbc7zC0Z7meJtIs68rv8meuCm2tqAHkJYj/6juMHHzXRd/niBAy8YVT12pkcfgGzwALF+xfVUVMHV0NCg9h1DNaZGJP1AEefkVEwcLds+4+fEX0TBidGmF7ENE1API85yxXPJk/JbHclwwktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890278; c=relaxed/simple;
	bh=ogVCeeotpVkCZgT9BWifTpjDsQ2JBOb62SruTvjbE3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amHWuuocIoW98kaavVML9mMOMX8IhUUGTfRqCzfBnDEyLy0D6JRZC0bFfz7AsYR0xQJ+cvURm+AceZt/fUc84r62tugcMr6PgK5F4II6NneIECXyYPgoDKCbLpST24f5EjyuMQFcC1oZrWec3KujMrcSLZ/ldPDWP6Z2AGXxENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myeWYAKp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myeWYAKp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40E61F00A3D;
	Wed,  5 Aug 2026 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890277;
	bh=ZnGPaUyY443yPkK5bcbs4zCdAZhwETllrkOEOaCaRFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=myeWYAKpFfdGZ0EtFIwCMMQt75IskmKIAGlE484k9M6vFns7gQoZB7fqY/7SgVHCb
	 S+Q8SBgwmjr3EuC8JLjh4zsvC30GAF7Hma9VJkjC41gK+PjbJBQ3C+fyD/zAj9YVlK
	 JesucAESuOAPmIf+VgA3Yut8muG0bCFYzSpiCZS1jriR6USSSk95ZS7ndwFVb5N6pr
	 Zp3HnCBUCsr8ObZXs3XwvLN0kiF2ZzSRr9XDmlC12I76WY+yYBOqmqdn4NI2FE9ViD
	 j9mmQQVvXQtVF30DF1vs3KlvudtMj0QbJQArD48X/1H7IjLWObHqO+jdx1f0ri1RrZ
	 Rz1HxPdlIk5rQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Plowman <david.plowman@raspberrypi.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Jai Luthra <jai.luthra@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] media: i2c: imx219: Correct the minimum vblanking value
Date: Tue,  4 Aug 2026 20:37:52 -0400
Message-ID: <20260805003754.3975160-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805003754.3975160-1-sashal@kernel.org>
References: <2026072956-strum-murmuring-51d3@gregkh>
 <20260805003754.3975160-1-sashal@kernel.org>
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
index 3744b936dcd6e..cd639bb13db54 100644
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

