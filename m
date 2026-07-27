Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06E3BE17D
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785126250; cv=none; b=sNW3doiEFru/4EsMjz0xYnZFygz+P9qfQlyxkylEsUtBW83zOMMF4TTH9qS5fpQyMbu9axWeJE2GC93w1TGkY/MtEZkc4jsCAh82HMoHuYvuZhV5egYUaCaN5jJdVTMliQmUJODQxPi468BTDSwrXLD37qTcQQZRlxYEmOiSpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785126250; c=relaxed/simple;
	bh=Yy8IISh+FV9cpGipg7vORYQVek5AJgkZkfEGn4HmLng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC354dPbpabuY1KKOZwFSs8U/6NA0RaI69DPZSuS5sldh5srytvjreutfEyg5ZOsFznfYnLsDJ6P8U9DtSSsF42fIF2Lo8SSOfQ1/4I5mID7to3caaj8V7CpcrD14H+O2do6mMgzVegTb7t6aXMEbn9nHwBra4nC4AYJC+OkLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SMek3enj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SMek3enj"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383cb94f742so1831344a91.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 21:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785126249; x=1785731049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yy8IISh+FV9cpGipg7vORYQVek5AJgkZkfEGn4HmLng=;
        b=SMek3enjC0QcceEKJ2YigUQLSZxXK7+3z6wbSBE/YJ128mSWeXKUEkGpJll+RTWWtw
         /vKU0ZiDRC8OHKtfMeT8GTe6dzMdnug7Ok6gdGqtwM+xHmvI+TVxw6Vi9q8q2Kq8thSm
         859oqd4WyfYkZK3Q5k8HJh10d9doqxgDT7tZvzcsSQGe/vQ+Dp/WbzTbEM5F9xlLtxPK
         HQokyFrZrWN+X+e0zfTp2B5sRCWfyn7Pg9tGxZBzvbv/1mAidlwP6OvFsaW92kp6X5ug
         jDwyIupoid8bEpOHpM7LnCe6/bsGE2HvunMDWy8D5teCbmJQ9d6eLfQY2n8QmYQOGi+2
         n10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785126249; x=1785731049;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yy8IISh+FV9cpGipg7vORYQVek5AJgkZkfEGn4HmLng=;
        b=CAzqUQWg3XKWvoj4guS/JknDnzb+8WpAPkQYK+7c1KEZTQnrTDQvctw5VwKj0kzy/N
         qLCAwuPoVOSX5+42WH/zO5oDNKvho9VWOSt/YV8fKpozlByEYYBbhQb3Jm4fq7hbTmSj
         lb9qGRwTErD7YTV+afj1+aTxkNKLtw9/qS7lj8HSvzXhpe4MDQHEPPasU5PR0EBvw+5X
         qHAWqGdfP6PnanRuUSA9MyvzGmWZoR0ZPdu/+G+Kay2bQshGKIoh3Fzj5GbToPBsI9aJ
         fxwKAK5gutiIHvlgZSc7viqJqmnN5DokBSASDFNA/RvKgsT14aIrs/SneokoHLZkKIir
         cLMA==
X-Forwarded-Encrypted: i=1; AHgh+RonmIs468aVJcIL1qR2HflygELR5DQWdRZYpMkIGtDz+UiVnG7rPXpNmKip6bzGRHfLSfHeMaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+6aF35yxYo5RZqfA5dR+omkS4SPXDSrMK5HN+ceJlbHoHhcLA
	cfNN+zbevQJ8NnsCtXYnattY07iHcG7gt7WUFaPAkWEgDO1KtWkHKrjW+U8XkcQu2UM=
X-Gm-Gg: AR+sD11XzJPOTTj8bXGzsmZohxAHzSeWp3dY3urEdA+O09sS7aMa1ltRH3JEikKL5ux
	x4kKwPJUBypvTnTMd3EtFt6MXw7DLo651vYQ7gKeBB/mF5sVNZdFM6vqmdC6uGWQ9B1sD+fIJ4e
	T3HDiN5OJNL9S+L3lQhjH2jhidHtGRcubCUbnf2/werrImuvhIDzshwOgMzJ7LJz0OMowqZOWVB
	nl3suav5nO5tXBt4XvZTs6fxiTHHquAKsK2k6/MlOr1+/nN0WOm2Im+/FOFMo293nCoiL60Uobk
	T5IoaYkzCax252Q1429BfMCfzpIGdA26jv5LGlY9dwkICKVYmgrhwbGpiexxxyiZC/acyv/t0l8
	4eVSkRm8Xwy4M7IJdszYV987Q9Mkdk9ZKjniHTg17KtkYXOvupDTaCWqiQB9Q2A==
X-Received: by 2002:a17:90b:5350:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38f29399845mr6819950a91.2.1785126248497;
        Sun, 26 Jul 2026 21:24:08 -0700 (PDT)
Received: from ziepe.ca ([64.114.68.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f041b8be9sm4471929a91.14.2026.07.26.21.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:24:08 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1woCsf-0002Mt-Ls;
	Mon, 27 Jul 2026 01:23:57 -0300
Date: Mon, 27 Jul 2026 01:23:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <ambdXXcfgK+cxqxa@ziepe.ca>
References: <20260717180442.110954-2-aneesh.kumar@kernel.org>
 <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
 <amEhEKQW0_HJ9cLN@ziepe.ca>
 <20260723075704.GC110966@unreal>
 <amTJY_CdE-uDgoGG@ziepe.ca>
 <20260726081753.GD12003@unreal>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260726081753.GD12003@unreal>

On Sun, Jul 26, 2026 at 11:17:53AM +0300, Leon Romanovsky wrote:

> Currently, the phys type universally describes memory and can be
> reliably translated into any required representation. It is the most
> fundamental type we have.

You cannot go from phys to page reliably unless you make assumptions
about the phys, that's the whole issue here. If the callchain expects
and intends to use a page it should really stay in a page and not take
a side trip to phys.

I agree it would help to have some helpers that were more phys based
for the callchains that want that since we are mixing two fairly
different activities in these functions..

But making phys the only output out of the pool isn't going to be an
improvement.

BTW how does a struct page even work for decrypted memory? You can't
actually use it that way right? If you try to access it then you'll
get the wrong IPA and it should explode?

Maybe we should be blocking the struct page path entirely for CC
shared?

Jason
