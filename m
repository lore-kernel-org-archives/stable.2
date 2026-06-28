Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035F30D41A
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782674472; cv=none; b=qOxpopmz288FLDZiG0w58A3t82nDVWKgBGVQqwuFdqndADfx9XOxNpYi8OKdw/qM+fnLaayteBulc1h+LhBBFt16Lmy7wOV1rzS/NRJzY+cy3CpWKJH1vw+RFJJidQYIkTEeWBN4jLZV/QBxdIjG5CCzSQRPAgpACiOFF5hirIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782674472; c=relaxed/simple;
	bh=WemZFKGQNzUQjFtR/GuiIm0PbNiG5Vr7xD+zliPgDkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvT4kfiv63z+xo1KxuOOCBaXL3LUuw2CizDEeqGmPi8WiXCIRi5P9jREO25ef4aKrUuyYRtQnJsNGpATVo9H/QG2ocKxsMBK+gSGGKeS5gnvVCwkC77a4RaOAExu96fLG4y52ct/x4mkCvOgcs2erbbYioJ7i0HgkeCab5MPgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=bl/SerZj; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="bl/SerZj"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8eb1a801df6so16387526d6.3
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782674470; x=1783279270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B3nWEDPzWp1hYdBxyiC5oBoK1fd906Y6w7ZmA+S9t/o=;
        b=bl/SerZjZL2mGEx7l3As7519OYBCc9mR0rUwOvn+Y6DRdZNqL8Qmp+NsmdwaJe0zKW
         10EQpUpu2cFyVMm4JuK+MicZwyK128CTyhJbX6amuFBPL5qFgaHEXVuj+CeR/i8GA1tM
         a76Bsar39cL6RwQ8Z6CPSN8bKNEGyqRGquQlo1iSIpoHCWhzn7YL17dm6hw22jOT0GRC
         sZ0g4oC9rjHk0PAUS43hYqxeudYV2kToyIqniJU1CgIG+sbt2bmjf3bvaut2BG1TNOJh
         3qgKow6jsYnnlDAifyUWrmunOEz2CAuo9hE5JFFP6ZCc11VYtAALdKLOLv8rYSfZv6Lg
         AA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782674470; x=1783279270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3nWEDPzWp1hYdBxyiC5oBoK1fd906Y6w7ZmA+S9t/o=;
        b=qz1eYI5ZTP6XNOTk9JU/Iet8JIfn3I56FV+yAbTA1LUrNappf1X6Aduxxbru7ck16K
         nQDM9F5s/N+efRRHFMQQJprWfWC/a7SKt/H0yVccySyDc5UZC0QamXkVVif7Ppykj0P+
         lp8ylm2gHWl+oFpKpiPrIC4Oi2okZ2dV5l2vtrWs/8ZnyG1P4xndULz/OvTecqa0zqKG
         GXEs+PCF9xe6VFpHXGjNL4IfqKoiLHz+tfvEaARF6iachgNNfdOonGxtJAze5hx9Bphb
         cjjNlr4LgIxnzmqseDgAW8PZok9iFE8MsqN85cU9Cjjjc1Rmsxd+cs0MJzGz8+eBOcd1
         Fr5w==
X-Forwarded-Encrypted: i=1; AHgh+RpL5F2MR74JAGPZGvHmD6JrzpLVk2RftS/tUNe8Jc6QdTkkqwowBiJoUE04KDlMzXtlqAON4AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKW63GtvZvV4TDj5KFFgRYjf3ALpGlxyA6eQG8BG3xSVIkjtm0
	dATENGT4hAdRiArdWPuhhjKjaHPSJUxQecsks3k6cVdz7/epms+1vH2mV/+OJ/Vcrg==
X-Gm-Gg: AfdE7cnhfuUli6ey3794yGzULOZ51UkJQigJH/XepyVeRZSS8+ozm/GRfLoXIsbaMWU
	sq7EpVo5HW7YiiLA0sveutKd+yBXdXFrVGTcHW8SvEcB0NJ3sgavUAdg01jfipmmTeDC/Gb9njx
	cNY25OzvMabOONgI78OTVKHCr3u0dnyfK3KmT32CBxbodBxKbRrmsjzhtbAerdjfDWsC9r/Oi/O
	eJshuV9+og6MV4u8953TCburo738i8XM/EZoo820DhclP2dfe9IwJ/W081fF76tIyMSxqwhRFWT
	M5KhK1VB10tJRDNnvbcx58fUr7CVrbarjl+50JbRAx3rewOMjWNlyy9s6n2QpakpV0RcQhlI4cI
	lXWQS+XM6aX9NCF0sOQQeksABc5g+XyAMzTd6jINdwtqGRbG84CXid88qQiYqU0Q2ZPLq3smxS9
	04WGg+OnEcK3Pf1tGkuixwe4g49VjDHSXwXNY0PY3/tgc=
X-Received: by 2002:a05:6214:2aac:b0:8e1:8ade:2e9c with SMTP id 6a1803df08f44-8e6d6d608ecmr245875396d6.37.1782674470545;
        Sun, 28 Jun 2026 12:21:10 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f019d47704sm8164636d6.30.2026.06.28.12.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 12:21:10 -0700 (PDT)
Date: Sun, 28 Jun 2026 15:21:07 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <40d36aa1-4926-4c0a-9511-7e7aa445c65d@rowland.harvard.edu>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
 <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
 <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
 <eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
 <CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com>
 <02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu>
 <CAFgddh+dEgtJf=3rL_48x5aQx7q3FH20CAw-50J32JOJCYdtMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFgddh+dEgtJf=3rL_48x5aQx7q3FH20CAw-50J32JOJCYdtMQ@mail.gmail.com>

On Sun, Jun 28, 2026 at 10:01:32PM +0530, Nikhil Solanke wrote:
> On Sun, 28 Jun 2026 at 19:25, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Sun, Jun 28, 2026 at 11:53:09AM +0530, Nikhil Solanke wrote:
> > > I need some help with the USB_QUIRK_DELAY_INIT part. I can't figure
> > > out how to make it properly work with my patch because of the
> > > following reasons:
> > >
> > > 1. I don't want to move it to the top because, from my pov, there must
> > > have been some reason for placing that quirk where it is now. so i
> > > don't want to mess with it.
> > >
> > > 2. Regarding my idea of adding a condition — so that it doesn't change
> > > the behavior when the quirk isn't set — if the full configuration set
> > > exceeds 255 bytes, we would have to issue a 2nd request. In this case
> > > the existing behavior would be more justified.
> > >
> > > So, I'm a bit confused about how to implement this properly. Adding
> > > yet another condition to fix the second case doesn't feel right to me.
> > > It would look unnecessarily complicated. I would appreciate a bit of
> > > help and advice.
> >
> > If the 255-byte quirk flag isn't set, do the delay before the second
> > transfer just as it is now.
> >
> > If the 255-byte quirk flag is set, do the delay before the first
> > transfer.  If a second transfer is needed, you can do a second delay
> > before it or not -- I suspect it doesn't matter.  If you want to be
> > safe, add the second delay.
> >
> > Alan Stern
> 
> Ok thanks! Just to make sure, because the change I will introduce
> won't affect any existing behavior, these changes (relating to
> DELAY_INIT quirk) won't belong in a new patch, right?

Maybe the best thing to do at this point is to assume that both quirk 
flags will never be set for the same device.  Under that assumption 
there's no need to change the delay code in any way.  Just add a comment 
mentioning this assumption to avoid confusing people in the future.

Alan Stern
