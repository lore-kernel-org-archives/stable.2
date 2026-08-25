Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D0370D4D
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787700461; cv=fail; b=Uespq6zqvFIkd3hk/bR/VlQQY7E36guUNNMXTMxJv8w798LfAZx9DCjzQ1SODtNw9dFuEkF1Sn5N5HZ+VzIoePntwnoSRwiE/tL8+kuJkm9XwJpW+o2hqw297KjwW2P2YFgvRwhxZi2bF1uH5tSKqL4vGZtMpi0hfwXrR9GHaFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787700461; c=relaxed/simple;
	bh=SNtXyhyiFRTcdWTPmN/NnYAeeN5FR6zrwOHWif+yV0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bfZ437dmT1E4YeUC5zY7sVZ8hGSD6+nUTXzN/Iv58W6+AhLJ0stOF+k/M96F7xBbFQBHL7mzdUSzKWx1vq5Q/L0ORVnLmevIYBUYGMC/HBGor/2sMeukjQeAnaxvLfTmQ205XQU9nZ2FCPH9FK5cEf9E91LdeFrNJ9jpnnoUX4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KirBGdko; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KirBGdko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787700459; x=1819236459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SNtXyhyiFRTcdWTPmN/NnYAeeN5FR6zrwOHWif+yV0A=;
  b=KirBGdkoigPG1rwyerE+2/7gKiXhrJwpb6lMXbUgyWxluESmzx0cfLo4
   cSZ4QQy3Agq9anycLelTIAGrl8Mc58fsUfMQ3OSPRhgpln39ltlwQQ98C
   wgeh1gc7+stZAefna+nPZOEcvZraPau08wL2uhuuDCy2+1snSJ+KydFEb
   hUQ97dsOP+0TPCx1zsJtuNzwVpnF1yQHvfX7ATRiL2fA6eWxI6OSuwlUw
   UxTBoJEoEE6ZDvIJEyjWVfyz+xnuJpv4zlo/xidKecWedPJfe2BXHRHmd
   wlqimaCUYXoDQrHAdhaGWfG2lUN8AyjuErUloHvS+kLp/D2qgA+HCp/w9
   Q==;
X-CSE-ConnectionGUID: xMJqcnZ7SGSsfPo1j51CCA==
X-CSE-MsgGUID: ntt437jDRMKpa1KfCstNFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87946681"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="87946681"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 16:27:38 -0700
X-CSE-ConnectionGUID: t4ILv8U4TgyDx1QSEL8cLA==
X-CSE-MsgGUID: Qci4pg/QRjW2ZgFSXAsrdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="266110398"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 16:27:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 16:27:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 16:27:38 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 16:27:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El+aclotJWZVpru1bwzHonpICfwsrKuqa9uOWaIP/bI5xgzL1tw1DSW5kTrfYbCR2aZGMSOvqQ4b+apj1zKvBDkSE1Yt7eKHFQawH/UrCrkVyDIF9d70gskzE9CY2BARrgi18MCPljmDVkelNY0dZ1ywixPieTo8NiOL0W8LnsByKztO78lAbN8UMv9iFQILc2sf8V9TQFOu4bkOuBwjgx4GlneDWDYUTV2UADDSAZG8rbXGJDkCAgl4/J79nA31dOhGPgXrvpmPR5O7l/h7aWl27rPNVqBwa7tBzjg+P0+xT5heM2AoNR6p8pIIEv9poa/k/QnA9nSRrFbzzqlSSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNtXyhyiFRTcdWTPmN/NnYAeeN5FR6zrwOHWif+yV0A=;
 b=K2wFgSN50uLgTZb8FTu/iuRApBBtFzlXAU4rLDbV2VJtdDmu3RwG3SDGNCUtWZZv5CcHxFptJyC+QD34b1hcnrHfdzULzML+SEk7N4/NDZJOCD7/SE49DFJClLLXQ3GWLVOpfDYq2C9i7axXwWERVJYnc9qD0fF7AxTO/+k4oCZQbwHT1xGXzaMpXatuFslFKo+x7g6a2Q7BMs+MwZ89XvIFttQWODXag7XyG0Z3WPxxeRYrre/cqITleyxKX/jwAqTQNEbWJV5rRKI0o3i2uFFyvqeLaTZxnSIo16c2WjVbvRC5WfIKu/fHFwNkYS43Sbx1pUy7DxRfL0kSXm1Zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 23:27:36 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 23:27:36 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "Mun, Gwan-gyeong"
	<gwan-gyeong.mun@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>,
	=?iso-8859-1?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: RE: [PATCH 6.18.y 3/3] drm/xe/guc_ads: use uncached mapping for UM
 queue BO
Thread-Topic: [PATCH 6.18.y 3/3] drm/xe/guc_ads: use uncached mapping for UM
 queue BO
Thread-Index: AQHdNEPNHrqMrvw0lUCE3w7iNje1vraubvoAgAD69VA=
Date: Tue, 25 Aug 2026 23:27:35 +0000
Message-ID: <PH8PR11MB8040D345403799ABE30D65EAF4AF2@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <2026082036-afterglow-tapered-84a0@gregkh>
 <20260825034224.642641-1-jia.yao@intel.com>
 <20260825034224.642641-3-jia.yao@intel.com>
 <2026082551-promotion-liberty-83d3@gregkh>
In-Reply-To: <2026082551-promotion-liberty-83d3@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|SA1PR11MB6807:EE_
x-ms-office365-filtering-correlation-id: cff30ff6-1b71-4d87-8082-08df0300722a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|42112799006|23010399003|376014|1800799024|366016|38070700021|10067099003|4143699003|11063799006|5023799004|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 9xH/ZWH6iTGLAuHAhzGmwpU3+2CTvubh5bvbC3Fo63d8z0eCyDaqe3T9eE4yG42fkEaOL9bp3V+Gu0/9f4sDZ/a8zzrKDJHLbvrxEO2oSyBOSychy3VouBGOK1h7lBxeyc98OLj+7DUQKfVdHdDuGcDGaa7IltOQZcoSr3+vNpuVsm+1/+u6ktiY/k58kvTij5pgNFmCUXuLaDuWTpjhzW6/MmPdJ4FWyWdDw897ZI2OWYLMIEQKzx2PAFYbbizxx/7RXSxJeWSEjCF9G2toKtPaM4wlep8ZtpW67xpxKVW+jPuhDtKMpfjjLl7cHnd5WLnxOQY0fD1drRU9ZSpMG3qqxuP28Au+VdyF66JPhnF/nPXuVsdXnpaVbmfoYGvreFFJBbxGcR1OSNRj5o96hMze8lrT2mV+zUMpdYewn9CAqgeiN4b4h77CGWNjnCCvwWnGpNdMr14r77Y67vsnSs+U6xaSSJO33TaVmET1sbCn5mnqX3mMZN8RMgfW1q61KhpUPl5nP3hykvfqGxs+vhWPtgMkC8U89yPZuaFejPnxdK4BW5wVk4Y38hT6Ri1CPJh/Y2jDoCW8HYdpuj5JdjBXjt5mirNg4X+U400q6hRcjdCMLCrrJAAFZSrQfSekkEkWyj3AQ5qu/gp4aRSk+j6qMR+qA6xV4MDK3YH9N9dt4dqp+vlrFW4YihfzJRLQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(23010399003)(376014)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?25aYuyLiYLcC+IeZnyWCnx92FeSP+p3zASbnSpgtd9ollKvpVjnqE1Lx2n?=
 =?iso-8859-1?Q?oxXf2aTd/wV0rpjKkSafzotgGaE7bJvcxyaWDCpInilYMKi0FDRkEydSwR?=
 =?iso-8859-1?Q?PdzPJMU70/PL/sU1KGxV23m2rfOVRmtwaMWWKRB2EDWQG92glSaYhNf0P2?=
 =?iso-8859-1?Q?Jg0rZveCglI/eWR910N4JkjBH7JaZGFiA9LphGiQwHfVPmg83imOjrB1PG?=
 =?iso-8859-1?Q?geaQxYrmILHXYlmeUIrEH1Og91nUhhSPXLFHMVp1Q6cFzOOkS2o9lCq2QJ?=
 =?iso-8859-1?Q?FAfJ9/7WQMTWM2NdRDAQtqunGbR22uUaXGSbmCA5wb5Jd0hFl3IqjJhlEV?=
 =?iso-8859-1?Q?UOTAsKlFnh1lVSQMBwoKS4dZ09FJGEKhs1mOF2rk39fPlOajccO6mUmD3A?=
 =?iso-8859-1?Q?54sjuz/vKUWAjB/SYPlGDCefEVNeu7EZrxIAiYkScoY6DipuTGjnG/PDB9?=
 =?iso-8859-1?Q?hzOPa6PJ3MeBA/ZgceGG1GeZCld7m8GXjvxX3o1cfyjH9QxaSn+WO33kWV?=
 =?iso-8859-1?Q?f0agslTVE5S5kUNuLFN+XbLxyKq0WT7+BNzItwl9j8h9tqAfqMM8WovaXK?=
 =?iso-8859-1?Q?niURADXh3uCIk2pDexklxEHM7iDo9fa3/v5LbbzF2WOnE/pNk1vUhKjjFA?=
 =?iso-8859-1?Q?ioWbzoGyQYaJP7GVftN79/00naF/6gq5TwZAowRgc4SZquY0y+4pyM+JZR?=
 =?iso-8859-1?Q?d3RELhvLSi6DKkHCtjaE1O/TfJTrbj+7NHUUMK+fM/kNFlvPHrLFYhAPv4?=
 =?iso-8859-1?Q?FVxm/T/G3AKZolhib4QLdbiV+YpK10+9zJoFcW49BZR8aJRihiQKogv/kf?=
 =?iso-8859-1?Q?TCRf6M5R8L5Oat1LZOTosH7vflE58Dt1UvlRpYrktnfCZTt+wF3uDUWC+7?=
 =?iso-8859-1?Q?JpG4xvsbZFm4Fs+9L1Es+6nEUQHUE3nZu6SMapehQa1VDLfU/t3eNlMnGi?=
 =?iso-8859-1?Q?YHaHrjtRu9jjqrpio/mo73q3bzXtSvj14O9C16MRRFWJCsvGSfZnpd6muy?=
 =?iso-8859-1?Q?jJdeTMXBY9cNHta0zkT/X/vIJ2dexcJpf8BEztOItj2Sla66GcLyMc2Fft?=
 =?iso-8859-1?Q?5AKHksrsVSqTx6dd9cVdj01uGv3TQ4P7sUTJaWeKinF9ypHtBxEGEGyWla?=
 =?iso-8859-1?Q?SYvx+WTlkee4Agi6mCfBPlwWzoZfs1t4U8BpWclHWcQCtlScD14oFb48Ce?=
 =?iso-8859-1?Q?jPc/Y8J8W+nCmWuf5opcdGtlA1uQf7ROOICsTjCbFc4BzkMegRIY6amn5r?=
 =?iso-8859-1?Q?ihgm2BEP4PUAcmnt/C1kSxwyV8cRlFjj9diSp+XkI4WVrKxchHgIiuw1u3?=
 =?iso-8859-1?Q?fGoC4bBbARTljo24L8M3jH0mphKEX5TJzDVOlwj9gANyNcZnvEFay66IgO?=
 =?iso-8859-1?Q?bWqgcTQO0hYH3qqtE5u59FWYl3fWQZ1/K4jfjRDkjrs3AezLkz6xfym3Dg?=
 =?iso-8859-1?Q?54J1hGdw79cuy71FHWn1Mr2m/Z7T8YM6luqy3E0THjaLQCwJbmDTodJ6HE?=
 =?iso-8859-1?Q?pJIPOPS6hxWOxEr7B5QDLfRtw2J2EAhri2pXa2t8TDHUQfsAI1wAgDYX63?=
 =?iso-8859-1?Q?VQ4Ek74Y8PuSitd3dvdu/8c6CBtBW1mWQHhpZV+dmE/D5tw09JpDZYn0AE?=
 =?iso-8859-1?Q?P2Q2VT+cgqfKE9BDDY0PH5XH8FV9dPH+xHNE81WXreNAwG27lR4SjtUpPl?=
 =?iso-8859-1?Q?dbqgF7B4v7vN4CBj3jcd/fcPs8UUM7R/M9OZxazyO8dIRwkReoIoXsUFVK?=
 =?iso-8859-1?Q?z5uj/YuqLx0zEz5b0ysvOe9yhpTlh9Pt+bSH7t3VEhjbxp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 04ceMVoZKvPgr7Ij4ugJE4B6Yp1Esfa/offbr6bUJqF6H9/38IXVDBPDTqmQ/FU+GvILRy7uFbO+puaW2X3ULsWk3Jxj28NLoxWedULYrUCgEUmK6EzPsIG81Wa0S9yxNe/kh5sAANiJ9+tjPhxGFFyOAKGd3kxy35AschqEHWk/WmJz7g8O0Mafo/DVjxaanFwZWrtAOfkwzf/BsbwYl8PqpsYR5tWAvbs39EhpnPD1zO57w41PBwMVnhb4cifVxX3U9CVO4gTdQak+Rsc9uzyx7kmOc4PwbiXPSE6H6ekw3sUBjxX2hKz6MYA4qIMMnJBSVqLeyRiSt6WshBTVew==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff30ff6-1b71-4d87-8082-08df0300722a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 23:27:35.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CbCfzaf8q1srwV+XLOZfAtd2YtbXYCiD2jFm1nhmM7NMCM1ynQJXVJHDzQU1EV0XIe+Dd9A7kIbLFIinnN7kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
X-OriginatorOrg: intel.com

Sorry for that, will fix it and send another one.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, August 25, 2026 1:29 AM
> To: Yao, Jia <jia.yao@intel.com>
> Cc: stable@vger.kernel.org; Mun, Gwan-gyeong <gwan-
> gyeong.mun@intel.com>; Auld, Matthew <matthew.auld@intel.com>;
> Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> Subject: Re: [PATCH 6.18.y 3/3] drm/xe/guc_ads: use uncached mapping for
> UM queue BO
>=20
> On Tue, Aug 25, 2026 at 03:42:24AM +0000, Jia Yao wrote:
> > On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
> > if GuC reads the queue via GGTT (WB), stale data may be observed when
> > the cacheline has been polluted by another agent.
> >
> > To match the GAM's UC writes, configure the GuC mapping as UC as well.
> >
> > Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
> > Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: <stable@vger.kernel.org> # v6.12+
> > Signed-off-by: Jia Yao <jia.yao@intel.com> Reviewed by: Matthew Auld
> > <matthew.auld@intel.com>
> > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > Link:
> > https://patch.msgid.link/20260804165057.129529-4-jia.yao@intel.com
> > (cherry picked from commit
> 9daa302a82590eeee7bdc68023ddad302df4b88c)
>=20
> Same here, invalid git commit id.
>=20
> You all really screw yourself with the bizarre "cherry-pick backwards in =
time"
> model :(
>=20
> Please reconsider it as it seems to cause nothing but trouble.
>=20
> greg k-h
