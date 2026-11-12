Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794463094;
	b=PN+GEeh2MvamPAWuXdTOdGrv+r4vkfCR/7ShCZGcO0Wy7QVG00eqkT1k7Kmg1qwmEdVM
	 8OiSD6jeqmi6wEhSCHJBmIpQmO1X4jrQ5oKzn/blaEUhkPHOsNI1LnqefTQr419rLpjRo
	 vQ6y0KpD3c6XeC0XtgkScehE91XZgvs6BPJUD2rw8De9GAN+GRE40wUMeGfQxGhffWgSn
	 TwdVN7SqOBHL01HwPIv/PJizqDk+JDAIPPQ+Hm5LEi4PSP0ss6irv6i5p/81KrZnOoIaq
	 A5J2CUGuEGLCTOqyV6dRrcsv/ndNulnx4i5JKuXmIaHcMIKeqRFAt2Xu9baDA2pnLow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794463094;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=k8hnm/k/1RQU+EEybCN3aADnPnnc+mvcACPlNV09LFw=;
	b=2RFIl/ZQqUQrB7ggLZY1G4/EsD2d6rJA8H2oX1yEO/5swrNliCLpHEnFxk8+RiMv9Reb
	 OXHOEROdg5sycWI3CE3qKc43vUbVnLqGFRGrGpRvDkWOcBEdu575UrSD2CG1ytx71VtfH
	 TALC0fbhAvAMH83zKxHa8PmiWr37TnImNjEqCDVgJigaHvKGOL5Qyg5dZBqNulSa/swgR
	 8gAd0vH/iLjhAZhH42pF2CSAIL80fuBNcjfggnrgufh+H8j8hp2MHjB/xM09sz8av/jmT
	 VLNh2Ro6z7SmNRvPLnPQKtxBPc1sRIFC3TZGYwcDiyWpXFsZ9WTZV7gHcIVFVuXpdOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XM1G+4ah;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5D606A339;
	Thu, 12 Nov 2026 05:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22F5D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XM1G+4ah
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794463094; x=1825999094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k8hnm/k/1RQU+EEybCN3aADnPnnc+mvcACPlNV09LFw=;
  b=XM1G+4ahVMDmcVNU4giktMAJCgwnEipamKgMNHr/h8obWlfZLVfcL/Ac
   B51YJRuQ8qrbIb5gx+6FnewTEWC6Hgk376P6nqQPIe9kmxGc7lUgwGwkA
   yEcvNi6e/amShwg9TMRlYCFsZD6k0E9m8aBTrOCEHQiEyaA2jkOlmHjzP
   MEQ7CnPUOnE7SmkqIaiiKgcSrPTYvwtuijh0M9S6QIe9nsEoyJ1lgqZAl
   y8Hv9eK+193RE3D/1HsTTSpuCcEZYkWND9L7xeKacg64DVDoEt49uN8py
   T27HMQFN6XiuoQ5p07jgZZd/J4NrloiYote1juK6PUwFJQvQjnLyYnTjN
   A==;
X-CSE-ConnectionGUID: /cL99mYPTZuDqLbjScGktA==
X-CSE-MsgGUID: uapqFPBnTU6OFm4fIsD/9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3147083"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3147083"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 21:58:13 -0800
X-CSE-ConnectionGUID: Q5aU2I8eSNGBH0pZJu/dHw==
X-CSE-MsgGUID: m9NASm07RjaT5dcXGrp8EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8911197"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 21:58:13 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 21:58:11 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 21:58:11 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 21:58:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDhPRsglvmo+g/6ro91Mf3+juSSGSq5vuHR4wIAXKEXIKAwN/53xavIdil/EgF2tPnOPkIh01S6UiItVFSmvqQrZFNH0ttEvdJm+d3pAhTxdfCI0KlWzl6WnO4GrYtxOiWLt7ngAeFxUr8QF9PS8oO3bmFvjANFB469cGnB+hfQOSvROhNtKOm14rEZ9J4fCqPuiqV5WCnQOBNTuRf6brLbBWztO4HcWTz9lKE0pkThUXPn08FB0yZHWNd5mr4+nX8Y0AI0XxQ0gS5K3DSuNV8yC/crWANVmdXSJ1g+ONFLSLxLweq+Dl4bgfry3qVW0je/Y8zCQRdAbg5Zt4rswPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8hnm/k/1RQU+EEybCN3aADnPnnc+mvcACPlNV09LFw=;
 b=a+GBDcmAM/lJQIVWEqJAIlC5Ceu+utdIMsZl5KomswQfMOr7tPeVnMx7/RqdmiLFo1zKJxJG0WwGWhyzENBqzK5XOUngOiSoEAee81XTVwXrNgzyVCE+CuzFGdwedczPKQOcUQej1//HfpYqSANU/dxiS2SAp8e6ryU7h8t4W/Lf83uN9nB3kfGY7Pnf5i3hcPuDG0rzOKsof4ifdB4OjjeAiFHbwplymGIz7xBASD2/UR0ZOi/8mD9aR8leSWxc78lS12RfvOa/hi3pyNmgYKOZukxmws+lJDM55hhcPPffuFhbPQ2Fwh6n81gUgJAM6QIAQHl3vvY8EEwUGzbcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SA1PR11MB9616.namprd11.prod.outlook.com (2603:10b6:806:4c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 05:58:09 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 05:58:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Gomes, Vinicius"
	<vinicius.gomes@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] iommu/vt-d: Set FPD when tearing down a PASID entry
 with fault_ignore
Thread-Topic: [PATCH 1/2] iommu/vt-d: Set FPD when tearing down a PASID entry
 with fault_ignore
Thread-Index: AQHdbBy1WviHWnKL8k6VlSTBa55W37cgCjAAgAVXJQCABJvEgA==
Date: Thu, 12 Nov 2026 05:58:09 +0000
Message-ID: <CO1PR11MB48355713BC88BEA8794279E18C702@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261104051059.1345010-1-baolu.lu@linux.intel.com>
 <20261104051059.1345010-2-baolu.lu@linux.intel.com>
 <87o6c3uedj.fsf@intel.com>
 <7f86b03e-1c99-44ed-8d07-3502a21821fc@linux.intel.com>
In-Reply-To: <7f86b03e-1c99-44ed-8d07-3502a21821fc@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|SA1PR11MB9616:EE_
x-ms-office365-filtering-correlation-id: f30f725f-f706-4da8-b9ad-08df4081edc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|38070700021|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003|261009223027099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021135927099003;
x-microsoft-antispam-message-info: MaAyPesyhUW6sxuuOBFiUOyxti+KmNfociYg7H7IO4sz3NAic/h6KfyiyQELpdXrjnLysGH4cdfctKQfHPSzgr7MxFKe3IjuRYBvKP/QPaJ2q1Dgli/Z96npEWAxCsJ77dP6mDKGacacJoXXev/vQ4BYZkwVFbOcjwpT2P8bo/Aetkx/045kOVM2T0NoQsedNh4cjHnA/nctioSyUX4upFr/GgFhVBlEY3LQJbeFzkWSUCHTB/X+d+cZRRGAMtU+T7hA3gyjE9XxTqkzJqUcm6/gFLEHS/wzPwbHxfCw4KsrLvpX2Gy1l/f6PxQgRyY26q5IhXsCxHZPCsv9HbFDY7Adi5VmVLbhERrsKbfQLh8as9pT5+V0HTkpRv8Pbd/b0MVfeXxeZuzR/EwKHXjobiCBOs02KTFHnbM1EteNODN+DsJCrL6ckXHohInwkqL/Y1rDK0FWAgSuZZqzqnxNW+dyTkPvISuiPAs8OtWWqGPD6+IGIA4EPwOn/7KgbmE3gtdMr6CGrqutzzb+8pbhqSZzmKeVEbadUCYC9g+vUPuys0QiXWoVuveW5DQE/LKIo1E+jm2tcQ0xGMBxscwq3WG3YxJQEFOFt/rKgu5rrKfQ3lZPMD0n0SWZ51zmxDZfuok69Yk3VCrb0YroebwyQMJl7C6omv7utJTAJSBQCe6fT2j7cP/wDwfMCJ3gXC6wG3xKbXe5cjibRPjAefRgl4sVBk1YmAL1DFOCHSXEsQ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021135927099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkFFR2h5ME9WZ0Vxb0taSzR0cDBrU1VBQUpZaXM0YU1nV2hnaTRLbDErSGp2?=
 =?utf-8?B?REF6UVRKSS9CQitZWW9kQW1KMnNGZjlJOUg0U1FsQkN3ZWQyZWlvOFNXbFhq?=
 =?utf-8?B?TzBVRWZUMVd0VGVRK1RMZ0NERm9OR0hzbzhWcVBBdmdkRlVyRVJQU3l0Z3hk?=
 =?utf-8?B?dTBYdlN2bCtMM1c2eVJ1Q2NmTEJkdzFWbGJEb3FPTk1qZ1h5UTVqdTRIbGhK?=
 =?utf-8?B?ZGRkVitOLzl0dTNTMEI1Z2t5MnlLWGVTSjd6d2Flenl0MjVtUTN4dThucTVq?=
 =?utf-8?B?WWxOcnRzS2xhUDdpOW1TZnRmNGR2WWRkVjZjQzRDNDYxTVNhSFFuZ2MzUGQr?=
 =?utf-8?B?Zjk5eFdkd0RRVllCU1RyYkdUVWgzM2QwVzEra2hqWXV4ZnhrZ3JWNzRLdXQ1?=
 =?utf-8?B?ZkN2U081NWM1enIwOEdSaFR3Z3NUUEtJSkQ2Zk53TmR4c1lKY3dENFJxZTQy?=
 =?utf-8?B?eWZ0b25jY0NVVUViMlJNN0FSdVk2dm1xN1k1dXh5S1NKbDV1d1ozT0RIQUY2?=
 =?utf-8?B?RjNaN29iSmh1M2hrNExYQVZrUzNDcFJidWM5Vlc1ZEd4OHBRNTJ1RmVDRlAr?=
 =?utf-8?B?TXpBa2xqY0JhSVM1bFBIc2U1dSsrNlgxTHpGMHdyeXVJNWpZQkYwNmdWQWl5?=
 =?utf-8?B?ZEwxT01OamZEZDFuVnVpNmtjZFl4M1lQQk55TlFkSDU0bWNZaWl0VjAycmJk?=
 =?utf-8?B?bjhCREJxNk5FbnNleGFpcWIxR3FQNE16VUE0d2hFTDg3bFlxeVR0clRyR0hy?=
 =?utf-8?B?K3AzaWtuV1d3eExUMzgyTlZ4RHY0dUJnZ0VZT2RBc0I3Umc2QzVoOXpKTHdR?=
 =?utf-8?B?Zmh4aXdqMVE4dklYVWlKVEF6REgxdUk2NDZmc1MyME11Vml1R09xUEh0WndO?=
 =?utf-8?B?U0RtN00vWTRIOVAxQVRNem5VTGE3N0k3eVg1Z3ZMMEFpUXlUalpxZ0lHM0Y1?=
 =?utf-8?B?VG9KckQ1cWxXQ1dwMTBhSmdlZ0xlRVcxTzlpL0dXMjBqQXViNWF2bDNDTWsv?=
 =?utf-8?B?OVo4U2pFM285QWV1RlZYY0swdDc1eFdlbStnaTdUdklVMlJGSWdvVnAzWnlh?=
 =?utf-8?B?SkJVZDBnYTYzdHZtbUVycDNMNlY1Q3BEeHdsbXFiRDlWa0NyV1d5Y3RsWUtP?=
 =?utf-8?B?WTN1UjN5T0htYUU2eHB6YXh4UHdmRXZodHowcjFxOFpmWmFjMnF2THpPMnNX?=
 =?utf-8?B?M1F5RTRIUTZVYzYzS3NUbGp2NGJ0UWJRU2gycjBCaDdsSlNFaG9MdWFGTWo5?=
 =?utf-8?B?Y2pzRjNyK0pWak04YlVNR0Z2MkMwZThEbDYrYUFFYzFWL1RXTFZ6ZzhHeFNC?=
 =?utf-8?B?MjhLRmxDRVhaWDJHai83alFiV0k3MTI3Zi81dnI0aFpQV2pIL2dwVTZuSFgr?=
 =?utf-8?B?a3lRV1BKZ1ZYTUhtOHh4QU1HZXBoQjlydUNwYTFnWkJMRlZTOTN2a21yZ2oz?=
 =?utf-8?B?VHA2N01sL1FHK0N6V0FjQTVzN3Q4SXVIY2tmRGtSTzhxVVI5bTJTeXJpT0dN?=
 =?utf-8?B?a3N1Y0YrQnBncjl2OXFZQk1WcHJ4b0o4Q2ppWnQ4NXo1TjhCQUY1MmlGZ3V6?=
 =?utf-8?B?T2tLcVZ2K0JRQ0psLytuckNHUm1mQU5OS3J1b3BwMlhUenJBQ1pIUERwSENs?=
 =?utf-8?B?T2VPaWJ0MmJhTElHT3ZjWVhhc2RwT2RWY2xja0prTEc1cThhb1VqNjFXVXVu?=
 =?utf-8?B?RDR6bHNKc1VWcDhKcWFBWGMvSCs0R0FGTit3bXRFMFdobkUycFpVV1RYUmM1?=
 =?utf-8?B?T1VMSVJjTmk2R3B5THFhNjR6N09CemlMa0NRZ2ZpVVlyQ2xnQXE1UkxzeGdO?=
 =?utf-8?B?cUdXYkFYd3dwRXdQZkMweGRyU0NmZkh6a3dIUk15b25aZFBzTUNRQjdpdWp3?=
 =?utf-8?B?WkY1RU5GdXZQVGUwdzA4VlJ5bi9kU080a2hUSVRkdGljQjQ3eFIxRnUyeDl6?=
 =?utf-8?B?b0NXOEsvMkpkeW5pWStpRDVQZjAwSVkvRml2YWZGVUJDMi9kVHJac2diUllr?=
 =?utf-8?B?R05xNlI2aXZZZ3p6NzRybTkxeVBnUzJFZi9rbTYwbUtGOWVJWjZoc3BlMjVD?=
 =?utf-8?B?RWpvN2ptZ28zbHhGVVhtWEUrbGxoNTZSUTZqc1hWRzc1VVVaNHU1RmgwUVRo?=
 =?utf-8?B?V1kzQVpmWE9leUN2S29URjdwRmFXTVR0RGpEaWdnbi9jNVhnYThnMU9TWUx5?=
 =?utf-8?B?bkVMYlNHd0wvdzZxYUNTc21keGZucUFPemJTMnQ5NHZBSndlR0FDeUsySFBS?=
 =?utf-8?B?Q3VLSHp5MVhOWVdKaUx1Z0hnTk9iZndrVTdYMlg3N3A3Q2ZvY2hUR0lWNXBu?=
 =?utf-8?B?bVIxL25ob3haWWROZmd0bWpLM0JVK0RMWnVxUkpFMm5vR2l4TU5OZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wsxIfmupvzPnZgBeSFQJQCuvh/ilLJr03CbTILoVPlWd1pa3fG0NEm1rzEiaSLDb5LU+oFbqW2/vI7+0CjvfK9R7KVPrUGMNaepJFpthmjoEZ+VvvHWVguBHGmWt3sCm3gAnNSCdaXQWNC3VSOloNPcV9HvP2hzwJcwl3VphCi7hR+DjpniRg9ngdTMOyLL+cwx5Si2GSDyjqJUXwhuxwJwXSBm48gyr+ABhPhCm2SDTNE97CLh75haL4pvqi/6br+21Z/77JTrskk7VOXJthd2BSfm0LjLoAXghF9DXfRI0xa2mdMgASHnY62jrr6Vf/2VDkCRsEHeNE6cbCp6JGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30f725f-f706-4da8-b9ad-08df4081edc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 05:58:09.3810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlTTD6k8zS0pp+6tcUX7G4DPjxBg7PH6rMpdsdc6Av6iEmrDbZTPc85UCOTTqdmauHmLYRbJvErVd7GB7g5N1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9616
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE5vdmVtYmVyIDksIDIwMjYgMzozNSBQTQ0KPiANCj4gT24gMTEvNi8yMDI2IDY6MDEgQU0s
IFZpbmljaXVzIENvc3RhIEdvbWVzIHdyb3RlOg0KPiA+IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4gd3JpdGVzOg0KPiA+DQo+ID4+ICAgc3RhdGljIHZvaWQNCj4gPj4gICBwYXNp
ZF9jYWNoZV9pbnZhbGlkYXRpb25fd2l0aF9wYXNpZChzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11
LA0KPiA+PiAgIAkJCQkgICAgdTE2IGRpZCwgdTMyIHBhc2lkKQ0KPiA+PiBAQCAtMjUzLDcgKzIz
OCw2IEBAIHZvaWQgaW50ZWxfcGFzaWRfdGVhcl9kb3duX2VudHJ5KHN0cnVjdA0KPiBpbnRlbF9p
b21tdSAqaW9tbXUsIHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPj4NCj4gPj4gICAJaWYgKCFwYXNp
ZF9wdGVfaXNfcHJlc2VudChwdGUpKSB7DQo+ID4+ICAgCQlpZiAoIXBhc2lkX3B0ZV9pc19mYXVs
dF9kaXNhYmxlZChwdGUpKSB7DQo+ID4+IC0JCQlXQVJOX09OKFJFQURfT05DRShwdGUtPnZhbFsw
XSkgIT0gMCk7DQo+ID4+ICAgCQkJc3Bpbl91bmxvY2soJmlvbW11LT5sb2NrKTsNCj4gPj4gICAJ
CQlyZXR1cm47DQo+ID4+ICAgCQl9DQo+ID4+IEBAIC0yNjYsNiArMjUwLDggQEAgdm9pZCBpbnRl
bF9wYXNpZF90ZWFyX2Rvd25fZW50cnkoc3RydWN0DQo+IGludGVsX2lvbW11ICppb21tdSwgc3Ry
dWN0IGRldmljZSAqZGV2LA0KPiA+PiAgIAkJICovDQo+ID4+ICAgCQlwYXNpZF9jbGVhcl9lbnRy
eShwdGUpOw0KPiA+PiAgIAkJc3Bpbl91bmxvY2soJmlvbW11LT5sb2NrKTsNCj4gPj4gKwkJaWYg
KCFlY2FwX2NvaGVyZW50KGlvbW11LT5lY2FwKSkNCj4gPj4gKwkJCWNsZmx1c2hfY2FjaGVfcmFu
Z2UocHRlLCBzaXplb2YoKnB0ZSkpOw0KPiA+PiAgIAkJaW50ZWxfaW9tbXVfZHJhaW5fcGFzaWRf
cHJxKGRldiwgcGFzaWQpOw0KPiA+Pg0KPiA+IEkgdGhpbmsgaXQncyB3b3J0aCBkb2N1bWVudGlu
ZyBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugd2h5IGJvdGggb2YgdGhlc2UNCj4gPiBhcmUgbmVlZGVk
LCByZW1vdmluZyB0aGUgd2FybmluZyBhbmQgYWRkaW5nIHRoZSBmbHVzaC4NCj4gDQo+IFllcy4g
SSB3aWxsIGFkZCB0aGUgZm9sbG93aW5nIHRvIHRoZSBjb21taXQgbWVzc2FnZToNCj4gDQo+ICAg
QWxzbyBkcm9wIHRoZSBXQVJOX09OKCkgZm9yIGEgbm9uLXByZXNlbnQgZW50cnkgd2l0aG91dCBG
UEQuIFNpbmNlDQo+ICAgY29tbWl0IDc1ZWQwMDA1NWMwNSBhIGNvbmN1cnJlbnQgdGVhcmRvd24g
Y2FuIHNlZSBzdWNoIGFuIGVudHJ5IGJlZm9yZQ0KPiAgIGl0IGlzIHplcm9lZC4gRmx1c2ggdGhl
IGNhY2hlIGFmdGVyIGNsZWFyaW5nIGFuIEZQRC1vbmx5IGVudHJ5LCBhcw0KPiAgIG90aGVyIFBB
U0lEIGVudHJ5IHVwZGF0ZXMgZG8gb24gbm9uLWNvaGVyZW50IGhhcmR3YXJlLg0KPiANCg0KaG1t
IGlzIGl0IGEgc2VwYXJhdGUgZml4Pw0K
