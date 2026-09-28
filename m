Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EF399007
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621085; cv=none; b=NY5kEmxmd9u+6S4g7iHiDYQxE0mH41q64hSCiCsmIzGv0zRTM97TDDJYMznskFFD+AyC5QVYJjmGDrHHy8PCM2FiSe7+hEd/2FrMAkp0ErEbLsjK6UmQsofJApmBR2npbfkatBreMpaN0SuKZauO90uKlkJAMXDT3AviYKMZQPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621085; c=relaxed/simple;
	bh=fgZb1uyHuREpfJhcxIG+6xsb2Dd9OodLn5MW9pjjays=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBaxatrPahhQ9GeJJZy1PlET3PEAuLHZ4qtl+sHnG1Mw2wZR6q1r2D5i3cVhHtI+mPQHtOG7EJw1QMhOSGDKZE200syHm1vQL0Ll3lvt8xht//lyoWCh0Y6/fYPBUD26GgFbgbd6E7gXCv1oULGTVyphOqX1xt4qy+KafBGcdOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kSfdOxTF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSfdOxTF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2db33db4de9so9345ad.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790621083; x=1791225883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fGyq3NjAgVBa/imXLuFDsnsoYGS7geOe1+K5qFW3IBY=;
        b=kSfdOxTF5Scyy5fJt6VhBZiI5SsHa2DPHJ3gnBQgpGaCa+oo7DMjCzCasj63XNl2HH
         cqrjT0LCF+DSLv0HKmavGwuEZo9CxPtJz4tYxCXLd0zyqwFbtFFQgeBpeWYbnWH0k2lJ
         F/TLCjR7kZjWoOTYR/9ryI0TRlbdveu9tLifJuMZb3U+vGWI9soDMDpMffskdrcWOb1Z
         EpZX2GFl8k+ODl6XKEOWuw2+TDyWbqWVHvC1Tdf/H9khU1sY7zSY5rluTQSqfqITJ7A6
         RIQQb6WgL64SGjLgLHwlMWeqXC0iBpF/lb5x+Vx15ntatofbTECUcqFBnH3ObvNuFkHM
         lS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621083; x=1791225883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fGyq3NjAgVBa/imXLuFDsnsoYGS7geOe1+K5qFW3IBY=;
        b=OPew5hc4DBETcKYoQLq9EDX8EXw8376k5DJXJg6FGxvQ5CKPm7kgBRE+j1biAVWz8d
         T7dGVv6HKY44I+VbYCVSMRyU9GP/lvNiT3UrlndJxWgmb1+b03gtF92PDYDh4takNqMO
         r/NOXk+8xErgbBY0jAFpZemOk8PnqiYH29Sms4s13vKUhrSd7z8t8+Dph4qqWipq6H9N
         7r+8nKuOupIrpFeNH2VXSgF7cPFvXClNBjlKkMk6ypHcm7zMpuI1TvkdwhN/jMnGz/kV
         a2eTe5uEIbR3xZoCIMlukMZgXaIJCZ5IbgiMP5EtQNa12OQhoRWbPOHDVIGjne8SytYo
         Rrjg==
X-Forwarded-Encrypted: i=1; AKwUvBzbRG2VZb00fwxxSwuBWjmigGA/rHMtmOreq/hqpODZBhHt5s25Fu0+zs/mBZNrB750OtXR0As=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAXDOFhoglKUnK6TL1B3sliCNdQHFXQBBmvRy8FL/RhZ0OGhHi
	kVnT9Y1YSOHqvqOQl57uj4kRLu06wglwTBvY31N0DayFj6oxXZZfuvPPwexrISHWjQ==
X-Gm-Gg: AYBFou0H8AHN/ZYKQCIcgoizK46QgkaHgjDCydkp6iMKDersxc6Zifk2ecO/N4BAaN/
	bpO5B9yYsJH6KLiqM8P51zXVVcXwOFF5AKheGpCALf8dIJAO833kixf/mp2y6XQVfSIumM4MP1h
	YNUZBqedtCM24xWp0Q+titwQQspylvhQO04myUqx8m16Swnzcc0QFQytclyRRJtpp2/uDI9YiE7
	eWEZSoq1zRf24VA+QV6aAmeL3Oa6VJv+BHSLSQdPp5qL7KWl7sL/gwiuGAKg7d1oe+AEosefyuk
	/VGajHZm4G2yMWthQ5Y7pwYZQ/3h674x+wMa32btgBB7ym0KYfs+4bVKQnNsGaZvblVv4XerH2K
	LKeAAh59F/EvjM/kWACyngNnwqyxR7ABydqhsCwDWuTCNlkX7npbV9MFuXPLy0bLr7MvgjW0SZm
	dPw690jYnRtaogFe9qaPyj2RH+70AligJm36UQ8SZ5nwti0TbvgJQl9Zp/jgdG/0MrIGKyMmhMd
	eIrkhoI8tmdScJLrYw3cHqn3aAMGofsEnnf
X-Received: by 2002:a17:903:3a8b:b0:2cf:9ec1:ea6e with SMTP id d9443c01a7336-2e2c600c613mr90615ad.8.1790621082290;
        Mon, 28 Sep 2026 11:44:42 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4986a1910sm767152a91.14.2026.09.28.11.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:44:41 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:44:34 +0000
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
Subject: Re: [PATCH v7 9/9] iommu/arm-smmu-v3: Support the DS expansion of
 range invalidation SCALE
Message-ID: <arq1kpVwCUO8xrh2@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <9-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:17PM -0300, Jason Gunthorpe wrote:
> If DS is supported then SCALE can go up to 39. Compute a scale max that is
> compatible for the entire invs list.
> 
> Replace the has_range_inv in the invs list with a 0 range_inv_scale_max
> to mean range invalidation is unavailable.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

[...]
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1060,9 +1060,15 @@ static void arm_smmu_invs_update_caps(struct arm_smmu_invs *invs,
>  		invs->has_ats = true;
>  
>  	if (inv->smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> -		invs->has_range_inv = true;
> +		unsigned int scale_max;
> +
>  		if (inv->smmu->options & ARM_SMMU_OPT_FULL_CONT_RANGE_INV)
>  			invs->has_full_cont_range_inv = true;
> +
> +		scale_max = (inv->smmu->features & ARM_SMMU_FEAT_DS) ? 39 : 31;
> +		if (!invs->range_inv_scale_max ||
> +		    scale_max < invs->range_inv_scale_max)
> +			invs->range_inv_scale_max = scale_max;

Nit: maybe a short comment here, e.g. "SCALE is 6 bits when
SMMU_IDR5.DS == 1, values above 39 are treated as 39 (H.a 4.4.1.1)"?

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
