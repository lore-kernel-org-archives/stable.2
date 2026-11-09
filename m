Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794220338;
	b=en2PVNHUD8zZlzIeCkH7BdnFQjxEXebQZfEaW0BRZUcZ6tRMxNXX3T7w6nbEFOSrbeMk
	 gybQmlwEc1nQDfhPnGeNs6fwASk0nhaQ8iNOi/1/+4Golga8dEccV27KW/uG3WXEN8+ID
	 CaDb4ng/tYUaAmMQLcJawYUi2Hz0WGNl0+GwWcCrqAz+hCEgdVZE3tjmXYfjhg1zsr/TH
	 kjbN8t5wdPdmBLZVsUjWl89snLsbIan0JzJu/Z+U15BMEXzqO+XzMw0mmGvX2GWQ4VD54
	 q2x4GBoyiFD1RGVH4h9Krn6tVhm/54xJdfiS6KPCIHAAtB47pfJk1qil1XY7cQ2yDtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220338;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BB3UT2LFAIJBFBPgaGQPUub1w5YGdMntsAyoqNXFv4s=;
	b=C18RUzJyG+oY1hMdZ2/YJB7pwGc3RiN5Od86J+gkVzER8hCHB8giGM234U6GwX22uISI
	 RP9svawrdGuwSU2LXkvCwg2tt75WGMfBXSpVrg2u0yaOXTey06H15C4jgMjiZ7xr2lGoN
	 mqs5ciSbzMRNx2DDgl+xoO0qmMRmRXqgfOpjBJ05w+yaoHobht6L1f8mrZGwMz4pzFlFD
	 ERL7F0cgRSn7Oujmqz56A9khE35lFkmae8mpXI5KLU4UbPnPXBh+OxYY89/HupNGfb2Ol
	 o4xOvBby5QX8V2KCaC+HD8pj+f6bsSQbKT5ldUZ1BEp8kGzOLEyHp15HjaXlM83kamg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="5bkRvSR/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.67
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F9606A321;
	Mon,  9 Nov 2026 10:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 683F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5bkRvSR/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5jUhih0UL6+13whcAlm8s7aMsivnrPMXCtu0wEAoQVJTa6RGH78JSehg1qLnNYIZi98Bsqiqoh2HZIvLYiXuCEUj7fEa6gdSjZ+n3ih//qK9uC/111meOpWU+Dm/c+IUDA6C1qqfbpwftsNMlVvzwU7GNne3TGsrrfDyV0B6WJr8ou07aIurAJYVo1V4+fuAR1QuAy87CrI5Ttn3vw9ZRNYveVUjB3rSm7kAeCD9SxAd8ClENCAh4s+HraDTMtM7PMWYIaXIIAHbeT+YuGxPjJwpj0/lNdMGzRq4+vz06rxtpXylAvl/paBJ8pEtKNBl/Tz5Gtm523Q8BrymlMuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB3UT2LFAIJBFBPgaGQPUub1w5YGdMntsAyoqNXFv4s=;
 b=cc+H5CUZiLyB4ZI4ollMinHtMb0AAjpunSXlLkJYV+dAcEj5Jcolk0dvpoDmCK1W8pdgNQDn7lWgygNSzuhLH0wKXrAEgNusf84Dc0t83CRMqc+t9PBf1FB7dXYPuYgf+89hX5BQGx0fUlSV+QRjy+GBMc5l/udPW5EZmG/UldclqUMBI44Mibo5qbR+vqY99gBSsuAb7ENZyo6zP915LG7MPrR6KMqUGZ0qy+f56AzqvM/i5IO+znqSs+morzA5STJIqOYQZFVx+4oJbn97Evs+FzFxa4zBH3eLA0o7NGYDdgq5to77L2HlSMQ8UpyeV/IUghEjVTHKLMWehQCkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB3UT2LFAIJBFBPgaGQPUub1w5YGdMntsAyoqNXFv4s=;
 b=5bkRvSR/nvPkInFwY7V9WBrkhD86MEunHsxIbZskx2IstxJANcfk323R8zBVLEKohnJBqFLiDxmScozy2E+Cq6ffHMTZw0wu4ppJ3l/FnvdT7TTHk3GVbzERwPFEUSSHKqEZCyHMmAS/6gIa62qQt7R1z5P+3gkhtPzXr0Xuc5A=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 10:30:11 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0592.007; Mon, 9 Nov 2026
 10:30:11 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "pratyush@kernel.org" <pratyush@kernel.org>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	"xu.xin@linux.dev" <xu.xin@linux.dev>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "baoquan.he@linux.dev" <baoquan.he@linux.dev>,
	"riel@surriel.com" <riel@surriel.com>, "usama.arif@linux.dev"
	<usama.arif@linux.dev>, "david@kernel.org" <david@kernel.org>,
	"mhocko@suse.com" <mhocko@suse.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "kasong@tencent.com"
	<kasong@tencent.com>, "jack@suse.cz" <jack@suse.cz>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "weixugc@google.com" <weixugc@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "liam@infradead.org"
	<liam@infradead.org>, "gourry@gourry.net" <gourry@gourry.net>,
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "jannh@google.com"
	<jannh@google.com>, "chrisl@kernel.org" <chrisl@kernel.org>,
	"yuanchu@google.com" <yuanchu@google.com>, "youngjun.park@lge.com"
	<youngjun.park@lge.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"rakie.kim@sk.com" <rakie.kim@sk.com>, "joshua.hahnjy@gmail.com"
	<joshua.hahnjy@gmail.com>, "rppt@kernel.org" <rppt@kernel.org>,
	"axelrasmussen@google.com" <axelrasmussen@google.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "willy@infradead.org" <willy@infradead.org>,
	"osalvador@suse.de" <osalvador@suse.de>, "surenb@google.com"
	<surenb@google.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"matthew.brost@intel.com" <matthew.brost@intel.com>, "minchan@kernel.org"
	<minchan@kernel.org>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "will@kernel.org" <will@kernel.org>,
	"hughd@google.com" <hughd@google.com>, "nico.pache@linux.dev"
	<nico.pache@linux.dev>, "qi.zheng@linux.dev" <qi.zheng@linux.dev>,
	"baohua@kernel.org" <baohua@kernel.org>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "harry@kernel.org" <harry@kernel.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "apopple@nvidia.com" <apopple@nvidia.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "vbabka@kernel.org"
	<vbabka@kernel.org>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>, "npiggin@gmail.com"
	<npiggin@gmail.com>, "ljs@kernel.org" <ljs@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, "kas@kernel.org" <kas@kernel.org>,
	"mhocko@kernel.org" <mhocko@kernel.org>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "usama.anjum@arm.com" <usama.anjum@arm.com>
Subject: Re: [PATCH v3 09/47] mm/rmap: handle device-exclusive entries in
 folio_referenced_one()
Thread-Topic: [PATCH v3 09/47] mm/rmap: handle device-exclusive entries in
 folio_referenced_one()
Thread-Index: AQHdcAbsHWcP0DWki0q0mxHxIZQkG7clNKcAgABLCQCAAArZAA==
Date: Mon, 9 Nov 2026 10:30:11 +0000
Message-ID: <7194ff7d170f8b47eec8361fa9e195ff2d1581c9.camel@amd.com>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
	 <20261031-fixes_core-v3-9-d6437171ecc3@kernel.org>
	 <50c50262c50da19f6a2b27f848324772b0e3c707.camel@amd.com>
	 <db93735f-2452-453f-bfe2-f1cef00f143a@kernel.org>
In-Reply-To: <db93735f-2452-453f-bfe2-f1cef00f143a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|SJ2PR12MB8977:EE_
x-ms-office365-filtering-correlation-id: 64694d7a-6a05-495e-4523-08df3e4c6f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|921020|38070700021|261009223027099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 qiX/qyiwQNuZLJujpTYaoarSyDWqV7F3abWNVvbNX5r/70KYubOw4agHpRpVxwA2CYNnsaY19CrS7CQzmActCfMBZQbiKs0GSSMfluD/2El1d9hQppCJsamgRHYt69/bsUDW/7cvf4QmLmo59euUmCTlKyD29sEkb7GvUsLZS2teByG5KUqI6bTp34FeP80DJp4ZPidmbZTrrP0h4I+bW4Lmr5fxoJyrVQZgAImcioTjPvtcqHzguqdurh5D8lnVz6dku9C9V77HVsUw9KQ2NFNGILvnVOk+VPJOL0wKNacjZEUT/hC7NE2ArW7eZhTKMcWKYmG0ZOFghlwfIg6dKCkr8C2O4ptTxJlgyYunhyNe2HBu3kogD1zJCf7PcPaZ52gHczFgcK4ZAiDZtCkECp/bHaJ+yrS+LwbCgUeH8J8J0rz3Qsza9r2qE7wG+KZhgPzYbX0a1hq9OMJnXRImqYjfUu0+3FQ5t34YsRIc+l0S/wnZJ2g/N4Jt9bU3L2ehpVJbH4Loh7nXDFcYtBgIh8ly0oFa7tMoTneG8X/OiYucb8Fw5I2lhL1JjK2o5UbuPpvrlK5BNTgIexj1yIMNQrLUNc1fM69XAO7k7LdsC7AF1ha7YP62N7pe+SEjJWTqnJr7FFqPsqztG6MS33U/uzQLyBm11YTuxMhRiJo+wsQY8xyCDZwXJmkp+0o1rtta
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(921020)(38070700021)(261009223027099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmY4V2FhWUJUWmJwRXhESE5oTWlWOHFHRFFONWQ0OUN3RVlVdjlXUm90d3hX?=
 =?utf-8?B?Q3JzbElDenl6V3VvaVJpTEdkZW4yNlozWVphUFdheEZ6d0NrZzJQeEU0QkJh?=
 =?utf-8?B?WFlBbE9RbjRUYXd6ZENRVC9LMjdoUjhic2NjbmVlZUc0SURnbmsxL0R0cUZB?=
 =?utf-8?B?bTZkZFZYMlJWNVN5dm13cEdHRHJhdTZJUDhBZy80emZLVXE2KzVDRWlEK2ho?=
 =?utf-8?B?YTkzalVYWG9mRnYzZTB1MHA5bkV6NlRPSUJXRTRKckpCRUlyR3NmbDdJZUZY?=
 =?utf-8?B?WDhtQktVOEdRNFE5T1p3UllwWVc3UUZJOHFxUnpDNUl2SFF4enlKVENlTE42?=
 =?utf-8?B?aE8wcHByR0w2aUduemYwM0pTUXVYVjRwbjN5SE1xSmQ5c3lQSFB5RmFPNmxK?=
 =?utf-8?B?WTVWSXdIbDFwTDZHU2k1STBsK3BoazhYUUhOdFRGY1gwanVZNUVTSTl5dkRT?=
 =?utf-8?B?TWg2V2JSSFFDeG9WV1YyZUxoSFN5UlZPWlZqVDVaRzNSY1BwbzM3L3diUTRp?=
 =?utf-8?B?OGF1Y2drSnZ3dEZrWG5hWTdaUDJMQ04rd1kwYVJhR2hjNkZHSGZPbHZhL3Rq?=
 =?utf-8?B?ekhYem9HZGMrL3pSaXh6dzJjTE94Q1cyMytIRUZLeTRFY3JnU2N2NGVLQVVw?=
 =?utf-8?B?NWJhT3ZNYjBQbndualJmOUdoa1duU3E5ODdhNVMrTmNuLzc2TnFidXkvWkNF?=
 =?utf-8?B?aHhlWU9vKzdaeE5xUENoT0VOT0pzTUU1RGlIS1UyUm9VR1d1OEFIbDR4ZlhN?=
 =?utf-8?B?MDVJa3YreXg0ZjRTYnBsYXcxd0tQQ3R6dkpCK0h1OUROdklKV3V3ZUx3dU16?=
 =?utf-8?B?bzVSOGpjbXFldS90S2w5WEVWbHlMRWxPbm54NC92R0VxMGlsREordWFrRzU4?=
 =?utf-8?B?ZzdrY2FlbFl0MnpQaE9TMEhvOVhVSmgrUjZLeGdTaStFVk5OVjkrcXFLYmJi?=
 =?utf-8?B?UHJUQ1YxbFN6Yy9URXR6dENDZVJjVjlmMWN6cTdiRXRlc2pua2Y5R2ZIVzhk?=
 =?utf-8?B?K2NjOWFNOWNxTzdLYTlmeFY2S0FwaThQc2dVWnE0MGljWFhaR2lQWnRQTlNt?=
 =?utf-8?B?S2VnMFA0VWNoOXd0bm5oNG9KMVlISmJrRllPbGpUS0ZOOUh1eFhQdUFJalI2?=
 =?utf-8?B?aENISjFjQ2ZlelF5UTZqVkRIa0tlZ2EraTY5MVBLM0FHU3BZVHROTC9WTGtU?=
 =?utf-8?B?UkxBa3gvdTNNOG00bnBGUTYwdU9EaWZGczc1T25HbEljQWdUNjh3ekFlaWtr?=
 =?utf-8?B?emk2N2RvdmVRRFlFaUQxQXFrN1M3Ym1kVzErUG5tS2VrSGxsWDBQc1k3cnFH?=
 =?utf-8?B?aURPaU1EZHVDOHo5M05ZWU15ZDFFc0E0M0Zvc210OGhDeHZXa3k1Q2hCNnJy?=
 =?utf-8?B?ZTMrd2FTY2ZoWENYOXFoQzU4ZklJMUNCSTM1TEM4aFk0T1l4YmVhOWFubThI?=
 =?utf-8?B?VU5EY2pLcEFMalAvTHdOV0ZFdDZNeGloMGo4bFdVeVVyak9FTGtrR0ZYYTdZ?=
 =?utf-8?B?UkhGSDBVUk81NThwTUdxdDhKUkFkSWJoekQ1VEgwVkVYWC8yR3BEOEs4OHU0?=
 =?utf-8?B?NlZBZ0djR2lnZGdpVmErM2dmQkN2SGU3UGhTNFlpSFVtOEo5Z25CNDRxZktL?=
 =?utf-8?B?L0RJdXFZaUduUm5EZDZmN1R1TkVBVEtlZmZhOHlxb1VDVytkSnFpbDROU0Jo?=
 =?utf-8?B?cE9sbHEwam5QOWYrMjFlcERHV3hNRW1lb1UwR0FmZ2FpZDdPUG93SHhnZ0JM?=
 =?utf-8?B?WVVVK2h1bUhwbFlLUkI5OVVnR2pXVFJVT2tvcmlUM3M4OUJCSzgzVW8rZjNm?=
 =?utf-8?B?bGZDa0d5bTU4cUFzMGpIOUdZT3BlYzBiS1NlNmdwYXZadmhFTzlKUmQ4ZkRJ?=
 =?utf-8?B?cmdFZExaWFVqNWVrTSttMjhoNk0xakVqdlFsbmtUZGtOZTFnVUZyNFpLblJx?=
 =?utf-8?B?VkhBc05nRFBvR1VMeGQzKy9pcXBMSFBWaDdjY1luZW10aWpRemRiMEYrS1hQ?=
 =?utf-8?B?VFJUVGV4WWJTU2tjcDdwVVVVSkVzcmlzN2RPS1VQK2M3UzlreWNFOFlOMG8w?=
 =?utf-8?B?enBVK1B0Q3dvK3dLREhhNjd4UzcxYWxCSVhDSTF5eElZNDN1bk1KRkNpK2pT?=
 =?utf-8?B?bXkvT2N2UDVwWkJoeUpKMDQ4QUdLWjVNTCtFNUYrR0JvV3dTeWcvUjlXNHgy?=
 =?utf-8?B?OEVsWWFtOTRvTjk1MFlza0lKVExBU3g5TmZXcFY2UndFR1hSRnNnTEZYQlN0?=
 =?utf-8?B?TThUS3ZaNko0ZEhjTGhWSTZVcUcyNUhwS0tkYjluK1VRM2pMMmZuSHJzNDUv?=
 =?utf-8?Q?iJVIAyx4NjZhimVKE1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E391D201524774448900B10A781B4313@namprd12.prod.outlook.com>
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
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64694d7a-6a05-495e-4523-08df3e4c6f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 10:30:11.4545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNbm/UewzWdpsUueSsSQCXZGfgEMrPyvC+8ebFPrVjfIwHCINVZXtEhJHehbWQTuShdJ1EQfDqZDRxbKgp0Ibw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977

T24gTW9uLCAyMDI2LTExLTA5IGF0IDEwOjUxICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCAoQXJt
KSB3cm90ZToNCj4gT24gMTEvOS8yNiAwNjoyMiwgR2FyZywgU2hpdmFuayB3cm90ZToNCj4gPiBP
biBTYXQsIDIwMjYtMTAtMzEgYXQgMTA6MzkgKzAxMDAsIERhdmlkIEhpbGRlbmJyYW5kIChBcm0p
IHdyb3RlOg0KPiA+ID4gcGFnZV92bWFfbWFwcGVkX3dhbGsoKSBjYW4gcmV0dXJuIG5vbi1wcmVz
ZW50IGRldmljZS1leGNsdXNpdmUgZW50cmllcywNCj4gPiA+IGJ1dCBmb2xpb19yZWZlcmVuY2Vk
X29uZSgpIHBhc3NlcyB0aGVtIHRvIFBURSB5b3VuZy1iaXQgYWNjZXNzb3JzIHRoYXQNCj4gPiA+
IHJlcXVpcmUgcHJlc2VudCBQVEVzLg0KPiA+ID4gDQo+ID4gPiBXZSBtdXN0IG5laXRoZXIgY2Fs
bCBjbGVhcl9mbHVzaF95b3VuZ19wdGVzX25vdGlmeSgpIG5vcg0KPiA+ID4gZm9saW9fcHRlX2Jh
dGNoKCkgd2l0aCBub24tcHJlc2VudCBlbnRyaWVzLiBGb3IgZXhhbXBsZSwgY2xlYXJpbmcgdGhl
DQo+ID4gPiB5b3VuZyBiaXQgb24gbm9uLXByZXNlbnQgUFRFcyBjYW4gY29ycnVwdCB0aGUgZW50
cnk6IG9uIGFybTY0DQo+ID4gPiBQVEVfQUYgb3ZlcmxhcHMgdGhlIHN3YXAgdHlwZSwgc28gY2xl
YXJpbmcgaXQgdHVybnMgYSBkZXZpY2UtZXhjbHVzaXZlDQo+ID4gPiBlbnRyeSBpbnRvIGFuIG9y
ZGluYXJ5IHN3YXAgZW50cnkuDQo+ID4gPiANCj4gPiA+IGZvbGlvX3B0ZV9iYXRjaCgpIHdpbGwg
Vk1fV0FSTl9PTl9GT0xJTy4NCj4gPiA+IA0KPiA+ID4gQXBwbHkgdGhlIHNhbWUgYXBwcm9hY2gg
YXMgdGhlIHByZXZpb3VzIGZpeGVzIHRvIGUuZy4sIGRhbW9uX3B0ZXBfbWtvbGQoKToNCj4gPiA+
IHRyZWF0IHRoZXNlIGVudHJpZXMgYXMgb2xkIGZyb20gdGhlIENQVSdzIHBlcnNwZWN0aXZlIGFu
ZCBvYnRhaW4gdGhlaXINCj4gPiA+IHlvdW5nIHN0YXRlIHRocm91Z2ggdGhlIE1NVSBub3RpZmll
ci4NCj4gPiA+IA0KPiA+ID4gU2tpcCBQVEUgYmF0Y2hpbmcgYW5kIE1HTFJVIGxvb2stYXJvdW5k
IGZvciBub24tcHJlc2VudCBlbnRyaWVzLCBhbmQNCj4gPiA+IGRvbid0IG1vZGlmeSBub24tcHJl
c2VudCBQVEVzLg0KPiA+ID4gDQo+ID4gPiBGaXhlczogYjc1NmEzYjVlN2VhICgibW06IGRldmlj
ZSBleGNsdXNpdmUgbWVtb3J5IGFjY2VzcyIpDQo+ID4gPiBSZXZpZXdlZC1ieTogTG9yZW56byBT
dG9ha2VzIChBUk0pIDxsanNAa2VybmVsLm9yZz4NCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQo+ID4gPiBSZXBvcnRlZC1ieTogSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFuZGEu
Y29tPg0KPiA+ID4gUmV2aWV3ZWQtYnk6IEhhcnJ5IFlvbyAoTWV0YSkgPGhhcnJ5QGtlcm5lbC5v
cmc+DQo+ID4gPiBSZXZpZXdlZC1ieTogQmFycnkgU29uZyA8YmFvaHVhQGtlcm5lbC5vcmc+DQo+
ID4gPiBSZXZpZXdlZC1ieTogRGV2IEphaW4gPGRldi5qYWluQGFybS5jb20+DQo+ID4gPiBUZXN0
ZWQtYnk6IE11aGFtbWFkIFVzYW1hIEFuanVtIDx1c2FtYS5hbmp1bUBhcm0uY29tPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQgKEFybSkgPGRhdmlkQGtlcm5lbC5vcmc+
DQo+ID4gPiAtLS0NCj4gPiA+ICBtbS9ybWFwLmMgfCAyMyArKysrKysrKysrKysrKysrKysrLS0t
LQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvbW0vcm1hcC5jIGIvbW0vcm1hcC5jDQo+ID4g
PiBpbmRleCAxMTMxYjc2YmJiYzI4Li4wZmFlZjQ2ODA2ZTVjIDEwMDY0NA0KPiA+ID4gLS0tIGEv
bW0vcm1hcC5jDQo+ID4gPiArKysgYi9tbS9ybWFwLmMNCj4gPiA+IEBAIC05MjQsNiArOTI0LDcg
QEAgc3RhdGljIGJvb2wgZm9saW9fcmVmZXJlbmNlZF9vbmUoc3RydWN0IGZvbGlvICpmb2xpbywN
Cj4gPiA+ICAJREVGSU5FX0ZPTElPX1ZNQV9XQUxLKHB2bXcsIGZvbGlvLCB2bWEsIGFkZHJlc3Ms
IDApOw0KPiA+ID4gIAlpbnQgcHRlcyA9IDAsIHJlZmVyZW5jZWQgPSAwOw0KPiA+ID4gIAl1bnNp
Z25lZCBpbnQgbnI7DQo+ID4gPiArCXB0ZV90IHB0ZXZhbDsNCj4gPiA+ICANCj4gPiA+ICAJd2hp
bGUgKHBhZ2Vfdm1hX21hcHBlZF93YWxrKCZwdm13KSkgew0KPiA+ID4gIAkJYWRkcmVzcyA9IHB2
bXcuYWRkcmVzczsNCj4gPiA+IEBAIC05NjgsMTAgKzk2OSwxMiBAQCBzdGF0aWMgYm9vbCBmb2xp
b19yZWZlcmVuY2VkX29uZShzdHJ1Y3QgZm9saW8gKmZvbGlvLA0KPiA+ID4gIAkJCXJldHVybiBm
YWxzZTsNCj4gPiA+ICAJCX0NCj4gPiA+ICANCj4gPiA+IC0JCWlmIChwdm13LnB0ZSAmJiBmb2xp
b190ZXN0X2xhcmdlKGZvbGlvKSkgew0KPiA+ID4gKwkJaWYgKHB2bXcucHRlKQ0KPiA+ID4gKwkJ
CXB0ZXZhbCA9IHB0ZXBfZ2V0KHB2bXcucHRlKTsNCj4gPiA+ICsNCj4gPiA+ICsJCWlmIChwdm13
LnB0ZSAmJiBwdGVfcHJlc2VudChwdGV2YWwpICYmIGZvbGlvX3Rlc3RfbGFyZ2UoZm9saW8pKSB7
DQo+ID4gPiAgCQkJY29uc3QgdW5zaWduZWQgbG9uZyBlbmRfYWRkciA9IHBtZF9hZGRyX2VuZChh
ZGRyZXNzLCB2bWEtPnZtX2VuZCk7DQo+ID4gPiAgCQkJY29uc3QgdW5zaWduZWQgaW50IG1heF9u
ciA9IChlbmRfYWRkciAtIGFkZHJlc3MpID4+IFBBR0VfU0hJRlQ7DQo+ID4gPiAtCQkJcHRlX3Qg
cHRldmFsID0gcHRlcF9nZXQocHZtdy5wdGUpOw0KPiA+ID4gIA0KPiA+ID4gIAkJCW5yID0gZm9s
aW9fcHRlX2JhdGNoKGZvbGlvLCBwdm13LnB0ZSwgcHRldmFsLCBtYXhfbnIpOw0KPiA+ID4gIAkJ
fQ0KPiA+ID4gQEAgLTk4MSwxMSArOTg0LDIzIEBAIHN0YXRpYyBib29sIGZvbGlvX3JlZmVyZW5j
ZWRfb25lKHN0cnVjdCBmb2xpbyAqZm9saW8sDQo+ID4gPiAgCQkgKiBhcmUuIOKAlHRoZXkgY291
bGQgYmUgb24gYWN0aXZlL2luYWN0aXZlIGxpc3RzIG9yIG9uIE1HTFJVLiBTbyB0aGUNCj4gPiA+
ICAJCSAqIHNpbXBsZXN0IGFwcHJvYWNoIGlzIHRvIGRpc2FibGUgdGhpcyBsb29rLWFyb3VuZCBv
cHRpbWl6YXRpb24uDQo+ID4gPiAgCQkgKi8NCj4gPiA+IC0JCWlmIChscnVfZ2VuX2VuYWJsZWQo
KSAmJiAhbHJ1X2dlbl9zd2l0Y2hpbmcoKSAmJiBwdm13LnB0ZSkgew0KPiA+ID4gKwkJaWYgKGxy
dV9nZW5fZW5hYmxlZCgpICYmICFscnVfZ2VuX3N3aXRjaGluZygpICYmIHB2bXcucHRlICYmDQo+
ID4gPiArCQkgICAgcHRlX3ByZXNlbnQocHRldmFsKSkgew0KPiA+ID4gIAkJCWlmIChscnVfZ2Vu
X2xvb2tfYXJvdW5kKCZwdm13LCBucikpDQo+ID4gPiAgCQkJCXJlZmVyZW5jZWQrKzsNCj4gPiA+
ICAJCX0gZWxzZSBpZiAocHZtdy5wdGUpIHsNCj4gPiA+IC0JCQlpZiAoY2xlYXJfZmx1c2hfeW91
bmdfcHRlc19ub3RpZnkodm1hLCBhZGRyZXNzLCBwdm13LnB0ZSwgbnIpKQ0KPiA+IA0KPiA+IFRo
aXMgd2FzIHRoZSBvbmx5IGNhbGxlciBvZiBjbGVhcl9mbHVzaF95b3VuZ19wdGVzX25vdGlmeSgp
LCBzbyB0aGlzDQo+ID4gbGVhdmVzIGJvdGggZGVmaW5pdGlvbnMgaW4gbW0vaW50ZXJuYWwuaCB1
bnVzZWQuDQo+ID4gDQo+ID4gV291bGQgeW91IHByZWZlciB0byByZW1vdmUgdGhlbSwgb3Iga2Vl
cCB0aGVtIGZvciBjb21wYW55IHdpdGggdGhlaXINCj4gPiBzdGlsbCB1c2VkIHRlc3RfYW5kX2Ns
ZWFyX3lvdW5nX3B0ZXNfbm90aWZ5IGZyaWVuZD8NCj4gDQo+IENhbiB5b3Ugc2VuZCBhIGNsZWFu
dXA/IFRoYW5rcyENCg0KU3VyZSwgdGhhbmtzLiBXaWxsIGRvLg0KDQpJJ2xsIGluY2x1ZGUgaXQg
aW4gVjIgb2YgbXkgcHJldmlvdXMgc2VyaWVzIFsxXS4NCg0KRG8geW91IGhhdmUgYW55IGNvbW1l
bnQgb24gWzFdIG5vdywgYmVmb3JlIEkgc2VuZCBWMi4NCg0KWzFdDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1tbS8yMDI2MTAyNi11bnVzZWQtc3ltLXYxLTAtODJjYTJkY2VhYmUxQGFt
ZC5jb20NCg0KDQpUaGFua3MsDQpTaGl2YW5rDQo=
