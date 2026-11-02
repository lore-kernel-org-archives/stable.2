Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793621955;
	b=t58QkIQgHNGKD4tf3dMy5XBXft73qwiEjrdHV11IAWXPPLY9bQ/0452W++ebeZuZpniq
	 YnH1IPX78GX5oRpYBdjSrfXIviCk2YeTrWy+0NrhlPhK78mHL+buNkgy4Xuh8PH5LzXrg
	 9IGMOmpo6UefFG5Df2zOjSE6r6yWm4smFeiDamw+PeODjBsUL9syTnJrTPNXYsU3t2URN
	 I+QFrjSuWrKw3mK74pDAoTE+/kbWO9TAYMNnF0cYh0mse3EG1bveVSx/JyHn7GDtGR0cI
	 cNWTtQVS8v4Nt1u34dq0XawGnh6gj35AciN0LCXBd3RcF7QVtB4v20okVYlJ6FAjUxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621955;
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
	bh=9w5x/9fWJ+xck7Z6wUyNqrCOl1Snh0CNogBREiCOhB4=;
	b=oTU3Lpk6vtPCv0On6L5cgXtQVqiZlr3OcMEDpg40TfSqqxUjYMGCpQZI4MtLbGA2y+qa
	 sVF3xkg6hEDOm++bWzBn7xqB0cYey2GlCtBgK8z13rPzUsgNbfNUx1L41Q66aSvlxHVIx
	 kokhqrd7usLnBURPdgLJuooeYxJjKTUOWQZjteVFhhGHrRVk32Z5ssstj+ao136taDmYK
	 4lzjDAWPyj/aKWbDFmZbjFtO/1cDJO3UPNFhhpH7XE4Azum5NWxTcL53DxiosVcMISAhf
	 BPuGdSWdLUQfdF2h2CFmh0OGLVYtBvtrqHlN7i34E03F7UHAjXwcpQGk/nIa/QyPRrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DNlMVaNs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.36
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D0606A324;
	Mon,  2 Nov 2026 12:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A3D0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DNlMVaNs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVtosMOiSyDV3d8+lDfoGE5hAd2Ij2TqT4siwJXNYKxBQY8RaEgLi/hACy0s+1Tncnpl6WCzwmQCpx+a8EJyDPilXC+ZxjsYxji7SBP0MJ4h40jujiqaRSLZ2RTyO/DWMZ5nEbgyLyinK45KWk8Yy2zEzQ3Kak0SQ65I7836gaQ1G2bE1RWQHoYumJgt86kQgLFtcKp3CaOZP7rS+SEcmyhbnyavqaLN2YVM062/tUMwZKqLIpDORK1PXJIZTpnAp4OT55QYuEyKkzsouxyQASXZ2hBFmz0m9tSXhHeTYi+WtG+kcJkQMYwUg99pI8wIGUphqaGUf+470eWlGb7joQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9w5x/9fWJ+xck7Z6wUyNqrCOl1Snh0CNogBREiCOhB4=;
 b=OsOd6SPshRzrYG3q4YygB6AVWQr4sBKfLqdUKc+2Vl0ciRBiIB44M8MmIwB0hD+b3vOfLQGwECOTNjaO5GyDfWt9U5s8ldxpPRARnt4qiryz//qdzeYW6LZMgUrspd4B3vHZQWvbt2MNRUBs23s2tVDgB5B4ODupWbLJY+BF9PnJqXGG14ny3oezVVzaZfkNEn4U17TeDOriA+MgM2ryefwI36RE/43GFQRBIv7qLDx40MGD7EU9083ApeMDq7qR6o/aADK3nzxJmWqgxPIc6Fezf6akM/4o58ctxRC72Iu8/jQCQBxiRYdQBkG6FgMRYmuHthJrwFPCsfZtnbjjIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w5x/9fWJ+xck7Z6wUyNqrCOl1Snh0CNogBREiCOhB4=;
 b=DNlMVaNsTRUkVI3q1Yx1j8yW6+UTxsbsCCCoasGCk7Uy9HpOVOsgo8036fgoNM9wXyehbu2QieR/zPY5JvJkqZqaJYvE+xYJstejVumr6dyeKqnmK95Mbo6hiHQmO2vfKfu6jb+h8ES/+cIBy8pzljs9dBt+aCJe36eCgm/AbsA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by DSVPR12MB999261.namprd12.prod.outlook.com (2603:10b6:8:41b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:19:12 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 12:19:12 +0000
Message-ID: <bb6ac913-6c60-4673-8c67-705f0938df6c@amd.com>
Date: Mon, 2 Nov 2026 17:48:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] soundwire: amd: Initialise and cancel IRQ work
 around manager lifetime
To: Lee Jones <lee@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "N, Poojitha" <Poojitha.N@amd.com>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-17-lee@kernel.org>
 <43cae78b-8a9f-4528-982c-85c0049b1414@amd.com>
 <3f883f3f-221d-4355-a39f-8321f2ebce49@amd.com>
 <20261102093145.GB13023@google.com>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261102093145.GB13023@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25b::14) To CY5PR12MB6252.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|DSVPR12MB999261:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4293eb-8e0a-4969-bf39-08df38db80a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261021123027099003|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	VFXV/WtiiSUumUjauWLEvyqU/nr5tWFxSDQULGsuLcoFHQ2uzuhtcMxk+a2sI0tjLWBEBikPIkXiUJQGW+Yp5P7cWOfaaYd4ym1ZaOjEf/A0jL+T/6kb0LqHYCez8ZDLpy8BPi+ugM724wiYgi8FjjKWuU3+eIfSC6ZrBQVEwd7+yFpgMKVur80HDv0DJxtPPNMsUsBImsA/CE6KKJEnf2R2BidRumCM7Eozh3UR8+SyBfnjXlHM5t9vFAYWs9Y4ukN2uIXc0DFJyKSJA547ieN/aHhi3+TPmm7d1PuV4YKYBUuuPWnOjAMNtakKZivRryiBMlMuxHgB1h93xLkLjYqI/yeMUf4weYuS8LsVrZGt/UKsdf1UOB1bmIDrSAVEHceA5LCZgi5sacleruNFMDp1A0gRVKwh2AIF6D47tbn/nHvT4gp/TlHhhU9ehS7IyDZgsDNS2dJDJjAH69U/FDoeGmnfxgd+2VzBOTq+y9o6eBoiadBFjKJpbKJZHo3mh5nClqPv/oUcoti+4s5eJ/mmDU7IFo5pFV2vXnVt7KSKim4crom7Jv2VSAA8Bcflg4+PxYKRN5mfVtI6OVkqPUV74aOop4vLnHW7U9NZSgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021123027099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TThIV1luZG1DdXQ2bGJEeGZZRFBGYzdFVEdoTXFFTHNVNTh4dXZPOHozeERB?=
 =?utf-8?B?SjE3R3l3MWZnY3lCYzhHWGpBYUtaVU1rLzBUeHh3RHFmSTVPU0g2Z0pUVEIv?=
 =?utf-8?B?ci9ZVGpwTFh1TkFlRWIxdGdnZmt2RkR1UjdlcU5BVTA5dUd6Q25iTWEzakhl?=
 =?utf-8?B?NE5ITlpDdTBqbURzUjRDQVNTWDhubytrWU9lb3RBcHNTUEgwWjlJZEp2dWVS?=
 =?utf-8?B?aXZycnFNOEJOSDJha1U2TDZ5c3drSm9GK0RVRXZackxUQW42MnFDZUFuUzBY?=
 =?utf-8?B?aDIxNGxRRHdPSVMzdjU3ZUFReG9yVkg3NllMSmtKYVFLc2NMNU44RS9DV21S?=
 =?utf-8?B?bHVMNllzUE1HaUljMG51L0hWRDVGeFVrMEJSYWVXSG9nM2krVmhRU2psRkly?=
 =?utf-8?B?NHNmWTRobEFORnFqZ2tFbTBBSjBDUDJLWHV4b1RIWFVablBUU1V1czFjUElJ?=
 =?utf-8?B?U0Q4Tm9aZ0lnUWVtQmVJZ2VLd01hOVI4QzVndnVNY1Iva0NmelpWZkV1Z1hK?=
 =?utf-8?B?N2RyWWxlWm5BNXVsODJMRlBxRG0xdEs0bUlhN3FtR2VNZ292UXJLTVlsQVRn?=
 =?utf-8?B?TTRJcHU5QS9HT1BUOHFlZk1aSG5mYkdtckFpS215dTZLbTBiWDV6Szk4bFpD?=
 =?utf-8?B?aHJCSWFnMXJkVzFWWmJyZG4wYkJYVUtrd2M1RWlOanJNSnZabGJBL1FCaGdJ?=
 =?utf-8?B?MlJmUDNxaEZQNjU4RWVNcnVpVTd2VlJxcVFEWmlSUS9KdWVFWkF4UVVWbVE1?=
 =?utf-8?B?VXpHUDFLZDdhZmRuTnpWSStDS01lNnFXVWQvVGlzajFVWW53V1p4eFpqK3ZX?=
 =?utf-8?B?YlIydTUvK3RTL1BEbGc4TTU2L0IwTWxxRDZNdkZ4T213NTRZK09qTHkvMDJq?=
 =?utf-8?B?dktxMVJmTzRKVlZ4K1NLd2xxV05oSlpOaVFQdHQzOEpaU09QWEN6MmtUVlNR?=
 =?utf-8?B?L1N1UHd1RjJIelFlZThuSzI4ZFhuZnIxd1dUNk10cUxaS0prZTFQWENjd25M?=
 =?utf-8?B?YjBBdmNKbndLY05ZejIxbDBFT2F2bm1KNXJnbjgwdCs4cGo0c0pPL3NyZWZo?=
 =?utf-8?B?NDNmZ1lwOVprMytKekJXeTNEQWEzOUR4Nm1qSjEwK25EYXhGUmovNVZFcnZM?=
 =?utf-8?B?b1hab0EvTW1rZXpyRjlBeElWMkUvZWR2OWdyYVBwbUJzU242TzN5S0Q3RFV2?=
 =?utf-8?B?aGNxUFdDQ2RoSUZQMnFIMUJWcXhIOXc3MmJEWkV6Qis3bFdwcXpGaHdTV0pp?=
 =?utf-8?B?MGR2dkZBZm9jU1l1Q3BmOVFlUDFCSWRxVkZkMkg1NGRwZmE5bG4zc1RjVU40?=
 =?utf-8?B?NXFVSklvOTdTZmxCdk9jSXlRQ0hTdG1kOXhaKzRZU2pYTGo2VEpuZU42czBt?=
 =?utf-8?B?YjBUS1JwVDFRS01LZkxRQk5oUEdQUUZZOWswQzdWemFnZ05mRGc3Vm5xbXBv?=
 =?utf-8?B?Q3FBTERIOXNZS1RpWEhWL29zSEZSRUo5M2NQL2o5d2RXelVTeU1CK2ZEdzNH?=
 =?utf-8?B?VHArMHZ6NGhLTDVRb3k3azBIalJkNml3SmNNdXhFVERaZnZGTjdEdTJaR3dG?=
 =?utf-8?B?OUFxY0NweEc0RVR1QVpoVDNXaW5YdWl2VVM5SzI0c2tOdDFiUHhsYWxlejdH?=
 =?utf-8?B?WHR4dHFQRGt0NzMrOFZyNTA0N2xnenJGaWdmUWs0b1JWMTJMOUdaQkx1Y3hU?=
 =?utf-8?B?Rkd1VDFrc3NuU2loNEl3Qkt1ZTVlVDU3OTUzZ1ZJbVhsYnlIaDRSTG5aV0Rw?=
 =?utf-8?B?L1Y2K29ZdjZVdUp4aFVyZXF1YUtnRGFaU2FiWTdETS9IK0NYdVlORER4eTUz?=
 =?utf-8?B?aGxNZTc3VjZvSGpvV21UUHZFenRSbEJpei9IYTJvT1E2ZnR1U2lqZTVHczBV?=
 =?utf-8?B?bjBOK1FrN0dJNjY4QWlRd1Qxc3Z6dERQbTBka2RVYmJ1Rzd5QSthNVdicENC?=
 =?utf-8?B?L3JrT1dPdU91QkIzTERlbUNacUVvK2EwYy9ydXlvK29kYngxVlBVNmNVeDBG?=
 =?utf-8?B?NTJiRGtCRFBsMFcvNm9iOHpIWjlhT2wvM1dTVXBLenA2RGRudlluMFVURHo5?=
 =?utf-8?B?bUYwVER6em9hVmgrczFPV2xqUzZmenpwR2lLdjhYNWhodDNPUVRGbGFxVjlG?=
 =?utf-8?B?ZWhrbUszZzNlQTN1b04rbCttM1BSVXNBalJKQWt0c0l1MGxxOE5ubXZMQmpz?=
 =?utf-8?B?clNyQ3dmVFIyVmNISGlKV1FwK0R0VVU5RVMwZHp5ak9BVTcyWUtTMjRESDRC?=
 =?utf-8?B?QXhFd08xdE5LWVR6M0NzQlJ4T25xSVBxbjRXR3ZQbEM1VHc4OGtVVWxjQ1BG?=
 =?utf-8?B?TktqdDlQWnFjOUgxTU5BUHZyeHRFUGNOOGNCUmdvYkxRR0hQZU0wQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4293eb-8e0a-4969-bf39-08df38db80a3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:19:12.0720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxl6mCt0K+mxRDboSlfIE3Wy2w9tSqfHp6pjyOlbQwK0ulImRUTS2RakqI7gMxMihqPNiURv/eRBV/Ce+hOrNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999261



On 11/2/26 15:01, Lee Jones wrote:
> [Some people who received this message don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Fri, 30 Oct 2026, Mario Limonciello wrote:
>> On 10/30/26 07:13, Mukunda,Vijendar wrote:
>>> On 10/30/26 16:16, Lee Jones wrote:
>>>> [You don't often get email from lee@kernel.org. Learn why this is
>>>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> amd_sdw_manager_probe() publishes amd_manager via dev_set_drvdata()
>>>> before initialising amd_sdw_irq_thread and amd_sdw_work, allowing an
>>>> early interrupt to schedule uninitialised work.  During removal,
>>>> amd_sdw_manager_remove() only cancels amd_sdw_work without first
>>>> cancelling amd_sdw_irq_thread, allowing deferred IRQ work to re-queue
>>>> amd_sdw_work or dereference amd_manager after it is freed.
>>>>
>>>> Initialise both work items before calling dev_set_drvdata() in
>>>> amd_sdw_manager_probe(), and cancel amd_sdw_irq_thread before
>>>> amd_sdw_work in amd_sdw_manager_remove().
>>>>
>>>> Fixes: 65f93e4096a0 ("soundwire: amd: add SoundWire manager
>>>> interrupt handling")
>>>> Closes: https://sashiko.dev/#/bug/linux-9890e8dc-4b7d-44d3-
>>>> bfb0-171dc421e28c
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>>> ---
>>>>    drivers/soundwire/amd_manager.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/
>>>> amd_manager.c
>>>> index 98b09d81f3b8..2e1038ea0f36 100644
>>>> --- a/drivers/soundwire/amd_manager.c
>>>> +++ b/drivers/soundwire/amd_manager.c
>>>> @@ -1185,9 +1185,9 @@ static int amd_sdw_manager_probe(struct
>>>> platform_device *pdev)
>>>>                   sdw_bus_master_delete(&amd_manager->bus);
>>>>                   return ret;
>>>>           }
>>>> -       dev_set_drvdata(dev, amd_manager);
>>>>           INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
>>>>           INIT_WORK(&amd_manager->amd_sdw_work,
>>>> amd_sdw_update_slave_status_work);
>>>> +       dev_set_drvdata(dev, amd_manager);
>>> The probe-side ordering issue is valid — an interrupt arriving after
>>> dev_set_drvdata() but before INIT_WORK() could schedule work on an
>>> uninitialised work_struct.
>>>
>>> The remove-side fix is already posted as part of our v3 patch series:
>>>
>>> https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-
>>> Vijendar.Mukunda@amd.com/T/#m60177687bb84758efdd6f5f09eba8ad32f0e4631
>>>
>>> The probe-side fix will be included in our upcoming v4 patch series,
>>> which contains major driver restructuring and customer-critical bug
>>> fixes. Merging this patch independently would conflict with v4 and
>>> complicate the review process.
>>>
>>> Could you please drop this patch? Both issues will be covered by our
>>> v3/v4 series.
>>>
>> Lee,
>>
>> I think as a general statement since there is still these big pending
>> changes already in flight, could you either wait a few weeks until they
>> merge or rebase your series on the in-flight version to see what still
>> actually makes sense?
> I will leave the AMD driver alone.
>
> Please be kind enough to add my Reported-by for any issued that you fix
> as a result of these reports.
Sure, thanks for reporting these issues.

I'll make sure to include your Reported-by: tag for any fixes resulting
from these reports.
>
> Thanks.
>
> --
> Lee Jones

