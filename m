Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704489;
	b=zOusGfc4SECA9la2aiZaFDUIk2QHrD/FzHbRZq9UiTeicbRFPPIi+IL8k/nFr2KYrAX9
	 /j8boUDz8pyUpDYwCCrFIYAXgUa0kw5J6OrXc7PdrkSzEpDKvXjtvYgksHVXyUau70Jez
	 I1zvPFnsvjvp3F+MUAXkGV9XU+MNZSGpQc5qz1kkZ+pOlLahlA5QWSfELuo9OJs1BzXG0
	 zaTk6AlaKRaU4XaL6olcmDcR2H7RGoVbyK14ZeHem9Np53GaIHWyDAKQFyhVB7SjsP/Ke
	 yq57FgqGMpZzWVw9uFE4kU3D37Ypg5xncSI7GfAjdXCZyb8W8oD42hjm+CHfZW3AcCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704489;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z++RwfSOpv1D+is69MtrAgce33j60bZ7b/lnmHz+62o=;
	b=29njrPJtWNO8F6pcGiLr/YQFVRwDeX09MRG2iw/vpqtYdnUv6kCfyk7XiLh7cr/s6Ldp
	 CxYLgsXq1viEGhCvdvT7yLG9UuHiPeey9qhXYG/k37Q1AcLMwYSewm+c0RgSbMGaWrUOP
	 ddO7VLPf7R6J7HwxOq3FXro24yPeHal2LPicpVfxTt/lDp1uG4YJpQmqxrwi0+m35U4RY
	 TPeDksEUCA3kfDfkdzmcxkZ7/xeK1SEZv7bwbdXuF2qP4hGfQzBvMLshyJhw141IVRhUd
	 /2TEnKvAtjT7pRLDkYM/53LdUhxie1DPmkHIBImn5QW8a9x61ak860Vd4Qm4RN9xbpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=I7+2eveW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A3606A327;
	Sun, 15 Nov 2026 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=I7+2eveW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4311F000C4;
	Sun, 15 Nov 2026 01:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794704488;
	bh=Z++RwfSOpv1D+is69MtrAgce33j60bZ7b/lnmHz+62o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I7+2eveWTbz5QA7n3oa8l8UmABOwqAo93YJY58ad7Gq6lfHtbMMao8yrMvSF0oQFl
	 bs0og4THi0b6or62hMXyuP3E44tyHUBRRSFtJmeJ9sRzGhlw+zKU2cPo/7r2WKpkkb
	 ais8kbBlQ7TTTwDgzm1xVCf3jK/9uNsoJydOuLGI=
Date: Sat, 14 Nov 2026 17:01:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, leon@kernel.org,
 david@kernel.org, kas@kernel.org, dave.hansen@linux.intel.com,
 bp@alien8.de, rppt@kernel.org, stable@vger.kernel.org,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
Message-Id: <20261114170127.3d29199864eb352d9045eaba@linux-foundation.org>
In-Reply-To: <20261115000005.GG3706007@nvidia.com>
References: <20261113195536.2660763-1-gourry@gourry.net>
	<20261113200303.GA395967@nvidia.com>
	<179460249376.482102.14669935557901467762.b4-reply@b4>
	<20261114002027.GE3706007@nvidia.com>
	<20261113181025.6e8b9475b29c13d29f59e02e@linux-foundation.org>
	<20261115000005.GG3706007@nvidia.com>
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

On Sat, 14 Nov 2026 20:00:05 -0400 Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Nov 13, 2026 at 06:10:25PM -0800, Andrew Morton wrote:
> 
> > How does this look for an altered changelog?
> > 
> > : On x86, a shadow-stack PTE has its ordinary write bit clear.  The CPU
> > : rejects ordinary stores to it, but pte_write() reports it writable because
> > : shadow-stack instructions can write it.  HMM consequently sets
> > : HMM_PFN_WRITE, which Nouveau turns into ordinary GPU write permission.  A
> > : process with GPU access can then overwrite its own shadow stack,
> > : potentially corrupting return addresses or bypassing that protection.
> > : 
> > : Reject shadow-stack VMAs in hmm_vma_walk_test(), including read access.  A
> > : requested fault returns -EFAULT; a snapshot records HMM_PFN_ERROR.
> 
> Yes, but it is not just nouveau, RDMA user can do this too and
> that is far more common..

Thanks.  This?

On x86, a shadow-stack PTE has its ordinary write bit clear.  The CPU
rejects ordinary stores, but pte_write() reports it writable because
shadow-stack instructions can write it.  HMM consequently sets
HMM_PFN_WRITE.  Nouveau uses that flag for GPU write permission, and
RDMA on-demand paging can use it to grant device write permission to a
registered memory region.  A device, or an RDMA peer with write access
to that region, can then overwrite the process's shadow stack,
potentially corrupting return addresses or bypassing that protection.

Reject shadow-stack VMAs in hmm_vma_walk_test(), including read access.
A requested fault returns -EFAULT; a snapshot records HMM_PFN_ERROR.

