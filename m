Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F433B8124
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105754; cv=none; b=DccG61PymjsJW+tA1gw6HOk7/DWe9p4xAaY3+sA0N+6C7IlhefchQYVxetSSABj4s7cbgT19xPxB2AzYbGu1RAS4jvIbwELAsM1bjRA+AV/Tv2IRuufVK37q9mgWInZjBud8zJfza9AtA0ZOssdppBU4KU/jKbs2G0V7Rkw99co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105754; c=relaxed/simple;
	bh=XNze1Rj4JpnA+MAhhiEQfdQ7tEFIAbbJ8igjMhTyxkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMJR2M09ONsI8914OXZ1TwJeqGg6lcBYn8jseu3SpR9vxQss7n7Klm2A2vf6DRnD152Hkm+aWCquyPgQjsr42uHuHeSgvELK/Gc0PS92qoTJE4MAglWv8RFePHP/rbf0eJxDVAXc0sPf+3yniqrXnmjYcqfNpRLaP+6yqluOoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKFzR3fh; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKFzR3fh"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-307631dbfedso14878113eec.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105753; x=1781710553; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVgM/siIoM2PXbcXJa1Dk1ZFx+nbYqp/f0zPJFPRPIw=;
        b=IKFzR3fhniQ7hN4wmZulS+BxE9CPxSBzboP4Z+2yXqPh745OTK4uTJVDdRrBlT5xIx
         x1JXQoMBS1EyLzA27Vx/E2OWEvJEgRUJ6JYSiUQupqx/taC2/A6EvAE4IyXrs7r1ux/i
         1j138M2QZYdxaMFDOUCDKVTA1f3IoZXQgGyf7dbkJ7lGufQCFxt96FPS7BYfokclOxn2
         pFA77d4ONWuB1tz6NGBulV9QB4aonCI5C6VXm5vaQyaRTecv9rH4CV8X3Xr86yhL9k5+
         qV68lBLuXxnaCEO2/SMS8LT/29YUvztJ85OxVCDej3un+W1C0qA5FLGlvNZqUn5pL4+A
         EvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105753; x=1781710553;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVgM/siIoM2PXbcXJa1Dk1ZFx+nbYqp/f0zPJFPRPIw=;
        b=L0dehhfS/zF9U4lQnQiMYLmKmdo0bIRHxUmubGSmxPwhLE4pMvO8qPq3emCciERaDi
         Ix0CDmNrKcsNuKg0KloIFK1oiVVcQ5Y6NRoqLwFbjDhQYhaRMwc+vAqWygOwEGimqSI9
         1/HXPYVWmKvRMHf05YH38+d2stWSYNku1aTkKAgw7YIi6KJ8Cfd9efLvrkfVz/1O6LHK
         //bEIZLdFR36G2bKle50STlrCpdUoP6tMld8a8QFBGYQCTJTIEeO5QU4NfivP7n6iDP5
         R9ZJistNf+nQAnkFYIFRRiZX6dWr/UlQAdmaqfieDzDIKKQqjhpKcZHPnrtQZBy+raJL
         EMrQ==
X-Forwarded-Encrypted: i=1; AFNElJ85By1pcmBlwJ425dDpAI0E0uHWJug8+3UG/2dI4howx1MG1H2U5sILs8a0SNwu2xjKaKywX+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhwA2WKGDJDjVtLA8mm7pNQIloWxQID0iUZkTi2r1hf0ZhmrCz
	/6EUOQ2x4JeGl4dP0pOiYV+9e7oaFdTVz1LIsgCXrvFBxwHfK1SYHKOJ
X-Gm-Gg: Acq92OEE0gmB5fdglEaVGRw87fMWM6U1RmPMUXKUwI7rrtuzCfQad7Q06Q9EX033xD+
	8PFAUV6QqW78aeV8zuqm3Hv7bRuOOeFW2shuhZkgGXI09PrA03cdTF/BGQHkDh0enoAic8Ijxsr
	VZ7vSMu0GrEiePy3Fs0RHMI6F5zRznxWG4B6VBB7seAumXZu5XJ4EVcfn8Z/QEWhsMCmiUxfTz3
	RtxS8Ead9hZvOcJ0ScAPwURIceyzxBdwfvqcbYrGKVxDju+A4HxDLp25B++R9N4XDr8hGKS3UR1
	+zcDFQsw9bS7bqH89ims+rvdRG43H30ZzcFIOPOqfbav49z9+k/ZwFF/mlMfBIJ97Dz6dELiDID
	1JJCa7QK0WS4tol0O7Eu820vqIG2Gv5aXCeYot2jVyEU2OVFK83MeevKpPGqEXHeroaREYUj7yh
	RxA+LcV2PU2GLGKeC2gZwzoOOF2dlJL6L3bvSBHTx2LXKqS9GvZ4YRimLrFJqxdzAUewKXCh0bb
	ovgIz/K4uyU
X-Received: by 2002:a05:7300:3211:b0:2ed:6f94:9d9f with SMTP id 5a478bee46e88-307d5fed48amr6894235eec.11.1781105752454;
        Wed, 10 Jun 2026 08:35:52 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-23.user3p.v-tal.net.br. [177.4.161.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df102a1sm24818383eec.20.2026.06.10.08.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 08:35:51 -0700 (PDT)
Message-ID: <e7ed47de-1799-4ba1-b29d-5ec992e978bc@gmail.com>
Date: Wed, 10 Jun 2026 12:35:46 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: topology: validate vendor array size before
 parsing
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, notify@kernel.org, stable@vger.kernel.org
References: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
 <a14ebacf-2c2d-4de7-8404-05ae92d8ee83@gmail.com>
 <aimBR9VyYnK8CpBD@sirena.co.uk>
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <aimBR9VyYnK8CpBD@sirena.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6Xc8L9ar1loh37WlSWNVqo2X"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6Xc8L9ar1loh37WlSWNVqo2X
Content-Type: multipart/mixed; boundary="------------iM2tN9oRg00h0xKRwZlU9DAo";
 protected-headers="v1"
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, notify@kernel.org, stable@vger.kernel.org
Message-ID: <e7ed47de-1799-4ba1-b29d-5ec992e978bc@gmail.com>
Subject: Re: [PATCH] ASoC: SOF: topology: validate vendor array size before
 parsing
References: <20260603-sof-topology-array-size-signed-v1-1-84f97879a4ef@gmail.com>
 <a14ebacf-2c2d-4de7-8404-05ae92d8ee83@gmail.com>
 <aimBR9VyYnK8CpBD@sirena.co.uk>
In-Reply-To: <aimBR9VyYnK8CpBD@sirena.co.uk>
Autocrypt-Gossip: addr=broonie@kernel.org; keydata=
 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
Autocrypt-Gossip: addr=perex@perex.cz; keydata=
 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

--------------iM2tN9oRg00h0xKRwZlU9DAo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6/10/26 12:22, Mark Brown wrote:
> Please don't send content free pings and please allow a reasonable time=

> for review.  People get busy, go on holiday, attend conferences and so =

> on so unless there is some reason for urgency (like critical bug fixes)=

> please allow at least a couple of weeks for review.  If there have been=

> review comments then people may be waiting for those to be addressed.
>=20
> Sending content free pings adds to the mail volume (if they are seen at=

> all) which is often the problem and since they can't be reviewed
> directly if something has gone wrong you'll have to resend the patches
> anyway, so sending again is generally a better approach though there ar=
e
> some other maintainers who like them - if in doubt look at how patches
> for the subsystem are normally handled.

Okay, thank you for the advice as I am still
getting used to how this subsystem operates.=20

Regards,
C=C3=A1ssio

--------------iM2tN9oRg00h0xKRwZlU9DAo--

--------------6Xc8L9ar1loh37WlSWNVqo2X
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSrYqI5vIrg1X9eqEjQXT8aWv/ugwUCaimEUgUDAAAAAAAKCRDQXT8aWv/ugwoP
AQDKM6t4WtnKY+3RFlgApnSee/9889C0BiaQoe0oQgYmjQD9FQlWOR0L4sfHPh6GWfr7L0yOLtHc
rEh+HdkiUc2mTQA=
=vbBF
-----END PGP SIGNATURE-----

--------------6Xc8L9ar1loh37WlSWNVqo2X--
