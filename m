Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D17CA6F;
	Wed,  1 Jul 2026 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864406; cv=fail; b=RLuafA1rVIYyEX56dMAqZOeMxnpfQDOg6aIIvKsrQjxkW2VCLuW8LoJZp8rKWLrwFCzTYsRrqhyPzQ3CAYGUoNSjQRNoSyC3vWxqdKveJO5ISz+7mB3+yO2/dBpJ23qaoCIRKhVnHGrDslSZa6Qh17lgWaba97XlT/3zjoyMi58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864406; c=relaxed/simple;
	bh=FKefEl1oj+AeMApvJGGdUF+kropMznJGof24Q9X/v84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i2dv2WkA+gYL2cpksBo7aWjT5rsNFgDb/pjFnp1wIhf+Ecd2c9+9jsK0UC521XitBJLQogaG16BS7qOrEnxaAUi70izhGVtosYncStyj09/6GZpdzdHv4QFSEOpW302d+riiqerPbcunEO/KZM0o+W2wgJymB7ajesus6tIdJtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FB5b0BR8; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FB5b0BR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782864405; x=1814400405;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FKefEl1oj+AeMApvJGGdUF+kropMznJGof24Q9X/v84=;
  b=FB5b0BR8ltPuArt61xLAt4hl6mlzM/E397dlw4md4ctuNKXbEMVCpgLi
   3QnKOiuQdTgk4nikmNu/llbJk5evcJkHg4YsZ08pZZk1zbuff5VOrdL2E
   QA0JY8ehLhY/leloV90E+rGaqYe+g/dBOQMa03max+oL6MMSvTJhePYyl
   x0ecH3Ttv7lPizhnHIXEaVfw7b3x2/zC2OTUk+hsJepS3TkJBqOi7vDaT
   1SkeA5O7eTcvVUzzX2DXk5FhdtTf1UUA04Q5lisBDch0qHs/8Uyd3I8+O
   JJe4in+TYl1aLyc3wvigLUAnoxl2Lo2lTmux3YESYPcmx1m/0wS/adD+P
   w==;
X-CSE-ConnectionGUID: 8zIuM6hGT7uPRBAHJ5qgyw==
X-CSE-MsgGUID: UZ+Wbub4RlmunaQ/pHxFFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="101016368"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="101016368"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:06:45 -0700
X-CSE-ConnectionGUID: aOSyk9rOQ3Gj2ido4Jdx0A==
X-CSE-MsgGUID: Whht7j9lRseSZs5pZ+pPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="282473004"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:06:45 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:06:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 17:06:44 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:06:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PT4b32eyPBP0t9XxT19diSI6dqs6ieqxfofFfvjhuabIdGEP6tOjL5rDRFYYLG14vLEWkUoviX2t16DgF8jR9AXz1k28PPgR1I+nbY+QMhA74Kd+SFi8Qk94F+h14EDLPOR7qN33O9sUBjGSccLTrw63RvQlsCSJ0MwAAGEm4/x5jvx4pU35zqt989q2FCdytvBDl72eOAVVl3HMMgRCaPxQOXMj3KUMYa+aQxI2QYJ7+XR+n8ls6AFGRDBzw0awgF72y/lZt4pjYwU8UZefMCm+5js2AstTXpYD3oHvoqM4/DBbBzaCmMFvcyEjpVg8C2xUsy4u099q+rPJwQPDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKefEl1oj+AeMApvJGGdUF+kropMznJGof24Q9X/v84=;
 b=Wv7HfM0/Dcia7OQ8DDUcRwZtQGT2pMj55l0sbITRX3TFjqQUfhsvJGjMsBu8KyRtWaZ5g03HH3rSutx4LdbBpxXEjnBFb/cLSUmqyKguZeRbYEpfrXXWJBzK8yNf9tEB3XNRDUUPIimTEelR7oDzVO76cQkKT0jyKMsI2D4PHUwffVGR1Y9ofCOStktDMIefyfsn4+mLYoYL3UED+xA+egHyGWyrw7kgnvtIKwj0nC3Hk+XaULXIf+0tDE+Ynpz+LbpNWPe0SX5DP5FwSm2YQ5acrOZX51rLyuqz6WrVzK+qqY3kw/L/0/Z485lDqnLMcCArKr5n30NdiaZXHC6HGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by SA1PR11MB7109.namprd11.prod.outlook.com (2603:10b6:806:2ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 00:06:40 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 00:06:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "mingo@redhat.com" <mingo@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "david.laight.linux@gmail.com"
	<david.laight.linux@gmail.com>, "Huang, Kai" <kai.huang@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "tsyrulnikov.borys@gmail.com"
	<tsyrulnikov.borys@gmail.com>, "djbw@kernel.org" <djbw@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v4 1/3] x86/tdx: Fix off-by-one in port I/O handling
Thread-Topic: [PATCH v4 1/3] x86/tdx: Fix off-by-one in port I/O handling
Thread-Index: AQHc9DERmjLrmSzB9UedgkR0nb29eLZX8piA
Date: Wed, 1 Jul 2026 00:06:40 +0000
Message-ID: <fe2dc0645051fd20788fc80eac66f8109ddeccdc.camel@intel.com>
References: <cover.1780584300.git.kas@kernel.org>
	 <e5a75bb68a6a778c95cac2ef77acd55cfd24d389.1780584300.git.kas@kernel.org>
In-Reply-To: <e5a75bb68a6a778c95cac2ef77acd55cfd24d389.1780584300.git.kas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|SA1PR11MB7109:EE_
x-ms-office365-filtering-correlation-id: 8f1458ea-a0b0-4dc6-7b6b-08ded704a032
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|38070700021|56012099006|4143699003|22082099003|11063799006|18002099003;
x-microsoft-antispam-message-info: wT0UCAITwD4w2sbwpCGAWQ/rTdHmArqbaEmPdqEhyj/79Xkcxbl7iHgNfL/FAqBmiRi4QQe+AZPX5FqmFy6diqwJ6QWmBdyBtvcay2uOnc/efWCeSOIOTlWnrZGM8dHjYxcbierazs15Jri+31P3GpBW2iR2ot3FEm44PsZM3HkyckOjH1ZWegXwuxImQFLlf8KJwOabXLwdLmucjeGf6uzFDXZFRRJEZ45pooMk4ndEHjv10I0KsId27OwQXAUxZKICWzKzPQobm0slBNh0jdlHkjPfMMQyHXPGfjJ+b9X56s0UnN3ZUn99ipJvEcCsxPxzPrfw7YzcqC+O9gB9licfqV6wh0JidATyGENYt3HDu4q59tz2swXx9MdvEuZfy0nnmsg/JEpUfuGgWBP2Ii8dxteK55KqTvs8a65kS1lr8w9K8BJNPtpuiOOinMkJJC7GdnBNHsIOyWLwlkViP5bF29otJU2jQ8R1HgJuPN2914q0wHrqgacsGUhkDl+vgXAFyuF4Cr7F0ibuqoQfuqIVnenorbKHu7Cj6CIRzLCzUoCr2p13s/aRV9UecFLw6h9T1EbD/4rJcSCoBJ+5HE4j0vJwRzrUlfw0QDu9TBb6GO7B9bFnR6kXeRLJnRRjtW0dpXm4JbEBVSQM89v04L/TfCa98BPCISixvzd9ZWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(38070700021)(56012099006)(4143699003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3VPNTJMOFJaaGtQc0duLzIvdDNhYm9EMlhHR2x2NVkvaTZkMG11a0pRZ3BE?=
 =?utf-8?B?RXNzaFljQzZjbUVpVi9nTGY2YkZBTlpBcnorejdzcktnWTBwQnJqVHRVdU45?=
 =?utf-8?B?amlBQStraGgya1hQNE82dGY0NnRBNFF2S2xlL1FNMkxyWiswWTZwaWo2Vy8r?=
 =?utf-8?B?aHhuVUpCZ3lXR3ZZKysyeFF0bGYvUzc3TjZxSTMzUndaM041K2w5UnNuc3B4?=
 =?utf-8?B?Q293enhNVzhhUlRVd0w5TVgyS1h1V0xBazhMVGRja0NwOExrK1c3L3lhb3h2?=
 =?utf-8?B?WVlGRmllZ0MrY2tPRTYxRnFOaXlCK1U3cVBHSEZmbTVEZWh0Q2hqdkU4ZWph?=
 =?utf-8?B?ekdKVjYzMFNEd3AzakZGbEFleFNQZGQ4U0t3TEdNZWt6V20vZjZrUDVlcXp1?=
 =?utf-8?B?WjVidWdnYW9Xdk1aV0ZoblNLMENCd2ZZWWc0alNjMm9OT1RpT05hc0JJUVo3?=
 =?utf-8?B?RllNNFdZZkdQK3VhUFp2QnBySHVKNzU1alZaak0vdDUrV3Q5a0cyNGtPQ1FB?=
 =?utf-8?B?UitnWlIzcEpBbktDRjA2QzlsclhBVWRhL1NmUTlsOEk1cFd1S084Y29jT2E3?=
 =?utf-8?B?YU1pK1BCSit0c3c1aEJzdGlnOW40TXh3cFIxeGNaZkh2YVQ3dDZvenBTZ3Rs?=
 =?utf-8?B?RzdwbWkzR1paYTVpTVBZWmdtWUJPbEZCM3NDWlpQVVNnZEpPdDRnUTYxNVc5?=
 =?utf-8?B?NisyQkhhR1N5cTA1WE8yWVpUTlJ2cGY1ME5Yb3RlRm9ERlEvdytKYVZnUElE?=
 =?utf-8?B?YWVzZGxzOEhIUno4azByZW1Lb0U3R2FOWDVKUGw3MXF3VTNobTRNb3VJZTZK?=
 =?utf-8?B?SVFCc1lFTHZkRTRjM2Zzemt1NzdLOE1KdHNtRGkzVmwrUENwMXl3WkRRbFpX?=
 =?utf-8?B?QTU5YWkrSjFVUFA0dzVRbkY1d0ZTSXBSMlZpZ0hnZXVGK29nSG0rRzRNYmU3?=
 =?utf-8?B?M3puV3ZYODhmQm1ab2VhdTdKdXZLVkxVL1lXTHk3bzk1cWUzNDlpWXRlVHov?=
 =?utf-8?B?dmQ2NVlpZUEyVzg3Q2toblkyd0Rxa2xPbS91M2lJeEJPRWJTT0Nob1VvUHYv?=
 =?utf-8?B?ZWt5ZWZLK2FlYzFGVTlsOHIrM2xNeFp1YkkvaHZIN0RPclFwUHVVenpoZ2l1?=
 =?utf-8?B?ZWpDaERJNWJkaFdPdlAzRXdCbDh5cEtXMHhoUTBhZkM2V2JMZVFWdlVoNUl0?=
 =?utf-8?B?WittbkcvcHJXMzBtZm9IdGJFUjEzL3F3YkVpd3NCYmtGQ2pOR1lNUkpneE81?=
 =?utf-8?B?YkRabDJCM2tlekxDdERKajhiRHd6QS90Qng3UXByWHI3ajlkTnZrcWtKSnpX?=
 =?utf-8?B?MTZHcVZUOENiZU05SUppRmMrVjdhQWZpWmY4RUpZN3M4ZUx2NEczODdER0sr?=
 =?utf-8?B?eklLVFcrT3kxQWkwMVlac0NMYW9zeWp3QVNnY0Z4WmxmdUtNMVI0em91UllT?=
 =?utf-8?B?bGs1eWx5amJwUTlhNjM2RW1jTk1vMGxhY2xxQi9XeDdjQ1VjWkRBREZIUlhK?=
 =?utf-8?B?amdHT0oyZTNRWEdIQ2l4dURCVkZlQkY4c2xUdnp4Z1J5UTN3c2JXSTV3TEJh?=
 =?utf-8?B?UExKTUtsUnV2QUFEL0VnYXJKMUpPWHIrbXFsZTQxcU5rdFN0UGNhK2pHOCs1?=
 =?utf-8?B?TitDN2l6VDdCY255dW96ZHE1emovRUdaNmM4MmUrY0Z4eGJTb01mMWpDNnVh?=
 =?utf-8?B?Q2FWR2RlRmE0aXVUbE9QeVQ4SEpFQVdyQ0svNGhJN2ZxVnorOFJIL0FxOVRC?=
 =?utf-8?B?eFBxVTlCNXpvUmFya1VaSlo0SGp0YzVVY0M1eEFNTXppZkZzQkFSU2MwcDFT?=
 =?utf-8?B?K3oxbTRCd2cwajFwMUVmYTlZWVhIdlR0aW5xZERQaVhQa0lWdGFiZzI1SS9I?=
 =?utf-8?B?SjFiai9HSkFZbU83VDZ5Z2E2c2tJYkprWWVIM1I5Q0RXZWRXK21EWkVDeVc2?=
 =?utf-8?B?enhPWUY0aEVkT3pleDJpd01rUkhkVjg4d0g1NzAzRnl2QzZvNHR1YWFrRFVy?=
 =?utf-8?B?MENvYWZOSVpPLzd0T1ZCSmhYcHgxdUJ1c0NKU0RIcG90RSt6a2NiRW8zbkQx?=
 =?utf-8?B?M1FTSCtteS9JNkozNURFQlBJZEUxaXNERzFQb0MyVlN1dlZGV3ZDUmxlVmE0?=
 =?utf-8?B?dkxZV1hjZGpEK1U2eEFjRHdoSDRLTG02NThMK1lyaGVjc0dqWElLNVBQMGR3?=
 =?utf-8?B?T1dOQ1B5ZlRFb0QyeW5FQVZoeERkZGhqUktpcjJkV09SNEwrY0FxOWlLVS9a?=
 =?utf-8?B?RE1hNUg2TU1xN0lmV1d0N2JpUFBwSnM3RTJhc0hwQnQ4Q043YmVKbURlZzJW?=
 =?utf-8?B?TGhjYXhXMWZCdnRGZ0tKWXo5Ti9tNjRqeTRhaEpyOHpoQktmcHk1TXJQSi9L?=
 =?utf-8?Q?IMdD///2BCfjLjS4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2852059A94815F4EA4F4670FA6B9107A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QGSpb32txeUEQBpwPagfufAa+vDQjKvsuASxdxN21jFgItGvUqrqjpN5oDSf6qb2YhzplBwTQ3Rp4AfACmhZtVKStzT/tEQ6DXPtt5W/VO6u/6FfSobFQNgzP88Q+XMMi+r4VkutOo0Ya1ddHfscjy4wwzX0O/InrdC+W+qiSbbM6FweydLymHknksbcUmQyV+n5WZqkysYLi3oSur9ppDZT0ARqzaOntSKLTMvyWFS0wlUNkOnaoI3lTY6UvjAFYUZagCAVFsS65oIhJDiB+pFPuVYif9JlyhpUo7ekf6RAc+wms4jTk32pOLaChV7JLrsw3773rDKNzE5GTFJ+tw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1458ea-a0b0-4dc6-7b6b-08ded704a032
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 00:06:40.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3G7YEEdMUmgnxHWhrOhPZv7lXNWfDxUrSNbitsjg86qLs005VLaOvaiIL+oapz+G+lXhh8KiVIf3QG5k5yyojkOLJSDe1iT4Sj17M8Qb9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7109
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTA0IGF0IDE1OjQ2ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgKE1ldGEp
IHdyb3RlOg0KPiBoYW5kbGVfaW4oKSBhbmQgaGFuZGxlX291dCgpIGluIGFyY2gveDg2L2NvY28v
dGR4L3RkeC5jIHVzZToNCj4gDQo+IMKgwqDCoCB1NjQgbWFzayA9IEdFTk1BU0soQklUU19QRVJf
QllURSAqIHNpemUsIDApOw0KPiANCj4gR0VOTUFTSyhoLCBsKSBpbmNsdWRlcyBiaXQgaC4gRm9y
IHNpemU9MSAoSU5CKSwgdGhpcyBwcm9kdWNlcw0KPiBHRU5NQVNLKDgsIDApID0gMHgxRkYgKDkg
Yml0cykgaW5zdGVhZCBvZiBHRU5NQVNLKDcsIDApID0gMHhGRiAoOA0KPiBiaXRzKS4gVGhlIG1h
c2sgaXMgb25lIGJpdCB0b28gd2lkZSBmb3IgYWxsIEkvTyBzaXplcy4NCj4gDQo+IEZpeCB0aGUg
bWFzayBjYWxjdWxhdGlvbi4NCj4gDQo+IEZpeGVzOiAwMzE0OTk0ODgzMmEgKCJ4ODYvdGR4OiBQ
b3J0IEkvTzogQWRkIHJ1bnRpbWUgaHlwZXJjYWxscyIpDQo+IFJlcG9ydGVkLWJ5OiBCb3J5cyBU
c3lydWxuaWtvdiA8dHN5cnVsbmlrb3YuYm9yeXNAZ21haWwuY29tPg0KPiBMaW5rOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvQ0FLd19Eejk2cmZTUWM2Um4rOVFCY1VGSGhta0srOXp1K1A9
Ynhvd2Zad3hyQVRDQlJnQG1haWwuZ21haWwuY29tLw0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJ5bCBT
aHV0c2VtYXUgKE1ldGEpIDxrYXNAa2VybmVsLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEthaSBIdWFu
ZyA8a2FpLmh1YW5nQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEt1cHB1c3dhbXkgU2F0aHlh
bmFyYXlhbmFuIDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+DQo+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vjb21i
ZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=
