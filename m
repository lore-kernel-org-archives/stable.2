Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792497448;
	b=fIUqjOKONsE37TgVTq3Zn8/yoUHHLseS1TdkVGFRst8oFBiccbn85FB5wZOXWxjZ0v2B
	 ZNCB++6SK60F6JM/iaOpupGcn+0/BbO2zCGMrT29S4oMaCHJJisoJGwlBp9iqleH4evSE
	 YOlrF/lL0S/gMndWnQogcCTcAUUmyzNZvh1Xc20vdC9wHo7UQZ4jqWmgzanKmtH7PrX0w
	 jjFmsJ8KmObbqXQ3A8eo3qV3o0ded/X/cNgTQN2vNcDdopItB5aB9s3veO7tmxJMw4HGQ
	 D25wMvBG6GW7isS1y2qzVGBXyQiu2aseKJ9+vDHta/r5ySK57+dKwhy6gne6DdwF3Pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497448;
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
	bh=/4HsJ/iZ2Od2/WCqu9u/ChfB6IRg8N/KR5JON50TOoc=;
	b=iRkp0RkAnUs7pnvSAuJNOWtMa8nlJ9nWzd9QT9G+oEoHl9kTEHvmx7QjUAzX+O/7NR+7
	 VDc5pSRd1vaStM0gc0mGVZriiGDcPiPB9xx4WmjBNGto8sR6rtLEVgHZWDJR9Am9X+V2M
	 4zG0O3AO6zvOWa7J4fostBKLXX+ssPmCRUwB10sB9UoGS7J4fEDXZX2TtoKl+SXJhTgHj
	 nIVLVDG0Q19g3Q6F8E0r8LWKkI6MQrO2W3d802yh9feIqm+99W0KbGKV4392elG1fYrMb
	 GRJYohJTkLXm77Rm6pAAcj408SIg9cjOs0Wx+M7cGqfmIPsEfX2keHgzgmFM40xHNdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wcbq6rTK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.39
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC4606A31C;
	Tue, 20 Oct 2026 11:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DBC4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wcbq6rTK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItbkGa64z85/4YLttmXeG3FarSxPyfxJbtT+JKEe85JfE+bnGEXTn5cXGuU6QBtKkYQCgjht5zhLJV9qavAE/G9R2w/8WEfZFRlNWKKgVJPJvG7qHuOeyphNnT4lFYfXznezajnhT1zMWjDJCx8Z+fPry1mQkHCTSR2J28DYjZYjy2Rk+Nse6I5XujAjBIzL5r8gileFory7xWZWThnL6L+jJQOMfc9Pxon3YDsxOLdsgDHXzy5+OeNxYhrHIOf9jRLCSz1zClvWefswwXxFVU1m3PZkgz79ud5WznJvKoV09FngPSBqEWAMlyeceBXX+PxtV2CwK3sF0Suq+4MaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4HsJ/iZ2Od2/WCqu9u/ChfB6IRg8N/KR5JON50TOoc=;
 b=l/eC17Ndz/nx4utl1wbCb/t92AfWiW0+gZA3xnPKRIEoVuIVgVSF2q0uHMUis6ZCEV1z8w6NtuPlNDxyuNs9F77dgyM8BcRmy3lvAhcZBVOYapu0kx2s5k4NrtX/uXGQZpiUY5JgYnW7GY/YrYR3lHbiErP/8xcQ/F0usdpzicE3Tbm3JDZcay7BBPSJrcgFKBQbU9elmzWiik0Cy7iz1a6ejbDaUzX1cbZ5Mj3+NLsIEcl32S9gCtwAUUY64SWYQSyqCn3fajsQtdkf9LYWz6VDEcQKkkdplEA7988But1Df4CJJfYN6mW/9aOqeTQVMPua0zp30pXiCnKcR7ym0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4HsJ/iZ2Od2/WCqu9u/ChfB6IRg8N/KR5JON50TOoc=;
 b=wcbq6rTKR0Zo6fG6QlVxliVsm+/xqMGw+xhsjcSq+XzRVTGVBAZuTFltFF/w+43TXWTnFHbrk80EWAhP1vz6AbgVJfQpV+cmoYSORo4+NAIoTfrl7ThMoFXIcuUYV6me+RZBgdsj3o+2sFrmdkryMtEr249qkd0mSLnw0j9MW+E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 11:57:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:57:25 +0000
Message-ID: <80e5634c-dc61-4f9d-98bd-9785e67abc54@amd.com>
Date: Tue, 20 Oct 2026 13:57:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Fix IOVA offset when linking phys vecs to sgt
To: Yili Zhang <zhangyili01@baidu.com>
Cc: alex@shazbot.org, ankita@nvidia.com, dri-devel@lists.freedesktop.org,
 leon@kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 nicolinc@nvidia.com, stable@vger.kernel.org, sumit.semwal@linaro.org,
 dawid.osuchowski@linux.intel.com
References: <20260924065508.27245-1-zhangyili01@baidu.com>
 <20261020091945.27327-1-zhangyili01@baidu.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261020091945.27327-1-zhangyili01@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: d269c3a4-4861-4ec0-e8b3-08df2ea14ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x2Td/WU/9zR+E7abROzFwOQSCEGXrGuO1KHDlnXQHaWdmmSVqkYgb3PBjkjcPs8JBIS8U0UmnmHZndtUdcfec+NiBYUQep07ivb2J7lzvDsOlg4Axa7kZTE7PvjImF//ibut/i1mV7LmklufpoIAyVX96CrIUARJvH64h+hsP6E9KwuUFuAtJSq96BBDwT1Me5Zu2VpDpAZi6klLsH+ISGmeXt9MjOCCwVh4ix94IZvYtoCHGvc7HufTUuSXBUducpMObf63Pic3ggPVjvcjnVvbKX6Ur9FdSicHIDn5BksaZ2s4/Bay2gRsIH/9tYVZ6p9QQS7dW7D4R9wIQ5MtpGqCx07GsAU4TCw0dSzNjqW2rz/DIJaJmtXnsdHYRcBy7dhqy5N7B5KHxnbAJz41dYK+EJA6wdG1lw65YlfmwU1AaLPCWcCeovZ/YV/KIfCciknTWW3f6t9IU8wEJOF3QrQe/5o+EhL94IqlpM5HyQGd0Oi14CkaeV9p9jcjUuvk1lTo8HHVVjGrscAGmr0pOQiltzIkOQUrkItC5ZCfQzefQxRi7kJ2MgZfqavQvOSGiMdq5uKMafDET41Mf5HlrYqRe0ek9+UAwkCHbOHuD/yurn6G737JkQ+KmwPA7CuDdGpIkHAT4k0+hwcfJKMRzOwWcJohVkkIBDYV8XyZeAI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUJrT0sxejd6WkVMM01TTnFWTXBXNVNGa2ZYOWlxNUtlSWFSdFlTdjJSaXRE?=
 =?utf-8?B?S2FIR2Rkamhva0dRYVdPaUdoeHMvUzRPMWRKcXBKZXp5NGFyVXBuNFVxQnMz?=
 =?utf-8?B?aVpkQjJidXUxUDNPdGs3WTJJQ09nL0I3Q2ExTEFmUUpld1hHN2JWdXZvNE91?=
 =?utf-8?B?eWhSUFBnQ240MGM3ZnJlOHNuMERtd1dqSmJWRlhmaS84RmNxcU9kRVdrYUNr?=
 =?utf-8?B?Rzluc1Q5R09pdThtODlPSFFzMXZyajdVZEFNMU9icTRjYUhueUIxeSs2aytN?=
 =?utf-8?B?a0xkRVZJeFRhbDhFbCtjY2Ezc1d2c2Z4UnZmZEZJUVlLK3E4UTg5aEEyUnhV?=
 =?utf-8?B?UzhHbjZCYmpNcVpvWkoyVVBCbTF1Y25xUVJBd0FwZHM1bEcxeXRPQUhwM3Mz?=
 =?utf-8?B?UU5TWFljNE9ZVy9FbUtMUW4wRHcvUmY1QzZNaXMxU25yWjlQOU5DWUlSdHJN?=
 =?utf-8?B?NHVkM2JOSDRncGE2WEp5QWJPazV4c1c3NXNIT2w3WEU4MERzSTlJY0xsZ3Zt?=
 =?utf-8?B?QUc2ZkwrMWplQklHUGpQdUJ3N3h3VWlYc2p1dXNxd2hoUVlCNE1FQ2pGcTdM?=
 =?utf-8?B?clROUURqYkxFVnBVNUk1d1B5eWxkNEZHUy96eDY3QVNOaTliSkxwcmhmZ3Z1?=
 =?utf-8?B?ejVmYTJPdHJ5ZXBjYUhLZGFIU3dqS0haR0lIQmxxYXBjeUhlcEp0ZEpSV1NR?=
 =?utf-8?B?WUVFaEZlaFN6cWNTWlJ1NlhIeGZkSm83Sk94Wjd1eHFUNTJ6M2tJZ3FmeUdW?=
 =?utf-8?B?blRIYXIxdmI3eXVyMEhtNmZyMmpvSFhDV1NzVXZ0RzlWNTBHUmJkZ2NHeHZU?=
 =?utf-8?B?d0V3YzNGVHNwb3R1b2FSQTN5dXpSamVHVVZWdHc4STRBVmM3UmtlYW9BZW9q?=
 =?utf-8?B?U2Y1N0VxQmNtVVVueTBtTFc2bFNxd2tUVjZpZnZaWmdnc3ZoNDhDd0JhMkVk?=
 =?utf-8?B?UHpnTVdPWmh1andyVm8ramlzTFJ4T2VmS2tXRlZlQXZGWnpYeWU5UEFMN295?=
 =?utf-8?B?c08xSTJ1YTlIa1NRMVBlanpBaFNXbzg2NkdYejJ0ZHFiZnQ2NURKeGkzaDVY?=
 =?utf-8?B?RFIya2FBaFpTb0ROZHYxL2xrVm9TZExzdVNuZkVNRlpFMm4zZ0hFVlRYdnRt?=
 =?utf-8?B?SExPUjlZM1dkVnVtLzBiSHFrRzFhVmR0Y01jRmsyM0FlNnRzZ0tXRmc1NFJi?=
 =?utf-8?B?dk1oc2tHSk9WZUwvVlFucHp4ek1IRU0vSXJZVzJjRnlWOEZQMzgzcHdTRnF5?=
 =?utf-8?B?OWxsU2UxYlFGaSt6a3MzaHphZ0RKZkRHMFJ0VU9BVWRmQ0ZhTXNSR3NCVEZV?=
 =?utf-8?B?aUxuTWVIczFGaHZaUVZQeU5DUFQ1RjUyVFNFZlBnQUJtK011QmduVDR5bDFj?=
 =?utf-8?B?blBSeTYrZ3k0NUR5aldsMFpDYU4rL1JGalJmcWRKMXZlZUNXNkFaVk54U0x0?=
 =?utf-8?B?N0pjWFNWMTNNNnNxYlQ1RnVScHlFOHJ4U2ljZHB4QmxDeWU5N1BXMERlNzUy?=
 =?utf-8?B?YnhEdzNxYmNRYzV6THVSakVOdWJWVlZhY1ZlN1djaWFGWVZYSklZRURlZFpH?=
 =?utf-8?B?dTk1dmR2bk16K0FhcndWYi9oYk5WaG1KTUhzZll0M0pvRVlDcmRQZWdJWkxj?=
 =?utf-8?B?ckV1dGFTdzg2OURRNmhjbWl0OHJVU0diVGpxZVNOKzNPMDRwejR2eXVqaktU?=
 =?utf-8?B?dURPWUhTa0NtaklheEpVa283NnFuVVdjUXBJQTIvVDlmQVJrTmhVTUtIWG00?=
 =?utf-8?B?TFp0aUtJNjQ4TFBhd0FMWk5hZm92aThiUzdCVUo0ZjRjV1pwTWtqcTBJU1Zk?=
 =?utf-8?B?MnpmZDREVjRSN0UrSkhaSVZCSzVhTENjSitjRXlFYWpoWGFhWUtadloyaGV1?=
 =?utf-8?B?S2dSVUo4VDZGNndtZHo2RUdRbHRveTF2dkhOSFlab0hnZ2QvbVhHVk10ekZD?=
 =?utf-8?B?QnZHL01aOEk4c09hczJFNjFDdTVRRkpqZGxvWm10b0djbGZtV291RXFlQzRG?=
 =?utf-8?B?Nno1RFJqNXlpOUF5TFRjYk9EQXMvdFZkS1pyZkNoYnNyMEtWUWVmN1JzaDZ3?=
 =?utf-8?B?S0Vua0ovMGl5RURpSmRIdGRmZWdLb3lJSGxHQ3NhUUZUNG8zNnB5SjUyYkJx?=
 =?utf-8?B?K0NrRFFNa21icG1PWmlsRm5rdi8xdCt1WUhybUNTWDRXZGlrRUtpRHEzbnRW?=
 =?utf-8?B?aXA1QWoxY0FOb05LOG1BWjJDTXFOQXlLaDdqRXk0MXlSUkdEdzB2TkZ1UTZC?=
 =?utf-8?B?VkdXRFpWZ2xVUnpDRmgzbVdQM3M4VVpidE5NQkdvcFlxMGo2WSsrMVpFcm00?=
 =?utf-8?Q?oUgqru98tl5NlRot9o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d269c3a4-4861-4ec0-e8b3-08df2ea14ea8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:57:25.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHtlR8D9tfdI+KW2ufS32Et9hC/Fka5KkFnR5yr+NPHzIR6IfTJIWgAr91QQddfS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

On 10/20/26 11:19, Yili Zhang wrote:
> Hi Sumit, Christian,
> 
> Gentle ping on this patch.
> 
> It has two Reviewed-by tags from Dawid and Leon, but I don't see the fix in
> v7.3. Since the 7.4 merge window is now open, could it be queued for v7.4?
> 
> I'm happy to resend with the collected Reviewed-by tags if that helps.

I've just pushed it to drm-misc-fixes.

Sorry I'm way to busy at the moment.

Regards,
Christian.

> 
> Thanks,
> Yili

