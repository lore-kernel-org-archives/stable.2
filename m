Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE963451C6
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111016; cv=none; b=hSqz2HxFGiOZbfv3dJbeziM1s/kEGQoKZ7rB84YGzzX5Bd1KNbe4353byGQLVYpeoxa5a0nX/o1np8UbKB9fm90qTt3YpFaWPQGqAzYKMBf/arQlifsTPHZmNQU4rxg52rKVIHbAPMDYAU9RaYtr/LsB20wN+p9F1alTXumcVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111016; c=relaxed/simple;
	bh=q/GnNhRXgtNonj5Hbv5TaXifaC6125LqAHt7jpcSvkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFZq4pGCWy8eaIbZ+9VAVIHsoR230yZAUg/QL0kjNQmvUU5ikhPpQa/bmYVmxydzm+bn5l5nFIfeL4c5mydFMDMcm3+7l/Eml/+QSxPjne3qWRuWebUQ+DrUA+uIl3oXHByV0/TJX1Su3Zw+ee3QzbebD1dBaZ2oD34we/sk7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVeWb3tk; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVeWb3tk"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-13817614cd3so2550168c88.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781111014; x=1781715814; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80O98Z5SURIfal+xsAh8ZVNVFCyTDBt3hWYfVCW8oqU=;
        b=IVeWb3tklmWl//SpFc2N0MSVAH8WnRnTFo1u1MejaE/evB1n+KM45bhL64KIEXOieN
         RrA8VWj9jaOd7YEJmTYShASUDZAdOclQ7C+orIwaMRSMi60AaUW/8hTFUzhz4ZPgIAYn
         203/9rfhkujle8xECUQ15gQWhNGPiW5EubydRr5AQMVAbAI5gPqCUOrJefVO4AZy//wx
         2vrm0ie52l/AvxbZuqhneQfBqG2Z4i2JnbjeFU05wkeWcsMmG3HK08I0Rnksh7TzY6R+
         p+51QxIlEGkaNzPvbg4kAd4EkchDrsuKKUWCZ0mw90oTda8+g6V4RZP8EfBJqBwe+SWU
         LMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111014; x=1781715814;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80O98Z5SURIfal+xsAh8ZVNVFCyTDBt3hWYfVCW8oqU=;
        b=QfuRiwNP1zUBe09geYkYWQpvjXG5QCl6O5tS7zpMgDKXQjOx3PMndqinttfIhYnYEl
         WZf1hq8l1gFG/gzSuA169114+vBhaV0DYDhMAzvHzy9GtnJRZrd5upA4PC1FxyKNMqAV
         TGXzuxaJSuQIAHAcZ0mX0S7bHSGvhekQDo+VDLac5nxiJ22oHJaylLfXZtOQHHC9IFgM
         OU9XIb5jS6U8shRLnPvnoDkBT6EP7DCMGwwuCHLPfV4Dkdqoybwc4X3xerVTyzYKYLlh
         ZfOSvvi7gCtPiiuROZu9iSRJvGfAs/XSx1hQ8Ii1n1GOC8aA23qLEnXZE7j5Pg5LUntT
         fFaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lJiAuphqqbgDAlU6LRsEWd48NqaMsrHI17CO2J61N/BM8umq8n6TkIp9AVIJoKNsZ8wFAU7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsmAeUU9BxDTLgtYzTvcHVWZDayiv78KNHAuailLO2vDRSSu80
	4dg3j6iM/gYEk5ZkNJMxHpdZyZb8npSIv2TdEeWyygOFhb6nN2BWLlO1
X-Gm-Gg: Acq92OEzGmjJlddipbEHyZS/Q8m3PidZZXhINSJta9EQDR6mZ6dpOebZsnzBl4KNMmI
	CJ7/lpKVK3fv9s2JoUJ+aQPgzb9QxlHFWpz8HpF2bE8UVTtRXz5qNMWcD5Tm9GpznOMn9JIcA5D
	kkCuRIW8o5msRAjHS6/jm3CzfCHsGqHzQhDd8FUuEAis6JaCV/BLbZI8+DMYtFbhyCAWee+p3kr
	+LlaMKOZP1vsbycSLPxSizzuMgbEkBcplIytgDFkK5eLmcK9RvlA71hds0S7wU44Lg77NEWwdH8
	RF4Uh3XpPbdReNOATLwBHzXkOuKvFc7W8teznywjqRUlv9P3smR7j3UiluqGIIG1eb2jLJNUyvu
	RCkpmnmJqlfjzaQQy2XqEYdOmqvnnvQJQ+pqwXOtyPQVO5EwdrlnrYbBUrvbgERJkewchB01D/I
	ebMWSOubGT7IiiaTVnKmPZRQslZpzpab9zoyCYfTRP5sr9KHoW12Tvg4c5MkXPz9vGkqdcRPGqv
	Wv9F2JY8HVV
X-Received: by 2002:a05:7022:390:b0:130:6936:dcde with SMTP id a92af1059eb24-138066d4f9fmr15907662c88.14.1781111013277;
        Wed, 10 Jun 2026 10:03:33 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-23.user3p.v-tal.net.br. [177.4.161.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54c9c12sm19100570c88.6.2026.06.10.10.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 10:03:32 -0700 (PDT)
Message-ID: <953cdb8f-abc2-4420-b718-ff918ee84808@gmail.com>
Date: Wed, 10 Jun 2026 14:03:25 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: topology: validate vendor array size before
 parsing
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, notify@kernel.org, stable@vger.kernel.org
References: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
 <fcf37969-2641-4480-a4cf-3eaf37b7d3b9@linux.intel.com>
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <fcf37969-2641-4480-a4cf-3eaf37b7d3b9@linux.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AmZ4jy1r43WftB2UwyOeevTO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AmZ4jy1r43WftB2UwyOeevTO
Content-Type: multipart/mixed; boundary="------------0DxepLFtLAPMC10xcpkMY0o7";
 protected-headers="v1"
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, notify@kernel.org, stable@vger.kernel.org
Message-ID: <953cdb8f-abc2-4420-b718-ff918ee84808@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: topology: validate vendor array size before
 parsing
References: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
 <fcf37969-2641-4480-a4cf-3eaf37b7d3b9@linux.intel.com>
In-Reply-To: <fcf37969-2641-4480-a4cf-3eaf37b7d3b9@linux.intel.com>
Autocrypt-Gossip: addr=broonie@kernel.org; keydata=
 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
Autocrypt-Gossip: addr=perex@perex.cz; keydata=
 xsFNBFvNeCsBEACUu2ZgwoGXmVFGukNPWjA68/7eMWI7AvNHpekSGv3z42Iy4DGZabs2Jtvk
 ZeWulJmMOh9ktP9rVWYKL9H54gH5LSdxjYYTQpSCPzM37nisJaksC8XCwD4yTDR+VFCtB5z/
 E7U0qujGhU5jDTne3dZpVv1QnYHlVHk4noKxLjvEQIdJWzsF6e2EMp4SLG/OXhdC9ZeNt5IU
 HQpcKgyIOUdq+44B4VCzAMniaNLKNAZkTQ6Hc0sz0jXdq+8ZpaoPEgLlt7IlztT/MUcH3ABD
 LwcFvCsuPLLmiczk6/38iIjqMtrN7/gP8nvZuvCValLyzlArtbHFH8v7qO8o/5KXX62acCZ4
 aHXaUHk7ahr15VbOsaqUIFfNxpthxYFuWDu9u0lhvEef5tDWb/FX+TOa8iSLjNoe69vMCj1F
 srZ9x2gjbqS2NgGfpQPwwoBxG0YRf6ierZK3I6A15N0RY5/KSFCQvJOX0aW8TztisbmJvX54
 GNGzWurrztj690XLp/clewmfIUS3CYFqKLErT4761BpiK5XWUB4oxYVwc+L8btk1GOCOBVsp
 4xAVD2m7M+9YKitNiYM4RtFiXwqfLk1uUTEvsaFkC1vu3C9aVDn3KQrZ9M8MBh/f2c8VcKbN
 njxs6x6tOdF5IhUc2E+janDLPZIfWDjYJ6syHadicPiATruKvwARAQABzSBKYXJvc2xhdiBL
 eXNlbGEgPHBlcmV4QHBlcmV4LmN6PsLBjgQTAQgAOBYhBF7f7LZepM3UTvmsRTCsxHw/elMJ
 BQJbzXgrAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEDCsxHw/elMJDGAP/ReIRiRw
 lSzijpsGF/AslLEljncG5tvb/xHwCxK5JawIpViwwyJss06/IAvdY5vn5AdfUfCl2J+OakaR
 VM/hdHjCYNu4bdBYZQBmEiKsPccZG2YFDRudEmiaoaJ1e8ZsiA3rSf4SiWWsbcBOYHr/unTf
 4KQsdUHzPUt8Ffi9HrAFzI2wjjiyV5yUGp3x58ZypAIMcKFtA1aDwhA6YmQ6lb8/bC0LTC6l
 cAAS1tj7YF5nFfXsodCOKK5rKf5/QOF0OCD2Gy+mGLNQnq6S+kD+ujQfOLaUHeyfcNBEBxda
 nZID7gzd65bHUMAeWttZr3m5ESrlt2SaNBddbN7NVpVa/292cuwDCLw2j+fAZbiVOYyqMSY4
 LaNqmfa0wJAv30BMKeRAovozJy62j0AnntqrvtDqqvuXgYirj2BEDxx0OhZVqlI8o5qB6rA5
 Pfp2xKRE8Fw3mASYRDNad08JDhJgsR/N5JDGbh4+6sznOA5J63TJ+vCFGM37M5WXInrZJBM3
 ABicmpClXn42zX3Gdf/GMM3SQBrIriBtB9iEHQcRG/F+kkGOY4QDi4BZxo45KraANGmCkDk0
 +xLZVfWh8YOBep+x2Sf83up5IMmIZAtYnxr77VlMYHDWjnpFnfuja+fcnkuzvvy7AHJZUO1A
 aKexwcBjfTxtlX4BiNoK+MgrjYywzsFNBFvNeCsBEACb8FXFMOw1g+IGVicWVB+9AvOLOhqI
 FMhUuDWmlsnT8B/aLxcRVUTXoNgJpt0y0SpWD3eEJOkqjHuvHfk+VhKWDsg6vlNUmF1Ttvob
 18rce0UH1s+wlE8YX8zFgODbtRx8h/BpykwnuWNTiotu9itlE83yOUbv/kHOPUz4Ul1+LoCf
 V2xXssYSEnNr+uUG6/xPnaTvKj+pC7YCl38Jd5PgxsP3omW2Pi9T3rDO6cztu6VvR9/vlQ8Z
 t0p+eeiGqQV3I+7k+S0J6TxMEHI8xmfYFcaVDlKeA5asxkqu5PDZm3Dzgb0XmFbVeakI0be8
 +mS6s0Y4ATtn/D84PQo4bvYqTsqAAJkApEbHEIHPwRyaXjI7fq5BTXfUO+++UXlBCkiH8Sle
 2a8IGI1aBzuL7G9suORQUlBCxy+0H7ugr2uku1e0S/3LhdfAQRUAQm+K7NfSljtGuL8RjXWQ
 f3B6Vs7vo+17jOU7tzviahgeRTcYBss3e264RkL62zdZyyArbVbK7uIU6utvv0eYqG9cni+o
 z7CAe7vMbb5KfNOAJ16+znlOFTieKGyFQBtByHkhh86BQNQn77aESJRQdXvo5YCGX3BuRUaQ
 zydmrgwauQTSnIhgLZPv5pphuKOmkzvlCDX+tmaCrNdNc+0geSAXNe4CqYQlSnJv6odbrQlD
 Qotm9QARAQABwsF2BBgBCAAgFiEEXt/stl6kzdRO+axFMKzEfD96UwkFAlvNeCsCGwwACgkQ
 MKzEfD96Uwlkjg/+MZVS4M/vBbIkH3byGId/MWPy13QdDzBvV0WBqfnr6n99lf7tKKp85bpB
 y7KRAPtXu+9WBzbbIe42sxmWJtDFIeT0HJxPn64l9a1btPnaILblE1mrfZYAxIOMk3UZA3PH
 uFdyhQDJbDGi3LklDhsJFTAhBZI5xMSnqhaMmWCL99OWwfyJn2omp8R+lBfAJZR31vW6wzsj
 ssOvKIbgBpV/o3oGyAofIXPYzhY+jhWgOYtiPw9bknu748K+kK3fk0OeEG6doO4leB7LuWig
 dmLZkcLlJzSE6UhEwHZ8WREOMIGJnMF51WcF0A3JUeKpYYEvSJNDEm7dRtpb0x/Y5HIfrg5/
 qAKutAYPY7ClQLu5RHv5uqshiwyfGPaiE8Coyphvd5YbOlMm3mC/DbEstHG7zA89fN9gAzsJ
 0TFL5lNz1s/fo+//ktlG9H28EHD8WOwkpibsngpvY+FKUGfJgIxpmdXVOkiORWQpndWyRIqw
 k8vz1gDNeG7HOIh46GnKIrQiUXVzAuUvM5vI9YaW3YRNTcn3pguQRt+Tl9Y6G+j+yvuLL173
 m4zRUU6DOygmpQAVYSOJvKAJ07AhQGaWAAi5msM6BcTU4YGcpW7FHr6+xaFDlRHzf1lkvavX
 WoxP1IA1DFuBMeYMzfyi4qDWjXc+C51ZaQd39EulYMh+JVaWRoY=

--------------0DxepLFtLAPMC10xcpkMY0o7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6/10/26 13:03, P=C3=A9ter Ujfalusi wrote:
>> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
>> index 8fc7726aec29..bb6b981e55d1 100644
>> --- a/sound/soc/sof/topology.c
>> +++ b/sound/soc/sof/topology.c
>> @@ -740,10 +740,13 @@ static int sof_parse_token_sets(struct snd_soc_c=
omponent *scomp,
>>  	int ret;
>> =20
>>  	while (array_size > 0 && total < count * token_instance_num) {
>> +		if (array_size < (int)sizeof(*array))
>> +			return -EINVAL;
>> +
>>  		asize =3D le32_to_cpu(array->size);
>> =20
>>  		/* validate asize */
>> -		if (asize < sizeof(*array)) {
>> +		if (asize < (int)sizeof(*array)) {
>>  			dev_err(scomp->dev, "error: invalid array size 0x%x\n",
>>  				asize);
>>  			return -EINVAL;
>=20
> I think this only partially right, I would cover a bit more:
>=20
> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
> index 898b94f88706..b0d37ec2bc5e 100644
> --- a/sound/soc/sof/topology.c
> +++ b/sound/soc/sof/topology.c
> @@ -12,6 +12,7 @@
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/firmware.h>
> +#include <linux/overflow.h>
>  #include <linux/workqueue.h>
>  #include <sound/tlv.h>
>  #include <uapi/sound/sof/tokens.h>
> @@ -738,27 +739,43 @@ static int sof_parse_token_sets(struct snd_soc_co=
mponent *scomp,
>  	size_t offset =3D 0;
>  	int found =3D 0;
>  	int total =3D 0;
> +	int max_tokens;
>  	int asize;
>  	int ret;
> =20
> -	while (array_size > 0 && total < count * token_instance_num) {
> +	if (check_mul_overflow(count, token_instance_num, &max_tokens)) {
> +		dev_err(scomp->dev, "%s: token count overflow %d * %d\n",
> +			__func__, count, token_instance_num);
> +		return -EINVAL;
> +	}
> +
> +	while (array_size > 0 && total < max_tokens) {
> +		if (array_size < (int)sizeof(*array)) {
> +			dev_err(scomp->dev,
> +				"%s: invalid remaining array size %d\n",
> +				__func__, array_size);
> +			return -EINVAL;
> +		}
> +
>  		asize =3D le32_to_cpu(array->size);
> =20
>  		/* validate asize */
> -		if (asize < sizeof(*array)) {
> -			dev_err(scomp->dev, "error: invalid array size 0x%x\n",
> -				asize);
> +		if (asize < (int)sizeof(*array)) {
> +			dev_err(scomp->dev, "%s: vendor array too small %d\n",
> +				__func__, asize);
>  			return -EINVAL;
>  		}
> =20
>  		/* make sure there is enough data before parsing */
> -		array_size -=3D asize;
> -		if (array_size < 0) {
> -			dev_err(scomp->dev, "error: invalid array size 0x%x\n",
> -				asize);
> +		if (asize > array_size) {
> +			dev_err(scomp->dev,
> +				"%s: vendor array size %d exceeds remaining data\n",
> +				__func__, asize);
>  			return -EINVAL;
>  		}
> =20
> +		array_size -=3D asize;
> +
>  		/* call correct parser depending on type */
>  		switch (le32_to_cpu(array->type)) {
>  		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
>=20

Thank you, this is way more complete.
I will respin a v2.

--=20
Thanks,
C=C3=A1ssio


--------------0DxepLFtLAPMC10xcpkMY0o7--

--------------AmZ4jy1r43WftB2UwyOeevTO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSrYqI5vIrg1X9eqEjQXT8aWv/ugwUCaimY3gUDAAAAAAAKCRDQXT8aWv/ug9I/
AP47MdcTCP1fsL2TbD8/1LBLvWCKbV7ZCQ/naXkS8y+ISwEA6GYKWfPdqjmEpYoOzDVr9myaqGeZ
Sn2dR/aS/QEoIA4=
=49u/
-----END PGP SIGNATURE-----

--------------AmZ4jy1r43WftB2UwyOeevTO--
