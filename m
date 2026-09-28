Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E954AA3EA
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595376; cv=none; b=XzxfTHOiSoCIOraXYhKPlV9WWbNTIRBdnaF+r7hzxd0N6zvvd7i1cw+iT0hU2UKusnRs6GzOTlbKqVT0s7+jULTv9LbXKaEq3yrzzByVryPrMot5ztNG3I7WE9mNC/x79PhiOC6GMf9B1x4a4zyIavetFxunvX3rmnU/10cpPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595376; c=relaxed/simple;
	bh=szkmBZw5tkv9QIb3MfF0UTg+9Z/SIDMcAeVrvWmsXDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeY6FocTmOAguSJhifr9FT69aR6cNKlrw09Q5+CQT4Y3LFkcVU4qQpE/UcbcG4yiqnVy/VLn7AEMrRu78fY+HpdNNyvTaN8A78CDXboyoDGGOdUwI4vPTmZYf8IiCNuejrKnKpbdbMlImJeCeR73sPSaEUPhh2juekR9Sjf1ZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOj4qUzV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOj4qUzV"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d3b445a84fso67645ad.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790595375; x=1791200175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2virUEPJU+T2t2fxsSozm2l7j+QFgng63b99urpUcvQ=;
        b=GOj4qUzVaxBlmmSt/DQ7x3Qgd08qWEI38YUzbX02q6ccbnOkAplYyROjq7TlouAm+8
         6e1C3Lf3qjp6rjZ6aN6nfnGzvamBTqzF/SilB1tynnLbFHM816Unk+ko4qY+AVdrK30v
         SugW6Nbjxxf4oX4Hyg7SMG9wcdNtqQYs8sjggkLOybNkBcED3XUEoxHqPMyUHGRIsjOH
         DXv3g3Rkojf+Kq4i0jpHyNG4FwacvA3+FfDaJKhGAryphaf/3rPrBWjVoa7p7qh9Bp7I
         nWTUH4GEhmgvN5ZyRsw+Au5Mj9iyNh9WMsj43GRSRe9bL5hPa6F6qYC54eCnJUV1xBI4
         DKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595375; x=1791200175;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2virUEPJU+T2t2fxsSozm2l7j+QFgng63b99urpUcvQ=;
        b=anf4nimRRnLqnnVFQqqCVu79PNHhBW19NJadL+u4ShTFK+GbtsBVosE0WXPY9Z6t/b
         RJXizbPCzb0MD0B1iAuYcgx3s9cXfrdPGXpCYc8uEsVNFGdkOHNOylmdPmSZehsAu8ey
         GRS+awPLO3+XjqjTkIigbxolauYN7bN478N6h+Fem03/4U2zwqt0t21TlLhsExmt+e7n
         OSZsvokqAMZJeNzykPsuBE4+hJAdA1yLyCDu2z8O8lu8KoK/AGRGlzwATTflkx02UM5A
         /GeqRFl1dcc7RLJDWfZL+M96bekxjp9eK3w4H8C1FQLdQ4neWvseLVrs+FdcjpKq6mNy
         fj8A==
X-Forwarded-Encrypted: i=1; AKwUvBw3W/fiA4Qvt4ibRsNE3VKAmQaMeceYL3InOwAH/c1lpeMOXAtZqMb3texAhPU4mQEEAb0OxRA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmnlUGTUct7Fg/HsmBLz5edWtRDxIhDcfToIqSP+fiZFu09H3O
	2HuDhDImB7ewK13NynnBF9u+wKOre1xTQqc429w2/gojoAjIZxpGvexrjpgglG4gqQ==
X-Gm-Gg: AYBFou1IWoc3T1MTm9A8RlSd1BrGTXLhvWcgWbBOG09U6uMgAOc2E/w0mlowFF8F22Z
	2aG/dNfV5rvy1nL5EiPn18oDPVyqlIYvYklnytYVOrf/LOyviM3bup+cpqSiTlslwkhEnHIpAZG
	4xkdbt8De3pHsjsy7uxG9FL0vxmyUoSRPk2jvoJzK7jzcFdMKkdJY1rJ7/6hNv3dB1o8QlQkTTn
	YB8k4bqKnfViItCLd982bVUhoyJyE5ZAm1BzyXbFx8ML2oDt6TJ3e2/lHAHHsceyTMuBy5UYlIn
	DHIxvpzC9+kB7WN7dLegEwcrC3Os1CM5RqcFPf1JBIsEKRVffIPRpE9rAezG7/+gHANGmF3Ur3k
	HpfuvsXh+uoEjjqXewJnPXkE6r34IUqGnl5tCyOuDdqZcSLUI1V1sQLLeFlkS+YysErJvTwbb/B
	xLokYKb302n/ATnwZbFp9cgE2VMD7J9ugmwslKCR6JHpDKKSno6oDGDHZG6Pe9TMUN4B0d6vLP/
	IJKJhI/gcxwkFsbNp64V7uG12MotgXjoXzR
X-Received: by 2002:a17:902:fc8e:b0:2df:83ce:7271 with SMTP id d9443c01a7336-2dfa624aac2mr6638095ad.10.1790595374074;
        Mon, 28 Sep 2026 04:36:14 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bafesm39086245ad.51.2026.09.28.04.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:36:13 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:36:05 +0000
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
Subject: Re: [PATCH v7 3/9] iommu/arm-smmu-v3: Move pgsize out of arm_smmu_inv
Message-ID: <arpRJQHAKMKIcX-w@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <3-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:11PM -0300, Jason Gunthorpe wrote:
> pgsize is a constant property of the domain, it is the base translation
> granule of the page table (4k, 16k, 64k) in log2.
> 
> Store it to the struct arm_smmu_domain based on how the page table was
> created.
> 
> Pass it around in the tlbi.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
