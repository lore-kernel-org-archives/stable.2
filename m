Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B34FDE55;
	Thu,  3 Sep 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458339; cv=fail; b=qmd1pkFmCy9E3pbn4Im1bHotpECryLMhFfPWj7Nbe7x0ZvSJ2ay++SmaJ3KpObpO4WwC5dSJkb94Hd2PjUetEVTaDf0lQC59wc7ZMpPHgVpHELoZbaBzngHlM9pJuWZc9tgp+H/WWo+J/4wmSqkWndB1Fzp9a24Y1zOaaXkfJiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458339; c=relaxed/simple;
	bh=bfD6JfbfFu8pJlZCx0Vl5y7RE5BwIAG448slBy0Aa54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JII78qm2TENVnEW5qEIZ2CUOC96MB9JJF/L4lxDRGXEJqEvmxOHicaOleBwSspYpCVAGSzRg1E0OxhkpeOCGIt3rmrD/iBoSrOdQe6IbJbIYFNxJ1WLXr4LF4UxXnEqfOa7OVgF4wU5TSUOPoyIzQYpBqHkezZpE7ljZswhDnWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKGRfOUF; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKGRfOUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788458336; x=1819994336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bfD6JfbfFu8pJlZCx0Vl5y7RE5BwIAG448slBy0Aa54=;
  b=FKGRfOUFWLRUeR6rbgMu0Dt52ez4WnaDuvLjtjIKAm0+TW2C5MBEyE1i
   XZKdswrVmOdwQofuizaQYtryiBDaLkviyR/Mo8UMcJvy1T005vdift4jw
   jWsIArx9SuuIBeCp0atXqsg9yS2fMJEa5PkVBEwKz+RssbEotXNIGncRP
   d45CNd99ez32ntjh7RWDIphofGYjcT4Qds/HfKgXZ2az+n+HrVgk2FOOv
   CvZv5Z8ekDzuK9vENObRp7LxLiXtR0ZNO1zBfQxoGQJ0XB397PIn9z5w0
   nFIumulSwDbD5BLFYMZVrhDf5tOcz2Uf1hqoMwHzW3BMYuaHxJ+QcexaB
   Q==;
X-CSE-ConnectionGUID: FNoJy2ArSfKPhPtu8+oh6g==
X-CSE-MsgGUID: fYX8cEVcSHGumh4kvxBp5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87889577"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="87889577"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 10:58:54 -0700
X-CSE-ConnectionGUID: nut007fXQuyieapYBxwSrg==
X-CSE-MsgGUID: CjV1qcEcRImX3CtGA+mFXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="266551547"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 10:58:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 10:58:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 10:58:53 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 10:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vu1TOlVFSDRFUGLSZWgXJcumWJEJ6RKCAfhAg5f040tR0yxGchyYDN5N9ltOtLI3jrCMFiDmzL5ZHRKGFebrY6JG3CKAWKuN7+5QKz7ZR/hkMnzkdDsqwRr8hHHQFUyAtTITmG4DT+UosiPRao/6Zy402mpjJrlolpsxE2RwGgeYDD1wk16ERwWh2eVw/I1R3lIm9fEX5n7omeleOwr0fcLrQGFpCjTdA7w9WC05BpAH/fnmEGbvh5lermQGj8y8pJBFa+B7yVKJNBKEw5wywQXU6K27xEmwFGFkdSae82+EeHRz9X1QlM1SqByzEhWDfJKpbrwhJbLxikHkLAbTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfD6JfbfFu8pJlZCx0Vl5y7RE5BwIAG448slBy0Aa54=;
 b=RW6BK22kRADGTSwIvnVcjY/wzJWheLFWVSFfiZybUM87qjkphtzRf07ZCYU3z6dKwjCTr+Qj05GpbvYAZC4dM3uh6PWLrWXCurpFEw3kJjIebWQRfeCb1PlFbpNfGlDeM6RCtGwA5WEIUa/aoG0tgL+3ClCC4Les3XBy+c++lH3kKmf83PrvVGzZywWpJFPq3aIUClHHgxvFlzPBe7dYuuroqnm2mWnY0IXJIBu2qVmx5+te0H2Tn7G4Ud10FuCS9MdBuemoKp+b8flXfzjXlnwi2PviUI69K9UPhcgaKHrWqKZcaIGq0VAhpUeDoP9Cf97bMb0xPs5sI8VWBPEkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7580.namprd11.prod.outlook.com (2603:10b6:8:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 17:58:49 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 17:58:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "vernon2gm@gmail.com" <vernon2gm@gmail.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>
CC: "andrew+kernel@donnellan.id.au" <andrew+kernel@donnellan.id.au>,
	"rppt@kernel.org" <rppt@kernel.org>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, "yanglincheng@kylinos.cn"
	<yanglincheng@kylinos.cn>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "david@kernel.org" <david@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"tj@kernel.org" <tj@kernel.org>, "orsonpeters@gmail.com"
	<orsonpeters@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "rmclure@linux.ibm.com" <rmclure@linux.ibm.com>,
	"bp@alien8.de" <bp@alien8.de>, "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm: Fix pmd_modify() dropping the dirty bit
Thread-Topic: [PATCH] x86/mm: Fix pmd_modify() dropping the dirty bit
Thread-Index: AQHdO1K4MHbba6oaQ0Cd7mC7VbQSrba8v1SAgAAoUwCAAD1wAA==
Date: Thu, 3 Sep 2026 17:58:49 +0000
Message-ID: <c15c2b17e110782d966751dbf3c487a6db837a87.camel@intel.com>
References: <20260903031608.1194238-1-vernon2gm@gmail.com>
	 <aplfcTfjeQUgnrvH@thinkstation>
	 <314f11c1-ce5e-4b36-b296-0ab742550851@intel.com>
In-Reply-To: <314f11c1-ce5e-4b36-b296-0ab742550851@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7580:EE_
x-ms-office365-filtering-correlation-id: 81b9e9ab-f0fc-4e51-8a29-08df09e501ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|38070700021|4143699003|11063799006|10067099003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: +65MkyM+augeMaaY0oGjs4RT8VDb8/wiUbxg4RLoAxkbYsuPxKz7/1hKhgeQ+HBDnnDb4bzWh8vieDbETu0B6qIXervoDUqo5GDo2vMUrOzXVi+YeSn0m1Rq89N17wNYCx3mRAn+dT5lwHYVdzw012Wb8PP2p/3CCdWiO/g/G1MrD5H401jPCFkDx4dhU6wlYl3Opv9h4GKDvbSAt/kQmf88JNU4YNMxPqpwtbHJ3CvUvZjKjFdyA3IpwMClBsX4mXIUi6ou5Vb9Fpu7vJ7iVLStFmycXqz9t4ihJHudVYLM/+B6A4tuTRubfgTkYOHSL6vCvRaGbfna8o8jVAOn/qrQS7roWS9tmQrwRk8HtiGbybDuCzVeLKlNr34sUKbL3CNdicq7b1MzUz/1eNYiR6IVu21XevZtaAkeBL+7Jr7UIdrjCDIX2zrcR0+nthoCrFizNdUoAxL8j/QgB6L70CQDHzliZqeCbYOrZPq7afOI3AHoNCXGRQunJFpgd6e1JdLe06dZ5loMDCrjbLY73rNcoq7dJGhhuGnSRfKx4aL+xvWXG/SJ1KbbSeUFsunkXqJ/ZwsT+PvTtKdTjJBXayAtsI8WxPkM5eRcGwtR/cSs4VjBMGiYDvpvOsx5zgins/8F8gOlj2RPr9Wd8/OYVOem3vdhWq4CFXJoQTpA3oo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(38070700021)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTRHRWRxcTAvb3BPdk1yY2J2NUoyNnVlMkV2VWN1QlJLVzNlL2JQRTIyRkR2?=
 =?utf-8?B?KzVDdnY3ZGorZDNmbithZE04WGFCSE94UnYrRXRyZ0poRjgrcTdQS0VZRU5Q?=
 =?utf-8?B?NElta1pYYVFCYVFDb1h4cmVnTjFleWJCMEFMeFBwVXdtZEUwR2IrOTU0TERy?=
 =?utf-8?B?cUd1UDVRb3ArT2t6bzEzV244UkUwRWJycGV0dE5sOHJCdnBaSW0zLzZqMWZW?=
 =?utf-8?B?ZktLak5lVGdZTlBDZTVNMTFZVTJtSzNPcno0bWpnd3dHcS9KSDRYK0R3OG5X?=
 =?utf-8?B?d0N6dHFyREJlcitXUVZLTWVEQ2xhN3dKMTFxQ0krejEwRCs0NFh0TDRvaW1S?=
 =?utf-8?B?MEdWZklLQnBmdlhGcEUxRkZKSGZtcDFxOVBndmVEMml1V2lsVUR1MmU5ZnlC?=
 =?utf-8?B?ZTVKZXJsVzJveWZLVFpwM0Z5RlBBZytJdmpOOWJJSC9vWGg4UjdSYWxYMHVV?=
 =?utf-8?B?R2MxVWZiWGgza3hEU1BBb2RFKzhWNmRtbnFsNlV3QXNnc2hPSHdBSlIyZzIv?=
 =?utf-8?B?YktIWCtrcUUxc2Nick5vaDFIczl4ZEZkdXlpcFlmczgvWXQzSER2dDJiZ201?=
 =?utf-8?B?ZVQ2TUZ1eDljU2RBZUNoTDFyTFE3RUpkOU94eFV6UVNNbndrVk1sTEo3allk?=
 =?utf-8?B?VGt4MDFlb0cwTGlZMURXbVpCV3Y0em5CS1JtaGI2eGZGOVA3dE5ZTUhId3B4?=
 =?utf-8?B?WjZaK1hiM0J4SmhOREJMYVplL0dKUFVKY2cra0tFcEdOdWJDU2FzZUYvTTNr?=
 =?utf-8?B?dUZ3Tkk4N0RCcFArc2cwN3lGVHF4NHhteUUzbXBiemQyN2xHSjBlNkFYL29y?=
 =?utf-8?B?SEp2blExQ3Z4bDhURDMvZzhvYzIrZVV1NStlUkR5UzlWY0lGcVgwUC9wR3hS?=
 =?utf-8?B?Zkk5VGRiMkpEVWlnUFhWY0VpUlljRjlMbmJOd09WTkx4RU1JWHpYYkRXSWVa?=
 =?utf-8?B?d0VPRUJKT2JwYWF1QnZuelJ0S0JXczI2aHRPNEFDTnd0MnNOVFkzNWJCekNW?=
 =?utf-8?B?RXJKTG9odWtvWVR3VXdPVXRWUTcrRzVUSDNzcTZJZThBcHgxaTYyUjhaR1Nv?=
 =?utf-8?B?aytIeFpzT1l5bFBXY0hTZFB2NHhBcVdXazhGUFBHY0dSOVEzNXVhNXFpMWVT?=
 =?utf-8?B?endPTWM0Q1BYeFpWWU9SeUpsRktycTVteVhxdVZEY3k5SU5Kcklvb1RKbHFI?=
 =?utf-8?B?R2lPekRPdkhwQXk5YTgwUnpJWUZvd0dqenEyVjZqSW9vSHY2WDBBcnNPY09v?=
 =?utf-8?B?bDhOTHgzQU42MjlSbUpPVnpBREJCdVVBZUpZUnBvak5PRHZrc3dtbnNHNFVt?=
 =?utf-8?B?ZDNvZS9QcXVydkNPNUdjeHlKWnpSaEcrbG1Md1hnSGNDM1ZxTEJ5MmRqRDlD?=
 =?utf-8?B?aU1ycFNWYjVhdG0xbENRVy9TWmlNWkVnNHpPdENobWN1YmtKaXJVK1pJb3RO?=
 =?utf-8?B?d3F2ckxqdTBRdDN6RmwweTlBbXRlV2NOcEsxUFh5WE5BYUVRdStvWVRRRmxL?=
 =?utf-8?B?TldnSWpYdmtFQmRVYzg2U0pFbTc4UUYrNFBXdXVsWG5lektNS2JobGdhQmY4?=
 =?utf-8?B?WU5MK2NmZGJ0YW1JaW01Njl5c1RFZExBRFFoRWZvRXVqd3hiNHBqcHBaOUZM?=
 =?utf-8?B?UUJtK0x5T2ZGeUpjalhRbHB4d0tvS1ErbUVNU0p1VS84SUdzWWtCenJWdWEy?=
 =?utf-8?B?YVk2VkcyNkxrcWhKeElCUUpYc24ranBVN3JhMUJGdzZKdHFEakdzMlJqNms2?=
 =?utf-8?B?NjNnZFZKcnE0b3dBOGZoMk81M3U1U1NrUFVrUU5JNXE3VUcySVY3V29tQmxL?=
 =?utf-8?B?MVVpZlZsaEFZa3R2NEhpK2hhR1orNlRwSnh6UHg0a0l4cHQ2R1h2Zk1DVERX?=
 =?utf-8?B?K21xeVprQ3dCTUF6NjdPdlAzQ210eTNnZ2E3UHMvcVJlTnRzWUVjMjhXQmN6?=
 =?utf-8?B?dlhBYWY0RUNYWXcrR3RZbUlDYVhtYUQyRjdBUXdMZForMVNWK3U4c0UzMzZC?=
 =?utf-8?B?UkZQZW1pcGoreWFlaWJ6LzB3Ym92cG5JT1NQbFU5bDlUM0Jzc1lPcHBvTUtG?=
 =?utf-8?B?SW1EMGw1akU2OXkzMlNGRXoxTllVSVFKQk4zb2c4ZU5YSnFvVFZGOVV0Tkcw?=
 =?utf-8?B?M3UzbkhGV1pNRVRXMktXRjM4TEpVbWFnR0pjcDBibWYyMWtUcDVGS0FadUIr?=
 =?utf-8?B?THRKMlZLRm5vM083YnNISlE4QndiMW9HclIvTndPWVFURDZhY0VZMG9Cb2Jr?=
 =?utf-8?B?OUUwUitmdXp1L002dCtCK0Z4K2JzL2plbnRJTHdZNTV4ZGk3Rjk5YnFET0VX?=
 =?utf-8?B?c0RJMW1IR1NLbnFKcHIzWnR5VUsxRGhvTHBMREw4eklnczhteXcvUTVHYm5v?=
 =?utf-8?Q?zTvLNn1+fqhqP6a0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2620A73529FAD04C88F2F6714136336E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T7RkDX4l8701hQfsebsjv3sfulE2Ts48EgSQZ4V30Vf0P9XMNctEN8CQ2zm9SyeUfsMXg9jQdhT0GTmCsRVMy1FNS1a/o04OMSPYIAZ3MS8738VuVZ1+Nvkm38oOzKnpEDgwY6/Xu58oTGfxSvLJ2Eycd3sGcihFkFDwqtlRLsHBCiq8OhlYeLjTfkiE20TB8fOkaZdvIwV6dWCtQ9a/ScQHFKhbRCwIGF6kZrGK2c3iqyAspg4mJnDOonTtNKadqZraQUjWiaTFRALepJyCUMiIoSl5vZx67SxmkShZDnEWsQ4+gCpVigyk8zjV8Lnz0cfzPl/XtTbxdI7St+ynxg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b9e9ab-f0fc-4e51-8a29-08df09e501ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 17:58:49.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8R1KnGVCWgdsbtfNrdwzAZae8DltbEtAunu1DDYYLxP7iXRrQphMNXbLJ5KPM8KCsXtaQ7ZhUAcSAyITGxjs/VRVVpFbtugJT9vr4fJkNMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7580
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA5LTAzIGF0IDA3OjE4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS8zLzI2IDA0OjU0LCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6DQo+ID4gPiBDbG9zZXM6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvQ0FKeEx4TVVHdTEtTCtPX25BT05Pd09YblM9Y05iTkFw
Q1dxZHRoUmpkNzZMVGh0U1BnQG1haWwuZ21haWwuY29tLw0KPiA+ID4gRml4ZXM6IGJiM2FhZGY3
ZDQ0NiAoIng4Ni9tbTogU3RhcnQgYWN0dWFsbHkgbWFya2luZyBfUEFHRV9TQVZFRF9ESVJUWSIp
DQo+ID4gSG0uIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgd291bGQgdGhpcyBjb21taXQgZXhwbGlj
aXRseSBleGNsdWRlDQo+ID4gX1BBR0VfRElSVFkgZnJvbSB0aGUgbWFzazoNCj4gPiANCj4gPiAt
wqDCoMKgwqDCoMKgIHZhbCAmPSBfSFBBR0VfQ0hHX01BU0s7DQo+ID4gK8KgwqDCoMKgwqDCoCB2
YWwgJj0gKF9IUEFHRV9DSEdfTUFTSyAmIH5fUEFHRV9ESVJUWSk7DQo+ID4gDQo+ID4gUmljaywg
Y291bGQgeW91IGNvbW1lbnQ/IEl0IGRvZXNuJ3QgbG9vayBsaWtlIGEgdHlwby4NCj4gDQo+IE15
IGd1ZXNzIGlzIHRoYXQgaXQncyBzb21lIHJlbW5hbnQgZnJvbSBhbiBlYXJsaWVyIHZlcnNpb24g
b2YgdGhlIHBhdGNoLg0KPiBUaGUgYXN5bW1ldHJ5IHdpdGggcHRlX21vZGlmeSgpIHZzLiBwbWRf
bW9kaWZ5KCkganVzdCBjYW4ndCBiZSBleHBsYWluZWQNCj4gYW55IG90aGVyIHdheS4gSXQgX21p
Z2h0XyBoYXZlIGJlZW4gc29tZSBhdHRlbXB0IHRvIHNheSwgIkhleQ0KPiBfUEFHRV9ESVJUWSBp
cyBub3cgYSBwYXJ0IG9mIHRoZSBwZ3Byb3RfdCBzaW5jZSBpdCdzIHBhcnQgb2YgdGhlDQo+ICdw
ZXJtaXNzaW9ucycgb2YgYSBzaGFkb3cgc3RhY2sgUFRFIiB0aGF0IGdvdCBhYmFuZG9uZWQuDQo+
IA0KPiBCdXQgSSBkb24ndCBzZWUgYW55dGhpbmcgd3Jvbmcgd2l0aCB0aGUgZml4IGF0IGFsbC4N
Cj4gDQo+IEl0IGRvZXMgZ2l2ZSBtZSBwYXVzZSB0aGF0IHRoaXMgaGFzIGJlZW4gbG9zaW5nIHVz
ZXIgZGF0YSBmb3Igc28gbG9uZywNCj4gYnV0IGl0IG11c3QganVzdCBiZSBhIHdlaXJkIGNvbWJp
bmF0aW9uIG9mIGZlYXR1cmVzIHRoYXQgZmV3IGZvbGtzIHVzZQ0KPiB0b2dldGhlciAoaHVnZSBw
YWdlcyArIE1BRFZfRlJFRSkuDQoNCk9vZi4gTG9va2luZyBiYWNrIHRocm91Z2ggdGhlIHBhdGNo
IGhpc3RvcnksIHRoZSBkaXJ0eSBiaXQgdXNlZCB0byBiZSBoYW5kbGVkDQpzZXBhcmF0ZWx5LCBz
dWNoIHRoYXQgdGhlIHN0cmlwcGluZyB3YXMgbmVlZGVkLiBMaWtlIHRoaXM6DQoNCiBzdGF0aWMg
aW5saW5lIHB0ZV90IHB0ZV9tb2RpZnkocHRlX3QgcHRlLCBwZ3Byb3RfdCBuZXdwcm90KQ0KIHsN
CglwdGV2YWxfdCBfcGFnZV9jaGdfbWFza19ub19kaXJ0eSA9IF9QQUdFX0NIR19NQVNLICYgfl9Q
QUdFX0RJUlRZOw0KIAlwdGV2YWxfdCB2YWwgPSBwdGVfdmFsKHB0ZSksIG9sZHZhbCA9IHZhbDsN
CglwdGVfdCBwdGVfcmVzdWx0Ow0KIA0KIAkvKg0KIAkgKiBDaG9wIG9mZiB0aGUgTlggYml0IChp
ZiBwcmVzZW50KSwgYW5kIGFkZCB0aGUgTlggcG9ydGlvbiBvZg0KIAkgKiB0aGUgbmV3cHJvdCAo
aWYgcHJlc2VudCk6DQogCSAqLw0KCXZhbCAmPSBfcGFnZV9jaGdfbWFza19ub19kaXJ0eTsNCgl2
YWwgfD0gY2hlY2tfcGdwcm90KG5ld3Byb3QpICYgfl9wYWdlX2NoZ19tYXNrX25vX2RpcnR5Ow0K
IAl2YWwgPSBmbGlwX3Byb3Rub25lX2d1YXJkKG9sZHZhbCwgdmFsLCBQVEVfUEZOX01BU0spOw0K
DQoJcHRlX3Jlc3VsdCA9IF9fcHRlKHZhbCk7DQoNCgkvKg0KCSAqIERpcnR5IGJpdCBpcyBub3Qg
cHJlc2VydmVkIGFib3ZlIHNvIGl0IGNhbiBiZSBkb25lDQoJICogaW4gYSBzcGVjaWFsIHdheSBm
b3IgdGhlIHNoYWRvdyBzdGFjayBjYXNlLCB3aGVyZSBpdA0KCSAqIG1heSBuZWVkIHRvIHNldCBf
UEFHRV9DT1cuIF9fcHRlX21rZGlydHkoKSB3aWxsIGRvIHRoaXMgaW4NCgkgKiB0aGUgY2FzZSBv
ZiBzaGFkb3cgc3RhY2suDQoJICovDQoJaWYgKHB0ZV9kaXJ0eShwdGUpKQ0KCQlwdGVfcmVzdWx0
ID0gX19wdGVfbWtkaXJ0eShwdGVfcmVzdWx0LCBmYWxzZSk7DQoNCglyZXR1cm4gcHRlX3Jlc3Vs
dDsNCiB9DQogDQogc3RhdGljIGlubGluZSBwbWRfdCBwbWRfbW9kaWZ5KHBtZF90IHBtZCwgcGdw
cm90X3QgbmV3cHJvdCkNCiB7DQoJcHRldmFsX3QgX2hwYWdlX2NoZ19tYXNrX25vX2RpcnR5ID0g
X0hQQUdFX0NIR19NQVNLICYgfl9QQUdFX0RJUlRZOw0KIAlwbWR2YWxfdCB2YWwgPSBwbWRfdmFs
KHBtZCksIG9sZHZhbCA9IHZhbDsNCglwbWRfdCBwbWRfcmVzdWx0Ow0KDQoJdmFsICY9IF9ocGFn
ZV9jaGdfbWFza19ub19kaXJ0eTsNCgl2YWwgfD0gY2hlY2tfcGdwcm90KG5ld3Byb3QpICYgfl9o
cGFnZV9jaGdfbWFza19ub19kaXJ0eTsNCiAJdmFsID0gZmxpcF9wcm90bm9uZV9ndWFyZChvbGR2
YWwsIHZhbCwgUEhZU0lDQUxfUE1EX1BBR0VfTUFTSyk7DQoNCg0KCXBtZF9yZXN1bHQgPSBfX3Bt
ZCh2YWwpOw0KDQoJLyoNCgkgKiBEaXJ0eSBiaXQgaXMgbm90IHByZXNlcnZlZCBhYm92ZSBzbyBp
dCBjYW4gYmUgZG9uZQ0KCSAqIGluIGEgc3BlY2lhbCB3YXkgZm9yIHRoZSBzaGFkb3cgc3RhY2sg
Y2FzZSwgd2hlcmUgaXQNCgkgKiBtYXkgbmVlZCB0byBzZXQgX1BBR0VfQ09XLiBfX3BtZF9ta2Rp
cnR5KCkgd2lsbCBkbyB0aGlzIGluDQoJICogdGhlIGNhc2Ugb2Ygc2hhZG93IHN0YWNrLg0KCSAq
Lw0KCWlmIChwbWRfZGlydHkocG1kKSkNCgkJcG1kX3Jlc3VsdCA9IF9fcG1kX21rZGlydHkocG1k
X3Jlc3VsdCwgZmFsc2UpOw0KDQoJcmV0dXJuIHBtZF9yZXN1bHQ7DQogfQ0KDQpUaGUgZGlydHkg
Yml0IHdhcyByZW1vdmVkIGZyb20gdGhlIHB0ZSwgdGhlbiBoYW5kbGVkIHNlcGFyYXRlbHkgdG8g
c2hhcmUgbG9naWMNCmluIHRoZSBta2RpcnR5IGhlbHBlcnMuIER1cmluZyBkZXZlbG9wbWVudCBp
dCB3YXMgY2hhbmdlZCB0byBkbyB0aGUgbmVjZXNzYXJ5DQphZGp1c3RtZW50cyBkZXBlbmRpbmcg
b24gdGhlIGRpcnR5IGJpdCBpbiAndmFsJywgYnV0IHRoZSBtYXNrIGFkanVzdG1lbnQgb24gdGhl
DQpwbWRfbW9kaWZ5KCkgc2lkZSBkaWRuJ3QgZ2V0IHVwZGF0ZWQuIFNvIEkgZG9uJ3QgcmVtZW1i
ZXIgb3Igc2VlIGFueSBpbnRlbnRpb24NCmZvciB0aGUgZGlmZmVyZW5jZS4NCg0KSSBjYW4ndCBm
aW5kIGFueXRoaW5nIGJhY2sgdGhlbiB0aGF0IHdvdWxkIGhhdmUgcHJldmVudGVkIGl0LiBUaGUg
YnVnIGNhdXNlIGFuZA0KZml4IGxvb2tzIGNvcnJlY3QgdG8gbWUuDQo=
