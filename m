Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714613A9D95
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 20:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950380; cv=fail; b=q8gd+WlpCMsLW5IBYibu21x8YpPty76PWCaR4EffuThUTrQfQl84QLXxss7f8B7srVVbpGBMQDyJj041KzFL0+ko2qgXYukyjKO2z1L3/gUsBhxrL+YvM0ux9/5xO/g/+KtKZHP2J5xZFCnnQL6JLVZygUfGNudeYjqDHM79Tvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950380; c=relaxed/simple;
	bh=simYlW767KWOCT55Ng2SF8UicGtgjviSPySnQtBtxqw=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=jIaRYnYQ0K2upJYOzB4H7DG5MdWL/M+aWMvKIFPMsP9Z+s1PFty588Ss5wsCfjmJ1e8fBQeocMJH1T0YgaPWPVoVY9yhrxWhSZH5mV6B2FIYlkoOqY6dRppUStDD9g4dE74S3kGsg3vzRRMz3+rmD44W77tF49lxG11MxA1YLPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kzEIsuGG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HVuJLbWa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kzEIsuGG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HVuJLbWa"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SHK0L7283094;
	Fri, 28 Aug 2026 20:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=b/Fe9OV90SEdLdss
	rqcek4CblAEgMOtMRjudJ6bTqQ4=; b=kzEIsuGG7Z2hprM4mGwCbr2SmMqH9vNd
	e7BiwvLqrOu0Vof7Vj6gK3xENw0SdzJ5G4vRkKNRc2MguL74b1nmoUFpFTRSsKuC
	Tev0qJReI7h2mh6zObKZbWqKKLaoy7pqA8JMpPy1PRa07MhT5ljc20SIne6hKYpn
	GuwY2ocL6Ecp62NqPIDwoRBXVr3gTOhNa8VKi8FlCXAx4yRkD0oTl1XS3yVKrekd
	5MS/86WAbDzN47ln+yhj7xNEu9MfkBsCCIWK8W9yHeQqFW02cut5pikNolGZhnDX
	uSTYxBZuEQ1TTTWQmeDA0yOh6Kxp347b8Vf/uVCEE+KFJiTnTi998g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g73tctrth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Aug 2026 20:52:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67SKoEfB031753;
	Fri, 28 Aug 2026 20:52:54 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012029.outbound.protection.outlook.com [40.107.200.29])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g85101eft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 20:52:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXDrdOcXD/5hTGnWjbkfxjm2NrQCzKkVovRA3mJDJibRCnRv+vXZBkhnQ5/xEdTJwW8U5Hoy+MsLATupFZtnE+CCyvJvMc7rZQjpmTHDOcdvs74Te0dsj6JuJAy2g01tlExWInNRe0sB0SY705m9Bzzwhw8wuvQeLo7Cj3I7nTqUMNh8r7F4PWI/ca99rzLxF/Twc2SJj/vPdM/L2NdMcTgtG27TZGw+RWimDvz6skhXkIi7rhaIw16j6ZPvQ/+kmSaW0lS7/6xPqGp0xfjbSDsma5caU9XKXbHd1tX4h4jc2bED5f/M3PCIqWX2qonx1llqYG9lHfeGMZ9aHFXTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/Fe9OV90SEdLdssrqcek4CblAEgMOtMRjudJ6bTqQ4=;
 b=cmgeiy9VbZW3KIUFSkJRHfN8XteUxIyKKP/ztUcAHvz1biPQn32TkOU2sHMulPmNGW57EX/gx9fG/JesKvk5qfHjChtFw6u5lwAoTAUvzrxsCxojJtvFUgzJp8qDHpyG3+Fa6e+5WuT1u8acQRptqLSUG2VnucNgbQnAJ5Mz4c28xdgiznTQdtK6nzXLK5l3x/beX74SDxAUG5Kp1lboLgjl+/I8+nhV8ti6IZK4IeBOIWVcIYN5sDkfKsRi6FLvTmpa+BR57Yk//FnaI1ny0sXGUJGXPtIJbUv4TXRanY+8j4u008YltPkfu6JZD1ozz05Y0ofJ06/LpZImnXS1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/Fe9OV90SEdLdssrqcek4CblAEgMOtMRjudJ6bTqQ4=;
 b=HVuJLbWa7W3xkwI5I2zERnhJc04Xfwm4g5BWp1r//7TK/nmzvi7Y/0R+b17BEYR5jS8AjJScwV6GODhtl9TkProNmH3MxpvfzQ3MEkN/zBcmg7Ig20qvSuMEqIYfaFu2pnXWvqu3gDSgK98Xhg8fUQQkS1RhVHY44nfWZYCQw4k=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by PH8PR10MB6359.namprd10.prod.outlook.com (2603:10b6:510:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Fri, 28 Aug
 2026 20:52:49 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.21.0382.007; Fri, 28 Aug 2026
 20:52:49 +0000
Message-ID: <ab4f47f6-9232-4ff8-83f8-ec96e7e19e14@oracle.com>
Date: Sat, 29 Aug 2026 02:22:44 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Stable backport AI reviews question
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0337.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::14) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|PH8PR10MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b75514-50a9-4985-3c60-08df0546521a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	P3pWZrrba8GqhIyXlT7Q7z7bYbrVnAI8nUr7eV375LNHLj4eTK68PXqB9AuIUVGxN5gDOWefl3KkRovo2k3Trbfms/u9bMiHn/HO0EzWtexqR7ZqXoGDrzCszELEYVhTP3PVUWtJabEyAQJwBRfnl0fEr00aAglXM3YPYYT037JWmTUY6Z3THk+4mR6w85FCM6fbOONGP0evUvp15i94F9Le4y2joqToJ5w//UHZGYDYl5KR82CnaaMFahfJGp+9PBP6r57PYbz05hxLVyRC2C4wY4Vzoi6qmw/e9kEiqr+p8rKTlU2dY0Iby7upIokyKxAy0Nlum84b9pE5Gqs76yvKtRq6+6QrKAPoCuN266YGfxPtcWjXJW6aTpW3xsTqSML8rT2cek1SbnJ7qyDoqCUBi4wf+cnGj0XItZjJZdoLQMVpyaxX3UmuyOKPTWPHYjCH4NzfD8takrN7RG1uwE89APAp7Qx0sgAa9MOFR9sFAa2f+uhFfQZQ3wnFc3sd9vNafpCJLeKjvzswRf1C4MTQ2PraTVTRcmx3ce7atnkyPVC6ynfByAWv+UT0/9yGR8aBmFsMIPWvaFn93eTt3MBG51VlF5XV471M0E77k4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0R6M0VCaGFjTXBpRmY2WmlSZEZpbjJ2VWY0aklLa1RjQytLYVZhWHhSVm9R?=
 =?utf-8?B?UzhLTUpIelpLMGNlWGx6Tm9ZNnNHa3plRnF0akdtZFpQTTYyeCtnNU1QdjZQ?=
 =?utf-8?B?R2N6ZHdXUU41MXhNUEczWFFBck10eVJGbGdZK3ZLVVh0WlJXdFlJYW5BaWI4?=
 =?utf-8?B?bkRsclVMZ2tWTVFPbkFNSGg4bmJyYTc5b3pvM0FLTmZQd3BYVXlqZXNGSWUr?=
 =?utf-8?B?d2d1RVFlNGlYTS85QVBOdTRxY3VvVUJQSVJ2Y2FqanZLSVMzQmlrODl6TVA1?=
 =?utf-8?B?cmlxU0JFeEI1eGRhYm9LZjRkQ3ZGVERTVXcrTS9QTzJmd0FoT3VPUkJNbmsw?=
 =?utf-8?B?cnlySDAzaVZoSEllamNKcnZFVjZHVEsrOTM0M0tNRE9XMUIyazZiVlFnVmw3?=
 =?utf-8?B?a1ZQSzlOQkN3WHdxZ29OS3RVNVlESi9vOFRESGpTaDFqYVlzVmFSL2M4Zkpu?=
 =?utf-8?B?dGxCTXRvNFM5SmlJRExVa3NzcllZblY4ak1uYlFlbGMraUh0QjZPc0hzQXhO?=
 =?utf-8?B?NVdPbWh3NktXaHJERmd5bllIRmgrVHU4NW1ja1pSUmY1Y1k2VlFaRkVYOUJr?=
 =?utf-8?B?NHNZSlVvWFhUZWZORzlLYUlEc01zU1lTdUhlNXZvbit6dkphR3FsTUJJS2dG?=
 =?utf-8?B?Y1UvOUl1L3lzdW1qMVN4aG5BUFRtUHV5NFV6SWNjNkx1eGdnaUM4akFhSDJ2?=
 =?utf-8?B?YWllT3IxK1l1Tk1qcHRtblJWbVgzWXFmRGFCWjc1QnlsQXdsM1RnVFBsWndS?=
 =?utf-8?B?OVJ5Mmc0b3dlVk50d0NCWTlBeWVVMzNIcElEQ2xFaW0yOWs0NVcvL0s0RnNz?=
 =?utf-8?B?eGhQQlN4ZjJQeW9CRUdvc2Q4S3Q3cFhWTXdaOWxmNCtzcmRqOFpadUdNTnlx?=
 =?utf-8?B?eEFGV2JiMlhoaVBQN3JXZjhSNWlESFhYSzdZRXhPbUVIZlBKZW9mbGc3UnNB?=
 =?utf-8?B?MEZUZDloV0U0dTJDNkw2dTArV0JUTXhmN2NHMW5CUjFsT3MraTBQcUsrc0xL?=
 =?utf-8?B?b2cvWHU4MVdra3g1YjRrbnhleUNWVDVYck14UEUzc0Nmb00vblB1dndLRllG?=
 =?utf-8?B?R3JUZjRhbnpGNmwwSlIxVjZWU0d4L1FzRWMrWHluNTU5TzNlekRXZExFTjhM?=
 =?utf-8?B?MHpUSW5nNTN1ZzNYNW1xQjEzSXZtZUFmTFQ4UmxBTFlXOVFYSjRraDFWbHZY?=
 =?utf-8?B?YktjcmdOYW1vOSs4cUhwYzJ0WURwK1ZJMmNJQnd4UkZtM2JENDdxbk9ZMzda?=
 =?utf-8?B?cjI1UWwxVElmcWtkOUdpWG1pZ1VhMGFlR3VQYm0wRnJBb28wMU50Z2ZNNHRw?=
 =?utf-8?B?SHUxZXk0YzBiOUhIZ3FKSUtzMkhGYkdaYmhYS3NNMDZ4NkhTZ0JwSGNBaW5T?=
 =?utf-8?B?cFZuN0E3cFRZT2RwanhjeXp5TnZPQ3FpaTdzQXhvTGxmaTZZZEJ0UWRxcEdL?=
 =?utf-8?B?bHRPdkhIeW1McXkyWm5jbjhCYWNhQUNwbjdkditBZHRYM3pickRwY1JnRDRs?=
 =?utf-8?B?dzR0Z3dtV2ZuUzF0Qlc0UEw5alVoSnlqM2lyS0phSHVBb2tqa3FZQjFLczdW?=
 =?utf-8?B?S0hSTjMvMW5ScW9majBQMDF0VGg5K3JWVXRaYzhTR05scFFpVkkxZnhXU2lW?=
 =?utf-8?B?a1lMWjBRa3BHeXlNclVDd3hYbUlRSjZQbTFadXFHOWRVaWxaeXVKMHNPdC83?=
 =?utf-8?B?K3dyRzRsZ0liemdRVHRPeTMzTjRWVTN2U09yUE9Pa1QrU3Z0c3g4dFp4U0I0?=
 =?utf-8?B?c1paaWdHWW8zWERCbHhHakxUZUZCZ20vazRzNVdUVDJDOTlzc3RxLzc2Z2Y0?=
 =?utf-8?B?QWttNUFNRTQ4WTlpZU90WmczQzg2eDNsbFo1MWxsWHVBY0VWUndCSU41bTh5?=
 =?utf-8?B?Nm82OHRYbkJQWmFxY1BwVFdqQ0oyK20zVWc3TVFjZUZFdUE5WnNTQ3ZTN2d6?=
 =?utf-8?B?MnlERHA3c1ZjNGViK2pHZ2VxYS9VdVZNN1VmVFhRdk42ajZ5UmxsdXM1ZDNM?=
 =?utf-8?B?RGQ3QnVNRHQ3N3RsZ1FqUS9nVmpSUy9JeXA3Q3JwNzd5VXpxaFdBd29LN2xj?=
 =?utf-8?B?SG1xWmtvMWhMbXVoSys0RVAyNDU1OXM5SnladDNMVmk0RHF4UW1JaUtRVmw0?=
 =?utf-8?B?ZTRSNWxReXZZKzZkNktELzhUOWRVdnRJSlhwRWd5RzBReUdtQ2hyb0REZlJ6?=
 =?utf-8?B?VG9vSlJCUFhQa2RRRHY1UUZ4TnVPWklsa2VVSE92emp4V0syQ1M0QVFFOUJF?=
 =?utf-8?B?cTEwRVh0SDhoRUdhZ0NEQlA5Y042OUxRM05kMjJlSk9OWlZxNDRWZEE4Nits?=
 =?utf-8?B?TloySnB4bUFNaExUOVdycjZRSTVEQkFQNDZxZXBlWjk0TTYweDZpampsSDFW?=
 =?utf-8?Q?ez1SGcW5ZzzUc4BCMzEjjaMnWlQHiGi8ztWh0?=
X-Exchange-RoutingPolicyChecked:
	VcJRVfAvrG4TVG4Qo9GA8SBS+k6ZoctloO2qQZ8Bg9IeDkHUGcaE3iDKCiQi6ugOwjEavPG/5WJzqtZ265alo1MFMCZikMGu/lczB77PeySDbAwrib0OXZY196e7S2bWD4pw68IM58huA4nmtexFB3S0yiR07B/2jIMQ7RVVY0qMDiUEVCWgkMLwAZLIc5I2Znp6DnWXcXOf1pzfo4vKE4HeWHRb2M8KLTtM1hGzPBrhIUQKNvyeegHakugW3gOsnMYvHvNAfX4g50m5q7pnKml+XddiJTqJNsYFj2/alIYh3jWIv7BanggAfag92D/UGutwLQu+rcowoDB2vyCRIw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d1y7kdPEZt+DIYzrfmnFRvh685C01idwABiOCsb53SESFIpeerXHvn5Kn4aEFjNWgS9J+toaXfQmgROZLXZXiAWEFGkT+0ANAogYaLn6t1A/zljacRl2O7rao05p0K2dfzS+rhJpPSPBeVhkUO+sAM7jbZg4O8Zp2R/gQsJ1iqyBW/H2rMZF4Y3RBXN1fWY+eFHp2xzbMLntuj3fjQDbeqAT+6zhoh+Nt1J7nSR0T9IMeqrebOlYbD0TxvcZwNiS0fLuaup2uBsWaiFq2eiTRmJAF5JgZns+o31nPqq8kGlnkEloTT8ax5poOwXLzaZ1X1Ych17dMvZDBoh9Ly5micTOgkj2ERSKGVphFmc5qQhN9FFDhAUW++HvMQf7kI7DC93IRpk11P1KwdwUYsJTBIqvEjqaMTiWOCMbBNjnU2lZycu87Wr91SOkSodEsAM4sfpthBiu3Yfb0LIZls6VCnevU525hnGeqymH2bUAub8aeug6cwWOVJDDpCnzyYkuiTNiTcKlTQhC2DAj4TJ4hsWMuzq/Nqmu0cxWKk9Bs74hIw8U1MmqqD6pBIqzDrxI412Ss6jl3HXiH/P51vNjywT92/7zDTg/+do74+FaI6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b75514-50a9-4985-3c60-08df0546521a
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 20:52:49.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUgzfQU0fdwzOqviAkgH54FFrQJLS2nz6nSzE2FR5zw4tyEP20Oc5njdOFeMicl/X60E1LkL9+AyPyh6R3KwDnGEUrI04IVcc1JbYcKlkbnjnv9JVsdiMAKw1IJqFCBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=818 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608280181
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE4MiBTYWx0ZWRfX2v1l9BV7uWCv
 3uUAxQBmaekpup3jPtFibC4DOBSZuW5tsnXLFR5heNH3vognsoTfEdM2NzlsWnrBSnJafRrtzog
 /Sjv9Tm5otBH+0n+u36j+Bhh2JjeD16gx7fgawE62BFshy7M24KV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE4MiBTYWx0ZWRfX0z1jNcAY6/z1
 v2lVM+bYawfBMBxoFf+p6qpfoePO0upsBveJXp77KkEzXEimB+UO6rYqd44s39F5gMnK/FpuBSJ
 koGu8N1TNN4+d/GJk37/PV52SeT6esln5mbW1V4XCSsYyMnBouGQvwOQsx1+vhlgSAgXa7G77CB
 Pp1HYnnk3yhAo3lavOiKxmkrE2gQW6hTI3YobE2QyjW5gNYhk6x8Bt9ug/y0NCiZEDADq/GD/XZ
 54uAYE/2guJcIcj02zaYZPeTh7KvXrskIItdFqf1EdivTGjFhpigyLz1cjk5d1pOGO+F4RGbHiF
 302FgoVsN3gJrugVSmJ4OpxMisrLDVzCCdq8ohv7XauPLClC6KFf7C6qPKvQBFUUILC9gak8o6f
 A6nZOWqIyLbhoHziZezhRmKGA2QvRUTYyap85Zf+QXUvY1fgfhG1EzYMaUbQfudvPPfhQfLDrIq
 Nv8icN5ybDtfkjYMcYw==
X-Proofpoint-GUID: 6POJ4HTWCn_dr8Iwh1D_q6762kj3H1K0
X-Proofpoint-ORIG-GUID: 6POJ4HTWCn_dr8Iwh1D_q6762kj3H1K0
X-Authority-Analysis: v=2.4 cv=bq98wkai c=1 sm=1 tr=0 ts=6a91f527 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=XBYTcC3t-2TnLNB7H_wA:9 a=QEXdDO2ut3YA:10

Hi Greg, and Sasha,

I hope you are doing well.

I have been doing some AI assisted review for stable backports. Few 
examples are available here:
https://lore.kernel.org/all/?q=f%3AHarshit+AI-assisted

Sometimes I am unable to complete a review within the 48-hour review 
window of rc cycle. Would it still be useful to report any problems I 
find after the stable release candidate has been published?

Thanks,
Harshit
