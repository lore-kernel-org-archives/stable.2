Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B33581257;
	Tue,  8 Sep 2026 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897387; cv=none; b=bmpSu+JXP0faS2e07aNV6cHXLnNoLfxRCt9oveTo5dxeLV43kuXRFBofxG6cr6azgFUTPzf0T3YbWnYJtpDdSFmIUexIeLFoganbeshsedOiH5Rni2oSNUUUYTBQ6WvT2atB/ojhR95RAexDf84OFcKCsfcuwUo8ISnBT4IdsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897387; c=relaxed/simple;
	bh=92WNq9IfnRE2rL4eWooUtSOzTsGKkpp2lqGcKMajoB4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JNmVzTLJQdaxFxVMpl6dKT3eX60KneuLMAS1ss3HqBn3CN1dGRtyz+XnFnkho2N9plIKYkViIsjgUbgSKNNB8FoIoshRJ7kE9lcPUV5wHs1k4HB2ldHsDb0Fr5pM7cou7j1OMXL387BjYc/4FReH1XNdvIc22ylOFGrFBwtI45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i4QZY7QG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4QZY7QG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788897385; x=1820433385;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=92WNq9IfnRE2rL4eWooUtSOzTsGKkpp2lqGcKMajoB4=;
  b=i4QZY7QGENeoLRuV3dOkrSRIKuzh709uqpMF5I5RgDhZNkhwpKstkuqm
   XJUw1y5b5qhxem1DQH1XiPTrGVZWxI4+AB4FGPtx67O6uMF99LhC6nXkv
   CpxEGWWyWzehVv06vXgdDZ/o4GduXRhLqbL4nsl/m/ZrBSGIyZKVzWQyH
   4nXi1dihRjSxSJhvqDOmm35hQl6MuZOZa3UXxbYpob4rcNc1iNzIJpQOl
   PfR2W+Dh65e3lUcDi+ntws6ho9/ohXamFHjId5lvO4Msrf1RQZKmOu8bj
   XiDpSxNDdvqAg9QspexZ9kl2g+uSrNLGM4xnF8oHvD3ngfJlzgfD9V8Zu
   A==;
X-CSE-ConnectionGUID: MLCC5J9DTryABYHEZgi1cQ==
X-CSE-MsgGUID: 13bKP4sUSJyRvdkG1c/YPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100832550"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="100832550"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 12:56:24 -0700
X-CSE-ConnectionGUID: UwuuMuwAQvCQ9Bk8kTaOrQ==
X-CSE-MsgGUID: IYs5WnooRVaQr7up1rF9zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="300970475"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.109])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 12:56:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 8 Sep 2026 22:56:16 +0300 (EEST)
To: Liz Fong-Jones <lizf@honeycomb.io>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev, 
    amd-gfx@lists.freedesktop.org, Jon Nettleton <jon@solid-run.com>, 
    Jon Nettleton <jon.nettleton@gmail.com>, 
    Jacob Martin <jacob.martin@canonical.com>, 
    Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v4] PCI: Fix BAR resize for devices on a root bus
In-Reply-To: <20260908-pci-rebar-root-bus-v4-1-2780e9c22e08@honeycomb.io>
Message-ID: <8866d915-56d1-312b-ae68-b65021abd914@linux.intel.com>
References: <20260908-pci-rebar-root-bus-v4-1-2780e9c22e08@honeycomb.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-308109410-1788897376=:1164"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-308109410-1788897376=:1164
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

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
> Assign the released BARs directly from the root bus windows when there
> is no upstream bridge. On failure, roll back through the existing
> restore path exactly as in the bridged case.
>=20
> The root bus path also had a locking bug that any fix here necessarily
> touches: the old "goto out" jumped to up_read(&pci_bus_sem) without a
> matching down_read() (as does the "goto restore" taken when
> pci_dev_res_add_to_list() fails in the release loop). Take pci_bus_sem
> before the BAR release loop so every path through the function holds
> it exactly once.
>=20
> Use pci_upstream_bridge() rather than testing pdev->bus->self
> directly to decide whether the device has an upstream bridge. The two
> are usually equivalent, but pci_is_root_bus() -- which
> pci_upstream_bridge() uses internally -- documents that "virtual"
> buses added for SR-IOV via virtfn_add_bus() also have bus->self =3D=3D
> NULL without being root buses. pci_do_resource_release_and_resize()
> is reachable for VF BAR resizes (see the pci_resource_is_iov() checks
> elsewhere in this file and in rebar.c), so testing bus->self directly
> could misroute a VF resize into the root-bus assignment path added
> above. Nothing about the bug being fixed here involves a VF; this is
> purely for correctness on that path.
>=20
> Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path=
")
> Cc: stable@vger.kernel.org
> Link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-7.0/+bug/215959=
6
> Assisted-by: Claude:claude-fable-5 checkpatch
> Assisted-by: Claude:claude-sonnet-5
> Reviewed-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
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
> - Add Reviewed-by from Krzysztof Wilczy=C5=84ski, received on v2.
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
> - Move Ilpo J=C3=A4rvinen to To: for final review, per Bjorn.
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
> To: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: regressions@lists.linux.dev
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Jon Nettleton <jon@solid-run.com>
> Cc: Jon Nettleton <jon.nettleton@gmail.com>
> Cc: Jacob Martin <jacob.martin@canonical.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> ---
>  drivers/pci/setup-bus.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e8c94aa1d3c1..9907dc5521aa 100644
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
> @@ -2415,13 +2418,24 @@ int pci_do_resource_release_and_resize(struct pci=
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
> +=09=09/*
> +=09=09 * A device on a root bus has no bridge windows to adjust.
> +=09=09 * Assign the BARs released above directly from the root bus
> +=09=09 * windows.
> +=09=09 */
> +=09=09list_for_each_entry(dev_res, &saved, list) {
> +=09=09=09i =3D pci_resource_num(pdev, dev_res->res);
> =20
> -=09down_read(&pci_bus_sem);
> -=09ret =3D pbus_reassign_bridge_resources(bus, res, &saved);
> -=09if (ret)
> -=09=09goto restore;
> +=09=09=09ret =3D pci_assign_resource(pdev, i);
> +=09=09=09if (ret)
> +=09=09=09=09goto restore;

Maybe this is what has to be done here, but I wonder if this could use=20
pci_bus_assign_resources()?

--=20
 i.

--8323328-308109410-1788897376=:1164--
