Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619534;
	b=MTHVJh+82jfzeFjQTTcrakcXYqPNARBFJtIwqTyP1qOzx1EOnzCNqGdeiZRFtGnSdHXD
	 FgVWnNbp5+6U/tgPCpZAhxOGup8JlK5QHqpbEvNqTsd+XuDp40L57sfancNLk3xePGx1d
	 YvQ/natN8YvVd9UhU0nnWezdwtrX1AdGvEvKilnC1sT484R7x9GuyE367SG0XTbuCkam5
	 NF2WlTttG/2ZwWpof6q9wMLb8cXNv4jsu+f0svd9uTiiX6nAmd0OTbcqzMLJ3hz4BPIwI
	 fTtzLiS9LADvSgXExbI+QSiTfcv94qaFdwzwt7E3DeHUiDz4k4qOCTNnP8TZHnc0kdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NdbVFyWe19281WK83tQAmEl+s6eagpmlGkk6wK3Kh5g=;
	b=zT4k7zc0Sjy93JXc05FpRZtLixvelS8qmCkuT+7H7AaMrJJ76Hh2S+BejKSsa7Wu38zf
	 iFwQ48xJHYRjfv0d/4kSSugLF3xl498Dt3uMmPF7DZzlsa+aBKpN9j/hbR9EeKxkq5p3E
	 RAhS21/Ikk1i9sTQB4eI4C7zgBKkedOVLhbd1nIuWV/y/pOBCIR/v6x/Wii1IH1L9j8eW
	 I/zH2iRSTdqcmX8pXCzG1JCyvKJ6TVEjnuZPnn/kzZo3q7lJ59MauXz3E3C/Mi0yRrhO7
	 0eRrnPXy7W9m9rtWAZ5OlKZNA+jM5mpwUdqowPnzG8DEaxre/YOFqOzdYKsm/NZezoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2KWPAxb;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F506606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F506606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2KWPAxb
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-48eee44b908so3435075fac.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619533; x=1796224333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdbVFyWe19281WK83tQAmEl+s6eagpmlGkk6wK3Kh5g=;
        b=C2KWPAxbKGhRgVIaDYf9Vv5PdOMEfQt3IAULiJ2iY1UWbLuP4fgHThSHI3WgToVdN2
         DDfEtPcYCf1PWPS4lmOcFJ4XPO+1vhu/gK51r7wVzMMivYZWVuxTsVdxH+eaivLeq914
         HWWfrovUKzYJifSX3seIqvW2g/M2TwMAdUJ8aGVAtc9i0GGZSIX7RgB60uvSQ0N3d+SC
         1hposu3sE5YA819kvdSUdqXgoJsbqNxQSnnRm2IKUizJ0VHmnX2BLXmcHKb1NPtkX7ub
         mW5k0l2lmJt1BJd3Gl4ig3gxGRZgOj/V+WrMCfqGOwR7ZvSZeXWbn77XffFzwHkrzKkC
         7P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619533; x=1796224333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NdbVFyWe19281WK83tQAmEl+s6eagpmlGkk6wK3Kh5g=;
        b=lmqAXMnqhucBI9xW3b8ybqD+MVHiEjvNQS9B9tO0tmD0XXoLO4ihDLcjKv7/4VA5iB
         PaXZwMkL4IAiIgAhgOtCe3oAjnK1tmU8XUW3i8FPZubvSZ2LQkfpSwnNgDDRFtdtxaFO
         JB+tZZIGpNb2o/MyDo++f/pYDklEnZWIyeGQJOxbA3NNXW3TZR1BedHnAhLREqYooAVS
         7CFAU5jnsU9PZdElHJH0uZDakPPDoW9Ii83onmNnlzRFRq7Z17aMlvWMse8LSXNvj7LQ
         DN71clFrnpddFVx76s1Nr24qzRuK74G4LGlbYYrIko8AmKk9Loow7YaCC7SMHFkdjcJl
         pbDQ==
X-Gm-Message-State: APuU4Z+Hm7vTI2P3xrgMjPuInckfTQ7QWRKkcOW8QVbqaFUTlOZ/EpVy
	wkn+6U8p1pgeONUhJjCmUTdWksasCmRcD5boZWF97RNBfmZdvDQBWmaRH+vO7gy8
X-Gm-Gg: AZFdTZcPQdZwlczsv7eafmDNx8gxgM0pZnxEU61XFZ9pGVIUCttN8Eyn1BOSrT2AScJ
	Q5PbyAulN1MuGjvFpGuF+uEwN+FlafCthxiQMWuNOPz5gzmQR3/300B4RmEwu5QYzBTX0/R9Nud
	dIBYuQFe6B1n/l/e+t5wJm3c9QkZMzq67iCvomQRdTEcdocfRzwgQye1k2ULSN5urZMKF/GBX+B
	utKdowP8Nx34ryVNoU0mzUrnNGKHr72lY/FfXy2Gl97BZhz/jlKHwmNElGLVapnSgf/VVmd3afQ
	CSLYx5eRIsPdi4rnoecRn+iZ9FqLzdaGnlgC7z1sjc0NQnquKBHkqv6tJYC5sFE5AfaVQ8hMeRq
	sa3SRDF17x7z+pi0mgVxfNEoliIDgKMw85N18LJnOlPDfGUsYqtTbm7GbNMFn0CBbhkPqdi8Pxq
	YzsqfSRBiO/yv9hzeEmZFa+QJ1yAzBVcT/rm6f+Ft4G5bS+zf4vB4vBLKgvB2vYoe7HrBdvCp4g
	eJGmnJfyDZBkeor0K8Ei2wCWMtRD+MJ+XZ0/cShguPsN7i+dZXynOwJGSOPnWf+BLiO64jrMNTf
	bal+z6SBm0RMCV0AynK5tHezlVVufOAcMNfuOFvgKWTofykAsPsQ5pjUK3pB2PQbPAqpQTlAEDk
	dY7SMDEuWkQQ93KXqg7WRZelQDRbPZqUqUlHoQZrJbNZf8elhB1U6lpxdC0/+w3H0VR22qwZ6wY
	m2In/XUK4FN31l9PJl+MxkIxqzXr7E6IgAVR6z6cDSqQ==
X-Received: by 2002:a05:6871:89d0:20b0:4bd:f503:b00b with SMTP id 586e51a60fabf-4bdf5223e3dmr10131992fac.53.1795619533091;
        Wed, 25 Nov 2026 07:12:13 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5b07d766sm16375442fac.2.2026.11.25.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:12:12 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 5.10.y] iio: proximity: sx9500: ignore event config writes that don't change state
Date: Wed, 25 Nov 2026 20:42:05 +0530
Message-ID: <20261125151206.341667-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112541-thursday-proud-9f04@gregkh>
References: <2026112541-thursday-proud-9f04@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b8ed9165906597b69a46fabf39ab41690721ebe8 upstream.

sx9500_write_event_config() adjusts the channel and close/far user
counts on every write, even when the event is already in the requested
state. Writing 0 to a disabled event and then 1 leaves the counts at 0,
so the channel and its interrupts stay off while the event reads as
enabled. As channel_users[] is shared with raw reads, those can then
wait forever for a conversion. Writing 1 twice and then 0 has the
opposite effect.

Return early when the state doesn't change, as
sx_common_write_event_config() does.

Fixes: 4193c0f1d863 ("iio: driver for Semtech SX9500 proximity solution")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ Context: write_event_config() still takes int state here and tests
state == 1; the added check is unchanged. ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9500.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index acb821cbad46..f7d3c3b547a5 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -551,6 +551,12 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->mutex);
 
+	/* The user counts must only change when the state does. */
+	if (data->event_enabled[chan->channel] == state) {
+		ret = 0;
+		goto out_unlock;
+	}
+
 	if (state == 1) {
 		ret = sx9500_inc_chan_users(data, chan->channel);
 		if (ret < 0)
-- 
2.53.0

