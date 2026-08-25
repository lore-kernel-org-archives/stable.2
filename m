Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D03BAD88;
	Tue, 25 Aug 2026 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787640289; cv=fail; b=ewG/i8qQe5Wyw1TNMq/voENSiRpR4V4LrXEbzJnQgW2MJk3AxiCemfEpHGIT0Ei33YU4wvGIvZkd6Vk/SGeBfkY+SFDqK0n29Ft5WmUYdPP6QlKF4CLWBFtuHobukhufLBdnZOTN7qeN8BvuRKDH+idFdoRr9+E641mSgQ4EmEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787640289; c=relaxed/simple;
	bh=0vgN9IqnlOwIfNpfoNAF9A3gddBNoum4SHaajB5VC3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XPeXQi09qecWtHDyt3J9ScsfH9UamkkFsfFef8fYRz8wKPPkJfB2aUkWhGyhKSRgoHHdIj8JGnLH+wngvlmX2DC7GdBocjMNIonaT3I5NpQeH9vsPD/rgw8pX23mc4o74nCATI9vULtGENmcurjcOmI0ZzB37Nz2w/W4WJijLyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsGo7rMS; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsGo7rMS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787640287; x=1819176287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0vgN9IqnlOwIfNpfoNAF9A3gddBNoum4SHaajB5VC3o=;
  b=SsGo7rMSSt1xa9Nj1zY5RatCHRCpbthJRGicJ/bz05seXAWxwrfHQZ92
   MicoRKsLA7LdUS4fC0F04bqfKGE84ao6UTT7EsaLPrxaNJEEHPUVPugax
   wq3XKNhqOM9Xc5/DLL66UVdAtT1okcxxFIud5ko/2cRXoVBNcz+aZty2e
   bqqQEEvWF9It6qUQB0xr6fjHK1Fcm+vZ2mzN34Pyl5rgjKeFrbS921/nt
   GuKkNbFlxVhPtCm52g7OJ32+gCQAAxr5oN0zBqnFYjW1itXCsmeNKGz0L
   MQo//VVBQDH6pNYBsgtMnvFqk3HrfvOci0fbQ557tOJQYU9OWVHVj9Bur
   Q==;
X-CSE-ConnectionGUID: fRPHfxFJTkSzzxWrOvub1Q==
X-CSE-MsgGUID: hWaWEBpYTXu2IShbF3ItJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88114582"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88114582"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 23:44:46 -0700
X-CSE-ConnectionGUID: Zin9cvx8Tl221v2accDrOw==
X-CSE-MsgGUID: QwkqF2PQSWu+1Z4djZsyeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="263918582"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 23:44:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 23:44:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 23:44:43 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 23:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpTPFc7eJQYJe06t3sTVnGZ7mUwvs/EKtIeQ++VRoB9y9R+/qssjZaojlQ02lbREc2cKWa7n1WGXnPZh6sgv/JDflJcx+dpVpEzI4fRXPelWzp1eS6JEPgUgZDFZGAjTJlcDeVjq/QKctD2/NDJ6LvtoWjQAxSgjrdc1n9G3FRIqxTdA0gfRiaOk4nj0H6titY3z0Pb4f7WCQj4/X83JQTZnk3usrWpB2XWQZhpRRC89gDn9ZIlx8btMTGoFKG69XJAHl7VZjYrcr9tABUEC3TuLcBJtNazP6oMj0wquVwKbNakjFQYljvxcHfzaQ/tuJd1dsvjYu0Nxi3fgRyMtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYYY1t2CGzYtoeHUT6iCsgwrdRLXzZ5/V9pQaMidouY=;
 b=mulv5pDdQ8rJRNx3zm+UIH5Khw6oq0DBhTBDA3wnjWf5QqCrN8h32YO5kvCBN/dSD3d6voskQPC18ZhodAApj9/HCMk2AdO2xQCpB2lQ8gh+bIBAxHtugVq2e/htioLm1kBJ9Eo1WdkDU3JqN6yOeVLodPhlQ8ZMZpTNyyG30glPmQglSHBKj2qr1lShMUx+440WdxYAW3/PiAsraXqJuLOMFUcsssQz1mXWGA6/1NaKAud6PGPDaxxaBzU7JZF4Z9WZQPc8E2zGcGsDxASUCp3SL80dIkZB9ufvzoz5VizoiKSJ+XIOYKU69sS9f3sDje1FTimNB/iYhFYgL1teqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8018.namprd11.prod.outlook.com (2603:10b6:8:116::12)
 by IA1PR11MB7920.namprd11.prod.outlook.com (2603:10b6:208:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 06:44:36 +0000
Received: from DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c]) by DS0PR11MB8018.namprd11.prod.outlook.com
 ([fe80::47ca:c2e1:9362:422c%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 06:44:36 +0000
From: "Guo, Wangyang" <wangyang.guo@intel.com>
To: Vishal Badole <Vishal.Badole@amd.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>, "Liang, Dan"
	<dan.liang@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Topic: [PATCH v3] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Thread-Index: AQHdMZ3tdV+npnPqB0WWZCwr5BkDJbauVWPA
Date: Tue, 25 Aug 2026 06:44:36 +0000
Message-ID: <DS0PR11MB80186E471C1553ADAB16FEA592AF2@DS0PR11MB8018.namprd11.prod.outlook.com>
References: <20260821184923.2462575-1-Vishal.Badole@amd.com>
In-Reply-To: <20260821184923.2462575-1-Vishal.Badole@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8018:EE_|IA1PR11MB7920:EE_
x-ms-office365-filtering-correlation-id: 94bc1680-5888-49a3-11d2-08df02745451
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: Z1iWtyN9ZhBxhTIO2uOj9THBR4Fp7BqieyqCfzodwbGQXkk5DahGMGAyLZmTKmyVCBrJOr+dwITdRDP34wiKjMkYxmpF4Em8zqcj5rwIWWOfvoYK2Re5ZQzxSZl5J85qadDEGS4Pw++gZUZ8TT6CI4a2uxlkDOReH17e/qQMIp6uWxdjH+MSIRN9B3JCmfGbc9X1bz3loqY/cHugeVNYXDj64fSEvyAqOfyTyOQfWPft8qpYtPswN9x00gcTS4IdTEFqLF1AUXPvzEVtC5SByjLZxAR0lWufyTe6GLE3DpkffjPAuKdW1qlTTSPoRSxKtvZOnQrtF8IyBVM6VLGWWYKw1IG2ALF+nO+EU93hOGPULYZc+CQYuZmCBLB0AJLtqyv98sVZZ8mzWPgJmPcsXdBAZKBFzW3ST8eyMg/NEFo7PGrCVPrbbC1SySLujBjWNTiaf+be+Nri3NiQH2NyE3n6hkHQUzmgWjgt2HsACDzKRm1jvI0CrR+2ibx+n9xJDpNMu3SOCqT0+ALRRKjQt0AbRZTTvvDJrzv33E5oZ8rrYESIfXmT4o90sV9LmBIaGFJ4Fp/wTMQsDGCsfl3r5EVQI9VrR26tZrZseTcUI2k8dn4WPE2ObKmSdDM2aERsNGe7Ot46le6yOFu/vs8ZIl1ztSCQfL7JeCKF6XNwT/lCHG9oWLzOG9NInKyIoe3cNab113hXg2I+qKtQgxrgBPK2Q1bf2e9egB7SazoM7ls=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8018.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mP9Gslvl8sQzLWjIatdYB5M7MTgStZjBT/dYgmWSTecXmwRpw/IPyUZlswqI?=
 =?us-ascii?Q?Mtw2O5pKmt8fQdigUHiPL5BRVRI19h1cdOzS/rtJKw0s7gCWV+jF/es+ygR8?=
 =?us-ascii?Q?NwOTFv0M2vnTTKdTkJJIwe2OUIbF9M7DN1G26fa+9fXHoy/gdl2nB1Ic3ewm?=
 =?us-ascii?Q?mi9HWbY6yVnUGcM7K9dPAU5tLe1KKXEKknHt4ytDVtUJVzZX/G8q1zZoJsOF?=
 =?us-ascii?Q?qGF2SS2LriVUrVcQ87cyoPNN1WsVepOxnkRuq9iUineavRZZmpwfVfLOLvL5?=
 =?us-ascii?Q?NqksnroXbM1XEBj/WB7E4Zlb+cqCYHK9zd4LgpV2BYp0Ay2r0LLJWwaEIZl0?=
 =?us-ascii?Q?LvCpMgeFErnOL+tFmnBncGYhImn7GDcKMqoL+ancq7zDhibk8K5mRHvzRL78?=
 =?us-ascii?Q?UbKKIa/Pfcx5rLMtiukhtXCqgvHftoJcg8B1g8w/1hLNCkesP514IJP/TqGU?=
 =?us-ascii?Q?f7lhXGSS1bn6z0e3sJJEC4i1xteCcbwu8B+UGo/adYt6UP8ydwgDsJjk455W?=
 =?us-ascii?Q?IEcSY50g8QCoZV1R01iy2f83ynmoLqwBOF+qnc6VKMFJFPz3EoKbDkXjcoyL?=
 =?us-ascii?Q?0dw16xwhcZrpJ6+vHitG7fU0qr5WPFUSXmDdAzSUpkPIMH2uykep1NGo7OdZ?=
 =?us-ascii?Q?4+jCO8hTMM3RVe1PkX74MbXWjM21dKhiHtUCTHjE7R0y/2iMwVIxUWmnbZMM?=
 =?us-ascii?Q?7XpOZU+2n5Vz6f9U7AW8oDNt7QqrBHt9/0mJFYvb+ElH2KOd1ne6kxZoXpLi?=
 =?us-ascii?Q?W/EchXSr5DlRdcxgTQqrAeXBvQs6+xJzs63tazrviNDKm5yYhhSWsbbSqTf3?=
 =?us-ascii?Q?LZYcqGZbPSf1NfNNX1/97kR+0+cnal12LxTmTOhnMBkcG6Txk3td4Foqg+bH?=
 =?us-ascii?Q?Tu7kCr1318d63Mf5Okb1l6Cj0tko4EXNba3Ocjj+K3G3vBQDBHg2E70Py1RN?=
 =?us-ascii?Q?/8a9S7KPoxylZcyuhKJc3vmm9cqZhqzdBFozzG324DdyLUBmRtmDv3uwdtS4?=
 =?us-ascii?Q?ioyvm5jzIhd1YbitcTCQlMmJkBPHKIjEoo9l2N00Hf8DhYPtolVqLplBe/0S?=
 =?us-ascii?Q?CK1GTj2MYAWoR4ihwMjmYMk36cfNU5DwCvJxY8mKc08K/9fOBtqFdThmjq29?=
 =?us-ascii?Q?g0cl41/l/HnBjQS44eLoItl8+HJDJ3oCGok+DSjrSQGftSJFbPZJPgEhqQZe?=
 =?us-ascii?Q?mnE6Oa8bPKrAQw4fmnUXSkO83fwWf4yu6R3EYex0AtpXdqVOow61dGs7VJZv?=
 =?us-ascii?Q?BjCWmafwZ++OsRWYq+j+B78KQ1mVArOW94up6LxRhTxzRUNGoeCBGfPys6/P?=
 =?us-ascii?Q?DW4LRi8N0zwEpy7auFV9hw6W6q1ALtkzbXDuWWLPvCChYTBrn3LnAXx+Rpiz?=
 =?us-ascii?Q?mwWsYmrCfG3Y01LKkyX/o71RRdZ3wvbU6G4etxYxjQREVMGpq/x55zFlbKPO?=
 =?us-ascii?Q?Mq4ivgvlGWUm1W6/oVOzizoFr40sSbwKaB5i9/fP9FsalfOixTiyKD6tGpcU?=
 =?us-ascii?Q?G3m7zXAS1KMhA6UvdKi7smQZz1KvkPRk5isokYul4RlEbF0/ea3/l8VQWKu9?=
 =?us-ascii?Q?rDQLQsXzCQE8AgWObxzVdcZD5yRP3zy+cg3xDc00Dan1W0F1zhYglpBDGsrV?=
 =?us-ascii?Q?ZrGcqsvrGw0K/g2/WZZZ9Mcagl9xxUZN1li+2AIhvR09Cck7NHISSq51Mtz0?=
 =?us-ascii?Q?6q5t4LSw3YNuKTVPgsv0lFOS3B7X+0yDb6eRur3/94LNq4WZhrnwWkOTh+Mg?=
 =?us-ascii?Q?U/XLSUy+2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dm5QbwuFmMyTjFQUeLUfhWoRCirVEq9IQ9MS3WHlvBUS5rNsiuJAgh7Ya9r0Vxy2S22/e3KEXKaHlIxbyNbEbHH6QIcww65AAABVc6n07suecs5ieZFHI22HAVs7Gp7Di9vlDFVQhy2IO5KOUCpZqrXyC9EhZvo/miGoaaTc+5JQhHu05E+449QIVZWex7u+3j0Kha8tQJMMd2T0Hg7Dz0fTbwoFnMO/awfvvZG0of/aFjXZHVRTPNSbke/mD0YGNYkmghWIakMk4TFG7UqKY46IFGuQYJM3z+FfC6Gu1TxLP40pn1lO5ObjpPZ/ll5cV2nimbVbgKLd1Plz65EXTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8018.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bc1680-5888-49a3-11d2-08df02745451
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 06:44:36.3636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qk6JswNZM7TK6BZB+QjIxliP51oAw0LROhgFTDwddOqMH+BX0QoW0ICPegL4Kfa0wAFeHf43F0cwSXbzfYcH6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7920
X-OriginatorOrg: intel.com

+	for_each_possible_cpu(cpu) {
+		if (!zalloc_cpumask_var(&snapshot[cpu], GFP_KERNEL)) {
+			while (cpu--)
for_each_possible_cpu(cpu) may have holes, but "while (cpu--)" assume the e=
numeration is dense.
Although freeing NULL is not a bug, it worths a comment or check for such s=
ubtle thing.=20
+				free_cpumask_var(snapshot[cpu]);
+			kfree(snapshot);
+			goto out;
+		}
+	}
