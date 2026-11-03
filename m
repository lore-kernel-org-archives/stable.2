Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712151;
	b=2v2rMBMuo7Mevh8kfZ9imZdBtkon2QKMK6xgm4+g4FPjNSKQvBg3QCTvdxWv8bZBG7T0
	 9BJP9lTlq8iYGd4ZGV96hl1GDWN8eZijHHD9s+8FRWhPtcJ/sTSxrDKhlBmOIRz7mm+XC
	 E2WW6WT25gP/cx5GVJoXzBUo+U6EXF3qtWfOyaQw3XGndZrPqMrgq6CaVCdFTfybnBJkA
	 907UVkdxoD/y+KROFQVoRhl+RMtKWfMQzxGx/1a0hzphEaBPgzziUkvdICucP1r7nQSbx
	 yKk4e/NlEiTwukey5bgVlRcXiYTCPF14iwEZHArudbV6zXA9jBGQGASUIsXx+cSbohA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712151;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZO15Wpi9ERhHWGfexIrXUF/h1fo5dyIH9P5nUF4t1yQ=;
	b=gphxZERXOoYb2AxPiaK83ooy3Q9R6BfloDNaA/wPNhq8FbFUplOkvZHqir2m2QYoLiZ5
	 Y3EOnyymk0vT+n0jRVYJxZvootk1L0UmrXCzldvoJN5TcQuQAHBhONLUAL1ikMd1JGGmz
	 BnchUMzkEkls4M4MPTutjY7nEmYjNe+E7sNWI7TdCJy1dGxCOUvlPwwsPNAuv7thsU6QL
	 0UBYgg9//XxIw5CzyF0L/1GeZuDOmKay6ecImATu+YAfdw6U3cJsxLTKFdOGnF7O7r62k
	 MCeTj+yQ/da/Xfhej5xzBkIqwQYt8o2BfUbfSs0EX1yIY8+fVZ/MiiP0yXzDZiDHO4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=hFn5Q9UN;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98048606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98048606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=hFn5Q9UN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793712147; x=1793971347;
	bh=ZO15Wpi9ERhHWGfexIrXUF/h1fo5dyIH9P5nUF4t1yQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hFn5Q9UN4acnKSncmrnd3yfY+uI/TcYmWgP8Y/RilS8cdrETAyed/0p++h+Ekr7lV
	 eORBgcH2zCXBLbgG5wj+Tr2LHvansoxi7E9lAD6VhR2U7+/lA4RKBVCqFBvGOEHgm/
	 9k88zueHdttM4BAz5RZ2NEY2W87ZrpQmz3WWSk82BqvzoswrGLmTaerTJAYGtduxLU
	 kIrlTWxaA67pKUkZBmaMiVk5ROAQXtHBj7QI2sYX7VOqQLNxh0ZNUq57QHa1nG7ST+
	 Hs3YNQxuNIQ2SRrLJRVqe7wQFFwgb0IGMCzWs0+VXiB7QRHBkTYd53WZeT3oeSmlwI
	 kkwUkxAXSTTrg==
Date: Tue, 03 Nov 2026 13:22:23 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] ALSA: line6: Bound capture copies by the PCM buffer size
Message-ID: <20261103132205.675-1-enscrpt@pm.me>
In-Reply-To: <sashiko-outbox-195233@kernel.org>
References: <20261103120723.328-1-enscrpt@pm.me> <sashiko-outbox-195233@kernel.org>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: d4340bebf67f51a740dfad832b5337d9ef0e7896
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

> Does clamping frames to runtime->buffer_size here cause the capture
> stream to stall whenever an incoming packet exceeds the buffer size
> (for example, when a user configures a 1-period 64-byte capture buffer
> of 11 or 16 frames and receives a regular 44- or 48-frame 1 ms packet
> or a larger USB/IP packet)?

Yes. Clamping frames to buffer_size adds exactly one buffer to pos_done
and then subtracts it, so the ring position never advances and the
stream makes no progress. The same holds for a buffer of exactly one
packet, so the bound has to be two packets.

v2 takes a different approach: snd_line6_capture_open() now constrains
SNDRV_PCM_HW_PARAM_BUFFER_BYTES to at least twice the larger of the two
endpoints' packet sizes, so hw_params rejects a buffer that cannot hold
two packets, and line6_capture_copy() keeps only a guard that drops an
oversized packet with a ratelimited error instead of clamping it, for
the case that should no longer be reachable.

> Also, fsize is not read again after frames is computed at the top of
> line6_capture_copy(), so is the assignment to fsize here unused?

fsize is read in the single-chunk branch (memcpy(..., fbuf, fsize)),
which runs when pos_done is zero, so the assignment was used. It goes
away in v2 with the clamp.

v2 tested on 7.3-rc7 against 1024-byte packets: a 1024-byte buffer is
now refused at hw_params with -EINVAL, and a 2048-byte buffer streams
for 30 s with no KASAN report, with hw_ptr sampled once a second at
positions 0 and 256 inside the 512-frame buffer and advancing by about
450000 frames per second.

