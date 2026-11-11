Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440159;
	b=c+HWh3VYLiwzy39aCgSDYjYXccB12SVnWHknz1vzX64v61DsiSZz40ViA5mHtr0fhcb1
	 EpMYdMaSpiim/O4dw/JbY4D0UzOPKmYoFllWPN+wBNfDyXsLPH2skJ+lehrc6cW6GSbcd
	 SBaAWPx2ZW4bx274XPesARqUD5tgJhMZMfAB/R/+8SVF5QzYXYHUkUtK31e3g9WsnkN1S
	 nLeX6egTn8sGfmZslEImyxtSCWd7YCAWSm2LWAAV779wzLXxGiiTX0DkoPwfWgNgahx4M
	 vmy5rA4AkSzAQYLW7rVwVyr7mMWIPdF7liiQiK8B0hmdMWtWgI4KFrrRaXKcR/8cfpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440159;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=LXD7gw2yiL/iHzNSHv7yzZLlAdtBMURofRbgu+y1eb0=;
	b=PrCdkG2Z4ykI8Rt2XkmfmbZ526QXFUKFTYvS8+3yFk2VcvMI3kUiakNlc6FmP+vjrVNc
	 tZhGyMbxEhNTp90BqhJHQtwNE22XJKBmsPKQhXeQH9VszOGvlsJp+Ekgw756vsN8Pux+6
	 bKr0qdIFES9eWIjRW4ySDyN+LSH/dl8EmfM1+Zidvv/eQalG3aCBOlUHixdyDCM9dN5um
	 ZUtp9AVZnAMfWnJu5IdTITKVwHC4+n6mhXHFDii53oUZeEQ4SiEO8NgNdhwU4mUi5UzWI
	 pg6BQVuLscNfIBiiGJfzlQYZQ7pop9WxBRXrB6PGIDS7Q0Fx02Vlftzk7R/FXiAJSPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXUQWF9+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46619606A31C;
	Wed, 11 Nov 2026 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXUQWF9+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2562D1F00A05;
	Wed, 11 Nov 2026 23:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440158;
	bh=LXD7gw2yiL/iHzNSHv7yzZLlAdtBMURofRbgu+y1eb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DXUQWF9+zSlEJOPMIqg0Tipv7VHpDjFrUIrvJ6gifkaN65qS8YYIdLNQHzu7kWUwk
	 nrkvgSQN8xEFm6JrTO27PWRn4xWqsF+vpghzxpz6BE4PbmfpUFKZV9Uy9rGUkZi/4s
	 sLMxmSLyE/1zvZsx0Z2cVc9X7uGSXF4Ij/oUvPczsGU0MCFb4W0ZoiLAxESbUC02ZX
	 jYEsultDiQ0tpHFyyaFTQZ8iZ4kWFSaXQKjRcDzkkHyL/4RRJZPXbPmxViXXt2xL1G
	 OoohisamLkbzv6z/aj9LVzunRJHh9z0F+W+8UFvt/u3MEUd3EbpCfuZVio4vB96noz
	 YZP1x05O3WMtg==
Message-ID: <0ce11245-3da6-423c-9f54-175eed413182@kernel.org>
Date: Thu, 12 Nov 2026 08:35:56 +0900
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libahci: Stop the SW activity blink timers on port
 suspend
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org
References: <20261110135615.291884-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261110135615.291884-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/26 22:56, Niklas Cassel wrote:
> The SW activity blink timers are not stopped when a port is suspended.
> Every command goes through ahci_qc_issue() -> ahci_sw_activity(), so
> with SW activity enabled, a blink timer can still be pending when
> ahci_port_suspend() runs, e.g. armed by the commands issued just before
> it, and ahci_sw_activity_blink() re-arms it as long as there was
> activity.
> 
> If the timer fires while the port is suspended, ahci_sw_activity_blink()
> -> ahci_transmit_led_message() -> ahci_rpm_get_port() calls
> pm_runtime_get_sync() from timer softirq context, and the EM registers
> of a suspended controller get written. If the port is resumed while the
> timer is still pending, ahci_port_resume() -> ahci_start_port() ->
> ahci_init_sw_activity() calls timer_setup() on a timer that is still
> queued in the timer wheel, corrupting it.
> 
> Stop the timers in ahci_port_suspend(). Use timer_delete_sync() rather
> than timer_shutdown_sync(): the timers are only stopped until the port
> is resumed, while timer_shutdown_sync() is meant for timers that are
> torn down for good.
> 
> Fixes: 18f7ba4c2f4b ("libata/ahci: enclosure management support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Developed with the assistance of an LLM.
> 
> Tested in QEMU (q35, KVM) with KASAN, UBSAN, DEBUG_OBJECTS_TIMERS and
> lockdep, using TEST-ONLY hooks: one fakes enclosure management (QEMU's
> AHCI has none), the other arms the blink timer as ahci_qc_issue() does
> and then calls ->port_suspend() and ->port_resume() back to back, while
> the timer is still pending.
> 
>   unpatched                              patched
>   ODEBUG: init active ... timer_list     no warnings,
>   hint: ahci_sw_activity_blink,          I/O after resume works
>   from ahci_port_resume()
> 
> The timer firing while the port is suspended is not covered, as the
> fake EM support never reaches ahci_rpm_get_port().
> 
>  drivers/ata/libahci.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index ef760d81d1d1..2e71ba7ea374 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2491,8 +2491,21 @@ static void ahci_handle_s2idle(struct ata_port *ap)
>  
>  static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
>  {
> +	struct ahci_port_priv *pp = ap->private_data;
>  	const char *emsg = NULL;
> -	int rc;
> +	int rc, i;
> +
> +	/*
> +	 * Stop the SW activity blink timers, so that they cannot fire while
> +	 * the port is suspended. ahci_init_sw_activity() sets them up again
> +	 * on resume.
> +	 */
> +	for (i = 0; i < EM_MAX_SLOTS; i++) {
> +		struct ahci_em_priv *emp = &pp->em_priv[i];
> +
> +		if (emp->timer.function)
> +			timer_delete_sync(&emp->timer);

Looks OK. Did you check that the timer handler does not restart/requeue the
timer? timer_delete_sync() states that it should not.

> +	}
>  
>  	rc = ahci_deinit_port(ap, &emsg);
>  	if (rc == 0)


-- 
Damien Le Moal
Western Digital Research
