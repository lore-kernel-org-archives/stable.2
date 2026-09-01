Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41E2E62B7;
	Tue,  1 Sep 2026 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788242870; cv=none; b=eGv2ww2wVhPJpS1j5K8ANB5R7bwsR4XgxQM4xhMzFCtfKgXzCXaSjQOEtgquZ733RGFoCDfnejRNTq28xgI6YtzKig+A+Gs2xn0D0YM8DVxIzGFciRHe/uqMwFs692roD2gZ6n0lXvMXic6H59t+xWD71/nGxtRv0tMDIUPMWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788242870; c=relaxed/simple;
	bh=EyJFedm9yBXHYCIlo7Wa7jv+cajU5nWrj95T3FvDHt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dccz7FvfbYwYOEGvI5qcnAM9l29FWdKi8fjdjMIcPkjzLv0qKOrLNo3VJbbinYcT9xOk4pYlZJHY66LlSqZREeBKOlVpay5yQTqGjCqJBhGW7zdGpD8M7OyzzChoGkLfQK0ecy4LVtXQ6YhXiJi7uLq0pMQgTho82OL3TqgLX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=AaZcbZUB; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="AaZcbZUB"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hYwPr6Fm5z6BrK;
	Tue,  1 Sep 2026 08:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1788242864;
	bh=EyJFedm9yBXHYCIlo7Wa7jv+cajU5nWrj95T3FvDHt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AaZcbZUBUjiHpwnDEDvwdaXMbBo3j3Rtu/8cvnYKOaLiTvu6WNCQaRvW8I1ifYJK5
	 WFzsCjH2rxBJCd6M+Dp18B+D+x7XrZdNNR8u/6T9Vsl8IgikN8qGKEiYYJwTEBRJ9P
	 kCnqPMjoEXJjLu+Ipcve16cyTAYsGVv6Q29LMg5FG5bGvgY9qTRCIXuy8crMlTqQ87
	 m8Pvgv5OdG4kp++hEAa3AsPyg/kEqP8s8ApZSxOHdynHYP8xAJGgYK5GQGqiJOfAXX
	 QXGqAEG1VS7ISGL3mCV+kPeyfFSBXpvpJxe3oqRi6QyIgeXsi4t6Wj5xDa0oPzGMSW
	 rHuxgv1CnxeOw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hYwPr5XM1z517B;
	Tue,  1 Sep 2026 08:07:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hYwPq0TBvz8tcZ;
	Tue,  1 Sep 2026 08:07:43 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 466345FA73;
	Tue,  1 Sep 2026 08:07:42 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <3b6b0bbc-b73e-4e6e-89e1-1bc16841b50f@leemhuis.info>
Date: Tue, 1 Sep 2026 08:07:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] PCI: Dynamic OF node creation hangs on invalid
 bridge configuration
To: Angel J <iamanaws@httpd.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-rpi-kernel@lists.infradead.org"
 <linux-rpi-kernel@lists.infradead.org>,
 "helgaas@kernel.org" <helgaas@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "andrea.porta@suse.com" <andrea.porta@suse.com>,
 "florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>
References: 
 <GXe6anuewkS4bLNwca3cYOmUxN9csc0TxLYGSBc1qNRmfrmvFlcmD62wEM23TxfzfuXAv4P3yvUv7pyraleARrL1Na-aN8w-t9uc1Igu8DA=@httpd.dev>
 <-KoxZtWNyNmnEu6-RkoMW2kenooTum0AiXwENwNBtoxqyI9wDXo1UJik1Wn9Igj_VRQ9bcYlva6FUZYq17UdPChUz_-mtDyrHSFO7t_broI=@httpd.dev>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <-KoxZtWNyNmnEu6-RkoMW2kenooTum0AiXwENwNBtoxqyI9wDXo1UJik1Wn9Igj_VRQ9bcYlva6FUZYq17UdPChUz_-mtDyrHSFO7t_broI=@httpd.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178824286275.2620659.5128722016604008017@mxe9fb.netcup.net>
X-NC-CID: /dmWgWKF59PmYZ/AwPWOUh7Swv4gHILa3CD/nyP/iPsNi8REolM=

On 9/1/26 02:59, Angel J wrote:
> A friendly ping on this regression.

Ideally the problem would be fixed, sure. But by your explanation it was
already in mainline and backporting those changes might be too much
churn. But you could try to submit a backport of ce26f588c831 (if that's
all that's needed) to the stable team (or ask somebody to do that for
you), maybe they will puck it up.

And overall: I not entirely sure if this counts as a regression, as you
(if I understood things properly) enabled something new in your .config
(that caused some other hidden problem to show up). That makes it a
non-regression, as, say, new security restrictions (that block things
that used to work) guarded by a new config option could never be
introduced otherwise in Linux.

Ciao, Thorsten

> It still affects Linux 6.18, and
> the tested invalid-bridge guard allows the machine to boot with
> CONFIG_PCI_DYNAMIC_OF_NODES=y.
> 
> Is any additional information or testing needed from me?
> 
> Thanks,
> Angel
> 
> 
> 
> On Saturday, August 22nd, 2026 at 19:14, Angel J <iamanaws@httpd.dev> wrote:
> 
>> Hello,
>>
> 
>> This regression was introduced in v6.17-rc1 and remains in the dynamic
>> PCI OF node code. Linux 6.18 fails very early during boot on my Dell XPS
>> 8940 when CONFIG_PCI_DYNAMIC_OF_NODES=y. The display goes black before
>> any useful console or pstore output appears, and the machine remains
>> hung.
>>
> 
>> Disabling CONFIG_PCI_DYNAMIC_OF_NODES makes the same kernel boot normally.
>> Linux v6.19-rc5 also boots because the RP1 driver stopped selecting that
>> option, not because the dynamic PCI OF node code changed.
>>
> 
>> Hardware:
>>
> 
>>   System: Dell XPS 8940, board 0K3CM7, BIOS 2.27.1 (2025-04-03)
>>   CPU: Intel Core i7-11700 (Rocket Lake)
>>   Triggering device: 0000:00:00.0, Intel 8086:4c43
>>   Firmware boot: UEFI, ACPI-based x86_64
>>
> 
>> Test results:
>>
> 
>>   Linux 6.12.103: good
>>   Linux v6.17-rc1: bad
>>   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=y: bad
>>   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=n: good
>>   Linux 6.18.44, CONFIG_PCI_DYNAMIC_OF_NODES=y, skip invalid bridge: good
>>   Linux v6.19-rc4: bad
>>   Linux v6.19-rc5: good
>>   Linux 4621c338d33f: bad
>>   Linux e55feea3a03a: good
>>
> 
>> The first-parent boundary between the last two tests is:
>>
> 
>>   e55feea3a03a ("Merge tag 'soc-fixes-6.19' ...")
>>
> 
>> That merge contains ce26f588c831 ("misc: rp1: drop overlay support"), which
>> removes:
>>
> 
>>   select PCI_DYNAMIC_OF_NODES
>>
> 
>> from MISC_RP1. The generated configurations differed only by:
>>
> 
>>   -CONFIG_PCI_DYNAMIC_OF_NODES=y
>>   +# CONFIG_PCI_DYNAMIC_OF_NODES is not set
>>
> 
>> CONFIG_MISC_RP1=m in both. The known-bad 4621c338d33f and Linux 6.18.44
>> both boot after disabling PCI_DYNAMIC_OF_NODES (and MISC_RP1, whose Kconfig
>> select otherwise forces it on).
>>
> 
>> There is no RP1 device in this machine, and its driver does not probe.
>> MISC_RP1 affects this x86 system only because its Kconfig select enables
>> PCI_DYNAMIC_OF_NODES globally.
>>
> 
>> I narrowed the hang to dynamic OF node creation for 0000:00:00.0
>> (8086:4c43), the Intel Rocket Lake-S integrated memory controller. On
>> this machine it reports PCI class 0604 and header type 1, but it is bound
>> to icl_uncore and is not a usable forwarding bridge:
>>
> 
>>   Bus: primary=ff, secondary=ff, subordinate=ff
>>   I/O and memory bridge windows: invalid/all ones
>>   kernel: bridge configuration invalid ([bus ff-ff]), reconfiguring
>>
> 
>> A minimal dynamic node for this device boots. Adding only
>> device_type="pci" makes it hang. Full PCI dynamic OF node generation also
>> boots when only 0000:00:00.0 is skipped.
>>
> 
>> I also tested a generic guard in of_pci_make_dev_node(). It reads
>> PCI_PRIMARY_BUS and skips node creation if the primary bus does not match
>> pdev->bus->number, the secondary bus is not greater than the primary bus,
>> or the secondary bus is greater than the subordinate bus. Linux 6.18.44
>> boots with CONFIG_PCI_DYNAMIC_OF_NODES=y and logs:
>>
> 
>>   pci 0000:00:00.0: skipping dynamic OF node for invalid bridge
>>
> 
>> The regression was introduced by 49d63971f963 in v6.17-rc1. Commit
>> ce26f588c831 made v6.19-rc5 boot by removing MISC_RP1's select of
>> PCI_DYNAMIC_OF_NODES. That avoids the failing path in the tested
>> configuration but does not change of_pci_make_dev_node().
>>
> 
>> I do not have a log from the failed boots. No output appeared with
>> earlyprintk=efi,keep, keep_bootcon, ignore_loglevel, loglevel=8,
>> initcall_debug, and EFI pstore enabled. Blacklisting both GPU drivers and
>> disabling the Intel IOMMU did not make the bad kernel boot.
>>
> 
>> Should of_pci_make_dev_node() reject devices with invalid bridge bus
>> configuration, or should 8086:4c43 use a device-specific quirk? I can
>> prepare and test a patch for either approach. For Linux 6.18 stable,
>> would that fix be preferable to backporting ce26f588c831 and its
>> dependencies?
>>
> 
>> #regzbot introduced: 49d63971f963
>> #regzbot title: PCI_DYNAMIC_OF_NODES early boot hang on ACPI x86
>>
> 
>> Thanks,
>> Angel J
>>
> 
>>
> 
>>
> 
>>
> 
>>
> 
>>

