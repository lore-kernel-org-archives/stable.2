Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102C1448E0;
	Sat, 26 Sep 2026 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425844; cv=none; b=ZL/CdV3edypdcl/2xgvCmxvrhi9ZFkyg5wjyvO3/f9EUadNbLCvN0kh0abj9/uk38FnRejKy4Gc/F3I61DQWpyVsTf++Rxmr0Pihv2UKQFdt4U71yJRmK9M7lRD6F5Vm1bS4A1RWg0TIR033suAKSA92c4a5kV8p9KcajSbcp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425844; c=relaxed/simple;
	bh=l0HriZXii94iYULL+mMAU7AhPlXuKjWhbRFloqNQe1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDAMVcewd0lkmPf/eIm5Bm5nzOwnzHPQBDmDRAukPGBbMzKf8XxN3Hk2VxtaUUIySfb2ASGUwb1WVtYnOnto5nsEZjOGv6YBGWq7nNgatdfGLQmsVRdN9j2uv90J3teaqbYAFH3MMMxByqQua/PPgGH4kZ1Y/xb7Gb/WnC9UObg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDMdvgN7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDMdvgN7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B9C1F000FF;
	Sat, 26 Sep 2026 12:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790425843;
	bh=jWmnr7J4qu50XLlqlwEJX9uF3ohuEh01l7hkZBw4udg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NDMdvgN7zdsJbrPGGtgUlpHSWa5X+tCBjwkOiPPwqzVmEKLh+962MTZSKBrOvDue+
	 5iTUQf9MIUFFPmqsCqYENm1fmR4RGguYYt2Pna5Q2+VBZhcfJK26o9tSA+bkecJb+A
	 9yeJOcMBXTHmDICCgWYeI1hxmvCZMpV+iiN0a+qtL7XNdpaetzaAPHENZT0vLYkS9v
	 25KxuZ1UT8j9ue5eBfNDEdMfWbczlTtoJb4WoZjh2KdFDjrf75vZHUXjuWaF6sxGuB
	 /2qET4s5/yNTNLAR+vFMfXdxUORDfAcZ9elhECTSR7o/39v648u2tQCQXyPhMtuysA
	 icoq9f3dz92RA==
Date: Sat, 26 Sep 2026 15:30:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yili Zhang <zhangyili01@baidu.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Fix IOVA offset when linking phys vecs to sgt
Message-ID: <20260926123038.GT563127@unreal>
References: <20260924065508.27245-1-zhangyili01@baidu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924065508.27245-1-zhangyili01@baidu.com>

On Thu, Sep 24, 2026 at 02:55:08PM +0800, Yili Zhang wrote:
> The dma_buf_phys_vec_to_sgt() routine links every physical range into
> the allocated IOVA space at offset zero instead of advancing the offset
> by the already mapped length. This breaks the THRU_HOST_BRIDGE flow
> whenever phys_vec contains more than one entry: the second and
> subsequent dma_iova_link() calls try to install mappings on top of
> PTEs that already exist, which fails and makes the whole conversion
> return an error.
> 
> Fix it by passing the accumulated mapped_len as the IOVA offset. This
> matches the pattern used by all other dma_iova_link() callers and is
> consistent with the rest of the function: dma_iova_sync() and the
> error path in dma_iova_destroy() both operate on the [0, mapped_len)
> prefix of the IOVA space, which assumes that the ranges were linked
> contiguously starting at offset 0.
> 
> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> ---
>  drivers/dma-buf/dma-buf-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>
