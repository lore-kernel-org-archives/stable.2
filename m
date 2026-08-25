Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D853FE347
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651735; cv=none; b=o0UXMo0EUsapTvgo+H2N21TmwHtTjJiGOlJ2ROQUVCYjlHyUwonrUXH8BRsf9++A+mbCD8VpK6dVRRe88JtvYx08Lcsk5mnDs9ABLCfCbnrWAAcYT7QMNUVqxl1j7g8nVc4j73NXFZiLYhk3qE6MPTZoMT0VGzji+iY1vTL0g44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651735; c=relaxed/simple;
	bh=XzaAibm+M9Dc/5gYq3GKmDGXqfQoFphDgDegCWcgc1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEzszZoY7k/zC62bN82f3FkCQzJFUoP8SduLkBnQw+JZvKdlVlfxBqtaBpFWikV9q5wfN5fOdTV2irsWGgujTegiXXPlN+s4MSaEmy7/RXGesktFZALkKuMzqyGIVhbI9EDswbGu0A1jnjEIG20hbqZzxEvadHHuq64DN+kziqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a9VO3vXO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a9VO3vXO"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15c42a45adso86631466b.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787651731; x=1788256531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L8/ympwJy7UG2l2hXdqKdXh3q513FQ6SISpiMxScLrc=;
        b=a9VO3vXOoxOOz1cI+cNXw+f+O+XEpaLqRoN5vjSYepjLse9Sf/v2LpDi6I61guXC3f
         MMqNo/v1qvtEXXgAcsOWkDjpUMtTg+DKhWmma8Ku8ksikBH9oXNqQNx2qEwzJWUdsqFn
         TyvigluBmcG8II71uf77TISqr8qk4kRk6H/bRjsgosvkQ1KXw9ulOrv1VuufJnPoZCai
         mZHFd8Grh88BjDNL5gIx01EwYTft1b5Ub+IjMi0ZZDSE0FxFcfusbItK3S6cjBq+lSLL
         KBHDxoDYqUPzEVTp01dOOtUJmaIm953XVGI7KoNwACjkcmxjXbB+PTebXFinSBitUjey
         eczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651731; x=1788256531;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8/ympwJy7UG2l2hXdqKdXh3q513FQ6SISpiMxScLrc=;
        b=TTMnXFyhHpqZT9QdCtRrPjDkxNlxceji2gdINpUpUMTa75wHU32BQTCrx2TTn/zzZq
         TW5JxTi95V4fFe5KJoRPvQ/v0uDisw6AnmZlhbvxOTpFaXU8kWhSu75I6aHpvRoDJeGV
         tuwkR5BUZMbFKDOqs3i1KWR+A6ANvXt7cxQw7VsOlL4IfacCf7T7Ek4nYzLr/NPFmiVZ
         0cwuuoq30NPLj6NAIZAaRK294yJXBk+Xpn6UuS6Oj784eGu3QtaFTaZ9R43LQ/NedHJ5
         ZgZ1XOmyIiLV9mSIBrn+flOqY03ABLXl9C0HRFi7WL7Ho4ywurDTzUrf6yCOMGECYCMq
         WYgg==
X-Forwarded-Encrypted: i=1; AHgh+RrDg+fRTKneQ4bbfota+csEknDQ0kIMp7EXVJ/DbGXklxm/xEpLyk4gZ7EI+f+098ZwJRvTKxQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nfUPgpXqHKBh/wgP7JA/3FqYyNUTal+Ek0OnUS3Ce1wUkG+/fU
	oLQGESkIQSyp3xntEBIFOzwrSmcOA5LhFv2ybw8tkuatoOvTE0P1jVr7qNuXda8Jc/Y=
X-Gm-Gg: AR+sD12g0zynUb6lvJDE/BPczbU/aOks+ylpAmQVhb74WQPGx2ekJCs67kG0Y2piL6l
	qLU9oce/+wknxGW8+W6JNBp+bMeWEXtPcosysHG2mebeXD5ekcRy/s5wbeiSnOmJYK4A+qw8Cfv
	Mgj6Yyx3stJ+e02rpon1xo7kHFFXfIs/OmD2r2+2OTGzATfm8Nw4z7T+7xLg6ZwN9g7RrvKNrDb
	eMapLKC7YqKI4XF8F51XT9BYrvzLTLCPIXz3Nr0M8JCeAnpBrYPNGS3KcqdxzOFjR4NnqlsSWCR
	QXLe0J2dq1nIQ6tWXL1/FpMYr9YEMONVX9YHhU5zny5/0DXV0gRraIkPxjoRMoUpDwGkYcCYl//
	RSrlCY0SAfuHmZBJkarnBPnla0SMxYi6tmnN3DcOrwmJr5+RHPOT4MXhx1tAdjOd1rOXKcAuMBN
	yrbf6J833lMnbiwVHQHCYH8qYgoJLpjYp10Ls7Qj987FeCIZ33PR2J3/dMlswe+A==
X-Received: by 2002:a17:906:794f:b0:c1c:4c72:e6df with SMTP id a640c23a62f3a-c24e2860886mr564689466b.0.1787651731469;
        Tue, 25 Aug 2026 02:55:31 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f6b48sm1759023966b.33.2026.08.25.02.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:55:31 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:55:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Rio <rioo.tsukatsukii@gmail.com>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 0/6] panic: fix panic_force_cpu= redirect races and
 NMI bypass
Message-ID: <ao1mkbDPbChOKjt9@pathway.suse.cz>
References: <20260818163806.17460-1-include@grrlz.net>
 <20260818114158.cc20b0cfcbe730a30597b466@linux-foundation.org>
 <0EBA4DAD-7B63-4AD6-B1E7-523D09E1305D@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0EBA4DAD-7B63-4AD6-B1E7-523D09E1305D@grrlz.net>

On Tue 2026-08-18 19:45:47, Bradley Morgan wrote:
> On 18 August 2026 19:41:58 BST, Andrew Morton <akpm@linux-foundation.org>
> wrote:
> >On Tue, 18 Aug 2026 16:38:00 +0000 Bradley Morgan <include@grrlz.net>
> >wrote:
> >
> >> The panic_force_cpu= parameter redirects a panic to a specific CPU so
> >> the crash kernel runs there. The redirect code in panic_try_force_cpu()
> >> had two races and an NMI bypass, all found by Sashiko. This series
> >> closes them and kills one more hack that the rework turned up.
> >
> >Thanks.  Sashiko had more to say:
> >	https://sashiko.dev/#/patchset/20260818163806.17460-1-include@grrlz.net
> >
> >In the first one it suggests va_copy(), but perhaps this would be
> >better addressed with va_end/va_start.
> >
> 
> Sashiko said there was ANOTHER bug, I might just screammm, at this point,
> some sort of superhero needs to come by and suggest the fix that sashiko
> likes :sob:

We are all still learning how to deal with Sashiko. It is quite good
at finding problems. We always have to decide/agree on what is worth
fixing and what is not worth it.

I described my opinion in replies to the particular patches.

Anyway, we are getting close. I believe that v7 will be final ;-)

Best Regards,
Petr
