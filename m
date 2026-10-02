Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B341B87C0;
	Fri,  2 Oct 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935820; cv=none; b=P+Qqg8o2ASY4l8Pp87WcufThvGSe1CQ8uWs5IX8copA58022outzo9B9dBApeEKyQ5JeyZvel3+/6Bvrb02K/UpBe1SkdFljDQdGORKgP+DVF6ER7zjb8uoXbmi0BeHN/a4uhx8RzhlgwSYpFiTUsq3c1sh9396yUut6IpmPpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935820; c=relaxed/simple;
	bh=ZXTEuJkN+jyGhP+NASBflSms8faUWwcyD/4mTMboVj4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Hx8LZUJ9ZDXM/uSPdZpHe709LX5N0CR23BxBNRWSAwDWx9Aqx1j1/Ny0hrDgGhgDNJJs0sMwsArVR2sk00ecmybxUXOqlBamLX7nHIUAgl8TsIkGXTejCea+fMZRzMRGUU1z0A3qkqEiSHnvlxea5T/rhUqjSFgdxPYJqu1BEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=I1SHgeMI; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="I1SHgeMI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D02EA02DB;
	Fri,  2 Oct 2026 12:10:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790935814; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BfL6SKTLkWrhN/wsJ7rNqoRO9lvotlnH5Ssl/GHYpKE=;
	b=I1SHgeMI2oUSvOtZ8BoNQV1vxsvRVddvcmtNwTeKiaFtt/w+CBgmp8Tdefs2bs38sXLrwK
	pYmCENY6TbiXBfFqRZKYmUzso1autjg+eUkr1STTsj5UmFyh1uPPPUjKoHjzMVFgSxCRWV
	qegcshsOAgi4tC5eZWHLq2JZdp6OcdZXURvwB3pQqfvdeT7IAXy79S1gc9xOazAWRrtdC5
	D5HPuGMSQNQcAseZ0NWZJyt+9vrNUQkq2ZO05DCEoOtKhfLwf4I11Ml/2tcdEqE70j3B41
	r6J9tysrfF4YKFD/7aFA//TuET79LynJH3wllc/QQmQFEvEgld0+FScBfGLjvw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 12:10:03 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: taozj888@163.com
Cc: theo.lebrun@bootlin.com, stable@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haavard
 Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: macb: rate limit netdev error info print in
 the data path
In-Reply-To: <20260930113520.392025-1-taozj888@163.com>
References: <20260930113520.392025-1-taozj888@163.com>
Message-ID: <b06cb02d9b26ceff272d7e34927a7eac@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Zijin

On 30.9.2026 13:35, taozj888@163.com wrote:
> From: taozijin <taozj888@163.com>
> 
> Now the MACB ethernet driver print the netdev error information
> directly by netdev_err(), which would lead to a large number of
> error information print if there was a significant number of
> error or just jumbo packets exceeding the MTU received when booting.
> For example, it would print a large number of:
> 
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> ...

Out of interest: Is this a Phytium vendor kernel?

> 
> in gem_rx() by received a large number of packets without
> RX_EOF flag set, especially with unknown packet
> type that would penetrate the hardware offload for the IP packets.
> 
> The unlimited prints here would greatly bother and delay
> the system booting process unless the source stop sending
> packets since they occupy the console output bandwidth and
> other processes have to wait for the completion of printing those
> messages.
> 
> So rate limit the netdev error information print in the receive
> and transmit data path.
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")

IMHO the correct tag is 4df95131ea80 ("net/macb: change RX path for 
GEM")?
At least the gem_rx() messages were introduced here.

> Cc: stable@vger.kernel.org
> 

Drop the blank line as otherwise tooling might get confused and doesn't
get all tags correctly.

> Signed-off-by: Zijin Tao <taozj888@163.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
> b/drivers/net/ethernet/cadence/macb_main.c
> index 8e5c034dc3a4..ca60960bec36 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1617,16 +1617,16 @@ static int gem_rx(struct macb_queue *queue, 
> struct napi_struct *napi,
>  		count++;
> 
>  		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
> -			netdev_err(bp->netdev,
> -				   "not whole frame pointed by descriptor\n");
> +			if (net_ratelimit())
> +				netdev_err(bp->netdev, "not whole frame pointed by descriptor\n");

This will just hide the error message, but the split/drop is still 
present.
How about limiting JML in macb_init_hw() properly?

         if ((bp->caps & MACB_CAPS_JUMBO) && bp->jumbo_max_len) {
                 u32 jml = bp->rx_buffer_size - NET_IP_ALIGN + 
ETH_FCS_LEN;
                 gem_writel(bp, JML, min(jml, bp->jumbo_max_len));
         }

The code above is untested, so probably needs further tweaking. An 
alternative could
be to handle the split frames in gem_rx() correctly.

> [...]

Thanks,
Nicolai
