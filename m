Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793248060;
	b=QVdGwH4uElnFM6TAU1+eOIeuoP9rNGLCYcFf+V+DVqwxAQZAK5d2xINW5JN90XsqFefX
	 JzBQ2lEyiGlEqdZQkwy75mSd6qD7Vhb1436odFNWXv9fdIOEXSIUrOJ341OZxCQf19CQr
	 dkz4GXAc23gaifK3OvIiTNWZyEwvZ1A5SfE+Va6OIMlxvYIO1khUWVOqORl5uKXIJDWZl
	 A26ALwPhWzLF03cwrhQ7ZGqDV2dct4imxROsgQQvOe1YILt/HEzW0Sv/yjdyqBi0VVBAw
	 vkJvdj5HBUNGflllN0sYTSnViqRoXs6dce0Z1AKooMv78dGseUScAIMppsH9nxSFpbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793248060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=92Ry8Npagaq/z8a8VQiLsTt0Bsh/v/B89EOMNxNHR6w=;
	b=xgwDLiovT7KkYXCMULSot0Fv1ATRKXmSbKDnn1lysN26X1OQj1kvAclav0jE8rt1S5na
	 N2h5oXUluWy9g0Y0fSBI6hyToVRJLKANVBRKKluWcFvO79NDoSs9JMD3qecdHuyDjR2+Q
	 Xbn1zClZgQmyjHBbQg9Zs7K+1k+k47H96FX7YdYIFRVy29H6xVu/ssTvTSI10aCeDArnU
	 wuisQyYrmxM1GLMRqwgFLx+cN+dkFn1EUkFsTWVR/B/Zi42HosgD3j7RwNC5Ec5N0ykui
	 xA/Sc5TQtQUvr2bg3MODFVGS36lPWju9wOc0f5xHjqgXz5KO3YeWP6W0s2Zcp1Y96iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmrIkzsF;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1C606A337
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 04:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE1C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmrIkzsF
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so162489a91.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 21:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793248059; x=1793852859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92Ry8Npagaq/z8a8VQiLsTt0Bsh/v/B89EOMNxNHR6w=;
        b=PmrIkzsF3KWnP0i6mMndM6dmhR3o55JdfGB0tKABw5xOAMyEwvboHP936D2DTSd7yi
         HsM3FXRiVwQr/fKIEPvhektnia9sU2G4HOSXZlnRsDBW/zTlfaKjVO9omxl649aBln3Q
         Gf5CYIqV+U+q+aVU2MsQTjNkBgrUutudp8NJsImyalHlZujeME9ABU1C+PiDotVLpLrZ
         FySJryJUdt3JLLZAmdCX8VzgS1G09ewoclj+1OQkznyFJY7832qOBBCEPFSaavjYbuLo
         mqfDNEEQGBHNnhBDG4BIApB8j6ug75eez0IFzQ/GzKQrcepcY19gu91AKaSo3n6IxaQU
         0W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793248059; x=1793852859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=92Ry8Npagaq/z8a8VQiLsTt0Bsh/v/B89EOMNxNHR6w=;
        b=DyXbmYUSB7f4QZo2FWJoki4pN1UaIBIw2tMxvRbl5Ir1Yw6QPPiOikOwOiKmgEJpxh
         CXWubTcUcC5/uzbEmBu7gQfVgeoYobX7cnE7AxOa7QjYlgAXKzfQOv7jR6sP1FOSluAG
         vgntkqy9lr+J5EvMiniS3V4GytyvsDND2rEgBMxuKg6OkZciVGdCaQi7xCZwmxAlAL5Y
         gmEkAdRMxB1K7fgpnd/4T5rpxqTuUhFzBnN4RhoSZtgP+m73RGf3FwpRgdvz5XrHn4Qh
         dipOWjHMtlmqb5p34o6wJrizoitVG0p46wgfndXcuU0LiVwcqM5xdV1EQPMnTCF6OYoN
         lpGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwugC7MJT4lHBiRJhnhZC0B8BNnCvyI6qHXRWL2uRbeACHVEZlMFSK15QQf6VlNmoCClnw3//k=@vger.kernel.org
X-Gm-Message-State: AFq9FYL+iWOPWkzE7GK42BZc58sVtWhTr+4Tll2YFtqDlXLOnD+grklO
	g6LOlwDczyFo8lGnHsb1vvCH9vQO9dWmQX6lNkAB1LxGWS6MfywrDZkKV7NqpDPDsmY=
X-Gm-Gg: AYBFou3//nb5t+2FP49YGuefc1aJevqbXcegWMzgZ9o6jTOow88GaBPt6gzcs404dxR
	CGriWQ+CskdX0kMAxqOL47/7t0i1e11CwmQwKZ1XEjwMZF4PnDNv7UopoDaOO41pw3sR6IuFnel
	7f9DHzJyfX/ZnmK8HvOj5oQoIp1Qs5ZzIIxImAQlk4m1YpiOHKp1iAbc23FN19sO7s1Xc2UPwbB
	N4bmHYCC0VWebKQgihFW4f3mDtzH6pShtBySl6Yobz3twhs/iMxAmAovMJCF5dZhFX1Z+/Wyofv
	TCesIa4hIb3wikICsXa2guZjEnlsXjlqXJwH3K5hXAcvAZzAOrSZoVAB1rw8+l7uwmbpD3puVKc
	ZZqz1SMEzRPfs5nep0fFwVf/BfG/xUFcH0vxNEyZa6XsPRCdIWaVlJAZF9EARKYpVCy1/8+wZvZ
	dR1YPjy+Do2SveEGzAujSgqg5n2xp/Cwai3X/LjQyRZDbM64SOXCuH4WJFFT0lldnlva3gMV9lM
	n2miZ6AY7M3yjbs21ZOWcv+b0NcqdVNNBltkdeWY/1z7naRusZWBztt+TSdb2rAF7zlD7tSPtdP
	UXx2bZt57HBqd9OOscbs99itxjuTS8fzI3gel4EibLBQf4Bk450gbk8=
X-Received: by 2002:a17:90b:57e6:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3ae6ed88ed6mr887736a91.37.1793248059222;
        Wed, 28 Oct 2026 21:27:39 -0700 (PDT)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e898317sm2010846a91.16.2026.10.28.21.27.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 21:27:38 -0700 (PDT)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	guoqing.jiang@linux.dev,
	gi-oh.kim@ionos.com,
	aleksei.marov@ionos.com,
	lgs201920130244@gmail.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] RDMA/rtrs-srv: Reject an empty pathname
Date: Thu, 29 Oct 2026 12:27:19 +0800
Message-ID: <20261029042719.75868-4-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029042719.75868-1-izaiahsun@gmail.com>
References: <20261029042719.75868-1-izaiahsun@gmail.com>
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

process_info_req() uses the pathname sent by the client as the name of
the session device and rejects names containing '/' or '.', but it
accepts an empty one.  dev_set_name() succeeds for it, and device_add()
then fails in kobject_add_internal(), which warns about the empty name.

Reject an empty pathname together with the other invalid ones.

Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
warnings.  Run-tested under KVM with KASAN, lockdep and kmemleak, using
a small user-space rtrs client that sends an empty pathname: the server
now rejects it at the check above, nothing is reported, and an ordinary
rnbd map, I/O and unmap afterwards still work.  Not tested on RDMA
hardware.

Fixes: dea7bb3ad3e0 ("RDMA/rtrs: Do not allow sessname to contain special symbols / and .")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 kbound
Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 56f0ab5a7619..d34a177f7ba2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -823,6 +823,10 @@ static int process_info_req(struct rtrs_srv_con *con,
 		return err;
 	}
 
+	if (!msg->pathname[0]) {
+		rtrs_err(s, "pathname cannot be empty\n");
+		return -EINVAL;
+	}
 	if (strchr(msg->pathname, '/') || strchr(msg->pathname, '.')) {
 		rtrs_err(s, "pathname cannot contain / and .\n");
 		return -EINVAL;
-- 
2.53.0

