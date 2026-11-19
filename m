Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795066605;
	b=4DBYyWfX6XAagd6NGjV7AfjfggdOo+4r+wzEx3dflhKcnHcC349CcPmluXVD71IGDyPZ
	 ccFokt8gXam2GIXa52RjD0oIrNsSl4JEY9rWbE3WhyO3s1UoaaK8nGI6KqzaYAJ6YKpIo
	 X1fjDKINASxdacq+w88O8scyqB+jXY+FIrc+yX/tTKF2GIarEYSgib6w/vAMUPbxrhA4u
	 uAnUfeX2PJwVTGPAr3GmUFmVpdJ2kf3yPkNc9AS1aaURPJAWPkO77xujqSqr5i6OOyVbW
	 I3n6whmHw4pPdnKf0GaR0QhAFJZklyjml9IhX+7+KMuKjjLz1xnXRsBt/RZvBiNfcAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066605;
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
	bh=8qEFyIATQ9+Puqo7vIQ2JJPKI+Ya2Yyc0hoqeow0yws=;
	b=4xYlG/CanG7YLd2m/vnV5CYab+k8sbosYlpJgnJER8Q4G/n1we6uTJMvAq7YUaE0f8tD
	 /JtbcbL2H2c+IZq6HGea0+ZvZv8RyhPLdwVjLokhoyDvQyzDNZoV17TxklslnQFqQcQp5
	 4YrgUSi805GAQHIG7ET3acv3hba6WvF0EnrLvYgPPYx8RlwnFvIiuvJW8Ba1d97NaBg7g
	 DDS99EadFu2mxlGaeQmxSFa4FSb/57sRnqGfJH0VwvzK6awNKuo7Cyppkkgn6CBR4AvYu
	 AKRfXS0aMMxmz0+YFytuHgwwArWyb0ToYZ2ZKMYtLTY46VAyVrjrhBFYVdSU8aTiy1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1jezpPKu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.62
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BB4606A326;
	Thu, 19 Nov 2026 05:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6BB4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1jezpPKu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfhuCsadtlLTV+kw+EoG949j5xi4834YEMwQ2y0h1mFbCdIcfxv0wh8FJXWpMnrTITN1pIq3skkDxb/lfF4OOqyDBKn6XIjE3U57tUi/hkbCg+uEUSxJOgTk3GcwM2D/YKcwLfLdWF9npb9oBW/QhqQBsILO7M4vUyZ6mDB4FN/UuWgYojh90Ae8T/ck4fSfujQ+Orj+Gg/rHuan3Kj9Dd73pfteCvcwFJCBqTB80MZnWcav/vhv4WxqRpwyd2CH6fEqFPvSsBPq1QxuYaR8/XlxOlWxC2TRu+okkSyWgMDyzyIHRoPSKGZOSETB0yA6fFjAj8FlrIMm4Q6vbGdW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qEFyIATQ9+Puqo7vIQ2JJPKI+Ya2Yyc0hoqeow0yws=;
 b=yx2Ow62iM3BM2fCQpcQIFzV9u2QJSqP4ykVSR/UJ0bS4GvuLnfbfYgSV0NJf2d5TNuCUAN6I6hWpPKu27xSN9IheQ+rvO5+eZx37INWXLPcQqN9AbEwDBqUVkHkmX8Uc6V9Vb6cbtkQAnlsTHThk8PCqp6fJ0KFepNcJzRAR/vDA1dezVMFo8jhBvfyJuqDq/iOCA3SMxXuwZgLQMe0+2Y6pcLGzFd2KhTIeDfSF3/vgWdYAb/uCmQeRgg1i5UxhcZNQ3UOM+1SwMLFCsX7BFAvU6xkjI4iYrMfGta3I01VzZJ+Z0ljstl25Dj+o1o1z/3J8XDF8ygGYp3E2DUC8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qEFyIATQ9+Puqo7vIQ2JJPKI+Ya2Yyc0hoqeow0yws=;
 b=1jezpPKuhnWCOUOs5JGr1FyA5GtRhWAynEyvoYA4Raij+uRTD3FtlQ4ciea8EGz3XIDfEs8RVla3GPQWQp8KqQeiVPLMIztEeTqOU65dSTeaTZ5r6po2jDks3FEBCHfi7nmzBDIS0ONKDGT+d2wvUT8/LwiC/uS6loXebQsLHdU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Thu, 19 Nov 2026 05:36:41 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 05:36:41 +0000
Message-ID: <36c48ade-ace8-466a-9967-1261f485cc4e@amd.com>
Date: Thu, 19 Nov 2026 11:06:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] dmaengine: ae4dma: Unregister DMA engine in
 ae4_pci_remove()
To: Lee Jones <lee@kernel.org>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Philipp Stanner <pstanner@redhat.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-4-lee@kernel.org>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20261117163809.622249-4-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:176::6) To DS0PR12MB6559.namprd12.prod.outlook.com
 (2603:10b6:8:d1::6)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6559:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb03f01-ed08-4271-70c3-08df45ff1708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|11063799006|56012099006|261102130727099003|4143699003|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	u5q93L5GWh0Gfs28t7jTjOLqN/MEAtYs2EumOl+vys2g7VSkQP/EA/ohz/SghFPnWWpG5BnIINX2dl4AapHuNDRPjTj1uQV0jx0v+N3boUhuTGl2DVw0HTcLF3gKtHJsQj/6/ggmItp/HtUPY8RWPF1paQrNIWf7zrZkwuT6vUZELgZYKrQW/btJAlL9peAjXQjuKipvcyfLOSXvJqK6hocYEAbDj92+mAhfIAf2mqb5eFmNBLzuFQu9uhVEN3Eil3Kro/nzIvqF3wY3I8JzqRfx4MA6VoMw+0nz+/YBe6ShulIMC2OuZ4WSAzCavsB2bMnr8LygFTDsIYDH7UkSAbxxAqT7ywUc3PM52zY005R1i1ihWjB1rMzfM55+FjGztE/9ISw/+o6zKb/v1AzeuGni7xgXKigBDoTb7UdNtGHDbI3Hd5ERSKc4lvQutEdI7NO1iwt+BfaVgSJm0rjS1/3O3f+JATin0bogmmcf2wcQN4Zd4AyoeWrm2UC8zNAfbZ67l2xWkCg7uetwJrnUFEHCHGQ9Gvtdvy9Ez+8WEK1KTJ92P6LQVOEHi8fq3TehVYeAQWw4TjQqPo13mhB09ZCTGeXmLCaIlsDVuwYZwVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261102130727099003)(4143699003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWpzWE9aQ0JXVWNwRERmcUFOV1EyNEZmOXlpSXVxY2V4aWNDbFBSYU9LZ3RU?=
 =?utf-8?B?eUhiTUFtclVYTkN2Yitzb21jK1dyUmYyQ3dZS0V6QXZMZTJDcm1HQ1NvczVV?=
 =?utf-8?B?U3plc0J6QUlxU09uY0JwTG5rN2Q0TGRFY0k3OXlVd2s3SWQ4azRPK2J3MG5y?=
 =?utf-8?B?VXVTQUZmeVJtOXQwb3VvM1RhZXZ6RWhTdGxob3RVc0tUb0dlWVZjank1MjU2?=
 =?utf-8?B?eFRWMFhGM2dlL1pldGZTdkloWWNQNHg3SVR2enA4cG44WUh6R1BtRGNicDBn?=
 =?utf-8?B?RHA5ckNPdzd2dGw4bWhnQWlUd01qQVlodGltc29HZVV1WlRzNGMwbHFTOGgv?=
 =?utf-8?B?MVBhNENEUnk1eHRqK092Z2IvQXdkbFY4UWl3WlI1ckRvY1grQ0RFSmp3N292?=
 =?utf-8?B?NEozUzlWR21mSE82NGxGRldGYjk3RHl6Rm50Y3U1RkdlWU5QUjJxSnNVL0N5?=
 =?utf-8?B?QVkzODNOTUNacWtIbmlVVnhXeEtTN1VuZnBFVjY5aWh1cFpJaVFWTW56Zklk?=
 =?utf-8?B?RTJXMHlvWFg4VjM0SktPRkhkUHBPeG5kK3NwQkxFSzFSWVkwSk5rWW9iOE9k?=
 =?utf-8?B?RmlPMElncXVvVTNESkJZd1JUWlNjdUcvdm8rMktLWitpdGFERGgrTURJYUdn?=
 =?utf-8?B?U21ENG02Y3FmVWVJSFVqQ0N6Vjh1R1dYb003Q2x4d1dKR3o4MzVhMEp4QlJx?=
 =?utf-8?B?U25FOFVDWkhKYUtSYzIrV0YvN0pqbVcvRDBxeHU0UmIwYnBZOVU0WGNjQWIv?=
 =?utf-8?B?Ty9icVltQzljNEgvbE9waFRublF4WUtRa29tZ2tKUGU1MlFtSmJ5WE1ZWnFR?=
 =?utf-8?B?T0wyNFUvVUx4WTIrUHJNeGhTanBod0U1OHpxWnFqM1BSbHZNa0NLb3FwdTBK?=
 =?utf-8?B?emt0RWIzY1crREhvYzdrQStDMHpKb3dSMktDYW8wMnZmamlWOXpubUQ4a0du?=
 =?utf-8?B?T05wUGI0VmZueEpTUlFJd1NXdXZISC9OOVFMZ1Y2am9sTk1BWjJjbGlnOElv?=
 =?utf-8?B?T05VeWxkdGI3S2xTcWhaUGozUXpGbWxKc3E0MjZKc2dHdGFIQkV6cnFlRDA4?=
 =?utf-8?B?NU1ZSTJDczl6UGVFK0FtRDlPQmVGQk9oL2tYaVJMdkVQaithZmJMUnJSZEZZ?=
 =?utf-8?B?VmJHUDJ3SnBBdWRLZnpkdnp3MnpzOWovU04yRW5aK1hQdklXS1FPN0lzc3ZC?=
 =?utf-8?B?TlBteWVDakgvQnlEeDJTQ05SaHlBSCtHTVp4L0xCTG5OSDZKNW1qZmdjVUY1?=
 =?utf-8?B?b3pwRk1hbE1mbVNmZzVuR2d0ZVhJdjN2aFN4U0NqSUdwcjRoUjNjUWtqRWlo?=
 =?utf-8?B?M1gwdmVvUFlQVk5UMGJ6czNjMjFjclVrWGNHZklSOVBZdjlneWg3SnIwaFNX?=
 =?utf-8?B?NEVHSjhVWHNwYnlwZjdrYlVXNFNlaU90OGpEblNZMitpWEgwTCtvWjBuUWp6?=
 =?utf-8?B?MkNhWDNzbHlqR0hHVnNLSnlsSEx2Z0NQVFkvcjFJeWFuVWxSbFlVeDk2dnpm?=
 =?utf-8?B?bmpGbmRqS29tOXRwVmc4a2YvRkFaOTVHUzJWd3hRU3pHak0wOHpPbHBVaG14?=
 =?utf-8?B?RmZSNDllZDk0OVl1MEUyZWZwVDFzL0lPaHdUcVFhWnhQeVNPTHc5Y29OaGIw?=
 =?utf-8?B?ODJ2Q0F0Vis5ZVR4Z2kzd0pOSGFsSm9WN3VybG9OUFJRTUZzcUxGRVp3bnhU?=
 =?utf-8?B?aWxkYW1hd0R4VlBwMXpLc0t4cHF5bmVnT1VtRDd2blRVZzlpd1diRG1QUWs0?=
 =?utf-8?B?M2pObS92QWIyRTVLbGkrTDRuUVNiOTRsM0pKTkdESGZhejM3Wk1SSEIxbjJw?=
 =?utf-8?B?SzFlb3FqaGJsazRiU0V5KzZWUWphWmNBSzBvbXBXZUxzUWxlZkl1eTBucytE?=
 =?utf-8?B?eWdZSlBBam5UcUltbVJ1b0V0VC9YbDVNSlQzMVdSK05BdFdqbFdueWM2cXQ0?=
 =?utf-8?B?aUdnV0thb2t3Ky9VOEh1eWE4aWRoRTdRUTVFSEJGSEF4eXNWMWM3ZzFuVEdj?=
 =?utf-8?B?VGJNWXFzcDUvSUVuUld1eFBac0NIclFHenhEZ2IrUVJwZkJIOGI4SENBQnVH?=
 =?utf-8?B?WnU1N1YwNlpSZGp0TVNzSWdHOVVKYzFKaTRrTEkrcDhoMkpaUmY5WG9aREIy?=
 =?utf-8?B?Y2Q0cGpuU1lTVHBvMFk4RzhudXZ3cnFmb0NTc0NtYk11UWlTQ0s4aHlPaG9N?=
 =?utf-8?B?YW1zY2tyZnUzN1o5ak9mbnlFT3VMWSt0UGxsY1N1bUdFQzZWWENSYWVPbVFv?=
 =?utf-8?B?eTZqTmtVbTFvL0hDT2lMVUZtU3dkZkpxM0tJK3BQZFpkcEpCaGhwSzhVUjBV?=
 =?utf-8?B?aG9uMHVaT0hneVNsWnVQOFBhMTdnb0ZHbmZjRTFaV1NyMU9temJ6Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb03f01-ed08-4271-70c3-08df45ff1708
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 05:36:41.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSTMnDkJdpBUzNSujaJy5AZC3qrWTf66LQf7XhAhnPGUfaLRY5c0zHgV0jRmpmY0s9vfGCKg77QFnX/mR72HBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212


On 11/17/2026 10:07 PM, Lee Jones wrote:
> ae4_core_init() registers the DMA device and creates the descriptor slab
> cache via pt_dmaengine_register(), but ae4_pci_remove() never undoes
> either, leaking the descriptor cache and leaving a dangling DMA device
> registered after device removal.
>
> Unregister the DMA device first, so that no channels remain available to
> clients, then stop the per-queue completion work, which may still free
> descriptors into the cache, and only then destroy the descriptor cache.
> pt_dmaengine_unregister() is open-coded here because it destroys the
> cache immediately after unregistering, before the completion work has
> been stopped.
>
> Unregistering the DMA device also removes the ptdma debugfs entries,
> which were previously left behind after removal, pointing at freed
> device data.
>
> Fixes: 98f5a4432622 ("dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register")
> Closes: https://sashiko.dev/#/bug/linux-10d41112-e133-4bc5-8e53-b3e96592c70d
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>
> v1 => v2:
>   - Stop the completion work before destroying the descriptor cache
>   - Open-code the unregistration rather than exporting pt_dmaengine_unregister()
>
>   drivers/dma/amd/ae4dma/ae4dma-pci.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> index 2c63907db228..b97fd37bb87d 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> @@ -131,8 +131,14 @@ static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   static void ae4_pci_remove(struct pci_dev *pdev)
>   {
>   	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
> +	struct pt_device *pt = &ae4->pt;
>   
> +	dma_async_device_unregister(&pt->dma_dev);
> +
> +	/* Completion processing frees descriptors into the cache, so stop it first */
>   	ae4_destroy_work(ae4);
> +	kmem_cache_destroy(pt->dma_desc_cache);
> +
>   	ae4_deinit(ae4);
>   }
>   

Acked-by: Basavaraj Natikar<Basavaraj.Natikar@amd.com>


Thanks,
--
Basavaraj


