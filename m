Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86449550D
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913003; cv=none; b=mylR2gZtfU/Ftf3KLOu0zKIkdOI5MpT1U4EXV8FkW3h05t7Ej4yHeKqOgrK5veyMNFuEcZF8+FGN2AbbpofFOeQTqlJvXmLhctT6FQPCxkG3TMv3tW7nusrEO2BNI8QLkyR+0LhY7igQ6AOR/0618xjFjoMdletTxWKUtsdB810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913003; c=relaxed/simple;
	bh=Rvbe9sFMJGpQWup1UcjTJpn3Xq27G7UIqOzhJnx5NSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aw2WMamVmaFBBrjnwuwLIRugFMh4bCWNQryHPVqdV1/3GFiijFuIDilRz4pg2fScZbfeyafJuhEzllai/tXo5bz2W+D5MsTLD6Bu6IBuAJagUWj6CMwXkie2ugN2S7Hl0+tZKDyCWXgvOJIbotVqAMUhM68Wlthbqx6QkJrE2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ic4t8H/y; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ic4t8H/y"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso39505ad.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782912999; x=1783517799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qS13cSENFGcBB0bnz6k1QAxOjQr0kz2UqGp/5+eDOd8=;
        b=Ic4t8H/youc6RlIzIJUsjoIK0uNO8p2/e7x4/Jabg6v4vqafr8T64dfIOoNmiPGuNZ
         1DLvWMQu2x1oUlWJww1PqUbc0FBnGsWMUgbEaaAhZWnXyWReYrLrlLKs0qsNfzW9HSTZ
         dIlFjwiUf3LGl+0eprZ+MLRq4wgBJ+ooH85lxLjxyyrumtQbsvEzTkVlCUM2Aff91HYQ
         x3Yu61GrOZSa2thG9n15OkLZyRQS/L2IPspEqYD8oAFw8UhYPQaDtbQengtyS7HfpTjD
         hjErBPmZrGTwxWHR+1bEr7kBP1TEWxeg1O5s3geRzUqusBBLsY56WGg5MnKaIMHOy2CW
         qTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912999; x=1783517799;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qS13cSENFGcBB0bnz6k1QAxOjQr0kz2UqGp/5+eDOd8=;
        b=motaXlahORGyz8wJ72wBlgkMPK9RW5x47/VgNci7lNxUk3FoWB/BgGUimQiG+TXTYT
         h0GE+HjwEvKGWumJ9+9dOUIiJw/eP4wQ0CE7cIEJcCAYS/+J1yng7TG6VWY9ZSXqcgpB
         Vp2OuqlzqK9GIjIKlIrTOsTFLUb9VmGIBP8ps95RRjzyxXPK6BwNt8Evqhjp8GLGOs2/
         4P8mqYhUB3TvRvPIPAaWG/0QdECKzTk+7yCMXaOTKCKd/+1Jv+tWe6ilPe5PPxEhyE8u
         2Sjbk+StMKJ6cVpP8dNTkWyI53X6pqvAlwK7AI5+idc0HI3KbuWNOj5gRehzKM/VzICj
         MJLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5LPz53m637uRaRU51og4Pj6FRksAPl9yRShJqjmBamVCwbUCnOaOZpvOz8fL0LOyz+/k60ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfALP+C9YuKt/HopZyykiJw5HlcizJwtVHEU78Xa202Sj/CrHt
	F6oIuJTxTGkt746hlUQxNiKHLGfMtmTL1TAx/Sj7mepE7PLKNb9P8uC0CyTVfd9IZg==
X-Gm-Gg: AfdE7ckpiXXXDWXxJSN5fR6fTLvr6/oT6A1Mk17zqaAv0Lnq13goxSEUDxUSm4PXQEh
	TUv83fUPPmAcVpRU2giQDeBmAukTYWpgdummZKCeaExlxVFxcVZLkwpJ0NpoJ/ZfR2Gp1OqAvER
	xL7EYTsozQBqtcdATSj0kcbq3iowaWXQBUDG52aO3J/4TOBDOibtQnbr1bdBCKSAJXm801ryWLB
	dvG2Xmg71OPPd7m4O2mV9sqBrL3ff77SO4AM1EHcMgGLmuCrKQGsE411SLG2S3hUV/AObyklyVI
	QEgAstQkuYXWbAVoBfWEA84Be1ZC9wjGjURnfKvJ2fYWif7r96KCS/HvV+MDk9QmYY81yUy+8LE
	m7hler6ncMWAaLC3BLaDiilhx1kyfuUYT1/NbsAm2SpRYwZEIaBF/59qa4+yjXdQKj2nMNWcboM
	OA7n3IgmsBiGQzteUVIbyScbJ6p90v9Q1YU2w5TdrLSrZE4Yk=
X-Received: by 2002:a17:903:283:b0:2ca:1bbe:c3e0 with SMTP id d9443c01a7336-2ca8f1bb537mr296825ad.0.1782912998682;
        Wed, 01 Jul 2026 06:36:38 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479fffa65bsm4111750b3a.21.2026.07.01.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:36:36 -0700 (PDT)
Date: Wed, 1 Jul 2026 13:36:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akUX3T3fIoN42sdM@google.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <20260630185942.GF7481@nvidia.com>
 <akUQj2pa1W-MekgF@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akUQj2pa1W-MekgF@google.com>

On Wed, Jul 01, 2026 at 01:05:19PM +0000, Mostafa Saleh wrote:
> On Tue, Jun 30, 2026 at 03:59:42PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 30, 2026 at 03:33:12PM +0000, Mostafa Saleh wrote:
> > 
> > > For example patch#1 verifies log2size and split and both are read
> > > from HW registers. Same for the base address or other addresses as
> > > the page tables, they  might be corrupted due to a buggy driver.
> > > My point is that, it is really hard to assume that the previous state
> > > of registers/STE/page-tables were valid or even consistent, when the
> > > kernel crashed and did not transition the state gracefully.
> > 
> > Sure, and this mechanism is probably not very useful for debugging
> > these kinds of errors in the SMMU driver. Oh well, that isn't a common
> > source of kernel crashes :)
> 
> I hope not! Although memory corruption can happen due to many other
> reasons :/
> 
> I am not trying to bikeshed, but I wondering if there is a more
> reliable way rather than doing archaeology from a panicked kernel
> SMMUv3 configuration, as I am worried that will be even harder to
> debug if it goes wrong.
> 
> >  
> > > Similarly for TLBs, the kernel might have panicked in the middle of an
> > > unmap or free domain. (not to mention what that means for RPM where
> > > a device reset with unknown TLBs)
> > 
> > TLB is fine. kdump works by carving out a chunk of memory for the
> > future crash kernel. When the kernel boots it ignores all the memory
> > used by the prior kernel. So DMA can keep running into the old kernels
> > memory with no issue. It doesn't matter if the TLBs are inconsistent or
> > not.
> 
> Ideally if a TLB is to be missed (because of the panic), it should not
> point to kdump memory as it is carved-out. However, it is still a leap to
> assume that the TLBs are in a good shape as I mentioned with RPM (or
> even if the device resets transiently for some reason) it can end up
> with garbage in its TLBs.

Regarding RPM, I can say that even if we panicked while SMMU was off in
the previous kernel, when we call device_reset() in the new kernel we
still issue the TLBI_ALL with the reset.

However, I agree with the overall problem, i.e. IF an active device
unmaps the DMA addr after the transaction in the previous kernel, 
(with the SMMU powered ON) but the TLBI was missed due to a crash/panic,
Any new DMA in the new kernel may alias onto a memory in the previous 
(crashed) kernel, not the kdump kernel.

That way, I agree that continuing DMA could be problematic as we may
corrupt the very memory we'd wanna analyze for a crash.

Thanks,
Praan

