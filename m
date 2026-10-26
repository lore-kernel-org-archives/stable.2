Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792976984;
	b=DYr7GNFepjC6jiBVOKoqdLMfXod6loR6SfwmBpgd7+VT50B10nN/kWK0Esq9v1XPe4rS
	 Jxt060SH2iuBBemYUcQU9bPorgemiWObaCNWs+hHxFWuvz76GfWhEnXCGtzMDxBV64UkZ
	 +ZR5cp33UO+qWT2qtS2B9JxE+epumfFts5v2c33yqRffTYX2wAhk9rz3GB1+DTKqPYjEz
	 tNX9P3jgUM2cJJeookCg13SxrkzLbYxxm3VhUPZLuRXMrFJK6S6kRNlXdCbaDJ7w1kOPW
	 nx/ffRBSXTWSl5IZHrVNvX43INRIDWJC0neWmhPL0Ig2Mwwy8YIPyqFbGOpFrks69ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792976984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=i6evN3+Ke0MX69bWlyygAZJMq2satdlGaiCf2WgHvX8=;
	b=N7jC3a4Epv75HVDjzsia7tHXhLS6jS/5djvydZGVmdV+Xm1Mb58+HYfeYJaq8ZalnOOG
	 t7bdCI3S6VgGR3CnRgyY/6IKMZ4ftivGItwU7onvQkuREkCSYUagm5ufix3DutXj07ciu
	 38ReJjSh8VDyQov3FtVIbS0VVw8lCg5d6D6D0pzHrf7VI04Pl0dXy1JnSor1/qFIkGw+d
	 g2geb6SyJG3In/GtynTWoEUsRjF2vD7k+oEKA+0CpCW3e23TL6GY0U+r/jnvYTFuro9EA
	 kn+j+5azFJ5tYIg0sPZoY5sMl4TaHFJej2uCY23ZGzLDLj/0QX5zWtJ1u6gExr6S66g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=MMk+k0CO;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E99606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 01:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2E99606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=MMk+k0CO
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53512cd2f85so27880961cf.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792976983; x=1793581783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i6evN3+Ke0MX69bWlyygAZJMq2satdlGaiCf2WgHvX8=;
        b=MMk+k0COyYmNm4YdnxYfC2ghljf4SFkUhbA6kOhdeg1cbfitG0EjUsLQQEsUWdh2mT
         DfisF8g8yCg2zHx3IasNOO7RoHrWYOPP6vcdds9StC+lsuj6pEzcWdILCdQbgNGYa2gA
         fiWfgn11b2ceufwdYy2Q/aKNdKRi3guSGdI+5531lVzJQMrxEiYtYM9XzQsCI0sgoBtA
         0SAZzsqwgQu1MOojO7vvZbQg+to6vbuYsUW3/bNiA5a27yiZ3RtFjyuvXX0S+onRwy+n
         DrhHSBrd6oFm3nt3UAb01Ka+25XOFLCV3zQMmrJj3FeDJPFc0wS8cAuNIgLE3yNxipaB
         JAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792976983; x=1793581783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i6evN3+Ke0MX69bWlyygAZJMq2satdlGaiCf2WgHvX8=;
        b=bDV7Y0ARSUBp7M9Yf9mfVT2yO0qU4BvQPkzjQgwp0HsLkCEix3vJXGBVwlT6Tpo1CM
         MSchCYUBwZ5Ss3NONDjY/ZClxZWMaDCbyUyMMv4iCbRqdGrJkxIYmgGvvhSL7yT8i65H
         +MoqmIO8qAchc/+WFxYj1xujLWsBk/+gFW6RFzZrcVprbS6M65yuWE1PNfzBR1F8yTrq
         5CHAL3NAzR2Ir0XAckJBOHfT8JRInkZ0V8UXkvfqnGq+7hmDX7UrrR6K/xuS0L1WxG4U
         4IyheLWXHOmXlE9ZoXuOPIknZhR7RoFONY8ij6FY3weQG8y6tdfxaMBQJTWBnU9RuTSI
         Guyw==
X-Forwarded-Encrypted: i=1; AKwUvBzs8aaCqDvbtwOlKA7QnuiXUvalB6Ly/gKS61ypxdtP/Ow2HJhiCTuMU3/sV770G4e3eKySEGw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLAj+GihOBDaoz6/g5FjlmQmEtPuatQWbt2/HrfkWVUQZh6R72G
	shttDuDaUwZj42Wr9PB5aMVgm8EXFDh+fVh3YQBaWdyxZdvM+Jd4yzIFFwiFM1BeQQsTdEQZaIM
	PqlWSrw==
X-Gm-Gg: AYBFou1ZLEGKCb+VHTTJvS6kw7iy6Fk5ZhDn475vaf/rXfYiHdmRiNyNWbtxw6qqEpw
	OvF3rnwZnb8nMl14cXpFK/ziiC74Nvpso0BOZ0qXxoNuwhlEiIo3blfnMYIF2jBSQPnEd8Q31gf
	OP7Qu+D3/Mn/NahysgkW+oHO7r6NtiW3bRr+w78ZyewDDGbi6brGHoHB4yu0+H0nLxLoW/re+wg
	/9S8H9RjX3MZBS4E8ZfMZwAJlYTvzxxpxFqzsybuOgyNvyI+m5ELgyu12e/2EZoZjw8OIoNIIBS
	q7k6L//USqmNZb5F/GaY+LHqO1tHxM2FoEeBtJjLQYnpKwnWFFsR3wp3XZAL/f1P565QtLnN1g+
	fI1LNdxxzeB8GALGVe0dOLIBag0eTKagaqJlifyP/hLQMVWY0NgUJdSe7yQQgD8FLMoFetmI4jk
	YkKquzUpYEg7Ii/CoGB6tIsSXOLdIhE/HnxZL/yP0PjNQWRZ1gOLgGeENP9LfvwzjlwAMtRFMWq
	yAob2ixXyv9kxE+TsOcLoHXRTy7PoFj6EjWA72ZvDIkDeenmH1vcl4Y
X-Received: by 2002:ac8:5f10:0:b0:536:8843:c2bf with SMTP id d75a77b69052e-5383b5f25d9mr84356811cf.67.1792976982790;
        Sun, 25 Oct 2026 18:09:42 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53839739ad5sm43892661cf.23.2026.10.25.18.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 18:09:41 -0700 (PDT)
Date: Sun, 25 Oct 2026 21:09:38 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: IgorpetinDev <igorpetindev@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: core: hcd: flush giveback work on stop
Message-ID: <4f60a287-f914-4b81-9dbb-d93528312356@rowland.harvard.edu>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
 <20261024155614.2732-1-igorpetindev@gmail.com>
 <20261025000643.425c57ca.michal.pecio@gmail.com>
 <CAG21Q83f_Oj5+-OPjFdxzmLWnFkjfYhY9ordyO0zoGtxkWEW3w@mail.gmail.com>
 <76dfb124-d488-45b1-9525-5369026b529f@rowland.harvard.edu>
 <20261025171019.49c9a66f.michal.pecio@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025171019.49c9a66f.michal.pecio@gmail.com>

On Sun, Oct 25, 2026 at 05:10:19PM +0100, Michal Pecio wrote:
> On Sun, 25 Oct 2026 11:16:59 -0400, Alan Stern wrote:
> > > > > +      * Even though all URBs have been given back,  
> > > >
> > > > but does anyone actually believe this here?
> > > >
> > > > Hundreds of drivers written over three decades, often
> > > > without linux-usb review. I don't trust them at all.  
> > 
> > If it's not true, there's likely to be trouble when the completion 
> > handler is called.  We could forcibly remove any remaining URBs from
> > the lists before flushing the work item and just leak them (with a
> > warning of some sort -- ideally, one that prints out the names of the
> > completion handler routines for the leaked URBs, if at all possible).
> 
> But you are now talking about developing a whole new feature of
> unclear usefulness (will anyone pay attention to those logs?),

Actually I mentioned two new features: forcibly removing any remaining 
URBs, and printing a warning about them.  I guess you're saying that the 
warning would be of unclear usefulness.  That may be true; I was just 
thinking that if anybody was interesting in chasing down the cause of 
such errors, knowing which driver was involved would be useful.

> while my suggestion is merely a small tweak which costs nothing
> and makes no functional difference under normal circumstances,
> but reduces severity of hypothetical failures.

What suggestion was that?  Using cancel_work_sync() instead of 
flush_work()?  Doesn't that amount to the same thing as forcibly 
removing remaining URBs from the giveback lists?

I still think if you're going to deliberately leak some memory because 
of a misbehaving driver, there ought to be some mention of it in the 
kernel log.  Otherwise, how would anybody ever know?

Alan Stern
