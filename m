Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DD3B14D9;
	Fri,  4 Sep 2026 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512280; cv=none; b=Sn/tgHHp5PY67VKUSWlYIGAxroIovKHVXyBxwCvnDnT2/xHpMkSMNUm6FhCSf7Oh2XMRdDS6NxrpCQ/n4l4hNPK7XazlHm0mZO/psK+dHdtWpFUthurnv/izmvSfoCKt+dgLthNkFhyi/lPVd+Rj7rulPeDELW1Ys8MPy82Abfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512280; c=relaxed/simple;
	bh=ItAgOmWZHah4VZWU9hUE3n8qwEZmfg2QY78XykHTKCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIlUSaeNIUQ95Padguoef49A0tZzlUXt13fenQfulCw9nuKkVOUi0FQc5PeV4ojtM1FichIBGkbGG1SmOK5ZGx8JRXIrqn3XlAGdgRM+MFWhBPjEFe7pDZI9XHS5WZYfVFKEvdex9wYTOFtX1QAcq4AafJbiCsjvK8faXqjPDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B40G1lPS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B40G1lPS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0087D4E41502;
	Fri,  4 Sep 2026 08:57:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C66726057F;
	Fri,  4 Sep 2026 08:57:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2358511C7A64B;
	Fri,  4 Sep 2026 10:57:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788512269; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=34b7Bgxp3x9PLa1m5wRwWiIKL6BceNCxaxsVLtWyi2c=;
	b=B40G1lPSnWpdXk/CKxFqyw9eP36g1t3Nw9ZlPzXqHo8TIx8Mp34rN+Oqel70t9Zf8EM3Ps
	S2v7En6gcV89Qf6wuWaywPCR23vtVKmWDqmUZ8C3n6n11Dlg7bFEFEJwAk9orVAo7DC51T
	NcjD9A2V2aZwGDHxbO/Wvk/no9/E26MnPe0szKMQ6HDJArnltsTxWQRJuVfkTUlX43ZiZy
	9IX8AhtAh7uXKer6HfK5+UMaYDx3UbL2Vt5VabTKVKpeTc8iwxxW+7EzPeybNuNA5OrQM4
	utJqkzvZpw3vFRN7yEyth45ZR/6OTVhaSiaPKhRCp6J+xyCqW7XpP5fj7yFlIA==
Date: Fri, 4 Sep 2026 10:57:43 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Angel J <iamanaws@httpd.dev>, Lizhi Hou <lizhi.hou@amd.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-rpi-kernel@lists.infradead.org"
 <linux-rpi-kernel@lists.infradead.org>, "robh@kernel.org"
 <robh@kernel.org>, Andrea della Porta <andrea.porta@suse.com>,
 "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid
 bridge configuration
Message-ID: <20260904105743.1c396a8b@bootlin.com>
In-Reply-To: <20260903231744.GA2281658@bhelgaas>
References: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>
	<20260903231744.GA2281658@bhelgaas>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Angel, Bjorn,

On Thu, 3 Sep 2026 18:17:44 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+to Herve, Lizhi for PCI dynamic OF node stuff]
> 
> On Sun, Aug 23, 2026 at 02:14:25AM +0000, Angel J wrote:
> > Hello,
> > 
> > This regression was introduced in v6.17-rc1 and remains in the dynamic
> > PCI OF node code. Linux 6.18 fails very early during boot on my Dell XPS
> > 8940 when CONFIG_PCI_DYNAMIC_OF_NODES=y. The display goes black before
> > any useful console or pstore output appears, and the machine remains
> > hung.  
> 
> Oof, sorry, that's a terrible failure to debug.  Thanks for your
> persistence in chasing it.
> 
> I don't think 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
> is a likely culprit by itself because there's just nothing there that
> looks like it would relate to a Dell XPS 8940.
> 
> > Disabling CONFIG_PCI_DYNAMIC_OF_NODES makes the same kernel boot normally.
> > Linux v6.19-rc5 also boots because the RP1 driver stopped selecting that
> > option, not because the dynamic PCI OF node code changed.
> > 
> > Hardware:
> > 
> >   System: Dell XPS 8940, board 0K3CM7, BIOS 2.27.1 (2025-04-03)
> >   CPU: Intel Core i7-11700 (Rocket Lake)
> >   Triggering device: 0000:00:00.0, Intel 8086:4c43
> >   Firmware boot: UEFI, ACPI-based x86_64
> > 
> > Test results:
> > 
> >   Linux 6.12.103: good
> >   Linux v6.17-rc1: bad
> >   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=y: bad
> >   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=n: good
> >   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=y, skip invalid bridge: good
> >   Linux v6.19-rc4: bad
> >   Linux v6.19-rc5: good
> >   Linux 4621c338d33f: bad
> >   Linux e55feea3a03a: good
> > 
> > The first-parent boundary between the last two tests is:
> > 
> >   e55feea3a03a ("Merge tag 'soc-fixes-6.19' ...")
> > 
> > That merge contains ce26f588c831 ("misc: rp1: drop overlay support"), which
> > removes:
> > 
> >   select PCI_DYNAMIC_OF_NODES
> > 
> > from MISC_RP1. The generated configurations differed only by:
> > 
> >   -CONFIG_PCI_DYNAMIC_OF_NODES=y
> >   +# CONFIG_PCI_DYNAMIC_OF_NODES is not set
> > 
> > CONFIG_MISC_RP1=m in both. The known-bad 4621c338d33f and Linux 6.18.44
> > both boot after disabling PCI_DYNAMIC_OF_NODES (and MISC_RP1, whose Kconfig
> > select otherwise forces it on).
> > 
> > There is no RP1 device in this machine, and its driver does not probe.
> > MISC_RP1 affects this x86 system only because its Kconfig select enables
> > PCI_DYNAMIC_OF_NODES globally.
> > 
> > I narrowed the hang to dynamic OF node creation for 0000:00:00.0
> > (8086:4c43), the Intel Rocket Lake-S integrated memory controller. On
> > this machine it reports PCI class 0604 and header type 1, but it is bound
> > to icl_uncore and is not a usable forwarding bridge:
> > 
> >   Bus: primary=ff, secondary=ff, subordinate=ff
> >   I/O and memory bridge windows: invalid/all ones
> >   kernel: bridge configuration invalid ([bus ff-ff]), reconfiguring

Is this PCI logs reported with PCI_DYNAMIC_OF_NODES=y or PCI_DYNAMIC_OF_NODES=n
or always whatever the PCI_DYNAMIC_OF_NODES Kconfig value ?

A PCI class 0604 is a PCI-to-PCI bridge.

Something in kernel code prevent the scan of this PCI-to-PCI bridge even if the
kernel tries to reconfigure it. Indeed, the device is "Intel Rocket Lake-S
integrated memory controller" and not a PCI-to-PCI bridge

The of_pci_make_dev_node() is called by the PCI core [1] to create OF node for
bridges.

of_pci_make_dev_node() will set (device_type = "pci" in the created node).

But if the device it is not a bridge, this is obviously wrong (even if I don't
understand why it hangs the system).

Maybe the test done at [1] should be improved to detect those wrong bridges.
and skip the of_pci_make_dev_node() call when a wrong bridge is detected.

[1] https://elixir.bootlin.com/linux/v7.2/source/drivers/pci/bus.c#L355


Best regards,
Hervé
