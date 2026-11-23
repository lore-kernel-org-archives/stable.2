Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466055;
	b=OXGwxa3TyOUjgIGGDFRvfTmocQxerOd0BnaG+ZICOAgZAFrWjN4NfE95Nd5g1vWAmDJn
	 5MdXV4MF8Y3C753/uQwBHbhqj/f9Y2BYI2swyv60OrP5C4kgSR1F9UU5CHg8IstUA1Tw2
	 D0Yka6iKyaM2MX0hLNBoUXHniI6bhMInI89jtgmNPUmCkyLHMDu052rlUw8doS/ZbRq+x
	 nhdNj/hD5BpvoFx51L66EuvERXlq5FLcquKgF/K4uWaj5gZsIfFtevZzJd8pUN2utb81g
	 n6j7AKfxpe1SrnLHyRF1apcPEWQYovQA8FaNlv/bqIiPxrZ3bkuR5HvzeOusfI1Y0HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=6OR603YV4U0OwPPTqnIgdhTgPtFX3ZXpQfBjAD1u2oU=;
	b=cZHZ8vSbvj+zLgkoZ9Hk6RxEP4kvEm2ZV4jU6tzZK99bBT8yceoxlL6Xs9ORIVT3Ygcg
	 bL/0CH57r7pk0u7NSb0T68rllCaFxSPwNdDur2TAKxuOiOdod/5oApj7rMw1cWpGzKvAP
	 lEgU5N3zNsjvOz73yE4SD8Ig5bgHwrls2Qmz8NW0PMpO8hMCb30u6TEi38hst4Q17XLkw
	 2LaCKcCjw/RHra4OD0CB5pjF6giNp0NRdqUBv9f4FZatriIs4qK1+bEMe4kQoLsK00kln
	 sbryc2FkNW0NEnp2cT7ZPy1PlhBguh+0+C3aFcY1Z5Lv8fFwodSJ98v4m+iHer5zyag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z8KvwE2H;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406A606A6B5
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4406A606A6B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z8KvwE2H
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so35880635e9.1
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795466053; x=1796070853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6OR603YV4U0OwPPTqnIgdhTgPtFX3ZXpQfBjAD1u2oU=;
        b=Z8KvwE2HmbcjiuKTw78Oy+YNYHN8GNMgYBZwyBWDc/CS0fSAzLEia6d20eoogHK0Hn
         vOuMZc1tGZkHl7DRiiN+t3bG2IFgC252SnyjViZZKXxG9fRFGcYKfrBO+gk8UHSk3PWe
         S4iem9nIFGhaqX9NQ4Js9uiYZ1+inGXClZv/XXVbBl4Y69Qr784kcrIcx08WVIOgzljm
         plrZjF8lPFXblMkh0/Wvq2uMJQ9p88D/hQep5TZFnT808MyazsF/ICLskauneupXUkER
         9bkaRo6Qx+GEcxY/itzEn9R2ug2yuZuI5MRf0EGq41C1Fta/MjuipuTd+qCOu4na/voY
         H/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466053; x=1796070853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6OR603YV4U0OwPPTqnIgdhTgPtFX3ZXpQfBjAD1u2oU=;
        b=FrUs2f/QDpRQgGSoo253pzEpegZRl65YWYJMmhWtTjxNXx2Pw02Y9oVaekmbPi7IcG
         6MLpExgDSgrTeHbu0mC1A9BLVcYG00lq3Lx2NBz3/MDkw7C6+ynHDykYson6DApw8Rm8
         pfTGTSWTjnevMAoIB5z6tBq8zX4c1aETt8Yx+Kw0l9/zI7PXgyrKMJubW6EqjZ2p7u14
         PINE8VzbXY/kNiea8ZZUwtTUXpL4ijRqfEBg1FhL4CmiYYgw+Ssl68XoAi5F18pVWgpk
         i0GsTThy98hcmOh6q0fUg2I2rbrorsBDoT+J3I1AdfPBIB9xEAoh6ZKA+tIvZtqi/YKu
         SPBg==
X-Forwarded-Encrypted: i=1; AL+hErFmwTWOz012fyPWNIp84W9PmnAVmPbA0Gp0XCZ3NQtuHjEhuLcs7xJVow7zDHtBwgq10SALiSs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vLewzJjDFD4dVn2fVTpVbfHO9+lLEJNah5caT9g4aie2wJf8x
	kVDVbovV/cyM0N+XXXZhwbXEL5rNSWyZx1PTZew5mSQBHTNmYAxs1wHR
X-Gm-Gg: AZFdTZcJ8KDwHl1aqbE8aY8v0NX90/gqYWW7bobV6/Fdqzw1FSyyJmQHX2I4icCvEFc
	hWNbJ6EI73Dmb7vUAFQqQsFp1XnRVWZSd2V3U7R5GA3pJXazUHmFrE/iHLl4GwU1ffXpR+xZObo
	Y/dZAl0M4cRJXFIY40FZBJZCPc+Ipz1JeOjiGQad1gUaFMK1uFZYrmS0HyBKjgiHWmX8aHpzr7x
	VVIzET6KB684ghI4xaPIYDgJ2CvBgzcgmbQZ7/L8MByPwClkKgAtvELG8IAvuAk+0M7ksnPWKYe
	mLQm7rGjPSELFrIF61RDjzPa5BVYp+KaF4rFozPEFNEK8lY6AlYEaXtpqttozs4gDp1GOIcTTe1
	VJA+OWmkzHvnHlVghaR6y+OhVIH7idxRHKFAwZAst3uP9FefOi1LJMjHtmZUqOJsuRGhdgthhKR
	7Zn1M6z8+ZEx2hVWfdaTqYFtzj5ESTdnQAcDbecx8gvVyCPbzHY87yILp2sqB9EE15lBqUopJB+
	1TondJu5OPs44NpQHvoKVhrwHBaENeQm7slKmmjqJ0zAYXNyCIQ0ayd2Q7czx5dVeSTWLZCScqg
	d9/UXuAYFHggApHX/xDDD5Ftp7AJAA==
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr275019355e9.14.1795466052668;
        Mon, 23 Nov 2026 12:34:12 -0800 (PST)
Received: from unknown.local ([151.34.53.154])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm515946805e9.13.2026.11.23.12.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:34:12 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
Date: Mon, 23 Nov 2026 21:33:55 +0100
Subject: [PATCH 3/5] media: ccs: Store the format set on a sink pad
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
Message-Id: <20261123-b4-ccs-imx376-v1-3-2b26850a6f11@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795466045; l=1782;
 i=morf3089@gmail.com; s=20240402; h=from:subject:message-id;
 bh=4SRiFW3bBAJ1IlBIN9DDyNFw3BbzT3m+KdYlz1JrA0Y=;
 b=l6DYb4OFrWa8aj8hDAV/Ql3Ppfpp3sLbxSS9XESSX/YP2O41q74bDTNHZvj54ZnsZPqr/xJx3
 rqMTCmBBAI2BQpjfkeyJakYJMMHHDCYCa1+p9Lfedm9CmP0aFocujWP
X-Developer-Key: i=morf3089@gmail.com; a=ed25519;
 pk=HsGrEQ3ia8BGGGO8/nUM2K2UX9JKvRPV+nbrVDGrYhA=

Setting the format on the sink pad of the binner or the scaler only
updated the crop and compose rectangles of the sub-device and its source
pad, the format itself was never stored in the sub-device state. Reading
the format back returned the one set up by ccs_init_state(), i.e. the
size of the pixel array, and the selection rectangles, which depend on
the size of the sink pad format, were bounded by it.

Link validation then fails with -EPIPE for any readout mode that does not
output the full pixel array: the scaler's sink pad format is the pixel
array size whereas the binner's source pad format is the binned size, and
there is no way to make the two match from user space since setting the
sink format has no effect.

Before the sub-device active state was used, the active sink format was
stored in struct ccs_subdev (sink_fmt) in ccs_set_format(). The switch to
the sub-device state dropped storing it. Store it in the state again.

Fixes: d8bca3ed1d70 ("media: ccs: Use sub-device active state")
Cc: stable@vger.kernel.org
Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 drivers/media/i2c/ccs/ccs-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 1cc4350856fd..a4af27de5453 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -2275,6 +2275,9 @@ static int ccs_set_format(struct v4l2_subdev *subdev,
 		      CCS_LIM(sensor, MIN_Y_OUTPUT_SIZE),
 		      CCS_LIM(sensor, MAX_Y_OUTPUT_SIZE));
 
+	*v4l2_subdev_state_get_format(sd_state, ssd->sink_pad,
+				      CCS_STREAM_PIXEL) = fmt->format;
+
 	crop = v4l2_subdev_state_get_crop(sd_state, ssd->sink_pad,
 					  CCS_STREAM_PIXEL);
 

-- 
2.56.1

