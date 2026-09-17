Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012013.outbound.protection.outlook.com [40.107.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834D4A2A5D;
	Thu, 17 Sep 2026 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641956; cv=fail; b=rzUYh1WnXKDDZMBKz86TyC6ydDaDWVRRp1o3kBp9896qoBqvoPxR/ZVXlpGXju6AqN1FEC5X+lPgKA26IxYQvQ8AkwXGM0mkLIr+5zqgY3Dt8WWyK5VUmV9VhN3m305FF3iG6w9FxFk4wKRS0Nn8QVeX6tn2V0bjmXkuR3uSahE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641956; c=relaxed/simple;
	bh=M9irDJEwPLMgUH92Gy4rvCVIC+ilnc10TYSDN+1xXgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aMJ72SDx/dSaOXx0p4o8z097ZQ8FwfbeBZJe4ouNC3cvei3h08UGF1LXLNpe8bzQccKAkltDF6Hs23S9rxqWTXjvRsKoJD3EbiLKW2UTzDP97uxbylDg9YbGUDhBQXEDCwlXss3t9CLfC/PTb3zGVIj4e3EUYWwjLks8QKS72Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CF5rLtNy; arc=fail smtp.client-ip=40.107.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CF5rLtNy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnwvsZ5hahX0HQgofbAIW1SWTUXj4JyPj3jteAGKgxjxM6nT9ouuYsmr1mTn/lpo/Cd4dJYSz5p/3NSLx2iZQKNiA0UAlHw30LrFoLFnQi4FHKqCpf2rsE/xTVmorIWkp6oQrHiXhxkBe76Rsr5cuFtvPNy4wRwxDRDwYtTRlxWi7X0NoxF96T0A+mPQDzQKaUggcunVPiVOVtVJ2CyftroMa+IcYNgJD89IZfSMU8yi8dyeRaMDLUZh4qgdPvLwwnJ8j277v1pqJzlQwIjQMqYre2tjJwfeS/pfgYoL/XoHW/ezSQ6E5h0cim1UdzdKZgjLG3PAjIx/m/dqJ7pDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX4GB8SSRTQXlINpubsT4QBm2M5uYHCj7eGzgo/7mJg=;
 b=IreqN3Cz2IjUVYcOq5CNTnBEh+xt8PaiiaQUBv84bExWf8uaNnmwt7fkUJcvt9ykM6xjzOJcrl/K8+Ag2Rxfky7OqIZujwTc2gjMnwrrJxQPdrbFfenKE8kUxFnL9k7CEhjUsEsT81zBCqgDSxgaqvYd9OzEyEOk6clDXVcea94M2h0abCKlu7PN/+cWyfmi3f4iyWjXiGMauFwP2pY/x3ZenXkSBcU7LYh/N3sAAgAP36HuqQrQVwDqXhUDW156A6ZlR9wQDNWg4vo/4afyMwHJZSa7tn1DqhBOpam0bAKeWU2zOzZn2tg7SoyFvuW7CdHEQth+KHdQhZLZLX4uzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX4GB8SSRTQXlINpubsT4QBm2M5uYHCj7eGzgo/7mJg=;
 b=CF5rLtNySiFkDl/pBNbIkWN44TOEjsFdoTUZILZ0iiOF94Rm+3XweZyuIZDNtGTBujRtAdaqI9QXYZCtIDTqJkScUnEfQLKclewk/wWHUORy9j6HtSvjnW6yq5uUZO7SmxiCj6TF7sXdWRukFYmwsQJAA8JBD01PaEpTmkJdqkrAk5670zhGsiFoYAngqnOL2iVXIn06AK1qbFchdsRcx/35SoDr0Xh7epWSM3REGCfNEX42J+ekm2HI34pnn/GlCG7Lp87hQ8OgFU7BuBz6VVwd5qbFmBSyik0s5gmnmk1k//nVsLROEa78EvYfSkOOlRLr/vG4Wd4Fm1cF8vpR8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:45:50 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 10:45:50 +0000
Message-ID: <f7678a37-4dd6-4219-bcef-34a2d74783a6@nvidia.com>
Date: Thu, 17 Sep 2026 13:45:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5e: advertise MACsec offload only when
 supported
To: Ralf Lici <ralf@mandelbit.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Boris Pismenny <borisp@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Emeel Hakim <ehakim@nvidia.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Simon Horman <horms@kernel.org>, stable@vger.kernel.org
References: <1b7ebced14243c1b342923a25bcc44ec77c45907.1787086511.git.ralf@mandelbit.com>
 <20260917071019.134035-1-ralf@mandelbit.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260917071019.134035-1-ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::19) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: cc34ed0e-d25f-4a99-7178-08df14a8d6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+l4aXQhfwjIIx+7rjW1bUEif7uHhwXbGS2EGmQb/IG8O2wYEvNCkk+2tJuP+rE95VgSIKenkRpDpTRAXe9FexalcSuorjFNFo/dbrx6cRWAYBA2ju758t9v4Gkem7mVT7pef3yJsBpanHE8Ks9EJ5DvaVn0MKtjb7oys0tlnEnF9xGbE8oZ1AgyY/Beewt8KIUM8Hfk1jqDkfGCGaIQJPHE0yB+x62ckEJzg2rHZdKYGB8XooKCUB2B8xzGk+p2OG4D/lSwdJT/ZSqigO1KTZ9qzhnPuhqKJ9XCSOLU8GcCBKIS+SmhBC1WY5c0do/osnf2TXHXWeUknyaOWJT/R2fIlb0ilMg4kGmxPAPa6kRxj2liDsgS+J7PH4ADlb2Jvd4Ak5HABiSFP1jSVkTPQfgAArUb2rkTZAAHGDJJ5qnigOuSQ75IiOs13a3LnFYhniEJ5IuccUmEVilrNrTBskdFLFtiVP4Y89SmvGFMXGqQQV/ULb0v0s97ajPI6OJWB3ih5ahukJ7gsiYj/C448PvUGTT7JyrbZt4hAZFJIkHLOQbfiPi7o2U8z8rWxLf9NYGVJ51iy0Ks+J2i14JxqT//fLMDEveU/E7wZY1LpVBwHSMSM2rzWPXUzXmvB0YRsut9CjVJWy+N8oyAjIaSdyrH2C2DL2Q5qEQG7P3lK7mE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rjlva0FqNFdTYXV6Wkx6K2RuaHErRHMxRWZDYUNRcWNNWHpKKzRUTjVRR1l3?=
 =?utf-8?B?OUlseTQvckxuU09kVzBaSEpsZzJDWWpqTHhrc0JXb1FCTFdxRjVmMmpwTFFO?=
 =?utf-8?B?K2IyeW9Ud1c3WFJZelRwQVVQc0VickhBR0tOUm45WkI3a2JobC8ycExyUWhm?=
 =?utf-8?B?QzAyTGJWa1Y2MDI3SWtPR2VvV0Z3ZDZYMVc2VmhDVEFBSXdxSjBsRVBna2M5?=
 =?utf-8?B?MlZlMlNIck9Tdm5GcERlL0Ezbjk1UjE2TkxRbEhRbkZtcHMxdWdvbmlWUyth?=
 =?utf-8?B?TEk5emNNMDRWaGMxdGtUUHh6eFVwR3ZvdTFiZzdEbk9PYWh5T1kxclZRZUpR?=
 =?utf-8?B?MG1haWhFbktyU2lBbUVMWHpxTUtwTEJ1eXl5QWZBZ1YyYjF5ZGhOWnRFTHFo?=
 =?utf-8?B?MFYwTzhXZXgrSTRQOFB3R2ZCUlZiTHhjTVp3VGxOYklJQW9yWEZ0TXZ4YnJE?=
 =?utf-8?B?Tllpc1l5MFVOaGNFNGptVzBMekJqSEx1bDdPdHkxVEswczhFalFpd1Jjd3pW?=
 =?utf-8?B?L1RWRVdYamdqRm16SXFORkZZYU9jYnRSWEtjcWxrdnY1SEJ5ODErNTRQYnJ5?=
 =?utf-8?B?eVJ3NklxWnVhekZjdmZjcVhpM0U3SU5zSEQ3QkpsS1cxaE1qdjcrRE54dGl6?=
 =?utf-8?B?WGpVZ3ZVbzE3b2dNNEpKNTNTVlZCNTNjRnZrSUtydXMweGZIWkMvL29zTFB4?=
 =?utf-8?B?UWZJOHB4Yi9jVTBwdjNwY0kxY1FidUdyTTg2MlN1ejlVS3RPWDliTHJ4NE02?=
 =?utf-8?B?Y2FtYzFRYXFybThmU0hkRjgwREZXNTNpOE0vamR3YlA2M3NFY1VjaERTUDYr?=
 =?utf-8?B?dmZ4N2Rhc1RTVm0xZ1Y2ZUIweXRCRURTREFSVnVWRmhsNm42WTVqU1E0TytU?=
 =?utf-8?B?Y0JRRlRySldWbXhkUnBVbURQVXo1ZEJMM2FUSm1ha0VPRDZvOVA2Rlc0d1dF?=
 =?utf-8?B?QmtkZ0xVVUZlNEFSVURLYjV3dVovT2R4MEVwTHBiVGNQckhHRDJNek1xck5R?=
 =?utf-8?B?OFhlV1RqcFE2QnEwUWUyWktKdWtWdVVrYlcybGV6UUNxTEZwV2Fza0NVaHhJ?=
 =?utf-8?B?Z1dsc1JVVVFpNFFlZGtrV3FyTFloQjE0V2NhVlJ0UFR4cnBrZEZtZEh0Wlpo?=
 =?utf-8?B?eWJSYXBiWFBCUE1DbUM5RW0ranVDTW9qNTRWcmlTYmF2dUJGTTVlNjQ0Z2lm?=
 =?utf-8?B?RG5NZGxpeTNRNTdRRittVXplY2hsZlRhMU1NaG5KTFpoOUlNaURYSkpUamZz?=
 =?utf-8?B?UGIySmN6dzE3UnNmWlZYYStJc0VXbEZWV3l0eGt6VnJqNXpzWEF6b1FWOEsr?=
 =?utf-8?B?L2hEUHV4K3BnVUxDSG5ERnY0VHFocUNOS2hDeGdXOUhWUlhkdXBia0Q2N0gv?=
 =?utf-8?B?YlpKclJCa3l2VjNScFR2Y1RMblUvdFZqdGlWekdTQWloamJmQ1NVZVhlWWR1?=
 =?utf-8?B?MnRMTlRNL3QzRE9hcG1iOE1sQ1VjQ0RPTkhMRkUwSC9wbGpmNks3NjcrWDdP?=
 =?utf-8?B?UmxNV3RCbHFNS2xBcnk4SHJRUXpRR1pwdGtHclVnNW8xUXVOOW9QVlAvV28v?=
 =?utf-8?B?YldmNnhKNk4xZVByT0VOTEpoSlB4ZnJmbUs5MGcxcXIvRWlCTE9FeXYvSlEz?=
 =?utf-8?B?ZTJWS0RvTDVGaHdPTEUwQ25jS3hHL1BUeXlEbDdld1VDYUJZR1ZpTWtBY2Zj?=
 =?utf-8?B?ZDhEakUrcll1bnFqdWgydWFjNlJuWVlSZ081WGpJc0NvNVFka3BKSUxuT0dH?=
 =?utf-8?B?MCt1V1VUOUtnSHkzRGJMWUQ0c0VMa2FoY2NWVkRXWGdrcXVibjQvTGNIWFhm?=
 =?utf-8?B?NFdsTG82elNqSDkrc25UYWtkLzNuMlhZNTNtVWR5aDlIYVBxWWhZVjZSRnFm?=
 =?utf-8?B?V0JUc1FDNFVQNzMyNGFmWXBMLzRCeXh2d3RTZG00Z010cW9JOTJaRllWRDI3?=
 =?utf-8?B?eHRKcEFPMno2TFkwdXN6OFdwSnM3elB4QUlYWDJoL2Vsa3JRYWRoZUpxd1FE?=
 =?utf-8?B?MFRaZjBDTzJTdzhmZ2Z6MXlHWXptVGlkU2ZGUWZNMDFJQ0MyQ3JYM2NQT01u?=
 =?utf-8?B?b0lmaDV4cXJhcmFZZVdhdG1uejQ3QUJjRVBpd2pNTGlDdnNrN3dWUThIdnI1?=
 =?utf-8?B?M1piOGJha1dyZWFxa0ZVZ2tSNWdyYmtEa2U1Y1N1VEg5NThIR09VOHJJeFBK?=
 =?utf-8?B?RlQ1TmdiTkRVazZPQThiaHFJc1M0V1RzWXZPeDlhdkNMSVpxMXdGVDNab3J1?=
 =?utf-8?B?eVZCNThpM1JsYU5ndU5jUllVcEFYVnUxVm5hKytqMWxyYlJyYkptNlJhOUN1?=
 =?utf-8?B?b0EzRktPa1dkc2JUby85eUhKM2ViL3pmWFJuRGNCalg5RHdpY1Z4Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc34ed0e-d25f-4a99-7178-08df14a8d6fe
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:45:50.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YUuPsTx6wzgTZSuzh5w2mMQs2t+ioru5ADAVeNcjgpNRGnAkpvvDkIL5Njrui8MZjSt0geEkCXWc90uyE3AJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668



On 17/09/2026 10:10, Ralf Lici wrote:
> Hi,
> 
> Gentle ping on this patch in case it got lost in the queue.
> 
> Please let me know if there are any comments or if you'd prefer a
> respin.
> 
> Thanks.
> 

Hi,
Sorry for the delay, it was missed during August vacations.

Patch LGTM, you can re-send it yourself and add my tag:
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

I can also do that, let me know.
