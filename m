Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622227;
	b=fvrGCZaLLU6vckyED+JcSN97/geUzz7BzuKtov3VLN/4FPxFe06/fdzJD7rNoUWptS3a
	 NtxhEa4h8B+lPUnbvW/zjvG6Ham2L4tehDXYzQMlDXBQLaE8uz5TCx4X7vur2YzYTzy7q
	 O/1Uduhu7grJFHAYme1CgFFKVBaS2cXf0nDFWjLKHDOYxYVhmKyyqvUirGFNGObGbMPzQ
	 WbtgyKZ0QHLvMZQbZxpEVQVzmcjo4uOyFNvzMKwwzZChtMwPx9MzECX3RFRUgr2oqylJN
	 ZRlm5L0JJttC6ANMNGbK2zR8wtOGqoX0FepZQezEJv2bTgQ2M0Xcr2Y/XW3p33Xy/Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622227;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HSXUmoTueZUEvp7VgPWfl7EqYA8mQIeXBc1RFV+0lh4=;
	b=YdW92868kUGr0TsVviNqTnnkEwcYaH9KslRoT4SRvXaYJYLOYYcPLiPVGqEHAw95UQv7
	 h25rXEuRCUmkuYr7MnRthCGPBxUdc/w7rvm7Ojw9S7LE2rQhy4ycP9hI6U2fdNf6hIao/
	 KqSb1OBDvl+CXNB2rdW/fMi5/qpjfbB/VAWYGjHMm1DweNDb8JlYtL5oR5NGMbG8TpCrP
	 fDDb6tR3CkdrrRi68GQDWCjFb4KERNX2yNsW+LITYrlTlj3LJFiOUKBqAGX30eqNlZfjo
	 wOw0zouAWKhc1+kg1/Jak+3/AwzRqVyC8k+kWgWGHgfI61tWYcPykXWPAeRb1JPlHIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=FZOy+twc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA6606A32E;
	Sat, 14 Nov 2026 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=FZOy+twc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C761F000C4;
	Sat, 14 Nov 2026 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794622226;
	bh=HSXUmoTueZUEvp7VgPWfl7EqYA8mQIeXBc1RFV+0lh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FZOy+twcnZdsp/2EYUVyITPvhBid7djzTEf6WgS5LYzQKEOteWGy4HePPqY1U7vKf
	 5HZ3yUtdC8/0f+7WVBBTQ7muLcyCwFBlIhgCfyxNHz5nY402zWm/TJunHyONNDjanR
	 KUed1YSuY1/MyfntRmJ5o+tzH0P3AZgDw89dT3dM=
Date: Fri, 13 Nov 2026 18:10:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, leon@kernel.org,
 david@kernel.org, kas@kernel.org, dave.hansen@linux.intel.com,
 bp@alien8.de, rppt@kernel.org, stable@vger.kernel.org,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
Message-Id: <20261113181025.6e8b9475b29c13d29f59e02e@linux-foundation.org>
In-Reply-To: <20261114002027.GE3706007@nvidia.com>
References: <20261113195536.2660763-1-gourry@gourry.net>
	<20261113200303.GA395967@nvidia.com>
	<179460249376.482102.14669935557901467762.b4-reply@b4>
	<20261114002027.GE3706007@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 20:20:27 -0400 Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Nov 13, 2026 at 03:41:33PM -0500, Gregory Price (Meta) wrote:
> > On 2026-11-13 16:03 -0400, Jason Gunthorpe wrote:
> > > On Fri, Nov 13, 2026 at 02:55:36PM -0500, Gregory Price (Meta) wrote:
> > > > HMM can grant ordinary device write access to a userspace shadow stack.
> > > > On x86, pte_write() is true for a shadow-stack PTE, so a populated page
> > > > can be returned with HMM_PFN_WRITE without taking a CPU write fault.
> > > 
> > > I'm not sure I understand this? The pte is writable but you don't want
> > > only DMA to write to it?
> > >
> > > Is there something special on x86 that makes the shadow stack pte
> > > non-writable by the CPU?
> > >
> > 
> > Some of the context is here:
> > https://lore.kernel.org/all/20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org/
> > 
> > We had a similar issue with migration, but this should handle the DMA
> > case as well.
> > 
> > It's "technically writable" but the kernel is supposed to prevent that.
> 
> Bah, it's not writable at all. The CPU PTE has write disabled and
> someone thought it was a good idea to make pte_write() return true
> because the CPU allows writes through a special instruction on this
> special PTE? So now all the places like this think its writable, when
> it really isn't.
> 
> You could also fix this by having something like pte_real_write() or
> whatever that doesn't lie about the write bit in the PTE :|
> 
> The patch is still fine, in that it matches what everything else does,
> but I'd include these details someplace..

How does this look for an altered changelog?

: On x86, a shadow-stack PTE has its ordinary write bit clear.  The CPU
: rejects ordinary stores to it, but pte_write() reports it writable because
: shadow-stack instructions can write it.  HMM consequently sets
: HMM_PFN_WRITE, which Nouveau turns into ordinary GPU write permission.  A
: process with GPU access can then overwrite its own shadow stack,
: potentially corrupting return addresses or bypassing that protection.
: 
: Reject shadow-stack VMAs in hmm_vma_walk_test(), including read access.  A
: requested fault returns -EFAULT; a snapshot records HMM_PFN_ERROR.
