Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466056;
	b=yJNn5j1E8mzueLTC0FnynsMNvtBuu1wgUkJiolQEE5U4MxvQuZEAeIwN3FTtpmcTKQjW
	 9KLYlPrLnTU6OTlU1mNdP7YshhvKkiSnXfdOtvOlr9watsN8QNjOwvIZ98F8mfY73d2CZ
	 GStpD3CH04Np+mzFab3ubQqlBCCElySpkwE/I6q9KmKj6X4MdLq7dsI24Wl3x8GKU98o2
	 QuvRbKA1lE/YZtSaRHUhTCUanLG7RoB79Suvgtw0FGefX50J04ySke4lCI0UpDhT8J9qt
	 g4TBv94xQDiBn8IAmCXblJd2iOBAmEv6tExD+waVZtHa0qEXV9pJr+XcdHIY1wFtrJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=jmJspXYhqF5Ifm6vBoYFDWnnVcY5oxgK5Qh3Vesxuh0=;
	b=0SiCRFoACHVApz9den1rb7g9yjOxnQ80LGdpAmU/ArixUEloHcZJzIa0s/tHcanJb+Qt
	 9k9EuchRCS8hmxmrCjfrQOmiCaBI9TodRr6cRVkS7xMFmpuEP3K/EfNJPqQX5uShT5bdi
	 ZNZP3waERKJ9adbS43MOqX5a6wMcs9CUHDXB00v5Kbn16eeVoio99dW8xz/gvoUKdRRRu
	 u3WGq4DlrkaH75FPKKsAmu3ZtBFNnYp6+j80XhEkw/Tch5Ckbl6i/KSD/uSDueFPiiJlA
	 Ka1zvnfBZXEPfGzzkaJNoPxqXmhAjpXIywinCcc90W87CTSJ8vWc1f/zBytLOKV5o5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqHfWJa9;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DD60A2611
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB4DD60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eqHfWJa9
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso36662825e9.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795466054; x=1796070854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jmJspXYhqF5Ifm6vBoYFDWnnVcY5oxgK5Qh3Vesxuh0=;
        b=eqHfWJa9Wea/Fb3/RD4KYoNZlniZ37XLDzgSuVOIwm9447N4+odJLiA9+zkUe8O7X8
         pK0pzNZwfoFcU2dNJid5h6+dBt/TBAwVz5J5T6E+Boe72nNC8S/RYIm3Egeli4/IEMgA
         kMjdkocnsr/jvd8VxembzJJFNYf+KCwWAEdQP5wt6SiDf20JnQi1dTcd+XnXb/P19sdj
         mlD2MvXC8CBGvpHU3jm2kIMGANo69DZbATy6WMiPUyFHx4o6VMlPn0bU5asxKS4JoHHh
         SRDGprAGom/o6GTtJv7uVF3N3HmCr5Me8w2SGAictAeM4pxXxdh5NZwEa1Iqxd1MlJ5A
         eZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466054; x=1796070854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jmJspXYhqF5Ifm6vBoYFDWnnVcY5oxgK5Qh3Vesxuh0=;
        b=xPv1VlKUwTxbgK7U3pUXqSYRMpJtprKaT7ZXE99tmkV6w5smqnB+qAtKKEu+0Pl+B/
         V7yt7gp7SsWBQWfrsuh4Prk/uO5pyUqBOLk3d0MpjXaS5cMfElMnP6rtsrqIFw6LD+fG
         +rncGY8TJxaexKmHDw2iWVMgVtSSgMJjLr5fX82fdLB8XoNYA3k0/QNUTh7QCyltqLTL
         emL43/2KQKsqqGW6Q9FsE08Pd4p3mUWz7kcEo1FNi0ypaH0GB1AAzEq2zG6n00IATlFw
         Rr4bfCk2Ctf5alvQ7mVm4C9NtIv5RUKMzT/vSiMzjQXhrbeS/UoeMo8xbRmXi33iPTdt
         oQtA==
X-Forwarded-Encrypted: i=1; AL+hErELq7d7bD97JC0eZ9QidMVbv/I/dFTC11+S4m2bb/QQeJe2Fh18YgzkQXHagFp4aAc9DHoWwT8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0ff+5JsOxqVqIGrIHoRmdNec/UrH09hoOF+JfzlyxiYsmbuTV
	LLe1ivoLi0B0qTipgcS19cQ9+2pnv4DrUEGipNIZ5TFo/AtkOwsAUt8w
X-Gm-Gg: AZFdTZe9QDX36FRo6FNSu5c0Fy8sKgfE1CGqn0VGKwXYOAyTHhqD8zKOY3oLokFuRRj
	4UUsYm4CJZssB6lB1BBYFYGlwCUjKez4AaXD2IDqAz7YrH6Sr0u7q6MwPK6ZX+QR9Lg+jgeBR9C
	pIhmyNR5WM8Lh2X1rH/m+m47ohU1K9HQp58/yL3C0EhQ0J9NUe19wnsyupXvpAwbfsxCUofOtko
	ef18vmI9a66K0FxTFk9GhtGWxkK1C/U35YIjIb1vaiPdWKr7xidyzQm7upJMitWS7yOUmAKGbRq
	USEMFWtxa13PX4FuTwaCPuLH40ltcYb0WqOE/f82/KGTH39sFLrGtSEBocMniZrgr6hPgqQ+2IF
	IMj/0UFdPMqUaF4xtddQlUjmceTnj9Fvwp+VF8qy8csPjqN9ZruoZVSLmwNtcx07FxFollJZF58
	tDuOA3E2kTC1InE+4JhPURoqO4mWOKi/JVU40dOQoOO+7VCY/eme3m4znBvdjV7ZvFnRNCOKF5i
	iUqk6IUnsa0g0EWB+x5sfaRYsvkPmDaty+sVh3yUTAw8W74+dpzl131NHg1LQKzL/npbJtj9jGu
	IGzXYiqhUA8HdHAqXSjdMmdvfklpL+A=
X-Received: by 2002:a05:600c:820e:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4bb887c9936mr256814445e9.1.1795466054054;
        Mon, 23 Nov 2026 12:34:14 -0800 (PST)
Received: from unknown.local ([151.34.53.154])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm515946805e9.13.2026.11.23.12.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:34:13 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
Date: Mon, 23 Nov 2026 21:33:56 +0100
Subject: [PATCH 4/5] media: ccs: Make the source pad format follow the crop
 rectangle
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-b4-ccs-imx376-v1-4-2b26850a6f11@gmail.com>
References: <20261123-b4-ccs-imx376-v1-0-2b26850a6f11@gmail.com>
In-Reply-To: <20261123-b4-ccs-imx376-v1-0-2b26850a6f11@gmail.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, stable@vger.kernel.org, 
 Gianluca Boiano <morf3089@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795466045; l=3197;
 i=morf3089@gmail.com; s=20240402; h=from:subject:message-id;
 bh=AfhBJJT/dYmW+sBV6vyFvVaWagbgV6JhE5LC9kE6/9w=;
 b=nA+mPZum9SfgJ6ZaFHnBsjvxZSARCOiB7wSvuXdYHv0c3WlskBv1F9e4K0z64Lp5zVi/LfWCS
 bsfvfP9bsrpApXIBaGZJ8QAEOn0BW8kIsqyx1hwoN5rRmPBZz/5icF1
X-Developer-Key: i=morf3089@gmail.com; a=ed25519;
 pk=HsGrEQ3ia8BGGGO8/nUM2K2UX9JKvRPV+nbrVDGrYhA=

The size of the format on the source pad of the pixel array, and on the
source pad of the sub-device that is the source of the CSI-2 bus, is that
of the crop rectangle on the same pad: the analogue crop of the pixel
array and the digital crop at the end of the pipeline, respectively. The
format was only initialised from the pixel array size or the compose
rectangle and never updated when the crop was set, so after setting such a
crop the format did not match what the sensor outputs.

As the format of a source pad can not be set from user space, and the
format of the sink pad it is linked to has to match it, link validation
fails with -EPIPE for any crop other than the full area.

Update the size of the format when the crop is set. As the size of the
pixel array format is then no longer its native size, use the native size
as the bounds for its crop.

Fixes: d8bca3ed1d70 ("media: ccs: Use sub-device active state")
Cc: stable@vger.kernel.org
Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index a4af27de5453..acea07d906f3 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -2541,6 +2541,14 @@ static int ccs_sel_supported(struct v4l2_subdev *subdev,
 	}
 }
 
+static void ccs_get_native_size(struct ccs_subdev *ssd, struct v4l2_rect *r)
+{
+	r->top = 0;
+	r->left = 0;
+	r->width = CCS_LIM(ssd->sensor, X_ADDR_MAX) + 1;
+	r->height = CCS_LIM(ssd->sensor, Y_ADDR_MAX) + 1;
+}
+
 static int ccs_set_crop(struct v4l2_subdev *subdev,
 			const struct v4l2_subdev_client_info *ci,
 			struct v4l2_subdev_state *sd_state,
@@ -2556,7 +2564,9 @@ static int ccs_set_crop(struct v4l2_subdev *subdev,
 	comp = v4l2_subdev_state_get_compose(sd_state, ssd->sink_pad,
 					     CCS_STREAM_PIXEL);
 
-	if (sel->pad == ssd->sink_pad) {
+	if (ssd == sensor->pixel_array) {
+		ccs_get_native_size(ssd, &src_size);
+	} else if (sel->pad == ssd->sink_pad) {
 		struct v4l2_mbus_framefmt *mfmt =
 			v4l2_subdev_state_get_format(sd_state, sel->pad);
 
@@ -2579,20 +2589,21 @@ static int ccs_set_crop(struct v4l2_subdev *subdev,
 
 	*crop = sel->r;
 
-	if (ssd != sensor->pixel_array && sel->pad == CCS_PAD_SINK)
+	if (sel->pad == ssd->source_pad) {
+		struct v4l2_mbus_framefmt *fmt =
+			v4l2_subdev_state_get_format(sd_state, sel->pad,
+						     CCS_STREAM_PIXEL);
+
+		/* The size of the source pad format is that of the crop. */
+		fmt->width = crop->width;
+		fmt->height = crop->height;
+	} else {
 		ccs_propagate(subdev, sd_state, V4L2_SEL_TGT_CROP);
+	}
 
 	return 0;
 }
 
-static void ccs_get_native_size(struct ccs_subdev *ssd, struct v4l2_rect *r)
-{
-	r->top = 0;
-	r->left = 0;
-	r->width = CCS_LIM(ssd->sensor, X_ADDR_MAX) + 1;
-	r->height = CCS_LIM(ssd->sensor, Y_ADDR_MAX) + 1;
-}
-
 static int ccs_get_selection(struct v4l2_subdev *subdev,
 			     const struct v4l2_subdev_client_info *ci,
 			     struct v4l2_subdev_state *sd_state,

-- 
2.56.1

