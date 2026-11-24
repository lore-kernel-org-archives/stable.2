Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557644;
	b=IK+xWB4jAiUddzpR+CkXFVIDzRq+CFaIa7Um6YFYll0iDbrj6HCQOqULXvIKYLffgFDJ
	 vV4vYb2Rrr2VO3CZgZ2U2izFQRjv2NZ0dSSalBzfJyHEIaM1/2p6T/2GQ5NmLqZyubhtW
	 cUXEbWGM6ANs7tDiRpzmyWd2FjdkkBNND+9/Jlicx9Mn35DjqGKww4raVjYAGCFWs6EyX
	 5SeJGzEH+JxyFcJAVseeOwNJyAat97iIWTzCaty0D2/sevdihJeE7K3u8slXJg9iDs0pg
	 NfTTvN+CZpxp6mkvKflU/a9ZKMREMlfNlxchMi5GZfjh3txh5x4k1k7OvE8ilQ6xXdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EA7eHt/O0bYrcpIzHzTDx2hG19gCRJEI4TFAz5QRzRs=;
	b=MMBv2TJtuOjcBtmFZCQo3zb3kyGSoVRiYSH8CfO7WpjoAVSOWvdUEILabhYqh25kRbOu
	 1hOLCPQ2cKEJiJWr1uvwHiqh4iqhIbClC6BFJV+i77xw66uSBzHypilhILOsa9kHJ1lk3
	 /p/j5gl2IVjgwB9rahJd7jZv6aXyFr76+gmLYoxr0Lqjwq1DQeX6S1WgMH3OroU+W37gE
	 ZPFtmAe6W/gEnN3ay73DZGxgvSXiX8ByKy4y99237EtaqywzCAUZPzdVZ0DYOqZ6SdkDC
	 bD9WWPbzSrqHm7hpLXz91sRfcu4LhefFgPfX+qOBOFz9lBUbLD58rOKnjum1J9RTq/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jZnFtPjb;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E068606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E068606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jZnFtPjb
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2efc4a84e75so217615ad.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795557642; x=1796162442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EA7eHt/O0bYrcpIzHzTDx2hG19gCRJEI4TFAz5QRzRs=;
        b=jZnFtPjb03VDAoy7LgZlrMly7UoHS6SmHa4pTOwxJ22Wn9lf2V/KFWZjrC56OoBeyA
         vM7mopWtpOTgWrDW2uhp2OLm2tY9AnxSywh3Y1/6xNEepHMzUQTNGt1E6oe79iGkp6kA
         6kxrVK8IWLGGnKpdI0M60ms4CmD2DkdiwiXmajVjsKbFtElFTVmMd5FGuhaeogK8vmOb
         yMMBwYE+WEwrtMakOg0tcnwv7AdXU8qpGR6n3Rcx2MecqDqgQ1i/wjJON1sPGZjxJWO0
         0/z5cXeMQ98bnRA42PAIXEZ6m3EcmPoCTVTfgR8vVMX2YEvZe450aguqz0eTSmgC9/s9
         VW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795557642; x=1796162442;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EA7eHt/O0bYrcpIzHzTDx2hG19gCRJEI4TFAz5QRzRs=;
        b=WBHEZlrbkkQ09qisxwyYVckZldVn1HCVCZqnjEBeCoT6JfUXB/NNbQAqJExEAl+TkI
         4drSYHUT0bvZSrLGwa+vHNMLM3x9VR3WrGhB/tdFAi3ZbfruOBu0ZV8nGI8tAlRlA0gi
         bo4yyiJDAwH0Ek9z1wccyFbyfnWzztGG+QGQXivvUZIa+L27PWOmWlVhYwu7NGroHhT5
         eyOJ7ZdHKbG97U+shhphPkHGKHRpT3EW/d2tJ5btqLMOJcFw/MqZ1rKQgxGik4fcq0xL
         O+UbXrDaVTKmkZJsHQ2SA2Y+qPyCilUevrrmeXin+P9F7JXMiPXZABSblVPc0b+v2l2T
         tC8g==
X-Forwarded-Encrypted: i=1; AL+hErFP8pl3AIri8SX0ivPebt4PCBCpG3Zsu9110yE2wH3Xc5ueczFT3GpVF6mWyLVoVnuCyh+Ryw8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dNuLG3tzcHoSFl74hzP8XfyBg7w2Lo/tXiu3alajTPTtvNlA1
	FrfjeZE2uKUr09BzRRhfyrCVWhYwuaLIIyWq97gayibOf9pmwhlWkS+Yxq5OWu1ZZQ==
X-Gm-Gg: AZFdTZdUX7g9TuJoXpkGxadNR6D0VJMzWQkRAvke2aS2Cbbsl+DfT3ZOWsI5g1kiqjz
	nllXlxqyWzAi1hAhuFujwHDWpFRb+TlyVaNNOseOXQBAR1BwNOlSVvSNtsHAa9Go01TDHXgCjE2
	bJMOv9uTFaQur1PG/PcTdF7lpkFneduLrSftmxlUXsHYmIqC7q2CBFRw84TdXNVbaRLkUae05SO
	CTi2GDwjJIcDjineJEzAxB/CWtwCyKi9jEJZKxNBvWJiQDGEpU8AdViAofBdoTBU4xF3vE0/J4j
	SIf3DEIHal3NOfE1TuuGZUejbVS00nzwwsQyRcrv7xeiM5C9RoERwK098t1M4lYiL9f75Nn/iGr
	miA8KDCONg/dYVWBpWhsscfiuRxe8PUE9JBguEU8BsBsz9GeZTN/YBR3weYBxE4R9yHz4G/4bUd
	4zQJERC92pxNe2RSieXnoFxD4PWdtAvYSiJD//MuUa818Qxli8/SOF8lJeAre8SmpPKrZ+/PJ1G
	f5/lC49SCPYW/PsTYLpm4VPoQYVbElGG8FDESYsHbbuiHs0g2r3mYH5RZ8hTxciYg79f1wEJHkw
	xuh5BbP6TLcHrW6Okeyul0rivQjlZiFw9iWYFVUBe1kyHNzWCMxQvng1t4vphJncjhHquzcDYUJ
	shXeJsHFHCfP3v3YgEHT1elRUBZ1QNUT5xohVQOxDciE=
X-Received: by 2002:a17:903:1444:b0:2d0:1aaf:daec with SMTP id d9443c01a7336-2f0665697d7mr10304545ad.9.1795557641889;
        Tue, 24 Nov 2026 14:00:41 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm24132763a91.4.2026.11.24.14.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:00:41 -0800 (PST)
Date: Tue, 24 Nov 2026 22:00:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset may
 need it
Message-ID: <awYIlvOacAWrT99b@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
 <20261118163706.7138d246@shazbot.org>
 <20261119143237.4bf54796@shazbot.org>
 <awC5Ldqmue6DiO44@google.com>
 <20261124084852.661dd7c1@shazbot.org>
 <awXedVCoT7M79Rk5@google.com>
 <20261124145743.6c253bd2@shazbot.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124145743.6c253bd2@shazbot.org>

On Tue, Nov 24, 2026 at 02:57:43PM -0700, Alex Williamson wrote:
>On Tue, 24 Nov 2026 21:04:57 +0000
>Samiullah Khawaja <skhawaja@google.com> wrote:
>
>> On Tue, Nov 24, 2026 at 08:48:52AM -0700, Alex Williamson wrote:
>> >On Fri, 20 Nov 2026 22:21:16 +0000
>> >Samiullah Khawaja <skhawaja@google.com> wrote:
>> >
>> >> On Thu, Nov 19, 2026 at 02:32:37PM -0800, Alex Williamson wrote:
>> >> >On Wed, 18 Nov 2026 16:37:06 -0800
>> >> >Alex Williamson <alex@shazbot.org> wrote:
>> >> >
>> >> >> On Thu, 12 Nov 2026 23:57:00 +0000
>> >> >> Samiullah Khawaja <skhawaja@google.com> wrote:
>> >> >>
>> >> >> > Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
>> >> >> > vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
>> >> >> > upstream bridge before resetting the device, and skips the reset if the
>> >> >> > trylock fails.
>> >> >> >
>> >> >> > All VFs of a PF have the same upstream bridge. Take a device with two
>> >> >> > VFs, both used by one process. When the process is killed, both VFs can
>> >> >> > be released at the same time. The first one takes the bridge lock and
>> >> >> > does its FLR, the second one fails the trylock and is never reset.
>> >> >> >
>> >> >> > The bridge lock is only needed for a bus reset, which is done through
>> >> >> > the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
>> >> >> > resets the bus for it because the PF and the other VFs are on the same
>> >> >> > bus.
>> >> >> >
>> >> >> > Add pci_reset_needs_bridge_lock(), which returns true if any reset
>> >> >> > method enabled for the device is a bus reset, and only lock the bridge
>> >> >> > in vfio_pci_core_disable() when it does.
>> >> >> >
>> >> >> > Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
>> >> >> > Cc: stable@vger.kernel.org
>> >> >> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> >> >> > ---
>> >> >> > Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
>> >> >> > with two VFs. Both VFs are opened through VFIO and then closed from two
>> >> >> > threads at the same time, counting FLRs with a kprobe on pcie_flr().
>> >> >> > Without this patch one VF missed its FLR in 50 of 50 rounds, with it
>> >> >> > both VFs were reset in every round. I will send a VFIO selftest for this
>> >> >> > separately.
>> >> >> > ---
>> >> >> >  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
>> >> >> >  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>> >> >> >  include/linux/pci.h              |  1 +
>> >> >> >  3 files changed, 31 insertions(+), 1 deletion(-)
>> >> >> >
>> >>

[snip]

>> >I think the test I'm proposing precludes a bus reset, ie. there is no
>> >upstream bridge, the device flags prevent it, or we're provided with a
>> >VF.  It's only those cases where we can't do a bus reset anyway, that
>> >we can skip the bridge device lock.  I think that means it's useful in
>> >PCI-core as well as vfio-pci.  Did I miss something?
>>
>> Yes, the slot reset probe doesn't account for the VFs and will allow
>> reset of the slot when hotplug is enabled.
>>
>> I think that is probably a fix that needs to be done orthogonal to this.
>> I will send a v2 of this by doing the needs_bridge_lock() as you
>> mentioned above.
>
>Yes, there might be a latent bug in the slot reset path.  I know s390
>has some weird per-VF slot reset, but they set the per_func_slot flag.
>The test in pci_dev_reset_slot_function() probably needs to account for
>both VFs and multifunction devices as:
>
>	((dev->multifunction || dev->is_virtfn) &&
>	 !dev->slot->per_func_slot)

Yes, that is exactly the fix I am thinking about. Let me send this one
also separately.
>
>As you suggest though, that's a separate fix.  Thanks,
>
>Alex
