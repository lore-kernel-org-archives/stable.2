Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02900423E9A;
	Thu, 17 Sep 2026 22:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683708; cv=none; b=gziE6FdhLaEZYrbHEuBQ4jZwH05J4hzeDo0Wu3x2phQnWMjdmq1F+6sfHpEpad4GNorcfwNu9xYTvEOlhkOeRABpx8rZzpo1Gzc9yAgDZ9W5VKGgcM4/41H5LVXRG+xcuW6bH3EJm3iDJIFYNb0k0tS7ot+QWOrXNH60ottvdh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683708; c=relaxed/simple;
	bh=DYLKcdWgUxWKojVh4s9EMGySLtbagKKKLvKjv72fCKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIasE3xHZwra3iJ7wtaIeXoF+ZyBl6GmEDmzi0U35C8Vz9R6axOLqG7BPuZh0lbDAnI0J2EYPVEVQwMXmWtun02lwd+RooKO1uZyn/tB0IzCLRx0XnAUH04an3kdvYPhE9erzV6Z59Uo1H4UiKKvQ/r5tu74H66nromTv6htcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7B8Jb6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7B8Jb6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503C11F000FF;
	Thu, 17 Sep 2026 22:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683706;
	bh=DYLKcdWgUxWKojVh4s9EMGySLtbagKKKLvKjv72fCKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W7B8Jb6LsZgxQY1TGMe0NpwV+5mwH0cl173FgwDqS5agi8bDkUmeWR/q/8zdP5gCS
	 ljvF+1zo82pwCgAgQ+t5UyNVuWniDEXoGiFFA/QyQFcbrURcLD3/qClJfIY+FBugPd
	 6xiUD1biKQxGQwpkMgbxtWEaztuwQu0zAQtgNs6PW3leHq9jRiqMA8yI45vkyhO4Vk
	 umi58PSoBAoZx3r56tdjyTpCIT+NOxEJRMxKUpVre8Ty8fkGHrIEWztUn4jFlNR6IZ
	 pvJHZ+Ws5Gz/7JRCsZ78zN5z9lmNi7wknHiq137TlZDTFI7cNyngH9K+7UvHwuAdoP
	 bU0uHayQSD4jw==
Date: Thu, 17 Sep 2026 23:21:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: eblanc@baylibre.com, jneanne@baylibre.com, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] regulator: tps6594-regulator: Fix np_pmic_parent leak in
 tps6594_regulator_probe()
Message-ID: <9931609e-c74a-45b3-8dc9-ced30cc44d81@sirena.org.uk>
References: <20260917143155.2156974-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6N4ON8eRNOABAT6C"
Content-Disposition: inline
In-Reply-To: <20260917143155.2156974-1-vulab@iscas.ac.cn>
X-Cookie: Whip it, whip it good!


--6N4ON8eRNOABAT6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 02:31:55PM +0000, Wentao Liang wrote:
> tps6594_regulator_probe() takes a reference on the PMIC parent node
> with of_get_parent(), but never drops it, so the reference leaks on
> every loop iteration and on each error return of the probe.

This doesn't apply against current code, please check and resend.

--6N4ON8eRNOABAT6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsZ/YACgkQJNaLcl1U
h9Cl2Af/RWRfY6Grn0RvjuyGL6fTjLdWBtsBuIoGhW5aco9iZTCSYAWj6RqZQSDZ
IIIUBB85VI0FRjIsR2aNvAA4Q/zlUASUgOGdfXeNRrOfOiN7WDXOUk4BqZCbS5E9
EDsLfEyy4wSf62G33m4SowUNKbS1H1wNmz8G6Ioeq+PjBYkX6/6upzM7jtSbhzN/
opakFHGduiR/Qd+yPy+rjoJE08m7Crj6+32l6YIAwmo2Yy38uF79cQPrOJubU4dN
dT0yO1HhA9K4a0YjJ9Vvw9UwNHvBPpQlbzTIlXWRLFYDdj2FOKem6H7k7j3bLe7k
vR1/g9xF88GweyyFHUl6bba4rgJYVA==
=t3ZD
-----END PGP SIGNATURE-----

--6N4ON8eRNOABAT6C--
