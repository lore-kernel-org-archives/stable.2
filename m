Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD313377AB6;
	Sun, 23 Aug 2026 02:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787451283; cv=none; b=dGooxWpkjFC3PR1ScwEamyNvDxPms26Vxb3A8ERubA7VYD6Kf4xYR/WMlc2kQvh+ftvNRdTy/pNCV+kxNPlIFkojcoafXn5IMW03BO51ZwgTu6h+cdrO1LKO59K7e/U6IH1x/7XqJAoSkOrXN8u/rpozv0D0v4yNq8LSAYWMwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787451283; c=relaxed/simple;
	bh=DRkxTvZbI1EJfie9pxFcCEipG+No0t5u6lL906w7lu8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=siW3v6mSD5KkgFRDpk9VGAmKc+s6aM9PI2Bmr8rDICjPBuXcO+qL43xZatOZcjYsVS4HUohjmSnMS3t/n5qZnAhpuJfaE4cYXN3r8VlOJujLg/C9R/c+jbvMlyHlrK3Z/CEwIAB8FZSkHxfvxa595D5/w6UVm5sH7DPdHm8jjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev; spf=pass smtp.mailfrom=httpd.dev; dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b=DvDdywB4; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=httpd.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b="DvDdywB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=httpd.dev;
	s=protonmail2; t=1787451271; x=1787710471;
	bh=4J6bCxPshWp7f3qp56C2WcD7YMKy40HDmmnsQrLHimM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DvDdywB4rI3wC3O16hurybpVl9ACdYtsRKa6vbDts9EngNAE7yR8SfsuCgQycby+7
	 UObVznkDmM+gf4zhbvilw5lRAh1KVnUHzwF02iH6MACFV7kTriL6G/bFHerS4/X4oC
	 eRJyBc0ZaL7vAwrNprs2gXnYKr//jp6WkVHlxkQaCVLClGNAZ2HsFanCNcTFweo3ZB
	 OY8LlpTrzlKAXwjKblVBRg0gqABoqA3T9kdVCpWp32bac0FE/rujrSJE/k0r0S6cwf
	 JEQ4VLIo1R5qcBMSkKMoHKgQxOTPvOnNb2Vjq4QADzGlgxnmCOWuWN2Q0ZtOl2u1Kp
	 la+guzjMT6fkA==
Date: Sun, 23 Aug 2026 02:14:25 +0000
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Angel J <iamanaws@httpd.dev>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "helgaas@kernel.org" <helgaas@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "andrea.porta@suse.com" <andrea.porta@suse.com>, "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid bridge configuration
Message-ID: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>
Feedback-ID: 163474212:user:proton
X-Pm-Message-ID: 31142567ec075a3e2598ab04adff317de0e77832
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------0ef466dcdb1e40e51586a73753b73daa3d57415976dd54a41ab1ba279b082e9e"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------0ef466dcdb1e40e51586a73753b73daa3d57415976dd54a41ab1ba279b082e9e
Content-Type: multipart/mixed;boundary=---------------------5816d7253a565b3528da584c08321c23

-----------------------5816d7253a565b3528da584c08321c23
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello,

This regression was introduced in v6.17-rc1 and remains in the dynamic
PCI OF node code. Linux 6.18 fails very early during boot on my Dell XPS
8940 when CONFIG_PCI_DYNAMIC_OF_NODES=3Dy. The display goes black before
any useful console or pstore output appears, and the machine remains
hung.

Disabling CONFIG_PCI_DYNAMIC_OF_NODES makes the same kernel boot normally.
Linux v6.19-rc5 also boots because the RP1 driver stopped selecting that
option, not because the dynamic PCI OF node code changed.

Hardware:

  System: Dell XPS 8940, board 0K3CM7, BIOS 2.27.1 (2025-04-03)
  CPU: Intel Core i7-11700 (Rocket Lake)
  Triggering device: 0000:00:00.0, Intel 8086:4c43
  Firmware boot: UEFI, ACPI-based x86_64

Test results:

  Linux 6.12.103: good
  Linux v6.17-rc1: bad
  Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=3Dy: bad
  Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=3Dn: good
  Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=3Dy, skip invalid bridge: goo=
d
  Linux v6.19-rc4: bad
  Linux v6.19-rc5: good
  Linux 4621c338d33f: bad
  Linux e55feea3a03a: good

The first-parent boundary between the last two tests is:

  e55feea3a03a ("Merge tag 'soc-fixes-6.19' ...")

That merge contains ce26f588c831 ("misc: rp1: drop overlay support"), whic=
h
removes:

  select PCI_DYNAMIC_OF_NODES

from MISC_RP1. The generated configurations differed only by:

  -CONFIG_PCI_DYNAMIC_OF_NODES=3Dy
  +# CONFIG_PCI_DYNAMIC_OF_NODES is not set

CONFIG_MISC_RP1=3Dm in both. The known-bad 4621c338d33f and Linux 6.18.44
both boot after disabling PCI_DYNAMIC_OF_NODES (and MISC_RP1, whose Kconfi=
g
select otherwise forces it on).

There is no RP1 device in this machine, and its driver does not probe.
MISC_RP1 affects this x86 system only because its Kconfig select enables
PCI_DYNAMIC_OF_NODES globally.

I narrowed the hang to dynamic OF node creation for 0000:00:00.0
(8086:4c43), the Intel Rocket Lake-S integrated memory controller. On
this machine it reports PCI class 0604 and header type 1, but it is bound
to icl_uncore and is not a usable forwarding bridge:

  Bus: primary=3Dff, secondary=3Dff, subordinate=3Dff
  I/O and memory bridge windows: invalid/all ones
  kernel: bridge configuration invalid ([bus ff-ff]), reconfiguring

A minimal dynamic node for this device boots. Adding only
device_type=3D"pci" makes it hang. Full PCI dynamic OF node generation als=
o
boots when only 0000:00:00.0 is skipped.

I also tested a generic guard in of_pci_make_dev_node(). It reads
PCI_PRIMARY_BUS and skips node creation if the primary bus does not match
pdev->bus->number, the secondary bus is not greater than the primary bus,
or the secondary bus is greater than the subordinate bus. Linux 6.18.44
boots with CONFIG_PCI_DYNAMIC_OF_NODES=3Dy and logs:

  pci 0000:00:00.0: skipping dynamic OF node for invalid bridge

The regression was introduced by 49d63971f963 in v6.17-rc1. Commit
ce26f588c831 made v6.19-rc5 boot by removing MISC_RP1's select of
PCI_DYNAMIC_OF_NODES. That avoids the failing path in the tested
configuration but does not change of_pci_make_dev_node().

I do not have a log from the failed boots. No output appeared with
earlyprintk=3Defi,keep, keep_bootcon, ignore_loglevel, loglevel=3D8,
initcall_debug, and EFI pstore enabled. Blacklisting both GPU drivers and
disabling the Intel IOMMU did not make the bad kernel boot.

Should of_pci_make_dev_node() reject devices with invalid bridge bus
configuration, or should 8086:4c43 use a device-specific quirk? I can
prepare and test a patch for either approach. For Linux 6.18 stable,
would that fix be preferable to backporting ce26f588c831 and its
dependencies?

#regzbot introduced: 49d63971f963
#regzbot title: PCI_DYNAMIC_OF_NODES early boot hang on ACPI x86

Thanks,
Angel J






-----------------------5816d7253a565b3528da584c08321c23--

--------0ef466dcdb1e40e51586a73753b73daa3d57415976dd54a41ab1ba279b082e9e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqKV28JEBoBbwppzUxnRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdLuaAoGKL92QTzbI2Uy7jw4k6tIc99AdBp6S6r
YQoA3BYhBEAFf9htFyVnqZzmVhoBbwppzUxnAADIqQD/fnLk8GJzel74P3PZ
NqUm7u5JPB8p1goB/ebqiGCVVakA/jt6U8pQNghHs/SsdfY/fVJqNl9WXIEV
5zaRuPsjk5cK
=Lb99
-----END PGP SIGNATURE-----


--------0ef466dcdb1e40e51586a73753b73daa3d57415976dd54a41ab1ba279b082e9e--

