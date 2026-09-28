Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D24AA03A
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595315; cv=none; b=a/ufaI7wMhn65TpVSIN9S7t77Z612XgG8COaN8SwV+h77wgTNnOs9uSMyPqtiSBbsmysiQQAemJGVdkQw8JR7NS2AkwPy+gAg0ayxuYlDHxe5Y2Aey7PdQQh1X8D2Sbc2QZGJkck4oWZgDOq9R+jrweC9iI/rXA9JCgSe2XT8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595315; c=relaxed/simple;
	bh=Sgb/qwXpmQngxdKfzdWp2Tw8ZOcFCpzKxu2JQCTmjco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOw/ZWtC7yq7LdrqAWeOqDY/e3v+kpCQLlv+wyQmtH6dQvM8p1xkNRSSdgUAGCauMpt+vXUTzYJkLyH1htmzcNmjP336GwCTfcD5BwsrSfT3QaQvSlcURUmd2iZGpa6CMjFk8A7WSO5q3v+nRxM5Y6biFFHklN1kTEo+6zmS6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmlSAqXl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmlSAqXl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d8facae850so80255ad.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790595314; x=1791200114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AHgrG2jneIj+c6tmDkqbazBsM333la4Thr0x2hp0ezw=;
        b=lmlSAqXlnjJ+KNXxY4MUHf2dtnsyEC3rZFoLzmOGqcw0a7GoMVndBF7ZxSHZWmNzpM
         znn7BAVSUs8paiSSyiPH88O3kSeNVRFR/ybbjBl2SGsAhM/x0G1rmlaEmNntt5/6cw87
         MUrkEuBw9zmY0sApuRgB1kN0zzgKwuH1rss8WH1tgkyyHk53ceKdp6PWfGpmRBPvuOw6
         QpxEDLLR9DSO6cSO1vNBEAemYxoYWxNr0Hj23yqwJNd54x5YxRjEYBUA68zHTbbMFNN4
         ReKIKqdbhOzbncTAwDfsvdo47cU2r3sZdgq3BbqOMBi8fb+NF4jJsvjJCHUiPz7tzv0b
         Y/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595314; x=1791200114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHgrG2jneIj+c6tmDkqbazBsM333la4Thr0x2hp0ezw=;
        b=PV0ZvNH1NoX2qZYyaTqC1qCQOlxK7WB3Il9gHcMIdepuQq6Yuy+jyS6XlJ/5Em9VgC
         KvAykYe2T4nPl97mC2M6xmPjEDIJXgxz1hYV6zQihlD+lCiNTsnMMZ31bEuFasXAFNSN
         BEpLKnHiFD+5AQx1AGLhoZsWG92dLq74LKLv50d4fRz3I3IwHkrYxXq9qc95VID0JVZM
         2ni3G+x5PPFAj+HjJVIkaRbNR6PIr30WriiemKWZ4gNC4M5YcU50hGmcJnUqPpl3LHkN
         UGuDzNSm5TYXxhWb5kwHiFCeHYeuYZdaHNpUcLiiQxyhoNJFZ5gMBayxo1kdLokvF9iW
         rRAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSM2N17JAOKoBaT02kvye42ixZjCKfxG5QdXT3q+8LacDJUxJCTw0X60GqiwMgGKu3BomFnjg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGecIVoH0OZsv/1GgCMOznMfjzkVhsL+JhgR8MvWy7NGhLRlpL
	/0THctl9DBvVOALAWzsoSS2nElnNiRu7I/yEGdcboJxaVSym/H/zxpBzWnXQQOkoqw==
X-Gm-Gg: AYBFou3iw9Yi8ZfMSv3Nn8vVtesBTtTFDln+js9PFoDFpd7X0TwqjsBAjUhFx20nPOs
	C5uvhzYOxbmKo1cfhkFWGgS5d4Hq8Is+LTp69ozEdSr+5XGIqwk8I0pQ+wfoJFep5fkhiWF1/kn
	ntooLmtINKKCy4j7WYJ2YWpQBLiOn6eQ7++Lnu1445mxnpHYo/q7V2VBaNGvGICE3pzrtKOlNbz
	t0k6D/pTnI+rAUNdu73vmC8BLdtbofy/UflSBQPwopsVMPUSZePbmkAK3WMHM8rebVTnoGVyXZ1
	qRVriN3/LfY2CF5+h6UPY2xxhRApbJj2nBdj7+eMtsfuq8sliHdbtUNGH+WY1F3dWVp52jTh9aK
	OaW3d517Yr+mBfjAJrq/jh/eY2Gz15kgR+yzvSEM5k98KcTiG+gRaSbXDsvpSDh/fl7f3Que+ZT
	nguEvtWIyL+PR7hWWzptrObA9/9Queca6mah4hdTJpDZfvvXP8710O+1Gn1biUdiqyCYrgr10DU
	dR+mkxmLD63u/0YlpSP0E5Z2ibjmGj+329m
X-Received: by 2002:a17:902:e892:b0:2c7:9e6a:1a8d with SMTP id d9443c01a7336-2dfa62274fcmr6365335ad.12.1790595312887;
        Mon, 28 Sep 2026 04:35:12 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913dbc34sm39183265ad.13.2026.09.28.04.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:35:12 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:35:04 +0000
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
Subject: Re: [PATCH v7 1/9] iommu/arm-smmu-v3: Handle ARM erratum for CONT
 under invalidation with SVA
Message-ID: <arpQ6KINJE4velBl@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <1-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:09PM -0300, Jason Gunthorpe wrote:
> The erratum (MMU-700: #3777127, S3: #3673557) deals with under
> invalidation of a CONT PTE grouping in the SMMU. The recommended work
> around is to use a range invalidation that spans the entire CONT. The only
> user of CONT in the kernel right now is through SVA sharing a CPU page
> table that contains a CONT created by the mm.
> 
> Previously it was thought that this errata was dealt with because the
> driver always uses range invalidation. However, there is a subtle detail
> in the errata that the invalidation range must fully enclose the entire
> CONT for it to work.
> 
> It seems that two sequential range invalidations, with a split point
> falling inside a CONT grouping, will not prevent the errata.
> 
> The SMMU's range invalidation generation algorithm does not produce a
> single invalidation for a single SVA invalidation request, nor does the mm
> carefully align the SVA invalidation ranges to accommodate the splitting
> of the invalidation into several ranges.
> 
> Thus, when processing a SVA invalidation, the range invalidation splitting
> routine can generate a range invalidation that is split in the middle of
> the CONT and risk under invalidation from this errata. This condition
> could be triggered by a malicious userspace manipulating the TLB gathers
> via mmap/mprotect/munmap.
> 
> Update the errata list to the include the S3 variation, detect the IOMMUs
> that have it, and then have SVA invalidations use a simplified version of
> the over invalidation algorithm from the tlbi rework series. This ensures
> that a single range invalidation is issued for a single MMU notifier
> callback and now the range invalidation is guarenteed to cover any posible
> CONT.
> 
> Future work to add CONT to iommu_domain page tables should either use this
> one-invalidate/one-range invalidation algorithm or disable CONT support in
> the iommu_domain.
> 
> Cc: stable@vger.kernel.org
> Cc: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> Fixes: 3f1ce8e85ee0 ("iommu/arm-smmu-v3: Share process page tables")
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  Documentation/arch/arm64/silicon-errata.rst   |  3 +-
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  7 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 91 +++++++++++++++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +
>  4 files changed, 88 insertions(+), 18 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <peaan@google.com>

Thanks,
Praan
