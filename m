Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013012.outbound.protection.outlook.com [52.101.72.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEE83DB999
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273506; cv=fail; b=mjH6JNDQbyLD2WFHy2Gbn3IXUjH/eAbjy5cLr+BP73KJ50JXzVMUumVe9L3JD/dEkXwENxegjOlKj3upzknBlyqS/UD4NoYKnfgo+lUnWJwJeY1uZ++oRvEouPvBZoNMKQuImsCfQy2iYwuTXrdcPdYZJcgOrxcYAM6p4x6NBVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273506; c=relaxed/simple;
	bh=ettm9H8hlRGgo5ZH8EEmh1EZcZcxCdvNqcC1f6cc9y0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1+E6NWPX6wpDQjbFK8b6/6LHHWp0s1KKZO1NM9N9UhpnwX+62YGnw2emil9QTuCg9uY49PNtk3c3GEeevxZ5ZCa1pW3hhvWx/hFNM/jzeYqdBWCFPyt8fwC/zS5xuKNFPFAJJwFH8PjrW5oEgOhz2b/iKckzuVQkLwkXi1OPWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com; spf=pass smtp.mailfrom=criteo.com; dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b=bKl3tAkL; arc=fail smtp.client-ip=52.101.72.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criteo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b="bKl3tAkL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYLgK3xcKYBGzhr4qJ1PPJVyWbbVfdflENU3vVwJDfLtNNpMKdm9cHJ7ansTeblGJSdokqxmXvdFS1vHFmYQ5dZqdZRNLaiT0Jx+4pyh0TmwtFeurM7y3CaOXU/qetB3uNfSrayvvdtuI5qtaTtlsdMi6htDUssSbX0+2A/9+0YYxPNLK+0kfDnAgzz70ADyvKpX4CF044imSXCo6VAm6R8SzAIDaQk0uY+Pew2WrHafPyv8R6WbXasmbT0wAa0GS9pJwtQy5U5mTrfLWB41t3v6OEO9W4PhfYkIkqC9GSy9ka9+BLuScIHt731FRXik2GYrd+xop5+fIHMskJFWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ettm9H8hlRGgo5ZH8EEmh1EZcZcxCdvNqcC1f6cc9y0=;
 b=hOGglRWAhzZWQucNWnXVM3Ld2GEcXNF7FaauqDdCea2zjBoK9Mv7qb0ZDzsi+qgSmjigK1OyiHTScBCoeL+ppBlzD+7f+X1TN2td9k2nnwXgHkqLvW3I1lmfavTa/Si20wxHW9Qt2FASfKI4fpNNBaGG1M/WnXggMBXxespggzqRU0tn7grshk0tR34TnLmFepjEI99QCIQU9AA8E1G8f8wpGM5yDtDQ12Uy23msEE+aMLQrW5gxD65RFdBvdkJ3R9oKJdsaeEtt7hTsEsXprhqAz0kF5IUCezmt6quFg6tsh4YVzPkuuEx6kzE0NcMsIRiF8G49MF1r/vlri+2d6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ettm9H8hlRGgo5ZH8EEmh1EZcZcxCdvNqcC1f6cc9y0=;
 b=bKl3tAkLmEpdsy+0SWt8s372amW95SNXXkxFN3LPbXDak7NnwIhvUqO77olQk+ThQ6xNxWzqpuGYwh/WRXytl94Jn2/tGydbIuxvllXbLuTjzKudi7E/p0lf2QFFW0SPlZvPo/ZGUU2jlhtnRtUaG33UP8yjNp1fycBBOxWOrJCLMhFK+BEgCBbJs7uuxOA3hNdv8S04t/1tvODcFerDZkrPRCfA9pzt0wfHZf5VQU7Z7KJBSWmMD8WtpuS5ur3fI0U+fJcp/RoM+J8RStStG69JazZNdfsRGvMyEp7BiufLBCA9JCy30ymXmaZXxfu61MCCkzpONYcc9PyU1850bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by DU4PR04MB11847.eurprd04.prod.outlook.com
 (2603:10a6:10:622::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 07:31:25 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 07:31:25 +0000
Message-ID: <8e5acc95-dd4f-4125-ac51-c8fb70623ba9@criteo.com>
Date: Fri, 17 Jul 2026 09:31:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: sched/fair: Only update stats for allowed CPUs when looking for
 dst group
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Adam Li <adamli@os.amperecomputing.com>,
 Peter Zijlstra <peterz@infradead.org>, colin.i.king@gmail.com,
 Greg KH <gregkh@linuxfoundation.org>
References: <2026071635-goliath-clamp-5cef@gregkh>
 <20260716232340.0008-stable-reply@kernel.org>
Content-Language: en-US
From: Erwan Velu <e.velu@criteo.com>
In-Reply-To: <20260716232340.0008-stable-reply@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0217.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::18) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|DU4PR04MB11847:EE_
X-MS-Office365-Filtering-Correlation-Id: 09040d8b-7cc8-4306-f39c-08dee3d56835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yK0zK4x65Dht56T0rU+QbRtZO80xRfeAA/mYUWFSHkacvnZvwghsVZMAYxaIYtK3UTnfNUEVBTRqGZyC5qJPOH4VII4S4RHK9qlPSV+0afg+Z2hP9smKmkStRwvBOqXbgtKpfKYsZFZOe/af78o+gwFArjxl0UKCFriEd9YFjwhKaQ+m/+npczIeMQBxz6857gYe0tGMo00haGcM9UM/yWDh+XTxP0IRSmmGfeSXLQcurkYVbQlWg4zWoz2zRt+sUfpKA1An7s75xExFeN2Q8IL473YgYHOOf/HWqj1wz2ITPCxnExsIpYJt5wqc92zZtbA9elB7MPLygELtUBM2TotqD36WgaiXm4cAzhjC0vCKGPl+vxOiJfsigopWVT9Bc60x5NTgAhBYwP9aOgnPdoDj692YKzNwB1bMuPMlfu8IWa0ATwG3feQoLZHzbyU9y9p5iQuCVV9Yl1qngwg5ubdOIDIi72Q+q4SkPHUZWILsP7+DSJsuKfM7M1pRlTMoct5Mt0+9sY5hW3UB8HaLoRKIa4+9X0g49ilncmIWQsj+VV3k6XN/qDDMB6B9dKmr38XWb+Xc8PW7GFtJ29TQjX/uD+SyO9Stdg5lcCcWIErHESLq8Vk4DRtUxgXbe0jWRgRVO0kLwLmvQFZBuug4N0Z7S9DufNrrKyl8Vxhm6y8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGIxbXE4UW9jajhtZ2xRa1NYV1EwMG11SWpqQ2ltc04zNXRycFowNWhiTDc5?=
 =?utf-8?B?OXBPYzJsZVhlNitxS1Y0b2FkUEtSRGU5MUczTEozc2tPdm8wQTRKTGhyNEFp?=
 =?utf-8?B?SjNGTXBwU0xOQlczQTEyOUU5REpPQWFrVzBuU0VzSjV0SzBhWUxKVC9vYjAv?=
 =?utf-8?B?VXJVc3VGVjV4RzZUN3JIVUh5Y1kySWZXNitzeWt6SUZDM1FqeEYzU2pnTU1E?=
 =?utf-8?B?UXZ5K1dDVFFSRkhyUGtuOUtYRHd3UGlhNmRhZzBqcjFPb2VINUJiRVZmamZE?=
 =?utf-8?B?dGhVWGlkeU50ZEJjTTBSdWJ5MHpNaTZnZU56V21wUmFLNzNoWFdoVGZDa1h3?=
 =?utf-8?B?UFN5QTRRM0g0TitzRy9zQkdERitFTi93MXNCd0pXQlJtK0JUcmdvUHN0T3FM?=
 =?utf-8?B?ZXpIQ25wZUVxdiswejl1ZnpiMXQ3RWpPNTh4U09FRFM1SjEzZEhMbDFMYVlh?=
 =?utf-8?B?VDlmRG4rM0RKc3ppMEQ3OTNBSkFIWUZxNldCYVdrRFdwTUZ1bDBJZVBNOGoz?=
 =?utf-8?B?alMwWGltRlAzZjRBdUFQOGhiZjNjUGtVSDFScnRESnNOaTlPMFF4Q1hTajVv?=
 =?utf-8?B?THZiS1czUEdDRG5USnlDVkpWY0tYY3JycHN2c1IwY2JIblg1M25ROWo5SHUr?=
 =?utf-8?B?R0UreldZTlNpZy9rNkhqYURYakZFa2FSV2U2a0sxUjhnQXE2ZnQvUTZLNDUx?=
 =?utf-8?B?QkgvSm1nYzJQSmdxTUJVc09rWndzS0lleC9PT3RZcFdjR0UxVW1GbDFEQzVX?=
 =?utf-8?B?U2Zoa3g0MjVLR1lCSG9iUzYxcXhtQkxIdFordm9zbXo4dmFGSjdGZFJYZHNZ?=
 =?utf-8?B?N0podGpMY1daL2R0SGlPUXFYdWdtMi9wbFo2d1c1em53K0JCUC9aNWIvRUpU?=
 =?utf-8?B?ZzBIYXpJR283alJuZ25TQmdmSHliZU1TVlZnajJwUnY2M29PQWp4YWMvWEJw?=
 =?utf-8?B?bDRaQXhza29ESjZQeDF5SUNlWW91MldZMTQ3b2dSdUpOK01IMG5TczR6WVZZ?=
 =?utf-8?B?TUoyTDVRZ2RLMlEreElKbjhnQk5xMGFkQkt6Rlhwdmkrd0czcS9KTklTWi93?=
 =?utf-8?B?dlZQYkk3bEZBMTdMVXNzbEJicmVWeWQxNHEvZ3lUYnJnOGQzSE9najJBWEhF?=
 =?utf-8?B?QVFxYVExTXRkMEpUZVVzYzJ1WGVJK2ZJQThlK2FiNXcwSzRWQ2QxNWxmNitq?=
 =?utf-8?B?dmZ2R0VscTlXejEvR1FuUlhRN0NGWFNQSWsvZU9QWXpNSTgrT0s0bmlOODZD?=
 =?utf-8?B?MXJjalVYdlpkNzJUVUJMQTFjS3Q1K0Vwa3RtMWRBa0xQUU9kcWVPdU1JQlRN?=
 =?utf-8?B?cTBCNnRzMG5Za1J6ZTBwSm16QW15eTFCa1AvakVDS1FsLzJ4YWF6c2lBdXhE?=
 =?utf-8?B?TVZ6VlhsNGl3RUx6YzVQVkFCVWdyQ1BMQ1JQRTNzZFJlaVZKSkdFdmxWY0Ny?=
 =?utf-8?B?VkN1dVZIajlSZjU4TVFrV0VBc3cxNXlBdVpiQVJKUDFQR3pDTVQycEUyVkNI?=
 =?utf-8?B?ZjVtekw4OHlJclF5OXU2cVlmUWdDTkd3TzN6OTR6TjFvS3pNWGg4NkJONjYw?=
 =?utf-8?B?WHRTelZmaisxOHVYZFV1MG1NUloySGYzb08yQVRqRUkxdmNUV24zWTMvSE5K?=
 =?utf-8?B?K3ZmaEJucGdtbUc2a0dobmNTamg4ZFRhMUJGZEZtWTVwUXdaU1AySGw3SlVB?=
 =?utf-8?B?aS9qMzQweUdaT1k2c2xNZm9XSkdsdWNieVdmNGlybXRsTXVwT3RKQXJ0Rm1N?=
 =?utf-8?B?NVZ6VjQrSlZ6WW5jZGJlcHpJVUpoUXo4UHlmaThQbVZqK2llSnM2SFNtaDZ0?=
 =?utf-8?B?VkszNHJheTFkRFhWdGFLaDFvL0tpWnBUc0lrLzRSZVo4d2pqbFZCUDFrRmRB?=
 =?utf-8?B?MFNNVHdBN0hhelMxdWhmcWVHOTN6SWVNT0VFTGpIdGQ1UmNCYjhWZ1RMU3B2?=
 =?utf-8?B?UlVzQXNLamRVUmkzd1ROQWhQQUQrVHEra0JRSEdRazBiejB3cUJINWc4OUJn?=
 =?utf-8?B?QkZONTZyQ0ZMcU5VWlUwbTVWYk02WEUrQVg0Qjd3YVdpUERDUnF3MzQzTXZT?=
 =?utf-8?B?ZVNTQmFnMWJsZkhYRVBHRkRpSDFQMC81SlNucTRzV2s3TE52M2dZalFycFQw?=
 =?utf-8?B?bGVjTDlBVXczbGZLUXR1c1p1YklqcWhvaVFzVnAzdkJYY1BlaExRNlltSUl5?=
 =?utf-8?B?QVAzV2pQc0RvRlhLcjVlcGp0QkRUTVJzUGRONm5kaTlWTDRnZTBrT0JmWXY2?=
 =?utf-8?B?K1kxcHZScjdGY21wY0VoTzRSaXF0SkkycVZvQVVwbytZWjhaNEVab09Rekpq?=
 =?utf-8?B?ZGNwU2VQRnlkU0c1Qi84bzk0TEE1N3VQV1pjNWNKVS9vRWgxYXV2dz09?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09040d8b-7cc8-4306-f39c-08dee3d56835
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 07:31:25.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWGzGmbL7zQ5ctq4ALYlV92rrUAhvYLETkdZSqGP5rxsDw2XM5ARMQbA7rwy+F3tHXMNmQFJLtXqzMM4glCysQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11847


On 7/17/26 03:37, Sasha Levin wrote:
> [Vous ne recevez pas souvent de courriers de sashal@kernel.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>
> On Thu, Jul 16, 2026 at 03:12:00PM +0200, Greg KH wrote:
>> On Wed, Jul 15, 2026 at 04:29:09PM +0200, Erwan Velu wrote:
>>> Please backport commit 82d6e01a0699800efd8b048eb584c907ccb47b7a, introduced
>>> in 6.19 as all stable kernels are affected by a significant performance
>>> issue.
>> Now applied to the 6.18.y tree, thanks.
> Queued for 6.12, 6.6, 6.1, 5.15, and 5.10 as well, thanks.
>
Oh thanks for confirming,

Erwan,

