Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665C262FD0;
	Wed,  1 Jul 2026 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924603; cv=none; b=akSprN+G5Jb4DSIuf9zLPX1efhUugELxPYOPQDoKpCR5q2Vsv9MYV0N74TMVxyp4tYdaiOMqMeXdqHa/LK4CJ/X76irQ/brriB+OXDl9l8JgOVlyj79HjE/nWZ26aSsRegzl+yOsViBhn9dkaoFx2rmtfTPiSbJpBNoLGWb/xZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924603; c=relaxed/simple;
	bh=zA7Ymi/b3OiuLUkH8YU6LdnM8Ey0Xw2bQAC8t9F7idA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmH7uncLMhuhGzWuLtENeilSuDNJ4dY5PsgGEiA8+LNuNa/0/tuaYzO1QPkP8eEJcZPx5hjKTxfKtBoz4cnZhYo/6rQIIKOe1t6EvsnXMLFi7IfLUjYEQmuf+s1mheuxXxiQ2El32nefAwSS2o2l774VM5d3twnleuFHP8NcXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLOxq5EY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLOxq5EY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4421F000E9;
	Wed,  1 Jul 2026 16:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782924602;
	bh=jLbiszPFpSFYZ6KZ6Fk2pESh9JefSlc9Ztaf/QjWd/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HLOxq5EYVJOr8HaeRF1w67/0ZKXvk8OyUxB2jeFTl33wp9v92jdZFHB2U6oeIKfWs
	 u/Bi4ITjOJMIPwTr2d/OerjaV+7zhcan0WxE525XM59QUcgHJniAqbWv1T63iQMJT6
	 rwkQ4R0281naCy1QqnbFyhb6MI+v6mPe9/24q6PEtRg1/3g9eXE8CfW0fOJj+xjNRR
	 h5bQG1zCKD4zs3lfUEDe7mAIWhMa1eJFdKm/4vKYDmK301JJ+K339A1hNaYyn6iQ6L
	 iXpPfNgmYmVRpGZMHkeoBySn01nQo6hI0iVH26aqUYW8RWOn6/voIwUiNXW6tFOF8d
	 bsJG8GDGd32Yw==
Date: Wed, 1 Jul 2026 17:49:57 +0100
From: Mark Brown <broonie@kernel.org>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: s.nawrocki@samsung.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fix: sound/soc/samsung: snow_probe: leaked of_node
 references on devm_snd_soc_register_card failure
Message-ID: <bf95ef0c-d80c-4e56-924f-5b41ef629603@sirena.org.uk>
References: <20260627035925.60472-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+HR+mjIYGdKN8HL5"
Content-Disposition: inline
In-Reply-To: <20260627035925.60472-1-vulab@iscas.ac.cn>
X-Cookie: Do unto others before they undo you.


--+HR+mjIYGdKN8HL5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 11:59:25AM +0800, WenTao Liang wrote:
> In snow_probe(), snd_soc_of_get_dai_link_codecs() acquires of_node
> references for codecs, and of_parse_phandle() acquires a reference for

> @@ -203,6 +203,7 @@ static int snow_probe(struct platform_device *pdev)
>  		}
>  	}
> =20
> +	of_node_get(link->cpus->of_node);
>  	link->platforms->of_node =3D link->cpus->of_node;
> =20
>  	/* Update card-name if provided through DT, else use default name */

Where does this reference get dropped in non-error paths?

--+HR+mjIYGdKN8HL5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpFRTUACgkQJNaLcl1U
h9CSNgf9HIZZcyZn0ldKzQ458OYMcid3zUmMkDYPealpVF7EktlifZgakKg0xYn6
94z1hDk7jrKs/pv5KTmcZCLKTdSjR9AMifb3H35ct/Ujd+jZ0RKy6tx+iITBgAlV
NfjJinxq4ypMuIiyUkqCbvXrZj2VLbS8HJMCFbCaRaS36vafwctANbfXp7gKrQDr
xoGUXzUelrhh79RNPzvILovCjHfuzjlAAdqCi32tgYelEvyTEQdILXkLvPAafR4J
6M8915V5F8dyMHYVFtwHBLAxaTQlmmdpzK/auGofg5dyXCaBvDuYg9uVlxfmFFSi
gGfTGJYPoC/QMT41DobgUW9pfNLY5g==
=aiNz
-----END PGP SIGNATURE-----

--+HR+mjIYGdKN8HL5--
