Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792495190;
	b=QbBOhaaZu800WNxI0bMmHbwJD4AZ/jHZuvCZJAXj0GhhWq+ELJZzCGPKf1racsJ5Y+sy
	 Of6g57+1BFAnO/YbUQZ9m7FQKCjgc3nXChTwKmfpHpHQkstUHaHn0cDuNFjeS8+8g8sP/
	 ABDcHRCyVUO8zTaVQblWhqGqjzS5YndGQxyO46G/QsK25ZlzN9A16s5rMLZ8UdV+zpI6f
	 k75ifdHHcVEuoSvRhE92KZfZYMc/qWzncbbtOneYEeOEjo7zfE81/pKpXKd/Sh/mOkEJz
	 20TSTmQGE02Nken+RzaveDFLS1Mml8wrNBZdNFTi8IhcRE/j4Gy7sMy/Ov1Zjmy/Ilw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495190;
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
	bh=lwAGlC5cgHyLHo5csSXqabd9CnRhoOd2gbLTF16IaII=;
	b=bvZ9nK84KJm56SYvltzDED68xZ/qbi3h87PPU2Z5r7lrKOA9kiSciFqUgySDm83ZY0ol
	 +bXH9B3ttHXhUJm4YEdb6yIkQdDy1+sBTsVcV+kWo8Ix8l1qN4L3+CsCgnq3a1JbhJo8B
	 yeO0EdEXBkM1UlfCzuBqVl6xhcBMAT9zcAtbkICtCo3GOG8cY3wlzYPzEVm5N5XUNnjdd
	 BKfaZQpJMUPON9p4c/a1586j10cr9r+ijxNDBFXYfYeOkoq7sfhK8rTgrTLlDeeWxaWb0
	 oGoV8dkEOYh6cB19xgjR2LeoLii9sLlfKQlTKdsf2oT3Ni+NNjC0HGl1idCM3BmuOUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qOHBO5LU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.38
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E8606A31A;
	Tue, 20 Oct 2026 11:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E19E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qOHBO5LU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aELiAdt+NFZtz9NsMRx3RL2nwoUgCAxoIh0tNZE0MVCO0tQWd4ex+fSvmmVNXEDNO8392RbK2kVQkafuJ/I0CrtBJ9B1jbD9Cg7HmoI/hzotkUX9ddMNGTjTlhZFhQSPzVGiqYvszxyDUDFVm6L3l5BiWq4gadobnaQh38bwZA66AsW55ZDIepx2byd+U/wMaRdLUhsk/cYJqh0I4UL3pO8xg6QPuWAcFNgVNb77AcO6mrzUfIoAkp43BgffqOjLOT4ApuHDiOaRZvqTTwbTvmsFrdS/32ijjSX9U4o5g1Dls4L5HdEYECsgswUhLgfulLl8bQ6F2j4Ih70izbdFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwAGlC5cgHyLHo5csSXqabd9CnRhoOd2gbLTF16IaII=;
 b=Gk4nZozr9c5JRt71LDd1l2pCikSBvnwSMWtwgVxi67mRn+vvshQQ/KDRiq2hq+G0SzkGDTm7N9G+P3VPNNuIia/u/OgfwAFpTARujthh3qD/0b3cwzEws5ZzDyWixywvxxAhJD5ZAw8+Rq+YP/8LzrojUPalROL55uVDu6W6jKhOThCcTcrcTeCQOrLnNIHTPoju0DCNaBzt6r1IWqgKUZV6WfS625Zq8N6qp6eGoM4wxTi8gf6pZh5KkcyLWMVX9BXq0oWbpXwwb8v4Zh/gUde+6wSdJ/6FLNVxfDlaBXKwzymEDn461HqiPx/9GwmEfs5IJEG3PFBjrmoFHiaH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwAGlC5cgHyLHo5csSXqabd9CnRhoOd2gbLTF16IaII=;
 b=qOHBO5LUO5uCcCWND0B3VJvEBmZX4Mr92SrWLDDU540oqXARNIc+SO3bMAouhqYzFbetAg8f6P0vTF3nH2wy6l3ISnbP/d5w7+4PK9yk8BcH0U6i1VAEXZjc34PaCKzbEtcuQY0368xDj51kxj0Eo48EeUMHSjqz+l0e8kW4Jqg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 11:19:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:19:43 +0000
Message-ID: <7021bcf3-172b-4275-b6f1-065b7d0aa791@amd.com>
Date: Tue, 20 Oct 2026 13:19:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
To: phasta@kernel.org, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, Sean Paul <seanpaul@chromium.org>,
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>,
 kernel-team@android.com, Simona Vetter <simona.vetter@ffwll.ch>,
 stable@vger.kernel.org
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
 <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
 <d54ba24b0a4748b5c00052d4542460ea014aa50d.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <d54ba24b0a4748b5c00052d4542460ea014aa50d.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 03410bce-8df1-4ce7-50b9-08df2e9c0a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|56012099006|11063799006|4143699003|261009223027099003|261009221227099003|261009220027099003|261009221727099003|261009223327099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Pj0IWCa5QaMG5xyjXb0wdpqSgsx8lz20bulyVvB8vj2fo2lLumSmhX6p32ESe+eIY+ZOB4TyIbGz7uo2WB+62yeZKwl79MM4RT6r0XEp6N7KJeCAyGQXT8gWmSDhFXiM7D3YKnj1sUjgIZoflh6HJjX/mnvAfm0nOPdSflHCt+MF4t+UyHE/JVCvW5YRzOG+R4I7w3ilYXEyWtKqkJ58BD+o8c2z1AkLTPd0g7sMKkB+WBboqDy4BJHz+ycnbdlPz85bE7PRZLJakWpr5efwwyAX0c2kRCdvh+K7sCcQd8lsFNchl5/fiWpgz/at6INydlSgtYhd5aV63zMKUJ3lcLFuVihf+8EWH5AWqpxu39v5aUSWvemKZ0KE2mOTW1bgzcdjNpC9B8h8rt6gwBCDmHB4xbKCBlSak7il2bw2uQExRnfAMLlhEmvi+GwmXYdTja3/O2qQQSiV/ZxeziPXdYMHS3e3EpXL4wy4rGXENPLVUbsLv0ny63HSpzJzIOTm6JYIq+83fH6GigkD5YEx/895XJtz49EFD7j5oT3B/WBV00tA5WTWaBMxkZfoHRutvFWhumSpEmHHFSzAfEDK7rJSY9GZYDn6GjVVjASE+zZr37T5vLOYW1+fJKWy/hOclZS1VNeuA+iwOaGzLIq2kvd9+gg2Q+RecRd4k77uFdI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(56012099006)(11063799006)(4143699003)(261009223027099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223327099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHp1SUpLZmtyNHB3ZVJGODhmWUxVRElvM0JYb29tQUt1a1dCU0EwUmFZb1JE?=
 =?utf-8?B?dmdHell4UGFZNnNHcjZZczlSZjcvY0dQTzdxK2pKTWtYZGVPZTEzb29GY0ZX?=
 =?utf-8?B?NjQ4UTFBaVdIUG1TaGJtdEFDeERWbDUvSlRCQXdGRTgzciswaFQ4Nm10OXZm?=
 =?utf-8?B?QUl4RmNwZ29GdUtjaWNCUE9Gc08xOVFYWlgxNVQ0UktLbDd2akhSRUJQYzZB?=
 =?utf-8?B?TFhMOUhvRlFYS21QZVhXR1plOWFZcGZMMHlFUTdubGJuQnRyeXVJVWduNXZk?=
 =?utf-8?B?TlYrTENtODZoYmlMUWYvM1B5b3NKYUszZjNXVzFzYnlDMUFTMXAwZjZJQyto?=
 =?utf-8?B?TjlKeFdIQ3dKUkVRQTBib1ViT2IycUhLa3FKdzFQREZEa3hKeWtxWHQ2QTRx?=
 =?utf-8?B?T2JrdUpYbGUzK1ZJZTRLY3Y5QmVTQ1VtWGd2enNyb0hLQTJXcUgyQUJjYzVr?=
 =?utf-8?B?OVJ5MDBKTy9iVENJMno4bVhRSUhHZzZoTTBVZVNtZnlvYjl2WEhoVUMzMFEr?=
 =?utf-8?B?bGtqVzhyZFZHczhWUTBWeGlnMmQ5MklVVWpUWnJ0c3RjNmxhODVRMlUwL1Vu?=
 =?utf-8?B?U2dDYk5GWU9ubHhtR1RZUm1Va0ZKVmN3UHptNGVOS3dyY05uWVJNOGp5bWFq?=
 =?utf-8?B?cGk0anVnbjJ6Z3REMXZiS09FMG1ubmZEL3dLYlBJNTQ2aUZDdGRiTEs4VE9U?=
 =?utf-8?B?M0krL0tFSGJ2OVRrSGJ4cDBlRml4bWw4TE9GQ2hEcGxacjF3OWoyOUphN1lE?=
 =?utf-8?B?cGp6L0dGYnd4M3paenI3bzFXZ0x1QVhhZ1NleUpJalZnMHVTTEpoOFJ3MnRt?=
 =?utf-8?B?YU9Fa3ZWMVdwV1A0ZzJhOEtvd1dZaXZEUU56Q3ordzZ0SFZqR21vL0RkdGZO?=
 =?utf-8?B?R1k0cEtjeTdwZjhpNGJDWXI4SGlROEYvcktBWDRjWkZQM1RPZzRKdWFWNTl2?=
 =?utf-8?B?RnhDZlNBWHJqdmpIdENhMEsxT2p0a2tjM01Obk1vbWczSVRoN3p3c1MxQlRK?=
 =?utf-8?B?QktCRktHdTZBOVNLdGxMcjVqdld5b1ZVZFFwUHozT2oxUDNmTTR6OHA4cHFO?=
 =?utf-8?B?VWF6eFhUUS9hZzFrbXNNMlZyVzdubkZYWVdZdk5mWFRYRzBmV1ZxZjU3RFpB?=
 =?utf-8?B?VVV2eTY0UGZFcUE5OTh6MjhhNTIvZnJDVW02SkZQVzBiNHNSWVV3QlI2V0Q3?=
 =?utf-8?B?VzRuVTBiZk5JZkN5OThpZG95VHF4V2VlbStaTFNWOTN3TzFRdmo5S2FNZ3pt?=
 =?utf-8?B?eUZWNy9ZUWppR2ZnWnF6ZlZmMWJ4NW1HMjlMaEtkdTQ1d3hYZWRLVWlPTzZN?=
 =?utf-8?B?M2JNK3BoRWRiYkdPWktVK2xOVDh5WU5oMU1qWU5OTDVVNW1sdEJGK3RIRnBm?=
 =?utf-8?B?SFRDNmIzMDhCTHVXMHRsbFdvVjNLblNqN0RTeERnbExZN2VhdjR5bjQ1aVFK?=
 =?utf-8?B?bW5GT2FIUWpJbzRSM3RmUlhhbHZGc0N5SmxZV05QTkprU1lJQ2IvblplcTlp?=
 =?utf-8?B?TksvSFFZSWg1cUcxVWZWRGpiLzN2Sm5IVVQxaDlyeEcwQnRkQ1ppOWttdXQr?=
 =?utf-8?B?TVBlYk1tOWlER0YrSDNVOUtmZ0xQR2JSWWNadTVJREtFTnFZOVpaRGxZNmg1?=
 =?utf-8?B?d3hBcitYYkxEK3doRkMwWDBsb2RaakJZcEFGblVkYlZMaFI1djVqR3FBdUVt?=
 =?utf-8?B?TVpzU1M5MGJ4NHZnMlBnOG1BeTYrWWJzREpOVUE3MUZjNGNhQ3N0UGNjNy81?=
 =?utf-8?B?cjJCN1RYWHpDMWZudjhzNU12THQ0WFM1SHJqT2FnU0xyR1NNRWFQemtTeHVw?=
 =?utf-8?B?ejlMb3hkQVZibVRCM1dvZGFxejNlYWNhcThTeUdIdkpWTkFORHNGOGlTUzNy?=
 =?utf-8?B?K2IweGRrL3hUcGxaUzc3ek84bEpmN3NMUWRjZ3J2MFR2eXJua3ZYMlhOaTgz?=
 =?utf-8?B?U1hib3JWdUxJM3Q0LzNESkszQjhZaS9aUFVwKzVKRFBPR0NmSjcrUDdUZEdw?=
 =?utf-8?B?THBEWWNxRHR0N3BSNUxOMnJ6RkVCcUo0Lzk0ZHdkOVZqZTNUYmpIVDVta08y?=
 =?utf-8?B?M1h0bFJBd1hDVFF6YitqQWh0R1hiOFkvMGk0T3ZsMzdpTThwWjBKWjR0aGxI?=
 =?utf-8?B?c25kWTdFVHlLdkh6VU5maFdmV2I2TmhuaHFRdkNod3YvVDRTTHlQUFdLMUhm?=
 =?utf-8?B?LzZJdUtZcmhZUDJ4MkttTzFiWlBSMWN3cUhHa1pIZGExbkZLRk90MFdpYjlN?=
 =?utf-8?B?WUlWbWZReWNqNkZYZk5XekJkM0xNVTRrUHNtOGo0TXpHcHBBSm10SjZIM2Nu?=
 =?utf-8?Q?J0n78SugayPbAO3N/s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03410bce-8df1-4ce7-50b9-08df2e9c0a82
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:19:43.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2K2lFCLby0DLuJsfNXRGzM0LNyheYbKtTDrFIY6iRfhfPWr6P/kTgPmrdiLg5X2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729



On 10/20/26 09:14, Philipp Stanner wrote:
> On Tue, 2026-07-21 at 09:21 +0100, André Draszik wrote:
>>
> 
> […]
> 
>>
>>
>> ---
>> v3:
>> - Philipp: update kerneldoc, add Fixes:
>>
>> v2: new patch
>> ---
>>  drivers/gpu/drm/drm_crtc.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
>> index 63ead8ba6756..e8e80c936852 100644
>> --- a/drivers/gpu/drm/drm_crtc.c
>> +++ b/drivers/gpu/drm/drm_crtc.c
>> @@ -493,14 +493,23 @@ EXPORT_SYMBOL(__drmm_crtc_alloc_with_planes);
>>   * drm_crtc_cleanup - Clean up the core crtc usage
>>   * @crtc: CRTC to cleanup
>>   *
>> - * This function cleans up @crtc and removes it from the DRM mode setting
>> - * core. Note that the function does *not* free the crtc structure itself,
>> - * this is the responsibility of the caller.
>> + * This function cleans up @crtc and removes it from the DRM mode setting core,
>> + * after first waiting an RCU grace period to ensure @crtc->dev can safely be
>> + * dereferenced by our dma_fence_ops.
>> + *
>> + * Note that the function does *not* free the crtc structure itself, this is the
>> + * responsibility of the caller.
>>   */
>>  void drm_crtc_cleanup(struct drm_crtc *crtc)
>>  {
>>  	struct drm_device *dev = crtc->dev;
>>  
>> +	/* Ensure our dma_fence_ops remain valid for an RCU grace period after
>> +	 * the fence is signaled. This is necessary because our dma_fence_ops
>> +	 * dereference crtc->dev.
>> +	 */
>> +	synchronize_rcu();
>> +
>>  	/* Note that the crtc_list is considered to be static; should we
>>  	 * remove the drm_crtc at runtime we would have to decrement all
>>  	 * the indices on the drm_crtc after us in the crtc_list.
> 
> 
> Seems we forgot [1] this patch. Sorry about that.
> 
> This fix also looks fine to me (for now) since it's what the dma_fence
> contract currently demands.
> 
> I'm a bit nervous about a synchronize_rcu() being in every cleanup
> path, but I suspect it's the most reasonable thing to do now.
> 
> Let's wait a day or two to see if anyone has fundamental objections.
> Could someone with some CRTC knowledge give it an R-b? Otherwise I'd
> push it this week.

I just picked them up and I'm about to push them to drm-misc-fixes.

Regards,
Christian.

> 
> 
> Regards,
> Philipp
> 
> 
> [1] https://lore.kernel.org/dri-devel/73fc12734386c9bebc9cf6d3cea4c5f8e125255e.camel@mailbox.org/T/#thttps://lore.kernel.org/dri-devel/73fc12734386c9bebc9cf6d3cea4c5f8e125255e.camel@mailbox.org/T/#t

