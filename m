Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F41A9F97;
	Fri,  7 Aug 2026 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101344; cv=fail; b=rKEyRUnUUEMI4Nj0i7OKkdkiJzOj+YqWWXQDTCWW3ProKfkct/s1OoNNYv9RfLTh9tE5uO/BKSrfrYce4H/LQBP6it+jXehtFrtWxLyAsXE4zwHGo77Sz/yW0BQAfKksEoNEqyCFk7go8FmcAQzqsrfeokv4LkfAvwJpbQn06EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101344; c=relaxed/simple;
	bh=i4q4AXuEpCjtWdOLQ37tqnsuizIrnDJVhURcLp7kf7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=euB+29RJl1n279jYDohf8pd5/MsYvA8i7xDEPiKYzxea3iqYlk3xg/pNHo27W+EovZwT/QG6eV9/Cq+zUjKJkrAv5x4R79NSs44MVnukpaVmJcrMZNlwWsAwzcWvoX2Fj/LtcB68ZnAa5F3iv0/dM1WmdKsD5Bz38AAYiU7Vpi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mL7gZIyi; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mL7gZIyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786101342; x=1817637342;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i4q4AXuEpCjtWdOLQ37tqnsuizIrnDJVhURcLp7kf7E=;
  b=mL7gZIyi4x15JHWVbJ0Q1hlUBK3pcLV0w42PX2vC+ydGHFTATaEsbeXq
   Xl5pdum+wMP4SzHZlC4JfT8GGyEqycGpFwXJ5Gym/gYUBaLlcsp3jaacS
   1ak+2b/wtnK8bowj9TXRvVQRXHxO3evei9el4LufOLGoLIGypucXG/3yL
   +ArdVLSvfFcSQtlKXSbnH8QNaZoWxS/FMcS5JgZEoNFWGftavg/d9MT4w
   kdtGhwflyH5zOyzd+L3kTexGzQ1vdu5GUXbslq8239gdCTV7jCW1gF00+
   kgGcgtf3l3B2pUoHKdjLXWxq5RvC3S7mu9W3/OUYdx/5ahFvyPXLmH7x3
   Q==;
X-CSE-ConnectionGUID: +hXzVMUySgCUPOZh+PAH0A==
X-CSE-MsgGUID: qGAGfwGrTruePtTj8MkS6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85827104"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="85827104"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 04:15:41 -0700
X-CSE-ConnectionGUID: CdvvTW6cR8StFRADcUo5jA==
X-CSE-MsgGUID: PBn6uJjHSKOedk2zFtLF0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="258513604"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 04:15:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 04:15:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 04:15:40 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 04:15:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bitrLq1kJK0HYiftwly5wMoOMkE9noFwn1QbJudRIQxH5bOWCVUqA+It8/sCoWvcenmNm+yw5/SxwKJdKJ+UjgU+5UBxUlMZ1tDrZqCR3Vo9OFenJz4czohpWt3ZYaQmbOQ69qoRiEdQRUVXL0rQ5s2+wXoO38BhGvGLOW/ni8DkvdXH5q+wtW/a5ZbNXP4zkjZeJHYXaIOD7yi5MH9MHkey501tRPjb/N1PCBb5LJqxUlnfscHIM2rDW1pus9WKFdUWiVmcnfVvUi1E2YqBd0mnpDy3WjmB+ia9wCA6lOBKkuocYVumSruB+LhuNyJ9XoKd81ijLIUBWyya432DOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC8FDVFvaNpe6Vkh3AF8qPBDYGuBkw72fUODNlMlczU=;
 b=X8APM4GyiHoVHTIQoeU5SVIEr+XKtn51oHgNPIGKHHEcu/1FhsWC0/JzXzWroUyESg6sM1QQmYZdo4MxOk9EZ8ZKnVkDRoPuUZ5oYXsK14lujq0syWnhWy/z5HSbtZuuiio7LoZlsDgmt3M14gMEKgFiSVxSFF098llHqtBhhqP4mK7hQn696Z7IukpuiSbzGpIyf9nY7+6iI8z1Ox5Ut/AVIZNus1zg/1A2h++KOZlFtgsxV5yYOprbX7Dewemh33DWcMldkhywqc63sX5sG5yK3QQEZ3tvdudwPSx4YlboAn/A6p0oBUwU5C9PkE+9aCDcdaqKnqdiD0okEIEqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by DS6PR11MB425752.namprd11.prod.outlook.com
 (2603:10b6:8:528::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 11:15:29 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::675:8a:9680:ad3f%6]) with mapi id 15.21.0270.017; Fri, 7 Aug 2026
 11:15:28 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "Hadi Salim, Jamal" <jhs@mojatatu.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "edumazet@google.com" <edumazet@google.com>, "Jagielski,
 Jedrzej" <jedrzej.jagielski@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net v1] net/sched: cls_u32: feed
 u32_replace_hw_knode() with correct set of flags
Thread-Topic: [Intel-wired-lan] [PATCH net v1] net/sched: cls_u32: feed
 u32_replace_hw_knode() with correct set of flags
Thread-Index: AQHdJlbpE4oVQDQmjU6RjBYWqEmPJ7aSbpmg
Date: Fri, 7 Aug 2026 11:15:28 +0000
Message-ID: <DS4PPF7551E655214DCC347F9701AA76387E5D12@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
In-Reply-To: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|DS6PR11MB425752:EE_
x-ms-office365-filtering-correlation-id: 6c65fbcc-f686-4f94-afa7-08def4753015
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|11063799006|56012099006|10067099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 6472rxSnmiV/4i3I0mmaAyTD4GV8vY5Mrd3K0/qJENYqpqOvrTg5KkjphKjB+VdL6Sy2dgzsZs/1eIfVzLCHhAlA5qa9Ktupxd2StCjXz/ttqnQeqO48utgao4sPMRIY7UMuOM0uFIcpGkxY6RhW/GH1HWtHOR3lePmfUzuo2mjVizP4AusP+svI+F1AganxAOXQogKJ5EGybk4bui6yD2Y5gCBCyZJBPturATz0TedinKgjAVS4OhfgPDtmo7ewt0B2NRkQE1TOdfrAuNZfsyqTEAiPkJgYxmb34d8dpwGVsNt/ni221uJTlTnDE4eCfRqt4JlFoQ1y+FxBj4fA17fr241QxH155xbGn6ZrkWDS8Lyovvo0CgECG5Esd0CgEQT86yKNM9Ur2J7MwYNlh9DdNJWC1Nk6/Wa2BMekwBH0G0MDSLE2iOWf4DDWkOV14rPs7IJEFBoxxUrUA0O3i7xK04FiQfeXkBJiXU0jBZaHmIz/HBuVVhfjZ+pj5xYC3K/X7rfjJQ0nRegP33DnCCRpGlzCIvTDv349FhLB5sSrRhDQx0vHu7kr+/jYMtcKUxvoqi6VPqNiwnJKTagpFAVi+EIkjaHHFHms62I/U+U5Lo7ku/g+DunNb6P7kz+h66f8qiJzJZXMbY44sSdB13IZeJcGD0i/YkoPekZSPiixHwVk97WFR5dk6pcF3RCwaKyMMsa0GIVL3MnLvMEIWulLUKNovDRZHDoYFb+NVxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7551E6552.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(11063799006)(56012099006)(10067099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ct8cOSBdt0pjU/WF3Lu/HjIryES9mIKkSNJw5+pZGyJ/f5A5DuSMMKsNQvlO?=
 =?us-ascii?Q?rhtzuae5cL31+nVOxvVrS+HQElo1CFHX5Rb81P2rV85VuGDFS2e/h+/eeWsX?=
 =?us-ascii?Q?UEVJTjeR3iH/WjzzrIHRZz8/7Dmv+Y+5zJ5NSAeAblIcmMaZ9D1t5T7qZ12k?=
 =?us-ascii?Q?OYddcetQwt6mdzCUwjhRYhoMWbEGUwAVMbMdB4KKLlapd0n4SDYN5xRcPH61?=
 =?us-ascii?Q?ddkwZYIJk3faBQw17DZCBRQk2ieG3jxdQgjOt6Fz0AxsukWf+YRtdOySGZBs?=
 =?us-ascii?Q?f8RRatzAg7Mcp+CwXfJjGx9UQ+fgBNXl/nrz7l+RT/KhzkWHmEe7AZ0RE1R/?=
 =?us-ascii?Q?B+iJTVg5P231x2byMjeyZg7oCcw6oenDANBFOILiKlfXV54KLbaOQN8fdNAu?=
 =?us-ascii?Q?aT1QK3BWpZD9TTmOp2o3szndZy4xh4jzoLARNAvwCuBvN4PhJ21/bcPYMQH/?=
 =?us-ascii?Q?tHLOTF/X3p92tNQZQMly/91l+TT9b1IaizlvO9t84LXSDYfhGF84ZSJp5UBt?=
 =?us-ascii?Q?riYHZMqvbS4/UYt7Uptjpx1pZ/BH7a8dRcPoO0Z+fezK9BaKvplZ5/9gsWFF?=
 =?us-ascii?Q?YCkfcIObHHWrBG4OUa+P10fFIj6EWwSm/lRJGeqVHPBJWGL5XU19MGafFpOn?=
 =?us-ascii?Q?D0hsvKBOPFY56nmnu4Bp5n/D8o0uYmSRAYYc5Ct4tA5+v1sxHwhltm4/afXk?=
 =?us-ascii?Q?IBYL8fDuozrmWGDU6ukZ+qJCXwT6nGSiUNxN1ZygYtkpW1Dc4jMUyqWCcWs0?=
 =?us-ascii?Q?DVx/3J614WsomR34zKshlGZDLCymwIf8KE1Jq1w5oYu2052ncYyKs9l609qp?=
 =?us-ascii?Q?UD0Y89uxMKddMtd+F1L8oaewaOjVFl1u8okgqZrXXHbVYKWyYmbxDJ/R0e6C?=
 =?us-ascii?Q?FA4pxgT7+v9SBhg5J5p4lagPKt3zZrnRkCsyCrL5wedFGhdYpQnI6+GJsOLe?=
 =?us-ascii?Q?IcFjGc6Irg5a/ciQxLzcStjDcCdJOKXOvSRvhU635MU5H+FIpTElOV17b3GH?=
 =?us-ascii?Q?BBaAXw7ZWJuA1fP784KvKcjALfQ9sFsykZ2PmOeClURWU674kb6YjEk/vQTz?=
 =?us-ascii?Q?//NWbct2ce4kxXHAwzhWlPU3ux/taZyyDMuBluleSYCB/oZVvZHAfrPu3Cb3?=
 =?us-ascii?Q?EUW+JqiRn55u8nqtz7VnNqvluevk6TCrJcGx/reAX0Q1utEiZ9RpoGr8ZJfz?=
 =?us-ascii?Q?clChRyoeHklpWpBmaNXuwGSFcSDy+6rSaZQDB4EMnwPTphd1lumAKTboum3s?=
 =?us-ascii?Q?Wokz79IzjOt4Zkj46GqktrY7Ju1tcSiDcdVlBLnakiXBpllSru2gYLpWawDk?=
 =?us-ascii?Q?b2cp4v5l+jCz9IUQlIgNlviJ2yTdfUdQLCDSsgaocpgFVWLw3oO+xCU0QE21?=
 =?us-ascii?Q?Cx5HRqn631dhXyollhFQH2VCi7gsvhc86RXc3zm3SYDyjrW+6T5hcqf4Hhrc?=
 =?us-ascii?Q?H0wwvwUGWM8ac2EjdnIonC41Mzs8s5KTca113V5X94dND25rGP9p0EvBEdI0?=
 =?us-ascii?Q?Sr9gQxWPhXKmQ8MfnpZvBnftltvHyJOJFbEXNDCSHjMH01TEWhpXFpPWS1wt?=
 =?us-ascii?Q?SqnQMArdRzNd7Hjv/qUmjUuiMaNaJ5eViVI74rkrNAuHnDaG6T0D3QtPoMRa?=
 =?us-ascii?Q?y881Zdg9xdE1GdHoJP+R8S9RxMG5FhzoTkN2MNvs3GN0So0XNg8HS1dqcI0N?=
 =?us-ascii?Q?I3ManQYZydC6x9lPGTWXv1/eWB5OYuq3ddrU494F/vP1be6ejFI/sDJtLYoU?=
 =?us-ascii?Q?rOxhr3525Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h+gMOTYwyNfT8cHriXZgedEw+Dtc0LYShKVTyyq/df1+7YWKpH0M1/ExC15ieWEyuSanWhk81dYynnVdX+go8YFEevaS9ebc/kpbh9duHr9vorqT3LAgGBUEkBUiAiR1F7evrytCW5Ii5iYj57BUetreyqSc5ZzRey7xRwJN0CjVvrLv8rQN66KxpozqMBCbB1H4PZUbg0wxBD79/4ZlS7BF3SKsZNk2F45xGs6gDfK4uRxeVwq8kf6C8q/zUMvVrvLZ3y/QpMo4jTL/ns4ZDuOSeN8nS0ePEGy14nrNZlnOazOsylmMokVs7uKlqFiko683wt/++H/T/xzr4x7p7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c65fbcc-f686-4f94-afa7-08def4753015
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 11:15:28.7804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOrV4GYp7INPTbG5k4TSl9AT0Wnkk3Bp/13djGnYUjVRGfRQRVBK7wdNSZ2Swdugr+DPZEMk6sQMPS7gC52P0/A2RJp/Ag6y67pfJ9xs/1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB425752
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Jedrzej Jagielski
> Sent: Friday, August 7, 2026 12:04 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; kuba@kernel.org; Hadi Salim, Jamal
> <jhs@mojatatu.com>; jiri@resnulli.us; edumazet@google.com;
> Jagielski, Jedrzej <jedrzej.jagielski@intel.com>;
> stable@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] net/sched: cls_u32: feed
> u32_replace_hw_knode() with correct set of flags
>=20
> Fix u32_change() to pass proper variable to u32_replace_hw_knode().
>=20
> When trying to offload u32 cmd by adding skip_sw attributes it gets
> ignored and it cannot be correctly processed by HW and
> tc_cls_u32_offload struct which is then passed to driver lacks
> skip_sw var enabled.
>=20
> u32_replace_hw_knode is fed with the TCA_ACT_* flags (bits 16+)
> instead of TCA_CLS_* flags (bits 0-4) which actually stores the
> flags parsed by tc, so tc_skip_sw() always returns false. This leads
> to ignoring some of the attibutes which are meant to be configured
attibutes -> attributes=20


> on filter setup.
>=20
> None of the TCA_ACT_FLAGS_* is actually used within
> u32_replace_hw_knode(), so there is no point in passing them.
>=20
> Looks like commit 695176bfe5de ("net_sched: refactor TC action init
> API") shadowed the local flags variable which used to be set with
> nla_get_u32(tb[TCA_U32_FLAGS]) with the flags as the new function
> param while not replacing for none of the u32_replace_hw_knode()
> calls.
Better avoid double negation, for example: 'without updating either call to=
 u32_replace_hw_knode()'=20

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

>=20
> Fixes: 695176bfe5de ("net_sched: refactor TC action init API")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  net/sched/cls_u32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c index
> 8f30cc82181d..dc6e455e64ec 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -935,7 +935,7 @@ static int u32_change(struct net *net, struct
> sk_buff *in_skb,
>=20
>  		u32_bind_filter(tp, new, base, tb);
>=20
> -		err =3D u32_replace_hw_knode(tp, new, flags, extack);
> +		err =3D u32_replace_hw_knode(tp, new, userflags, extack);
>  		if (err) {
>  			u32_unbind_filter(tp, new, tb);
>=20
> @@ -1161,7 +1161,7 @@ static int u32_change(struct net *net, struct
> sk_buff *in_skb,
>  		struct tc_u_knode __rcu **ins;
>  		struct tc_u_knode *pins;
>=20
> -		err =3D u32_replace_hw_knode(tp, n, flags, extack);
> +		err =3D u32_replace_hw_knode(tp, n, userflags, extack);
>  		if (err)
>  			goto errunbind;
>=20
> --
> 2.31.1

