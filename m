Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345A261B91
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888524; cv=none; b=iCcbltAJas9Ba3E+65+MN5yRtCsiMXWEjEuejY86SW5Vzm4r8Eizj4SMxflv6CJYN6SgVHCJpf24HA0+SejXLwVVzDDPENZo7W3MfS7L99+dw5PNAsUDLPjog71PNX4t8OxPF3A1oYf/yoc5Lus6ngwDNCGvpX7iM8uXkwT6t9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888524; c=relaxed/simple;
	bh=zV1HYSGu/5QVho204hnSggKyt5GAczb5zVmVas7VbC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXkr3YPuO0nBRvF+BOFM/kq86+qwWXjCfCNqDui+dPGTxqthT1e8JK6pLt5Xu5ibZR4lnoXzPxVJW1g1ScOjWKGDUxu4Dwpj2SqsX87Cwccq2jvOl/Nvg7QhMzP4RqvZoS67hCl3hAiYhNEVje/9DmIjHK802O3hU2wEKARkNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YELwz7mg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YELwz7mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5762A1F00A3F;
	Wed,  5 Aug 2026 00:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785888522;
	bh=rhnclBTNRd5TIoypzVTJmZuGqh8ZCxJexxcwLB6APzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YELwz7mgLsaKGD1ygfob7tJVj+0eCUYDyIRTbRCrXZpa7IMBH6Bw+QYWUMnBD42yN
	 xHSKyHzsd2fIzJh7htLx8qLitMssh+izrdAsml9DpOmO+PaaTfQMVA0TYDbivBvonp
	 2EMaXGoCPu0xOO3e1SNANKv430PbnSQn909jGlnPlJCG/44v0Modr8wTxl2XrI6ZEe
	 asKNzLNpYJJ8d+T1SkgZb1/C2/66GQpP/bx8v02UrPkhNqFzHqNGh2pdNDEAysjAmg
	 H8AwOy1WMxqm1GX3v1Yz9C2peKVTKlxMo5jGPCvVs6sLEgkbLljNuhs265jcXEPToz
	 7e1EvsRenpvMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] media: imx219: Fix maximum frame length in lines
Date: Tue,  4 Aug 2026 20:08:37 -0400
Message-ID: <20260805000837.3912288-4-sashal@kernel.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 2c4f1ba7354312ad2d6e34e70a518a51a9344715 ]

The driver used the maximum frame length in lines value of 0xffff, but the
maximum appears to be 0xfffe instead. Fix it.

Fixes: 1283b3b8f82b ("media: i2c: Add driver for Sony IMX219 sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 1c51886d3a073..8434070477550 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -73,7 +73,7 @@
 
 /* V_TIMING internal */
 #define IMX219_REG_FRM_LENGTH_A		0x0160
-#define IMX219_FLL_MAX			0xffff
+#define IMX219_FLL_MAX			0xfffe
 #define IMX219_VBLANK_MIN		32
 
 #define IMX219_REG_ORIENTATION		0x0172
-- 
2.53.0

