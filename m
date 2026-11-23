Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466051;
	b=A59rJ1T1LtbgdL2+IrQ0pO/I58SaENdxwl/hMHy6ctHyVYm1d+/m8k3SVL4++jhrscf1
	 17D80CAjxCibmV5PGPHAyaGo78kGPgPDEYtUgWBF7bdJZbGSm4ExfS5/lgVuAsmOmrkhS
	 ynZrhrHD/Amj6vIMmEF5uzDKX40O/B3FnS/7/k1W6rZRP/5XL7y5tb27zzcxWVQOGxNTb
	 b0pny+rz2QaM6dqgwy0ZuMaT0pkyKc4RBHm8yzrpiQOvFQ/It5MJ7L6JWeGwbL+GBJF93
	 UXurgjvJQApu5cc/WNoYIbtj9hDZ/WsVIHnvdurFreJa8K5wo651EpryPp4smQEh6gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=e2HIsCv1tN4Vi7S2Bt6sM0bBboMl+JYL9mFDX5CB8EU=;
	b=mJfN2SX96w6+8fztoqItiZtkjXF3Hr6Qi8rSByP9UHq3XikXixoGRuOozS75Z0u5w26V
	 1bolBmiyKXXlQVuQhx1ZdNd4upQrPSz8jrz5Suy/8i/8+dOjBgcaJJvlpY9xaPh914dsv
	 qQNCuq/ZXdcG/b3I5k9pQLbD2MHZCiwjSQbbe3oHaPHL156D2IzUV3ZoitsMtMs9Xyr0a
	 +u2/PMvyi7Ih03ecymCJzFbksZ7jjfHVFO34wOHWCiVikylqeL6VqTvmD83/WdXAPplN7
	 sH+tUHMn2sXbjolbEYMWerZR9CxVnooXIdqJMhqNOhIwW+2JXOxhceA0Verj+cHUYQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z0dkIdz1;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19720606A327
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19720606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z0dkIdz1
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so35171265e9.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795466048; x=1796070848; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e2HIsCv1tN4Vi7S2Bt6sM0bBboMl+JYL9mFDX5CB8EU=;
        b=Z0dkIdz1roQI0bhGJaA9+OHdDJUb11pyWR1I0jClrb25KvbgqdbiUJpTQ/2I5gSBa1
         ox35HBBCOO/04aN+1/A2xtOItH+b2YFK3uEiKdSjLNqcUXt7OWClMQuHYnWIlhzNABdT
         8JGr7lszt+hrHB3P1lnIuYM3IuSJLMBfr4IQKPq8lfbOhRi5Z5Bqc+XiAZlqJLcfqu6F
         Tex4oD/W46mqnR5WWtm149Ey8O/ke4KvGBV89JhJiqn7Z5DGI3EvTQeTBtsgnr6oNDYH
         CBKE3gbHgR6HixF4//gzTiEUrZxUyfLt/Bi5nmrzEfR3RtbNbrsgZkb0JjKoZTjb6IMA
         s4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466048; x=1796070848;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e2HIsCv1tN4Vi7S2Bt6sM0bBboMl+JYL9mFDX5CB8EU=;
        b=tNFsfT0FZweNWzM6E6VnMfRxVA+EHPSN3V8CZVqtrBWsK9zKB0Qy9nZMQxzSsNOEx+
         ZfV+6khC28Xq1V0SorZfcXQABNnJlGG6IotB08asC7QqpjYAFQL45q+/6ltifVxG2D6S
         YpRWG/9o4s4l/c5EvIsFDMziLYJjOJKbxJ87zHJUiVNQJOfTPIZ3mu2QVkaI8XfHGf+u
         N7RZ/cUN4PaEWRkqcHjv5YtD9Tpi4EKPUeIEhbtQ/sHD8l0/j+N6LFWQpAlGq2QQjq4u
         SgJ2Xy6lxLcCr1PN7trrpP8nW7ltKqqxbKxkMDEprKVjZ59s2t2f3rtikOZBoBQ80VLw
         kccg==
X-Forwarded-Encrypted: i=1; AL+hErHtENF97HqwZ10Hb8QtfWIJaS7svIsgQvNjah3Mfa0fRFfJdAj8LiwFYGoL0nQ1KkL/lgHrw1Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pnSoRITyUZ4MAeCH0VTL4Wu69DDhRmgEEboPb/YSr9g8hM46c
	98NJ3jji8vIlfoIEwiuzZubyoSwEAnf+30b2prwm74a4G7fhlA31vDvT
X-Gm-Gg: AZFdTZcQp2Tboz2VUdY3tZNfWkiVs7hcQcH7lDqrJW+LT2Wvio07qFclWjopHb5bY91
	CYXZV6Rho6j6uJPcoFxTPp4NHUDls/sE+dyu8sNVL9ebhTLMeFW0mvEMKUkiHG7EePi4jwxFz66
	WVUXajRH5EGIxsK0weu4R6kpUxJCpyfOu4YSWuK6fqMyUUGefe4eOB/YCIKQ1Wy5+gCqjmOlmhx
	ucY2yI3AbiLifCltnMLrLeMgFyN3bDPy/9nQn8ugPXc5acpKjjt1XoYk6pQSarFdGKTcapGQiA8
	rVw22x7schxF9biLVy6ckhMWoLs5sijtTW3bhRrwCTKSa+fenof6SKw+n1FrKNd1KDSKCje/oCX
	dt7sEjTkogEVu7Kwbwfz9WG5K/imVPq2ldz1YimPl2zfwmmElcm+Gsno3xF7QpQwgQd+l3L+XJH
	ylxTnzJR5W2YYnMK4nJZsWstIDoQAMK7DOITnINtbRyndeFNXDOWw68g38HtVR7XvIqTPEbf+x5
	jD8aLXt20pENuw5sD8QpQEi8WJVzhQyjBsvKv6H3WMgVE70zLaEuMC47lhCh/4Gr/hCEsMkkgzc
	hD40wYE3bpZO4sP5asCUgXb7Yw+yAg==
X-Received: by 2002:a05:600c:64c8:b0:4bb:6848:d433 with SMTP id 5b1f17b1804b1-4bb8881d141mr251247305e9.26.1795466048254;
        Mon, 23 Nov 2026 12:34:08 -0800 (PST)
Received: from unknown.local ([151.34.53.154])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm515946805e9.13.2026.11.23.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:34:07 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH 0/5] media: qcom: camss, ccs: Sony IMX376 on SDM660 using
 the MIPI CCS driver
Date: Mon, 23 Nov 2026 21:33:52 +0100
Message-Id: <20261123-b4-ccs-imx376-v1-0-2b26850a6f11@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5EQBBA4atIrVWiy99kriIWuhVKwky6EIm4u
 8byW7x3gLIXVvhGB3jeROU3B5g4Ajc0c88obTBQQoUxRGgzdE5Rpj0tC0zStqGcyk+XWwjN33M
 n+/Or6te62pHdck/gPC+R5DbtcQAAAA==
X-Change-ID: 20261122-b4-ccs-imx376-03da25278f5b
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, Gianluca Boiano <morf3089@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795466045; l=3605;
 i=morf3089@gmail.com; s=20240402; h=from:subject:message-id;
 bh=Ux1jAIk65UvpQG9eUkT9o3z3KHkRuAwplFQDfWVP5dU=;
 b=Vskrd5wcS4R1Anr5d6Nyalh7iBdzMn/H73Qb2lS95hRFgbE9FGaCuvQ9ikd9Hacqt/V2wzhXR
 6U9YRMIlS/oAOkvr6vMQ5bzaJ2s+MkhuOnvS0jFNeEWgPI1e7GDTjVa
X-Developer-Key: i=morf3089@gmail.com; a=ed25519;
 pk=HsGrEQ3ia8BGGGO8/nUM2K2UX9JKvRPV+nbrVDGrYhA=

Hi,

These make the Sony IMX376 work with the mainline MIPI CCS driver behind
the Qualcomm CAMSS on SDM660. Nothing specific to the sensor is added to
the driver: the DT node uses "mipi-ccs-1.1", and the manufacturer specific
register settings come from CCS static data (sensors/sony,imx376.yaml,
https://github.com/M0Rf30/ccs-static-data/pull/1, to be submitted to
ccs-static-data).

Tested on a Xiaomi Mi A2 (SDM660, rear IMX376, 4 lanes, link frequencies
500 and 864 MHz):

  - 2592x1940 (2x2 binned), 36 fps at 500 MHz
  - 5184x3880, 29 fps at 864 MHz
  - switching between the two repeatedly
  - cropping the pixel array (4096x3000 binned to 2048x1500)
  - the front IMX376 and the IMX486, which use dedicated drivers, still
    stream

Patches:

1: CAMSS calls s_stream on every sub-device from the video node up to the
   sensor. For a sensor with several sub-devices (CCS has a pixel array, a
   binner and a scaler) that includes the pixel array, whose s_stream
   fails with -EINVAL as only the CSI-2 source pad can be enabled. Stop at
   the sub-device that is bound to CAMSS, as the other CSI-2 receiver
   drivers do (ipu3-cio2, rkisp1, ti-cal, ipu6, rcar-vin): that
   sub-device is responsible for starting what is upstream of it. This
   touches the loops that Qianhui Xu's "media: camss: video: factor
   pipeline stream on/off into a helper" also changes; I'm happy to
   rebase on top of it.

2: The link frequency and the pixel clock were looked up from the pixel
   array of a CCS sensor, whose pixel rate is not the one on the CSI-2
   bus. Use the sub-device bound to CAMSS instead.

3, 4: Two CCS bugs found while doing the above, both regressions from the
   switch to sub-device active state: the format set on a sink pad is not
   stored, and the format of a source pad does not follow the crop
   rectangle. Link validation fails with -EPIPE for anything but the
   native size.

5: CCS static data can carry manufacturer register blocks conditional on
   sensor register values (rules); the driver parses them but never
   writes them. Apply the matching blocks at stream start. The IMX376
   needs this for its full resolution mode, which uses different
   readout registers than the binned one.

The pipeline is configured the usual way, from the pixel array to the
source of the CSI-2 bus (here the scaler), setting the binning with the
compose rectangle of the binner and then the size of the sink pad of the
scaler:

  media-ctl -V '"ccs binner 2-001a":0[fmt:SRGGB12_1X12/5184x3880 compose:(0,0)/2592x1940]'
  media-ctl -V '"ccs scaler 2-001a":0[fmt:SRGGB12_1X12/2592x1940 crop:(0,0)/2592x1940 compose:(0,0)/2592x1940]'
  media-ctl -V '"ccs scaler 2-001a":1[fmt:SRGGB10_1X10/2592x1940]'

---
Gianluca Boiano (5):
      media: qcom: camss: Don't stream sub-devices upstream of the sensor
      media: qcom: camss: Look up link frequency from the sub-device on the CSI-2 link
      media: ccs: Store the format set on a sink pad
      media: ccs: Make the source pad format follow the crop rectangle
      media: ccs: Apply rule-based manufacturer register blocks at stream start

 drivers/media/i2c/ccs/ccs-core.c                | 106 +++++++++++++++++++++---
 drivers/media/platform/qcom/camss/camss-video.c |  28 +++++++
 drivers/media/platform/qcom/camss/camss.c       |   6 +-
 3 files changed, 129 insertions(+), 11 deletions(-)
---
base-commit: aa0f4c41d4870a18e65772a1817af16427200371
change-id: 20261122-b4-ccs-imx376-03da25278f5b

Best regards,
--  
Gianluca Boiano <morf3089@gmail.com>

