Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBC4DA9D2;
	Wed, 30 Sep 2026 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802751; cv=none; b=oWA3KAbynLLtbrnIQg2owGFM01+joGE5pb6HMAM+d1kiEotIXNZxjjS4EBB72fiRmbVHnrwWDY2EJRYhpscL5GLT5waQhxi3R1vqvPk4kKATxIbcAVO5jIGF5ezAVFVqpdzCo7wom6RuzFW0GL2eldU5P9q1i9CKIevJkpEMhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802751; c=relaxed/simple;
	bh=nhGFUue6W3/azyptdndfI71M0av0dF5gpG/2hedrUNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2GBvXSnTH3qxYp70C/C/pDtKCSlWUlqBc3Yb+c8V1/r3VurztXACwalMrQTuz8ZyVOpepQ6/8eN7tWRtgrf8128O1mIOxEutCMRLRhuN6l9rKeoJ0xEMvmhP3siLiMP55bM42O7fX+wyd9OD2QYoXKcvJUYDsIuQH5grW6Yr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmQ5O6B/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmQ5O6B/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39721F000FF;
	Wed, 30 Sep 2026 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790802749;
	bh=8HYVJZF3emcaxpxNaf7IY/+PsW+gK43mDYKZSJ0KbX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kmQ5O6B/uwLgRKNhPdej41UUORlhkCJJNdFVyz8XqTHGQMO5VPgBMfR6BORZBdEi4
	 I6O1hNANoyVg7CViQA/WascVsFrkAQogZQL3JT4lA3JsIFrmYpQWlW06u67Tlqqd2c
	 xjsF/vGnjDOKAgrHSBU6gdtOjS8riVvxqy85c1V3APZErS0Svd+QOjAkSgpFUPo67j
	 vzilJ8MkRSjE3Zdoga+DBorigO+lt/KVbx0CZ/3v1C2Xg18R1mKDiNGmFTWHw9SeHX
	 nIHW8IYcEUWqk2Ur2mGfxB4nNvIthQ8apBqqUy2HCtUmVk7AlwCmXEMizbziaUWc4K
	 NjdZJojvU2D5Q==
Date: Wed, 30 Sep 2026 16:12:28 -0500
From: Rob Herring <robh@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	maz@kernel.org, robin.murphy@arm.com, saravanak@kernel.org,
	will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] of: Fix phandle_node reference leak in of_map_id()
Message-ID: <20260930211228.GA271514-robh@kernel.org>
References: <20260917124039.2151588-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917124039.2151588-1-vulab@iscas.ac.cn>

On Thu, Sep 17, 2026 at 12:40:39PM +0000, Wentao Liang wrote:
> of_find_node_by_phandle() returns a node with an elevated reference
> count. When the caller passes target == NULL it only wants the
> translated ID, so that reference is never handed over and must be
> dropped before returning success.
> 
> Fixes: 987068fcbdb7 ("of/irq: Break out msi-map lookup (again)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/of/base.c | 2 ++
>  1 file changed, 2 insertions(+)

This doesn't apply on current code.

Rob
