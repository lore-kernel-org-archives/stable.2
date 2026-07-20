Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08E3C4546;
	Mon, 20 Jul 2026 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540654; cv=fail; b=TItSRSmHTUybDnGqQEIkWUzdPxR5ZY5Biybs3b1rCWJ9MSfLHx6/KOcORdgtZ5wXMWPssvU5SgvkoOBm6xuh3yX3q3s0/MkkTBcgcNMrK1LkX+iBEdOCiQorZfj1wYCzYEvsd2F9pkL0ibTr5ynNLW3z49jZ86Q9XS6zRaEYdqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540654; c=relaxed/simple;
	bh=QWP+cF7dBatrUmxfQ99NCCbhrCZj3+kuq4U+EndT01E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TSSgr/+7k5I+5ENd5RSnGjc+JD3T5ATBrfesvcl446y8u9s2RMxIZ+MpN2LMgcYTr1+JCgIwbKCFXnVAxhZkHALumxkJcfLwxaphphrMaw7esg/bmgnQ+jT1vR86IET3H56wjkPA8tsc1UG5lZO27N1U1XbCn+5+xl3fBmwQjts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcjIZ9/L; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcjIZ9/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784540654; x=1816076654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QWP+cF7dBatrUmxfQ99NCCbhrCZj3+kuq4U+EndT01E=;
  b=KcjIZ9/LXfeNeO8lXdwkWYez/2XvGKo+JotoXBeyN330CIx0KH6lxlxo
   1Hct50g4CZ2QbTip1MUpgZnBZiEGZD9L2DB6zK4Mgg/agwc82Ssfl1ASe
   1uwPU49pL7l5j0eJZ43eEBq2bsmeynndzxb+OWVCLknQd2/kHvNK3aFKz
   9yJ56H8zEnEN56NPc1JiCVgFhT0tw4b5slpuTU+REY/O2n+/UVRJNdRUa
   7S+HICvj6FEv2fg/ndigzB4dCR7TXMsWdifzIZzSnxO1YMZHS1YEXhWeU
   7BxEtJXK2+srz6UI3F+vvvUlmqiZYMLfG6hWbsHL2QTFa718ZYTP0ZAEz
   w==;
X-CSE-ConnectionGUID: stWgRT9/S2GAknf48B7fvw==
X-CSE-MsgGUID: 0E7ME5BsT+yhc4XXmWz4Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="96630042"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="96630042"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 02:44:13 -0700
X-CSE-ConnectionGUID: gg2jWMT8TCyBY5L8B7YwbA==
X-CSE-MsgGUID: YLOmOJWmQUmPBBuukdNaIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="280692796"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 02:44:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 02:44:07 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 02:44:07 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 02:44:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcchQRgbOSDlI8556DIq5r+ym5NLEdc2WZ2A+fNg19EMEhz2wsOJIpYJjD5V+vv1XulxpfmCy4dLpfuoprC8yz8NDRRKdkUzaGXBwT6X90UZVbbizKKUNKwZTZs8f1IvDNSoV2DEhJcEapCKJBEopP+NY1V+dG/wJtqXKYcXqFwOoDFZ/Ox88VoN04B/HybJEuktJ147879G98YmL2DORG/y3hEfDvDsRdMe2WvBlWWvcw1VufGJ3fy4ZAxuWceoPfn8jPhyMXo58qAfDa7ZYbNLqPt9PqHFuA+CO0LyDs82wjDZWWUHAf4xEwhzaBPiF5NwZqE8LSLOIM6jcm3WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWP+cF7dBatrUmxfQ99NCCbhrCZj3+kuq4U+EndT01E=;
 b=E/JYPEHa38M/P4DkirjV8/q1nU7YqSGGYGYFWGpXd6bojil8UfYpXdzzPku5905BY59N2Gs1gbr4x1XM+/mPFCgGceHsf9OFket+lKEMCk4qlWvf6ImX5rS08PPlTLsKj8Xsk2/Cke2cCwMstEPSBx4GNGu8aJ2x2dPCmflpINFiW7zIGTY67hl8OSDYmYfSLkhZXSiOP7qiguFZmWHCGF1Ec2aSUeQSOb/zIGeKcjKy14jC9kSKiWLfodcKHBBZXam3ijDRUuwaohvrMJarD48a89iix5dwze8tYCOSWIdPPlJgqdUIyQKnvQTDFw9zqlMYbEkcjmawHfRYQQ1J+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA1PR11MB6919.namprd11.prod.outlook.com (2603:10b6:806:2bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 09:44:05 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 09:44:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] iommu/iommufd: Fix IOPF group ownership UAF
Thread-Topic: [PATCH v3 1/2] iommu/iommufd: Fix IOPF group ownership UAF
Thread-Index: AQHdGCUfi2sqGkeOA0aYv8A90rYyprZ2J/7Q
Date: Mon, 20 Jul 2026 09:44:04 +0000
Message-ID: <CO1PR11MB4835B3DD303A8EC5752FB9F48CC32@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
 <20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
 <3CFD314D0FE4D7EC+20260720085017.3998878-2-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <3CFD314D0FE4D7EC+20260720085017.3998878-2-peiyang_he@smail.nju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA1PR11MB6919:EE_
x-ms-office365-filtering-correlation-id: 39c94b90-a306-428e-7df5-08dee6436ffe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|38070700021|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: s/Da1pDiz484Qib5GFjeX5O3W7l0tO8qOgOk68qPbTW7SQpV267s9GwlnrvGHn/k+ssMDxJSvMNkHO81IOeBVkXPB7w6EzMYTk5WI4tcqTDCV/licd4wxYTaueFLK+NGg5LTMvqs/OxRZHZyqHeYrbPWVSY3XU7XqBqqy+IrSfuOGmxrS6Kr14Tgm3hnr1373UbtlxCO82QFDiCnkcIZI2peMStks8vSGGjCJDOD2B3M90E7yK0VRTBz2hdL7LHWeEgfi1GKahFempOSQQ41iqiYwCRJWu5IAiTd4lnEyIZXDunysgOVdJ/A8qXAYbNFybc2560GT7h67cWg6BRy7yk61eufB4LARsQoUIUawsA5EWCR2N5xiaE/EDfSe5CGkQa+DICZe/1Xh3z3SmuuXaPXcjCijqMqNwDT17SzyfECk7lMrRYvbIt6gHazVmGRmwa9kUCfwf9UmYKhXijWdwJW6bGevK8oKxpoLETMFIi+AFwhdl1K0S+lxfreBQGOwHQEOSup8h0xRDA3uqW+RMtQujiWYpjEIt8W/M9UM5jAgEpHJkXzqRSJxSYmkbYckQQjDz8uVGH8rE3nvO5IChMwGevWoNy/sL+chLHoCzFJkAshDOF+FTxtYkDnhW8l+Z/Yds6pmzssn5EakzeXHdVijoAGeI0g/diow1ubXFGCz5oUNblMlPYWr0TA4mfeEMYM2H2mEsKftScdK1W5bCqfw9PkhslL+WjCXdb4fnQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VGkCG4LFS1/6G5q7yToiZc11xRk8UCOJLLa6GSCboAhNVqMrIJLhcwQSgI2V?=
 =?us-ascii?Q?vesve7owKoWp/+u4I1t9cO7fGlrEeOF04vI8OTa4ezlIiLbvqoRd5pmZtvyz?=
 =?us-ascii?Q?bHVvoGUA+vCb2tPKhjzgMeU0NwrOur9T6xbFN6c/KIqCSncJYGpUHahQcn/P?=
 =?us-ascii?Q?KaiYbN3ZAnBJm51xQ8nX6/7Y3vXdrRqdB2Syw6Iv+IwkLgRm63bAX2VTdLWb?=
 =?us-ascii?Q?NxgpX4DKX4x0HpC4xlKTeLHyAPiBlJCOe6WkYmfS+FzE7Zct5N20qqsxGbS9?=
 =?us-ascii?Q?LomKFonY/MkyVuMRLyOcQNXj2a0UNok8n6yxEr6fKPwMuPqbN88SdQHyjdbx?=
 =?us-ascii?Q?MU/lAGoQ9DQR8DeB09i12izpsAuu7QivE43HrFhzlfI7uzjanNvKPCZ9NCjH?=
 =?us-ascii?Q?1RLzRINF/XOREt8uSDwB0YljUwJySi00h1FHq8CcC5u9H1YKFmOEidyG6EU/?=
 =?us-ascii?Q?96iiiOlqZbldGiknodcT9Xdqr1mlU7BjszDP8VJZthw6lnImFd9VZ9FRA/vs?=
 =?us-ascii?Q?ntySczbQOmMPVK+Ftq5KtoMbJE1Zt4H4pdFRpKamHpxwl8Sz6n9nziIymgCC?=
 =?us-ascii?Q?1RaSCk8arcIwVvtuiA7+tVW/oV8/Ndz+x+W0MMSoZgIIAm5SpCnFGDy6pe4G?=
 =?us-ascii?Q?XyVUTi44I8Q/RPgy7KdTH3i4Vuz44Wlt1vSc3KTBk4wT1SzoKoTQFb5SYt0O?=
 =?us-ascii?Q?S1G/MCRlvDTTQ1rk7SosTS9vnPQOeuOzOFD2cMv98DSdM6QgT7+yGBmfKRtP?=
 =?us-ascii?Q?CLF2Jt5K/1FcKMci3mZAB0L2VVrfeFBS/wViQcm8sYcjOvFx+ucPmmvlm59+?=
 =?us-ascii?Q?wH9c1WL6k55JTSVm/xd4uyBnVkHruU7SFkuueNy47ZkduhsbFcPqEQLM6sAF?=
 =?us-ascii?Q?pYSSE7wDeXeiI+byE7a0vUx0qAx8GM2g8VrLIZ7bt2HzNP1wXC7EdCeDgSTd?=
 =?us-ascii?Q?7gNgxaF6ycZhQF/cW1cQc6vjbA2djK3tyjzEV5ugLb/Wd7ss1vjGMIz1BEcX?=
 =?us-ascii?Q?ZcjTVJ8UoO3ksmqxZyqOXcvQ7QdepzHcYPNigrCoyCHWnpt+38WSWIeIgRx3?=
 =?us-ascii?Q?IPRLn9xGSu1d6yW5mQ38j+inNKdigvYaBUwi/1adRNNcl6GxP9uI2OsLtMHg?=
 =?us-ascii?Q?nDz/wT9PhhRVq3XWMrkIkLqfPiBEeylOZXiboVS9cS9WdlA7S4KOQKVr3tcQ?=
 =?us-ascii?Q?pHinVeaLgVTzJpVfoyMYths9SBhyw6p+oh38a+Zh+0t2klGup3LR7AV9BRc9?=
 =?us-ascii?Q?iH2plxyDEJ9L7KgyVf6YQUtdYzIIqAquqg6RTqTpD4DZQFdfne6BOr/zhQXZ?=
 =?us-ascii?Q?0avz0DGjsdDZOTWXM4UaIBrg9GqUcxiTWzIWU4nqUFT5HQ5x3tWGEWZTiSL8?=
 =?us-ascii?Q?bLERp9F6TaLhUAM/G7nhdmwwRRTt0d78VxYz/HxtoeNmnUSfANETjJg1OVPA?=
 =?us-ascii?Q?j4ReZ92S3jF05yE9vQ3SpcwncCwt2pCUpTzePEtUMKfnrtLqM24JauEPOgb6?=
 =?us-ascii?Q?SZHed9zr8iN1JB74OE/gO0VgcnQsxxEXzd9sj0r8DVt2h6k3agCfdV5ZzaTg?=
 =?us-ascii?Q?sJhwH6sqPivIs7utqYtOS8ybw2Cml/P0L64yTOt5H0hv96pXNiGVLs/MBhfF?=
 =?us-ascii?Q?Za8zGLNB1Cbc5yl51ZooTwpNrb6DkAHSR01emoGkkTdPOWtamv8Sl9cJTo3h?=
 =?us-ascii?Q?MOCC4LeDc9k5xQwXnZkhdbni1EtpoDg2sDVMeMBuwMKdtfrX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hTs2yFVsYW/nHeSoTMUU5IKMzLOFcVbHfP4LmFesY3FcXndrdThCqNGb4+hiDGjwklQ6234iTvtjc6RVnvif95gCr5p6yBh/ZFf8vp+F8D3zMXRsPhf/mRG5DAbzaDb0VeAs57yhxkwYoXT8yCq9ByRGJMKlgXqAtg47BPDbidZ3zbVGg4reZ+RzBhwvrAWQ2Py+lFFYVDcBrSPAANpG1iCxsQ9mE241ybxsYnu8zhbX4D09oo/q3pQzeNFMxF6Pkxv1McP+1a3a3mc9hvT1sEqydiGPuT5j0BoxApDfWxR1KGq2eDP8hO3xDtP6/9j+JX3O0OZzNYmL9g4BJM3iZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c94b90-a306-428e-7df5-08dee6436ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:44:04.8849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjFj1MbfKpJ8wllGbCCHfUb+4G9KJAgbBBYgxYQPdJbz6D7nPnH7oRciO+JnC3noiPVO9ypIw7GQIWcV5ENriQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6919
X-OriginatorOrg: intel.com

> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Sent: Monday, July 20, 2026 4:50 PM
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
> before IOMMUFD queues it for userspace response.
> Make iopf_group_response() send a response regardless of pending-list
> membership, so the dequeued group can still be completed by IOMMUFD.
>=20
> Closes: https://lore.kernel.org/all/B4F28798E2E784CA+d29f723c-b2b5-4b67-
> 8d1c-4f7b9b0b27cb@smail.nju.edu.cn/
> Fixes: 34765cbc679c ("iommufd: Associate fault object with
> iommufd_hw_pgtable")
> Cc: stable@vger.kernel.org
> Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
