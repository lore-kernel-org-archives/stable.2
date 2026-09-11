Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [37.187.220.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03F22D4DC;
	Fri, 11 Sep 2026 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.220.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167723; cv=none; b=nRK1LJSzMGU7oOZzCuc87c7deXMpV0b8nVK5hLjXxxiulnFcViLMK/WGIpwxyaglEft2urad61nczVbyi8bqHVc5CosGZoidrQ9jLyQnf/+v+v+lAwRO0Wh8UZHBR5/ttVdyWhk7+mUuww0ia4p/6/gzibPUmCfehxDuWagoebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167723; c=relaxed/simple;
	bh=GDWpdlWBvWQt3dhuKeKibH1Tjl0SGYwcHArgbQuxBAs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2oYnPQHEt99FL+kE2V6AVbyk5MJSfGcAzxEtNQwmGRw+GLrOsT9ejK9+WQBNy1y/SgQb/eEA6As4MaykQkGcPpWJ8OYnEzASF1pgkBM75WftZRIfrzDDGsNwwCO5vJcumMWlWYTyiQB183CQfaQs4uJEvIYcJiFd+Eu/fxYMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev; spf=pass smtp.mailfrom=httpd.dev; dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b=r/1NWGdP; arc=none smtp.client-ip=37.187.220.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=httpd.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=httpd.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=httpd.dev header.i=@httpd.dev header.b="r/1NWGdP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=httpd.dev;
	s=protonmail3; t=1789167701; x=1789426901;
	bh=svNifJx/ssGLp8arNI7ZY0FJrahK16lXJGPKGD+vP4w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=r/1NWGdPchEZbBl26e4NC9V6mD2SZDu0PFIJ9f+Aah6f0Mgt5PMT+8uMniIdkI5Td
	 +hEOdsLGiP1pODfTr4CMXGObRDzb/zMcc9cNSQaYf6afWhHsV/R6/tooGJ6/HARNTP
	 l+KQMlqUAaCz2Yc/b3YtHfacM34jMgvUcCCM3R1z+u5zr9QXcm2+vR+aJ8kRDQunAJ
	 DEZdu+rdPTceCxW10Qi/wx7cKo4V0vrPvC8Qu+XqbOVxQQWxKb2pgWsPjEU605GqfW
	 Jw6if3Z+G8Z2XWk0AnF7nG+ok/JcTzAtSBaSBoJt0uXHZvXImVTPbztF5tV0W3+bYy
	 3rHknZxRCgbkA==
Date: Fri, 11 Sep 2026 23:01:38 +0000
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Angel J <iamanaws@httpd.dev>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>, "helgaas@kernel.org" <helgaas@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "andrea.porta@suse.com" <andrea.porta@suse.com>, "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid bridge configuration
Message-ID: <cFJoUZ6c5g5YbFCrwUnx6RlitHRl-0cS2fadDSFJNf9SgLreKutrmZj1r56hFh8ZUAbzvuCqBG4w9ZYAE8xAWP9HnLwbjMOBzac-iMnMMZc=@httpd.dev>
In-Reply-To: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>
References: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>
Feedback-ID: 163474212:user:proton
X-Pm-Message-ID: a0b45507d5eac067fa00aa047aa0fedcad9d25b7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------584d05c12d919d8b9959a7be2db6ff9738f85cff09fbdb5a0c245caa7bd7149b"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------584d05c12d919d8b9959a7be2db6ff9738f85cff09fbdb5a0c245caa7bd7149b
Content-Type: multipart/mixed;boundary=---------------------5847a96ded5969a4c792075b9c3489f2

-----------------------5847a96ded5969a4c792075b9c3489f2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Andrea, Herv=C3=A9, Bjorn, Thorsten,

Thanks for the guidance, it was very useful. I went back through the tests
and got some more insight into the hang.

Andrea wrote:
> Angel, could you please provide the following output:
>
> lspci -nn
> setpci -s 00:00.0 HEADER_TYPE
>
> from a running (i.e. with CONFIG_PCI_DYNAMIC_OF_NODES=3Dn) system?

On Linux 6.12.109, with CONFIG_PCI_DYNAMIC_OF_NODES disabled, the relevant
output is:

  $ lspci -nn
  00:00.0 PCI bridge [0604]: Intel Corporation Device [8086:4c43] (rev 01)

  $ setpci -s 00:00.0 HEADER_TYPE
  01

  $ setpci -s 00:00.0 PRIMARY_BUS SECONDARY_BUS SUBORDINATE_BUS
  ff
  ff
  ff

The device is bound to icl_uncore. I get the same values on the patched
kernel with CONFIG_PCI_DYNAMIC_OF_NODES=3Dy.

Herv=C3=A9 wrote:
> Is this PCI logs reported with PCI_DYNAMIC_OF_NODES=3Dy or PCI_DYNAMIC_O=
F_NODES=3Dn
> or always whatever the PCI_DYNAMIC_OF_NODES Kconfig value ?

The messages appear on successful boots with either setting:

  pci 0000:00:00.0: [8086:4c43] type 01 class 0x060400 conventional PCI br=
idge
  pci 0000:00:00.0: bridge configuration invalid ([bus ff-ff]), reconfigur=
ing

I confirmed this on 6.12.107 with the option disabled and 6.12.108 with it
enabled. They also appear on the patched 6.18.44 kernel.

Bjorn wrote:
> I don't think 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
> is a likely culprit by itself because there's just nothing there that
> looks like it would relate to a Dell XPS 8940.

That change exposed the problem by enabling PCI_DYNAMIC_OF_NODES in my
configuration. I bisected again with the option enabled throughout and
found an earlier boundary:

  3dc8adeeefa0  PCI: of_property: Constify parameter in of_pci_get_addr_fl=
ags()
  1f340724419e  PCI: of: Create device tree PCI host bridge node

The first is the direct parent of the second. I boot-tested both without
any guard, changing only the source commit; their generated kernel
configurations are identical.

All of these tests have CONFIG_PCI_DYNAMIC_OF_NODES=3Dy:

  Source         Change             Result
  3dc8adeeefa0    None               Boots
  1f340724419e    None               Hangs
  1f340724419e    Subordinate guard  Boots
  6.18.44        None               Hangs
  6.18.44        Subordinate guard  Boots

Herv=C3=A9 wrote:
> Maybe the test done at [1] should be improved to detect those wrong brid=
ges.
> and skip the of_pci_make_dev_node() call when a wrong bridge is detected=
.

I added logging to the first bad commit to check the bridge scan. It shows
that 00:00.0 has no subordinate bus after either pass, despite satisfying
pci_is_bridge():

  pci 0000:00:00.0: PCI OF debug: scan pass 0, buses ff/ff/ff
  pci 0000:00:00.0: PCI OF debug: scan pass 0 done, subordinate bus absent
  pci 0000:00:00.0: PCI OF debug: scan pass 1, buses ff/ff/ff
  pci 0000:00:00.0: PCI OF debug: scan pass 1 done, subordinate bus absent

of_pci_prop_bus_range() dereferences pdev->subordinate without checking it=
.
of_pci_prop_intr_map() also uses that pointer. Before 1f340724419e,
of_pci_make_dev_node() returns because the parent OF node is missing on
this ACPI system. That commit creates the parent node, allowing property
generation to reach the unchecked access.

My earlier report overstated the device_type=3D"pci" result. The minimal-n=
ode
test that hung added device_type, bus-range and interrupt-map together;
I haven't confirmed a hang with device_type alone.

I tested this guard in of_pci_make_dev_node(), before node creation:

  if (pci_is_bridge(pdev) && !pdev->subordinate)
          return;

Both the first bad commit and 6.18.44 boot with it. The 6.18.44 test uses
only the guard, without diagnostic logging. The host OF node and the nodes
for bridges 00:01.0 and 00:1c.0 are still created; 00:00.0 is skipped.

This points to the NULL subordinate pointer as the cause of the hang,
although I still don't have a crash trace from an unguarded boot. I'll
send the patch as a reply to this email. Is of_pci_make_dev_node() the
right place for this check?

#regzbot introduced: 1f340724419eda8ab07a20edcaf5ec8f70134231

Thanks,
Angel J

-----------------------5847a96ded5969a4c792075b9c3489f2--

--------584d05c12d919d8b9959a7be2db6ff9738f85cff09fbdb5a0c245caa7bd7149b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqkiEMJEBoBbwppzUxnRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmegSr5JAKTKbLgmkCFNkhGukr6dbSbs2YiqV+yU
jqBBgBYhBEAFf9htFyVnqZzmVhoBbwppzUxnAACUBAEA+Vrv4qecaflgoNqE
krZ5Pt2A+D2ZHLPlXo7tpk7HjFQA/Am4TUPLoTW5RVSeYbATvytA/Gnbz89i
DW2hzZv5IxwL
=it4L
-----END PGP SIGNATURE-----


--------584d05c12d919d8b9959a7be2db6ff9738f85cff09fbdb5a0c245caa7bd7149b--

