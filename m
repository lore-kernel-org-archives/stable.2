Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48E37E310;
	Mon, 24 Aug 2026 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787608195; cv=none; b=gb+OADucYLLIEqxKENW7nHXhnTI5Pj9UQeUr9APQQdan2KVMOxkKcv/S/xym56nlc6805W2EkxltwSoIWVjy8YtopzxQ9wHJJ7zFMieaz2ZQz9sW/HFLdAl4dL83ztWgSRAdMQO4gfXTpr0DyQxTErD7XxuQUS8OzF7fQK6sE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787608195; c=relaxed/simple;
	bh=56xfdz7PwV1Y5Ku8/e6bO66IS0u8QipkU0I0VeqnkrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+WWIdqCz1Q+ROozLzFyCfl4twpmKMiXesdDB+Sm+6hNyqEKk7JZo2V0yiusuT5zkiReB5KSQwIDaIYqn4n3/OyHnOE/kAP/mRIlatPv04B84MauFVvsxkhtiN+GnF8PXJcPJkJKotBcDAwK8tr9i2tKcnnhW2bL5iqdUPuPg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTJfD7JP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTJfD7JP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3843B1F000E9;
	Mon, 24 Aug 2026 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787608194;
	bh=8Y8tZ2yPkr4eQp29NxFMS96y/9nHRbndwJB2IImZV/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jTJfD7JPczCoAwBQ/gC69/NBh6dq7TxqxsLBOnFlpNuChbA0lUnPGmLyUK6ofWnQ3
	 nligsvcnPjWoDWiw8TBtD/ma/+DK4i8amIpv1k9z+tWvzwfoouRV0vTHYxd+FjqHS7
	 Lk513FEK8mv8nrX0Ots+A8lYMO7vSa7CeUbb0Bsw3sBOAsLrUnwHMwHynUX3YhDGQ6
	 +Zs3WWfF2zedV+wJkmWSWe93r7LbVyo+jrpqbwG9DTG/Qgg2kMGA3Xi41vzQ8uLY1k
	 HswIq9e3dGyXwiDWQ2M+dfkiuZgRbHYjugYv30IRKabfYKjkj600uNiQD8337iaDcz
	 Q3fEBzj9s8wUA==
Date: Mon, 24 Aug 2026 16:49:53 -0500
From: Rob Herring <robh@kernel.org>
To: zhaoguohan@kylinos.cn
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org,
	Oded Gabbay <ogabbay@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] accel/ethosu: check MMIO mapping errors in probe
Message-ID: <20260824214953.GB50486-robh@kernel.org>
References: <20260716065219.931088-1-zhaoguohan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716065219.931088-1-zhaoguohan@kylinos.cn>

On Thu, Jul 16, 2026 at 02:52:19PM +0800, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> devm_platform_ioremap_resource() returns an error pointer when the register
> resource cannot be mapped. ethosu_probe() stores it and continues until
> initialization dereferences it through MMIO accessors.
> 
> Return the mapping error before initializing the device.
> 
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>  drivers/accel/ethosu/ethosu_drv.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Rob

