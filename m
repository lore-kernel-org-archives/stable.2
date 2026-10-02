Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E953A8749
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790942906; cv=none; b=ODq3qDFv4Z0m0bZaUCPNDy3pfwbquQnL1GtWxBvNlIEymiz8z0ium6Etw2h3sPUZmibtsRFnK9TMV+eWh4XCk6Z2QYYH4CKZA5wHu9fO6Rt9agVUtetawo3XtyOH/pQVRiwumZnZVNPjWfC+qLixc8WmNLGN3TNelJ8HKRf6qsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790942906; c=relaxed/simple;
	bh=X61e5l5tAmbK194rKvEOva5qQjovrr4ntCAoJ1nygO8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=uKiI5h6L9r8wfxrJpyJWZN5CrH3FcC7Rsi1sATKU8EPCoGSkPS7W1IYA5tJzCrgMfk6NG1DMnF5jznpqeLQf7rDLynhztSJ3jE+GRq4Lo8vNqC/Iq2UqjJDOYEc9P+7+ntn7/EME3/sDrcQnK8Sod8+uOyJcxW+LB+6RqIr4lTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ngAJ7NKr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ngAJ7NKr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AFD9E4E410FC;
	Fri,  2 Oct 2026 12:08:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7BC9A603DC;
	Fri,  2 Oct 2026 12:08:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2720103281BC;
	Fri,  2 Oct 2026 14:08:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790942901; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hBfCY8ZDmjd9t596TtAJ9WNL7uehdO8CPfKsMuKXE88=;
	b=ngAJ7NKrOrBW8hsfsC/CmSLYUHPzbNIocfSDX7+ZGRRVl6DSkSJSuUcl6XtYx8irVoNdWb
	Gjm4bV6anZbSiVTymEMm5Te9BewlvcOUWCIfySdVt8ADBJXA89ORfMvAo8PwsU2l1KHB2V
	d9oc55kUEzWM7K9+I7WEkIovj5A/d9RcoNnwCqmC23XI5KtS0uKQGeded5oQsKoAR8W3r7
	CQB5Mx47D45OO7X+g6xkk8QRvLgA/GNdG9cMd9locpA+sqYLiANoFTnMY3QwaCo2lXeazm
	7P4fBxlTXKIIQYWzlLnNLneKTZJS4NCz30ttu8W39NjQ1Zc+htLrEvMBaf5Gtg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 14:08:03 +0200
Message-Id: <DLUC9MKOACM3.OPW5RYHOYZV1@bootlin.com>
Subject: Re: [PATCH net v2] net: macb: rate limit netdev error info print in
 the data path
Cc: <stable@vger.kernel.org>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Haavard
 Skinnemoen" <hskinnemoen@atmel.com>, "Jeff Garzik" <jeff@garzik.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Nicolai Buchwitz" <nb@tipi-net.de>, <taozj888@163.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260930113520.392025-1-taozj888@163.com>
 <b06cb02d9b26ceff272d7e34927a7eac@tipi-net.de>
In-Reply-To: <b06cb02d9b26ceff272d7e34927a7eac@tipi-net.de>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolai,

On Fri Oct 2, 2026 at 12:10 PM CEST, Nicolai Buchwitz wrote:
> On 30.9.2026 13:35, taozj888@163.com wrote:
>> From: taozijin <taozj888@163.com>
>>=20
>> Now the MACB ethernet driver print the netdev error information
>> directly by netdev_err(), which would lead to a large number of
>> error information print if there was a significant number of
>> error or just jumbo packets exceeding the MTU received when booting.
>> For example, it would print a large number of:
>>=20
>> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
>> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
>> ...
>
> Out of interest: Is this a Phytium vendor kernel?

I looked in the past so I'll answer: yes!

Internet search gives one worthy result: a 2025 series to DPDK adding
MACB support. Some extracts about the exact string match and also how
they support ACPI or OF and no other platform apparently.

#define OF_PHYTIUM_GEM1P0_MAC	"cdns,phytium-gem-1.0"	/* Phytium 1.0 MAC */
#define OF_PHYTIUM_GEM2P0_MAC	"cdns,phytium-gem-2.0"	/* Phytium 2.0 MAC */
#define ACPI_PHYTIUM_GEM1P0_MAC	"PHYT0036"	/* Phytium 1.0  MAC */

static int macb_get_dev_type(struct rte_eth_dev *dev)
{
	// ...

	if (!strcmp(dev_type, OF_PHYTIUM_GEM1P0_MAC) ||
	    !strcmp(dev_type, ACPI_PHYTIUM_GEM1P0_MAC)) {
		priv->dev_type =3D DEV_TYPE_PHYTIUM_GEM1P0_MAC;
	} else if (!strcmp(dev_type, OF_PHYTIUM_GEM2P0_MAC)) {
		priv->dev_type =3D DEV_TYPE_PHYTIUM_GEM2P0_MAC;
	} else {
		MACB_LOG(ERR, "Unsupported device type: %s.", dev_type);
		ret =3D -EINVAL;
	}

	// ...
}

@Zijin: do you have any other Linux MACB patches for it to work?

>> in gem_rx() by received a large number of packets without
>> RX_EOF flag set, especially with unknown packet
>> type that would penetrate the hardware offload for the IP packets.
>>=20
>> The unlimited prints here would greatly bother and delay
>> the system booting process unless the source stop sending
>> packets since they occupy the console output bandwidth and
>> other processes have to wait for the completion of printing those
>> messages.
>>=20
>> So rate limit the netdev error information print in the receive
>> and transmit data path.
>>=20
>> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
>
> IMHO the correct tag is 4df95131ea80 ("net/macb: change RX path for=20
> GEM")?
> At least the gem_rx() messages were introduced here.

The patch used to touch macb_start_xmit(), which explains why I told
Zijin to target the initial commit on previous revision.

@Zijin: where is the V2 changelog? Each new revision must list (below
the fold line for single patches) their exhaustive list of changes
compared to the previous revision.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#resp=
ond-to-review-comments
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-=
canonical-patch-format

>> Cc: stable@vger.kernel.org
>>=20
>
> Drop the blank line as otherwise tooling might get confused and doesn't
> get all tags correctly.
>
>> Signed-off-by: Zijin Tao <taozj888@163.com>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c=20
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 8e5c034dc3a4..ca60960bec36 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1617,16 +1617,16 @@ static int gem_rx(struct macb_queue *queue,=20
>> struct napi_struct *napi,
>>  		count++;
>>=20
>>  		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
>> -			netdev_err(bp->netdev,
>> -				   "not whole frame pointed by descriptor\n");
>> +			if (net_ratelimit())
>> +				netdev_err(bp->netdev, "not whole frame pointed by descriptor\n");
>
> This will just hide the error message, but the split/drop is still=20
> present.
> How about limiting JML in macb_init_hw() properly?
>
>          if ((bp->caps & MACB_CAPS_JUMBO) && bp->jumbo_max_len) {
>                  u32 jml =3D bp->rx_buffer_size - NET_IP_ALIGN +=20
> ETH_FCS_LEN;
>                  gem_writel(bp, JML, min(jml, bp->jumbo_max_len));
>          }
>
> The code above is untested, so probably needs further tweaking. An=20
> alternative could
> be to handle the split frames in gem_rx() correctly.

I agree with you but to clarify for Zijin: if you do this then it should
be a separate patch as changes are pretty unrelated.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

