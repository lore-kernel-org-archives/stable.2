Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43C1220F2D;
	Sun,  7 Jun 2026 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852389; cv=none; b=Amn2+uvsgr+A56+7PTvTEvT4zxDM3WY0rOIo2rxirmlb0OH++D53NhF4n0IvyiI+chkrlSkwCKrFlVKsz7Q1a8j3oDBXAjyGBxLWnUNXoDv/1/ZHhDfGis/CsVqSp4XTN7K6/6fcc49+jhrXynCD2syfVdUkuwvlXt/gj6ohyK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852389; c=relaxed/simple;
	bh=UHOrwhIddpp61bKZYue79ECpscxqyH8KhLDhF8d0fkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THAFU8JJBqbMaNaldtXK7Q7dAdWAxSif9uPg25Wm8Bhazj0OOG2pYm042qU0VA2ULRH2DZDK91FE7j9ILab6xCexp0qo7NADrz5qXF41DlCR/blshSRAEVjt9wan5ILh9tW45qZ17OedJSaI9x4gXf+xHDLPgmD+Q8RlrRKxg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o/xBFDVA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o/xBFDVA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5oMknEXe36qU1bPGmnb8gDZjM7NiqJWhpG1ba25rvls=; b=o/xBFDVATbF7i+hIvfAEHdFtZI
	nqytBHAymVHRtd6JTPJsz7xHAvJWXkErSetcwTLm3m5icBIaZ8/RkV2MMjYCA0ejRwUO5FDRX8Nd3
	KIIcwIxllpRP4xKEl6ue6fsKH/3UlN+8Y/GokjHII7JVagEOzKdxrr2SfiuhcLAXA5cxlqVmH90SF
	cmz7hJlbKjTdApYfx4ZYxnCcs9ZFRgwveTtQzKfhyHYlnHYnatL6QSgvnrjyuJgJH9RglF3Gsv0Jx
	O8Pp3YRwa7sLY4gQr2gbKfXZTgTrc9euauT9kfcbqfZJHqdUjdO1cx7pIF7Z4zgViLF4rQUXKbNd9
	wMxbW2RQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWH3Y-00000002MRH-3CB5;
	Sun, 07 Jun 2026 17:13:04 +0000
Message-ID: <570aef33-c7fc-41dc-9042-d3871d58de0a@infradead.org>
Date: Sun, 7 Jun 2026 10:13:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_legacy: remove documentation for removed module
 parameters
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org
Cc: stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Damien Le Moal <dlemoal@kernel.org>
References: <20260607064053.195166-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260607064053.195166-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/26 11:40 PM, Ethan Nelson-Moore wrote:
> Commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") removed
> several module parameters from the pata_legacy driver, but neglected to
> remove their documentation. Remove it.
> 
> Fixes: 3c4d783f6922 ("ata: pata_legacy: remove VLB support")
> Cc: stable@vger.kernel.org # 7.0+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  .../admin-guide/kernel-parameters.txt         | 37 -------------------
>  1 file changed, 37 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 97007f4f69d4..47bccc148a54 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4935,18 +4935,6 @@ Kernel parameters
>  			Set to non-zero if a chip is present that snoops speed
>  			changes.  Disabled by default.
>  
> -	pata_legacy.ht6560a=	[HW,LIBATA]
> -			Format: <int>
> -			Set to 1, 2, or 3 for HT 6560A on the primary channel,
> -			the secondary channel, or both channels respectively.
> -			Disabled by default.
> -
> -	pata_legacy.ht6560b=	[HW,LIBATA]
> -			Format: <int>
> -			Set to 1, 2, or 3 for HT 6560B on the primary channel,
> -			the secondary channel, or both channels respectively.
> -			Disabled by default.
> -
>  	pata_legacy.iordy_mask=	[HW,LIBATA]
>  			Format: <int>
>  			IORDY enable mask.  Set individual bits to allow IORDY
> @@ -4959,18 +4947,6 @@ Kernel parameters
>  			with the sequence.  By default IORDY is allowed across
>  			all channels.
>  
> -	pata_legacy.opti82c46x=	[HW,LIBATA]
> -			Format: <int>
> -			Set to 1, 2, or 3 for Opti 82c611A on the primary
> -			channel, the secondary channel, or both channels
> -			respectively.  Disabled by default.
> -
> -	pata_legacy.opti82c611a=	[HW,LIBATA]
> -			Format: <int>
> -			Set to 1, 2, or 3 for Opti 82c465MV on the primary
> -			channel, the secondary channel, or both channels
> -			respectively.  Disabled by default.
> -
>  	pata_legacy.pio_mask=	[HW,LIBATA]
>  			Format: <int>
>  			PIO mode mask for autospeed devices.  Set individual
> @@ -4994,19 +4970,6 @@ Kernel parameters
>  			the first port in the list above (0x1f0), and so on.
>  			By default all supported ports are probed.
>  
> -	pata_legacy.qdi=	[HW,LIBATA]
> -			Format: <int>
> -			Set to non-zero to probe QDI controllers.  By default
> -			set to 1 if CONFIG_PATA_QDI_MODULE, 0 otherwise.
> -
> -	pata_legacy.winbond=	[HW,LIBATA]
> -			Format: <int>
> -			Set to non-zero to probe Winbond controllers.  Use
> -			the standard I/O port (0x130) if 1, otherwise the
> -			value given is the I/O port to use (typically 0x1b0).
> -			By default set to 1 if CONFIG_PATA_WINBOND_VLB_MODULE,
> -			0 otherwise.
> -
>  	pata_platform.pio_mask=	[HW,LIBATA]
>  			Format: <int>
>  			Supported PIO mode mask.  Set individual bits to allow

-- 
~Randy
