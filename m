Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830207;
	b=tPx0le6vIeTrZjOyNQh1EEhl0CN7wnLpsCHv4Zh0LzuWUr+ipVyLBByaSJ/3rl8fpu5h
	 CN3yYH/7NHBzN+4DUzp4CFoWyXshbVlMayUk21IGNHyD/Y9ttCLY6OTYE9zCu9aKZ0Q67
	 XVRnLinog8jrOSVBcJP2yOflSeatwt76rEOFxXOWWQKVFVANmX23A4Ki/pjVxnfp7f8Hj
	 RkXKJFHW/9zyxI3cyQO8+gL5tnGMquhlEJ2lssRgKXvJSEePirVrA+iZaAGLASLmS8dZh
	 NWLiNJBJ6JaECRywBscNSNZFsVdLHLNxwQX5iDz6Z31E5UrSfO1W/Pl1DvEF3+iHWoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=v0Pwk6CaaHvFgXY2gQX9zn/QUfhEytg331EKFMXCHHo=;
	b=Y5Ox0ZdvlI+0hteC5gamir/AmahlF4FA8R98HrEf00sf6aYO9nDnIcwhR3nIYCUMkfnu
	 ipS0FSE+f1Dg0U9f4ShZgl7YGvVdHJkkG66DKrrXxAn7Uh9+2rZBU2ET0NUyW0Bvyr8r6
	 xgLVIuI1JwcfbFUbhg5MJnR8yG51e4Fdq2jLil3aqgpTthUWkaL7RaY4CX5DowKPVG/mY
	 Nzwc9sSBQTZEcEZ4abfd3RvTwAopGXYJ6F8wXlvi/GrB6+IPtafCzAMgWJkyQ45O/MK59
	 A8U2uhAeSGK2VBmQBfQrSgBfbhOeWbXHlYsD8GlmoPU47vYVmEDRWGrkCDsmuJ9BGsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=K6QuAuQJ;
	arc=none smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB19606A33D
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAB19606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=K6QuAuQJ
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3acd523a802so33593601fa.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794830204; x=1795435004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v0Pwk6CaaHvFgXY2gQX9zn/QUfhEytg331EKFMXCHHo=;
        b=K6QuAuQJWUkxqikWrZ3j43wGho2vSW00MBfV6rkA7bNMYX+be0i+viVynRYuY5ml38
         YVrbqqzWKdh0m2MSTRvE//kfuLRd1oE46xlPusARo7KVc9lSv09uQD0wtKhsIsf93A+a
         cTQgmUbRpg7UUd1w+0fBDYzAjItWceeqPN+tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794830204; x=1795435004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0Pwk6CaaHvFgXY2gQX9zn/QUfhEytg331EKFMXCHHo=;
        b=0p5sv0dyXprPjO6JbOqKMw0gFafup4eWOnoDNr1zfKGeKewsSmWm/7g5C7QC25S9JR
         obh9Webt+0hW3Ib32BZlBGzi3fvY0vDn3RWzAyhEevU4RnbLTuuJnNsDiIOAekE619o9
         PG+HuwZs7M6w90AQFotvxuAY5Tpw06jAxPa0/NuXDsIsbYORdiw51V/sVlIu8tVEarfm
         xzDbTog0y2jBgBZYoKXvfmzDZ1Tq3o6CXPC/GaCb0IG3zXt5Dh6rz+SbzrhkYgMAoalp
         8CkhqX3H41qLshe8AnWGOmnuO6qQ8V//LEbtj+FSyFakfW0lw81pxZmmu/SNBQ2iezlh
         P0yg==
X-Forwarded-Encrypted: i=1; AL+hErFJ8P1PWHR1G6inob1wKrNhTwjIIGXHomsfO6+CJX1hKic2VE6m38qEku9/Ih/nYedDtjA/OxA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AAGVFvgpYqaalRmtDmTg5eVy9x7lLNnn/tj0lTWeGIrMEbKGo
	GROE0ibZd4cEJfi4Y29mwqHY2dY0i7Co2z+8ml47qKkCkCGnLpNwLVXaOG9VwVWQEA==
X-Gm-Gg: AYBFou3cKVC15L+ZIoqdN4R29COrrOQPk8R8ihsnrNY6kd98GxDfk0nXlQa463mJLu+
	E6nvbh23/2q1WMJjlL3m4f29/vUVEHi6bYyHKQCcGRyO78rxkytpVu+uMldgkYSerVfoXXvnkhf
	EH7H9rAUB6wsKgXLrc+ofgsFuS7m0xW6VbxZy8kLAvxP9jObhG2SslanEtoHf7o66vZNcck/q4T
	Mqwyt+B+N3oU9I1/g09gtaVkddQGEfle2CGn9ApNprOC3u2YP6b4sMGJn6DoxvPc1tUHv2vfgp8
	/udm2820+EeNyosLHnIHY0lY1nYqYWz6GS7cGZh0eOWJ9rZjhhoCnBGYkwVI1vEzXWYrZb4T0CY
	Ali/wuOkDvw2rZiiqxA4b1vOyYXGSR9Az1tzUoKJcl02mrEXy663FsY7wXE+BqyWAzyQnYyw9rw
	2wZ/iNiYNob/N7LJ3o7Lc52pfEIQx0VesYbWfuznGcJYcJoo6PgTw9yglpSEVnuZXr71xUdZ2m0
	cGpfZTL5ZzjhaN5cN79Zcq2IsAVYa+2Tye5Owc9uXWRTES6PD54zbPcV2OknEXY0oEoMEOPk0Ti
	+WWH8iPOF/D6+mAs5yb4mLCCPFAlOzouJQPZL0HtnyOUX5fzhC9PmkhHAooKun6p01cJlaqMiXt
	w+7QyN11TmA==
X-Received: by 2002:a05:651c:993:b0:3ab:2d74:71e with SMTP id 38308e7fff4ca-3ae2b4eecd2mr24839651fa.10.1794830204243;
        Mon, 16 Nov 2026 03:56:44 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712dad7dsm3183754e87.9.2026.11.16.03.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:56:42 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Nov 2026 11:56:37 +0000
Subject: [PATCH 1/3] media: uvcvideo: Reject short metadata
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
Message-Id: <20261116-uvc-shortmeta-v1-1-487cfe42fa89@chromium.org>
References: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
In-Reply-To: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, Sinan Turunc <enscrpt@pm.me>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

The UVC header has two bits saying whether the packet contains the
optional PTS or SCR fields.

If the header says that those fields are there, but the header is not
big enough to hold them, there is something wrong going on and we could
read out of bounds.

Mark the metadata as invalid and move on.

Reported-by: Sinan Turunc <enscrpt@pm.me>
Closes: https://lore.kernel.org/linux-media/20261115121701.189-1-enscrpt@pm.me/
Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 8 ++++++++
 drivers/media/usb/uvc/uvcvideo.h  | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index a92a986ab714..9cc5d83acbc2 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1487,6 +1487,14 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
 	if (has_scr)
 		len_std += 6;
 
+	if (length < len_std) {
+		uvc_warn_once(stream->dev, UVC_WARN_META_SHORT,
+			      "UVC non compliance: payload header length %u is shorter than expected %zu (flags 0x%02x).\n",
+			      length, len_std, mem[1]);
+		meta_buf->error = 1;
+		return;
+	}
+
 	if (stream->meta.format == V4L2_META_FMT_UVC)
 		length = len_std;
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index af8cef94ffff..59e23e55bc2e 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -661,6 +661,7 @@ static inline struct uvc_fh *to_uvc_fh(struct file *filp)
 #define UVC_WARN_PROBE_DEF	1
 #define UVC_WARN_XU_GET_RES	2
 #define UVC_WARN_QUERY_CTRL	3
+#define UVC_WARN_META_SHORT	4
 
 extern unsigned int uvc_clock_param;
 extern unsigned int uvc_no_drop_param;

-- 
2.56.0.679.gc527c65306-goog

