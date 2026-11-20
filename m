Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213282;
	b=qJQT0Y1P7KQA3Aouc7IaZeraUmawB5d2mGKA0JZym1ErB6ZYaW4qYhwlHa6CcRLZYCeK
	 lR+WUgYEkv3EoWfkTKuE91k1Y1xvo/rQ3jYm5CkBNS4QC4eocOhChZeLl8EiDqKdrYotb
	 6c2CDG85lGIQgWuxQseqBBaTNrhiV8BMlXrxg8lUWl5WzC5hDPxMQ6fvpJMouU2HzMDFj
	 jgAyfPeFsDoG+aMMUm3pSRaoZFLpLhoKy05GfoNnaUB9qsC0WJyVtTJ7Gd7nKGoJl7EQo
	 5AiyRp7VuzFNXhFpl0675rG5cS/nNYV/C73YPbDZ2q1JiVAYwAxCtSjEr46UJrb33LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YWAHn2Sutfx4jyhpprq+KziM+rM4UEONRsPYaYW8qwc=;
	b=RfJ0M42XcfGU72g4tHKHPwsKlXuIMiCL08HQCXvVnEGNxTmpLBdGku7Mk1LPGfxoFG13
	 gCmuhdNN+5/wZC0OV2AZSSlOa4LsNzEJJPB/Rh3hd1WcUsJOmTtGrgBTLMBwxgWd3gHn7
	 iRZJObpzNgUYBny7TASnzyVnNJALqGPrfNk1kEdeNdKpf4wgUecGAkfRRZrc8xW3I217Z
	 WLCwjUIzfPOvTJmkDEIwnnyBy5/plqMoYK+ijBQpkry7dRHf9OfrHWPgQTXHX2fGlEHpd
	 utMWp6tKW6RxBT44TDhToUtdfQ651JgL40QFlm5NcnN6iXQX7nUYA3U2ngkeNgLOthQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yf6DiZlS;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A0606A6AE
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 22:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 378A0606A6AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Yf6DiZlS
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2efc4a84e75so7455ad.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213281; x=1795818081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YWAHn2Sutfx4jyhpprq+KziM+rM4UEONRsPYaYW8qwc=;
        b=Yf6DiZlSNFO5GLCuQDAESWda3efOZ+ibaIKUvebHR9Ots3v4MJUI7W1R383LBgPssP
         JemDiDFzGhF2EXC2dNnbjkXEdmG8tiZfnzUH/N688CKz+Ac3/Gwltykxrvaa3EDKhRTj
         816ODB0DgIVzcAVJ++EiaZMkbWjndkCiLJIOF/8dZhmVY2+MEWkZcj47mZvmt4B4lBE3
         +ekVzpMJxEKBn6+5mvwrfbPUmacS0toEphyggM9hC2bCrhjbb1inSozdq3vb5n6hJZZ0
         2wu23ClMuJ/AYhbR0sW4ZN7U9MYW22amTmpeLxvnoKXtHxg8unyhrkzmb3perxPOaQ6v
         tvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213281; x=1795818081;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWAHn2Sutfx4jyhpprq+KziM+rM4UEONRsPYaYW8qwc=;
        b=0Pw1g0eE2o8J+8QLbYX+Dud6KmKOl5tQYZNCq2VsY3BZickIx/Jut87pV4J2oP4+/5
         9HEUaCbuYQMGAjd7HcL8KbhSIE2DK9jMCl4OrtgUtt+asazXwWpeAqe/hc11KpWXgQgF
         u7xfTgFsHOqntQnVCkh5USFIw+S3nU8r+0/UimWdCvxn+/h0G2oCBa01eqsm21XbKhSY
         ZtqIp6FxEX59CAWrDmCOBqX2KZwkOTWh6B5Pab0g1tbHb+NUn0eFTq0ES2gXEix2Fi5I
         /gRulRGz7x55EUGO54ZTiORXed5/BBJ/cN1KLcIIzQtkzdF3LIA739/Kvj4+NWThGkn9
         Sw/Q==
X-Forwarded-Encrypted: i=1; AL+hErE4tCAB/U7Qm8OIzbSwuEDeDcWDQmzMVR2E8JNJ3yDSslvhV1gwVheboB4XYYTfeVXKzSO1Js0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GF1q9zHzDl9v/yyaffU3Iq9flcD6IuCFsxOk2bmc0xeI4mAOt
	2lbgCSf0kiXThRLeyIgFi23XDVrmYNRZCj8TaXa9FL4fN179iSBOeTigXzgZztspWA==
X-Gm-Gg: AZFdTZdLPtPD/4tFxTC/k9uV8FYOtql9NpVdsZEO7Zqfp18jQMlRpcONZ8XHqszEF1s
	tmriZOcVGAaTulBZfTms4xzsHnScnyqXJOrnq4uyLogSld9GCBq9cotGUyUWatukczH8iC5NVyt
	GFpY9Wb2Ce1ehtd7f0QWstdnA3znodZtbz74Hq8NF5Mo+2FrCTEeK0sP5lWCEoCuJe0yGYTGeSU
	fYLrizxuVeOBeId+J6AN14k6rz7hHh2yIHWdnFsslj1LljxC6l655AKHTKL6hIwSxX0MLv798zx
	8ohAEkOftMcUy/tWZ8DVW98JGqI2g2+EeEiLg7Fq1+vO1T6z1MyZmvfl2kht88OjP4ZkBj7mwnt
	5yUxzjkq7O7F/+A+TaHSwK9++dvhDrHRkJjCat9Aqc6qD4xV38gvGhjBz1RgSjFgTRi+jL2/OlR
	3UT3KxLga5ujlOxEGGHJnDR75iTidC52VibV3RLiL7I3zDEeAghzYaGsV73BuSEY+b3WiX6qnxb
	hTBgLfbxfylmbiny1hiAPJhXLaX6SEFGJ844EGi4eteamdG/0DyTTuu1slzb7jMlM6nKNOZ/M+r
	ESSosRJzg+gHBU3sfhiXDgD76FLoTgBaxJoR6fkFREP5ThwYk7aNBBKGnAi2H2gWjd28sqpLeGi
	juvYeeaFvq/JpyHX6v4V1qQ==
X-Received: by 2002:a17:902:f709:b0:2e6:1735:f645 with SMTP id d9443c01a7336-2f062b91bfdmr1318055ad.4.1795213280161;
        Fri, 20 Nov 2026 14:21:20 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm5793510a91.6.2026.11.20.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:21:18 -0800 (PST)
Date: Fri, 20 Nov 2026 22:21:16 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset may
 need it
Message-ID: <awC5Ldqmue6DiO44@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
 <20261118163706.7138d246@shazbot.org>
 <20261119143237.4bf54796@shazbot.org>
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
In-Reply-To: <20261119143237.4bf54796@shazbot.org>

On Thu, Nov 19, 2026 at 02:32:37PM -0800, Alex Williamson wrote:
>On Wed, 18 Nov 2026 16:37:06 -0800
>Alex Williamson <alex@shazbot.org> wrote:
>
>> On Thu, 12 Nov 2026 23:57:00 +0000
>> Samiullah Khawaja <skhawaja@google.com> wrote:
>>
>> > Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
>> > vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
>> > upstream bridge before resetting the device, and skips the reset if the
>> > trylock fails.
>> >
>> > All VFs of a PF have the same upstream bridge. Take a device with two
>> > VFs, both used by one process. When the process is killed, both VFs can
>> > be released at the same time. The first one takes the bridge lock and
>> > does its FLR, the second one fails the trylock and is never reset.
>> >
>> > The bridge lock is only needed for a bus reset, which is done through
>> > the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
>> > resets the bus for it because the PF and the other VFs are on the same
>> > bus.
>> >
>> > Add pci_reset_needs_bridge_lock(), which returns true if any reset
>> > method enabled for the device is a bus reset, and only lock the bridge
>> > in vfio_pci_core_disable() when it does.
>> >
>> > Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> > ---
>> > Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
>> > with two VFs. Both VFs are opened through VFIO and then closed from two
>> > threads at the same time, counting FLRs with a kprobe on pcie_flr().
>> > Without this patch one VF missed its FLR in 50 of 50 rounds, with it
>> > both VFs were reset in every round. I will send a VFIO selftest for this
>> > separately.
>> > ---
>> >  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
>> >  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>> >  include/linux/pci.h              |  1 +
>> >  3 files changed, 31 insertions(+), 1 deletion(-)
>> >

[snip]

>> > +
>> > +		if (pci_reset_fn_methods[m].reset_fn == pci_reset_bus_function ||
>> > +		    pci_reset_fn_methods[m].reset_fn == cxl_reset_bus_function)
>>
>> This looks like a maintenance nightmare.  What if instead we did
>> something like:
>>
>> bool pci_parent_bus_reset_possible(struct pci_dev *dev)
>> {
>> 	struct pci_dev *pdev;
>>
>> 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
>> 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
>> 		return false;
>>
>> 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
>> 		if (pdev != dev)
>> 			return false;
>>
>> 	return true;
>> }
>> EXPORT_SYMBOL_GPL(pci_parent_bus_reset_possible);
>>
>> static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
>> {
>> 	if (!pci_parent_bus_reset_possible(dev))
>> 		return -ENOTTY;
>>
>> 	if (probe)
>> 		return 0;
>>
>> 	return pci_bridge_secondary_bus_reset(dev->bus->self);
>> }
>>
>> Where we'd then condition acquiring the bridge lock on whether it's
>> even possible for a function scoped reset to perform a bus reset.
>>
>> It's a bit broader of a test than whether we actually have the necessary
>> methods in our reset_fn list, but since we're not locking the reset_fn
>> list between test and function-reset, it's also safer.  Thanks,
>
>After exploring Ionut's patch[1], what I propose above is probably
>wrong.  We don't have any guarantees that the sibling topology is
>static and this bus-reset-possible function presents it as immutable.
>The existing bus-reset function has the same race, but the gap is
>smaller, let's not make it bigger.
>
>There are however immutable properties we can test that cover a fair
>number of cases.  For example:
>
>bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
>{
>	return pci_upstream_bridge(dev) &&
>		!(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
>}
>EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);
>
>We should be able to use this as a condition on whether we acquire the
>bridge device lock, in pci_reset_function() and in vfio-pci code.
>Thanks,

This sounds good and it will also fix the bug that I am seeing.

The only caveat is that pci_dev_wait() might fail during VF reset and
then it might try to do a bus reset if the VF is behind a pciehp or CXL
port. I would prefer to do it only for vfio-pci code as that is where
the reset skip issue is. pci_reset_function() takes the lock and
serializes the VF reset. Are you ok with doing it just for vfio-pci?

Thanks,
Sami
