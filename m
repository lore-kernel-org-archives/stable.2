Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794843185;
	b=wo98ZiMzSN8UV6jo1IYJJ0eDUaYlkUHeecSA5R+jz0YUdsdMkJ+bZc5IMUXgv/yVhgzU
	 KYBdhFVtSv/3AHO+2brhK4zWLVZT4IKDt2h9sDo+/hpP0VL/7SDVbd0tphp0E5pEEjkUd
	 i39T4QjEjxmLZNl6v9skOK2kDsW64gcpmsdRS4d3Nu+3L/gUJRLwvC8WB2EEIMTijwOT9
	 DvJWlQzMwkuoUMka7ZI/7sRdaMmU6zeIKAnkJaqXqh5yyVqn5V4k9Cjy0hvSyw8op75WN
	 r+p7boNSsn7SeFgz5Ezh9bRofkGWZJFu22zcg091fLaoThbuqns24ZhsUqrOZx+2//w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843185;
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
	bh=C+j+4XkHf4LiDZU7z6o8HQSgVoE7bLITsjQsgM893MM=;
	b=fJQpHp99QfMbB8/rF6uT0QZ771sGeTYSFtSH0IuRbQc3MwPMdykO/KyT4fbUjfKyEjja
	 7uCMteqXX1Q6F52Mz8B3HrCaomWSiA1fpu9jgFXwgARCVSPCMIUwwGTRO/Is66VlF/bA1
	 3lx/q4CZKMVftxEO9FcFKXk8Pdlt4QQrjJXsvrOwd9mK7soAeXJm6HXGNJcQ4qeleQtOZ
	 eEzWWxFoQoslPmrOWEAY8yCAb0Ze4oYJyUM5x1Z+nolrqukAklbf7vLgpoOMsxFK3b/uF
	 h7faA13nqR3stbVU831AihPY8GPshfMsvUahfOo0m4X6zEFTxQ/3zCXQ1gnnS8O+hpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M5zuDo6f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.18
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72050606A322;
	Mon, 16 Nov 2026 15:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72050606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M5zuDo6f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LK+07FsWlCFioNqjmPT2amfAxkRyMGuiWn5yMxteMkLpzZq8dhnN06FUUbkBO6Yak7XdTvUEOnK9Psn5Wh1OZZXQFVF6LdTuaB023nV8FvcGrrMQWbzXNq1aqgTcpVkc891ydZdGAh4eNps621UawkHJLP2TY61xG39CsnR7IbGy5wuhsMWsLHnMg6W6gYpVExzskyU3bgYcdNOyWeu6U55cPASGocHIO8B4WAlFsdjYPgX9lp+1yj95vfEAZKPxuiMxryq3eNgXtbTHF0eNq3/lAd7mgHvdwgF62yXiEFMk6Jvk9dGzhbpA+gMLhgmO8x93cxddn7vHvrmFZ6q9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+j+4XkHf4LiDZU7z6o8HQSgVoE7bLITsjQsgM893MM=;
 b=uvkrYp8RukLek9qedd1xK94F6EPj0vHz7U3Jn2Fzkr5hcP9TcXlEPFNYwhND8HHCcf2qXkXb4bsLhg7ckSfAT0awjVcn6GViWVrACYOUf86Ewo0qg8eUnczeVo4Z78sIelUMb+bXvX/cybVLW9mBMxMZvayJPA8mIKtQFZgHw7eoFRcnj89FhGPgK6YlRpvlS76xv/kl3JV71MZJE7yVYnc0BPBn2p1DMV8UQdRM98Fm239voBWh5b6Lei77r1Kqhx871JWzalPLmUgrSxLCoOebJ1bdQswbYRQxKS6Nbpg/R8S+RHru89FXTzZnonqskp0uIVT5HMwDhmfq0lxGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+j+4XkHf4LiDZU7z6o8HQSgVoE7bLITsjQsgM893MM=;
 b=M5zuDo6fM+ESoNL3yOjUGApZZsZ9X3ufZVNjntkp6/0nEVovwPDJ5n0btHee1HZ4CskOS666LJAdqXvsC0EKuyrHKHcB532nNfv9AP+hn83GCSYcd7tqqQiBTS3uvQ0NpQP8mXI026GH/8hEuVBcZuBP640/QeywWawLQBFOTak=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB138305.namprd12.prod.outlook.com (2603:10b6:806:517::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:31:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 15:31:00 +0000
Message-ID: <d65e90aa-a97a-4703-adb9-e95e07d8e4c7@amd.com>
Date: Mon, 16 Nov 2026 16:30:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/syncobj: Limit the number of handles and use
 kvmalloc for user-sized arrays
To: "Yu, Fei" <fei.yu@intel.com>
Cc: dri-devel@lists.freedesktop.org, tursulin@ursulin.net,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com,
 madhurkumar004@gmail.com, stable@vger.kernel.org
References: <3aaea7f4-62a5-435c-b1ca-35babf30a7d2@amd.com>
 <20261110084906.2458016-1-fei.yu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261110084906.2458016-1-fei.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To PH7PR12MB5685.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB138305:EE_
X-MS-Office365-Filtering-Correlation-Id: b50a3786-256a-4fdb-a86d-08df43f69d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|366016|22082099003|18002099003|5023799004|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	JMbvlthBL5VxjQyYPLI4HPf06MWgNDeRoxIsvBjJHaWxIih9vws6jJ+97D0sVFyRZ93Pg+NfDQmdAjzWllJRDf21bTp7RwQxhL11Gptc/7DrmvH09VtQEraHVaEMJliS3BOytDLUR6318WKLx6r1Fx2JL5aHSVEjXErmf8k3PnpUYlv3/0fE6M7mR+v4mQQHLLVZA654TZTMvRc09fJMaJ+ihVagtDHeWnh8SdMeNteybBsQQWYud862LOvdwNC1EriN21W+0tdnxt2Sr39H8s3OTWxhpZrxsxYJLtwQAgi0EGGdZANB/GmfX2ehbjNytggC/xV6vok60fzrepWpApbPDx00h91jNdqjKXd5e/LuXFOy14Tkp1YvbFnkR+X/8lj53oTmiNVGOQECkshwlPZmS9d6o4o+sqQLDnYXurAiIOMJ+HOfnQZhqQSmZbExRillmL5M8lakGqBPWZCu150OvGgflwffILntFShoP1OSq69pXnLieDjNkqKuC/arryx7LYF4/cMuUHVTTZOdRyr61xJKROjX6zYoh9u2c8NHrzMXQUTGDAVPG6jQo3qOuuKX+ahIvYVxkJndwijs5GrLzQ671QyTHWWCdiithp3GkIsNrY/gQsATgitmGDd04SQGbRBm+u+zvYF3KUhTe6WOZLJF642ZmdI/0d2b38o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(366016)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk4wblpreHZXdEtkZmI0Ukx1S2tJL1dIb0cxdk0vSlNoMm5lSVNpVitTSXM5?=
 =?utf-8?B?MjN4elVobjVOdXpRN0NsaTdNVFNTbktTeTMvLzYrM280SFJMYWhMSUZDWEtn?=
 =?utf-8?B?dFZUd1Nmcis4MWpPNmptSkduWEhIc3ZFeEJKdkVZSkpKZ05rNEUvZ1NPTXVh?=
 =?utf-8?B?RFEyakNKeXlESDRkbWxEbUJyNSt0Vk9DWi9WR1dxWktDaXI1RGo5a3l2bXlI?=
 =?utf-8?B?R0RZM0E1cW1KSFBBZzBsbzQ0c0FXcW1hMDFTdnJEUWlsQnVhRXVycXRZNnp5?=
 =?utf-8?B?dzRzVVgzV3JJR2hHWnl6VW14d2ppZkpQdjlNMmdpRmJUemF4SHFpaDlqNmRF?=
 =?utf-8?B?c0RpcHlyc2tPNUdNSEdCb0w0Vmt3b2J5V1dVZ1RkMEc4MlRzdWVRQnREN1FT?=
 =?utf-8?B?cGw2MndZUW9pT2JKMTgrajVHTzBuTElZUjUvRFVoQ3B4R3dmTVR5ZTNEdTIy?=
 =?utf-8?B?ZnN6K0psY2RDS2J1YVVuMjZHWHltTThkKzV3QlRpYm9kcHdSYVlJaHBaRG5Q?=
 =?utf-8?B?K3Rja2VmOUZyTnZUNlIvTUFCQzVva2hOL1ozUFBNenkzSUtuUUtMaXRnZGVW?=
 =?utf-8?B?M1B1SmN3Rmc3ZHZuNU81eVVSSTBEQnF2L2t5TnNyOW1Mb0R2MDJkb0xycisy?=
 =?utf-8?B?bVRZcXhpbTFPd25lN3NQTTdEa2FnWEZzZkZ2MDRxMkhpL1A0UlhFR2ZaU1dy?=
 =?utf-8?B?enFhVjd6MkdUOWV2SHE0ZjhKVWRFTzJmL2NLV3JHV3VPWVRZaU5lYndNbXdL?=
 =?utf-8?B?cVh1LzhVZ1Vkc1pPM01ENzRKMzBDeG9hWWZvZEJtN3lQb3ZwUnBSUVdQVXZs?=
 =?utf-8?B?clZuK3RrYThNVUh5SFRwMWhpZVRlRnNWWnl4YzJlNGtBWlppQUJLVjZUUnNn?=
 =?utf-8?B?QWdXdUtJMmtJS010OE5pRFBDUGR2WmRqSTE5S3J0clZlb21uVURmQVY0aEpM?=
 =?utf-8?B?SGx2dE55a1BCaGdjbHA5aUR4R1YxZUNXVjhHZk5Sb1pobHBLSUhUZ3B2ckww?=
 =?utf-8?B?T2dUMUN2enV4cVJNTWJuMi9pWjh5cmhKd281RldEMzRMQlRkM3pEQ2hleGtj?=
 =?utf-8?B?ZjJUNU9qTm1OekdKSDZzeS9NWGlRME5zRGFZWmMxcGllUVQ4OHU0S3dWZGpS?=
 =?utf-8?B?MHpYNFYxREIxSUJCOUdOQm02WWFxdWVNQjFXR2tCZFprUXBORUg4QkV3ZE91?=
 =?utf-8?B?L0tqYXZUWFBMZWpPUEdJYjBBNFNhRWRJK1doQ29jQnIwVU9JUmxRY0tSb2ZS?=
 =?utf-8?B?aHRjN1lKQ1JvTERwZWNkVnhZdmZsTlRGbFVVNXRhZzVYeEE2WU5nZGhqb1ho?=
 =?utf-8?B?a1RIcTZkRngrRk9hN204WjJDWTRrVG8yUkRvYnRCM1V3Vm9GTldyZW1QajZi?=
 =?utf-8?B?TWZXUUpKQUQ2Q1JDVnc2K2tJNVR1UDFCZDhIWnU2Y0dMdEJhalB2UzRHSUNQ?=
 =?utf-8?B?L29RbUdVcmJOWUdaU0xrMENPaWdQYk1UYU5QK04xVG1Xdml2VlZvbWJpQlda?=
 =?utf-8?B?eFVQbjhidWUrcUlQU3d5aTF2NnpPQVRZcnlORkQ2RUdtdDlMSUNhVVNJaXVj?=
 =?utf-8?B?MERoQXV5ODJEQW5rUm4yZ1NNdlYrUTBEUU5aL0kyUTFCckNDVkYvWWM2RHdN?=
 =?utf-8?B?R0I3b2dVQ0RVZ0lETSszM3ZhTzJ3K2dCdW1iM0ZFcGs1K3hNbXBRNGJFZDc1?=
 =?utf-8?B?VHhtNk03Z0NUaEQ0UUZSemgwTEhQbFc2ZFVDWnlqNWJHbXY1c1p6c0gySzYz?=
 =?utf-8?B?dEtLMVlyTmtUUWY0ZjdzODFoK1VZYXlmdkF2SVdiMXgwOHZhTGZ4NTYzM0da?=
 =?utf-8?B?SnhDVkozNHE5U0dBOW1ocUdXcVpidno3bDlFNjdjenp1YUFkSTY4VnlUa3NP?=
 =?utf-8?B?RCthYnlieXdvcy9tZW1kMS84Yk1CV0gyRzNFK2t0YW5nYTNsblUwL2ZvWmhN?=
 =?utf-8?B?OGVudVpRV3RvVVNKS1JCN29SdEIxZ0RSVnVqL1JlT2tSd2JuSm9ZV3lMMDJp?=
 =?utf-8?B?UjlLNkVGZ1lndnBIMDlSOTZ0TzE4dDRFZ3lWRnprUk9KMk56ZUNZT2JJRXJ6?=
 =?utf-8?B?N1pOaThHR0pjMFNSMmdoR3loMXMwcHdoamMwTzdrZHArZ1JVcStTK1Jka0N5?=
 =?utf-8?B?Zklybi81amlSTC8xd2hnK3RGYjEwb3JSVUVvRUw3dkdRK1hmZDh3OHljSmxr?=
 =?utf-8?B?WXJxa0FqYzhwNm5uNWJsTWRrUFBKT1Y5WkM4cTVtN2N5TndqYkRwN0tjYkgr?=
 =?utf-8?B?R2FXelQ2Rmp1bmdFRXZ4eHNSMzJlbTJnWTQybGRQZTUyckExakU4WWEzb2FW?=
 =?utf-8?Q?LJj72jZy1MDcchB/bK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50a3786-256a-4fdb-a86d-08df43f69d75
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:30:59.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrEt3gy+xnS5XOwsRgrARx05iX2tJmQT76B0al/iTcHMClLtlBb30k4jqf/7e/Te
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB138305

On 11/10/26 09:49, Yu, Fei wrote:
> From: Fei Yu <fei.yu@intel.com>
> 
> On 11/9/26 12:54, Christian König wrote:
>> On 11/9/26 02:48, Yu, Fei wrote:
>>> Signed-off-by: Fei Yu <fei.yu@intel.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Let me know if you need somebody to push this to drm-misc-next.
> 
> Thanks for the review! Yes please, I don't have drm-misc commit
> access, so I'd be grateful if you could push it.
> 
> Since it carries Fixes: and Cc: stable, drm-misc-fixes was what we
> discussed earlier, but drm-misc-next is fine with me too if you
> prefer, your call.

Right, I just pushed it to drm-misc-fixes.

Sorry for the delay,
Christian.

> 
> I'll send the uAPI doc patch for the 1M limit against drm-misc-next
> once this has landed.
> 
> Thanks,
> Fei

