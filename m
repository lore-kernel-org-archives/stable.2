Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283695;
	b=PbyBcMWu1Md5dJ7T21hszQBNUuMKirUbRO89M0XUlAdwnYHnL6YdwsDpAxcczlbSfy4N
	 xc6Z978JdH4v71GLajeddV4DFEy7pt7NIj/nLAWqFYUEIIw81F9uHrvnLi0HNJYvHa8mH
	 q5LThcs5lFrHVCbzZXq9El8lsthKkCBWlgVQwchNxDwx+2MumDOj25XXIb29MY7cQrym1
	 q7dhexvXvm6BCRbwuTaYVudtZHhpjP0+zsden9hh3AJxbIKi6mF762CLhQTMHULXvjkyN
	 wu5sDqHtCn9XkxAFr8vX/CmsaFVcfGCUjIaDVN3zGnRgsqk4EszWwGOzQe9JohJQSLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4PgsaR4ckK5t3xF1DMntq3pCLZ4hCM/y/z/GhVyNqpY=;
	b=T2B0HdVhFwOrxnm2wuL64ix6JQ+fdKquYmax7It7P+19d0IuwYd942T+Y9KkZfMPa/Sl
	 pecJfrO9eyomrsBplWNCndbWu9SScrwDfpfhDLk2Bu6DSS67r2+CHTDIWdbut/AnbiK06
	 Ak2AlhilDJ8VLTQeHU3jpNEq93rAakMkbJOiGrjzkPXgZ0VuQaUGagIzeRj4r70GzbD3K
	 Lg/10w2ZL1bSb4Rgf2S7MRe7FrMpyAZGpJcMuXmlUVzr/ebJuF75L3/pInWfQwS0GpEUS
	 3mMM+luHBvYyYOedm8Jwh4w9dAkbTUGqyg9BLE09bJJcRrVIO5mykTyOFEwJldsIpHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=GNvHvBm4;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A2606A93F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 543A2606A93F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=GNvHvBm4
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53381e53b80so25772961cf.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1793283694; x=1793888494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4PgsaR4ckK5t3xF1DMntq3pCLZ4hCM/y/z/GhVyNqpY=;
        b=GNvHvBm4mMgh7rz8MsEf+usoEGfQS12MNY4qTikdK3l8nMefZobclBwbgYCNCHbMRQ
         18r86okFfxWendn/mBrUkDkjHO37BOSuwRAsYQaRtd+NFSifDxKXg2ZcgS7OBd+Diuu7
         qNpKS5+EyEvAq9qp9ijq+AOZLvmqvNN4WerwMjlTU/UTZkLC7iEryT7UqHm7xc1W7XEi
         zgUA+k6GBxsSqpo34PK8gzcqe2jesByU2cRcDnWENUt+95+Za2l1q1WjAFCugdv1YZOO
         9hzvf/Aykg3ibJOysRmQUBq/mk/TrzepBrYgWV/dhJguVvXjm9/Pyj04sln/C0sy8x6U
         xTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283694; x=1793888494;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4PgsaR4ckK5t3xF1DMntq3pCLZ4hCM/y/z/GhVyNqpY=;
        b=O2vcXMGmFRmj+5ZagGh2oWmCM49RIntQG1MyvitRVMQz0EXs/w3kM7EALOITdzYYUU
         b3qedtXqVYKMDU8OaXS7osLF5FFoGyfY86JUbJS82y64CU+BKJy4ZFkt/P53qUrYlWdB
         rFN21RePHE4/b11CoDreYPka9S+CuUzWA8QZzRR8wnd4y4b8mlMkrXtKoOUjBD5aAZwz
         oZQc3NSodNnSbEgEaVIN/kYAzBQp3ixPThbDML/eJnParvukY3iIyyuvXB6O/64FX6uX
         oZlHNisEnaLisCy5w92uDUUvHRGmr3RY0gl8m5+zBP99Vq+KzNMBPrz8EWEDa3M17G7D
         7R3g==
X-Forwarded-Encrypted: i=1; AKwUvBzwi0cDale4nZO4v9hVbJmhDpO1/zs7J2MNQHsw5uUtv0akH5bvriJCRMUY3YParFw0HyY+BfE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhuXHEtFrBkdxzc79RkXFAHFXDN8eay/T9G/pruihoCEfSNaVy
	mACRwN/X4BUI0d2GeVKCvuilUi4LfIsd3que7z6br5ia6NV685iXrxU9ATE8McfeqQyxFO22uxR
	EiQ+Gkw==
X-Gm-Gg: AYBFou08FgbVbqCr16FSGznG+76sz7846NyTBqZI3meY1s9+Gn6z5LcFINJWj1Vc2ig
	XmqdzLjpSKQqUGcZethqS++wWP8EjGH8dvvbTtJQd0xLGtC2BQrUqmFfhBiU48uDEeNKyPc/AXm
	poTExb6w7NjFx21PxytJPbds6rXoQlqHJuP3Dy5DkjEUMLF6uUI5MOU6zPBGzX3qnppYGcIn8R0
	wkf9w0gvM8s4pTr/pble10dNmcWdCscipd44DY0GL5+zvN+jdjdw6mecM4nAEI/OGi49E5YqFxu
	w9BwIWxC+rEv4qaMtxWcVSTy3desWNCCmK0M1euKyyVCb5ll72AOsoyOHHxQW/aTBMPNQLBWY2T
	ei2yxO+n6u7HDAubF8V/AaqwKtVizVmvcxJmdIOG38w9WpVTL9W+iRYS5DKwCdYoG/s2dZ7Q1HO
	FuzXefxgkSJsSkyeYO7cQJZrv0R2h7k4YPjfLR3MjGT4a0DoGw8cBbOFg7SO+ZPDGb8pAYE/P0N
	PL8oVJAJ5eK9dlMD1S38/YxL5HDte7pEjwxk0WreJR+c9z9D2d0vxlJJ4PTHSnrch5awepVP3S3
	bPJYlqIo86kUoafLwxk1P+VarVyVomuwBRQvO1LQpXEhwGY=
X-Received: by 2002:a05:622a:58a:b0:536:76ae:94b1 with SMTP id d75a77b69052e-53fcc9beae1mr90780141cf.55.1793283693937;
        Thu, 29 Oct 2026 07:21:33 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f82cfsm131305831cf.13.2026.10.29.07.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:21:33 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:21:30 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	IgorpetinDev <igorpetindev@gmail.com>, Tejun Heo <tj@kernel.org>,
	Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	syzbot+a5b220cacb0618384d5a@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] usb: core: hcd: flush giveback work on stop
Message-ID: <f4c1664b-1c89-49c3-a5cf-7c496e63ed3a@rowland.harvard.edu>
References: <20261023174015.54793-1-igorpetindev@gmail.com>
 <20261024155614.2732-1-igorpetindev@gmail.com>
 <20261025000643.425c57ca.michal.pecio@gmail.com>
 <CAG21Q83f_Oj5+-OPjFdxzmLWnFkjfYhY9ordyO0zoGtxkWEW3w@mail.gmail.com>
 <2026102924-flashily-myspace-60a8@gregkh>
 <20261029114422.2ba64d53.michal.pecio@gmail.com>
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
In-Reply-To: <20261029114422.2ba64d53.michal.pecio@gmail.com>

On Thu, Oct 29, 2026 at 11:44:22AM +0100, Michal Pecio wrote:
> On Thu, 29 Oct 2026 10:42:35 +0100, Greg Kroah-Hartman wrote:
> > On Sun, Oct 25, 2026 at 10:54:57AM +0300, IgorpetinDev wrote:
> > > Hi Michal,
> > >   
> > > > No such domain?
> > > > Looks like you trusted an LLM ;)  
> > > 
> > > good catch, that was just a clumsy typo on my part: I accidentally typed
> > > appspotmail.com instead of appspot.com in the closes tag, anyway - the syzbot ID
> > > itself is valid. If Greg or Alan prefer a v4 to fix the URL typo, I'll
> > > gladly resend it, or it can be fixed up when applying.  
> > 
> > Please fix up and send a new version.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> 
> This race had been reported by syzbot previously and a patch
> has been hanging on linux-usb since August.
> 
> https://lore.kernel.org/linux-usb/20260823125831.6ea35650.michal.pecio@gmail.com/
> 
> There is only a bit of controversy over flushing vs cancelling the
> work. I think that cancelling (and leaking stray completions as opposed
> to letting them run, likely UAF things and maybe corrupt memory) is the
> right choice, as a courtesy to anyone who might create such bugs and
> need to deal with them.

I have to agree that Michal's patch is more elegant than Igor's.

(Although, as a small nit, I would change the last line of the new 
comment from:

	 * However, we still must kill these works so they don't UAF the HCD.

to something more precise, like this:

	 * However, we still must wait for the BH work items to finish
	 * because they access the hcd structure, which is about to be
	 * deallocated.  Any URBs not yet handled will just have to leak.

It's a minor thing.)

Alan Stern
