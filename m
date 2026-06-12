Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C832572F
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277122; cv=none; b=olUmnqyZd1Hx0F8TMQH2XuCUvWFd5G3QBwSR2eXJ35OU8Z9Ho1AlAa4NM6xRe4nTT6aFdHuMBXNk4bIXjBSuyECBfdhRJA/FxnHKoP8+6GBl17/u4bf7nMPQqhtXrIfsso/seobu0GDKCUwDg7+yFUK0edAQurXwgqrfVKBVk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277122; c=relaxed/simple;
	bh=G75brgHYs2YfSe+Qlduz0qj9/u727IddI66jXx2vWFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O76wmp6XzOdN2G5hNJ1KCRq8VtNI1fYpb87CcYyDvzjmh6oIU8cjmdZNvAYJTWAkfxmcoBh2/jsIcFpj6kdm15bSSK5EbrYLtTd/l2OK9ry1wmhm3G7o0/ffNNN7y0A2CNmXeE8tPr/+i9jTmOiIYF5zu+P9Q0fqOguhAs6Z/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R8F3NSXq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R8F3NSXq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eedc94d37so646031f8f.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781277119; x=1781881919; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uHz30rGtCI4aGvtHgmZ0RxbN8WTv9zc5L1bDGGQ4qcI=;
        b=R8F3NSXqmvxuJiPVMiMTT2M7+gajgYka5n3GMB/HqQshDvfcEDzCIKmjn5RgZK3KAl
         dYTNE5pMIgvPaIwfWFIgLtRF7ZwN7dPUx4G4YYmYEaj29y81BkpRhfclM1IXTCu6c+Tc
         F1AuXKVttlc3KmKirfr56KMjIA25UjKMAJfhLen/o/+AQp5MtxGVHp+f9EfMbsnmoo3z
         OfNj94Yxnr5ZspVAeW5Pj6hHfaTRy/Xfk8Ci8RPnNKAA9o482SSl6eOmZ60F6C32ACbd
         YRMdrKvQWqOT+QXrUfvQGiiqSZL3TflypsRFGdFU5Mfvn/74t/v9mS4g3IxE2cdxQvO3
         TtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781277119; x=1781881919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHz30rGtCI4aGvtHgmZ0RxbN8WTv9zc5L1bDGGQ4qcI=;
        b=B+wGNrvd7bykAsf5MVLq/qASCfFdZX6J2t3VIvZwK2qtrlx4jkPnsLgwsupqsOXa8i
         6afRL5BRdGl6O01aS6LyBrJUM4UWLDlBThE/Ci4yFIVfhXknrBIn8aMyZpf06x+xPwAa
         owsSIHBF+UQWd3LAPsuQ/x753ed6+lBfq9CRKFpBd0iCOnuTHr9uD2MAxRdnjVVMe9Un
         r6dj1f19OyMwkIrJlma7w5u1wZvmi8SqYlimCOExkDdkxhSElbWeRedbpAXaw97qt0FJ
         PcKV9zQe7edds1OXAQ8pJVKAOwsN+SnTxpZPE2xZCRMaQ+Oi/bZveggd3D6mcaj/dF6A
         zp8g==
X-Forwarded-Encrypted: i=1; AFNElJ8NOPbmi7pzoG7Kz13+xYri/sS06q4tmxeA+qQjPZVttpnIN5BDH462sm0VtqDd7PUIfGRFcgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpxqQnueEcC7JQXELkVy1DEr/NwAiBtzxMzdTM56xVcOFSdjqZ
	Q6HR9b/r3nvmN0//fSBaSBnMZVMaFgRG/HVwq54rPWS9Q+zpGgLBRuRcZ4B2YWiSRpo=
X-Gm-Gg: Acq92OEt+B3q8mLuGLnJOTmI9Pz4G9RrWXnnaSSC3opKA4/+QjB8QEsSvNNYn6cf69k
	/jXwGHxgHc6f2uHkGo1I5puS1XIeJEZkd9cZ1w6LWpCDuZPbr50O6uCYxVeZASObrn8vrM008Wa
	RD9QVABKioKWkM3p0jZILsJRNvqTdVYbSZsQPj6AY9SRCqEyfq2S9bO8stSa0A0/WFSFg/Ib8WV
	zmkD4M44PDp+6txWW3VKWaO9BcHCIVd7N1R+KeUhytVskdcHSGG/hxU/6EefCovlnZTYVVPzwyU
	NysdtmbtcZW5LNo1sjS300ZRBzxwo3VWgEPYCa8weIfnpQBsIYdop+u0fo4xSSY/XcwMXSJkexh
	P8WII06dv5JFaQsjB2SSDekKO4rOCSTwcNWf10vfWj4xZv8y1ffdv5C69Y05/8QV8phaiUOKrk5
	AW9Ehr/gR5aIg6lsiTw9jN3trMDw==
X-Received: by 2002:a05:6000:41f6:b0:45e:ed7f:1dd with SMTP id ffacd0b85a97d-4606db96b8dmr5403781f8f.25.1781277119080;
        Fri, 12 Jun 2026 08:11:59 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2dbfb1sm6913084f8f.35.2026.06.12.08.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 08:11:58 -0700 (PDT)
Date: Fri, 12 Jun 2026 17:11:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	mm-commits@vger.kernel.org, stable@vger.kernel.org,
	nathan@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
	ansuelsmth@gmail.com, andersson@kernel.org,
	aleksander.lobakin@intel.com, agordeev@linux.ibm.com, arnd@arndb.de
Subject: Re: + errh-use-__always_inline-on-all-error-pointer-helpers.patch
 added to mm-nonmm-unstable branch
Message-ID: <aiwhvPaHef0pdm3-@pathway.suse.cz>
References: <20260526184100.3BA431F000E9@smtp.kernel.org>
 <ah6WDkwO8eYY5f2a@ashevche-desk.local>
 <ah7PWK4gTdOYG1t_@pathway>
 <CAJ-ks9nHkcgwdh7i8efAv=ka2rtX9o6ZnGZk5KeroCX2G_t3mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9nHkcgwdh7i8efAv=ka2rtX9o6ZnGZk5KeroCX2G_t3mg@mail.gmail.com>

On Tue 2026-06-02 09:46:33, Tamir Duberstein wrote:
> On Tue, Jun 2, 2026 at 8:41 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > Adding Tamir into Cc.
> >
> > On Tue 2026-06-02 11:36:30, Andy Shevchenko wrote:
> > > On Tue, May 26, 2026 at 11:40:59AM -0700, Andrew Morton wrote:
> > >
> > > > The patch titled
> > > >      Subject: err.h: use __always_inline on all error pointer helpers
> > > > has been added to the -mm mm-nonmm-unstable branch.  Its filename is
> > > >      errh-use-__always_inline-on-all-error-pointer-helpers.patch
> > > >
> > > > This patch will shortly appear at
> > > >      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/errh-use-__always_inline-on-all-error-pointer-helpers.patch
> > >
> > > Petr, shouldn't this also fix the problem with old (buggy) GCC for xtensa
> > > (IIRC) that we encountered in some tests a couple of months ago?
> >
> > It might here there as well. Unfortunately, I could not test it easily
> > because it required some old GCC.
> >
> > I wonder if Tamir could try to revert the commit 8901ac9d2c7eb8ed
> > ("printf: Compile the kunit test with DISABLE_BRANCH_PROFILING")
> > and try this patch instead.
> 
> Yes, confirmed.
> 
> I rebuilt xtensa-linux GCC 8.5.0 and tested printf_kunit.c with the original
> randconfig and branch profiling enabled, without DISABLE_BRANCH_PROFILING.
> 
> Without Arnd's patch, the original failure reproduces:
> 
> printf_kunit.c: In function 'errptr.part.2': error: call to
> '__compiletime_assert_313' declared with attribute error: BUILD_BUG_ON failed:
> IS_ERR(PTR)
> 
> With "err.h: use __always_inline on all error pointer helpers" applied, the same
> compile succeeds.
> 
> So Arnd's patch fixes this case and commit 8901ac9d2c7e ("printf: Compile the
> kunit test with DISABLE_BRANCH_PROFILING") can be reverted once it lands.

Great. Thank you both for pointing it out and testing it!

It seems that it is not in the Linus' tree yet. I guess
that it will appear in the 7.2 merge window, ...
I set up reminder to myself.

Best Regards,
Petr
