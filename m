Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046019;
	b=gI17c1/Evvq9udnNSG/ahwMNwkd1kEMlvhv0PFajoP3pZTkSORSpL8gvtq6N7nLZWZJC
	 G5En33A0H8igVVh7/rVf/Mp8AGp9MjK1EbTP4sCGzlH+NclSOKUeCZsuC2kEp1BQm+bb/
	 gE20JWibjBy29wgxM3+oIezxtPaMZcB3vEB9IQf/9aMMdsCt5A6LBSND8Web9PWPw+pgR
	 S/RS1LV6O3iQttmyvtrcm8dpS8wQ6srlz0mVd8ssK9gsm/akVEcn7pXj5mm/NDCGGEp5Y
	 PxCvy5C6JBLci4eTrsSkwDewl4X3UAGgRZpzkBdTXXxDF9bZ26tv/SaN7DYdjnHrptA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046019;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ERlBYZ4xAp+9e4+HzV92HJMzDBW04RSBL+5LrAiRODo=;
	b=U1EmsDWIA1oXcvzHAB4EspUMAqXr/EyDA42rnwkGJM9OuEJEEIs5CUsY+A9A6Ksejwbc
	 DxVcb8qZbu0d0MslBdb/NAuYVIDFBQbhAhQvFD1ZKy/MNZwSiRlufFs7iTsYWhDfhDUwH
	 4LnybXtlaoEMsZ1JxpuQoRwFO9aR5Lmhz1VaZe8fgEZGbptT6FxBlbcceH5p0lFXPBj1q
	 ynY97SmD7uk2UdM6hOD/ZobsDsisxH3k+o9+A4BYNpOPXMatGg8GXZDF8zpiKzUUH+roH
	 cSMgsaIsOLbUwbJaaWRJbS3gxdBEQwpp5N1hho7XQmoLnGDyUx27RLeVJc4KvpsK24g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5j9ffGM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C45606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h5j9ffGM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78451F0089F;
	Sat,  7 Nov 2026 10:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046019;
	bh=ERlBYZ4xAp+9e4+HzV92HJMzDBW04RSBL+5LrAiRODo=;
	h=From:To:Cc:Subject:Date;
	b=h5j9ffGMBUTnPUGDjvBgxiwkh5vbsZhlEAGUgv8ts22zYqaioJjKYI7F1BMnsS8ix
	 7EnbeIV1oHu4XAtYCsAib9hkd45CZVShKiI6TIgzvVL7lti8jA28Rao4eGM+fFoSQd
	 xNSMYD8b6tEEMzQP4pTDFrw/ZHOIYSByfLqEHqjdPsWU7+71tWZsSiPJe8qBdnNQdT
	 zM0zojDeAOYZEkcgfsSjsL39VswRsulsnw6e57iH0b7VhqfBiZE2nAjiP6piBXnuxg
	 /FCX9Ap0/hvEbMM2w5gWUiXQjjuHQUWMXeC48ds/8urapuBcqvPctmsfAvkc5VHSC+
	 ObXaXm+AKQhiA==
From: Sasha Levin <sashal@kernel.org>
To: sakari.ailus@linux.intel.com,
	dave.stevenson@raspberrypi.com,
	laurent.pinchart@ideasonboard.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: imx219: The horizontal blanking step is 8" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:57 -0500
Message-ID: <20261107050657-failed-6.18-47576c541e9b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 47576c541e9b473841742bd0686d4940f5c93564
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050657-failed-6.18-47576c541e9b@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 47576c541e9b473841742bd0686d4940f5c93564 Mon Sep 17 00:00:00 2001
From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Mon, 22 Jun 2026 14:23:40 +0300
Subject: [PATCH] media: imx219: The horizontal blanking step is 8

The step for the LINE_LENGTH_A register on imx219 is 8. Take this into
account in creating and modifying the horizontal blanking control. The
minimum line length in pixels as well as the horizontal blanking values
are already divisible by 8.

Fixes: cd5e2fd89923 ("media: i2c: imx219: make HBLANK r/w to allow longer exposures")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/imx219.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index b1f29037af742..05717b1e32244 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -78,6 +78,7 @@
 #define IMX219_LLP_MIN			0x0d78
 #define IMX219_BINNED_LLP_MIN		0x0de8
 #define IMX219_LLP_MAX			0x7ff0
+#define IMX219_LLP_STEP			8
 
 #define IMX219_REG_X_ADD_STA_A		CCI_REG16(0x0164)
 #define IMX219_REG_X_ADD_END_A		CCI_REG16(0x0166)
@@ -593,7 +594,8 @@ static int imx219_init_controls(struct imx219 *imx219)
 	imx219->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_HBLANK,
 					   IMX219_LLP_MIN - mode->width,
-					   IMX219_LLP_MAX - mode->width, 1,
+					   IMX219_LLP_MAX - mode->width,
+					   IMX219_LLP_STEP,
 					   IMX219_LLP_MIN - mode->width);
 	exposure_max = mode->fll_def - IMX219_EXPOSURE_OFFSET;
 	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
@@ -935,7 +937,8 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 				  IMX219_BINNED_LLP_MIN : IMX219_LLP_MIN;
 		ret = __v4l2_ctrl_modify_range(imx219->hblank,
 					       llp_min - mode->width,
-					       IMX219_LLP_MAX - mode->width, 1,
+					       IMX219_LLP_MAX - mode->width,
+					       IMX219_LLP_STEP,
 					       llp_min - mode->width);
 		if (ret)
 			return ret;
-- 
2.53.0




