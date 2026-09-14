Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06744605C
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386618; cv=none; b=GKkSPPwxu5L1RNFQaaZqppogHgBGPSlQ3IreYi4e2CS4CiV5ddnk1LqNuqT6Q5LETuTXpFpWqqMIWYqqObEZ508KwNz18xCUcNed9ox4X/oPSoGpipkLisMuzsflFiRO0lE/FJMzYJErpQdSvoPkE2EKpsB05T7GtGppCzadBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386618; c=relaxed/simple;
	bh=Q8ksi+xZgxIagv9+QQVvkuR0wfKZoHt0nu/3YJrwAf8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBrp3oxZ1MJYkqea0iV5UA+A7LJ8M7sUcboi7S2iSmfR1tIlN2+aRSqpxP9bA9PZP2kqIBlGHsM0iB3C5N9V+PppIapPZ6ElstyiBx5MKpfZ+b/w73CM1ENDmRV+mKxmHVMJ+loN5rkhtP9BB7yylSIwHvuwMhiHisSqMndwonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X3W0IJr9; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X3W0IJr9"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c2so285991466b.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789386614; x=1789991414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b3d/NyVwn33xRXNwAVXKr9GMiiFtUoOWjxTC/8TNYXw=;
        b=X3W0IJr9hBeZ4qGivj24+Ul+Des8dIPbzdBUI0Q3HKkT75wJXHtgj54KOm+hxQ/KqR
         fyqkuVBubWlibJlw9IbMg8vMBwpNfU1BdYlbUEMzUXJw6nZR+Sl8LKghIo/Czi2oglzR
         ko059MNsVA6Xug/DpswvQdsMreHPygok49yraiBKD/RtX0mgU3wy6ojGiWrnGqbjlr3Z
         207qdc90W5EDJdfiZBlD699pqxU/usdleueoL8FGYku2aewzCsDD8BhgaSGfwh5VL47f
         Ze2PqngAgaDxwJPk8wxa/ZSZpp9OA2IxHIXunHn0hqsPx4fc+K2h/IbT3Westz4XGr8t
         oMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789386614; x=1789991414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b3d/NyVwn33xRXNwAVXKr9GMiiFtUoOWjxTC/8TNYXw=;
        b=JD+maE68fBAr2+d5OXzU5LDLd3Fd88tfSpbHcRuwoHLKqd0UHW0KjNHwhXm96d53/L
         YvSIUCOe/svPHmYp+/pLl1TwbvJb/lgX66P61cP+0QVWUNwGn8nX7hYUaONsQIq/HpTY
         RBmtZGUui4N7uFpAY0TBSEA87UfSI0oavTmxKDU3lIdi42vbrZ72q+qCizY64sTSrpiJ
         a5kmwSXnHtp6olMRcWXbRxqsZKFl6YtfvdENDVxMkv+NYKSTYCBtNuCnKZeDu1L/TdfU
         UhyJR2d1jRnOhGhPGCCxjB7FDQy1iMFoQGxuug0XCo88dN9QbgJ6s62MP0XImtTbEtZg
         E06w==
X-Forwarded-Encrypted: i=1; AKwUvBzv3/S4wCXMhKJfYCZcJGbORfBmk5WFDkq1wT7CBSNmTyUbbukbXvpFEzxQvdW6I1uVaQUgZIg=@vger.kernel.org
X-Gm-Message-State: AFuF++mmJUzEz0WmqkXJF/PNEkeNeQ7qoSEpu4hLgcD5SYWYyOeMDcX6
	ZxJUR2GqzZc9Fdrh+cPNIW/j83C/SpPcn3KwkOf8id7hQHdZ/64vNlszH+p/AvCpsog=
X-Gm-Gg: AYBFou2YmLMILIfcJzDR9qFzzE50Rxl+390VOTRNvuy3KduY2dnD9hRhLNR6Y43Yk3e
	DDA90/loGRuikEyHB16SuCIszNmpFh6qrtxbjacv9yrg66MRHLo0UbaJdTRUqHJXrS4yEXoMsE/
	GVBD75NSHR+vDIad1o0jfAb6hFPWjjkjVq/7weW+UOqWxcCGw7A4tLY4buMpTm9muJeuQaXQTxD
	ag6kD5/OjVrqT1kxFVKZPBmIzUeptznIno9vpHGvTvbpPEJoAmDnO0aDPck6EUOHGpSF+2hk7X+
	XQGp77T7SqxHtQaUBc5mHjFvT0uXdD2+ixV4CMVTnIMDPLwEQfQNkHd7usqLcwAw//nGHTQdyiY
	C5Y/Ef+PwxLTBhrjQvoX2Mcda0Nt8AQt71H0zrL5zHKgxFygcLEyh1q7b9v5ZpNYhwClIvRUakA
	aTbSinc/HxyyIjL88ovpVOMDUWR+ku/c5/99sOcSX+8bT+QDfIzcukcWR5zUABHCFiFow=
X-Received: by 2002:a17:907:3e07:b0:c25:8c05:902f with SMTP id a640c23a62f3a-c29b86b7559mr277818766b.13.1789386614302;
        Mon, 14 Sep 2026 04:50:14 -0700 (PDT)
Received: from localhost ([82.145.119.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4dfc7sm415116366b.4.2026.09.14.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:50:13 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 14 Sep 2026 13:53:53 +0200
To: Angel J <iamanaws@httpd.dev>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"andrea.porta@suse.com" <andrea.porta@suse.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid
 bridge configuration
Message-ID: <aqfgUUkZYZg6ZABF@apocalypse>
References: <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>
 <cFJoUZ6c5g5YbFCrwUnx6RlitHRl-0cS2fadDSFJNf9SgLreKutrmZj1r56hFh8ZUAbzvuCqBG4w9ZYAE8xAWP9HnLwbjMOBzac-iMnMMZc=@httpd.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cFJoUZ6c5g5YbFCrwUnx6RlitHRl-0cS2fadDSFJNf9SgLreKutrmZj1r56hFh8ZUAbzvuCqBG4w9ZYAE8xAWP9HnLwbjMOBzac-iMnMMZc=@httpd.dev>

Hi Angel,

On 23:01 Fri 11 Sep     , Angel J wrote:
> Hi Andrea, Hervé, Bjorn, Thorsten,
> 
> Thanks for the guidance, it was very useful. I went back through the tests
> and got some more insight into the hang.
> 
> Andrea wrote:
> > Angel, could you please provide the following output:
> >
> > lspci -nn
> > setpci -s 00:00.0 HEADER_TYPE
> >
> > from a running (i.e. with CONFIG_PCI_DYNAMIC_OF_NODES=n) system?
> 
> On Linux 6.12.109, with CONFIG_PCI_DYNAMIC_OF_NODES disabled, the relevant
> output is:
> 
>   $ lspci -nn
>   00:00.0 PCI bridge [0604]: Intel Corporation Device [8086:4c43] (rev 01)
> 
>   $ setpci -s 00:00.0 HEADER_TYPE
>   01
> 
>   $ setpci -s 00:00.0 PRIMARY_BUS SECONDARY_BUS SUBORDINATE_BUS
>   ff
>   ff
>   ff

So it seems that a device which is reported as a PCI bridge does not manage any
bus underneath.

> 
> The device is bound to icl_uncore. I get the same values on the patched
> kernel with CONFIG_PCI_DYNAMIC_OF_NODES=y.
> 
> Hervé wrote:
> > Is this PCI logs reported with PCI_DYNAMIC_OF_NODES=y or PCI_DYNAMIC_OF_NODES=n
> > or always whatever the PCI_DYNAMIC_OF_NODES Kconfig value ?
> 
> The messages appear on successful boots with either setting:
> 
>   pci 0000:00:00.0: [8086:4c43] type 01 class 0x060400 conventional PCI bridge
>   pci 0000:00:00.0: bridge configuration invalid ([bus ff-ff]), reconfiguring
> 
> I confirmed this on 6.12.107 with the option disabled and 6.12.108 with it
> enabled. They also appear on the patched 6.18.44 kernel.
> 
> Bjorn wrote:
> > I don't think 49d63971f963 ("misc: rp1: RaspberryPi RP1 misc driver")
> > is a likely culprit by itself because there's just nothing there that
> > looks like it would relate to a Dell XPS 8940.
> 
> That change exposed the problem by enabling PCI_DYNAMIC_OF_NODES in my
> configuration. I bisected again with the option enabled throughout and
> found an earlier boundary:
> 
>   3dc8adeeefa0  PCI: of_property: Constify parameter in of_pci_get_addr_flags()
>   1f340724419e  PCI: of: Create device tree PCI host bridge node
> 
> The first is the direct parent of the second. I boot-tested both without
> any guard, changing only the source commit; their generated kernel
> configurations are identical.
> 
> All of these tests have CONFIG_PCI_DYNAMIC_OF_NODES=y:
> 
>   Source         Change             Result
>   3dc8adeeefa0    None               Boots
>   1f340724419e    None               Hangs
>   1f340724419e    Subordinate guard  Boots
>   6.18.44        None               Hangs
>   6.18.44        Subordinate guard  Boots
> 
> Hervé wrote:
> > Maybe the test done at [1] should be improved to detect those wrong bridges.
> > and skip the of_pci_make_dev_node() call when a wrong bridge is detected.
> 
> I added logging to the first bad commit to check the bridge scan. It shows
> that 00:00.0 has no subordinate bus after either pass, despite satisfying
> pci_is_bridge():
> 
>   pci 0000:00:00.0: PCI OF debug: scan pass 0, buses ff/ff/ff
>   pci 0000:00:00.0: PCI OF debug: scan pass 0 done, subordinate bus absent
>   pci 0000:00:00.0: PCI OF debug: scan pass 1, buses ff/ff/ff
>   pci 0000:00:00.0: PCI OF debug: scan pass 1 done, subordinate bus absent

This is confirmed by the BIOS/fw not filling the bus range and by the kernel
failing to reallocate the bus since the range registers are probably read-only.
Apparently this is not a bridge, it should be at most a host controller.

> 
> of_pci_prop_bus_range() dereferences pdev->subordinate without checking it.
> of_pci_prop_intr_map() also uses that pointer. Before 1f340724419e,
> of_pci_make_dev_node() returns because the parent OF node is missing on
> this ACPI system. That commit creates the parent node, allowing property
> generation to reach the unchecked access.
> 
> My earlier report overstated the device_type="pci" result. The minimal-node
> test that hung added device_type, bus-range and interrupt-map together;
> I haven't confirmed a hang with device_type alone.
> 
> I tested this guard in of_pci_make_dev_node(), before node creation:
> 
>   if (pci_is_bridge(pdev) && !pdev->subordinate)
>           return;

Not sure, maybe can it be considered a hw bug? If this is the case, we can maybe
add a quirk for this device. Could you please test adding a quirk as PCI_FIXUP_HEADER
in which you downgrade the class from 0604 to 0600 and see it works even without
your proposed check in of_pci_make_dev_node()?

If this works, maybe we can just turn the body of your conditional into just an error
log plus fast exit, because a bridge must have valid subordinate.

Many thanks,
Andrea

> Both the first bad commit and 6.18.44 boot with it. The 6.18.44 test uses
> only the guard, without diagnostic logging. The host OF node and the nodes
> for bridges 00:01.0 and 00:1c.0 are still created; 00:00.0 is skipped.
> 
> This points to the NULL subordinate pointer as the cause of the hang,
> although I still don't have a crash trace from an unguarded boot. I'll
> send the patch as a reply to this email. Is of_pci_make_dev_node() the
> right place for this check?
> 
> #regzbot introduced: 1f340724419eda8ab07a20edcaf5ec8f70134231
> 
> Thanks,
> Angel J



