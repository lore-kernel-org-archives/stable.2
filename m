Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C8F3A59A8;
	Mon, 14 Sep 2026 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789423556; cv=none; b=tMYETjjH5PMQ1rZ2jwno/YLf+g5XLpCcCL96Su+uxVua0NjX9AkZ66Fg9nf392e60M7pF0Atsd+h2gfHlog6+eVJXPIkf0LRTbXrTEnidveEwGILmhW817D8+UmnZedbT9Y2KksnmIWimKOTZaxCZ0PQoVViC4IGj/1sk8KVSgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789423556; c=relaxed/simple;
	bh=YHFgBNwlBuPlwY9TiBTmQDMECMDowJ+LRsmJZnVM6rU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SX5PT4V1HFHUEroCCT9ZAajep2kEv9eoM4OtdAZZGlP8PtZQ8pgPze2/DhIQN2fhyJ/gieGu9bR9hqyCL6uYhBd8z3cYGxHtBFRp9veg5lvFM56SSYIOQGP8j+F3iOR5YxZjFNez9ax/4bGKKjsTotXnEZ/nF7FA6QJvZGu1bqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev; spf=pass smtp.mailfrom=httpd.dev; dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b=pdNahPvt; arc=none smtp.client-ip=185.70.43.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=httpd.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b="pdNahPvt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=httpd.dev;
	s=protonmail3; t=1789423545; x=1789682745;
	bh=Rdh6BpsS2ZBxSHoCL6MTLR/CvIG3h3H+FjSL8fIoDu0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pdNahPvt2BB1arBQ5v4qpXo5bg0zP5s7HIn1+olJ5jwfSiSWVs5GqlWAMyBRC6W/+
	 Td5w7dSFUHAPGdGckpsobUvkUMd4YKYd8QimIqNnEnxJ5UnvPCCbILOi2zskv7bi7w
	 iQIOg9PdLQ+gJePd/ksOQct9pnGdxsXUkVRtuxtQF1bNVDLehfYhFwqX+o9j8q5DNH
	 9IsQs1c2iW320N8nrXGJ0uS2DlC3We8v0hvP6ZMPCI7PHruH6wvPEiVflf1x5WKEGz
	 jC98VmtX2VTSb4gE0k/0O0sS4EnL3/0XsZmG6Id4EebUCwLSwhPa3qH0U9XWIqsejy
	 9IQJ1Accj3XAw==
Date: Mon, 14 Sep 2026 22:05:42 +0000
To: Andrea della Porta <andrea.porta@suse.com>
From: Angel J <iamanaws@httpd.dev>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "helgaas@kernel.org" <helgaas@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid bridge configuration
Message-ID: <B6jXhRRiVu4TfgjwfVOLgxbh1xIciImKFVMmjkMRoDt5SO7WpM2M3gBqsjtnh3VhYobWdcNfqFrmlCdhqZBqUakSNkTeVNZYJnXLTx55kRI=@httpd.dev>
In-Reply-To: <aqfgUUkZYZg6ZABF@apocalypse>
References: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev> <cFJoUZ6c5g5YbFCrwUnx6RlitHRl-0cS2fadDSFJNf9SgLreKutrmZj1r56hFh8ZUAbzvuCqBG4w9ZYAE8xAWP9HnLwbjMOBzac-iMnMMZc=@httpd.dev> <aqfgUUkZYZg6ZABF@apocalypse>
Feedback-ID: 163474212:user:proton
X-Pm-Message-ID: 6d3df382b75293d9f22cbe8d8632a381269862fa
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------5cd21dd00fc3eadb7c45d7f6769116ebf5fbf2df01333f68e813fd9b368d6e9d"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5cd21dd00fc3eadb7c45d7f6769116ebf5fbf2df01333f68e813fd9b368d6e9d
Content-Type: multipart/mixed;boundary=---------------------857f455b86085cc7d31d35501c9f818e

-----------------------857f455b86085cc7d31d35501c9f818e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Andrea,

> Could you please test adding a quirk as PCI_FIXUP_HEADER
> in which you downgrade the class from 0604 to 0600 and see it works even=
 without
> your proposed check in of_pci_make_dev_node()?

I tested this on Linux 6.18.44 with CONFIG_PCI_DYNAMIC_OF_NODES=3Dy.
Changing only the class to 0600 still doesn't boot with both OF fixes
removed.

pci_is_bridge() checks the header type. I confirmed the class quirk runs
by restoring the v2 property checks, which lets it boot and log:

  class=3D060000 header=3D01 is_bridge=3D1

I then tried changing both the class to 0600 and the header type to 00.
That boots without either OF fix and logs:

  class=3D060000 header=3D00 is_bridge=3D0

These changes affect the kernel's cached values. The raw registers still
report class 0604 and header 01. With the header override, 00:00.0 no
longer gets an OF node; the other bridges still do.

The v2 patch also boots without any device quirk. It keeps the node for
00:00.0 and skips only bus-range and interrupt-map when there is no
subordinate bus.

Changing the header type as well made it boot here. I'll send the quirk
for 8086:4c43 with both changes. I'll also keep the check in
of_pci_make_dev_node() and add an error message before returning when a
bridge has no subordinate bus, as you suggested.

Thanks,
Angel J

-----------------------857f455b86085cc7d31d35501c9f818e--

--------5cd21dd00fc3eadb7c45d7f6769116ebf5fbf2df01333f68e813fd9b368d6e9d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmqob6kJEBoBbwppzUxnRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfLDBAjI4XUj8aqiPkUFeLTm6ZqIS0El3XJNZ97
RP41eRYhBEAFf9htFyVnqZzmVhoBbwppzUxnAABCLgEAqa3AkxdlMpgQTkAa
7MYv78X3W51xL2LSBaxL/BlExe0A/1HLZKvHUd+0sOEyXuzhzJNKlelqtmSA
a2fltJbpD6QP
=PK0d
-----END PGP SIGNATURE-----


--------5cd21dd00fc3eadb7c45d7f6769116ebf5fbf2df01333f68e813fd9b368d6e9d--

