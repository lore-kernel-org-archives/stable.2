Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795849754;
	b=3CCZj8cDMaOdvDVUYvsOt/BnCoUfsVUxdnxYmEh4GD7foDlKgq53kqNBncKQhYoQx1cJ
	 04+hS6EWrlyYsjRn57qqBilUxY5PeQpC4clA9aSKK5+af6Szrcx1h+INxynIdcWc3P/QR
	 N1iAALRu8ZanUIS3Jr/deicqDNilE2DXU+JXTHrNaAu92D4OXq0xkKsezIzyNs11PuhmE
	 0EpF56uw91MkBP7kwrIki9WULhCUeLAKSlck83fHiR/+RfMWBNiYqGKMehpUpg2QwJI9p
	 OUsTRGa0yoivl4m7RzbE2+ZCgw8uzuF/GnaxOTI17XsC50wT4o8IVgUEytKS/1Lu5eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795849754;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+frJhA5zcIV6hnLz17sMj4USifPldAOiBN2xX/VQuJ0=;
	b=P2tRkUy2h2jPw1+69Ehu3j4h9UCgCbwYwKn4OfB6T0NMuqr/vYILtOg+JtNEnqak1Tqj
	 r6oemC6wJIevsLudhAIUy9BjjIEKMqPIJZb0JP/SlmoizYqbsld8MZWAZB5u9oRwzRjT/
	 9/id5qq8hR3hQIYKaJozqai2lZOx8WnB9xtn5WgA+myckX5oAFpFtdunpIk0yiIVMUoev
	 38TDfTwD0AGggZKWE65ov1EmD/xFUCVY+HZQQed1E17KornRchZaPN1uUHHCAmMJENIHV
	 oTuNiCfQ/YN0WsHqCMj+xMPlGm6gjfNYoQtXbBtFbJSeoDcNMz632oNAbNb6DxHtq0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sakamocchi.jp;
	spf=pass smtp.mailfrom=sakamocchi.jp;
	dkim=pass header.d=sakamocchi.jp header.i=@sakamocchi.jp header.a=rsa-sha256 header.s=fm3 header.b=VGY3ixS3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D02nf2W6;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDB606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 07:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DDDB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.a=rsa-sha256 header.s=fm3 header.b=VGY3ixS3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D02nf2W6
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90360140031B
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 02:09:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 28 Nov 2026 02:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1795849751; x=
	1795936151; bh=+frJhA5zcIV6hnLz17sMj4USifPldAOiBN2xX/VQuJ0=; b=V
	GY3ixS3CchDsdvzileLMnmX14a/AXcFpGR00GNOhDejoY8XM59gD0uftvI+A1YTZ
	p1e+56yvxGc2ZG1Rc7yRxVD9+ZebNuSo4PEi5vmKC9erV5PcXrKzUqKpmOKCflRL
	GTy5OIeWGSzUQNOKUorAx05CjomLIt/Hs7LZacoVa0xJ355KCQ/Rvu03d+pQxaK6
	9MdGDdk0+QH6/q/PuGzXJS5MG816dLvqb3kmfJf/PZvSL5N7kHEUs+JF1t9rrjdH
	6EDtQvxxJAV/XkseddhSbP/0u5eOp9CjYshYAjhASy1K1YREsesIQ+PucJ4LZo8e
	ClVOLnZeTtac4062O66Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795849751; x=1795936151; bh=+frJhA5zcIV6hnLz17sMj4USifPldAOiBN2
	xX/VQuJ0=; b=D02nf2W6huqSpNx1Rof1Us5vxnci74KAh4aN3ur9TbPkr4QMEVQ
	SPasEIiDnIj1IrqVSemC7G3LzVvzP0ojuF06hD36lVrwyY+q3RX7cEv4RgioNIyo
	UPwE6DZFklUkzsDRjdC2y/cQ7yCqeKtFDrdM4kUc94s3c6P7IVq1bwy/b/G5JSQx
	PuMG/xPgV7tLA2i3lTfK/bf0Vi6TRC008D16FyrpyDRIUGLztLz8Cy0i2oC8CpHd
	zOllt4H45cq7S48H6Xo/D3C3/GppUrgRgFKIwj/WuvMypHf4PrpMVe6hzIZR6yBs
	GtTwIFDgPnIllsz7kNvTCCynwwePwz5Yo8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=sakamocchi.jp a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795849751; d=sakamocchi.jp;
	mf=PG8tdGFrYXNoaUBzYWthbW9jY2hpLmpwPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:p4ygSzdUdz06wT9oEcf9kGruGyqyKqqGZ40Wxm8qWc4UMgM
	eAeN0lefXS4AUNFZqkbIIi1QlhWnry2wCmD1zJJd8WUDBTVHnYCO44mv8iZUvyy4
	DfEvd1ozuiYKNAdqFOI86hgIK2qXdY/VS1DWR/vc8N2fcm4GWh5TXz8v8IJtOoPF
	Gdf4P1+BnqjR0FGC1DxmZBWLcprc6eD/ZKOZLvqPDfUlSMB8hq+lODzBubinzXDU
	PFdNF2hwbxpvIJlmt6Q/LOpXoIix1X0RiEiGyuq04FAdCkCgXRJWU948Jwj6oOh/
	5w9rIL+0ZL6GtiHi2aroYcwVq/UGqOlrZmtaVEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4eIHAzxUDOZbubWuqbwViWAjn72C4pydkB4NbeRapdA=:faWgTroi3I2wGwABHClzoxA/B9fZ7VkTcZei+E0NV18=;
X-ME-Sender: <xms:Fn4Ka5FXrAzTAgGTbhkJsrzVn_rfnYPIuwtnhDH_Ps5lRLU7cWpLUg>
    <xme:Fn4Ka3r-ppey1wsokl8pf1RL78Zg-oBWJcNrdvdvaYdRLR7cIpSHrdal7_iVFFFds
    ZyUM3F275zvP0lEDEbh8qnKnlRjxGT_yi5qUqzyE6oeKzdq_eQHXx3w>
X-ME-Received: <xmr:Fn4KaybFqWUvEl1caU8ch8MSmYPNLFVH5sOsKFswH5fT81pZHefN4At8kpCyMKaSZkCxgXk8EqSvVbMFOuqLu6o_KE9b4uI>
X-ME-Proxy-Cause: dmFkZTGeDN2v3u5ZZvh7XT2Ap623SiXr7ExrrNxlnUzkXyQ4MQmD5jwVQc2cRlZoEXOtNM
    67x1FEbKTfEvpshQ5uxFn3Ws8UmhUaecGdkQww1AviRjV0yBTXQqA04YlcQyBZgRsIzWOT
    x1JePIxxXdOmpYZJaRbJOEXVnnDKnDCzoD6iM/tgsoNRNy7iTY90H1dVdgjq4Cujco4KyT
    UpzxMWUaC+RZhAQMuj3qs05tqsphebV4p7T+3SC069X4MxfT61k24uXBbuVliMRxUx5hSU
    jl59Z5yQkxeONKqH7P2jBfB5+fQ80AlvdpC5MRfHVEVlOSCowlGPN8xxtN5vZi+vHz7vGS
    N74wy7+4S9CF0WhXeNPWOFugYWaGys8n0YWsTENzmrc7PHuS71M4ILu+E0KQ15DzunLVcM
    sxwwv7A5pscE3PGRPJmjiwmvXsTdeOEgkjKfSgS4tqnLoMWNQsOZsb1kckiwJDB86PHCxM
    uVz4y+fDhpWTtkXPz/a7TaMxoAypdBoyTuzsHGQH0obpG23sRl4FTAXYwiqRbDPXuKwODH
    VaxS8WYcjeKqli4WwV+ShNb/dljuJlpTYRxge9QnHMnXd1pKnZjvLzyskrtGyZac+ECjcp
    87jJfskSXFh0S5V+qZhma6hExXuf76uF5wahneCSMqgp5K0FhQ9ZpQVkz4tw
X-ME-Proxy: <xmx:Fn4KawU0oRK7rsdFqLMYqPVZBqh9qUEbPe8IL5SfZjZnGDJi51giIw>
    <xmx:Fn4Ka78aBBxMlNYOi2ekgdigFf2phi0npLqlyzL8DbqXsm9ROMw8cA>
    <xmx:Fn4Ka58BqeYZjmlEDTdTFiWgroRGbNySHK4nm9PdO3rZFYSiZ3WKQQ>
    <xmx:Fn4Ka7RmQlksWp1RCKTexE6XKtsOZqhVEphycpfj6Z1iK3pujpmiSw>
    <xmx:F34Ka8-zCdloXzVrcNza9ipTzRvNA-ZeOUirOMNIZv0iCo3aBF-tpcmd>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Nov 2026 02:09:09 -0500 (EST)
Date: Sat, 28 Nov 2026 16:09:06 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] ALSA: oxfw: bound the stream format entries to the
 response length
Message-ID: <20261128070906.GA47735@sakamocchi.jp>
References: <20261125121238.1602172-1-maoyixie.tju@gmail.com>
 <20261125121238.1602172-4-maoyixie.tju@gmail.com>
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
In-Reply-To: <20261125121238.1602172-4-maoyixie.tju@gmail.com>

Hi,

Thank you for suggesting the change. I think the changes in the other two
patches are good, however for this patch I have a concern about adding the
new function.

On Wed, Nov 25, 2026 at 08:12:38PM +0800, Maoyi Xie wrote:
> snd_oxfw_stream_parse_format() takes the number of two-byte entries of
> a stream format from format[4] and never sees the length of the
> response. A count of 254 or 255 can read past the 512-byte response
> buffer. An accepted format is stored with the length of its response
> and parsed again later. A count that needs more than that length reads
> past the copy.
> 
> Check the length of a response against its entry count before the
> format is parsed or stored. Formats other than AM824 compound still
> reach the parser and get -ENXIO.
> 
> Found with a CodeQL-based static analysis tool. Reproduced in a
> userspace harness under AddressSanitizer. Not tested on hardware.
> 
> Fixes: 5cd1d3f47a63 ("ALSA: oxfw: Change the way to make PCM rules/constraints")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
> ---
> I used an LLM to help write the harness and this patch.
> 
>  sound/firewire/oxfw/oxfw-stream.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
> index 5e36d7153a7b..d8fe136369d8 100644
> --- a/sound/firewire/oxfw/oxfw-stream.c
> +++ b/sound/firewire/oxfw/oxfw-stream.c
> @@ -484,6 +484,19 @@ void snd_oxfw_stream_update_duplex(struct snd_oxfw *oxfw)
>  	}
>  }
>  
> +/*
> + * A format of AM824 compound has five bytes, followed by two bytes for each of its entries.
> + * A response can be shorter than that. The parser rejects every other format before it reads
> + * an entry.
> + */
> +static bool format_has_all_entries(const u8 *format, unsigned int len)
> +{
> +	if (len < 2 || format[0] != 0x90 || format[1] != 0x40)
> +		return true;
> +
> +	return len >= 5 && len >= 5 + format[4] * 2;
> +}
> +
>  int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
>  				enum avc_general_plug_dir dir,
>  				struct snd_oxfw_stream_formation *formation)

Could we perform the length check in snd_oxfw_stream_parse_format() instead
of inserting format_has_all_entries()? The former is called immediately
after the latter with your patch.

> @@ -501,7 +514,7 @@ int snd_oxfw_stream_get_current_formation(struct snd_oxfw *oxfw,
>  
>  		err = avc_stream_get_format_single(oxfw->unit, dir, 0, format, &len);
>  		if (err >= 0) {
> -			if (len < 3)
> +			if (len < 3 || !format_has_all_entries(format, len))
>  				err = -EIO;
>  			else
>  				err = snd_oxfw_stream_parse_format(format, formation);
> @@ -662,6 +675,11 @@ assume_stream_formats(struct snd_oxfw *oxfw, enum avc_general_plug_dir dir,
>  		*len = 7;
>  	}
>  
> +	if (!format_has_all_entries(buf, *len)) {
> +		err = -EIO;
> +		goto end;
> +	}
> +
>  	/* parse and set stream format */
>  	eid = 0;
>  	err = snd_oxfw_stream_parse_format(buf, &formation);
> @@ -740,7 +758,7 @@ static int fill_stream_formats(struct snd_oxfw *oxfw,
>  	/* LIST subfunction is implemented */
>  	while (eid < SND_OXFW_STREAM_FORMAT_ENTRIES) {
>  		/* The format is too short. */
> -		if (len < 3) {
> +		if (len < 3 || !format_has_all_entries(buf, len)) {
>  			err = -EIO;
>  			break;
>  		}
> -- 
> 2.34.1

Thanks

Takashi Sakamoto
