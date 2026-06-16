Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3D3AB5B8;
	Tue, 16 Jun 2026 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649062; cv=none; b=QKlBaYSFtOubu1PdiQbYRgvHe+3DqR0MmqGw3S2kIKiAsCv2qh61jC1SkJAA83CggIcyVOhTin8BqAcYq8sJEk4sJGURw1MdmgSA2OKk6JdwOziM4SLJKLJ0YG9qes9f3S1V2/nNDNGKPOrZcL03DQh5Swupv7suUJqEZ7Mm5rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649062; c=relaxed/simple;
	bh=u+EjfXEtMOWobmqbeSfAKWQoHPaxuk50sDJrW1KXnIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AE7oc0vC+CQNYKCoFqx4WYuUsN3MhzFbvzk/otcfHwdbbIIgaLGP5d9bHQOd9QOcHT0I+C+8egRRZtArEwO82lqJ01/bTWtNMDe3emPfaHw/rwyePPA9sSMApaYd/jO1/zJ3kKGP7bK+LLN8poyLjtGT0q66INxiOfOWQgiQ3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=cOjqQwdU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ao7hB8oP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="cOjqQwdU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ao7hB8oP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C03BFEC02B0;
	Tue, 16 Jun 2026 18:30:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 16 Jun 2026 18:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781649058;
	 x=1781735458; bh=+rHioyxYKaAJ4voYMnnaD3/bRBJeekx7zwdVkQIQUaU=; b=
	cOjqQwdUNOXO8ALbDbO5Z0Ln8eTHl5wyQqsu6jgkiIl7qzfprtLp7llSYBgg0Wvx
	wvIlv7kOo5MjD9cimT+e5Vu7AUQX+CXcajBbiNvmkNGdDrW9E1lTE6c/ItJw81xD
	ucJdRc8LxDBOKkxc+FAAZmn9Ld27t2Y3OyDj4btQs+U5xyYe9Sw0YZxdndm9ZeV4
	vZlG7NbxRV3ejpqjYK5wxOEra8ZbLBinXXhOa8BnLogXG5UX7QFXGYD1GbcFdkR7
	u3jHHhSLiHCSzZmaGSWABHIgXhwDOxDFc5F4/VKHgwFKuXL5ThYwvZRBE226j4Ku
	EB3VAUA1773mkEkC8eTVrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781649058; x=
	1781735458; bh=+rHioyxYKaAJ4voYMnnaD3/bRBJeekx7zwdVkQIQUaU=; b=A
	o7hB8oPpV6BUt0hX9ngV85lw8YaKLaTf3jVFxOJ6cJIVl1xHpHg84X/Zfeo8EWCB
	GrbZtkpXdHpHFqsIgp6XhS3Nx9Mg4akEo8tMkm2wJ0/ZI93HuUI64U31JJVtSGUB
	IGDdmZ9vR7yDocDwlXnOGX3oAA1hFInebb6NrGpJa8Ycd8brxggat1/HRH6iri8h
	F4e3jsu2Mdm90J9uR9Uj4dLR9aFkM4QQrke4xrbAesv3dYnAQ7NvZX7lyEKKJwh5
	fpqUYRzjJbfcFKqmt1g9H8FfpMbibnAzEv3uhUNM/MGoFS767LNQ48CR3vJxH7Tl
	LDGwX0btEFAeSXQkG3BbQ==
X-ME-Sender: <xms:oc4xasSCgAyl4jtUB7Xl5wUysUgATze-_wqVO4njVfw32fccAcur4g>
    <xme:oc4xalqYyEO8ZAxdLI6whZg8q3F7oari7gni07ii4g94dikVbntIvV9DgPMPqqlmM
    XogChvxAXRNkO-Ddi0XjV1L8Pmrcc8TLfNlTWRAVTu7CDDFvAGm>
X-ME-Received: <xmr:oc4xam3VDGQtUREFgIvJBX9B7fMqFMAfT2a1iamlQQMfRqb-si-AoYwGGKU>
X-ME-Proxy-Cause: dmFkZTEQIFPA4DQ+IouZXdl4nSL5KRmpBGJ3LtjyzM/GA31zC1k73CGibn8xX7GbuoPEQH
    oUVqqCdVPKY60sTREchsl+HrmfPRF2QiEsb2Wji/gNsSR2FgRPcUYKPCFbtTQ64kL5iQuM
    7Ave/+wa27MixGbGt2a6e9N5roePRyYb14CpYGgQX8pg5f5enPj/CARpjhzVd5ghDW/Y33
    3o7CsWsim4sddyGENQ5mlsl1S7NNxDm7JLGRXjh3kBc6FJokPdNxC/B7r/8iy4kJKkPTR/
    zh2ysrQ4usOcEpOAMY+tXkbR5FDKAJdoMG/JTDW8LwPYdG77yApNnK8Khs4RgGZvJqxWCU
    Sx60sepY32PnQgNSPKEOqxkworrp2jrMr9hjGttSQMiRnsDoyOjFq6jU3KP+vaZTWiHrda
    09u4ZplXGHZ1PjuucjmtF8GuiW9GdYa7ZPRYzJyp6PbiLjm3DMywDCLSJW3eaWfR5Q3UmQ
    JcZLCgNjlh1sO1TkV9HqUStnWjsc3rIXLrNwdNWHQEsG9v/VTToRCHbKfBuDhshpb7W+0j
    eia862X0khMn38HSTycGBw8o5+tuJPiNhFbYAWmQaRYtjBWeHsZwC4Auyghag1gHek0BUv
    dAs6qZJ5uB6kYs5SNUW2vqTdWBxYZASA25IIQKNQK++QbEV4hGsd556i+HwA
X-ME-Proxy: <xmx:oc4xak445CRRPh97mIcTJKdDCKjLqE9LN3rAAvxcXJdEcO6LNNhJrA>
    <xmx:oc4xaqRG-xMhniFjEg-nkFA_6wRqzeMp1PDFZXk-7KD7hP6rbIvLlg>
    <xmx:oc4xahWpUs3ZYUjBUz6J8aIjBa4_hykahb73R278jz20t4xmqvNQEA>
    <xmx:oc4xanFyAQydMqPW_Z5omgpFRXnZQkZ_bNL0wtvk3HgWvdMexKbD1A>
    <xmx:os4xanbm7eaPWslPJ7D7bqGPJWEYDzdDbkT72KcoWnZ0W00l1MJEh7zS>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 18:30:56 -0400 (EDT)
Date: Tue, 16 Jun 2026 16:30:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: Anthony Pighin <anthony.pighin@nokia.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Kefeng Wang
 <wangkefeng.wang@huawei.com>, Vlastimil Babka <vbabka@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, alex@shazbot.org,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Peter
 Xu <peterx@redhat.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <20260616163054.77fdb61a@shazbot.org>
In-Reply-To: <20260616180129.160016-1-anthony.pighin@nokia.com>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 14:01:29 -0400
Anthony Pighin <anthony.pighin@nokia.com> wrote:

> VFIO PCI devices support PMD-sized page table entries for BAR mappings
> via their huge_fault handler (vfio_pci_mmap_huge_fault).  However, the
> VFIO device file_operations never provided a get_unmapped_area callback
> to request PMD-aligned virtual address placement from the mmap address
> allocator.
> 
> Before commit 34d7cf637c43 ("mm: don't try THP alignment for FS without
> get_unmapped_area"), this was masked by a bug introduced in commit
> ed48e87c7df3 ("thp: add thp_get_unmapped_area_vmflags()") which
> inadvertently applied THP alignment to all file-backed mappings,
> regardless of whether they provided a get_unmapped_area callback.
> 
> When commit 34d7cf637c43 ("mm: don't try THP alignment for FS without
> get_unmapped_area") correctly restricted THP alignment to anonymous
> mappings and files that explicitly opt in via get_unmapped_area, VFIO BAR
> mappings lost their PMD-aligned placement.  Since the huge_fault handler
> requires both the VMA start address and the physical PFN to be
> PMD-aligned, unaligned VMAs force a fallback to 4KB page faults.
> 
> For example, a 2GiB BAR results in 524,288 individual page faults
> instead of 1,024 PMD-sized faults, increasing the VFIO_IOMMU_MAP_DMA
> pinning time by orders of magnitude -- a regression directly visible to
> KVM guests during PCI device initialization.
> 
> Fix this by providing a get_unmapped_area callback in vfio_device_fops,
> following the same pattern used by ext4, xfs, btrfs, fuse, and other
> subsystems that benefit from THP-aligned placement.

The trouble is that PMD alignment isn't right either, your 1024 PMD
faults on a 2GiB BAR would be 2 faults on x86_64 with PUD mappings.
QEMU has forced the alignment to make it optimal for some time[1], so
there are userspace VMM options.  Seems like you were previously
getting lucky.

Peter Xu was working on a more comprehensive solution[2] late last
year, but it seems there was an objection to the
file_operations.get_mapping_order() proposal before Plumbers and the
thread hasn't rekindled.

Gentle bump to Peter and Willy that maybe we could resurrect that
effort.  Thanks,

Alex

[1]https://gitlab.com/qemu-project/qemu/-/commit/00b519c0bca0
[2]https://lore.kernel.org/all/20251204151003.171039-1-peterx@redhat.com/
