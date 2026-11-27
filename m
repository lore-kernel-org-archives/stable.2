Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770731;
	b=V9/GUoSOKDWUg8ZFbmEvU5zzy2tPuUdY8Rpaltj3n3XqpKtmyjg6RZsc6x9EHxjN51j5
	 crha7j2eEO2L9WEPQHQKAO5EXDz/UTWL0hZ9HL1pzvlzVaYjq7s2e3EpWDflnjOhBSG9a
	 NW5LsHYU7gS2bpWKIqWLgbX3vwAfw2dC5A+8mtNE9togs+FASiBUNL1ClYk1vVpAxk3jN
	 laQ0HovsiCHajWksHgRQXelGQZvlOO8NGLcnIkxgFIip7v+HnMePSbzLgCi+V8Ey20kIh
	 ljq2ZX4OKaURaEGe70jnu4Ka8PatMJNL5/ylFkcjZfXyGb1o7XHjVFBfstJRB6Nwhtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7BmBlqkLTRWPnM/PyPREkTVAoRCehz9jfOuEcWz3kOo=;
	b=GaLlpXL1TqztjqD2cOnOHx6LXtnYYu4VDivjIF7bpApYNc+9yLXLr2zptXdYtT7V3SB6
	 Gv6p5iT2iff1TH1VrMNFCo4Nn97cKzLMkvqlpJqeplEqntllupZNKM4mv7nNvvZO3C2Z4
	 Mwg2IEZf9st17G9J0TUwYu1rD7DK4v4EF75ezu29JQ9ZlyGKA/GhJzGjTHTpFd3luYUEQ
	 6faFp0WhUJ+mS9rv3ZtjpDBOc7vfcwcMs2a1wzGEfGddt1MXy8Wbh85Q/ycP+D3S3jmzh
	 9DDilF1EFTWgkqEJMfPrfrAFNO2bQKx+Xcqs4PwgkOez7CkG/TAvHZyIVSxr072j6vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tuxon.dev;
	spf=pass smtp.mailfrom=tuxon.dev;
	dkim=pass header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=oUQtFPfH;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE692606A334
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE692606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tuxon.dev header.i=@tuxon.dev header.a=rsa-sha256 header.s=google header.b=oUQtFPfH
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so9095143a12.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1795770729; x=1796375529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7BmBlqkLTRWPnM/PyPREkTVAoRCehz9jfOuEcWz3kOo=;
        b=oUQtFPfHi1S6G+Lki3MzTQU86GQHUmr/a7X4kCX27BKxweK2JCwd1auoyJbq2h0HbQ
         3X39h5pwxHW+tWps2o0RFgepURXxk1OguFJljOt010jDjXDrOO1KYqKijW6maJ4sEbev
         tUnLjv2oaxOPj3/4XJIxCN0BsmJHLBj3y498UFTgEG+GUR1NLsWSZv1YE2jdesVVwF2X
         tcMiitjnx+V+w25x/IEB2KldSyjntkjyw5NTnEXwkCcJzqLKfdDj+NAhE7Drx6lWOcw3
         ySVBQGUMXO/Ai3k88g/5bXwZVH8M+9vRrj+4D6Ai4t+p1be1gvN2P7nhEJebNOBW/HX0
         0cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770729; x=1796375529;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7BmBlqkLTRWPnM/PyPREkTVAoRCehz9jfOuEcWz3kOo=;
        b=MY1i2ljN79z9oj6lDpCo0ErHpDehF90nW8MmzMJc7LDDeSQGR2K+VuV44fE3wYqrVI
         ydVGwqdSxTgYq8/n0WV+KJIHViMBhVkMGuW8D8pDW5lV6PxDjK1IqlZi3cURf93O4il+
         B2DGhrLQeUMioC/PBcTtdvyj4MNU19vDw75CYrm4kwrfWzfXGcod+kriv4kObpeUVFLc
         Ggc0dJEykrLwue+jPPguD+U3HVecCbQQQw07E2uggXWHyaxBzKBRN3b8/MKk6sKjxOrI
         o4LHLNfRe34SKEbVe6s+3Jy1vKMgTznruBhmeqZfVEN4uWG3hwtNto7RbcSAR700+NVT
         g5ew==
X-Forwarded-Encrypted: i=1; AL+hErGMSAB+HcREzS7xy8bMLRjiGbMKyjy1aEraN6Y9Cshi1Ylx4gq8Y9s78E4jAIz5rsWp4VhrsAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+/eU/7D103+5B6g4k6Buks2IhMTEy12HRFGIVsqxQw9rWA3zO
	UseUaWKnPlgGIcLeGaWIwNtw9dkD7TsTeFtk5gnHNELgzAPZfMYSskeI0ciOdq7JeJI=
X-Gm-Gg: AZFdTZejL4J+vbtMK1jUJU/DX4gDjS7tYe9llkXDI4PBQpMwHj5gE7uWhINy5DePImI
	ZP89Ryf06SjUysb9HmdlIEFfkIHvhkW07Mnvd+CgmYEYD5jLOy9KzrZiC31Ap+s6beq1G54XrB2
	zFGOA8C+lTFpyMh2AOpehzfsGWY29XggidNmmOBbMv1PbQetwP5tWeyhhlVqrd4zWdRfC6eEhYx
	RtuSJ924Ea52T3VsPW7oalaI3YoQqK74tjCby9ChdTdJXelEyzgfWWCrMMBQcS3VyQMziw0U9HM
	J57BvfZisz4Z+e+8hNwQQJr0ANyDYRdroXP+wCwNPH4QcB6lEZfsszqEobfhLFHNVeNrnJkYakP
	dairVzpE3bxTVOaKO70HX5ueLoJbleTGiq1BTRU8G9MmneQOap1r9QutwBGAzNf5QGKsnSPpz1t
	TXkC8Phla8J3yeXnnQIaYZVQv/ULvdhfzs3nPAb7mk///wGybbmR9R2GCx0dTTxUv33D2PrAlqw
	IOZdwhdPlFRB7Jfz00AUZUrIXjmVAtVRXQWJExd9mVvhojnKvLQvoTxGru0zo9MbigkedETI2gy
	Tdodwsqt02esvc97kbxnsE8+kdOqyelw4DYd
X-Received: by 2002:a05:6402:13cb:b0:6ba:4bf3:4a2 with SMTP id 4fb4d7f45d1cf-6ba4bf305c0mr15740801a12.17.1795770728948;
        Fri, 27 Nov 2026 01:12:08 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4abbd84e661sm43017556f8f.18.2026.11.27.01.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 01:12:08 -0800 (PST)
Message-ID: <bd8014fe-6a77-445d-b73d-e87404638593@tuxon.dev>
Date: Fri, 27 Nov 2026 11:12:06 +0200
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
Subject: Re: [PATCH v2 1/7] i3c: renesas: Fix zero I2C SCL rate on pure I3C
 buses
To: Diogo Ivo <diogo.ivo.sx@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, stable@vger.kernel.org
References: <20261026-divo-ssgrlpcsrc-2966-i3c-v2-0-2e76b87209bb@renesas.com>
 <20261026-divo-ssgrlpcsrc-2966-i3c-v2-1-2e76b87209bb@renesas.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20261026-divo-ssgrlpcsrc-2966-i3c-v2-1-2e76b87209bb@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Diogo,

On 10/26/26 13:35, Diogo Ivo wrote:
> On a pure I3C bus there are no I2C devices, so the I3C core leaves
> bus->scl_rate.i2c at zero if i2c-scl-hz is not specified in DT.
> Deriving i2c_total_ticks from that zero rate programs a zero-width
> open-drain SCL into the STDBR open-drain fields, which are still used
> in pure I3C mode for example in DAA.
> 
> Fall back to the 1 MHz FM+ limit instead, the fastest rate an I2C
> device could have, so that a sane open-drain timing is programmed.
> 
> Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
> Cc: stable@vger.kernel.org
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
> ---
> Changes in v2:
>   - Substituted if/else with ternary operator
>   - Picked up R-b from Wolfram Sang
> ---
>   drivers/i3c/master/renesas-i3c.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
> index 8b264f72e55c..78d0a2c4a19e 100644
> --- a/drivers/i3c/master/renesas-i3c.c
> +++ b/drivers/i3c/master/renesas-i3c.c
> @@ -579,7 +579,15 @@ static int renesas_i3c_bus_init(struct i3c_master_controller *m)
>   	if (!i3c->rate)
>   		return -EINVAL;
>   
> -	i2c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
> +	/*
> +	 * A pure I3C bus has no I2C devices, so the I3C core leaves
> +	 * scl_rate.i2c at zero if not explicitly defined in DT. The
> +	 * open-drain SCL fields of STDBR, which are used for the DAA
> +	 * pending read, are derived from it though, so fall back to
> +	 * the 1 MHz FM+ limit instead of programming a zero-width clock.
> +	 */
> +	i2c_total_ticks = DIV_ROUND_UP(i3c->rate,
> +				       bus->scl_rate.i2c ?: I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE);

The manual (at lest the RZ/G3S, Rev.1.30) mentions on the documentation of 
BFCTL.FMPE bit:

Set this bit to 1 when using the transmission rate within a range up to 1 Mbps 
(Fast-mode Plus [Fm+]) of the I3C-bus specification. Set this bit to 0 when 
using the transmission rate at other rates (up to 100 kbps [Sm], up to 400 kbps
[Fm]).

In case the i2c_total_ticks = I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE should the 
BFCTL.FMPE bit also be set for the operation you mentioned? If so, maybe set the 
default to I3C_BUS_I2C_FM_SCL_MAX_RATE to avoid any further changes?

Thank you,
Claudiu
