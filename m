Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145044C67C;
	Mon, 14 Sep 2026 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388411; cv=none; b=d+wmJ5CHpepl2FYwnpZR/Cfow7cZ1syUNRC3cKPXR3jjTMefyTsxieSoNI1vsM2NNxvkg+hrNHe9GGOB9krChIajgwq6xcHaOWZkTHDCGTHVktluYa2QMSwawTR3YXoUdvt6ZvI7NBPXl+E/nlyrLKkBakt/4/aLabGmJ5DSosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388411; c=relaxed/simple;
	bh=1CAcEe4QlA211iDV5LFfJIyFyShs/f5TCZKA9xt3M0o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=X2+foasGcYJuBnZ0Vyn9H34g8/r3yNSRqFEqYkVkBL7nUkNIhg0i+/az+7xs1cj2tC+ox2Q+O3lhprs2k3HOZvJuS4wFaczzSRJmpoMWtgCNjby2iTD0l6ONj+0NC5hNKnDfyC1zUDFGKKnCN+phT9bQgrapwdxzYgaTfOv6SOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLXfkuCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLXfkuCE"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 698991F000FF;
	Mon, 14 Sep 2026 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789388409;
	bh=1CAcEe4QlA211iDV5LFfJIyFyShs/f5TCZKA9xt3M0o=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=VLXfkuCEinZaQfoaqE5dFpScu2TKPiyMQLw6ODNLYWmybVY6ggTF/6q6nD9HqrIEy
	 5IsvNkmS/WUqRRPWqZLoNN5h34CTM/K2VkiuUePNNMWEolYiZc4naAyPzEfe6Q9DUJ
	 Vi6JSuvpwByxoD4ETwnSo/zpz+Wh+GzbVuRZ0CGd4m/SpI98XG+aya7J9+B/WdL/59
	 AgIRovN6a5M8cgwCUfCMcyuVkW++zwA7XxJDw+fjwWYp3s9qtc5aoxr5cupcOiUtCc
	 OG4pNozHXODhDZ9+ECIpAlMEYe+WsAh4zu+of6RhSEsYKDDUmJVR9qJTWJHdInbcjO
	 vPWeGvPkNGUtw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=3c7626485cbfcfdc5d1f2f4e0724e820fdbe28a207f265f06e8767126a80;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 14 Sep 2026 14:20:05 +0200
Message-Id: <DLF191CC4QMM.1SNYEHUFJ9GK2@kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: spi-nor: fix the lock left held by
 spi_nor_rww_start_exclusive()
Cc: <pratyush@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <vigneshr@ti.com>, <richard@nod.at>,
 <takahiro.kuwano@infineon.com>, <stable@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Itai Handler"
 <itai.handler@gmail.com>
X-Mailer: aerc 0.20.0
References: <20260914081149.1916589-1-itai.handler@gmail.com>
 <20260914081149.1916589-2-itai.handler@gmail.com>
 <87ld94owzj.fsf@bootlin.com>
In-Reply-To: <87ld94owzj.fsf@bootlin.com>

--3c7626485cbfcfdc5d1f2f4e0724e820fdbe28a207f265f06e8767126a80
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

> Michael, since we already got a cycle with AI walls of text just to tell
> "fix that damn conversion", can I (or you) apply that other patch, so we
> can get rid of these? Let me know what you prefer, although I don't
> remember where that thread is.

It's already in spi-nor/next since last friday.

https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/log/?h=3Dspi-=
nor/next
https://lore.kernel.org/linux-mtd/178913311701.1915651.4791624215787396187.=
b4-ty@b4/T/#me3b51a242469a4d9722089e18547e87fdc65d7c9

-michael

--3c7626485cbfcfdc5d1f2f4e0724e820fdbe28a207f265f06e8767126a80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaqfmdhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/h+rQGA21WADlbJRzTdcUtVgkfLn13FsZlH9fAL
mL3YyjGxWm8otE5+lAWk9UiwKbbDR2RkAX96KFwcbgZlq2jUCk0r/ZX1/9uZhwHP
n4v0jC/6LgaWS1IDGhs8UpbKkMQ/AmbCLjg=
=KUGi
-----END PGP SIGNATURE-----

--3c7626485cbfcfdc5d1f2f4e0724e820fdbe28a207f265f06e8767126a80--
