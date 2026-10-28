Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181962;
	b=tC4J45uBgatgqcGGphsvaCartV0bMPjV9k0+TyjYoW3SbyG9cjPomzZkzsnjXyH47RR5
	 MbSn9Zg448T1WnZnSqhQzx8743Ui0IQOo9pSPIepQYamaH6eVf3trXqcClJkLeOQUMDjO
	 AuLYXXfv0aI0AL775v51dfx5IuNG/oSovUg1tehds8RaeQspJKkkpKNLi404h6DCNiMS0
	 pnP2eVrAiz3W9GxImC55hhE8OTpjprIeXFkm8qPc9wKoscOMDvPeASq0QfNDoO1D4vHBS
	 MliH7lCHU92HT0Rrxf1XEXp/SwEFnJbLrMuZYLGwPrfLS8K2oton2xBIu507NUrRmZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181962;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NAoqzJJLYEl/71mItF/KJrpHXvjH7jXDLRcjZwyY56U=;
	b=ZSf4rsjfHDUGp4wrcVKqwdN4nB2mXdJpbjEOvWNCrWM3B1L4SLoNtI5x7ihICrQXAekC
	 5YTabrGm+PgLqhszEpLP//eNUKQulGqU0W5zFhxVlaEO+RAASR+k4EiKjQf1Kk7KAdVB4
	 ggzC2gS+2FQRfsvVk4W0gHbPtiphayI5+kLMZ+NSm9kMj6V+zcxcSJm/qo73WqT8msSeK
	 vU/Pi3SXK+SXXQDERHgUFdWUB7ZQq7NfoPczlakYSzYZqm6WqhPlV6EL8DAfKPEIWmi4x
	 +N3KfNzMf+89+jNVKjUbD5YPlHn5fQnovqf1opEvfdQxQHfBwkaSRloC2vlYDtXtk4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vkyG+Qva;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941A606A31A;
	Wed, 28 Oct 2026 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vkyG+Qva
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C77C1F01825;
	Wed, 28 Oct 2026 10:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793181961;
	bh=NAoqzJJLYEl/71mItF/KJrpHXvjH7jXDLRcjZwyY56U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vkyG+QvasZphdnkwaoRvoq1V56SZcgGUXnj4HVvjWeYKZcKYuvOKW8EDHdN4dgQX2
	 MnyJ55N64l24dzM/nGRloB9FDY+g/rSa6e+5Sr8W0D5G8W9JSSuTG9/NrW/Q8P+BMl
	 MH1m0ywukaGBQnxeGP/hEfKLOX/0jxvfOgOhIjF4=
Date: Wed, 28 Oct 2026 11:05:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Brad Warrum <bwarrum@linux.ibm.com>,
	Ritu Agarwal <rituagar@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Adam Reznechek <adreznec@linux.vnet.ibm.com>,
	Steven Royer <seroyer@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/6] misc: ibmvmc: initialize HMC state before device
 registration
Message-ID: <2026102832-spearhead-concur-fbbf@gregkh>
References: <20261028044828.96177-1-yaojiale02@163.com>
 <20261028044828.96177-5-yaojiale02@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028044828.96177-5-yaojiale02@163.com>

On Wed, Oct 28, 2026 at 12:48:24PM +0800, Jiale Yao wrote:
> misc_register() exposes the IBM VMC device before the HMC state and
> spinlocks are initialized. A userspace operation racing module
> initialization can therefore access an HMC through an uninitialized
> spinlock.
> 
> Initialize all HMC state before registering the misc device.
> 
> Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/misc/ibmvmc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
> index 6afef0788b90..d03aeb8dea8f 100644
> --- a/drivers/misc/ibmvmc.c
> +++ b/drivers/misc/ibmvmc.c
> @@ -2366,14 +2366,6 @@ static int __init ibmvmc_module_init(void)
>  	ibmvmc.state = ibmvmc_state_initial;
>  	pr_info("ibmvmc: version %s\n", IBMVMC_DRIVER_VERSION);
>  
> -	rc = misc_register(&ibmvmc_miscdev);
> -	if (rc) {
> -		pr_err("ibmvmc: misc registration failed\n");
> -		goto misc_register_failed;
> -	}
> -	pr_info("ibmvmc: node %d:%d\n", MISC_MAJOR,
> -		ibmvmc_miscdev.minor);
> -
>  	/* Initialize data structures */
>  	memset(hmcs, 0, sizeof(struct ibmvmc_hmc) * MAX_HMCS);
>  	for (i = 0; i < MAX_HMCS; i++) {
> @@ -2383,6 +2375,14 @@ static int __init ibmvmc_module_init(void)
>  			hmcs[i].queue_outbound_msgs[j] = VMC_INVALID_BUFFER_ID;
>  	}
>  
> +	rc = misc_register(&ibmvmc_miscdev);
> +	if (rc) {
> +		pr_err("ibmvmc: misc registration failed\n");
> +		goto misc_register_failed;
> +	}
> +	pr_info("ibmvmc: node %d:%d\n", MISC_MAJOR,
> +		ibmvmc_miscdev.minor);

Note, when drivers are successful, they are quiet, so this can go away
with an add-on patch.

thanks,

greg k-h
