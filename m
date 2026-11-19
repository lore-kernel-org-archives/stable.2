Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795066448;
	b=u/97cMEaqP5reeQ5b0FNtKrGSIpvYnDpJ85xebqG6+WDBUJiXypmt5rZ+5QOyvvqOIVe
	 jPUzojuHDWUCGRHfYSOy+NoOTMp+F4oJ4GIPTH++XKPVYHTP4rhC4+PYQ8c7pLz4ubXUc
	 PK9B8FqPyhRbZCroVEztuXZwPl5Azb1VEffBx2r5G9RVXzWhwEzZyRbaK0jdU60HGl1rP
	 L/IZrPpa+TjXMldcP9Y5Ka1KCN67zjb3u3B54aHPNabnq2htP8SrKSs5ZlpxXrLVi258l
	 cv4gwAp+K5ff1eR6D95DGzQcDxKXJSZiSTovDVgiyZDF7+77NlSgyHmZmxdICJMT4zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066448;
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
	bh=kr/qrzIJwbZsq5sHCahnNiwhx9OUeV0WlIEZ0oJVvR0=;
	b=ifgkqW5DGvvOGR9eh4NVxzxvNaD6Zly9WBaRvFWTmseK9A9KiF+gRFPCW4ETHoPoYPZT
	 AKzQp0Da5t5MJ9xz1zfbgxj+NQgP+pgTjNbE1QtTmeOGdPweFUY05jNcjpUUbryIfaJn+
	 NPp70iCy9xBcVRN9V71f2VAWb6eU1Fqx85TYTKnDagr5suWg1V3oNYUhSfRMKd/g03fqx
	 OgKpw7v1hDo/ZLNEmNihcYqZDojn04krcWgm3rydb8feyOiVshb4W2Bb7me905OAmcR1a
	 Yn1Gfqid5/WDRZXlHMBacxCQO9YzXRtRKKVUv9EZy3O2NjFo6GZTx9g4tOJ0kB9Ke9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AzO5f4bv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.30
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84809606A325;
	Thu, 19 Nov 2026 05:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84809606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AzO5f4bv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJLdd+iDdidO9u8a2Kuhbws4szOrwCJO7QDRGxZyOU6qKsVSkIs3IolSt1Win9ihftiSBApu9bPJrusTc8tFYBqFx6CYtze95M5IhjWsbkjdOkumFgn4mhaUPKDE+P0mLFHzno6i5KroUn/gaoTY+qkemlZirs5Sn5+s+Is35lSBnr2EKX8aI/EOgMelvYHeSeesxf9HOR0dLr46ZbYAOE1a5ZghnQOVnLcg7+TF/fj3HUt4rSVF+mgNa6HnK9Ink/X3yR23mZC1MbODdmNKcil6l8l7yq27ZcLtyCJoRuCgEmmPF0vTMBySynSSncFEkkpL2PikMEwM7WbPMKyXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr/qrzIJwbZsq5sHCahnNiwhx9OUeV0WlIEZ0oJVvR0=;
 b=AfM4bJSnxTKp6VF/BFpigUouV2wt2FNP66Sl8NAsyryWSN/OwxGGCg10IDubbnhe/T/ohaKX1dHJBap7gtzLUHdrN/n2v1/ZNUqofwyX/13B/DRXFzIj31FQDbUR0xo/KrGNRmrMAE9qbxNwNKYA4e9MdkGhNMic61qBhSsVCdrWMRSOPlJ1Apz9D63dbGU1afnfZLlgP3GJjkSrAobzNn+WJbNR4vZ9dtmsKTf2Fsh7a3ZlpIj7dyxHOSNKwBxbt2UgamTwLMJyzbDwo39/GAE0ktkbjqQi23KWfzwSSuKidCMi2Y42ZyzAYPtNOEescvaYewNtXcOWP/1XP9NRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr/qrzIJwbZsq5sHCahnNiwhx9OUeV0WlIEZ0oJVvR0=;
 b=AzO5f4bvroVgdAUq6JOO+BrFWEg+0FBiZ3JJG+aaiquaF8pYjbJ7WmdnqfVL+YqqWAwcBtxkT93RSRdFtOsxt2duT1jxNs7CsmJCNGLVgoGRjtIxQydHICGydnsy64M5/YqruB7FLpIgisOsWgn5qLDzDuCnyvMzqFIUd4tparg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Thu, 19 Nov 2026 05:34:04 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 05:34:03 +0000
Message-ID: <625f0edf-a02c-4edd-b87c-59de9152c78e@amd.com>
Date: Thu, 19 Nov 2026 11:03:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] dmaengine: ae4dma: Let the pending work exit
 before cancelling it
To: Lee Jones <lee@kernel.org>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Philipp Stanner <pstanner@redhat.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-3-lee@kernel.org>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20261117163809.622249-3-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::12) To DS0PR12MB6559.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 46ae546b-3da3-4448-c68b-08df45feb8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|261009221727099003|22082099003|18002099003|261009223327099003|261009220027099003|261009223027099003|261009221227099003|11063799006|56012099006|4143699003|261026121527099003|261102123227099003|10067099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	vasvNNtGPnV4/qaJOJNxsHJGaebCjSiH4V52CsRePeMgAc6HZnoNqhURZi5sKakDlGrzBySGBhqtrVAD2/HO/5vzs5iLFgbUZY6qGc41OJdPLh3tbE9IWqcr7eYBHRYtfdzN9Z5io4bc5zsBYybKMWp9PBSXryQpgWceBYc4a0YDkKIIjxpDR/45anKmD2WTnX5hZOloamtXGUUEP3QHRufK7c6Ytxe7nec7auqTqLbqif1XUsMnAD6vTzq171qwO9/jdR8t22iknhDltS/de1p1aVlQ9rCzBYxdXh7Io8c1dQjn4qC7wCuJ9PJGukTUzGGNnweiLxJ3FdipksWM2+6g+rTuiUrquAHCDIS2cx5C2JS5D0aH9VNZ474cLMcNFuZ9hp37mXW3p5dSOYRUnfHR/lGfG+hySHuYpZzVs+fAb5PQO7pruCYQEulOva1/YjSMPHo+0h1uhGMqwnFauNp9JXfViGdk+LymCKxYwEd3kOibnvWMYa2mDd1asc7vJorSa7Qki59jh2SyhUei/0jUvqYTcWL+P3td4SOZ90wteZ5WgHMRjGY2EKFnZqVkLpazBOCfxRcgMehHKT8PvrCun1aPRyJtehsxUB7bjWXDSWsHma3gsj/e1CIijPOEHIwnOknZbPKw40zNaY0qw3Zi2VSGC4pivvk8r35pbSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261009221727099003)(22082099003)(18002099003)(261009223327099003)(261009220027099003)(261009223027099003)(261009221227099003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261102123227099003)(10067099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUpoK25FaDVSTFZmK2V2Qng4Zk5KME5CekdiSUF4aW1xWStKNFprdVRGN1h2?=
 =?utf-8?B?VEtBTThVWVh6MWh0QStVcHROVG9oNHhBVTNBOS85bjhnamZMejRpUm8zRnU3?=
 =?utf-8?B?cGI1eXl2NWYvNDI4WmdaL1ZSb0F3TlB4ZHJ0L2g4d3FHejV2Y0d2dWR5dGRj?=
 =?utf-8?B?R0FaSUdwOVpWVlJkMDlFTm9WcHJ6RFFWVGYrNkJzQWV0c080dFc4aURqaTlL?=
 =?utf-8?B?M2FEZlo1QmIrOVVhSnBWRWwxWktQaHJjbk5ycmlKaWhraUpZbW9WRnhDY2FF?=
 =?utf-8?B?dUFieHdMZzF6eGNYTmdZYUljeGZTZm1GWEpNMlo2M0VvWkpsbUNOWERMWUth?=
 =?utf-8?B?bmFrYkdlenZEcFBvVW9mbTFJY2lzOFJUR0N4czhkYmt0QS9yRWtvNlJ1elc1?=
 =?utf-8?B?eDhMMTZubzlVSEhqS0hsOFBwVXZKNGVRS0RPb1YrcktJa1ZxdkdLODRHTXM3?=
 =?utf-8?B?QVFXbC9IS1piTWgrakQyZE83SmtlWGpIS21VZmVDbk9LRUczODRFSFQxZW5q?=
 =?utf-8?B?WWJvTzdma2JTNmlDWVhheG5hODdNN3BaVGlGYWtHU1dpc2FUY1JQNUNsMWJw?=
 =?utf-8?B?VXhsVS9wTWNlQ000YkQ4WmNuQzY0dnFWdzJUK0dKTHE4Z2lNWHAvL2hBQjVF?=
 =?utf-8?B?c2xWK2R6VUk2YlRZOXI3KzVnRVhnNEs3NkNlR1ZmYjJPWjNGMmlLU3paWjZ3?=
 =?utf-8?B?cFZiU0N2NFJBN1JUTHhUMml0eGd2cXZIYjBXZE1CVW9kM203YkgrQmhKdm9C?=
 =?utf-8?B?ODlyWExseFkrSG9EWWE5cHF4b0FtcGFjN2JWZ1FFL01GTnV5RGVZNEVIWDVH?=
 =?utf-8?B?cy9IS2ZHNzg2ZnJGM0N3cElhc3JkWnFYM0Nka1NFdytCcDMxMklObjlreEJU?=
 =?utf-8?B?cEM3ZGsvUjZNRUFLWVI5MnA2MEpPYitlaWFjYld6OHRoUFhJVlg1akdZZC9J?=
 =?utf-8?B?S2gyOWhXcUtna3JxV1kvcUR1Tk1sLzZsZncvdGpQQ3kvekh4dnhMVEt3cWV2?=
 =?utf-8?B?aWh2Q0VvenBBeFIxWGt4dm40MHQreW92RkNSemlEUXY4U0o1Ymloc21uRWcr?=
 =?utf-8?B?b0hYbnVNYitqTmxLU21zMUw2THBoSlQxVGwydU9nOVJZK25qaUFhTTJHMUVL?=
 =?utf-8?B?bk9LYUpyMGorTGpPM1ptV0xKZXNFZUxZa1hndEJRZVhuMXdaeENib3c1VldS?=
 =?utf-8?B?V2tPcXg1S3p2ZEZPTGtJeXZsQmk3ZDRlSWFWNHhQL01ZUmhLRVNPeFViK0lJ?=
 =?utf-8?B?ZWdtcFI3WldDWVN6Rk9PR3RUQ1JqOWlJdHozdFJVSEIwVXFlZ1ZyZUZQZ1ZM?=
 =?utf-8?B?cStBTG9GVnVhZHdmbFJQMk5XWkZVcC9BcUZBU1V2cktIWFBFQms5cEtNd3FC?=
 =?utf-8?B?c1hHQWNOMHMxT0Q4UVR6TG05c09yTDd4em5wdlg4RG5tZkk3WlhLNWM2cUxi?=
 =?utf-8?B?R0xUTHZhU1MyZDQvcnhBR2NLc0tMWFJCUnhST3FvbjR1dTVKTytsZDlJR3o5?=
 =?utf-8?B?TkxxZTZBZlN5OVpYRXRHNitzUDdYMjF3Y2l1RFo2NHNRUWlyMHVXQUhjcWtH?=
 =?utf-8?B?MXlFU1E1ck5XbUFNTXp2ZWFjNkZSVzk0dHF0KzZGbm56YmtrZVA5bXhRd292?=
 =?utf-8?B?TE15MU1LZWRIYSttSnd3ZzRRSEc3a0U5TzNXaStHVnd3LzV6K0QyYUIzMUtS?=
 =?utf-8?B?K1Y4VXJXTklHTnZSY2F1TGVVTjJTU2IzYjB1V1h4KzVGc1lIZDJYUThub3Q2?=
 =?utf-8?B?anhKTkk1RlNscFBvREFZdFpXdlgzZHZkcWhYbTBJYlk5d0dwYmZSSDl2V0tW?=
 =?utf-8?B?VnMzanBrS1hoOVdRdFlxU0RxZEMzWm1CS1dhUVM5d1A4eUFoeXU3Wkw5Ukhh?=
 =?utf-8?B?UjIzemV5T2tvQ0MzaDZ5TWpVOGNCTHhQSWsxT2dRMjRpSmUzcXRTeWdjMkcv?=
 =?utf-8?B?eThvRmEyWlE0SElrTnhqR2hYQ0dUSUoyd3hkbFZkanNuR1g3ZE1KTU1RVTMv?=
 =?utf-8?B?YlRmZmpnT2QydFlneGNYU3dRY3RNUDNlSEVuSGVQVERwMG1OL0hPWDNHalhl?=
 =?utf-8?B?eU9leUpOaDZucHpPOWdhUE1KT2dGdExBd3ZpTnZvemF6d1Vwd2VPbUdYdEli?=
 =?utf-8?B?MzU2dGlYZ3VSMWs2TWxvMXhrc0c2NDJuaFlsWTJwWjA1Tmd1R08zbXdBazFQ?=
 =?utf-8?B?UVlGUHBWd3lYRyt5dlVFVEw5TjE5MU9BTW5nZHVrWjc3M1NXRjhYeHVIak5q?=
 =?utf-8?B?dHQzTnJnRTRyaGVGZVVyYVQ4ak1YQlp0aGFrK1QxN1dtR1M5WkFGOXN2RWFm?=
 =?utf-8?B?aTQ0UmlPRnZUOWJCQ3RTWmMxQ25KcUFoUGtRY3pPTGx3SVVTYUcwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ae546b-3da3-4448-c68b-08df45feb8cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 05:34:03.7322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3DUscsTGigvyOffcHKZoduJHDW0sWBTwHeiBaPTOxs2Wu6H1Ti5jfxAJWU2l8ymV+JvtmCfPmS88VbJgSJzxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212


On 11/17/2026 10:07 PM, Lee Jones wrote:
> ae4_pending_work() loops forever waiting for interrupts, so it never
> returns once it has started running, which it does 100us after probe.
> ae4_destroy_work() calls cancel_delayed_work_sync() on it, which waits
> for the running work to finish and therefore blocks indefinitely,
> hanging device removal and, once the work has started, the probe error
> path in ae4_core_init().
>
> Add a per-queue stop flag that ae4_destroy_work() sets, then wake the
> queue's wait queue so that the work leaves its loop before it is
> cancelled and its workqueue destroyed.
>
> Fixes: 90a30e268d9b ("dmaengine: ae4dma: Add AMD ae4dma controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>
> v1 => v2: New patch, so that ae4_destroy_work() can no longer hang
>
>   drivers/dma/amd/ae4dma/ae4dma-dev.c | 8 ++++++++
>   drivers/dma/amd/ae4dma/ae4dma.h     | 1 +
>   2 files changed, 9 insertions(+)
>
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> index 8de3bef41b58..be86188da16c 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> @@ -23,9 +23,13 @@ static void ae4_pending_work(struct work_struct *work)
>   
>   	for (;;) {
>   		wait_event_interruptible(ae4cmd_q->q_w,
> +					 READ_ONCE(ae4cmd_q->stop) ||
>   					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
>   					   atomic64_read(&ae4cmd_q->intr_cnt)));
>   
> +		if (READ_ONCE(ae4cmd_q->stop))
> +			break;
> +
>   		atomic64_inc(&ae4cmd_q->done_cnt);
>   
>   		mutex_lock(&ae4cmd_q->cmd_lock);
> @@ -81,6 +85,10 @@ void ae4_destroy_work(struct ae4_device *ae4)
>   		if (!ae4cmd_q->pws)
>   			break;
>   
> +		/* Make ae4_pending_work() leave its loop so that it can be cancelled */
> +		WRITE_ONCE(ae4cmd_q->stop, true);
> +		wake_up(&ae4cmd_q->q_w);
> +
>   		cancel_delayed_work_sync(&ae4cmd_q->p_work);
>   		destroy_workqueue(ae4cmd_q->pws);
>   	}
> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
> index 57f6048726bb..affb1d7d9d7d 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma.h
> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
> @@ -60,6 +60,7 @@ struct ae4_cmd_queue {
>   	u32 dridx;
>   	u32 tail_wi;
>   	u32 id;
> +	bool stop;
>   };
>   
>   union dwou {

Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj


