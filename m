Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794745044;
	b=xBFeL4C/sweuABqsns0pRtcViZoKwcoJiCxXiOUSoFgT5uQSpr+pZwV7fJyfC1U6wC1U
	 JVCJe/bI6656OdY6luCTXUkTs1W3Lg4lTYGyuI/X1cHOOYOJZjmYb6qwl8k3X2ulbzzC4
	 A5Xk66kqTDKqlhlHYUoWWhEJ8EKTaozlM4WlVzbC0cvBon+FvZslaeHjnFWqkGD6fOEqo
	 CUiPzIby1XOxPnc1xC9URCKRitmbro0sUEDfrp4tHqREutK7VHQQpNhQNz1H+7wqkkuKC
	 +XU+XFT3jeF7Hm5CULvztO+bwOEe0OetSm4hwBMhImN9qKXyQpbK2NpJUgzYEWUzUNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794745044;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HSieq9Kr+Lv0bYY/t7jT+oYMzlrXjrzzugbFbs8ONwc=;
	b=jIUOiLaouHh6vtiDVOFqIX/OZqig4vV1hLgnWdb6c9e7B4XY9FAhfJ7e3orNL6EPl8oR
	 eQYk5xHpYLgupUBmdbh3NDqIaSkzHupXLPjtsG7hYT97l+bJeltnQ5nsqSXaz6/+pgb2Y
	 95WAecYVA60CmONQQCRGJcGhMjNzZIexvow6AepAt8NvLrLRCAfXJmyE7oAJRMzQjIb05
	 PeiS+6gnlRhpgVzWQuFaD6t84vJJ35Ux6p7QHtbND5jCvTUGUmX10fliK5g4l/awMMUU/
	 corwjIlLE6NuIfkO7e5PPfo3aTcsXVSDD5bQ/lQT3a+ZCRJ51xwAKtNU3fOqDkoKUPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=qHosZlD3;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0FA606A31A;
	Sun, 15 Nov 2026 12:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F0FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=qHosZlD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1794745041; x=1795004241;
	bh=HSieq9Kr+Lv0bYY/t7jT+oYMzlrXjrzzugbFbs8ONwc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qHosZlD3yVZ9fwvUmnc4hfYPPKknoMo9NJSXNny3jkXABONJ40LSeOYArWVnNLGvC
	 ZxmOIOj+tCr9T232p+NDo9yqKtymaCu4h0r/c6E5PtO/4U2oD58oVfB5MpriZtw90o
	 8tFaNRmgewnUHj9qlxoSX7qL8cvhX8XNUjmsQ/QI6boI+7psrxFazOnq+dHK2IlNRd
	 gMQ57C/5yNsHs8IvmCJuO/SSah2Xi/H9be4BlDcpVoMMv7+bvSeBqSPWi2XQ0D9rPm
	 9+zH/0RkU9or7bRIFv8kbyrnUKvhn9/4KU604S7VH4Z7qlm8w7t0cnTlGNnTIPVxBF
	 JOP+xT4vz+gyQ==
Date: Sun, 15 Nov 2026 12:17:18 +0000
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>
From: Sinan Turunc <enscrpt@pm.me>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] media: uvcvideo: Reject metadata packets shorter than their header
Message-ID: <20261115121701.189-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: ae5b306e35375055db343d5fb860a0a83e2cc56b
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

uvc_video_decode_meta() derives the length of a UVC payload header
from the PTS and SCR flag bits in the packet, not from the packet
length, and with V4L2_META_FMT_UVC it copies that many bytes with
memcpy(meta->buf, &mem[2], length - 2). Nothing compares the derived
length with the packet length, so a packet shorter than the header it
claims is read past its end, and the bytes beyond it - whatever the
URB buffer held there before - are copied into the metadata buffer
that userspace reads.

An emulated UVC camera that sends an 8-byte isochronous packet with a
3-byte header and both the PTS and SCR bits set made the copy take 10
bytes from mem[2]: the last four came from past the packet, and in one
run those four were the tail of the previous packet still in the URB
buffer (03 0c, a UVC header) rather than zeros. With this patch the
same device delivers no metadata blocks at all, and the video stream
is unchanged: 25905 buffers, 5958150 bytes over a 30-second window.

The check is placed after the derived length is final and before the
format override, and treats such a packet the way the function already
treats a 2-byte one: it returns.

Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Cc: stable@vger.kernel.org
Signed-off-by: Sinan Turunc <enscrpt@pm.me>
---
 drivers/media/usb/uvc/uvc_video.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_=
video.c
index fc3536a4399..25c3b8dc891 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1487,6 +1487,10 @@ static void uvc_video_decode_meta(struct uvc_streami=
ng *stream,
 =09if (has_scr)
 =09=09len_std +=3D 6;
=20
+=09/* A packet shorter than the header it declares is malformed. */
+=09if (length < len_std)
+=09=09return;
+
 =09if (stream->meta.format =3D=3D V4L2_META_FMT_UVC)
 =09=09length =3D len_std;
=20
--=20
2.56.0


