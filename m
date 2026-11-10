Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794332520;
	b=xJReTh8vR7J2O+qvYQfPCOrpXV8M7scw+x+ywrZtHfMEWKaEISJOEsATrIvCtxSgz4zC
	 kGS5jlN/nmBeOpIZPOGXok7i1RnrPY0l8z2HmnY0LE1yjDSJ5dPV3fmUIuBntSq7vCqPr
	 qCWJgQwFfUGOqOxHxhNqSn7GREVCo0RMTPC3ueqhA6ori5DYXKU5VQEDuv7RiRkOprLWY
	 9pnHZKnYC9fBiX4/IooWNEDGpMeIkA76eIQBn/4gPmbFDbKRiNU1M6X6aFpsA/1SVCeCq
	 XSeXwrI/kM4qnvRADs3WB0IzisKdgyYkeHYtET79edTiJb0OjBaYYIeKF9nru40sblA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332520;
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
	bh=AgWkJncGW/pDYBe40hdii26sEBXDStfxUJe6xnhsLIw=;
	b=WS/oXd0z0lAevXhpxtI7wJ7XiMuuCddA1wk/URUGPLRnYxDrWf+ks+zuuDLRCrtk42td
	 u+1igEyGtbfI19QCrqZp3yYIMPJQ1v7/QL/IqIGeGT6pmkskJtRI/8zX9fAzN5wf0d5ra
	 Et4O9elaOAa05MUiigwof9O1tEjBe/FO3Mehn6E940rnq2BkW6ga/mFecxY0G4E3g2E9K
	 xJjk/VwmfDSMsMURz3cvlxZ6QlxcQ/9cXD450TGiPAFbKpGzla88mabs8hc24gN8Wi/Mw
	 uJBqkuZYW3t8dw+T5zkAEwjG1NEJ4CyOL3Z5cIHBZmibsTBFalCUlXXQNetHyHz6IWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QiDlaxJg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530C606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9530C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QiDlaxJg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794332520; x=1825868520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AgWkJncGW/pDYBe40hdii26sEBXDStfxUJe6xnhsLIw=;
  b=QiDlaxJgnAw63KHqF7dbyHWjUfZBW6oD6KcW5GPaxdrG6Bhu5fH4S5v3
   5/QE67PWgs3cvJi4vntfHI7T2W6ADNFaJVTxG3Ltzs4gfOqQ5jYUesGs2
   J12fubUfJV/Opt5zhr+dnhOpNJpEthGHqwa6NAXQsG3TuNX1m9cypjB9f
   PQwu0QrdrXxO6SP28c5W7FuFQ/+7QHQ+Zc6yydbgJLgj2EYSNJaWUHZ3e
   rw+aqMhgSt2aYzmKqWtgA8HkDQVdzGCbDBG0Cy/ep09xAGpMImZSS+gnG
   UtfLWBmgRKZkvBpBinsZdfHimNXvr74C05OgIdIYDs59k6YjD5qv9nEJN
   w==;
X-CSE-ConnectionGUID: hhrNfel5SwKSlC2EzFvoEg==
X-CSE-MsgGUID: 0IP+OPsdQemyhhXG7q67ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2991930"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2991930"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:41:59 -0800
X-CSE-ConnectionGUID: ihdUIfRpT5y8yffAZeepYg==
X-CSE-MsgGUID: NeFUpTCUTmOga8xKtBrk6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="9940841"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:41:59 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 09:41:58 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 09:41:58 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 09:41:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdrqEO7f/Q7qj+bfqfOGc6newKLeToe6z+toXS8eukUHWa8OhWeNun6xnXQlCMAJ9ivDE9Wvf29UrqFUWW5x2j2jaqYIymazOme7XTKD9W7jtoXev3yWvPBXlHo1uTbYx6UqcNVK487YpEcmDx1OHWdgC7TyvhEcP5bv2sfdik1lBeJQasLetjHY6wTKxDVt0KBBJ0r4iAX6BSY2hLt/7kbAuhUmphIpG2RU7A6Qkz0stPF0f5M4xYCShHAj8jr5pbl4IFPQdnuCSPd1GDXkGO1QerVWRfMEiEFWmVEQfZiIBomI6k2Bof8iTaXCMF/BZOMcO+sxxeru6WMIc5RoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgWkJncGW/pDYBe40hdii26sEBXDStfxUJe6xnhsLIw=;
 b=Yaye1A+xlvGlBYbOCkjNj4d6xJ/ZMakBwClCa9xP6vMiBcufp9rKJSn5AqABP4iw/f2Vj7mwnNTKl+qJ7vNnoXjtTL3EQ/R03eIELvoHo0Q65VQVcxAmd3mZbOQlfRQQWpeNStvrMJK2j40SF9Omf4wdp9bLOhp7r/pwxb5oee7ARvifhZpow+9BHelY265FyAV4d6SsZ+LfGWPl0l+aQUhp2SqGhZqzKemtRPwXRUfTA/S85KlhpTAWcmgGSI8m0aAlmxkd1OelnroWWu1vO1dajkLiA71vJSUGV0hDyIvGTCOAZwZSkKY7J+6dZJiL8HSKLJHMQKiM9pMdco6rSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS3PR11MB619106.namprd11.prod.outlook.com (2603:10b6:8:43e::11)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 17:41:55 +0000
Received: from DS3PR11MB619106.namprd11.prod.outlook.com
 ([fe80::3637:8d63:f875:b4ee]) by DS3PR11MB619106.namprd11.prod.outlook.com
 ([fe80::3637:8d63:f875:b4ee%7]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 17:41:55 +0000
From: "Yao, Jia" <jia.yao@intel.com>
To: Sasha Levin <sashal@kernel.org>, "Mun, Gwan-gyeong"
	<gwan-gyeong.mun@intel.com>, "Auld, Matthew" <matthew.auld@intel.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: FAILED: patch "[PATCH] drm/xe/guc_ads: use uncached mapping for
 UM queue BO" failed to apply to 6.12-stable tree
Thread-Topic: FAILED: patch "[PATCH] drm/xe/guc_ads: use uncached mapping for
 UM queue BO" failed to apply to 6.12-stable tree
Thread-Index: AQHdbqEPujCQtMoLrUK2rzyz0VbU7bcnmDow
Date: Tue, 10 Nov 2026 17:41:55 +0000
Message-ID: <DS3PR11MB6191067EA123221858417BC370F4722@DS3PR11MB619106.namprd11.prod.outlook.com>
References: <20261107051619-failed-6.12-9daa302a8259@kernel.org>
In-Reply-To: <20261107051619-failed-6.12-9daa302a8259@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR11MB619106:EE_|CY8PR11MB7136:EE_
x-ms-office365-filtering-correlation-id: bba54503-1248-42af-0164-08df3f51e9d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|42112799006|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: +4UiOu3hguWn3nmQz2QuIRW1DcUCC3DNDsvJ2rB2hBLbEqWn+3464OuFuy7VM1vx+W0XXC75WK7EZg7J2vO74moQ+Ai3LceLQMfrWmhlt0VbQ8e3QVex0Mu9gvQ/e3eXvNuZldoFWiZTLTzFAm/nH/NTd1wxBlSZEddjy9TMzdTY//99IG1gbW/L+QmG9SUeNHLcGdK24nUJUo6Pscj8kj5oeRWYtFRS9CO8Yi5Z/qhFqNWztgC1IXX5NcmS9FsDHGku37Icrk/HpfuxiEgaZNWZUMFzsENqr6K9LYWSY575zkARjTsb6gFvqIzf2R1rl/2eJmvmTAYPmIHcu+1sKN8zXDF8CLeCJaj1yXtVZkClcAcISs235+Pr0y5tIHkG202T9xRAhcX5mXKb/GGfOQ1q0FhysQkTVbRAGBoSenatzpqRN7Uk44yf2dPYD3kNQCfK5N6lj5sW42Uj9oLt5079QDnc4w3c+G0UEA18wvG/VmfxOXvCL8VSlCQ5Zk8l8shHRd3Z1DhCv2n4tTD4ZQPZvIQKWSJLlbUjqEi9ymZSieSSs/lKgYS2XgLi4r8uQkIBf92aCZRWF5czLr3VvlhcfNZVVw44i6Ws2ApJn71ZezMvUe0HrzvUYQ2kgBD1fbZay4L8ZZpfFbRjFeLx28mzsZgT38z+tt5uzRyfMSnsZb5IQkHuCiaZ8eW8AAVx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR11MB619106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(42112799006)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTZpV1hkR0tXZjVTL1BKS211TXB1UkMrZU9oT1lLZHhiaDgxVVNQQzBUTHh6?=
 =?utf-8?B?OTk2Q1MzSmJLMS9PS1JMUitocVovYXdsakJ2aFVhT0E3bWtoTWFBZDROMk4v?=
 =?utf-8?B?MGFtU3haR1hiZ3Mxdkg1MGVDcyt5QWNYRTNuajUzTHh0WmE4SXpGYno5TndI?=
 =?utf-8?B?cXBZbU5xUmNQWFVwVUl6djBWSmdGQnQzc0pDRDcxc2dLcDhtMzY1aGhOeEZT?=
 =?utf-8?B?MlcrQ0dWMWJMd0dIV0lNdlV0R0dFaGcrQ2Q2QUZ1blJzYUgxem9Td1ZRaUY2?=
 =?utf-8?B?eUV5ZHhlckJPRzRrVVBBRTRLTldzbVcyMDlWOTh6aE1ZclVmelhkNkxGV3pB?=
 =?utf-8?B?QlBMKzI1L0RVYnNPNmZWZmJTQ29nTHU5cjVlUk85bXlHblh2azZURzA4RmZZ?=
 =?utf-8?B?b3ArZ1gyakY4MkQrRmRzM3pwTTF1QVpsM3RNbWcwM1p0TWo1elhXZEpqZzZE?=
 =?utf-8?B?RklBVFJTMXlINjJtRzhaVTZIS042a0taWWFqR3FmcFRxQWdoVTJ0TVRmM1ZC?=
 =?utf-8?B?cThqTHJEbDIzUVAwczlzZHdOWFJSdi91QW95VEdQd2dzM0t3SDVjbWdseUNQ?=
 =?utf-8?B?eWFiaHNVeW1YLzl5WDJNbHFNWWhPNFk2WHBNVElVTHFPOGFCWUw1Rjd6aTVS?=
 =?utf-8?B?SWU2NDZvamZxeHdhcXhBZm9TamRiSytNaGdyTjlhUklzNDdTbXdRZXdsUjI3?=
 =?utf-8?B?ZkJyV3RmeU1OelhsTHIxNFIvQjNOMFFDSlBDVDZFSGlNVGJURkROZTJYbFpk?=
 =?utf-8?B?SHVFSHRBZm1kSFQ4cmlvdFV2NTFlclVmOWpsTjF2OGRnRG16cmhHakNJcmx6?=
 =?utf-8?B?RkRqOFVYWE1OaERuZ1BYMGNnblVJd0U0TEV0VkU2akEvNWl5bEVyck0zQmdh?=
 =?utf-8?B?dEMyQzJwTmpkSFBEVmVFU1NRdnhOWmRwMXJiUFF6aXBNWmNnYXNsSmx6SFlS?=
 =?utf-8?B?aHRST2REbUZFd2V1RG5acSs4WGFHV2xteTB0OStUbmk2U0ZsZVZMWUtuK1Bw?=
 =?utf-8?B?Y1RHd0NuVFFHSVRuQ3NxUWNTWFYraE1iUjZBRE5LOEp4STFhS3hvc3d0bFho?=
 =?utf-8?B?dnFYV1NUU3pZUjdIRmE1Nmp5YW1lZStBL24rQmNYZEMrMGVVVDRUZWMwRVdN?=
 =?utf-8?B?cURGUEp6T1NjVmtjWUJkSWt3a0tCaXdDREdRN0pnK01QWmZGKzhrYllMYXh5?=
 =?utf-8?B?Y3Rra3RaRXk4Y3JHcjZuTFNVSElIUTFWVHYycGlNTkRVS0VLK3JNa0M4Y0Nn?=
 =?utf-8?B?U3N6QnFQSEpQUGdvNExCQmg0L3FxY1ZOa05tNVJPQnE3cXV5OVNNUFhLNHVo?=
 =?utf-8?B?UytMSnB2anlLMURLTi9VSlVYZk1ndFpJcW1Id0hIQ2Z3NXU0L1lYS09rVXhG?=
 =?utf-8?B?ZE50eUJTMzVaZmRRWjRkVTJ1bmNIRkhMT3gwQ0o2bzdIR3cwWXRIYkVBcWpn?=
 =?utf-8?B?UFFqMXRHUTRkaDdUSzNqOU1WN2laRkpEZ0ZyUnJYSHNhdHNsb2VKV1ZjMHBR?=
 =?utf-8?B?V0NjNS81b2hLd2RvRE1SRFNOOG9tWWdvY3RkVWxjeGZZWmJSbGFCcXdJaWlZ?=
 =?utf-8?B?R3V0alkyWXlxWnd3VFp0VDJzUVV2cmlDUWhYeFphSmpTNHduWW5LMDFnSjRP?=
 =?utf-8?B?YmhZTTNBS2JEYis1Z3ZTeVhLSlpBYklLUHRUMGJ4eVd2Vnk3Rjk3d29HWjNF?=
 =?utf-8?B?dE1aK215cTB3TFE2Ynk5TW56TitpVk1hQ1BSek1OUjdoVXpxY3MyTzR2OC8y?=
 =?utf-8?B?YzRTNVdWLzJUSzZrN3J0aFFrRzIvTnk4Z0Y1dHZZQVlkbG1BN2FId3F4d2pO?=
 =?utf-8?B?dVpzRUxOVjJiM3krM2Z4bjFPT252d05iV25iamZVdVJibS9aOWY5UjRlNVFK?=
 =?utf-8?B?dHhid0VnNmVxdTZpekxvQ3BmTlRYYk9RdzdxNU1xMGc0bVIxWVVxeXVsQlBx?=
 =?utf-8?B?bzFHZGErNHBJelcrV0o5eGpjUk5hNWZNWXJ1RUc3RzI0MC9KTGhzQ1RPMS9k?=
 =?utf-8?B?THNmeEtpY2U3bURGSkR6ZlBEQU44OEhld1B1eXpiY3d5dWIwRVJReVVsdEZC?=
 =?utf-8?B?RnIxVWxWaVZ6WGw1amVNSk4wR08yU2RmNlZ0QXl0ZTBXdHVsUzZ4UTdQWUVl?=
 =?utf-8?B?RVo5Q3J1NHpYWmhCT204RDN1US9sVGhWdnhwZjNVS1JubjFZOVl3VURPNVBJ?=
 =?utf-8?B?YkJIbVl3MW4zZGhCWlhkdW1HRWZoSTF0eVA4Z1VvbStwd1F5cjBVQTB2RXUz?=
 =?utf-8?B?VnY1VkxvN2M0VE1BbkZETnN2dWdyVTNqSWQxblg4eDlFMVhoWWJ6NGFpK0Z5?=
 =?utf-8?Q?LNC6+DFVlS7q9eE5Z2?=
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
X-Exchange-RoutingPolicyChecked: FAS1jvRrp+wYgin+cAhvQYrmBmBamg58oz3iUhksFmm8CIgZaQ1mZmIqs3T3P4UTCfObZog3c46zRHpwzDXxbworGMLwl+MDgvlL+TcJEn1SNCnuVUF3FKkCDdWPLki3WJ8kbpgoxZmDfC/hvb8p90kG2jWIoFEOB9/T93BOwbVcPl7znghZ4+d5bdUGepKyB7hwsxq+JK1BYSPsIH+votxvQrGHM+lphYwtvDl8qq09XLdZDxJ5hOu6ALZ1LzisCFQdg7KEOnt61Z4wzoJhOun7kVJCQ7X066zIgFZ4Mkq/uj16ziXjO0mBvadAuvm6VjmMjrbYjzI7nj0v4OoLPA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR11MB619106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba54503-1248-42af-0164-08df3f51e9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 17:41:55.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: plR33vn2jyHrq6vZs2VSmPzz02q9SWeMiW603660BmppfwO8gB9Rpik6p8y1cyYVZNtTS7IaORiuWrerd/j4Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com

SSBjaGVja2VkIGluY2x1ZGUvZHJtL2ludGVsL3hlX3BjaWlkcy5oIGluIExpbnV4IDYuMTIuIFRo
ZSBoaWdoZXN0IFhlIGdlbmVyYXRpb24gZGVmaW5lZCB0aGVyZSBpcyBYZTIsIHRoZSBwYXRjaCBp
cyBmb3IgWGUzLCBzbyB0aGUgcGF0Y2ggaXMgbm90IG5lZWRlZC4NCg0KVGhhbmtzLA0KSmlhDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FzaGEgTGV2aW4gPHNhc2hh
bEBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgTm92ZW1iZXIgNywgMjAyNiAyOjE2IEFN
DQo+IFRvOiBZYW8sIEppYSA8amlhLnlhb0BpbnRlbC5jb20+OyBNdW4sIEd3YW4tZ3llb25nIDxn
d2FuLQ0KPiBneWVvbmcubXVuQGludGVsLmNvbT47IEF1bGQsIE1hdHRoZXcgPG1hdHRoZXcuYXVs
ZEBpbnRlbC5jb20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IEZB
SUxFRDogcGF0Y2ggIltQQVRDSF0gZHJtL3hlL2d1Y19hZHM6IHVzZSB1bmNhY2hlZCBtYXBwaW5n
IGZvcg0KPiBVTSBxdWV1ZSBCTyIgZmFpbGVkIHRvIGFwcGx5IHRvIDYuMTItc3RhYmxlIHRyZWUN
Cj4gDQo+IFRoZSBwYXRjaCBiZWxvdyBkb2VzIG5vdCBhcHBseSB0byB0aGUgNi4xMi1zdGFibGUg
dHJlZS4NCj4gSWYgc29tZW9uZSB3YW50cyBpdCBhcHBsaWVkIHRoZXJlLCBvciB0byBhbnkgb3Ro
ZXIgc3RhYmxlIG9yIGxvbmd0ZXJtIHRyZWUsDQo+IHRoZW4gcGxlYXNlIGVtYWlsIHRoZSBiYWNr
cG9ydCwgaW5jbHVkaW5nIHRoZSBvcmlnaW5hbCBnaXQgY29tbWl0IGlkIHRvDQo+IDxzdGFibGVA
dmdlci5rZXJuZWwub3JnPi4NCj4gDQo+IFRvIHJlcHJvZHVjZSB0aGUgY29uZmxpY3QgYW5kIHJl
c3VibWl0LCB5b3UgbWF5IHVzZSB0aGUgZm9sbG93aW5nIGNvbW1hbmRzOg0KPiANCj4gZ2l0IGZl
dGNoIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJs
ZS9saW51eC5naXQvDQo+IGxpbnV4LTYuMTIueSBnaXQgY2hlY2tvdXQgRkVUQ0hfSEVBRCBnaXQg
Y2hlcnJ5LXBpY2sgLXgNCj4gOWRhYTMwMmE4MjU5MGVlZWU3YmRjNjgwMjNkZGFkMzAyZGY0Yjg4
Yw0KPiAjIDxyZXNvbHZlIGNvbmZsaWN0cywgYnVpbGQsIHRlc3QsIGV0Yy4+IGdpdCBjb21taXQg
LXMgZ2l0IHNlbmQtZW1haWwgLS10bw0KPiAnPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+JyAtLWlu
LXJlcGx5LXRvICcyMDI2MTEwNzA1MTYxOS1mYWlsZWQtNi4xMi0NCj4gOWRhYTMwMmE4MjU5QGtl
cm5lbC5vcmcnIC0tc3ViamVjdC1wcmVmaXggJ1BBVENIIDYuMTIueScgJ0hFQUReLi4nDQo+IA0K
PiBUaGFua3MsDQo+IFNhc2hhDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0gb3JpZ2luYWwgY29t
bWl0IGluIExpbnVzJ3MgdHJlZSAtLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IEZyb20gOWRhYTMw
MmE4MjU5MGVlZWU3YmRjNjgwMjNkZGFkMzAyZGY0Yjg4YyBNb24gU2VwIDE3DQo+IDAwOjAwOjAw
IDIwMDENCj4gRnJvbTogSmlhIFlhbyA8amlhLnlhb0BpbnRlbC5jb20+DQo+IERhdGU6IFR1ZSwg
NCBBdWcgMjAyNiAxNjo1MDo1NyArMDAwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIGRybS94ZS9ndWNf
YWRzOiB1c2UgdW5jYWNoZWQgbWFwcGluZyBmb3IgVU0gcXVldWUgQk8NCj4gDQo+IE9uIFByZS1Y
ZTNwIHBsYXRmb3JtLCB0aGUgR0FNIHdyaXRlIHRoZSBVTSBxdWV1ZSB0aHJvdWdoIERQQSB1c2lu
ZyBVQy4NCj4gaWYgR3VDIHJlYWRzIHRoZSBxdWV1ZSB2aWEgR0dUVCAoV0IpLCBzdGFsZSBkYXRh
IG1heSBiZSBvYnNlcnZlZCB3aGVuIHRoZQ0KPiBjYWNoZWxpbmUgaGFzIGJlZW4gcG9sbHV0ZWQg
YnkgYW5vdGhlciBhZ2VudC4NCj4gDQo+IFRvIG1hdGNoIHRoZSBHQU0ncyBVQyB3cml0ZXMsIGNv
bmZpZ3VyZSB0aGUgR3VDIG1hcHBpbmcgYXMgVUMgYXMgd2VsbC4NCj4gDQo+IEZpeGVzOiA5YzU3
YmMwODY1MmEgKCJkcm0veGUvbG5sOiBEcm9wIGZvcmNlX3Byb2JlIHJlcXVpcmVtZW50IikNCj4g
Q2M6IEd3YW4tZ3llb25nIE11biA8Z3dhbi1neWVvbmcubXVuQGludGVsLmNvbT4NCj4gQ2M6IE1h
dHRoZXcgQXVsZCA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NCj4gQ2M6IDxzdGFibGVAdmdlci5r
ZXJuZWwub3JnPiAjIHY2LjEyKw0KPiBTaWduZWQtb2ZmLWJ5OiBKaWEgWWFvIDxqaWEueWFvQGlu
dGVsLmNvbT4gUmV2aWV3ZWQgYnk6IE1hdHRoZXcgQXVsZA0KPiA8bWF0dGhldy5hdWxkQGludGVs
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBBdWxkIDxtYXR0aGV3LmF1bGRAaW50ZWwu
Y29tPg0KPiBMaW5rOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjA4MDQxNjUwNTcuMTI5
NTI5LTQtDQo+IGppYS55YW9AaW50ZWwuY29tDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3hl
L3hlX2d1Y19hZHMuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3hlL3hl
X2d1Y19hZHMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS94ZS94ZV9ndWNfYWRzLmMgaW5kZXggNzc0
MjlmZjRkMmE5YS4uZmY4ZWVlMzgzMWFhMg0KPiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3hlL3hlX2d1Y19hZHMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGUveGVfZ3VjX2Fk
cy5jDQo+IEBAIC00NTgsNyArNDU4LDggQEAgaW50IHhlX2d1Y19hZHNfaW5pdChzdHJ1Y3QgeGVf
Z3VjX2FkcyAqYWRzKQ0KPiAgCQl1MzIgdW1fZmxhZ3MgPSBYRV9CT19GTEFHX1ZSQU1fSUZfREdG
WCh0aWxlKSB8DQo+ICAJCQkgICAgICAgWEVfQk9fRkxBR19HR1RUIHwNCj4gIAkJCSAgICAgICBY
RV9CT19GTEFHX0dHVFRfSU5WQUxJREFURSB8DQo+IC0JCQkgICAgICAgWEVfQk9fRkxBR19QSU5O
RURfTk9SRVNUT1JFOw0KPiArCQkJICAgICAgIFhFX0JPX0ZMQUdfUElOTkVEX05PUkVTVE9SRSB8
DQo+ICsJCQkgICAgICAgWEVfQk9fRkxBR19ORUVEU19VQzsNCj4gDQo+ICAJCWJvID0geGVfbWFu
YWdlZF9ib19jcmVhdGVfcGluX21hcCh4ZSwgdGlsZSwgdW1fc2l6ZSwNCj4gdW1fZmxhZ3MpOw0K
PiAgCQlpZiAoSVNfRVJSKGJvKSkNCj4gLS0NCj4gMi41My4wDQo+IA0KPiANCj4gDQoNCg==
