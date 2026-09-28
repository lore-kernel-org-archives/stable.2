Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE44EF15D
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613553; cv=none; b=a7juTiotwnTgq7GoWfhJn/mfPk+B748v81vuC85dvrBdhRYzusxBxtowcknEu4en2sx0vElze6CeLyn5RpOWc6NsSHwv6K7cK5ik0LpkFo24EHYVJszpAhXZ11ft7tfVlqU+K7JRxV4uDVr+6wqVAjIYVhzp/SjaEMGvjoVdCPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613553; c=relaxed/simple;
	bh=eUfvVLZQX2fpM3flyInt6K9umn99g8n9V1ePGkoJIa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT0XGsBtqiLyI2SyZ0TEwy1cGLA4z2olVxGBCe/XLuY58g0TngkiFaqt1AVIOV9Ya81oXxo7RHTOJRzwp7+8w1Zws35WkYYWnnqlh1LZAgJzM+0EwfkjOO+wO+Ge9IuQzCQDS/hylWbPX5NZ5K3syiYMBrwPUAg6Fl5s2GNEn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfV9Pgyi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfV9Pgyi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d3b445a84fso45ad.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790613551; x=1791218351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=39N4SJ5sD0wjIsHC5a7NtN6vI6BvpcPPu/06LAjzoVM=;
        b=JfV9Pgyi/tKJGmV0wsJkemyexPUQeDYYMMTxqx1EuB2KJEgjPMK8A5iByYCzvfWGQy
         iUvAbhd+PDUFPvQDo7yCaEMSczBF2OuI+5g6BcbBra4d1orWEeuWzvojSxQ3T6/cBHfL
         v/cBQPDSRcWvEEF22deza+mF9nbcFz+7Eh7Wy0awzsZqgoalh/xFHoPRPk4f5lQXtfLr
         t+952EUVhJT9gWhAVqOhTgQlEMJcrBnKJzLrLLLL7zxzKCmtQI2YLzmd6z7+fMTHCVXz
         B64mRmDUZHAaOrxPVcuy7owfdKIkVQDPhkvYxh5lv+wbhMixkCG9DQGmNarpIRstv99k
         1HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790613551; x=1791218351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39N4SJ5sD0wjIsHC5a7NtN6vI6BvpcPPu/06LAjzoVM=;
        b=dRP0yzf948pof8u2Es57gXyK+YUgua0n/o61UZ0fZgDymRYtAsRoqTyi3+kMAzqmjQ
         v47EXQoSwiyZq3qiKfgU0TPLMa3brDija/VQeRrxR6j8Q3BC8ADBu9+NhYDBa1Yqpo21
         HGaEetjjb4Mps+rZ+79NGWyCRpRURxvxlcZNBGNKyElkhwcvF7vcSoaAytz1QnF0TOm6
         v7RtfMVV48XhJ2rQS6qvRMzPxhKkdO2mkmbFzuZ3uGcuFFxuS7c4n7wMqipqPuH8cTcv
         EHJjSJVDHcbogdVsHyrXOqr31m1b7oWsfyJcFVZ3JOJMh07cQ9PxvQy49Pod7dTpNErH
         rEOw==
X-Forwarded-Encrypted: i=1; AKwUvBwiCzNjHWw2Dbq+wWrg0FWTP9fvpQaKAIZgymFRzNbyounfyKQN1OHM6BWa0FYnUvtHOcbuu9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBM9RGBC9ENeVhBInCJZNDyKQy8E13gLxi84CONFYFc/75ufSf
	xDwrbCM+J3kxdQTuLGLwTU6t7oO/N9bdyRI9H8DeJ+u3PQFvAU5vJe9snSYbCDNoMQ==
X-Gm-Gg: AYBFou37iIogYRJ0Aon7BjsFnjAyR2H7rl7IXyA1h2VnwUPFNta30aXuAkgpndauKR5
	4/O6a4VXcKvWwI5GalIcIImdr528q/bTPqYox+TCEDTLiLIUpjiu+iin7aPUWZj4TmW1JhCWGBZ
	fiwsLqRgwT2icspt29e0+c8hmAyF2s87tZylJQqWyimp64XnQE6m6T8Xy1nbl9b6L2MVbajQHTL
	pwsNSLTyG8xbq+Z9qvNCtMIontYTOg9IY0dg8HFXVtm990yjkzYo4EUus7LRLKNYesI81kJ9fM9
	FGqiAUwXm20nOEd/8aOZFOfCC9q6/XAhLIFUzTJqbS2tuY0MCHr4Hl4wtuKTN6NsSf4GR/Y3ISe
	UTqrztmLta4zcBBq/lAp03D8C0hDmJo8DAls9yBhIYadvpN7MCA85BE7dqa7dEL77uDrbgFcMQa
	vIAG9vVSViLG3B0KOdeTlgpBDdZMNypJ0a5qZLvk+RoDGYW4dxGDkIfLif71vMQM7e+fyRsc3yo
	tj5KAqIvl4qVIPRYsSr5XcS2gIpBEDpPQPI/ne/mFjybgY=
X-Received: by 2002:a17:903:4b0c:b0:2d5:db3d:1a42 with SMTP id d9443c01a7336-2dfa9773f0fmr7086335ad.15.1790613550389;
        Mon, 28 Sep 2026 09:39:10 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498057a62sm330376a91.13.2026.09.28.09.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:39:09 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:39:02 +0000
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
Subject: Re: [PATCH v7 6/9] iommu/arm-smmu-v3: Precompute the invalidation
 commands
Message-ID: <arqYJgFdbcyAn__v@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <6-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:14PM -0300, Jason Gunthorpe wrote:
> Store the required cmd data in the tlbi and just copy it out when
> processing each item in the invs list. The cmd form only depends on if the
> instance supports range invalidation or not, otherwise it is always the
> same.
> 
> This avoids redundant calculations for each invs entry.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
