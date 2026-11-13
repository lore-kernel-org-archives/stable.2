Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583227;
	b=x8tFIR0cnTJnEIBB88rTyDpdyDKwO7ryCRLxWVpsN1VtRqO0c/m5Qa7O+klWsIe0YQIB
	 G0+7bSMF9ryRPEsXTQojeVwrBz6MIyq6mbgz/jHw4s5QmAT+TTPHt3WTBsLUHAXohajlq
	 RTScbc7hTIFlYQr13ZAFhcoh8S7xfxC2m0OMu5XrSg3Y3wS6gERN3pfqemCE5cgVEjWKO
	 BIp5yTyu9oKjwhUQl6G38ybnvfIcw+wqYmIidL14lha6y/veB2x0McbA11S7Zua3lJHm0
	 QAhud4oc6bN4Dcq6nYaFppz73TiQ4DehdgShRqf74RsZoUAntPuTiH7kBApraiXDgWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583227;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QJq+GUc6PAR3xy+Pfkqz+19LZE/YeqLmKaLV5oi4iko=;
	b=hD0cyd5nmgYTaBzZiGfBGzwpH0/ECFLSd1suDy/7kQpzbn3px/KZZgom/8RsMN84qkHQ
	 A3XANTWL2cHP3or033QrrtpPVtgIKzcqtuSxLbAOiWPFURlcfDJBKP/n5YxtV2GX/92yV
	 ijWK2g7EeJCA23L3zZM5htL0GH/yqITlb8wiDXsMguCtwaOy+ZOrLT/40M2+ZqAmliLVq
	 UeIQ81FSIlcVbohRiiumbl9I3vGZa1nnOfarnupmkKJEG2tSAkqOD2EsycTDW4toEcQHn
	 ttuKLrYQ+CgKj4K/J1mFK1JonXieS4PBZVEcvPPJBNfEtAW0QpAShoimgLBYem5MY5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NnjU6d5V;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB68606A88C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB68606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=NnjU6d5V
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-843cf077f10so2412401a34.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794583225; x=1795188025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJq+GUc6PAR3xy+Pfkqz+19LZE/YeqLmKaLV5oi4iko=;
        b=NnjU6d5VxM7A0+O4guD0V8fANOGIUq+iGf3jiYWrUO8W0bs9Y90UbrZhLlkWFpHJW2
         r+BfTji7EQkDUffbPgCw3SB3lRIl66kt/GBWpF5/sBULa1TCVPuFwubp16ZHonT1+mMY
         U77t3R3OpIp33QNWWn6UJmgljvsaCZP2yA7MYTykh/Kw+QxN/OrOZVjiNDi4z4RAHXPV
         i8dDuP3eRItU4MQ5XYXc/HdVjf9q1UqhxPAb1IXs5p4aVzMacS7F71GMeae5upCHZR3Q
         MriSbLqAcPOe9sNMQHZqwn5MW80lzKIYQ9bjbvMBq6tu0sz9R8TTHe2r/VreYnkKPPq/
         i/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583225; x=1795188025;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QJq+GUc6PAR3xy+Pfkqz+19LZE/YeqLmKaLV5oi4iko=;
        b=p39RWRfywHyCV6XkbIfhXpAMNxfl9nwlmjynBoRjPpw+pKQRQ4FgwMiSa0yHH6KldG
         QzWg5zR+kxq62Qzdktd2NrWrujPXqa1f89mw5GnLnUjYa/qqxS2/gp5nXCobJ+lHjOwH
         Oh19LRzasdbphA6w0ajD/G/Wg1mHcAQOEvs3T1ovdZCLHnLp6APBWL5BSelrCLJUn0KP
         nQ7wT0QKvl9I39kXxmtTCl85amHfTjwsb85eU0/evVYP5qneX5VqGyAwYhmF13m0BwVe
         v1psvATU4Q5XtscFDuRB8Upsywgn5QVOCvABfPu7bRwk7zf9wxk2+Y8HU/y4Ax1IC39G
         6F0w==
X-Forwarded-Encrypted: i=1; AL+hErEnPd2aRLUxfRHd98CmSULGC26sDkL2nJUYGKYv2ANTg5S5W+GGK0IHDUzGzghtLaTxWnF/MOI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+p0zzVUkPGB62x4dQSsUyrKdSW8wTLe1x9rll2S2h31B+Juv1Y
	60DUmB99CgBjEigrz8vq3Aqh6oly4REnF/EiTxRxCIW8s4KGxClCM9FpaZbMz38KBOk=
X-Gm-Gg: AYBFou1rbmGGCVIw3w3X/ZBdbYUqq968t0ONArtwgMebkY/DKAgIzpATyGDLWuEFFgP
	krCHaxDKV+oBYiVGyBSB6vVALYlEWW0wnH2F5QtKeY51GKLPr3aSdC1E7uxeVfK+g8wYvVNlLFN
	xOiCO9M/BOnVJogzuOCSolkYYPQc2/rNDs6csWU14EijQ5uX7gR+I6XMFROlE5iePYbZb6G1uMZ
	IaaNE5ejaMjeJ9ATdJFXTHdwuOkwM3J9mX63I2uqALlK3kME0lsjUOxqDjIU8bfScTrdcaa4nG4
	LzbRhdaP5L03rIfWlOkosyxG52lZlJ1dsCZ0Mc5o1wIKqf6QOMCeKBQ44gC7g18O8ry6Me7qIRO
	Fu9OQe7Yio+5DKZPZFXKlXmnh1oOgLqLKlwEvyh/QUhBrh9Bs4TvsU2iI6GjQWOJhnDpttxXo3W
	Xa9NN5SDJr0eZ6ytlp1HtyZZgxEW94xT+ECaZbQZGOCuUpcZHLOkcG3uMvSsdrX2bsNImeIIa+U
	kA+yqNC3nIL7igxtCewOrqESCP3+soXFQ7TlMH9ctYjJosuWbIbEiiwvvAB1934p23CIuxiq5vw
	zvra9jquTuK8mFndlYMRDOtbTHdNQu15bJM2zkJWi4saVM5ixQdSzwn7j4Puop5423ZOfN6zWxD
	HGD8=
X-Received: by 2002:a05:6820:55c6:20b0:6d9:e2f3:9b51 with SMTP id 006d021491bc7-71ab5084396mr1064228eaf.66.1794583225149;
        Fri, 13 Nov 2026 07:20:25 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:fb76:8640:983b:6899? ([2600:8803:e7e4:500:fb76:8640:983b:6899])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71ab4338765sm2019311eaf.14.2026.11.13.07.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:20:24 -0800 (PST)
Message-ID: <06f0a178-5d98-4c6c-b596-c0eba8ae9234@baylibre.com>
Date: Fri, 13 Nov 2026 09:20:23 -0600
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
Subject: Re: [PATCH] spi: axi-spi-engine: Start the program length at zero
To: Kees Cook <kees@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-spi@vger.kernel.org,
 linux-hardening@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261113065508.i.606-kees@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261113065508.i.606-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 12:55 AM, Kees Cook wrote:
> spi_engine_optimize_message() allocates the program with kzalloc_flex(),
> which sets the __counted_by() counter "length" to the allocated size when
> the compiler supports __builtin_counted_by_ref(). The program is then
> filled by spi_engine_program_add_cmd(), which increments "length" and
> stores at length - 1, expecting it to start at zero as it did when the
> program came from kzalloc().
> 
> Reset "length" after the allocation, since it is a "usage" counter, not
> a "total allocation" counter.
> 
> Build tested ARCH=x86_64 defconfig with CONFIG_SPI_AXI_SPI_ENGINE=m and
> W=1, with GCC 16.2.0.
> 
> Reported-by: Dennis Gilmore <dennis@ausil.us>
> Closes: https://lore.kernel.org/all/20261112025252.71375-1-dennis@ausil.us/
> Fixes: 69050f8d6d075 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

>  drivers/spi/spi-axi-spi-engine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index ead5b295e680..9cfee409f15c 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -818,6 +818,8 @@ static int spi_engine_optimize_message(struct spi_message *msg)
>  	p = kzalloc_flex(*p, instructions, p_dry.length + 1);
>  	if (!p)
>  		return -ENOMEM;
> +	/* spi_engine_program_add_cmd() counts the instructions as it adds them. */
> +	p->length = 0;
>  
>  	spi_engine_compile_message(msg, false, p);
>  

