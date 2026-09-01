Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2B30B521;
	Tue,  1 Sep 2026 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224375; cv=none; b=RP2o9G0XDHabd3H4OnHVdZCOfFQPEILzDqn1TX01XFX+ES91WjtmVx+edFLpVtikso7nHtc2YYQCx1/Zo9wKhI1e+gII7ohjYvgoeDqwraWg0p3cQV/OR12IYeFlvAsF+O7AakWWjZ58YMjRZi5hGw/dyDbce8y/7hd5D8Tghz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224375; c=relaxed/simple;
	bh=+3rpXvdizBAasQQCZSs50TByA2/x7dRZogapzcQCMRw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C1J8HmVoEce3Ml3rAq7R9IMeS5U/k//8V96ran3ZszlnUwsxuqm/Axo1IK741NMr1cc6lwvpW2JCfrsdKLnjIpbRXCkFY1GB13F2BUQawxD8Ml2xXxP8Jmb6p4YfspblgXXOcu5LC1mdDkOqbsTrhwbTN1ufy29EpjKJZAvCj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev; spf=pass smtp.mailfrom=httpd.dev; dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b=eyZ4rKrU; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=httpd.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b="eyZ4rKrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=httpd.dev;
	s=protonmail2; t=1788224369; x=1788483569;
	bh=dsiMiEDU1iyqNugGv5MENp6q2JX/4otwgNxyz/lzYSA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eyZ4rKrUt95gUpqH2GtBgTuAWyqVXqdFv6BWKJVHnaaw6BIc8ukN/w1d1m14h6uZb
	 qRS1Ke6znhKhp66XqY/aZrkg1DyrpD/KHYNEwHozBhwky6FNjNkne5rkitYKNgfZZ4
	 mnC1TGoJdO+gRCi93bp4ZYbkRHmFEkv4Ivcfqmm0XbJZjv/h+XYcTIlJYMAIBdg6Pq
	 Y/902OM5RIUUg/VrrtggZph4h/Wes50V6/DeV5QuRYV4AhlUSacZC9a8jlROgXKn5c
	 SOSqbHBnolmCUnfC6IewVLdYdkJRL9PcRE6A8L1MZCVmTLSSh8TSOkInuYcVJtV/Kv
	 FSmCuPhbYMutw==
Date: Tue, 01 Sep 2026 00:59:25 +0000
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Angel J <iamanaws@httpd.dev>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "helgaas@kernel.org" <helgaas@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "andrea.porta@suse.com" <andrea.porta@suse.com>, "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid bridge configuration
Message-ID: <-KoxZtWNyNmnEu6-RkoMW2kenooTum0AiXwENwNBtoxqyI9wDXo1UJik1Wn9Igj_VRQ9bcYlva6FUZYq17UdPChUz_-mtDyrHSFO7t_broI=@httpd.dev>
In-Reply-To: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>
References: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>
Feedback-ID: 163474212:user:proton
X-Pm-Message-ID: 1031240fee8ce565906bd8ac4c0dbb2408b2550f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------92b2098d95252a39ada38c9e88383d14dd60f1ac3fa7fee7e6a674a7c834e248"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------92b2098d95252a39ada38c9e88383d14dd60f1ac3fa7fee7e6a674a7c834e248
Content-Type: multipart/mixed;boundary=---------------------9fc1428e6ff9ebac9729a5244b051e32

-----------------------9fc1428e6ff9ebac9729a5244b051e32
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hello,

A friendly ping on this regression. It still affects Linux 6.18, and
the tested invalid-bridge guard allows the machine to boot with
CONFIG_PCI_DYNAMIC_OF_NODES=3Dy.

Is any additional information or testing needed from me?

Thanks,
Angel



On Saturday, August 22nd, 2026 at 19:14, Angel J <iamanaws@httpd.dev> wrot=
e:

> Hello,
> =


> This regression was introduced in v6.17-rc1 and remains in the dynamic
> PCI OF node code. Linux 6.18 fails very early during boot on my Dell XPS
> 8940 when CONFIG_PCI_DYNAMIC_OF_NODES=3Dy. The display goes black before
> any useful console or pstore output appears, and the machine remains
> hung.
> =


> Disabling CONFIG_PCI_DYNAMIC_OF_NODES makes the same kernel boot normall=
y.
> Linux v6.19-rc5 also boots because the RP1 driver stopped selecting that
> option, not because the dynamic PCI OF node code changed.
> =


> Hardware:
> =


>   System: Dell XPS 8940, board 0K3CM7, BIOS 2.27.1 (2025-04-03)
>   CPU: Intel Core i7-11700 (Rocket Lake)
>   Triggering device: 0000:00:00.0, Intel 8086:4c43
>   Firmware boot: UEFI, ACPI-based x86_64
> =


> Test results:
> =


>   Linux 6.12.103: good
>   Linux v6.17-rc1: bad
>   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=3Dy: bad
>   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=3Dn: good
>   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=3Dy, skip invalid bridge: g=
ood
>   Linux v6.19-rc4: bad
>   Linux v6.19-rc5: good
>   Linux 4621c338d33f: bad
>   Linux e55feea3a03a: good
> =


> The first-parent boundary between the last two tests is:
> =


>   e55feea3a03a ("Merge tag 'soc-fixes-6.19' ...")
> =


> That merge contains ce26f588c831 ("misc: rp1: drop overlay support"), wh=
ich
> removes:
> =


>   select PCI_DYNAMIC_OF_NODES
> =


> from MISC_RP1. The generated configurations differed only by:
> =


>   -CONFIG_PCI_DYNAMIC_OF_NODES=3Dy
>   +# CONFIG_PCI_DYNAMIC_OF_NODES is not set
> =


> CONFIG_MISC_RP1=3Dm in both. The known-bad 4621c338d33f and Linux 6.18.4=
4
> both boot after disabling PCI_DYNAMIC_OF_NODES (and MISC_RP1, whose Kcon=
fig
> select otherwise forces it on).
> =


> There is no RP1 device in this machine, and its driver does not probe.
> MISC_RP1 affects this x86 system only because its Kconfig select enables
> PCI_DYNAMIC_OF_NODES globally.
> =


> I narrowed the hang to dynamic OF node creation for 0000:00:00.0
> (8086:4c43), the Intel Rocket Lake-S integrated memory controller. On
> this machine it reports PCI class 0604 and header type 1, but it is boun=
d
> to icl_uncore and is not a usable forwarding bridge:
> =


>   Bus: primary=3Dff, secondary=3Dff, subordinate=3Dff
>   I/O and memory bridge windows: invalid/all ones
>   kernel: bridge configuration invalid ([bus ff-ff]), reconfiguring
> =


> A minimal dynamic node for this device boots. Adding only
> device_type=3D"pci" makes it hang. Full PCI dynamic OF node generation a=
lso
> boots when only 0000:00:00.0 is skipped.
> =


> I also tested a generic guard in of_pci_make_dev_node(). It reads
> PCI_PRIMARY_BUS and skips node creation if the primary bus does not matc=
h
> pdev->bus->number, the secondary bus is not greater than the primary bus=
,
> or the secondary bus is greater than the subordinate bus. Linux 6.18.44
> boots with CONFIG_PCI_DYNAMIC_OF_NODES=3Dy and logs:
> =


>   pci 0000:00:00.0: skipping dynamic OF node for invalid bridge
> =


> The regression was introduced by 49d63971f963 in v6.17-rc1. Commit
> ce26f588c831 made v6.19-rc5 boot by removing MISC_RP1's select of
> PCI_DYNAMIC_OF_NODES. That avoids the failing path in the tested
> configuration but does not change of_pci_make_dev_node().
> =


> I do not have a log from the failed boots. No output appeared with
> earlyprintk=3Defi,keep, keep_bootcon, ignore_loglevel, loglevel=3D8,
> initcall_debug, and EFI pstore enabled. Blacklisting both GPU drivers an=
d
> disabling the Intel IOMMU did not make the bad kernel boot.
> =


> Should of_pci_make_dev_node() reject devices with invalid bridge bus
> configuration, or should 8086:4c43 use a device-specific quirk? I can
> prepare and test a patch for either approach. For Linux 6.18 stable,
> would that fix be preferable to backporting ce26f588c831 and its
> dependencies?
> =


> #regzbot introduced: 49d63971f963
> #regzbot title: PCI_DYNAMIC_OF_NODES early boot hang on ACPI x86
> =


> Thanks,
> Angel J
> =


> =


> =


> =


> =


> =


-----------------------9fc1428e6ff9ebac9729a5244b051e32--

--------92b2098d95252a39ada38c9e88383d14dd60f1ac3fa7fee7e6a674a7c834e248
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqWI18JEBoBbwppzUxnRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfl/6uNekZTiSEcr0zFYMmZB7pZXzWkFaFAVYQ1
zRRp2xYhBEAFf9htFyVnqZzmVhoBbwppzUxnAAAzOwD9FRMnq+YbDgEDUc3n
pVpEge+RLMOPpjo9taK9Dno8I+gA/0J3r7cKUxlGLsTjReprBRnyMa4sDEjT
KBCLgZOvyacC
=k1eP
-----END PGP SIGNATURE-----


--------92b2098d95252a39ada38c9e88383d14dd60f1ac3fa7fee7e6a674a7c834e248--

