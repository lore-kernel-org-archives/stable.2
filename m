Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186322;
	b=XcrcJ8YXz1C7PAqtBvt3tl/+R9+4/997cAJ/f0yxj4kZ1MU2kNHePc/AmNmObdacaJMm
	 AWP352g175R7zNa27GrtkZf30PmGj/i0gsuqc9oGM595twsIouAfAEbEXfk32gVVYW9lX
	 nWCMN1pvHahm5i+YwT1jUwPYcxMUQWzV1vY6mDUFufvwx6QwOuABFsHzb0duO8y9uwdEf
	 xO1qip5+TQIpkUOhMtSCKT/z7o3KORD2ZPSWqDzY7nVwHfYK8cxx0tbsQtoT/Tnh3BFf1
	 Aek/p8u2eQQUWuocWROtT4cMmN9YJAwcM+F1mgzqZqV2shdbe3SiVrK/mLeeZcugzZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186322;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EwZjGQ/L6W2wuiU/1KOeUOkMNGWRYn6WQ4YecNTtyAs=;
	b=qA7H0dJiN4KqIMnhteaKGa5phGKN0FXI9IupPgZxWdnfk7NcrHyJqUe8iOmx2MiU0Ca0
	 YbyU/AlMbb1wzk5xYBYza1tLqpm3/rmtxqttOUw1omLgGg/GL6q5k+2tMTT8FA4A+FFXC
	 nWG2KBdysSekRGyyouYPUZBZ+rWKITqDHpPUjAhFTNbVlplft79TaD4uV86U7SmeAu7wG
	 ovclMww++feM7J9z0H9tvAG0pEGD0309b7hRg/zvmrvN/RTObliWRO32faziZuMs5YSDy
	 FgywqZej0E6YTg707mL4TWKY1DZ79tjnPtEh4FrtyhWppm7mxFCtfT7alfS9skyRsXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7QkC6O5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA1606A325;
	Fri, 20 Nov 2026 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N7QkC6O5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EF91F000C0;
	Fri, 20 Nov 2026 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795186321;
	bh=EwZjGQ/L6W2wuiU/1KOeUOkMNGWRYn6WQ4YecNTtyAs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N7QkC6O5ru1LuOvBydTpKokXSxQ8Mk7hR+C/3NI1Y5qTLB1EZEsQ1HmFRjvd+8kYU
	 HsIc7ThLdYfWfrSiS0o4Utj9NyUS2GlolkvIhnwr3yfxxFCVoGUdOaYuiF2fmgo97h
	 LzkX/i/0Sk/vX9C1K25hTpRCgNZdqYIejOgOheDHVLCghfuEiV5v7e6dt73XfXXj/K
	 /Xb1+Fq0St0dn8W3ruiBFhdyHso30lLr7/+EhjwJkj2NNkVs/PzjiAG9UIk7u1xETe
	 XHL+s5mE9DMvbLhlPZ6w8gBLNO25o5xWm3ZdZLLTi/mbtxzmRqbSJwwctDr55fKT9O
	 klVCuh+hPieug==
Message-ID: <a26b43d2-40f9-4e33-9f76-1dc91239f454@kernel.org>
Date: Fri, 20 Nov 2026 15:51:58 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH] usb: musb: fix use-after-free in musb_remove()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bin Liu <b-liu@ti.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Felipe Balbi <balbi@ti.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261107-usb-uaf-fix-v1-1-ba33689d0ca3@kernel.org>
 <2026112044-screen-punch-ca38@gregkh>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <2026112044-screen-punch-ca38@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20-Nov-26 15:47, Greg Kroah-Hartman wrote:
> On Sat, Nov 07, 2026 at 12:46:17PM +0100, Joshua Crofts wrote:
>> Currently in musb_remove(), musb_platform_exit() drops the PHY refcount
>> before usb_phy_shutdown() is called, causing a use-after-free bug.
>> 
>> Reorder the function so that usb_phy_shutdown() is called before
>> musb_platform_exit(), the same way as musb_init_controller() does in the
>> error path.
>> 
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/bug/linux-d180c2b9-0006-4638-a22b-13df8c201235
>> Fixes: 39cee200c23e ("usb: musb: core: call init and shutdown for the usb phy")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Joshua Crofts <crofts@kernel.org>
>> ---
>>  drivers/usb/musb/musb_core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>> index 73ac25f53698..8e52246de948 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -2642,6 +2642,7 @@ static void musb_remove(struct platform_device *pdev)
>>  	musb_disable_interrupts(musb);
>>  	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>>  	spin_unlock_irqrestore(&musb->lock, flags);
>> +	usb_phy_shutdown(musb->xceiv);
>>  	musb_platform_exit(musb);
>>  
>>  	pm_runtime_dont_use_autosuspend(musb->controller);
>> @@ -2650,7 +2651,6 @@ static void musb_remove(struct platform_device *pdev)
>>  	musb_phy_callback = NULL;
>>  	if (musb->dma_controller)
>>  		musb_dma_controller_destroy(musb->dma_controller);
>> -	usb_phy_shutdown(musb->xceiv);
>>  	musb_free(musb);
>>  	device_init_wakeup(dev, 0);
>>  }
>> 
>> ---
>> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
>> change-id: 20261107-usb-uaf-fix-bedcd9cd8f4b
>> 
>> Best regards,
>> -- 
>> Joshua Crofts
>> 
> 
> Does not apply to usb-linus

I already sent a rebased v2:
https://lore.kernel.org/linux-usb/20261120-usb-uaf-fix-v2-1-cc3cb2a38ad5@kernel.org

-- 
Kind regards,
Joshua Crofts

