Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA1B3A9017;
	Fri, 11 Sep 2026 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146306; cv=pass; b=kOlGvGxOsXaioCESzGvZ3SXn4n5OZ7rgqT69jtWOWM0eSqYbnEbHh2rYLvk6eEZvqCDHVHUkRII3Z3parxHx38q3Nmt/nPgi9uP5KPMdRqhLKr0wGWjzkUFk0FsobZFdIkIKTAJBlWPByKVIGh7zEYiDvq8FwIZ5JermUISkbbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146306; c=relaxed/simple;
	bh=zmm2A9MpyqXedvJIwK5sxvkk99dKnoIZhT+vOHH0ACE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8HA2KiwxzPD2UvU/bd5jQwWbtXyKOWPZBSiJuwIR43y06LbTVbpqgYNnFrvuJr2k37ngEGzva8dZ8PhDtPhT0qWqEU0NoqG9b2v0+SEp75eIIcYpC6yWwxg6XZCfYuLecUFYDu23WLUusxaYcpRQT+7jicR/OkAE/3eOpX/O4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=AGLqEFdi; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=CDc2O9/B; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="AGLqEFdi";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="CDc2O9/B"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-kgp0.prod.antispam.mailspamprotection.com; s=arckey; t=1789146304;
	 b=IZhtqSl8mFGG0aV9I5Iy8QVVIP1tdLO3JE7WzQLQMciH/EeGGVAUhrMSjIhAoqRcMBzsw/BrcZ
	  bJLKgHXM8FcpzmX3ULNthTi0seohL8ytvH8Gc/Sx/l4G0/TodN0iDwfNx17c1baUHuxRjuCl82
	  Wb//l+FiC3tUsgpOn6cUCgcuGWKMiCUdkjVJiWrxpwFuFwyDK3G9wJoH+Kw64yuyN+HqnZ653y
	  P4Ty8v+a7GX4k3FLcEevOHxOo/YKxvG+yAtPSnnskQA0QXjYTnRyQ8aOYasE+9f+kmkDyBcXBn
	  eIzBiZ8zp5KGyETaXcAqfN/6di7jsluimUNveGT2QR/qXw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-kgp0.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-kgp0.prod.antispam.mailspamprotection.com; s=arckey; t=1789146304;
	bh=zmm2A9MpyqXedvJIwK5sxvkk99dKnoIZhT+vOHH0ACE=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=CwXLZ4xxFDA9BZfEEEV+W7Dj2BIRpxf1Do3BzaLqzY4aww+X1dJeRmR0C1Q+E4/FZkr9mPIIfh
	  9rJvt+DuBOxv6FJWmmWY2HGnSiFGjKS13KFWVCY09BGMDHy15SE6KzDFY6HWHoiU5zYHQmq7y9
	  w69mhtbXZ1k2prqCAZy87S50u2seO3+eUva/n3zvuCsD+q4+QvrGds9bGcAsMH4AGWNuapg3bL
	  Cr8cjYaashV6NF2O/rFMS9VZ++wC9M2dcAhPEpGX1cwl7K9uWRDBZkdHn6GXWQJM6P4bNW1+gP
	  Ur+nJIRut9T7mwyirrl4IHe/AnwNnwjjbRa+DA+FgC5NBg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=81PD0CXtFGTjh51Xosv+I8Ek9s2K3RDqe2oIG9Klr/4=; b=AGLqEFdiRr0VfriCB9xqgKOLVe
	UYcRyZI9Kg4n8EUqe9x2Xa+tTUjfHIHN28LWrocOL9Cupl4JDRN66JlBViYrCW+C6gqQ9HG3fWFWq
	moVxqyeyMC2JHHwZB/wxcyEgou7dAmURXWV8SOSh1UH6WbkKCPHSBoj5TE/cm4ooTQdU=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-kgp0.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x53jv-00000003KWR-1eZb;
	Fri, 11 Sep 2026 16:04:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=81PD0CXtFGTjh51Xosv+I8Ek9s2K3RDqe2oIG9Klr/4=; b=CDc2O9/Bp647s1FkMlCidAeJfl
	o0q4hrW0WDGNSsLrXE9ld196/IrCjEbKttiE/dj2jKqacv0IQpjtSYrqwPIm1qxtTqAmXrb0sA0Gv
	l17uMqKZwieQqdXX1zl62Zd8QXB4ZT2KoXvlljrFfQl9Ylg+8GMC5V41ZFRL8JoeKHlQ=;
Received: from [79.28.97.251] (port=62844 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <francesco@valla.it>)
	id 1x53jl-000000000mt-3Gpl;
	Fri, 11 Sep 2026 16:04:25 +0000
Date: Fri, 11 Sep 2026 18:04:24 +0200
From: Francesco Valla <francesco@valla.it>
To: Markus Breitenberger <bre@breiti.cc>
Cc: srini@kernel.org, alexander.sverdlin@siemens.com, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	Markus Breitenberger <bre@keba.com>, stable@vger.kernel.org
Subject: Re: [PATCH] eeprom: at25: fix read_poll_timeout argument order
Message-ID: <aqQlk5A3j4smHlf9@bywater>
References: <20260826121334.122881-1-bre@breiti.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826121334.122881-1-bre@breiti.cc>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 2b71bfd380d1641964c1a690c677dce9
X-AntiAbuse: ID - 2b71bfd380d1641964c1a690c677dce9
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x53jv-00000003KWR-1eZb-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-kgp0.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Markus,

On Wed, Aug 26, 2026 at 02:13:34PM +0200, Markus Breitenberger wrote:
> From: Markus Breitenberger <bre@keba.com>
> 
> Commit 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API") passes
> the arguments to read_poll_timeout() in the wrong order. It supplies false
> as sleep_us, USEC_PER_MSEC as timeout_us, and USEC_PER_MSEC * EE_TIMEOUT
> as sleep_before_read.
> 
> Consequently, at25_wait_ready() busy-polls with a timeout of only 1 ms
> instead of sleeping between polls and timing out after 25 ms. EEPROMs which
> keep the write-in-progress bit set for longer than 1 ms are reported as
> timed out, although the page may still be programmed after the driver
> returns. A multi-page write is then aborted after the first page, leaving a
> partial write.
> 
> This was reproduced with a 25LC080: a 32-byte write spanning two 16-byte
> pages returned -ETIMEDOUT after programming only the first page.
> 

This impacted also a device equipped with a M95512W EEPROM from ST, for
which I saw consistent write timeouts (even if on a second read the
memory contains the intended value). I can confirm your fix solved the
issue.

Tested-by: Francesco Valla <francesco@valla.it>

> Pass the polling interval, timeout, and sleep_before_read argument in their
> proper positions.
> 
> Fixes: 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Breitenberger <bre@keba.com>
> ---
>  drivers/nvmem/at25.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/at25.c b/drivers/nvmem/at25.c
> index bc2cfb75d9bb4..9e71c6a859471 100644
> --- a/drivers/nvmem/at25.c
> +++ b/drivers/nvmem/at25.c
> @@ -224,8 +224,8 @@ static int at25_wait_ready(struct at25_data *at25)
>  					   SPI_MEM_OP_DATA_IN(1, bounce, 1));
>  
>  	read_poll_timeout(spi_mem_exec_op, status,
> -			  status || !(bounce[0] & AT25_SR_nRDY), false,
> -			  USEC_PER_MSEC, USEC_PER_MSEC * EE_TIMEOUT,
> +			  status || !(bounce[0] & AT25_SR_nRDY),
> +			  USEC_PER_MSEC, USEC_PER_MSEC * EE_TIMEOUT, false,
>  			  at25->spimem, &op);
>  	if (status < 0)
>  		return status;
> -- 
> 2.47.3
> 

Thank you!

Regards,

Francesco

