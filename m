Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0914E430F;
	Thu,  8 Oct 2026 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.13.27.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474589; cv=none; b=fBxS8fK9XWa0ccxt6TkiFDXhsOGiGwH/ATmwsn3hVcHKxig45SOTO5kUmcJrLG5d6gUhvxr8pRqYufhvy1g9GnCvW2zDbGqYCY+RkyOH9iGojOfF+oKT/4GrIx88Gl6hNvIKx3M/TcOLEmOk+Lv4qJkU2WKblTr2He75sXD+e8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474589; c=relaxed/simple;
	bh=3BRRsyRn7l0PCM/cWR1V3gLoh9yQ6IkWyov5FasnGmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=N4ewbC/7XE2wImprNUlczD9jiKFE9kWNHgK3zYQ7Cz3JW9r4L+NDoUIKrmlQcmP8+XPlg1xixoJNlNPN5xgIFjySTZyWWcpXgO2+Rg+IPfVLrxrome2BVX4QjOTpCu/1JmFpjWQgHLmLqn7nBf48yIEiDbISOz/qrMeRF2qbQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it; spf=pass smtp.mailfrom=kcore.it; dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b=IDls/YM2; arc=none smtp.client-ip=49.13.27.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kcore.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b="IDls/YM2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
	s=spark; h=References:In-Reply-To:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date;
	bh=3BRRsyRn7l0PCM/cWR1V3gLoh9yQ6IkWyov5FasnGmw=; b=IDls/YM212Z7/V4xq29RRZiA2A
	W3/kqTtikMf/FdFvT2VaWEO2YtexOjHnEHLd5B+6NTkIK1hVT2WemWB2vy+e8m/1CEnZklw8UNA9j
	PTSZUWHAT9PtOo0f3tbIpYs83pqAEuGIuvI5snW0L2+qdps0EFZlRQAAdLRJgy89o09A=;
Received: from mnencia by spark.kcore.it with local (Exim 4.100.1)
	(envelope-from <mnencia@kcore.it>)
	id 1xEq7z-000000004Q9-1ssV;
	Thu, 08 Oct 2026 17:33:51 +0200
Date: Thu, 8 Oct 2026 17:33:51 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: praveenpuglia@gmail.com
Cc: miguel.vadillo@intel.com, mchehab@kernel.org,
	sakari.ailus@linux.intel.com, mehdi.djait@linux.intel.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: cvs: Leave the privacy LED to firmware on
 Synaptics SVP7xxx
Message-ID: <ase33z4RBKKPCkq0@spark.kcore.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-cvs-privacy-led-v1-1-b78d5c512cba@gmail.com>
References: <20261008-cvs-privacy-led-v1-1-b78d5c512cba@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Tested-by: Marco Nenciarini <mnencia@kcore.it>

Tested on a Dell Pro Max 16 Premium (MA16250) with Debian v7.2.6. I
built intel_cvs.ko with this one-line change applied and have run it
for 3 days. The kernel log shows quirks 0x3a, the privacy LED turns
on while streaming, and the stream is unaffected.
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEfCO4BD5l0pgKIbbiWJ8D8BulUDgFAmrHt88ACgkQWJ8D8Bul
UDiC3A//ThtRB5yWW3wiRv8hbttq6zZOleyfqhf++uT8qgLMAFgDtWPCrc05CrzI
DGroF+1zEQtfZIVW5hjy6/K7j2gUDrEA+lR1EMMiyt0xaMgdUyFWdGx5fAhcHwgZ
GRTcnkMoQOuRxg1FJ/w54wvj81lheoAPDOtjVjvmzf7F/16I1NQdJdd8Y8oOczQ9
n/o7BNpfnwNmXZPHQ8wsdX+dC694htZd/3gkjU8VnPcUaxb9WCQTFkewCwZbnvgq
h3aVKGd5Q53yN4EW3Wf4j6ITxxOxcaIEwYOqXpC+WgC6XJIj4wHDS8R6DDC+9JR5
7NWRcTFx91BL6iAWW+rinjpUoBDcIrUd2BC08H0J90UvPQcMJris5ygeK+e6HYig
8Us15j2EZNZMNSj6DnsKcmdCU3wG5j/YU6lanONHuUxWZxgqflkrthEJpE2glWcC
q+K1TNGMSIONGnYOp/1E6sR1UeaCEUXwNHjeugk1xepDlHltCkiKMyQ0Xkm5JGkb
NXie+fGUkY7mpCa0AC4ja60bh/vtCZRS/glvzdXH2tZNMeYin/0Ng3mAdasK8tV4
PCYqb/s+7Qkw8FvRnrB9UR7rYFirzCP8PeUSQUqk74LLjgWa31gqeeZkoLnJS2Eq
O9cioaU5Pq9u1DBk9vnVh//cD/pBz9OFN48NHcOCzGYQeZmIE7M=
=YAvp
-----END PGP SIGNATURE-----
