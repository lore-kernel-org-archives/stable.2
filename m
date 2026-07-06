Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66751BC08F;
	Mon,  6 Jul 2026 22:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375617; cv=fail; b=lzYiLDjNvdRnmCtKMmoqK/r0igT2gOrhQg+nUw+ruXUFxk8stnLES++Qpl1jVv4nNsQVksYEVhtzsVw5EE89yLbsREPuA7f7lEMMvLbPuEKfy5IpSYt/JM+jMiPY+k/9jc/HtNhPCPWcPYEemiEkRbtiwZtKxpbvkx0ZEMqvMjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375617; c=relaxed/simple;
	bh=vKVAcYwZ1deg0kTcnuCLmK237+sNLlzfjf12ecDgFNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cFet6Q5r+DjQ0uzNSlPsasJs7SUUVzev8g3yQN5iWY61rOg2ZZYkFfxGdaZQSW5q7OYftyEBeVFGkyq31WP3h/xjY1do6Sj3i/VftxjuZSV7SilcYbaMSx3HriuhhLsQ8B1Xosu9IIg7Nj7Eiv+6LoVmNpqIXA+HXjpGC/BIIR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBKHbwd8; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBKHbwd8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783375616; x=1814911616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vKVAcYwZ1deg0kTcnuCLmK237+sNLlzfjf12ecDgFNg=;
  b=XBKHbwd8z39ThEIOsmpS4m7mB2sWDp9SaILZ10XPTMtEhPBRlEMewSY4
   dPpKrAli0iwayh3C+nfnejKfAC+xAEcYECU4Lw9h4GIqa0xA/ZvWdVhRu
   0hbsNVfVRkvzVH9LntrYeundKV07idyFV8HaED7qce/y4g0YkA0G3uk4F
   sSWS2LBZGvVRwqwdVfwt1lAH28qH93dX0hehbGRmDKaprFG4QEyVuvW+G
   ToFow4pVBG9m5gFRsFfkwOyPnXxz8Y9iEzOQHndfoLLbBlIL+MB5XUriV
   z9ukh0zm7/npqE4KBYVrbMnmndguHilfqm+PA68PDU3dQpoKADnVS4QSF
   g==;
X-CSE-ConnectionGUID: D+eWazmzQ++fEvxmBoLqWA==
X-CSE-MsgGUID: ih2IDs4DTqCjYabqC3J9pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="94623688"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="94623688"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 15:06:55 -0700
X-CSE-ConnectionGUID: 92sFd85KROest4Y4p+oCZA==
X-CSE-MsgGUID: ftk6tR3ySo+BqGQiFa1TKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="258739607"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 15:06:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 15:06:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 15:06:54 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.20)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 15:06:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5QfnXo15YV3DHyMHfgV4LRBCtNDW1eVGV0LUAat9/+A6hP3P/D8GTU/TF1yKF2U6WaudEnDIrphzIOSY/ulyRUcJbSvhe9v6w3R+pkyG84ThpltdzuGvutWRoD+E33AoVBYJVlnLtOMKX/P6mtp7qNEHER0NwRWpbCOu9CN5w3BE//HAbGrpAfv+M9Kz29AwnrCQ1jp8/FH2uW1rEvZgDR8/e0d2eyCwEkDPfndujW4vEYAcnRomvEWfBtYJeKHyhNExiEl3+FgN3XYng6zez05Qt0wh11sFeb03IanuDqUCQlN3QI4lbFiG7/pZSoJ2LzYGx3Ng/kq1+f4kbPjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKVAcYwZ1deg0kTcnuCLmK237+sNLlzfjf12ecDgFNg=;
 b=Fq97OyTlMFtOdqB/jsXe0qCZ3La/E9qA7QZjgLWJOgW9ZdxuSVnBit9tyslk/UpwhWEgka2k1Ynr+loNcibCyngrUKWs8GNlm0iVVEZ2oAEFN1nvAvmTRjgdYhjIq0JnLmMMUpcT2HO6aN5g453aZK2qr7/QEeRxR+moM3vOEaJwxv1WYwz/MqSs5wIsHGBCRrUMs9iyXs6YwST/S6hkTzV4+slj+1kzpNwSqYneBsH/jTSI/iejd3V3I46j7cMrEZFClQzdLREmsJFZjhaYWbSafRIAnNdEPjdLxIzXa7NRedVyBhLmiT1o+iTt6ocIp5hio2HVv9djZq6BAksMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21)
 by DS4PPF1C4B3BAB7.namprd11.prod.outlook.com (2603:10b6:f:fc02::f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 22:06:46 +0000
Received: from DM6PR11MB4691.namprd11.prod.outlook.com
 ([fe80::5d52:baaf:8c72:ba5d]) by DM6PR11MB4691.namprd11.prod.outlook.com
 ([fe80::5d52:baaf:8c72:ba5d%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 22:06:46 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "bestswngs@gmail.com"
	<bestswngs@gmail.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "zhanghy@sangfor.com"
	<zhanghy@sangfor.com>, "Wang, Zhong" <wangzhong.c0ss4ck@bytedance.com>,
	"shixuanqing.11@bytedance.com" <shixuanqing.11@bytedance.com>
Subject: Re: [PATCH v2] KVM: x86: Destroy the PIC and IOAPIC before destroying
 vCPUs
Thread-Topic: [PATCH v2] KVM: x86: Destroy the PIC and IOAPIC before
 destroying vCPUs
Thread-Index: AQHdDXGHmWBSyPf6DEOzA+pP+a140LZgzV0AgAA/NQA=
Date: Mon, 6 Jul 2026 22:06:46 +0000
Message-ID: <51b8068149510179f59901b439e5f393c7757760.camel@intel.com>
References: <20260705045450.1325048-2-bestswngs@gmail.com>
		 <20260706180025.2735341-3-bestswngs@gmail.com>
	 <akvx7que1BE5DY-O@google.com>
In-Reply-To: <akvx7que1BE5DY-O@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4691:EE_|DS4PPF1C4B3BAB7:EE_
x-ms-office365-filtering-correlation-id: 59b3a6a5-7360-426e-1526-08dedbaadf2d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|22082099003|56012099006|18002099003|11063799006|4143699003;
x-microsoft-antispam-message-info: QQMxpdd1/Y6jk429wzpseRqEusfJ1xsT3PHT+d3wS6QAtXqlbPeGkqqJHuCWGec+XLjhQ4Dca1dGJ9Q46eBP6m1goj5bcGdxU1BZ+VjY5eWhWkRET2F4SzcsEULtu84BDh1o9vzOgchKIkqDFSSz6XAkJMyR7Myv2lBd6c4MzRjLIcEAEdyhUGVk59c0wlAMERJtzeHsI9zmKvnFqXMInJO3hOGflirbsktYx7yhr/pmFlsbnCh1nnDDwusPM71oNK369c/ljilQJBpMPob3h/XtqUUt2lGgRqjHOC6TxlcdufvqQ9whCATDmAJ1he03MuaO2ZUgi8xOfNgwCBvyYytTGury/1ca8mMDm0nBeLFHA6a++1QWvWgvWWX35YLZcemzEboLzyKDprEKE5cXpORdsLvRo182M9nB73sPh86e3DEBX6NRG61ijIlk1dwjCUtFnimMjPy8tWNFluI86GgwWYdCc9RiKr5tyEKBpYE2p/zydU9VKfecJCCFd1k7c+qcdsAtalLv/kfm49fzSf3JYCK/+xbNkmZOElTXeUpXvkdpge5D7O2EzrGRCFDJazNZJLcMiIr2TXNjppZbIyG3mj1tX09rcpYJqcXJuFxRcCAxNFBIMvSsUG4SOw9BLYWDn36PdEGfi9Pq0CxoPxWCPrq3KmNcP1eblFW4ZVJR4XLJmpFMujjNxlWHYY/+1c25zzmX22YKkNmEceLNox43hsQj3/RowzoBcvP1HWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4691.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(22082099003)(56012099006)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVNyOUxpUDRKejNKZXRCNys3YmI2RkU4Q1JKQlZtc09IQUx2VXROV0lyYmY3?=
 =?utf-8?B?S1ZmMG1PeEdCQldad1hqN2JXMXd1aFVBemlPdVgwcFhWOXM0SThBKzlwQWtw?=
 =?utf-8?B?eUJCZTczZ2pJYUlaR2Zpd3lPbE05eTh1dGlGZzZ0T0ZIZ3BNU21tdFlISkcz?=
 =?utf-8?B?TjNYbVlTREhDOEp1eUNKN0htaFFRdGdoSDdHSytBbytjcjZLYUZtem4xbFlL?=
 =?utf-8?B?YVhTY2lGUXY2bUlGYnBmUWhpMWZVTmlLUStXSlMrUkxPMzBYc1ZrTTFraEdq?=
 =?utf-8?B?OVJNU0xabjVJU0tEdmFrd0dqaUx2QmxuUms0cTczREtlU0UveGdoWFdQbnhl?=
 =?utf-8?B?TjB4eDdjUUtIUWxsMnNhZGVWWW1PQkwxTWVIRktVb1lxWnFiUEUyRk1PTDlm?=
 =?utf-8?B?blZROTZ1RlV5alg2S1VhbHk1aHR4WWRmbWtXWXR3Q2YxOVB4MFNKbEJ6YVlo?=
 =?utf-8?B?UWdncEUvUkE3aGRKQlpnaHQ4WTk3OGFrQ3JHSnFjdSt1aHc0OUUreWMrZ25I?=
 =?utf-8?B?d0J3SlM5elM5d1QvYmNhaDVPVTNoSkRuT1B2SjhsTkFqWGZ6YzNZaEJ4alVR?=
 =?utf-8?B?TWg1bnhVY2F6QkpwWjNWQmZLMmhiZzl6eCszVnd2V09kZjl3MkdCMmoydXVK?=
 =?utf-8?B?VkFjVUY5ZjgwTyt0UGtnMFZSckVjd1RjczVBblZOVGVTMnF3NTVnQU40N1dG?=
 =?utf-8?B?RG9YR1R4M3RPemtyWE9Pc0hqWjM4V2MrVVAyNEowWVNZRVNQcmtKUVRlVEcv?=
 =?utf-8?B?dTdpQXpwR1BXVzZ0dGsxN1NkNGlMeFRRTGYrelZ3MTFBY213OStqUXJVeklm?=
 =?utf-8?B?dzZmaG42bC9pOWxhRGhqb05SbzZwYmNDMFhxNHY0d3ZCQThPTy9NaHplci9C?=
 =?utf-8?B?OEVNdnlEcFVpLzBQQnhFcWJUS1hQYk9SRHlVTmUyVnNpdFlkNkN6Zi9tMm92?=
 =?utf-8?B?MnhyYjIwZ3ErNUdFUTV1WVZXYWtTZm5xWkpsVDF5NlY5TzZtcG16U0x4bjha?=
 =?utf-8?B?WGFiQk82Q1NuZ2V3b0xzYTJzRmxwcGpHak1pY2FGLzcyc0MxSlBzbGVUTmxM?=
 =?utf-8?B?Z1VVTVdpT3NRZXNKc09YYVV3TUlQZ1pUL2o1Ky9yemRLSElYTDVNSFFMdnlF?=
 =?utf-8?B?YWxuN3FtbHpnRlFhc1Q2RmlHcE9CZUduaHVMUGkySUQ3ZWYxV0VIdm9GZFZl?=
 =?utf-8?B?UUkxTlhpcnNiclRoemdCclYwZ0pDbnhrWnpWSjhkd0k3QjZjcGo3b3Q4YW1B?=
 =?utf-8?B?V3I2aVFuQlNqMy9CczVldW5FTzVDSW5YczBlZkdTY0FETVpVMmRhczNzajV5?=
 =?utf-8?B?dFVZR0didktCZ21qU295WEd2RTFxMXlyK0h4RERqb1haTWVmUEl3UXJabTdk?=
 =?utf-8?B?Nit1NHVqTVpZaTdqVVkyMUIwUlFFOG13UEIxZnk1N1lqVlU4M1ZOelRjZlBk?=
 =?utf-8?B?L1dCSlVXQXcyVFdnZGg3TFprM2lnQTRZYUpkS0NSVWExeUFMMG9VNFdlS3ZW?=
 =?utf-8?B?blRXbU1PYmF2RnFMYVBGT0VBUEdBbFYrZzZkclJJWTJiZmpCNlRpYjJqeTdo?=
 =?utf-8?B?U3NFOEdlSlZxb2hNWSttNG1UUXRTd0dTUWI5TW5xcjFCdFdWTDFxUVJJcWp2?=
 =?utf-8?B?M09wWm1nQnlTMjZOaWxOM3ZNOUZURzQyeG5PSzFua0Y1aU0raFNPRldPY0Nl?=
 =?utf-8?B?K2tjQzRkM1ZEalRiL1FSMlRnb1B6cjJUWWtkdFY5L0VOVk9ZSnJPbjluVU82?=
 =?utf-8?B?Q1RpNkJjVU5GV3pBNURxUmIveWVhbVM2SmxSL3paSjJRa3NWWGlHR1JQNnNi?=
 =?utf-8?B?akJiU2ZQRHdNd1ZmV1hVSFVvWE5weGpaMzhqTjVhMjI3Tm9BZ3F3M09QQzNB?=
 =?utf-8?B?eWRKVXNHbWxEKzNmTkljUjdlanZIVEhDTHBOVWR6RDBpTnVOUkFHRS91S20w?=
 =?utf-8?B?bW1iZyt6WHVPWXZ2ZzdNSGZFRU9CcXNtdDF3bVdIR3FXdnZBWThsZ0oyOTFG?=
 =?utf-8?B?OE1kUm5TQ0crQ0Y3dmE3dEpoSC9SUjJNZVpqTWw5cm9VeGJyZ2tUa3libTZZ?=
 =?utf-8?B?THBtTzVXNThMMmxFZ2tzSVl0Yk5NYUdsa2FMdVo1VWVkMmQ1c1FDelh5NTFJ?=
 =?utf-8?B?dkZNNE5EQ01ZblQwSG8wMUY2VlJwR280V05MQnY3QU1IY0JhSUoyeVJWTkxR?=
 =?utf-8?B?UmR4NzMwWkJGT3krMlNsMEZJOThPZG5VMUxKVEFKdTIyOURJSmprL2d1cDc1?=
 =?utf-8?B?Tjdmckh5d2xhVWNMclBsWm5Rcm4vWXhVYlY2Mnh4eElSa05VbHpSTHd4NXJy?=
 =?utf-8?B?MlgwVjQwM3pVd25jUVg1dzl0SGwyZHVIaGVKVytJdno5VW00aGoxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0000372C95C91546B8C557B55B20B6A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EzrLupzb57HUmlxb7pwtR5OQuq+DgCdKk2PWM5lT8IX0CpKoDa1PWz8se1VaYiJ2peHBDl7GaNQzTk2R4QJq1CJGqxZRhfltKNg8P6pno4IN8I23I6wrCFve9v6t8x6V2GP01N9A55C4ab1/fgxGuQinyB+kBhxJl7JIjkFaUdL/LDvSlMv9RXdbTmv6L2CTcWmTuM+9lnATL0p1ngbgqeHTZvJGmaBekP+aWIEZNrrTIWWYhWtY531jXjBL+vDDH8e9hUpqSZI3axFveaaEOo0QwgB9fHLusy/h93wRmWP40VE2TiEB4mEk7JJZN023uIaDmmfdxH4+OaR7qltu+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4691.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b3a6a5-7360-426e-1526-08dedbaadf2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 22:06:46.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNafHF4lOqEhwgKcbohMTs/GBmGfHg4p/NQXEHwzPQxiQnvu/KRmodjCpWHuKVq0mkPKdqiGso8Eldwrl3ytag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF1C4B3BAB7
X-OriginatorOrg: intel.com

DQo+ICAgICBBbHRlcm5hdGl2ZWx5LCBLVk0gY291bGQgc2ltcGx5IGRlc3Ryb3kgdGhlIEkvTyBB
UElDIGR1cmluZyB0aGUgInByZSIgcGhhc2UNCj4gICAgIG9mIFZNIGRlc3RydWN0aW9uLCBidXQg
dGhhdCBnZXRzIG1vcmUgdGhhbiBhIGJpdCBza2V0Y2h5IGFzIEtWTSBleHBlY3RzIHRoZQ0KPiAg
ICAgSS9PIEFQSUMgdG8gZXhpc3QgaWYgaW9hcGljX2luX2tlcm5lbCgpIGlzIHRydWUsIGFuZCBu
ZXN0ZWQgdmlydHVhbGl6YXRpb24NCj4gICAgIGluIHBhcnRpY3VsYXIgaGFzIGEgYmFkIGhhYml0
IG9mIHRvdWNoaW5nIFZNLXNjb3BlIHN0YXRlIGR1cmluZyB2Q1BVDQo+ICAgICBkZXN0cnVjdGlv
bi4gIEUuZy4gYXR0ZW1wdGluZyB0byBmcmVlIHRoZSBQSUMgZHVyaW5nIHRoZSBwcmUgcGhhc2Ug
d291bGQNCj4gICAgIGxlYWQgdG8gYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4ga3ZtX2Nw
dV9oYXNfZXh0aW50KCksIGFuZCBpdCdzIG5vdA0KPiAgICAgaGFyZCB0byBpbWFnaW5lIHRoZSBJ
L08gQVBJQyBoYXZpbmcgYSBzaW1pbGFyIGZsYXcuDQoNCkhtbSBzZWVtcyB2bXhfdmNwdV9mcmVl
KCkgY2FuIGV2ZW50dWFsbHkgY2FsbCBpbnRvIGt2bV9jcHVfaGFzX2V4dGludCgpIHZpYQ0KbmVz
dGVkX3ZteF92bWV4aXQoKS4gIFRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0Lg0KDQo+ICAgICANCj4g
ICAgIEZpeGVzOiAxN2JjZDcxNDQyNjMgKCJLVk06IHg4NjogRnJlZSB2Q1BVcyBiZWZvcmUgZnJl
ZWluZyBWTSBzdGF0ZSIpDQo+ICAgICBSZXBvcnRlZC1ieTogPHpkaS1kaXNjbG9zdXJlc0B0cmVu
ZG1pY3JvLmNvbT4NCj4gICAgIENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ICAgICBTaWdu
ZWQtb2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gDQo+
IGRpZmYgLS1naXQgYXJjaC94ODYva3ZtL3g4Ni5jIGFyY2gveDg2L2t2bS94ODYuYw0KPiBpbmRl
eCAwNjI2ZTgzNWU5ZWIuLmEwY2M3NGM4ZGVkMSAxMDA2NDQNCj4gLS0tIGFyY2gveDg2L2t2bS94
ODYuYw0KPiArKysgYXJjaC94ODYva3ZtL3g4Ni5jDQo+IEBAIC05OTQyLDYgKzk5NDIsOCBAQCB2
b2lkIGt2bV9hcmNoX3ByZV9kZXN0cm95X3ZtKHN0cnVjdCBrdm0gKmt2bSkNCj4gICAgICAgICAg
Ki8NCj4gICNpZmRlZiBDT05GSUdfS1ZNX0lPQVBJQw0KPiAgICAgICAgIGt2bV9mcmVlX3BpdChr
dm0pOw0KPiArICAgICAgIGlmIChrdm0tPmFyY2gudmlvYXBpYykNCj4gKyAgICAgICAgICAgICAg
IGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygma3ZtLT5hcmNoLnZpb2FwaWMtPmVvaV9pbmplY3Qp
Ow0KDQpNYXliZSBhZGQgYSBjb21tZW50IHRvIGV4cGxhaW4gd2h5IHdlIGNhbm5vdCBkZXN0cm95
IElPQVBJQyBhbmQgUElDIGhlcmU/DQo=
