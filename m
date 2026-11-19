Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120854;
	b=SaQiU+nszphHqlS98pvWPYTGk/xVBb3w0ql89Dp/dGxzBXgQEoLHNZe14tmS1i6BO/R5
	 djkQoUkVz55RnsYOoCkPwIS1SWiBMGAamKpZ+MOhjBJsiZmfOoluhcsHLQyrOkA9KbmIz
	 pIph1IWVKgDLNjyuMeA8maZxaWVnIfU9UHflUAXyy6SBDD9nadkMvjeGsBDpCn0WX//92
	 IuORGUhzoUyQ902n77h6trR1HXBE7lWXqBCtB2lCmEYCvJSQR80FbwWyIF/PL54s8iSzP
	 RTR+V1L/+riPyQ3k6C2/Gwjfx1rSAhTHAoKJQ/vp+1ROW28gm9Q+qXzUUP+PETyQ0MA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120854;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=eX/xzoa4y7JeAgJc3+QLzXwEm/kqLcsaDykE/9OKGl8=;
	b=CdCBI4qUohDAxoiURXNLg8GS3xuZg4yafNKfCAmZ/YtpFpA4GO/r6fnY3kLbg6b67+61
	 ozqT1IwG4T/K5Gmk7g8t6+27eDOvlAQohfphyzLPSqw8RNF5Qp1gUjVUj9n9uBCN/7GEF
	 +Zwxxf++hcKGkx293Vy7XU8Ob52fWdFgUUm2k4a0L+rQes2ZA5C0Kz7EHDOQ67Tt6eNq7
	 U1pny6CTmTJwto17hOKhYqE3YfJgnBmUOmuU0RaOoS1ZpWM379qXNkkdOOW5lD21pvXap
	 jahKa7Qircatj1qWKOEDoatfv38ZVF8iwhFBwU8eXZHd+KhBfRsRRB4PE3T4e6x2mww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g6FyMhW+;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=UjhJeFxa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812B606A93B;
	Thu, 19 Nov 2026 20:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1812B606A93B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g6FyMhW+;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=UjhJeFxa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795120853; x=1826656853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eX/xzoa4y7JeAgJc3+QLzXwEm/kqLcsaDykE/9OKGl8=;
  b=g6FyMhW+CG34444y1B9GLPAAmPT1OLfEhEbaTmnr9TJe/s9pkFcvR109
   r6GhUg/L5I90eLcpxXkRpzWgdJ2OsLDqjJdrDKUOTQrq7sooNuY0h408t
   7C4PAxiWknAvppFc8oS2vpUT5fbSSLzlUBhv5jQEFf/nlqfP1hLxQ3sEJ
   biTiw6R7s9O7DLKrqKNL9DA8lmWF1xnqSZe3WPj3C91PJVIpmUx90ovjL
   Z1x3iu7lESSmFEh2wWIS91j5HHb5J8ckO7cpt8TfSETby39OkFvZiWAEX
   zfBXchsBQ3snD3SB+EzfKDXSJ4LvPQ07mihydrtODYDDDa74O2laxDMMc
   A==;
X-CSE-ConnectionGUID: j96HPSAPRNCoI5oQHIcCZA==
X-CSE-MsgGUID: ViUxeOpcTE2pJhGxSvCdFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3877032"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3877032"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 12:40:52 -0800
X-CSE-ConnectionGUID: NjiyuN5pQHmGkbcVzlb0fw==
X-CSE-MsgGUID: Oy6i4C2BRBemQuxUXiLr2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12240167"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 12:40:52 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 12:40:51 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 12:40:51 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.18) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 12:40:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVWQ3yYKgP44xvfmmpFQcaT2nZaScIz0TSLryfEhBtScZKlAGajZqRZfV1I4AzTCXYdaLZyH8XHvAuDqYsJOTqf9uu/RXMTnXD1uB5aV2TGlAulGYl7d/4GaI+cpgJbFLY3G+lbpYKpabNnMmcGln/8wyJokiQnl5gv2WZ3dKhTzi70FcWGzXdw5NXjft1GwbQo13nlQGrPD0PqtzIWtO7W2JK8n04NQ9+4jmPQKLr7lL9c65zNlnFdHuQaefsyMAkh4O4GjoPH+UtK6+LCEJkpV2PCgUSOneysB3DouQNbDy9HNgX0IUYxq2smY6ueSPQqDLroVm44V64nHnbPaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX/xzoa4y7JeAgJc3+QLzXwEm/kqLcsaDykE/9OKGl8=;
 b=JmLJ3W3ivwqPCMSoVCwum5mOXo/2H3ckbxdFuOPZYyD8+UfyEwXw7R4Qw9elrV3t6PqCUZ1rJgITUgryfGEVOk8MdDvCWmnsdTy0HN+Y8PFIswB2JSJtPb1oZ7gyCDg+fo5tt6TAsKLIM0uN9r61RbhOiuPJqnDu4LM0nweEB/1T/OLJlL1BHO70FtdBe/C1eqEAqfJ8jv0aJMdjZxwSxolhs9PLxbWEznPKD4OdEJzSnYtLj1n4m8bzfBxKa7CFuI0083/BLK0a4L/h7fK2tBAXa/Jbpy8KfS0m7LUIzSYcSwJ/VjVq08jKUkZm0YT2XUeTHlFRAhazRcwSW+Gv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX/xzoa4y7JeAgJc3+QLzXwEm/kqLcsaDykE/9OKGl8=;
 b=UjhJeFxafDFrLSJE9aCSeWL1TY/v2epujmQIEUOdSm7l+vHolemRotcqAbZgLY8ZnS4/hjPDBuScWT0cIYJLSSsKms2mrcUNw7Edkc8gilhBEdiiyxEQ9NtG+bgzSy3oj38H3yhSK5nFlOctdm0OKJbVvc1msxDB07AY4mAeUnA=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DSSPR11MB9618.namprd11.prod.outlook.com
 (2603:10b6:8:375::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 20:40:49 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 20:40:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "jgg@nvidia.com" <jgg@nvidia.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "ljs@kernel.org" <ljs@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "david@kernel.org" <david@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "kernel-team@meta.com"
	<kernel-team@meta.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "gourry@gourry.net" <gourry@gourry.net>
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
Thread-Topic: [PATCH] mm/hmm: reject shadow-stack mappings
Thread-Index: AQHdeGZBH1l7ImqEJ0KOHtCVGoraMQ==
Date: Thu, 19 Nov 2026 20:40:48 +0000
Message-ID: <0c6fcb3daeab0ab3df0593cf389124e38e1d7f3f.camel@intel.com>
References: <20261113195536.2660763-1-gourry@gourry.net>
	 <20261113200303.GA395967@nvidia.com>
	 <179460249376.482102.14669935557901467762.b4-reply@b4>
	 <20261114002027.GE3706007@nvidia.com>
	 <20261113181025.6e8b9475b29c13d29f59e02e@linux-foundation.org>
	 <20261115000005.GG3706007@nvidia.com>
	 <20261114170127.3d29199864eb352d9045eaba@linux-foundation.org>
	 <55034934-8aab-4e8a-a74a-b30c977670ed@intel.com>
In-Reply-To: <55034934-8aab-4e8a-a74a-b30c977670ed@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DSSPR11MB9618:EE_
x-ms-office365-filtering-correlation-id: c8e38b27-2063-4e6b-0b54-08df467d650c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|3023799007|4143699003|11063799006|10067099003|261022075727099003|261026121527099003|56012099006|261021121427099003|261009223027099003|261102123227099003|38070700021;
x-microsoft-antispam-message-info: sgwzx6ibgiYRm3Gacchf01dzF5+pWvE1A/PKX+HD2jgtmEgldohYhF6YRD2NngBln8xS42/XwTtYg2m7bUu4iGuQgTMyR0PGlBtgzguFw7Soem2UVKFFs4R6wzjQoJZRUd8z5k3PiTa4RQsu43nSnFPOP7KoiG/O+biRMUthuIcQMYM93ijmQ+KqBxaO0/ddkJGcjLjZAV2vg1tmq4Nr3Pcl70KBKeum5AAxrGXjladE8AEClRNCIrBspjME16ddzqyFvCT7npoNhw0YzpIZKbV/aY6gtJxRawBX41tucwghnE+nJkE+KkZGa1YA+WQvpHflIRRyh6Phh5QhSLbgfMpPj09+7/YROmbajc8J6gHVIGZUdPlh4QVZzPfUF9QnX2Lz0xeMUNh6/4sbuF4jsjaPdoDCqwYw5T6udqwvwpSRGDhuNixlwHEd5saS+BN8UNNTLerjgg3bt03llUodSpbUY8xD3SDUKfLatkovFNUXE74hPi7baeyrNoMgwrJ/UVlKpCNkwoQz+Ld3bjd9OhMxqsXg61Gn7HcQO45UEUYwR/Pi9FEmFM8g3mIglPOuB5NqV4weRBWdIG2II4Thievzc2g1FqLAbX4nJPNxsL6Hu4AlWSGFa564Qx1c0MoKW1K23t0V/5qOMsOl2CQBDtJR8fzX1Y3fn/Gzv+T3iIRHH2MOnmoK1jMkeY4/FP+jQAaTXLWDzlIGRBzIgEI66Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(10067099003)(261022075727099003)(261026121527099003)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE9Pb1E4TnVyYlhkMXZJdDVlMVRGcWlyVHBSb0xJTDRQb2VoRHhZQVNXZlpY?=
 =?utf-8?B?bzVIUWk0TGlBNlR2ang3KzlaODhjRU1KZk9EN1lkczFmRkZ6ajBKN0xjNkR5?=
 =?utf-8?B?RTNNWU9Id3RQTTl1bjRnMWMreVc2eVQ1Vjd4bk16aTBRM1ozRG10eUw0Vk43?=
 =?utf-8?B?S0Q3T3haaEZRcFJzSFBCdTArTkFwTm43WkQzbW5adjJmQW0xSWRQdkpzSG1S?=
 =?utf-8?B?YmV0bm9DZGJxUmNJcTlGeExFQjNLQkhYWGJpOGY1UzRxc0R6ZlRYY3ZoMFR0?=
 =?utf-8?B?VzZOaDFzOHRQM25hWWtiNmRKWUEwVmM3RlpaOHk4aVVOMEduV1Yzdk5xQjYy?=
 =?utf-8?B?NFl4MVVGSGNCa3pkWHgxckIvMVhrSHhlZ3pnUkU2OEV3b1RBbjI4Nm04Zm54?=
 =?utf-8?B?SnBVVkVmZHpKdWlRTEU1TmZPTkVTU2hWNjU3azVubDdXVENqZi9HRFBITkl5?=
 =?utf-8?B?VVlQQzJTQUlEZnB6N0Y0eGJQem01RXMxNUR5aE10VklnaXVEcTA3eTVLRTVr?=
 =?utf-8?B?L2JCT05FaFQwK0FyTyszNGlnUWdtekNFSmhHRHNyNzdvRXJ3ZnFKTDB2dkZy?=
 =?utf-8?B?NFgwKzZQZnlYa2RlMUx2STBQN0VMT3dTdTBJTngrUDZqT3dJSXd6cm1tbUxK?=
 =?utf-8?B?QlRjV1orcGllRHI0YU5LREtoYXVlV0RaMml4NFVmcEhrZ2NLcW1lWVBrS0R0?=
 =?utf-8?B?aXlETHZqRkpSV3dlZ0tvRnNSSGgzK2IxNENrbVFFdDJsWXF5bSsxaER2V0th?=
 =?utf-8?B?Q2xRNmhwSGJ3eFozN24zRnlEak9xV1pIN2VweDBkMWhKc0t4b2cvcjY0ZWZL?=
 =?utf-8?B?d2Vta3NDYWNFOGRrNGtUcXgrZjJ5clFOS1VRR2dZRkdQUlpTUFJvTDJGTWNO?=
 =?utf-8?B?SW5xOWtDc1Z6WVUwRUd2WWh1QTNQZHpIdEhwNlJsdU1rTmRtZDBjVmlSTFIz?=
 =?utf-8?B?TnVzeFFLbnkyTU1vUVpnR0xDaFUvZDgzTE11N2JONGw4QmdTS0lhS1ZsSjcr?=
 =?utf-8?B?ei9HSnVGdTZ0VWpBdEpYYjFsanFPN00zaHA2NjlzcXNoblFEZEZlNGxZOHNQ?=
 =?utf-8?B?Nmh2UnhwUmo3M1pOY3JReVZjeUxiNHNIZ0dvZDNOY2VFMmtkcVpSaVE0TDl5?=
 =?utf-8?B?S3BsL3FGaWo3N1hBZ3VnMWhhazdmbmlwOEY1SXFWQVdsWi8vQjNUYTU2Qjdm?=
 =?utf-8?B?QTFNZG4wRjJHaE9IbE5HMG1zc1o1bDh0RXplVUtXamhjcHRmdERzVE90aks1?=
 =?utf-8?B?Y3Z6Q05Xamczcm1PV1lGTUFtNWl1L05MWDNEaTAySzVCTGxkTlR2ajJIZ0hK?=
 =?utf-8?B?MjhvaExPZTBmRHRmTkMzZzlVQUhuSWNucGVUUlVsSXdVekkwMURDeFk3Rkhl?=
 =?utf-8?B?aWNmeUdQcVJMeHlqbGp0UFg0ZXB2NjNwdUlEMkNEOW9ub3h0QisxcVRmY3I5?=
 =?utf-8?B?ckZidUcyeTFkb2JTdW95R2hncUkrcXFqTHYrS1RVMFgvME5jYmJDcnQ4aWxk?=
 =?utf-8?B?b2hqamxxODhzOTU0dFZzdWo3Yjh1MGhyUHVXZGs3L21KTDlMR1N5ejlQbXNq?=
 =?utf-8?B?dmxnZjc2M0kxaFhwblNFYUhicnVGNEdQTUc3WnFvdFV4SjJBY3RQQWFma0NL?=
 =?utf-8?B?ZmdEbHRibjJhblFEeHNMN0Zha1JBaUtBZGU3NHhQZmxWaDMrUithZmhVcmZK?=
 =?utf-8?B?L1dJWnJ2bzB0aUNxdFdCaytOWFhnUWNocDRmeXhGbTRHWVd0azk2T3RBcUhK?=
 =?utf-8?B?UXdTQnFzT2RORE9GWHh5VUVEcGpZdjN1ZTJ2TlRFY2VpTHRyS3VubSs2YWRL?=
 =?utf-8?B?d2l5Y1V5WndKdGVLV3kvRS9ydEIvdkpPMTU3SUhTNHdJOWUzMkd0ZmZLNVEx?=
 =?utf-8?B?aE9iVVF2S1RlYWlHTVlnV3VQdit1bjNxWElwc1ZyVTBGV2EvWWhkaWJxMWdM?=
 =?utf-8?B?Zzh2L0w1Z0cwUVRqNXZOdktrNUk4d0NYVjk5SGYwNEZNQ3BFeUo3eVlyMFVK?=
 =?utf-8?B?ZnpWVzJmZTN4NXVuWFNVS0pvOEZocnF5eXptWE02Q29CUU1pS3hZaGtGTHlh?=
 =?utf-8?B?VG1jRTV1NVdwYmtCa3U2NVlGWW9kZzhwMXB0azlmZmFMekJBVDkwMjRTN1cz?=
 =?utf-8?B?b3B4c1VUTDZnQXZZUU9rMUtUZ001T2wzSVJHZW9vUys4NXY5bU1FYUhjVWM3?=
 =?utf-8?B?NGU2QzU0RWdyakZpellSSW14SGZoRE8zYmpJYkRCOHNYSWdLanBHcFBwK0Zx?=
 =?utf-8?B?ZktIc3d3by93aktlMEVpRCtBSlFySjk0a0d6QnFiTEt3RG10c3kyd2grZ1Ri?=
 =?utf-8?B?Ulh3TUVNWU44MTUwMjEyTkU0Q0JSZ244d0s1THowZE5pSTJ2SjdSc0ZQeFFn?=
 =?utf-8?Q?+7uZ/0L49vszBiAg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1333F367832D3342832C6E54E19CE913@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: XZPfRCzQStqlvQxbq1VvLGYcFWKOkIQlwpa4yT+6DACMnzoBf6RbaBbvJDbHd55KEiWOuaySqLIe6yyiFfA9P25DS3GTuNVZZjEOrOQv4Eilb1sbwG4KE4m70egbDNkD4/EQjhDoJBPXV7703doBu1WefQgtC0GDImNvUWxeOAuL2iIgTPE0n72feHF/yMGKVK5NCGn9EMU3zjlTYnooNncNo0jyfcCgTSeSBoDpJJXXAInqSlOM4gOe4icG7EMr1Hc9CePCt0t9L44yNFN2fqJXypgwHIP2UAfbpDhimwdmIjy3dUdZp2+dbFDZi7V+/WO/jzNaNfHOlQsyec01Jg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e38b27-2063-4e6b-0b54-08df467d650c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 20:40:48.9528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWSuPuUPFpKrILTdvU2asb7UTa4knRZFrSdH0ZtWnQU+vZV21d9Pn3SdvIoMYj5+m2/ycEdHwAYR291n1hNi/b4dVqn1MHefS9CwfWOeQ4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9618
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTExLTE5IGF0IDEyOjA1IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMTEvMTQvMjYgMTc6MDEsIEFuZHJldyBNb3J0b24gd3JvdGU6DQo+ID4gT24geDg2LCBhIHNo
YWRvdy1zdGFjayBQVEUgaGFzIGl0cyBvcmRpbmFyeSB3cml0ZSBiaXQgY2xlYXIuwqAgVGhlIENQ
VQ0KPiA+IHJlamVjdHMgb3JkaW5hcnkgc3RvcmVzLCBidXQgcHRlX3dyaXRlKCkgcmVwb3J0cyBp
dCB3cml0YWJsZSBiZWNhdXNlDQo+ID4gc2hhZG93LXN0YWNrIGluc3RydWN0aW9ucyBjYW4gd3Jp
dGUgaXQuwqAgSE1NIGNvbnNlcXVlbnRseSBzZXRzDQo+ID4gSE1NX1BGTl9XUklURS7CoCBOb3V2
ZWF1IHVzZXMgdGhhdCBmbGFnIGZvciBHUFUgd3JpdGUgcGVybWlzc2lvbiwgYW5kDQo+ID4gUkRN
QSBvbi1kZW1hbmQgcGFnaW5nIGNhbiB1c2UgaXQgdG8gZ3JhbnQgZGV2aWNlIHdyaXRlIHBlcm1p
c3Npb24gdG8gYQ0KPiA+IHJlZ2lzdGVyZWQgbWVtb3J5IHJlZ2lvbi7CoCBBIGRldmljZSwgb3Ig
YW4gUkRNQSBwZWVyIHdpdGggd3JpdGUgYWNjZXNzDQo+ID4gdG8gdGhhdCByZWdpb24sIGNhbiB0
aGVuIG92ZXJ3cml0ZSB0aGUgcHJvY2VzcydzIHNoYWRvdyBzdGFjaywNCj4gPiBwb3RlbnRpYWxs
eSBjb3JydXB0aW5nIHJldHVybiBhZGRyZXNzZXMgb3IgYnlwYXNzaW5nIHRoYXQgcHJvdGVjdGlv
bi4NCj4gPiANCj4gPiBSZWplY3Qgc2hhZG93LXN0YWNrIFZNQXMgaW4gaG1tX3ZtYV93YWxrX3Rl
c3QoKSwgaW5jbHVkaW5nIHJlYWQgYWNjZXNzLg0KPiA+IEEgcmVxdWVzdGVkIGZhdWx0IHJldHVy
bnMgLUVGQVVMVDsgYSBzbmFwc2hvdCByZWNvcmRzIEhNTV9QRk5fRVJST1IuDQo+IA0KPiBUaGlz
IGlzIGEgZnVuIG9uZS4NCj4gDQo+IEkgYWxtb3N0IHdvbmRlciBpZiB3ZSB3YW50IHRvIGdvIG9u
ZSBzdGVwIGZ1cnRoZXIgYW5kIGRpc2FsbG93IEdVUHMgd2l0aA0KPiBGT0xMX1dSSVRFIG9uIHRo
ZXNlIFBURXMuIFRoZXJlIHNob3VsZCBiZSBwcmVjaW91cyBmZXcgcmVhc29ucyBmb3INCj4gZGV2
aWNlcyB0byBiZSB3cml0aW5nIHRvIHNoYWRvdyBzdGFjayBwYWdlcy4NCj4gDQo+IElzbid0IHRo
aXMgYSBiaWdnZXIgaXNzdWUgdGhhbiBITU0/IFNob3VsZCB0aGUgZml4IGJlIGluIEhNTT8NCg0K
V2UgZG8gcmVqZWN0IEdVUHMgdG8gc2hhZG93IHN0YWNrIFBURXMgd2l0aCBGT0xMX1dSSVRFLCB1
bmxlc3MgRk9MTF9GT1JDRSBpcw0KcGFzc2VkLiBUaGUgdHJpY2t5IHRoaW5nIGFzIG1lbnRpb25l
ZCBteSBvdGhlcnMgaW4gdGhpcyB0aHJlYWQgaXMgdGhhdCBzaGFkb3cNCnN0YWNrIG1lbW9yeSAq
aXMqIHdyaXRhYmxlIGJ5IHVzZXJzcGFjZS4gQnV0IGFsc28gdGhlIGtlcm5lbCBzaG91bGQgbm90
IHRyZWF0IGl0DQphcyBzdWNoDQoNCkEgZmFsc2UgbmVnYXRpdmUgZm9yIHB0ZV93cml0ZSgpIGlz
IGRhbmdlcm91cyB3aGVuIHRoZSBrZXJuZWwgbmVlZHMgdG8gZGVjaWRlDQp3aGVuIHRvIHJldm9r
ZSBhY2Nlc3MuIChpLmUuIGZvcmspIEkgdGhpbmsgYSBtaXN0YWtlIHRoZXJlIGlzIHNvbWV3aGF0
IHdvcnNlDQp0aGVuIG1pc3NpbmcgYW4gZXhvdGljIHdheSB0byBjYWpvbGUgdGhlIGtlcm5lbCBp
bnRvIHdyaXRpbmcgdG8gYSB1c2VyJ3Mgc2hhZG93DQpzdGFjayBsaWtlIHRoaXMuIFNvIEkgdGhp
bmsgcHRlX3dyaXRlKCkgYmVpbmcgdHJ1ZSBmb3Igc2hhZG93IHN0YWNrcyBpcyB0aGUNCmNvcnJl
Y3QgaW1wbGVtZW50YXRpb24uDQoNCkJ1dCwgbWF5YmUgdGhlIHByb2JsZW0gaXMgdGhhdCBwdGVf
d3JpdGUoKSBpcyBkb2luZyB0aGUgam9iIG9mIHR3byBzZXBhcmF0ZQ0KY29uY2VwdHMuIFdoYXQg
aWYgdGhlcmUgd2FzIGEgcHRlX3VzZXJzcGFjZV9jb3VsZF93cml0ZSgpIGFuZCBhDQpwdGVfa2Vy
bmVsX3Nob3VsZF9ub3Rfd3JpdGUoKT8gTmFtZXMgd291bGQgbmVlZCBzb21lIHdvcmsuLi4NCg==
