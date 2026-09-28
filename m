Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B78340401
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619946; cv=none; b=L6emAzkAzDWUPKI/CwZ/6EF1w8wJtSiRV89LOZVS1XKg/qDthx7XVpvr9bdhlVDD3VKVDU2+BuBNOLtmGu4dlN+q+KYOY7rvXWMCyZjX9f6S+YpIh1dJoGJZxy0EHlNF6hLBhwkwQTgUQXEc83jdIMl8lIHjYA61dcuetabuu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619946; c=relaxed/simple;
	bh=S6eNU2hZhNF7ss9QpaGLOW/V81g2oJ53iDZrrOnsD4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZi1Kyq0WEIOjOR+iBoqvSMo1PMP4gi3fVhWbfEXeng43S+spLxP7d7gNQrXOZ44GZaESErei1NYnXmTSwm73Rwn6xzLg1cl68DCQzd+31eRDOjqf/bZ8VnLT3+PRuEIEbIZ1z3k/ceniyCo8qEYvJfQcw8L0q56dcSZlAl0168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IO4P93KI; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IO4P93KI"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2db33db4de9so8075ad.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619944; x=1791224744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6xtdmPyxZgVCGy2Ldjj48nQ82FMLqqca6Mq7V23FWM=;
        b=IO4P93KIDOW+P2uTRUmyRgsJusEnS4QCJuxRc3bgygSF+I0gLWixDuZMwr0lOdyBCX
         Fzs9cwJm5EoViaFVszWYzHwHKNB+ABpQm06hOfX8IFHIm0uxt88SVpiuesF2sCqaMDqu
         sFJVYUfxtaqVdbCkQqOu4FFXrldFeFwgUH27nzUFslCXQVVHbSuiE0Y/Aqbff4gEL4jM
         uAJDLTELQhGz1OLzjtwOnmP/QoNqqvmZCYpEE30Gy/lQTHhhVnDzWc/hHKIcuGJQRxu0
         rWdaXaOuWQf1tRn8VQeTYonGCF4yaU9mQA3eBUjDOdAXkipr8ryrZWG+BqnzjPZAxtco
         nU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619944; x=1791224744;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6xtdmPyxZgVCGy2Ldjj48nQ82FMLqqca6Mq7V23FWM=;
        b=bvO3K+QBrsuiNr6ZSKPj/OQYh2XySSNC13doVLIiclZWtvCT+RuK8SZsh3YOLNp4QN
         HO3cwK9SNTJZTsZ15nP3kmSC9pcWQTIOp517mfgj08t7BOjJcnDdJrrVDHJ23wCnlsrI
         FTYlJMfmSPCp9v/gFyk0m0xB2mqNUR3EUeS/3UU92jS9jNP+8ahz8fzOvc8Jv5qEqSYT
         UhP7s878zeB+EZRVSPLOj7bFiQuezRbQ997sxK9aP5cBeatCJwwx7wXESiq2F+zVEN8x
         cuLiyeGjL5gKWGce5PzikE0jGUXsmPhgP8e1oigfobuhweaYAZSAwKvqJcRdhAzlb/5B
         yHpg==
X-Forwarded-Encrypted: i=1; AKwUvBw84hnuJADS7kaBo4ZcE2ZVDVYgvlPvZkJyvw+wa8ZDJNK8z+zLBtA5L7i2zJIWdV5stQIj6Fs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLS52tn+kRK8VlmnkE27CJ8zYsn5fsjloce141g9HICezzJkthC
	u8fxv//Lbu1Mkcy9CVZWzQbyMy1u8ge+9P+bLWWDSVn4XrSR5aBA7ti0d7Mvc4rWjw==
X-Gm-Gg: AYBFou1xESBfDTtG6kcDCXxULTxebZ5DFBs+3mULG2qzLaCZz5FnigKNR5Q3grMRgnw
	erGwz4EwqIVS+f0c2WQr5DLJLZD9v4Ei2BZQXyf9HdOuozQXVxQc5g9/iPM2Pv4KMo1nYCwFkg5
	60IlBt8+SMa6tFY0iXebJr1ZiGBBgLTHCpikBFzMUAWuJlR2hLdjBviSQn//XpvWaCJ3KODhy/Q
	KXM68xkwk9Ms99qeeR+iPnrClvPy/tVzWPqm/UOBKGVl8wx3l2cWxRjnkHbDRL6sj67h51h5ZHl
	JDfZ3RrP6Lmd4IFTotnhCOZnIGhonXV9aNkwgAs6N5+gy15Lz9SqtJQeBrAGcQsR3VY617oh1Lx
	R4+ux+wBRblrpdUdMfpbvALVNcsYGyzfiuVIAUohHTxCYw5lxEulULHJi0vYCQiZnzwbcwnTiGh
	TOZn6b4iJZJMXIQLUydLufQyBMdiAhQpCp0I+CXrZLWmBOC6NyddfZyrCQ9u3/6btRVgcRqlsUX
	w5QLOYuMaRZjfBb6kKHfsnYVMH2i2fD5wiz
X-Received: by 2002:a17:903:3a8b:b0:2cf:9ec1:ea6e with SMTP id d9443c01a7336-2e2c600c613mr28065ad.8.1790619943076;
        Mon, 28 Sep 2026 11:25:43 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858c123sm831538a91.3.2026.09.28.11.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:25:42 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:25:34 +0000
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
Subject: Re: [PATCH v7 8/9] iommu/arm-smmu-v3: Change how the tlbi describes
 the invalidation
Message-ID: <arqxHgwVXcS5PIJZ@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <8-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:16PM -0300, Jason Gunthorpe wrote:
> The range-invalidation logic has long had a FIXME that there is not enough
> information to properly compute the range invalidation. There is also
> subtly not enough information to properly compute the single stride
> either.
> 
> Change tlbi to use the information format that iommupt is going to use for
> ARM. This prepares the invalidation code to support iommupt and fixes two
> small limitations with the current code.
> 
> iommupt is designed to accumulate all invalidation into a single gather,
> then the iommu driver should issue a small number of commands to execute
> the gather to control invalidation latency. This is in contrast to
> io-pgtable-arm.c which generates many gather flushes and direct walk cache
> flushes as it progresses.
> 
> To accommodate this the gather will accumulate "damage" in bitmaps, one
> for leaf changes and one for table changes. This is enough information for
> SMMUv3 to compute the proper stride for single invalidation and to
> generate ideal hints for range invalidation.
> 
> Change the inner workings of the tlbi process to directly use this
> new-style gather description with the idea that the iommupt conversion
> will just direct assign the gather fields to the tlbi.
> 
> Rework the three places creating the tlbi to express their needs in
> terms of the new bitmaps.
>
> 1) Simple iotlb invalidation always gets a single range of leaf
>    levels, so it can set a single leaf bit
> 
> 2) Walk invalidation is expected to clear the table and all the leaves it
>    could contain. Set a single table bit and all the leaf bits.
> 
>    There is a weakness in the existing io-pgtable where it double
>    invalidates the leaves, once through the arm_smmu_tlb_inv_walk() then
>    again through the gather. Since these are separate operations they are
>    not capped by the invalidation count limits and a single unmap may end
>    up doing thousands of tlbi commands. Eventually converting to iommupt's
>    gather only approach will correct this.
> 
> 3) SVA invalidation has no idea what the MM did, so it will set all
>    the bits in the bitmaps.
> 
>    This corrects another weakness where the range-invalidation logic
>    was generating hints assuming the #2 rules which isn't correct
>    for SVA.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
