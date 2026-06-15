Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03D3B3893;
	Mon, 15 Jun 2026 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529603; cv=none; b=cyj+G2k7xZdpSwwNebD74rcrSHf7HK7/2ynOImXgNNN3BEk9KGFDxdo3TDEN5v3lejSn49TRyZBd/LNPucRgbkU6CQcu/jNGrbYvG+LepwxhyxcVXzqvAQ/LyUOa3E8QRZqVRyZaaEoOPKhP0hW6ZXPIv1kMmGP0APT9n0bM1Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529603; c=relaxed/simple;
	bh=ARng867Z8/xmCrjtRCYxtG6U56IpAcYEMF23TIXRco0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5XwfGarSKxxtGQup3unKg6RwrR85e3Ngp3AVWYLVzBes3u5I0tY7om3LZQx4vmmQYCdGbjF2VNBmCGsC1/ZQ1QGluJAGXwV292+edmibSAYl33dSlIYaLsxDAObuk1LdoyTBfxbYBHEE7jtb2fBm1N0K3eTurmoPMEUoo5JZkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Fv1XLVC5; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Fv1XLVC5"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 92AD814C2D6;
	Mon, 15 Jun 2026 15:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1781529600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nr26wB4jxyUehxgg/V7GDc+U4yFEP+dNnog84OFBoLg=;
	b=Fv1XLVC5fHmh4VnUolpw7QKycOz7AZTobfasK2TUI/jjqBebonynZFT5vY48DvjVb9PlY3
	wn9xt+vy3oiEn/4nWn+Kbtk8BFHQnIg5+DnpkCNvA/10thuU9+dLzsN4EDj1FExu1G6Xib
	P9RKrZmssjKx/ODKbJFaYUJLZYQmnqhAHxrT9/hcX98OWKPqqZKqFApgn2XjAiANzkcewU
	EiJyrhzKrZ3bQJVUupbgQsNoR0DjnFVRg7fddzXVnAyepfoPE4oPREdAXmPv48TxwDwEAz
	mRJU+NhXe7yUlbYFeiyiDBTU8qD3/L85/5SARl8ZCBg1qIG8+p9fT0GcnrtY7A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f78421f0;
	Mon, 15 Jun 2026 13:19:55 +0000 (UTC)
Date: Mon, 15 Jun 2026 22:19:40 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Breno Leitao <leitao@debian.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eryu Guan <eguan@linux.alibaba.com>,
	Yiwen Jiang <jiangyiwen@huawei.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] 9p: fix WARN_ON when dropping nlink on files with nlink=0
Message-ID: <ai_77Gr0h_n5SkET@codewreck.org>
References: <20260126-9p-v1-1-dc234d53ae87@debian.org>
 <aZGRkaFZPXfZW8a0@codewreck.org>
 <aeY32gOaV5jw1s8F@gmail.com>
 <aeZNdxmYw1K0Swg9@codewreck.org>
 <ai-842Shp-LJIOBD@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ai-842Shp-LJIOBD@gmail.com>

Breno Leitao wrote on Mon, Jun 15, 2026 at 01:51:09AM -0700:
> > Please send as a proper PATCH mail and I'll tentatively apply for 7.2
> > (a bit too late for 7.1)
> 
> Please, don't forget this one for 7.2. This is one is hurting me from
> time to time.

Thanks for the reminder, that did fall through the cracks, with the
dozen of LLM-generated patches that came in lately and my attention
being more than limited..

I've picked 20260421-9p-v2-1-48762d294fad@debian.org up, and will send
it to Linus at the end of the week unless something bad happens

-- 
Dominique
