Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F2142CB12
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613084; cv=none; b=sJLUamsaTFKZCtTf7RfkqBB4EyjuAEDZ+A+C4Gsa6vKrKe0CvsyArgkOpFSLC5R941uWd0SyUifoAdwJAlQaU2syfcR6bgVDAMrixG7cwsFcPioOMeAq7T1PiOHUWcvw1th3GsNeFbSUhD+Pi0ZYGUlBvmgHqDeiadtnu5+FIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613084; c=relaxed/simple;
	bh=u7N2Wz8N3g79uBYieYx5umiLmofN8vzB4vLH6EOh0wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qubx6N7byJ6glnDpmM3zJSHijorajR7TxttviVeXpB7u8MEtQ4DTi/q1rnZ1Y3qAZFwClEia+UB7d1cpJwEulONYx8cn14pjs7Q1/a07NJvl8XOdi7tPWPK/cfZNrfe0TPdMHFgxtoPVWO0mN8JyNXN7oF2gzT5skPmCe9a52/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gKq1+/Y7; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gKq1+/Y7"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-73770fd1b65so9492137.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783613082; x=1784217882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u7N2Wz8N3g79uBYieYx5umiLmofN8vzB4vLH6EOh0wc=;
        b=gKq1+/Y7bdxNHcppQwyf8F1erVay9/bAsWWmtx9IMqTbXHDjNcy+Y8gfMbnHwWYIhq
         85+Gpq1VE7tWlGbjuN+GQOHOk0td63TsoZbTSKJffSlvvHhc+tQwKvVcjpj5qgh0b+J1
         3k+lU/bEzsiPI7PfAS16LVcVAfboe/4CEtGgt0kxxO0OILRNa7LHd95yJKxhw57RyUt0
         F24S+OfMgo9BIcUtUoB3DVmijM6HmBzdmcnrd+g+9zDSfMsBVhIaO74+DgqN8rEGW05C
         EoWnQON4WDjrDG72bJIEp7z2HEUNH6mSthX3e68CJ+gvfU3n7U2uZf/jItDThM2sswPR
         QUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783613082; x=1784217882;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u7N2Wz8N3g79uBYieYx5umiLmofN8vzB4vLH6EOh0wc=;
        b=gPwqwoIMhMbj8e+jC7UjumW3ictmab9hNEOtpudA07CFmKJPKRTbJv/efLx7RJcLxp
         MFi5xiEKrDd77MtcDq/CX1iC6RJfEPlvcENd9fFmjE/+1zw6jeRyD9DHjcCK+5VXRM1a
         AHiWgMkPK4MqNbOUOkitQ2T/3R9OQfMZRewnn3uOk1wgi04zzG6Lk1chbBYEPIcaELy/
         BZM6o8eMVHV6ERm51l7ccM9BJaH0IOVsRySCtvQ/Up/oftIwAmfVLZkm/02ZCt81nYtE
         oTyneNNrqbSovXj3mI346nhADWU/XyrJBpkkMcbwR6/UV7qJ4DOg2QvjexHVExsOf8y7
         DMOg==
X-Forwarded-Encrypted: i=1; AHgh+RpkvPVyV0T6hw9b4t5iEjRCeSwfTJiNAMw2Lm0+KZBwfEGBTlRsCkbHInLi+8hYeK25u8T84bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aHMfT7VZ6T20Iskkq94M9zVq6wPKZpUO0vkIQbW960oQ+3Hb
	WNNDI3Up/TWmAR3c3MML4ysMvPQRIuROX5hFyJYuN0fFuO+K99YEY4jNA1CTL5Ybnf8=
X-Gm-Gg: AfdE7cmhkVlYf7373Nz5+yiqQsGc+1nbx6evgfCann7TroH234/ubCR+UwbrRYef6by
	uXem5O3jGjYa/CFFyLKC5RipdHtJrweXLzgIEGEtwxUitG9snl0zmIO40SpIysYWghUmSmMDqQs
	OlBzbS7jsmKvOddOrcY0oJmQG+usaE3HUWYk7wX3uBpTA14NxB3wr9aywA4XG5Y731AEVvmORwT
	Bx87+WtdGVxg03GMDCgJUJ6l4p2LNJsm6o3sgx1BJV3uXMbGT+mATnrAdzyYwVKi3wlajyRhQCW
	VdLIZHTIs4wkCKsk9ZYPvvQkrldXn+tEayg2jGzqFlC8OosxKWjtN3iDf6uq3iZsShLcSZdNqnQ
	wag4llFKnu0lAOnbLkFowdTe4T+v+XpJ/2AQ8bYZzTYD3Ln7v4gZVAz1M0DZ9
X-Received: by 2002:a05:6102:f9c:b0:737:ba2e:8a29 with SMTP id ada2fe7eead31-744e0306830mr5071060137.27.1783613081904;
        Thu, 09 Jul 2026 09:04:41 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d9f6sm20470796d6.23.2026.07.09.09.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:04:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1whrEu-000000058g9-24As;
	Thu, 09 Jul 2026 13:04:40 -0300
Date: Thu, 9 Jul 2026 13:04:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, jpb@kernel.org,
	catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <20260709160440.GL118978@ziepe.ca>
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
 <20260703164914.GY7525@ziepe.ca>
 <6465c885-3a9d-4c0b-ab74-7665e274ae72@arm.com>
 <20260703192459.GB1978949@ziepe.ca>
 <f13b30cf-e885-44c6-8e61-7924937eb8ac@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f13b30cf-e885-44c6-8e61-7924937eb8ac@arm.com>

On Mon, Jul 06, 2026 at 03:13:01PM +0100, Robin Murphy wrote:

> Indeed if anyone does want to use SVA on such mismatched hardware and are
> happy to use a custom kernel with CONFIG_ARM64_HAFT disabled then they can
> and will continue to be able to do so.

It seems like we have a chip that is impacted by this. I'm being told
that the necessary ARM IP is not available in time to properly match
SMMU and CPU for its particular application.d

The chip is embedded so those work arounds are possibly OK - but I
think this issue keeps coming up and ARM should have a better overall
solution for CPU/SMMU mismatch in the ecosystem since it seems like
this is going to keep happening..

Even if Linux could automatically limit the CPU features to the SMMU
it would be a big help.

Jason
