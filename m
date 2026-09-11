Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E7371860
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120229; cv=none; b=OHtgQZNCqmuo1ZhkfCYKEVZe5PrZYFn5VMfSvZEAwPNOgYAiaiio3FlH6H8Kuc9BvOxv6OOvW5pQ/zVnnNQh87iraeqS7+Yt4QMR/R/O7byeFOeLyGemNEOMl7/dpnLxAboIY2U2IovLo+ECzH4QSb2t3T4Jzqsy72nObwVtHHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120229; c=relaxed/simple;
	bh=No71cd5buUUHeBE48TQG44YiouRm3taIpFkpoL0GdvU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FWf56Lxxl/ZDRgkCdZilR6lfKPoR3HkF9XmPZ8cN79DYUWIC3j4JtEck2iYpPl0z4fU0v5A+4bKckJJUhEUpvzPNXyzzLlt4iG2VbtV6L9NJriZCCQEUvtPzDJjbdtw5XfEzKn1y5c9PqBTfLJusuBP8iyq/+mkA3GDw1U8Ih6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=miewqeWi; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="miewqeWi"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3a4bef87631so4905381fa.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1789120225; x=1789725025; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hdzbs4lJ5S888JvEnLEEzWnpR79iP4hGYQ+NNaIqwIk=;
        b=miewqeWi19LXZgrZS54WPwI3F+kFKrDhmNZl/OVZnMLPmPvUbNXxJw3Kk4GW1bhSRG
         FT6VBU4+IHZ4eKF+heZqkJTqXtnzbpD95u0sfsVLrjtLInRzhOEZsGIODO0Ox0QaK7Ur
         oBEL90BLETJou+W8Fc+mGgXxWyYmqNsUnH1hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789120225; x=1789725025;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hdzbs4lJ5S888JvEnLEEzWnpR79iP4hGYQ+NNaIqwIk=;
        b=hK4XCeNm8vSDOfiLeogKrYmCAG+MyUVgj5ywPkTIdkLrTdR5PVNBU/ZHHnBeTWk9Mb
         q53CKirnhcKIc6CKMDmaWN+Lzp3uCcM3cSOwBCkduE9PgNZju154U83XQfDg4RrC5Nu6
         4zKMNFGcbe5dO8e2QHrPnLw2a5roZBFTKNC2zq3Ymq6N3MqwbvNOf1R9PcAEjj9yz21s
         IEvms6TD/bx1jJVSt1BKAWiSc7+Cqd7WoPEVdmde1OXBj7jT2ILvqIrmW1JDjyV6EzF3
         mG0ue9rp8jxK8IJNlXq4CUb5t0VOr+sXwoqnhUCeuj9YyQ+KZDeELmGkY40+q1p/Rhu2
         UWbQ==
X-Forwarded-Encrypted: i=1; AKwUvByLKPkZ8OHE86LGZs1QGywmx/jXi5kSa8pyNnIxTOpOoGivhinDqxEKyFq0sppmVV8EwL9D5Ro=@vger.kernel.org
X-Gm-Message-State: AFuF++kuY5pNJfBBpUeWfrvYf/ky1a3gbFxz6W7DmeQKO49JsYn/lpyd
	+BZniTjPUWx8x3k7kVfESDOR5jyAMFioz1lucdwhujPcCL2iHnhijghRqV99SPPXkw==
X-Gm-Gg: AYBFou1/0BMZngcnPluBWxKU8grs0UVSUtXvq6blOyw/WZMy1mKozyl5rgdoXRSaLkp
	kyKa78FwLmd7e6Y5UOzcYrLxjw3vQd97goTN5Q/AuDRXbx5oNuzmuh0JyAh4BNT2yQzA+HsA7Sv
	DsnYIQOLAXv74P40OsTsH7raGgOodLer5whmfKTLAWgTaCqh7XmZ9bVZ96vStMr2hMtVWAKe1DF
	TYxBb3RgFYBKCfUvZw0hzltOLYDtyWOthszRutvxlVF1IMTQ/kM5IW3hYmQ9Yivy22CfOsDv2Tz
	O0uU+4ZfMBA2myG6I8JB+TqRLNZCZ80LsSlxBebH0WDixMD328NAKdAmNTr9p8hAUgQtgtmtqoL
	RClz4uhpSRzZJsGTr57JCngmE2jk0aBw3J/HXovu8P0JDb0C6W11/VuytN7zaNGLm2I2skxfoGT
	XODMhCuCrnS9YrqgNRhq82W/sRbAxxAoq1+7crHNg0yZZDhMx7Avtxd7kOmywUIpvd1K+ahX+Lf
	S/Fl8+vK/95uUTBtOqu5TbGGmd23XaNJEzN1wTXWX6G/siZSg==
X-Received: by 2002:a2e:a551:0:b0:3a3:7741:b43c with SMTP id 38308e7fff4ca-3a5a5082d76mr3491941fa.7.1789120225152;
        Fri, 11 Sep 2026 02:50:25 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a33263ebsm5138231fa.17.2026.09.11.02.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:50:24 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: uvcvideo: Automatically handle invalid
 uvc_versions
Date: Fri, 11 Sep 2026 09:50:21 +0000
Message-Id: <20260911-uvc-version-v2-0-395f27b0444c@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN3Oo2oC/22MOw7DIBAFr2JtnY0wJt8q94hcWLCYLWyiJUaJL
 O4e7DrlPL2ZFRIJU4J7s4JQ5sRxrqAPDdgwzCMhu8qglT6rm7rgki1mku2HAzny1nRXYwmq8RL
 y/Nlrz75y4PSO8t3jud3W/53cYoudIXNynpRx9LBB4sTLdIwyQl9K+QHsbC9MqQAAAA==
X-Change-ID: 20260907-uvc-version-aedefc4384ce
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Edwin Gatier <edwin.gatier@protonmail.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

This series changes the way we handle invalid uvc_versions. Instead of
just failing it will try to continue probing.

Now that we are at it, add a quirk to fix an Avermedia device affected
by this error.

Why keep using the quirk? Because I think it is more correct to handle
them that way and the quirk system can give us an idea of what vendors
are more respectful with the spec.

Thanks!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Add quirk for Avermedia
- Change the way the compliance error message is printed and cache
  ctrl_size
- Link to v1: https://lore.kernel.org/r/20260907-uvc-version-v1-1-34e45dfe04de@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Force UVC version for Avermedia GC515
      media: uvcvideo: Automatically handle cameras with invalid uvc_version

 drivers/media/usb/uvc/uvc_driver.c | 22 +++++++++++++++----
 drivers/media/usb/uvc/uvc_video.c  | 44 ++++++++++++++++++++++++++------------
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 49 insertions(+), 18 deletions(-)
---
base-commit: 27953c044974baf7e24dee3e9342fe0103dea80c
change-id: 20260907-uvc-version-aedefc4384ce

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

