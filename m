Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC282EEE74;
	Wed, 17 Jun 2026 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733802; cv=fail; b=DHYc4hVaY0J4Kj7HnmTmeBsdRFqWYpLr5ZrGfu2/0ug5m6XaDrnmN/8nQWYyQe+8C3+K0bHVQlWeEZAmZ5Z5iqaHFu909q1laZgxbJG0TcLKSuTw76a9jiJMPS6GaCSg1eMWmNKzRCwUd36t4Oifu9s/zLKvgEAfb3N6DB0M5b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733802; c=relaxed/simple;
	bh=GSmlTHPGDZxVBW9gLePHUXOiO8bIr+N/ptIgtdKH9Pw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S9JLnjKfE0Wn0dW8mWg174sYve+fyVH8pGFJj8ZJvAgmlUCLHuY0FhmdCUtt8n7wi+tirTvquPnuXDDyl3kmws40hYNwJtvbAPy8T9ktZRuzDhBl33u/vUf9yOgq1O9abBD+ltEz+MGuLgC7VPYgCAC/41YVP1X2uCUQDT0boek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgG49xYO; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgG49xYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781733801; x=1813269801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GSmlTHPGDZxVBW9gLePHUXOiO8bIr+N/ptIgtdKH9Pw=;
  b=JgG49xYOIm+o//FWaKJDWpqeAFofqLp7Eh46nzLGuc+dw2zA86NZ48R7
   p4g5T53xsUnpa7UwKFSgPdeSt1egaXS0mnO8xk6/cKIztQ19WtGvDylVJ
   n9lfb5ANzi17vYCRIZUBiPnFWEoZcxKRV3Z+3KaHqV+hUG7zwR4wFQzOU
   SvEIJ2luWjmsFyz6UCbF41IqnI+kna4jBBqHd0jlrcUYgaNYRIPJub5qy
   Ic3qFSqP4tgekS2KO9YveqJoGRwDdv41DbMOLFgAcnEfUVcfu/wCAfCnq
   sooTiFOWCZBMLkibAhsXNj9hwWBXLPM0P3lhDJBQjSBSRLvay983r/CcO
   Q==;
X-CSE-ConnectionGUID: 10I9LQjSSFeA/irpYZCdyA==
X-CSE-MsgGUID: nNZxE8iERgiv1k97sJH5OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82554153"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="82554153"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 15:03:08 -0700
X-CSE-ConnectionGUID: SfGbu1n4QLaa1tiLhqpfwA==
X-CSE-MsgGUID: snUvfM1PRRiXs4bA2QX2/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="271887336"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 15:03:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 15:03:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 15:03:07 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.22) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 15:03:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnCXgrBU84PxX8O8SZnB2AI/2jPDg+CvMFfNqZuw1w0LRUkk5tDG6nS2Fzs8ywwC+5bthfJux0GZCG8VwRYbVDxj4L35FdE5lMNwqo+amvYWam+5Lv9frwUuhe0OUzbA+u78T9gssGBdbQjvwVy4cmv9jRKLt5VA1NXX1vx+IiJwRsL63OUPT0OUdHuTwE6fBkWbksucOLG/QjikyvFkOwS7pgv1FQtg8It/mVKmI4hFKBI4LYvl+ZfTYBEfSNR1V3tLoPkP+uEMsaS2uMXpuAW+vxkxdVMvYh0Nl2YP8wcqotjrCjegqPRmsoRQMS0f1nBzSDyVz+0tZ0u5ZSYncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSmlTHPGDZxVBW9gLePHUXOiO8bIr+N/ptIgtdKH9Pw=;
 b=RgF6c2Mj3PEu6JUP0SQMMpuggzI1iWpXd4/5iLh/3vStazNJsI8On7Bf1jdi1vfpr8qkyg/tUWTp7vNDZZoTGEQ2UkY7lj50e5Xvz4dfTdgQW6t9oKqFsjKGT4pefVrNUyS/akG5e2x5tNrMSCU1JYtmmZf5ZVtU5CX5yOcndlnA9o2F4N5UgrB0Q8nss4en+fuOPXMGR46lCUyqLB6UTUBC2wXjBqK5YFcEO5C23SPTwPm9M/L9NGMGrTse4QZd3y4Ie5Q1wiXy3kUh78oHxtrjtxdYYwkEG2uyLgBqdbi6G9KblNFIjziakgrCYwLQ8aQSBPLaeOKjJ6Eou3EQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 CY2PR11MB861495.namprd11.prod.outlook.com (2603:10b6:930:114::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 22:03:02 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 22:03:02 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "jmattson@google.com" <jmattson@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yosry@kernel.org" <yosry@kernel.org>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
Thread-Topic: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
Thread-Index: AQHc/dm+vhBqLF7f3EanPIP01uKgGbZCncWAgAAZzgCAAJbYAA==
Date: Wed, 17 Jun 2026 22:03:02 +0000
Message-ID: <861c890587cb8cd0e2893ea4041555d33d8e9db4.camel@intel.com>
References: <20260616214652.2157032-1-yosry@kernel.org>
	 <20260616214652.2157032-2-yosry@kernel.org>
	 <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
	 <ajKbCii_1LpyQKjJ@google.com>
In-Reply-To: <ajKbCii_1LpyQKjJ@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|CY2PR11MB861495:EE_
x-ms-office365-filtering-correlation-id: 224b7cfa-8efe-4f17-0e3a-08deccbc33aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|18002099003|22082099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: MgSWB1W3S1akMWpJ93Bon6KPcLKrSo06zWwtCCXoZoAT9QjjGMuz/A3ZCU7RX+MqCRaPjMGTLnPCz5b07P8ax5X5tceYmriWUGwyKQVX3//nirL3T5H+1DFPyA+43krfIq7I8MtOXvHPDS5O56ER/AQNFIxsVxrjz9NexUxXR4fTIJCfqPL4e7shdUmOa6fr6DKog15Br6xmSocyXIjkn/4R7CC+9E4girFgIbDWNTrgCU+33hjxss7q5lhmftKEfP9B+qVHB3HdOwBQiEBj0qTUXce1Io7PJK1qLgFMQeGfes0ZzK5KuY+HP2fjrl8h5g6zlv2TW5HY3qG/6yY37//i+xj92pwUhGAK6FqYJ7YXjk/UR9G7PjqiXlZy5kdmHtJL1+f3QfUoMD3T/3J8Ay2DiBb3Z1jdGp989YcCim351/pp6a1E66Lg6uud9Byn8fGs8VYFYwH5PjojJFhvotvvtA4W54Mh40FYI+EhDWYC/4KmzSQH9BBa8pdpKxJCnvynwxmktiqhm/EXzximWgNiMs4i5HQDpe3iSdeJJysBxBz7gv3CQaDi3p8gQyeAe/foYkqVFoNFB8aezfwT9TR7A7RTlMx5dTIauusaEyXAjUOGrOoVsuz8GcWdqURkoQAlPeiwjPWO/PQwwOJuD6Kht0JUtiH2GAii225em3fPLEydlvxXjpzRUEUdpdsCZ2MbmlCXLUsSy2/EZNmJY+Ksx8HlN6sjOZ5dlLxP6QHdJWyshxUl7vgQ8iKtOuMn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXhMdk9hYjZvcW1OZnFVMkVUUkZqa0RHSUlhTDVZV2tDMWJaY2JHL1dwelR3?=
 =?utf-8?B?RmNzbFJqSVByWThLdVh3TXFDTTQvVVhuK245aGpWbDFhU1c0UmdpOXpnZlla?=
 =?utf-8?B?WlBkTEtKM3Fwd0krOEE4MVYyRi9KMy9aSmhxWk81dk1Kd0lwWXdhaFlzZEwr?=
 =?utf-8?B?Q043MVppa3NQY0N1NUlJeDRiSERsUmRPVUxhVmhJWWtrV2pabVF5WnZTR1hY?=
 =?utf-8?B?VHU1dmJndEkzaWJKS0I3dElPODQ5dHlBTUI2MFpXYWZOdmNZdTdJb0Z3bHhz?=
 =?utf-8?B?d1pJaVp4cDhFN0wrL09sNVd4R3M3NGt2K2ZTUjlhOXZuR2JpYmp1ZkhXNmJ2?=
 =?utf-8?B?aUhQcUY4V1JQZ1Y4Y2RTZjdRTlFBOUhlZktOWm0zTGJnUU5RMS9IVTllMnhx?=
 =?utf-8?B?bkV6TkIwZDNTZTA0ZzBXZE90TjFta3JnbC9wM0Rkc3k4RmRTUGFGcWs5d2lS?=
 =?utf-8?B?dHNHU05TTSs0bjY0Z0IyaGlabUFCUTdqT3E2eGlXOFpYQXAzRExKSU1ONkZU?=
 =?utf-8?B?bWxReDcybGh5Y25FUkxrbzIvZU41Q24vL3NEU2UrNThxdFZKVWVmWkp6Zm4x?=
 =?utf-8?B?RkVMaXpQNW50SjEza2tYY2V2WlJGK3R2MXMrR3VVbGFKSHVQMUdyMzdia2ti?=
 =?utf-8?B?TXhZT1BtRGFwK0xTRk8yTlMzcmFQVmorTHdmMzVWS3BPUk80cVJlemZ6b1FV?=
 =?utf-8?B?dXFpdDJEbm84UHNXdkZibUQ5R0pTTmh3bW52Vi81NDBhaFE4dE50TTRoODNV?=
 =?utf-8?B?b3FIN3lQMldXbS9EMEh1eUU0aFROdmJSQ3hRZDNqclJWYXFlWjBabEF0RGN3?=
 =?utf-8?B?R0xPSWQrQ1VSNnB0eVNRK2k4Wkl4SnNuaHdRWFFsRjhseFc1KzFPNnZqWExI?=
 =?utf-8?B?RE9iL2tJNmU4eFdaMStJQWlTaURNcDloN3VSWk9uY3RtWXpxaVZLR1RIK1Z4?=
 =?utf-8?B?MG5XeHNqY0ZLcjExTVNVQjJ4ZHhLVENvOWpxSDJGK2xzcVY5RFBsbmNiYkUw?=
 =?utf-8?B?T2dYYUZQM1dQZ3JwQ3h3bWJyb3lmOXhVeDIzMDdPU0V2WUVuTTFYTDlId290?=
 =?utf-8?B?NGFqR0twRFk2d3JaUmV3VjNHOHBSc3ZMMDdqTzFRcDNxVko0SWdZZ2lDU0Y1?=
 =?utf-8?B?SnBvTlIxaTErSE5MNmJJZWQvanY1bVpMUEdiS2gvOENMNnlDUWJ4dUFndThZ?=
 =?utf-8?B?eTEzbVl3dHhnVnowbXlhd21QUHNoWmd0YktZUG05SzdRaWpKVzM5NE5mV2x6?=
 =?utf-8?B?UkZnQlVPdC9BbUJua1IrSFhVem9OZkxoYzUwcytoTVQ0WmxVRSs5TEpPZzZa?=
 =?utf-8?B?Z0lwSFBlZndhQmY0MWhyNDU2dHU3NGZ4akxYOU02Nzg5QjhzSVhrS3lGdGNa?=
 =?utf-8?B?RVphUWd5L3hLU3NUWWtTZXYrU2lhTGlwandOQnh6UVZvd2JXZGRTcG44Wmo1?=
 =?utf-8?B?akROb3lXZUJ5aXpWZzYvMEpwY2hxVkhaMzFCdHBHRDZmcFRMK1FUR1dwREdW?=
 =?utf-8?B?RTdoMjdpVUpIcVkyQTlCeCtycHpvMnhWM2czdWp3aEhvc1hmOWNqNDFvU3lw?=
 =?utf-8?B?MW85eUVoTHlldXhrOWNVMFlZQUh6WFFUU3MrRjlXZVdIcHFGVDZzTjd5YjdR?=
 =?utf-8?B?QXlqMktOQ1MrWFNaODFCcjBjb3B2MUdtY3dUQUtXK0tEcVdMTmNvejJxU2xl?=
 =?utf-8?B?aTM3U1d6QzF5Nk5wTTZwNGNTS0JJY1g4L1RjbnM0OE9XOVpFNU9aR1h3UEIw?=
 =?utf-8?B?VWFCRW5VTjRzZmFZK0kvcFhHdjI3QzArdHBtMGJqMVlyVU9KeG9mME4wcjh0?=
 =?utf-8?B?YlpIU2pzQ2xEUGoyTHZISEhZMExwRU5DcHVLeU80cmNQL2dMR1FLMHhTOWZi?=
 =?utf-8?B?RGdkbU5xcnN5TmNSWlFqWmtLOE5QVzhTT0NwVVpLZy9NQkJMaHBieFBqa0o1?=
 =?utf-8?B?NUhkbEpzS0tRam5IZEwrM0VKZnNjVUh2cXB1YURjVTBIeHVualAwcXBkb3Rq?=
 =?utf-8?B?RXhTZFgyVnB3cTVMT1pMMEg4bEx5Q1Z6WWQrRlFuWkFzOXorWlc5SzFIM2hN?=
 =?utf-8?B?UzdLUjZJd2I0NXpGbW5LeWRnenlLSFZsVitxeXIzK1Z3QlFpKzdIalkva3R2?=
 =?utf-8?B?ZkNWamhXSTJFREJtblVEbXIwNkNqL3d1Z2xrOTFENS8rOHRiOHI3dnF6cFdG?=
 =?utf-8?B?RHpTTGxQTzNyZDBpdmlYdGxDZ3R6RjRKbTdPWkZyWlMrcG9RMzdUOVFqR3No?=
 =?utf-8?B?WjA2QzdKL21hNFlDR2x2a2RvWjhnYit4bXY5eXFqc1JCRm5PTUxPZXJuVnRk?=
 =?utf-8?B?dmw0S1VDQWVvRnM1b2NTNXo3QVlSZDdtNGFnVW52OGFpK2Y4YUtHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AA55FDC5825864B9882D2F68554FBD1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: APgkeyLrP8eYBpAleUEyCZz4og+2VSTPBvoGW1PoaDJ7gxaU5FjOrs2LFwTIxylprOJ0ErS5L5Gxa/WPBqPMLEmrrklxvSB9Gc9BT6wEgIqgZYGXQMFvDrk28HG+OUGYbVgmU2HzWQVTp6eMMP4rXGrmdHbOi3y6dzItRBCYixUTmkXCcLqh1sqZyqLezZS1eU+hAtyLgcH6t0ub37lZkUMmicbN58p1uphjXi42Y2JYgM70qtl60OLkzTX5EpQC2Lo9bOgtq6jJ1VgMvF3PvOb+hBhN4BJvBMJItJrcBnM4UaQJMZw9LpWJ3VrNXzU8o+Bh6GLvzWxNrJJs7jXJjA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224b7cfa-8efe-4f17-0e3a-08deccbc33aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 22:03:02.5338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5FGrdOh9SgAZMZEDGOn47px4ELYi+KO82y0cl3169Rlz9d8lXSErLjW488WDW6j3kVmcqAesuBS9YX0u1nXrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR11MB861495
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA2LTE3IGF0IDA2OjAzIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBXZWQsIEp1biAxNywgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IE9uIFR1
ZSwgMjAyNi0wNi0xNiBhdCAyMTo0NiArMDAwMCwgWW9zcnkgQWhtZWQgd3JvdGU6DQo+ID4gPiBN
YWtlIHN1cmUgdnBpZDAyIGlzIGFsd2F5cyBmbHVzaGVkIG9uIGZpcnN0IHVzZSBieSBzZXR0aW5n
IGxhc3RfdnBpZD0wDQo+ID4gPiB3aGVuIGFsbG9jYXRpbmcgdnBpZDAyLiAgbmVzdGVkX3ZteF90
cmFuc2l0aW9uX3RsYl9mbHVzaCgpIHdpbGwgYWx3YXlzDQo+ID4gPiBkZXRlY3QgYSBWUElEIGNo
YW5nZSBvbiBmaXJzdCBWTS1FbnRlciBhZnRlciBWTVhPTiwgYmVjYXVzZSBWUElEPTAgaW4NCj4g
PiA+IHZtY2IxMiBpcyBub3QgYWxsb3dlZCBpZiBMMSBlbmFibGVzIFZQSUQuDQo+ID4gDQo+ID4g
dm1jczEyIDotKQ0KPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGlzIGF2b2lkcyB1c2luZyBzdGFsZSBU
TEIgZW50cmllcyBmcm9tIGEgcHJldmlvdXMgbGlmZXRpbWUgb2YgdGhlDQo+ID4gPiBWUElELCB0
aGF0IG1pZ2h0IGhhdmUgYmVlbiBhc3NvY2lhdGVkIHdpdGggYSBkaWZmZXJlbnQgdkNQVSAob3Ig
YQ0KPiA+ID4gY29tcGxldGVseSBkaWZmZXJlbnQgVk0pLg0KPiA+ID4gDQo+ID4gPiBOb3RlIHRo
YXQgbGFzdF92cGlkIGlzIGFscmVhZHkgYmVpbmcgaW5pdGlhbGl6ZWQgYXMgMCB3aGVuIHRoZSB2
Q1BVIGlzDQo+ID4gPiBjcmVhdGVkLCBidXQgaXQgaXMgbm90IHJlc2V0IHdoZW4gdnBpZDAyIGlz
IGZyZWVkIG9uIFZNWE9GRi4gSGVuY2UsIHRoZQ0KPiA+ID4gcHJvYmxlbSBjYW4gb25seSBvY2N1
ciBpZiBMMSBkb2VzIFZNWE9GRiAtPiBWTVhPTiwgcnVucyBhbiBMMiwgYW5kIEtWTQ0KPiA+ID4g
aGFwcGVucyB0byByZXVzZSBhIFZQSUQgdGhhdCBoYXMgVExCIGVudHJpZXMgb24gdGhlIHBoeXNp
Y2FsIENQVS4NCj4gPiANCj4gPiBOb3Qgc3VyZSB3aGV0aGVyIGl0J3MgYmV0dGVyIHRvIHNldCBp
dCB0byAwIGluIGZyZWVfbmVzdGVkKCksIHdoaWNoIGFsc28gcmVzZXRzDQo+ID4gc29tZSBvdGhl
ciBuZXN0ZWQgZmllbGRzIHRvIGNsZWFuIHNsYXRlIEFGQUlDVD8NCj4gDQo+IEl0IG5lZWRzIHRv
IGJlIHNldCBvbiBmaXJzdCB1c2UsIGZvciB0aGUgc2FtZSByZWFzb24gdGhhdCBrdm1fbW11X2xv
YWQoKSBmbHVzaGVzDQo+IHRoZSByb290Og0KPiANCj4gCS8qDQo+IAkgKiBGbHVzaCBhbnkgVExC
IGVudHJpZXMgZm9yIHRoZSBuZXcgcm9vdCwgdGhlIHByb3ZlbmFuY2Ugb2YgdGhlIHJvb3QNCj4g
CSAqIGlzIHVua25vd24uICBFdmVuIGlmIEtWTSBlbnN1cmVzIHRoZXJlIGFyZSBubyBzdGFsZSBU
TEIgZW50cmllcw0KPiAJICogZm9yIGEgZnJlZWQgcm9vdCwgaW4gdGhlb3J5IGFub3RoZXIgaHlw
ZXJ2aXNvciBjb3VsZCBoYXZlIGxlZnQNCj4gCSAqIHN0YWxlIGVudHJpZXMuICBGbHVzaGluZyBv
biBhbGxvYyBhbHNvIGFsbG93cyBLVk0gdG8gc2tpcCB0aGUgVExCDQo+IAkgKiBmbHVzaCB3aGVu
IGZyZWVpbmcgYSByb290IChzZWUga3ZtX3RkcF9tbXVfcHV0X3Jvb3QoKSkuDQo+IAkgKi8NCj4g
CWt2bV94ODZfY2FsbChmbHVzaF90bGJfY3VycmVudCkodmNwdSk7DQoNCkkgdGhpbmsgeW91IG1l
YW4gdGhlICJhY3R1YWwgZmx1c2giIG5lZWRzIHRvIGJlIGRvbmUgb24gdGhlIGZpcnN0IHVzZS4g
IEJ1dA0Kc2V0dGluZyBsYXN0X3ZwaWQgdG8gMCBpcyBhIHNldHRpbmcgd2hpY2ggaXMgdG8gbWFr
ZSBzdXJlIHRoZSBhY3R1YWwgZmx1c2ggd2lsbA0KYWx3YXlzIGJlIGRvbmUgb24gdGhlIGZpcnN0
IHVzZSwgaS5lLiwgdGhlIGFjdHVhbCBmbHVzaCB3aWxsIGFsd2F5cyBiZSBkb25lIG9uDQp0aGUg
Zmlyc3QgdXNlLiAgRm9yIHRoaXMgcHVycG9zZSBzZWVtcyB0byBtZSB0aGVyZSdzIG5vIGRpZmZl
cmVuY2UgYmV0d2Vlbg0Kc2V0dGluZyBsYXN0X3ZwaWQgdG8gMCBpbiBlbnRlcl92bXhfb3BlcmF0
aW9uKCkgYW5kIGZyZWVfbmVzdGVkKCksIGJ1dCBtYXliZSBJDQphbSBtaXNzaW5nIHNvbWV0aGlu
Zy4NCg0KQnV0IEkgZ3Vlc3MgZG9pbmcgaXQgaW4gZW50ZXJfdm14X29wZXJhdGlvbigpIG1hdGNo
ZXMgdGhlIGxvZ2ljIG9mICJkb2luZyBhY3R1YWwNCmZsdXNoIG9uIGZpcnN0IHVzZSIgbW9yZSA6
LSkNCg==
