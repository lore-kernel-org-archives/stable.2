Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839244;
	b=Qs7msseg4s+sAk1NoJuEtowM27FkqglTnyTIaJtz+RLfHRaDsPUu7XsD1QSrt/Zl2NH7
	 jUlkEMNLYArsKPXsX83stCt521ZRX8GutiBJRiMO3Np0A1Igc45j3NvixbvokeiSJpqyX
	 nbnTc4wzcevr76Z/MjjedpB1jgIZldRY+SZm/G4EMU+WcUoCwW4nIc7hl/cgge95308Zs
	 fcpf0ZdVPvKILxwPB0VjlzfsKwbKk7Fe0u8fwRykRpxJnGzjGTRyoQSPTlJsKG3FTOVr9
	 pRU+r8nzKP2N17wrrDD++87HQSc2PGsWImyUr5BWDIR+5TuDdToiiEjezbiA3opjsRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=yZqYyYz6dpLdL8GHBDQVwB9zUDWf7FNjz92hLeD5y5Q=;
	b=UrJEgGoiZD83vWZsk797wh8WeaKm0l+IHpcCE7RNCZIBXL9tLo53lTH5JhceoEu2fAKb
	 BVRnMXE9WEr8Yi+0MeawABySR9kwpBcl1sCf7auKEmua3SX23lOlxFQ1qqS0WPmQTXnua
	 i76c+0wHFmu/5iWh/IllbjBuPwLLGOZuC3vzB/BE3yomJqeT9jZBIIT2n8ZEcavvscDAc
	 C49RT71+rPoPbjq00XGwqsWTLqNKJuiPaFjGQSg5ogUrfYw1KbvYL02P/HzuEGQq0LUuP
	 rTQy9i10Hw6m2YHmazhTHEhCCtsbGxwyLTN605D8lmtTxdRIbgxIYtKdjj0vtYGETXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZmHJNTVG;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53788606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53788606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZmHJNTVG
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b6b22be970so1222077b3a.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794839244; x=1795444044; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZqYyYz6dpLdL8GHBDQVwB9zUDWf7FNjz92hLeD5y5Q=;
        b=ZmHJNTVGRFaJxProFfNJwYaLRFxmkdQZY36U/C2KOVuwIXgVAHtTg01DCadocrHE/N
         tpa6qW4l/W88dTj8Zm5oWfGSgxhr4OQn/LfnYZ9Dd+V/nThWk/DO5l12U7iwqL2+0/yy
         PKtPwav2AmlPo9rOQXabORjyyOYEDRLZRfNLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794839244; x=1795444044;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yZqYyYz6dpLdL8GHBDQVwB9zUDWf7FNjz92hLeD5y5Q=;
        b=qEdADqfqeb8SysXu+iok2U2zK5i7DA+UZuG9vHd4wpRk+xl95D40m+1i0LfgRVFVdA
         9H+vgLdWGBr6Yob9UexwZ28DpMNQwcYWe8L/tSuoqThxFnYwa/KLjLR+5oOD3gyYGauU
         JjaAblz6LZDlE+oLcD0wBEjLo8tLJrg3g5LAgfb25LKOgaMUrHv3kD3a16TlyzCTOX1E
         XUrNDND73AMk3lwJJlD9fspHR7iDnStH/4e16nFTCN8HTeVHaCViLqxiKEQj8+bKElbQ
         Zw/iDYvJprycJV8Mz+BEA2I3u+59EpnnQEzkGmmeeF73Wd/2ZZ+lSZ5RJ1JG1HhbZxbe
         D7Rw==
X-Forwarded-Encrypted: i=1; AL+hErEbz+yE/5+KHw5jln/gkQim+k8Vbw2vnnN62bpLNcCPGmnkDR/6T8pEev7uwmZ0nW21ISo42l8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nQKzycUT+Tt03/QPXU5D1qIj5rKvJsA8oBHsa1qktgwyP1UeE
	LmvaSWy5lL21iH0rg0vBoHxOmexs1t+9PP2jTbQm2FkQFser6QQiWQWj46tzt7Il34n+1kPHBVL
	xsDtaMYdv
X-Gm-Gg: AYBFou1g/BjhXQ/d8Yu6kZflmTTKjabiFVAu/CorFK0cA2QsZVwW7AhNHOfM1yOegrV
	ALEupbP+1JCvJYGXASYk5aosCrMo2xkzq5vGNNUvcx3/TA4IlBOEOZARDeCn6gaBpLEm3PiPE1b
	v9tTTuma/TY6INGMoEefDwxI0boQDqF0ILKWXEDUDH+rC5fmaeBebfk8VxBmelw2Mi3GwvVenAK
	W2YPfFhyzATu6q7wj3AxHlfbm3JnSI06lFaW26MSbfm9XFEYonzaa775IcDH8MTs+OmLmEFtJBA
	J0QpDgVNRLSa2NY12sYj1kiGtzNIFMftF9F8S9LpAyGGs9lbEab6vlpkuVlxY8DTveoDtnSXDhx
	gh0Bx6CRQfHTyuJ/ocU5pg2qvvRswfCLakUtpgQE6JymfQ8mMj6qqPs/TQHlOig1dF0gEJf7Z9f
	7fA6L4Kl8vwcfEc3VynXn6aZfXcynov/dIf6GqI7lf88HNHVTlrD8VirL5Dywl7Z+2NbwJN0B3N
	T85FDfKVtuO65IQxFPPqxKV+V7PM4Z2fAu7IPXxPJb5PthRUZYHizrYFr6pi/tC3m+raIg9LuAQ
	uoqP/1xg5WT4n80eMqDz1I26s55ij9vmc/Gh8QYTlJuokz4qEiRMOmwhExE82DLrmQ==
X-Received: by 2002:a05:6300:14d:b0:3dd:d729:c62c with SMTP id adf61e73a8af0-3f7a95f74cemr9975526637.54.1794839243109;
        Mon, 16 Nov 2026 06:27:23 -0800 (PST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com. [74.125.82.47])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18c7575sm4419824a12.27.2026.11.16.06.27.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 06:27:22 -0800 (PST)
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so5246344c88.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 06:27:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGPnwsnTf90SMXv84LXXSDIAT99kYnEi2Ln3iGgGaD+/xnqhcWiYJkPJnJVbBVnYtum5inCIy4=@vger.kernel.org
X-Received: by 2002:a05:701a:844a:20b0:1b5:1a41:f3b6 with SMTP id
 a92af1059eb24-1b51a41f403mr6681578c88.4.1794839241010; Mon, 16 Nov 2026
 06:27:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
 <20261116-uvc-shortmeta-v1-3-487cfe42fa89@chromium.org> <20261116140114.GC1714298@killaraus.ideasonboard.com>
In-Reply-To: <20261116140114.GC1714298@killaraus.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 16 Nov 2026 15:27:06 +0100
X-Gmail-Original-Message-ID: <CANiDSCvitQJU+RTO0MLJgJLPK3BZVPHPcrtU_7iJygGRxKpCgA@mail.gmail.com>
X-Gm-Features: AclHuK9EY-9Q3Zcf3NUEcs1Z5UODzPpXwEEXxHoNI2jIHFloOBFHm9IQER-8PH4
Message-ID: <CANiDSCvitQJU+RTO0MLJgJLPK3BZVPHPcrtU_7iJygGRxKpCgA@mail.gmail.com>
Subject: Re: [PATCH 3/3] media: uvcvideo: Fix unaligned and OOB access
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent


On Mon, 16 Nov 2026 at 15:01, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Nov 16, 2026 at 11:56:39AM +0000, Ricardo Ribalda wrote:
> > meta->buf and scr point to packed metadata and USB packet memory that do
> > not need to be aligned to anything. Also, scr + 4 is a 16-bit field, so
> > reading it as a u32 reads 2 bytes out of bounds.
> >
> > We use *_unaligned() in the rest of uvc_video_decode_meta(), but not in
> > the debug print.
> >
> > Fix this.
> >
> > Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index e9be0a627033..3e3296ec5c65 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -1532,9 +1532,9 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
> >               "%s(): t-sys %lluns, SOF %u, len %u, flags 0x%x, PTS %u, STC %u frame SOF %u\n",
> >               __func__, ktime_to_ns(time), meta->sof, meta->length,
> >               meta->flags,
> > -             has_pts ? *(u32 *)meta->buf : 0,
> > -             has_scr ? *(u32 *)scr : 0,
> > -             has_scr ? *(u32 *)(scr + 4) & 0x7ff : 0);
> > +             has_pts ? get_unaligned_le32(meta->buf) : 0,
> > +             has_scr ? get_unaligned_le32(scr) : 0,
> > +             has_scr ? get_unaligned_le16(scr + 4) & 0x7ff : 0);
>
> I wonder if things would look cleaner if we introduced a struct uvc_scr
> instead of fiddling with manual access to buffer offsets. What do you
> think N It would look like this:

I do not see a big point in introducing the struct: we still do the
manual offset math and get_unaligned_le*() in the callers (and meta->buf
is still unaligned), and marking an in-memory struct __packed just
makes slower for no reason. I think it would make more sense to have a
helper like uvc_video_parse_stc_sof_pts(*data, *stc, *sof, *pts) that
processes the header for clock, stats, and meta.

Comparing only SCR.STC in uvc_video_decode_meta() does look nicer
though.

Let me give it a try, and if I think that it looks nicer I will send a
v3 with it; otherwise I will send a version of your proposal with my own
added personal and funny bugs.

> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
