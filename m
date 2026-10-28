Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.100
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793176306;
	b=Kiec28AJbOL/IAhgwXVnTUZCM7DhIq91mZwEqMDrI3pY6aprvVJq0LoLtX8pqjklkFHu
	 N1TMYPkzRVTNtjyBIui7NnE298FSAJBV8TKE+un+F9J6knHUEWc4CmVkhdqcvKwmANsT8
	 i52f4CL6bbubugJUj5Hi7xBwboU1jCxTN/99UvWGZqloT3TD3eXvhG0e22yhpmgUIrKmX
	 53HV1sfUOHP6HqQ+GbqYX8xK1D5Wdl+yaJfBneO8c0hhp7H0PiWGcYHYEf2vJP+Jfss2E
	 QT4bU7T/oVoebgGcv4liV1ZflHydbNdbyFlRYGOIZdxZHd8x9yEuB8C8RcXgI58vMaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176306;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:References:X-GUID:X-Has-Attach:X-Mailer:Message-ID:
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
	bh=R4bIjafVqnefoqWfOirnIk9YsJMgHot7UIhdQImgnPk=;
	b=iJcMmBKzTJCvaLWtQCJrgfXbAct3UxCAV6jWsEVANtwzALlKqdI8A0iOe6yOZO3EC4jS
	 PEl19uLW+DemI0YWWQPdLshU1iaBlyA7IcJTDKOqloEhziTZIOx+zpCMDbGYdW5H0GUBt
	 O1R7kXZzcVGNMk9KFy0iWHwpOQBkZGvn6nvUcnzVp4ULn0ESVqftSwLD4TEIuf4yMjArG
	 tLsbfuXlHal9xUn5oNfBMZsB2/e8RzVYW5ijIfsJojz9nIiaDd0j7tISl5EiWijufdCDe
	 i+yisJ/yccYg0ksyBGIBpSuXOgAnS6+ed0fQQ6F7K6MhVbGC6QCTg+IfuLdHXp85gBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amlogic.com;
	spf=pass smtp.mailfrom=amlogic.com;
	dkim=pass header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=D8DBxkcX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.100
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023100.outbound.protection.outlook.com [40.107.44.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC87E606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC87E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amlogic.com header.i=@amlogic.com header.a=rsa-sha256 header.s=selector1 header.b=D8DBxkcX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbO40rcVSv/ZGQIwkCF1myWDVWW4P+5EeQ0MO/f8mQSsOHLgSXMp0jShwsZ6rV0c0Ojyzf0qEduSfZ85SPncb1xY4PVIgEH/UelZdYpqpdTbibQ5HhcqKioTdQO0ssI0R2qBy2z8VZCQuu31N3Aeh87Mr1vPohEYEvfH7r2v0sZf4iA+Z9LvkgPXkZ30mFOP/mq/fGMYYU++3pnCSV1eAxkIRumWeZQj8/nN5TeK2YRp0H7YvY/qY9GpUM4CuyuSphbi181p1h7e7AM+CdIQrUKNYpeL6wFqiLqKS28N+xs4NleVPPknjSwnBz1XulvU2UFwlTMnVkWBDHfDNuXl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4bIjafVqnefoqWfOirnIk9YsJMgHot7UIhdQImgnPk=;
 b=GqLSa26PZ/+0imkIclgnIApyxUz4tRyJjwjabHgws+iNM6/Au4Y3OufEvAf0v/K/fOFUbh6Pe0mLEIqRJfZ9xPZ16Z7tkHYtKIaSkV3wBRZ+YMqpMlFaTNB1tIY721PheHpFo74AIZ9OA//kOW9NChXAJqGtY5p5R4GpVDpga+vrUaZH46TieKXF9O/d/7ZbxIfGvnt7RcjAyctrSIE4qzSqsltuGXuisHyb7MN6PGW/o/We6id+5iBVXUl5GDjXsMtE/O9xLMjPngHM9xihWWQckgZsb97njcIlUgXx99OEwVm+4mbxX7nO04h3SvHv3qCyXTXoMQTtI3jlpEykHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4bIjafVqnefoqWfOirnIk9YsJMgHot7UIhdQImgnPk=;
 b=D8DBxkcXWpTpwcIthRRL68l8aKL2kRTrfQlXrrmsiSx5fG+ut479BaA41u1SQHTL3YAmrwkg+IAlyAcWYRZeLaAISNnkya/0ebpZg3UXPLx2XRt9isYQo3NdvJFB4+0h35IdcAXrwdDxAkDm+igzNqabmL40nulbyQn0nbOwEKikr5vJlR0VdTpJtey4j9V8zxTQZH5PcWf+4hmyi50AoLqFXYiE3IIM2KQvLKDNbYamfrDkRwbQPQJi11YL3cic8eW0aDkVcSbdYV+KzzpbigJ6VCMAGOtdcrlA/ha92TnQG2MgXXJ8MvBAqCOioL2wIRu/S3eK1pqx67rPQw0YwQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB7459.apcprd03.prod.outlook.com (2603:1096:400:3ca::11)
 by TY8PR03MB10449.apcprd03.prod.outlook.com (2603:1096:405:3ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:31:42 +0000
Received: from TYZPR03MB7459.apcprd03.prod.outlook.com
 ([fe80::d306:36de:44d2:3a3]) by TYZPR03MB7459.apcprd03.prod.outlook.com
 ([fe80::d306:36de:44d2:3a3%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:31:42 +0000
Date: Wed, 28 Oct 2026 16:31:40 +0800
From: "yao.zhang1@amlogic.com" <yao.zhang1@amlogic.com>
To: sashal <sashal@kernel.org>, 
	gregkh <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, 
	tuan.zhang <tuan.zhang@amlogic.com>, 
	jianxin.pan <jianxin.pan@amlogic.com>
Subject: Re: mm: call the security_mmap_file() LSM hook in remap_file_pages()
References: <2026102716561458946426@amlogic.com>, 
	<2026-10-27-1-daily-reply-0001-remap-file-pages-5-15@kernel.org>
X-GUID: 6B7A9A34-0FE8-4C0C-9ACD-954B2EFB6709
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.213[cn]
Message-ID: <2026102816313856114725@amlogic.com>
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: JH0PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:990:78::26) To TYZPR03MB7459.apcprd03.prod.outlook.com
 (2603:1096:400:3ca::11)
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
X-MS-TrafficTypeDiagnostic: TYZPR03MB7459:EE_|TY8PR03MB10449:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d73b540-c60e-45d1-38aa-08df34cde500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|261026140227099003|56012099006|5023799004|261009223027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|18002099003|261026121527099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Vmsh/w5ag/iB1obo73Emi/7jlFcvFnRvD7Rp49xzAT0Srh9oYMtcwjkrJFq33+0a3AWTiLJ4aNQ9zyWNH4YMRfxADRI0afgdhF7EIIfaEX23royZn/eOzBuCID0SUJzFiuiBbKXPlAaPHKrs6OStMHXHBu77WlbBTJ5y53dNJ1B9iZ/WaL5fsxPFjkCL2+5RHo22RJmx0OWjJeGin5/lawfcK8qFpZggA7MfBHRf0RQa9svoxHuycBbw1YDTS/9aTQczsAACojzrioZZuO81Igaat36shwxNQpI25+B74+DMSZ8lH8ZPBE+4qFDWqvH1u52juuc2Zn9IITutqBzuxaMu/g3NNnThLJPmyQXRWjOQIGGu68SccDtY+1lyV0hQUMjtipkuzoWbixI7q4Qlfmoh3HB8I8kZko7lDxiLacSOvz//y3JSW01qxj8haujzIv5qkWRLedykBFY0Tr1HR4x+bb2Mijn9Xx7E430QONDjf+0QF+47KILxaQeDZl+O3AX1+supipftKZroU5Wz1BljhhRcUg+B8tHtFJVCqSUOWPb2iTjX02BAAiACdy8Kjy/qmoTUVrZlbM32qocW/Mb3+Mjllr5Gm77bRohMAz0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7459.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(261026140227099003)(56012099006)(5023799004)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(18002099003)(261026121527099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejdJbUNTMEw1WFhEUUtNNFlpcDgreW94ajkvK2FGNitXTTFUWWplOWwvZ08r?=
 =?utf-8?B?Y2puR0dxbEw1ZHI1M2xIUUdvRkFGZEFHN055L0ZGQk96UlQ4QTBtbnp6OEEr?=
 =?utf-8?B?S2NuajMxNFFCQVdyV2RudjRjSVBrMUsrTTR0enV3VVFPWjVlbWdncXMyM3o0?=
 =?utf-8?B?QWVDOHJJblg5RHEzeUtkdTFhSWl3RnNrN3FVUXFOdElNOWE4MGo1QlQxbktr?=
 =?utf-8?B?THNPRzNrT3RCNTk3dFRsQmQ1MzJuMHgyekhuSFNJVFJBa1p3bkU3NXJnNnE2?=
 =?utf-8?B?V2dCeHBoZXMreG5mdDl4dkJRcERkOHVSeFJFd05JeFhSN1YvQU5VWCtRRVZ6?=
 =?utf-8?B?L2xIaWdGaEE0dysrTTJJVW5KUHl2SWhUWGNUSVFZNWNLN3ErWkpQUjdLY1VC?=
 =?utf-8?B?bzh0TGtPMEpCZTREVHRGUStpZkVOcFdsamdiZVp3dVArZXk3a0taRi9jYWdJ?=
 =?utf-8?B?SEZhRWdzNGRKancwYnk2WkxZVTVWV3ByanlEUlBJU1JWQ2VQUE56dEE0OGh6?=
 =?utf-8?B?ZzMwZjliM3l4ZnNmMkhJK1FJYmJabXpteGJPNVdMRGxGUHhhRUsrNXU1eFFu?=
 =?utf-8?B?MjROYkF0OTh6eE5kY29zT0luYXNWUnlaNGNPdFJIZ1cwcTFOTXF2ZkJLTDBx?=
 =?utf-8?B?VWN1N0txcHVJRlZiOUhTZUF0aFArMUdMMzloWXVmSmlKa2hJTVVlWHVZWC9X?=
 =?utf-8?B?ak5QNFlnWWFYM3hKY3l5cTl6Nnp4VmVHaWNNcEJjSmROZUp4ZTZpdmVoQTV6?=
 =?utf-8?B?a3dkcUZPOUlwYXE3YVJlT3lhWjlyeC9lUE41L053QXJWUmhCM0xDZXljNnMz?=
 =?utf-8?B?WGk5TkFtQ3d4bnAxek1ueURHNXFYR0dEcjlKaTY5cEpQcVFGRC9GakZBRjlS?=
 =?utf-8?B?U1crWldYVTlzR1JiVkJQeXhtZm9XY094cmF2UXFweEdKMzZwRHVPUVZyaUlY?=
 =?utf-8?B?RHdWYnR0aVI0eGIwV0o2V1RFTWRxMFUrZTh2dUFTYk1idG9iNi80dmdJZk05?=
 =?utf-8?B?TG5mM1hQSUo1dE41bklyVzlraFVSc0VBT0swalg5UEZCZGZDOGV3Z1hkYUhl?=
 =?utf-8?B?M3ZIeFhnaFg2MHpvVE5OK3pMNGRPdVZUcmkzeGw2cnc0LzJuZ2gxT3hRM2sy?=
 =?utf-8?B?Y2I4WlNTa1kyVEVMVWlFaHg0a3F4LzhJNlBVUE9xQVpqZzFMazlVNFkwSlNP?=
 =?utf-8?B?cGJpcnRkWHdpWC9pQVlKR0tOZ2xJNUtZYzFHancwdGFxRWFjVWYxVE5KOXFk?=
 =?utf-8?B?RUVUeHFZT3JWQVZZbDdjVzNBY3NRZ3NtRXBnaFZEVnluNzI5VEtMRkgxQk5y?=
 =?utf-8?B?dlRLVkFYMCszaEcvd3R3dmUwMGpLT0hVZzc2TU9ZTHdsYUlYYlNXd0l3c2V3?=
 =?utf-8?B?Y09rTlhnc3FiNGg5YnkzdmpBdEZhemgwTFB6Z2hzaitXc29vc0pBOFhWR2hF?=
 =?utf-8?B?ZEsrNys0V081VFRjWVJmbGVDdlhPSE83SStRQ0FJck9yUitXL2Q5cFgwNDhR?=
 =?utf-8?B?VXI4R0FlMy9kS1kxNEd0NVhjMUJ1T2kyZmhXdnBwT1dLdlRCampMdnRaTlRF?=
 =?utf-8?B?WUI0TE5naFR4R3hzdndNOUlvK09pUEZSNUxtamZ1eGN4ZkE2VVV4alpIVlAv?=
 =?utf-8?B?SzRCREFSWUF0RitUa3JMMEY3MmRIekJ5SnRQSERCc0ZoUGRsdVRVc0h1QWFO?=
 =?utf-8?B?UHI2Q3liSVl2dzl3aFVSQ2k3THRzdXFKUXFFMloxTTVTSC92SEJjRUdDSklh?=
 =?utf-8?B?YjUyTVpDbnpRTXBhcjNsYzhwY3g0VGkzQTl5cUJMTG5ZbDhERWdVekJhaXJU?=
 =?utf-8?B?UURzT0VtOXBrTUk4VmR1WXVrM3dnckhWWU1mbVFKUWZTdXVZemtFTXF4YVpx?=
 =?utf-8?B?ODFXSVVhZ1dieUZONDdKeDJ0VUtpL2dkanFLeDYwUzVReEhtNkdZVnZOMkhT?=
 =?utf-8?B?czVWSHA5QmlDdDY0Tk5TcE8reEM5d0pLaGczYmRmME5OdWtiUmVRais0RTN6?=
 =?utf-8?B?dkE5NXE1MFlZeDM4YWZJeS90R2t5Qi9ySUNnSU4vOUJHaUtnRjdnSTV3L1hq?=
 =?utf-8?B?TUFOQUMveS9sV3c3eCt3aXU5Mm5UZGF0WHkzRWRLeWw4dUhYeXdmSmdkRHlZ?=
 =?utf-8?B?UzhiMjZSRnI4Nm1ZbE9VVTNhUzFSVFZURkFObHlRMXJCbm5kdThRcHFscWJL?=
 =?utf-8?B?S05uYWZkMllGNHVoWlo3UThPSEN3TFhuNXR5OXN5eGJIOXlCUHhyUE92Qjhp?=
 =?utf-8?B?bWlwVjNkS2cyeEJCZWYrVjVZYXJJbnB3VHVQbWZqVHZPM1dhdnZCNUprZHNP?=
 =?utf-8?B?cUx3eUFtaC8rQk00TWdOSmE4bHdzTHh4Qktya0hYMzNzYmIvM1JBdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d73b540-c60e-45d1-38aa-08df34cde500
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7459.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 08:31:42.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j8w0Eyzd/S7KCw3r4uxuKgsTkIevUeu+saArNFL3+tpubnqqegVU/bjD1Tjs9ipbNV2M5sTE+HRIOUhPKESSSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY8PR03MB10449

SGkgc2FzaGFsICwgZ3JlZ2toCgoxLCAgQmFzZWQgb24gNS4xNS55LCBJIHRlc3RlZCB0aGVzZSB0
d28gcGF0Y2hlczsgCnRoZSBrZXJuZWwgQlVJTEQgc3VjY2Vzc2Z1bGx5IGFuZCBrZXJuZWwgYm9v
dHVwIHdpdGhvdXQgYW55IGlzc3Vlcy4KCjIsICBTdWJtaXR0ZWQgdHdvIHBhdGNoZXMgdmlhIGBn
aXQgc2VuZC1lbWFpbGAuCmVhN2UyZDVlNDljMDoKTWVzc2FnZS1JRDogPDIwMjYxMDI4MDgwNzE5
LjE4MjEtMS15YW8uemhhbmcxQGFtbG9naWMuY29tPgoKNThhMDM5ZTY3OWZlOgpNZXNzYWdlLUlE
OiA8MjAyNjEwMjgwODA4MzUuMTg1Mi0xLXlhby56aGFuZzFAYW1sb2dpYy5jb20+CgpTdWJtaXQg
dG8KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvc3RhYmxlLwoKClRoYW5rcywgCgoKLS0tLS0tLS0t
LS0tLS0KCgo+WyBFWFRFUk5BTCBFTUFJTCBdCgoKCj4KCgoKPj4gSWYgdXNlIHRoZSBvcmlnaW5h
bCBjb21taXQsIHRoZXJlIHdpbGwgYmUgY29uZmxpY3RzCgoKCj4+wqAgdGhhdCBuZWVkIHRvIGJl
IHJlc29sdmVkIG1hbnVhbGx5LgoKCgo+CgoKCj5UaGUgb3JpZ2luYWwgY2FuJ3QgZ28gdG8gNS4x
NSBvbiBpdHMgb3duLiBlYTdlMmQ1ZTQ5YzAgKCJtbTogY2FsbCB0aGUKCgoKPnNlY3VyaXR5X21t
YXBfZmlsZSgpIExTTSBob29rIGluIHJlbWFwX2ZpbGVfcGFnZXMoKSIpIGNhbGxzCgoKCj5zZWN1
cml0eV9tbWFwX2ZpbGUoKSB1bmRlciB0aGUgbW1hcCB3cml0ZSBsb2NrLCB3aGljaCBjcmVhdGVz
IGEgbG9jayBpbnZlcnNpb24KCgoKPndpdGggSU1BLiBUaGF0IGlzIGZpeGVkIGJ5IDU4YTAzOWU2
NzlmZSAoIm1tOiBzcGxpdCBjcml0aWNhbCByZWdpb24gaW4KCgoKPnJlbWFwX2ZpbGVfcGFnZXMo
KSBhbmQgaW52b2tlIExTTXMgaW4gYmV0d2VlbiIpLiBHcmVnIGRyb3BwZWQgdGhlIGVhcmxpZXIg
NS4xNQoKCgo+YW5kIDUuMTAgYmFja3BvcnRzIGluIEZlYnJ1YXJ5IDIwMjUgZm9yIGxlYXZpbmcg
aXQgb3V0LCBhbmQgNi4xLnkgaGFzIGNhcnJpZWQKCgoKPnRoZSBvcmlnaW5hbCB3aXRob3V0IGl0
IHNpbmNlIDYuMS4xMjAuCgoKCj4KCgoKPkkndmUgcXVldWVkIDU4YTAzOWU2NzlmZSBmb3IgNi4x
LiBGb3IgNS4xNSB0aGUgYmFja3BvcnQgaGFzIHRvIGJlIHRoZSB0d28KCgoKPmNvbW1pdHMgYXMg
YSBwYWlyOiB0aGUgb3JpZ2luYWwsIHRoZW4gNThhMDM5ZTY3OWZlLgoKCgo+CgoKCj4+IDEsIFdo
YXQgaXMgYSAidGVzdGVkIGJhY2twb3J0Ij8KCgoKPj4gSXMgdGhpcyBmb3IgdmVyaWZ5aW5nIGNv
ZGUgQlVJTEQgYW5kIGtlcm5lbCBib290dXA/CgoKCj4+IG9yCgoKCj4+IFJlcHJvZHVjZSB0aGUg
aXNzdWUgYW5kIHZlcmlmeSB0aGF0IHRoZSBwYXRjaCBpcyBlZmZlY3RpdmU/CgoKCj4KCgoKPkF0
IG1pbmltdW0sIGJ1aWxkIGFuZCBib290IDUuMTUueSB3aXRoIGJvdGggcGF0Y2hlcyBhcHBsaWVk
LiBJZiB5b3UgY2FuCgoKCj5yZXByb2R1Y2UgdGhlIG9yaWdpbmFsIHByb2JsZW0sIHBsZWFzZSBh
bHNvIGNvbmZpcm0gaXQgaXMgZ29uZS4KCgoKPgoKCgo+PiAyLCBIb3cgc2hvdWxkIEkgcHJvdmlk
ZSB0aGUgInRlc3RlZCBiYWNrcG9ydCIgdG8geW91PwoKCgo+PiBBcyBhIHBhdGNoIGZpbGU/CgoK
Cj4+IG9yCgoKCj4+IGFzIGEgbGluaz8KCgoKPgoKCgo+U2VuZCB0aGVtIGlubGluZSB3aXRoIGdp
dCBzZW5kLWVtYWlsIHRvIHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcsIG9uZSBtYWlsIHBlcgoKCgo+
cGF0Y2gsIHdpdGggW1BBVENIIDUuMTUueV0gaW4gdGhlIHN1YmplY3QuIEVhY2ggY29tbWl0IG1l
c3NhZ2UgbmVlZHMgdGhlCgoKCj51cHN0cmVhbSBjb21taXQgSUQgYW5kIGEgbm90ZSBvbiBhbnl0
aGluZyB5b3UgY2hhbmdlZCBmcm9tIGl0LiBTZWUgT3B0aW9uIDMgaW4KCgoKPkRvY3VtZW50YXRp
b24vcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLnJzdC4KCgoKPgoKCgo+LS0KCgoKPlRoYW5r
cywKCgoKPlNhc2hhCgoK
