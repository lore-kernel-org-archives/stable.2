Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DC31E835
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101659; cv=none; b=cxUuJeVWlKieT5/80OaiKlFRIE1e/Wbx+RYBZNAH05WS8n1rFaFNldhxotvflrZR/ci8wQ1apCigyViITh12n/pR1ToUcr23DHT4fvKFEGcbGn2kmreq9HRaFLP926p6ON+vu6LQy95FkY9r9p9shqp9KasEppCvTmBHIyL5/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101659; c=relaxed/simple;
	bh=no+TfyfR9zY9Wog4sk5xDBEL+f26cKfkCuNcqqGqzpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCixIwvdEkoPkue8LRUqZrAJNQVPUYXVcuGRmYQulwzhDG7WXAHkbo55NUATU365iTKNQh0rnGJdo5Tny0CueGkBarQM9ahS6CaSkdOQ4KO25Edq9jv73hpNTwXovpaaidJ0yI7G8/ukhW1JqNzy1+EutAE15VxgcdKGCM3oXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wb/Ht060; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wb/Ht060"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so12191666a12.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781101656; x=1781706456; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkcUeI/o0XHeHIOtaMcqDkX8z1WvMaUaPvRPtFv5LGM=;
        b=Wb/Ht0601XeT7UjyeRiMpPWRpBMIqTm492Psm+LNdeASRt+vYAghXAa4jqU49rd8+f
         UghmazziCOeGAuRSabmGUpb8ZVUY98hEBGfoEUBP4CreAKYHm52FZGYC1i9ZgNiYE7IR
         oQ5CmzHVjKiwBixgvr2eC46q2ypnp+/gTnehP6Erh5xgz47/qIalwNsu/LigQC2QSnlt
         3p2AacyVBe2AbFYpKEoEdWlmZRgnH2JnWl8vrKCMDC0MUd5o6E4tUnrSTY43NR05qKtv
         8qMuQFh+hu3lc/iq7X2RNN1r+z6zojTMk7uW6isBz2V85EFR5hIe2I3TxR78mzADllsx
         Rpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781101656; x=1781706456;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KkcUeI/o0XHeHIOtaMcqDkX8z1WvMaUaPvRPtFv5LGM=;
        b=dXYB24mogztjFP/hlvdv1mDLY1/BCh/7WBQpKJ9bKMsOLyo3sFGRafpGYE4e1cAblI
         tWVluA45XNDy5zHRvR+zzw2KdWx/SSEIu++8II3UALNT27XPiodYPTpahUxCEzq2uxQx
         DEQTbM52RLooE/WmWjt9lTMBzbDPUo921odCt37wposGcrY43nRkoDMlDeBBFW4nvdXr
         annnFQ7ntgvE9LVAExDelPCw8sGTVd/Xj4q1sXh/D18weBcTHUAWvxEDFuNuUwf3lDtF
         OmERDGUA/AXsT+NIWg5IqdZN/cHsgSdLAYiIvwUwnqN+K0H0JVVGioKCmghMCjOEicDE
         9iaA==
X-Forwarded-Encrypted: i=1; AFNElJ+ndxBP3bE6UCQOi8+0hOrWG2mTJ1/Je3O5jFVaM8Oy9YurF5pX81oB/NFfyKF8tn6WF+g8bbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2qxzwH/BtyF1I382ywSEzncxXbpZbXyGkTZiYgKhtB+9rrNPu
	jGZ0VlbEdDnWV3lxvP1H+qPZaoCIhtqcGTJ6zQoZT+AuXg7JQa3VfFpz
X-Gm-Gg: Acq92OFIq/YFGJTmSLPC6NHX5rsl/E1xrl7LZC5GAgraKGS1oquxgxHlghzRgnQkoSK
	32lKY4pj80Asv2VgsvX9i+uE8gppkVJ2juhvBjaptEzii65SnK8cAGMOuiLB2GO6erpRnXf2cg2
	/lALRUqOuONPCVcupeP0f14Y0AGnNlxG2oG6sT6WtQEVaP0/DzP2wy36jdVfiUB/h+SV/Y1YxX6
	WArywNrLeykbr7lj1mPyy3UhnwRqjA8BUOBrPo6ZjLTEZlL5KN9XhBLhvU0T3ingijrWyI9pqCk
	nbd9WOB4L1umNqrfFZJyooauYs/Wp3vF6Or4VoFkZTaj41uVoDu9tHwhtGca67ko052wdNFOxNB
	dhYacfKjVSlTCcJC6l3Nm/ECduxuVVHje4lFwOF2xfpmOZKXup0VHNvvtpruzWGxcl2MLQMeAOv
	88uJlQPiaWzXSQqA3npZtbGbTMQP9BbMTK9iAOMA6C0wiBSW+ePzZMEA93sGJH4LHOs4S1jQ/B4
	w6qTt2yrZxR
X-Received: by 2002:a05:6402:5209:b0:68f:c64f:c33 with SMTP id 4fb4d7f45d1cf-69238a50730mr3987451a12.28.1781101656203;
        Wed, 10 Jun 2026 07:27:36 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-23.user3p.v-tal.net.br. [177.4.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64c2f1bbsm9879797a12.2.2026.06.10.07.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 07:27:35 -0700 (PDT)
Message-ID: <a14ebacf-2c2d-4de7-8404-05ae92d8ee83@gmail.com>
Date: Wed, 10 Jun 2026 11:27:25 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: topology: validate vendor array size before
 parsing
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
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
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NE449Rn0QoUyWn3nVspA7QEX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NE449Rn0QoUyWn3nVspA7QEX
Content-Type: multipart/mixed; boundary="------------9r3ebczSTgHCX24S0kvULdRz";
 protected-headers="v1"
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, notify@kernel.org, stable@vger.kernel.org
Message-ID: <a14ebacf-2c2d-4de7-8404-05ae92d8ee83@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: topology: validate vendor array size before
 parsing
References: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
In-Reply-To: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
Autocrypt-Gossip: addr=broonie@kernel.org; keydata=
 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
Autocrypt-Gossip: addr=perex@perex.cz; keydata=
 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

--------------9r3ebczSTgHCX24S0kvULdRz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

On 6/3/26 14:57, C=C3=A1ssio Gabriel wrote:
> sof_parse_token_sets() reads array->size while iterating over topology
> private data. The loop condition only checks that some data remains, so=
 a
> malformed topology with a truncated trailing vendor array can make the
> parser read the size field before a full vendor-array header is availab=
le.
>=20
> Validate that the remaining private data contains a complete
> snd_soc_tplg_vendor_array header before reading array->size.
>=20
> The declared array size check also needs to remain signed. asize is an =
int,
> but sizeof(*array) has type size_t, so comparing them directly promotes=

> negative asize values to unsigned and lets them pass the check,
> as reported in the stable review thread reference below.
>=20
> Cast sizeof(*array) to int when validating the declared array size. Thi=
s
> rejects negative, zero and otherwise too-small sizes before the parser
> dispatches to the tuple-specific code.
>=20
> Link: https://lore.kernel.org/stable/CANiDSCsjR5NHqu_Ui5cOqWdJgFqmYsQ9W=
R8O7m0WOhngaYXFpw@mail.gmail.com/t/#m9b3be379221e79327cc13fd71009287368ef=
4f23
> Fixes: 215e5fe75881 ("ASoC: SOF: topology: reject invalid vendor array =
size in token parser")
> Cc: stable@vger.kernel.org
> Signed-off-by: C=C3=A1ssio Gabriel <cassiogabrielcontato@gmail.com>
> ---
>  sound/soc/sof/topology.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
> index 8fc7726aec29..bb6b981e55d1 100644
> --- a/sound/soc/sof/topology.c
> +++ b/sound/soc/sof/topology.c
> @@ -740,10 +740,13 @@ static int sof_parse_token_sets(struct snd_soc_co=
mponent *scomp,
>  	int ret;
> =20
>  	while (array_size > 0 && total < count * token_instance_num) {
> +		if (array_size < (int)sizeof(*array))
> +			return -EINVAL;
> +
>  		asize =3D le32_to_cpu(array->size);
> =20
>  		/* validate asize */
> -		if (asize < sizeof(*array)) {
> +		if (asize < (int)sizeof(*array)) {
>  			dev_err(scomp->dev, "error: invalid array size 0x%x\n",
>  				asize);
>  			return -EINVAL;
>=20

Gentle ping on that fix.
Sorry for the noise.

--=20
Thanks,
C=C3=A1ssio


--------------9r3ebczSTgHCX24S0kvULdRz--

--------------NE449Rn0QoUyWn3nVspA7QEX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSrYqI5vIrg1X9eqEjQXT8aWv/ugwUCail0TQUDAAAAAAAKCRDQXT8aWv/ug9Xm
AP91TPpE1XwLCLxRGgSPdiO/2mjrMmQzGtsuloshfRMi7wEA0jbbSyF/U4fnnDu3TSdSn/bJA8aM
O6SfEL/zcp5hqgs=
=e8fD
-----END PGP SIGNATURE-----

--------------NE449Rn0QoUyWn3nVspA7QEX--
