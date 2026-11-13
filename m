Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794612124;
	b=hIQVWi7I2tr0nXmyoirXIQzB1LBY3ITW35FI4HAIFrm+omcacnSqAFav4huJ2zUG3Q72
	 NUlF1JV1TxFoYIylFDT8dfeWSLsIlAwdseCcaYYuPFKWHGUcZJPltakaXzqUGDh3If3/q
	 I/waZP3xD7S4sNezr0wp6rsRxmguRIXs0hoEJvzqSucjJwgJkoG4Ag8ODZ0PEjIlwyEyi
	 R37SI2j3Gqi+6dUhW/dV467rri16xqFZWIJjaDYoAD6aoEn661NGrBnMVxYKAnISsTNTV
	 6MQCTtlog2AR/kIbvGLN9cg1VSJn/RFeti/GwV5dAOSXFHgOQyKzKBPGzvNd7hUxuuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612124;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ZsejWeu9THgrJxOVchF9elewIGJCMrXuPvoZNud0bZc=;
	b=f2s6qBCLgGY2LhUbwBEVh++3nrz1gAm+OdwmWPX35GHZdWueBmttPiGoHYEk+IaD+ej9
	 2DVwDwFTL1JzXKeAmKt8eShGPOGaNgneJ29iqoZnmDwwFkjV0bNrsrT2OIbhi9Vx1vtkg
	 0wgFwi0z7SYyMnWrIe1vWT0HSYlha9QkvIGHN06CAdJPwABpU9XvyXea4vEsK7xn/TXVF
	 moi0cBDAmgPBjeosLqQqe5r+JhSQ6IOVQM6XLS2cCtmGddz66n7f4pGtfXNF28Cyb1IuT
	 1zPmGaLh/eIWPTfBQezaGLaYJntVpWT0rBxRT3grsjRdU2cTSzRA3SVPSaZHn6AqpPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="0kX/qgey";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.30
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C145606A333;
	Fri, 13 Nov 2026 23:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C145606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0kX/qgey
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmZNSTtouHW3rS258+0nf0Mwkup8DcTHtpXXoIEUQ26qx0Hrum9HqenCu8o1s52kRXD/iiGrhm5KSglfDmdiNyIGDJyiPhffT1QTxGKJ904ftWfvGUjsTM9H5RS9yG4sBaZ2uSp51vxDU2t59ME2QJJBMKJ1yyymrcr4dqa7cppFiyrVh/nD2eAg0zRH4tEhYScLD/sBFeoSyxGYFUoWjJ/53wo8s5V6EbV+Fz1bv08/C653NT9Rzxxbc/wqFkQRwxdYuI8hYSespuXGAHT4N7UlYCzJOxEdiOLOEmCL6yOrGpaXXIcyCULRlOhsMChMMiljD9K3y8s5LvLmavD7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsejWeu9THgrJxOVchF9elewIGJCMrXuPvoZNud0bZc=;
 b=Fq+ptg64lBuFZJzDmZgD/t3j4LQ5U7L2Tpwmna/2tMoBP9qxRpE/WK/6lv+eeLOb2Ss/0bVaRrmKDMWtoklG4xHKz+ewV7LhvPslGt2UAU4kA9gJWo0lrN22FCM/12Ccz5jVIC9xgCHIwVzSvPGhAnN4xGTntlK+n5GtxOMF+ov9Ymj5EjN6Vl8eFMLcKvxmk9EGhkYNOjHmmlw3QvzEUHFeEW3vOYnnlP9DW2LhT4fvxkdOJN91N/q8RcCKDSTU66iSlZyL2t/eO3yZ9sFnT/l4IcPzb6OQbUlL/PyXF2hn1FEQ062IpPbh6sdaEHIdk5SXLBW2ByB5opY9VF/mUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsejWeu9THgrJxOVchF9elewIGJCMrXuPvoZNud0bZc=;
 b=0kX/qgeys13BcdDCcmmI0Adp/IdxVlxAmtrXX39Cf88M4eZ+uYk7Yws9vXPDlWBDHDsS9VrwL/Bw/0Gp6aVZldEJkZk+TEbxQ20OrkqFwk30IZ7ZxeprbPItuZWuHjbtNJ59cWhhMvyED2nv0MHLzOI0+iJ5VWAMJkDcHUezo1w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) by CY8PR12MB8193.namprd12.prod.outlook.com
 (2603:10b6:930:71::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 23:20:29 +0000
Received: from SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc]) by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 ([fe80::fd82:d106:2d09:2dcc%5]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 23:20:28 +0000
Message-ID: <4c4894ce-b7a5-4824-b5b9-5f45a8901ad8@amd.com>
Date: Fri, 13 Nov 2026 18:20:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix use-after-free in create_process() error
 path
To: Hongyan Xu <getshell@seu.edu.cn>, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261108105617.1309-1-getshell@seu.edu.cn>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261108105617.1309-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::23) To SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5)
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
X-MS-TrafficTypeDiagnostic: SA5PPF8ECEC29A9:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d093eb5-4a7a-4e5c-5ab3-08df41dcb462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|261009223027099003|18002099003|22082099003|6133799003|261022075727099003|56012099006|5023799004|11063799006|261102123227099003|261021121427099003|261026140227099003|261026121527099003|261022105027099003|261021123027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
 a1gT6ePw5t/Ig7SPezztKuvNycANKo+WAnMltBAnOFZeHMkUQ2fEdDlryLl+8jzSu/fmQDQjROn1+ENwgVBACRxoHqtZyk07ApPytuWouqmvJ5lmS1OktYVlIIR8FoE/G1SD5vR8fZUpFR0aM3ooKts8j0RmP29y2oiccR7q1PgNPct7F6ozyCdvFe5gafiFjdR5yxMOH8IyZ9AJ8NQovdQq+mzyMA/gbARo+hSd6vYmTYtA8F7UkEwocTIfVCTFczumYGuR+oZhGWM2fFraIhR6tznwbpoyKq8ElIbNfCx9X4dxqck3KtG9WjsIHCXYM5Aq63KADBYXOcH59YNboqErRLZV5Up1hMafsC7hYt9kz1R6Sj3GHmf6ukpye715cAqTbvkiXhR3jqbm72/hJHQ5n4U60Fx3DDetOBH4XiVbZbFLz1Lqu3Wrby+xU5CQUsQJpBCaYDgyGkAc3iD+smLR/ttRKciQh85m/ES9GtR8FIEuDKmntfuKuX2sZuXlnmXSO/zm2lC+/uzqJridnmrVYzJOZVxiS+vPWuaqNnd2cjV2SjGy4DOWNJhTS7EwwzH9DWv/ru6sNYgUxMaBlhAHDAhEzOcN9+hyuz0J7BX50W5aXAvsuPqwYrZ+TLYGH+NTZ4TQTv2RKC0YUXx/qMbXdieJp5SoMreHev7mjr0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PPF8ECEC29A9.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261009223027099003)(18002099003)(22082099003)(6133799003)(261022075727099003)(56012099006)(5023799004)(11063799006)(261102123227099003)(261021121427099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021123027099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Yi9ub09NUnFRekMxMnA0bi90cXhNMCtHUnYvZXhid1VoL1BHRm1XaDE3MVZh?=
 =?utf-8?B?d2VxTW9HTlU4TE12akFwNHlZSmZCc2d0K2hxMDFRRnRYdlRNSG9aaWM4U1pV?=
 =?utf-8?B?TzMzUkVzSTVPeVdpVE91L3FpMU9MT1kyZGlVKzhJWUdPQkFpR3M0aEtGcUdm?=
 =?utf-8?B?L0Z0azRVcUNZR0lRcVJDQm1ObmNORUpleUtzKzJ5QUlyWC9KTkZ1UUFSNXZS?=
 =?utf-8?B?MkxRbnhhOGJISkIrcjR3S0xqL1NsZVloN3pkc0FTVXhMaytXTGF3cUdubWpv?=
 =?utf-8?B?a0NxWDNzV3VIbDVVbzI0dzQ3OEowQVRPYVh1WDhCVVByalg2WDV4QjhXMzVa?=
 =?utf-8?B?VTJsb1N6b3dBQnYrRHJUTzc0dU9LSklpTjlCOUw1UllRcTRObTVzSnhiZVVY?=
 =?utf-8?B?ZVlFeTF2QW4rZmtUS201RjVKdmI4U0IrcS9RSHhITU8zUlF0T09LckxrS1VU?=
 =?utf-8?B?aDB1VGFnbDV2OWxlK0RrY0syaW9lWlN2dTZrNDFQR2NRWU5XMnNkVzRhK3Ji?=
 =?utf-8?B?dDcyaEFXVkNOb1E4R3h2a0tWL1RUaS9sc3JQcEtZQTJsZjdiUDhPaHVCSmhF?=
 =?utf-8?B?akJqYkdsbVI5OTdvM3FVLzJQbmsveXd4TmFYekxFOFY4L3YvOEFqOVhNckFN?=
 =?utf-8?B?RkxWeXd6NG9IaExmQXZQWUsxSlhNa0ZzdGozL1NEM3c4SlVRYk5xMXEvZXZY?=
 =?utf-8?B?ZUhkK3A3dXV3Z2l0dTczdi9kbDFaKzFSWW80dVNiM1IwSmpzSk5CUG9WbHFZ?=
 =?utf-8?B?S1llUHhnd1RvcktqN2ZtMnN2dURHc3FhN29TVUxVb3JtYkFTait5RmpHV3V2?=
 =?utf-8?B?SzVpVVFBS1hEVk13SkFtajBNMjRtYW1pQUpWK0h5MWh2YTVoYmErSkRibCsv?=
 =?utf-8?B?TmxGRVlSdWpoVGZ5Mk1JUThacHJLUGR3c1BZaUpOTm1vOE1Ya25BYzk3MXNE?=
 =?utf-8?B?U09RUG0zWkZ5ZUIrR0wvWGM4akthU01FRUNqWi9HWVdvMmNjSUpmREkvV2FX?=
 =?utf-8?B?LzkyUHFsSWo3OWNPWmtqNEltUGZHbERVcUo5U1NuOW9rZEJsdm5MQ01DWmRq?=
 =?utf-8?B?Wmlkc1hvZlFsUC9CNFBrRys5c2hPY1BOMFFNbGJwUlR1OXlkbUQyM0NsbmFM?=
 =?utf-8?B?MWJDL3hFVmtvRU4vdUsxWnROYW5INmlaOVJkdnhLd3pYdW81RFoyL1lJK1Nn?=
 =?utf-8?B?ZThXVEdxM2ljYTZDS3dyZW8zNE9nMG5HTEh6UEh1K3R4Q3ZhVVBFV0Rwd25W?=
 =?utf-8?B?Z245NXlON21VUm05VWNZcFM4T3h5WDNQL2F6dUIvTzdMNkN4bVd1bThCVkVJ?=
 =?utf-8?B?bEFiVlJncUpkUHgzdUk1aThmUXV4bFFiRVFCekNsMGxSdmdzSHZYamJYREts?=
 =?utf-8?B?WHd1ZmFXZktCUVNUTzRFWDNSa3Nxbnhyd2Rna0FFV0I1d1JBZEN5eEI2a2ZJ?=
 =?utf-8?B?OFo2Wk9XcFEyUjNsUWN5ZXlyT1ZrM200L25aZG5jNGlIb2x1akV2RXV0K1Zj?=
 =?utf-8?B?T1BpT2JlWS9uZFQ0UjRGeGxLRzRJTlFBZGZuK1ZnUCtqTCtDcUc2dDRHcG04?=
 =?utf-8?B?TFozdXpkVXk4b2tPRkFNdjBucm15ZnNYejlkL1F1dHZaZTgrdmthRGFmMjc4?=
 =?utf-8?B?QmFKVE1TRDZKZlJ3bWc3Tyt2aFBTVDZhU2ZMVG9yeldRQUxCaWdpMEZqTDVI?=
 =?utf-8?B?QXZsWlFMcVlpM0ZYd3c4bnFjekdPNFRjSEZHMTJUQ0lXc0NLV25wdUJrTk85?=
 =?utf-8?B?eThLenc4RUxpSFJqdHVrZUxscDF3WjcrTTZQMTFOT00yN3EzLzBpd1RxeDly?=
 =?utf-8?B?cHhsbTR0Z0FXVjRNWENNWVFYUThGdENJRENKR1hkSnJhYjNiMVlkOXlXczdO?=
 =?utf-8?B?bFFadzdhUEdhRDF0K3AwNkFxOUN3UnZDMjEzMVZ5N25hKzBpTVZ2QmZITmxz?=
 =?utf-8?B?TkIrT1JyVnc3ZUNlK2FTWDFBWXNzL2hRbTd2dVZ5NVNNOCtoUGc0Q05Za1JS?=
 =?utf-8?B?elNsT1lPa0xkckRadjdjZ1IvelNQbEFVd285REtPWmNFTkpsTzhWZlp4WWtI?=
 =?utf-8?B?ajQrMEcwamlvVUVDNTlNc04zRkE1QmlQWlBuMjdCVkR3U2FKMXhQMm94b3RN?=
 =?utf-8?B?Qk9oQVd0K1RGY1JtS2QzQzJpYVB0WEVLcGd4bXZ3M3p2dDNKS3FmNHJtV2h6?=
 =?utf-8?B?Um9XRkdWc3lrTTBHNUtIbXVwbWtLbkdhZCt3QlE2TGQ4ZDhIdTdsMUZsVlph?=
 =?utf-8?B?Z1hKczEraFFXZnl3WWUxa21PTldIRFM0OFBOTGxWdUxRY1QzUHN6ZVRQc3dt?=
 =?utf-8?B?ZjVlV1JzVUVma2xlQk4zekhxelZ5MjBoZXhsV0ljUVc4elpsM3F1Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d093eb5-4a7a-4e5c-5ab3-08df41dcb462
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF8ECEC29A9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 23:20:28.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYFuDlfwcZVLPUSDhcT2b7jRQxgE9+WN6AwAezcfRx/tPEAzcQpke5A89p6ROg7nJ3lgGQrfuEXQ0KsHdabeKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
X-OriginatorOrg: amd.com


On 2026-11-08 05:56, Hongyan Xu wrote:
> create_process() publishes the process in kfd_processes_table before its
> last failing call (alloc_notifier() must find it there), and its error path
> frees it with a bare kfree(), ignoring the refcount.  find_process() takes
> its reference inside the sRCU critical section but callers use the process
> after leaving it, so synchronize_srcu() misses them, and the error path
> cannot unref once either: it holds two (kref_init() and the one keeping
> free_notifier() from starting kfd_process_wq_release()).
>
> Release the process as soon as it is visible: take the lead thread
> reference right after lead_thread is assigned, run ida_init() before
> mmu_notifier_get(), so the release work is safe on a half-built object.
> The published error paths unlink with hash_del_rcu(), synchronize_srcu()
> and drop both references, so the last one runs kfd_process_wq_release().
> Both labels hold exactly two references, so nothing is freed early and no
> path falls into the unwind the unpublished labels keep, now with
> put_task_struct()).  Restore pqm_uninit() (kfd_process_queue_manager.c):
> pqm_init()'s 128 byte queue slot bitmap leaked per failure.  Match
> kfd_debugfs_remove_process() by process, not pid.
>
> Fixes: 3248b6d3cbcd ("drm/amdkfd: Use mmu_notifier_get")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 12 ++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 46 ++++++++++++++++++++++--
>   2 files changed, 54 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> index 7d4e07452cdb..a17a3a307266 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> @@ -33,6 +33,7 @@ static struct list_head procs;
>   struct debugfs_proc_entry {
>   	struct list_head list;
>   	struct dentry *proc_dentry;
> +	struct kfd_process *process;

Hi Hongyan,

Thank you for working on this. It looks like your patch is based on an 
outdated version of the branch. Current master branch already has a fix 
for this part of your patch:

commit 325de6bf3328efd5acf5072337fc196928753de8
Author: Zhu Lingshan <lingshan.zhu@amd.com>
Date:   Wed Jul 1 11:03:09 2026 +0800

     drm/amdkfd: expose pasid of secondary contexts by debugfs

     Current kfd debugfs interfaces only expose pasid
     of the primary process, this commit exposes
     pasid of secondary contexts by debugfs

     Just like entries under sysfs,
     the secondary contexts are named as
     context_<id> under its primary kfd process.

     The layout:
     /sys/kernel/debug/kfd/proc# tree
     .
     └── 5802
         ├── context_0
         │   ├── pasid_1025
         │   └── pasid_63266
         ├── context_1
         │   ├── pasid_1025
         │   └── pasid_63266
         ├── pasid_1025
         └── pasid_63266

     Another fix is, kfd_debugfs_add_process may fail,
     this commit change it to return a meaningful
     value other than void

     Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
     Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


>   	pid_t pid;
>   };
>   
> @@ -151,6 +152,7 @@ void kfd_debugfs_add_process(struct kfd_process *p)
>   		return;
>   
>   	list_add(&entry->list, &procs);
> +	entry->process = p;
>   	entry->pid = p->lead_thread->pid;
>   	snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "%d",
>   		 (int)entry->pid);
> @@ -174,9 +176,17 @@ void kfd_debugfs_remove_process(struct kfd_process *p)
>   {
>   	struct debugfs_proc_entry *entry, *next;
>   
> +	/*
> +	 * Match the entry that was added for this process and not one that
> +	 * merely has the same pid: kfd_process_wq_release() also runs for a
> +	 * process that failed in create_process() and never got an entry,
> +	 * and after an exec(3) the old and the new primary kfd_process of a
> +	 * process have the same lead thread while a file descriptor keeps
> +	 * the old one alive.
> +	 */
>   	mutex_lock(&kfd_processes_mutex);
>   	list_for_each_entry_safe(entry, next, &procs, list) {
> -		if (entry->pid != p->lead_thread->pid)
> +		if (entry->process != p)
>   			continue;
>   
>   		debugfs_remove_recursive(entry->proc_dentry);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 12e24fbf8c46..f118f7f03de7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1600,6 +1600,11 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
>   	mutex_init(&process->mutex);
>   	process->mm = thread->mm;
>   	process->lead_thread = thread->group_leader;
> +	/*
> +	 * Take the reference on the lead thread before the process can be
> +	 * released through kfd_process_wq_release(), which drops it again.
> +	 */
> +	get_task_struct(process->lead_thread);
>   	process->n_pdds = 0;
>   	process->queues_paused = false;
>   
> @@ -1648,13 +1653,17 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
>   	 */
>   	if (primary) {
>   		process->context_id = KFD_CONTEXT_ID_PRIMARY;
> +		/*
> +		 * Must be initialized before the process can be given to
> +		 * kfd_process_wq_release(), which destroys it.
> +		 */
> +		ida_init(&process->id_table);
>   		mn = mmu_notifier_get(&kfd_process_mmu_notifier_ops, process->mm);
>   		if (IS_ERR(mn)) {
>   			err = PTR_ERR(mn);
>   			goto err_register_notifier;
>   		}
>   		BUG_ON(mn != &process->mmu_notifier);
> -		ida_init(&process->id_table);
>   	}
>   
>   	err = kfd_process_alloc_id(process);
> @@ -1664,7 +1673,6 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
>   	}
>   
>   	kfd_unref_process(process);
> -	get_task_struct(process->lead_thread);
>   
>   	INIT_WORK(&process->debug_event_workarea, debug_event_write_work_handler);
>   
> @@ -1673,8 +1681,39 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
>   err_alloc_id:
>   	kfd_process_free_id(process);
>   err_register_notifier:
> +	/*
> +	 * The process is already in kfd_processes_table, so find_process()
> +	 * may have handed it out with a reference taken on it.  Unlink it
> +	 * and wait for the readers that are still walking the table before
> +	 * dropping the references held here: afterwards no new reference
> +	 * can be taken and the ones already taken keep the process alive.
> +	 * The memory is then freed by kfd_process_wq_release() when the
> +	 * last reference is dropped.
> +	 */
>   	hash_del_rcu(&process->kfd_processes);
> -	svm_range_list_fini(process);
> +	synchronize_srcu(&kfd_processes_srcu);
> +
> +	/*
> +	 * kfd_process_wq_release() frees the memory, but it does not
> +	 * destroy the queue manager: on the normal path that is done by
> +	 * kfd_process_notifier_release_internal(), which neither of these
> +	 * two error paths can reach, because no mmu notifier was
> +	 * registered for the process.  The process is unlinked and no
> +	 * reader can reach the pqm any more, so destroy it here, before
> +	 * the references are dropped.
> +	 */
> +	pqm_uninit(&process->pqm);
> +
> +	/*
> +	 * Drop the reference that keeps a failing free_notifier() from
> +	 * starting kfd_process_wq_release() and the one taken by
> +	 * kref_init().
> +	 */
> +	kfd_unref_process(process);
> +	kfd_unref_process(process);
> +
> +	return ERR_PTR(err);
> +
>   err_init_svm_range_list:
>   	kfd_process_free_outstanding_kfd_bos(process);
>   	kfd_process_destroy_pdds(process);
> @@ -1684,6 +1723,7 @@ struct kfd_process *create_process(const struct task_struct *thread, bool primar
>   	kfd_event_free_process(process);
>   err_event_init:
>   	mutex_destroy(&process->mutex);
> +	put_task_struct(process->lead_thread);

The changes in kfd_process.c look reasonable. I'll try to apply them 
without the changes in kfd_debugfs.c.

Regards,
   Felix


>   	kfree(process);
>   err_alloc_process:
>   	return ERR_PTR(err);
