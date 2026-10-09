Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A7A48551A
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576258; cv=none; b=OxEe0RWDJZ6HzYmOy/cSlPuq0PoymE3BMB2ILP2RiMKF5P4mcYOawVZneR39DSCcthduuz7ofyapg8cuFjQ8XqG3rG0ACUqhdNK3mE07ncpW2+n0CphKCAicCREFq5WOWLI/Opv3cAyi2U2MgujLNAUuJNVFuDThhXL7Ce9/Fgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576258; c=relaxed/simple;
	bh=hAluV0ZsKWum/hosRJaag7DxK3pHK5KP5bP9qisBpl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEJ+9IkJH2otPvX7l7dz6xskeFo4MtKecRFabTAlc3UmYlnJ7EMwD2aSFI6ZzFCB3Xphr9zWZ1OWSe36elCAxaaw66Ajd9ODDgte4KrxTS8xZW84UOgl2HKVhqXquV0bu3TXSUt4RTfR2nm5QsFnuuLqfNi0dH30m3hlFcXrq1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=E50PmzQ/; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E50PmzQ/"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91791ec1b83so1814286d6.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 13:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1791576254; x=1792181054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F4LeZey2LdZLtm6I9smRb+XZ/TgW85BBKXmmgDgTNho=;
        b=E50PmzQ/PjmpOByeW9O3EepiGBLd4OLXgqSvmp/jH2+tsnlH/TNqbU8FlT/yDlHHaD
         D47/H/eD4+602EpG4vjcD7yyq3D+8sMJ6pK7SXK/ym8WCqnyfKUPamywI72ik2PrAYoy
         Nr3fasZ5ZzonBh/Cmajh6lMhY3yAAVejQBneS3cXASh5V25aRgcaFej8I+lM9MuR8ZUX
         9Lh1YrcKvCKkfxQaN6GtBHDdQvmMSJE1ko66nfqdqS4DMonDPbT/1Os9oPXUVIJUapvd
         ssx7mkTc6pog88s/H6wW3dD27wey4x0Y/11eMuSjU4CnnvSZ6a1Ht4xXV6obsPTLXAFC
         7rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576254; x=1792181054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F4LeZey2LdZLtm6I9smRb+XZ/TgW85BBKXmmgDgTNho=;
        b=OjQyT/U4aRWk8AiTUKRPj0ERdZMVi3sYTUVk94CXsV101d1cP78A9L13psjKVBFijs
         bq5G0GCmtCku1DOWnRbShEW1n25haK3e7Fip3OsbGwaLrQOuDz4oRmTSIVtvCqUMkfxF
         wqjGv8a0dYr+Ln3JVWw3Lp8An4MtonNAmavAo4ViF6Eq8s49ly4ituE9WLFGa4QdFx6H
         b93UKeID6aJwZtf/js2AP3iJI1na44T0rMZXMhTRwww29ILTSHfVdNWKZ/Z5oYqdS/pT
         sRTlYtjrjq0o54ujI5bAGTqQKuv9+7sCRNx+PjJtw4EovciDYX+sQ4o6ym2850rIlVDm
         DP8A==
X-Forwarded-Encrypted: i=1; AKwUvByK559JlM288l29wGWfpEG9I0u5S8dKEwGfvEx+vG6eWyJA/KtKEu9HPuVyqok3kfv5IibhGtE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIYWuVSZydId1J4QqdWNZzWfD5eF9sDWmvKe7IHMBKI67SaU4N
	ZaghutiJWrkQEPiXU7Z+fR6EybDAKVYk+Tona2WJRj/3q2+rbo8MWl8auFNCTfFQqsA=
X-Gm-Gg: AYBFou33MqGfcoK+pA2ZyC/FZGVw5XrLNibvlpEBJTlr6RGly5VRlwPhVOuu/nzdPeY
	qdidGFvG/we5/ttqIBU9sbhcKqsFtPzUsNruXkBOV098MuKgaNAFFOcaCyK6/7TUY+REEyPmFw9
	YVrKadLl2m8TH3cK4HQ6p8jyCYVXycPFb5CR/b61JGA3JpTun1qZ9VTZnC6LbKq8ocBRBtB8Ibd
	FPb30dkHF8niVVL2M4eQ+KRSr3k66WjWw3sCtEiM1+WXdCq7wNHQ3PVtVby7YFQBrXtuTEX8SFn
	nd2NP3xncq56Pr838xGOaLqATAyof0amBMJstUj10XWbZVBbHRfEnrWe187pedvweZVHSk8sg2e
	6KP4VgHDPxjHjjbNMa8yJdc/dWcF1UKjHCGK7U1U2LShSzQ+Gf5h/WZom8yjPeuu2ck20njC/ED
	VH2mQyNJimIJvswDl9uLH97YQhVQUsQh8/ASWkO+95gGxP4QeErP9bi/TLw2FJf0SFO02g3zsSc
	mp0JCx/5izrDCBLmx0kjZ8qDbfOWdTppX6gvtVVyq1Hl2PJNwQdTqv4
X-Received: by 2002:ad4:5aae:0:b0:917:aeed:9240 with SMTP id 6a1803df08f44-91b5555f788mr51483116d6.31.1791576253590;
        Fri, 09 Oct 2026 13:04:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550ddf7csm26430326d6.42.2026.10.09.13.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 13:04:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xFGp8-00000000uLx-2ouW;
	Fri, 09 Oct 2026 17:04:10 -0300
Date: Fri, 9 Oct 2026 17:04:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kevin Mitchell <kevmitch@arista.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
	stable@vger.kernel.org, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: allow identity domain during device release
Message-ID: <20261009200410.GC14213@ziepe.ca>
References: <20261008202530.14501-2-kevmitch@arista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008202530.14501-2-kevmitch@arista.com>

On Thu, Oct 08, 2026 at 01:25:27PM -0700, Kevin Mitchell wrote:
> @@ -2548,11 +2548,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  	return iommu_dev;
>  }
>  
> +static struct protection_domain identity_domain;
> +
>  static void amd_iommu_release_device(struct device *dev)
>  {
>  	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  
> -	WARN_ON(dev_data->domain);
> +	/*
> +	 * Devices with direct mapped regions are attached to the
> +	 * identity_domain as their release_domain.
> +	 */
> +	WARN_ON(dev_data->domain && dev_data->domain != &identity_domain);

At this point I think you can probably just delete this WARN_ON
instead of trying to fiddle it like this.

Ultimately the dev_data->domain should not be set by the identity
domain, Vasant said he was going to work on that clean up..

Jason
