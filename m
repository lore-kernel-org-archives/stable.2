Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E2C2BF3F4
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097359; cv=none; b=YQsODbFEOfpc9UQ/jvt5TvdW5BUcCXqASllSlEkDC96VgUacRLGmpjj8LmyLD99GUnl8//Yu1BgXKug74guXqzlbkNpouIECTjHcrDxCAztQr1bIClhlEVr0OZdPhGjiOpPtk/injo7scTwNhtdPr+CS5Wah/gKLe8VIK8i1ajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097359; c=relaxed/simple;
	bh=NImIZmSEszOUZywtJZSxACAiRqZzU96rD6XMWaHuLMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsDasukhQ67pZ78DCmiuhje7qWWMkukT0lpI60XimTe55WApa2LSV5gbfvsKgWCj1EiWqlk+x/JqyrdY5VKohwp+sj4GD5YKLMIdigVDH+gRLSSanGQKtvh1e02s/aUlQQZ/c6R3EBlU4pS390B9ZoDy183UB568dUUxMp57Z0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZsrGrE/J; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZsrGrE/J"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c1372f84dso5188861cf.2
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783097356; x=1783702156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QyotU5l8k0oAbp2gmOwsLK/XfEKLkjm+dMk7XQ103yI=;
        b=ZsrGrE/JCa9UqFweXEUFXoopadGiJ1o5dgKY+5RjVsPeb2utESZjaK/lLRxiuh4dGg
         eJf7KEkE1cDp5NiYKZNiQis3zKG3kMyyGHx1tatCsooulsb5onD2cuot26vck2NgBtba
         +94iSAj7jBjUqA1VhyRF3+ham9QdpJ37HwhUVdp6emb9m2DuR93sR/8b2YYGqM1WcHUt
         duicbEjJTsMCQ7Z9r03zi6YMQ1YEn7HsxxD2xp9VRgb4VMCCOYV36V2Vk2V96NlnsL0s
         /mTbvkV/RKx/EXGjusf+hHV51dqXuovYJge3Juq5k6bLG2lVV3P4UVpbNT4ykT2eGW4s
         LWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783097356; x=1783702156;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QyotU5l8k0oAbp2gmOwsLK/XfEKLkjm+dMk7XQ103yI=;
        b=SCL+iztNTWO4rMLDZlie3AKROn16gh+9nSNBLHJ95nLpsHTwURPWLaMoOu6Xh6cw+A
         ULbzQrzsMTisJwJLHSXVZer5ASTM4twv8M4vHXOGvL0C9kBaGxHu1j2ps+ZG9w5SOXbv
         Y10FaKnF/pmKeKqjf0IiFe51EPhhAyWa8MlLknPZiwh32j9C70JybCctJKC6RkuZky7J
         +97M8bAsI0Ln4GYgPTIq+LDWz2DqCo5kyQ0gvMQYSg7ngIl95osZ0IQkstU05KqR0teM
         JuFpGQb5x9qXAmlXtTmb3G3kXSFzbkKwUfOwErOUzd4SXdqSgdgzwR8jsIi1CQYWjlzV
         u5sA==
X-Forwarded-Encrypted: i=1; AFNElJ91o71BCbbxZWXDsRjUnuchn8TVjoXcCAMyYCsx2PPUlNmndRcauOIhFWZybOWtC+94hjewQIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyua3kWRHlRrzrW+j+l3m7duGNzkOx3WDeMMbx2WxzQElrukviX
	gWvG0HgxYKYDX0L+9cyR7Ho6tlt6ha6izAzjL8okJFhokRBPRa5rfg+cMYBZL4sZ9Mw=
X-Gm-Gg: AfdE7cnal8x2vR0+jZvazlLyTk2uXc1RVpNG9ukzHlMemv2v8vQyryiAjZihP5HwwFQ
	REWY5fr6HRxfVlIQymErGrAH8jqEVm1Z6KDMPf2uHWk+RGOVF5W1uRwiWwiS1KkwyILyRGuk7Ci
	hQcgIGcpPAcsc8/MWI0+fIoFYF4WkcoPF5qdcOFQ0GIU785hgBkNuzXV0MIjejwAW+lZhU+4Yu8
	qLPJxhaN2gmPNVYjqrVdy1MC6at3xi5DNodySWIatUfY4NCXQFqtkmvihj8rHqBTXKcBumryfoZ
	SBR2erRBtKRfTJly5VthGjad9S0R2bN2pT1nBgZGvM48vOWTPXJkugNO2/cXRY3KccSSlLvKmeH
	AJ57pnCjj1OXeBt+u2LDssTvwy8C+o2EQ/if5DdrHIvndFpnZwsd+s0U58HR4FqlUMM8hLE32RB
	b5P68R+tnap57et7vEtFLtyFTRuutSvojAObkiukO9cy0D1WF/S8pdJVaHc5rU0FedH9Q=
X-Received: by 2002:ac8:594c:0:b0:51c:2cd3:ae7e with SMTP id d75a77b69052e-51c4c33eedamr5242041cf.45.1783097355828;
        Fri, 03 Jul 2026 09:49:15 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f4724bab9esm57511866d6.42.2026.07.03.09.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:49:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfh4k-00000008F7B-0pi6;
	Fri, 03 Jul 2026 13:49:14 -0300
Date: Fri, 3 Jul 2026 13:49:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, jpb@kernel.org,
	catalin.marinas@arm.com, yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <20260703164914.GY7525@ziepe.ca>
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>

On Wed, Jul 01, 2026 at 06:45:17PM +0100, Robin Murphy wrote:

> @@ -211,6 +213,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  	if (system_supports_bbml2_noabort())
>  		feat_mask |= ARM_SMMU_FEAT_BBML2;
>  
> +	if (system_supports_haft())
> +		feat_mask |= ARM_SMMU_FEAT_HAFT;

I fear this is going to make SVA stop working on systems it currently
does work on, so it might be a major regression. 

SMMU HTTU is not a commonly implemented feature.. I think of all the
NVIDIA ARM chips only one supports it. Given that a quick internal
check is raising concerns this will be breaking for us. We need to
check in more detail which cores have HAFT.

Breaking already deployed SVA would be a major functional regression.

I think this should start by just enabling SMMU HAFT when CPU HAFT is
on, when possible. Maybe print a warning on the mismatch instead of
failing.

Since we can't break already deployed SVA a full solution would either
have to somehow turn off CPU HAFT or we ignore the gap in the AF
updates..

Jason
