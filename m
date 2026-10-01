Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAFF50AC33;
	Thu,  1 Oct 2026 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869190; cv=fail; b=n3SlCzqhbeHJF/bw6lfbalK4fo5IG1b/Bj9oJtgIXk9fjVGClyYbJdcIWEDC3VkNr+E44yJI94Tk3pdm7ogFMEm+CVW5iQcGHG+3dvz7Onwj/Yxr3fhtjkkPofa3dMRexA6q7INX/oxQQgwkB55nrVUdKrp9glzXzlhuHLlZLHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869190; c=relaxed/simple;
	bh=UnBJ3y8FRe92oba3Tl57f6o/ZIpthmMyRo85oZchM3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkMDU4jW7mel76ZzMAQ9+aEPV10GfmhMOGI9Uu2RakQyTBC1Qso9tbk6zEdg14qwS3b2sMl8n5vavdNWsNXnetHpTwPFS/b959oUFIuoSG65gUxFMu/1ZIFaA7bW7DTknI4BjUpa1fQylnMqw6izNO/cq5k1bwxSv1Q13ocP+Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=HzZ1fnSy; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="HzZ1fnSy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOPPHNuuJSR7xnMm+/mr7MUTllbWAvKTvm3yKbEVvN2zK5HyVrC3W0589QbZuXNwPdc8XbAI/s4hABNH8y3TuzIe9oe7IJSjsx8Q05EWiGU86AjNqFmMiORSmLu3CetjD254Bn6SG4Ch+37MJVYkVDxQIlBygPirGsKFqbVLk2j8yLIzJd4NiaGYwGL6ZOyOhyw/cwmOPag4ZC7pXz3hmm/oRAbow2YBB2+vj6Pq63Kc66rgLN2Fnhltjd2j7mK+i1NTOFcMDlac59Usqfn49ULtbiRbeXOvk0wiSuAHWenX3KnmPCoBrAjoqC0W+ioo2/koPixYbW5EKZKkTYgpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxe+vwedGxpMCfXVWQZqKuNY6MtpNRD99v8QTThvdnE=;
 b=POds5NANS8g1gUorcmqefjmbljz20/qQeAD8ypNC86xiYiwKxoSPilf//k0N3xWbx1igKMRjLKDBZZ4vOwV3oMiXRvkXeMxDzZobYyLVRjDOD4zCNSUcCD2g3dyKsaTr/7baA6HPoNo3wcxp6QgNkf8XMIUfR/z/S6/8IXhNhek3CL/mTvXcRuQH8o+63jHUQFmspjJj3t+x4ugPq813+sD3LXATPJ4UPoMV7yz0Qssd2aJtWZUPQI6b8LwP9ETiFMwzDqAzTS16e+dx6n+6rVRlJNsjiSLYqhw55i9DN/XT3JJeoSqns0enDZtNMAe6CN+43J9BvSLYS9ZFFDgl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxe+vwedGxpMCfXVWQZqKuNY6MtpNRD99v8QTThvdnE=;
 b=HzZ1fnSyA16SiwaTJlVOy7DiEH1RVhxFuiLjdcl35k0d5LcAuCGaGakpwnDqdzVUIG/xZRCU6hDS+FlGH1Q/Oy0ElUWqLSuD4FeMYj1FLiRrk9YYslACMsA/EKYyFxXHLeejseShhVsECFkU1XSpF68tXeQE0YPUbPK8PEJFUruB3QxsCRsHYEAJySZ2GSX8bvORkgqM4VCDnzyKIJRXDewt/AoxAW6+GmhhyRG/oqowgJfDaqugovRSa4dVCyV7n33Ccke2bh3sjez9n+W4o7dBGY7W2zQ/7R+wsts+nj7i09hNm5V8gJUTc3ItyfszW/fhSXqyV7uROSnhEb/O7A==
Received: from MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23)
 by LV2PR22MB3584.namprd22.prod.outlook.com (2603:10b6:408:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 15:39:41 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:303:8d:cafe::10) by MW4PR03CA0168.outlook.office365.com
 (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 15:39:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 165.85.157.49) smtp.mailfrom=gehealthcare.com; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 15:39:40 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 7EA7E1FD89;
	Thu,  1 Oct 2026 18:39:37 +0300 (EEST)
Date: Thu, 1 Oct 2026 18:39:37 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>, stable@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ian.ray@gehealthcare.com
Subject: Re: [PATCH] mmc: core: Don't program invalid host driver type for
 fixed eMMC type
Message-ID: <ar5-udUwk8JeB-ut@zeus>
References: <20260926122908.866-1-ian.ray@gehealthcare.com>
 <CAPx+jO-59V8bg+DB4pOqEmdPZrfLi098YsyzkBRnf2Krb7ufVA@mail.gmail.com>
 <791c00cf-4f25-423c-b2f3-4cdc2d2c4a2b@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <791c00cf-4f25-423c-b2f3-4cdc2d2c4a2b@intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|LV2PR22MB3584:EE_
X-MS-Office365-Filtering-Correlation-Id: 56b95d31-2cd9-4157-7487-08df1fd23550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|11063799006|56012099006|4143699003|6133799003|3023799007|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RGLAIXUAFTSGtTrXCpr4K8zuvh9i3VW7LFfhQKEoOMw1dIJrbOayHIXmv0GOiz5Mh825oGaNp83aBm4XqIet3iGCt0Z4AIFPU9y3lNNnX6UGWCfB27Fb2GM7JBKcgzPygNJJ043764Czalr0BG+/VblPBRcW6CLIk9AVrQ7Y5z5JuYZEI4yfnDiyGs3H0rFh5w7py9BiAnW1mQkW4r8/C/b0ZAEP8v2g0zkIe9LXAAsIsPZT0J/V0XOcKVBe3eRE4/LbMrPZYLmta354njwI4rLE3uQzRvo2pnZJMrSrcZOmMSxcG0C9UYQRmxdscp/RkgaI5KyyECsKIAsizCzGXtAE+OSHFfnOut0mmNHdeoQra6Pmv67grn1TIZm97klHPWPYOWQ7qPLWQiC3icCM9lO1ovEj/z7euvljWWrNUT108MlqGZ59Rhmf1Zmo8ZU6aZ/x+o1NL5hNlZ6iE6+CYjyGLhslzADSrxowSxOEFSzdqapkdizfWxXHDqa2YnTIfFX08o0+SYUONBT5jd0qhO3Nqw7mnehaCURRsABzUYO37RSVQ3gMxFtrAan0uAUXpDP9EMMHCnoG7fK8efAVM3w12JnCjRtOliwlSEhLRULW48m6ZVIAS/eE0813vRufYiSM5GrWQcSryyN032c3v5MnnI8yrxlMIyjz7H5AgRhv3aazod5t/HZc43D9aK6Dmsk+6j1bVssBp48G8qU/5g==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(6133799003)(3023799007)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E3HkO71gudEq4I11/NxlJ4mkyPxrRoQ8JdgkLq4KCK7IZM+fNilTi1z1JO4Pb7nmLhjj6IqwQK8CmA2TKZcybojtMo8eVt989+uXKE7unADvLLplj9oR5jW4db6wNN1qrnlKQ7J1cDDQfcM60WR9uWyqg78LWILf4BTUQwcgO5KT8NazYxXEtQO3KLd9bNbfuWN6FF74uW28gl8w9fxedPr6JA/ZqlNF2F4CJU+WC8R9r52GvDvq6E2bWtZwXqMMbAkO6FQQVdrBiqVGCOtO116XJxig/IY5fSnIjyJU/4eSz7b/t0GJM7Z6Bc4H9ZmRPf4F1jrtJTGEcK8eJ2gRqn5XAyg4p9l2ZLd4/z7teI0DqTcqPm0WDp9Mffz8wgZK/jRFoqeEizA0LxdIeid9LtXyB4R1m4hE6JmxxSXiRCen4DkzH3apzG0x4zJ/Qqn6
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:39:40.3274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b95d31-2cd9-4157-7487-08df1fd23550
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR22MB3584

On Wed, Sep 30, 2026 at 10:00:47PM +0300, Adrian Hunter wrote:
> On 29/09/2026 16:06, Ulf Hansson wrote:
> > + Adrian
> >
> > On Sat, Sep 26, 2026 at 2:29 PM Ian Ray <ian.ray@gehealthcare.com> wrote:
> >>
> >> The host controller driver type value used by the MMC core [1] _mostly_
> >> overlaps with the eMMC device I/O driver strength value [2] as shown in
> >> the table below; however, there is _no_ host mapping for eMMC value 4.
> >
> > I think the mapping exists only because that is what the SD spec
> > provided when this was introduced.
> >
> > We can certainly add something that corresponds to value 4 from the
> > eMMC spec as well, to make this complete.
> >
> >>
> >>   host value/type   | eMMC value | nominal impedance | strength
> >>   ------------------+------------+-------------------+---------
> >>   0 / Type B        | 0          | 50 Ohm            | x1
> >>   1 / Type A        | 1          | 33 Ohm            | x1.5
> >>   2 / Type C        | 2          | 66 Ohm            | x0.75
> >>   3 / Type D        | 3          | 100 Ohm           | x0.5
> >>   (none)            | 4          | 40 Ohm            | x1.2
> >>
> >> [1] MMC_SET_DRIVER_TYPE_* in include/linux/mmc/host.h
> >>
> >> [2] 'fixed-emmc-driver-type', see JESD84-B51 Table 206 and
> >>
> >>
> >> Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
> >> for fixed driver type"), the selected eMMC driver strength is passed
> >> directly to mmc_set_driver_type().  For a fixed eMMC driver type of 4
> >> this reaches sdhci_set_ios(), which only knows types 0..3 and therefore
> >> complains on every ios update:
> >>
> >>   mmc2: invalid driver type, default to driver type B
> >
> > Perhaps the print above from sdhci_set_ios() is simply a bit
> > misleading. For example, it looks like arasan_select_phy_clock()
> > actually uses the value in ios.drv_type as is.
> >
> > To me, it looks like the problem is that mmc_select_drive_strength()
> > doesn't really do its job correctly, as it should help us to figure
> > out what is supported by the card *and* by the host, so we can request
> > a proper driver type when calling the ->set_ios() callback.
> 
> mmc_select_drive_strength() returns the card value directly and
> the host value in *drv_type.
> 
> fixed-emmc-driver-type as described by
> Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
> doesn't mention the host controller, and the original commits
> 6186d06c519e2 "mmc: parse new binding for eMMC fixed driver type"
> be17f1ce8572d "mmc: core: properly init drv_type" seemingly
> deliberately left it alone.
> 
> 5a52c5701a67d "mmc: core: Fix host controller programming for
> fixed driver type" introduces a new policy: fixed-emmc-driver-type
> is a host controller setting also.
> 
> If that was done by mmc_select_drive_strength(), it would look
> something like below ( note it no longer allows fixed_drv_type to override
> ->select_drive_strength() , and fixed-emmc-driver-type will then hit
> any nonremovable SD or SDIO ):
> 
> int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
>                               int card_drv_type, int *drv_type)
> {
>         struct mmc_host *host = card->host;
>         int fixed_drv_type = host->fixed_drv_type;
>         int host_drv_type = SD_DRIVER_TYPE_B;
> 
>         *drv_type = 0;
> 
>         if (!host->ops->select_drive_strength) {
>                 if (fixed_drv_type >= 0 &&
>                     (card_drv_type & mmc_driver_type_mask(fixed_drv_type))) {
>                         *drv_type = fixed_drv_type;
>                         return fixed_drv_type;
>                 }
>                 return 0;
>         }
> 
>         /* Use SD definition of driver strength for hosts */
>         if (host->caps & MMC_CAP_DRIVER_TYPE_A)
>                 host_drv_type |= SD_DRIVER_TYPE_A;
> 
>         if (host->caps & MMC_CAP_DRIVER_TYPE_C)
>                 host_drv_type |= SD_DRIVER_TYPE_C;
> 
>         if (host->caps & MMC_CAP_DRIVER_TYPE_D)
>                 host_drv_type |= SD_DRIVER_TYPE_D;
> 
>         /*
>          * The drive strength that the hardware can support
>          * depends on the board design.  Pass the appropriate
>          * information and let the hardware specific code
>          * return what is possible given the options
>          */
>         return host->ops->select_drive_strength(card, max_dtr,
>                                                 host_drv_type,
>                                                 card_drv_type,
>                                                 drv_type);
> }
> 
> and:
> 
> static void mmc_select_driver_type(struct mmc_card *card)
> {
>         int card_drv_type, drive_strength, drv_type = 0;
> 
>         card_drv_type = card->ext_csd.raw_driver_strength |
>                         mmc_driver_type_mask(0);
> 
>         drive_strength = mmc_select_drive_strength(card,
>                                                    card->ext_csd.hs200_max_dtr,
>                                                    card_drv_type, &drv_type);
> 
>         card->drive_strength = drive_strength;
> 
>         if (drv_type)
>                 mmc_set_driver_type(card->host, drv_type);
> }
> 
> But that doesn't help with drivers where the controller does
> do not support the value passed by fixed-emmc-driver-type even
> though the card does.  mmc_select_drive_strength() has no way
> of knowing that.  The ->select_drive_strength() callback
> allows selecting different values. fixed-emmc-driver-type is
> one value.
> 
> The warning in sdhci.c seems correct.  SDHCI is an SD standard,
> so doesn't define value 4 (and only has 2 bits for the field).
> The selected driver strength is not being programmed - deserves
> a warning.
> 
> Perhaps if the affected driver implements
> ->select_drive_strength():
> 
> static int ???_select_drive_strength(struct mmc_card *card,
>                                      unsigned int max_dtr, int host_drv,
>                                      int card_drv, int *host_driver_strength)
> {
>         struct mmc_host *host = card->host;
>         int fixed_drv_type = host->fixed_drv_type;
> 
>         if (fixed_drv_type >= 0 &&
>             (card_drv & mmc_driver_type_mask(fixed_drv_type))) {
>                 if (fixed_drv_type == 4)
>                         *drv_type = MMC_SET_DRIVER_TYPE_B;
>                 else
>                         *drv_type = fixed_drv_type;
>                 return fixed_drv_type;
>         }
>         return 0;
> }
> 
> But that requires the changes to
> mmc_select_drive_strength() and mmc_select_driver_type()
> above (with its caveats), so that ->select_drive_strength()
> overrides fixed-emmc-driver-type.  That would be fine for
> drivers/mmc/host/sdhci-pci-core.c, and probably
> amd_select_drive_strength(), but it is starting to get
> complicated.
> 
> A simpler alternative is for the affected driver to hook
> ->set_ios() and fix up the value.
> 
> void ???_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> {
>         if (ios->drv_type == 4)
>                 ios->drv_type = MMC_SET_DRIVER_TYPE_B;
> 
>         return sdhci_set_ios(mmc, ios);
> }
> 
> And in probe (assuming struct sdhci_host *host):
> 
>         host->mmc_host_ops.set_ios = ???_set_ios;
> 

Thank you for the feedback.

The "invalid driver type" warning that I originally observed originates
in sdhci_set_ios_common() which is shared by all SDHCI hosts (IIUC).

Thus any SDHCI host configured with `fixed-emmc-driver-type = <4>` would
log that warning.

The affected driver for my scenario is sdhci-esdhc-imx.c, and the
proposed change (below) suppresses the warning.

But I am hesitant to open-code the same fixup in every SDHCI driver.
And I am unsure whether this belongs per-driver, or whether the right
fix is in the core / or to the warning itself.

Comments welcome!

drivers/mmc/host/sdhci-esdhc-imx.c

```
static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
{
       /*
        * A drv_type of 4 reaches this callback only via the eMMC
        * 'fixed-emmc-driver-type' path: it is the eMMC I/O driver strength
        * value 4 (40 Ohm, see JESD84-B51 Table 206), which has no equivalent
        * host driver type in the SD standard that SDHCI implements (only
        * types B/A/C/D are defined).  Map it to the default Type B here to
        * avoid an "invalid driver type" warning from sdhci_set_ios().  The
        * card's HS_TIMING field is programmed separately from
        * card->drive_strength and is unaffected.
        */
       if (ios->drv_type == 4)
               ios->drv_type = MMC_SET_DRIVER_TYPE_B;

       sdhci_set_ios(mmc, ios);
}

static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
{
...
               /*
                * Support fix up of eMMC driver types which have no SDHCI
                * host driver type equivalent.
                */
               host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;

```

> 
> >
> >>
> >> The mmc card itself is still programmed correctly (the HS_TIMING driver
> >> strength field is set from card->drive_strength independently), so this
> >> is a spurious, repeated warning for a valid, documented configuration.
> >>
> >> Change to only program the host when the eMMC driver type value maps to
> >> a valid host driver type.
> >>
> >> Tested on i.MX8MP (usdhc3, eMMC in HS400) with
> >> `fixed-emmc-driver-type = <4>`: the warning is no longer logged and the
> >> HS_TIMING register contains 0x43 as expected.
> >>
> >> Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> >
> > I have looped in Adrian, to get his opinion on this.
> >
> > Kind regards
> > Uffe
> >
> >> ---
> >>  drivers/mmc/core/mmc.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> index 05444ecf3909..ff5d4b805998 100644
> >> --- a/drivers/mmc/core/mmc.c
> >> +++ b/drivers/mmc/core/mmc.c
> >> @@ -1371,9 +1371,11 @@ static void mmc_select_driver_type(struct mmc_card *card)
> >>
> >>         card->drive_strength = drive_strength;
> >>
> >> -       if (fixed_drv_type >= 0 && drive_strength)
> >> -               mmc_set_driver_type(card->host, drive_strength);
> >> -       else if (drv_type)
> >> +       if (fixed_drv_type >= 0 && drive_strength) {
> >> +               /* eMMC driver types >= 4 have no host controller equivalent. */
> >> +               if (drive_strength <= MMC_SET_DRIVER_TYPE_D)
> >> +                       mmc_set_driver_type(card->host, drive_strength);
> >> +       } else if (drv_type)
> >>                 mmc_set_driver_type(card->host, drv_type);
> >>  }
> >>
> >> --
> >> 2.49.0
> >>
> 
