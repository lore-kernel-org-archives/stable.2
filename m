Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395284;
	b=2fNng6I3PLILkq7ZFZdNZIVVVFSGeH0G1UoJWAMJOUDkN/WU5DYYon3i0DMTsm9n1hCJ
	 AAKWmxuYialRO4mTSZSBkRQKmloXASZBM4e1wd+mj2pC6ZQJOc9sBMokAPW1R7DjWyyyo
	 DL6E6pxydIC2QuhNKiPWeYSI4vKmrwNkkjy58IVtGaZ1b8RTM101uTzhb6oJ1MMPGOkkB
	 Vr+auP/3NR1xMoMAuzIdfooiEIlAO3ianujlgyYmYqRZmewKbRaO7AmS2U2XwDGCDUTyQ
	 0t2MMjV/1kCoT+p1VadmQsiFAZ4VEpEcCrhatsaIyG3c2ExkHBCe/+gFt6XixREW7lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395284;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HQX9cJw2kzgbRp5ZXfT3vcd1PI1jMq0ASyGe44SgcLI=;
	b=KUxBo/uK1s8wUbr2p/EQJ1XXe/FkhGmEbM0QDRs15TIpAgXm0t0B215zYR4SrBZkfRXU
	 qxNyMpD5AkuZzuanvCVu9kT3aGNxhrQcYH+eZn9aooFoAyv9iYdtJ4B6W0k716M3skQCf
	 6sY1S6eyS1Nui26zeMYkMnlgPdRcmAjSccWVsPCYMvmVdN0F4jVMuTqatH88RDVGgmmfH
	 CKOS3jEy71g2fS6ac+cy3Jq2vRS1dM8ve1JcaIQVwrQwzUYGNysrW5PYlK/XCi+Meq1Sd
	 8YAKF1KVbL54ewtfXLVXxwxARUiIzWgRYYmqUezNGD9f1ZG1K+gpdWWkqjVwwNmDExQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=temperror header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=EtigL5D7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wn6wGwFZ;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0460A6F5A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 21:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA0460A6F5A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=EtigL5D7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wn6wGwFZ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C051B7A014F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:21:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 30 Oct 2026 17:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793395281;
	 x=1793481681; bh=HQX9cJw2kzgbRp5ZXfT3vcd1PI1jMq0ASyGe44SgcLI=; b=
	EtigL5D7X3Ci0fdiYSyY6w7E2heYOCP4KYtQm64NUT1PLaPa4z3vESeUztDNJzGt
	iZvEY9sPTHbAqlOd4AydzcBTOsoKwse/lUfrhh+nIQ0WtE3+bGC8EX7iD7BCbDX0
	Ex5V4jQbKmmnOLTRi1JJZmG5uo3YS25LjpAPyAXRXHkhnFLvF5R5qBGhvtjPVfPz
	dM3ppSYsfgIEtWpoO8WVa6ydMsdPEMPUMe8LU43E4Ki/M/kgl3SnmOsM1kl0JZ0u
	GDr2p5040VOF69X3lGI7R5LNg9ddJpvW1PgecuPpUCAypDYVlbb9zOxX1PIT1LzM
	07Kuum3c7mVvqPYGu+UKKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793395281; x=
	1793481681; bh=HQX9cJw2kzgbRp5ZXfT3vcd1PI1jMq0ASyGe44SgcLI=; b=w
	n6wGwFZzDf8z8hu4ZTzBEmHruyIYa7EKwLy9q6Jxhyiova0T0pka1Y/hD+eBIFmJ
	9c63wqYYVhgVXiukrJ+rdoZW7Cou+Al8jRbf1+Rg/j0ZlPYxl1ouIiGhJ9cuI2S0
	2yEuiRW1XmuQFvXbnIlnLlDc3+M3UDj0JDpRSUiR3q57kuT3ez5sn8spmNoKhX2R
	r0qn0W0DqOax1CVIkA2Z0k2t70jAOwZ/RXucBVR2LU7nAlyw1xhCJaPGLIgyJDda
	ozEfARV2JK9BS68/sZVbYnJdGD2JXONSB/Rv1SzDcutiKDVIwRfR8pUaNC56O3/d
	k3JuDsDIjx0PCXZdXymRA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793395281; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O2MUKTwoCdLFkBLY/Foubnba7wCG2Burk9PrVh3SYhnA7GL
	gkzPnj53QQhsSZNHt8MR1d1pdKfD2c7r29U3vPuC2FVIJRdyoYZ4FEvWMr6cX4uh
	gNoo0xQcQm3TEE0wFQkCtUU36fwGOCJ13JU9HNPlDkN0QGCjb6ujEu/gT8r6HbbU
	furnNH7mpjnS/L1pfOd9/6EeuciRi8uBazsYrqk355B985CBz+6qDCzmvr7psSRF
	cdsF9H1qtRXIJplz2oHO8hOmY1VcL+gjc3oApLKSmWO0eKFPQNEml/z4fBy4P0BA
	97N3mQeuDj1Mv60147JeSrzNKXJZvFYj0rzlCFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:mv4aGPcAwkiXx8VjHMnj2do5S6mOFkP/wTto/isqEDQ=:CkHN/CEk7RtqsrgxCKdks+dxaIj4YkGXmvUoGunDtU0=;
X-ME-Sender: <xms:UQrlamwQ0wp5NMTR8_DkMZw9udTOE_0tE6HKXbSDPbQCe6LxeGaOZg>
    <xme:UQrlaqbXLTPCgqL0wurDeYBMCdb2hzT4WAEGyzpX5IyZh75w4EhKMSPpn_4cMBKre
    pGcGenKkvQjP_EmyMkl9eSCUrmm2AMCUKfV4OZ2DqZqxHyJS8DDDw>
X-ME-Received: <xmr:UQrlan0D5YSzqL_fNh7UuDr1gQ6aYa5K9HKpctWhkRzEhX087R6MjslZvgAadQ>
X-ME-Proxy-Cause: dmFkZTE9Qh59DEx5nBSxZ4EeJRHFHQUhtDF7/XkmVFDFZ1f8L9mJVueb32IcXNnhguBPcy
    oVhHboeHNk9hdJEswRPzUXFTt4r8VkNlA/hsFSvMf/O5KTL7M5hFrbG5vNZ3om0ctjr+7U
    08HiGDASsNv4o8fW4CNazOXJF/nasRc+CmXNe4E7KbEgewlslmUiXMUwmD5KhBCj9WWwMS
    T6Wkb+meTa/IhB01JPwRkyqEpj1gT820d6i0HSXfnkS/JNLfbF8t4EkjpkYi8irYjUxdse
    kMJKsuE9nUEvzkblcySo/ojLVkWWzPeH7dm0err5Aarel59lew26uF2QYMwNHhYI0Ag0Kp
    TDk6xIhPWm4yKaA3f6hGs18C4XZUop54Wl2swPD53gjeTdt2Fdm0mdCrT8bxKUmcOkEdhS
    QtD6N3scm8JyelIiJycBKlif3ZPP4S3OoVyAlmcgvHMU0m+TS/8bBfrcWbFiWbmvrKwBZy
    4i97X7yHFchoUYyqDXS7tP6qutvr5B7sYeoyiuCFelEYj9UVmOZorlfiGI9aP/cI9eMPXM
    cY1Z7V1EaYt7N3aAREmyuySkfTGRaerZ7HLBWlbfhRbbRmmr9WhdhuPf+AgbzTZw3oIbcl
    MKgqHOV3B4jBz5xroZpDePlLg2LylNHdjAm5e4E4mqv3HNCqTvPcw85jj9Sw
X-ME-Proxy: <xmx:UQrlasdIS0aBLRAipTfkHYbCnkUaoh4aSD9-QQLubmqqPHa_oICRMQ>
    <xmx:UQrlakLo1Lfzqrx-r37RRIV5xqNZ6x6utW1nyG18F2fyRqCdWZQPRg>
    <xmx:UQrlaqrPl0x1b85hwT7y5l-0AfdHkOBSkYMR8xoNvEM5R3CachtbzA>
    <xmx:UQrlaisy2HZxZ7svPUW0si3-gyZMFUUxhdawqML4YW_Bje2PmyYaVQ>
    <xmx:UQrlavZgftgP_iY9aDoLfI03lmwiLeIAG6BtAMIf-TOJLJFkfAcRq5t8>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 17:21:20 -0400 (EDT)
Date: Fri, 30 Oct 2026 15:21:18 -0600
From: Alex Williamson <alex@shazbot.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Ankit Agrawal <ankita@nvidia.com>, "Ritesh Harjani
 (IBM)" <ritesh.list@gmail.com>, alex@shazbot.org, David Matlack
 <dmatlack@google.com>
Subject: Re: [PATCH v1] vfio/pci: pass FAULT_FLAG_WRITE to
 vmf_insert_pfn_pmd/pud()
Message-ID: <20261030152118.72b62a9a@shazbot.org>
In-Reply-To: <20261024015540.538758-1-almasrymina@google.com>
References: <20261024015540.538758-1-almasrymina@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 01:55:40 +0000
Mina Almasry <almasrymina@google.com> wrote:

> vfio_pci_vmf_insert_pfn() unconditionally passes write=false to
> vmf_insert_pfn_pmd() and vmf_insert_pfn_pud().
> 
> In insert_pmd() and insert_pud(), write=false skips marking newly
> inserted PMD/PUD entries dirty/young via pmd_mkyoung(pmd_mkdirty()) and
> maybe_pmd_mkwrite(). Furthermore, when vma_wants_writenotify() is active
> on a shared writable VMA (for example, after CLEAR_REFS_SOFT_DIRTY
> clears VM_SOFTDIRTY and calls vma_set_page_prot()), vm_page_prot is
> downgraded to read-only so insert_pmd()/insert_pud() with write=false
> installs a write-protected huge PMD/PUD. Subsequent write faults enter
> wp_huge_pmd() or wp_huge_pud(), which invoke vma->vm_ops->huge_fault()
> to upgrade the entry in place. Because vfio_pci_vmf_insert_pfn() passes
> write=false, insert_pmd() and insert_pud() see !pmd_none(*pmd) with
> !write, do nothing, and return VM_FAULT_NOPAGE without setting the write
> bit or splitting the huge page, causing an infinite write page-fault
> loop.
> 
> Pass vmf->flags & FAULT_FLAG_WRITE to vmf_insert_pfn_pmd() and
> vmf_insert_pfn_pud() so write faults properly mark huge PFNMAP entries
> dirty and writable.

This seems correct to me, but the commit log misses the human
practicality portion of the argument, or at least buries it too subtly
for me in the soft-dirty references.  AIUI, this is effectively only
reached by something like CRIU twiddling clear_refs via procfs on a
running process.  That's the kind of thing someone evaluating this for
stable would want to know.

Given this unique use case, this also looks like a selftest candidate
(Cc +David).  Thanks,

Alex
 
> Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
> Cc: stable@vger.kernel.org
> Cc: Ankit Agrawal <ankita@nvidia.com>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index fcbb2da860e2..204d959086e9 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1745,6 +1745,8 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
>  				   unsigned long pfn,
>  				   unsigned int order)
>  {
> +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> +
>  	lockdep_assert_held_read(&vdev->memory_lock);
>  
>  	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
> @@ -1754,10 +1756,10 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
>  		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
>  
>  	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) && order == PMD_ORDER)
> -		return vmf_insert_pfn_pmd(vmf, pfn, false);
> +		return vmf_insert_pfn_pmd(vmf, pfn, write);
>  
>  	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) && order == PUD_ORDER)
> -		return vmf_insert_pfn_pud(vmf, pfn, false);
> +		return vmf_insert_pfn_pud(vmf, pfn, write);
>  
>  	return VM_FAULT_FALLBACK;
>  }
> 
> base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b

