Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793362479;
	b=kUE5f8LYVYAAestjLynszq0koB5EjOzQG+7sTZqI72KBigbax+4cKd6domckGn++oYym
	 g0HUYKf9FJVfrBkBBu938j5x7XniE1VHMDDFJkq4gljyUO1BORdvRhj3B/6yAGSfwrH08
	 IM2s1TxUZMrLZ3cnM0EsVQvUgfD5E1amrQkAEYJejkvvOrjsJ7plU15jUeu8RlN2XaZAo
	 jrEEsYAjTiYiLitShFSPiCNCIgnguv0QcguGXSJ6/NgnrkTix2EICOv6INQuXIZ2qmd1Y
	 HS/kQO1M0ZTto45uBWp88RSvyMnqCisioIcFxGFPHvpXCBVav/Yellm5FwT0FpSGOeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362479;
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
	bh=WEILxpHy8XVM5V1lZLKFx5DW1yJ07XSEf/vL+KhDXQM=;
	b=mSCmSnvecX/KlpH1oV1W9tYmqgdJLRoGesAIJBp6Grb3Dhp3KnBoBKpc6sQ98j8DBoIe
	 NVQICL5fThNhRWlX5dUYjimf8kPYBG284/4Rus2SZkcFuIXmjiHynZbItWGEUeGWLiOxF
	 5D/2GbY+jsm5DN/wktYS9rcFPJM83Hw2sdaznZ6+DexQV5OWeMpZAvUVhHTOSZhscNGGx
	 5fjkuih74GU9xruMV60rkAKG+T6CX4uqBjkoSgXndOs7iRXrX8OahA7//61TvOLoAeQuf
	 G5CiD4YZBpZGv+rPmSbKPzI0qu/f1chEbAOetpUoS0WcCzNGHMaG2J1DrSQ1/EmcNzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="dvBe/WN8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.61
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1516606A329;
	Fri, 30 Oct 2026 12:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1516606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dvBe/WN8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxmcIigFZDk9Sq84lW+oWU2rEtU1HBxUstPljl3oRINdWCZ/Z/xjW/v8Zg3dfk3UxyyMmq/eF6RMkJ0EbO4exDvhSzihcAO+tHQYdovB5VvNxUe6JWmj6WKDUsuEgHNyDttp2WARcRmdaAeU7a2TFjEyp3xABVPWUvCoXSYjDP4pXtEYt0W1E5t3oLMf43c3XXIjSZlBZSCI0VsXUjtuozxoS5oRF1MNuETrPjNdbFPvlcw2IVfaEsZg/AVGkIZFXj0IOCffmsfA71cN8tlHw9/Ym9qmK3dIfX97nW4jBI005v/rlqRHjjcGt0KVd/vRa+MCqBhVgRDBCDb84V3+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEILxpHy8XVM5V1lZLKFx5DW1yJ07XSEf/vL+KhDXQM=;
 b=q3ERiDJ5jgzqfzV4oJi63DtszlNQz1dQQ73DLtM3fNbAtpyTnjKB09muQSET3I1FEpzL/UqzEjz2oU3isYUNPoDxA6oiWeJk/Q2L0VTPDZbPHWQOBG4hWPiie7WnbwHQVAOgLBIY7h2NXV7lhxZxp5x0080qh+9S4QcTGWHOCmgVZoKbr+wce9vWHAI8eo6dJszgYAx7xCU/3k/3NM2GMN+yscWXnp4L+LuUNmIcTm/1DvOpbv0EEcmbD9FLK8CXtKfEaKK5N28wlANuyUhTmPR+muD3lbaROZAcbGRBaKhvREFeO4TQum6y5GXLjnLpeBCwqhLvty5Ttw9qK4SNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEILxpHy8XVM5V1lZLKFx5DW1yJ07XSEf/vL+KhDXQM=;
 b=dvBe/WN8Lavc2plfqLEuNeVhmhwxRH/beLVwu4VbFrYsqpAvNopHyjSfVYpHO/gRQ4gBGkJmFsTotxt4zat8W0PAQ+1O3t2lW2/kGYmxdV1ItU22PtwcIGZtgWPq5I/x9JeUbMAmBmhVF3AiX0yMSQu3/4vRFfv6Co9Zb0mTN8k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 30 Oct
 2026 12:14:35 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:14:35 +0000
Message-ID: <43cae78b-8a9f-4528-982c-85c0049b1414@amd.com>
Date: Fri, 30 Oct 2026 17:43:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] soundwire: amd: Initialise and cancel IRQ work
 around manager lifetime
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <Mario.Limonciello@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "N, Poojitha" <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-17-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-17-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::18) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 137c5b07-09b8-42d2-f633-08df367f5c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|261021121427099003|261022105027099003|261009223027099003|10067099003|261022075727099003|261021123027099003|56012099006|22082099003|261026121527099003|18002099003|13003099007|261028144727099003|11063799006|261026140227099003|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	xHnZr9+qqdL9y90mLWaER1Zw4iDKsS6Z8k29u/SZ1OjSnJu2RrwEvM0gFaosFmt7oRp8vX2XtyEf0+N2hnuGLVYQlAz+wLrxEVGcjxpiE6jpoDb3VzmuePQ54L0Y0YkhrhkJMU3sCnnTE5BZ1ffixMsZsE+u9oLmnjtGAnEacS0mzs7T5so7M/0bYUyxWWG1KW95vKWT9tY+ye+HXbfEOL4/wyKjVjCtJdm23mA2Oq7BYB35zK0M7E8E13ZFdsrm3Lc50GM8v8+cifumW2mAY6qXwqoCCh9iuqRuQiPHFumje5yWJlLSDtMFxshq0JD9gb+tgmuO/GUbeOn60KJ3yLffOytw0KE1ubXqYL9TGMUX3zEtIFtZmci+yqlnUqF8W/brY418od+iNtBz/x5ss+DrwzYVRObeWuAGUmzL6DkJQGn4eqXWl/FkUjDPdj+UdJwXpG2oFMipZmjFcQUK4UIOxZcvCqIzliSwdBJ82Pimjgt3zaMIatCqmABgv9OM/R05uiVhyaiusaMieIylXk/QpahRXXbKABYFLs2cSMFKWgbSyt/0aShA+gGgaaIimXcYjCZ9qKMHsmmbaS/wGKSgWh0KFGxUDMq7YikD6aO3b9G+FPgRKiETRUdBWPnhY5el46gAerulIzXrq0tu5Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(261022075727099003)(261021123027099003)(56012099006)(22082099003)(261026121527099003)(18002099003)(13003099007)(261028144727099003)(11063799006)(261026140227099003)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0xsb2xMOGZLVDF1MXZjS0RpeEdpU1MyM0JwNjhUYWtVTXVFcFZHWmUydXVM?=
 =?utf-8?B?cHF4a1pMUkIyL2VyQnNBcmRnT1ZYaWJIbHFGbHFIMzEwbmx4S0ZVdnc2WUJY?=
 =?utf-8?B?c1ZkUFEwYS9Gc1ZZeEVSMEV1NVNya1ZPRzE1dE1NcFNEbTZMdWxGNldQMUk3?=
 =?utf-8?B?bDBlOHZDTlRJMi9XTzlabEZFNWVubDliMWxTN1U0L1pVbUNndTh5ZjR3SWgr?=
 =?utf-8?B?S0UxVDFwNk1tU0ZVTGp4RnB5aDVUaEtuVENEODFLcXZ3d09CcEhBTUZzRlZt?=
 =?utf-8?B?RTNEWHRSYWc0elRjTXhiRkN5R2QwempsYnFDVnhGMGZIeTFHMVpBR20wcEY3?=
 =?utf-8?B?RVhSb0N0bGVBTUVFUXFHOWtSNnFxcHRUVTdtMUtkYVdCekQvYWkwbzFoVTZ2?=
 =?utf-8?B?RTNyaHFrcmlPcG12b1VKK0J2ayszMkduMnp3dk90TjdWMytXY1A0QzNBeDg2?=
 =?utf-8?B?WGZDWVFDRm5CMXRUblJXYlg2VkViRFl5aTZLL1dvNEJOQ3Rla3ZSS1pSTW84?=
 =?utf-8?B?QUpuaHJ1T2lVQ25TQ0NXM0F4QXg0RVhaYWNWSWJaMEFVcHM4czJPYjRTOEEr?=
 =?utf-8?B?MWc0azIzZ0o3bjA4ZVFFbmhGMFp1MEc4STJFTnRhZjE5VkdwU21pUVk3ZGJN?=
 =?utf-8?B?V3c0d3RFQXI0blA3TFJud2lDS21scUNjSjdjRWRtczY3cU1XZHBFNTBFK3Rt?=
 =?utf-8?B?UTVLWlRxVU93dEkzVGJRTzNXcUhWQTM3UjdqdGc2bW5vcXJoVkNucTFMR0li?=
 =?utf-8?B?ZmJENzZhbDVHcHZZTlNOMGpwbVlpTWJkN2ovSlJybUZwcnhCN3FGNWNSWnRi?=
 =?utf-8?B?a21uc2N3eEtydzNiY3JWUzRMVE5WRkFsZEo2OExKUzJrdkVZeUVFSktDNzlV?=
 =?utf-8?B?RCthMEdrc3c0WVBLR2ZLR0dCdUV0T2VJUnhtV2xlL1V2ZTB5bmtnRkp2dFBE?=
 =?utf-8?B?MkY2Sm5qNFNUdFdkQ3dOaHdnSWZ0dFkvL3QrRi9lclM2cjJXQ3BtRlRjQ20y?=
 =?utf-8?B?Nm95a3FpKzBlLzREZms2QUFBVkVlTndNRy9INUd6TmtwekpVWkNUdEdLRU5J?=
 =?utf-8?B?QmhnRzB1Q1RNT1EzV0VLamtLekRvZnZsanFHemw1WC9ZYkhGY0ZqRGdyWDRx?=
 =?utf-8?B?ZysrRGhtdTlzOGM4Qm95QldMbmVKREFvNWVHcjQ5bXlMa1h6MVlIUTk4cnVG?=
 =?utf-8?B?VEJQSFZGbWlEaEpyeUV2cHBlc0l1U1JWQTUxYVdIWW96a3A3R0duT1o5Z2h0?=
 =?utf-8?B?Mkc1VjJxSmF5bkVGRWJ1bTMrM3pZdmtOckdhdUx0cDBCTHFtSFora1VLcVNN?=
 =?utf-8?B?K01wQUNOZ052TTcxa0VNem9jejJvaDhEeS9FaHlGZHpvN2g5VG5tSXgyRGZp?=
 =?utf-8?B?cG1ZYnJGZGhmR1JhT1QycHY0bjdFZVZ3TFJiZW1LWjAxUFdPbFp3ZCttNVVQ?=
 =?utf-8?B?WHBZMU9XVHhicGNDbzJtc21wOWF3b1kxOEdFZTU3aWZtWTcvNGF4cUJKUEJE?=
 =?utf-8?B?b1lRMyttd3BXTjJ6YkVnVFBKYTFQL2VNSzd1NlVmUENIOTgvcGE1VzdzN042?=
 =?utf-8?B?QmRXbGp1ZFRaMWt4Q2NhNXh6WXBqbkhuQ3pJOUJCczB4dWc1R21Odi9YRDl3?=
 =?utf-8?B?aTN6eHdkUnhDNHFDRFpncTJ2Zm9rRkRCSEg5Rm5rQXpPVHl1VFpUdCtIUFRI?=
 =?utf-8?B?eGl1NkU2Q2lwUnl0a0hXbDc4QzNidUQveVRnc2x2M2JQZ0VZM0M0WEdOUDBk?=
 =?utf-8?B?ZWhvZWgzeVRYeDQ4VG4vcnRRa2gvMVM2cUIvNEliMFY4ZkdUU29NR0RoSHg5?=
 =?utf-8?B?R05mVUZWTVlkUC82cjdDM2s3MGlXRVZiL2JobmtNNlFNUXB2UG9IeXQ4cGZj?=
 =?utf-8?B?OTRFczArckJTOUd5dVlDcmowWERnRlF0WWIvWHVxZ0pzVWhoUnd0MjhadlJP?=
 =?utf-8?B?TXJaV0hKY0F4WlJNZ3M5NkZmQS9oeHBqS0JtQXk2dTA0N2NGajdWdDRaclY1?=
 =?utf-8?B?amRUZ3R1bXRUVXJScWdaNStNQ3pTK1pmZFJabExQOEZpdG5LQlR5ajZWT21y?=
 =?utf-8?B?bGhrek10YzBJVTd6WGUwcXVnUEk0R095ZW5NamdZNkU2STNMREcyVnAybXly?=
 =?utf-8?B?bjNseWoyTjVLbFVlUlZuL2hsUjVyYXBuSCtaMXZ1YUpHNGZONWlZRjFyY09t?=
 =?utf-8?B?RFRCQnlhekhPWVNMYlVFOFVQVTFFdmJLMW5KRW5yVXRtTmVVeExvMEdLeThh?=
 =?utf-8?B?aVowQUdIa1hxWWNOUmcyT0tVNmhRODZ5STJ5ejhCVDdSSjlacnNjSEUyaGxz?=
 =?utf-8?B?UVpSR0N6ZFI5aG4vcnhXUnU5SForSGJvMXc0WlowL0ZJRlZ0bTJ1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137c5b07-09b8-42d2-f633-08df367f5c7e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:14:35.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25HOB5sDHUSPg0By9htV2B3iOjk4MD3oLNm0l5A6hftlOvRhlNM4LSLU7Davdw0oqN3XaOekPb1frVv5IxvjGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211



On 10/30/26 16:16, Lee Jones wrote:
> [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> amd_sdw_manager_probe() publishes amd_manager via dev_set_drvdata()
> before initialising amd_sdw_irq_thread and amd_sdw_work, allowing an
> early interrupt to schedule uninitialised work.  During removal,
> amd_sdw_manager_remove() only cancels amd_sdw_work without first
> cancelling amd_sdw_irq_thread, allowing deferred IRQ work to re-queue
> amd_sdw_work or dereference amd_manager after it is freed.
>
> Initialise both work items before calling dev_set_drvdata() in
> amd_sdw_manager_probe(), and cancel amd_sdw_irq_thread before
> amd_sdw_work in amd_sdw_manager_remove().
>
> Fixes: 65f93e4096a0 ("soundwire: amd: add SoundWire manager interrupt handling")
> Closes: https://sashiko.dev/#/bug/linux-9890e8dc-4b7d-44d3-bfb0-171dc421e28c
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_manager.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 98b09d81f3b8..2e1038ea0f36 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -1185,9 +1185,9 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
>                  sdw_bus_master_delete(&amd_manager->bus);
>                  return ret;
>          }
> -       dev_set_drvdata(dev, amd_manager);
>          INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
>          INIT_WORK(&amd_manager->amd_sdw_work, amd_sdw_update_slave_status_work);
> +       dev_set_drvdata(dev, amd_manager);
The probe-side ordering issue is valid — an interrupt arriving after
dev_set_drvdata() but before INIT_WORK() could schedule work on an
uninitialised work_struct.

The remove-side fix is already posted as part of our v3 patch series:

https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-Vijendar.Mukunda@amd.com/T/#m60177687bb84758efdd6f5f09eba8ad32f0e4631

The probe-side fix will be included in our upcoming v4 patch series,
which contains major driver restructuring and customer-critical bug
fixes. Merging this patch independently would conflict with v4 and
complicate the review process.

Could you please drop this patch? Both issues will be covered by our
v3/v4 series.

>          return 0;
>   }
>
> @@ -1197,6 +1197,7 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
>          int ret;
>
>          pm_runtime_disable(&pdev->dev);
> +       cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
proper fix already posted as part of v3 version.
https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-Vijendar.Mukunda@amd.com/T/#m60177687bb84758efdd6f5f09eba8ad32f0e4631

>          cancel_work_sync(&amd_manager->amd_sdw_work);
>          amd_disable_sdw_interrupts(amd_manager);
>          sdw_bus_master_delete(&amd_manager->bus);
> --
> 2.56.0.317.g454f8302e1-goog

