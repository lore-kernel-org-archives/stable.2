Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB630367B6D
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584199; cv=none; b=h/HqT0l81DwI0FKAmDshCIKoacnucRW4h0FOuB6YtRtlYcTkvdiwFoVh6jDvlQgJuAgWGQfPXh28MFOKfGe0CDcGvrV9HGucAlVTvAcEh6VkIhHdIkZ9Md90kt4ND2hFxr5OG0LDQ0aap7uQzril+uox3XiBAkdLgZ5LWUzowCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584199; c=relaxed/simple;
	bh=dfMidm/UL0JV4R20isZPTs+J7q4aMwjodEzJbjwDOP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrXEXeZxYU4PDdlvv8/TgP2Yed4w4WJskiZn4W2zuxuLzR+av7T+glH9tXd5GdTck+0tZEgCx+kh0NnzTf5X8KxZsT0WfEkhTAxqxEoS2UiOx6ecBKhlzmn+gjbkO5KDvXBkkrfsJYKyYZcRVenxChBL3EcYWMUVa0XS3u7xpUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pmgDPO1/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pmgDPO1/"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-90c522298d2so22302086d6.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787584196; x=1788188996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k6j7WBdzhGUFGnvNUS2cIrQrd4SkMPF+Ufhv82BZDwo=;
        b=pmgDPO1/RBFgoiE96DFR795j8SXC6Eeh+MoBXciqrqhbwmcN7P/6Vw4Bf4HiaiZAqj
         YwgOBXaHBg506pt/fYWTMKROKnRG7upUVhrz2ouiDS2ecu7GdKzMQMPbvR1wiicxPKjn
         j+AMx5gZbWPmWwmQ1lKGV84xB8/fvcUZXLF5XXHxgXCiwSkfDk6YkrVMZexje32GCD5J
         c/EdX8FMGZ5d+797EBamksX4Qbb3OhgZE67Kil6zfiRrdLD370lFv2HOMigNH97vkeiE
         Nwu9WAXadXCLiQqwqQzswaxjf6iYvP+jJIIB1rMo4+FwWqIb1d74/NQngOwqFdF46Jgh
         fiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584196; x=1788188996;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6j7WBdzhGUFGnvNUS2cIrQrd4SkMPF+Ufhv82BZDwo=;
        b=Orpr8VfmfG/tYfeYu8aVWXKWeaKJinLKCDq6VqdGce85ey8Y5mvAd5MfXs+bXDY4R8
         cSAu7PIRYiRmPW3w6Xh1BKtuMInDZ6jphpfkQmLe5BC4sxz22GfkCKwEHctoXrmb0eHd
         UY3opnQmxhllq4lb7kgVgDz0RHIVsKtfPpBZQbqNYFBgIEbbTVhVOLutd13gMNXF82++
         703ovuDIdrjjv+JW3l5VkJS7MTfYCxIX03wSW0T8yaWHFfZRNd3pSdQC4wqWLuCnzwHb
         c8Et0dcxgPvJVb0U/cWNVAlEIZ5k0LXhFvtHPfvShaoCKH7hRzsRLYo66nrQkCXUrtiL
         O1xw==
X-Forwarded-Encrypted: i=1; AHgh+RrRkIIrSLeBKYKlVyGtUroAR1mj+CIrVh7NppyI2K4yMLn7EDTIkyADVTzR5te2jbx6pm8WkmQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kWNgsC9WSLqF/5+yrEEiRALIOiT99gPiMJWIjdqJ2YA3fyaflm
	pto/k9gGOQL72zeRe50IRK4wSljMEdUXPWwbzbUZL4UHGiBK2fUJdjVOxmYPMjvvzeY=
X-Gm-Gg: AR+sD103mIq4Dp5hGydBfppD301hQW3bdIZ6qwN4HmLS22sC/nL/3BNQWperZgLfo74
	qCV8LQ/K/0XpvAQpNSwNBGWD3FnPvPF80YuddsYsqAzIeBE6UIa7fj+0rdLJXhgFFgscCKV8pGb
	HC3LnA4LO8xrJ0lTU24rKXyevfTF+bQALRSqAbRGpyZeC3Ht8A3ojrjNn08j8iTjpKkE02D96jA
	jG9ky5sC8T3pKgYNn5+9hjG3aImOglOPduoELpcqropX6WypM49PTsP/rzbtJALtZkQ2/WRCAFG
	JnVAvFzi6+daEaW/kYKH9ia8Eb/wzFGP3lgvhq8qZ8lGcHK9WJ7evMd1HVcFB9F1KS50440fUxR
	MYJ5XAqnHQOEstC1vpVqnhyHg9Gc8KcUQGVk8GPmQ+zV9ezBiC4juC9Z+0V2w7o1DakCE1HSR9E
	a9HJGcQmi54KsAhrsw64IWjA7t4QEi0WesL2RmBfYfgwLFytOYXTZxymNP45tYlThDRHFZsQY2+
	Q8HI0as29MLxK3SzbyYO1359V3fipXui5aTpVBVCkys
X-Received: by 2002:a05:6214:21cb:b0:8f3:cf36:15ca with SMTP id 6a1803df08f44-90c8098e804mr271697776d6.9.1787584196428;
        Mon, 24 Aug 2026 08:09:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c9360b07csm64972756d6.17.2026.08.24.08.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:09:55 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:09:54 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, edumazet@google.com, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, syzbot+0dbf6d295b3350944f0b@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/mempolicy: refcount the weighted interleave state
 instead of copying it
Message-ID: <aoxeJmrVAiqOVIE8@gourry-fedora-PF4VCD3F>
References: <20260821104043.f692421fec915c0c5bc1fbe6@linux-foundation.org>
 <20260824024117.1755899-1-gourry@gourry.net>
 <aou1Gwxk2s8Qjdm9@casper.infradead.org>
 <aou9WUf2qU8UewL7@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aou9WUf2qU8UewL7@gourry-fedora-PF4VCD3F>

On Sun, Aug 23, 2026 at 11:52:55PM -0400, Gregory Price wrote:
> On Mon, Aug 24, 2026 at 04:06:03AM +0100, Matthew Wilcox wrote:
> > On Sun, Aug 23, 2026 at 10:41:17PM -0400, Gregory Price wrote:
> > 
> > Bit of a shame to take/put a refcount on every memory allocation.  That
> > seems like it might hurt (even being on a different cacheline).  Would
> > it make more sense to use SRCU for this?
> 
> Bulk allocation - from some measurements it's about once per 100-pages
> on average.  Looking back at the data I was getting about 41 refs per
> 4096 pages (16MB chunks).
> 
> Have to imagine there's other cache fighting in that stack too. 
> 
> I'm less familiar with the rules around SRCU so i shied away from it,
> but I will take a look.
> 

I will update to the new fast srcu mechanism, but it'll prevent
backporting beyond 6.18.

Best to backport the gfp fix and update to srcu in normal cadence.

Will submit separately.

~Gregory
