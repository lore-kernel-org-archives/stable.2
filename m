Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72B45A2AA
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624757; cv=none; b=gGXXkqFUupz5EWm4Mz7NwJgTnA1jCTU8da/69dNueJo9xd8ogXSLNGBmpsqFi27MM1hUIHuznKmX60lynqsEvaiOybknd8ArSqqT+yWNeXLIisc5EiEs7idQzMOokGu4oro7ced3u/nhmr2t+gxmKYKL+vKZRcuX0dj+iInKuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624757; c=relaxed/simple;
	bh=CTM77BtBAxRz/NUGhlV6ePIrWWx8detoQl79hBAb/aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InrYq/XPG0xxC8Uk47uNBA+QyGaLJBZOL6y6Ol+/iR5lITaQzbAfbWz8ADF/IGAHeLqpc5VgOll6jjGKZL0i6HCkrhauv1rQJT1hBzUzaogFt8guIScTM+WMZvnLKkBduEBA+J8evyYNSnPFCLMBRUqMDYvHKmpLQG9eOC5R9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=raYE9ug/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="raYE9ug/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2db33db4de9so12575ad.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790624755; x=1791229555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J1T7FYtEHLzKBOAf0DCFYQLvpaY4ZVWXjng9Q2koYuQ=;
        b=raYE9ug/QFfJodxahZajkSnqSzDLSE/wyQ1H3Ykg4GuUOIoYlqrZFV2u0DH7m0sebJ
         +UaOVs0pctUqfVDuFDM3dQ1DmScY8OquARMr0iYRlOoze+a/11bWGBtSHSlLyu3uriOh
         MTyCCamdlM0In2RPnQ0nbta3vsyfx8yKKoKMEMWRmb1rYbGtqMCz8+uNMLinLgLR9shL
         YQ6kttURI+k/oQZ58+Yr3kkKt3ioQmUYEQlvYlMz/Y/1Mel9PyFTiB6K5aSt9HoWwWDk
         iLCa0b+Rmyds05sAX4nrQselCsLMVmlRoPsPO2LS1o1sNCCTCSj9p6lLwPtL1xxCvKHc
         UI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790624755; x=1791229555;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J1T7FYtEHLzKBOAf0DCFYQLvpaY4ZVWXjng9Q2koYuQ=;
        b=Bi4vSpvTvH51RQx607HdElR0xsx77zmTFex/Ev44DY1vBnJeRYUKr0BGpqD89qvl4y
         wO8EZgk6CSJHa00W2AGescjWexO4k/mi2Qs/UCr9p6HuuDRhHS8jwfEDsXFLtwq/w0hQ
         T1zTt48GHFvdkPkyixwh8s3DT0q4c+Cm7TbY1MgQY1rxEY+JRRBKHXQ9Anu6I41coH0u
         01Nxw844LcRimnaRiwHaLWaVOXd8CsLP+2vaKvu6QCC8vWrHqGAKW+p+7hU4Al88hivI
         Y2bPW+7K0GzaQ0O5r8rdk8GBcU4wx05+/d4mcVap1ox/eP9XQKxN7Sarilot0iO/Kp2K
         Hlhw==
X-Forwarded-Encrypted: i=1; AKwUvBxyJ2rqjnUo6Jy0U830RN3f9OtAPCb18osHeNnStEgEB073kQp+YaIFp0yGbB7Xo1oid+Gs55s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgI+jandgmFtBOY9cUHlt/kfXF1IBuRsRp73ywLOw3SwJqW2lO
	Nsn3hajYFMpmEu/GqUz5V+UzM+n06P9g8yWc4B3Q2Xdqsyf5CVdmTC7+hw0kRYZCbQ==
X-Gm-Gg: AYBFou0Be1vM4y2o1gX5uTh5CBilRG8HKz5Qsc0o2Hk3xVDPltrFcRwJRc07aWSVln0
	OQnv8A09NKQ1//TAFXvf4V2CnGr53hba86dpuqJOQ2vb5KHBVH31L84/WoUEm4XiWI6bmzPy/YO
	gUNYfQLrGA6yQJ7Un2i0lwscVmIFlK7i1TPgO29a6ROsgqNIE9CWHojLfNWkZFycOE0zqaXfeoj
	Y2eaAroLx1yZYc8OBh73r9LDWiSHk1mlxyT5bgjWeRSsWo2FkQ625C9SuFRvUP37qJR/C7IJC6I
	qH2q8BLJPtqIEh2rR4IwTnCPBWdoc4u+MT2HvS7v+NjhYD1wZavEwYMb3Di1hawgreIU0FMB/Uw
	RHzmkzoa6iLWppz645PIbUmORjn0SbY2okPO/kIwaJhTqzWqjP+u1kpQQtwnIfPvpA86gTj6c3b
	lz1iKhaC4cAzzegqJBRQVWGb/6zZ7SnV8h8L/jUUK9+zYyHAhH2YJzLQBt9CtTOozXvGrNvGUJo
	QR+vWG0drcRjXdUIbkFcGHn1FOLNzCHOMy7
X-Received: by 2002:a17:903:4b0c:b0:2d5:db3d:1a42 with SMTP id d9443c01a7336-2dfa9773f0fmr8136125ad.15.1790624754609;
        Mon, 28 Sep 2026 12:45:54 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4926b3f9fsm1077587a91.0.2026.09.28.12.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 12:45:54 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:45:45 +0000
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
Subject: Re: [PATCH v7 0/9] Organize the SMMUv3 invalidation flow so iommupt
 can use it
Message-ID: <arrD6aTjENIsa4sO@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:08PM -0300, Jason Gunthorpe wrote:
> [ This is part of the patch pile to move SMMUv3 over to the generic page
> table, the precursor patches have been merged now. What's left:
>  1) Organize the SMMUv3 invalidation flow so iommupt can use it
>  2) Use the generic iommu page table for SMMUv3
> 
> The first patch should ideally go to -rc
> 
> The whole branch is here:
>    https://github.com/jgunthorpe/linux/commits/iommu_pt_arm64/
> ]
> 
> iommupt has a design that focuses on building a single iommu_iotlb_gather
> for arbitary batches of map/unmap operations. The gather uses the free
> list and it captures invalidations of tables, leaves and supports mixed
> levels.
> 
> The introduction of PT_FEAT_DETAILED_GATHER provides some additional
> information that is useful for ARM: the damage bitmaps for the table and
> leaf changes.
> 
> Prior to switching SMMUv3 over to use iommupt prepare for this by
> reworking the internal invalidation to work on the same data format that
> iommupt will produce. Bridge the invalidations generated by io-pgtable
> into the new format. The conversion is simple enough, io-pgtable generates
> invalidation operations that have only a single set bit in
> table_levels_bitmap/leaf_levels_bitmap, so we can convert the io-pgtable
> provided size into the proper level leaf or table bit.
>

[...]

FWIW, I was able to run dma_map_benchmark for 4K & 2M 
(-g 1 / -g 512, 1..256 threads) and I observe no change in map/unmap
latency vs. base, no measurable overhead on the leaf unmap hot path.

Tested-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
