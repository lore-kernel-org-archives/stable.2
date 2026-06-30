Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905902F4A0C
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795699; cv=none; b=E3ft8fNcYChQev+ocJdhL46pT0wLLqzhwOemXXxtu5ye6FQbISYXCAzD6YDKEACKoMpVKbClFxNSq0Kb/dl/Qcena8M3K8DY33u5gE6LpCNAcRyQeXdkYY7fimqCn/3Am9UIudOHcRstw1bKuOr0JKY/mOEPX8sE35WrmpVDhEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795699; c=relaxed/simple;
	bh=LbBL6mPFjg+PWrpu211fjZc7jz53pUAwVRjjUNY3QVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knqmwOIoqvSzuITshyBGh1gKSxcaKwDPe6QOd8DHdNogbnFIuQEYg7kkQ+OHUbQhfgC/za3s6QUFHKd9NeyxZgl0GHV8dPakHuSVcCEHOi35aFyGIPEUv5YgRFgL9RJOnNqAEumHZ+OHCQkdz3Jigdx3IXRJySulzqq6dGcLT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rCHgPUQ4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCHgPUQ4"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c9b1db4964so25325ad.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 22:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782795698; x=1783400498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PUHXAQhop2N6I4yFe6BAtOJ0PNQXYFAlD9Rf6jdS8+4=;
        b=rCHgPUQ40isEEKtMgh/NRPr/dZ2dJyMwLq2kJnI8lTH9tArW86B8QEOINzHKqdSMWW
         NQ39nRiOGzaHWwOn0Ze7ImGpLmZ0Rm5lc8ID/srawQupa+2lE5FZKTWwG6xV8PqLxKe9
         UPZxcxNixUUmhHLH9TbRvkcrTbGUPxSmCxNuoWgQIf1vHxzz6b80EASSWybsPz7R5pDu
         9ceZgryL9LedHRTddes6H+p5z/K7QF3incCnzHfr6uEH5yJFlgTHyl6WVyCZQySb51iX
         MB+J7LgcgAs2d9YyMxRmI9NVmhBjPKX+nQdwE8N2S06+913Ctkxmz871DqBSIaHlFKyL
         xKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795698; x=1783400498;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PUHXAQhop2N6I4yFe6BAtOJ0PNQXYFAlD9Rf6jdS8+4=;
        b=dnfC2rvwT1nKdLQ0QmHvh+2T8XTJHZ7lBnojBQDFRZq0807ue+zxLzdefPVMWxwWmp
         3oX4HibdkfhuoKuKuA7bMomwZqFR7l2OM6kOw+ziU4CIERBu6bS8hlqsmo95reZryO5/
         ygSZwz52EsUonUStSG5MfJdworOe3LHJ2tJM7KOMf9mR/gvLo/aNOGF5QjxuWOyzUaj5
         9iZM7WzZcNigGj8qouHUi8o/Xj1Cw9QCEsTxy0+bc10r92gBhFTpg58OhiPQECLrip5s
         Mau2YZ133K/LFd7/mXOqszCoaMhtGHLyJE5Km9cJHPcMUQQrJyRfLKZpWXnx4g4N4ZKg
         cvMw==
X-Forwarded-Encrypted: i=1; AHgh+RpbVZUJHb7SxwuJT0RPR1fy2K932+pee3lDQFq/3NE+37sPB7p8GKyxoSjzbSvNWbvTsuHx9rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRM2a71iB8BG1n7+NmRpPvNPnjFjZipvMaImRk/8NQOwylEw9
	nguB4pIK0PUwiPMejr/TN7m1wuBrggnQ+/HVSzLJYgBLxFSL/Jx3qNFqnQYEu+7+Zw==
X-Gm-Gg: AfdE7ck8SrSEtyaCYOaa/yzeOp6YXOxQZPIN43N2umWzgEtiO5VwEJj7kbwaQ8afw13
	DNbIz1UQZZV37qLQcn9aBvCEzraDdgcM59DHAUsGK3sgWEfyWW3zptvSjaTunq55nzGSxcISw1B
	ZykQaOTy4F8kgWCLul1jaQqi9NnVM9KtnIZ6ouQPrxnzYkbogHLBjGz+OrVSR94aTov67R1mz/Y
	xLBaETsbJDYj9NXYvx20+sXpDdESgC4QhJydmRG2Q1Qlj/EDQ3FN5Ro61UdMQTQSyftGCDvk4/d
	lZEozRz6vrd9ssbrS6RZrFtVhRJxMPrjCVSHJI/pz6hEie0UJrwZY349tINXNWDIo+kIv1bDOrR
	Z/pkkMMN2Ze0kNcf1bRPfYB2gzGuOitkOsW9hgbc22PJ9PFJE57yPSUfRd9OPNVMxvsGhosvMh/
	zxhCbLnW+iLEMoH8mhMwFurTHNF1NtOt5h85GyCgph/zt9Uz4=
X-Received: by 2002:a17:903:4b4b:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2ca3def6034mr542235ad.25.1782795697347;
        Mon, 29 Jun 2026 22:01:37 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a70a21sm5627295ad.7.2026.06.29.22.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 22:01:36 -0700 (PDT)
Date: Tue, 30 Jun 2026 05:01:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 4/7] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in
 kdump kernel
Message-ID: <akNNqx_aEp35h0Ys@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <1280ac4fdb37f998fd6dcb2bf8f4437283279395.1779265413.git.nicolinc@nvidia.com>
 <akKMCYsdH4lVSyf7@google.com>
 <akNDZM7n/EpBmajY@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akNDZM7n/EpBmajY@nvidia.com>

On Mon, Jun 29, 2026 at 09:17:40PM -0700, Nicolin Chen wrote:
> On Mon, Jun 29, 2026 at 03:15:21PM +0000, Pranjal Shrivastava wrote:
> > On Wed, May 20, 2026 at 10:03:21AM -0700, Nicolin Chen wrote:
> > > +	if (!is_kdump_kernel()) {
> > > +		writeq_relaxed(smmu->evtq.q.q_base,
> > > +			       smmu->base + ARM_SMMU_EVTQ_BASE);
> > > +		writel_relaxed(smmu->evtq.q.llq.prod,
> > > +			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
> > > +		writel_relaxed(smmu->evtq.q.llq.cons,
> > > +			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
> > > +
> > > +		enables |= CR0_EVTQEN;
> > > +		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> > > +					      ARM_SMMU_CR0ACK);
> > 
> > Nit:
> > I believe only the write_reg_sync(CR0) should be under this if condition
> > do we see any weird behavior if we perform the reg writes in
> > kdump_kernel?
> 
> Since CR0_EVTQEN isn't set, the other three writes are dead code.
> 
> So, I skipped them.

Ack,

Praan
