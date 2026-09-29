Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDE3D88F2;
	Tue, 29 Sep 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695884; cv=none; b=Yhu0r/Al6BvHlTVgTW+qwIyNmw9KpQHsY/c4Ws+6E6xoCrMoz74sBrevEJTPe/j2LztQ1PtRahSed8RHNkbVrwIIL+TZxKGjW10QhpS8pFjtI5FSZM6W4LivWVynXiPs2dOFrK7gdLbLu5Nl78tT/ppBdR334NRhZc75fyTjbWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695884; c=relaxed/simple;
	bh=2ZewhfadxiSWnz4AaDisoAKtPq56s4kBxyCgZUZbvxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZWilaAIC5X5ig+6WxeQ6573JnrLqIxlcRnBsSC5unDpdcN3HY1ldBk+CP6wfqdVPeIwAlZPtLg06XbFjfc2OV4DCdDeDCUaCtbr9KPfZtW68SMTTe5rAHsy3mD8WJ4LuZ7Fn+3ifJExbI/2jNFxwZAk7jbPYy+fjqYl1yKBSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC9Qgybb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC9Qgybb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2707E1F00899;
	Tue, 29 Sep 2026 15:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790695882;
	bh=oHuujSasinLI7hEqP77ZK4vcwV+0umrHPRpUO3Iumeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TC9QgybbOnjrXp5VGy0t4URIje1OCUU3w0BXLWX4GYcVVnu/QB9sgTvo7r1w6hiSP
	 3f1byAoDAnrAVSp/E5uM+58spjHTArkI3XKpGz+NZ85hrlx92tAxaEqxoJs5el6oCs
	 hsgPh085ETcZN3pSVAkXNa06bRt5ni8+06JihaFp/tDXqyylISjg8CPR6fEbjKm96O
	 Yxa3F0KzEXAjkVp5xhyaubeAfTxOHQezLw9YiRLQeu0t8aOMeOT0Rqo0ViJ5NQ5H0U
	 4QLTk0iquJjorBYbAYvTWejc+J16HbgkJDdYjN2xCj5Q8pFWTBTc0oh0YKCsso37V3
	 +wrVrX5xjQ1Cw==
Date: Tue, 29 Sep 2026 16:31:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Corentin Labbe <clabbe@baylibre.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 0/4] regulator: of: Fixes to of_regulator_bulk_get_all()
Message-ID: <e8e21dc7-7b83-40cf-a006-ac5bdeb54d16@sirena.org.uk>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PMup6bLNlrwwEGA2"
Content-Disposition: inline
In-Reply-To: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
X-Cookie: 1 bulls, 3 cows.


--PMup6bLNlrwwEGA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2026 at 02:05:45PM +0400, Alexey Charkov wrote:

>       regulator: of: fill in supply names in of_regulator_bulk_get_all()
>       regulator: of: state who owns the array from of_regulator_bulk_get_all()
>       power: sequencing: pcie-m2: Fix leaking array from of_regulator_bulk_get_all()
>       PCI/pwrctrl: generic: Fix leaking array from of_regulator_bulk_get_all()

Please don't combine tangentially related patches for multiple
subsystems into a single series, it just causes problems getting things
applied.  If there's no actual dependencies send things separately to
each subsystem.

--PMup6bLNlrwwEGA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq72cQACgkQJNaLcl1U
h9BW0Af7BmDivtMYIvX97relpTiu+hGwIUb97C8f4oRuS9CugEDtWDvkDSLJ9FYD
RZxEeI9p8aFc8EBwjEcSU2GxSO/Hq6t9uyEeNa7eoa7Pdrju11VSMShs8XzouzBB
WLcPckZE/69EctnAvVyg314wF3lKkrIiwOv9i+HWB8kgVGtOtq5hnt9D13DqOxfG
F1gj5gqAIr7oOtbfY6l+6wiM0loHXsWCVQ7U0hbG+wmfIEeFZajR//idWRwFWFsP
hA0jtuQJXcXHSrhgqLnTBru3jty5catTK8W5dgqrHFXCEo5PyMj6dP52/+ZSrrWm
l6/adbk7CKJVZUsPD22bi7d3EjHCuQ==
=VEi+
-----END PGP SIGNATURE-----

--PMup6bLNlrwwEGA2--
