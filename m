Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794795219;
	b=vypacod4ZlbRWNaEeAlbA+4GDuLpHd1uutgzMP/ZBd0wKdDPN45hR5zPL8gi7IUM+Z1W
	 nggzSJUxCEA1IFiD3yLrdenGRepSKRDLBSuSFjIUMPfx8adCS1m5VQAs3eRtcRWDCvvov
	 FgzZ+NGms2z6LsVWdEiUpSGntXA78kcWBHOBOAlD9m9ZXWyboNomLFqqt1JGgDbnCZNwd
	 5Ey0HTHqq2VF4KJe8yT4x3D6AItlOuprVg1BgUWge1o02fucW5uaSiuJ0jECJJaDMttmk
	 oNy6D9MSdGZMqcg2kbqm2NZ6sp6x/yEuHhZYyjE1TO5o35PeufVVo3fL9gCzfYF9iqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794795219;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:From:To:Cc:Subject:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=uom7B3dmljcE5dgbhBFq073CCfa8xqWgFEsm90SeRkQ=;
	b=eDMM63QRzU5r5VSdWa5DAvzu4m54hrD7nAQVm6K/h9BsK2e5wcGkPlhENyiFiE65VKbv
	 R59IQc46+HyRCBJO0HZZVE/Ehkl8HXnBhQu/0vkmn8CBvnps8f0xJevOBlaRzmhKf9ajI
	 gQDgp2LwT4AgwmilHytc7gHQi/8g/oTvzEAHQVlzF2t7dmINICiTDRlm0VaXyjxh7bzO3
	 TL/XXq74OBbeIPgmmeqfA6fPArz0AaPae79Twt8AWE92Zw9Gzs7Bd4T9nCJo9ykLwcjpC
	 qcPRDkRlM1Ohy9wFwQrpyeSGUbr7rjov/ja9U/bEOjdat1xu6hUB88slKJRgDMvSXNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=FyqVxPRZ;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467A606A337;
	Mon, 16 Nov 2026 02:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3467A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=FyqVxPRZ
Received: from killaraus.ideasonboard.com (81-175-209-152.bb.dnainternet.fi [81.175.209.152])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7DD9C63C;
	Mon, 16 Nov 2026 03:11:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794795063;
	bh=0BXRXg7UODOKuM2rD1/JbijBaD+p9Q3+Qq2kMPYggPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FyqVxPRZn4cQ1oVgqaY2W4ZgnziY/cr7vY6VVQTkfYYUgC6KIJzz4jYdrkGvfeH5J
	 cvsjxy8QIzQ+KqvgYGCazQ7BEo7J6FVgJkaah6TYC5hEiVLC91ZYJUVqK+z8kY8Fla
	 0hydk5iyUkuj4cOEWWTc+Tb2e7mOyO96RXSjBXyo=
Message-ID: <89b15b01cfebb86185ec643ec6ce5427@killaraus.ideasonboard.com>
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sinan Turunc <enscrpt@pm.me>
Cc: Hans de Goede <hansg@kernel.org>, mchehab@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Reject metadata packets shorter than
 their header
Date: Mon, 16 Nov 2026 04:13:25 +0200
In-Reply-To: <20261115121701.189-1-enscrpt@pm.me>
References:  <20261115121701.189-1-enscrpt@pm.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hello,

This is an automated reply.

You have sent a patch or bug report that appears to have been generated
by an LLM. The commit message, code and/or problem description show
little to no real understanding of the issue and changes being proposed.

Such patches or reports require a large amount of work to handle. They
rely on maintainers to propose - and often even implement - a proper
design. The probability that the author will learn from the experience
to improve their future contributions is close to zero.

As a result, to make good use of maintainer time and keep the kernel
development process sustainable, your contribution has been rejected.

If you believe the change you proposed is important, take time to study
the problem, learn, and develop a solution without AI assistance.
Answering this e-mail or generating a new version of a patch by feeding
this reply to an LLM will only result in your e-mails being ignored.

Please note that if your patch attempted to address an important
problem, maintainers or other contributors can submit and merge a
similar or entirely different fix without crediting you.

Your contributions to the Linux kernel will be welcome if you genuinely
desire to invest your time and learn.

Thank you,

Laurent's mail bot

On Sun, 15 Nov 2026 12:17:18 +0000, Sinan Turunc <enscrpt@pm.me> wrote:
> uvc_video_decode_meta() derives the length of a UVC payload header
> from the PTS and SCR flag bits in the packet, not from the packet
> length, and with V4L2_META_FMT_UVC it copies that many bytes with
> memcpy(meta->buf, &mem[2], length - 2). Nothing compares the derived
> length with the packet length, so a packet shorter than the header it
> claims is read past its end, and the bytes beyond it - whatever the
> URB buffer held there before - are copied into the metadata buffer
> that userspace reads.
>=20
> An emulated UVC camera that sends an 8-byte isochronous packet with a
> 3-byte header and both the PTS and SCR bits set made the copy take 10
> bytes from mem[2]: the last four came from past the packet, and in one
> run those four were the tail of the previous packet still in the URB
> buffer (03 0c, a UVC header) rather than zeros. With this patch the
> same device delivers no metadata blocks at all, and the video stream
> is unchanged: 25905 buffers, 5958150 bytes over a 30-second window.
>=20
> The check is placed after the derived length is final and before the
> format override, and treats such a packet the way the function already
> treats a 2-byte one: it returns.
>=20
> Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Turunc <enscrpt@pm.me>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_=
video.c
> index fc3536a4399..25c3b8dc891 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1487,6 +1487,10 @@ static void uvc_video_decode_meta(struct uvc_streami=
ng *stream,
>  	if (has_scr)
>  		len_std +=3D 6;
> =20
> +	/* A packet shorter than the header it declares is malformed. */
> +	if (length < len_std)
> +		return;
> +
>  	if (stream->meta.format =3D=3D V4L2_META_FMT_UVC)
>  		length =3D len_std;
> =20
