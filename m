Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102B38BF6A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015307; cv=none; b=NL6svyG/udT63Ed4Qu08GSRwuCQ2Tpxx745X0ERfUdyEQEaNey1Z1KfZM2zpzNsKC/A+m7ioXERPY1whm+xGO1qqehIXZD/tnpInB0nZkPrgO3u56BwSgZavE8JXYZPLPryo2UcIxmE09yrfoFyc4uZELBfvnwDG1xIFmFvX8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015307; c=relaxed/simple;
	bh=UzIpQvdgLlLmdEHkcbM8fn3Gj6yOw8Amrfp5HGyfXNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxeDXZI9IjW9nmbj5CTbtX/m/DibPOGBfvVj4Wqdg/eb/YuA06Murx+Y989aH1GStkhkHKcn6K2uiQOs8s/7tFLFVmBV68OqtAu38h69XzmdfyxGo5FZy7DbyffX2R9sWf84ZGdySWmVJBf72Q0QGx7IFKAIICxR4b++IjnVDoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puMJ1FFK; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puMJ1FFK"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-451fd21113cso670193fac.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 00:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784015305; x=1784620105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EnDWZQFCaqFrKcYRbfLF0I0CeGWYxEfSRV+U8/QwLQE=;
        b=puMJ1FFKE0bXil0ccIRkMD5YMX24uu3p0j92CP3sYc9NB2Aj2pePKlYCOt9tWqqoum
         kDe0V6WZRNyZG9r2k2R6CDumU0wOfodwPs+9OZ8LtwnBZrdrmzD5yERaJuOB3vuI4piR
         AJ4vjVoNoXVF5UGQ3xHkpOrbALydbpXD2nd/2XmYcAp0kha+tMXq8Mrad6HFqG5PYR2l
         elaLR1tcDFWdzOUbNTrrqFy3Y5zx1GT34DYmsJG249LioteucEzUSWt4jLuf4ckMIZ10
         U3TowfhiWz7KJJix3GLrg4/5uVmq8RSsDhwLHfXgCyl7hSREo6wrG79BIoC3/Gai3IW1
         wnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784015305; x=1784620105;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EnDWZQFCaqFrKcYRbfLF0I0CeGWYxEfSRV+U8/QwLQE=;
        b=QVMJZWP3Y7KNpukeewtAyp8inOYP3gABMMT1y56ER71GneUfdnjfrbktFH6hW/ieME
         ZJsy2DfOWEycAap9W3vy+n+VPlO8xUhWzZsp16d1xALAj70PhpSKzUg5/vYbk9+FoXjD
         AA+wnKM3xKHMrf6lR6V8HDzlklvuFttSlbN4s/CvvTMWRaeACLv10wh1PlvgeebAObwF
         Hw4YAzDdoIL9lNxAcuQvbe6OSh5PhSkHkzp4GHu5XcU3OXyK4pKsZlShAT89hpiz/GeC
         WppIG6/4APxXE6P/aadk/1Lv+917BxRY3DbdRP/8hwVqAK2Vjp8qbQAVCxV2UIE7r2Np
         9+jg==
X-Forwarded-Encrypted: i=1; AFNElJ+1rtge3mjhAgRjSTUrikMUmPZf4F6HnVqRJDcGdGLV5ZOQ8Q1lRdChcHEQt1PswXxLoguAzjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxul8atKT8a/PZmelFKJROe+jJXN/cITGMmCO17Y/kPAro3dClm
	LCWOlXhVtWlScZJ2xUpYxvjos3ZLmMQ4Wjx/4VWe0pCUM4LCQNNXk2KC
X-Gm-Gg: AfdE7ckBPAxij02zepDOA2BR2XjvHIjuKlYtViolJorcFxzKFmPWIVOjBPQO6Y7KT5s
	iFHG2YnHy0ieN+s5ffmQOeWxZY5HvGGtE/Ts3EeqnOkO0te7GxW11dgGmmi66JzDnJOZQIsfKZR
	gZ0BYQBscsSlyjSZn/ERQY7XQhjoobTnFJEnvByaEO4KgdqdOhYyNgrvaJZN8pRafzdJZNVmGtV
	Xe3QE6Wt9QruE7VPL/CnD7STZIbMWwppf+fUcQz03gKDCDS/JXEb+BXF8UD15LWViPNQcgynNwa
	Y26hm/bsluvFx4ehyxqNprfxscIzKWgienpIL6apM376gBXSMAFHkL/8ip83hOisXm3KnFAH++r
	xtKMMT0l5LS4sUmy5eaFjcynVYodRrNk5qyggS6bY49ZJInSwS64m+IXavKi8JEK7GhSKF41wpb
	gKkYgyKf4g3rRukp0=
X-Received: by 2002:a05:6871:5386:b0:43b:891d:7c89 with SMTP id 586e51a60fabf-451f279c84cmr6166807fac.11.1784015305044;
        Tue, 14 Jul 2026 00:48:25 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4560a9b178fsm870394fac.5.2026.07.14.00.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:48:23 -0700 (PDT)
Date: Tue, 14 Jul 2026 10:48:16 +0300
From: Dan Carpenter <error27@gmail.com>
To: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
Cc: christian.taedcke@weidmueller.com, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
Message-ID: <alXpwPZauHMhFJF8@stanley.mountain>
References: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
 <ak96OkpYvJrK1Vbt@stanley.mountain>
 <a9eec0a6-6f16-48d7-9864-0051cb8c455b@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9eec0a6-6f16-48d7-9864-0051cb8c455b@weidmueller.com>

On Tue, Jul 14, 2026 at 09:44:22AM +0200, Taedcke, Christian wrote:
> 
> 
> On 7/9/2026 12:38 PM, Dan Carpenter wrote:
> > On Fri, Jul 03, 2026 at 09:56:12AM +0200, Christian Taedcke via B4 Relay wrote:
> >> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> >>
> >> When one irq is used for errors and each channel gets a dedicated irq,
> >> the total number of irqs is num_channels + 1. If the error irq is not
> >> the last entry in irqbuf[] but an earlier one, the loop assigning
> >> per-channel irqs terminates one iteration too early and the last
> >> channel is left without an irq.
> >>
> >> Iterate over all collected irqs instead of num_channels so the
> >> error-irq skip does not shorten the effective channel count.
> >>
> >> Fixes: 188c6ba1dd92 ("dmaengine: nbpfaxi: Fix memory corruption in probe()")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> >> ---
> >> Changes in v3:
> >> - Guard against out-of-bound writes to chan in case of an invalid eirq.
> >> - Link to v2: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com
> >>
> >> Changes in v2:
> >> - Advance chan only when assigning a real irq to fix out-of-bounds
> >>   memory access.
> >> - Remove now redundant ARRAY_SIZE(irqbuf) check.
> >> - Link to v1: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com
> >>
> >> To: christian.taedcke-oss@weidmueller.com
> >> To: Vinod Koul <vkoul@kernel.org>
> >> To: Frank Li <Frank.Li@kernel.org>
> >> To: Dan Carpenter <error27@gmail.com>
> >> Cc: dmaengine@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> ---
> >>  drivers/dma/nbpfaxi.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> >> index 05d7321629cc..b1f06f0bd0d5 100644
> >> --- a/drivers/dma/nbpfaxi.c
> >> +++ b/drivers/dma/nbpfaxi.c
> >> @@ -1374,14 +1374,14 @@ static int nbpf_probe(struct platform_device *pdev)
> >>  		if (irqs == num_channels + 1) {
> >>  			struct nbpf_channel *chan;
> >>  
> >> -			for (i = 0, chan = nbpf->chan; i < num_channels;
> >> -			     i++, chan++) {
> >> +			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
> >>  				/* Skip the error IRQ */
> >>  				if (irqbuf[i] == eirq)
> >> -					i++;
> >> -				if (i >= ARRAY_SIZE(irqbuf))
> >> +					continue;
> >> +				if (chan >= nbpf->chan + num_channels)
> > 
> > Prefer my check, but sure...
> 
> Thank you for your review, i send a new version where i try to use your preferred check.
> > 
> > It's pretty annoying that sashiko bot doesn't CC the CC list.
> 
> Is there anything i can do to improve this? Should i reply to the sashiko bot comments and also send this to the CC list?
> 

Not at all.  Just random grumbling.

regards,
dan carpenter

