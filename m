Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792539140;
	b=xvWJZoFI45OQpyHIxWnx/n0aNq+CgD7h+s1yg+w6HJ2AcV5uU5LRecQMLLriTElTNxVM
	 mH1jA5gZq63JQxrIRyboQI+QpmEEUN280wBb0pATdcyKFxsjOks7SkexfYSaPkWoH7G3M
	 Po/mjjpByBnRdce3CsmGdVBt4i4OorNW4MWAWtMvHiUocNOTGHExtWv87KsBGbB8vPJ61
	 Pg3PRzlNFiGXtpxW5WgR6XCHh+t7YOht2Dk4Oq02e4ZEpA5SzCmLyF9WSoLC6Ljc9FVY9
	 YYcuXWDIQeTzA5tA1Aed2iMrw/IRpMq7DkENrFkwwD3uv/kLpvRZq17l2sbnH8x7fBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539140;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID;
	bh=QonuCVhj2ooVrhzYTSlErCILpybvj7XAwzqi1ebhgUU=;
	b=Ngbt4B+LrfjyyVcrnkYM4uYbDCuuSva3XQMV2tnbB9DEpRjbktZthMKeUxUknwugVX5J
	 mXFD5w9zBM2wJ3GZEDce0Cetlq+Jv5mPFVRu6Ekjd7d/e/cF510wb+WJEcS0nKXDYRnrW
	 hYTl7DgU/NTswOaoynCnk6pdlDWBBjWSQRs88IOu2BswnVKbggkBcLmcYcBU4N7SmYWU8
	 F8+M9SSaH0bFz3eANEvNt1e6oq3yTer+xQUc9qUVKn5xXUjg4A1u8ANbTSvLbN8SUm9jh
	 kkUP+zMzvZNxkP7RZv+6UJeT8TEu4l3xWyhn1m99vW7SgKmlKXKu0WusZCvU6KnZjMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=PPfgaBb9;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=cEdMh4Cf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C1606A31A
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 23:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 507C1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=PPfgaBb9;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=cEdMh4Cf
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KLBSn31273251;
	Tue, 20 Oct 2026 23:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QonuCVhj2ooVrhzYTSlErCILpybvj7XAwzqi1ebhgUU=; b=
	PPfgaBb9okSyR1Kew0eRNjNm+l0Wqw+XVtNmMdLx1z/MktvJ1Q1ecwjZ6mKePZ7k
	nLXvwzwxoX6nzj8EYwuYhzW/LPiT1XblkF64UZQB7GF6L1xHs89D01ORZPff55Nl
	jfllyZZw/A3R+8o64tgEOylvOESRgNG/5zduMA/kiTn3Uu7fjFkZ+KjA71nuXr/1
	wymwcAvTp8MU3QL4cHp05LdTvIi8XaOecskfvT9ptYUm13L0v32cL0zRKhVXRzwB
	CsPYWdUgXlRjcB7Be1QHZ9TQzXxJ4NqBl0SL5FotAc5fdB7glimuM4D6h9P0TID7
	GRGR2bFXAevxubwp4DXyZQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hdw4fhpct-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 23:32:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69KNDIw3399531;
	Tue, 20 Oct 2026 23:32:13 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4heeq0wwa7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 23:32:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+puNRyMdm6cLyZgSMHlef8SnqValSkP5ijvli78fjwS0whg0GymYTBAUv5iEGjnUthgQJwWTIo0qo+7USlmm7fjlhLpICt3qxgTMkNTNnHmF8f7kf39Tx1DaMMPb7geE7z0FNNBTd91TgI/z1UBu/yKuvS7V3FrZEA/OYMG1CwsOuzeBjYezLBHEvykA5RG+IPdvjr7mOjMhEDSQlL0py59+r6K1o99tjigSwXJtDPIv0zvBeRqlHcW1pH/K7iTlXYRyzjiTmPA9qDpaBJ8jb9QDcDMYIT7gmGBWubcWvF3ZlqnwY8Ae6KBmAwITmF99qJ2oYlP7d0/0KcQaNmOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QonuCVhj2ooVrhzYTSlErCILpybvj7XAwzqi1ebhgUU=;
 b=mxSvn7ZYwgfC22ZRrCH6Xu6cNO2HQMLiOGUCVaDIO4waghdy4+vBzHkKvMCWB7MaqEqpmMw3bwrpUiG41ygb5i8Fyhfxf47flIE9NO6YBusjy+M/+BKQDRsm/GWYsKnxM+vVurNz4zYawMcyvM+RlAdpkDkbWEjRED5LMHwiVNFxvNChNIC5aXHcmrJ0zBEtz1v4Tvbna2G/JVYB4T7QZQZyusp1mJOdW9p0Wp3ACj8Oqv7b30NXxq9zW62p/eT9IbrqNK1YbisjkjOsTxdo0HiV15BbvGJYAk3CGuS9zmeIh0nBV1ifxps4WYjNTy9giCcTCU1kDjG9WzxnHH4d7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QonuCVhj2ooVrhzYTSlErCILpybvj7XAwzqi1ebhgUU=;
 b=cEdMh4Cf1YyXdcUl62zcVdo2Rg8CgBoPo6zv8GbhYFRXg0nImbYAREQJoGmsgZiAHDR3LWcnAqY8cL4RvQHc71XjzA3dDWTMw6XJGd54CEDjRckdzVZRKyT7nI/C+W1gsxgK3flAjWL3p1hMxpJslDIJtNRz5fIoS0nxFF2cI88=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by SJ0PR10MB5833.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 23:32:10 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::d1ce:85e9:74e4:3120]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::d1ce:85e9:74e4:3120%8]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 23:32:10 +0000
Message-ID: <dfda3096-5d9f-4cb9-a361-efe3911ded09@oracle.com>
Date: Tue, 20 Oct 2026 18:32:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vhost-scsi: zero misaligned I/O bounce pages
To: Shubham Antil <shubham@octane.security>, virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>,
        gio@octane.security, stable@vger.kernel.org,
        harshit.m.mogalapalli@oracle.com, ilya.okomin@oracle.com
References: <20261020105503.75904-1-shubham@octane.security>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20261020105503.75904-1-shubham@octane.security>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37)
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
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c256ca-0d90-4b71-d5bc-08df2f025c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|3023799007|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bvcph4YEtkoirfu/WodvomJs+unJjAWPdc79JLWouvZy5q0b080e+xm8LkjMfT0DEYWIUFCAjb2j7p2oHUhRqavBZAVQ8O5SuvHGu6QWhzc7Kw+aSfF8jtppwB4SBz0vDKsedXrpwxnubs+0n61lzcH6hQWN6Thb1uMwvNfXIFaCcIQX5NK4H+3stJssljQCAmq5yNabw0ZO4ycnJjFa77zNQyekjNZSfpDBFVNZ6FpXXPV1Biz+Ve/kHxdw+mDtRCtYeOUNbjh09DpUnuUnCPeEyHVe5tlSkbjnZgFIe+9GXjonI4bq2xK2GnXTw23G961dtNeojxlYB2zipkxxPU8pnYVjyCDOoIiRJvXnrf+q9P6yj6wQdIBhgiJz42VGZahX9hMT7vyBIl0f89aZhiDoVLV8yHCnKDwEl3yg6uWnYC5X0h9Xo5GQEdQWLvwfGNkBzll8Ihes0srlRU6kTD/cGxihke3xnwSeEf5F5A/DfCeCZp53AXd1re/fNHhDd/GXXYwKQWVbB1FH0JKsGk3dIg/Va2j7LpZPwZo+7tuLr/Arn4fvPCExhb1sx+GqJv/QT8svXAMlj8yXMAlgSL+dzpj/zMCymjUVCCDjkzojbohzv/vByC7L8AyETTE7gfG5/r0D77amMl5XuhxpK3e61+Iq/iWt9I4J0BeiyKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFJEaGhmT3NteDJLeGEzYVhLeEVvWnNvV0RpZDdia05rYjQ0RS91OTdrNGpl?=
 =?utf-8?B?bFR6UkdGTStTZzNNdXNKdmU2bGk0K2VzRWJOYXBmakxwL0paMEpxb3RmRitW?=
 =?utf-8?B?b1ZVcmthR2lVNkJ5cjZiN1c5aUJISW52eGV6eWU3ZUQ0NjdtTWhxd1BxbWRO?=
 =?utf-8?B?bVhWMlprRFlHL1RjeHVEam5HMGsvS0F3ZXVwUDBKTUJPNHJXbEhCaWZCZlRs?=
 =?utf-8?B?RmVGdVpOaEVocThra1ZXR0diZ1c2UTc1MG1RY3ZnVW9QVlZScFFoaUFrRnJS?=
 =?utf-8?B?dnd5ZlZ4bzUwaVo0WUIxT2k3NnNpb0ZBY0dUSzZ3SEd6VHR0OEJrWjBzdDJD?=
 =?utf-8?B?V2hORzlyemFrdnorb1FUQ0Ewam56WElienUvYnRxeEZETlBHQWpnOXM3eUoy?=
 =?utf-8?B?SnhGV2x5Y3pxTmQrMzJGcEg1bGFydHZhL3E3M3JWVnlXNkN5Y1JxaXN1MjBN?=
 =?utf-8?B?cTlKSGhkQ1B5MGNPTDZRMlpXVkRZZVBEc0owY1ZZWkdDb0ttT0JyNU5qTitl?=
 =?utf-8?B?YXNGK25nWk9WME1IZk5WUGozNGVXcld6V2pNUG9zdWtJa3B3dW9YRWtnWWht?=
 =?utf-8?B?Z3pYV24zZWkvOUFHU1VXWXNxd2JaTi9GNmx5ejROUkZlL21aR2ovMW5zQ2d2?=
 =?utf-8?B?eFFKVE9tLzVUWDFwbkF1RWxlanJ1RDZHL1hWVGw0cEUyV252V1VuRTFIckdk?=
 =?utf-8?B?T2MzTDJ4UXFjNDRmQUNGYmJYaS9lRkNrV2JHSXJaKzBtL2oyVHNhU2lhaHAy?=
 =?utf-8?B?YzYzUEIwamowdUhKNGtIYVQxMURsYi9WM3grd2tQMnM4aU9Ta00zbWQxcmVC?=
 =?utf-8?B?QWJnYXZKdHlFeG5kTzdMeldXQi9PWW1XNVF0cHkrQjQxRWdyVHFoQmVJdDha?=
 =?utf-8?B?SGlwOHAySUJkL3M0cXFOVXdaK05CbXc2MlJvcm9WTlZGQWZPSUlxTUhvWFEz?=
 =?utf-8?B?T0l3ZjQ2NnVCMDB3RE5HdXZUL1ExQnZ1L05mbFYzUkdZeitHY3ptQk5XQzZQ?=
 =?utf-8?B?dDVhZnh4bVU4NmhJdG1NU0tGdktsV0x4cy9MTjc4ODJMM3I0SVJ6aGJtU1Ry?=
 =?utf-8?B?UXVoc1ZIeHE0bjVZSXQ3bXBQSjZVQUhHa0UrdHNTcnZHMzJaQUlXZ3JwaTRj?=
 =?utf-8?B?WGlJY09UM0t3dzQ2UzBGUHp5NmpxRUc3UklERW1ibURzUlBTUEFuVTZQRWVO?=
 =?utf-8?B?WFJTRlRwcnd5eU94dHkzTGs0Mmord0ZWTTN3OU9zQ04vMkxqRWpVTmJzd09k?=
 =?utf-8?B?QTk0Nko5c2RQTll4T0FEeTZGZ3dEUlptWFpoSXhOVWZMZXo3TUdZR21oVWJl?=
 =?utf-8?B?N1JTUHJzY3FhblJ6K1VNK1k1MUtCTExUYU9wUXU1M2N3QXNrWHBmQ080Z3A5?=
 =?utf-8?B?Z2xyNnR5dHptdXpWc1B2dm4vSTQxZFdNTU15V3pNUUlBdmFBUEkzK2hkZktr?=
 =?utf-8?B?YzQ1YXZQb0JUdkg2UFI3Vzl3aEJhNWc3V3Vsdzl6YS9CWTFsWVZ0M2VKZmRm?=
 =?utf-8?B?Ylo3aTBqVEU4SEVGM2loeTNOTnBNYTlucjNLaEEzb3IyMU1iNlpKMGFoeFBx?=
 =?utf-8?B?WnlxWlhvdmk3SW0zdlMxZFVEaXFIUmZhT25JQzFjSUZHc09iOXgrc2c5Q0VK?=
 =?utf-8?B?Zk5rR2JYVGJEaFhYam1xTmIveGVSV2M0eWhoQllWMHViY1I5bGV6N0NzbDR4?=
 =?utf-8?B?eFZFMDNHQ1JzbXEydVdKL3dMVmkyRmtjZDk3V3N3U1VmOHRjaEdYdnlFTGxX?=
 =?utf-8?B?bU9tV2F4bll4WHlnek5SZnVaTk5MdUpDaDJsN1VJbW44VVBibFlPNDZUTVFq?=
 =?utf-8?B?Z1NBVER3QW9POWJjN3lRMmhDVGpHMC8yR0gzSjZHakR4K1gwMkUwVHdVVFV4?=
 =?utf-8?B?MzhOZ3VEaVdORzZzM2Q0SVNSVmxaUVp1blRlWkkzVWdsQVdYRnJEdG5rYUhK?=
 =?utf-8?B?RCswd04yTW41aEJOcjU1aFFwaXNNeWpMU1hSZXNnejJieEVnaHRyQ1FYMk5Y?=
 =?utf-8?B?YVhtR1p4VGJ5SUk2aWd1YTQ0MzhnMGl0NCtraW9wNEpRWnhldk14MDVzMGFl?=
 =?utf-8?B?NzM4cHJFdFQ3cDZ0TFRYbFhYeGdtaUJmd29HeUVueG1GelgxWTRtZHVNK1lH?=
 =?utf-8?B?R3V2TXYweThSUmJWSUduaGx1dDE2Z0ErdFJEQkNKTFZ4c3IwZXdnNWY5T1ky?=
 =?utf-8?B?YU4vYVE4MDRIVjJFY0FDVFRmRFJjMHlrY3lKdnZ3UkttMS9SQ2ZvTmZyM2Vj?=
 =?utf-8?B?SHpFeHJuMUkvR3AzcWZTMXBPMFo0eXFKTGNrZGhKNjZGU3lHblFPRlRLTzM4?=
 =?utf-8?B?ZFlGeXNyQ0pveW5haGZrVTBTMmRyZGkrU0sxZGkxN1ZLeGxnRTlHbmQwbWp0?=
 =?utf-8?Q?qEJs25jeOe83xkCg=3D?=
X-Exchange-RoutingPolicyChecked:
	DkGwgoU8xqWfISlN6atatk8dfA9Ex3AvQ8o1dAY7yCHWW6folXwCB3QXIRHZM5JynZWxIIEWn3P7of0M3Mlb6CMQ2Q9vDZZjri6SPeGL485wzRwylF5tQxp5SUFOBrTxMsMpiQGjbrLZuy/B3n60z2i0J/VS3C9AbJn1mPXpGIvOwRDZ/ZDejuk4GZxgv/WCMMhBVLEJ5lIJ6m9BfQMZKe+k4uVVu3Azraz4dE4LqPX90hO8FwqVdkHRJrIE+Jv8SWMwmIBEdERDV9P8x3CpgJen2Vlqp1e/E7pspNFyVv4t8RbelebawDaqAhPoXa9BKfuhLRqL67UknufDgYS8AQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ezN6CuPPiNNqSyjmFIcdbse8DqiWZLrz35yrCHnK6OM0uS+yCcASO55+bxTydee/UO5dBrfK0ltcveAHQRjzzR28TN2XF1QEGyakR27YsokzgtN1BrWU1FCwFe6jx2V+ZEG0woEhxH29lCWaOuSBratT444+EeHEEf+/flfRYQjuBJAlDSSwg4pi7LpqWJ7RcmsRt8tt2IlQLyYE2GlJufMOH5wrzedr+e79spnI4/lES96hczXQUe5a5LDZeZI5CAzUaMiCiIl8qFJCkhItWFOsqXpOWrKpcJnbtx8cFIbVtizpZ4g2jnn1veGG/rT8j6hMybIgPsLSQCeWQpjMGKe6njoB1CQDflAPytFlN8Ez7nIrkTwZZ1IprWz9a9ogks8qziHfH4VPw/p5bPyuHdHts8EkNml1GBfyTnCLd3oS7mEqrJ8PRGZp1hmWkktJbTvySjt/hYvY4OYfm9HIb2IDAXqVHpQEJPBfsExoqsyCZf3/rRPU06g4HZ+MiH3FRZWMSursTPk9i4H5mIo59Z8iT4MMTAwXZ3Rg6d3HgIm2H9BL1e0VjIqUZXBdT+87xMOTX2mhJqt4MJiqMZyBIZ4mc4cFP6qQrL98MaWb/80=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c256ca-0d90-4b71-d5bc-08df2f025c73
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 23:32:09.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+ZlgHhQllWxIENLZNzFYr997MrA3eKPneKs3whJLqgx4fwY/BCCvPRkOOENY2s1RKsQG56G8BG+/JtpnQhWovwkrwRUBWnTUcR6VkgJzzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200093
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA5MyBTYWx0ZWRfX1S2I0fXq0mTj
 KZcVL1W+8U7oUHbwcPKQCfMecNFtw7U6okqgmXtomCPECKPphuZBbZG1l1oaiq4uqzP3+hAkfrW
 K35nKH+e+sFjwlHxxhSyPD8gkgHVaZROrOGVCnsew/LuInW2oh+B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA5MyBTYWx0ZWRfX1FKW5+Q+rKY3
 b+ZL+3OkW7H3ohoStGfKd66yq0uvEeWlDu9IrYRs/VkO/5mygdm6dCdw89aZZQzUnDp8we3XQ3k
 oKjsoSRX+XhtFhJ/VzbZn2AgLBKVqfuq28LB7iW9IU1t2NCTXGL44arz9N4+FV4mBW4nIicWrOo
 q6pJZGG0OK53XEf9U2io8f/geG8iPtTKuFhXsrvxs8d6ssBv+7jkByBhHW5ikjVd5ip2nOS2+IU
 kQ+7hLx6rOaPf7rupR2ra+6QIErUCBnyZsM8pDM3bGhIDkL00ZAIKpzLtQtblNVkFM7ahnRsJBD
 Z5O2HdPwIwi3A1jZTW28GuH1k840dfOtbyMY/ShNHrpfyx3ZT8lnG4A5V6rtAoL/qxqBs2gt/0I
 +eKTkCTqM7tKf3vDMc2inCdFL0TyUDjxkXYyzZenXraTN7H+Gi1BRwcRR7XrpkzPw25WUj4fwj6
 bv5CNTRegJ/XO0T8a9A==
X-Authority-Analysis: v=2.4 cv=cfNHPXDM c=1 sm=1 tr=0 ts=6ad7f9fe cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=fFVshwKfkycnGkrGNp0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TFwyyMvXnVsVlR_zCIDnqAq49lcVmtIk
X-Proofpoint-ORIG-GUID: TFwyyMvXnVsVlR_zCIDnqAq49lcVmtIk

On 10/20/26 5:55 AM, Shubham Antil wrote:
> The misaligned I/O fallback copies the full bounce scatterlist to the
> request buffer during completion.  If a data-in command transfers less
> than requested, part of a newly allocated bounce page can remain unwritten.
> 
> Allocate bounce pages with __GFP_ZERO so all bytes copied during completion
> have a defined value.  This path is already the slow fallback for
> misaligned I/O, so the added initialization cost is acceptable.
> 
> Found during an LLM-assisted source audit and validated with a QEMU/KVM
> vhost-scsi target using misaligned data-in commands.
> 
> Fixes: 5ced58bfa132 ("vhost-scsi: Fix alignment handling with windows")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM (OpenAI Codex, gpt-5.6-sol)
> Signed-off-by: Shubham Antil <shubham@octane.security>
> ---
> Changes in v3:
> - Restore allocation-time zeroing after review confirmed that this is an
>    already slow and uncommon bounce-buffer fallback.
> - Keep the change minimal and document why the zeroing is required.
> - Drop the transfer-length copy-back change from v2.
> - Add the discovery method and the requested Fixes, stable Cc, Assisted-by,
>    and Signed-off-by tags.
> 
>   drivers/vhost/scsi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 885fac5ed042..8493a372de6c 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -937,7 +937,12 @@ vhost_scsi_copy_iov_to_sgl(struct vhost_scsi_cmd *cmd, struct iov_iter *iter,
>   	}
>   
>   	for_each_sgtable_sg(sg_table, sg, i) {
> -		page = alloc_page(GFP_KERNEL);
> +		/*
> +		 * Completion copies the full bounce buffer, including bytes the
> +		 * target did not write. This is already the slow fallback for
> +		 * misaligned I/O, so zeroing is acceptable here.
> +		 */
> +		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
>   		if (!page) {
>   			ret = -ENOMEM;
>   			goto err;
> 
Reviewed-by: Mike Christie <michael.christie@oracle.com>
