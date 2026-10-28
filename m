Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225567;
	b=jErCq7D8AFmHwlD3zzRYDtm4mz1gDM0yTySj8S5kGDt59oHvWCfEXUy/VcUqkyJuZGbB
	 /j3bI4kPEQPcghGCdY1vchTQIfBJRy0OuzX6J9hkVzITTaOKh+jRAeoHzkPqa9AshC0Ge
	 qXwhovQ0dOA/LF4RJIqHKAmePfr4JQEOUqJ1nhbzbdwAScPV4gHdvQAHDkVBVU88FMYJL
	 AsrEcCQaj1nm02kzSerT9ZuGPkrDZNFQYfP7aTAdcoi75xsrlasX8QQJe77tfQF2YNa1c
	 dRmjf9RAacO9ks/XEdUIKqx5hULN39Y1GxF66F6DXWHm13vMOlL3yI56K+Zna2xrXsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225567;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=M3Ck9eyVD75IOnRETh1mD4sLHe0E+TueuPB6Ea2RtIc=;
	b=gnidRN5uc57n28ypPzUaZyjHAWEHJwiAt0o7SAC1JdlQkI9J1qhN4x4tXvifCnDFNlcY
	 pU00IJzYYUjaYZ0yyP8Y5hPNrhWXCfU9A0BSFGkHQGybCipzwsG0t3hmvlDn7bEoX/FxN
	 vXgEdJS9QR8ZL3Y35N5e7fb8RPK6xxPVg3iOYSH7zm8AAxVUUcGe+VpNJav7HmZvCKgNi
	 DLJHLId3J9oxdPxJ0c7Z80zdIhHcHOY4WY7s80U+nsWRQqbJ1OK1Yq8QCC1VykGX359gO
	 vTk88SQ/LGp2cHQamKcuO0CKkUTom2V8OsgM6ti1IBiv8spTJ8wlngfC/qjGrEBcGuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.147
Received: from mta0.migadu.com (out-147.mta0.migadu.com [91.218.175.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA5606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6BA5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y+Decs/7/+vp1xu4bxl9QSBsBoAQltojViXKsaLAsUQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793225556; v=1; x=1793830356;
 b=uxe3tKZD3rgWKDBrvKJdhzEHdVT5FOsyiurK82BE0r3CCx1NjDF/Ox1X/7UzJ8TiRg2H1mXH
 6Riy7L0RQ/c+7UjW6euETgs66c3dk35K34lojEdkGxNygQxZ4pUbDHssGUd+TrbPpk8TYp+k90y
 NUsJ+/PWqNgYmINEprxnYf3s=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c8b5232d2f55aa01;
	Wed, 28 Oct 2026 22:12:36 +0000
X-Mizu-Trace-ID: c8b5232d2f55aa01
X-Migadu-Flow: FLOW_OUT
Message-ID: <6b9f70ca-86a5-465f-af09-2df49ee11628@linux.dev>
Date: Wed, 28 Oct 2026 22:12:31 +0000
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
Subject: Re: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before
 it is applied
To: Linkui Xiao <xiaolinkui@126.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20261028090455.2291659-1-xiaolinkui@126.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261028090455.2291659-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/10/2026 09:04, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> e1000e_config_hwtstamp() stores the requested configuration in
> adapter->hwtstamp_config right after the rx filter has been
> translated, but the two register writes that follow are verified by
> reading the registers back and each of them can fail with -EAGAIN.
> 
> When one of them does, the driver is left holding a configuration the
> hardware never accepted:
> 
>   - e1000e_hwtstamp_get() hands it back to user space, so an
>     application that reads the configuration back is told that
>     hardware time stamping is in effect while it is not;
> 
>   - e1000e_systim_reset() re-applies it after every reset, including
>     the ones the watchdog triggers, and keeps failing;
> 
>   - e1000_watchdog() starts polling TSYNCRXCTL_VALID for the cached rx
>     filter, and e1000_xmit_frame() still parks skbs that ask for a Tx
>     time stamp because it only looks at FLAG_HAS_HW_TIMESTAMP, so they
>     are eventually dropped by e1000e_tx_hwtstamp_work() with a
>     "clearing Tx timestamp hang" warning.
> 
> Cache the configuration only once both registers have been verified,
> so that adapter->hwtstamp_config always describes what the hardware
> is programmed with.
> 
> Fixes: 62d7e3a2d006 ("e1000e: Validate hwtstamp_config completely before applying it")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 35f5590228eb..7ae33273734f 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3715,8 +3715,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
>   		return -ERANGE;
>   	}
>   
> -	adapter->hwtstamp_config = *config;
> -
>   	/* enable/disable Tx h/w time stamping */
>   	regval = er32(TSYNCTXCTL);
>   	regval &= ~E1000_TSYNCTXCTL_ENABLED;
> @@ -3763,6 +3761,8 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
>   	er32(RXSTMPH);
>   	er32(TXSTMPH);
>   
> +	adapter->hwtstamp_config = *config;
> +
>   	return 0;
>   }
>   

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
