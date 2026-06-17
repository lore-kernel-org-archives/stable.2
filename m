Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834EA3B6C0B;
	Wed, 17 Jun 2026 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735856; cv=fail; b=ozLUxvbjDDraloDTEmg2ziv6URmb8ThuKJTOZnrmGptBMGCK9h5rwYfMkEpqJpQwz3ekuczgyAPxQKKOEIydUGAmcIZUpyBW7q30hIogHQZyUQ09MFVfS16tdVKFaQJUYfxSvHzi9uVr7CC8YxPG4fi+tsKVFpa+btSybtDEJvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735856; c=relaxed/simple;
	bh=f5Dlu/zgI8YwvIHurxDRq8o0x2uwffG3dEJWDkCVS1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hUFhEusQSanYZ2S5clMrt0LDv2n4oq0milxOQ0TocL2Cxm8g22jeOA5iz0J9APoGCyiTLITYfelokzo5KJk9dWZvm/NT1guTQD868mLeGmlBR37F3IhocrsPI8Z+lQSVvPVjIrqEcEMLUQKQkftD/oPwWCPPu6p2tFQjBQctccA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsTaOak3; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsTaOak3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781735855; x=1813271855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f5Dlu/zgI8YwvIHurxDRq8o0x2uwffG3dEJWDkCVS1c=;
  b=VsTaOak3LzgAE9sVIyiwLaJCkfEjYLAryTcZj0N/uM0GowQbM2I1Supr
   6kMBVj14ZHKktxw8w+E3qMb9Usl2KAZ9ZCHR8/prt5d0jtSAOEtPdL1bv
   j0rBOoajWrKIgbtk0cW+GmADXtAfrwHF6S4F0l6lheqkZ4jrv9KHoSIxT
   DeYORM13g93UV6jVoCjYvq7kzIl1DF3WRdrF/OiTsQF3TCey9CUQZgdeD
   iyisaHaGVPsxsOhMmZvnZ+Xm8Tvdq4hmx1yeSfHX87hEgEllmV7XZ7ppl
   1lg9Y/RRT49X0UgmVvEVrRFgonYAOOPM3x5eYKMEshptnFkUUHf1gwi3t
   A==;
X-CSE-ConnectionGUID: WGUvqGVwTbaTvSH5YmmyNg==
X-CSE-MsgGUID: PBNM39e1QkOdtquv9vkHfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82753502"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="82753502"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 15:37:34 -0700
X-CSE-ConnectionGUID: l0EGuG1UTJ+xsphvLv3xOw==
X-CSE-MsgGUID: 9gJMTj7PRiqk0qEcnvVRFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="286302729"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 15:37:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 15:37:33 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 15:37:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 15:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzVdz3NtBn24NB9a8V0l0SyHIMZRiTbjwQMbC7Cpxc3hFa2+Pt1L7nMUCeO9T4pt69bvfFvq8ROUzWJNr3JW81PKdCYqn49Hc21VWmmA3KXIUrFrVIavnk5/A1GBi4vaS/iea4TgTtIN1DPfdDUNJJOBji4FET4Kahf25cdtVxJvdtPORbIgyY8iqjD3tcUaI2F0WpYtF6/Gu9SAcGU7kHBUXEY3Cf6x2XQOJgyy5f/t+MiOnKrIEg1qsfAhhXTrsGsAfHpcFF2MdY6cHT5ZCdWy766uiYXSSQ87aO/vgME3NssokoF1Yow89R1VajpGmD9n/kRYFelCCqZ1pWzDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5Dlu/zgI8YwvIHurxDRq8o0x2uwffG3dEJWDkCVS1c=;
 b=aF794c23kamERJw5L4K4cLsJJryUqS1Owa98Hop9HHerKzwULJWnIkI2iiSuv/ZTIQnAhYpAY+/iN3rpJDRNhCefI0A3qtzOK5rS43EAIcDoYI1Jc+/TUIJ6Ao958n+clvavHEXGHRRZWgYVFlkAe0zfDViYnGChSiHwVVchKN7Eilrm9tge2QjInfmlRXUd4bfvESPm3LFtaAHhNgYj8OLjV6ZGgWTLAquJu1IGCO/ZyxBeSLkadJxtxRhK/JI5L02byDyUsTSNAGdr6OvmS1u90PsuFIEmzMrH3Iv0BtwgLT8b1BnZe93RNjbU8L9xbecTJi7DNuRF8jVqJI/FiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ0PR11MB5117.namprd11.prod.outlook.com (2603:10b6:a03:2d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 22:37:30 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 22:37:30 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "yosry@kernel.org"
	<yosry@kernel.org>
CC: "jmattson@google.com" <jmattson@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
Thread-Topic: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
Thread-Index: AQHc/dm+vhBqLF7f3EanPIP01uKgGbZCncWAgAAZzgCAAJbYAIAAAI6AgAAGDoCAAAMGAA==
Date: Wed, 17 Jun 2026 22:37:30 +0000
Message-ID: <599ad9edcf9817fb1c4c37aac135e9d83c408306.camel@intel.com>
References: <20260616214652.2157032-1-yosry@kernel.org>
	 <20260616214652.2157032-2-yosry@kernel.org>
	 <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
	 <ajKbCii_1LpyQKjJ@google.com>
	 <861c890587cb8cd0e2893ea4041555d33d8e9db4.camel@intel.com>
	 <CAO9r8zOMkyjG+a8YLGskEaHaLpGyo4qnrHBGJu=pZc_4a3bZWg@mail.gmail.com>
	 <ajMfH1kWnzFuHJoU@google.com>
In-Reply-To: <ajMfH1kWnzFuHJoU@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ0PR11MB5117:EE_
x-ms-office365-filtering-correlation-id: f672997c-347b-4902-30b7-08deccc10458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|38070700021|11063799006|56012099006|22082099003|4143699003;
x-microsoft-antispam-message-info: ZiQjUm3NGn1rIWEv0nB1Ronn+H8yaWOBC/vWDhBvRc38b8saJY826PM9fH0wWfvE2PDfKmF/mmF3FsP2zjCRpSFHK0DXo8EztcgbVcr/gv3/H3gNDR/ARKwH6yeas7eLz3uXcbr1RcW7UiX3CX4X6eQiLjZtj12KSmNjy2/sLZrinh7cyjRLV1RwcpwqnbukiUdL1gj8xiA0DJfyMRKLyLSNs1aOyjQynK/psuyMgU7oYuaDSJkJoaJlQDNdgzNiOlGF2ZLcakYsBDcLR0Vc7HAp5yq3nf3wPUiwoDITgfD5mBxibc603Eq+tsSGSwgEFIgiLcjVEECdL5bii8dkP4qy4FMygY928rBayAsXZvXg83+V5PONzIIo91aPB8VDzCNA64il32b6JGdKK6tBPgwjSQOD8FyIccwBFVmHd07OcP+VbfQNPQIXXPh1XZm+L8yQiTTQeuDCh3UFIvebfUYYC2Lfxcmj3RF2tKFR7vSApBGmGdC4RlSNeUio+SaFJMu7M7OgRit2Rh5qXYtbTyFwzkuCMLsuGn0cZjfHnZ+RTkaqHo6B8MlqdJtF30uMvebIFxGGh5uCsBkiSO5A6ljWOy6PmiRqoYBowpuRTsjvADXQCo1w1+pq1w3aYMDeaiNu5WqX2cdrhseTVz1D2vRKQzq1rI5aUVqPoyXraMbRx4QnVTBWmJ+ltA7dpJ+x6wZABzQ3UZchWlGSmGqiJWU06JQxZG0pyVxsdUMwEd5/TqJ3DWkKKPyK83oaarAk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(38070700021)(11063799006)(56012099006)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHRiOHl1SFdyL3VwTHdRak0ya2greVgxMTI2dWhicmkrMys0K0M0dndEbEFa?=
 =?utf-8?B?UDlyUWozU2hycGZKek1nc2ZMM3dmZTk1VDNnVmt6elk1SFJpOGdGMndWOUxN?=
 =?utf-8?B?N2pZaUNYZ29HdmNDcStsMGIyMW5QS2oyTFJCSWkzY1RNMW8xM1RnNHNvVyth?=
 =?utf-8?B?WVZ3ZkZHQzcySVkvTEVrcFVvVHh3UmRlZG56ZFVCN3p3SmhqdDM2MXlQUjhI?=
 =?utf-8?B?cVA2bWV0K3l2MmZVQlo2cDdobGphZGdDTWxIVDd4Q2NjekNOU3FuOEozTFQ1?=
 =?utf-8?B?eVcyU0luaGZjekc4dFBQZHlySTI5cVdsTDVLZzIzRTRZZ2gyN0ZoNjBuZGJw?=
 =?utf-8?B?Rm9jYWEvZHhnQ2xXckwwRmRETE5WMFhCaDRhWlM1K3I0dWEyc0xZY0sxeGFV?=
 =?utf-8?B?d3piNGFYd3RVbkd6Q2RUVnlkVkxHYVlHQ0RSSkg5YXZ6SmZ4cExadGRkMk1l?=
 =?utf-8?B?aUhlY2x5V3NPN2xvenRXalFxQjJDZlR3b3A2U2MrSjJjckJYb0VNclJ1b0t4?=
 =?utf-8?B?VG9uNVAydGNDN3QrVlBKUW5FdjUxa0lWaW1ReHF3V0lBOGw2MEFzZExtYlE1?=
 =?utf-8?B?TktlTkRVQTA5UnVkTC9DdXFRaWV6S3dTZnFiWmIrZkkzbzFkOTZ1U2NYbENP?=
 =?utf-8?B?cU5lZll1R2Nnd21OUlhOVkxRRGg5OFF1cEhpZTU5MmFwSHhaUTdod2hXWDJH?=
 =?utf-8?B?eVlPL0ZJYmNmRVJlS2dVREUyQkNBUkR0VGVKNWtpck1FbkpNbDFlNDFrczhn?=
 =?utf-8?B?ZHpQSTVmY2kxeldBcHl6cWwzNVo1NWs3RSs2anJySFN0ZFNlbyt0K0szdTAz?=
 =?utf-8?B?TDBTU0VsN24zRkhzVm5MWlJuMnJXREpzdGY1NjR3VFU2TVBtSUZOUEVmR3Vq?=
 =?utf-8?B?c0hJY01EaXYxSTZlUm9vaTJOZXdmYXpwcllndEZPRWxEZkZWcTA3L0E3dWxm?=
 =?utf-8?B?WmNyV2poMDhrVi9jVnM1VEZCRks1akNaZytSNGpzTENUdjBHd05sVzFYUWVr?=
 =?utf-8?B?empqNW9vY2x4ZEh6bFBEQm5WVFFVa2YyeDVJVCs4TWNhQnN0V0FCM1dZbVFU?=
 =?utf-8?B?VWNSbXZLSGhTay9WTDNqSkRkTFJPV0VCYkVrdDZGUzkxNE4rV21UREhlTjBB?=
 =?utf-8?B?SDdrRDdia2FCZ1lvRGFtSVdhQnFJZ2dpMGkwemEzd3FjZHZwYW5zbUpzRUhU?=
 =?utf-8?B?YVJib2JMemVEbEZLKzdDUFlvQU9ZdUw0ZXphY0g2TFkwa281NlY0UHA3RXpG?=
 =?utf-8?B?Uk5NVXhzVDBQcHM0eEJlT21lQTVhN2RuODY5b0h5SzZUMmRZZGpaekhmaDVy?=
 =?utf-8?B?YWt1U3BPSHVDSTE2dHRaNDdzNVk0ZVlFMXhtSmE0ZGdSdkVucnVSbXArSWNY?=
 =?utf-8?B?cG5aa2EvVkRWcHdoUTZCbGs3QmxPbmR6Wk8vVnVBRm4ra0JaMEFvcU9Yc2cw?=
 =?utf-8?B?Z1NUZFFWSTJzNlROZ09TUUV6b2RCeG5OdkJKa1daVVBDNytFcUIzTDQ5azl0?=
 =?utf-8?B?WlN0TjZCRGNLVnl4YzUxS0RMQlBBNWNlODl5NDdCbGUvNEtkbk9QNXRHOHRG?=
 =?utf-8?B?TnpjbE1nTlQxTDNuT1RqTjd6U25DZFBiZWhCMzcrV2tOUW5zeVlPSGxOVE9O?=
 =?utf-8?B?R3RFakxiMzM2VW1hUEJVUFVFK3JSOTUzQUNXWlQxNm5vSGZ1UEZTYmNrdkEz?=
 =?utf-8?B?MVhhT2V2ZTZTTGsrYTZxNjg5bkx2UXhjRGRpdWZYeGlvT0NaS2hTWG9IWUMr?=
 =?utf-8?B?VTNMT1dueHdhdTdCdTlQUmJOUmtOVW9zNjNEblovRytZUnVyOVAxTjRFSWZY?=
 =?utf-8?B?cUVxcVl2UDM3Y0s0a0hML25Vb3NRQVI1cGFmVWFuYUVicmNTOXpFNmFUSUxp?=
 =?utf-8?B?V1pudjdmNlBPelZBV3VWNUIyVkxjWkRnRlQwd2N5UHFnVnZKTTNLYWNpMExu?=
 =?utf-8?B?YjZOK0tNdFlUcUwrdTZYV0w4NWEwcjM2SHl2WmMxdEdlRnd6Rk40SXQraFhZ?=
 =?utf-8?B?KzJNVWlxOG0xT256bG9ua0Q2aTM5RWNsbzFuNFpFUHhrM0dDcmdkaXpXdlFk?=
 =?utf-8?B?Z0hkdXZDQkhyb1dMU3BWWktGYkhIc2hHUkdzd3g0aiszZ1Y3dnJaejViSDFU?=
 =?utf-8?B?ZHNIZkNmaGQ3L1BMb0E3K0dCTEpiNDJQUVMveFBjZWQrb0hsOURSYmFoNnkr?=
 =?utf-8?B?dmNpc0xwdmZXKzRlQUw4N2dQL1dUNFBmTXkrZkgvNGhET1dpMkNrWnJZN3U2?=
 =?utf-8?B?Z0lJTWFkdWJtMGdlekMyVTcyYm5mUitzcndoWGlLcFAybHN1ejUydWp2YW90?=
 =?utf-8?B?MWVwUmhld0J5ZVdsNmdWcldNUGZnR3lZaDZhZWZMMmRYYzhlbmJXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FAED40C83A1DE49B7499F9566579746@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qybAzaM4uMhR6koCWMjK1RP0a04mJxprpWB8WRdfqeT6ONuk0MrxZSVZEo30y/sjzDJhB4VxHd6ICuyAX2clBm4NNBoRK/Wr09QxfmQdrnBujDWa2gk62rjAdILDHjEr6xq4hlSelD4l/WJv0Ha43KIDUnU1I9dRmD0CMcaZ7/5siH5b8KRe7pCJsWzQ+nkeBopQjV5N/SeCWnjN5ESNvfhzsSPU4aGOpj8U9w3afAmn3EfJs2WNo8aaqPRgnwhzb8Vg56tZ+kNJAqAtjCaOTvkDTtRMw8d9Xk1peVshTSIc5ZMbr5tDdffhhfi7QamS2JVChUTEFUgqQf9gvEHD0Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f672997c-347b-4902-30b7-08deccc10458
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 22:37:30.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RG1g7IHmOjqTLgKSTdfKKjnhW0VNSgWz8jcvsoLxk2Nzxg7jjsW546WxwwsQ6Vkg3ntGIQvh9O9kH6AEMTzTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5117
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA2LTE3IGF0IDE1OjI2IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+ID4gSSB0aGluayB5b3UgbWVhbiB0aGUgImFjdHVhbCBmbHVzaCIgbmVlZHMgdG8g
YmUgZG9uZSBvbiB0aGUgZmlyc3QgdXNlLsKgIEJ1dA0KPiA+ID4gc2V0dGluZyBsYXN0X3ZwaWQg
dG8gMCBpcyBhIHNldHRpbmcgd2hpY2ggaXMgdG8gbWFrZSBzdXJlIHRoZSBhY3R1YWwgZmx1c2gg
d2lsbA0KPiA+ID4gYWx3YXlzIGJlIGRvbmUgb24gdGhlIGZpcnN0IHVzZSwgaS5lLiwgdGhlIGFj
dHVhbCBmbHVzaCB3aWxsIGFsd2F5cyBiZSBkb25lIG9uDQo+ID4gPiB0aGUgZmlyc3QgdXNlLsKg
IEZvciB0aGlzIHB1cnBvc2Ugc2VlbXMgdG8gbWUgdGhlcmUncyBubyBkaWZmZXJlbmNlIGJldHdl
ZW4NCj4gPiA+IHNldHRpbmcgbGFzdF92cGlkIHRvIDAgaW4gZW50ZXJfdm14X29wZXJhdGlvbigp
IGFuZCBmcmVlX25lc3RlZCgpLCBidXQgbWF5YmUgSQ0KPiA+ID4gYW0gbWlzc2luZyBzb21ldGhp
bmcuDQo+IA0KPiBZb3UncmUgbm90IG1pc3NpbmcgYW55dGhpbmcuwqAgSXQncyBqdXN0IHRoYXQg
cHV0dGluZyBpdCBpbiBmcmVlX25lc3RlZCgpIHN1YnRseQ0KPiByZWxpZXMgb24gemVyby1hbGxv
Y2F0aW5nIHZteC0+bmVzdGVkLCBzbyB0aGF0IHRoZSAqdmVyeSogZmlyc3QgdXNlIGFsc28gZmx1
c2hlcw0KPiB2cGlkMDIuwqAgUmVseWluZyBvbiB6ZXJvLWFsbG9jYXRpbmcgaXMgZ2VuZXJhbGx5
IGEtb2ssIGJ1dCBpbiB0aGlzIGNhc2UgaXQgd291bGQNCj4gcmVxdWlyZSBkb2N1bWVudGluZyB0
aGUgc2FtZSBiYXNlIGxvZ2ljIGluIG11bHRpcGxlIHBsYWNlcy4NCg0KUmlnaHQuIEFncmVlZC4N
Cg==
