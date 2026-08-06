Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB53A83B1
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786033187; cv=fail; b=UKbd4UsWqJjqqs204PuwmV6W8iiFL2IVo8/yZoocafiaxsJExPvGow9iDXH4a3bL4sW0cgyzBOcMynXCGi8N4QLiOe7/QNURikZZ40k5YSweuHKQgstVFrCh/yuweEKYmudPb0WLYWKuSRbs42N7fRqpBVx0zOkwIWQz7T2CJw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786033187; c=relaxed/simple;
	bh=dbo5TmFSBaDhQhC7Hl8PMN15HzTMBJfO/i16tMJGPvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F1Dh244bnguvCJgMcH+SY1bqphbjsAADYmeo2OIakRbL8wIoSkj1kIBkfNSp3/eWmGT+UkQCh4Zxp73AqI7Ym0OCinhMSwrsITgw7Al1raJYTLM3NFoyIVd0dWnMxnbyf65sFs/FNAu7eSIAjO+P/+xViE+hrEk/PigAMX0y6m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NdotuJ6q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wE8HBT+K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NdotuJ6q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wE8HBT+K"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676FuBUK3045329;
	Thu, 6 Aug 2026 16:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+2m9VdGQ9ElsOj8ZchjVPWhvfPa8IhDrNmeRPjMX4IY=; b=
	NdotuJ6qR2UZmi9EC3hKogtcFN+/F+WAx64vApt6R+OCoeQnwozkH8M0048B+DPB
	djOI96UeABcS4gR5QCXdlE4rXky6Iwxz5IkkJbo4PfjL/0WR18dpZchQh+sxdRx1
	1M1NJo1nr+HoNi2H+uY0VrqivokoMI7lxPZIvtg7/wNnOunjeP88yj4pVfVYO2uG
	RnI3JOMvv8d9aOzp1NgYQENrb13HqjFEd40BUXgZ7TST1+QTAR4xn81GLFhu4Qb2
	ql4iveW4qfXQnUWoWOYdP0S9ZY/kspfAGTxwLI3/JAz85SMmHeMHlQeS08goUGOR
	/68/D66Bi9hDaPQZuoPsNg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs9bte4sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Aug 2026 16:19:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 676GAa0O008451;
	Thu, 6 Aug 2026 16:19:35 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78vxx6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 06 Aug 2026 16:19:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ1QoG2J1Z9AIZpBMj7YIWpUlySI90u8T9OKvmXB5p5qvMkobByZ8f8peLmWptg5dYKI/+ll/uu4bC07dyTkoXn6hw/aoQIepuCQ6AVTwFBY2/7RyYlg5QdF9Gr8KKazIzsC2XiT+NYXDAZvQXNqzEyvv6+KAGT0PY5HYR0IHQmDOSKw3Hz9izKdjsFV6v2jf3RXpingOEnTWCAU1+L11Oaq0CxUcUF3wbLKxpRZBgrHi1MgUuzylGn7Gv0McNj64fZI7MXY8qoLwb8IpXvMeELxKAjwb64mFLUr5Q5x1wxI3gwscdB91X3URlV1Vr9JfLyD+WsmuOda1OfnqaHytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2m9VdGQ9ElsOj8ZchjVPWhvfPa8IhDrNmeRPjMX4IY=;
 b=i1uT6iRJDqw4gN/o5qfl89G/OSF/SFtrFlFONwpY28iFvltxVe2DNAv/2V48vn77tW6gsEXRVvOUddvifxWGvG3XLEB0+P+r5SEeJbqrSqzc0AzlmrfLb71jOP0mRAlR9juW8Dl+fbcX6jIXro1BWec4sJmn/44gJZdMPf6hk+eqHXj4U7Rmf+C1O0oZllWsLgUZT3hz4BI4luYm8SkYaLwyUfQsIgkB2hr48+ZhvM5gCeafgWAxgdvR85nWGKANaHYEx024vnyH6a34sQQrozUEMAY2gSsa7lBZYyczyxUfhePBS+Oan6kJdKDaFzSHYO5dwl9ma3v+htbIk8skdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2m9VdGQ9ElsOj8ZchjVPWhvfPa8IhDrNmeRPjMX4IY=;
 b=wE8HBT+K5M+DMIQPcOe+neADIx44DKZDhPYzPrco2Eu7Xl6u857zkidxJOatW7LPa3JrUoQW6uXT+3zDfNM/0SCsH3TQ3Gy1jC6veRZ1JSoeGYM7wsX5SfchgXy+AdlwXTYu4UKNVMbhbN3WffB8Ddt1PQwdZASoThSVyfRUUoQ=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by MW4PR10MB5840.namprd10.prod.outlook.com (2603:10b6:303:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 16:19:29 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 16:19:29 +0000
Message-ID: <6c049895-dfc1-4cb4-b90d-35d2ae503153@oracle.com>
Date: Thu, 6 Aug 2026 21:49:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y 6/6] KVM: x86/mmu: Rename __direct_map() to
 direct_map()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <2026072557-gem-defensive-a757@gregkh>
 <20260730192933.3123642-1-sashal@kernel.org>
 <20260730192933.3123642-6-sashal@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260730192933.3123642-6-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::7) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|MW4PR10MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dad1efa-8715-4b9c-a9a2-08def3d67dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Mz2st2hQ/SIIyp2JuWd9CotFJ3KYJYVnUGhV8sc3WrX/i+MUKL4OJp6+XtXiUh136L4e6/DO38L87roHqzEs6keBel6Ri3oC5JQvrRajGg8nLUKyaZuW9fW8zZnMjWDEVWILfcLY7++k6nFPwzCGxjbi4fMY20KJh02VrelP+D5tWTXBrWhf95w5YbbHIUAIVU2aZxD+Kdj5UxraLB6oRZTXNegliS2c6P1uZub90y1j+fcNG9JBRo8zNjuYdK3MhV6m+PO6lPdUfIhW4kuVb7dOWC33NgvpexT9/KKsW7mFYkDy6KjyIR4e57Xmusr8M+/u5s7W4RfmApYl62JzedREtIBYMZvS1ZGYH8N3jCKJHzhwdyxWv3SYUGvf28jcflESN/dUmCKXSTCqbWWob7tz9jdjmnHfU3eWtXC743PTY588+WfmL8/Ir+lhjG23WT9Jka1t8RvsTLV6Bq3pvdc1chweUWt7RLo/0o30MbL8D2NG4XiWVcIjgnzBbNMvkIoGjRNZC5qocX8ISIW5Jp1S0nZTgfJQk2xLD1mpbpJPR1k5F/bqjOQ3rANRBxtx6I6+KjoKGYUVuHXrCIhbeuF4QvXFzeydcjuTMhYdsiPQhqB60YGz+XGscu/E+rXq3NwIiWW+KF2Wk/68V1LG9GvrAaYw18y0GTWaF1RIzg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTdhV0x6UXBrd1hic2h3SThXdjFwM1l1M09GMzVFU0V6b0JuOVg5bGo4R1Jk?=
 =?utf-8?B?QzdicDJWejFNRHZ1N0VNUFZPc0QvTDVjUEZjUTdnK1V6cWk5VzVQVk1PUHUx?=
 =?utf-8?B?bDV4aDhNamZEbDhzQTY0MHhqcXFZazJXNnFuQ3pMd2wvRUF0MkJEWFJYUjhw?=
 =?utf-8?B?QmxuYUh0Y2FDaDFScGNzTDBUVXlBdFF2L0xwOS9jYXBrYjJYOE1TWDU4WWNY?=
 =?utf-8?B?cWhuQVM5bjczU2RKS2ZqN3JrMlJScUUyRDc1TjdQOTU3Zm1wQXZnUVhncUZC?=
 =?utf-8?B?cXAvd3Jua1FhTWg2bjNRWHVlRFlITXZzQWs5QngrY21TVkw3bUlCMk5xVU5Z?=
 =?utf-8?B?YkdMSEVXeUI3c3ZYQlNSRUdndzUvb01Pbm9ENkNTSlZJU2JxdkZYRVhFRkJJ?=
 =?utf-8?B?WTh1RzZsbVFUMEkwOTJRNldhM2NTeS9BZFdlQ3MvZnd3T1JIeFIxQ0NENElO?=
 =?utf-8?B?ZVp2allQUjE0TzNFdjhxc3gwYXJOK2VlTEtXRCtWV3Y3VUJVV0hOVGpUcmp5?=
 =?utf-8?B?UndsQlFjdmN6ZnYwZWZEMk8rLzdJUDYxc3YvZjBOYkhFYmdGdklEVFBJVThJ?=
 =?utf-8?B?ZHJ1RXRsMUh6Q2dyTnQ0TE80T1VWK2pLWEpqZUxUeHM4aGR4ZjZHM2RVZ0o3?=
 =?utf-8?B?SjBvaGJiTVFRK1lXU1F0YmtBajVKOWl1ZHdyTmNDZE5lQnk1QVNKVXVFZGY3?=
 =?utf-8?B?V3JTenRaQnVLUmpJa2pmOCtjWjJhck04NDNMbm4rb0JSeUMzUGRJQ2ZNbzBn?=
 =?utf-8?B?c3p1Rm9NU3JvTHZCdHlmNVcyS3FCTFNWcHFPS1p3U1kvTkhwZm5ERndYZE1h?=
 =?utf-8?B?YW1nRXFhdk9YRjF6eVQzNkljc1BNSmllT3N5b0R5V1NQR25DSmdZTWdpTTlJ?=
 =?utf-8?B?ZThSNllGNUY1MWRIU2E5MEFiT0xCQnozWm1Td1pqaWxDR0IzcVFFdmZGclBr?=
 =?utf-8?B?am8yWU81WWY5SnBQNXN1M3JlaUN4aHpmR0dRREtyMkhJMk5ibG5XVTlrblo1?=
 =?utf-8?B?WkhOd2I1dXZjZ1RKWFJDYmFtc0pQOW1ScENrd1crdHBuLzFxNk91R0cwVnBP?=
 =?utf-8?B?UDNvTWFSZWxHYkJCMERLZ3JrKzVqdW9PSGQrWG1SQVdZM29kVTNYRGhNMlJY?=
 =?utf-8?B?bWxVNVY4NWJmL3ZyOEJrTm4wRXhJRSsxZzMrV1BpeGlQKzFRVyt2c3ZZVExh?=
 =?utf-8?B?YWEzRHB4b1ErRmZiQ2cyTk8rSHBzMS9iNjB0dExWYnB2WE1ERG5hNS9MdERE?=
 =?utf-8?B?ak5PTW5PNWMyWnI5RXNwTU9pL09ka2ltNWZCaXdmQlB6NThBRStDdnlpTjBW?=
 =?utf-8?B?ZlhBcXBhY3BSbjRHazVDdy9ETXhqY3RrbHNJSVg0M0d4aWJUZndlc2dYTldy?=
 =?utf-8?B?SWo4bEVRejhPZkZBbGJuS0pkaXVqQk4xV05rZGZ3Z21rMU1hNkd2dHpYMm1M?=
 =?utf-8?B?NGNITWdwNWxEMi9DMHhwc1lsZm1GSitvMmM0OUR2YkdTNmUrNGxnMXFWbkZZ?=
 =?utf-8?B?Q0ozWGk2aGdreEhmWU5mK0V5MmQ1WE1RMVJvV0FzUWVKbE1SaWVpNjJzTFpu?=
 =?utf-8?B?THJ0SHN1K1RRTHZoNUZET09Pb3Q3YjNlK1pnM21DalMwZmNyUDIyU2g3M3Fm?=
 =?utf-8?B?T0ZlN2pQSnBlTGwxWVJZTlJZdVg0MjNJaDlOZEhDMUZSTFlYa2JaUzlVUU1B?=
 =?utf-8?B?RjFpMWtoQllmN21lZHNqNGdJeVVEcS9hc01EMjNBYnFrS29WaHY4OXFFNE5N?=
 =?utf-8?B?SHNKL0pJSmNJdWgza253VHNYNFBOaGZBNnVuMndnY3lER09xK2dEN0x6OTJZ?=
 =?utf-8?B?bGVUQXBUWWEwZDVNaGMxMVZZWThKaVVYOTZvQ1VkRlR4N2NOc05lNnNob2Jv?=
 =?utf-8?B?T1ErVmsyRGxrczBJZ2dBNHo2eWJCTjFKNSs3VXV6TmM5YzZXMVZtWGxtRXQx?=
 =?utf-8?B?Z3VubW1wZ0pRcDI1bmh6ZHlBSWh0L0NTU3dkVHRzTE12Mmp1c2gyQ3Bmcngz?=
 =?utf-8?B?dkVDV1B5Q3B2alZ6RkdwdXdZQURDclNPUlAyM3MyVkNmZVh1Tm54RE5uUlR2?=
 =?utf-8?B?SEtTMjVydDRjR3J6MjZCVnhCNkhRZFh0bXFDRVZQWmhjMXp3V3dWZHBIODVr?=
 =?utf-8?B?RytUUFlETnpnTEdibi84dndhUHNHRnp0dmdlbSt2U21maHFPSjcrVjJxT1FL?=
 =?utf-8?B?dzgyY2ovZnlwNkhwdlFGbEtWaTI4QXZTS3dRQkx1QWFMSGl1NGdva09ReE9K?=
 =?utf-8?B?VVhkMWdVcG5qOVhPOWYvWC82N1lFd2VGZS80aUltTmd6MEhocTI3MDlka1cv?=
 =?utf-8?B?WjVCZUIveTFFRDZNenUvMzdxdHlsSVVPOVl1ZjU5TU9vVlpIVjhCZmpFMC9J?=
 =?utf-8?Q?c5bGY7ZRWKrcqmg5xhRRANbWjyMRKz576hu+P?=
X-Exchange-RoutingPolicyChecked:
	nhNYfS79m2tIsfBzgRv5IaoTuCiBdlq2pxRxK5wl+aLfWU2sTueaZA5EQrsDieGr4C+aXLUcEGvVqsl+b7JHxtca7z2hy4iHWZAWRIQY1YBVaL6uEK2f3ji8H6A9CEutIYCj4AmPrpwXsdIfvOCDcAmJcB/nooYFzPZNp3khOO4pMx/9yX8kMTt5BRRRTCPjcbk/PJ8vBsxnDK8MsJvCIgdo13rje8AKuB8eA3ynhcm8VPzh+WBz0hLJ/TjWlRgufZkGJMwFvXdTNkspQ8fEsAqrgvOp8EvNs32FdgvdHNKwuxkoeWY80l0lLKpe5Rd9MZWsafdATAL77JlCdJCCjg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N7d6mVvnBSFW2DnTkr20jf1eQFJtDV5xWBiJ/de/HeZ4vV/O1GbGWVxyAWh6Z9ZWWwlARoHiaSmP3/CEGCrxf/K27hroeKKm+QVFo7aE65Q0kmJeo0qE3UFYfup9JMIPORlORNaPUTAHIWTIOuD4AkTPaG4OGp45v14EwUovDlPDjtfaS+ag+nRWbl60VY6pKamQlHh4QhsEk8Qvz3hsrzKf5DCeTOaw5JMJ+VjckBjZzPD+7c8Gmo8PL9BMHrr1j3fq1L/vWUEFDr2NAH2axbSTLKC+XJ9RLXSBYf8KlMAli+FXGSOeV0m18ftw5GrU6fvfGXFmo7rnPAHP/0XvzhbTBc3Reqg9+y2dwSLyTo0e7gg1bxhxp+tOwmY56Dy2qvtI6zukcHgSp4lYPTJzlg+zMzSEj4Y4//+TNq7zKDd/Xh1G6qb5BlYOVIHvOCbEtEojGVgxbs6iIM6lqgWpYs/h+GHgZWTCsNSQHU+eajhCO842pf5Shbkm8TspmlF2/RT0u48Uea+wfoT4+KSuHpiduLheguLNL5f7iOn0rAzbcAE/S7YxjMtAjBvt4rlkfY+cCA7+qcDW6h4i6deQLnfTUUfxbPECMywEsF3jmoU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dad1efa-8715-4b9c-a9a2-08def3d67dfc
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:19:29.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vikeSyoYDHjfQS5AM3eWA2gV81abvmjfJE+1tysHGfj7QCCNbnscrWoh2DmJUANiCanzUIazArIV7y47cr3UZxLEl3vC33xdXNMuf+9UpUBNLzykTZQ+x2eQij3z4yNZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608060126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyNyBTYWx0ZWRfX2K2tpeA2mKHQ
 Io1pCvJ5N+Wse1m1L/4FYWISVnBhRZ7d7wpcCFX2CuBISz2Aev/6LlYemN8Amsn/Ewj96FXbO47
 hQxBJbP7M7DkkZvTrgxTZ/xrAxDA614EM3reLwU0QiiFJrNqazlfjoofOQuvhAHlBVqk6F30up1
 FPLvjz5naETLFlk9QGTfWTzqM/GGXB6e0mtOWiMYknkt+sWdP8Bs906F5+HfS3fIrtFyGbiEKU6
 MffLJH9KDFqqoDAMpfysW+XjK3nS6N5qw5JJozL2hL6LYLf9g/CIOIPXYS2YuWYKJLp8d2M6iK7
 okWYJn39YzHDZLycvyArTKOP3TtOGXbRQWJiHe4GV7K2rJC5ltElM3i0GLPLa8KbrsUS56OU1Up
 +RJ9XftMkeFWQQsDhBbpqE9N0UsMMGbLUCoG2gn7SqXaXdv5iIThatLD2XhsTRq3MkZcFIrLhPW
 WT1a6D/rVjK+w/y6SSrHEjzoD/PZXGlVavR7bvQE=
X-Proofpoint-ORIG-GUID: oDE22NSxW2NDPI-v3oib5_Eyaq5Au365
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyNyBTYWx0ZWRfX59N6UQdEpzP1
 7ocntyMesZ4Pqwahkgv7w8bSh1sDXX5lgH4lB+DSrc1JRP3dFqXJzGLto20slinhgCk0jiBn5NU
 +Wnb98Vm75yQVrKzRts7f6QE5fTIz8CpuTefTz/73irvupshD/CY
X-Authority-Analysis: v=2.4 cv=ZOTnX37b c=1 sm=1 tr=0 ts=6a74b418 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=1XWaLZrsAAAA:8
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=pOaPYpXHUPaPqpBZVvwA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13510
X-Proofpoint-GUID: oDE22NSxW2NDPI-v3oib5_Eyaq5Au365

Hi Sasha

On 31/07/26 12:59 am, Sasha Levin wrote:
> From: David Matlack <dmatlack@google.com>
> 
> [ Upstream commit 6c882ef4fc7bd99b67ad152e75428b669281c521 ]
> 
> Rename __direct_map() to direct_map() since the leading underscores are
> unnecessary. This also makes the page fault handler names more
> consistent: kvm_tdp_mmu_page_fault() calls kvm_tdp_mmu_map() and
> direct_page_fault() calls direct_map().
> 
> Opportunistically make some trivial cleanups to comments that had to be
> modified anyway since they mentioned __direct_map(). Specifically, use
> "()" when referring to functions, and include kvm_tdp_mmu_map() among
> the various callers of disallowed_hugepage_adjust().
> 
> No functional change intended.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20220921173546.2674386-11-dmatlack@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I don't see them in queue-5.15 , FYI.

Also I think along with 6 prerequisites and final 7th patch, we also 
might need: commit: 9f33697ac7ff ("KVM: x86/mmu: Stop needlessly making 
MMU pages available for TDP MMU faults") should be a clean cherru-pick.


thanks,
harshit
> ---
>   arch/x86/kvm/mmu/mmu.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 04e814816b17..c274ab0ceff9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2991,11 +2991,11 @@ void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
>   	    is_shadow_present_pte(spte) &&
>   	    !is_large_pte(spte)) {
>   		/*
> -		 * A small SPTE exists for this pfn, but FNAME(fetch)
> -		 * and __direct_map would like to create a large PTE
> -		 * instead: just force them to go down another level,
> -		 * patching back for them into pfn the next 9 bits of
> -		 * the address.
> +		 * A small SPTE exists for this pfn, but FNAME(fetch),
> +		 * direct_map(), or kvm_tdp_mmu_map() would like to create a
> +		 * large PTE instead: just force them to go down another level,
> +		 * patching back for them into pfn the next 9 bits of the
> +		 * address.
>   		 */
>   		u64 page_mask = KVM_PAGES_PER_HPAGE(level) -
>   				KVM_PAGES_PER_HPAGE(level - 1);
> @@ -3004,9 +3004,9 @@ void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
>   	}
>   }
>   
> -static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> -			int map_writable, int max_level, kvm_pfn_t pfn,
> -			bool prefault, bool is_tdp)
> +static int direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> +		      int map_writable, int max_level, kvm_pfn_t pfn,
> +		      bool prefault, bool is_tdp)
>   {
>   	bool nx_huge_page_workaround_enabled = is_nx_huge_page_enabled();
>   	bool write = error_code & PFERR_WRITE_MASK;
> @@ -4037,8 +4037,8 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>   	if (r)
>   		goto out_unlock;
>   
> -	r = __direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
> -			 prefault, is_tdp);
> +	r = direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
> +		       prefault, is_tdp);
>   
>   out_unlock:
>   	write_unlock(&vcpu->kvm->mmu_lock);

