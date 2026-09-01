Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133163EFFC3;
	Tue,  1 Sep 2026 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788227383; cv=fail; b=ASrZly9lekqPfC1jjdQ/2rp9Zzta+sexJo7U7fpv0hahM3rtoDkknx7pPe4sPMFCB5etpYXIYVnl/fcEMkzG1uyGNdaEJWRh9hXOM3NFtzSk1I/AMDOAY44e4Qnv7q0qS1tTlb7bU4qWVzlREPMh84u5ORSvZYBe2wUsoIP+T3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788227383; c=relaxed/simple;
	bh=rOlE/Sjywtf7C4Z5oXDgjKKGGq1BYOsdyniqnhcSPV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L8qULo1VS8wTmvsHTzlPtVWhc/tM0sCag221ik7WI7xgm7/ByDa5c3fyONEWZQ0hfNPz/75msR+zTrqJ4/JylSHOugczpSxYg34s56VOYOY4u2P3FfZ2wd3dSPACdHxtjQZcCAVdZ/rzihMJrzuTGff/Hz7+iJd4mww9B/8WjGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1s+4SFO; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1s+4SFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788227344; x=1819763344;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rOlE/Sjywtf7C4Z5oXDgjKKGGq1BYOsdyniqnhcSPV8=;
  b=X1s+4SFOZoDzelXNY6IPyoJQ9rhj38xGtOCV3T4v8Vk7ZozLap5AEXQb
   lY7lpcqerD1Ru7B/vFeWIkKWByjxCaeTUwvq/LLNfeJApqyeE/80E0wmb
   PGWwK3fmPfUC+rlO7H5a8pt/hJkbghu/WIZ/ghy1eT4IOIhU1oCpHNmPE
   uijg14QBCkqfl3bzemGX4EVybPXP9d6LN3BiMwPz+/IfRQ2gUBwq7nY+J
   N+CIhaUp19nrOhQdIHvnnmpAu3CKp42otoDF3j9/kXD1+55TLV6yIdhBH
   uXykPJ9wo6tjLtOMneCU7RfATd9xQXP4DZUd3fj861J9daeNWdSDNy3YL
   w==;
X-CSE-ConnectionGUID: HLHNrQ25RDCcc5aX2rSXrQ==
X-CSE-MsgGUID: yrR1yb/pRyuFeDYchdCf6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88519993"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88519993"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 18:48:57 -0700
X-CSE-ConnectionGUID: SEZRt3KeSoWAhXn6D9dz5w==
X-CSE-MsgGUID: 0Da/8dNeTmapLc1teHykgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="268998979"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 18:48:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 18:48:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 18:48:55 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 18:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O91d1OFo0brg7cdDDQ8T4tn28E5HaFPa1kL0KnxcWoiootxu2dzgd+ysokt00Kzu8ACEYFUt2Rasxt24HokR7H3rteBiMmqjx1W4uibh6OaYb2uvuPYLbhMoi9P5251ErLDoVA43VdHhX25zLKAef9YcmnRdUc5tRJYrGsAUaZULwNBm0yxX/dzZBbvSn+wKz+8zzO9AS0GwrhhziaoLtTV3j9mep2KEkAdNvpWGRVCRE/GqSPcmcP2acXVgHNZNh3kG5mZ+zuNc1VZzXC7sCTzOAJ9FOoSpb4CLaEdDLWK6rmwx145PG1yBYkdsi+0khX9oDyIfPH5XpqNbA62TMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOlE/Sjywtf7C4Z5oXDgjKKGGq1BYOsdyniqnhcSPV8=;
 b=EZEx+Mqeikw+RPPo//g9BKJOjhZK4ENiiAVGKNbWZUtrg2Kpdy8ORTWqqTYtkhPd8S9pdgfEaotgTOXuiSaL59woTCndepT92l/Ee6sNatqP6T36XQ2M1podrnPoi4Xoigg210M2faJyH3ZF1vWhXTXVV5QwXrouim5ygsbtrZSUmL76TbsVoNBcINkYNmAfrTU/bH90qXdSSH2fcN5/7Cu5iVQhJl1dgCeajpAtsTdcJ/OWLGKPWYWnnMW1Ynp0Lg88xTGQz9TDzEzV1pm25UhMr2DSkmJXOCL2D8QyjfrZoYr+QEGqUoDytAnI5RgLnmaiJDf3VJIiPiTjbXZLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12)
 by DM3PPF291EF9BF1.namprd11.prod.outlook.com (2603:10b6:f:fc00::f15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 01:48:48 +0000
Received: from DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c]) by DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 01:48:47 +0000
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Vishal Badole <Vishal.Badole@amd.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "Liang, Dan"
	<dan.liang@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v4] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Topic: [PATCH v4] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Index: AQHdNX6toNA1xXH9KUybzygOg4Myo7a4+Ucw
Date: Tue, 1 Sep 2026 01:48:47 +0000
Message-ID: <DS0PR11MB80182E1B2DE32122C96B607192A82@DS0PR11MB8018.namprd11.prod.outlook.com>
References: <20260826171537.4167367-1-Vishal.Badole@amd.com>
In-Reply-To: <20260826171537.4167367-1-Vishal.Badole@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8018:EE_|DM3PPF291EF9BF1:EE_
x-ms-office365-filtering-correlation-id: 42fe4e5f-81d0-470a-85a8-08df07cb2a45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|11063799006|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: B4QEW6pE7NBZlx70nORBt9GeNmcvz4AEB20Ufpe8+/etl1Z1VASl9+AhXklZykObhjC8T2CJQnp3EYE2gYwCS3gPXcJ8c2aJejAuOEVMA5guVcRJpF1gZ79kR4FlCyCg2Ao9euv47EYVNav5O2F1gWYFGBEzYjm+naAtVx+1Nsuoaef/bKDJupQaVHxwYzg5mg9BLGiFXYLXH8By3/ZfTQBsJbBU2/eQA6wQxLWgwpTe06L0ZkKyNwiPTcitn0//N2QxqxV7o2xS43qrTb+6CEUuXeLEBCeLoMFED2Wgt0gRWgTAyPKP7wlJYlRu8ZUJ4jkR7z5OTFKbyo4vhwb3eg+XvhK4fUmQM0DmzlGQWROK/RVcGPLAyt0vFGPkTpAEOOvYKVPEXawhqlYzXMjGI0LRjrLXQHRXGsMa5w670MssZHk0wgMadykdVPu2DfF6/BmtN/BkIbNIWtGBbGi818yJMDwGH5AFW1ssicXr7FlP4raGwEkrq9IooxcqvzfEExH3Ka3ZJYYhS+jibcKPTi06OmMvhT6gpGqbcj9xuIY0bZVrubVTu4oMb4bTPQm/rT/KDrF5muuSIagmEvIzywlfW0vWrbMc94p9Ys9WdXo9gpwkYlsBSV/i3l6GLj3YK3xIBJPeQHFUSyIUHjgiTeQdgA8tf0JMdc83g02T12Jx5liSwbhY2XYvxFeU8DY+1PMNK2PydJylbMn30qOcXayBeifoqt7xG5TIVYvuubo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IBXUUoqO0ncZNKCnq49ZAJZSNbA8Qs8xLXGBnNnDllP/LVtKcur6CxQ0tiT3?=
 =?us-ascii?Q?V3RgBaFu5sOOule86rFGTshJSzGJVwwOXw4Vk2LJxDQ+r864ng342hie+u6x?=
 =?us-ascii?Q?UVKmU8/u4CGq0m9hhrE+DvaqafjhonXEnw6G21gH1VeD8/NUZVe976l7xot0?=
 =?us-ascii?Q?BdHlee0W3Iz5Q6pxyKqbZqEE8GAvawRF0cluM+11XHo8o7e/FRnSwDRnLouf?=
 =?us-ascii?Q?ku3JBm9yH+aD7p0gdvgMonEHJpy4ET0H2mXCulkvz+hdlB0VQt1dCzU3qj8a?=
 =?us-ascii?Q?CRZlOtFXWoP3RPCQwGo6YpGkIBbyb9M6XQ+JtOBnp2988lr2G7decZ0+S3ny?=
 =?us-ascii?Q?oestFe5tWkf8wti+Ut0SnmTobLXDRUtga6IRCz30niRlVJFO1UL6XDraW2V5?=
 =?us-ascii?Q?BhMQF23625X03xId/0AAGwapCfUyKbjTCEYpKe3pcOXxppNnH6/qVgDuGfRo?=
 =?us-ascii?Q?C56vtyiVwczY/KIMNueqU2k08G+dfu2o3f462315Q7LWXqd0nvp8EIN9sDJR?=
 =?us-ascii?Q?CfRem9KvQQFVKA14MFInPv4oLcqwngmHlquzg4Dzc1q+JNxel2BA+Apey4Mj?=
 =?us-ascii?Q?7V681jTj+Uh7NMeArsmQYwwTzePONXVahDMZSIaiGpyEobr582s4MuqE6c9Q?=
 =?us-ascii?Q?y6Nfm1Ju/ekZDZdCBDjF6eaMxIlY1ooG5x6Y5+Z/V6DC5LZG+n5aE295uQDI?=
 =?us-ascii?Q?XeCZYLkDsyMJ0rFS0UvxdmZbGkVtEGLaUvMIByyJjaDOqZBMVIw1go9hVfiz?=
 =?us-ascii?Q?4g0yhgWWcGFLgm4MNrLbWAX89iAgvNGBcep7eTG3kQTGHF8ZJW4y3IGwhxO3?=
 =?us-ascii?Q?e/xVdZIMJTpexL9X3ib70QBr5Scy7NTSjQjNTJS1c1J7XIE1VoS+cs4rDaFM?=
 =?us-ascii?Q?JutPmaaOiKw9wdVJMOkk0LaVHctxM7UMNHeI9ONsezh/Gi0IlBjBdu2dev2W?=
 =?us-ascii?Q?PPbfv95gZDmcaW21cEMfyszCyW6bZqKYMhwLVflriSN2Qe6DeTXkgCdGDXn8?=
 =?us-ascii?Q?vdSwFXK23vSRfxo9Rk39/ItJbkjNzLOHHviCEoeIzOoJ7F64lRbAaxypWlI9?=
 =?us-ascii?Q?YxV9YOT3uZToz0KyElPCqE4RgAH3D+tMsc2kAx4gS7DAkWg7Asledtrl7aed?=
 =?us-ascii?Q?/k8lxOilzGZAb1VEaqJNAXxK1TR7Ii90gmZ+dfZFuv3Mpmh1RfEwZerSRNfj?=
 =?us-ascii?Q?KOs6nAWCJbFDC82QXl2/Wx6cQUtfd31rbRH6dSTwQHqL9lSMraJQ2mwMUaaW?=
 =?us-ascii?Q?KSM0Qk0VQ6xesKBNBtDpWil3jA3IEnfUzbBr2Eqj5/QKL3BSse8xniwdDsh0?=
 =?us-ascii?Q?ffOY9mRj6cIvG3crZr2I11hjVlWpd05ooAfU/B8okC1N80nKsIsVeey0IUeB?=
 =?us-ascii?Q?4DehzPfoJQ7NFfF21e9/wRhjrrvsSkPOy7QnCz4kiu1vGW83IvziU4BGWN9U?=
 =?us-ascii?Q?N7u7SHAZBKU62iUS60TEdwnY+AJzmZhQboRV2vxXAfrZj1REn9t1rFlmIFBy?=
 =?us-ascii?Q?t44vqLtkv4hkWP6CDwYt8g+XRm4yrJfZZJOIyM7G3g6MAvPUJnkxnSOhzol0?=
 =?us-ascii?Q?RQqkqV+FitKP2T5eLvZ+cYBmvyPDi0q/QjArldZ8M3F+NplY412D04fC2Hm1?=
 =?us-ascii?Q?R5Fz1cZnqMpYAbVQHHMU6/Pn2tJeKHM9BVXkK2qTVrcce8ddYO2IOse7JVIq?=
 =?us-ascii?Q?BpE1QwkyJ3P8WatEf3A4GMNhs24tw8ucp60F3J9CMgBLdJd4BBw62BNd9Anb?=
 =?us-ascii?Q?2T3q6YcVvA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U24GshsfdhWMLvUFn2/8UOgr6Ej/SU2Dwxfda330oQP5x2j+LQRQ9CaU0ZWTBzf/yTHApGnoxkaBHtswll7PXnc3qqohZlJ+YRBAkz+psA//vGfnF77GO9HGfJiiwq9gGBnygmNgg/6u8cXwH47JNMBsIZUkj5wYCWY5hrA7CfVqKEz6lUXDeYbGYfu3eEZpqdWi+mmhaPdo4KVXHSN6IUg2+bHbBzeKacbVYORaEbKXIUzVrpy4gFwLo+1mMZw5Tafj2IBdcri3dbvsy4fAvcwrk5+ftsp+GwVyftWzYEy8KxH2t63HPardB6sjEJ6LOiEpH7NeCQ8xuKRJAxmE6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42fe4e5f-81d0-470a-85a8-08df07cb2a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 01:48:47.8196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3MPbJabVAiMrqo/zyCre3pgZ3grLoQOkighypdEhzs63tTLN94rRj6h3oWM5GLeKkvisaz1lmdwFiWJef0tJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF291EF9BF1
X-OriginatorOrg: intel.com

> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> ---
> Changes in v4:
> - Drop the index-based unwind; reuse the mask-based cleanup path.

Reproduced under QEMU via offline-cluster + reset_controller: I/O from the
online CPUs stalls (QID-timeout/completion-polled). This patch fixes it.

Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
Tested-by: Wangyang Guo <wangyang.guo@intel.com>
