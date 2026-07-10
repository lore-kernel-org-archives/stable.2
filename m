Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C83246EB;
	Fri, 10 Jul 2026 02:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783651353; cv=none; b=kkhE9tCxaosCTre6XWFvXsNoRZk6WRKDZdfA6GsQceYOnbv/zhJk0soRLCtzTwjQ7pbSfDxa+mnp8Lp7b1usjn7JndG3XHIyZUBnxyUu1dXi1QPugAkll47LgfD8Pj1wFJRYSZxermSylr/rZHjy5D7+ocfQbvXet6bruqTs2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783651353; c=relaxed/simple;
	bh=gx+ra1hZnmrrzim40EBXIy/+RsvC/s0kcfr/sDU0VAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADEWn9PfHK85JkxgHc0fFx5hGkT1ZgiNPqpmeEjlPSG35O8lh7f+DNzTD1/vZQmA87eCyXHLs76dUKXUnSx4Ghm5Ihw9/Y0zrETTKqDnWVBONZWLyJDpcM8wsJgqloLc2BE0COUqP8t4a7zwxERgK0eDrHGfFx1tsWv6wH+AUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKxCABF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKxCABF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA71B1F00A3D;
	Fri, 10 Jul 2026 02:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783651351;
	bh=0CkT2pbPlw2rWsywXX0DcvXBZbc7R7CKMiUZ7rlutY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RKxCABF+rjTzG3Y3507xPZgMXL614Re7iPyRGeBmo3r6m9CM1WqzXIhj925XeOf+v
	 ONT1ce6IAXM72kaPqAn7nsBPDVvNaOOL4mYnUb9ZJbQKbQa6HDa2s+qGqEfswXFY+C
	 SkI40Iw1i+H9kQAXgPGqI7Jnenf34Fq//XjNKsOKmzI2bBTDpa6GN2TGlmLR6Zd6oo
	 BJs4xsG1TI8SlmQR8aqEjDm4pJtuqCLWSRGKg0Rn3tbTrL2e5uhcG7ZMj54TE6P4MH
	 cx4lIFDIisg23PzzYwLchGKUGG+ctS2We74YF7MxkrvYfFeAC8BfIYwDVIv3UZefa0
	 71Mdx4L+wyB3A==
Date: Fri, 10 Jul 2026 10:42:22 +0800
From: Gao Xiang <xiang@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] erofs: cap LZMA stream pool size
Message-ID: <alBcDlPeV8IPEngL@debian>
Mail-Followup-To: Michael Bommarito <michael.bommarito@gmail.com>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260710023036.3745254-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710023036.3745254-1-michael.bommarito@gmail.com>

On Thu, Jul 09, 2026 at 10:30:36PM -0400, Michael Bommarito wrote:
> fs/erofs/decompressor_lzma.c sizes the module-global MicroLZMA stream
> pool from num_possible_cpus() or lzma_streams, then
> z_erofs_load_lzma_config() preallocates one image-supplied dictionary per
> stream, accepting dictionaries up to 8 MiB.  On high-CPU systems, a small
> EROFS image can pin hundreds of MiB of vmalloc-backed decoder state until
> the erofs module is unloaded.
> 
> Impact: an attacker-supplied EROFS image mounted by the system can pin up
> to 8 MiB times the LZMA stream count of kernel vmalloc memory.
> 
> Cap the LZMA stream pool at 16 streams.  That keeps the worst-case
> preallocated dictionary pool at 128 MiB while preserving the existing
> per-image dictionary limit.
> 
> Fixes: 622ceaddb764 ("erofs: lzma compression support")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

I guess we can make the maximum LZMA configurable
instead by using a Kconfig?

like CONFIG_EROFS_FS_LZMA_MAX_STREAMS, since I assume there is 
the different setting between the embedded systems and servers.

Thanks,
Gao Xiang
