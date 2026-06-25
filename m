Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0727AC4C
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402171; cv=none; b=Fq7vStMGUWB5kqzgCfbrDIQyFajv+cCHDFjbYLZCSeRq02SfurIG9pVsHjA0dLApPW0kauG3I/YgeBkuHPKPawt1G1VJORd1tklr2tPv1rw8Z10Y11dS7U4eNjnwfah5DzrAcgxBLM12gGAIgvCLqWwZ/Ny4jH5xyievfnjmDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402171; c=relaxed/simple;
	bh=1uwEbRalPWFJmHclInV23jNvE56jmhdw0cpejw7yKCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoDewm24wJtKBZ+n8pf1p08vQGyziY0+VIPRrKVgCA4VOZENkqgrJABMxX4ag2AtRnZ6IxSBEFP3bDNP/ruIm/utodRt/Ax5CUjY/I1xm+b05cbxqGQS7EZYl2oY2DlazdUYAYKl/LaRAib4sJkGXmdFriF+ctDjHBxwHqDrprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LtaWFVQf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LtaWFVQf"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-462bb734793so1709188f8f.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782402168; x=1783006968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gB23+sd00tzG2OsfIn9GO4d0OXAtSMMUBTk/3RoFTHA=;
        b=LtaWFVQf3dmD+2UTJIfJ/+YRize95nrI3sCf15UxJzsQjWK+pCs/0R8k2ZL+pcDxwz
         j1x6b8JYC01wnX6gEFVUf3dT+nUsq+mTq2YETwQuO3JxKBGxE7FAtomUIWZDj67eFMuv
         Cz4Z65y2Hpj+dVlX6ZBECZ/e/ZJfaWXAlKbTq+7w4ErmPGXp3DhlTxFLhs8H+KWpSpLz
         9exlhTYfA+GWepntRzGO+jaKano8hmbaHHS2VwWAD+pq5qYOz9SVmjHzuggdzTMOrXZO
         4XLmlaYdwPMUAx+t/cRgxwg6Bxdz0h7CKwlk0zRQgrUzfpVIHpT2rid3yOHuTq6BZ/9P
         9qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782402168; x=1783006968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB23+sd00tzG2OsfIn9GO4d0OXAtSMMUBTk/3RoFTHA=;
        b=fr7mnlrqHuGDFfGuAQc8X0S0L9nZ55hgoalCv1Xydb6DRMASuwMw2ZgPK5nOvg7Loy
         KDNj8QCeCzxU6BSB53/nRZg3dYk/0AEcXof1bk/VarfeLEQZ/AE1KSrrFJKXAZNcBQg/
         dGopG19QAsHZxHtr6mj+eqVbwB9jXr36NoUg3r956+DJgT719k+zogt9pF5HuDCIZJQx
         RooxKW0Dx5N4bQ/++ucS2Jmt0W9mZJkwFX6OX3U5hTfH/4o/oxbTvb7h/vKdMHvnmb9M
         l6PHyanpDrSaeMxcftm5J/SwTpbxfcxB6jIVubr/JZGJrQ67DVdIwxv0nCyh9lLyIMvJ
         J6PA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3V/RmXlevEELoYBKD9t8N+V/nBPP9/ddgxXZmGG8bSQG297DBHGMDiO92xm+JRRK5YbYVqvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySd8hRPO7XksW6+Z3LQl+HpcQCmwzrcmiRR/OxvV5vsrp3yda8
	V+zz0NR152/69eILY0yyvRJBKeL5/6xfVJ7hxTGcZZdC967RUj/3knbHe7/T4juXr18=
X-Gm-Gg: AfdE7ckfGrzuOicg0Wt1QFb2PSk1UIzxmALEZTU2Lh46744Npr80V3kYM3j8EL6mPqj
	XVGRpZw0uwEG4zA/E7Kefmh3FqtVfZ9saBjyJ+QzzcFzxbRTfZenLQsJKvWWzYKdc9beF4AqxUB
	ZqPZyoYpoX0hZWsOq02gXRZod6R2jCWVwpgSi1eeQbXsHo9DK7UOApsRtfw20SOhVNqqT5E5lvn
	BuyWEOjtC8U/WuuNMRhyF2Z3DIWydkqfP73VDiplG1hKqu1altm68fjOh7mDUUgTmjJHhtc6JCv
	SJE7N3+qblqNB2j7XMrTC7IReW8eB7gdiphl4xEO2Kl063LAwzmKWYJ7nMqXsr73OfaYJr1tWND
	rL4lUKJ8TgWZnVl/ZwvrA4NXGwgqXolGuw0pMraA5FhsNpixaw6tUTcIuqyhzXB+l+nwn5QOD17
	NmuLp8S2gYVxw96gA=
X-Received: by 2002:a05:6000:708:b0:45e:edc8:d440 with SMTP id ffacd0b85a97d-46dbec3fc5amr5453031f8f.1.1782402168242;
        Thu, 25 Jun 2026 08:42:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46de7effe5bsm5033765f8f.5.2026.06.25.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 08:42:47 -0700 (PDT)
Date: Thu, 25 Jun 2026 17:42:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michal Hocko <mhocko@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
	Jiri Kosina <jkosina@suse.cz>
Subject: Re: Fixed tag magic: was: Re: [PATCH v2 1/4] sys_info: add helper
 for callers that handle all_bt
Message-ID: <aj1MdKcXP3uIW7AX@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
 <aj1Jh57McGH94gGY@pathway.suse.cz>
 <EEB33A51-758A-4A67-8AC5-7200B53F8C1D@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EEB33A51-758A-4A67-8AC5-7200B53F8C1D@grrlz.net>

On Thu 2026-06-25 16:31:47, Bradley Morgan wrote:
> On June 25, 2026 4:30:15 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
> wrote:
> >On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
> >> On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
> >wrote:
> >> 
> >> > Some callers handle SYS_INFO_ALL_BT themselves before calling
> >sys_info().
> >> > Add a helper that strips that bit without turning an all_bt only mask
> >into
> >> > a kernel_sys_info fallback.
> >> 
> >> I assume this patch wants a Fixes: and a cc:stable also.
> >> 
> >> It would be nice to have the conventional [0/N] cover letter to tell
> >> readers what this is all about.
> >> 
> >> The patches all have different Fixes: targets.  This risks inviting the
> >> -stable maintainers to merge only some of the patches into some
> >> kernels, resulting in an untested combination and which might break
> >> things.
> >
> >I do not agree here. The Fixes tag should should point to a commit
> >which introduced the regression into the given code. And finding
> >some magic common point beause there is some magic undocumented
> >process for maintaining stable kernels sounds like a way to hell
> >to me.
> >
> >Best Regards,
> >Petr
> 
> 
> oh no.
> I added the generic tag to V4, no worries, it is the earliest possible
> fixes tag. But I really don't wanna be doing a V5 just to revert my
> fixes tags.

This is the risk when sending 4 versions of a fix within 5 days.
A good practice is to wait at least one week before sending another
version. It gives people chance to react and helps the discussion
to settle.

That said, I am not going to block this because of the fixes tags.
But I suggest to wait longer next time.

Best Regards,
Petr
