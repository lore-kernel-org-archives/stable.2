Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EAF410D36
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592060; cv=fail; b=ZyVqSWy93562X6/NPYcg6QFNu+sWzf/vslFH3IW/bu2BAvlcwotjWN7B73/OdBpeQnq7/O5BC8S6DOrX7axEPK6b7VVneQf56of5rUnIcZFNC88EC0iiSdTc6yWsEl3Gs5c2qKh5oBpMfVhCKrX1s7eaOtyyHYrrLlvjakd+r8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592060; c=relaxed/simple;
	bh=rPWcFazdbCig2iTU57g27pumJDHuQbIy2mD2afDoLH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EdjUbnKDcuz3q9V7jNmr5ldV9AbGhozZXG8UfRReUhCWXSekzsMgvHvlfwPQkFL/ILdw0/GVq8IwGL8FbZ6SmsVXw4am/BzA0UhyMCnNcTMsmRhQ0AECFpcdGdWxxDrQeQXS96UimJd7nLUfWlmQmwU8SSUGBgMKtyy/mkIPvK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWmwyjfs; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWmwyjfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783592058; x=1815128058;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rPWcFazdbCig2iTU57g27pumJDHuQbIy2mD2afDoLH0=;
  b=kWmwyjfspVU002x6kOoN7gFAFevEgkNMMXw5pUzd/Pfbk3FvN9tho25G
   YfhViCmmVKeio8HkesEU1pJhhkDvXATd/mlG4sbvxJEa0nBMo8uz2fBXN
   h3xuR73gh73n0ROHP8O2FRlbVLLSHh+BIV/UXXCKV5fvVoF8gCDuhPcuN
   xST64GQiG19v1JjXOKiopzM9PG1QhiTZN6jvhUNQNMiyxlTmwCnkd0/kA
   Hr0LykFrVS0VFcWFLRgRztLe/4YY+3OlBP5rTO8TZDXBcodb51YK3QYG7
   u8pls+2WyRo5R2tZY+SldarCJZ7F0qkIQoZO8z50baRKuuCHKJ0MQSw7j
   w==;
X-CSE-ConnectionGUID: wmdhrDxWQ6SBZxIlzaSHqg==
X-CSE-MsgGUID: 20R57sPuShmSHs1KWB0PGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101816481"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101816481"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:14:07 -0700
X-CSE-ConnectionGUID: RIKrqiBsSBymO0vVN5RtrA==
X-CSE-MsgGUID: t/KTRg15SlWOKuOJ+bV5LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="248171061"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 03:14:04 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 03:14:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 03:14:03 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 03:14:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeP2o+vGpKTxN/7oMIhxwDuP0Kwg9vLMBRfp5xjkuB0HdyR9DKV+s1lh2V3/aGb1hijnMsDXGEK0cfmggrlCBe/8vpkhz2dHP6I/kjKiRDDm5Efna94tClx7MVA8cXmPpGbk//6tdJ+UnzEMv87AdH0Y+J24mZlgb5vRCwZnGqN934Obtt0fqHhaJPr4PgFLaIC0aCdgFuk6G2+0/+w+KyAMnDnpw3dNqn345MuA9hr5xfyrCKbTiCuwzqKxg+ZI6Kk/ncoHIuz0bnSyGBrO0UsNUyotNC7yY/kI7Xsh6U4a1cRm/857SMG9ApsP7NN81P27sUDEQYkKEjLVOnpNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPWcFazdbCig2iTU57g27pumJDHuQbIy2mD2afDoLH0=;
 b=SQBdE25YVpyqBFNod9s7CIyS3/mkLSmZkwnYp4UdEEq3Hie+Zfu43UDRXAKG/XpxeDoEm8zo3AFB4cjyCOsOfJElBu3CUSBsGj79GKcK9W6qP9jLRYrBw50FTvD8PH0jFJSsmv0EOT1NEZLz5o8DxMnCxqrXV4Fq4E9lY08Wp3aBQ3FeyQSe8Nq72NlaD1YyMLfyCf+JzCqPPa00UKOZbP9OaegI5NRoBECkEeyggYS8P5EtN86EYsVSjtJCXQVLdmQ/OmzrgjwDVAScdIoQeGyx4ejPCCVkqVDCqJ+XsB7o3X0XOeKk28kfzkY0xBkPX8snzJtjacefuaYlbx6DYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by DM3PPFE94346F35.namprd11.prod.outlook.com (2603:10b6:f:fc00::f59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 10:13:55 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 10:13:55 +0000
From: "Gote, Nitin R" <nitin.r.gote@intel.com>
To: =?utf-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Christian Konig
	<christian.koenig@amd.com>, "Auld, Matthew" <matthew.auld@intel.com>
Subject: RE: [PATCH v5 1/2] drm/ttm: Fix UAF on dma-buf attach failure for sg
 BOs
Thread-Topic: [PATCH v5 1/2] drm/ttm: Fix UAF on dma-buf attach failure for sg
 BOs
Thread-Index: AQHdDrU0ucZynDeGDUq+bIkBqJqqcrZjj8OAgAEbn1A=
Date: Thu, 9 Jul 2026 10:13:55 +0000
Message-ID: <SA3PR11MB8118CD97E2053C96ABA7AF32D0FE2@SA3PR11MB8118.namprd11.prod.outlook.com>
References: <20260708091512.205482-4-nitin.r.gote@intel.com>
	 <20260708091512.205482-5-nitin.r.gote@intel.com>
 <df72ae4a41d526c3db1577532d13260bbe331869.camel@linux.intel.com>
In-Reply-To: <df72ae4a41d526c3db1577532d13260bbe331869.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8118:EE_|DM3PPFE94346F35:EE_
x-ms-office365-filtering-correlation-id: 28bbd268-d031-4edc-e7e4-08dedda2c8aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: d3HALpM+NGcA08/qJX8bsPIxemYjO/bJA7BCI60yXCtX1V13CEDTsg79COKcy0pZYK9IcL94W8iIYK0eiKWISyiwLTgnjjx1wGM4rufQCuwfW95+8OIC8Kg1VfLO9UWjHgt2J7/WxZTq9buAUSIYxSNeZmuhEqXxH12Sy3n8YJ8JeSe5EnMqO5DNbxdDGpChLiyTDZmGIKfQ/4fHFKlu4wjbnIUNtwlzq0i5HWQwEJ6RvciyVOzwSj99OeLb4a/hwfG/EVtzC8dOualhBVXXeKkDqpn76KdBBf3tBj/1RpR03DVjZBrZb/63aYHmaufZ6+m3CrrX6jFckSsiE5vi1kvbfXjG/BMAavfWFkdOSP3tjaN15hYAt4jzSTXFMbxAQqA6TJtNsfpC+ISHwqxbC/4WpcIi85C1YlZUtMEAE+ccbj1hpp6s6skituXm39nN9geWK06clKF4urhLpbHxk6NsYQGBCGgKoKdKyhQsz+/jkxq8et9SROnoUIQd0IvDwA65OwNdaHHPGA4jONc6lIiXzp96hVJ/D8cbpTCH2U9E5qS96poFvn14l+ffXyE7ZkvXsAgqUv1b/aWCCzSt0I7FaKrPDMfd8ZNGW2RzTPIi3FfEygYEukn2+SRqb9b+VKK3T6Y+SA1dxUe1ggAFukQ1RADqMUVF39vI/tfkFKo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTcvNnAvRE9vNGQxenNoNEgrbkF6MHczb3I3YnRvaEJ3dkVGR0pEbFlLeCtR?=
 =?utf-8?B?bUNxWHoxcVpGdVJyZWxrdTgwSzNhQzlPYksvR2hCVjhibUdNMWFFTmxKNVVq?=
 =?utf-8?B?RklGTjFZWElTRG9OVXBveVJlMFVGZVVWQnVGSUt5Uzkvd2c4ZXNTR3RiWUx3?=
 =?utf-8?B?VTRSRVpFeTFsMkVBbUV0dDBJblEwRG5kUmUydkFHanJLL1JFc1IxdmZ0aHdI?=
 =?utf-8?B?TFFBTkdSTCtQWWVueVE2R0tHZUoyNTFESk43Yy8wYS8vNXRDemdlU2ZzbE9Y?=
 =?utf-8?B?dlZJMGZCQ29KSnVkZWFTZ3d3MDFWUmdyNEQ0dElyUUlyVVB1QkVFZFl1aGVR?=
 =?utf-8?B?ZnlKRS9QcS9xOU5sY0tLVmVjdmc5Ly8rMEZYN0xWVlBERDQzeUNUNjFnNFRE?=
 =?utf-8?B?am5ocVdpeTh0RGRUU3BrRGpYN2VNY2xxOWtmRGJRVWs5R2E2SFhyaXFSc3JG?=
 =?utf-8?B?YnZwdm1FT0NmTjNaTnRlVkM0MjE5a2ZycjBLcURyekR6a3dxd3ZEOGJTVU5D?=
 =?utf-8?B?SDNoZHRyOTlERkNMNTNuQXRVYkR3ek1PSlQ4QUdTZ1Y2VHdYbGM1VWdzYWU3?=
 =?utf-8?B?WUJVU1RvRnJnNjd1NThVdmN2NVVLMmNBMGxZTkJ0eWd5K0hPUXM4QTFiM1c5?=
 =?utf-8?B?bUZwWjVIREtBL2hxUmdtdHpWQ0l6cGhVaHo3dk9DRGRIT1VPVGdsUkZZd2lD?=
 =?utf-8?B?VWlGYm9uLzFaOW40elp1VCs1TFk0OGpLZDRQRlJrT241cDRwVUtLQWdmME1L?=
 =?utf-8?B?TXZsMnhzTXpDZEpXbDM0eUN5NnUvSncxNUFTNmVlbHFpa1NXYTc1TkxLZFM2?=
 =?utf-8?B?cHJnNFIwSEx2bHpoaGRDU002L2NBcmdNRVVtb29rbnlqNkFwOEQwbDUyQko0?=
 =?utf-8?B?cThiZzhHaG15T1FFRkx0aU9jSk05SlVBeWZ5UjJVQVh1WVl0T1pzSzBKNkR4?=
 =?utf-8?B?UG42Rk1FR1BJM25EaGw4Wm5LMHpVNlM2Ri9ickZadEc3MUZhbC96cEVocVdU?=
 =?utf-8?B?UlBGRjlIbGJxMG9sOUlWQ3BlZVZkT3lFQ09uZGUxNk1XV3lPa042RXhwdUNt?=
 =?utf-8?B?d0kzTjRTRFcranlLd29FeENsYjJ5MlZxY2pQMCs4NUtma25veWJOejZVbVNQ?=
 =?utf-8?B?Yk5qZGxpNVNNUGJWSjc0Yk5TRkVaWjJPc1Rja1NIWUpoelVzYzQzcHQ1QnNp?=
 =?utf-8?B?cVI5WktKTG5tc0RzVzZCS2plU0pUVHQrN3RTSmJ4cDZsbVhrT3Rybkxieklv?=
 =?utf-8?B?VWRzQXN5aE5CS0l1RHd6ZVJVVTJuOHpUWUEwck9EZ0dMVGxxaUdOU3hTRUM3?=
 =?utf-8?B?RGJZWlJXNUovZk5MOVpyanlxeVRrcDVQRnJTNHBPZW43Z214TzJ0ZG5ZZ3k5?=
 =?utf-8?B?eEZwK0FVbGZBc0tVN3BFM0ZXVVZzUFBwdEtpRDBjM2wxTmh1NGV3b0hsTmtt?=
 =?utf-8?B?ZVBQUy96THRIdXpwakM1NXZzbmViOEtaaGdsazFWS3ZxdFM0QmZua2w2R1lh?=
 =?utf-8?B?WlZsazlUeUc4c2FWUUI5aWN1MFcyQjRkRlNhb2c1OUx3Y1dHRkJiSDc5L0tS?=
 =?utf-8?B?SGEyS1VQa0IyWGQ3cHlpTGovN3FhclNlMXRORHFUWXVRd3FNTGdBdTRqMUVH?=
 =?utf-8?B?ODVDTU51anVROXhnbjNldDlZYW9CMWNTUVRNNFVGKytWTjAwdGdXNU9jdXBI?=
 =?utf-8?B?SVAzbHcyZTFldXN1ZkxzV2N0d1F2T2FOODdaNk9NdjVaOXRXSDFaM0lScExs?=
 =?utf-8?B?UklCRDJmTml2U1dWNHo5MlBMQ0JkWnpicUtUZ0dhTU1RVjlCd204a2dmRDFy?=
 =?utf-8?B?Tjg3Wms4bnA4MktMbXUvRUgydWVnRmFXK0NBTldLYUNPc0NNaFFsSTdJeHJX?=
 =?utf-8?B?eDVzakduVFZTYTloMEFIQkFLdFZZaWUyeHZzWTZpTGdaaGN5b1IwMFQzaFVU?=
 =?utf-8?B?RzdxWGVlWEkwcFJtckJGUUVuVDQyU1BRei80VktZLzZGRkxUNVc3NHhLUTl6?=
 =?utf-8?B?MlVsenk4VHNVQ0VLOWkwWCtueW9FWHpWbXpoNGRqeWZRMFl6RFlqZWl6ejhz?=
 =?utf-8?B?cWpCaU9WVXVYNXd2L253em1GS3VIQzhKcWt3Zk1QSmlZR3dVeWNXK0ZVeXlq?=
 =?utf-8?B?WklnWSs4Z1EyRlZ5dlBHalZPVWNreWZQRHdjZTYxWGNwVkNuR3Zub2VNbHds?=
 =?utf-8?B?dm1rSEFlaFVQSjFKVVQ4V3p1eDR0SzJQQ2pUaUNpS2VWVEFKdGJpVTYzeSs5?=
 =?utf-8?B?ZmY3WDZGZWZqUTBwNk5lZ2VqYjdjOWgxSlZFZ1NxQ1hRNE41OFBKbFh1aEhY?=
 =?utf-8?B?ZW84QndnVlBYUndDSzNNdG5rQWJROEFFc3dwY1VRMzJvRkhRM2Y3dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kvRFI1Y3jwBmqecSOcmWnHCdCz44FXjRsYGxixhd7d5OBi9IOqTFuVgFGQrg/kfUhftTUyOnKkJTNSDmf1kSKISxRGZWEsWcyGvdPVe+/xI6iN5fXT155C+rR+tHhj7N2b3p/JoC7IY4qbwa1pxYSwrpqnIpdCu+1qL6PSgU5Hgg4QRbLAGFHtkYW7cNO4oLfCa1MCYNmnWUCrv140I4BqVQs5xm4PbliYiCoOx/DlidJwHaRfG5Et5J6u5F5qa4laED2TLeQy8hleThzUqli/tFteADqHXvExcdEwxjo/7Rhjot3/G/XIcnk3vfIDKL79dmGrWHA2nAoy7VeZ1g8A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bbd268-d031-4edc-e7e4-08dedda2c8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 10:13:55.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: plPKD1+Z59m7uha+OVioJe1yLD/2LPna3Yt1MW4hCF+YlCKETiQ9J9/FFfzg0K8YaPH1W3MK9pZne5ZMrGjTkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE94346F35
X-OriginatorOrg: intel.com

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRob21hcyBIZWxsc3Ryw7Zt
IDx0aG9tYXMuaGVsbHN0cm9tQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBK
dWx5IDgsIDIwMjYgNjowOCBQTQ0KPiBUbzogR290ZSwgTml0aW4gUiA8bml0aW4uci5nb3RlQGlu
dGVsLmNvbT47IGludGVsLXhlQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZzsgQ2hyaXN0aWFuIEtvbmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
OyBBdWxkLA0KPiBNYXR0aGV3IDxtYXR0aGV3LmF1bGRAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY1IDEvMl0gZHJtL3R0bTogRml4IFVBRiBvbiBkbWEtYnVmIGF0dGFjaCBmYWls
dXJlIGZvciBzZyBCT3MNCj4gDQo+IEhpLCBOaXRpbiwNCj4gDQo+IE9uIFdlZCwgMjAyNi0wNy0w
OCBhdCAxNDo0NSArMDUzMCwgTml0aW4gR290ZSB3cm90ZToNCj4gPiBXaGVuIGEgZG1hLWJ1ZiBp
bXBvcnRlciBjcmVhdGVzIGEgdHRtX2JvX3R5cGVfc2cgQk8gd2l0aCBiby0NCj4gPiA+YmFzZS5y
ZXN2DQo+ID4gcG9pbnRpbmcgYXQgdGhlIGV4cG9ydGVyJ3MgZG1hX2J1Zi0+cmVzdiBhbmQgZG1h
X2J1Zl9keW5hbWljX2F0dGFjaCgpDQo+ID4gZmFpbHMsIG5vIGRtYV9idWYgcmVmZXJlbmNlIGlz
IGhlbGQuIFRoZSBleHBvcnRlciBjYW4gYmUgZnJlZWQgYmVmb3JlDQo+ID4gdGhlIGRlbGF5ZWRf
ZGVsZXRlIHdvcmtlciBjYWxscyBkbWFfcmVzdl9sb2NrKGJvLT5iYXNlLnJlc3YpLCBjYXVzaW5n
DQo+ID4gYQ0KPiA+IHVzZS1hZnRlci1mcmVlOg0KPiA+DQo+ID4gwqAgT29wczogZ2VuZXJhbCBw
cm90ZWN0aW9uIGZhdWx0LCBwcm9iYWJseSBmb3Igbm9uLWNhbm9uaWNhbCBhZGRyZXNzDQo+ID4g
wqDCoMKgwqDCoMKgwqAgMHg2YjZiNmI2YjZiNmI2YjljDQo+ID4gwqAgV29ya3F1ZXVlOiB0dG0g
dHRtX2JvX2RlbGF5ZWRfZGVsZXRlIFt0dG1dDQo+ID4gwqAgUklQOiAwMDEwOm11dGV4X2Nhbl9z
cGluX29uX293bmVyKzB4M2YvMHhjMA0KPiA+DQo+ID4gdHRtX2JvX2luZGl2aWR1YWxpemVfcmVz
digpIHNraXBzIHRoZSByZXN2IHN3YXAgZm9yIGFsbCBzZyBCT3MgdG8ga2VlcA0KPiA+IHRoZSBz
aGFyZWQgcmVzdiBhdmFpbGFibGUgZm9yIGRlbGF5ZWRfZGVsZXRlIHRvIHJlbGVhc2UgdGhlIGRt
YS1idWYNCj4gPiBtYXBwaW5nLiBBIEJPIHdob3NlIGF0dGFjaCBuZXZlciBzdWNjZWVkZWQgaGFz
IG5vIG1hcHBpbmcgdG8gcmVsZWFzZSwNCj4gPiB5ZXQgaXQga2VlcHMgYm8tPmJhc2UucmVzdiBw
b2ludGluZyBhdCB0aGUgZXhwb3J0ZXIgcmVzdiB0aGF0DQo+ID4gZGVsYXllZF9kZWxldGUgbGF0
ZXIgbG9ja3Mgb25jZSB0aGUgZXhwb3J0ZXIgaXMgZ29uZS4NCj4gPg0KPiA+IEZpeCB0aGlzIGJ5
IGNoZWNraW5nIGJvLT5iYXNlLmltcG9ydF9hdHRhY2gsIHdoaWNoIGlzIHNldCBvbmx5IGFmdGVy
IGENCj4gPiBzdWNjZXNzZnVsIGF0dGFjaC4gVGhlIGNoZWNrIGlzIHBsYWNlZCBhZnRlciBkbWFf
cmVzdl9jb3B5X2ZlbmNlcygpIHNvDQo+ID4gc3VjY2Vzc2Z1bCBpbXBvcnRzIHN0aWxsIGNvcHkg
ZmVuY2VzIHRvIF9yZXN2IGJlZm9yZSByZXR1cm5pbmcsDQo+ID4ga2VlcGluZyB0aGUgc2hhcmVk
IHJlc3YgZm9yIGRlbGF5ZWRfZGVsZXRlLiBGYWlsZWQgaW1wb3J0cyBmYWxsDQo+ID4gdGhyb3Vn
aCB0byBzd2FwIHJlc3YgdG8gX3Jlc3YsIHNvIGRlbGF5ZWRfZGVsZXRlIG5ldmVyIGxvY2tzIHRo
ZSBzdGFsZQ0KPiA+IGV4cG9ydGVyIHJlc3YuDQo+ID4NCj4gPiBDbG9zZXM6DQo+ID4gaHR0cHM6
Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS94ZS9rZXJuZWwvLS93b3JrX2l0ZW1zLzgwMjMN
Cj4gPiBGaXhlczogZDk5ZmJkOWFhYjYyICgiZHJtL3R0bTogQWx3YXlzIHRha2UgdGhlIGJvIGRl
bGF5ZWQgY2xlYW51cCBwYXRoDQo+ID4gZm9yIGltcG9ydGVkIGJvcyIpDQo+ID4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmfCoCMgdjYuOCsNCj4gPiBDYzogVGhvbWFzIEhlbGxzdHJvbSA8dGhv
bWFzLmhlbGxzdHJvbUBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IENocmlzdGlhbiBLb25pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiA+IENjOiBNYXR0aGV3IEF1bGQgPG1hdHRoZXcu
YXVsZEBpbnRlbC5jb20+DQo+ID4gQXNzaXN0ZWQtYnk6IEdpdEh1Yl9Db3BpbG90OmNsYXVkZS1z
b25uZXQtNC42DQo+ID4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaXRpbiBHb3RlIDxuaXRpbi5yLmdv
dGVAaW50ZWwuY29tPg0KPiANCj4gSXQgc2VlbXMgeW91IGRyb3BwZWQgdGhlIHBhdGNoIGNoYW5n
ZWxvZz8NCj4gDQo+IEFsc28gdGhlIFdBUk5fT05fT05DRSgpIHdlIGRpc2N1c3NlZCBmb3IgbGFz
dCB2ZXJzaW9uPw0KPiANCg0KU29ycnkgYWJvdXQgYm90aC4NCkkgaGFkIGFkZGVkIHRoZSBjaGFu
Z2Vsb2cgaW4gdGhlIGNvdmVyIGxldHRlciBvbmx5OyBJJ2xsIGFkZCBpdCBiZWxvdyB0aGUgLS0t
IGluIHRoZSBwYXRjaCBhcyB3ZWxsLg0KDQpBbHNvLCBJIHNob3VsZCBoYXZlIGtlcHQgaXQuIFdp
bGwgYWRkIGl0IGJhY2s6IFdBUk5fT05fT05DRShiby0+dHlwZSA9PSB0dG1fYm9fdHlwZV9zZyAm
JiBiby0+cmVzb3VyY2UpOw0KDQpXaXRoIHRoZSB4ZSBwYXRjaCAocGF0Y2ggMilhcHBsaWVkLCB0
aGlzIHNob3VsZCBub3QgaGl0IGZvciB4ZSBhbnltb3JlLCBidXQgeWVzIGl0IHdpbGwgaGVscCB0
byBjYXRjaCBvdGhlciBkcml2ZXIgdGhhdCBtYWtlcyBhIGZhaWxlZCBzZyBpbXBvcnQgTFJVLXZp
c2libGUgYmVmb3JlIGF0dGFjaCBzdWNjZWVkcy4NCkkgd2lsbCB1cGRhdGUgdGhpcyBpbiB2Ni4N
Cg0KVGhhbmsgeW91LA0KTml0aW4gDQoNCj4gL1Rob21hcw0KPiANCj4gDQo+IA0KPiA+IC0tLQ0K
PiA+IMKgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyB8IDI0ICsrKysrKysrKysrKysrKy0t
LS0tLS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDkgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8u
Yw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYyBpbmRleCAzOTgwZjM3NmUzYmEu
LmYxNTdlMjU5ZGQ1ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9i
by5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYw0KPiA+IEBAIC0yMDMs
MTUgKzIwMywyMSBAQCBzdGF0aWMgaW50IHR0bV9ib19pbmRpdmlkdWFsaXplX3Jlc3Yoc3RydWN0
DQo+ID4gdHRtX2J1ZmZlcl9vYmplY3QgKmJvKQ0KPiA+IMKgCWlmIChyKQ0KPiA+IMKgCQlyZXR1
cm4gcjsNCj4gPg0KPiA+IC0JaWYgKGJvLT50eXBlICE9IHR0bV9ib190eXBlX3NnKSB7DQo+ID4g
LQkJLyogVGhpcyB3b3JrcyBiZWNhdXNlIHRoZSBCTyBpcyBhYm91dCB0byBiZQ0KPiA+IGRlc3Ry
b3llZCBhbmQgbm9ib2R5DQo+ID4gLQkJICogcmVmZXJlbmNlIGl0IGFueSBtb3JlLiBUaGUgb25s
eSB0cmlja3kgY2FzZSBpcw0KPiA+IHRoZSB0cnlsb2NrIG9uDQo+ID4gLQkJICogdGhlIHJlc3Yg
b2JqZWN0IHdoaWxlIGhvbGRpbmcgdGhlIGxydV9sb2NrLg0KPiA+IC0JCSAqLw0KPiA+IC0JCXNw
aW5fbG9jaygmYm8tPmJkZXYtPmxydV9sb2NrKTsNCj4gPiAtCQliby0+YmFzZS5yZXN2ID0gJmJv
LT5iYXNlLl9yZXN2Ow0KPiA+IC0JCXNwaW5fdW5sb2NrKCZiby0+YmRldi0+bHJ1X2xvY2spOw0K
PiA+IC0JfQ0KPiA+ICsJLyoNCj4gPiArCSAqIFN1Y2Nlc3NmdWxseSBpbXBvcnRlZCBzZyBCT3Mg
bmVlZCB0aGUgc2hhcmVkIHJlc3YgZm9yDQo+ID4gZG1hLWJ1Zg0KPiA+ICsJICogY2xlYW51cC4g
RmFpbGVkIGltcG9ydHMgaGF2ZSBubyBhdHRhY2htZW50IG9yIG1hcHBpbmcgYW5kDQo+ID4gY2Fu
DQo+ID4gKwkgKiB1c2UgdGhlIHByaXZhdGUgX3Jlc3YuDQo+ID4gKwkgKi8NCj4gPiArCWlmIChi
by0+dHlwZSA9PSB0dG1fYm9fdHlwZV9zZyAmJiBiby0+YmFzZS5pbXBvcnRfYXR0YWNoKQ0KPiA+
ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCS8qIFRoaXMgd29ya3MgYmVjYXVzZSB0aGUgQk8g
aXMgYWJvdXQgdG8gYmUgZGVzdHJveWVkIGFuZA0KPiA+IG5vYm9keQ0KPiA+ICsJICogcmVmZXJl
bmNlcyBpdCBhbnkgbW9yZS4gVGhlIG9ubHkgdHJpY2t5IGNhc2UgaXMgdGhlDQo+ID4gdHJ5bG9j
ayBvbg0KPiA+ICsJICogdGhlIHJlc3Ygb2JqZWN0IHdoaWxlIGhvbGRpbmcgdGhlIGxydV9sb2Nr
Lg0KPiA+ICsJICovDQo+ID4gKwlzcGluX2xvY2soJmJvLT5iZGV2LT5scnVfbG9jayk7DQo+ID4g
Kwliby0+YmFzZS5yZXN2ID0gJmJvLT5iYXNlLl9yZXN2Ow0KPiA+ICsJc3Bpbl91bmxvY2soJmJv
LT5iZGV2LT5scnVfbG9jayk7DQo+ID4NCj4gPiDCoAlyZXR1cm4gcjsNCj4gPiDCoH0NCg==
