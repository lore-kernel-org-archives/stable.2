Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0928237D12E
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082852; cv=none; b=P68M/qdwSgI1/Vq5HSzalaDOnbwvaT1P0b5/yK6e3uulk3z6dM+1XqB9HcYmNzedhUhZYwmwHeaEE1rkU2vdsI6tscBC0rXFbsLMu+6dJER1f3rFEOJvVA7WGM8e6kA3AV/yRusR4luHtVUAxKtTl3Pbg0x3Y3dJvILQ0qYVKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082852; c=relaxed/simple;
	bh=weMclR0JbsCcCqPg/uiyIcYyJq2ObcwTZTr15YLIsZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPiQ5yL06YsEQmqawzuQRbd5xF73f/tu8GQt0Im4knLx41SnHpNg+JL7UMuTb628OUrRgvYBMfFojzYyyhpq8drPhEaPAyocktFiPQFh6usIWOrtG3stagAEqx2gWiDtcggzyrNp9+cU2sj4P6gsHOnDbAgJRNT5js3pLOH1Jhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aRKFtZ0G; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aRKFtZ0G"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cad4170e8eso29206215ad.3
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1785082850; x=1785687650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xYJV2WaFKQ0XZvcTBC+xPmoK69d/4/DPGZNWJ9OK0BA=;
        b=aRKFtZ0GJHrHpuqfvgmauuVULU5WKy+KGy3cOAVR1mgQBRvm/iSX0/WCP36wpnVbtY
         6rcTV6s3+Ia4wTNM6zssepggNdWhDa7Yw4CM+RjI1XLGQy3dVx/rOadhfje4Zl0qmLOZ
         zZ0nQ90jZQe0XOHXH66+EUbZJJOS3emFwNB8heI+3IIc9QYQRZTmwlDlmdRpQXP0kSGH
         Cy0kiYAmgGOXG4SAKsN9xLHOD/H8mnIiNLJ54oapbbs1ixU5eWqPnNJVmV3Felm8T7ws
         olnTG7wNF4g9oR5WvcJGqivS5sW5phqgZFAD1S69POvoJmkW/Hrz4zUCXRjgr0BDBabm
         jzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785082850; x=1785687650;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYJV2WaFKQ0XZvcTBC+xPmoK69d/4/DPGZNWJ9OK0BA=;
        b=h8a6rAfUq7/qwv3wP0OQW4Fmqd5XeTb89c8BlPzqELF8NqFHUECLoblVmdXKq289+L
         9Huysg6wyJ5N3BCMKwXmtXjZZPMqVi/qajCcpm8O8+OwhDrQY0K4jxLNTVDkiqr/K2oD
         mGAixR2EFqKJ5GmtryG3XqfoyqFcFdBQqhWBiVuWfZfbbLx67Z7jv8AwJW78kHCBk/C3
         QzqU81VT6IMt/BjC4Nti5bpT2ddHEHF5ZmAn/LtUT5YFLP7oBndBqPO1kUepetNCuGgb
         KyJ5mUK0HTvMXZvGdJmzV3Mi9JxfjzJ/G4ZyTKBL28qbPj8UBvNlwWzgKMRax3jux29o
         dyIA==
X-Forwarded-Encrypted: i=1; AHgh+RoqAvLw5EdAXjuc8B0GQ9PQOscnmgnBAk84Q5goUlaN998qFymQkJdRTnDNbad980Oh/LuBtAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE+FyxD/HL7UkGRXtewhT2cr/C0y/9CUdLbYywCfK8YNy7PQM5
	w5Twan0DLIdvfMi08aqWG08rEI3PoFV42S+N6pLD59JGhL13r0xgaczEOuRXYGt0+LI=
X-Gm-Gg: AR+sD12ns6wTDWJcdUGUCfTB/mjHHFf5d3S6a90YlYCCziCX7T88I6Ucs3aFxtxZRsM
	L+qsbDninHECqZVz330YBzr7jyXpkmg1UnH9kTakuCNvw7X3cIWoysJvleoK+4e5JWWKEnM6g26
	5izqoISXjHd82ZhJTgXPZ82+b5WLdKQ08EM015qS/LlBx2swhYiTcTTxDJ4wMRWiw8sfzdqrrz5
	c6P2PtJc1padGXZ74U4RS+wlUUq/Ig91NLAHGYxYlEI5Iby+6k2O5MoEFTr+0RFQOV/dLpsf6Uf
	2tL2qGW6Eo6VEvhd4r7TRVzzW0a9Xr7JxbBqk5klhTUfGMDgBnsEhjWchRS0Wzo8pYY8z78DSi2
	CMOIixzpFflFrzw3DNZQUMjWsEPptuqnnb++sRaF07LtEiyxMfC4=
X-Received: by 2002:a17:903:98f:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2cfde68785bmr51728885ad.5.1785082850240;
        Sun, 26 Jul 2026 09:20:50 -0700 (PDT)
Received: from ziepe.ca ([64.114.68.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81cd27sm22021795ad.79.2026.07.26.09.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 09:20:49 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wo1ar-0001SV-DZ;
	Sun, 26 Jul 2026 13:20:49 -0300
Date: Sun, 26 Jul 2026 13:20:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: joro@8bytes.org, will@kernel.org, kevin.tian@intel.com,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iommu/iommufd: Fix IOPF group ownership UAF
Message-ID: <amYz4X2N8bD0eZj1@ziepe.ca>
References: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
 <20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
 <3CFD314D0FE4D7EC+20260720085017.3998878-2-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CFD314D0FE4D7EC+20260720085017.3998878-2-peiyang_he@smail.nju.edu.cn>

On Mon, Jul 20, 2026 at 04:50:16PM +0800, Peiyang He wrote:
> iopf_group_alloc() links each last-page IOPF group into the generic IOPF
> pending list before invoking the domain fault handler.
> iommufd_fault_iopf_handler() also queued an accepted group in the
> IOMMUFD deliver list without removing it from the generic pending list.
> 
> When detach or HWPT replacement drops the device's IOPF reference count
> to zero, an IOMMU driver may call iopf_queue_remove_device(). That
> function responds to and frees groups through the generic pending list
> without removing the same groups from IOMMUFD's deliver list or response
> xarray. A later read, response, or cleanup can then access the freed
> group and cause a UAF.
> 
> Fix this by dequeuing an accepted group from the generic pending list
> before IOMMUFD queues it for userspace response.
> Make iopf_group_response() send a response regardless of pending-list
> membership, so the dequeued group can still be completed by IOMMUFD.
> 
> Closes: https://lore.kernel.org/all/B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn/
> Fixes: 34765cbc679c ("iommufd: Associate fault object with iommufd_hw_pgtable")
> Cc: stable@vger.kernel.org
> Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> ---
>  drivers/iommu/io-pgfault.c     | 24 +++++++++++++++++++-----
>  drivers/iommu/iommufd/eventq.c |  2 ++
>  include/linux/iommu.h          |  5 +++++
>  3 files changed, 26 insertions(+), 5 deletions(-)

Applied to for-rc

Thanks,
Jason
