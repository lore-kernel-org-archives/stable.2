Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2942983F
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750274; cv=none; b=NhRWa0JCBUeIRbcw3vSEgyFD+RheTO2MPd1fALuFlKAm1DtrPH/4w6qxJ33O0rJl/ag7SzMnGnxg15xWAB8SROSjRNGz9QEHkoAFwqDAeNn9cNh75oc4vaBduEPe2S8R8axp250terCj0rN4lT8Oad8lkIDuEy+fXMzKh8hlq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750274; c=relaxed/simple;
	bh=ySTaJdnZa62yhBnxOv6OcbAWc2ceyO8zhRkoDVDC8ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPwva2JxAJ6ISMcI8gdkxtpcNF8w7O+1ooA24rwlYHt9A0TWI99PzV6gutJ8Vp0VT4iOfaw9+fMiKIP4PDD8baEgfiTSGC2JLekb+NWWN5IQMLXALInb+BkNKeFR/Jj8V8/+CWFkfYgc3JnJTl7xjIqcRKsiRgn6KzFFZjG7Y1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8/6HH5z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8/6HH5z"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c81db32393so104205ad.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782750272; x=1783355072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0iNSQseB1MUx/UyReLsxkuNDNXPWZeXUlBY5ARaf804=;
        b=G8/6HH5zW/j3X7EAMkwUfiPjgFnfuycMSuIIoyfykbgYXhWbepRMxm1nMXK1znxbwK
         zLXtBjvAhcs3HOuIlBgL8u1M/nCgydv9PBtrG0mBRhQWKSVQR+jV1J+lrZCURiCP8DI/
         v83kzG4gi3CWn706j6c6TvWHynHWOIdeTD5gZXLV560bs6v9Gca28RF2OeDQqB8xI9gL
         OvmCVaCS9j0PjE4fyoJGv6JeX0g1InWSjNDaBohQs8Yfypb6JvZKeptnDHtErRLjiCDz
         JVrgBibanYh3Z1Bgr7nHSFzYugcjoayzriqUVzhVtedSY8r+G6HApeJnVwJduD599yNK
         KWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782750272; x=1783355072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0iNSQseB1MUx/UyReLsxkuNDNXPWZeXUlBY5ARaf804=;
        b=tH/xrBugne7cIAN6o2fPmgmH3wuj8lLisp+WMFLnQYiT9i+o7eNEccUivJTIdgcFJr
         7QSwxz8WWV7bwNOjJjYNoxWbgs+wvVnDEbbBRfsNAhDHumr/0ly8f5nk140PCPAnwRhY
         j8FsCknuP0XxJtjr9D5JcU+xXJ2HVbKjzxLlzY2cl/AcCd2Ngy3qReMK4V0JcYUoXf9w
         4W82+Ym/xac5exNnI/7ufzNGpQSeYq1TnDElMooDuXwOgkYtsa7iJ2cin9h+aHoXTp+n
         qVouLXWdyY4Uk6Se8hLyr/JNjGeUj695Oc51pAV0U6VN0D8gYcLbSpB205NVcLau8rKZ
         bFIw==
X-Forwarded-Encrypted: i=1; AHgh+RrLKsNWkOoYL/fNtL1TwUsKQdyofT3CX0Iae/chjYsOy6wq4qcT7POFhsuhVWfxJqEg1n8G9KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKkMTVnUZrmVUvVv68puu/SW6NOFHlTXPNFzw3EvzCAULkEy1
	+c1sfUDT1AuGvFmh0syPCxhC4ddZa1eaUGAd0IoRTxhWp3D6MM7Y4fvMf6aoSD2kXQ==
X-Gm-Gg: AfdE7cnNhIuNLb4O2UZeY6k0V9bApuIJ2Pr7vEXFtcWRYtk53FusekAJWpOWBwfKVOL
	/4g0GAjCLXFNqd7NY9eRt8qr/zP1rcYSGkLaWAW0MByO2CMoMeBLSCX/KqQG9lhPuON7YezNoDC
	sORq5UW1CXsI4UqzYRZKlCXtIqRzGP5b4u/zMWtpRSjs59uk9nn1B4g9OPc4T65bgiqbMKfpiii
	A+VHydIKkfHsPUiWMMl54mc/IjueBJpL5RH17NFhkuYO7VR1ryx5dfZZB3mFoDcZ5wSYXNjR/x8
	8YL9YuASSUO9Gqug8Fjn9bKj4bPKtOMm/SvF+THmkAPZLoyITbabDBmaMPmst9r7KendDzvj9jn
	dt8/9qQo1TeUpSxHU29FydF7XqN2kr/doW4WS92tEB9faAm/JNHx05IoiCbOsRssJCGreB0jxMP
	eNAq+iUZpcIIDLWwkq1KM44eVrVRRuK97X3xDUG3h9XIdpZBs=
X-Received: by 2002:a17:902:cec8:b0:2c6:cbcb:bc72 with SMTP id d9443c01a7336-2ca2d062c01mr256175ad.23.1782750271674;
        Mon, 29 Jun 2026 09:24:31 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37eb013af70sm3876698a91.0.2026.06.29.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:24:30 -0700 (PDT)
Date: Mon, 29 Jun 2026 16:24:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 5/7] iommu/arm-smmu-v3: Retain CR0_SMMUEN during
 kdump device reset
Message-ID: <akKcOMsUoc0mYVoe@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <f3866cc84cde2108b28c35b570ae502384e84c2a.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3866cc84cde2108b28c35b570ae502384e84c2a.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:22AM -0700, Nicolin Chen wrote:
> When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
> the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
> register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
> leaving them intact lets in-flight DMAs continue to be translated by the
> adopted stream table.
> 
> Initialize 'enables' to 0 so it can carry CR0_SMMUEN in kdump case. Then,
> preserve that when enabling the command queue.
> 
> Clear latched gerror bits if necessary.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
