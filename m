Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794821531;
	b=a4goI4VFV76nQaWlLbMZES9ECpNRt0i8qq35VYdMUp6tnBik/FSeF+5i+qg7S8YWIjMU
	 bFctuqViML/euoNS+7w9HK6L77Lpsh6J1DfCxtdqJwjKngkVsWzpOuBzIBpaehxZb9xqW
	 qOMPKvvuAtXYBdn2C+hQGZ6dfmND4s5jD3/Y5n6iboluSgZ9KEoIK2k9zw3miEZ2Da6dH
	 obK55ODG9PhXxQz5Q8/3pc/yU6XvuRT1Oi4ZMMxMTYtMw+g6yPs8yDgPllpVIBXcgZijW
	 WbU9PZP/IJyXXm1bmXumz073sHOYf9yU6+BUAwYvi32Gh77Dj7s/MTI5zjFVDw+Nbiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821531;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID;
	bh=EOj4J9A/o+UnXqFhDoaL5eluy6IVnqKj2/vGc/QNMI0=;
	b=TgzTxp7nEWORXqYXvcG6rN7+d+p7NkTXp//IlMgH3I9za1kDGQ4XeCDfFMSlSqwSczHN
	 KfokEwjl0PSEI7z3cZc1VldF2hnHZ1nAuJyDmwt7axDLgwlNAxrHBKRA28CaVMk0T56F1
	 Gp5BrpoMAltzDww1IErzjsakzTa+DUk83swCt1frdDXmbnNBIhuvypK/9/woMS+J40Tr7
	 ZcGj/5f7V6CdmdzqwOn/n6pnFXPBw3gfTAponM7hzP2zJLg+9etpNBTx/q56mr499zC8o
	 0wdm9ccnMK6RwdEXcN+FFnmXZdpd6eLwbypGs8LG2jlFgKCeZs3AiKomqGEnLP3puyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=oM3bmLjc;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=oYrlN7vn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B00606A329;
	Mon, 16 Nov 2026 09:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9B00606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=oM3bmLjc;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=oYrlN7vn
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AFNqLqk3818958;
	Mon, 16 Nov 2026 09:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EOj4J9A/o+UnXqFhDoaL5eluy6IVnqKj2/vGc/QNMI0=; b=
	oM3bmLjcuvYv60YMniHAYSu6B8mTOzng0QooszyicQBTBv7MEt3CeRENq2nRdMfN
	OvwFdCsFMlPz0unlgpzgfH3W9x4JiQKpjDY4IMMcn+zf5cLqnL65K3QMnK7VW4wo
	WLxbPLusjhtJapmvR5VcxrA8vDtWbZ7tgZpBhFjlf/uCuAH0RGXGjbb5JVyzOAmU
	p0Nvf7+pHkuRA6QmNBiG9PZkFpzRfVqk2yZZZ7w5/YP3S1zWX7CPTeIiOrrH/NRX
	wxsbJL/DJSb9bnvVSProIUWKO+c7W1Iwh+aL44q9IPpHD6WXJXbQVVtXjJw2K1XA
	S5nHpWhGoIyvDYky+Z04ig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hxe81hqxv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 09:31:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7ccD41550491;
	Mon, 16 Nov 2026 09:31:37 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hyv5sxnh2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Mon, 16 Nov 2026 09:31:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmOtIvgX4FLNFTV5tf9ZwIi7aCYbuqXl7dLlyESFObSHJk3V5QlsUrlAfm2M5XEtPQjh/uSp7d9yosslQAcidvsJf80OJAQF8nnIh/gSke+7LSabQDepCZYxQXMRgrm1n0xD2wCYrz7pkmTU68wU6qk1CLyEuiVMQ6VAb1TM89gwfYukMqPS87D2efUqowoMyhjEBC0Ig1+Fsr16KuexSnPaP+6rrEFG3bhJbtpjOcET0Avrx6oQmda1enFd7VWWW6koTGEIWl25a+k58Z5gsj8ced+9RmLpBoKbimcAQJ/4FgjdQCgNg6Go1i/+W0bqg62xphNahHKZbQQPKK2Wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOj4J9A/o+UnXqFhDoaL5eluy6IVnqKj2/vGc/QNMI0=;
 b=DBHfPXRRSIJfK6NQUOgYyDwAsYVP8ivVGznUlkhQOtCnr1/EAageGIObe61h1m3s5f2iJ9AyGv1lKTgNGGfxy6eQdIh3q8jN6v35AZtYWnjZH1e6XTp3Dun4DlgcfeB4s0U/ak4/gmbQoypPKm9E4K5+PEwOg2xlxPv0HSBHwn1k9Oafn/TiIcmNv9O3H3g/5RCSPTI4HcBlcziEGWgglobMVWpuPT3vNjm31jLpMBOJI1RxBDNJFDUWsOcxsGerye3l0EW2TqNTLtcTYqNrJFstItK6SOSIhyVZmOHx72Sobs0dAhZxqFKnzpb9sDaWHJYbe9WgrPLOK8hWYJSg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOj4J9A/o+UnXqFhDoaL5eluy6IVnqKj2/vGc/QNMI0=;
 b=oYrlN7vndeVBGdEs+0AcqRTBjhHEU++MkL4AZyx6vZ35UUvfH7x2Ro+7kOKWKzCr6LJxG8NhC2L155Z00Ws3mDZ3kHlir5YaxKn9/ZtFgLGl30rqo86Nu+UfFxBr1glTGXo7YVgSqiQRRvGhQDfqsf9/S6N8eIU3BL/KcfRIhjU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB5834.namprd10.prod.outlook.com (2603:10b6:a03:3ee::16)
 by CH3PR10MB7929.namprd10.prod.outlook.com (2603:10b6:610:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Mon, 16 Nov
 2026 09:31:34 +0000
Received: from SJ0PR10MB5834.namprd10.prod.outlook.com
 ([fe80::2444:1d33:3ce:d83a]) by SJ0PR10MB5834.namprd10.prod.outlook.com
 ([fe80::2444:1d33:3ce:d83a%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 09:31:34 +0000
Message-ID: <e258c325-4b4c-4738-8de7-733da90b532b@oracle.com>
Date: Mon, 16 Nov 2026 15:01:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 6.12.117] CPA detected W^X violation:
 0000000000000121 -> 0000000000000123 range: 0xffffffffc0477000 -
 0xffffffffc0477fff PFN 109c1f and WARNING at arch/x86/mm/pat/set_memory.c:665
 __change_page_attr_set_clr+0xf62/0xfb0
To: Sasha Levin <sashal@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski
 <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        regressions@lists.linux.dev, Salvatore Bonaccorso <carnil@debian.org>
References: <avdb9EPXBv2hRCzQ@eldamar.lan>
 <draft-agent5-0008-re-pat-wx-regression-612@kernel.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
In-Reply-To: <draft-agent5-0008-re-pat-wx-regression-612@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0136.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::8) To SJ0PR10MB5834.namprd10.prod.outlook.com
 (2603:10b6:a03:3ee::16)
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
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5834:EE_|CH3PR10MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: b8957b99-3fc7-4fff-7f57-08df43c467b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|261102123227099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HogYQa6VsA5uZxTrb+vJl8NJ1LRO+tpGCceVnPodq8yWUYVhacy0crz5BY8hokfDhveWjlYekYnUXkvvxK/F3bOV+B/oU/jDDyh0RQ4YWJHiu8TnPohSn7na1sjk/ti16bCbjXZjXedXaedLxnjuuV8UCo13RhAkMnJLBWZIprwHa2QkoJgXdhFYrZ24WDUwuWlGlOfi3swt25O4POLVUmejxFU/S9EWhV0tnI5dRK98iF0UTWSXkdepQg36aG9+19Lh0u6Jv5jcKNltszNHN7WMJZq+Ww6mJqyeFSG4owxCoAh4bIZE/UWzWix5gee9CffEpaLtBts/Ukkelu6fO7ZBSVc95szMoPUyiEdkZbsZ4995Oi8ScUgeGTVIZqn0jXx9nKmYcQ0ygBOaHr3of4/h7V3tXoopoFwwPSKCa2qGxrjyVgeeCsz+7eVbufV7ulDgsNH88gn9es0cxZ7LHfbxZt6L1RrjWhb7zeKHYQGlU+bMBsFuL8QVAWQQOYBhSNQLu9tgegDV3xs5vqC64DjvpDWctxzIBC3yGVDjNeQS9E279B62g3TSkqy0Tv2qbNRY2X/lp5qroooBYMWazfJ50P/0ZN9oME/Hvj7uOWs/VT6G2TTVHfSvdwzmb41mphr3JiwGAskTkq8I0+VEEzoXWR+S9vyiyGSupJ9kPfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5834.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(261102123227099003)(261021121427099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnBHVmNIWC91dDFiMFRYR3FkNzhnZWx5SFg3QkVYbE12VU52amwzb3JZck5i?=
 =?utf-8?B?OHVJc1FnYy9FWWpPSTVVT2VoVnFZbXpNNGhPeno0VXRBeHZOMDlSMklkSjFr?=
 =?utf-8?B?WldLOEVBZEwxUVZGZTI0RmhhR1BCT0Q5dWtVbWYxc1k0Sm01bkYyQkNXbHZh?=
 =?utf-8?B?Ylp6WUV4QjlaazE5Y2wvRndwLzFpNnFIdCtHbFZLUWtaeHYxanVGdGRRU3Fo?=
 =?utf-8?B?aDVRYTgvQmIvTTZBaXV3T3o1aVVzRFNzclhZbFdvSUF5blNVZGYxOEJZOTBo?=
 =?utf-8?B?Y0htY1ZBN3FqMVJCM29vT0ErVzZLaWxtQjNNVXpoYUYvZG5rSWNoQTZLODRC?=
 =?utf-8?B?aWp3dkFsMGR5dSt2blZESElqejdnOHdHVzRxNjluczVZS1dNd013SFhHSHUv?=
 =?utf-8?B?MnJtdlBqaWNBc2VBRm8xSzY2WGdxUlNVWUpYUVZTbUt3Q0lWak1ZQmVqbURm?=
 =?utf-8?B?aVVMVUN3VXNBa1Y4emd0SFd6Z1U3QlgzblFhZndXVWJpTCtTK1ZLNVlzTzk0?=
 =?utf-8?B?dS93SFNNK2tRTHd6OHFZZlBOZlUrU202WWhFMC9hK3NWVkdOUHJ5cXV6WlFh?=
 =?utf-8?B?RXhmZ1pOdnE1MGVYdGRXdENRS2JIZVlYTG9MTXN3aE5IV1o0ZmpzOFFjSzJi?=
 =?utf-8?B?VFVCZXloc1J4MmNqYlU4d3RRN1hsT0tUL0Q4RDc1ZHpxK0x4YlpQdEI4QzZx?=
 =?utf-8?B?Y1hBR2pTbFNMenB4eVZSTDlPdmlEQXg0Y3l5QWhZOFNMd3JZcDVOYXE2bU1K?=
 =?utf-8?B?UEhqOXkwbnlZcXY1QWRJb2pCM3BKRDgyVzhvdGp0a2Q0VHZBWnN4d0UrcjA1?=
 =?utf-8?B?RXdSbWlpcGFlT3BNYXRCUi9DazBJQU8vNVdsQWxlQ2ltWFZ4NW5XbWRvQmR1?=
 =?utf-8?B?Mit2TENKRzBBRWJOLzh6T0REYnd3KzMxTVJ3ZVlTbVFpMjBETTI0aHI5R1BX?=
 =?utf-8?B?MlJ0SzJGdmpTQzRRbjU2UWt2SHFPU0lLY1o0L2JqUzZha0g2ZmdxbjBiNm5j?=
 =?utf-8?B?UDJWc2w2WkZEZUF4clRNWEwvbWJjdllpS2V4di9LT05XRWZ4anNxUjNsVkRE?=
 =?utf-8?B?RENOQ3F4T1ZJSnRxRHFpYnBBTlBBdjlpR2I5bUE3bjVtK0wrLzErYXRuTExZ?=
 =?utf-8?B?b1FBN0VKNG1WNjRsdmFKN2tvSVpkL2tHMWwrbWtCL3N2VWxRMDBsL0pYQVR3?=
 =?utf-8?B?bldvbG1nYnlNaXFVRnBmT2NodXJVYTVYZDJ3Y0cxQnR3d2VqQUV4dFFseHpV?=
 =?utf-8?B?SldRV1NDRk01c1JQQkFIdEJmajB5N2tmOVpVdnZXN2VZN2tSNm1XVGxsYUky?=
 =?utf-8?B?UFZzQ3NNOU1yREJzK0JHUEYrUGljbm9FcXhzRG1ldFdISTFtb0ZqOENHNTlC?=
 =?utf-8?B?V2loVXdrN2RpbjNKM0s1U2QyR2hNMldITHl0T2p3bGZFWG50SWFUcXF5aUs1?=
 =?utf-8?B?MEM5OE1KQit6djIyQmJxNFV0SVkxK2ZaaWtjNGxxUnBDS2E3YW9YakYwZzJo?=
 =?utf-8?B?NmNveUc2WjlpL2NPR0NtY3RzNUZrdHhhNmVPeTFqVW85bFhrdUtWNEFIVUt6?=
 =?utf-8?B?d1dRR3FKZWx5ek5jUnpOTXZ0M3Ribmx6aCtTanhpTTNEb09NcFFoNzFjNExM?=
 =?utf-8?B?aEFvU3ZyRzdLU1huNWp2QXVOTXhmbjJweUdteFRISmtjK2JyWTJYckJaREY1?=
 =?utf-8?B?SExnTHRVUFdvdTFkZUJIaUczcENmWGszanVEZXdSOVhyZkxRSUNsdXZyN3VO?=
 =?utf-8?B?SlRHMzh5andmV3JHUEgrOHFxMEtsVldTSW5BMTcrY29qcTlwTWwxQ09VZTda?=
 =?utf-8?B?cnFOU0xjbzM1MmZqRkhWQ1ByRzBoQ3RMYnl5dzNWeTlWelhFSndDdUtVbFRz?=
 =?utf-8?B?VEcvUTRPa1FsaHhEN1ZZTi9rMStmdUliVXFleDFKdVVqczhBdElEcyt5QUd5?=
 =?utf-8?B?NW9Vb2hhcTMzWFhDSTZabklqNjZyVjk5UUxQK1hNcGcwVzlia21MRWhYbXli?=
 =?utf-8?B?ZGFUK29yc3NWWGVTbjJiTHBTbHRQRDJpTjFoQ1ZvQS9LL2pOS2o2ZTdiY1pr?=
 =?utf-8?B?eXFXeGVvTmh3S2tLVlVyUEVxcHJubU41WEFFYmdqN2RqaHg4QjZBZWRRYVN0?=
 =?utf-8?B?dW90YlRCc1B6cS9LK00xS0ZSQmdybG5qODNzUSs0Q1g5NTNCcUZYRUR5SVBQ?=
 =?utf-8?B?V2JCSXdZc2VQait4RnBESlREckozbHRFb2JzTHZVSmhOUnZZQVE5L3JZMFhB?=
 =?utf-8?B?YnZUdjJlSVhwUEMxdUI1UDMzN0oySXAwSEpMMUNON2VnTmtOY2F2TEFPQmtR?=
 =?utf-8?B?OHNPdjQwR1VsQURKc1Q0eEdVYmpOREVSbjBybjVncUVrTHN5RHBNRGRSdUJY?=
 =?utf-8?Q?MNc1WJ52EVyQq70riYob98pZJf+8h1iY7TMce?=
X-Exchange-RoutingPolicyChecked:
	V2Y2nXbSBSY3ZVtn3aIlrGUrrjlz8vgckvizU22tJXcwFwWxlnqr0H7HWFQtMxZ0XCcMPLM3cRrMJJUwEOFT89tTIpN2Uonu4FrBcUrlnI68j9gjNh3pKVZEyE7a5C9ALAFP8Nn2ZRz4Son2nW36yX4zbOHJI9hGAS41N4b5aJwakHiLfAwKEOlmQfQUWhJTm9qGHBmg5nBGO8ZScIOMVuLXEbYtnEJFWYtc8jO6cG68wLqfq/XMQ4M/PS7nPvJmMd6rdJtvyKRbzJXYMl8ju4tdj7Rf8EK1MHzR3uBqnXdsBRgBvxj24fcviVYikHCi9DW/JvGKNulV8UMbHEP9Xw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h7QB1vf6Kotr5fO/o7MqogiTIGs37tNss0Wd8GvrZw0qVUrq1+BJFv2v6Ee3f+kner0m/KyFL3pu/m51+8ZvI5UFq1WwVEguzKYGpnzSZSJ4WZ741VmO3rOmYmM4bVJ8jZm/8WwH9Z9wp+5Nhvju27HNoAOBmX+LdJpOzrj5319sxMmO/ISybPvUF9VAwXtfG648ngRCN43IRDwv6xbUvTvdh+oTbW5ZYvamylWfwLpb6C4HZnT606CFxeNEVVN8Wa774ZFjOlj7+eRC17UNpwcGixApeieE7IVDla+AW2dPDFKM5rHZ38s0cB0vNmrWZbCfF5VMu+nUGxL2nNrNFCz7HD/CjMr2TB27FFGYQRfL2NJYUyp0NgW+HMXnqPG1uN/dzMDFyl981t7+Hy5bDu1AoIQoN+LcTkenZhkRW6YbQG5tJFhOV6od+e8oBU/Gvij/qHN7AO3rjU7bQ8TXQvPSOq/ZW51VuWRHExLRa+HyhWeUCzHxy+PCr8ZDluhbtxwETrY/eKbFvyFlHddhoIdA9RMNIwxUtt5wG3nKLKiD6x3tJ1e+axVKV0+4WJrbNhMeYyd+BlJtbjYWVnm1Sq1CqtwjvVZEGoAqualoYxA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8957b99-3fc7-4fff-7f57-08df43c467b0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5834.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:31:34.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1lZu1/IivGR19UOp8N8sbwwrIMc5nUP1EtsJxfiDbf3mzyAcba9L0hJhHv38HtC14AxVMrAZr56Zx1CtPnXvqGFUeVCX1Rdk0TCsMx29cyd0q+FAzVd/2oYEeBzkgfb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611160037
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAzNyBTYWx0ZWRfX+EyJTcVho3Lc
 rhPyp2GbckFNAD97z5KR2cAoy3s5ZVEDOrSTTxyeRbGT/MCeeePDUMqGei6sH0xTjf+tE/mtBuy
 iRSjburA9vLfOXfha1xBVlRs40WuBoyGixNiODh7BjLWYVzWdm1/TzWoqYxZK9fL1me/VcGqLvm
 HTdkgUyiFf+TWhNFZcdb1Fdi1Rs0lAPuDwDJ0nJnmy2VDJLdiE5jX0ROpbp0jFYKDtw21l/ST6W
 BaOPYvhXMdK2aQuSr7AGEU3zO6GwVA5l7+uCqCoiMLUfOJSt9lG2D+nV34cGf5Ec2YXdHh+AP0O
 +6O68pliaGL6gC2TLAe1ZaVW04zbr7YX05F9J2u0Hz8+xNyuL+gaiP6C3pbcs5XAg3BqMGUhXmo
 GXp/hNQhNkyFmzw9njOcvV8OaBcYblIN2ieElexpNhrKwlrp/rQQ7/RkbWjEhDt5HOOIhofbMJo
 lQZFLPoyTwK0jyYexoiqQCDZEzYKADaqt1/7bYlQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAzNyBTYWx0ZWRfX33Rl2HaGZgAS
 BVfXJAOmkOIyhF3hs7d0f+MM9oNvZhcnD/7tfXheVvKgMuGVSJlmo4NRpEesTsJ1zuU/kFpRD4y
 WARBCAjES+YoGDscYDIh5pZYC9cyttiBMUfLucEFf4ZmFap9S9+Y
X-Authority-Analysis: v=2.4 cv=ZIBCCn7b c=1 sm=1 tr=0 ts=6afacd79 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=xNf9USuDAAAA:8
 a=jfQVYxa24jwVYcctglsA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-ORIG-GUID: h8peWp6B4NDCu2_cn5zmkIOkjaOsB4-v
X-Proofpoint-GUID: h8peWp6B4NDCu2_cn5zmkIOkjaOsB4-v

Hi Sasha,

On 14/11/26 11:12 pm, Sasha Levin wrote:
> On 2026-11-13, Salvatore Bonaccorso <carnil@debian.org> wrote:
>> One followup to this. Reverting
>>
>> Fixes: 091c44b2d3c3 ("x86/mm/pat: Use pr_warn() for early W^X warnings")
>> Fixes: 11d1ba991c07 ("x86/mm/pat: Fix effective RW computation in lookup_address_in_pgd_attr()")
> 
> Thanks for testing. Queued reverts of both for 6.12.
> 

Thanks!

Quick Note: We are just reverting the fixes just removed the fixes to 
the checker and the actual broken commit is: commit: 88a817e60dbb 
("x86/its: Use dynamic thunks for indirect branches") that introduced 
this problem.

thanks,
Harshit

> The same two patches are also dropped from the 6.6 and 6.1 queues, where they
> had not been released yet. 7.3 and 6.18 keep them, since there the check only
> prints a pr_warn.
> 

