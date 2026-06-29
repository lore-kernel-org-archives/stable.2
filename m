Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAA44D696
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750509; cv=none; b=J/qRZAhnOSHbRUpeE8X9wvMCX3DhJOujLOB43GSQY33TBgVvx0tOzCIQ26QTiQL+sYPkRpEKpxRomlH56K0BfxV2TxZFNT/xBraFh8Kn8xQje3z10ZLi7isJyQXZc0YxyceZxBfPa6rCQFuL70o/EIxmHV6eq3CvMMZpVOUaQqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750509; c=relaxed/simple;
	bh=HoZdwkQCUZWVoOYy4+KgRStt8L7Oi0ubrdBnrNiil7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuLbD+q9dIPtFACiYVwA//+u4svXQwFe/5N4i21/L9k/GMB+5lQJH4blBpZZF2COJ4BKNOfNrFKxquHgGjt4hvxwiEvL66uk6+iU3PjKLMZUxSDeyvs6HjqR/YOOqB9JX/A/hPC+MGtW5WOY0l6VX0Z0BU49HDfJQvJxvkcDMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxurUiQn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxurUiQn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso61825ad.1
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782750508; x=1783355308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bio6F01mW1uhzjb2Qp+Xy8h4WP35qzyJOdcn1fRlVDM=;
        b=sxurUiQnI9UrZmpGSrWpIpElvIk4/xzCDirQB3bCrmPHTaWZZ9JD+w65DMqMCoGHCj
         DtDHu9c4TGa2nxC5sVD+bt/WGvLCU0jspXd2WCg2bF6MNVFaeY5luSJugdGEWqYJYGpk
         mY5wWao2FYFVKgQmmF2KVzCvCMpa7h5TzcJTA1JfwnB/aIv8iMfcRtjCSGFQiWTbbTKY
         FsGCWSbUysHX3pJWTwHBaW8OUdqOSI8Df5Y/BLS/AcD4Z0rp/1/kPdi9t96CvXw4RQnk
         A05oh3Y2cdPJWnl7ykFrrb5Hhk4tjkWBDnSgxxPJIakfCO9QZUP1yVulhgRSwsa37uTO
         l3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782750508; x=1783355308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bio6F01mW1uhzjb2Qp+Xy8h4WP35qzyJOdcn1fRlVDM=;
        b=Ru0vZoO9jpAhjJASIQfk76YwyJ+DFw9zqVgkF7bhuMmbLlETBSESNFW/7T0QXxS+AO
         1HUFT2R92CvBeE2dwtkn/6FMmYVgfG6U/R3rJxbjVyYU/DyYKS4/tTzd+UH31usit3rf
         6Ya4Gf7XgWntqkQdB/prUX3v7DWNfJJud+WBk1BNyPjXsTRhOPAZgsi/cWT0t20e0Phz
         lBw7cTHa257WfMKhvW65SSHAdmd43Hv0CLQaF0e495ZXFusjjTN8inN37vxAEoVChV71
         LJFEtijm6t11NDVrOgFaAE/IItSHJFoW6l0/RSAW7SPrclKl663eKw5HFlpFeHpMgtCN
         EI8Q==
X-Forwarded-Encrypted: i=1; AHgh+RpegGlp8nggSl9iJJTdkVQxX8+VhXxWsQ0KAsJjSmM+sR6DW1YLAepqc43a+COGTAwrIhzxQzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvp98T4q7ZfEdRFRyu5DGfiUl4TaUCpHfpC2jlaQNC8UZ91yVx
	wkThQJp43x8bwp/tA0ySfepvM+mgsGpHCBIX8FYHL9KKpZoILylTOYM/MXl43LtjOA==
X-Gm-Gg: AfdE7cnJ5HzEcnqbVOtqX9g1cldFCqsfK62IYMEX/kZlOPAe4DhuHyjiu8Jfw640x3l
	HR/M/yRS8nDXd6xaAHjnMvpgupuGyIQ3fR21w2fZQj9zlOA9wfi9X9HzBYnO8n2KQwSzYuusy4l
	8HSdc1jWeIo/s4j0r5KBK0BpJQllYklTe929Dkx6GAfv6WBnQaOrCN5AHcEdTPX30o0x1XXqkpd
	AsMp6hsyZpwudtWYdLSZ931+btGEf6uIyLSmXjX2eX8hX+9vUMR3Rl6/mYPWQl+yW6wp2J5Q9bM
	QY1YyJPDC3wOMWW64Xr1/HgcGeHVYE9LEUVo6XtibIsGJzgMPYNk212qIbE0V+LEnmPlnGw/0RV
	gYq5/n4SMW7ieu0WvDHR4tp+SkuCtoc83cftS+h6f/8sEEO7CgU7xTuYOXQc8wNMs1PhzkDA7/X
	XNnbm/UbYWStT7Qy+P/4A+hq3V0alapkateq93/yvjODQwLC8=
X-Received: by 2002:a17:902:fdaf:b0:2c7:debf:2146 with SMTP id d9443c01a7336-2ca2cf9c2c1mr251595ad.9.1782750507162;
        Mon, 29 Jun 2026 09:28:27 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38052f4789dsm10213a91.14.2026.06.29.09.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:28:26 -0700 (PDT)
Date: Mon, 29 Jun 2026 16:28:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 6/7] iommu/arm-smmu-v3: Skip RMR bypass for kdump
 adoption
Message-ID: <akKdJFx7zhWtpjBT@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <88e75018e94adc2eb3db8c1fd97c3cc738c170bb.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e75018e94adc2eb3db8c1fd97c3cc738c170bb.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:23AM -0700, Nicolin Chen wrote:
> RMR bypass STEs are installed during SMMUv3 probe for StreamIDs listed by
> IORT RMR nodes. A normal boot switches the driver to a fresh stream table
> whose initial STEs abort, so those RMR SIDs need bypass entries before it
> becomes live. This preserves firmware/guest-owned traffic, including vSMMU
> guest MSI cases built around RMR-described SIDs.
> 
> ARM_SMMU_OPT_KDUMP_ADOPT is the opposite case: the driver keeps SMMUEN set
> and adopts the crashed kernel's stream table, so RMR SIDs already have the
> only translation state known to be safe for active in-flight DMA. Replacing
> an adopted STE with bypass can turn translated DMA into physical DMA, then
> point it at the wrong memory.
> 
> arm_smmu_make_bypass_ste() also rewrites the STE in place after clearing it
> first. While the table is live, a concurrent hardware STE fetch can observe
> V=0 or mixed old/new state.
> 
> Leaving the adopted STE unmodified keeps the kdump kernel using the crashed
> kernel's translation. That gives the endpoint driver a chance to probe and
> quiesce the device.
> 
> If the old STE was already abort or invalid, installing bypass would create
> new DMA permission; leaving it alone is a safer failure mode. Later domain
> setup still gets the RMR direct mappings through the reserved-region path.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
 
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
