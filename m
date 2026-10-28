Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793231068;
	b=cCYZoUnkYxt4cZsNujrbJt6bwc+iqTNK6fFPyECq4KSDwX9Upvgq24mosP7pkjUPxccT
	 agUVd2ppvlVJciwafTw2/nLrnEAQFxsjYSz3pn/QMl51wP1qT9mNJAJfuM+nLzaxdwLtM
	 VUQ0N5BrBA2IZ3zM8GZg6qzu/u7SjyCYcB0AKP0W7uH7aa0U4DGleN6VlT/AuqoY/Lr++
	 vw8kP0tScbNIg8oRR8dnjKOdU6ckkLlqMGFv1tL6LPbTQwV2weJGClAgFe7KQnFQZ1hZY
	 CGQSlxNTp2gNRr3oPkTv+ctWCuvLzSIIRa91QBA/VfkLOvYu0zi1MS6X+Op0AfIwbxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231068;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-TrafficTypeDiagnostic:X-MS-PublicTrafficType:
	 client-request-id:request-id:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID;
	bh=EHdWhNUzDhHtfrXl0yswF69pUJBFu1Qkuz8uyHtb/nw=;
	b=hJ9dHZOWGw4K1VCvdIW8vsZII+fJggbk3jhDua6quh8Hv67+bmSm9HwaPeDXCOUyT46d
	 Rg8+LabdMr2bb58+3S8Yx90Lwb0S8eMEKhBHjAKOyUtuvllBp4VlODhFR3M5TARIzPzEj
	 /s6yEKKUW1HpWAk/HaEXfrb8M/BKhNznbbkGT+p7OZ4c7i3PkAfW8rcpLeHZ+0Zftqpl2
	 7/GdMobIthfMT6MmDh9KGOYzoJTdS9A4fTCUu6ygG+hG7T0lAU7WI6bJlQ5E6e+KqoYYU
	 t+01eTDt1M/r0XJBLb/Eha+9634oxxqVkCkdcn7pzahm39rIeEOKoc0KR+ytGGbgIQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=m2ugfyOW;
	dkim=fail reason="signature verification failed" header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=VM9oYvrh;
	arc=fail smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDBC606A31D;
	Wed, 28 Oct 2026 23:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DDBC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=m2ugfyOW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=VM9oYvrh
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SMub7x3834627;
	Wed, 28 Oct 2026 23:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EHdWhNUzDhHtfrXl0yswF69pUJBFu1Qkuz8uyHtb/nw=; b=
	m2ugfyOW1PMKQNJBLDjGf4QjDr3ArJlHXfMbuUsaHl70ElCfISAvVOpRoFwHbq53
	dbE5AjNO+B5FB01rxSs/JC81vFy0VCJBMA+2OfO/JN+u2Y33k3jlsXxsAAjhco7j
	/hKUlj9aHIV25b0Ko7uCvx2gOPAn9JR1cWL6ZZByF2PAkNI6Nwhj+L5b0u8I9x9q
	tr86JaA4sIzUo+yZCsCykUSJj6EBHoJ8evYqRVNqoBGJS3iRF9cJ+/eq2njz96h3
	I8zOeIMTDIviXbdCP04DTsWI3T5w3g1kBT1fFaCyciz5sk8rshH1mQYcUzrc+dK8
	97/5w8byXbI+tg+EiFq+6w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hgkf1xssc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 23:44:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69SM85Hp068653;
	Wed, 28 Oct 2026 23:44:00 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hkqx15h0y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 28 Oct 2026 23:44:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLIf/BjNo+VKz/1zW2dbLlMwMUdHERsvc4j6dao84U6dvXcPNM1F9hkRhIwIs7lzXQFAEArRM06T09HHeMJU1Eh6ktI34pRvi+lZWc4e59gyKACkA1iYFobj67VxAp55dBYYv4rJ7XdeWlmvWIn57IniU2lnSf6jjuROy16jEU/PjecqyJ0TUpBo7SxiVEGqwX3YLPa06tvndTlf1BSaRfJZFRsPxDaGPK4LqNh68Nob/iRzp15sg/m+1bXxCpxGt2uJeu8EjdDmtnKUIgF4lK6iOoN1uU8g7w+VTCc+mdfvIyivH8E+h+zJw1VNEIVIeXVxAWdu1HTbBHsTz/lUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICaWKUAFZRypbyXb50x2C3Qe92waWjHdhz8blBz+fjw=;
 b=i7Npmnso7aCcjE7zI5RNHaEHYCFbqyOapAayrWFRbTj1UGCsWyeIMr2EJKDIPzkFxR+5NJiba7mfmYpMdcn858nPX/ncYcmXZwaI/HhXRoYJCDBq/1b89nkH7mnL/SaZnjg3faPLPVxzi+KQ1cs3LJn0C7wAqu8YolH0wSS/NZdJ+cmhAKYLb4V35ArvTZ43lt2fjCfLDCG02lKvVvUovatOFP8yCRVkm73KFCf0zGeRb58HOD+cEirpMy9waPquF9FRRKYtDT2NVucVkwRvu+JoLr8UwqrmqjPUqpQajkBuZKofX7ZHUJiZDYOwmBPolffoKlka1dkNiTWWFfme/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICaWKUAFZRypbyXb50x2C3Qe92waWjHdhz8blBz+fjw=;
 b=VM9oYvrhTRMKo+FpC2TIn4xc4yXhZcJmjsygDfPkGOeNzfYUKmkZOJc7mP/7Ue4Y+DgqZDWoEufsIt4PnZ5t0W9JP6ElsGwldK2tBMcQjgcNUnav5MNFUeMmXlRvYnc3QlRM9UDNrheT27EUDINurIw2XTLVWcLXLK9ypJ0CaAM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CY8PR10MB6660.namprd10.prod.outlook.com (2603:10b6:930:52::10)
 by CHBPR10MB250123.namprd10.prod.outlook.com with HTTP via P2P; Wed, 28 Oct
 2026 23:43:57 +0000
Received: from CY8PR10MB6660.namprd10.prod.outlook.com
 ([fe80::c6bd:8750:27f3:6e63]) by CY8PR10MB6660.namprd10.prod.outlook.com
 ([fe80::c6bd:8750:27f3:6e63%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 23:43:57 +0000
Message-ID: <c7fce0ea-888e-4e97-b4ed-ea63f92be5a5@oracle.com>
Date: Wed, 28 Oct 2026 16:43:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: restrict SO_ATTACH_BPF to privileged users
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>,
        "David S. Miller"
 <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Willem de Bruijn
 <willemb@google.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <CY8PR10MB66609715D3216D1B10CC186ACF6F2@CY8PR10MB6660.namprd10.prod.outlook.com>
 <DMGTEGTLTEUX.HECMYVCWNFQA@gmail.com>
Content-Language: en-US
From: manjunath.b.patil@oracle.com
In-Reply-To: <DMGTEGTLTEUX.HECMYVCWNFQA@gmail.com>
X-ClientProxiedBy: SA1P222CA0097.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::24) To CY8PR10MB6660.namprd10.prod.outlook.com
 (2603:10b6:930:52::10)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: CY8PR10MB6660:EE_|CHBPR10MB250123:EE_
X-MS-PublicTrafficType: Email
client-request-id: 294219a6-0756-4496-b38e-3878e57e4826
request-id: 091337fb-3f84-426b-0cb5-08df354d55a6
X-MS-Office365-Filtering-Correlation-Id: 091337fb-3f84-426b-0cb5-08df354d55a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261028144727099003|261021121427099003|56012099006|4143699003|261022105027099003|261009223027099003|261026121527099003|261021123027099003|10067099003|261026140227099003|18002099003|22082099003|6133799003|4133799003;
X-Microsoft-Antispam-Message-Info:
	Wi5Qe6a0G8g4mwMTQH72qEQHtKFYZ8SWECwcCmJk+oFxWm4YosfzUSI1BzVpuaP3ThdjxJFqUuDnY6kRU4WaD+l3zodbnRKmU9NuIj0kiitJU4SzctV/tn5ntDisKmQ9xAAMXIXYqUyIhg8Hh679gjVMmS8NrtUrxtPNSQutgxhhKehtnjgksdPbzzifScVk/hQKptnnlQYScTgLB3BNaKbmU6IJ1DOgAdxBzC4TcCtcXLv271+aOR59nujGjamxWTPfpNGFdXmICAXDoiKFiuo+x2Uhjzs9U1gVKzBC+QQAS3g1AI5Sk6q56LAuq629jYT2jtZ+pDfYLcRDHnVHJS5IfSldqSAFJdmnW9YATN7fr8JJlm4HqGsSBtXAnf+hvDDNdyRJ+O73bPcil6EjGJhbJv6c4hMUQ+w0UISitRks6LaM/udX1VDkSXffAHThofunUQbL0AzLx06Fyq+7dhlRz1Xxs1nPJ+gw8D9OvQY0t/Bpv/P3qv5+39oIl1047f8+Akap5ftqHaMxkIPr0NPUqip7Am7gO7S0VqrGa5SRAO6Hux3D+MV2ym2Fiz5wlkHQbFJXXuOYvBHwHuaoun5CmJX02sArJeOXLifhQMDCp3Bl7UsAbQ2Ck3Y6fj9V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261028144727099003)(261021121427099003)(56012099006)(4143699003)(261022105027099003)(261009223027099003)(261026121527099003)(261021123027099003)(10067099003)(261026140227099003)(18002099003)(22082099003)(6133799003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmpUdlI0YnRwcWJOMEJXZHJCVlNpUExSb0JOK3REamM0U3FBbmJuUXVMTTNI?=
 =?utf-8?B?MmZQckhwN2dPU1lYVTdTUHc5eVBVSUwzTkoyUlBXazZPZWJaTEdEQ2k4c2E3?=
 =?utf-8?B?Y3E4MXBjbDV4YWt0S1V1aXNYb1YzcnNDLzBLVFJyekJiMWVBcmxwcW13ZDZR?=
 =?utf-8?B?REVEbnBZbE9BbW9zTW02WndjZUxpYjVFNjZseVpsOUd4Zkl3dHZQRzBpVGhI?=
 =?utf-8?B?Y25zckI1WGE5enYveG1ndjh1akZhblFGT3kxd29IMUYwalFOUUo4ZklqTXl3?=
 =?utf-8?B?NUJzMWxPZFR0NytkSzFqVE9pZFA3MWZQQkhEUThldG9VVnlmUUNhUjZ6L254?=
 =?utf-8?B?WkZzSFU4ODZCNXVwbFJPd0FUQzZ5V3BaOGY1eU5BODRGdjdFMStlRlBHbWpB?=
 =?utf-8?B?ZUNHSHFmeXJLcGkrNEFTclhIaW84akV1TGc0VFgxSnRva3FjZFVpemJVNTgz?=
 =?utf-8?B?OWVWakdodzNhWWVkTmpzcldTS21oMHoxSW81aEtnODJVQkxvQ084WWxmaW1a?=
 =?utf-8?B?c1BrNjh2bDVldFp2V0RqODJJTmgzVkFVVWZ5UXFHSHhJNmUzRXlsMUdOWkI3?=
 =?utf-8?B?TzV2eTc0aVZWdU0yMjVzUmtuSXFNVmU2Zm8ydjFCb3ZvOHJuM1dOTzlaeVNC?=
 =?utf-8?B?Z1E5T3VXa2xMM2RyVGVBMXJGNWNFT3FPdVBXVzQzNlRDQ3dnN3RoU2kxV0dw?=
 =?utf-8?B?Y0dKWEJCZ084RFZHTE1kNzdZK09wSUFZTGV0a0ExN0xqYjVWeEc4elRJbGpz?=
 =?utf-8?B?b2dkZ3kvT1hKRnJtanlUVWkvbzFjSE9nV1RjMVJkYmlhdDdGbExtTjlGZmV6?=
 =?utf-8?B?UGxTMVZBOGhVTGRjcHF6aERTNUQ4OTVXTWcyeGRPY1d2Z0NkUlJZdlFWclBo?=
 =?utf-8?B?ZWUycmN4RHl2c0d2NGJpTW9hWkFKQ2ZIaC9iL2ZKRk44N3VBanArQloxWGJ3?=
 =?utf-8?B?R1NPY2NuTHpCa3dQRkJKVDVjMzBDQ0cydW8xUWw3Y2s2RnNYOG9DTU5XOGlB?=
 =?utf-8?B?aldZRVVqMDh6N2VlTDBuY05Pc2c0WERvbTZDMTB3U3dvVExxb3NjbURkQ2h5?=
 =?utf-8?B?b3dicGhVSndTR002UkNPK0hGMHJTcVliSHowT01sZW5YczQ1VHBFOUt3OXlH?=
 =?utf-8?B?KzIwRDJBeTh0bFkrQW5VeC85dWVFcWRrYngzUW1kVkhGZ2lnVS9nL251M1dS?=
 =?utf-8?B?UDRMM3lQbWR0a280NGRIdFpoR1NsZ2xvWEIybG9iVWh4SjYrbDlkdFI5SUVy?=
 =?utf-8?B?NW5RY2x4T25TRTBzT1duSHN0d3hRbGp6dHNFeTRiRmcrU3NBUCs1UmlSeVRP?=
 =?utf-8?B?SzVmbGhWZFRISk5uZG5EZ0tneHljbDZPWHRSV245NStwaUJUMVcva1pCQlRQ?=
 =?utf-8?B?TGo0SU5GbXJtTnFXWEx1c1RleG9SVlpydHRSM3QvY0o2ZEtFaDZ3QTRaTFdk?=
 =?utf-8?B?bndSNUN4Tm1XZnAxTnNqSEFYZEVSOWZkMWlwSExWY3k1TFdyUVRZc0Q2LytB?=
 =?utf-8?B?U2lYSWZ3ajhZcS9STUplWGhyVzlpYjlXR0pyT2RtY3NKMytSUU1VZlh6UFRD?=
 =?utf-8?B?SUFENlNBa3dlMjNMemlhMmZyU3phbnV1SnpWSUx4K3I2dzc3bWJVQlVnajVn?=
 =?utf-8?B?am1seGpPMGRKWXdtQ2dzazhCTFJwOXRHSlY4TXNET3VKU1Z2WmplUC9acEJa?=
 =?utf-8?B?ZE90NmJ4T2d6dG5SQmxZQWg2d29wZTJoVlM1blBOY0ZVSEV2RUpWZU00Uy8r?=
 =?utf-8?B?Q2dlSkNrN05oeXNaQXl1SXV2R2o0TGJqNnVpZXFoZy9BT3JiaWdISWFUeTRM?=
 =?utf-8?B?b3hobndrdC9xR3RUV1dWVEhHZWo5RFJVVW9BWnBYQWFjZDNqdFlKTHkvSWlH?=
 =?utf-8?B?aEl0M0tLa1kyaFFtU3BRT3YveE01S29zNkhHMW1sKzZVcjZnOFpkN0RaYUhq?=
 =?utf-8?B?WUUyS3VBb0V5dVhSM2NWSVh0b3M4ZUFwN3dNZTY0VVZkdU8wcUw4dkl0VHJ1?=
 =?utf-8?B?NkJkYUFDSmFIYU9zdXQ1U0htVEduNG1BM1BYY2dkZkwwOHZacHpxSHZZMlZ6?=
 =?utf-8?B?aVRrcFRDRWh2dlUwc2p0T1hVU0ZYRnY2T0ZuUzlUd2RtMjVxY1R0aGpHZWlL?=
 =?utf-8?B?TllBV3JPWWRYSmVKMUlhbktrTFJTNjVIT1QyWURzN25MZlJlOC84Zk9BTCtm?=
 =?utf-8?B?aVVjd0NHcWJoaWFCVnhmVkFHdExUTW82QkNUMERxcDhkYnFEK3pBdGJaSHJW?=
 =?utf-8?B?WTF3ZTdsUVJzVzN3NmNrNVVhL0lvVkxoUEUxaXdJZSsydEozZ2xKdGVSUDBW?=
 =?utf-8?B?Z1FNVTRBcGFBSk5DUUlQOTRXL1NxejdJMjkvODVhUlZkd29teWhLcEdJU0M5?=
 =?utf-8?Q?CS2/Nk/xiGKaeTiE=3D?=
X-Exchange-RoutingPolicyChecked:
	XMdFRzIcccsZ2Ib6vFbk9A3/rzzCtSPiRkAgztDJqWgk4IDLCvJMdyLpIIUq8XfFULiObASMntI/JA60KuYVrNTOIvWbfrpzXN9MKLdSgSAx5Tf9EZy6pnl3e2KwVi+pz9nQrjwzzGQ2fAflaeGVF0G37dv0GusVVMdGLNvz8dKJKB5bBjL5/1WITwm/pacg+c2hlXzx9q3+c/b8ZSoNVq/d3Fv9/24c4b7xlTm6WsGn8edO2l+qufO/eYoDkcI9RtHaxfrvPif5iLrtC7ahHa6cE9nOLttT0uH8SUWM37qF/OSSGuhodrIbxl6BZvduzOeoVowA67DvZLlIaEpMxA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	37RLQB7m/ZbDwyXhSb3AurLIO01hIqnn6mjTVl9wh3IBPsQFZyOLPmdH/4xn6tCLJb91SN7GCLKLFDJPDoihW5lsS+F78WmDsu2+Z6yNfqh9YhFR71HsvcsQdGScwBf3t7/8UoaGUm0chZed+lOS+IW6bgv9ZUEamUz6DOZQEF+6yu3aiRrcFUz4U+3wnTMCA/3QQd+6fwYrImWngrYiQ9vUQvHOt3woMz5e81SReB3j5WAVkSJSIxuOD82Gq8p6K718WuRnXvsbEl0aas7ugb+dyvGvQb0JqaKmX2eQceY9eIhxxF3Ewq1DIoRDVjSUiGZmCns2QBBfaFisyXVIqnV8iFeaJSSQLsDYeyf1olI9u4YTmv3OEaXgsWGHGtVcY8BPvsL0G506gHhHyIa6sH36ahCDwivmLXkgLgCmc/qmTcAH4eb7PXB8zqy14QmtGtWTHb0QOf1h3R2UlcMifhZmPB5Z3WADDitW4fFJSLQ/E0qqnyhjkj4v2L3Lud2FE5CeKDIfq8nt+bva9BQev7VZQa7J46jJ67G18qRqC8T0dg6fO1svZ8YQKvwHevtCWozdXbYQJOQ0tKSjWYF8tj9ahj/Wx32PyY0y+ebC9OE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091337fb-3f84-426b-0cb5-08df354d55a6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 23:43:57.6893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3crrP5a0Bm3qO9oTW4i8Dw6HzOqqdLhJS3QC9TGqBoOW9GMBefW4e8P1YdTMjVPWjr/UA/d3dxtCIk5viHrUoqNZ2lany9M5kXhLjcfo38c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR10MB250123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 adultscore=0
 mlxlogscore=-999 suspectscore=0 bulkscore=0 spamscore=100 phishscore=0
 mlxscore=100 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280094
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA5NCBTYWx0ZWRfX7djyX0yZlYa/
 gifYvkYWWaUbxOyFe7To5pTWXbAZ/jjk9qim20lugMI6y2ITOdqSxwGy1ZV6YwAscXK6mqYgC+O
 x7JMPsYiotIT4uqEJW6w9vwCFmsSCeTAi1HHIMqsE0kIpfjtZwcm
X-Authority-Analysis: v=2.4 cv=V//oQuni c=1 sm=1 tr=0 ts=6ae288c3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=RpNjiQI2AAAA:8
 a=yPCof4ZbAAAA:8 a=iYgqLKeDIdRyDgfoQ4cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: RwxKchVDkNAEAqe_1ZcTs1BVinqVg1eB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA5NCBTYWx0ZWRfX1UPn8Vo0TOWA
 gcnbi2AIrPjqPesnBpeWdryn0YIk4HLMGKI34mSavl3CLsgV8r3hkU43V2ULHb0sF+punGz8iM8
 rRiFnMPSMeL/pYy+KghnRZQDU92ypTAg+cxbmXut3Gc6iep7KiHTBrpA3ZZv79lGdtYizzBZaCL
 rrpTWz8EtkCUdT1CZjfrLeTB2kDmrP0AQHckgkMhe7kPkr8fLbBctHmId0j2Zpup/uaf4COEzFS
 CnSrC3fzKwuy4z0rRuQ1XRu2DWB/+SVKujPS59RBx1+3rgG7jlobG9oiBmwfoY84nK6Z2Vfefj4
 gao+VL16DOGQdOAhVNFbRHL4wHF/LN4YX/xPFjuzkicyoIrxCdZJFuzQv4vJ1+YCtdZH4gxho3p
 Jw8I/bWhK0qhi5QIvGQ1it0gOW5GJPqjzVVUnbsIti3xCFLjHqlRcF+742y7ABWBTXh/uTFECGt
 29ik+Y2cEQSRFkp2mpep+p8RwV5T1n5i+qf/U15Q=
X-Proofpoint-GUID: RwxKchVDkNAEAqe_1ZcTs1BVinqVg1eB

Hi,
On 10/28/26 3:12 PM, Alexei Starovoitov wrote:
> On Wed, Oct 28, 2026 at 02:=E2=80=8A58 PM Manjunath Patil <manjunath.=E2=
=80=8Ab.=E2=80=8Apatil@=E2=80=8A=20
> oracle.=E2=80=8Acom> wrote: > Commit 5d39580f68e6 ("tcp: restrict=20
> SO_ATTACH_FILTER to priv users") > requires CAP_NET_ADMIN to attach a=20
> classic BPF filter to a TCP socket.=E2=80=8A
>=20
>=20
> On Wed, Oct 28, 2026 at 02:58 PM Manjunath Patil <manjunath.b.patil@oracl=
e.com> wrote:
>> Commit 5d39580f68e6 ("tcp: restrict SO_ATTACH_FILTER to priv users")
>> requires CAP_NET_ADMIN to attach a classic BPF filter to a TCP socket.
>> However, a caller can still attach an eBPF socket filter through
>> SO_ATTACH_BPF without this capability. Both options install a filter
>> that runs on incoming TCP packets.
>=20
> Nack.
> SO_ATTACH_FILTER takes insns that the caller wrote.
> SO_ATTACH_BPF takes a prog FD, and BPF_PROG_LOAD is the gate for it.
Thanks for the explanation. I overlooked this distinction and treated=20
the different attachment checks as a missing permission check.

> unprivileged_bpf_disabled is 2 by default, so the load needs CAP_BPF.
> An admin who sets it to 0 allows every user to load socket filters.
>=20
>> Disabling unprivileged BPF loading does not close this gap: a caller
>> that already holds a socket-filter program file descriptor can still
>> use SO_ATTACH_BPF.
>=20
> That's not a gap. The FD is the permission.
> A process with CAP_BPF loads the prog and passes the FD to a process
> without caps.
My test loaded the socket-filter program as root, then retained its FD=20
in a worker that dropped its capabilities. That exercises supported=20
delegation; it does not establish a security bypass.

  See the comment in bpf_prog_load() and
> commit c8644cd0efe7 ("bpf: refine kernel.unprivileged_bpf_disabled behavi=
our").
> This patch breaks it. It also breaks a process that has CAP_BPF and
> doesn't have CAP_NET_ADMIN.
I agree. I am withdrawing this patch.

-Thanks,
Manjunath>
> pw-bot: cr
>=20

