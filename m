Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB442525A67;
	Wed, 16 Sep 2026 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569481; cv=fail; b=lyHkVSTiR4mY4UJ1z5dTSg6+At7Z40cA0WpDjUMr+oKLpMrqJDjy7hokBr6hg2RCOSKmb7faaHYgc9Wk2F0zIhD4CIq6bF7o+0yg5H+wSAECMPinB81h9CwJhZzHhIJ+OjC1Rd2KztAlfhJq8yMLcBcgkMWL8W8xmKR83aviyII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569481; c=relaxed/simple;
	bh=zQvnzV6XA97NYka0i1r96iyIxUw902v+KLgHnEMyT+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QfSOamQTB3BUocGL6WDst1sruD+yExEocGeZMsgwxVY+DkdcSvMYgxxuvvIR1fnNMsdwTFPhCSNHtHlmdtBn9mg26rouZfTRysyBpp5rj6RrbzxLu0ckTkHU64r3iBTDvjdPGTRkwPIHz35LPjXL9EQQy7OEHCAuKzyNS3cYB2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gd83rJ4G; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gd83rJ4G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRpR8K7s5Gs5aEfcMbv5TJL0uJyyHAopZ7HUitVKf3Bn03yMpJyB10NGsQX2a4XgvPTz4boAN9NghGRRqfrkkl0bCk8Hq9BLo0EguuMfhv0cmFXnNY/R7rcFqUra7kwOyo0FkS18Gzz5h15qJQ3a9UxyRaNQ1LNRi6Dt8Dy7ShPzkpBKXsoT60lKHhhRxOY0cFRrHd/RChaa9b3JGatR1J/UFtk/k8LdVaoHO0YUOT2z528+AGi0OhLzmLcZUSZdkhF2/gd/cmhmq9yFw4oD81m7VvAWTa0z3spL7lTvl1RvDJiOUs5il6FQozHmBFTpjeCXmLjC1HE1sPBvrebi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z19hTYKeFROcwA+Egpjvo9n3+wgQFV3J/13/HPKvwQE=;
 b=bTjwGdQZ6bRXD/Gbp4gV9rQdfA9HIX2bm7s2qq/JATe57mvlINrrf5wLihvPPEokpqfTJD95wuxI9zCds/dfAgWJ2WMSVfPxzoWUdik+mwhyFuvQi3Tc9R3SPnlmP1D+w+Mvii49Sq0D0+iQpx56SFt6yxYw5q/nxpVTS8ELeGMW+QYDus1kNvf+eCWsDxPmLssaGcCpXozWMZjD6EdVgaxh4py/OhMEcgcqWvuTSTS+xTMkZ9aJC968hYYe6nWaLzk269eOrc2ECjPOgIDrenp2sMV7ejbOqn/FLC8loFiftslnSGfxjCOhcL+AqDxROQk+AqBHC0KHUt/JAK985A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z19hTYKeFROcwA+Egpjvo9n3+wgQFV3J/13/HPKvwQE=;
 b=gd83rJ4G2+Oc286aG5BnEnLys5KFZsOj/cmH/rfet1F6/rImOj2cn6JjbkRZ6hADYAio81Q0dRfPEwNXWsg8NokVYjl6Y+6PiI1VPq2huEiEwfAHkdsm1q8kjKPa2hpZFNwCTyqM5sGASPu3yeByuj8cSSIlV8Ds9/idMhAUiLefQZITeyNBH98VkDN8t4k7aWpgQmQGx40pUuVyn5h7rWH0f243AR4cSVv3DbcPlJy7yXkxhCl7qdsTjcE3PpVLCE9/0zrFzYmvyjDnaWvndQD0tH3Ao+nbShVkWYA1ImBiNv4IK2X2KeTGYC14HTEsXUZPRegGOTf0zzWnFbUhkQ==
Received: from CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 by SJ0PR12MB6854.namprd12.prod.outlook.com (2603:10b6:a03:47c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:37:52 +0000
Received: from CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc]) by CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc%5]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 14:37:48 +0000
From: Leo Zhuo <qzhuo@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "aris@redhat.com" <aris@redhat.com>
CC: "bp@alien8.de" <bp@alien8.de>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	Leo Zhuo <qzhuo@nvidia.com>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] EDAC/sb_edac: Fix pci_vtd reference leak in
 haswell_mci_bind_devs()
Thread-Topic: [PATCH] EDAC/sb_edac: Fix pci_vtd reference leak in
 haswell_mci_bind_devs()
Thread-Index: AQHdRbzflGUviDHcyUSF/6AVIpqCarbRRPNg
Date: Wed, 16 Sep 2026 14:37:48 +0000
Message-ID:
 <CY8PR12MB72909C59B4374AB917E1D99DD1B92@CY8PR12MB7290.namprd12.prod.outlook.com>
References: <20260916092001.2000245-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916092001.2000245-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7290:EE_|SJ0PR12MB6854:EE_
x-ms-office365-filtering-correlation-id: 7819cadc-a7c4-4ad8-0367-08df140014a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 6DUCxNxjYkg6BulnFgMbYVsZszT0O7IQcD+RCUoxTfLH3Fm6bCb31KwbO6LhB8l/F53GRrV9T2DvLNfS0SieTSd6+Xz3J3+SjxFvy4ENu5ym5sG4t3vri+VZaUIknfJQxaUZJSIJqvtugTR+jtKmaxdJyuNEN7vVR2y+EYMhWIAz1yZxvMW03Axgd87No/pbleq9lz5X0JA0gCvHOUyt2aXmFvKZ1wJfz2PDUMNDCylMYy8m95KmKgh+PD6ID/jYTrGhEpVz9GWgiaZWX8m7KjHGRFE42JbycZbAJo06KP39V/9RvI+w3sy3GI8ZT33Lzpl2CYo/u2lE2Zz1xIfD0enbfBikHEiBqFj0BzkpMpbARA4xJIlE1iA5jx4cKjmZCPoS1Boc06pWeQqflGlXq/7rJPBZBBi3lm6kwBZ2FajX8NtR9A83fwpJ6ItjBiONluNhTWWKt2AWJvB63TbW2F2sJkHojHOI4y0DlTf86mVegWDtmR1IMbwdCb5VBcRR2jvaEgjN6Coqk3YEweSyAUwc9P7lKvpmBMvXSsUin/pNvevG70pWxL2kVPWZRvMPxYiEwyy20sNSDKe76X7cCah3G5/L+rGiX2Yut7JGt6WWjZsm2JBxxTKxy/pr19l+JzjOpIxNJ7ExJofx021+EAGCkBVs9BtxG2H9WSxLaCWZs/m3UTK6FPVGH2051j9DGz6EwdurZFTpi2kD8sSZldHNYF0HafBFK3x+ERMFepI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7290.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OBlzmi/J72j1IsxnjpQ5XLAo0TdTEmKLjWyk5tBF3lhrvvuVlmX40KLFxHId?=
 =?us-ascii?Q?KkfLptXm7SBVoIdIeKPDczKTdfF8I1HAnwVDQfRDkexbz+/xRJFrsZVC2RJS?=
 =?us-ascii?Q?EBHIecrHpuVAN8UfGhAhrBw/RWr8tIqO2IIVxMHqjdvjsx1qO3E1ZIHW6JLY?=
 =?us-ascii?Q?Xg3hnF+PLfItbDfVQ6eTGzIhzBHNMH/whhYu0vmTLNO/+abBze2FakwBMuJD?=
 =?us-ascii?Q?FtaFEVfH8jewF6vtY0NcfIVRIB8+YbN+swuLpAcklaQAJPvptfC0SsrFZM88?=
 =?us-ascii?Q?fwOG7yrCfv90Iwk85aOgB1h09M5yKsPhPYXGXTbyTlom+iQ4bO1bSFQxF8FI?=
 =?us-ascii?Q?ZkV/IC2gTJgcme0MOU/RECjVXy1+d44ElIEjbnrwumth2KsWAKmspVXxhZy2?=
 =?us-ascii?Q?DAHUe1rJyS5EJ3co1nAqBGbhKc6Cib7JD/8F+yY+a6rPmuxoE7ypUyTKM17F?=
 =?us-ascii?Q?WwpVhKVN1S2hwhHFDTA67N052lrhaLbtReyLUvpQhNEKfXLkAD0xLBjKSPQ2?=
 =?us-ascii?Q?9cd5bt1SYM/2c8JDDrM3a1wpfvX06mbgfCHFoZWXSMyhFKaBjO0o7vOizukn?=
 =?us-ascii?Q?zSvKmAG9nqktKRQE/gABPe1EDPF8duGHSVwRZZQ00PRvJ/aeiMqtLY7apomE?=
 =?us-ascii?Q?Dhyg9VxfAklJYiRBkI9DARwuaoAjpj7p+s5Hq+mAQVARkO6YBTbdslTxsv8i?=
 =?us-ascii?Q?5HCgfyxWS6ieiP5H8g/CQG8mNlo317P9j+nO0hp4dPaBKlTj+wqdwaizQxhf?=
 =?us-ascii?Q?O534WrdrwTE6al7r5I+VDvxUZadXmDbzZS2/w4BU8tuRDoWY54QRueqWiS08?=
 =?us-ascii?Q?MEweZPwLjwR5QI3qtNDIl6wSwbWn+kpMTJH8/p4zoMxtc8lSsfwhz1MSYiOk?=
 =?us-ascii?Q?EDkwDhms0YAKD/hNVXouNJgAZ/JI0d1A3mPCK64kx8AS19ZnspQOvqlgNm8A?=
 =?us-ascii?Q?Fm/jXoi6jldNJMGpOvQ0QuFdh++bd4HuSacrPVDNJ3jV0bKxxO0kx4IiAfPD?=
 =?us-ascii?Q?y7Nd1JEqqAOmJUCXOlRRrwmrO2iCTy3LPk8b52cRMdFwEOL7XZEHJNji7ENZ?=
 =?us-ascii?Q?B0pNeEpOHGX4O4mUku2gkNznq+5QJsseh+UihDi939Tn0ktwe44bqnDFhDZS?=
 =?us-ascii?Q?bPYhX7pTh1GFcbfSihgRruTq/n3qZf3RynIOKlfWrXLWEgGXh04/pdy+rZ7J?=
 =?us-ascii?Q?kU7+t4QzvPIVro7V8TJewevVKsG6eP7cUsmnlQDXFA6uZGxPKnvk4acBlOk4?=
 =?us-ascii?Q?dgZocAxN2pYxxc0clFzJ6NSgdAdzeWvAHrgQra6IcL94OiUpNTwbXyW4Kc6W?=
 =?us-ascii?Q?B0L+mpKxDK7i2ZTcyhTLZXECN+S7HW0a2v5DIamQDjE1qGJC+QkNTdG1GYQ8?=
 =?us-ascii?Q?1WfS+lQbh47NaWssc+OWAY5rEIvlMV2VAgG5G5mNaHiPE10BcpBbdYb1HcaK?=
 =?us-ascii?Q?ROyOTozm2uihAYCjxtMZsF4lRPXVE+lwaUUhR/G+M2Ko1sonh6r/eETRT8Gb?=
 =?us-ascii?Q?E+klFna9mezL02DW7obUnT0ffwUu5syNUyaYJ6GTgYBvi7aLT9ZdjNU0J3lQ?=
 =?us-ascii?Q?uKlmOH0TNZ1KI2oJH7vslvLfOGeQ0ndqK5qyngJPqn4xEs5MtaVZdoAnuQT5?=
 =?us-ascii?Q?C//yOou3LIAujCLKNk42ObJ9mA7zbNzCshCtgg6siWiO5NCE6FuIzjlQXjcY?=
 =?us-ascii?Q?Oio+ogHuTAbNBRbc57MOFOy8f24zb+9frRxnEq4XYFxoF/Hc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7290.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7819cadc-a7c4-4ad8-0367-08df140014a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:37:48.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9k13dk8blWgbdN7O2lLEnP9q6n7nbUdxRYKXe5N6MiXJoDkU9Y1Srviatcqnf3DlKwqFsqMfcFo138Iq4+Qi6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6854

> From: Wentao Liang <vulab@iscas.ac.cn>
> [...]
> Subject: [PATCH] EDAC/sb_edac: Fix pci_vtd reference leak in
> haswell_mci_bind_devs()
>=20
>=20
> In haswell_mci_bind_devs(), a reference to the VT-d device is taken with
> pci_get_device() and stored in pvt->info.pci_vtd.  If one of the required=
 devices is
> missing, the function returns -ENODEV without putting that reference, and=
 the
> caller frees the mem_ctl_info along with its private data, leaking the re=
ference.
>=20
> Put the device reference before returning on the error path.
>=20
> Fixes: 50d1bb93672f ("sb_edac: add support for Haswell based systems")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/edac/sb_edac.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c index
> 7b282dfd093f..5075c703e19e 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -2846,6 +2846,8 @@ static int haswell_mci_bind_devs(struct mem_ctl_inf=
o
> *mci,
>         return 0;
>=20
>  enodev:
> +       pci_dev_put(pvt->info.pci_vtd);
> +       pvt->info.pci_vtd =3D NULL;

The fix looks incomplete: it only releases pci_vtd only when haswell_mci_bi=
nd_devs() returns -ENODEV.=20
The reference still leaks if registration fails later or during normal driv=
er removal.=20
Broadwell's path has the same issue.

A complete fix should release pci_vtd whenever the MCI is freed, i.e, cover=
ing both Haswell and Broadwell=20
registration failures and normal removal. And ensure pci_dev_put (pci_vtd) =
is called exactly once.

How about the following fix:

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 6e248855a549..d0d01efc2fc9 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3315,6 +3315,7 @@ static struct notifier_block sbridge_mce_dec =3D {
 static void sbridge_unregister_mci(struct sbridge_dev *sbridge_dev)
 {
        struct mem_ctl_info *mci =3D sbridge_dev->mci;
+       struct sbridge_pvt *pvt;

        if (unlikely(!mci || !mci->pvt_info)) {
                edac_dbg(0, "MC: dev =3D %p\n", &sbridge_dev->pdev[0]->dev)=
;
@@ -3323,6 +3324,7 @@ static void sbridge_unregister_mci(struct sbridge_dev=
 *sbridge_dev)
                return;
        }

+       pvt =3D mci->pvt_info;
        edac_dbg(0, "MC: mci =3D %p, dev =3D %p\n",
                 mci, &sbridge_dev->pdev[0]->dev);

@@ -3331,6 +3333,7 @@ static void sbridge_unregister_mci(struct sbridge_dev=
 *sbridge_dev)

        edac_dbg(1, "%s: free mci struct\n", mci->ctl_name);
        kfree(mci->ctl_name);
+       pci_dev_put(pvt->info.pci_vtd);
        edac_mc_free(mci);
        sbridge_dev->mci =3D NULL;
 }
@@ -3531,6 +3534,7 @@ static int sbridge_register_mci(struct sbridge_dev *s=
bridge_dev, enum type type)
 fail:
        kfree(mci->ctl_name);
 fail0:
+       pci_dev_put(pvt->info.pci_vtd);
        edac_mc_free(mci);
        sbridge_dev->mci =3D NULL;
        return rc;
	=09
>         sbridge_printk(KERN_ERR, "Some needed devices are missing\n");
>         return -ENODEV;
>  }
> --
> 2.34.1
>=20

