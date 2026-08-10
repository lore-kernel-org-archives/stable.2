Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F333D50F
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372809; cv=none; b=IzmrYtFuQ4d5wGHQYvZfq9HnmxtHfnbm3HvUIpL+uw8+bK8qqyJVU09jgKCBC1kSVyesn9Km0eXnZa0eMU4/YztL21SXtM3Yw2n6cur61Uw6h59wcfcz1LVQ9SZXoUjA9jpGcTRZ4YU0XJtrQGY2s8u907d/JFn+ZQMzQ2a6bCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372809; c=relaxed/simple;
	bh=dfZiwVY2qnjtHARQDLFCt1K9e0b6RXXJ/mUadhoogoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpanpX2B7BNO5kuN1XHcq7s86QSUBuKwnsyYpZy1OdviNlOL6YtYezXHy0xKvRpA+OHoJFB13XEJZzbW/+MsWvOvMtKjs27yUJy4iML/fhAdaIxHLlpQ3rpTR8z2Gg3e8sXQE2+POCUcFJeGNSL/uN67RZDy+SxhbnnyphW2KXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=co7aDJ63; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="co7aDJ63"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso1104043a12.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786372807; x=1786977607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jJtKsWT4sx3y58QYdxZvJ/PHE2uBcHo6QmKYUPmhmYc=;
        b=co7aDJ63EzOJAQOcLXLRT32LUUvOz7QQINEiTE/QWGF75gvn193u5V6a7tn7jLUj1Z
         I8tGdLyiOPnLgP3lDHQx2EcHeLJW3OF22xuOPL6NLmaicfOYRuXNws8X0JE85rq5JZMi
         rXdvM3Ek/3sYr3DYW799/iTp+SMIuqYJi+ckU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372807; x=1786977607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jJtKsWT4sx3y58QYdxZvJ/PHE2uBcHo6QmKYUPmhmYc=;
        b=Ml7OTN4f8u+Q+S1YcpL0sQ0Bb5+lCawuwmreD6ogPp+By0uQ0Le0UhtFjvWinh+J/2
         TUdOuioNtsgdkWapBJT0FdAlTsRwS5ZtbfcJHg7AxcMM7EvslcGI2RtgsYDjHO06qxfE
         2nKBO1u+OfIuBKLhTJCdDEUSnMyQrKk+mcRAxyxK/XXf26nrde4vbFqhpmbpJvVk96OU
         nNxVW7qfOmw+phZiFdzX4qPseJhEeQVzcAzVrihTX/B4KNTgEStfXWiJLfRy2X+7mBUh
         OEdSlJ04p5lGhDvpdoEUt4PhnkxiGGcHYWMUTV7g6Py+4HHuCoAeMMvmfQhdenosCCik
         D7Wg==
X-Forwarded-Encrypted: i=1; AHgh+Rpt8vOdAfr/kN6975P9PHrzV0Ua7bPB3OLGTCsrajcE6K0g5gaaMOkLDfY6YyTPje2RPr1D52o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8CDzH8/NGIANarj3OkWDJSEMuuhOpltHZAMIJyI8BPAWHOxJL
	U3r+mo4mo75WWj9NRRyFuuzNN7DXSAStIzA21Bw/sEowxDt+iD4E/MAhqXg25sHXtw==
X-Gm-Gg: AR+sD133KVG7J7X6SQzWDywAS09Us4Z6sTZlDlq5fmQ7GNxTi+anlMrZzvWf1HzjQG3
	0P/dQtPeWHqhjkTH9Q4IFxVHItswIKHbGU+hV2U//a0EWC1PlO+A85fjfVzd50sTRzeX7pfaAht
	4ZaWjIYpJLF+qQsD6f9Dm+MChJEJMPKKDWXUupJ3nG18SlyO/zdtY8dC2czX6IIgsgqeG45m665
	FQm27XAHxlbpq0QyQ9pjwp1SUjDeTXh6Pts2lDBCqJZJeBuIz6+WOm0oogRUHHhTEaiOTZqpmiu
	Nb4XmdwHj65jcAIunDMdNFaRpf5lJ/iv/EP8NbXrscNXNZvE7BjpH5iUKuhfFYvOKw70sUFHLC1
	ryPLWgojg1QohFf8NZcR2d05Mj7pSdEkUdvu3ZLwMf8+dXJt4tROHTCdFIs/l2vWdyJCESZadqj
	mxi7H211bkS/CMArsny3UDlAoTti6/WP7UlryMt0FSbiwtX4IDM3iN3JxJbklk3UawCpogp1U+b
	I2TNtr6onKrHSXQE0h/G5uyu9Zy
X-Received: by 2002:a05:6a20:1602:b0:3c3:a3f4:5485 with SMTP id adf61e73a8af0-3cbce6cb2dbmr23968790637.6.1786372807013;
        Mon, 10 Aug 2026 07:40:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:ddfb:e755:8f7f:81af])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f35b16bsm4231740a12.20.2026.08.10.07.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:40:06 -0700 (PDT)
Date: Mon, 10 Aug 2026 23:40:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: Check for invalid/obsolete root *after* making
 MMU pages available
Message-ID: <annil73rmj0536I8@google.com>
References: <20260808062208.522577-1-senozhatsky@chromium.org>
 <anbL4h3ahwzG8iYa@google.com>
 <annbVU1ig24ZES-p@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <annbVU1ig24ZES-p@google.com>

On (26/08/10 07:08), Sean Christopherson wrote:
> On Sat, Aug 08, 2026, Sergey Senozhatsky wrote:
> > On (26/08/08 15:22), Sergey Senozhatsky wrote:
> > > From: Sean Christopherson <seanjc@google.com>
> > > 
> > > Check for a "stale" page fault, i.e. for an invalid and/or obsolete root,
> > > after making MMU pages available for the shadow MMU.  If reclaiming shadow
> > > pages zaps an in-use root, i.e. marks it invalid, then KVM will attempt to
> > > map memory into an invalid root.  On its own, populating an invalid root is
> > > "fine", but because child shadow pages inherit their parent's role, any
> > > children created during the map/fetch will be created as invalid pages,
> > > thus violating KVM's invariant that invalid pages are never on the list of
> > > active MMU pages.
> > > 
> > > Note, the underlying flaw has existed since KVM first started tracking
> > > invalid roots in 2008 (commit 2e53d63acba7, "KVM: MMU: ignore zapped root
> > > pagetables"), but the true badness only came along in 2020 (Linux 5.9)
> > > with the invariant that invalid shadow pages can't be on the list of
> > > active pages.
> > > 
> > > Note #2, inheriting role.invalid when creating child shadow pages is also
> > > far from ideal; that flaw will be addressed separately.
> > > 
> > > Conflicts:
> > > 	arch/x86/kvm/mmu/mmu.c
> > > 	arch/x86/kvm/mmu/paging_tmpl.h
> > 
> > Sean, can you please take a look if conflict resolution was done
> > correctly?
> 
> What kernel is this for?

Oh... good point.  I forgot to specify [PATCH 6.1.y]
