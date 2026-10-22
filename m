Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.181.193.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696444;
	b=faQRdteZuYI2JFl9rvlP03E5POZOFUN/iyA4NgDA4eTzZipGeZntQVlo/97dUaUXqwxC
	 g119hbiOe3nUVLjfS0IHa0tdUJkPHjTXWAorM0/0r4p3JqMjFkHFXnYVEU6xjEEa/FGd+
	 lFC5QKNDZJ9yChvSOqJqtLHQprzyAT5SLHa7mEXM9lJaIWc6D0oh1Xv/ZY4sVS+ifWp6D
	 0HbGfaL3Rgvt6Wdnjdme0Ign0xIlOxxz2+x1aj/UpFp79SgPruGvi9rGFxk7YeueLMq20
	 u7P3d0PuYFdz0fuEMlYSLOZInI0iQg4B53z+hBIvRg5VO/fjpSXLIPqnpo7DqYhW4pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696444;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=vsJpFAykU3s5jKmosS/bzWFNklnfVvPjnhdmd2c4CtM=;
	b=hOmhJjKavBCvcqWiBvj+SRbz9J6MIFkcnKZ8MKx3Ipalco9LMotgWSy6e79Q0Jp+fQLJ
	 sHVhx+9mCt3ILGHLESU+nzEZXpmji3s9e0JM/dmImyAHHTHTIl26KlA7/HsSNNVV/89j8
	 QH3M74KQ6pD3VY9d5bDbEVMnAAWIjB6cjF/yv9e+THQ433k/CUCVXypbkNOLkxNRRRJy+
	 pCIr4iBC6nQQgFNR2oqFFqCz6hh9ijMTP6tNkQg3CpS0M71SEseQLtyawLBayHVSGb9Nt
	 vqNF78ntDiKOPYDEo6AeCixQcn9bpJsKLRzdS+X9afhfa6ADBJnQUfzKpNU4kcXZ/Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=auroraos.dev;
	spf=pass smtp.mailfrom=auroraos.dev;
	arc=none smtp.remote-ip=95.181.193.9
Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B17606A319;
	Thu, 22 Oct 2026 19:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01B17606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (91.78.0.35) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 22 Oct
 2026 22:13:49 +0300
Message-ID: <04a4490d-ac6e-4e90-bec4-dd3c0525e62d@auroraos.dev>
Date: Thu, 22 Oct 2026 22:13:49 +0300
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
Subject: Re: [PATCH] media: dib8000: validate SNR exponent before shifting
To: Ilya Krutskih <devsec@tpz.ru>, Mauro Carvalho Chehab <mchehab@kernel.org>
CC: <lvc-project@linuxtesting.org>, Kees Cook <kees@kernel.org>, Hans Verkuil
	<hverkuil+cisco@kernel.org>, Patrick Boettcher <pboettcher@dibcom.fr>,
	Olivier Grenie <Olivier.Grenie@dibcom.fr>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261022172308.224576-1-devsec@tpz.ru>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20261022172308.224576-1-devsec@tpz.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 10/22/26 8:23 PM, Ilya Krutskih wrote:

   Please consider using --no-git-fallback with scripts/get_maintainer.pl --
I don't see what do I have to do with this patch (other than fixing another
bug in this driver earlier).

> Decode the SNR exponent as a signed value instead of storing it in a
> u32.

   I don't see where are you changing the type from u32 in this version of
patch -- this phrase seems to be copied from the 1st (internal) version...

> Subtracting 0x40 from the unsigned exponent currently causes it
> to wrap around when the encoded value represents a negative number.

   Seems to be the intended effect...

> Keep the signal and noise mantissas unsigned, as they are used in
> unsigned fixed-point arithmetic.

   Again, this phrase seems to be (mindlessly?) copied from the 1st
version... :-)

> Check exponent values before shifting by check_shl_overflow().

   Yes, that's what the patch below actually does! :-)

> Return the existing invalid SNR value when the exponent cannot be
> represented safely.
> 
> Fixes: 77e2c0f5d471 ("V4L/DVB (12900): DiB8000: added support for DiBcom ISDB-T/ISDB-Tsb demodulator DiB8000")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Krutskih <devsec@tpz.ru>
> ---
>  drivers/media/dvb-frontends/dib8000.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
> index d291113291e0..442ec06e34dc 100644
> --- a/drivers/media/dvb-frontends/dib8000.c
> +++ b/drivers/media/dvb-frontends/dib8000.c
[...]> @@ -3873,7 +3874,8 @@ static u32 dib8000_get_snr(struct dvb_frontend *fe)
>         exp = (val & 0x3f);
>         if ((exp & 0x20) != 0)
>                 exp -= 0x40;
> -       n <<= exp+16;
> +       if (check_shl_overflow(n, exp + 16, &n))

   The question is whether the hardware can actually return exp < -16 or > 15...

> +               return 0xffffffff;
> 
>         if (state->revision != 0x8090)
>                 val = dib8000_read_word(state, 543);
> @@ -3883,7 +3885,8 @@ static u32 dib8000_get_snr(struct dvb_frontend *fe)
>         exp = (val & 0x3f);
>         if ((exp & 0x20) != 0)
>                 exp -= 0x40;
> -       s <<= exp+16;
> +       if (check_shl_overflow(s, exp + 16, &s))
> +               return 0xffffffff;
> 
>         if (n > 0) {
>                 u32 t = (s/n) << 16;[...]

MBR, Sergey

