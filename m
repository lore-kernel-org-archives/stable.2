Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA84E433A
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613476; cv=none; b=P2Z3blYswRL67TbwtKAwOai7bnE7G/PiIJMXuX5Z/E7mHbaat0J7r31xkfCkKZE8rSozlepe+Dc6uoTWCUCVSNAAJE9DGxUyHZNyYpLeNuwBtNHZTfH/TXDcsjD8FawSFmJJ80UUg3iZ+gcx4zo8Zm3vFffieqR8Xd6jVl8fbX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613476; c=relaxed/simple;
	bh=IXp+DNYl+BoH3Oqn6yr0ixaywkuluAO68ZDn2+oQlXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWm2Zj3qgWlh3EVHftvW99eXnmmj6hrzEt2AHai7x8uLZNk/HXp5riX5hTTF+CvtL7/L4PSCbbBacHQZ/Tzrnm4PZFHqtLy8L/xdj5N1E95yADkm/A+Gp8RdeiEcq6pR3RmmCDc7ZOJln3xiIvMAW6WirKdC375isKY8seSd20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pE8sweve; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pE8sweve"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d3b445a84fso90635ad.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790613474; x=1791218274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M/MstH2yf2DRt7ZMfWOotv8NrOEYhdb7bl9lXouyXqQ=;
        b=pE8swevejwo93+ZmhKIbrPje6BVYus/8j+iIptZ1lP9b/XPGsDuprbrjOfUrMeg/pD
         sI88T4DBDI2YNRLdc+01yMtcC/ikry+qJy7o+FtvkjQ435ncyill+croaLKP+1gujxzI
         ir9EcasAb6m+WLxOR/EHcfyw7TKXHpfwYFAkDtgRRGlJmVnbqI40uAaA5DM8DzbpIduM
         3cuuUcod9kwj3doKIwzFq5MZsawRep8kEW1TWlFI9wEpybXxujKVU9yKKmu1qoylLpkT
         xqiuDlzZUp/Tewr+/g7+sPRnWzcPYsFC6t8T9zMhWYezUKp9rMT4CTIkz5B7DnuMNgLw
         ic+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613474; x=1791218274;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/MstH2yf2DRt7ZMfWOotv8NrOEYhdb7bl9lXouyXqQ=;
        b=EAcMTL7y1M4qrNCV7XICN4itJhIt5H00UP4A1d8wr8VtHPKBktu1uPAkmkAfAigJnD
         xZZ/pICjzMAO9ktuSPYMwq1w+g01U+vrk79i5+zagloZyJw3tqHeKovoIr+avMAXATKI
         GGbUGApGwDFdaORQqw0Yrtad4gRUkWwlZlZ4Z0EhFm5JiL8AuKAPMj60rSnRu+QE3WkA
         NIDzbcPJ7nE9DEg1MvDuIHts/QZ+gYrwiuyKvj7GQMCPUJwyL50dj3rqTiYFrWVAht+9
         KWiJWw3GSLCUuXWa2+pQEwV6vXJu6j0W/5fBERqpqcyfTldJvtZRE0Eoh3kyODzjsE0M
         KLVg==
X-Forwarded-Encrypted: i=1; AKwUvBwppgtgULUqyJHYd1w6VtQKZm93+2mza8VI9Bknce5NbmcFGuz4ZUotRethg4Kj+d+FoMf7Blo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrA/OuC2tY6u1cfHTvN2QjoCHcaHEvusttOuu9ghKoHW6tJqz4
	f5EUTw/ChW19oKwNqGI+ibG4mOfeGOdTtnfhkBcd3IPXq8C3YxrgNpZjyku/lQ9yhg==
X-Gm-Gg: AYBFou2ohDtqCFPZdXoZMTdJZAMvYQmym5KZ8jUlj7Twv7qxjcLnozyVa54tKUR9qRZ
	f5ADnXXuXDzAWF5Xacq/NoGEZU5CY/UPJxzWfPBKXTrG0gE4UD01zBhPntTZSeVKYn8wF5CdV56
	uuvq+nZOs5fza/6uwa2fNnzgq83hj1kWuzrtGW6175VufYPHgWjN5foW35kVcHT+7nS9PwCh8/W
	Dp2hLtnMDzCh3YHkHwJjwAlid7m9Nbpa7ugaoUeIUUdN+Y6ulq5vafDacHCrw8C8KYw/cYUDR4U
	mO8em/HbvGAswaFy76I9reKik94fVE3vxyGsmo3qUK+enGqOkSEk77OrXKxplTouXYj2Byd6YZR
	+Ljlme8//C+APMpGTX/PO3JWcBUHcBp+WjoVKdyjbNUt6ekT2+6mphq1R0udeuji+ysCPFwDpZe
	UjT+pmf40DJabZnockuy8L1T5oR6wOHAOCdtZBxE0Yw4w3aF08CXhyfKGFgLK6jQqyFRD1utP5F
	9/vt5a87StUsVTXgQIuaw6oqpI2h5XaH7td
X-Received: by 2002:a17:902:e884:b0:2d6:3c22:994e with SMTP id d9443c01a7336-2dfa976fec0mr5954175ad.11.1790613472819;
        Mon, 28 Sep 2026 09:37:52 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea78fedbsm4448464b3a.23.2026.09.28.09.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:37:52 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:37:44 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v7 4/9] iommu/arm-smmu-v3: Optimize range invalidation
 for latency
Message-ID: <arqX2OC71JneElBJ@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <4-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <arpohmaJTPEEI7mi@google.com>
 <20260928135007.GA1616761@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928135007.GA1616761@nvidia.com>

On Mon, Sep 28, 2026 at 10:50:07AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 28, 2026 at 01:15:50PM +0000, Pranjal Shrivastava wrote:
> > > -/* Used by non INV_TYPE_ATS* invalidations */
> > > -static void arm_smmu_inv_to_cmdq_batch(struct arm_smmu_inv *inv,
> > > +/*
> > > + * One TLBI command per IOTLB entry, assuming the entries are all at least
> > > + * iopte_granule sized. Returns false if too many commands would be needed which
> > > + * indicates too high a latency. The threshold is similar to MAX_DVM_OPS in
> > > + * arch/arm64/include/asm/tlbflush.h for the 4k PAGE_SIZE.
> > > + */
> > > +static bool arm_smmu_cmdq_batch_add_single(struct arm_smmu_device *smmu,
> > > +					   struct arm_smmu_cmdq_batch *cmds,
> > > +					   struct arm_smmu_cmd *cmd,
> > > +					   struct arm_smmu_tlbi *tlbi)
> > > +{
> > > +	unsigned long num_ops = tlbi->size / tlbi->iopte_size;
> > > +	unsigned long iova = tlbi->iova;
> > > +	unsigned long i;
> > > +
> > > +	if (!num_ops || num_ops > 512)
> > > +		return false;
> > > +
> > 
> > Should this be ">= 512"? The old arm_smmu_inv_size_too_big() and
> > arm64's __flush_tlb_range_limit_excess() both fall back to a full
> > invalidation at exactly 512:
> > 
> >         return pages >= (MAX_DVM_OPS * stride) >> PAGE_SHIFT;
> > 
> > 512 is what a walk flush could generate. For example, when 
> > __arm_lpae_unmap() frees a last-level table on a 4K granule,
> > it calls io_pgtable_tlb_flush_walk(iova, SZ_2M, SZ_4K), hence,
> > num_ops == 512.
> > 
> > Before this patch that was a single TLBI_NH_ASID/TLBI_S12_VMALL, now
> > it becomes 512 VA TLBIs + CMD_SYNC for every 2M table freed on a
> > non-RIL SMMU. The same check carries into arm_smmu_tlbi_calc_single()
> > later in the series.
> 
> I had set it deliberately like that so that a table flush would issue
> singles. That is largely based around the feedback from before that we
> shouldn't over invalidate.
> 
> We've been insensitive to that issue in the past, and I'm going to
> argue the >= of today's code is a bug as it effectively made alot of
> iopgtable actions turn into new full invalidations, while originally
> they were range bound singles.
> 
> So I view this choice as a return to the historical behavior before we
> started to fix the soft lockup issues. I guess it crept it during one
> of the refactorings where we merged the SVA limitation into the main
> flow.
> 

Makes sense, thanks. I checked and before the invs rework the only cap
was CMDQ_MAX_TLBI_OPS in the SVA notifier; the io-pgtable path issued
singles without any limit.


> Granted I didn't notice this detail that the current code was 511 not
> 512, I will add a remark to the commit message:
[...]
>     The current code switches at 511, but this turns every table removal
>     into a full invalidation. Change to 512 to try to minimize the amount
>     of full invalidation.

Nit: that holds for a 4K granule. With 16K/64K a table removal is still
a full invalidation (2048/8192 ops), and the limit there actually drops
from 2047/8191 to 512, so it may be worth incorporating in the remark too.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
