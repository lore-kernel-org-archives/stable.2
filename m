Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507161;
	b=Fkvo4kWL9moC1VjKyv9XvCzassKMJlEdBmMhRm94LvZHZx1ZYJhBcBuGjJbtpljv4s1e
	 IXkJQVuhjev9vFgGKs1pxO3pC4lcffntjCcGoToViySjXB77B/Q//uHhVp1WDRVfwEN+C
	 GqzFsIFWWtxI+FnEYTyDpwGrPTAfUR43zim20Oav+MVgNNNSFR0dwk0Tut7bKxP1TzSuZ
	 YaVFxkKK/G7/Wf5buao4SA9qSTj9WyXAevuQD0yLIfMbkdgk8CrOffC0UbMoRF4uQgOfQ
	 QsbWwyMIHh2BZVZJ9x8cPdoXHEzKliQAht4fkBUVFAxv1KHCey2ZlYYFPPxNoPjOjcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507161;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=puTQ6q6aVXUBDkeL+o3EOPQPEL5ILRceyCXV4OQTW+A=;
	b=Wl8Fw2UoeBB2MO546hQHehhLUvcPvM6JyNTw9Ib3kgVkMpxfQ+D5KAhuKJlG5ft6Q0Nq
	 XA1q8XgKFPFprL/lAO6J5p7ACae9JIHNOc/YpewVuTci7RgFmR8W+KblNBeL4FRe/Den1
	 9N82clLAAqbAaveKqKC9E/6Y9Rzn/4gMUxN+4MpJmnKlhb1IazQgzL4oR5z3M2XKbAIm5
	 THUlJJ9iMH74onoT+30LZnSXnt6H9BEhosjT6bLCXNQSlLHABbxRese/5KAA8FmXMMtNH
	 w5Pp/2Uh3lArRu4O0NV1mauLQtTVxXLuuMkpE8FA2gQPfic+u7Qcw1kL4yMrSnLnZ/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToykQe9j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1503606A31E;
	Tue, 24 Nov 2026 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToykQe9j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FF61F000C0;
	Tue, 24 Nov 2026 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795507160;
	bh=puTQ6q6aVXUBDkeL+o3EOPQPEL5ILRceyCXV4OQTW+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ToykQe9jdoRfKV/NY/xbUphVJDhJ+OVd4BKbcgZ6lPatcWpUff3ztZun+IFOa9Vw9
	 5inQA09ivc2VZnv1Y8eWHXlFfWt9Uuuxmruq9tW6tADiwLUFFQxTVmSM6j1Xk6SoKf
	 5Mjd4gOxQ+V687vBcKchddpMbTLfkg0QPw5WsJ/EVG5Il1QGYNVgaXUU0sCWhnjWMe
	 uuOkKcmkmoI4SaLkQZe1QgwOH9F2W6zYak0k/xnpMK7hQ+JjR+BZsRggNI9s/lQb0U
	 YGTgX+gEj4/bQvYGwhsYqySvvYDPnDMzPuV4QAXtwvmMUVMEHIooygGn2t5Lihhf6v
	 W4gifJpdRGoqA==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xVlQr-00000007ypS-2fVg;
	Tue, 24 Nov 2026 08:59:17 +0100
Date: Tue, 24 Nov 2026 08:59:17 +0100
From: Johan Hovold <johan@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Nishanth Menon <nm@ti.com>, "George G. Davis" <gdavis@mvista.com>,
	or <source@mvista.com>, Andrew Morton <akpm@linux-foundation.org>,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 09/10] rtc: omap: prevent NULL and dangling pointer
 dereferences in power-off path
Message-ID: <awVD1YwurAJDjien@hovoldconsulting.com>
References: <20261123200012.502284-1-lee@kernel.org>
 <20261123200012.502284-10-lee@kernel.org>
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
In-Reply-To: <20261123200012.502284-10-lee@kernel.org>

On Mon, Nov 23, 2026 at 07:59:20PM +0000, Lee Jones wrote:
> omap_rtc_remove() only clears the global omap_rtc_power_off_rtc pointer
> if pm_power_off still equals omap_rtc_power_off.  If another driver
> overwrote pm_power_off after probe, unbinding the RTC leaves
> omap_rtc_power_off_rtc pointing to freed memory.  Furthermore,
> omap_rtc_power_off_program() is exported and called directly from
> am33xx_rtc_only_idle() during suspend without checking whether
> omap_rtc_power_off_rtc is NULL, causing a NULL pointer dereference if
> omap_rtc_power_off_rtc was never assigned or was cleared on unbind.

This sounds like two separate issues and the am33xx_rtc_only_idle call()
was added later by commit 5a99ae0092fe ("soc: ti: pm33xx: AM437X: Add
rtc_only with ddr in self-refresh support").

> Always clear omap_rtc_power_off_rtc when removing the matching RTC
> instance, and return -ENODEV from omap_rtc_power_off_program() when
> omap_rtc_power_off_rtc is NULL.
> 
> Fixes: 222a12fca604 ("rtc: omap: add support for pmic_power_en")

So this isn't the right fixes tag for that.

> Closes: https://sashiko.dev/#/bug/linux-97b795c5-f68f-4228-948f-547a106c6775
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/rtc/rtc-omap.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index 3c978edd6c2c..156444fab916 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -416,6 +416,9 @@ int omap_rtc_power_off_program(void)
>  	int seconds;
>  	u32 val;
>  
> +	if (!rtc)
> +		return -ENODEV;
> +
>  	rtc->type->unlock(rtc);
>  	/* enable pmic_power_en control */
>  	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
> @@ -481,17 +484,19 @@ EXPORT_SYMBOL(omap_rtc_power_off_program);
>   */
>  static void omap_rtc_power_off(void)
>  {
> +	struct omap_rtc *rtc = omap_rtc_power_off_rtc;
>  	u32 val;
>  
> -	omap_rtc_power_off_program();
> +	if (omap_rtc_power_off_program())
> +		return;
  
>  	/* Set PMIC power enable and EXT_WAKEUP in case PB power on is used */
> -	omap_rtc_power_off_rtc->type->unlock(omap_rtc_power_off_rtc);
> -	val = rtc_readl(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG);
> +	rtc->type->unlock(rtc);
> +	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
>  	val |= OMAP_RTC_PMIC_POWER_EN_EN | OMAP_RTC_PMIC_EXT_WKUP_POL(0) |
>  			OMAP_RTC_PMIC_EXT_WKUP_EN(0);
> -	rtc_writel(omap_rtc_power_off_rtc, OMAP_RTC_PMIC_REG, val);
> -	omap_rtc_power_off_rtc->type->lock(omap_rtc_power_off_rtc);
> +	rtc_writel(rtc, OMAP_RTC_PMIC_REG, val);
> +	rtc->type->lock(rtc);

This is an unrelated change.

>  	/*
>  	 * Wait for alarm to trigger (within one second) and external PMIC to
> @@ -913,9 +918,9 @@ static void omap_rtc_remove(struct platform_device *pdev)
>  	struct omap_rtc *rtc = platform_get_drvdata(pdev);
>  	u8 reg;
>  
> -	if (pm_power_off == omap_rtc_power_off &&
> -			omap_rtc_power_off_rtc == rtc) {
> -		pm_power_off = NULL;
> +	if (omap_rtc_power_off_rtc == rtc) {
> +		if (pm_power_off == omap_rtc_power_off)
> +			pm_power_off = NULL;
>  		omap_rtc_power_off_rtc = NULL;
>  	}

You can only have one legacy power off handler, but leaving the
omap_rtc_power_off_rtc pointer set after unbind wasn't an issue before
the later added am33xx_rtc_only_idle() call.

So with the Fixes tag fixed and the unrelated changes in
omap_rtc_power_off() dropped I guess this can all go in one patch.

Johan
