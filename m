Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B602C3268;
	Tue, 23 Jun 2026 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229045; cv=none; b=V6S1lXJ+jqsYC5z3o8jEDkhpW1cQl9NtbJRe9pHCnynVD2r6uiI+mmCIXu6VHQkKe5dyAiWd2FHb6ir5pdZDxD5g1GxZGY5+UgN/PDuFlsnsPACmyfDcHGjsr8I+urUgGPZC7FQNzHa5ieX6AgjW3zjbPOARyFF8xQBNGIM874E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229045; c=relaxed/simple;
	bh=nREeY4DTiLgeB4zrofIO+IvNNQ2PDsTx87UtYyTPrPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ah1sVd/CJxj4IncbTOgDOYGQgItX+PbCxTFRQcICZnthCVzYqf68KvJusMwhfGXIyjVdiICPmDMPZ+f6lL0zkn91LTaHQ3XvTx1+YrGAH51xevHMQXgf3YPbM7lIpF/mowT6Mh8cvAUBv8yPSG+vW4w0rGFp0nEZ41HuomjxDQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdRUuRIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdRUuRIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB9B1F000E9;
	Tue, 23 Jun 2026 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782229044;
	bh=od1GINUddwoJVFpvWPgpX9maKY8Jm8T7x2Idfnie6Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OdRUuRIWDgSWPKI1zESzng3DnadQcFEv3Kwh2K5YAZZi8pcWF1Vs6DSMdAdHTUgKE
	 1SS5uC0R/o1lRd/byfakX336xbwGRcYM07VgavLLe+8EXFZkheQZ6NMWmvUu0xecYa
	 uur9AMwbe0rXlX9TdH1yj1ug88ODZq2k6HO6iXmPXbJMPAmDJEbjZXP3DwhLUxrroP
	 YDekleLVx7Qo8G8W1R6txeO3M+0n29S4q8vhRMMh7KalTq7gQmEZY7R5Dg3hZQydSv
	 6c9l5aR9dX0Fq1MYQtIH7dWDWUlPHwbqGKJ4WPTcDy4ZwYRY93UH7Xtofe6H7udnpw
	 wpPNn4Lw/Racw==
Date: Tue, 23 Jun 2026 17:37:19 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/1] i2c: mpc: Fix timeout calculations
Message-ID: <ajqmNOky98RWB989@zenone.zhora.eu>
References: <20260618144934.3249950-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618144934.3249950-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Thu, Jun 18, 2026 at 04:49:34PM +0200, Andy Shevchenko wrote:
> ON the first glance the harmless cleanup of the driver does nothing bad.
> However, as the operator precedence list states the '*' (multiplication)
> and '/' division operators have order 5 with left-to-right associativity
> the *= has order 17 and associativity right-to-left. It wouldn't not be
> a problem to replace
> 
> 	foo = foo * HZ / 1000000;
> 
> with
> 
> 	foo *= HZ / 1000000;
> 
> if HZ constant is in Hertz. The problem is that in the Linux kernel HZ is
> defined in jiffy units, which is order of magnitude smaller than a million.
> That's why operator precedence has a crucial role here. Fix the regression
> by reverting pre-optimized calculations.
> 
> Fixes: be40a3ae719f ("i2c: mpc: Use of_property_read_u32 instead of of_get_property")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

merged to i2c/i2c-fixes.

Thanks,
Andi

> ---
>  drivers/i2c/busses/i2c-mpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index 28c5c5c1fb7a..a21fa45bd64c 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -844,7 +844,7 @@ static int fsl_i2c_probe(struct platform_device *op)
>  					      "fsl,timeout", &mpc_ops.timeout);
>  
>  	if (!result) {
> -		mpc_ops.timeout *= HZ / 1000000;
> +		mpc_ops.timeout = mpc_ops.timeout * HZ / 1000000;
>  		if (mpc_ops.timeout < 5)
>  			mpc_ops.timeout = 5;
>  	} else {
> -- 
> 2.50.1
> 
