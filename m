Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D284456E12
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840463; cv=none; b=oRud5K0iNz6PRtOrOEz5AmMg8JWB2ZvxR8It1DlgsZnaKylY0vBg5wr2smgFLyGRpX8VNLfBOR+JXTzQ04c2ej/jP5+y+G8CIT8htqaHR56QjEOWsk+/JQ5AHAVqaibe61ftU6VQ2V094qE202t0QhkMUKeG4q9MbH6ru8ZmGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840463; c=relaxed/simple;
	bh=/2tg8CNYTZ/R9i8UsashDjiW8CAAuCI2OM0CfWJSNUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjOyQKUXcR5eQ8NFk7171H/UlzEwwr8QH1XQpuwt2DC03upfJoJLbRh59s05J/x7G6u1LJnIyky+406IeV0lBy0kfsWNyvEnPrvVLs7eKjBGil8VrWwspoPOk/FGJbv8rjpzS7zb2ze0pESP2zfPEzYB++pLMwLq28rvca4EwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy3riDWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy3riDWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3C61F00A3F;
	Tue,  4 Aug 2026 10:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840462;
	bh=SQl4ahUl0PkJAZTV9dR+B5ITd6TJ4y2GJyA3jjkXuDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cy3riDWsqN/ODi5BVlk6XQNoNHxgkqqYWNwB1ugtal1AjUHuRtnskZpAYjk/TlP6c
	 XuwKghzs5wPcFSHNxSFJu0ejtTBjxWqKkdjKvnU4kc/PnKz1xMhc1a8DuynFqHOSGU
	 SR4PD0ZwEEER8ICh21Lm1w5Id6jHO9UrrWdX7Uw9Uw2Q40V4TkIWcPFsymqlBgyywM
	 wV/kyMhGYWCHsGvEStJcCiN4U1yD2MYEWqwSSmm2mXD5bPLaz4soJiXtAieBCQiWoN
	 mXOrZ9qyUNojzIaxw7Grgw+oPHqrv/IarfyypSSx97Zyp+oRGYwmWGoozxVgEL5w32
	 FUFxXjy6jUFIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/7] media: i2c: imx219: Drop IMX219_VTS_* macros
Date: Tue,  4 Aug 2026 06:47:33 -0400
Message-ID: <20260804104737.2827302-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804104737.2827302-1-sashal@kernel.org>
References: <2026072955-retouch-favorably-ee17@gregkh>
 <20260804104737.2827302-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 5ebbdd7aab3321e60a8be23aac1fee4f16644021 ]

The IMX219_VTS_* macros define default VTS values for the modes
supported by the driver. They are used in a single place, and hinder
readability compared to using the value directly as a decimal number.
Drop them.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 2c4f1ba73543 ("media: imx219: Fix maximum frame length in lines")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/imx219.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index c34a8bb5854ad..c6894b15bc431 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -71,20 +71,10 @@
 
 /* V_TIMING internal */
 #define IMX219_REG_VTS			CCI_REG16(0x0160)
-#define IMX219_VTS_15FPS		0x0dc6
-#define IMX219_VTS_30FPS_1080P		0x06e3
-#define IMX219_VTS_30FPS_BINNED		0x06e3
-#define IMX219_VTS_30FPS_640x480	0x06e3
 #define IMX219_VTS_MAX			0xffff
 
 #define IMX219_VBLANK_MIN		32
 
-/*Frame Length Line*/
-#define IMX219_FLL_MIN			0x08a6
-#define IMX219_FLL_MAX			0xffff
-#define IMX219_FLL_STEP			1
-#define IMX219_FLL_DEFAULT		0x0c98
-
 /* HBLANK control - read only */
 #define IMX219_PPL_DEFAULT		3448
 
@@ -381,7 +371,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 3280,
 			.height = 2464
 		},
-		.vts_def = IMX219_VTS_15FPS,
+		.vts_def = 3526,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_3280x2464_regs),
 			.regs = mode_3280x2464_regs,
@@ -398,7 +388,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 1920,
 			.height = 1080
 		},
-		.vts_def = IMX219_VTS_30FPS_1080P,
+		.vts_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1920_1080_regs),
 			.regs = mode_1920_1080_regs,
@@ -415,7 +405,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 3280,
 			.height = 2464
 		},
-		.vts_def = IMX219_VTS_30FPS_BINNED,
+		.vts_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1640_1232_regs),
 			.regs = mode_1640_1232_regs,
@@ -432,7 +422,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 1280,
 			.height = 960
 		},
-		.vts_def = IMX219_VTS_30FPS_640x480,
+		.vts_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_640_480_regs),
 			.regs = mode_640_480_regs,
-- 
2.53.0

