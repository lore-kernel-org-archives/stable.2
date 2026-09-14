Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD82BEFE8;
	Mon, 14 Sep 2026 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428535; cv=none; b=mO8LalUHGKN6tc8imHk9jYqhbqyvs3LIcec9HyCzlEp/WF0byubhifcl87gErR9mlXC3qbpC5sgFc0R/aoIT0tq0y0Wurt386mrZs26jn9zDYBzi79ArL8wAujRIwkpaULADDWxGvHh40gPnrwVOAANHmpwh750xlzZujf+MRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428535; c=relaxed/simple;
	bh=so6+kpWSPAr+SaQAzS8bXa6DUJTn4TrJn7YN0EqL8rI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+1KcUP+m9fqNYriBy7m68XkMM6KkQhbK8ILqFhkI1YjsfiHTnFjrjkq11SeAyOtuG524lmyPx5G6L08Iy14kl26IJadA4DYTmXuDP85xId5qLpV74KvwGTgnlhf+qYk90YduS9HZMIvZ89NLImm4viuAaKL8OX0WrV1pUAGERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev; spf=pass smtp.mailfrom=httpd.dev; dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b=m262tNUn; arc=none smtp.client-ip=185.70.43.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=httpd.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b="m262tNUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=httpd.dev;
	s=protonmail3; t=1789428529; x=1789687729;
	bh=yxoj++wFvVAwzImdOHquYq/PvmSP6Nwb1m+Fxi9E1PA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=m262tNUn0qggQ6BzAr6L7CTMNd/qcn7PFIcSzWLEgQf6UWVQ5Rwi8wcNhMUddA0GJ
	 o21obADMQC6PjFbfGNy/Qt1MxIz+0r0lUCjX5jC+NA2f+ddY9vkdxqPNatH4e07E9T
	 UMDRj73N6reiM7ZmItw/MudS9bYjLfug+QW/i2oCRD4KGN5WUUkKs6I8Xg87j07s9F
	 P3VkZgItjLu9PdklKh035FJBOMK94QTqbEtPmUfCGnEP+jgTEFDZxT1Q2AcJ0HNdWN
	 hF4LeDW+lXOxWIWiEPJ46bhiT1DMdUOSLb1oMno7/fx7O/j1VX64JA3vkO8dKxZL/Y
	 Y6zybbh5jNVrA==
Date: Mon, 14 Sep 2026 23:28:45 +0000
To: Andrea della Porta <andrea.porta@suse.com>
From: Angel J <iamanaws@httpd.dev>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "helgaas@kernel.org" <helgaas@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid bridge configuration
Message-ID: <VaPKN3QbW3sGj8wePAvI_xD3twp_MQE4-4xeSbvgoQPVUnKDWKz0EWT_JiLehpmc6WOsCAoFOPs412Xhtthes_ZtvrgsKB4QB6QPz-XvRb4=@httpd.dev>
In-Reply-To: <B6jXhRRiVu4TfgjwfVOLgxbh1xIciImKFVMmjkMRoDt5SO7WpM2M3gBqsjtnh3VhYobWdcNfqFrmlCdhqZBqUakSNkTeVNZYJnXLTx55kRI=@httpd.dev>
References: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev> <cFJoUZ6c5g5YbFCrwUnx6RlitHRl-0cS2fadDSFJNf9SgLreKutrmZj1r56hFh8ZUAbzvuCqBG4w9ZYAE8xAWP9HnLwbjMOBzac-iMnMMZc=@httpd.dev> <aqfgUUkZYZg6ZABF@apocalypse> <B6jXhRRiVu4TfgjwfVOLgxbh1xIciImKFVMmjkMRoDt5SO7WpM2M3gBqsjtnh3VhYobWdcNfqFrmlCdhqZBqUakSNkTeVNZYJnXLTx55kRI=@httpd.dev>
Feedback-ID: 163474212:user:proton
X-Pm-Message-ID: d2ba4b13e36e34d8135a55ca2599efddc5d2a885
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------19abcaf36a79a582b2fcee0af394648d3ca185f375b08afc4f8b0c2cc5776182"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------19abcaf36a79a582b2fcee0af394648d3ca185f375b08afc4f8b0c2cc5776182
Content-Type: multipart/mixed;boundary=---------------------7de5e8224e3f8cd20eea8e5ae1dd0491

-----------------------7de5e8224e3f8cd20eea8e5ae1dd0491
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Ok, here it is...

I tested this quirk on Linux 6.18.44 with CONFIG_PCI_DYNAMIC_OF_NODES=3Dy,
and it boots without either OF fix. The diff below omits the test logging.

PCI_FIXUP_HEADER runs after the resources have been parsed using the
original header type, and changing hdr_type also affects configuration
restore. I don't know enough about this part of PCI to judge whether
that's safe, so I'll wait for your advice before submitting it as a patch.

Thanks,
Angel J

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda..57df88a38 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -291,6 +291,22 @@ static int __init pci_apply_final_quirks(void)
 }
 fs_initcall_sync(pci_apply_final_quirks);
 =


+/*
+ * On the Dell XPS 8940, 8086:4c43 reports a PCI-to-PCI bridge but has no
+ * downstream bus. Use host-bridge class and a normal header so that
+ * pci_is_bridge() does not send it through bridge scanning.
+ */
+static void quirk_intel_4c43_host_bridge(struct pci_dev *dev)
+{
+	if ((dev->class >> 8) !=3D PCI_CLASS_BRIDGE_PCI ||
+	    dev->hdr_type !=3D PCI_HEADER_TYPE_BRIDGE)
+		return;
+
+	dev->class =3D (PCI_CLASS_BRIDGE_HOST << 8) | (dev->class & 0xff);
+	dev->hdr_type =3D PCI_HEADER_TYPE_NORMAL;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x4c43, quirk_intel_4c43_ho=
st_bridge);
+
 /*
  * Decoding should be disabled for a PCI device during BAR sizing to avoi=
d
  * conflict. But doing so may cause problems on host bridge and perhaps o=
ther

-----------------------7de5e8224e3f8cd20eea8e5ae1dd0491--

--------19abcaf36a79a582b2fcee0af394648d3ca185f375b08afc4f8b0c2cc5776182
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmqogx0JEBoBbwppzUxnRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmes3p/1OSpN6LMhObrgEYZy+8qMUO+52BFBVbvV
KvCQQRYhBEAFf9htFyVnqZzmVhoBbwppzUxnAACY0wD/SFb48faYSk4S81Rn
a+nMZZ6WbytcUHJBks8/2VhxtfcA/jdk2n5GJvzeuyWgZAPW5fl9UDEyWQuO
Mti2YQDwnA4D
=zn2q
-----END PGP SIGNATURE-----


--------19abcaf36a79a582b2fcee0af394648d3ca185f375b08afc4f8b0c2cc5776182--

