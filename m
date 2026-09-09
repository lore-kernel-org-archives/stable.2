Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684814EE866;
	Wed,  9 Sep 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949094; cv=none; b=I6XcUKuItkl/fiEqiCGL1PQ7i/zgq4qr1cw88F5ntxZtpBHwNX2bx6F2kRlbECFAcnRSO7hH/p/w2dDz/2J3k6/wU8B69U4SWUkgUE7vHy3Pk0x2NPSzPNyREQQbFClTDknFJB5Coow2+M8BLJ1r7SIV1ozIwuEM6XFHYtkZmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949094; c=relaxed/simple;
	bh=ESfukMun3UZJlSPYk/dz2ksbll6RS7m053nZO66LCuU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PRRm47sC+mztgPV41jALAOWohwHaY+nsxj/9iyxBI5luzJdXaCHpn9zgW79fl/G5REVbkfm/vo0KAgUUHWNx4Hl305hCkkPRUUnQ6pSirHj0k1b66l0emBi1GEn0KgBTRlkUW3u7I39PLtvj6JUwgck3dFiuL66sjlTGaJF8sBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKdatVq9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKdatVq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788949086; x=1820485086;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ESfukMun3UZJlSPYk/dz2ksbll6RS7m053nZO66LCuU=;
  b=MKdatVq9attIZ1k/je30aR0sIutFA+Se7ZF4VRW1lQsBlvIj3qkFiiXo
   oo9MtYl+Ln506C9f3pGBYnWhKls7Bit1dCXw3RrO1grRMFUVjEEiOZvJz
   RPHnR2vrti2+bz710A1lxMg9Ult6YwzhhHO+mqap1rQ0I4XoQaWL563XY
   jitfvLC4d4wT/+rxVE1lOJOqq7IinYnLyF3uxXk2tUAmZGgBqyU1ZjiGW
   QyCl8/BrHhjKCUSTVfAYmF8os9AqPgrjR/pG6DS8dVVWNtdJgWpc0PaeB
   PQFz2r/DdGaJBvEblcbLQyelZHcpcc+cNVUD3c+7C9lVRHT4kssdBGM8h
   Q==;
X-CSE-ConnectionGUID: pdNcFyxBRs63BSLxRUn0eg==
X-CSE-MsgGUID: EliydpHzSQimDiaV2kccAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88516259"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="88516259"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 03:17:59 -0700
X-CSE-ConnectionGUID: Vtoo3Y8BTO2pb7m85djLbQ==
X-CSE-MsgGUID: /UHi7KrhQ4W4PxO2CYV5sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294783282"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 03:17:55 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Sep 2026 13:17:51 +0300 (EEST)
To: Liz Fong-Jones <lizf@honeycomb.io>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev, 
    amd-gfx@lists.freedesktop.org, Jon Nettleton <jon@solid-run.com>, 
    Jon Nettleton <jon.nettleton@gmail.com>, 
    Jacob Martin <jacob.martin@canonical.com>, 
    Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org
Subject: Re: [PATCH v5] PCI: Fix BAR resize for devices on a root bus
In-Reply-To: <20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io>
Message-ID: <29c5916f-da42-58f0-d4c7-815bbaed711b@linux.intel.com>
References: <20260908-pci-rebar-root-bus-v5-1-a210f405ea81@honeycomb.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1291541364-1788949012=:1156"
Content-ID: <ac91299a-1cf4-4b45-b9dc-b5931e0d84f3@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1291541364-1788949012=:1156
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d4054e8f-f2bf-aa5d-601e-5f28a115bd4e@linux.intel.com>

On Tue, 8 Sep 2026, Liz Fong-Jones wrote:

> pci_do_resource_release_and_resize() releases the device BARs that
> share a bridge window with the BAR being resized, but when the device
> sits directly on a root bus (pdev->bus->self =3D=3D NULL) it then skips
> resource assignment entirely and returns success, leaving the BARs it
> just released unassigned (IORESOURCE_UNSET).
>=20
> Skipping pbus_reassign_bridge_resources() is correct in that case --
> there is no bridge window to adjust -- but the device BARs still have
> to be reassigned. Before the BAR release was consolidated into the PCI
> core, this case worked for amdgpu because the driver released the BARs
> itself and then called pci_assign_unassigned_bus_resources()
> unconditionally after the resize, which assigns unassigned device BARs
> also on a root bus. Commit db92e3fef53e ("drm/amdgpu: Remove driver
> side BAR release before resize") removed that call, so nothing assigns
> the released BARs anymore.
>=20
> This breaks amdgpu completely on the SolidRun HoneyComb LX2K (NXP
> LX2160A, arm64, ACPI), where the GPU endpoint is enumerated directly
> on the root bus of its segment (there is no root port device, so
> pdev->bus->self is NULL):
>=20
>   amdgpu 0004:01:00.0: BAR 0 [mem 0xa400000000-0xa40fffffff 64bit pref]: =
releasing
>   amdgpu 0004:01:00.0: BAR 2 [mem 0xa410000000-0xa4101fffff 64bit pref]: =
releasing
>   amdgpu 0004:01:00.0: sw_init of IP block <gmc_v8_0> failed -19
>   amdgpu 0004:01:00.0: amdgpu_device_ip_init failed
>   amdgpu 0004:01:00.0: Fatal error during GPU init
>=20
> No error is logged because the resize path reports success; amdgpu
> then finds BAR0 IORESOURCE_UNSET and bails out with -ENODEV.
>=20
> When there is no upstream bridge, call pci_bus_assign_resources() on
> the root bus to place the BARs released above, using the same
> alignment-sorted algorithm as normal enumeration instead of a manual
> per-BAR loop. This also walks the rest of the hierarchy under the
> root bus, as pci_assign_unassigned_bus_resources() used to for amdgpu
> before commit db92e3fef53e ("drm/amdgpu: Remove driver side BAR
> release before resize") removed that call -- the core-side fix that
> commit asked for ("such a problem should be fixed inside
> pci_resize_resource() instead").
>=20
> pci_bus_assign_resources() returns void, so failure is detected by
> checking whether the released BARs are still assigned afterward; if
> not, roll back as in the bridged case. This is stricter than the
> bridged path -- it fails on any unplaced resource, not just required
> ones -- since a root bus typically has one shared window, and failing
> loudly seemed better than leaving something silently unassigned.
>=20
> The root bus path also had a locking bug that any fix here necessarily
> touches: the old "goto out" jumped to up_read(&pci_bus_sem) without a
> matching down_read() (as does the "goto restore" taken when
> pci_dev_res_add_to_list() fails in the release loop). Take pci_bus_sem
> before the BAR release loop so every path through the function holds
> it exactly once.
>=20
> Use pci_upstream_bridge() rather than testing pdev->bus->self
> directly. The two are usually equivalent, but pci_upstream_bridge()
> is the canonical test -- pci_is_root_bus(), which it's built on,
> warns that bus->self =3D=3D NULL doesn't necessarily mean a root bus
> (SR-IOV virtual buses from virtfn_add_bus() are the same).
>=20
> Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path=
")
> Cc: stable@vger.kernel.org
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/215959=
6
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Assisted-by: Claude:claude-fable-5 checkpatch
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>
> ---
> #regzbot introduced: 337b1b566db0
>=20
> Observed at runtime on Ubuntu's linux-hwe-7.0 (7.0.0-14, broken) vs
> linux-hwe-6.17 (working), but nothing here is distro-specific: Ubuntu
> carries this code unmodified, and the affected function is identical
> to current mainline. By source inspection the regression window is
> v6.18 (old code paths) to v6.19 (consolidation). Workaround for
> affected users: amdgpu.rebar=3D0.
>=20
> On the topology question raised in review: this is physical hardware,
> not a virtualized guest, running the UEFI/ACPI firmware variant of
> this board (SolidRun also ships a U-Boot/devicetree variant of the
> same hardware). Deferring to Jon Nettleton (CC'd, SolidRun) on the
> exact root complex wiring; see the hardware manual's block diagram:
> https://dev.solid-run.com/nxp/lx2160a/com-som/lx2160a-com-hardware-user-m=
anual#block-diagram
> ---
> Changes in v5:
> - Per Ilpo J=E4rvinen's review of v4: use pci_bus_assign_resources()
>   instead of a manual per-BAR pci_assign_resource() loop in the
>   root-bus branch. Same outcome for the bug being fixed, but reuses
>   the core's alignment-sorted placement algorithm

Great, it worked (I was somewhat afraid there might have been some=20
landmine for the case where there's no bridge).

And yes, it's very important in general case to assign the resource in=20
correct order because the assignment algorithm is greedy.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

>   and matches the
>   design intent stated in db92e3fef53e's commit message, rather than
>   reimplementing assignment ad hoc.
> - Drop Reviewed-by from Krzysztof Wilczy=F1ski: this revision changes
>   what the root-bus branch actually does (not just a predicate, as
>   in v3's pci_upstream_bridge() change), so his v2 review doesn't
>   carry over. Add Suggested-by for Ilpo instead.
> - Add Suggested-by for Bjorn Helgaas too: overdue credit for the
>   pci_upstream_bridge() suggestion from v3 review, which only ever
>   made it into the cover letter's changelog, not the actual commit
>   trailers.
> - Link to v4: https://patch.msgid.link/20260908-pci-rebar-root-bus-v4-1-2=
780e9c22e08@honeycomb.io
>=20
> Changes in v4:
> - No functional changes. Resending per Thorsten Leemhuis (regressions
>   tracking) -- this looked to have fallen through the cracks after
>   v3. Confirmed still broken today on v7.3-rc2 (mainline) and v7.2.4
>   (stable): pci_do_resource_release_and_resize() still has the
>   original "if (!bus->self) goto out;" with no reassignment on that
>   path.
> - Rebase onto current mainline.
> - Link to v3: https://patch.msgid.link/20260731-pci-rebar-root-bus-v3-1-6=
732e233fc99@honeycomb.io
>=20
> Changes in v3:
> - Add Reviewed-by from Krzysztof Wilczy=F1ski, received on v2.
> - Use pci_upstream_bridge() instead of testing pdev->bus->self
>   directly, per Bjorn Helgaas's review: bus->self =3D=3D NULL doesn't
>   necessarily mean a root bus (SR-IOV virtfn_add_bus() buses are the
>   same), and this function is reachable for VF BAR resizes elsewhere
>   in this file. Doesn't affect the bug being fixed here (not a VF)
>   but is more correct in general. Reviewed-by kept from v2 -- this is
>   a narrow, mechanical change to a path this device doesn't exercise,
>   not a substantive rework of what was reviewed.
> - Rebase onto current mainline.
> - Add Jacob Martin to Cc: he independently triaged and accepted the
>   corresponding Ubuntu report (LP: #2159596) on the Canonical kernel
>   team, so he has direct interest in this landing.
> - Move Ilpo J=E4rvinen to To: for final review, per Bjorn.
> - Link to v2: https://patch.msgid.link/20260712-pci-rebar-root-bus-v2-1-a=
1b9107a82dc@honeycomb.io
>=20
> Changes in v2:
> - Add Assisted-by tags (missing from v1; required per
>   Documentation/process/coding-assistants.rst)
> - Add Link: to the corresponding Ubuntu bug report
> - Drop the "# v6.19+" annotation on Cc: stable; unnecessary noise
>   given the Fixes: tag already lets the stable team derive applicable
>   versions (per stable-kernel-rules.rst)
> - Link to v1: https://patch.msgid.link/20260705-pci-rebar-root-bus-v1-1-5=
5df70cbdd88@honeycomb.io
>=20
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: regressions@lists.linux.dev
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Jon Nettleton <jon@solid-run.com>
> Cc: Jon Nettleton <jon.nettleton@gmail.com>
> Cc: Jacob Martin <jacob.martin@canonical.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> ---
>  drivers/pci/setup-bus.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d3c12..ed16ef7c26fa7 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2380,6 +2380,7 @@ int pci_do_resource_release_and_resize(struct pci_d=
ev *pdev, int resno, int size
>  =09struct resource *res =3D pci_resource_n(pdev, resno);
>  =09struct pci_dev_resource *dev_res;
>  =09struct pci_bus *bus =3D pdev->bus;
> +=09struct pci_dev *bridge =3D pci_upstream_bridge(pdev);
>  =09struct resource *b_win, *r;
>  =09LIST_HEAD(saved);
>  =09unsigned int i;
> @@ -2397,6 +2398,8 @@ int pci_do_resource_release_and_resize(struct pci_d=
ev *pdev, int resno, int size
>  =09if (ret)
>  =09=09return ret;
> =20
> +=09down_read(&pci_bus_sem);
> +
>  =09pci_dev_for_each_resource(pdev, r, i) {
>  =09=09if (i >=3D PCI_BRIDGE_RESOURCES)
>  =09=09=09break;
> @@ -2415,13 +2418,21 @@ int pci_do_resource_release_and_resize(struct pci=
_dev *pdev, int resno, int size
> =20
>  =09pci_resize_resource_set_size(pdev, resno, size);
> =20
> -=09if (!bus->self)
> -=09=09goto out;
> +=09if (bridge) {
> +=09=09ret =3D pbus_reassign_bridge_resources(bus, res, &saved);
> +=09=09if (ret)
> +=09=09=09goto restore;
> +=09} else {
> +=09=09/* No bridge window to adjust; let the core reassign the bus. */
> +=09=09pci_bus_assign_resources(bus);
> =20
> -=09down_read(&pci_bus_sem);
> -=09ret =3D pbus_reassign_bridge_resources(bus, res, &saved);
> -=09if (ret)
> -=09=09goto restore;
> +=09=09list_for_each_entry(dev_res, &saved, list) {
> +=09=09=09if (!resource_assigned(dev_res->res)) {
> +=09=09=09=09ret =3D -ENOSPC;
> +=09=09=09=09goto restore;
> +=09=09=09}
> +=09=09}
> +=09}
> =20
>  out:
>  =09up_read(&pci_bus_sem);
>=20
> ---
> base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
> change-id: 20260704-pci-rebar-root-bus-f3123fe10fc7
>=20
> Best regards,
> -- =20
> Liz Fong-Jones <lizf@honeycomb.io>
>=20
--8323328-1291541364-1788949012=:1156--
