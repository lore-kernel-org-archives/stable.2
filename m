Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555B44F54B;
	Mon, 21 Sep 2026 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979253; cv=none; b=toThGxTZb3cqVgpy25fkI8Rj+IPalCRHsj3eXxJFszNFxjSRVaVwpqmbRqLFZB2ap+7rR+iYFsOs83VDNuCXTU8rc+bdcnEGNcqaGUFcTv3/OPICmLufJ2dOZ7gpFtZXhRl7tiMngxxKYTBpj5ZkWHnhAMibROd3EwKzs/+yDKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979253; c=relaxed/simple;
	bh=pkyPTuTH+YKoglPBpvQOIpWF3ngNlLjfGTpiCPkEPZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OobRTyn4BlHUXLhLniHvEoDxfDi5lVec4eZMcr71ENRTmZFr//OfA6o6grGM/IvGeN/ELY06ew7kLQkZNpRx4+RAmLGJvsRRMLiH65x3otq5nOj5DH5wgiit7g9j2HSzxfao8cztPaplPQ7xpVp1DCC/R+Lb1nYt4jZp49i1o/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSuy99SE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSuy99SE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F7A1F000FF;
	Mon, 21 Sep 2026 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979251;
	bh=pkyPTuTH+YKoglPBpvQOIpWF3ngNlLjfGTpiCPkEPZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bSuy99SEHzRPu4717uVG/gx9vYsFT1M9CYXNrj64Q7b2+sf3EESpOgJzYlQAIS8FX
	 i6NrPwq5nk9Hfl4ZGs4ISyHZRWF78WenSHzpLShOSOjyYI+Qs6H89UxTifTgE7YgxB
	 2W+7Ltuv0V9vL1Rt06fNrQbsAP7F+vAdYobkMso45ud+a8pasqyQY8o+GkW3bI3UPu
	 7jeFa8AKtMHHZmMAtZXPJOdMGciOVyxK+t9MUeYB9ovkBCPrnM/5d9oBVOA12770pr
	 MSYs+j9kPOh1VlE5d7bEeZVtyng/+vV/E9ecY8VghvVxcMKgs5q/5EucT8b3r7g5Xc
	 ELhTUFdXUsClw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 560191AC52F3; Mon, 21 Sep 2026 09:27:28 +0100 (BST)
Date: Mon, 21 Sep 2026 10:27:28 +0200
From: Mark Brown <broonie@kernel.org>
To: Zimeng Li <me@lizi.moe>
Cc: srini@kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: qcom: lpass-cpu: use DAI table index for
 playback constraints
Message-ID: <arDqcJ5AbDjGHd-b@sirena.co.uk>
References: <20260920145848.44521-1-me@lizi.moe>
 <20260920193830.53706-1-me@lizi.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvsmE6McXcB+JTG+"
Content-Disposition: inline
In-Reply-To: <20260920193830.53706-1-me@lizi.moe>
X-Cookie: Too clever is dumb.


--nvsmE6McXcB+JTG+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2026 at 03:38:30AM +0800, Zimeng Li wrote:
> The DAI ID is a hardware port ID and is not necessarily the index of
> the corresponding entry in variant->dai_driver.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--nvsmE6McXcB+JTG+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqw6m8ACgkQJNaLcl1U
h9CJ1wf/Ww94F+jwBTs/9sMxb/9ORNRKgONadzCcCAb8XI4ncPtsAoqFoppP1oHg
8DJCzqqoMNJj1U52WtRGlcTZQAU1AFp5EvG0vmKk/1iUaPyDfDRopLBO5ftW+Ar1
jR4xWmjg2s3qQTpTsv11I3eL/7SaQfZKXV3Zb15iezHajhc085MeFFner9nEIZZZ
/bEDcWBopPAmAJYVi1yq4nouQHJtiOQIf3qi7eqPgHTScy57Jv2EaK6vgwTGjaHZ
DnafNsFMQFBAzjlQUGdK7saKtVTUu1htBL67iTk+H+jtf+X54qCMPelcySIOtule
JluIo0xD8AR6yfsc7Mq3CPB0/QpAIQ==
=P1Rl
-----END PGP SIGNATURE-----

--nvsmE6McXcB+JTG+--
