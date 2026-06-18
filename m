Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780E35E937;
	Thu, 18 Jun 2026 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780464; cv=fail; b=A7v3doLRyueE1S2PXzq1O+uOYjXnOIfP0SiZPPHvM2izAH4+sOnd+LIDubIO58IJLp6uM12CQFWjGc0EngPjpo8iEYXkF6OZvOqKynTD+IAsMt107eK3wDY8TjA1xROaX3uMYYU9v3GPi1Tgdwq3U8i8NumjTm3BQmM1Vo297g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780464; c=relaxed/simple;
	bh=2UTZcnAbAUzen8O6gNImRkTv8M36hKv3AAK2/3HJEV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eTpJLEalmm55wzcQ45IlWvs6RYqH/eNu79he4F7qWVDBR9GkcyWp900/9PgESm/o14Uj6+uEONh/zNexJcZ4zq/heNVKh7xM2Oew/SLIGcJxNy+vGwBX2HMuf2rGNunwXhZo8mCF+UbszWel1+AuqZE/N6yoeHI4BwWsFLSiKMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaaA8OEb; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaaA8OEb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781780464; x=1813316464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2UTZcnAbAUzen8O6gNImRkTv8M36hKv3AAK2/3HJEV4=;
  b=CaaA8OEbk8iHG5oyppfK4fyQexxK3QrqY8cwcMNk73AOGimE4ITle7Ga
   DdzzuhZ663KuRxfjkKPWjJf5s0WexBRfAT5zgkxJ+FoRoG5dkOoplyenL
   2xQzDO+isepbIQ9605EcNXT3d8qZXz+4V6WhMJDgm7nAky3xxM9M7sb3A
   y0N0RuhS0W3eIVRJNL+PDJjcDoZqtSyr9mgrJFmO7wCd5VwYcrUWdoCKl
   JTiVsFZNsyFlnrlTxw/I/SJLkKzWl2+f86YswEseqFDWTnbKX0DVM46kY
   /fkNAHE2PmSMDhQvSFsugBJ/6MjW3s2c3FRs0qYrs5A3pmzCQNfpsxFsE
   A==;
X-CSE-ConnectionGUID: U4aOjkreRuG8haJ26iqvSg==
X-CSE-MsgGUID: w+2n7T5TSrCrGY+ba9ohxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81720462"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81720462"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 04:01:03 -0700
X-CSE-ConnectionGUID: opKqsV1+QAuNnwUDOdfMdw==
X-CSE-MsgGUID: K64BpVHVRpKsu9Ng8ZwC+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248206381"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 04:01:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 04:01:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 04:01:02 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 04:00:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg//npmH61wut7SbTz73OmlbUydFPhTbg+CXsqi/PsgY9hkJZtritEsRuqMpoSlqSXK9pGNMPFrN6t8a6n9zd7K0TG7xQ+R81cVDuYtKOQoNqnB25XhlH4lLqNJ5Fy5eJ/t9ItFrSahC1ehmv2KAGhLyHCbSNyvs22Ne4e7X5bw3nYsfOn95R3KhEUmWwSlKhmfbTmQhuBOXBnmBV6t+eL1LFMnu4xIr9WiwsFMsPb7v4Z0GsHl6boZ9TfZFg822gsFwmtxorVzwaR4Guf6ZzrYsJFnRIdm5ZGnOKxnI4HPmxrXhNu4DIzJangMko3bK/SjfQtoM4vNB5lc1qubsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UTZcnAbAUzen8O6gNImRkTv8M36hKv3AAK2/3HJEV4=;
 b=MOgrAPBizXZi1KVugAYz89suSd/LOhJn7Itre5Iha5+8JblNY8cvXvBrcvIJJ55J2E4R9eBeAxrxNuVoVoaZ0+XUdBpJdtcuV0rUXfFOwIVNLT/bC8kleQZdD22T4SCuXQbtrA5k5K65H4aKnli6GrOdnz9JY/QMYZLRfoDYyaCL+3KmtuH8/9dqBe34Ij21ueHV38JK5I8r85xBs1aac3xHIskZNDGXutH7X3+E+BhqqWXXecnIyBD4nywF7ED4zTU6zNSuE29KEi0KRP4I4BB4IZQ/nUyMS5H1czDXscfZiAFH+BkI+t7p4QfyhQF2lRl+nBuhHXx87xN6m1Dzag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA1PR11MB6242.namprd11.prod.outlook.com (2603:10b6:208:3e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 11:00:50 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 11:00:50 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "yosry@kernel.org"
	<yosry@kernel.org>
CC: "jmattson@google.com" <jmattson@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] KVM: nVM: Ensure INVVPID is emulated on the correct
 physical CPU
Thread-Topic: [PATCH 3/3] KVM: nVM: Ensure INVVPID is emulated on the correct
 physical CPU
Thread-Index: AQHc/dnrNzVvTeXvpUS9nV6wg3t5hbZEJ7qA
Date: Thu, 18 Jun 2026 11:00:50 +0000
Message-ID: <01df728334062de2da94c587c71f692004993653.camel@intel.com>
References: <20260616214652.2157032-1-yosry@kernel.org>
	 <20260616214652.2157032-4-yosry@kernel.org>
In-Reply-To: <20260616214652.2157032-4-yosry@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA1PR11MB6242:EE_
x-ms-office365-filtering-correlation-id: cd4ac627-d46b-4c03-e2a0-08decd28dba7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|18002099003|22082099003|6133799003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: C1DP2ZaQjXpoT7CpizESsE4lk8UNDFPHcZh/g9VxDJ3MJrAIiCT9BLJjIlG37wiZ9wSZ0BHjPbF/AuGkLpzOFJvACR5b4DEZEhNs6xOirxJsL5lAOqFWNtt2MROdn4I7Cf/mLajS85tgjbHIVmkSqF0MNZkLWobHI3EAfE8+ZNSJ0jOpqwNvMUogYZDIVpd3POr1fCraO0H038dHuoRoin2pLC2MIvwSXFNcycr1OU2MCr1uHspFOXKcxuTWzWcEgOOz6wmMwlpH/qNKQQE3mU5tfiv7XPjanQkuupsIpCJo1PXwcRsgP/Se77teIUOu1NtyFgryMwYPLZ0tMIo2UEqteCacRieH0Lb+GkbDJz5fhVBfsSgiNTzR/P2LTbOixHrjTCxW51ya0tE0VtLkj5LnsdzrM5TTlv6xwcS92V8z49qTwMinLpGgZbRG6QSPn7BiMz0iDZOKD6GJ//s2onf7fExARO0adPZuqVPdnTOLj3iyGOiKr+2DoXGE8sTWHGlmOB1egqMuVXZ0eKFbNsKTSMvqTjbc8HXYCX/r5WaCS5sxFRFNIPfD5irrBExwNdGFyc6zN0gDy9XbGk3J5GFXUlaBQq1R0aDujQVRrv1ug/d8QctpYHfW/bZEfb1iMc3DY0alcl+1J6FAxKPNXjRg2vYmihB7FH5Y7iQv//TKa8ha9yUPpFI8vbXXAyWPMx1vef5D4AfRQ1jDmEoxkFrWzWx8tbE6RU3ZxR+YIabYv6jeSzBr/zhtOi02XTHE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWdhVkV1NkVsc1k0NDFEa2wvYzhHWHZvQXN0TVJLN0JXQjF5Q3JIV0paaG1N?=
 =?utf-8?B?YXlnUGJ3VW9uVGlnTkpTOSsyZjFVZEhwQjIwdmRLTmVIb3d6eHNHcFZJMUJ5?=
 =?utf-8?B?VFRqblc0RFdNTUlqQ3AvWVZqNms5aE9QaHhyQnJLNzdsZjdaUE5OSUJaZ1Bo?=
 =?utf-8?B?dnF2R1pOOUlhemE5eHJCVTJxa1pVQWVtMGRvWlNiRXg4OHVlNHR5RENsZFJ5?=
 =?utf-8?B?WXdLRHdJMElWblJpWWlJSUozajRpOTRVdVR3QlVxTDZ5c2ZxNDQ2WHdHWGdz?=
 =?utf-8?B?a0JEMkoxcDBFdGZFTnNZS2p3Wkp3QmFtdXFES2tsdTRKVE1xV3BNNDE1VTNL?=
 =?utf-8?B?TTdVMWw3SjZNTXZ1N0lyUitoWEZpTFBVdVI4UExJWjRDcHU4ajRZaEZRUlhJ?=
 =?utf-8?B?SEFBUlN2U2ZzMDY2MU9YSUdjY2pzQnlOdVczSnRrRFJlS3ZDMm05SE1nbEtQ?=
 =?utf-8?B?Q1ZNSXBydzBUeUI0eFJvVUVTVzhvK3VhaHprZ1lyMm8zak5hSExaYzF4N21M?=
 =?utf-8?B?QXFVZDF0STI4bTRrUWhSTjRHMWd1L0ZLWDVPWHpubzhLM3l0NG1jSzBMdTkr?=
 =?utf-8?B?NmVBNjBEaFBDWCsyZ3lkSStXN0h1dTZoS1crYTh2eGR4RFZoSEdqSi9kaThj?=
 =?utf-8?B?elV4bFVDRm1mN2xzVnljam5ad3I0b0RnN3hpNm1ZL1RjaHRqamNKbDByZHBn?=
 =?utf-8?B?cUQxYTJCdTRtQnNMVVpLLzBmcitFNTFPcDExTjQrR0sxL2lDVlJ3UWxBc2h6?=
 =?utf-8?B?cUk5b0k4K29CYjNSV1RMU29ldUpKSWVXOXRzUU1HVzA2Y0RyTUtFTzk5ZUlU?=
 =?utf-8?B?S1czN0xHdlFGMk1JUmxkTkVzUDg5UWlMWFJuQ3hLTVpMcUJ4ZlVtV1dGWTMy?=
 =?utf-8?B?bHc2UUxFRVprODh1b3JMZG9ybHQ0SWFxOEJnNFFXQ2dpVElTWkovemJZdG4v?=
 =?utf-8?B?dldGOGNnNWorR1VFUnBXWnRneFQ4RlhKL0pIRFhiODIxd28yd3g0U2IrRmRW?=
 =?utf-8?B?b1paaXVLMi9qa0pxbERiYnNyKzZmMkhtZVJYYUxRZEJnR3Q3MXdVQ0pMQWp2?=
 =?utf-8?B?V0xpbkMwd0c2Y2Z5a0EzamVMWE1kSXp1UGFSWEVnTGNOL3dVUTFUenIzZ1lu?=
 =?utf-8?B?c082cXBudytPQURxTUwvMVNtQ2NyVjQ1VWdYS2RRU1hSb1FsRDlmYnZwRG1I?=
 =?utf-8?B?YkNrZFlnckZTL3ZMQmxaS3NKK08xdlNoTGIyUHNJaHZ3eDVWaWxzcTV2SC9S?=
 =?utf-8?B?c0lSTmpkY2l0NnVueG9jVy95UklJck1wSW5hWHFRTWJyTzVGYmFLa0NlcFNo?=
 =?utf-8?B?NEhKOTBuVURuNWV0Q21WRHVYb29BcnFDZk1sazdOR29QVG5VTWVrSFhyRm1Y?=
 =?utf-8?B?Zk11OCt0Ty8rNVpZRkFDUTVHSHlzL1crQzlnaTFDai9jcUZZdVB3Y2laUXRN?=
 =?utf-8?B?Z1RwZ2ZBdzd4cXF5dDZUSWRSZVB4Mnl1ak1mWXRxbTNsYlY5Rnd2bmtseDVS?=
 =?utf-8?B?ejRTU2R4c2dQN0RiYVFHczJyQXpjbTlQV2svQ3NtUXJuUVNONzJyRk9mRGxO?=
 =?utf-8?B?bXRZSjB6MXVTZFdRV3d4eElWSzJkUGJsdlhSVmpxTlpCN0ZmbkpmcWZ2aDRK?=
 =?utf-8?B?VkplaC9jYlJrWS96MUVzK0xIUExaR2JhR3o2V2JRTEV4SGNXK3p0OUlVSW5I?=
 =?utf-8?B?VkZtR09KMCttZGMvVTRsKzkxSXNjWUdNcVlBSWlXSVZuT2U3azFqZUlSU1c1?=
 =?utf-8?B?bnBwUXczUlRQbVdYSE9DUXh2Uk1NdFczMnRWd2M3RGo3ajdmNElpZUtvN2VG?=
 =?utf-8?B?dFVQTHFEZmJLYk81NzBlL3BZQmQ2d1hwbitCdG5rS290NUpUbDZ0Ui9GQUhr?=
 =?utf-8?B?NENQSkpMcG5GRncxNFR6L2hRTzlnY1lRMXVoRFc2cXh6K055NXVjaEtZR3pV?=
 =?utf-8?B?RmZKMFZ3bXllZUd1bng0UXZ1MWVFRHRHeDVJWU1VK05KVzB0UlgrSGJ2YWlY?=
 =?utf-8?B?ZlZXTmhLYU9UVDFVNWNJa09KdzVCOXk1SzBSZ2xsSHRvT0RxOStGeWlwY3FH?=
 =?utf-8?B?TmhTYU9oLzliOFlXS3FvOEE1U1FXQnRnRXVYZlQwUk9icDZvdVVSckRZdXI2?=
 =?utf-8?B?L0R0NHpFcE9RTUFZNzJYYmEwWUF3d3BwU1VrVEVKNlRIZTVPUDJHdTJOVmo0?=
 =?utf-8?B?TlBlL0xUZFEyektlRGtUcHIwNXZqQXR5RHBNZjJNMEx5TWh2bHdhd2JIa0xz?=
 =?utf-8?B?OVhZd1hBYVNtUmlNejdXUW5JUS9ydWh5dW5ja0o3dWdackRrY0MzeW4zSGhz?=
 =?utf-8?B?VDcwcDh4ektVcnlMalF3bDhFaGxGUGpzb1EzaFAwQUxuc1llVVdTUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81EFA51669F9394FB387F90F2306E865@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qF1RvpjidjJrQscD664v0p/rCJPRwqATcZW77ZrjBCTRY4i73+Jqizyqwhq6qa3Qpgf8AWGdUNtcl6lOYNZZOFcXdE1Jkc+cz0RkEgJd6U6fcmxeOJ/NEV+P6kHON+TfkXM8CGxygCTtNTUyKXz2OhTbPyo2pw0LBUB+uVsCWh/ug0h+ckvmVD3UFSkorcKHeMgOlhx1gMpOEiEONeTnARLnVauGIEuVJ9SukVIWyMSE7zNV9sEM2O6p8FboXQeCSdC1D2XMwgJumMBApO3XcaHjISFVd8AVZVUypV68HtpO0i3j6N//93az95dNsNXpjxyoheChsQF2CT8ZyxZZGg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4ac627-d46b-4c03-e2a0-08decd28dba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 11:00:50.0293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qr7r4YCK4PkZYrNx5tCB9wL7VnOkqDtiBDXKCkvgR/zBIPqrgIcXTguesl0NF9egsp2AaT5xIJFoL+nNoLcaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6242
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA2LTE2IGF0IDIxOjQ2ICswMDAwLCBZb3NyeSBBaG1lZCB3cm90ZToNCj4g
V2hlbiBlbXVsYXRpbmcgSU5WVlBJRCwgS1ZNIGV4ZWN1dGVzIElOVlZQSUQgb24gdGhlIHBoeXNp
Y2FsIENQVSB1c2luZw0KPiB2cGlkMDIgKGluc3RlYWQgb2YgdGhlIEwxIGFzc2lnbmVkIFZQSUQp
LCBhZnRlciBkb2luZyBzb21lIHZhbGlkYXRpb25zDQo+IG9uIHRoZSBvcGVyYW5kcy4gSG93ZXZl
ciwgaXQgaXMgcG9zc2libGUgdGhhdCB0aGUgcGh5c2ljYWwgQ1BVIEtWTQ0KPiBleGVjdXRlcyBJ
TlZWUElEIG9uIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBDUFUgTDIgaXMgcnVubmluZyBvbi4NCj4g
DQo+IEZvciBleGFtcGxlLCBpbiB0aGUgZm9sbG93aW5nIHNjZW5hcmlvOg0KPiAtIEwyIHJ1bnMg
b24gQ1BVICMxIGFuZCBleGl0cyB0byBMMSAodm14LT5uZXN0ZWQudm1jczAyLmNwdT0xKQ0KPiAt
IEwxIG1pZ3JhdGVzIHRvIENQVSAjMiBhbmQgZXhlY3V0ZXMgSU5WVlBJRA0KPiAtIEtWTSBleGVj
dXRlcyBJTlZWUElEIG9uIENQVSAjMg0KPiAtIEwxIG1pZ3JhdGVzIGJhY2sgdG8gQ1BVICMxIGFu
ZCBydW5zIEwyICh2bXgtPm5lc3RlZC52bWNzMDIuY3B1PTEpDQo+IA0KPiBUaGUgVExCIGVudHJp
ZXMgb24gQ1BVICMxIGFyZSBuZXZlciBpbnZhbGlkYXRlZCwgYmVjYXVzZSBJTlZWUElEIHdhcw0K
PiBleGVjdXRlZCBvbiBDUFUgIzIsIGFuZCB2bWNzMDIgbmV2ZXIgcmFuIG9uIGEgZGlmZmVyZW50
IHBDUFUgKGkuZS4NCj4gdm14X3ZjcHVfbG9hZF92bWNzKCkgd2lsbCAqbm90KiByZXF1ZXN0IEtW
TV9SRVFfVExCX0ZMVVNIKS4NCj4gDQo+IEVuc3VyZSB0aGF0IElOVlZQSUQgaXMgYmVpbmcgZXhl
Y3V0ZWQgb24gdGhlIHNhbWUgcENQVSB0aGF0IEwyIGxhc3QgcmFuDQo+IG9uLCBhbmQgaWYgbm90
LCBmYWxsYmFjayB0byBjbGVhcmluZyBsYXN0X3ZwaWQ9MCB0byB0cmlnZ2VyIGEgZnVsbCBWUElE
DQo+IGZsdXNoIG9uIHRoZSBuZXh0IG5lc3RlZCBWTS1FbnRlciAoYXMgS1ZNIHdpbGwgZGV0ZWN0
IEwxIHVzaW5nIGENCj4gZGlmZmVyZW50IFZQSUQgZm9yIEwyKS4gSWYgTDIgZW5kcyB1cCBydW5u
aW5nIG9uIGEgZGlmZmVyZW50IHBDUFUsIEtWTQ0KPiB3aWxsIGZsdXNoIHRoZSBUTEIgYW55d2F5
IHRocm91Z2ggdm14X3ZjcHVfbG9hZF92bWNzKCkuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBZb3NyeSBBaG1lZCA8eW9zcnlAa2VybmVsLm9yZz4N
Cj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
