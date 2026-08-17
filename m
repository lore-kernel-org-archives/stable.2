Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DD43FB042
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965387; cv=none; b=WMojj4FK4iIkcNWjo+XBESbvEgQFreLwH1W/+OzhT2lUQeOFVO8Qb8EHjWghv4KaHxN+L/qQgyst6Z743hm/UsQLjT1qNGyIVjzpUxrptJLB4A9xIVXS8A6uOsvUIMsC2V+WkXR1hzLQ5HogBDiokXBvR7S6Bd4hxVBPGUYZGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965387; c=relaxed/simple;
	bh=VVXh1hJaIziTnYcw5VXBnBRcdWv8NrGa70oD5ZkUoBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3Y17UXYvru6JBzp3gn0pKEGIu42fRgWwgnQ7PreXUbjMeXutMUwve9F4OvOCQY/WLJc3dg4hUXyfkyqQsAXvgf83ByvvGuu+IqmNPicws0KFPbbL9Hld1PjqlQ8ZKwDLlgdclOWqpf5IL4Y8fc3k5KZuCDCYqDBnHgD64kKR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWKcQcjX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWKcQcjX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccdf36f63dso246605ad.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 04:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786965385; x=1787570185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R+l+UxdGP4xSYpq+snL3DrvZxjB7YwI2tVyA/dO6w4c=;
        b=AWKcQcjXD/D6J5J1hZni+5sx8WNCevU9x2JSSbpH2TJ0yKIPP2LmJ3QcQUyxItHItF
         4+bCQQxgh4eEGt5OHlTHLQkvvT6S8421GiRvp5gzhESIZpFXgFb9iyYmY4HoDy+4E8xx
         lub2WalbGNi3NDuornLxNnmj2gQwUJu5t9kFXft2xbUB5yIAowJaDLC55gg6+E6+mwlD
         Do1+DO6f2v6Mr9Ih9FaocC3vblyf80ZBDTqG2/KdHti/wQPLogjd1UAqCqwZTdaP7EO/
         NIN6RJHPV2jaQdWGvuNRAtYSuBwdS0nZ7gO783Jjzss4JoqSFwJN+9Shdx76+VkJ9a4I
         eN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786965385; x=1787570185;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R+l+UxdGP4xSYpq+snL3DrvZxjB7YwI2tVyA/dO6w4c=;
        b=R5JBLSmHJT8BaAinOJVGJ854Y3cKAj/bAe36zhfRL9Q+iaTVogrqb+xNgphAmbkNJD
         acVpCwijNv6ffCH8gwFp9wD8kCFs/fy0xnslXs2UaT8hM3O8oSr57KnIFpyt84SdmPYE
         R6tpw4WsFqjP3nMMK6FqoSMmdQ9xBQbUjyt+61b1vc8CGO8BBjs0EZ7UCLtcW18YH9RR
         uh/TaGiBKE/BQoJ8ju9b0HR9eDrVYMYIHNjIzPfoM47cWAS7owIMyLlZUnh8Z363uDah
         zY/vC1s8vySy6X3kGv9biZz6747d2vNR2/G2HBYf1BNPONjBu0rK9wfeXAyGKsyJQEUb
         pCYw==
X-Forwarded-Encrypted: i=1; AHgh+RrWWC6vCjIT5gYnD0k/QHkKy4WN6/HUX4rldncp95uK+V9NMRuc88K+p/jcU/c9IMcKIXivDHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQ5JzAeSSwd4wzxENcZqQX+gCL0dz8pUPys4QPtabNomHN6PE
	EtaS7edZQthLhKexRSPRz7/KtERpM603m+W+Np21noRqaM1FIz470LT9Wv4onDadXg==
X-Gm-Gg: AR+sD11qQrQCp6H3fFmePpQdt5PKhpaZc7ttZnVqiApTyo+pyI71hAEVA1tKwFaxqwj
	0xuNTTJa2/NbWiXafYudX4Ht9evvnhNGSTYpBqahHhaFKgjzSauMxyxIY/+PTsR0GOTAjca5HPe
	e3iY/VT1RBwVYpG5Rx1Pwsha9WLLhtYsFVb4JidPbZuJOCRv8Fh1BryCYU22+WrI3JTycVrM4EU
	p4vahi32ltcVF8zCwFgiiDOp6MCfsjZYD7TU/j9QoMqomS3w7HN4Q2EQNQmkT1fuV/eLAaItCNr
	URdSEZzlToUsPPZZtZoTMfyyfURNqvVJLug7Asq84Y+BtgMeTCYrgwO9HQPXf3yXRyZAfUR8eeU
	8LLNxNMjPFtxjPBfU2Ub9HAWNZMTAZxZjKNe1o7TYaRlk/fnIffFFfUdZASJQXZg7GuHPQPkVia
	X0GnQCa0fBS9WDNGvM8JgdXRkdvH70h4UTf/75nx4NSvciXvSMcBCR7BmdtBe2UhsnCHmibU181
	+KHK87zZfZSjmiurvh6wRs=
X-Received: by 2002:a17:903:2b0c:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2d596cfb925mr4566865ad.11.1786965384912;
        Mon, 17 Aug 2026 04:16:24 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb499e8csm3975245ad.2.2026.08.17.04.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:16:24 -0700 (PDT)
Date: Mon, 17 Aug 2026 11:16:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Dmitry Malkin <dma@nebius.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Message-ID: <aoLtgeYLpYobpyKN@google.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814174825.GC510472@nvidia.com>
 <PA1P190MB25573D7CFE42EF7DD2A8CDE8DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814221103.GE510472@nvidia.com>
 <PA1P190MB2557D53CB7FCB70EB8F79D09DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA1P190MB2557D53CB7FCB70EB8F79D09DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>

On Mon, Aug 17, 2026 at 09:29:10AM +0000, Dmitry Malkin wrote:
> > Don't use it that way?
> 
> Why not? We use pci=config_acs to configure ACS at kernel startup and
> enable direct PCIe peer-to-peer traffic between GPUs and NICs. All 
> affected devices are assigned to the same VM and IOMMU domain, which 
> also reduces the memory footprint by reducing the number of page tables
> and lowers IOTLB pressure.
> 

I'll defer the debate of enabling ACS or not OR supporting multi-device
groups for vIOMMU for a moment.

But, regarding PCI P2PDMA, you can still enable it with ACS enabled in
the upstream kernel *IF* your hardware supports TLP forwarding between
root ports.

When ACS is enabled, all TLPs get forwarded to the host's Root Ports
instead of getting routed directly through the switch. All that needs to
be done is to add an entry of your hardware to the whitelist in p2pdma.c
(pci_p2pdma_whitelist). Are you aware if your HW supports this? If yes,
then a simple addition like [1] should work.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260409150123.3538444-2-jmoroni@google.com/
