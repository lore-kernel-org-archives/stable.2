Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795385049;
	b=pYILfvbbhRHEGkdYvE+zql5St4t/TLlK6K1vpOyZT3gHD5aoGW8Q3GjwXM4PyhUqHOVb
	 wSEF16qVjbC92SoybLbZ43pDHxJzE5VCPZPx0MtWToKwuE6p2q4dqPONuStNgnaiNZCSN
	 36INDMAN9QEjhbNW72tma4Co9wAKiXjM/7I+tusYqoZkYWt6N5SsU/Ujsufpn/IN2sXQl
	 8t1xb6bt6itCmVqJbR3YNeiRsK2JfizgCLL0wWqsONKOCnJUW5tpiO/AScudtvgauYtU+
	 oM3M6AyxZ/74rYkZ4VqQyeyUDWYk/r28zt5XgEOAjjNsw5Xi5MSANN+lGiaNDPPUajg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795385049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=e1UeqpHopmbaPkusoHxAs650nxIkw9JTuQGwP/8OHlk=;
	b=NNPX7b5RFkkR0Gv+W3Mhkj7StiIcZRavK/5KNZ74q11BQdW02Jy1z1EVS5EwzzNwFdfD
	 e2wpygNvJ4IYjLk4WaYpP8FmnW1RzsH7ff9PHqPpgEcpErPe6vIDtRM2zr1v7ptt0i/Cx
	 xrElczkKlUrVlpw5XFfsUQkDEbV83LKbdfEzgDcz/5GnrR5RGj5842AGrjTXmd4bBukxz
	 mb0yw9XRCkqvfFcpXVpJv3UykeHELUHPxzxp72r5oyBgPeMNaxjL2jKp5nkJmqurD2Es9
	 q/ukfbS5MywQrW0ivDI2vc5Ad9znSvJyelLHHEKRx9Gkgjty4OUcZ2kf4NR/PTcjPog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=Zb6i+C64;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70250606A32C
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70250606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=Zb6i+C64
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55b8cd4e2abso32041531cf.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 14:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795385048; x=1795989848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e1UeqpHopmbaPkusoHxAs650nxIkw9JTuQGwP/8OHlk=;
        b=Zb6i+C64CASN2ndqPIkyqfK6CNP07EzVS4CJfCyAslD3l9TVj2ktcjdJKiATYHCa4d
         nFzVDD4e7Fb967Zmek2vssQc1g2uGyVD924kVnth7iDDsi9vf73VQ8fDaOquRrq3yu8r
         1dlGsXvToefm0ERzK/AMbRuwle4p0pqB4q5QhtuRDBdd641tDYrgYAfSQ2/ZWtmORlT6
         EAojqrwI3sg1ialRkcqFhaHNXGMzGKS96TyGaKJzbtu95+9y6ofCZGt57p53iw6If4N/
         HS1xpGwWTuqR/vTy8cHVy92eMMwVgBa9yVwksjvyvSLVPniauCMo8Ehb6zWb1wxd1oty
         yP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795385048; x=1795989848;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e1UeqpHopmbaPkusoHxAs650nxIkw9JTuQGwP/8OHlk=;
        b=gtxBjg1MRXWulFs/8sp6eofW8fILwUWnhL7GInn6LsSFxr3j2AN2c6WKzTPFLZgP2v
         2QXGXVI879F+st8mc7dXBYe+2acigPqWmtBBL3wu5sTd3Rko9ulcF2CRKSZDc6BrnLmD
         hxvgUdpzmdHsnX/TgZjZxdZR64168bDnvmM0+ySCi2J+Nitp24OUYUuenrGxHi0WJJ0V
         VIy6pWI/ASQyxSGOWb6yl4pSBumJsMJksCc/Ol8VVIMrhIreFvBEp0hedTQ4tllN5yrI
         bEK7xITmCKNM6cEe0V5OCrZQoVmTtrCkn3PTql4N8xxR0ZqXOXU1LXc+cBpT9vXYLf27
         RAAg==
X-Forwarded-Encrypted: i=1; AL+hErEE8QRut5gJja66hlAr5SvrexaevTX8+eTd0dSzX4DV4gi6Jlc4Ur8lsK8pdkUT5FPrBEs7j2o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/paKFvuhZwZl0PUBqqH//bzBysxgY/D69tvnf1kfLbPLrz4Xuk
	PL4CfiMMRQrsZwev6yGxQypJfJ2UizsoPAeDn2cJEUjvTRzUDRH4W971+Cy363yHjQ==
X-Gm-Gg: AZFdTZdarvWLGaYFSi1HT6Xrk7wBp4p9YJE6BdCRy5fx4i/YhFlPew6gpbfGOx1sgQA
	0mS41Cpvv39BhMmfZxaVHMLNJMhxjdeIgeGI5soLB9XjbbsgJ/yPFkw6YCeCVNWo+PXd97pGX4Z
	Frc0d4IIqoveItB/OtqQkXClpbQN2XDtNrXdAVOGoElRRAfpQvhwEn4hLi18HVw3YK+doBHGXEW
	qGEBZhXraqbZcCHtCY2Fa2IxuBSNqIy2yteezpilQLnCxf5tnVSlfE6pbzVwutDV24LEwNuEAmv
	P7G3wXnz47ZO1lkSj549r8l1zgxU15iR4UeaRcBA6v092Cdmcrm7npnuLKRGbL7gjOSnqbxR9Cd
	diQuedOTWeWK2RsS8UajqDzNUBrA/KgTi3PqG4GYRFvrISEd1DNbKO9mK9/6u/iAUsXpALXoj/L
	i5npkEx8AqPaAZsSiU0XOglzXGIx1c2FGWpDYtzbmjpyshqiymIdglrf2n+tZstOM3Zn+YR4TGe
	Hl6T94fi6n+JjOOvAwroOidH3VIz1v2/ygc110mUJMVZVhaMknnjY+45ffP5XSWdU95J0Ck9jFx
	EELwoLPcWgsf7OKwGx4q6t68umC7IA==
X-Received: by 2002:a05:622a:2b49:b0:537:c478:70e6 with SMTP id d75a77b69052e-55d76ac210dmr174765381cf.36.1795385048312;
        Sun, 22 Nov 2026 14:04:08 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788ae02fsm81501311cf.29.2026.11.22.14.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:04:06 -0800 (PST)
Date: Sun, 22 Nov 2026 17:04:04 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Arbab Haider <arbabhaider649@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shichao Lai <shichaorai@gmail.com>, linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
	syzbot+dc208a8cf8d37cf3e5ac@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb-storage: alauda: track media_initialized per port
Message-ID: <61e2f5db-8d78-4220-bb21-cedd9f579e8a@rowland.harvard.edu>
References: <ac19e630-f96a-4144-88dc-e3f22091c7bb@rowland.harvard.edu>
 <20261122175805.2955-2-arbabhaider649@gmail.com>
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
In-Reply-To: <20261122175805.2955-2-arbabhaider649@gmail.com>

On Sun, Nov 22, 2026 at 10:58:05PM +0500, Arbab Haider wrote:
> On Sun, Nov 22, 2026 at 09:53:25AM -0500, Alan Stern wrote:
> > I asked because when syzbot tests a patch successfully, it provides a
> > Tested-by: tag and asks to have the tag included in the final patch
> > submission -- but you didn't do this.  Did you run the reproducer
> > locally, without using the bot?
> 
> Yes, I ran the syzbot C reproducer locally in QEMU without using syzbot.
> I also just tried sending "#syz test" to syzbot, and it replied that
> patch testing via "#syz test" is currently disabled:
> 
>   Patch testing via #syz test is temporarily disabled.
>   See https://github.com/google/syzkaller/issues/8122 for details.
> 
> Also, while checking lore.kernel.org, I noticed that syzbot previously
> posted a similar AI-generated patch from Aleksandr Nogikh on 2026-08-28
> that never received a reply.

So it did -- I completely forgot about that.  For the sake of 
thoroughness, here's a link to the old patch:

https://lore.kernel.org/linux-usb/ea864031-b1e2-4b78-ab3a-58adf681efc6@mail.kernel.org/

BTW, the two patches aren't just similar.  Apart from minor differences 
in the descriptions they are identical.

>  Please let me know if you prefer taking
> that earlier patch instead, or if this submission looks good to you.

I'll leave that decision up to Greg; he can choose whichever he prefers.  
Regardless, for both patches:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
