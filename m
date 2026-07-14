Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CADC3A641B;
	Tue, 14 Jul 2026 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066978; cv=none; b=ihnHmIrpqjmxT0dCh0euMVP23tFqvjaj1hyIj8mPHUFWy/Tp8H7ov6cdygC2X3wkLw4OqAGARSCAujMExsyvrezjvFkRNaKI9pv00QNzylM6B2sNusL45v7ANDUkCwg60NVFfoydZbR+0X9QPim2gyU//gkVs9i3zgknY7h0X4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066978; c=relaxed/simple;
	bh=dmt/fGiX6on1rUYOUz/R4Sla5mRk7czJAkpAHmUN6i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLMuovqt/D8v8VliYSpqQkAB2zEO9wmy4UhE2ep/TyPeCR0FuEZghm74jJ7BzdllbMFVwHqveb5GndSKmd7AYG9QikpxLtANBrsO1kPb94Yvlm2WMSNzNUbSDxy8BJxI0rZNLqf0Co5D6vhSpiFba+QXdoHxXS9h9P0YerZ++2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTBr/yfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTBr/yfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20201F000E9;
	Tue, 14 Jul 2026 22:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066976;
	bh=wxvsj6q5kv46vdKE+rJesB3/rgThH7otn1mWolRYdcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FTBr/yfGvOtUsR788S9vygjJNjiAUVxeXnC25KDhcmlKsX9lnydoKTIg2KsirLheV
	 18FG2TCNMOZ96EGcM8/dDbMs0Oie5X7lvqPmqWRuSkV2M0MSJ7FH1DZmnsGzBnyvLQ
	 tQOcpdKZhLNyFXfDpJosBQ9bZPwfoN/qcy4orzs+UGMVOvNIqqvfe2m71p/mMJL+rV
	 L08+xhIyossHxPlX1QkcWcPjk+aLoCVMkKWK8Bd0pdqmYb9G68aeCCj3J3BZtMHVmR
	 NNtYCoHu/X5aBIP/n2p1FoFqHVkLXzTPlds13tvcTA8z5VqPFU6273AE5RIVLtr/Ct
	 cHeI0676htQaw==
Date: Wed, 15 Jul 2026 00:09:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: linux-i2c@vger.kernel.org, kblaiech@nvidia.com, asmaa@nvidia.com, 
	vadimp@mellanox.com, wsa@kernel.org, linux-kernel@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: mlxbf: Fix use-after-free in
 mlxbf_i2c_init_resource()
Message-ID: <alZyjKuqR-Hs90Dd@zenone.zhora.eu>
References: <20260714150808.85045-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714150808.85045-1-xuanqiang.luo@linux.dev>

Hi Xuanqiang,

On Tue, Jul 14, 2026 at 11:08:08PM +0800, Xuanqiang Luo wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> If devm_platform_get_and_ioremap_resource() returns an error,
> mlxbf_i2c_init_resource() frees tmp_res before reading tmp_res->io to
> get the error code. This results in a use-after-free.
> 
> Save the error code before freeing tmp_res.
> 
> Fixes: b5b5b32081cd ("i2c: mlxbf: I2C SMBus driver for Mellanox BlueField SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

merged to i2c/i2c-fixes.

Thanks,
Andi
