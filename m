Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793670881;
	b=0lH1BN/2SxwzP2fFdKejCxQGMAWL50fqxhYj0J+KUq38V6aTqRJvjJizmfEe/Kb7Qhkz
	 s/3EoRTt4nvowimcE+WFZWMzoP5BjxhraChsX5egBTobpkeeZSGq5119XYJqjMmMgS42K
	 qCr6VbmagNbdbQKv4vA1WPU2a1not2LgzcMy95C4oceO/eHlvtB/28M4M3hQ6oYY00AAi
	 zoEFthmAr+xD1Sp98Is1nr7iPSSgCr3aJGinl/2pB2SDyMvHOIYBhpLzaurOv6CyCp5N4
	 N+KSzFRGCl0LRNQiRQ8u1u9eVOpBFQHI7G5u1eqXPJoBO8aJnOqiMRBS+eczjUoI3JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670881;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis;
	bh=13bFW0v9jvf4p8LUMzy5R4OSuAi+NA5C4e1vHREHwAs=;
	b=EGQXMQ6+31tW3d+LrS1kdh2InbvajPMEOS1p68jiaAPFFmOWUJ4ZqWTy1YBxNWhx0MPe
	 5kRu7lDUnOjdCdLsYDf+kRRyniy2VoQIFWydxrQFMsrzOy4tQ44ExWpZIIExmKY6D+9Wv
	 vCjxm6uMBU5+idU2gHGjpDplIA4MNw3f7IAv+Bxle+sW11aR2xqN8uTRWetJHJ5HFDgz1
	 Ke8FB9zZIHzsaia28kXhd6gamGhhSkOriCyGlpZkbcxS0ODHm5RkiL8ir+khiFkwBR3l1
	 YwalXwIGuJYvkFMeDFkjHmBe1QPDpujJeqSRunl/1X8HLzGlqIxAty36Tl6BBtsiT8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b="jQvW/ZBd";
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=CfuMSzFn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE1606A33B;
	Tue,  3 Nov 2026 01:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEDE1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=jQvW/ZBd;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=CfuMSzFn
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2KXeEl3937192;
	Tue, 3 Nov 2026 01:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=13bFW0v9jvf4p8LUMzy5R4OSuAi+NA5C4e1vHREHwAs=; b=
	jQvW/ZBdYbpoxs8WtV4/xxbMt5bCsbhXrMxvxG8sGyZjK7AV+GrWEqaePkGBkqE4
	jT5U0ndwQ/fyVNzzCSWI7p7luK1a1KTn/mUEyBT8dIzUkHR8/e0ixwDn1GKhj4eU
	yuzIA4nsn6/Y+YjPRFZxK3pkn+YYXF1i1BS45WmcHT+hJ6OU9j8nm2KnuGAYERm1
	DrGDYK5oTWU6/rcP5UU+UpwfeQf54dZlVtZUZgx45YaOgQCJHmZx1Vk4FMFQtgdj
	rQQAHeLDDUAiSio9xkZ80omKmCXAkRzyKXrHDbrGd7jm9oxzRMshQnOg1S/8JQKs
	jBZ38GiUuLD0BAi/lCe4dg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn8cfu2q6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 03 Nov 2026 01:54:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31h3OF3634914;
	Tue, 3 Nov 2026 01:54:35 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hq60d0h3y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Tue, 03 Nov 2026 01:54:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6PIdFmmDicpMpwK2+qw1L3jhKbi3RxrMt/Tf5eRAV7aBer8IdZzAtE9j19wgmXRDV+5/MzxkC2juPaTbb1sQJvfbX1N5skqFBGsGhmOEFD4ntRrH5nI1COTlzpo8+FpRRW0oqh8RmThMuo72MsLyR9zB0PFYNrSdnoRQFoHhp+ddjTx8iu1Qn1rCfIAftGXKZAUAsHI4QxTdmRjCUby0zQC0DRDA0FIBV2L7nc1U4OYGTsDipQu6jD8yzaTJEU45R/24WSt9usHaYCp9hVxn67AoMAzKUo0KRfka/RJcW/0wszQ+QM1N3bGNbQ+jHfkvKra+QFwkgGG38cpqcpA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13bFW0v9jvf4p8LUMzy5R4OSuAi+NA5C4e1vHREHwAs=;
 b=aJKs7dNRGCaWC+Jk9nKccglPhnHOi2A+d+In9ErwokdNsOTu8M2Iy9yw10STxYTqWQjoMLJvHtCKixI6+AfMU3kAZQXmY6anfMDOuz3EknbFpe5rGqJqOh7ZDgPZTgmF4zEdBZEhSCC2g7BHwVzR0/0ZXD5r0fH67NZV1KlQB7g7YQkEs5jpCZfndFjTxQ7euCzM6BoZRHxLVcpvBqSrT4ECpNssV5m29CVUXY4JE1OIWOFrj+ZJWrdJHdUmzHDvUNczL4emb9oHlVgUv4toAl6+OU9HzHuqlndh3pEx4XW2v/p6e3+nrEdmHiucfZ2pZO02NebzRUkm2SLvqE3spw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13bFW0v9jvf4p8LUMzy5R4OSuAi+NA5C4e1vHREHwAs=;
 b=CfuMSzFnNjbT2QGPugAir2RJ7vby3yFcZHWnw070yugk0yDxmuuIr2q+taKJvMUN7t0oBPwGvkd91FkSmrHDuGgt//KTGg6RnDfCRImhW/7J636ou78lS9kntPP1o6TaooovsMB09lC57I98bONbekyY7iy1KrtwofOduZeyd/c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4261.namprd10.prod.outlook.com (2603:10b6:610:7d::23)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 01:54:32 +0000
Received: from CH2PR10MB4261.namprd10.prod.outlook.com
 ([fe80::fd17:1c07:31b4:a8aa]) by CH2PR10MB4261.namprd10.prod.outlook.com
 ([fe80::fd17:1c07:31b4:a8aa%6]) with mapi id 15.21.0569.009; Tue, 3 Nov 2026
 01:54:32 +0000
Message-ID: <655b611e-9b04-4f6e-abd8-3fefcd6e01ab@oracle.com>
Date: Mon, 2 Nov 2026 17:54:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vhost-vdpa: fix pinned page leak in
 vhost_vdpa_pa_map() error path
To: Tal Zussman <tz2294@columbia.edu>, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
 <20261031-vhost-vdpa-unpin-v1-1-94ffc9683256@columbia.edu>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20261031-vhost-vdpa-unpin-v1-1-94ffc9683256@columbia.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::7) To CH2PR10MB4261.namprd10.prod.outlook.com
 (2603:10b6:610:7d::23)
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
X-MS-TrafficTypeDiagnostic: CH2PR10MB4261:EE_|CH2PR10MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c191dec-a11c-4832-cb75-08df394d67aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|42112799006|1800799024|23010399003|366016|6133799003|10067099003|18002099003|261102123227099003|22082099003|56012099006|4143699003|261022105027099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	H3ihjVouzrbtuPGseSKBpU/k4qzXrDTneaDF0qkcwDzxFBR/iu7RaF1l0oa8Y+TbrKVtaqijW2CnJT33TjLydPcgVY0rxZEfEK3o9HepuWvthNbCDJnx30uzZ4VN+eO27V2brkTEA90uI7SM3i/cDYqdjVE9Em4FcPlTCE0sKa835TfaYj4GqLEcOHAOz+Wj+9PskJJDcRAThTPJpGtLyYL9XnitZNbSyj0mKMrpVRBdMhPwGTCPGvOr0gk6jLakb4i9V77J9RDgYa5dWDFLSG2aGHIGCo3vn1WTgqDTx7/ENShRTRqaKHouNAN54tX4B/ZGw8HSdZ/6MY5yqKt9rxBipJaE8cQd3Th7sgaHptX3NazczE7SxalsysEP/VQ0gnrNx6+7QwWwK6fDggfCSSl68ANDL1Lubb8nVSqO7scsYMoJX69+h21islilULlk4+saEQlHcrN0iFzVw/DcL4Wc+WSaP+G0rToCPv3MpkZ2aAs2n26WphhyyfVWRLSxKpi5++CIYLMztoLXJ3WETC3UIByFGxe6VNNQKVRCTKQOudntOVBXJtlrMy4dZVprokLKhLdMS/1swuhwsQjMol6LZZ0BNbtcCZADdhR5B8dOUYCAANFdG6khTYNcGeDa5gddEu45nEkxSiVpqRrpyhvysgG1ojKCgmZ1kXvcPoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(4143699003)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkd0TUFFSjhmdW5hQmFGRTlMQjBVbDBqQ05CbmdaWHdYVUdpekJEaVZyTFRK?=
 =?utf-8?B?MkJwZ0c1NVlqaE0vaGlKUmxhY2RqRlY3QWwzWUdCRG9UQmtKQjQrNkJFVHpa?=
 =?utf-8?B?aFdnZmdzYmFYLzVRTThjbEtjYmRyOHhrU2I5bndXb3hzYnF1SFB3S0FpUVVE?=
 =?utf-8?B?TnVqWGhpOW1vbGVJQzFTTjdITlVuS2RuZTAySjZUQkIvS0gxNjBOVFA1ejI2?=
 =?utf-8?B?d0lGOWlneDcyTGRSdm8zaFZEcHZIRmZtSDkrUXZ4RFMrc0FaNUpsWmZPNVVX?=
 =?utf-8?B?WWM0WXJLR0JDNmg1Z3pmbkY1RGR2bDUrdllLVHU0QUJ0eW5wY3RpQmVYVzk2?=
 =?utf-8?B?K2NnNGhyU1lneWowdGwwU2E5UHg5S1V4QWNiU0dYR2dBeVNWODZuOVZIV215?=
 =?utf-8?B?YjBkSlltL3p2SFhzT0t4R1RnRWZaM1dJRy9pUG5USzhPYmp3T3E2U1VhSVBC?=
 =?utf-8?B?cjJXUk55czVMQWdIRmp0SDFlWi95R0tTbEF2SEg0c2IvMnplV2pNeitFWHpG?=
 =?utf-8?B?cFFOK25HRjc4QVhkME4wTzJzZGdFZW44TnpzRUFqZEI2NTJqaXVQTTkydVVo?=
 =?utf-8?B?SmtJUVRRSkIyUCtFdjlqa29nSEJ1d0NNb1FQb3haZ2JtU0NSRGQza1BWaXNI?=
 =?utf-8?B?eWgyZTJqdU5QWVNKSnlYTDBaWml1UC8vODVZQWNuUGlOYkFZL1pFek9WRGpX?=
 =?utf-8?B?RFBHNjZXdTZybERFNEtGSlFxNlFFM1E1WFhhYWNUMG95bTJPT1YxazNLTXg1?=
 =?utf-8?B?T1RyUGg5ejZGeXpydmZjZnhHUEcvMFc2M01ham5sSHAyeUVncnBtZy9BdTFW?=
 =?utf-8?B?VjQwRHJkTW8yd1ZNUm5qczNKTVBNUmhEdGh0UzhmbGIzaTNNRHJqUVpGTFlr?=
 =?utf-8?B?dnlicFhuU3g3SnIyTEpkMWg4dEtCd0t3OEpNM2NteU5aVWRIWnJBUkJoVm8y?=
 =?utf-8?B?Tk1WMHRqTVNJaFZzZ0JwSEZnanJ6eUs5cVdYU3M4UE92eCt0d3IvMG43ajNR?=
 =?utf-8?B?YTBVa3FqODlyMWZWYk5MbzRFYjVUSDVvTjNnZllaYU9ZS2ZBUGgvVHJrNjU5?=
 =?utf-8?B?UTBXaFZCYURkMkVreW9KaHdLb205Z3RtUkdSa3ZrNEx3emMxQ3UyUHRHS3pn?=
 =?utf-8?B?UG90aDBvKzhGM1pUVzdtRWx1UEVJeDhRaWpRT2owRW9sZmpQM0Y1bjNlVk40?=
 =?utf-8?B?V0tKVklUREp6R0tNVHoxaW95UENSckppa3BxVVJGemlOdDM2M1phVlVQdFY0?=
 =?utf-8?B?YlBLcGlBQ3pXOGt1WjJpMERlaituZUEvcWd4M3kreEQyeTFsbHRHN3NMbzh0?=
 =?utf-8?B?a2EyanJ3cDNuY0ZWTEYzbkFRd2p0OE1vMVFGUVE2T0wrbUpDdUpNOEpscEFV?=
 =?utf-8?B?NXJLZkhQQ0syREZjcncwTUFIMlJTVVM0UWNSZDJoWGt1SlJuVXFGTWtnU29y?=
 =?utf-8?B?dGd3aGtlNkFwNTFDREpYRU5kNzY1c21QU0Uxc1FsRWhvcFVhYTN6ZFNHMDhZ?=
 =?utf-8?B?eGR6QXlhUDNQUkhSeDhHaEo3bTRWYnN5ZlZCZ1N4Zitla2pzUzNSWDFBcVRx?=
 =?utf-8?B?dmhOWnlrb0tPUWxSZEtWU29HT3JxTGNBQnI4b0ZVem92T3lLVlZCampCaUEz?=
 =?utf-8?B?S2Y0RWZWVjdhRjdjQWxFR1laSzU3QjVTSkt0M0xBMnBRUlZHY0lTWXF1UTI3?=
 =?utf-8?B?ZGRTL20vTmIrak5YN1JOUE54WVh1SmRRc3JRRlFsaXJvbTFveVFFNUVjSkoy?=
 =?utf-8?B?NDhlc2pyOTU0cnVoOVd1TlVweXNSL1BYSW85RGpPQXZlNVZCNmt6djNENnJj?=
 =?utf-8?B?MXc4akgwVEFTb0RITmZZQUwwTVhIaE1OOUlKeE5rOUJJcXJJR2IyN0pPWXZx?=
 =?utf-8?B?aXRtcllyYVduNGFacDBCbmZNTFkvY3U3M1VUYlY1RnB2N1N5YnRKNmVPVzJN?=
 =?utf-8?B?NEZjbkJBOHF0d1FiVDNEYlhjbTEyR1lQblZPVzQ0aXlRMythMXRxbEtOT3lZ?=
 =?utf-8?B?ZlJ4U1ZmdXZFQ2JCSS81SnhtemFTNTAxc2RyVWFpV3RoK2NBbGk3M3d2YW5I?=
 =?utf-8?B?SjRoUnU0OCtJUWZxamluaHpyRGhiZ2NjRmRNNm5TSTBzOEpMaE9OS3ZvdXRH?=
 =?utf-8?B?TTg4cUN5MFl6TWt3aWtjcE1objA0cnlHQnlHK1FGUExpVW9qdjVJRGRYUEVr?=
 =?utf-8?B?LzdjczhITmJ5eVYyZHdXZ21jY2poQmM0YmJsMWJ3T0VTSHhmeDduQUJKNHdX?=
 =?utf-8?B?b2tTenFLWk0wMUxCNHAzVEtJUnVHMEpweFkvQUpiTElQS0hXWFpmd3l0cWI3?=
 =?utf-8?B?YXA4VCtGNUJIMklPSzhOL0s3bDNObGJocTY4cWFSWDRKdWo1ZjYwdz09?=
X-Exchange-RoutingPolicyChecked:
	X1U2aBIyu57iubTQG4vJ2WX/L/zav7kHK7kPtwmVUpqRDJ3Eb3iiRPZPH4yP8XW/WQqDkaJSBaPxRMYC8iSND/DfCx4jcHGnZq9arqI0tac+g9+ZWZoKUcvZYqfm6gZy9ymBmfim1/O8FWbrNsUPJEQFoWR1eH6QwkkoziJ+4UWxrvGJQUHN06vbfMGXxQPnt9hsh2csuSSKL+HN3bN5IDYZ2FL/dxSy/0ukgvpxUHl3V3dUY3XVVGZKbbL/ucqg0vOP5qV30AX71tfGwNaDwGNDS3CP05iXdmJoG/9re20dqcmgcDwQGeQXox6hIHpSetbdiNKM+F6W/kyTcV/zGQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dqD7eCDwCZ6uH0fX99XBTh2pV1BPsQzS0OdAXd6AdqsaljikyrwjEvJc9qILiHO3YFpusoD3yQk5NubHbRw4dgIK84JDCChcUVJVu8NaBEe3f1E7dsNbynBL8UdzjMNI6yXK73qrf0q95OKraYUT+5cFH3jcjmWCYcsDfqw0jFbHcEf5SaI4LuQ0ca3NBsyWSLODRHK9w/FnXhMk50JpH7oL3mr/84RsDmpOHpzaOJxem41HC1SM8Ivby0ZQU1OoP198/aw5qBPuUGcvLIX7gYI3DtjZawZ49x52D01yxZUK9RW7T8L/vF3ngn4plb3hWL3yineD9TqSn3wKvIwAcy4QLvLpl6TeFRbL3CH2t1Vp/BtdoYfWkBeuN1COlvYO0Mzgi0d+nJtfO0NymuYyTYI50Do+O8czmYnQBjmmpH0wldQzrdyME4P85sXHWKKirS7Ye/U7BSs9rOcLeoeTpNtvTMC/k6861PSjUoY2weAXvkrKrLOJUmHU9/t/H7Bz78brU3LHq/lDIzaREm+62rC6vCEBc/vuqtHGz3wpgky+wMYSt5InwFN23TdITQmVHIgEx8bG/IUgIbPERIiqsxoMwgajpTY3O+FCO/wieyE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c191dec-a11c-4832-cb75-08df394d67aa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 01:54:32.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9aCxxtY1AicYxSzQCBwoS/Y3l5fZfjgqaAt7/BuBzi4HtdXut9riPk5z44Ipy4YoD1DedKrOVR7CAzV+OyniA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611030007
X-Proofpoint-ORIG-GUID: IL6CG2ZHmGlNWwU05X9R9V4gEk8A3_kk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAwNyBTYWx0ZWRfXzq/mD3YVONac
 0FmB7IFYatR4ejtk6w8YHYTOdNmtpCiW9f9WvRntaZTnjG9fvO5RAv0t6HDK80/J4mGAxZF+i0h
 0KZmMx+mklbtt2BP5mu7kbNSr7q8HJoV7P7Y0PR2SDy8SQZcZBo4PHDX2puSsL8/yCI0ufkGvKJ
 y/jdxhDLjhOLeJMfd8zUn5Sov6iR48VL/U+UfRzlcVS0TtGAWbPbGRW8lCi4zDICysKmC+AZJYe
 MNJyW3ii/xi2DKx+s0mJUzSC5T8DXQwerkpD7hR1woLJcDl3SMYlFeVxDnF6rR9BI3tn12JXSie
 U+2G6N7AAiPnFTuP7HgWHwwn/QWKb33bSNRl5MoYqVSVVgq7hQpq1xLqlLrbXriYcpfkDVPUktP
 sqilPUkIV00cQvN25c/9lc2tx8mlG1N2bOlJb3r0eUHjZreTpUQkcX8IuthnPh+YvTQI2OyUb0T
 jU5Smj4kZtJonomFaASvI3o2d1aiPz7ywAzNeyag=
X-Proofpoint-GUID: IL6CG2ZHmGlNWwU05X9R9V4gEk8A3_kk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAwNyBTYWx0ZWRfX7VXztsL85LrY
 xzKDAZefDWs7QugYGZU2vtatpAu/ym04R74SISb23IG0Tqgc2O6lBgUjUrvMDsJZYS/TiivldAw
 RyBW8HcAxd/hNW5h8Fh+vBlBIOqcYwIl3Bcjq+807jm/giBWSbNA
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ae93edb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=fVNGNZ_F2ZD5tW3CtwYA:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101

Good catch! Thanks for the fix, it looks good to me.

On 10/31/2026 10:45 AM, Tal Zussman wrote:
> When pin_user_pages() or vhost_vdpa_map() fails, vhost_vdpa_pa_map()
> is supposed to unpin the pages pinned after the last successfully
> mapped chunk, i.e. the range [map_pfn, last_pfn]. The unpin is guarded
> by nchunks, but nchunks is reset to 0 every time a chunk is mapped from
> inside the current page list, so a failure after any such boundary
> leaves that pending range pinned forever. With physically scattered
> memory nearly every page list contains a boundary, so the leak happens
> on practically every failed IOTLB update.
>
> The pending range is non-empty exactly when a page has been pinned,
> which last_pfn already tells us, so drop nchunks and test last_pfn.
>
> Fixes: ad89653f79f1 ("vhost-vdpa: fix page pinning leakage in error path (rework)")
> Cc: stable@vger.kernel.org
Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>

> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>   drivers/vhost/vdpa.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ff7d90719171..d9af728942b3 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1151,7 +1151,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>   	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
>   	unsigned int gup_flags = FOLL_LONGTERM;
>   	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> -	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long lock_limit, sz2pin, i;
>   	unsigned long page_offset;
>   	u64 start = iova;
>   	long pinned;
> @@ -1187,7 +1187,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>   
>   	cur_base = uaddr & PAGE_MASK;
>   	iova &= PAGE_MASK;
> -	nchunks = 0;
>   
>   	while (npages) {
>   		sz2pin = min_t(unsigned long, npages, list_size);
> @@ -1202,7 +1201,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>   			}
>   			goto out;
>   		}
> -		nchunks++;
>   
>   		if (!last_pfn)
>   			map_pfn = page_to_pfn(page_list[0]);
> @@ -1233,7 +1231,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>   
>   				map_pfn = this_pfn;
>   				iova += csize;
> -				nchunks = 0;
>   			}
>   
>   			last_pfn = this_pfn;
> @@ -1248,7 +1245,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>   			     PFN_PHYS(map_pfn), perm, NULL);
>   out:
>   	if (ret) {
> -		if (nchunks) {
> +		if (last_pfn) {
>   			unsigned long pfn;
>   
>   			/*
> @@ -1260,7 +1257,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>   			 * the corresponding unpinning will be handled by
>   			 * vdpa_unmap().
>   			 */
> -			WARN_ON(!last_pfn);
>   			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
>   				unpin_user_page(pfn_to_page(pfn));
>   		}
>
> -- 
> 2.39.5

