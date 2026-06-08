Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FA3E024E
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943561; cv=none; b=rKJchzwvWf/7Lxb11uTMUMBuRVxxXM/JEKryGW6FmnixnRfrSofmJIEYJZnCeJ9G+/Ithowtsq7EJE6Ucr2Yky4A5Me6WGqLPSYREil8veK3Q0K5tV6Lu1cTG9EFmniuF1tydJHIcrdHWXXlNBWK9yqXL5SZlRN+aPDWp9RNcaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943561; c=relaxed/simple;
	bh=NRYtjtKesHNdqf0BZGqy8B6mOcPPpM3Bi2aqmD/VBIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T44CNaogCNAaYfFVTna6Rug6Dg1C4qTAXVW5AzATvmdUwdwEosVew73lOSZKZjQHph7WtSyGcqCzB7ZGSyAQdwIDdhKXC70OkrjUW2AtEpTyUvuZN/mQKGyPb+9j9W5fT5v35mAy/nvTHR22LCZkKtO2VHhwdJVvwjHowQyyVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GNTEuR02; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GNTEuR02"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-915b5ce94c7so320053485a.2
        for <stable@vger.kernel.org>; Mon, 08 Jun 2026 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780943559; x=1781548359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1h0HrgEcGa6iFv+6HC94ID46NRoLdOidAgcn+xUH6Q=;
        b=GNTEuR02mj6R6ks9LqyfrJ9aOGwEceAtrqbOCZi7E/RxCWlafBNrpAfmUhUtC4CGhJ
         COidNsd5EcKwtYt7nPHdy2Lwjae21tTsPBu6S3URL3Z7bHjLwxcLyz7WLECfa7rqKaO9
         1qadf3afnQAsvZmdA/rCuNJmHGHdfR/+Drhot0HsvW2caI9LnuwVtDsdfViILBtAAGey
         uAFMFVmUSPzfWCmF0SnpMZf3lRYUOT1FjpdwuNJAV53JXeIKONLDyJhZUJVV12mRXJbl
         Q/BrO0b/mNoL+G+dLIUJdt8Kv5Si5H7QijHOOTgQ7pkWx0dO1ORLiTDTQXKsa0Q9Dulz
         v6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780943559; x=1781548359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1h0HrgEcGa6iFv+6HC94ID46NRoLdOidAgcn+xUH6Q=;
        b=ceycZvOg7fihPh6BTwEeOL3onSa3gqPj3LtVScl4YnGbfZcP8xpt1EuepC6KWts/tX
         7w8geWriRLJRZ6poEo3CuzNbNwqRphYcesAlHK9ejiNklRoObNvHxtwr+P16NKfx7+ng
         cRsOUcq8dFC3Zi+Y77PUAOCxDtQZtyt9/ICZFdqHUj2kGAfA5ovCsTDvBoaKqQWIvA/l
         SQNt8dLxwQSPk/1cNEJeP3G8jXP+DDH/1pXv5lBtfdV5gkfcO1OFs16q4U9tyEvQXZJP
         4vAPZMJLz1R9Gs2MZpU2aLQhpd3Bb0gjvfrUZIUIRBRHKI0k1S6EpFQYW5YnuPZCFUTs
         PdxQ==
X-Forwarded-Encrypted: i=1; AFNElJ++flsqU0oWMMizU+RgvQn1Vew5W+q/f8Bi1z2z+NxCXmbtYIPEfXDh725rynVMevfiB3m+rDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfhJoBW8pjmiLsiUsyUMojfRKzHXXfgcVEiMvApk0mktUM3jZt
	c1QWQvAoNw2KfhJK+I7YqHaCZS3+lT9D/Jz60IXOtwBo8MfM1yPjcY9SgPUV0xwo7ZU=
X-Gm-Gg: Acq92OFIsnKpueJK+4q3LBVfqxalFL+bH4FB2PHKYwQr/7M+9MGXJCsomYqcWTqqsEb
	Jt6idvbEXUobBYVYIwYA2izoe2XOP3Mb+Gt6wNwLFYsgpRrhHFtZqf7PNYVNFbr5A88RiXTRF9f
	/6mRvLy2Dm7YiNUl//k+zoQHcmBeDtNmMq22MlQk4I5B+7t+TkwdooyOatWV2KgDWSrV3ZnTuiy
	v146ogLYF3/+wVPnB8H5FjfYM4PCksDlpK0L00xUh4r8jLr9Fr4eOf7FNYBh+IM0PFQpDgABXRJ
	F7U0F/HDECFmwXQIp/OzsOhIwIdV+g1ZcATroJPRljvgrLBUxRDCDJ1Y5fFGMKSL2EKogLSdvEI
	OcTRxZWKl4gFdhnPGEkMsy49gazQbk+VFDA4JvXc6K5sTbOAmmoVZzEStzTRf+oVKdm5kV6ln+Q
	RvzZMHrLXT2/xvn0dKHZPbJW4rKwgWfCVmObkLuCF+Fx+YIDbxl81Lvf+btLOi71IHTEQ5j5zZv
	hzsgsLCeVVub912ovC5hpUTgBQ=
X-Received: by 2002:a05:620a:454b:b0:915:9a39:1d68 with SMTP id af79cd13be357-915a9c36a24mr2824742485a.5.1780943558746;
        Mon, 08 Jun 2026 11:32:38 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a238f8esm1834109985a.15.2026.06.08.11.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:32:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWem5-00000000Odd-3Loc;
	Mon, 08 Jun 2026 15:32:37 -0300
Date: Mon, 8 Jun 2026 15:32:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: fix refcount leak in __ib_alloc_pd()
Message-ID: <20260608183237.GF2764304@ziepe.ca>
References: <20260608085625.138331-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608085625.138331-1-vulab@iscas.ac.cn>

On Mon, Jun 08, 2026 at 08:56:25AM +0000, Wentao Liang wrote:
> The error handling in __ib_alloc_pd() has a refcount leak.

No it doesn't, the error handling is as designed.

> When get_dma_mr() fails it calls ib_dealloc_pd() which invokes
> ib_dealloc_pd_user().  If the driver's dealloc_pd operation returns
> an error, ib_dealloc_pd_user() returns early and skips both
> rdma_restrack_del() and kfree(pd).  This leaves the resource
> tracking kref held and the pd memory unfreed.  Because
> ib_dealloc_pd() has a void return, __ib_alloc_pd() cannot detect the
> failure, so the leak persists.

Yes, we can't handle failures on this path, the kernel verb
ib_dealloc_pd() could gain a WARN_ON to make these clearer, but the
correct thing for the user facing API is to just leave it as is
untouched.

If you mess with this you break the uverbs stuff pretty badly.

Jason
