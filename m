Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794201774;
	b=JZoFF7s8NQiTgmR4g4Ek2iQ+k0YprBGeBUyyyUND3huGDXXUT55Xbr7Xv/OOtoNyfA2r
	 DDKKZsHmzMBzAVXOX4dKr/0qzTPTvvcxt32En1HADNYoHiqdCrvnxGr7CKGRmlSdVP22Z
	 81rtldOCo12BVyLrpQy5+R90aR+j3Pq/R4loDiNPYsEtf/Xl47vJcrbmY0th1DwW5n+f6
	 qxPN/U0+NDf1Dw6w13fX2X8dglXKg7nxu4MxQr3Lh+sSdmZ4Nx/l0VHCmdiJgbjoxPwOs
	 Ovrste0ohXreHdnNh2yCsBauFcFX3kSKUJI6E43lYdQG5PrGZYsYSSE8C4VJBtPkJAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201774;
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
	bh=Jdu3nu1MtFKeGKb8mUbqmXFXFW//P4KpL81THeHx5PU=;
	b=2Ujkl09LotiYjQp6MNZZd8W/f10l8DmGKm3ytkceHGlNgPJY1Op1Mp5Q+no7DsMmVPxO
	 kk+4+f81MjRzpOg3f5Np+4BHHqPeyomqBD8CLxRWzmT9nlDtZpkBB9mgX4ZAMIrVa9zyI
	 /fWFuo7W7Y/msBwoMSwbwA2GZ1PxvF+FJEH/M3PKopXNabSBMIYqcJQXsTyAmU4AoNRWE
	 MaVmjYds4q5qrtkqjhObccB6KDYh1+gxjNOuKcoS3OAFAiivTfsXOYd7CivcdW7FeBn6N
	 b5Qo1mpBn6v1DQZUCwAZVdZrl84QnydRiQwdb/UH+AlmONknZb6ZAEtNfi1fakVbaEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h8QYmIMf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.40
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F77A606A31C;
	Mon,  9 Nov 2026 05:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F77A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h8QYmIMf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0hrr1goWA6DWoW2BBu1gKAu7L6pl6Axtrabd4SygOIK5eQqKBwrWEeukNXhAZ+CP31Wzk/v6ToiRRDiosZTaGwIt8KO033DbWw+xSUestMVG13duyherJkqshoCEBeIKNzst15Usti2l+hfiwQkz4FY1+Ihe32PcymJ1ANA2dJdZNAKMauXWlBUSMdTU6y99qqJknf2DYwIxicT5fQvKmiW6FqOXNV98YuW7svgZ9cmSVonfaF49/arJ3vX4JT08QXhUR47ec1X82LRbY2G+Kf/Et7C+xkkgvWBVnyuWS+ARq++W1Im5mLC3eTZBP34EQMZPpIgg72NWme3UNiWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jdu3nu1MtFKeGKb8mUbqmXFXFW//P4KpL81THeHx5PU=;
 b=wyTa6GabrcXHhoIaDCa+IU8dOq2zPrP2u6fjq9U4TX1jrcnkg7DJD7YRQpm5mLl/HTVHVT6JQ5eNhl/J8ZCTYuuak0eDNfAVUhWPCyi+mMW3mZO2p6jVm3U4EqhRTrGPxJx9yPcyCwwRGc/7qfTNVDeA6G+MA1wnMhjX2woC4uY8pAoaBH7vjp0wxCrYotBP7Ox1bLJZ8OHgiSDt5JtEVkcwsVdTVC1c+e7hPJqi4DR4HhFOa5Q/ADZ6/PjMFJfCOaOjsJHYuJhY0wXFiNnT6C3OOlhJzYWJcLcRNa07JRFqsGjk593D/2wI6Oahdsa9NsJWdYR3XiUo1yPYctrhiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jdu3nu1MtFKeGKb8mUbqmXFXFW//P4KpL81THeHx5PU=;
 b=h8QYmIMfQPgxKFjdGUIiaXUo38aUTaCGndhNjz9PLX0s1BcbPYVJ574vg3kUH4QiDJIHkkJAdS9YusmhgvtcQo0O17wrJneyEFy8ctpnJNg+V2E7FH6DZYaw7dHlyfMMWk79cBVc1iBNMylck/uVzhK78HA7H5CBXNi+zSAGhQA=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by CH8PR12MB404786.namprd12.prod.outlook.com (2603:10b6:610:705::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 05:22:48 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%2]) with mapi id 15.21.0592.007; Mon, 9 Nov 2026
 05:22:48 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "pratyush@kernel.org" <pratyush@kernel.org>, "osalvador@suse.de"
	<osalvador@suse.de>, "xu.xin@linux.dev" <xu.xin@linux.dev>,
	"peterx@redhat.com" <peterx@redhat.com>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "baoquan.he@linux.dev" <baoquan.he@linux.dev>,
	"riel@surriel.com" <riel@surriel.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "david@kernel.org" <david@kernel.org>,
	"mhocko@suse.com" <mhocko@suse.com>, "usama.arif@linux.dev"
	<usama.arif@linux.dev>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"jack@suse.cz" <jack@suse.cz>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "peterz@infradead.org" <peterz@infradead.org>,
	"weixugc@google.com" <weixugc@google.com>, "kees@kernel.org"
	<kees@kernel.org>, "kasong@tencent.com" <kasong@tencent.com>,
	"jannh@google.com" <jannh@google.com>, "chrisl@kernel.org"
	<chrisl@kernel.org>, "liam@infradead.org" <liam@infradead.org>,
	"yuanchu@google.com" <yuanchu@google.com>, "youngjun.park@lge.com"
	<youngjun.park@lge.com>, "ying.huang@linux.alibaba.com"
	<ying.huang@linux.alibaba.com>, "joshua.hahnjy@gmail.com"
	<joshua.hahnjy@gmail.com>, "rppt@kernel.org" <rppt@kernel.org>,
	"axelrasmussen@google.com" <axelrasmussen@google.com>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "gourry@gourry.net" <gourry@gourry.net>,
	"willy@infradead.org" <willy@infradead.org>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "surenb@google.com" <surenb@google.com>,
	"qi.zheng@linux.dev" <qi.zheng@linux.dev>, "matthew.brost@intel.com"
	<matthew.brost@intel.com>, "minchan@kernel.org" <minchan@kernel.org>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "will@kernel.org" <will@kernel.org>,
	"hughd@google.com" <hughd@google.com>, "nico.pache@linux.dev"
	<nico.pache@linux.dev>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"baohua@kernel.org" <baohua@kernel.org>, "muchun.song@linux.dev"
	<muchun.song@linux.dev>, "harry@kernel.org" <harry@kernel.org>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, "apopple@nvidia.com"
	<apopple@nvidia.com>, "ziy@nvidia.com" <ziy@nvidia.com>, "vbabka@kernel.org"
	<vbabka@kernel.org>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"ljs@kernel.org" <ljs@kernel.org>, "shikemeng@huaweicloud.com"
	<shikemeng@huaweicloud.com>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>, "kas@kernel.org"
	<kas@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "rakie.kim@sk.com"
	<rakie.kim@sk.com>
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
Thread-Index: AQHdcAbsHWcP0DWki0q0mxHxIZQkG7clNKcA
Date: Mon, 9 Nov 2026 05:22:48 +0000
Message-ID: <50c50262c50da19f6a2b27f848324772b0e3c707.camel@amd.com>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
	 <20261031-fixes_core-v3-9-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-9-d6437171ecc3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|CH8PR12MB404786:EE_
x-ms-office365-filtering-correlation-id: 526da432-306d-4bc4-c039-08df3e217e5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|921020|38070700021|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 q2lkhwU+GmjowQr96ppvMrLOkaA03JRDMOJip0rNe9GHLrxR0kVsKHQX0pQ6Ql4lJpL5M2ae1r3CxLH4ZSjvaT6YTcNxZl+Yx2llgwv3kHPAkcwRB4EpwhRHpj43vCAkojAVynzr1pZrJvlKSolxTdF66wlA1X8zuTIo2UHDdf8hkFFl/+y8akLMH2jpVVezJ2aIwTLySrZmjrUykMMZPgcl0MKTJ+xNYt013LP7LOf9tRhy12rVT+M6UpHg6opyUgHBYv+IGrUhIQZlVgBC+JMyjRgO5djm/MAVVvc94h3RSzQNIVI2f6FPiokTR5Q6pSxpFrn2aa9ehr1JVmeBuqdgeYEJE327Zm5puts8Uo+FkdTnB3giYVGwYEwU4ULDCyGgpdVqTA3h7oTzLjVuABITrsARhPTyMNS1ip+2CkmA6oOW8qNezdDGe2E6sOdqLN/zDxP0yXrUr+0Gke7l77SzgALe37qYkgLLCfQvHEa4Wx5CywwpSQT1lx39ZofQO2r7EM+iYMIeHfKqRCkRpELSofKMXOEdTyX6F66+GFZ83NqvIajjg6mnY5HVgPUMUGHOJCYrzyqdb3mrKJbWhMk6Bp/tys17eal9TuqK8b9SsWLLLkCDfiXk5KMl1ZCzzUFgfkb9/N8wQLTE4yhWAOaFnpI29bsVPD6HWXzTkcIIvyqeiu4vt7/+XOyBSnpKWTgqInptQR3WL+cYMX44pf55YaJkja+1Xr3wnMCLooFEuRvHtLH0Gx3loOWoZQfx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(921020)(38070700021)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWRIMEVTcDZPa0RxaEk5QmlMRjdMckM2SlpxWXhYT0Fnd3REZ1pTa2FQenBx?=
 =?utf-8?B?a3ZNaVIvMUZHaGtzdFZjMVFWVjNyMHpEdkNKL2YwQnBvWW1kQUc5d2gyS05G?=
 =?utf-8?B?VjB2M2tKNTdLeEdCcDBOMHdpUHJTZlhnWkJzQmIwZWJDZkgrT01UNFZ5KzI3?=
 =?utf-8?B?ZWRSalpjQTJ0ZmJHMTJjTmJyNCt0clZWMzBrelZGY0ZkN0pITURoVExjdi9Q?=
 =?utf-8?B?VWRQdTR5Y08vcG56bGpaK3U0c3g0NEw1WnlDVTlLSVlRN1ZFdmMyRHpXeGk4?=
 =?utf-8?B?akpKZXJxa2hQbXB0bGxCei95YVl4K1Y1UDhNRzdWV2NKbXRoWFRuRG4xZU1F?=
 =?utf-8?B?UVQ3UENqeWFlcjdWeUJ4SkJIQXhoQ0ZBRTZCZTNGSXFmQWZ5d1oxSk9ESHh6?=
 =?utf-8?B?Nk5rK1RVNnhGR2NaUWVWVWFBN3RteGNHSHI2UnNqOS9PcmV2MHB5M2JQajhu?=
 =?utf-8?B?YXBLdVRTZU1neXFGYW1MTmdGNVR3MjhlVEkwRmtJNHJtN1BuTmNja3BQalk5?=
 =?utf-8?B?bVJYZUhFbDZ0K2tnNjNlRVpCWWx1azFuYlVvWWZhZWowRmxaNnc3ekV3K3Z0?=
 =?utf-8?B?R25wbzZ4SmJReWFqajdTUHZiVXZjUXdRM1lJRExKMXp2ZWJWaUJ5elllT0VS?=
 =?utf-8?B?VzNURWdCNm1BMmtodWZUeGxUejFvT1JXWTZzZFZycGFQSE5nTnVsOGJ2UzZ6?=
 =?utf-8?B?R25aMFdBVVNnUDRKQmphWS92TjJGN09lc1d2bm5WR0hDK0FXMjlsbU5sclFz?=
 =?utf-8?B?Uzh5YUh1K3FyZ3Q1U0FWdXJuUjhLMitCaEIzRHFUM05ZNXZ1R05nRmRMRlE2?=
 =?utf-8?B?UHp6dElyUmtHZG1yYS9MVkxxOUtpMDNzWXk3SDhRM01Zb3BXc0d0ZGF0VFpy?=
 =?utf-8?B?Z2Q2SEhOOWE0QXNIUjN5T2ZKYUVNNHZSYnlYVVhDalRtbmxVV3BvRHRZaW1E?=
 =?utf-8?B?dGhvL29GdmJMQjB2RVU1UVdDQjhQVDFnQjRrVWNUQU5JbjRhSm5iZ1dPOW5r?=
 =?utf-8?B?bmF0LzcxdFQzMmFwTzB6WkpvU2ZHUEovbXVGTWtBTFdiNjZuZ3AyenJ3U1lK?=
 =?utf-8?B?dit0WUtha2FnNDRPRGYvYStiZHk4RXpWWGRMK2ZDNWJKZnZ6UEF1eTFFelp1?=
 =?utf-8?B?dGxkWnR4Mm1PVzhrRHMyZ3hFL25LeXlCRDhHbVVqQjcydmZLdVRBR215YWtE?=
 =?utf-8?B?S21RWkNBM1JxOWQzYzhxSkhLVTMvR2FzWGdOVTZ6UldIYXowVGNXVHM4M216?=
 =?utf-8?B?QVlzYkEyMWlURGpBRDJjZTEvVHlBQSsrLytLc20rN3o4ZjdaU2luZkNiSytH?=
 =?utf-8?B?Z2xhcmVGVXlXa2FXb1JjWURueWMxZTdmNmlQQUwrVkhyay9kQlNvSVJtSTV2?=
 =?utf-8?B?aFlLWDVLWExQdk1naWNKSktBZVFlTVVNUGFheGo0MTFITHlkSkF5cjlqOEJ4?=
 =?utf-8?B?TGZEb0FSaE9Gcnl4TGZ6NWtsNG9VY3g1S210cnNXQVF6cWpGdnJwb3podmdk?=
 =?utf-8?B?bHZpZkZXQkZmWDBIRks2SkVtVVpHZVNsZHdiTFpBWFhsNitqN0d4Qm5DMk9r?=
 =?utf-8?B?Vmc0SzZlYlVGQmNPOVNIaFg1NjRDVW1ZdUp2dHc3RHhjbWVmb1RON1BIUDRw?=
 =?utf-8?B?RVVqUWppdXd1UllLdFFrUlBtMVZpY0NsZWNpS2lFSS9zOHNtUEFoU2dMV1J5?=
 =?utf-8?B?dFFSN0M4S0V6RUZnU1F3c1ZLYjljK0dLeFZYcFU4WUJHSUY1QUxhTHJLWS8z?=
 =?utf-8?B?ZnRSTjFUbm8raXY2ZG42L21RS3ZEaW9tdnFISEIyL3RaUmJ0dE5JOFhCMFVw?=
 =?utf-8?B?cEFkbitPRlhvLytOa21Ba3gyby9QOUw1ajdyQTJ5UEp6d0lXYW8yM29keERJ?=
 =?utf-8?B?eENYanFJZlhHei9rZldRclZtT1hUUUlsbnVIeVZyd2l1N1pReWViOSt6ckJ0?=
 =?utf-8?B?bGZRc0xpNXFCcFEveTVVS2QrVU1Za3NIMEdqK3ZsTHNBRnIxZWlFY1U5Q0VU?=
 =?utf-8?B?TXlSTEo1b1VIUENsL2pDdHMzb1htMU5ucXdscU9NS3hmYmdyVUU0ckxNdTV4?=
 =?utf-8?B?a0ZaL1Q3b1p4QXB2UUd1U0lyam0zbHFxQkNVamVZRWZVL3M5N1VTejBySmhu?=
 =?utf-8?B?RHVkUjdLS01MUlpoWlZMNWVhWG1wazVoeFMxRW5VaDREQUdmeGZxS3hxL1VU?=
 =?utf-8?B?VWZkMzVlMkNsYUx0V09qcm1aYnBpK2tkUjlCZkd6eEpKVTZKNDFnaUQwWStH?=
 =?utf-8?B?VjdhUFJnSEk0eHg4dUZMMTc1dm5FcWg2aDFGSXZ5U0VpMDg4Y21JZWluSHBj?=
 =?utf-8?B?TG13b2x0QUxnOWlrcFhhbFBEYm9lbndXWkxmV0pJWStFTlFwN1ZEdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5312EA9465E47D48AC4A1DCFDEAB0643@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 526da432-306d-4bc4-c039-08df3e217e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 05:22:48.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLHvFetQTD5hwtKf3XIXePLg3jS38Zg8YrZLdOXQasEpn0rM17Bi28nJiin9uy9zEPm92uBGb3zcMWaHqHwcaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB404786

T24gU2F0LCAyMDI2LTEwLTMxIGF0IDEwOjM5ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCAoQXJt
KSB3cm90ZToNCj4gcGFnZV92bWFfbWFwcGVkX3dhbGsoKSBjYW4gcmV0dXJuIG5vbi1wcmVzZW50
IGRldmljZS1leGNsdXNpdmUgZW50cmllcywNCj4gYnV0IGZvbGlvX3JlZmVyZW5jZWRfb25lKCkg
cGFzc2VzIHRoZW0gdG8gUFRFIHlvdW5nLWJpdCBhY2Nlc3NvcnMgdGhhdA0KPiByZXF1aXJlIHBy
ZXNlbnQgUFRFcy4NCj4gDQo+IFdlIG11c3QgbmVpdGhlciBjYWxsIGNsZWFyX2ZsdXNoX3lvdW5n
X3B0ZXNfbm90aWZ5KCkgbm9yDQo+IGZvbGlvX3B0ZV9iYXRjaCgpIHdpdGggbm9uLXByZXNlbnQg
ZW50cmllcy4gRm9yIGV4YW1wbGUsIGNsZWFyaW5nIHRoZQ0KPiB5b3VuZyBiaXQgb24gbm9uLXBy
ZXNlbnQgUFRFcyBjYW4gY29ycnVwdCB0aGUgZW50cnk6IG9uIGFybTY0DQo+IFBURV9BRiBvdmVy
bGFwcyB0aGUgc3dhcCB0eXBlLCBzbyBjbGVhcmluZyBpdCB0dXJucyBhIGRldmljZS1leGNsdXNp
dmUNCj4gZW50cnkgaW50byBhbiBvcmRpbmFyeSBzd2FwIGVudHJ5Lg0KPiANCj4gZm9saW9fcHRl
X2JhdGNoKCkgd2lsbCBWTV9XQVJOX09OX0ZPTElPLg0KPiANCj4gQXBwbHkgdGhlIHNhbWUgYXBw
cm9hY2ggYXMgdGhlIHByZXZpb3VzIGZpeGVzIHRvIGUuZy4sIGRhbW9uX3B0ZXBfbWtvbGQoKToN
Cj4gdHJlYXQgdGhlc2UgZW50cmllcyBhcyBvbGQgZnJvbSB0aGUgQ1BVJ3MgcGVyc3BlY3RpdmUg
YW5kIG9idGFpbiB0aGVpcg0KPiB5b3VuZyBzdGF0ZSB0aHJvdWdoIHRoZSBNTVUgbm90aWZpZXIu
DQo+IA0KPiBTa2lwIFBURSBiYXRjaGluZyBhbmQgTUdMUlUgbG9vay1hcm91bmQgZm9yIG5vbi1w
cmVzZW50IGVudHJpZXMsIGFuZA0KPiBkb24ndCBtb2RpZnkgbm9uLXByZXNlbnQgUFRFcy4NCj4g
DQo+IEZpeGVzOiBiNzU2YTNiNWU3ZWEgKCJtbTogZGV2aWNlIGV4Y2x1c2l2ZSBtZW1vcnkgYWNj
ZXNzIikNCj4gUmV2aWV3ZWQtYnk6IExvcmVuem8gU3RvYWtlcyAoQVJNKSA8bGpzQGtlcm5lbC5v
cmc+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFJlcG9ydGVkLWJ5OiBKb3NlZiBC
YWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+DQo+IFJldmlld2VkLWJ5OiBIYXJyeSBZb28gKE1l
dGEpIDxoYXJyeUBrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogQmFycnkgU29uZyA8YmFvaHVh
QGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBEZXYgSmFpbiA8ZGV2LmphaW5AYXJtLmNvbT4N
Cj4gVGVzdGVkLWJ5OiBNdWhhbW1hZCBVc2FtYSBBbmp1bSA8dXNhbWEuYW5qdW1AYXJtLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgSGlsZGVuYnJhbmQgKEFybSkgPGRhdmlkQGtlcm5lbC5v
cmc+DQo+IC0tLQ0KPiAgbW0vcm1hcC5jIHwgMjMgKysrKysrKysrKysrKysrKysrKy0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL21tL3JtYXAuYyBiL21tL3JtYXAuYw0KPiBpbmRleCAxMTMxYjc2YmJiYzI4
Li4wZmFlZjQ2ODA2ZTVjIDEwMDY0NA0KPiAtLS0gYS9tbS9ybWFwLmMNCj4gKysrIGIvbW0vcm1h
cC5jDQo+IEBAIC05MjQsNiArOTI0LDcgQEAgc3RhdGljIGJvb2wgZm9saW9fcmVmZXJlbmNlZF9v
bmUoc3RydWN0IGZvbGlvICpmb2xpbywNCj4gIAlERUZJTkVfRk9MSU9fVk1BX1dBTEsocHZtdywg
Zm9saW8sIHZtYSwgYWRkcmVzcywgMCk7DQo+ICAJaW50IHB0ZXMgPSAwLCByZWZlcmVuY2VkID0g
MDsNCj4gIAl1bnNpZ25lZCBpbnQgbnI7DQo+ICsJcHRlX3QgcHRldmFsOw0KPiAgDQo+ICAJd2hp
bGUgKHBhZ2Vfdm1hX21hcHBlZF93YWxrKCZwdm13KSkgew0KPiAgCQlhZGRyZXNzID0gcHZtdy5h
ZGRyZXNzOw0KPiBAQCAtOTY4LDEwICs5NjksMTIgQEAgc3RhdGljIGJvb2wgZm9saW9fcmVmZXJl
bmNlZF9vbmUoc3RydWN0IGZvbGlvICpmb2xpbywNCj4gIAkJCXJldHVybiBmYWxzZTsNCj4gIAkJ
fQ0KPiAgDQo+IC0JCWlmIChwdm13LnB0ZSAmJiBmb2xpb190ZXN0X2xhcmdlKGZvbGlvKSkgew0K
PiArCQlpZiAocHZtdy5wdGUpDQo+ICsJCQlwdGV2YWwgPSBwdGVwX2dldChwdm13LnB0ZSk7DQo+
ICsNCj4gKwkJaWYgKHB2bXcucHRlICYmIHB0ZV9wcmVzZW50KHB0ZXZhbCkgJiYgZm9saW9fdGVz
dF9sYXJnZShmb2xpbykpIHsNCj4gIAkJCWNvbnN0IHVuc2lnbmVkIGxvbmcgZW5kX2FkZHIgPSBw
bWRfYWRkcl9lbmQoYWRkcmVzcywgdm1hLT52bV9lbmQpOw0KPiAgCQkJY29uc3QgdW5zaWduZWQg
aW50IG1heF9uciA9IChlbmRfYWRkciAtIGFkZHJlc3MpID4+IFBBR0VfU0hJRlQ7DQo+IC0JCQlw
dGVfdCBwdGV2YWwgPSBwdGVwX2dldChwdm13LnB0ZSk7DQo+ICANCj4gIAkJCW5yID0gZm9saW9f
cHRlX2JhdGNoKGZvbGlvLCBwdm13LnB0ZSwgcHRldmFsLCBtYXhfbnIpOw0KPiAgCQl9DQo+IEBA
IC05ODEsMTEgKzk4NCwyMyBAQCBzdGF0aWMgYm9vbCBmb2xpb19yZWZlcmVuY2VkX29uZShzdHJ1
Y3QgZm9saW8gKmZvbGlvLA0KPiAgCQkgKiBhcmUuIOKAlHRoZXkgY291bGQgYmUgb24gYWN0aXZl
L2luYWN0aXZlIGxpc3RzIG9yIG9uIE1HTFJVLiBTbyB0aGUNCj4gIAkJICogc2ltcGxlc3QgYXBw
cm9hY2ggaXMgdG8gZGlzYWJsZSB0aGlzIGxvb2stYXJvdW5kIG9wdGltaXphdGlvbi4NCj4gIAkJ
ICovDQo+IC0JCWlmIChscnVfZ2VuX2VuYWJsZWQoKSAmJiAhbHJ1X2dlbl9zd2l0Y2hpbmcoKSAm
JiBwdm13LnB0ZSkgew0KPiArCQlpZiAobHJ1X2dlbl9lbmFibGVkKCkgJiYgIWxydV9nZW5fc3dp
dGNoaW5nKCkgJiYgcHZtdy5wdGUgJiYNCj4gKwkJICAgIHB0ZV9wcmVzZW50KHB0ZXZhbCkpIHsN
Cj4gIAkJCWlmIChscnVfZ2VuX2xvb2tfYXJvdW5kKCZwdm13LCBucikpDQo+ICAJCQkJcmVmZXJl
bmNlZCsrOw0KPiAgCQl9IGVsc2UgaWYgKHB2bXcucHRlKSB7DQo+IC0JCQlpZiAoY2xlYXJfZmx1
c2hfeW91bmdfcHRlc19ub3RpZnkodm1hLCBhZGRyZXNzLCBwdm13LnB0ZSwgbnIpKQ0KDQpUaGlz
IHdhcyB0aGUgb25seSBjYWxsZXIgb2YgY2xlYXJfZmx1c2hfeW91bmdfcHRlc19ub3RpZnkoKSwg
c28gdGhpcw0KbGVhdmVzIGJvdGggZGVmaW5pdGlvbnMgaW4gbW0vaW50ZXJuYWwuaCB1bnVzZWQu
DQoNCldvdWxkIHlvdSBwcmVmZXIgdG8gcmVtb3ZlIHRoZW0sIG9yIGtlZXAgdGhlbSBmb3IgY29t
cGFueSB3aXRoIHRoZWlyDQpzdGlsbCB1c2VkIHRlc3RfYW5kX2NsZWFyX3lvdW5nX3B0ZXNfbm90
aWZ5IGZyaWVuZD8NCg0KPiArCQkJYm9vbCB5b3VuZyA9IGZhbHNlOw0KPiArDQo+ICsJCQkvKg0K
PiArCQkJICogUEZOIHN3YXAgUFRFcywgc3VjaCBhcyBkZXZpY2UtZXhjbHVzaXZlIG9uZXMsIHRo
YXQNCj4gKwkJCSAqIGFjdHVhbGx5IG1hcCBwYWdlcyBhcmUgIm9sZCIgZnJvbSBhIENQVSBwZXJz
cGVjdGl2ZS4NCj4gKwkJCSAqIFRoZSBNTVUgbm90aWZpZXIgdGFrZXMgY2FyZSBvZiBhbnkgZGV2
aWNlIGFzcGVjdHMuDQo+ICsJCQkgKi8NCj4gKwkJCWlmIChwdGVfcHJlc2VudChwdGV2YWwpKQ0K
PiArCQkJCXlvdW5nID0gY2xlYXJfZmx1c2hfeW91bmdfcHRlcyh2bWEsIGFkZHJlc3MsIHB2bXcu
cHRlLCBucik7DQo+ICsJCQl5b3VuZyB8PSBtbXVfbm90aWZpZXJfY2xlYXJfZmx1c2hfeW91bmco
dm1hLT52bV9tbSwgYWRkcmVzcywNCj4gKwkJCQkJCQkJYWRkcmVzcyArIG5yICogUEFHRV9TSVpF
KTsNCj4gKwkJCWlmICh5b3VuZykNCj4gIAkJCQlyZWZlcmVuY2VkKys7DQo+ICAJCX0gZWxzZSBp
ZiAoSVNfRU5BQkxFRChDT05GSUdfVFJBTlNQQVJFTlRfSFVHRVBBR0UpKSB7DQo+ICAJCQlpZiAo
cG1kcF9jbGVhcl9mbHVzaF95b3VuZ19ub3RpZnkodm1hLCBhZGRyZXNzLA0K
