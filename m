Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FA3A9627;
	Mon, 20 Jul 2026 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784524428; cv=fail; b=LTUB/CuM7cbtmIIrjoiDAJhPM5oAPP99Wb1jcdyjx9pt9Q7ZIR5ap+puCQd0JVlHsTot/yO27YJKCPYlDI+FYBwWH/MwhFk4enF9b4I8Jvb9abn8f+dkbSqpwTB1WGskhyr91rLXgSVO7S7bGmoAaEm0dGFoZnouVjkh5zJQfL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784524428; c=relaxed/simple;
	bh=Vf/D4alvN3UocPYAG3vn7jGHHPLPIFziqIE2hW8AUJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WW6uOav1kX1tU2urCx3k7hG/DmEeW6k1E5OuC3j4SVTVTjr29n5NlxPuA0tnvbPcRoqEBP4qSeKGmIdyHUZhBRl0+vDN2nmquQQeaoh2sOygm5oTGySu0J978VhSGhdm0nZOrLXtl/7tffWBNpiOoZGKh48ojSvX7fhlMSQz1Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atIZJrHJ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atIZJrHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784524426; x=1816060426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vf/D4alvN3UocPYAG3vn7jGHHPLPIFziqIE2hW8AUJE=;
  b=atIZJrHJdNB66lzzCF1rawbY4riUAIgY687Q+7DZbw8lHGeajcS86Ngy
   eZjAuPBdClTIipfJ+XltyZsMVN0d0ybAOGslc0GPydd64VxTem3s9YUJF
   iMRYSobwQP7Fq6h2o1YgTDuikHljZzq1S4KBDN4k4wnIPCz7j+9WA1n8l
   R/OM9QNCD/RXtf1cVligiXXcQhSGzrsUi/+TYztHUsI0RdcoDww65eF8q
   9VmPrYVQNEsYA/WTBRBcBr10h0PPR8IFOrqEIjWaWsvyers+tBb0HuGwT
   FiwUM++qMVpoSCePaytBY2x3Lhg9IvC8GM7GcFMLS3ISHu8nfapag5SSL
   A==;
X-CSE-ConnectionGUID: +8IleohhTru78AswdxlEyQ==
X-CSE-MsgGUID: RFPPSicOSFSVq035WTwi7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85297139"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85297139"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 22:13:45 -0700
X-CSE-ConnectionGUID: a1uutweOSuuTQNwFdKR9FQ==
X-CSE-MsgGUID: ythAhmbVQBqh3mDhuYJCMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="259357854"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 22:13:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 22:13:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 19 Jul 2026 22:13:43 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 22:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYz1qrPV7/YPBVbBRT5Izp0SWj9ZXiGZ15NkSP25OvRxpHj+8qQIQfHNu88bWGSOl/Zd3Rpj+pYQw0jsyklzNm1ltAOd1NLaKFYgpBD2FJksWf/S0AEkxJC5vbzsjSxGup3LmiUb9MOeQHtoDEsiXWokg0BBF3vxk29qpgQvAfxVtbNMrkZJRild9fXaHSjq5xh+lPFTE0OPrpn9GxHoHG7UwfHKsyLUy8C+IOFIjOI9hqUuerKgird/qS1tZY7eKmEuOOrjiJHGQQO5OCnD3aSyRaYjlAGuzNsHrlzrQfhJITjpAAum+1rIHkPzNDTfepauoFmF3FyeghnmSlNHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8Jk9e1cvl90npeDb2oGkpqW3iIfN4j2JqzpNgdcPAA=;
 b=d/uvhyJME/VhsasjFabN1r7b9UUmrbWcnaXsyikQpML/WcHSp+sqf307tQ9BZEVvIxoRE8jtCvaEXR/dPv8sSoupaeyJ+2ZZjF433CtsNOHvuFiJzcrdMC1W6cdKEc1JkTzmMooMcfikxZnMl8CpG4h5EhW3xHpqdCtDfaVKJIu5+r2pTCSv3A+Ro1W46aGXvWH5oJwASsLdjVxTBHEF0XPNywKRWSqrrb3JolD2DOXfk5xNfjyiDb7ffJcv+m2pjI1I2LcA/eNC0RLE/cco8aQONenU08Icfshhoj1NV4yKPTwjdsEPrX0yMECvB31f2gwO257FAbVji0DvQrjIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6)
 by DSWPR11MB9714.namprd11.prod.outlook.com (2603:10b6:8:354::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Mon, 20 Jul
 2026 05:13:36 +0000
Received: from SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb]) by SA2PR11MB4844.namprd11.prod.outlook.com
 ([fe80::61e5:7b38:b8a4:1abb%4]) with mapi id 15.21.0223.008; Mon, 20 Jul 2026
 05:13:36 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2] iommu/iommufd: Fix IOPF group ownership UAF
Thread-Topic: [PATCH v2] iommu/iommufd: Fix IOPF group ownership UAF
Thread-Index: AQHdFm6lE+E+gCXDVUGVeZjLG0mTVLZ1254w
Date: Mon, 20 Jul 2026 05:13:36 +0000
Message-ID: <SA2PR11MB48445CD1F0B71DC6E5B0BD168CC32@SA2PR11MB4844.namprd11.prod.outlook.com>
References: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
 <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4844:EE_|DSWPR11MB9714:EE_
x-ms-office365-filtering-correlation-id: ef4f1f00-cf2d-4dce-12bc-08dee61da71b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|4143699003|38070700021|10067099003|56012099006;
x-microsoft-antispam-message-info: 9EUfPyxf9PQLkJ1oObaH0o6cJA6HJzPDQFExvYq3ZHvstzCGqvZUXgbTjrZS+gmma/BLKBLzpLYoihu+41z21Gc8BHkdgDFxQ+9PE5cMT9mjc57FZk1asNFbpWkfYBppkDI0k2JRhdajRLIvCc9bRLvB2t+FYp/T5n9sF8tEI2FNhcxwzkQRHEDV3OyQTkRpXFdNt86OXpNMtsPIovQr5KkAQ/2IhtY+os1Vj9mDQ7Rc4YcNHpnBWy5pBitqB+twhUimxxUkvGfcgTDe4B1O6o3rY5+ZAMMahiraiFMpYNFCczZPbXkETkFa+Ps7XmCyghQvyFqQUc8z5rNOSo7jc/BuAZGngoSfMM/yZ9RB8hezVoW/j45Ejj/RoaikSva0UG9EZU//Rd1clEsT+wwYmg7RDcu2ZtsmTxglDu50NczWvEjfww9YcUMz4qFFtVF/q8BCEJDGcbZ4Ple8N06Jfm/iSC9QeVtWcEF73u44AdsI8iqu/87iFEQ2Lwe1EmuS56r2IOqT8P9owP/TQGSQD3kTMhGbaigVmtIOM3dmX5Nv+q+teNVsi9YEjkEPms+APU0kYXPTyeiQXktsMwv9d/UE2XsY6KZSSMIMBF6xdjkF0EgjyQ20yQ1Zzwc5AvfBMxFX1l+kO7B0EPG63A3lGmbx0IY6fiX/h+XahWGJ9HW7z1yBMWMTkMignK7wBckEjbtNCnHpOyGkzFLiR+nWuP6BJloLTr5E7IWS5HE+zmw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4844.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BsaRoHkR/5KyGFyGkV1NPgqr+OJo/VhennYwGaKjEKxYozf5MNUk7+916paW?=
 =?us-ascii?Q?caTKlkcK0UAbdslPbdO1u+9Qf94qemHh8fCRcysZmf7Pw6DpeYARsECQvKni?=
 =?us-ascii?Q?AZh4qmhYmBdBRrg1RPrkRzK+6hn1Bh0NiV5OjHcX4m54kl0XODBUNU7SqBCD?=
 =?us-ascii?Q?vEfOGiEwLWg5Mjz6JsD3QbidI9lfj7w6wdZZKWviReEeAjB9K6rlilyF3H4o?=
 =?us-ascii?Q?VraZK7oLuJlDahJu48GeAumKsHeCp6E/1mJlYFbHzL40xT/ylZQgfXWkUpC/?=
 =?us-ascii?Q?GPQUT+g4KGAywuQ/dEZlEKOho5OWVE7FqO9Qzd15/P01UqBMjlDyShQBJ18g?=
 =?us-ascii?Q?/u6cGi7sjOXvv52GnNSBHR4lqpBHbgfH317f6C5KT6DnDwk1JeOAgM9xCD5w?=
 =?us-ascii?Q?5L0wpVL6JB3JTQ5XLF3azJpCcCLAqXtBAAOfV2+G4h9cMxMl+LCgUhju5plY?=
 =?us-ascii?Q?Y08WbeZuDgJEPDzIB6ZoRFkS8vWvEgS29a4DA9VgVgViDwoxNyivMkBlSHwq?=
 =?us-ascii?Q?z+gKCeE6d3+BG21w2GjjTk97rHIVJBdMkW4eM44rW5MlUjYOL7VmyfrGwySb?=
 =?us-ascii?Q?DYtv5rqs8aBheqXZKVumDY+Bj46KzcziVBseVb16BkPnnndmIVfBP5tLys97?=
 =?us-ascii?Q?p+xpbJjW0yw3dUpLdRdG9he1NoBnuxtaAjec0tDsdD9mxnGGAHwnhklo2v38?=
 =?us-ascii?Q?P+d072hJBZqsrIbsGfrgVk9PCMhBKhc97WpxCIdx7oxEi4cgpgsyEi/e/BjW?=
 =?us-ascii?Q?OKUhs/oLVUThrQeWhAjL4IoT/moGycLFpaH6sZJVBkmye+D85bgbd63Qkktm?=
 =?us-ascii?Q?GL9HCpmS7Cq1wKwDDK2q5jxFdlpTpQUAuvAKTn34ZiLf7xF91xJ4eKyOG1jL?=
 =?us-ascii?Q?ZE2pw0n+TFcMce5+2624a4oDW0GxniBwx6ZGRsLuX8CcCQ/umxAo9XsWnMEI?=
 =?us-ascii?Q?LdCvEdi4z0P8V5F/dEnCrvz8dr12UsUq/dVQ9yUWZdI09swoFYXGnaTvUl5q?=
 =?us-ascii?Q?hW4IzSSXitKx30x3ScGiTFP6UDLyETRntjiTKCGNRa3m2Hq7sTy4nEZoV5vl?=
 =?us-ascii?Q?pbv6R8TrPDb9KOazkuXAaAd2JfgBk8MyKStqMdaooRr9Dr9UfWUFStN76fiY?=
 =?us-ascii?Q?gBKkKMoY3714t95sLT+8zk9kjq1GjqRggGhG/OEniuxjeT6P2hkUSPg6mSrP?=
 =?us-ascii?Q?X/VtEOufzOL/ub5L3nNgD4lQX51x2tYU48FWFqHJj8WubTP2cdecT/v2aL07?=
 =?us-ascii?Q?hqqtS31PYc8j62vUzihyD7P/C2wqCRv6yc2kUXKnURF4eXQ9iR2byNSshPxZ?=
 =?us-ascii?Q?FbYBD/F0ofMvUkLwPoh50gZUWleolZnEJtlVQrh0XelXSIoyYTfiANQ/Eq2t?=
 =?us-ascii?Q?4lGgRM50oIbh0o91y0rIOUYF31T4V6bIpHkWJGVNUSrnB5wZpdThg4DkARoq?=
 =?us-ascii?Q?UwNUCbhOSm2U4YUSU6TnEd0Unrc3mmf+O/jt/wV51FRSePR3zncKjNQvaBgS?=
 =?us-ascii?Q?SRVhJkqD6SrE/oK6U9ZWZlCcRyrRbvV4AF81TDIapEzTugpw8Wq4s+A/RAUN?=
 =?us-ascii?Q?SbMSTR93FJtJoeTwwNhEryE5jtf691bXwg9s/4poTBkLlwIH5dDVbis/F68b?=
 =?us-ascii?Q?G5PmGNHnYdO5jWpw7D2plseFbMH2kgZP4olVWn1T3pI5oI1Kje1jpqTn/dqD?=
 =?us-ascii?Q?4xa+l+BLj2EftlHBMa6wfyOMxG+Vb0CwxR8KETFl0Qfrfc5T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AbDoX7fWrkVadsY9PqlwRGcM3P1Y9d5l2jt2CAyqN+2tyt+gUQewTkKyKCfZvWsZCD/4J8lEz+SmZffiu4rai+IV0YK8fmT4wrtJPjOlbfqCxD0zyM0Iy5tmyhD43lBvFFo02E39+QfpJD53oLzc+8hlMQ2LuFEYJdORGJzeJnseddIZzpwWCagMwGd7ymfAtHe8LY8r+SP1TrXhjxccpcOBcgRPReZRlN60d4dJK/5Wgiu4v6XVbc55MiJA8kkzFdlwDVeAQbSb4MhavveOJyhrgtkmmtVMu4zb3wPslDFBkLuEp6opKVxigHEre8V2k0fuZiqkoLA79b3b0nGTJQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4844.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4f1f00-cf2d-4dce-12bc-08dee61da71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 05:13:36.4896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3GtCNQE9wUqYXuUR9SmsUYGDkL7wNLNLK9QYDchBTtw4GpYgh5ZWfbEmWeG+kLv5/ZtnB47BigFgRakMDbp2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9714
X-OriginatorOrg: intel.com

> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Sent: Saturday, July 18, 2026 12:33 PM
>=20
> iopf_group_alloc() links each last-page IOPF group into the generic IOPF
> pending list before invoking the domain fault handler.
> iommufd_fault_iopf_handler() also queued an accepted group in the
> IOMMUFD deliver list without removing it from the generic pending list.
>=20
> When detach or HWPT replacement drops the device's IOPF reference count
> to zero, an IOMMU driver may call iopf_queue_remove_device(). That
> function responds to and frees groups through the generic pending list
> without removing the same groups from IOMMUFD's deliver list or response
> xarray. A later read, response, or cleanup can then access the freed
> group and cause a UAF.
>=20
> Fix this by dequeuing an accepted group from the generic pending list
> before IOMMUFD queues it for userspace response, and by making
> iopf_group_response() free the group as well after sending the response.
> The abort_group cleanup in iommu_report_device_fault() keeps
> using the locked helper, since abort_group is stack-allocated
> and must not be freed by iopf_group_response().
>=20
> Closes: https://lore.kernel.org/all/B4F28798E2E784CA+d29f723c-b2b5-4b67-
> 8d1c-4f7b9b0b27cb@smail.nju.edu.cn/
> Fixes: 34765cbc679c ("iommufd: Associate fault object with
> iommufd_hw_pgtable")
> Cc: stable@vger.kernel.org
> Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.6-sol

this is basically ok but let's split it into two.

the first patch just includes addition of iopf_group_dequeue() and
removal of the check on list_empty() in iopf_group_response(). that's
simple and correct for backporting to stable.

the 2nd patch does the remaining cleanup:

  __iopf_group_response_locked(): locked version of sending response
  __iopf_group_response(): acquire lock and send response
  iopf_group_response(): send response plus freeing group. still as the
  exported symbol

then...

> @@ -267,11 +282,14 @@ int iommu_report_device_fault(struct device *dev,
> struct iopf_fault *evt)
>  err_abort:
>  	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
>  			     fault->prm.pasid);
> -	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);

...just replace iopf_group_response() with __iopf_group_response(). No
change to the following lines:

> -	if (group =3D=3D &abort_group)
> +	if (group =3D=3D &abort_group) {
> +		mutex_lock(&group->fault_param->lock);
> +		iopf_group_response_locked(group,
> IOMMU_PAGE_RESP_FAILURE);
> +		mutex_unlock(&group->fault_param->lock);
>  		__iopf_free_group(group);
> -	else
> -		iopf_free_group(group);
> +	} else {
> +		iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
> +	}

[...]

>  void iopf_group_response(struct iopf_group *group,
>  			 enum iommu_page_response_code status)
>  {
>  	struct iommu_fault_param *fault_param =3D group->fault_param;
> -	struct iopf_fault *iopf =3D &group->last_fault;
> -	struct device *dev =3D group->fault_param->dev;
> -	const struct iommu_ops *ops =3D dev_iommu_ops(dev);
> -	struct iommu_page_response resp =3D {
> -		.pasid =3D iopf->fault.prm.pasid,
> -		.grpid =3D iopf->fault.prm.grpid,
> -		.code =3D status,
> -	};
>=20
> -	/* Only send response if there is a fault report pending */
>  	mutex_lock(&fault_param->lock);
> -	if (!list_empty(&group->pending_node)) {
> -		ops->page_response(dev, &group->last_fault, &resp);
> -		list_del_init(&group->pending_node);
> -	}
> +	iopf_group_response_locked(group, status);
>  	mutex_unlock(&fault_param->lock);
> +	iopf_free_group(group);
>  }

iopf_group_response()
{
	__ iopf_group_response();
	iopf_free_group(group);
}

> @@ -469,15 +495,7 @@ void iopf_queue_remove_device(struct iopf_queue
> *queue, struct device *dev)
>  		kfree(partial_iopf);
>=20
>  	list_for_each_entry_safe(group, temp, &fault_param->faults,
> pending_node) {
> -		struct iopf_fault *iopf =3D &group->last_fault;
> -		struct iommu_page_response resp =3D {
> -			.pasid =3D iopf->fault.prm.pasid,
> -			.grpid =3D iopf->fault.prm.grpid,
> -			.code =3D IOMMU_PAGE_RESP_INVALID
> -		};
> -
> -		ops->page_response(dev, iopf, &resp);
> -		list_del_init(&group->pending_node);
> +		iopf_group_response_locked(group,
> IOMMU_PAGE_RESP_INVALID);
>  		iopf_free_group(group);
>  	}

	__iopf_group_response_locked();
	iopf_free_group(group);

