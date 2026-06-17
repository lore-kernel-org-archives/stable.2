Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0304A449ED2
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706120; cv=none; b=e0XJawlTgP9Ld+xIyib8k7/BB2rImtg6uhe8tYosvBAeEuv0L/dcuIxwVpxVLYqC8CG+zWBlSpvWiICLuGG4ykgMlm6/5Pj7R3f1cOWZ+fr5MGueL/RSNWjn6mRbpe4mV9VmWYdPLbbccgCEfZCZW9YZpPEJ5PzNIEGR7+gtCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706120; c=relaxed/simple;
	bh=tITp3vI8QCODQTdN3D7k1C5vtWMYgUCUyDY+YluPXsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pflefdndiJkG6P8YZhuVmb4uMe59snawrMYkIN0P307W6YAIkzlD7f5I7dSlkRdCDETygZlX4MzI4sX7Dr9jfXuFUXq+jqTI03wzMTdBuEp34xtkFVkw9TNkqdgGNrf2mWbKeVNhSRxlsEciJP1FlkA+FMXITh5Fzl7qKrUBVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtuAxn+I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmrUOBOd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtuAxn+I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmrUOBOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781706118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELObF5Iq/B3jkGpc0knxM9Qj8R7NO2xwYgcKK7rlrAQ=;
	b=PtuAxn+II8Km1nMtASvQ5s/Z4URBw25uJw+a7PVjNVj98XlmtO9sPPR9QoyaLaSVC8LVQ4
	pT1U9/7UegBETSlI+IgJA0myJB0kuMwry9OtHuiPMz+dxkPPeocQ9KW7YmH8Lg/tVguitQ
	KP6y3tyjZMVBlBNMMVlIMJbRDSUbki0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-wh63EqY9PYW5skKgISM_GQ-1; Wed, 17 Jun 2026 10:21:55 -0400
X-MC-Unique: wh63EqY9PYW5skKgISM_GQ-1
X-Mimecast-MFC-AGG-ID: wh63EqY9PYW5skKgISM_GQ_1781706114
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9157c8eb597so910304785a.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781706114; x=1782310914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELObF5Iq/B3jkGpc0knxM9Qj8R7NO2xwYgcKK7rlrAQ=;
        b=EmrUOBOdJNUkveNN8EZH7XwTz+W694tGph2Ev0FA0QMPvZlgggV+uyWhWHgV64pUsQ
         fdsU50lfVCE+itx+J05vOagCZ7r4XLRC4iWo3Dfeb4z9AUTT/Evb+fuJrFTGdIJHJC0s
         8L++gdkWTZjiS8V01OEGGlF2KTWABvsVh/ISIMFJ8MeKlyY2NcCU/n++ujOV2d/cb1ha
         R5Kz0cpNSM91DqS3CDK4UN2bSAZcoUoGwza/kM9jth6uHOIZV9iH+kMYYb05En1tArvH
         VCXCzIKSOOsmQxY0b0Ix3fQb0vXChJvmjFa9qx0s9TkcbGCqYin7aqH+ebYkNunPxH0v
         E3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706114; x=1782310914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELObF5Iq/B3jkGpc0knxM9Qj8R7NO2xwYgcKK7rlrAQ=;
        b=maZYPxmvkC5GfZJu280v9dmWQTfneDjNtyrttT1NcaQkZ10ygX7cEuzD5t9MoOeesL
         GcEYAsIwrqTzbXzjd61lcOCnbEHclyK25wT86iL4B8mTgdsdGPlJBE/4/yDoDl80LmGh
         YIZ1oFpd3fMaODoZmz2OWNn4Z8h+kzyJQ6+brVYJ4iFi2YYLXQz66dGAlRl9byyj3lu5
         AE2B/kObUv/w8W3OeEGnOn0vkItvY90GnQ1D26rrdDpn0MZfb89/CzjPztFrKbzRWkWh
         OGPLE929P0UKTxMcQTToxC9PYjHGR0ENOD8qGIyKL5fpK7i/3WfpyndlI/qXZmpfha5x
         BerQ==
X-Forwarded-Encrypted: i=1; AFNElJ86yLaYDO1IZIU4bltH9Dy9rh2MNT6nTmzW9tWtsVexGam3miITfQuoaDk1u8g4AjvF3as3800=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfaOqEdk6BSL5MHULBRwjtt37bUvglmLUZUeDFhErwJTyndvtf
	7qO07GNv+aquBwnK+4ezecT2p3V6/ZiF+YvsCJEvasniSUnKR+EYPn086nriG1UBug7FQJ4dGZx
	a5D6COHZ8FB3k94cp1jCAKBJtcYaWJ+dyazmmV1eNOz9VxB8vmwotaD7yug==
X-Gm-Gg: Acq92OGvY+9v8YjJP/2Yi0OuooVJGAX3ojUN2uTPkBJuzFNac0h/cKbYu34wLurunDq
	aKBOyVYMehUMLG3zsGEwpPLXOQZiAwW8S7Zo03Ymvk9ptxDEgbpB7PfSDt06EfQ6Qol/4OM4Zt9
	spvvdjw6g1FrbVRtXb7vyUgAv9tp4Q7jTS9ro0QlXq3nNvboNm2JptvmtEWN+yqe28+fQ+V+qDg
	PNjQzUSMvvSG1pejH/IdpUUCWLgU8IYMMhzW4wWyFVtYxeHqT8CxR95UCoxu9h3f1ij6ZcVxzzz
	6brKQfMq3mjylPisChe9LUnJOCrH96pBe7Cqj5qBRs/Z7CXmAhmsXZLO77K/Uz266jyFpn40K7t
	E/t4=
X-Received: by 2002:a05:620a:29ce:b0:915:c365:ffb1 with SMTP id af79cd13be357-91d8bfb0904mr635622985a.57.1781706113728;
        Wed, 17 Jun 2026 07:21:53 -0700 (PDT)
X-Received: by 2002:a05:620a:29ce:b0:915:c365:ffb1 with SMTP id af79cd13be357-91d8bfb0904mr635618885a.57.1781706113132;
        Wed, 17 Jun 2026 07:21:53 -0700 (PDT)
Received: from x1.local ([174.91.116.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006441sm1869207585a.27.2026.06.17.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:21:52 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:21:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Anthony Pighin <anthony.pighin@nokia.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajKtdCN0AlbmBnAj@x1.local>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260616163054.77fdb61a@shazbot.org>

On Tue, Jun 16, 2026 at 04:30:54PM -0600, Alex Williamson wrote:
> On Tue, 16 Jun 2026 14:01:29 -0400
> Anthony Pighin <anthony.pighin@nokia.com> wrote:
> 
> > VFIO PCI devices support PMD-sized page table entries for BAR mappings
> > via their huge_fault handler (vfio_pci_mmap_huge_fault).  However, the
> > VFIO device file_operations never provided a get_unmapped_area callback
> > to request PMD-aligned virtual address placement from the mmap address
> > allocator.
> > 
> > Before commit 34d7cf637c43 ("mm: don't try THP alignment for FS without
> > get_unmapped_area"), this was masked by a bug introduced in commit
> > ed48e87c7df3 ("thp: add thp_get_unmapped_area_vmflags()") which
> > inadvertently applied THP alignment to all file-backed mappings,
> > regardless of whether they provided a get_unmapped_area callback.
> > 
> > When commit 34d7cf637c43 ("mm: don't try THP alignment for FS without
> > get_unmapped_area") correctly restricted THP alignment to anonymous
> > mappings and files that explicitly opt in via get_unmapped_area, VFIO BAR
> > mappings lost their PMD-aligned placement.  Since the huge_fault handler
> > requires both the VMA start address and the physical PFN to be
> > PMD-aligned, unaligned VMAs force a fallback to 4KB page faults.
> > 
> > For example, a 2GiB BAR results in 524,288 individual page faults
> > instead of 1,024 PMD-sized faults, increasing the VFIO_IOMMU_MAP_DMA
> > pinning time by orders of magnitude -- a regression directly visible to
> > KVM guests during PCI device initialization.
> > 
> > Fix this by providing a get_unmapped_area callback in vfio_device_fops,
> > following the same pattern used by ext4, xfs, btrfs, fuse, and other
> > subsystems that benefit from THP-aligned placement.
> 
> The trouble is that PMD alignment isn't right either, your 1024 PMD
> faults on a 2GiB BAR would be 2 faults on x86_64 with PUD mappings.
> QEMU has forced the alignment to make it optimal for some time[1], so
> there are userspace VMM options.  Seems like you were previously
> getting lucky.
> 
> Peter Xu was working on a more comprehensive solution[2] late last
> year, but it seems there was an objection to the
> file_operations.get_mapping_order() proposal before Plumbers and the
> thread hasn't rekindled.
> 
> Gentle bump to Peter and Willy that maybe we could resurrect that
> effort.  Thanks,

Yes, since QEMU doesn't need it, it was low priority on my list (also due
to much more downstream works recently, and a lot of things happened).

I can definitely try again.

I'll wait for another 1-2 weeks in case Matthew would like to provide a
better suggestion, otherwise I can send a new version based on what we
have, and we can start from there.

Thanks,

-- 
Peter Xu

