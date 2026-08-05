Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70525B08C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888522; cv=none; b=oWfF35vxe/XpGrhqyxcbDnagxw8QV3EYTC9irKf13kaaC6qn4Fp5A+oh4upCtUC2XQCHiHJ96CvkTAVpSpdIGj0qxqURC6OyNcmDMcqRvxk0Oc/j0cVrK/LnBTcSQnEw0ZTNF21CM9gbZ6FRBy5Nuiy2Kw1c5/PqsTFPtxWFrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888522; c=relaxed/simple;
	bh=mR8NdvEvXr4IUAyB8fwYrT/QCRTD6hUPbc3qvJ1Iy8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuHxxB2uermft3BaVEEsG/GDgShgo3WcMFR8B3L98B0qeqnFItHxrca4jOFgxemSo6Hf0fw410wTKZXSor1SMpk11blnvJit8m4lInt8eAcvIlSxLG57zJLWwAhGBx6fRLcSZkjolH55InS8JA767tnsGxrZNo9g2WsRjjzFdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf6C4t0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf6C4t0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C3C1F00A3E;
	Wed,  5 Aug 2026 00:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785888521;
	bh=+2yymlnWxwznpsota6lkFMxoG1zmNGH047VDi6DiZxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kf6C4t0PeV9SL2nUMcfVLN+gUzngFaAjjNG1LWgekUP8MayXeZLsKvXd44ysGdPyE
	 CKIIZm2tEYRcAJQ/3bNVSbXPqsaJwiT5GhM4HcWDe01laDgpOgTssxlL0HJ2F3Yn7B
	 yJfUw1qCT54XEPlzA+qVFj7AtanwOnZsDTZ9HRumAhvaKpOZH/TXRpRuQUrsj5TKF+
	 4Gw6O8xf6REoXdNUjt9ifdQ76ePlcW9/R6WCeP6Ma1RIGS3d3JICA39rnpO1Pqy+vE
	 TKDebHPPBTC4kx2UJF9YnnBLWZOWEEpK3rHTr676J+stzbCbpU2Kgz/QwBQG2xggth
	 MHV4KLMoQOpEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Plowman <david.plowman@raspberrypi.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Jai Luthra <jai.luthra@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] media: i2c: imx219: Correct the minimum vblanking value
Date: Tue,  4 Aug 2026 20:08:35 -0400
Message-ID: <20260805000837.3912288-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805000837.3912288-1-sashal@kernel.org>
References: <2026072955-ice-rug-c64f@gregkh>
 <20260805000837.3912288-1-sashal@kernel.org>
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
index 290bc6c8a4854..7917277b18bc7 100644
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

