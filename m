Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2541370D4D
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787700415; cv=fail; b=Gvf8SaQS4WGuZHOvRqRIAtdYg7fBj9maqEj7G4GGqbM17LsudDcANilAzYoycAX2Fo75RoShwzHh9K4otJHJEtWBx1HVahpkdV+R4xO8o2iEPx05wf9wPitYASpH1yrKKrQW8P5/l4EyefLJUBQ8MRQiF0ToMzJpjvsJrqZutgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787700415; c=relaxed/simple;
	bh=JmFGNdoIARnNvwExNDac3O9I+fiozKHqdme4VkyNh8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=upnKQsEk5ujNHr9muRaUjwtjvNEbJBjq/WQ5rfYOnoILzmXjtHJUKKkhmHQPnHk+tk2ADUB5YkSRdP2dpEZYjjUYE4BRfj50u/RBAxpu1SKNsjtjO7Lpt6TUJNxJbTgzEKO4ubi8o8CJGNV+17/tTx7xJJNqBPKdh9sMbCT0Dc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVgDD4gu; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVgDD4gu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787700412; x=1819236412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JmFGNdoIARnNvwExNDac3O9I+fiozKHqdme4VkyNh8U=;
  b=GVgDD4gua8+M43BQHsN7oKFbxRmTheShTZKmaEFEU02/vcktNcRa5xph
   hKU33HQhq/IiA7dEIQMBKTNYdighN7r3ei0zQUWmS594E+sbPlRoOaW1I
   cjPeFIBUyyFy4OxlsSagZcP0q4K6SOtkPESd+05UgULzSMm6i7hMdV7Lb
   ++h3U65//qPhjyvfBLN6LfuqpcGVn2wzGwSwa1rw+QDN+fhqS4BhyAgLV
   0SzkpslHc1ZUhCz3L3jVp2Zb940xrngC6JDy8/epev6P/UAIVwUCyKdb0
   6c+q2JWeThIOlBkyB36/cr0X0izYDBw9nkGhvip+N0TmP5JKcMgrxhYio
   w==;
X-CSE-ConnectionGUID: pB3EESIlQ+WIcpuRAkIEiw==
X-CSE-MsgGUID: UCRJRy5jTHa6TzE/WLspjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88036173"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="88036173"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 16:26:52 -0700
X-CSE-ConnectionGUID: 2EQVroQxRhC/i36kWl56zQ==
X-CSE-MsgGUID: fa6N+SQ+QhSHFgVqZ+GcEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="261277522"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 16:26:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 16:26:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 16:26:51 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 16:26:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRUE9qmzCiZb5vo8slj8fGVj29ervfC3QtGvZlRiIOFqe6vjNU/6bUgvEp6jFj9FrTXI+nGNC0BPXAgEsm6vkdTbA0hgKGf2Bz5008nAQGyXzm2WbP5urhiBfo7ToBOUJ4jyYv8ADzMVcZV1QIjP538jpOPmfPJ4XjrDFzP8L5LWKdi01U1kZ4rlpYU+vhxUJgo5OJUGANaJ8SdOIY2mrMbw0g2nygulX2wbR1O20BnPUM+O5y3mCV+IpOR/c3TCVUcm+oSnNMqBU/69rNETqEDw9sPkm67dtGpsM2IBT1YxOVw5XZ5ruN6AgzI0S8ESVgcK0PHaamG9GNrRghYf6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmFGNdoIARnNvwExNDac3O9I+fiozKHqdme4VkyNh8U=;
 b=X7QpDcC8BGodoS9FCImV67jhILx4fSZ4L5hXbQN64pQCXeSdyaxEDi9NAFv/SOTSswV5s3c/zxzRTMRt2ERHIO4YPN/7+JmkHiWrRR2AwUzjVzwZt6H3hLgUCfAJuX16VlQemI3acMBljGeiCNnzNQ9UJzCmVqH02Gz+GTxANljkjtDcyPA76R0yaKq1xerE0Bg9o+dxo9cjt+Tkx2sduJAdksTJv2OEFNrutilK+9AVSzXZXgypPV2SqZwndxV7+EZb3piJWCCgyoDUnPxiHp85QMAKQ25D3ypShX9m2v/qlkFvMwCLgy0T9OYz0oOLczYvHMNbzm4PV6XjXqK4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 23:26:49 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 23:26:49 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Mun, Gwan-gyeong"
	<gwan-gyeong.mun@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>,
	=?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: RE: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
 separate BO
Thread-Topic: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
 separate BO
Thread-Index: AQHdNEOsiSEBcNzQHky6KoIO5zqwNraub0OAgAD4pLA=
Date: Tue, 25 Aug 2026 23:26:48 +0000
Message-ID: <PH8PR11MB80406B2B95B6FEC3ABCD4702F4AF2@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <2026082037-mutual-coroner-efeb@gregkh>
 <20260825034113.642528-1-jia.yao@intel.com>
 <2026082537-porridge-banish-b3bc@gregkh>
In-Reply-To: <2026082537-porridge-banish-b3bc@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|SA1PR11MB6807:EE_
x-ms-office365-filtering-correlation-id: 32d4f27b-4c8c-4804-55c1-08df03005628
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|42112799006|23010399003|376014|1800799024|366016|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: VyPlzcRVz1auqAYscJSkAYCbAC0Kl+1md1lSKG5UZ51HXQZ9GMNMhW2+iJNPp4aBIyr2DfyHBboI2FzI0yz0/BTHSP7ey4YKPnN+09dcZc+ibEsdGQNeInEoelqmgarwGw8yCB4NWLiCjSiEbCha0nQitagiKGgL5BUFOuVZcQtPCeik4jJ1R9vcgqgwJKoUVRYn2S5bDvh5unOvPoKseu8gelC0o2kf7KN0gFejMGbZTIfXsckFxrvtsJRqwyBbOl+m3LwGSz8H12tCfh0cNhoP31jDHH3t4RB4v3MzUIwTTCCTfcAl25ePO4VzLujP3YB2ISkp6lp9pjvjnhcV6L0rulzl2qTLv/khJywYWCOJP9JW0nAwnDHL87MEFwjKwZAhTz2M7RenyII8FocBvlWlwfRydyNTLWCZiDsccAcq1uoBNtVuGuI/3BW55tDKKJpwjPY/2p64qO2zFudBolJikkaY9hDnKW0wUOCdkbgkpraVTlucOklb1J3HK+o2Naw/XrUUq/ICQ69SzcfvLpT50+JUmv5yTdBZ4A1yFGVyVJGvBrQ24rToQeizXCtdbE2XB36vh9rpX+XwrJJn2hwSKv54Iw8JI1BuWrTHJOlunkJRoOzda9RjGS4FT7iO9LdUi8IRMVAu7aPl+8J60rGRnl2CQWf9TbXhWqdkIYtbgfXVK/SOVihemLGh6t/a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?212EKWVTmzUyAOYc+CXk36Hx/dg8APQuDOkCGw2k/peg57EOXnm8URVOnj?=
 =?iso-8859-1?Q?+9Xa2skiPp1v4hzk3tHJx4jgY+5qZjsaL9l+7d0wcquHInMHU2txzLY4CR?=
 =?iso-8859-1?Q?gfG29xuvCFDsyYuiJxiNqzWPf0rYlDFi2K07dWtv05ngXr9D1sDOZPoyf7?=
 =?iso-8859-1?Q?gWoJCInkddP6sYwYF8QyZzwgLgSMdp2Gv8FKrRtn9jXPf8HEZDR8XZnVHt?=
 =?iso-8859-1?Q?d9qELqP3S4bv4Rqtsm++MBLBtckd09WQsBapxhT0UbgLtfNoNe7rNVYmBh?=
 =?iso-8859-1?Q?rRAHpHtDaag9wvmjm3g1jRkQPECwbmi8lX7kjJSgXSDg/EThDdZtEyfJXE?=
 =?iso-8859-1?Q?1vKtHG3uLwLvE9DmPoDB8W8nY5ZN1vAFb7svZW6OAc9JlOnUUFBoDXWXT7?=
 =?iso-8859-1?Q?Ls9RWLPGFFoGb/JKPB6+gvfhLc4fStD1KeHIOL2A/SARevCROdASX09PhZ?=
 =?iso-8859-1?Q?TBGWUKW/HvCEB6AyRzbCq3GXtzf8JdmeEVn9/JqmRMG9oY4sblXgcGfwu/?=
 =?iso-8859-1?Q?wALD+Y5o4E+VBJjd6KTzvKwWSWFSlMxdc/5xrKAPz5ZfEvcm3YnGBDMrfS?=
 =?iso-8859-1?Q?+kZYMfdrjkoBFAo42vmss4Z7lKULoMaqpD6vcGRDq97YzL5qEhYadUP5G7?=
 =?iso-8859-1?Q?lHgX1PnxM/2gQmKo316FvXuoM9oBe4sE6ygOXhv9IgRyWAHFAABTcy3F4p?=
 =?iso-8859-1?Q?FZdkTMtYt1iy4j5097eV7zj67lXXugv3+y7u0InHl4vSn6x1alcFWmNKVx?=
 =?iso-8859-1?Q?sZJ8mGh8zwZUT16fpdkr6Kro2rLn/1wkCKyKgDzZSlWyO5MrkSEcQKhqXn?=
 =?iso-8859-1?Q?FUtfbD8gN5+pww3Qh2mUuOtVG+EkHnWoYn7gHzPTbToI9+QISQpy7K0RVV?=
 =?iso-8859-1?Q?KIOUFm4Sto8Ig/Xv1+ZMbYXAURLLlMfgCdSXtokHHOTCRIidrbGv1t1dab?=
 =?iso-8859-1?Q?795BxaAd4mmfubIubYS5PXl9mc+7VqO1glvF8ziPtU6ILM2I25VDaE2f8X?=
 =?iso-8859-1?Q?8ynmATZMsvh5CL/7+oLyL2kKclDvVx+o1MRDnM6sCvcC+CcP5z6CyIbJe7?=
 =?iso-8859-1?Q?fL92qQt/XFtreZuEaXl4/LvbOf53LVxONtfYmobiqYR73JTkLY1HNLPUQx?=
 =?iso-8859-1?Q?jTo9OUgIHqJs2olma2DuzIomjSll+DS2TG7WuIKp3NnqpotcHCg8trUYCp?=
 =?iso-8859-1?Q?qy3e/HiK+UzujETTHP5cfeq9kPaKfUw+hDtNFrkEv5Q5IHAeRqXh7G2NT2?=
 =?iso-8859-1?Q?T/n3wd1rRNRQbFn3ZUaZ1z2yX9G4MZ0h1Vz+9SF9FZfUP3HvPdeyPXxBBQ?=
 =?iso-8859-1?Q?bwyNwSZVTXUP0TSfHqZnAxG75oKdywGeKrDD4gGhNI/MAiF7GPPydRldFr?=
 =?iso-8859-1?Q?0+9xUsjaiMhb3HgzTHRu5cHFpXnPnuK9yBAI1NyGdCpFllyyFuQEVWOw4h?=
 =?iso-8859-1?Q?JJsx04o1M0/VIJiSp0ECDnQkFNb0XvvoiARkRf2yUYC4shFsDNoDUhPhd+?=
 =?iso-8859-1?Q?OP/8hPGF3eQScegR8NrDaVU64VnSLZfrb0aXTEI9tf1PmSen3f9MIFezYa?=
 =?iso-8859-1?Q?1q2QAVETuHzvVkjd6pfycp2b5LRmkiOrtcS/XIWtFYbrF9HwTFcKSdPA/R?=
 =?iso-8859-1?Q?JoxO3RHy9EiYBl/b1W+6gci1pz7QeaUUL9lIPDh9ZAM70N5aYWxX2jLPeo?=
 =?iso-8859-1?Q?vGKPFUoJrKW6n+NIxTQy4sTakY6ChTzGSuMg2rVZ9kZPGiAx7+MFpllNTR?=
 =?iso-8859-1?Q?Nzbc7hlA/TXZB9WjUsnHUhyk7y74oDrfBjSh+LMNv3Dp3W?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lx18IqaqTyNjCSr8ILzslSI8lEW3HFeiOL8X73nMejJ1PJI8XknQs3mhMHHPtUlS1bnXOyHGbxUo+bLs7lzTgRunxMe8/ott+ywMG2eDwtj3xgZjBj48yAyDqVwqH8zNLLusz+rLYhxQAa1nM6FhFyTgvkb+00UVY8m00E06TDLQ5DhETF188PYEWKfj9NHqwWraAuJoTffbx+e3g9C8nRMS4XLzo+WvMixZpKOf61D/sWwdPPFIOxeOZaQE5lRAFt6AP8xbwC16uWURoPiiKwzjPcRCBstl170hl8eAxDey7e4uw4TEIYtW5cp9BD3JzAr7cUp5iqXqXVLE6Utk4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d4f27b-4c8c-4804-55c1-08df03005628
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 23:26:49.0077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKtsE6Fl2UtA/I9mtAl4P992h5Wa1wg6tmvrGh7DINUvu6ore//wzSoXjYDLY59H4Kv0tNa/GyBnIjhZFW5daw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
X-OriginatorOrg: intel.com

I checked include/drm/intel/xe_pciids.h in Linux 6.12. The highest Xe gener=
ation defined there is Xe2, the patch is for Xe3, so the patch is not neede=
d.
> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, August 25, 2026 1:30 AM
> To: Yao, Jia <jia.yao@intel.com>
> Cc: stable@vger.kernel.org; Mun, Gwan-gyeong <gwan-
> gyeong.mun@intel.com>; Auld, Matthew <matthew.auld@intel.com>;
> Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> Subject: Re: [PATCH 6.12.y 1/3] drm/xe/guc_ads: allocate UM queues in a
> separate BO
>=20
> On Tue, Aug 25, 2026 at 03:41:11AM +0000, Jia Yao wrote:
> > Move the UM queues into a dedicated BO (ads->um_queue_bo) and avoid
> > CPU memset operations on it, which eliminates the CPU as a potential
> > cacheline-polluting agent and helps maintain consistency between GAM
> > writes and GuC reads.
> >
> > We also need to ensure the base_dpa for the queue is contiguous on hw
> > where this is used instead of a GGTT address. Another good reason to
> > split this out to a separate BO.
> >
> > Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.12+
> > Signed-off-by: Jia Yao <jia.yao@intel.com>
> > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Link:
> > https://patch.msgid.link/20260804165057.129529-2-jia.yao@intel.com
> > (cherry picked from commit
> 6af05de0dc19bbf3aaeec2020fe48b37c834b811)
>=20
> Same problem with this series, invalid git commit ids :(
