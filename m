Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com [165.173.182.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9023D7FF;
	Thu, 20 Aug 2026 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230881; cv=pass; b=WM9iSN7jAWGn0BwXDSDc7Om7Sp0t3GKYdt0JfuUWctnxLkbiQ1a7D848JGZ+JcAipaACX7BO/EASiIE87h9gyPC+4EzBRBJn3lv4EowiNp0Zt/ySG+hwP92LKHFERqBjiLq0wR+aCBIPptC62a2xo8AXHREdV0BmQgYKQUVhAUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230881; c=relaxed/simple;
	bh=IqrLDo+o8ggCy+1lV0BEKJrIpQOKrldsEdmIDhLNoRo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PRTE9v9+5yyHFYOpnmU42PFJVPpw6qLgEMxm65jIdnuan7A0IntJ4X3RrpZrYl466x5mRxDR/LRolBEsyop6m6bXVIFShah8dufLK7Vz5DYb1/e2pan5IvzY3hjogB1BoMXXi1QxZ0JmEyQIFUogwQU01r2pnfFDlQMLXx+CJ9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=PSskaIrW; arc=pass smtp.client-ip=165.173.182.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="PSskaIrW"
ARC-Seal: i=1; a=rsa-sha256; t=1787230870; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=myAzGI5t0yJ0JZTzkxc6zRevGax1kMNRbn2L8QvrmxqV32JlOLjv5vFtHJffqLU8IvOB5g6dAsfXrT1RU3Y3xhJEGw3/5IeDSUTj5DqOFj5dEHW8nTYyaWanpBNmHt3+zMUCBR8UbiX7Ikev+UzLAq3QyfL/B4G0ySYepZuf+lo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1787230870; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wla6raPHtteBLHHV3A2D4+XYL2OG81Vd8BvqSX4EaZI=; 
	b=In9a6dQnbR4gv/AkSPKq2ZzpIiYs7UgY8bAU7SsCm0n9P5nkipB42+AAD782lIWzXUTK7AH+OdPlKP/DSN5mhxa19xQuQ74guCOxyzxaXE8oncRrvzaewnbtaju67kyZw6lhr75xjA7rBy6i+I5Vc+Qk8eVgVn+XKsz7V3gCxQ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787230870;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=wla6raPHtteBLHHV3A2D4+XYL2OG81Vd8BvqSX4EaZI=;
	b=PSskaIrWnbbHnbGOjvCw0HI0LA/kOHCIqsaznHBx6EhsST3akNZBE458gyhWK0OT
	Jqajk670SMTPqOm+NTRHpjqRxA03X4aWcZH4JaZB57SxQm2pqrsiZc4ecnq/sXr1sj/
	A2iQ+AqZxJP3a863PAg4AwPYfxK154L/OR2kzHmvyiOOugbY5PEL+2u3Zb6S4rryOK7
	91mIRsY/KbclMusp9bj/5kJeqjFqEJk1UhcQM16Kx6IkxXCZBo6H6xXFbsv6f+6hg3I
	0o0Wg5Qc0d/wLmXUe7OJ+me35OLS8YB5Yook6AZGMTkh66vb/auhL0rtZ7HJaGf3s25
	/MpJrUvrqQ==
Received: by mx.zohomail.com with SMTPS id 1787230866468499.0069985737126;
	Thu, 20 Aug 2026 06:01:06 -0700 (PDT)
Message-ID: <96f97cf4e509efae5891795a6eb1543db737516c.camel@rong.moe>
Subject: Re: [PATCH 0/2] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
From: Rong Zhang <i@rong.moe>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit	
 <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Huang Rui
 <ray.huang@amd.com>, 	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
In-Reply-To: <sv2id4b3qz34q2tueg4mswgagoh2xr7tsk2eafxcxsqz2z4lkd@qs2hxx5cjcyl>
References: <20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe>
		 <zm24u35jq6ruz5teu6sevoe447esrqim3gn24s4bdb7kvncz6z@rmhomnfqzwht>
		 <c5dc4cae4f4f33c98ee96d4d15da446b9fbf1f59.camel@rong.moe>
		 <sv2id4b3qz34q2tueg4mswgagoh2xr7tsk2eafxcxsqz2z4lkd@qs2hxx5cjcyl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 20:54:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Ankit,

On Thu, 2026-08-20 at 05:48 +0000, Ankit Soni wrote:
> On Thu, Aug 20, 2026 at 01:38:35AM +0800, Rong Zhang wrote:
> > Hi Ankit,
> >=20
> > Thanks for your review.
> >=20
> > On Wed, 2026-08-19 at 10:32 +0000, Ankit Soni wrote:
> > > On Tue, Aug 11, 2026 at 04:36:17AM +0800, Rong Zhang wrote:
> > > > The AMD IOMMU Initialization State Machine has the following state
> > > > transition diagram (only the very first states are showed, and the
> > > > `IOMMU_' prefix is omitted):
> > > >=20
> > > >    START_STATE
> > > >         |
> > > >         v
> > > > [0] detect_ivrs() --> NOT_FOUND
> > > >         | ok
> > > >         v
> > > >   IVRS_DETECTED
> > > >         |
> > > >         v
> > > > [1] amd_iommu_disabled? (amd_iommu=3Doff) --> IOMMU_CMDLINE_DISABLE=
D
> > > >         | no
> > > >         v
> > > > [2] early_amd_iommu_init()
> > > >         |
> > > >         +-- [3] amd_iommu_detected? (!iommu=3Doff && ...) -+
> > > >         | yes                                            |  =20
> > > >         +-- ... --> IOMMU_INIT_ERROR <-------------------+
> > > >         | ok
> > > >         v
> > > > IOMMU_ACPI_FINISHED
> > > >         |
> > > >         v
> > > >        ...
> > > >=20
>=20
> ../..
>=20
> > > > ---
> > > > Rong Zhang (2):
> > > >       iommu/amd: Do not request ACS when IOMMU is not going to be i=
nitialized
> > > >       iommu/amd: Remove ad-hoc checks that are never true
> > >=20
> > > Hi,
> > >=20
> > > Thanks for the cleanup, and the analysis of the ACS call paths matche=
s what I see.
> > > Two things worth a look before this goes in.
> > >=20
> > > 1. Patch 2: I don't think the !amd_iommu_detected check in
> > >    early_amd_iommu_init() is unreachable. pci_iommu_alloc() returns e=
arly for
> > >    xen_pv_domain() before calling amd_iommu_detect(), but Xen PV stil=
l sets
> > >=20
> > > 	x86_init.irqs.intr_mode_init =3D x86_64_probe_apic;
> > >=20
> > >    so x86_64_probe_apic() -> enable_IR_x2apic() -> irq_remapping_prep=
are() ->
> > >    amd_iommu_prepare() enters the state machine anyway, and none of t=
he new
> > >    IOMMU_START_STATE conditions are true. That check looks like
> > >    the only thing currently stopping early_amd_iommu_init() from runn=
ing
> > >    there. Could you double-check that case before dropping it?
> >=20
> > This has been resolved by PATCH 1, where the checks have been embedded
> > into the state machine.
>=20
> Agreed on patch 1 - the state machine is the right place for those checks=
 and
> I have no objection to it. My concern is only patch 2 dropping the
> "amd_iommu_detected" check.
>=20
> >=20
> > I did some quick tests by commenting out the call to amd_iommu_detect()
> > in pci_iommu_alloc(), and adding a debug WARN() to iommu_go_to_state().
> > When I booted a VM with emulated IOMMU (-device amd-iommu) and with
> > either `amd_iommu=3Doff' or `iommu=3Doff':
> >=20
> > [    0.081948] APIC: Switch to symmetric I/O mode setup
> > [    0.082553] ------------[ cut here ]------------
> > [    0.083144] init_state: 0 =3D> 9, ret: -22
> > [    0.083617] WARNING: drivers/iommu/amd/init.c:3506 at iommu_go_to_st=
ate+0xf18/0x1c00, CPU#0: swapper/0/0
> > [    0.084809] Modules linked in:
> > [    0.085122] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-0=
2579-ge0f12714fa53-dirty #38 PREEMPT(lazy)
> > [    0.086124] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.17.0-debian-1.17.0-1 04/01/2014
> > [    0.087076] RIP: 0010:iommu_go_to_state+0xf23/0x1c00
> > [    0.087629] Code: 1b e7 2c 00 eb 12 c7 05 0f e7 2c 00 06 00 00 00 eb=
 03 90 0f 0b 45 31 f6 48 8d 3d e8 90 b6 ff 8b 15 fa e6 2c 00 44 89 f1 89 de=
 <67> 48 0f b9 3a 45 85 f6 0f 84 f4 f0 ff ff e8 8a c0 73 fe 48 8b 05
> > [    0.089556] RSP: 0000:ffffffff93a03e40 EFLAGS: 00010202
> > [    0.090039] RAX: 00000000fffffff9 RBX: 0000000000000000 RCX: 0000000=
0ffffffea
> > [    0.090677] RDX: 0000000000000009 RSI: 0000000000000000 RDI: fffffff=
f93d17440
> > [    0.091338] RBP: ffff8fbd47fd5c80 R08: 3fffffffffffdfff R09: fffffff=
f93b20aa8
> > [    0.092025] R10: 0000000000000002 R11: 0000000000000002 R12: 0000000=
00000001b
> > [    0.092662] R13: 0000000000000000 R14: 00000000ffffffea R15: 0000000=
000014770
> > [    0.093319] FS:  0000000000000000(0000) GS:ffff8fbdb3634000(0000) kn=
lGS:0000000000000000
> > [    0.094055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.094572] CR2: ffff8fbd4728f000 CR3: 0000000006844000 CR4: 0000000=
0000100b0
> > [    0.095214] Call Trace:
> > [    0.095437]  <TASK>
> > [    0.095628]  amd_iommu_prepare+0x15/0x40
> > [    0.096025]  irq_remapping_prepare+0x43/0x60
> > [    0.096406]  enable_IR_x2apic+0x22/0x190
> > [    0.096759]  x86_64_probe_apic+0xa/0x50
> > [    0.097130]  apic_intr_mode_init+0x70/0xd0
> > [    0.097495]  x86_late_time_init+0x28/0x40
> > [    0.097858]  start_kernel+0x6f9/0x7a0
> > [    0.098209]  x86_64_start_reservations+0x24/0x30
> > [    0.098629]  x86_64_start_kernel+0xd1/0xe0
> > [    0.099016]  common_startup_64+0x13e/0x158
> > [    0.099393]  </TASK>
> > [    0.099595] ---[ end trace 0000000000000000 ]---
> > [    0.100266] x2apic enabled
> > [    0.100758] APIC: Switched APIC routing to: physical x2apic
> >=20
> > ...where 0 is IOMMU_START_STATE and 9 is IOMMU_CMDLINE_DISABLED.
>=20
> Commenting out amd_iommu_detect() is right way to emulate this, and the t=
race=20
> confirms the entry path. But the boot options are what make it
> come out clean: amd_iommu=3Doff / iommu=3Doff set amd_iommu_disabled / no=
_iommu,
> so IOMMU_START_STATE bails on its first if - that's the 0 =3D> 9., which
> is clearly visible above.
>=20
> But,
> Xen's own iommu=3D sits on the hypervisor command line and goes to Xen's =
parser,
> not to Linux's iommu_setup(), and there no one sets no_iommu or amd_iommu=
_disabled.
>=20
> The wider point is that amd_iommu_detect() never running is the platform =
mean
> Linux does not own this IOMMU - Xen opts out of pci_iommu_alloc() and ins=
talls
> xen_swiotlb_dma_ops instead. 'amd_iommu_detected' was the only thing maki=
ng the
> irq-remapping entry path honour that, so without it (i.e. patch 2 removes=
 it)=20
> early_amd_iommu_init() proceeds on hardware the hypervisor owns.

Ah, indeed! Skipping calling amd_iommu_detect() acts as a kill switch to
gate IOMMU initialization anyway, and `amd_iommu_detected' is used by in
this case.

That said, I believe relying on the flag to gate IOMMU initialization in
Xen PV is too late that detect_ivrs() has been called.

The whole purpose of the series is to prevent calling detect_ivrs() at
all when unnecessary. Although detect_ivrs() is effectively a no-op due
to=C2=A0Xen PV always requesting ACS, I still prefer completely skipping it=
 in
Xen PV to prevent unnecessarily getting the IVRS table and accessing the
PCI config space.

After rethinking, I propose disallowing implicit START_STATE =3D>
IVRS_DETECTED transition. IOW, the IVRS_DETECTED state can only be
requested explicitly by amd_iommu_detect(). This should also help prevent
potential bugs if more housekeeping work is added to amd_iommu_detect()
in the future. In this manner, we should be able to safely remove
`amd_iommu_detected'.

This will make parts of PATCH 1 unnecessary, but I prefer leaving PATCH 1
as is it makes the intention clearer.

I will include the proposed change in v2.

Thanks,
Rong

>=20
> -Ankit
>=20
> >=20
> > Therefore, embedding the checks into the state machine ensures the chec=
ks
> > are done in all initialization paths and makes replicating the same
> > checks in state transition methods unnecessary.
> >=20
> > >=20
> > > 2. Patch 1 Fixes: 9f81ca8d1fd6 doesn't look right - it only moved the
> > >    amd_iommu_disabled check ahead of early_amd_iommu_init() and left
> > >    IOMMU_START_STATE and detect_ivrs() alone, so ACS was requested wi=
th
> > >    amd_iommu=3Doff both before and after it. The commit that actually=
 put
> > >    pci_request_acs() on the detect path is 1adb7d31b051 ("iommu/amd: =
Fix
> > >    pci_request_acs() call-place"). I'd drop Fixes: and Cc: stable and=
 post
> > >    this as a cleanup.
> >=20
> > Makes sense. Will drop them when resubmitting. I will defer to your
> > opinion on my explanation to the first question before resubmitting :)
> >=20
> > Thanks,
> > Rong
> >=20
> > >=20
> > > -Ankit
> > >=20
> > > >=20
> > > >  drivers/iommu/amd/init.c | 36 ++++++++++++++----------------------
> > > >  1 file changed, 14 insertions(+), 22 deletions(-)
> > > > ---
> > > > base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> > > > change-id: d58d0f31-amd-iommu-fix-acs-8f3d4aba8183
> > > >=20
> > > > Thanks,
> > > > Rong
> > > >=20
