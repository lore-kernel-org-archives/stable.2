Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CA3CAE99;
	Sun, 23 Aug 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489965; cv=none; b=gwuFUbiMb7ekhe2VRLnboqARrrW3BBSNgUTfsg1RkZYqk1HsSPIP2KgyGlZB8SAV0e2Gc4OTlLM1VZ7X6VqrY7RNZeKGeCVGcX2tUlKzp15ACJ/4RWLZKr8kXrzOkArDR0YLFM/N7mQLQ4whqpd5DfVLk6yOtKk+D1sYR4uzHBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489965; c=relaxed/simple;
	bh=1rWfNLzeSqDBuY5x+1Iz3WhRpyXveDZwcird3UHZiak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxRbq+A5uKkUC7Wrx/9LIeXH02XPgEPIAgvoLOzb2somdMq3hqqhsPtjwnXUfk7dasgX4O1/1CzOy6g9KqOCS0KwiB73PI61mHLWovBl1Qc2xDqrk5zUOozc6rEorKi5H7rfrXkdpfMzerh48fBl1TGzILcM/Kgngwlo1rb5uSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd+8aTFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd+8aTFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204F71F000E9;
	Sun, 23 Aug 2026 12:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787489963;
	bh=/Ov0tYDbk+TlLDpegxsvuVL0iS6K5D1KA8wlpfKMDCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qd+8aTFAxFf6TM0MMNKwkF4kX+0oloujIuDykTSYZ6Y4I7RfQIukm0vXsEZynbs9l
	 Lukrj1aA6z5AUOMh7QAuRT6lAcn1q8vyFEVvHdpL4Wrfc74TnbElCwhEWd/LFNqbMI
	 rVBk/foTJ7gOCRRDCAx9yVqdTO7F7hCF0EKIWNp8H7CxXggZruluhWvqRSZQyQYpPk
	 ZHRibyN5Grvt10CVT0Pd6+LOnvtTaXedFyBVcNRQXKWc1VWMfRUTmdEm/MaYxFjJd4
	 kWj/e3R5StPnBsU4VhJ5Clap898HvpPUmmk6cKQpPsytHHNBtFypJoUCaNhhd13ZoE
	 OU9rezcv/WqQQ==
Date: Sun, 23 Aug 2026 20:59:15 +0800
From: Gao Xiang <xiang@kernel.org>
To: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
Cc: xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	hongbohbli@tencent.com, guochunhai@vivo.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] erofs: skip sufficiently large global buffers when
 resizing
Message-ID: <aoruo-aVZ0IHJ58G@XiangdeMacBook-Pro.local>
Mail-Followup-To: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>,
	xiang@kernel.org, chao@kernel.org, zbestahu@gmail.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	hongbohbli@tencent.com, guochunhai@vivo.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20260822140017.8119-1-nikhilgurudasani314@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260822140017.8119-1-nikhilgurudasani314@gmail.com>

On Sat, Aug 22, 2026 at 07:30:17PM +0530, Nikhil Gurudasani wrote:
> z_erofs_gbuf_nrpages is advanced only after every global buffer has been
> grown. If a resize fails after some buffers were enlarged, a retry
> revisits those enlarged buffers.
> 
> Retrying the same size then returns -ENOMEM because alloc_pages_bulk()
> has no pages to add and the unchanged return value is treated as a
> failure. Retrying an intermediate size allocates a temporary pointer
> array smaller than gbuf->nrpages and copies more existing pointers than
> the array can hold.
> 
> Skip buffers that already satisfy the request. Once all remaining
> buffers have caught up, advancing z_erofs_gbuf_nrpages again describes
> the guaranteed minimum size across the pool.
> 
> Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
> Cc: stable@vger.kernel.org # 6.10+
> Signed-off-by: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang
