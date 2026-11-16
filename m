Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837982;
	b=j7S8JKiCzPYv0PVvdxLWlfdZvXWEppFErIW9WXjvqLq5ZCDbF1v00uj8VSBYo0hw+DE9
	 20jJHhFy8aU/a6dWBeGRWNBy2FNnfkgJeqXibSjXQBruMGrIRD58VUcMSxlA58D6K0pVd
	 /yhn28p34rdWRiFg7wWIjgrkjXaCfqgQQm4Jx7EahFNh0afzQ1rDk+vOxcAzV2GTjvNsS
	 6mPoaY5dsgqb0EJjHuRaHgUsOUw5YQPQ+bDsExspmjje732I+B1jv1tgZPIFIPaCvi4+t
	 /uyIb8ELgvsA9vlFhd8q+wFEvFihYRcogctXoNuIBrFSE313Rs++RWK/WAsxC1rwtmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837982;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Op53iop0x9KGQn5UzK0UMZyNCNF/PCnLenmV1gMq4is=;
	b=UZ023FVzP+CGjqINshFPkXcsmj2g5o9dtuDy5VGZA57Vlt8ul/zB1IPDoGg4mBvBgNd7
	 nW3gwIXATAxxGFt8yISh9bygjQS3a5ohEQd2w4CMKAU9MVhdB0gevFibG/1mLWcbVcDQM
	 6I2zjp3U+wQ+RMKDgtSHq2H8jSW4UUzmFFamYWZJncMHpWaTMNGUVg/NADI3Sa7Usq6QS
	 Mharenyl8FZPpCDfKbNLK881/By/E8OUJi64J/6aEYQajeO3GNBnNowWtgk1UfPeRa+rh
	 Wc10vhA+C0amSid8uQyLZO2yS/t0KWWQYr1jYj/hEikVqrwI9kWzi/x6oZq+mlXHSMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=jWcMc7Ou;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53094606A33A;
	Mon, 16 Nov 2026 14:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53094606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=jWcMc7Ou
Received: from killaraus.ideasonboard.com (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D629BB5;
	Mon, 16 Nov 2026 15:03:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794837834;
	bh=4Tfr5brx3F//9PX7y4euUCW/dOuZHuLk5sZJ/u+ToEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWcMc7OugNny4HwAmWTkTh4VKN6rbQec6QNb6n0bglGKqS9XNs/gvQ9hwVPiH18jT
	 exgKMfgI6MWpvd2BFSNSQ+chGy6VVumzj4fHy+2vWTWd1hh+pnkztqPaPfxG86vHWL
	 OKZyQV2JFDSg64TxPdMlZ6KCX9L5PC0BcAsINOvA=
Date: Mon, 16 Nov 2026 16:06:19 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sinan Turunc <enscrpt@pm.me>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] media: uvcvideo: Reject short metadata
Message-ID: <20261116140619.GD1714298@killaraus.ideasonboard.com>
References: <20261116-uvc-shortmeta-v1-0-487cfe42fa89@chromium.org>
 <20261116-uvc-shortmeta-v1-1-487cfe42fa89@chromium.org>
 <20261116130839.GA1714298@killaraus.ideasonboard.com>
 <CANiDSCsuPhCyeFWSBPWauECVHQ5A0ySMSqvC7UB6W9ZR4_+iAA@mail.gmail.com>
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
Content-Disposition: inline
In-Reply-To: <CANiDSCsuPhCyeFWSBPWauECVHQ5A0ySMSqvC7UB6W9ZR4_+iAA@mail.gmail.com>

On Mon, Nov 16, 2026 at 02:23:34PM +0100, Ricardo Ribalda wrote:
> On Mon, 16 Nov 2026 at 14:08, Laurent Pinchart wrote:
> > On Mon, Nov 16, 2026 at 11:56:37AM +0000, Ricardo Ribalda wrote:
> > > The UVC header has two bits saying whether the packet contains the
> > > optional PTS or SCR fields.
> > >
> > > If the header says that those fields are there, but the header is not
> > > big enough to hold them, there is something wrong going on and we could
> > > read out of bounds.
> >
> > There are multiple checks scattered through the code for this already,
> > some of them causing the whole data packet to be dropped, others just
> > short-circuiting operations such as clock and stats updates. Did you ned
> > see those ? It's getting too messy.
> 
> Yes I saw them :P.
> 
> I can move the tests to uvc_video_decode_start(). The question is what
> we should do for non compliant cameras.
> 
> I would love to just drop the packet altogether (with a non compliance
> warning), and if someone complains... we can add a quirk or some
> heuristics.

It's always the same issue with UVC, right ?

There are only two options: dropping the packet, or working around the
problem. The first option risks breaking some cameras. I would hope the
probability would be very close to zero, but I really have no idea.

If we work around the problem, I would centralize the logic that
computes the standard header size, extracts the PTS and SCR, and
validates the buffer size to a separate function. The checks will still
be run multiple times, but the logic will be centralized.

> Will send a v2
> 
> > > Mark the metadata as invalid and move on.
> > >
> > > Reported-by: Sinan Turunc <enscrpt@pm.me>
> > > Closes: https://lore.kernel.org/linux-media/20261115121701.189-1-enscrpt@pm.me/
> > > Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_video.c | 8 ++++++++
> > >  drivers/media/usb/uvc/uvcvideo.h  | 1 +
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > index a92a986ab714..9cc5d83acbc2 100644
> > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > @@ -1487,6 +1487,14 @@ static void uvc_video_decode_meta(struct uvc_streaming *stream,
> > >       if (has_scr)
> > >               len_std += 6;
> > >
> > > +     if (length < len_std) {
> > > +             uvc_warn_once(stream->dev, UVC_WARN_META_SHORT,
> > > +                           "UVC non compliance: payload header length %u is shorter than expected %zu (flags 0x%02x).\n",
> > > +                           length, len_std, mem[1]);
> > > +             meta_buf->error = 1;
> > > +             return;
> > > +     }
> > > +
> > >       if (stream->meta.format == V4L2_META_FMT_UVC)
> > >               length = len_std;
> > >
> > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > index af8cef94ffff..59e23e55bc2e 100644
> > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > @@ -661,6 +661,7 @@ static inline struct uvc_fh *to_uvc_fh(struct file *filp)
> > >  #define UVC_WARN_PROBE_DEF   1
> > >  #define UVC_WARN_XU_GET_RES  2
> > >  #define UVC_WARN_QUERY_CTRL  3
> > > +#define UVC_WARN_META_SHORT  4
> > >
> > >  extern unsigned int uvc_clock_param;
> > >  extern unsigned int uvc_no_drop_param;

-- 
Regards,

Laurent Pinchart
