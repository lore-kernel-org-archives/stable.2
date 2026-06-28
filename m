Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61F346AE1
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687977; cv=none; b=sjCQFNQNp2WJt+dGSLQQiQ3tbzeu3a39qJHPkR2pXKeUTETDbk8HgeQnSnuDGbQwLZ2pExjsssBAiCJNnWSs/gyq8Hc8Wf5WNuXEJT4QqYCTKyq3N6lN/mh2y8yQ0dlhorSlUou5jOqjozlg1hfg+kAqIfGwi5NSAxVV7htgviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687977; c=relaxed/simple;
	bh=Etgv1zt6H58TAeWQ2Ok+9a/koljupx+SXENx+QnUjf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEtAxmwirHtZgdo34Xo/BEXQBg4e4SzJDSmeUZa6msBeFgjvV/fWiL/Wd2tEijghMYPB9ugtpQq8bKTAIf8NUW6jHQvn4ykKwkozGsK+VjiPHLtPvi7WebjdM2b2jtYmclG3aVSPa4AsVFdftEdFHiA/mVMEwxUqCHAv0ZJ7Zzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gOm++ssk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gOm++ssk"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c81db32393so47805ad.0
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782687975; x=1783292775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w9ASwZXxOhuIEA88U9uqvxx2ThgVPLf9gDKq6x0EUXg=;
        b=gOm++sskAYG2FHpnMa2by1edIHMSL1MnUULlzEReTJZf8+GFbe9/hstZT9E+f6iJjW
         LKRFmkBJeqox4NlwDoNhC4t+lZuxLNGeniQOk9mfuS/v1pRhG1gssMZSdeb1PQzcSnNo
         U4obWgXJ2JDS2HQkW4rXmngb+NZPs6ClXF9kZEkjQitGDufJEZscfwuGK4UKLMtdCUJV
         HW5UeQG39pIzV51nvYY+sgXKOg2gELtKM9rLE0I5GE4whxBVxuVMvOzHPgXr1VJWT8wv
         6eevTs+iP0qZhFc6jWq0663t53a/eskcU3O6OSVsaussIbKVZu+kctgLnz5bqTL7cZdE
         qeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782687975; x=1783292775;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w9ASwZXxOhuIEA88U9uqvxx2ThgVPLf9gDKq6x0EUXg=;
        b=XDNXHLOd6+u9pFA5sjM7xfEJYp5aZmK01t6zLSdCvdt9ILsxe/InCMRZPkoy8jTl3e
         TrA2VxpAej9F0wupiEaFmkXiiQyU+meDvtJh8C8mu+zXyGtAItJJsR4qMy7kHEjIukLw
         72MdvwwvVkb5LOzqAEk3+ENzKVyv5lzijJeQryBZxSV7HM08l7CItmP/bIi18riem/7v
         FYf3w9V7HAQwgWRwUTnB94jjTvO8XLSnfwrWlYCq7MrTHpZtReEKwzv3HIn55jwrr7Kh
         MR6rwAQPAzOyA50LQMXX6r7Mvq0uStFeVgkTy8jrjlyCHeOg4SU8bXt/2Ml2rgvdIGdi
         pt8w==
X-Forwarded-Encrypted: i=1; AHgh+RqvAAEgT5IKvsCZA0+QdDpqrbrfVTdTlOWqQ9nQtOAYcIqRFFuVgultly1dymFaXDgHgEDns/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNUsAHnXQbDafDAxDNNdNkodMiCvtYUbP5ey+HJkmUmNOSjgY9
	Isk8Rf10loGNMFoH7gHXe7Lvefktt+1tW3gjW5L7TZTIh/mVm++AUGnHkjGnQ3OGdQ==
X-Gm-Gg: AfdE7cn1j8eNLbvl9TkIOK5OF0IgeKpKdWb4MK+y1yBQmn728AY5+DBut0Uwx0eC6WR
	Hzpt8QQMrST1urAFL54jSuO1wu81AecW8WoBAZWqHaA/YeqrzJaCAFLEyNXoLXWAb+vQ415fFju
	Lo1K7LLBFyvixNxlT+EdBVVrjG2SWr1jbwaCCnk9yRDeJOaHa+5o+8O/4owb8x/Jr3h57W1KYTv
	9KJ5Tt6ZWsup4rw3qZeiPLuGnr/DmDJQuyihM6KcsXvYHxz9NmZ0ZxUIQQ2I4RZunzjS1wEMHDz
	T/vwQwHb76QajfOmcSDCiLwF9CmtMCSTXCd9+4Gq3Wvq5VgPCJ/LbHIredQhtoB36vHVXfzXIay
	Nfxk6BzxLdGtSmSvc5sKiGxouVx71R5J3ZLxKDsFjOf7E/pg97V4uUgwYOX+qylYbPoZstOnfJ+
	cfcnAuAZZmY73VYNUkXw6m5mC4ZuzpX52BbtRW16oOnxu3JfQl7f9NiBYmlQ==
X-Received: by 2002:a17:902:fd87:b0:2c1:ee6e:be1c with SMTP id d9443c01a7336-2c9a27fbf39mr2722965ad.26.1782687974705;
        Sun, 28 Jun 2026 16:06:14 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca0b454815sm3400655ad.2.2026.06.28.16.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 16:06:14 -0700 (PDT)
Date: Sun, 28 Jun 2026 23:06:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 2/7] iommu/arm-smmu-v3: Implement
 is_attach_deferred() for kdump
Message-ID: <akGo30h_EZCUJCkJ@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <89cbd3760a13f11cf63f6ead12f44974511f308a.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89cbd3760a13f11cf63f6ead12f44974511f308a.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:19AM -0700, Nicolin Chen wrote:
> Though the kdump kernel adopts the crashed kernel's stream table, the iommu
> core will still try to attach each probed device to a default domain, which
> overwrites the adopted STE and breaks in-flight DMA from that device.
> 
> Implement an is_attach_deferred() callback to prevent this. For each device
> that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
> domain attachment, until the device driver explicitly requests it.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
