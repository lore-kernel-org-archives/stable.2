Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3322931D1;
	Wed, 15 Jul 2026 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100303; cv=fail; b=Z+A5Hp1z/2IPiLLT+W9hAQ2DJmervY9IMKldaiJxFjHGovzFrY+EZjq0XIexHUuTB+0dFK2WsvT1sKLfwNKpOAtXb7GwARdah4tdJBoPn8N6bo0Y1d89Vg+nWhOLuE5Fhwevlk2EJ9ZpwXekUoqcC7QQ6faRfPvAnJxPJyf43aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100303; c=relaxed/simple;
	bh=HaMx3Im2crRfY0G/vR59DgPQmzYq4XeeB5LBAL9Nfdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fd7Myjp4fxtkdfNDmaZ+xH44FnEXrEHgmEG1HESVi2F3RqWUmPH3xMbJRoNlUR1wDGm70SNnKRl3d6wq2qV9vszkynZx1Kya5eG9MLGYmI/AG2kMNhHz1DVDq9h34JLzSfklsx8cs8uP07xwsia+/JuUvecyz08wDy8wCdMPNkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=do+zu9a/; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="do+zu9a/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784100295; x=1815636295;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HaMx3Im2crRfY0G/vR59DgPQmzYq4XeeB5LBAL9Nfdg=;
  b=do+zu9a/ipkTs79FJqTdmqoDp8Fq8CslIElYvd5KeVdfTU8tdFaaW9zr
   t6mNyiDSv82rUikgouHHwLtByVVPa0axqweOIKg7GnNV3oXLD1hwwdrlf
   IxYHAkIqMxRQCZdfSKuNX2kortN4UMpSL+C5Ua3QQ1oDueH8jCgnZcri8
   z3G2KKNZZjYX1JbBK8eltJsM7ntNyQCS9z4qpm5iHlZDqZW5duf/pns67
   DmwqGmDYUc06gcsyH5ST+d2h4GpxnzuvpiV2Ti+hq/AiqVCOROhFJ/JZT
   jiUeH4SI324KBDHqU1NniQt/utdLkbOfo38EhIQymf2cMJPgEYTq9Ywcc
   g==;
X-CSE-ConnectionGUID: mzK/IiMQQhem21KY9qcfIA==
X-CSE-MsgGUID: bPHKLC54TAqz+fa12Hcu4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83716323"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="83716323"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:24:50 -0700
X-CSE-ConnectionGUID: azuzFCFDTzSCboR+LpMxug==
X-CSE-MsgGUID: iUBEj5aSQMWe+CtthGjWEg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 00:24:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 00:24:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 00:24:50 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 00:24:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LztcQ+a2yOlXuZunQ8xloZDCdXc1Ua7d57GSQFhtz1KaZFO+hPLmjf8FPEqZIhziUll3PGxHC4DyJyn/qnKpfroQthhC40sGRh0FgScER1FvvTIyoyGcJTPxW6gRwcIKqcKYHwLOaIddHTAaM/e2KXoNGiktbax/QndC2iKlM9VRXCHCkKBjvnF4tQqRAq7AhGaqRuATwNjMp/bZw5KSnA5zeI+E087Uy1gS3hRViQrq/XQ1Ci+QYtyBoeSvccyqgByYlYQGsP9iGXBdiq6q3GVNF2InvbEEnnyfLaEk8kzZ+v+phLAHSgGmCaRW64MjEz09pPK6R0QctxPwx/s9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaMx3Im2crRfY0G/vR59DgPQmzYq4XeeB5LBAL9Nfdg=;
 b=rr9XqlR2Thf+u3TfF/GtuSXykU9r+JSKIICZZnt632V3ukrL453YXNqohhDOUT63LQRIY0ebbZCzT0O4qTeJC9n+zqCugl2hhvvCn4pdMdEEr4FfYzhJtrz9PEJf3xfWyWwEIkZ+jW7TQzA5TbqX65rz84UWv2Z7Dp0QfU3mxG0Mq76UflKVAtYSnWXdgQTmVvt3BEc6hh/IEiSByfhaQH5zK4CPBHeJNg810C93dpzL62WZzYmCCxGw0HrCcZ8yg5LxWflGJ5BXZt2RFLbei8no2m8rp9AxiiBMwHWeSkZnKjPNAF73jz9z//o0iSNi+RHd8VOMNA2n1Y63m1GHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by IA4PR11MB9442.namprd11.prod.outlook.com (2603:10b6:208:55f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 07:24:46 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 07:24:46 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Mitch Williams
	<mitch.a.williams@intel.com>, Greg Rose <gregory.v.rose@intel.com>, "Sudheer
 Mogilappagari" <sudheer.mogilappagari@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v1 2/2] iavf: fix QoS capabilities memory leak
Thread-Topic: [PATCH iwl-net v1 2/2] iavf: fix QoS capabilities memory leak
Thread-Index: AQHdFCFAUvpnMwFFhk+NLzQJKqs0qLZuLbkg
Date: Wed, 15 Jul 2026 07:24:45 +0000
Message-ID: <PH0PR11MB5902F61778270611FDF6AEBDF0F82@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260715061131.34420-1-xuanqiang.luo@linux.dev>
 <20260715061131.34420-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715061131.34420-3-xuanqiang.luo@linux.dev>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|IA4PR11MB9442:EE_
x-ms-office365-filtering-correlation-id: 6a110cf7-e8ab-4c07-9c98-08dee2422596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|22082099003|18002099003|4143699003|11063799006;
x-microsoft-antispam-message-info: rb0aO9YwMJTmyC5vvjX+c+FJXt51IyinK0Z5OT3M5MO+VEDzkTxMQePutFTc3UFp1QHAB0SUn+soQkn9bfYkoBpS4SFXyAq3sKM/m4M4mQYyed2cANB6kNEDTUI9f9JsrVDAajYICK70dhGVNDf41auzZQFEQDCBf4vFL2G86BMitaNVZLUiTWcn8gWX5/pTLPuWJX8SQH+Yzo8OsNShj4Q5rsns+TtocyL1Or+ZomyscGqmWas+BFDcBr7SFOtagGuSpYGtuk3LKAkMfQ5SUY6N6E19mb8kW5FfSqBAmvuFJaRpnu19754g1J2VfVL5SlCX3akodXLCkRm2U5naDWD7n9DtyIbMF+ijh72jachFEQSIfsp87LegI8RdFLZYw3POP7iLxdYkLLNPkwCPANhh938Yr3K+Z1Q8Y6O/1/ay1jD6GgPLfsFsbuc8vANwBiKs8wst8I+rw/fKzn8TX0DG0wBdDrumOOs5nvxZpUEQfDhDPb5e3HYOoPusFxvWNEYAxUcqIg2/FFOLuwyOYXcE+FwpGdU5+D0h8OLsWSQrlTBxIS8ky2rhWsaYYfroQasoay6aEYaJZ27c8ate12lj4RIjGsoaZlcHwSOwIzqLB0lY6eU9Y9ViGFIipNHVQpgDE3tORni6KAgZPVe8f6j2Y38qkhMYwVIy1uaGDiH3kH44bIMvnSg8tsIFW4IOg92nf0cPyBShs20ruViF4SoCrlYwIbB2vW+dfIkg5s0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hl2ToQwaFDzNytdRj1asPDMWpKfp8LMlK4HCL8GlGWOtxuf0/jy+LXOeCZT1?=
 =?us-ascii?Q?LYsUqJ5hgu6CAIVFZezVpyZghhtcS983A088blRY7Xc5AUbyH0ENEAeuMZ/G?=
 =?us-ascii?Q?3g8TI3s7yT2UzHWB9eS3KK+c5FFgJNPyLms/YrlennrsWWyFVRACXNBuDWlo?=
 =?us-ascii?Q?JYP+lIJnxidjlnXl9hCrbeP9KSddWXT5bUx6ld+AvmZrslT16O5hE31yGX45?=
 =?us-ascii?Q?EKzu+NGmh2MokKNuGMI1CE8WsGGNlsjZHt3s7814MK6zPA6HYgKbszkokvzE?=
 =?us-ascii?Q?D+oB4IW+949lNaSBFPwH/F79OmeLWnl/3nkzx7RkxFp1FxTAd9WivImJ2pKS?=
 =?us-ascii?Q?vfpwiDxt1gh24wvaxtIJzvhi59QwVK2BSTNWjg34ijoxmdhhKIecKgwg8o2Q?=
 =?us-ascii?Q?xqRHy0ufMyMsSIMooS3Gf7n/IAf7LLPJa36iYagZN0dUmF/2ZNU1IAIPDjmC?=
 =?us-ascii?Q?M6MqhQfej0SUii8bkrD4NfKNDn6kvnLw8Cu2UfpqX1BEOqpQer1S/+br6QUR?=
 =?us-ascii?Q?LTtS4lqiKdwSlBKp6mE1ejzE1MdUXxD3xt76SLmNeR/jzWEtsetF304cDqM3?=
 =?us-ascii?Q?QiuCO/I/MGHaLtyrTMfJpAhwVZt3l+uWmtGDdpUppggfLYkGIf1l1yUXLt7P?=
 =?us-ascii?Q?rnl+yQyJAxk6u0IdbPSN3tKYBAAvRHgfkjbROl9XchR0mL7SbHe8tpUJIgkl?=
 =?us-ascii?Q?bLikJ9xzBs+k/RBx4xMthfUfBnRpbH4fdf4V5g18+mVFEc9EbZjnlhKye8oA?=
 =?us-ascii?Q?5TRH0KFAZlfeb4dllrlUG4WpDrNnR+1cLLOKQOl7DnZtX3Tm2meiFptWdQbP?=
 =?us-ascii?Q?MTvpjXxe4oKt6VsnXhYGc30h35v25pnNEC6nsY4nkfIIe0gxdaXO9EII4W70?=
 =?us-ascii?Q?H/5WSrjhRb8R9/wqa+LUc3AKK+uyt5BnoibzHxWOt/I6zHAIcU/+Epc3autD?=
 =?us-ascii?Q?uyoioTCVd+L77Nr91+pQTbD3kvAd9hKTJmvGEzQXrwV17nqkZdMwnmsKgMVt?=
 =?us-ascii?Q?exSp2Xn1kh/N4djcl23EFdrGIoN2akRcTbzquTUkE9Tn5wss/ACWyXq8rImE?=
 =?us-ascii?Q?XcUNXpWYVAzJbgfOntCoURlNFAh3LvUkrJE0ZBaqS2eKx+hRZG3KdcjOViZV?=
 =?us-ascii?Q?mzuP3KmEPGAilfOyL7LaHH4L8VGnbcrepk7Ux9PQK15BK1JD70RT64rLK80w?=
 =?us-ascii?Q?PAX6qIphjA0t11JfX8CchI3T7+TEhrfF4xd+cJPsXWjMTi9p7w791Y6z7oto?=
 =?us-ascii?Q?xSp45lG6pAlB48MhdaTZxUJ01I3mhSUnlKSr8fhxcBQHv4kErbvGEqs4CQuG?=
 =?us-ascii?Q?c3BruKBuyC6mqBaFwZN/Snh6Vmnkzxn6AcnjJSlHrOQTP13NaHt4L2FSzq+8?=
 =?us-ascii?Q?tdAnXhjB6bXtU6EfpM4Nj2nxRXr+vqL8B0Um5b78FJ9Ez4Vozeif98cxHnsm?=
 =?us-ascii?Q?5NcdDbCySbjQEda2Rzko+JGTMbUmzVk9s3KI6mJKjdwvX/r8minEqyk2nIv1?=
 =?us-ascii?Q?WXSWChAUpXMTbhnO2/mxwrRIud0bgGHMdGG7kpZTv/0V1vQudqk5CMzWWoey?=
 =?us-ascii?Q?vaD76KaEWVgfmpCUZ6Gr8loS4eafgEbgCaqHf5oyfipozey22cFKn4Xe1ryB?=
 =?us-ascii?Q?7JmjzGqR+phbkh5Lqb5QVgoE2TuyP/D8Y1T9e8p+duzdgkoofUzBYx9tL6oq?=
 =?us-ascii?Q?FqikiqUaBnu/wIkyzuc028gdRMMe1LBmiUo7NEFwHsZpspMhn+1cS4Y/gStz?=
 =?us-ascii?Q?i26qyheq+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gaQ8CHeRVMgHGNvLbSOxpjXzH5bgkY8V+wQNUyEisHGjVc07w4MsCW9JK7E2DQg5lJELEklCA7IFpv6oPfJeuDEabWvuiNHqThR/oFKFq/ninUfIy8GGZ65RNZYFkqxL2RTck+de22aMR7069PcKJlxeqV8RN6NEPAflP6Uxkh8hDEIq8OZHUK5IX9vZu9yaeJxT3eDkBMXsXWXfKhX2iYG3Zv8wblCsNkJoiqLtGxwJaNkCqRVsFGm/zh2BjYhq/gDyX5QmkUOFgCPWbLXG93fm3XRWzsSuj5tW9TydTCbffcB6d29uCU8N9ZYRjBf+weq6LGHrKL+B/d8H+f1M7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a110cf7-e8ab-4c07-9c98-08dee2422596
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 07:24:45.9511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2XeYND/FXuOvprPCE9e3U/GahlN/wONbZFAc0Wna/7Vh/SReovsojbkDNM3SLfDOK2vgwdR0byxXeMryabNfn0iQotwbx3cXgjtzynmjtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9442
X-OriginatorOrg: intel.com

From: xuanqiang.luo@linux.dev <xuanqiang.luo@linux.dev>=20
Sent: Wednesday, July 15, 2026 8:12 AM

>From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>
>Commit 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
>allocates adapter->qos_caps during probe, but iavf_remove() does not
>free it. This leaks the allocation whenever an iavf device is removed.
>
>Free adapter->qos_caps in iavf_remove().
>
>Fixes: 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
>Cc: stable@vger.kernel.org
>Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
