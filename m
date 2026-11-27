Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795809944;
	b=kDf/f6X84/nFvOBL753fZDVncmE49aXdsGzufAL8vPRoUOxbjshDlQNBwcxpUhltmTaz
	 szZiFgt3IHFnhH81pO3uTA2pQ48Va0nZ/YIjrSD/tWcqofqfxJqxBSViMOTUjGqtU1QRd
	 GAekhwB97ciAhqXRYLodI+Po2QR3sXsd9fnlMUHmZdHBBtYfL4Bl4iU0QbBNCJ0j65NI5
	 YSATzpZIv47jd83n6OKpv8Uz8HEYxQdPTuOJANN393QOex2jZMVCW4W7C7tsGvexXb5eR
	 sHuFBplWpOV5C26KkRdVmH7aEqhGC3ktuM2E3G67wxyD/hPEuEWORByvZJ9U9ZlBsIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809944;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:To:Content-Language:Cc:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID;
	bh=ibl6IQvetpW1H+Nk8S7sel1Grl3iyh+c8/l+FW5tK6Q=;
	b=zrzAHyqU8JMYMz+ZqwkWHrjaVBcDdq2U8L1zS9PZEeLXwcLQ3FU7WEPUwMFL0Yn+HAcH
	 mmcipc3dPGL/+bbAtV/NBRuUdawQe6+7gEI1ol5wfDCNrr7eaBcUEsjrqiCCXoxcSACOT
	 3zV+fPEkU90Az428ggJvgyVpP/kOrfS56YxLdkc5kcS40kTdhQK6CH8kJGLrjeYO+h/qg
	 bXhUeJZZowgB5ggsDayocLpO5P+8b72x73RJBgUpVBb3cd0vYNv+mABYImL1maiAzmz6T
	 F0gzlsK5Y8pgTTe2Q67/fKEhCH1UNpDn23Zv4L/W92NEP8Q+Zn0/I8c4CaoqLIv1Olg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=Sz2c2RIK;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=RbVOGA4r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7705B606A31E;
	Fri, 27 Nov 2026 20:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7705B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=Sz2c2RIK;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=RbVOGA4r
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARBPJXZ981592;
	Fri, 27 Nov 2026 20:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2026-11-19; bh=ibl6IQvetpW1H+Nk
	8S7sel1Grl3iyh+c8/l+FW5tK6Q=; b=Sz2c2RIKed6b/XVpLmK35q5xgkImWBCt
	AVHfHo80kLDovesCzFiDOZksJyMEq9MlnlT7vzzquBVqmkyH6nWHxifWyF8gdH5l
	UbJDJyRzK4PixhVodqX8SLsrt1CikcwqysG74G94hF36RcZXbWImKWBrrIgONtU3
	yd21Pam1YtUlLsHcHCxQLhzTD5kvFV6Ei8P5lEi54z+UL4JZffJJSCDYC7ZQHjbF
	QlyDzFFj58n8Yt2l6nED21fEhVOyZpJpe18QJvWS55Ybcxr2NTpEoCk6mDYkwngU
	cxwPlgIp845cKJA8JJ0ifUpjYV5GDZljnzRscYdnlcyLE2TFBAHf3Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j34t1rv3w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 20:05:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJ9ijY4005072;
	Fri, 27 Nov 2026 20:05:31 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4j7ca46qyq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Fri, 27 Nov 2026 20:05:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qM10XCoi7H9ZK2glvsjYYDPWp4yQ0YikLUnLzpqzlvN6I86uZRByibfupB78TSt9n+yfmfqXK0v+t6NU+wb+NhHZdpDHcLMD1wXNVgYFA5USwoGF0y0q1x5sEY3aGpqhVZfMyrfGipdtCs1oRppVRmoqVRulQJcvMIdtSlP9NxBPT44W0CeLGLtapjRaPFpoFeYlhWe5c57TtYtODloZiqKAiIl2dn7KQLWrDsttpltizzcZaXEqvDaESRHzFVV+V4QkeARrtwJYDaXrtFZqC/n+lQQz1xLZ6ZpO6eLYf+oASNYDwrmWp4MC4TYPxc+Nz8+DfcsXq6247GpPtEmL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibl6IQvetpW1H+Nk8S7sel1Grl3iyh+c8/l+FW5tK6Q=;
 b=J5RLuxzYoUfKebiWtUCE/nXFn+htsdt9zjnkayjYGrRTqPTyAYdBBu49tM/sM6QVVN2ZXnT6TCEECsqLjpfsZeN1L+QWsEm9ZoOnTk08R9b2wTuzOuTjJvfPtMh2YOzoanngq6+w7BzoavMOmhu9f0RdZb7l3tCQd/bsgx8nLdWnBcjUe/LeA8YGpwE7tPSzrgv4wa0nxFx9tkWyScj4DkegJUzT02QHRY3HLpBE9b/KJepYdlRWvsEvl/T5WckLVr/yTVFfj0MZfdltDMe8GVxxxc0XSLgK/A/EFCxEg+f2iw3xIXOsl9VbbeaH2fLrfdvbO+l7ytTx3u4P2wlHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibl6IQvetpW1H+Nk8S7sel1Grl3iyh+c8/l+FW5tK6Q=;
 b=RbVOGA4rg+mXaBSNj5+hjOUDga3XwZyvT+PfKQvhJNNnPwSt+625F0kAL9MNJGoWAAN3vWuSRcn7bhe2PlvfVOiY7VqCQFamljBbsw0iGQZmkDysEFjy/UKbPodYd146dHAIhPHOBofgt40Kf9pZe4HCJBqRXgQb4iUX2C72wfE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB5834.namprd10.prod.outlook.com (2603:10b6:a03:3ee::16)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Fri, 27 Nov
 2026 20:05:27 +0000
Received: from SJ0PR10MB5834.namprd10.prod.outlook.com
 ([fe80::2444:1d33:3ce:d83a]) by SJ0PR10MB5834.namprd10.prod.outlook.com
 ([fe80::2444:1d33:3ce:d83a%6]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 20:05:27 +0000
Message-ID: <100adc4c-d19f-4678-b009-365e47c89c8e@oracle.com>
Date: Sat, 28 Nov 2026 01:35:19 +0530
User-Agent: Mozilla Thunderbird
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [REGRESSION] 6.12.y: HugeTLB vmemmap restore corrupts LRU links after
 THP split
To: stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Content-Language: en-US
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DO3P289CA0016.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:1e::18) To SJ0PR10MB5834.namprd10.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5834:EE_|CH2PR10MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a48d8c6-0039-4b07-e14d-08df4cc1c790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|261009223027099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|261102123227099003|261022075727099003|10067099003|261028144727099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lHb+HuU1uBQ015dp4Vm2zJHy4o9vmp6MMCjCkYhjxynL+tUFclJDwx1elEXsJHvP56MoYsIn2rhdvFFxHTrIJwTEhYq3dS0AFAsZc/dHxcYQHJUA6HjQ6cEMi3+sgo/9fbMbwt0GedRdRAMlsYPybgQ4AI1RZBpUzy+qIz3VnEhwN//13/A/61wPkR4dC9U123R2/WbjUVQkgOe1eZJJPZ2LmR8MDEp5A10xuBfaxJyV0QcI2GLD00yafNDzRUgcDza29js06HJI3AnJsEvVyRJCF8i/kG/xvRN44hpoqhgg8aL5hR6p5EldnQgqPyfGotNTHjWlg5PQmDK0fD1rv4EL1JgfKA7D2q5f3KIQxLJXYPfbmzyPUJU1X5HJBEU4t9RKOXY2sE1Ib+zLEDa7t9FiBh+pFO9F0Y6gktQYsV0SMojmTaSOCWmX/s3jxjtz87rnc5yQvjIVLpTYciFDnY8EYHMiit2+lp8dPRkJNPSihd0WqxW8TNlX9GledSm66OiqpI9aOS80vIsss7iwkKkVCYzcpAfxuVYc0V4xGRGwG7zJLOjh0q5tRiIJjd1FWQtAeZVCH2WRd+UDP70/tXJtRW/b8XmwWfyawY4xPXPYH5eEdjdd1kXcy8pnByZVd9mIyti6WobUIrJE6YjrfFGq4vC1O0rii6KbM4Pfgxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5834.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(261009223027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261102123227099003)(261022075727099003)(10067099003)(261028144727099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFKL3FJTlVYeTBoRUk0dUxtckxzMk9NMlErRWZZU2dLRmNNUVZJOFV2bmx0?=
 =?utf-8?B?N3lCT0pjNlBLNkRKR3ZPb2lYaE5nSG9DTG9GanVVdWhyWCtWUlJDSGxOUVNs?=
 =?utf-8?B?RGE1b2txeFhsWERGWlhvWTdNWmw0b0pjVDV4STYraU5tUHlQOGd3TTVkUnZU?=
 =?utf-8?B?WDBWUWNRMjRNQU1JNFNaaEM5dWlvVGJuUk5UNjEwY3RhRHBsYUt4MFFmaElB?=
 =?utf-8?B?OUxjTVBDRGdZa21Jb0lBV0UxalZXVlFUNDVtdmZFS01CYk44c2xQWnFVanZh?=
 =?utf-8?B?QWZ2UVd5SXA4dHpWc3ljTytjVkp2bjBhQWNpeE5jK2xSQ3dFM1Q4cWpkNEpV?=
 =?utf-8?B?c1ZOUkEwaUt1dVhyR1ZzMEZ3QVRIYVB0RFlqV29pMGlnSnFQaXRCRS9xUzRx?=
 =?utf-8?B?VlptZkFUMFl0THFWMjZjeGpjL3BuRXZoQlhXUWFxNzIzNDIvWEpBODlDeGJo?=
 =?utf-8?B?bXdoOGlYeVMyVTNNa0xBdXhtNWFGUy9GYkdnMW9yK0pCbWhLdlp4TmVoMU9O?=
 =?utf-8?B?U0NkT0ZZdHlNUkUyTzJqNGg0U1ZYU1ExWUNxQkRUS293RG9jR2U3Z0NBWHVB?=
 =?utf-8?B?Z1oyekUzSHpxVXdaQyttSkpOSUZKNnJrVk9hMmk5ZW16RGlRVm1USWkra3Ev?=
 =?utf-8?B?R3MyRDBNYU8wSDlkRXpwZktWSC9zcmgwaDgranoxVkxIZjUvRjJrR3ZGRDVP?=
 =?utf-8?B?YjVmU3dmaG9KWGZiVktCcFlqR0EwTUhjNHpVMTcyZnJmelpPM1JZNjZScG1G?=
 =?utf-8?B?R3FBZHNwQ3hwT3ErNmU1TnF3RXpEN2R0WUtpVlhvNStSai9RTGhraHNWZUtV?=
 =?utf-8?B?QTFIaGpadXg3V09GcjZEek9SVE9QRWZmNUY2RmdXYWt4Zk56YXBXcGg1NDF2?=
 =?utf-8?B?TzR6REU1QXMzZWJEMUVqUTlVTDcyZ0VPM1ZYZkExTTFpRVcxa2VvVGdsU1Nt?=
 =?utf-8?B?MDJPZWc3Mi83enRuWFdSUm8vRGlDaEFDZkpNNjl5N09rbWZiWnB5TzFPSEVS?=
 =?utf-8?B?cnhtV0Npam1HM1o1MjM0UURyUlM5UVNkNDloRGNYT3BUajZGbmg5WFNOQWlE?=
 =?utf-8?B?TmpnQmkrcnIwQ1daMWtnN2R2dXhKNmtQc1BTYWJZRllmbm4ybHloNW9wZEhD?=
 =?utf-8?B?WDB2V2t1Tm1ZRnFLYnVBSFhjSVcyY1R4b2ZpMlVqZ2E4VnN3ZnQvdHRzQXNR?=
 =?utf-8?B?VzM3VVZnZm1mQ3JUYk1vbWsveExkRnlaQnN6VXIxL1RSRW1McENCU2RKY3Na?=
 =?utf-8?B?RUdJZlpaSllLMDBxa2lkbU9MZTY4eHU3M0QramVQQURiRGJ1OFZVM2xXUHlm?=
 =?utf-8?B?RjcvZjBoQmRqcE1kTk1rZkUvTVpBS2h1cGVlTEFlanFPbTRUazVmWWZETFpO?=
 =?utf-8?B?bWx0a2RDZ3JMYzUra0hOdldvMzF5Ri9kOU9tQnJNZTYrYWNxVVg4b1AxNDJ2?=
 =?utf-8?B?aWw1OWpQT3lHODBUZTFsaTMzTCtxRzRHKy9GcVJVN2tJcVc5Tzg0QVVpc085?=
 =?utf-8?B?clFXSURGaWFxODhQRllBaUtUNEhTS3EvK08zbjNxeHlTclVtazhzN1hZNnlq?=
 =?utf-8?B?NnEvSVZvaGRRL0M1L2kwZmRoTUFleDhiZ3lHU1ZOSDZ3WVlOT1lSMFI4c0Z3?=
 =?utf-8?B?MCtHZTBGTFozT1prRnRPZkUyQ1h3S1YxMXpidVVJRDcxNlRkc2JTTGpCc2Ur?=
 =?utf-8?B?Sy8xS2RZeS82eFNLZG40dlh4eURRNjdLQy9HM3AxZ1VZRTF1M0RYamVsdFNn?=
 =?utf-8?B?ZlBuRlJpQ0ZiZytod2J1UDFORWFTblFoMVJGMjJpVDZGN2MwNGlaYzI2K2RQ?=
 =?utf-8?B?OHVzN2huTEFEZjVUZWo1YzRSei9BTU1GRHgza21mc01DSGlnNmFvclU2KzBT?=
 =?utf-8?B?NHBXalYxWmZCV0FKTFZ1eFU4Sm5idVIydFBZcVVHcW8vcSszSzRVV2VrcmZo?=
 =?utf-8?B?bUJ5QXVMdStXUkhvS2tRSlhoc2hTTzhlRkxhSXdDRjRnc0trc1owZXJpQ3Ra?=
 =?utf-8?B?TWNVeDJtY0NXd1JaU1NpSkxMdkVQNjhXZXNvWW0zYjBmanNnbEczWXJ6bVUz?=
 =?utf-8?B?d0JqcC9PbjF5STUwTlNNR0lELzJYOU5udTA5TXJkdlNBQlNiR1g4ZGhpSmcr?=
 =?utf-8?B?NG0vUFhyL1hSR00xYXhJSGxQMFJDMldSL2tWTUxZL0xEY2dId3o2blp0Rm1M?=
 =?utf-8?B?WEdlbkRGTG5KcEFWNjVmYlQzRWZhRi9jNEdPSzRCMVRWSmNKckdBV3pOcWZs?=
 =?utf-8?B?RDhpWGIwcHl5UjdQV2M3bVNyMDZLSGhDSXVZR1A1eTJPZVFsM25KSnhjUWtS?=
 =?utf-8?B?cldSeXVIMHVUQUhiaTNNV2NBYzU1a1kyai9wVVc4Nld1bFJaZURUemZCWGw1?=
 =?utf-8?Q?tqj60SUGfdtjoIsCiXTIIJgpeeqjhYDa5lLCD?=
X-Exchange-RoutingPolicyChecked:
	RuBbX93yMs8ruYVQg1ZN8AVbluzieisSE8TrOM+iyyif4nAvWOaBIGFgupsG5jYrwp8eYbp3LfASEWWEyzoS/y6gAB71qfArpJMwHrX+IAXZHuqin28VZVTtHaw7bWJ13biw4XuxGMZLN5xrKvf4v/s1jnAnohD9tPhSsvhxLOzZyODMmSgyp25oHPTneonVI6V4vC5Nykq4ijYcfy0lKgYlFtPYUvya30Wg5XmFripT3da5hbM/w/cKQWRjaz2LpGbWpCg9m9PG5LPOyPtWe/zoPE6OMLHR6rVUakkIueliaUYZGEP8vc9uxb4Gg8iVNaAxt4Td1OMINANTIEJJIQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mnd5WEkw1fCV/vYhiua0LihalRabhYwLW6XPvB1Rm7mfh6f0+eef7KUX6mfXXuuxrb/YGojNIVqDqF7vDTiDPcWhNvGwqhWPGv0zB1xBwf62TJJKokONLEwrNnWbvpTQnj2Q28dzuW7XhWJfBRcw3qQC4wISNHVy5ULaePwcbAYnAOzQIIozdhFRAEiMuQ3LzzHnjuk59ZrPwS9O8az14+Msh6+eljsfly1ZKgkyL0tg+268dW68seL4nLo1BbpZXu0kXA46JJLtHt8j1GfkrL+laEOsqz61AQvpIU/UuUAquK22Q7exMiw8tcq5VUket30InI1aKwBbmjLCF0lsx4/zmnKMuh+33lKZEYsNhyvZH/7EVPNHI0/akfpuISGOsEl/LZGlpj31kEJyBa8TtTFA+NYakHOvT0xYZ4ppcuYUOIyseszkr4H2brj9kAxmGTr1yjpp0O7Ak5g3ZgkPU3XfeCGh1BvMJW8DHvTVAYBbpc5lfINy0rOSiYTbofvXnzgMJzF25TVJV9yd3KMoyFjGNOtSI05ue5yLvenfAVU7Y/DjYr1sNU0D2y19IR6KpLEw4LukQ7MXGg6I90b+ZIAqG6bsb9RpRsWBaDfn/ro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a48d8c6-0039-4b07-e14d-08df4cc1c790
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5834.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 20:05:27.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1f6JNO3mMKEW3eSwxfoYn694Dw13/QX2HIHl1LncZgU0Ge8h28gIseJ/MdFzYY0jqKVJB8In5UKEY5y/y0/9nFe/Je4B38Wnmjr6Ndxp5qgiepkCHaeN1PcQpDx6x/QP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=912
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611270079
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX11WgDxxe4YIa
 lt8FKQwvh41zaGyGGNSFFxD1nLSsqF/H9A5yimwKk4uMVB2ES2QNow5tP0VbTy7IsnG54O1j6mQ
 kU3nDpqaGYsoPtsVPKkTK16YvrsXNCTeF+OtB1lKEreXqnKn3VSJ
X-Proofpoint-ORIG-GUID: wbk7ktfCEL9XBrNTfrReTo2YBMgvL0WK
X-Authority-Analysis: v=2.4 cv=ePaGH3p1 c=1 sm=1 tr=0 ts=6b09e28b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=-7_IwblSBrBrB_03i0EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX0cFeubUOM37b
 2Q5YT5oSvlVP14+ldoIFn6Gt1l+Z9YxRRaEC9ClRwlJoljXwpQKh47Vkt1PgKG7apKI5ZU0rGQy
 HDH5fCKO9J4rQkBqQLA2cegmkV7E3kIBiE6HzAgeJbs2VL1AMOwqx0+eyOBGbJEf8TFg2Vro0ru
 r+PhwDr2CN7v8QVhT6N4pD8qgN+jWyF7apkMT8xWaKDUk3PnC9/w+DALIclzn/ZhKdVhixrAvyq
 5ry50VR/Ri5RtOLKAvJWmgckH6lE56/5bwMOrtO5fdS2K6bZgPcSGtE3BCPeViie5GH7/CTV5Aq
 EdOUXukDTs2Qc2MqFoBW+QWAa4E921u0WntgzU89KQYVjj69h4QKXHGDelgJPUa1oNfyXSECvxG
 QALkC+ytV189j8pgFgBuVle3Qrr6MEgf+Y5WZPc7c3n17DJHtM7jPZPGYBB29Jtl1c+pKfa2fT2
 S3zvVoxOrsoSBgElfcg==
X-Proofpoint-GUID: wbk7ktfCEL9XBrNTfrReTo2YBMgvL0WK

Hi Greg/Sasha,

We have hit a regression in our testing(with downstream kernel), and the 
same problem is in 6.12.114+, the culprit is 4b7920465ee8 
("mm/hugetlb_vmemmap: fix incorrect vmemmap restore in rollback").

Problem seen while running bunch of ltp tests with HVO enabled (hugepage 
vmemmap optimization). The backport copies HugeTLB head metadata into 
restored tail descriptors, leaving stale HugeTLB types when the memory 
returns to the allocator. After that memory is reused as a THP and 
split, incorrect HugeTLB accounting updates overwrite a neighboring 
page’s LRU pointer.


[ 4184.918774] RIP: 0010:__list_del_entry_valid_or_report+0x37/0x5a
[ 4184.923355] Code: d2 74 4a 48 85 c9 0f 84 9f 00 00 00 48 b8 00 01 00 
00 00 00 ad de 48 39 c2 74 7f 48 b8 22 01 00 00 00 00 ad de 48 39 c1 74 
5c <48> 8b 31 48 39 fe 75 40 48 8b 42 08 48 39 c6 75 23 b8 01 00 00 00
[ 4184.940329] RSP: 0018:ffffd022c44e3888 EFLAGS: 00010002
[ 4184.945473] RAX: dead000000000122 RBX: fffff44387a1d040 RCX: 
fffff44487a1d089
[ 4184.949857] RDX: fffff44387a1d008 RSI: 0000000000000000 RDI: 
fffff44387a1d048
[ 4184.956880] RBP: 0000000000000001 R08: 0000000000000000 R09: 
0000000000000000
[ 4184.963933] R10: 0000000000000000 R11: 0000000000000000 R12: 
ffff8ddd7ffd4000
[ 4184.968986] R13: 00000000ffffffff R14: 0000000000000001 R15: 
0000000000000001
[ 4184.973441] FS:  00007f6ec561b6c0(0000) GS:ffff8ddd6fc00000(0000) 
knlGS:0000000000000000
[ 4184.978371] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4184.983373] CR2: fffff44487a1d089 CR3: 0000000103344000 CR4: 
00000000003506f0
[ 4184.987987] Call Trace:
[ 4184.990139]  <TASK>
[ 4184.991921]  lru_gen_del_folio.constprop.0+0x134/0x1d0
[ 4184.995324]  __page_cache_release.part.0+0xa1/0x230
[ 4184.999332]  __folio_put+0xd0/0x140
[ 4185.002169]  __split_huge_page+0x514/0x720
[ 4185.005202]  split_huge_page_to_list_to_order+0x804/0x9e8
[ 4185.008615]  deferred_split_scan+0x297/0x4e0
[ 4185.011772]  do_shrink_slab+0x13b/0x360
[ 4185.014685]  shrink_slab_memcg+0x19e/0x290
[ 4185.017564]  drop_slab+0x77/0x100
[ 4185.019906]  drop_caches_sysctl_handler+0x94/0xa4
[ 4185.023090]  proc_sys_call_handler+0x175/0x350
[ 4185.026031]  vfs_write+0x29d/0x450
[ 4185.027975]  ksys_write+0x6d/0xf0
[ 4185.031778]  do_syscall_64+0x90/0x1c0
[


mm/hugetlb_vmemmap.c:__hugetlb_vmemmap_optimize_folio()


6.12.y (4b7920465ee8) shares the head backing page with the tails:

       copy_page(page_to_virt(vmemmap_head), folio);
       list_add(&vmemmap_head->lru, vmemmap_pages);
       memmap_pages_add(1);

       vmemmap_tail = vmemmap_head;

Upstream c7bde43f6daf uses a separate tail-only backing page:

       vmemmap_tail = vmemmap_get_tail(h->order, folio_zone(folio));
       if (!vmemmap_tail)
           return -ENOMEM;

Both states use this in vmemmap_restore_pte():

       copy_page(page_to_virt(dst), page_to_virt(src));


The upstream change relies on the separate tail-page representation
introduced by 622026e87c40 ("mm/hugetlb: remove fake head pages"). And 
it can;'t be easily cherry-picked

I propose reverting 4b7920465ee8 pending a restoration change adapted
to the 6.12.y metadata layout.



Thanks,
Harshit
