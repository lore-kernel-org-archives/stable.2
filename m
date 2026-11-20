Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167218;
	b=mMwsdNJfWPnG/B2W8by3nxZcqxIbJsHwHTEXBKNCG76+mjHERt6DFBinusXD3j4MwLWi
	 x1P3ZV5+orhFYF3dczOmHxwRZLKB6vqM6bXQKBwbl3/09xf7aUDxghdmUcZLUDzVNYnaL
	 WtkrKjd1ntIjuxfPNrQshkQRWPphcG/hc5w2Lbe8C2idrKstknd+zeX4skbC72iiNaL+/
	 J1YSErseISWzYcTStTbykQMpOiPd/+gyFtx1LFFLBg6iW4kCrSlmqQR6lg3WARn5naUPH
	 3rhKAv1XNdbNW1ORjbyxin+usw/xNMkg+skM/Dv8GzFMPWHOp2C8vJM73AZChVu9cGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167218;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=f46fSWsQEpET4J8APD1E1HzLj2/b8klFa+7cub+C8ys=;
	b=AGMamjK3zav8KVJru6bMbqlsqeXL+NH/WI7LCQ99yjfzJJh6P1f3YEAWmeqsmgRe2QQt
	 HOr/LZquYLRZjbp8TZ7xbPjOcydo3pLbxvdQ5ljmeQHhLxKrI6UMeS4VCOtoDHFygPcf+
	 KoErvVvrKPTXwFFIEtc7uSJ65Itz0DgOgu0TLzJoik65E0yaE7VfvKkOHptzesEs5eszz
	 FWUEPSW69jYgUXZhYdYr6O1GtSmfvNN9n2RAInKcQb000h/lXMhodCXa+FcVFY0l92t/K
	 JKkayXOFCMKRrmltstxiyzp0wjP2zaHurB84Pe7IYPFUTvCSW1SLh/QM9JV6MiKS/8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="h/Ka2vJb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.43
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB846606A325;
	Fri, 20 Nov 2026 09:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB846606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h/Ka2vJb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJb9XUOBSyRF7CO/KdRoRyAHv7cW28zwPsYmqTnbYL04gXGP5EQT93frzhtbCUUrjgPZGYZXUR0ZPtxK6CSbKdp3cLJ091NqR9lgBMKzMklAhT220pJsOaiQsF4xV1yGSSR6vz7/4UnTOKGk+Wr4Fu7Q08Y2gmMpYhhu145GUB+p+AG1TebwDIIn1xRMsBj15auuxrgrNf2KF5y4Qm/fzDELK3HH5ER2GBoApfCU/WTaaJrvmIRyWlMAifOTHc9VDKdpkk0t9BUbZtompgpjN+kD7JFlqsNtvXWltJz0sMUqziUTH4phEyVfkf8Sf7GDxG5riZZ0Gv0Vk3bCxs+yUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f46fSWsQEpET4J8APD1E1HzLj2/b8klFa+7cub+C8ys=;
 b=OYscwwbwNZaiBbOvHy1DCmEQBps9RSJ7XE4FmF41qbGzj1B7qSTEwIeaTk310dWqeq9XIVJkKSePFSksQ9Oq5BWtFYAvCRLk1h/Nb2FRzUsEstnU4GXnhi98zG50ORpBPJKh2FUw2zHPIyjNr39koQ6rmyCWAbLhLpn6WwCiTryr2Tv8A1ZQXRk89hODwAQIsPVc5Yd1+fJSWtwY7uHb8iyz4pPv7Uqb+m1ZuJxQXLAstW+I/doyMG485OaDjUppypAWhmBkZyclCNI2rzRsrWkWvBKOjJ13RlDbn25H6vJEzAnWhV2dTBUk4C3dylqYd+oyf9aFl7H1cTJKPOBeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f46fSWsQEpET4J8APD1E1HzLj2/b8klFa+7cub+C8ys=;
 b=h/Ka2vJbA6NT0K0zUxXqQ8V2mMvY5DPntODKnGw3UIgDVkuMSSepCer97VRSVJ8lFUAiLcCwAaLi1iHvx12+CrUzCx8WhjA0e+fgfeqvEKhJmhvKhOkorsJISE84a94wpPeuLTJrb402+bjmDCrL0y/Ti45sOPyNkin4hhXdDvE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 20 Nov
 2026 09:33:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 09:33:34 +0000
Message-ID: <1505a605-a5ba-4fed-bc91-89177faee4a0@amd.com>
Date: Fri, 20 Nov 2026 10:33:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf/dma-fence: Ensure correct ordering in
 dma_fence_timestamp()
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Chris Wilson <chris@chris-wilson.co.uk>, Danilo Krummrich <dakr@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Yunxiang Li <Yunxiang.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261119131830.2535266-2-phasta@kernel.org>
 <20261119131830.2535266-3-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261119131830.2535266-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::12) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed25bb2-748e-4853-7d9a-08df46e95857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261102123227099003|261026140227099003|261026121527099003|11063799006|261028144727099003|261022105027099003|261021123027099003|261021121427099003|921020|56012099006|4143699003|10067099003|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4jVJsdCKGMU/SsMNhHFOwdhSRB4bpMqL7isz3OLMzLn8h1cdt7K0258TyeD4yTbPFKWoXM/LtwNWD6iJa4hwhPQUyMWf+rPaWc7oznDH8LKkh3q/dbuK0JJcgdmUTpW1jVEB9bukNx7kQX7K6wtVI7Zp6jL8ATFFbkSxmQlbOC7Ove/4BzlL83q5cHUAiwq9oBVcwokFQGAOneZK30jeDMRupE2F9DfeJH1QsZWHJxOduvxlPzS2R5TDuNbcsAIHuohyfFEWGPcuaCgFWasWoQl4JZXVkl6Mgw5i3GkR4BroUBawpOnMSXfgL7HeGsKYm1scEIHXsLIonsw5vX0HSE4tfYhrTeA1CSUS443LNWfoNXznJz4N5lRsw8KSQgoxoYlTelTLJ4Z1RzGmBXxrFONWfOu45h0LEVZtK0Ctp+1IGsl+H3sTEj1cFHySXRiijDQcRTyv1dRy1vOudkEYrScpaSep8fHK2kaoeGJTr91nyJNTLguG1mhT4j9dWUWG7kSD50oZv4bU9J0xO/bTHMduSRcW+L4NQdwbzGPcq9LXCp8EaWnYvR8HGWzF5Eg5c3vwR5CpX4mGFnbukqYDdQw6bnlpTjoRNQX62czN7Qoed5gdxNsUIDwvrEAmzyd4P0UaWtKHW0ybcxihNk26veXvwub0bnDqdIbDnO267Xs3EmQasyw0+MAI1RHbCujghcnOoNt4Gz0DjqgJM3OINA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261102123227099003)(261026140227099003)(261026121527099003)(11063799006)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(921020)(56012099006)(4143699003)(10067099003)(18002099003)(261009223027099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUF4NDdxYmJQZVdPaFJkMjlYMVdBS0wyZ1ozSFRnRmU4c1FvZkc0Y0pDMEJk?=
 =?utf-8?B?bUJtWDBxSWhjeGh4WG8yMjdkblpNd1d1eTJXUUZYYUxyWDI5YVZQWTVOZzNU?=
 =?utf-8?B?U2cvNUtTTmhqZ3VMZlA1OUEwblgyOXFkN25yajVHNU9SZXlzeHpwdmFZeWtx?=
 =?utf-8?B?bVRhWk9WaEduVnY2a1dLMDZFOXJFbTVKYzdKV2VZNEl6VTJKWXpvajVldXIw?=
 =?utf-8?B?NE1nZXBFaTcvTEJ1WUlEZ3p6bjgvR2M4TjY3VUJGcEVvT1YydUhzMGxQcHgy?=
 =?utf-8?B?OE5CbXlOVGlvRUh3bWJiUmJlUXEySDdMU2VaNm1rai9EZjZnclpKaWt3VUZu?=
 =?utf-8?B?UnVHUTFkTmxjUzgzdWhEOVhFVnhVT21EOCtaUVpjMDR5U0F5K1g0UjdZSFVv?=
 =?utf-8?B?UlUwZ25CZ0RxendDTUZ3VVJvSTNGWXI4T0pVbG9RdUFNbGFZdE5IajNNdUNJ?=
 =?utf-8?B?ZFZKbFpoTlhpQ1FvWVB5Y1QzN01sQmdzL2owOVhLVTAxZmt1cUZDcnYyZURv?=
 =?utf-8?B?MlFibDUxN1FiNmxOWVc1aC9xaUZQNVZOZ2pZOVptY21SQWppdmcvZVE4UDJC?=
 =?utf-8?B?VTJwRDhScnpFcm4rWVRWeEo3S2JkeDByM0JyWE9ZM2VJaUJJM2lCVWhvdmhT?=
 =?utf-8?B?YWJQYUwzRjhoY1NhYU1HbHk4azdEc2VCRHFGU3J2d2RpVjloYzRQa003WW1D?=
 =?utf-8?B?eGJaU1ZYNjB1b2pralU1Z1VEVTR2eTVYbUJvbGRZcUhneGE3d0JjaWt4VFBK?=
 =?utf-8?B?U2pEWTNLd3htM3J3bTg3TzF5SnBXcGkrZUNnQURMNXFNTVduZEFFN1BPbitR?=
 =?utf-8?B?bndMR0ZZakovRDRnMDU2UkkyaGNvYjRQM0FxaHI5RSthb2FSc1dIRDRESFln?=
 =?utf-8?B?UkxEMTVMOHVuSFdCMWFDSllRQmpJdDBKRkVmSU5ERVAvYzI1R0lDYzRxUmlY?=
 =?utf-8?B?Vlh1T0hMZjlLU2RZaHFncjJBYkcxblBsYlZEWDRFSWk3NFhhS3gweGRzOHpV?=
 =?utf-8?B?WnplNXlUVmpXUmh0eGZnN1pqMUxWeDZrWFVHQUZIV0tiRk9RamhzSEhOb2pC?=
 =?utf-8?B?d3FqM3hzNHFxOHNIR1dQTkJpSXhxZjZBdTMrTFdjZ2RvSCtYUG84aG40Vkh4?=
 =?utf-8?B?NzIwWEJnalhDMEdUbTFhdzZzUjNIN1NPV0YrLzNLT3VhYnVMWDRyV2dyUXhv?=
 =?utf-8?B?ais2Nlh2WjhyWkl3cVlNQUIxT25DVWlGMnF1YjIzOS9lR0YzMnNGT1BtN2xI?=
 =?utf-8?B?SlJEMWF2ejh6cXVWS1pPUTdEMnJ2Ymxqd01XZW5Hai9EQnIwdERXRmFMemN6?=
 =?utf-8?B?VzBONlQ2b0xSOTVOK0FraEUvdGRWWmxsMTE0eXRhNnBFUDNsM1VLdjBSaDFt?=
 =?utf-8?B?SUV3RDR1Q0FicDdjd29KK1AzZ2VmYVhlVVlWSUo2Q21uNCs2clNucHpEYUl5?=
 =?utf-8?B?amQ3VlRNRFkvM0VGUituOHRxMXI3a1FOSFQ1dVNEdCtRUk5pSXlXZ1lVODdQ?=
 =?utf-8?B?WXJnK1pMUnl3SVc2dklUZXlvSjB1RWJ0K09KcktRUm9mWk1lWHNUS1pJWEpR?=
 =?utf-8?B?ZkxEM3MrSTlXbGZJN2Ntaml0cWE4WFh0NVlBUXVFdDlPeERlYVlhZGdOL3gr?=
 =?utf-8?B?aUp2TCsxQitwWVNoNzZjbGFiaEE3Qkk1b1FhQ1hGMTE5eGJLV2I4V1U1Sk4y?=
 =?utf-8?B?Zi80RUZ0MXRsNGw2SGp3dkprb1liTnBZRC9Da1A0YXZUQjlocDI3cDZGN1BQ?=
 =?utf-8?B?TEZXMGUvbkErRVVCTXVIRlY5dlEwVzR2S1NRei9PZDhKL2FHT0gwRS8xVXBi?=
 =?utf-8?B?SVovMkpCQ01kODdoZWR0eDZOSFRIMFJvcGJBRXZKNnFNbzB3bmtmTWl3b0R1?=
 =?utf-8?B?N2hlUHNTcXprM0lqSlpuQUZxdktzaExDS0trK1ZyRGJUQW05WkdzTnhKcndO?=
 =?utf-8?B?Tlp0OWQzbExqalFUT3RtN3NpcE0vVWlFcjgvcm5Lck51QTJRRVp4a2NhaU1h?=
 =?utf-8?B?NEpBUWpqR0tXL05QZytIM0RnU2FEMnJadTZpdU5EakhHQjIxUDdoTmRYWU4x?=
 =?utf-8?B?SG5UTFNIR2RPeEw0dENmK0swamswdFJpNS9SMlRYelFQU2d3UTFPdmNXSVZT?=
 =?utf-8?B?bDQreW8wbkpXeUVlVFRyMFBoT0RlNXBRdW1VNCt5WU42TUVmeVMxdndla3Rx?=
 =?utf-8?B?SWVHT1lWUVJ5amFOWUFGRGdsbnovMHBuWkNuOFBNNlRhQjVDOUlHdWpYRDly?=
 =?utf-8?B?MVZBZ2xYdnhOby9sSkpUMGgzWG1sNVBDWmFYZGZXaEZiZVpvemNHNzUyT3FY?=
 =?utf-8?Q?5X44sRK4MWPrrbB2Sv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed25bb2-748e-4853-7d9a-08df46e95857
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:33:33.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ta8hqCHJ7rW6/hi5UUogq57SEoq1VC5RyqtYCtr57asvzIIBlCoHL84aQJZH6AFL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194

On 11/19/26 14:18, Philipp Stanner wrote:
> dma_fence_timestamp() tests two fence flags with test_bit(), not
> providing any ordering.
> 
> The while loop + cpu_relax() seem to satisfy the desire to avoid
> locking, effectively rebuilding a locks spinning behavior in the rare
> case that a fence is signaling right now. Contrary to proper locking,
> however, correct memory ordering is not guaranteed.
> 
> Ensure correct ordering with locking.

My words when I tried to clean that up the first time: "Another alternative would be to grab the spinlock when that happens."

I don't remember the story why the busy loop was used and can't see any reasons why it wasn't done this way in the first place.

But my suggestion is to completely drop the DMA_FENCE_FLAG_TIMESTAMP_BIT as well. As far as I can tell that was only added as indicator that the timestamp is set, but we do that now for all fences anyway.

Regards,
Christian.

> Cc: stable@vger.kernel.org
> Fixes: b83ce9cb4a46 ("dma-buf: add dma_fence_timestamp helper")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  include/linux/dma-fence.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..34aefb63a7fe 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -708,13 +708,17 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
>   */
>  static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
>  {
> -	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
> -		return ktime_get();
> +	unsigned long flags;
> +	ktime_t ret;
>  
> -	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
> -		cpu_relax();
> +	dma_fence_lock_irqsave(fence, flags);
> +	if (WARN_ON(!dma_fence_test_signaled_flag(fence)))
> +		ret = ktime_get();
> +	else
> +		ret = fence->timestamp;
> +	dma_fence_unlock_irqrestore(fence, flags);
>  
> -	return fence->timestamp;
> +	return ret;
>  }
>  
>  signed long dma_fence_wait_timeout(struct dma_fence *,

