Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167132A3FE;
	Wed, 19 Aug 2026 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161449; cv=pass; b=nt8xfekRYVbQrWPpfrEc2YgdUYYaCmzap/wufQyCFxFNbrHRWQYE1Kvb4e2Z5+QV9MXXr4HaEt8eQ2ud+HKG+EWG/1esjRdhJmOfkDjaZK63JERHO3KnxxrIa4EP45GNXHAMkszDbr9OrDohPpnOFlX8CRTxo17tz8fgL668e7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161449; c=relaxed/simple;
	bh=zoml0604Hk368cD4ThGyEaxHhqMObCUkMl0mUFuPWpo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Z+YoBulrlCDnGZf1p4O9QMfht8JddYPkCSm7YLdjKvdxr0Gehu/6tjXCnidMbVHvtIJWQrznA/s50hzz3afickZrcj8J87dXBze+fxVUeOR2e+xjuybxZ4XIJqEK5vugCI8zfwb9UJJo0vi3GHa+Y+5OaEWbgA14Jy1Mke3+7oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=pCqXQpDZ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="pCqXQpDZ"
ARC-Seal: i=1; a=rsa-sha256; t=1787161435; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jlPBFvVNB7ANx7KcoCvqkMDVeVPGQu9CZPxTcBfC/laJLL2JkTxf4vTYmIotIUv5mpz5aOEXSi1AWzQWx4RTV7kTv/o4k6f/u2R29jA1HnzAgvjdI5FdTgZ04zJmdgGtpSktVsH1DcGYf27LIAL2WCy+xNkeb+P8LNCTzoPv8o0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787161435; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cD9Om299Pjgub1y5Untoy91MwqEVCH/vm59izD2DJlU=; 
	b=LLsHOb30WXjfX1mFhAuFB4Yz2Axo8purSyrT5vW2RRufw58kPIEY9UF0b5YISZoQjZqQBJsSeKcn7FovMnwyA6Ti31OIS0yJf7ajsAd11hrPeViqeYnaozLxgcL35U+qxklvnSXoeIbGxm+Z9BM7uLJkzM9G6P8JyLNm+5OrnnY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787161435;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=cD9Om299Pjgub1y5Untoy91MwqEVCH/vm59izD2DJlU=;
	b=pCqXQpDZ8nY2I2VfDguZdgnR0Ey3i8+M1yEP+2PkT9zCH8C86agk0dOPQsg4c11n
	4uq7eORsCegsPbbQm+Qab/4lkjJ183nqnNvMQdQPnAE8xfTDHtkmTNSQrnrlMCPXNVT
	1U2b+1s7ETfD6WN+VGUi1HMv/zm2qtHOCMOAhb40Av6VXwXffvtfVaPPiKcfr29t/cC
	M+kRco3ghYaaXAAGxJ2WZsl7gLKB3xiPAvU/NTi1MP9gOrC9MdyjqtOQ9fERFi6ILpG
	y2FvNVQqQQ/N2fsbBXjwf1pApI36nEDrqA1tNI1HWAnSSRyUbjd3q+I7AOd+wbrptNn
	EVC6n2lJMA==
Received: by mx.zohomail.com with SMTPS id 1787161433743255.80128562505138;
	Wed, 19 Aug 2026 10:43:53 -0700 (PDT)
Message-ID: <c5dc4cae4f4f33c98ee96d4d15da446b9fbf1f59.camel@rong.moe>
Subject: Re: [PATCH 0/2] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
From: Rong Zhang <i@rong.moe>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit	
 <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
 <jroedel@suse.de>,  Huang Rui <ray.huang@amd.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
In-Reply-To: <zm24u35jq6ruz5teu6sevoe447esrqim3gn24s4bdb7kvncz6z@rmhomnfqzwht>
References: <20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe>
		 <zm24u35jq6ruz5teu6sevoe447esrqim3gn24s4bdb7kvncz6z@rmhomnfqzwht>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 01:38:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Ankit,

Thanks for your review.

On Wed, 2026-08-19 at 10:32 +0000, Ankit Soni wrote:
> On Tue, Aug 11, 2026 at 04:36:17AM +0800, Rong Zhang wrote:
> > The AMD IOMMU Initialization State Machine has the following state
> > transition diagram (only the very first states are showed, and the
> > `IOMMU_' prefix is omitted):
> >=20
> >    START_STATE
> >         |
> >         v
> > [0] detect_ivrs() --> NOT_FOUND
> >         | ok
> >         v
> >   IVRS_DETECTED
> >         |
> >         v
> > [1] amd_iommu_disabled? (amd_iommu=3Doff) --> IOMMU_CMDLINE_DISABLED
> >         | no
> >         v
> > [2] early_amd_iommu_init()
> >         |
> >         +-- [3] amd_iommu_detected? (!iommu=3Doff && ...) -+
> >         | yes                                            |  =20
> >         +-- ... --> IOMMU_INIT_ERROR <-------------------+
> >         | ok
> >         v
> > IOMMU_ACPI_FINISHED
> >         |
> >         v
> >        ...
> >=20
> > [0] always calls pci_request_acs() as long as there's a valid IVRS tabl=
e
> > and no Stoney Ridge graphics. This is not optimal as ACS is not require=
d
> > in an [amd_]iommu=3Doff boot.
> >=20
> > In a normal boot, ACS is requested due to amd_iommu_detect() requesting
> > IVRS_DETECTED.
> >=20
> >     pci_request_acs+0x9/0x18
> >     iommu_go_to_state+0x106/0x1a20
> >     amd_iommu_detect+0x1c/0x50
> >     pci_iommu_alloc+0x26/0x40
> >     mm_core_init+0xa/0x120
> >     start_kernel+0x527/0x7a0
> >     x86_64_start_reservations+0x24/0x30
> >     x86_64_start_kernel+0xd1/0xe0
> >     common_startup_64+0x13e/0x158
> >=20
> > This is intended to ensure ACS is requested before the PCI core
> > initialization, or else a !CONFIG_IRQ_REMAP, nointremap or intremap=3Do=
ff
> > boot would be broken.
> >=20
> > However, in an amd_iommu=3Doff boot, the state machine still requests A=
CS
> > at the exact same time, as amd_iommu_detect() has nothing to do with
> > amd_iommu_disabled.
> >=20
> > Even worse, in an iommu=3Doff boot, though amd_iommu_detect() bails out
> > early, ACS is still requested due to amd_iommu_prepare() requesting
> > IOMMU_ACPI_FINISHED, which is called by irq_remapping_prepare() thanks
> > to CONFIG_X86_LOCAL_APIC (always set on X86_64) and CONFIG_IRQ_REMAP
> > (enabled by defconfig), unless nointremap or intremap=3Doff is also pas=
sed
> > to cmdline.
> >=20
> >     pci_request_acs+0x9/0x18
> >     iommu_go_to_state+0x106/0x1a20
> >     amd_iommu_prepare+0x15/0x40
> >     irq_remapping_prepare+0x43/0x60
> >     enable_IR_x2apic+0x22/0x190
> >     x86_64_probe_apic+0xa/0x50
> >     apic_intr_mode_init+0x70/0xd0
> >     x86_late_time_init+0x28/0x40
> >     start_kernel+0x6f9/0x7a0
> >     ...
> >=20
> > In both cases, [2] is still gated due to the [1] or [3] check, so that
> > IOMMU can be disabled per cmdline.
> >=20
> > Technically, it makes no sense to detect IVRS at all in an
> > [amd_]iommu=3Doff boot or if IOMMU is not supported due to platform
> > settings. This is probably why amd_iommu_detect() bails out before
> > requesting IVRS_DETECTED. Apparently only bailing out there is not
> > sufficient, and the bailing-out paths should really have been parts of
> > the state machine.
> >=20
> > Fix it by moving the bailing-out paths and [1] to the right place in th=
e
> > state machine (i.e., before [0]), and always requesting IVRS_DETECTED i=
n
> > amd_iommu_detect() to initialize the state machine early and properly.
> > This doesn't change the IOMMU initialization/failure sequence since
> > commit 9f81ca8d1fd6 ("iommu/amd: Don't call early_amd_iommu_init() when
> > AMD IOMMU is disabled").
> >=20
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> > Rong Zhang (2):
> >       iommu/amd: Do not request ACS when IOMMU is not going to be initi=
alized
> >       iommu/amd: Remove ad-hoc checks that are never true
>=20
> Hi,
>=20
> Thanks for the cleanup, and the analysis of the ACS call paths matches wh=
at I see.
> Two things worth a look before this goes in.
>=20
> 1. Patch 2: I don't think the !amd_iommu_detected check in
>    early_amd_iommu_init() is unreachable. pci_iommu_alloc() returns early=
 for
>    xen_pv_domain() before calling amd_iommu_detect(), but Xen PV still se=
ts
>=20
> 	x86_init.irqs.intr_mode_init =3D x86_64_probe_apic;
>=20
>    so x86_64_probe_apic() -> enable_IR_x2apic() -> irq_remapping_prepare(=
) ->
>    amd_iommu_prepare() enters the state machine anyway, and none of the n=
ew
>    IOMMU_START_STATE conditions are true. That check looks like
>    the only thing currently stopping early_amd_iommu_init() from running
>    there. Could you double-check that case before dropping it?

This has been resolved by PATCH 1, where the checks have been embedded
into the state machine.

I did some quick tests by commenting out the call to amd_iommu_detect()
in pci_iommu_alloc(), and adding a debug WARN() to iommu_go_to_state().
When I booted a VM with emulated IOMMU (-device amd-iommu) and with
either `amd_iommu=3Doff' or `iommu=3Doff':

[    0.081948] APIC: Switch to symmetric I/O mode setup
[    0.082553] ------------[ cut here ]------------
[    0.083144] init_state: 0 =3D> 9, ret: -22
[    0.083617] WARNING: drivers/iommu/amd/init.c:3506 at iommu_go_to_state+=
0xf18/0x1c00, CPU#0: swapper/0/0
[    0.084809] Modules linked in:
[    0.085122] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-02579=
-ge0f12714fa53-dirty #38 PREEMPT(lazy)
[    0.086124] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
7.0-debian-1.17.0-1 04/01/2014
[    0.087076] RIP: 0010:iommu_go_to_state+0xf23/0x1c00
[    0.087629] Code: 1b e7 2c 00 eb 12 c7 05 0f e7 2c 00 06 00 00 00 eb 03 =
90 0f 0b 45 31 f6 48 8d 3d e8 90 b6 ff 8b 15 fa e6 2c 00 44 89 f1 89 de <67=
> 48 0f b9 3a 45 85 f6 0f 84 f4 f0 ff ff e8 8a c0 73 fe 48 8b 05
[    0.089556] RSP: 0000:ffffffff93a03e40 EFLAGS: 00010202
[    0.090039] RAX: 00000000fffffff9 RBX: 0000000000000000 RCX: 00000000fff=
fffea
[    0.090677] RDX: 0000000000000009 RSI: 0000000000000000 RDI: ffffffff93d=
17440
[    0.091338] RBP: ffff8fbd47fd5c80 R08: 3fffffffffffdfff R09: ffffffff93b=
20aa8
[    0.092025] R10: 0000000000000002 R11: 0000000000000002 R12: 00000000000=
0001b
[    0.092662] R13: 0000000000000000 R14: 00000000ffffffea R15: 00000000000=
14770
[    0.093319] FS:  0000000000000000(0000) GS:ffff8fbdb3634000(0000) knlGS:=
0000000000000000
[    0.094055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.094572] CR2: ffff8fbd4728f000 CR3: 0000000006844000 CR4: 00000000000=
100b0
[    0.095214] Call Trace:
[    0.095437]  <TASK>
[    0.095628]  amd_iommu_prepare+0x15/0x40
[    0.096025]  irq_remapping_prepare+0x43/0x60
[    0.096406]  enable_IR_x2apic+0x22/0x190
[    0.096759]  x86_64_probe_apic+0xa/0x50
[    0.097130]  apic_intr_mode_init+0x70/0xd0
[    0.097495]  x86_late_time_init+0x28/0x40
[    0.097858]  start_kernel+0x6f9/0x7a0
[    0.098209]  x86_64_start_reservations+0x24/0x30
[    0.098629]  x86_64_start_kernel+0xd1/0xe0
[    0.099016]  common_startup_64+0x13e/0x158
[    0.099393]  </TASK>
[    0.099595] ---[ end trace 0000000000000000 ]---
[    0.100266] x2apic enabled
[    0.100758] APIC: Switched APIC routing to: physical x2apic

...where 0 is IOMMU_START_STATE and 9 is IOMMU_CMDLINE_DISABLED.

Therefore, embedding the checks into the state machine ensures the checks
are done in all initialization paths and makes replicating the same
checks in state transition methods unnecessary.

>=20
> 2. Patch 1 Fixes: 9f81ca8d1fd6 doesn't look right - it only moved the
>    amd_iommu_disabled check ahead of early_amd_iommu_init() and left
>    IOMMU_START_STATE and detect_ivrs() alone, so ACS was requested with
>    amd_iommu=3Doff both before and after it. The commit that actually put
>    pci_request_acs() on the detect path is 1adb7d31b051 ("iommu/amd: Fix
>    pci_request_acs() call-place"). I'd drop Fixes: and Cc: stable and pos=
t
>    this as a cleanup.

Makes sense. Will drop them when resubmitting. I will defer to your
opinion on my explanation to the first question before resubmitting :)

Thanks,
Rong

>=20
> -Ankit
>=20
> >=20
> >  drivers/iommu/amd/init.c | 36 ++++++++++++++----------------------
> >  1 file changed, 14 insertions(+), 22 deletions(-)
> > ---
> > base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> > change-id: d58d0f31-amd-iommu-fix-acs-8f3d4aba8183
> >=20
> > Thanks,
> > Rong
> >=20
