Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DF3314C4;
	Wed, 16 Sep 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570393; cv=fail; b=Me+JNgmLJaftqzcL1eXMLwE2ARNs8sLQ2kggNyJ57KXf4oO7nHjs6KEczHdufHxrwVKVofW1th0dLjxCW967c7pOqcd1K+ct6fRu3T6Z3z+hn606JqddHp0SgGTO0h+JnTTQVXdtf6pFHel8WSFOSXPimdZicXdS9hDnUNcik/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570393; c=relaxed/simple;
	bh=xU9qjhRActZrTD9D6htsUGWXgjd0y3rd+a2y71JYjD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I/oa7OSHLHQAlruR5aoq8hcVQidfJNEmRxoywwq59HV2j8/06w7rtEUlGoPu2Wwp4qfjG0MHPOlk9Gzp5SqqZGexJCfDwHP25A4JN3LHb/V1mPaIwV0qqiHR9E+mi8YqMaeQw4zMzVqRs5JryMBDRGvRqfedMCemdLfmGZc/BAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZCrTMBy; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZCrTMBy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWtwNNNwB4Co+/zNImpXpTFfGzA4RIr38LAVWulYYk2anvJUiIiFmmFsGkLAF/DGQ8vcMNuqaekYfvrFN18i3jH/W4hilswp/DNBBsJEoLEPd7F2cKG66Ha5Lqevd6ysIAYq1BM06PAHRlwWNdFF1fnna27HdjIa5gSRNhOz+7m/TCEJRqxJB/EMWug6M/pZdFiqkW3eOSvRBBi5cxpNX4HHWso6R9SipX3xXyrJBMSMmSWNXTYGKoR8ZbP1MidSRlLAV9x6mMaw1qMJwagAE5X2VDsQAqA/qHxVKdrC04B3/CSrzzrzSdGA8sQNCip62V0lIVskJiCoJWDVJhI43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmkt8WOMyTAhoidmAp/ZcDc1ADZ/Nxjuc2XA9aDS768=;
 b=amLCpk1xoq9wZABg/AmQDL9HRd+RUi1qoqmXg47d+3a+Z2sr3qlOgXyqky+Pv2krfUsUCFPDTd2ZkIkzvpA4K0adeDdsNK1UsAg8kOhSifcW+SBWT1HeO0sVOD9plW1WEaaAOR9cz/nHDk3zCXvOIM5G7EhwX8qipXZ7FsdusHK9o2Hqrb61QyZJ2gQHlY5B+sxR8cFjwrzw+8MUa9/oP0fpawV7wYhjOoCH5LgoEmaQRe8hRzERRuDfPO0zRdvbCp5GR7xQiqzoDyOlNNJno1StHMpNaCYA2LRsYtPo5lvWSWQurehzb4qGpfcgIYHuogmb6JF1VwAw6yFlRMgh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmkt8WOMyTAhoidmAp/ZcDc1ADZ/Nxjuc2XA9aDS768=;
 b=JZCrTMBy+RmNIBLxCnTquoSQrqOwnXNWx4voIPkoQfIaJL9x+s4fqeT3f9t3eiFhnl0AD2CAhcoqRZWiOLAtwYvfn2AE+9amhByMPqwKdcMcQNPbAVT2OKVIUaLwR7ryWvOJxvf7HGzHtsxygcQECfjAz8UVKtpczvR/jkxbN0Ah/MNz+Nw4HiOHGkDCPSdjx9ySquC0zzsG97PY/vMqLrgEDnQ2HPQRHz7TTUIzmMxA5X1N2wCEQHTfPnCek08VvxmnJCOU07cekB1mz0p07ivLzEA5UQmvmXcHKmZjfaY5Mt6zwrLgI4W/YRA7mZF80FHo86qSo8A9jIFOmPJmNQ==
Received: from CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 14:53:03 +0000
Received: from CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc]) by CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc%5]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 14:53:02 +0000
From: Leo Zhuo <qzhuo@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "bp@alien8.de" <bp@alien8.de>, "dougthompson@xmission.com"
	<dougthompson@xmission.com>, "juhlenko@akamai.com" <juhlenko@akamai.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] EDAC/i3000: Fix mci_pdev reference leak in
 i3000_init_one()
Thread-Topic: [PATCH] EDAC/i3000: Fix mci_pdev reference leak in
 i3000_init_one()
Thread-Index: AQHdRbwmloFXom/3l0GkqUM8IpurvbbRSLpA
Date: Wed, 16 Sep 2026 14:53:02 +0000
Message-ID:
 <CY8PR12MB7290DC961329B90C7A836907D1B92@CY8PR12MB7290.namprd12.prod.outlook.com>
References: <20260916091415.1997923-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916091415.1997923-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7290:EE_|MW4PR12MB7310:EE_
x-ms-office365-filtering-correlation-id: a29119ad-7cca-4f1e-52b8-08df1402356b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|22082099003|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 XsCKDp37YMKpffQrWLwQcB+0qQCWWbaclWY3aMscjxYF8A5BH/s7H2lamYrVPwaOcW1ELe1IBCGFkaiTYy2HqD7c2KofXu7FmYLmf7GjHur9MP+t4WovGiI7LNKSlFjMOAaoffjPFFyYCOFJHRDlGpMg0wxhMF7pUSSsFsKWn6RF8Os/c0+L0Z1qf/8DCqqwSfBiTB7T2gZB2WzdrR8Cu4MbkdTYjNQT1oT04S6sACMgyy9qihF5Lcw0dg1DxxTaUVY+Vv32yTAO2zOAQU845rNqk4lgmUHlhESUaQTtTqTtA5Y0ryLZbaePMCZ3K/CYMlFV/DqsOw7KHifSQ7hLUmHV2KcligI9LfKT8eAzPTK/l0k3JKLsPGzp+OVBci13XUJeCLb7WogF2QWVjSJeq3MWgr3Smg8KJ11/rNfHeBNmq+ttGPWAwBJ+xGp4euTkte0zcdKC4+V0ZTAq+DNCEtRprn8LW43n3XReqnIobWWGEyF6BbnuuS5yInL4IYEayB3lebussOt0Hw2/dNPCUQdL7yXENSCBYq2spgUquNjO5Nzq2+vDsuvbrJ3ozlkU54UGMPxKPevyzf4pe7Y4SsT2aNPyRVlznqdlyd1DnrFpHUHepJBO7ks27G2WHK3Rj2DOm3wQCICf8RTVs2cKoilkj33EC83dXYy+u3QYm7qCNrlI7wwifEfWWGia3FmjwfL8NZkDa6ZT4x1+HnWLKCnVkgjrOWT/S07fQj5Bn7M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7290.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(22082099003)(10067099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cFilAssyTyiGwjJ/+GmOf5RQwFLd6K45eIwTE2CMr7TRBBJPtfiG0ZEuoXso?=
 =?us-ascii?Q?STFxSFK209YCapoKqqO3ciWngc8sUpBzdPPzgJLRj1CbhfK10Lbv8vi/8qbi?=
 =?us-ascii?Q?N699qDkrw90qU68mKLAT5HLGfXR2zQXmrKDD4MTmnJWHit1ivnKqbSMW/1+i?=
 =?us-ascii?Q?blsYh9AkVmS9/ZfXTgi429q1cUdnhoD8calhcrkc05ZAYJg5dGt97VED8KB+?=
 =?us-ascii?Q?2AvMHTNF9UxEIWzocnkXAHMlQ1f8wIwVZ6qc7x1ZdXVb0xq/GeJ/xtSm8/RS?=
 =?us-ascii?Q?ugvSspdROlK6Z1B+1StQkubC6INHec3rMQwUNsrP8xbfgHYVSeU7jF9l6Grd?=
 =?us-ascii?Q?N8++js9xujAw6YvLF2631zH3BmuN6bqKEzXyLKWKZNXL1HvMwAVqcDvwHn9Z?=
 =?us-ascii?Q?cxxhKNdAj+JEJHIc8DoC0/WRMpiTyVC75nMmkB3SksqizD7AK3uIUVbu+EPm?=
 =?us-ascii?Q?rgbpJKEajP6+wie59qUPCNv+2jUj0YSbguklPQBI0TWsUxQ6I9D20v/pb6qU?=
 =?us-ascii?Q?VZA3N14T/gGOEvr5EfMiyjbIlnPT5bhQn94lCfJ8YuAjQPGPpgW6gjdzKTvh?=
 =?us-ascii?Q?xN+mHnS9mo1/mY5/FeDl9n1WMgWme6A2ERWLMleeATuQQCBR5w5lA0G6/5Ys?=
 =?us-ascii?Q?uag9ywSTUaFWlJYSk9CU7uLFED9028TiDQDYVWh6uvYT77eCeZX9mCHIOxrx?=
 =?us-ascii?Q?CfbmoMl4v0mHau7tg+3ws4v5hXqDjC9nNBi+7EREP3ifZ4MzHjnx6MFZFDM+?=
 =?us-ascii?Q?XIUcogkww7HGttGx4qmZ1NzlupDUGjonNzHkTxcEPDQY2LBZsdK3XqJqotpZ?=
 =?us-ascii?Q?PRBj3yWR09aqYuok+ZGnw8JOHOGk11/IiUgkDV8oLddRdTGgHegYuvE4pUBH?=
 =?us-ascii?Q?oeciNteFBGpR5fgGkGWkiXqt60thd0rtIog6bCcUYJQR04MO3eIe6FNHU4bw?=
 =?us-ascii?Q?c7ygJTMzaRdlmRLc8i1shy/MKmhkk9msNOppnU77K+AiW7msdiWa5o/1td9h?=
 =?us-ascii?Q?b+JqPL3wWsq09D0FZK4i+EZKI/I23ZDJZFcpOR8q04ioIyg/sgK+CiDUac6E?=
 =?us-ascii?Q?Jndt3G/rcF1BhsrKygWBVM0NX+LhPyHxIrkPWyCFDXNklixbjOP3xzUMOjIr?=
 =?us-ascii?Q?9dP+F7odiOEt0aMbfMKEd91GWmc5DZJmWLPMmCH6iKc91rnt6hMbqF0zqOIh?=
 =?us-ascii?Q?/6eMQLbmyqxsU4A85iwhPz+Y8geoSk9kny3EMZooZc4xAVCddvMv1lTsolDc?=
 =?us-ascii?Q?w9pYYho4Fce8MwFlds6jGd9a6lX9+jHLTxpiilnLG7RSAGTJRhRXTrxnOLU0?=
 =?us-ascii?Q?7IaZqeRmxDvVGu+cfw3F0VmZCvj1lOEY+pR+yhDzdwoxfunxBZLbtky7HjkF?=
 =?us-ascii?Q?WAFlznpR8IlVzmx3NDqXMG6rLYaxVxm+YiLNDKP8d0kj5ZMBdVQ8wiyXSDE4?=
 =?us-ascii?Q?GKqioFWpzbuFPDRO+an/7qaaz4ZeJ/pJ9lgm+y4LMg3I47vZycWyVXLRPetQ?=
 =?us-ascii?Q?UIHdRQbC8X2tOgzI2afk3YsN52mOxJCI/2hKL1UA6FzWOYCXUEyhzP/MEGp2?=
 =?us-ascii?Q?M6LQOvGmc6QNzk4otxv1LpJdqe4u2ANe8VOwP0fxcX3DaKBVkFw/+rwAGc8t?=
 =?us-ascii?Q?yXv6a6d9lzT+gJL7BB1syfUP0HKrQtI2O/7x3dvzuUUkDkPv1B30Wu099mgg?=
 =?us-ascii?Q?ZA5IFsFycvbEgufJ5HpJVqFKNtgniJLACKK5Qyu3BY9U1y15?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a29119ad-7cca-4f1e-52b8-08df1402356b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:53:02.8485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bObBlIQv4n08XRrmnhvtyDijFyirqRI5AA/Zq54mC/PLgbyV0PZsKI4oP7Wnv/zvFAeHStHUOTe3XIGNH4lAJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 5:14 PM
> To: akpm@linux-foundation.org
> Cc: bp@alien8.de; dougthompson@xmission.com; juhlenko@akamai.com; linux-
> edac@vger.kernel.org; linux-kernel@vger.kernel.org; tony.luck@intel.com; =
Wentao
> Liang <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] EDAC/i3000: Fix mci_pdev reference leak in i3000_init_on=
e()
>=20
>=20
> In i3000_init_one(), a reference to the PCI device is taken with
> pci_dev_get() and stored in the global mci_pdev even when
> i3000_probe1() fails.  On that path i3000_registered keeps its initial va=
lue of 1, so
> i3000_exit() skips the pci_dev_put() and the reference is leaked.
>=20
> Only take the reference after i3000_probe1() succeeds.
>=20
> Fixes: 535c6a53035d ("drivers/edac: new inte 30x0 MC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/edac/i3000_edac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c index
> 9065bc4386ff..d4ee6e185c80 100644
> --- a/drivers/edac/i3000_edac.c
> +++ b/drivers/edac/i3000_edac.c
> @@ -461,10 +461,13 @@ static int i3000_init_one(struct pci_dev *pdev, con=
st
> struct pci_device_id *ent)
>                 return -EIO;
>=20
>         rc =3D i3000_probe1(pdev, ent->driver_data);
> +       if (rc)
> +               return rc;
> +
>         if (!mci_pdev)
>                 mci_pdev =3D pci_dev_get(pdev);
>=20
> -       return rc;
> +       return 0;

For a successful normal probe() and exit() path,=20
the extra mci_pdev reference is not released because i3200_exit() skips pci=
_dev_put().
How about the following fix:

diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index d600b6c05217..ddfbbbbf8147 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -439,10 +439,13 @@ static int i3200_init_one(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
                return -EIO;

        rc =3D i3200_probe1(pdev, ent->driver_data);
+       if (rc)
+               return rc;
+
        if (!mci_pdev)
                mci_pdev =3D pci_dev_get(pdev);

-       return rc;
+       return 0;
 }

 static void i3200_remove_one(struct pci_dev *pdev)
@@ -529,10 +532,10 @@ static void __exit i3200_exit(void)
        edac_dbg(3, "MC:\n");

        pci_unregister_driver(&i3200_driver);
-       if (!i3200_registered) {
+       if (!i3200_registered)
                i3200_remove_one(mci_pdev);
-               pci_dev_put(mci_pdev);
-       }
+
+       pci_dev_put(mci_pdev);
 }

 module_init(i3200_init);

>  }
>=20
>  static void i3000_remove_one(struct pci_dev *pdev)
> --
> 2.34.1
>=20

