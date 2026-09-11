Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468CA4078CA;
	Fri, 11 Sep 2026 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152729; cv=none; b=bQS4ae4cI+tztEYZH5iVW2Xmys8XW3RKwx4KMrw2anRZXs0ynG/+4SERwqgAhdSkyzjgGmkups+DiAL9J2qGrT4uyDJ7/wMzdaZftyKZ1i/CWFu6S9DJUEk3k9FwsEFP71dSD7qCHmr05lBNV46yms417WnVVEDi+qGYUmuv0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152729; c=relaxed/simple;
	bh=ATqKkXAynA5QOvitO9FjFGvwl6ctXOXJbMRKDDJf2hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0HxwngPT4MlH1VcNEiowo/TGGDB6zKeSPLkM5dGHPu9Dw2HKQfm9TMPvpycQsR0RhHwBpFvfFWNr9B/7hBvrD2EUG68twaU1C78f4Pj/Kd/FFB9KsyavlG/7IhI8Jr1c6osOMA/XatnIuVHMbCpc3pFYJCaRLYam5bto9jrV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibrceeau; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibrceeau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE6B1F00898;
	Fri, 11 Sep 2026 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789152727;
	bh=N+qEtiefGNYeRTxGzeBD3t/Z7q5fIfiPccH3vPmIgB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ibrceeaukk5kc2bY3x1aA1Djv9txsrZBXBcoOVhJAhluX5OMBOIrDq3yMSs7Lgz77
	 UQUh1udNEiZwb1vq+7fHYMznCC+YHQhrZp02m6AE8fsfPvv/Zy7F8Dlm3Qdh39snZw
	 537WP1EcSe1968jTjquqsNTWRXKSLUj8eCeFwyJE2sm4Q/3HaA1c92qRyKOkQpFVRp
	 +slXJkbfa0qTe9C68xz/9+7wp0dHzD1SmQUBcAJW3Mdrp5RBer/s67x/z9pmYyy7rL
	 GkmgA2l1v8E7ZEAvhxs4yrjjzhjNMSPb+6CVDWIwUrTujnJJp+D4/DE2rQWRe3ELlX
	 DeLJbtsrpWxUg==
Message-ID: <db8af2fe-481d-454b-a205-4f22cd9b7a0d@kernel.org>
Date: Fri, 11 Sep 2026 20:52:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Lenovo IdeaPad Slim 3
 14IWC11
To: Iustin Ivan <iustinivan2002@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260911182328.9267-1-iustinivan2002@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260911182328.9267-1-iustinivan2002@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Sep-26 8:23 PM, Iustin Ivan wrote:
> The internal keyboard on the Lenovo IdeaPad Slim 3 14IWC11 (83RQ) does
> not work after boot. The keyboard ACKs every command during probe,
> including ATKBD_CMD_ENABLE, but never sends any scancodes afterwards.
> Booting with 'i8042.dumbkbd=1' makes it work at the cost of the
> CapsLock LED. Adding the atkbd_deactivate_fixup quirk fixes the
> keyboard and the LED natively.
> 
> DMI: LENOVO 83RQ/LNVNB161216, BIOS U2CN19WW 03/30/2026
> 
> Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
> Cc: stable@vger.kernel.org
> Signed-off-by: Iustin Ivan <iustinivan2002@gmail.com>

I'm starting to wonder if we should not just make this behavior the default.

IIRC the whole deactivate thing was added as a workaround for multi-byte scancodes
getting split-up during suspend/resume. I wonder if we can come-up with some
better fix for that ?

Regards,

Hans







> ---
>  drivers/input/keyboard/atkbd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index b9ad2381f885..923f77808381 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -1938,6 +1938,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
>  		},
>  		.callback = atkbd_deactivate_fixup,
>  	},
> +	{
> +		/* Lenovo IdeaPad Slim 3 14IWC11 (83RQ) */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83RQ"),
> +		},
> +		.callback = atkbd_deactivate_fixup,
> +	},
>  	{
>  		/* Xiaomi Book Pro 14 (TM2424) */
>  		.matches = {

