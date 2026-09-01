Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E5246A60D;
	Tue,  1 Sep 2026 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247982; cv=none; b=J9sZ7hPcNSg0+2L81fvH1plnPiOmHL9DuOuoWTA9lJjUOsHVdjf3yx2P1jS/VjwsTCwb0WDMaIu5PpmyNMgzX39amAbaGI8DZlx/0txqZSj7dULSJ8oi99hTQUVOA/THlVC/1tOAOnoyQCAfDnT3x8hOtL4JlYdJmBCNCsjdVU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247982; c=relaxed/simple;
	bh=2N9sCi6h9dJxi3qeeuQonOWtvlT3PqVXsA0qz1GT/7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUL62sapxC4tPUSPHuBMQxKEXL19Wrf4kzxoCVIydkqEiZ1xjiC23J57kSsQXyBZsGy1GCYQ+sjZsdFv6CH8yETz1bxUVFnw2JfkRp5awSvlBMHFC/FKuKX0hxtxoho2EPUMJVa2NvdE0H88jZAuK/M5yf5jvDRqFm2XZWz79a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7/cGw2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7/cGw2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160FB1F000E9;
	Tue,  1 Sep 2026 07:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788247980;
	bh=dvXB6JlFJ7X9cDLh9nu97HQ3RuIBY4MfLc0NAOT+UXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c7/cGw2XQNGsiIXqkgdTeFyQNQ60PhocbgoSrLF3JwD1G3esYuminR/vw9PatwZsf
	 FoXJOOazky/fOX9+xbD4LrdZfMqIzvDj851UDsexdzGt5wGGdfWzaDydcZg1G4oW+g
	 TYnPF36/8jDnVETfdfpOendapBkVXZptAiW3J4/iqVzOmU0d+6tfn7euWIqa/OCd6N
	 Kxqa3idA3K7tKYJ2R50kEFvVF/AAjyo4a/UhVdJDZidnEOGX9llb9iRPf+nD/wuxRq
	 AcQ4xHx1BB0JPEIpgH1c6dfXBqxjqnVdHj6z3GJommJaVbAe4NQoEU7EcB545AWAWF
	 +qtWTD6J9NTxw==
Date: Tue, 1 Sep 2026 15:32:42 +0800
From: Gao Xiang <xiang@kernel.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] erofs: add sysfs feature entry for xattr prefixes
Message-ID: <apZ_msfJd-XscfnG@XiangdeMacBook-Pro.local>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
	chao@kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260901062243.109172-1-jefflexu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901062243.109172-1-jefflexu@linux.alibaba.com>

On Tue, Sep 01, 2026 at 02:22:43PM +0800, Jingbo Xu wrote:
> Let /sys/fs/erofs/features/xattr_prefixes advertise that this kernel
> supports the EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES on-disk format.
> 
> Fixes: 6a318ccd7e08 ("erofs: enable long extended attribute name prefixes")
> Cc: <stable@vger.kernel.org> # 6.4+
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang
