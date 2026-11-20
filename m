Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795167514;
	b=2fTdUu/0xNGcGCwtxqtZfqIavsnWRAkaQsaXZ7k9kCEnElC+AXpWhJUwAH4nW7ZCfSRy
	 VDSrWr0NAmb6Rb960QS3HpS5zKCdOjS9Xa8aZMkZE6AQsf36OUaQzPpYtsG9co1ZkGZVb
	 x/ymmYIUreeyIgbUKyC7D72ZXrUvLChBCrxdVnJNI9Ss7DxBgJOlWGyNnjm033YYp9BXT
	 cg2lUb1nSbkJvZa99AAwRGQuaEe2ynP2p6bv8Dtgw10uhHKx/vplXrRZDDi9HsYqvVMj8
	 QAK6/9seezmg2Zj67hxTdhZBU8+gt6VufM1pvDKCFOEIpnWw3gbp4xDHDs8k4uh6MIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795167514;
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
	bh=E3kYN66unIfWJU+PWktPCCCNMP6jyfq3fFNRcFYEJqk=;
	b=XOTB65WxsumrsHMij2F8tgaz38VuPiexRA1ehwTJ/lzE2segzJmtYRY+OYjgrKwK5iX4
	 4g/297H1AsApZptHSjl5anhUozAaisu8oc4LR61C6wWTjTCVWAoHgH971/NtiJRn6igTS
	 5mRAguCRchhSlEo+2H2W01kBBR42gffTjquMKnEUClOceWzlijmSUmu5dQtsvznJ/revk
	 MQpYFB1Pr2+AnVgxYU5Z8xrMcZiB9xzohd9DW+cfjVikhCfW99WCVuWS/QgIqlR/Ztvwv
	 3WFM8/ntY1z+1RVWSQCG97v3Zfg9oqtGxRQ2U7T2lF+RkwQF/iOsOT/0azKIgsP3ncQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TQzXAOsU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.66
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4C606A33A;
	Fri, 20 Nov 2026 09:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BE4C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TQzXAOsU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGbw3k4M+2k71o/VSFreHzjc9RDnYkrzqkTTi1SzPhhXYD56dITfGe62j+ctDgEthbmTQYFXakn4EBJPjFGpuKXWavZFhOUete6Of7gvEKoxaZTIZN3lfbtlOKITp4cUXUtcet/ZzVv9AGodZWGR3B32HADwdbWb6L4UP/7WdVMYLhwVTSPCco1GauZHabOy6rO1GQD0Qs1fOG+N3EO2UgJw7PEdid0HlRe5y2k5VIFxNo6Zcrw16OXUhScrKjBOB9MjKmJKVk6xyO/uIgCx2h1CaKbTAbguvN71+7TWJdztI3K73zD/I8pKN7GjAiQaAPkdvmqeuYAPs/gEtgx+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3kYN66unIfWJU+PWktPCCCNMP6jyfq3fFNRcFYEJqk=;
 b=QSlPrzD5oZG57PzACrVqu4//e3EptTGah/JxKBlPwnNb72iYyfa4pUHKbkiKjO+8am5IV2DhjAdcrEXF/uxZDcrDcurGxEQ8lVfMRsoXyQEo36k+DKZgXY4g20WMDtvM1PbJ1kR205QyTQ1ONTaUyHmvOvQsjfK4HyXRBslLjTs3OuSUoI9PhSsgCAnyMh4BNtsZXcWPoiZQXqeHEEguxOqGJKLIzJLcuwJdxl2iNDqlT8cyF/BBo5+a5nR6kx1eHWRrLmA4yd6yZBqJh7gzskxS8K7GNto501yo7sGr2F3HnYwG3GrAJ7FC94y1SOXl4dGPjkKQ4AoNr1I3GSsWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3kYN66unIfWJU+PWktPCCCNMP6jyfq3fFNRcFYEJqk=;
 b=TQzXAOsUccTBTEFBNfbHevfIzVNiE3nwq3O1qCWHb0fzBWjP5hD8O5NV+YhKu6ZU6TPTxHIMheVZlqOqqyXEGaCjLU1jPlpYND3iOEVj/VO701r3VygsRL6d0GzXpnxMIEN0K3HZSghy/9KtmdzEdnAjTWWXjK4MmsfB91SWTlY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 20 Nov
 2026 09:38:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 09:38:30 +0000
Message-ID: <a8fe714b-6d26-4777-8b9c-4299ecdc3f44@amd.com>
Date: Fri, 20 Nov 2026 10:38:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma-buf: dma-fence: Add
 dma_fence_overwrite_timestamp()
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
 <20261119131830.2535266-4-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261119131830.2535266-4-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::6) To SJ0PR12MB5673.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 76af6d12-94e4-4f69-6b0c-08df46ea0968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|261102123227099003|261026140227099003|261026121527099003|11063799006|261028144727099003|261022075727099003|261022105027099003|261021121427099003|921020|56012099006|4143699003|261102130727099003|10067099003|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	daysot/Q0R2jsfrfCFYShvAmksU2zPzBKE2c3JtPAm8s4Eh6Shz9OKr0wEbDyTArMWEW/9Mb/jNcs1YVUEmIQg0AXDnwrOiP82N2Qn0YgJpYgcY5SjTvt3jW3zOomz0DPUJ7oec4RdNUYkA5ntEqlZkO5/KvLKuHHBK7ii/OqFvZYA95sm9jTW/qBgzOzVNAISRI5KpP68hQvB8339PcsB4SfEus0lvmYq+7doFrn+jvwG/3/7ddHPq72EOcbq/llRpknMgpAuK2F3pYD0dsdyy3aMLDMEyH/EgO3BPurcDHI00T7SJrgB6bi5oVDYNd/YV1RodCdNnXNI6j9knwleDKAFV21vLptzSNtkfmFqoVTb+BBki//wSwLLDeGmq6JIzi/wSnRiJtqiJtV1qKOkRf3hdIujsD/8AG3k/iF+TSCKwDaqhM4Y8IvdqwrBernl9RJIj/0tQksfiM0OXTEedB5ZZVLGdCC4KE6qhquUbQ37hl4mTtchJkPFBRfugCxpnAhkBWj3Jp48EOsrQxwoVyHoy87tIC0J3I6qzbIP45O065xlct0fsaRP2jgN4dqy7sdDm4lV9erco195Xdvugr8nsRkA3cLzubikuQL2In6sXlL03TD2NwmlE2lou8DmDmvfSXo6iRkDjWpPJVguWVX+vft0uvH7RhZzGk5i14g6ELv2OK15C2UMsPVYrg9c9dn/MPAIOZFYVxcqtxiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(261102123227099003)(261026140227099003)(261026121527099003)(11063799006)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(921020)(56012099006)(4143699003)(261102130727099003)(10067099003)(18002099003)(261009223027099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUlGSW9Wa09vaVlSS0NNWFkxSEQzZGc1MXVtaDc4bXJHSWEvZVlMdHhSelVy?=
 =?utf-8?B?YTNZRTNaN29odXlMcWR5d1hYUW9QYVF4TzFzTVM4bmNkOHdqOE9JZXR3WHRq?=
 =?utf-8?B?bGY4K3psektZTjlaeUZvMnJINHd5aW9LTjNoQzVOWW0vSGxFS0RJcmt1aVJv?=
 =?utf-8?B?NUh4SE1XZWxaeHoyZC82QWp2NDFyNndNYmZXSmZLbDdHZ01XVUh2TGtwUzly?=
 =?utf-8?B?N2FkcGtSVk5lQlFaMFkwTXEvY2o3aDAvMStmaW5tVzZwUkRBZEtXY2ZRWDVP?=
 =?utf-8?B?ZTB4Yy9yOHRBUHhjL1VvVWg1OXBWZXhrZmYvVnpaVTFhMkpZWXZobnhwTzF2?=
 =?utf-8?B?cXVKZXhQVk5LTlRSTlFSRndvNXBQWnl3VUI2YkwzTUVISWMvMUhEcnp3S3Nl?=
 =?utf-8?B?SEdSdWMrNS9TVVZ3dk1JRTJuMEM3dU5sVmkvWWs2YmNjUE0zdTZhVms5NG0r?=
 =?utf-8?B?bHc5R2xrR0JRclJXSjJVODFDRW93VWdSdC94c1ZvdXdSSFgrL2xwZm1FRnF4?=
 =?utf-8?B?QU5CWm10MlZ3U3lHM2NtajZWV1kvaEV3Tjc2YzRwcjRFMzBaN2M2clh0UWh0?=
 =?utf-8?B?dUY5b1N5czZBcngyR0VyNXYzbGdodkpiMTdHRW9yM1dqYmcvZDJ2MEtIQy9l?=
 =?utf-8?B?dG01dlBQMkRWY3FjTThFZUlBcTVoWWlBRCt3WXNTdDZaK3BWeGs1cDN6ZWZW?=
 =?utf-8?B?ZjdtVjRtMXIrUXVIbVF0TFk5OWR1dlprZ3oyMlFiNWJjNk9TWDZ1YWxxbU9Z?=
 =?utf-8?B?M3ZpbXk5ZEtpOTlsYmt2NDJKL0ViOEJjVHZtMzJVOWJ6bmNRbmtwL0pLbnJJ?=
 =?utf-8?B?ZXVpa2FtQTlBQTVyQ0FPakh5azFaVUpsUlVjeTNWMEJvT20wOVcxZUduUmc5?=
 =?utf-8?B?cVBrNDRTZmR1dWN2d2M5RWF0bTlKa1hHRFNjT1V3cmJQTDB5UTJUQ0NYYUZO?=
 =?utf-8?B?YWo5ZmluMWxSVjBaSXlQd05YTStlSGJacDM1LzVPSzVKalJxWHBWaHh2UEYr?=
 =?utf-8?B?ZzZMMzRxOExxVkhyRTgzcnAxak1JNEFVTmxFR1V2ZENKcmRHTUhoT1YxOURV?=
 =?utf-8?B?M3llMXFMR3dZWmQzcEhoRjVvUzNndmtndHM1MkJpOVNlUjZseDFCd1JNYTBX?=
 =?utf-8?B?TU1Kano3Y0ovb3M5R1RIMk1IZUQ3ZjJaQVJJTHRxcm1ieW9FVHNFdXZzV21Q?=
 =?utf-8?B?VkZQS1lXMjdrcXN3d0FCNTlHdTlueDcxc1BBVFBuNnNlK2tENFdtck5lVWcr?=
 =?utf-8?B?S1dEWlF0WHJXdXhwSC9nREhoUFp0K3FEcXZlQ2lMS3B4Z2tiOFlMdm9DcDhu?=
 =?utf-8?B?WXBWeFNNY09KMit6SXR5M1RSZzNiMmxVdElhcWRGbDZSTS9PeXdWZDdoUGpj?=
 =?utf-8?B?N1NBMUpZUDJLUlFZM0FuYjA3dmNiQjNyNmtKdUo4QVdXUW1sc1BWTUdTMUFS?=
 =?utf-8?B?aTd1T1lvTmErNXBJVmVJYzRUbVlkd3NFWU84TEk0Z1RFVEZXTUo3UGhZZXdZ?=
 =?utf-8?B?N0dMUHEvTWlRNzRCb1NSbE5hb29Nc2hGQ01BczMvanlXSWZiMXViK2hoRGY2?=
 =?utf-8?B?WVJIM1V4TkhRYXIyK2hWNUN6WVJUblgrS2pOanVsVXA1UnRTM0dzakpoZHVK?=
 =?utf-8?B?QndRSDZJcWZTcHAvcm4wNDE4S0xDUndLZnphWnlBQXlWeDFzZXlmUklYUFZH?=
 =?utf-8?B?bHpiNUhRa1MxNW9uTVpaOUVqY1B2U040RG1QZUlsSHZtUjBaVU41NE9LZE5p?=
 =?utf-8?B?aENxRWd2VXpWYzlPemtaKytTVUFzM3VBKy9oRWNzRGlPdUFXditmMWRvbFNW?=
 =?utf-8?B?eEMxZU9jTTBEdTJLdWtOUmRjVytUTGtiL1RaQWhTTnJnV1dsSTRPSHNiU2t3?=
 =?utf-8?B?OXRGV0RYVzc3dzY5b1o5RVJwZUdaTUhzeXJGdk41SzBLZVFtS3dhRTJZYW9U?=
 =?utf-8?B?WTdVQnptYkpHUUhLaFdzOWlQNFh6T292blJLREc5ZG5QbmZ2YmsvS2x1ZDg0?=
 =?utf-8?B?QlpEYzFvWVhrN0Z5bGtMWHRHWUJyeUFSL3ZxMlhxdE5FVnVQTXFxTmFXdnk2?=
 =?utf-8?B?YXlqV1hmSy9WR1pWVDIzS3VXeVNIVVJpSk4zdE1JNk5CWTN5MjRlSEVRb3RC?=
 =?utf-8?B?dE10M0NVSlVrOSt6b1pOWFh6TGdNZ2Q0dFdQakl5eitxTGNSNS92dW1pd1I4?=
 =?utf-8?B?alhhbkdDMExMbXN0RWlNNStiN2JKaGxJMnB3dHZaL2NBdnN4cG9uOFdzR2dy?=
 =?utf-8?B?a3Q2RXNWUGxRZkp3YW5LczI1QlVaSFY1QzJTLzA3VHRTVHRXRGY5dUJiNVc3?=
 =?utf-8?Q?hdm4LPX+mbpfQ2PIO0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76af6d12-94e4-4f69-6b0c-08df46ea0968
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:38:30.7645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NA5IIrvz3ppRtV9BOEUkEjsqRzDSSx7ve5deEDyLLjVkkuvmZol0eRHYTzc2SLsl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194

On 11/19/26 14:18, Philipp Stanner wrote:
> A fence's timestamp is just an opportunistic data point for debugging
> information etc. drm_sched, for example, uses the timestamps for its
> scheduling algorithms.
> 
> In rare situations it can make sense to allow users to overwrite a
> timestamp with a more accurate value. This is relatively harmless since
> the timestamp has no meaning for the implementation itself.
> 
> Add dma_fence_overwrite_timestamp().

I think that this is a very bad idea since it gives the impression that overwriting the timestamp on a fence is ok.

That was only done on the scheduled dma-fence because nobody cares about that time in the uAPI. For all other cases that can blow up.

I would rather come up with a clean approach for the scheduler to track the spend time per entity which would make that hack completely superfluous.

IIRC Tvrtko already created patches for that, I'm just not sure if they were ever committed.

Regards,
Christian.

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  drivers/dma-buf/dma-fence.c | 28 ++++++++++++++++++++++++++++
>  include/linux/dma-fence.h   |  1 +
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index bd58688b81a7..f1b7e90864bf 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -412,6 +412,34 @@ void dma_fence_signal_timestamp(struct dma_fence *fence, ktime_t timestamp)
>  }
>  EXPORT_SYMBOL(dma_fence_signal_timestamp);
>  
> +/**
> + * dma_fence_overwrite_timestamp - overwrite a fence's timestamp
> + * @fence: the fence whose timestamp shall be overwritten
> + * @timestamp: the timestamp
> + *
> + * A dma_fence's timestamp is merely an opportunistically evaluated value to
> + * obtain information such as scheduling granularity. In some situations it can
> + * make sense to overwrite with a custom value. This function provides said
> + * functionality with the correct memory ordering.
> + *
> + * Return: 0 on success, -EAGAIN if the fence was not yet signaled.
> + */
> +int dma_fence_overwrite_timestamp(struct dma_fence *fence, ktime_t timestamp)
> +{
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	dma_fence_lock_irqsave(fence, flags);
> +	if (dma_fence_test_signaled_flag(fence))
> +		fence->timestamp = timestamp;
> +	else
> +		ret = -EAGAIN;
> +	dma_fence_unlock_irqrestore(fence, flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dma_fence_overwrite_timestamp);
> +
>  /**
>   * dma_fence_signal_locked - signal completion of a fence
>   * @fence: the fence to signal
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 34aefb63a7fe..815471b844f0 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -447,6 +447,7 @@ bool dma_fence_check_and_signal_locked(struct dma_fence *fence);
>  void dma_fence_signal_locked(struct dma_fence *fence);
>  void dma_fence_signal_timestamp(struct dma_fence *fence, ktime_t timestamp);
>  void dma_fence_signal_timestamp_locked(struct dma_fence *fence, ktime_t timestamp);
> +int dma_fence_overwrite_timestamp(struct dma_fence *fence, ktime_t timestamp);
>  signed long dma_fence_default_wait(struct dma_fence *fence,
>  				   bool intr, signed long timeout);
>  int dma_fence_add_callback(struct dma_fence *fence,

