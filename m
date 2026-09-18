Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D773EAC80;
	Fri, 18 Sep 2026 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700712; cv=fail; b=L6fAYgn8bFF0Wh6wjsSJw9pDbIQLDEee8/r3mZwN1JA9PzkbXRZWCCoq/dHP8gk95N1fwGl6T6bIn92V/b6Z1XJGZ23ksXFLZ9sHQ8e1aM5b2xDQGOmSbGNtU1W6+ZbKX3vf3ZS3KkUBTA+nPD178ImbPpbsfWM7oSoSfsnT2vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700712; c=relaxed/simple;
	bh=XjTrBnjt3sD5UrtEpK290AK7g6wxVUWUyTqYFtmkFvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AvrUTw6QwX7bNuvLp9XnZr8sqZZqweFKOAEXUI8bN877eVFqhs1OlvpBJeoBN/b2VC8wQkUSdPTsMC14bqVYpce5GmBMWbWSAzZRm4Q1MK1HaqOp22TeHU4ZvGtS0/dnBatdeCg+VWn8eoK60StwUrTB0g0pkQksMciD0dIgmm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMnEJrwS; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMnEJrwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789700709; x=1821236709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XjTrBnjt3sD5UrtEpK290AK7g6wxVUWUyTqYFtmkFvw=;
  b=UMnEJrwSKrLm93G1dLPaXOMlAIWKPKqG27BZZr3CZ6W21EduaEBmKzuA
   dh8LhRdC9VfT19JFII9FlSaLY4u4tNXJPXTnXVMK5jVSWEOimmiRWfLzl
   TnRl0+RFADSn5KtwBYy+WRTWRqgw1qqQSo0wtNCwjND6tGuicuF+xLXj7
   jLCaLeUw4BqjMmi27xQtrrt6vmOO2rr5pMkSjcE+LGpOFXI3TGNAMb5Gd
   wTgZ0BSue4rj56Pcm2E+ipkbpabflsCAYwskNatZ5kEt5sbjhmikqAAaV
   FeSTKvQhyDTgqRao2C6Hn7LVbKq0WtMSLc2BtGjemOVX5gBKDZqv6VlOK
   Q==;
X-CSE-ConnectionGUID: qcfYEPSHS+S8MkziLe+0Mg==
X-CSE-MsgGUID: d0mZLpRJQaC1tG08kSA5iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92690803"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="92690803"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 20:05:03 -0700
X-CSE-ConnectionGUID: Ty/qRSqDRYuNInAqwpMaMQ==
X-CSE-MsgGUID: 0xGqf155SoCxJOItfik4FA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 20:05:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:05:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 20:05:02 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.14) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:05:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/SuxOidYqKpDWu2jrwVmGMS3j3YaM9Ffg8IN9oHmawhTRX9SQcOwengyZqiWgsN/EAW2k0++4tlQv4djyoW+hmA82h40NmbbqKrYrIktFgZ9Mxe29p7x6Rpog35o+qqMpWyDhi4or+GxBdUcMgx8SK6PCJV+ZPEZwYhNPBQCA/tT4BA591c1DzkwIBxo2AJa0xxlYhb0qyXpPkM4bMPG8j7yy1gU3TClc4Hqyw9Bjb+yDIbVGVjuTMx8JFc19kB4QuelQIsWfDAwQDU9FVYcF809DQ/MB4uIocjT5c9Jkt7B5RAhRvgrIuPusGfBIryqueRs0ikuVrIXCaLjFaTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9REasuyhDKytht7Nd1dzQaBBPP48rWWOL3GUkCcS7gE=;
 b=P3DrcWa5iHWUUZhd96E75xMjnwXVIvPpQQvNt/MVRaQj9cHhAe8OcKbfsjz8SHlvTOMwJhF+uBBI/MBkjBr2MJ8IOMzqhrs6O/8sf2WH/nebndhBuTSru8/M24MT58GflL3egGc7UZi+q0eIyx59+V8uTfqbJF3sEDYQhL18e8ENSh5jG9+BbfPzXSskkBpbjjG2qVCR1z3Fu8PAC1na4jZPaOWaSXAMlVN/Xi1l6wCYHisyC4N/LY5N/eb3qQA2itvwIrJgK9NqSTzy2T66iLkxJl50jfBJPzZZaUuaA7wR3MoD9+DxI3ZBy47iSdLseIxhv6G3EWLXaiBwn5puGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by SJ5PPF20F246184.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::819) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Fri, 18 Sep
 2026 03:04:57 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 03:04:54 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "tj@kernel.org"
	<tj@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Xuanqiang
 Luo <luoxuanqiang@kylinos.cn>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] igb/igbvf: disable work
 items before device removal
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] igb/igbvf: disable work
 items before device removal
Thread-Index: AQHdGPzjJZCT8cec6EKBKYEDbf2cBrbUArEA
Date: Fri, 18 Sep 2026 03:04:54 +0000
Message-ID: <LV1PR11MB879069BE4FE975BEE23CF3E290872@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260721103539.57990-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260721103539.57990-1-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|SJ5PPF20F246184:EE_
x-ms-office365-filtering-correlation-id: 0bd5b1e5-3530-49fd-4c8a-08df15319d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|18002099003|10067099003|56012099006|11063799006|22082099003;
x-microsoft-antispam-message-info: f7oQIfAwKb6ueVnuxI7nUBHoK9rlXF7bhmd3YQXj4EnNrNNl/scgb/RAsb1sl00xKodGs5BYojMYIUEhblD0mQUyeE5AqCxgGXiLW9pYhGDkARVyWurqcYpzKftjw7o8oI5DipZxMe9P8yFrZtr4U3MscN9GumeW4FTVD+LRiQkRXK34UpAloXMrzSzXsTfQ+Rl43GIHnHfoOMEeGgLYIyE0pMcOePc5vvOIi5+eUpOd0C9AwYvy44qPCxVvxeyOuMKlNjP8UZCHaJS9KXqyTo+GsEBArSHqTdOb4Ae8+y8FytKW4y9SChjlY6jcHvF7MgAVQb1Tp2Me9hDAMgYg/B2/kTgNYrfSfj0gKb5SgBO5cWnCkaESJq5xTJWAk7XsH9JAawKtWOzVcTrUwb5xJlbGT6zu+GyvHNncYRmGCAKqJZq0vfP83GO9hQsal++tUT57gl8+stqwuvPY62/n+VYL5gFnfnMH/2CwNGfEDqooZEu9nJGKdo4IXdALHY0+KT9BFD3C1hUn3GLuYkbnw+OKMy0j0nP1Me+89C0+7RU9F/jgn7oaiOpdLovSQ+Y3tWawvMYgHCCgn49juZRTPcFCE99dyYGNcq+aZfDqhPWdXsgUsmKUZFnbEV4tsmhz9MGoL+HxoAfZHLM6wMMYHSjAKxKjRSZm7xu65yyJ65YBNNQN+IJ7/gRDOJpKYgu6frptXekfbauNEDxfU9uDF3ydS7RrHZy9lRNHL+IjdnM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(18002099003)(10067099003)(56012099006)(11063799006)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0d2MpXShE5LYbeoaGcKUjcIwnicqbsP9wbvbm9S8H8InNoN6kHlWee8d8gdZ?=
 =?us-ascii?Q?bk7vm98yt7PGvvycTvInYPLVd+e5QZGLwEaZhd+DuJitrH4Zrz8HdZ+1wGhw?=
 =?us-ascii?Q?ssPKBw3VNyEhSZYa99M/0stcoHEnkDHuvrN1DPAR3s6m240ibflcvLmQ2Udw?=
 =?us-ascii?Q?0UAJJuoSkeIa+cQe98mSj3CwmwEICHD3doKQq6Tb1GjOtwceRtedt4uENWYN?=
 =?us-ascii?Q?ARMr3/8HNz+rropc19xdT/pMyK8gZvjuCWNlhW7fwSSORGE5Ct/wJV5IQZmy?=
 =?us-ascii?Q?xMtLQR/Z8NUhHQW7QNyMKR41ijpTJ3qFoHxPV8VIhZ466VTb5WsTJcIPFQSJ?=
 =?us-ascii?Q?S/SmGp4cWKjUMwIVkk6/BvI+SYoH44dsmCLZcukAQZYtDSPGZ4nX5AnTceNS?=
 =?us-ascii?Q?0QDmMaCzj++iyD/oKWnHi6wmus4GUEX3CpKSz0b0pScBrAkb3+3Q5QW3cF3P?=
 =?us-ascii?Q?MNFw5yHf/+vUpxwwRD86PEzDUAOfj0o8u0UqojUyLvk8wglSb0b444Lp13Qm?=
 =?us-ascii?Q?RT9/2CdH9b8hMf3OSY0xiM/oaM94FeBbSdCXzCR2epUKfMhVHGNnIOjGO7Hl?=
 =?us-ascii?Q?goSr0ub9owg0xCga/tnxhv98X62jnmeWtFacpQ7W/o6gVILpDQKUT8P3uxV8?=
 =?us-ascii?Q?COHQhRHi7W9Nr+euriSNDba+Vb328e4+RMLz2CdHcYZ/MnubBdPA6WWv9CbQ?=
 =?us-ascii?Q?OS9QMi7ccSsWNu4W7ZideSanWs+m+hGKK5j/ZsUEbBBwXGoBDEhgVh8c1gzQ?=
 =?us-ascii?Q?Ea+Sl5dgATKCZG5QIyNtzF0PU88wOx1AsWJ36J7KOgKTgVasMipkYOeEo7xA?=
 =?us-ascii?Q?+1i0+Tb/2TlblUDoYOpkPj+kl17Vk+g4s5v/qFUoUX7muxeR2BppTHwAQr1b?=
 =?us-ascii?Q?utlnfroYEnLU1CSeW4bccaLARRvRRKAF1Th64D2pmQ/6w0c5Ao4cafRzIKFW?=
 =?us-ascii?Q?y2GeRDeBdjWV2CMkHokmsPDfMSz5g4e8VFLh4yfMdKYmIhzll8m2Qla1xW3j?=
 =?us-ascii?Q?N8/ya+sZEKXl2jQPFvJq+TTLLAb1BO6O93Ujtsfupaa+oC6adfumu5w3Tjjh?=
 =?us-ascii?Q?oYSbwaYRMsb0dB7gNi/2zNAwQ/4b9RcT/U/ljpyMQfknomfQgn0KPh9bj9HE?=
 =?us-ascii?Q?9BBJTWFuFJTTBSxrjmpv9Q+x6Y9o36DTxSNJgeQTWymhdCke3ofVaVPZVuXN?=
 =?us-ascii?Q?OhoMbXZOdb7YkpmIemaOGcnJxPtkJTmVGXWcnQzDvIhi5pzByKo6vN5qiwFp?=
 =?us-ascii?Q?2eGKQXEr+eFFpmqJagD5NAjbydN543uXJQI7LF8xXGi/mSi99oGl9NDnv7A1?=
 =?us-ascii?Q?HLVT0JK2HjeBGP3gw6P/31Ra2nSNEekebd7I9pU5aOtAYTKkLRMC92iz0V8p?=
 =?us-ascii?Q?mSdIHBcVBqn9ot5BVLKqIGYtPMokBUoiX9Eo0nYHj1Svq4p1FVHefBAK43/8?=
 =?us-ascii?Q?+fRETZ6Xuo7Zhi8KkZ/y8eORiASm8lNHYeGGJWABsyIJ4ES1df1dxEXJthT/?=
 =?us-ascii?Q?AlOs+2Qnww+CHWi/Q4e556RdG8EY1T2CWCuWc5R0whHj5tjfFEei4YLVb4Mr?=
 =?us-ascii?Q?srEr+HWjvwgH3mRHpoZURXlCEc+v6aBEGbWCjR6W0TNElqI0nKajx9J3yP/b?=
 =?us-ascii?Q?V+ziUUTn3JYEtpMcqD4O4N7DkDm3VlEAnQRvARfu0HoENaNbMrC1SNVbte+w?=
 =?us-ascii?Q?2IqD532Z5n9dmxlm2mKafkECqYftvflPvtyyQQeW0HsacowGaaMMSokJ9zQv?=
 =?us-ascii?Q?MEX3eL1Qhg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gVjNvlnfJVQA/l8tFmSBlKvnNaF79oglY5LpN58VJlZb6/YqVYSEWVRFwIWu5ijVQK7EC8BUmBMyR5i7qW85rlcg6eNGwBJgMLg7xUILGQnPChHFv+0nWgS9HOpvgRPfQE2KeFRjgFK3EDYuRtccWurUIcYwE7f4ArbbajVwgnOuQccv3qQoM85a3O0dyTM2hyXQTpPzRAvjhq1KYo7+hyA5+hWDBvmksS9rYah6pjW8B76kOjQfqWXRSfKf3pVD2+fFmfPK/9HIhXlPD4UqaTwtRlfs3wxkQ/8AC/aBN8gu6zV9h7XoAxjN23pK8N0p4+F+SAztSiiDkII/DTL+sA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd5b1e5-3530-49fd-4c8a-08df15319d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 03:04:54.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2casMfDdxM5L7316jOxU/6bxWG/hyOu4cdA0ckPAokCdZGqA/lMhUeRf9qGuCY2suQ2650mtFGh5CUPtMyC2F3qh6CMCL6hr99Cw6j0wINo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF20F246184
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of x=
uanqiang.luo@linux.dev
> Sent: Tuesday, July 21, 2026 3:36 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <=
przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; tj@kernel.org; net=
dev@vger.kernel.org; Xuanqiang Luo <luoxuanqiang@kylinos.cn>; stable@vger.k=
ernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] igb/igbvf: disable work ite=
ms before device removal
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> A watchdog work item that is already running can queue the reset work aft=
er the remove path has canceled it. The netdev Tx timeout handler can also =
queue the reset work until unregister_netdev() shuts the interface down.
> In igb, device reset interrupts provide another enqueue path. The reset w=
ork may then run after free_netdev(), resulting in access to the freed adap=
ter memory.
>=20
> Although igb_reset_task() checks __IGB_DOWN, checking the bit already der=
eferences the adapter and therefore cannot protect its lifetime.
>=20
> Disable the watchdog work first and the reset work second in both drivers=
.
> Disabling the work items also prevents racing attempts to queue them duri=
ng device removal.
>=20
> Fixes: 760141a53e5d ("igb[v],ixgbe: don't use flush_scheduled_work()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--  drivers/net/ethernet=
/intel/igbvf/netdev.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
