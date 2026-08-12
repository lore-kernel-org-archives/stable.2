Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBD390229
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551311; cv=none; b=WKFJGMQm/xq5TolRJJ8WtYb6VNbjkHNJaf6X1w4foxPNPSIzFoMHaCVQ/PKoXzvaGHv9G5yt98ds5Hz8/AjcTOhrsTyVwZlxeeU9W4mrB4WZN3Ugig+Ka67xvibRBbsXckhuosY/M69v3WZ8SwmFDYQ1j77OmcYG1XeYSqsaTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551311; c=relaxed/simple;
	bh=c27w4V6Qe/JgNFovD8llFwPMrhgspYh/CiOlGLfJ5OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ2DVqQDlF+cejoqAvA6y13ukWKFoX53vBstC0lBrnBU3G6Fh00z4Ujd4qw1o8CdPS1Gx+xfshJ/5w4WnNpGmdw50Ly13/nL+mWoHe1xY0A55V6xRmlHbfVjEztm//w0pj/bl79XMdt7luGbCJjvEeAyFxRNo+1zpcPTRKHC/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6COBUvr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6COBUvr"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8485b358552so398498b3a.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786551309; x=1787156109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5xXYYKBkIi3QVhUJgfIVwXV/5v46b3QSM+Be9dLHZ8M=;
        b=C6COBUvrjo/G4BNUZ68Q8f8SZhkjQo24+27KLCPplbkxCsvzzOcFTjvaI2d8J1gLE1
         Kfh5IDt+XvO0ol3eRfJr5VkaUGDpuX1PdxSTVP5VVX8WXC5LoQCWp27h7PzDLQ1Ecppf
         UVmX921NahnSHsbQbiey9EPbQHYnIVLrTPGgkhN6RzHQazUKusyj3k6jvMCvsuvlbyLk
         xvrRKMrRb1W8nbTD17ozeASDZlIb9ugiqHt+kJNi5FYI4h2IH6zlwl0m2trMvM6jss3B
         YHJ+bNuh1aZpzMEsqLraNWFgCybvi3JiqIAPRI6J8DsB0zD/jSk3JQ4K1dpD5JGAprBE
         2b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551309; x=1787156109;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xXYYKBkIi3QVhUJgfIVwXV/5v46b3QSM+Be9dLHZ8M=;
        b=XrW6ncRkKzcWwQmzKMR/h8ZIHsvFjJL6TSIhrngZAKB9dY3gYW8ozmwDDUVV5bw1wo
         35/axNK7uiVOGbWDxhz4oGQ2lHEzPmKdMXRX5x5w4+4ouyLcOWXlhlS0y6RkP+PG5pDK
         fe0m8X0eoOrnXRUV0B0q+uGlvLrxaQQsFdMUagNU+HUoSWkamPt3Q7UVfJEvLukcuYNu
         ZW3obwEtK9B5NxfQaK2FFSAztUsxINfm8wkSkmLw3/4Z8myeyHaVcG+8IBcVzw9uu5c5
         hltn+t5VZw/Qya/iHMoLx2XczINh3piktWHM133y1VnaAlCozgbNBU9InJERa0MxIvLT
         qYsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoNpTJwsFXnjMxBw85SGAQPAqY8nCfb2pEidspQCufxCXttgfTsYIGxYXbidtEY/1DzBGMwBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5vXqebaVwZYDGZw6pz0nRHf2UzBmd5EgNQYrAnjFxgRR1O4E
	QWgV5uYhw/lzuTWvU4HK/pvg0LJh50harPWt/7PYPYPEPePG/AAm59Sf
X-Gm-Gg: AR+sD13Kva34/haN9xY0OlSYN4H+MLHcsEUhESUQatRpwmtpVNRnB6iw1tyhHIdMoGq
	BTckZDy48InIkDm/D5x4eA+JSlk2HTAOkFLZMy+RBRWQFqXZd9M76MLIo9OdXwFiLUtE410aVi/
	bIxTha1CY5uh+o1Dt95RSBU+czKxPGXf1AxYsmI9TQxxuC9QRLdcpcwJjXOVh5T6rdFvNx6zis+
	VoO5f1trHzMhGzUFT7ucuIJQ0YzQ1A5SWHlZidDad3NXzdyPQk7OozsUKqldUaQw5z1bsxQqCZe
	9YnocKeRqnirX3YXKOFryCsEncc+kuAEwld87wUr04JrbfS77FEAffmcrbZMKRQqDbbMkf1NUM5
	EtifGSn4ndmrs4M4MGNacsZxEWzuYbLdiQomt6FaQGmvJXLQA4V+MyzcaSZY8BRWxSHr15tC/54
	suRBOM3doDm8+NnLrU9Q65s4228NhBpN6OktLmXcAULdsyO1E1d+dbrkRhvmnqHHE=
X-Received: by 2002:a05:6a00:4c8d:b0:84a:2c46:3fdb with SMTP id d2e1a72fcca58-84fb53e7290mr6627264b3a.5.1786551309224;
        Wed, 12 Aug 2026 09:15:09 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1cf8146sm1322242b3a.10.2026.08.12.09.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:15:08 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:45:06 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>, tony.luck@intel.com,
	bp@alien8.de, linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] cxl/mce: Only act on uncorrected memory errors
Message-ID: <anycCjTgNvCgSVdq@acer-nitro-anv15-41>
References: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
 <ant2Z1mzHCrzmzXn@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ant2Z1mzHCrzmzXn@aschofie-mobl2.lan>

On Tue, Aug 11, 2026 at 12:22:15PM -0700, Alison Schofield wrote:
> On Tue, Aug 11, 2026 at 12:00:13AM +0530, Shaikh Kamaluddin wrote:
> > cxl_handle_mce() offlines the aliased page of an ELC region on any
> > record with a usable address; it does not check MCI_STATUS_UC or
> > filter non-memory errors. uc_decode_notifier(), the equivalent
> > handler for plain memory on the same chain at the same priority,
> > filters on mce->severity and leaves corrected errors untouched.
> > cxl_handle_mce() has no such gate, so a corrected error - which
> > the generic handler ignores - still causes the alias to be
> > permanently retired via memory_failure().
> > 
> > Corrected errors do reach the chain: machine_check_poll() logs
> > them via the same mce_gen_pool_process() path that feeds
> > x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
> > extends p->res to cover the DRAM half of the ELC pair, so a
> > routine DRAM CE carries an address inside the region resource.
> > 
> > Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
> > ("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
> > commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
> > machine checks") established this filter for an equivalent handler
> > on the same notifier chain; the consequence here is more severe, as
> > the CXL handler calls memory_failure() rather than recording a bad
> > block.
> > 
> > mce_is_correctable() is used instead of copying
> > uc_decode_notifier()'s AO/DEFERRED test because the alias must
> > still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
> > the reported page but nothing owns the alias.
> > 
> > Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> > 
> 
> Thanks for the patch Shaikh,
> 
> The patch looks good to me, and the reproduction details show that this has
> been thoroughly investigated.
> 
> The commit log is harder to follow than the code change itself. It seems
> that too much of the investigation has leaked into the commit log which
> makes it very dense and not very clarifying. For what is ultimately a
> small and straightforward behavioral fix, the log spends a lot of time
> narrating the code paths that establish the problem, while the important
> impact, a reduction in usable memory, gets lost.
> 
> The commit log should introduce the code change and make it easier to
> understand. I'd prefer the usual behavioral progression: describe what
> happens today, why that is wrong and its impact, then state how the patch
> fixes it. Also, please spell out Extended Linear Cache (ELC) on first use.
> 
> The subject can describe the behavior being fixed more directly as well.
> 
> For example: (if you use this example, you need to proofread it, to
> be sure I actually captured this correctly ;))
> 
> cxl/mce: Avoid alias page retirement for corrected errors
> 
> cxl_handle_mce() offlines the aliased page of an Extended Linear Cache
> (ELC) region for any MCE with a usable address in the region. This
> includes corrected errors and non-memory errors, needlessly reducing
> usable memory.
> 
> Restrict ELC MCE handling to uncorrected memory errors. Use
> mce_is_correctable() so that MCE_AR_SEVERITY errors continue to retire
> the alias when the reported page is handled elsewhere.
> 
> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
>
Thanks for the detailed feedback, Alison - that's a much better
structure for the commit log, and matches what you captured.
> 
> more below...
> 
> 
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > ---
> 
> The detailed investigation and reproduction below the scissors is useful and
> should stay there.
> 
> snip
> 
> > 
> > diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> > index 65fed913b221..ee70c1c9f9b9 100644
> > --- a/drivers/cxl/core/mce.c
> > +++ b/drivers/cxl/core/mce.c
> > @@ -18,7 +18,14 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
> >  	u64 spa, spa_alias;
> >  	unsigned long pfn;
> >  
> > -	if (!mce || !mce_usable_address(mce))
> > +	if (!mce)
> > +		return NOTIFY_DONE;
> > +
> > +	/* Only uncorrected memory errors warrant taking down the alias page */
> > +	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
> > +		return NOTIFY_DONE;
> > +
> 
> The comment restates what the if condition says. I think the comment can
> simply be dropped.
>
Dropped the comment from the code  and sent the v2 
https://lore.kernel.org/all/20260812151759.14390-1-shaikhkamal2012@gmail.com/
>
> 
> > +	if (!mce_usable_address(mce))
> >  		return NOTIFY_DONE;
> >  
> >  	spa = mce->addr & MCI_ADDR_PHYSADDR;
> > 
> > base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> > -- 
> > 2.43.0
> > 
