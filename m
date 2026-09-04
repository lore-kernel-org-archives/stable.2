Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D363D8132
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538666; cv=fail; b=q9YwneeQ3M7HNwhHtHv6JBO2M97xpysDGKyqUCdo9SScaHSgurGSzb6sdyjxOuuz5k6ArgTCJpiWG/oxwtsgoj9npre1pEJ9oBZQY1f32Ag8Vn/EEBznx1yBbgwobH1OVNld9AwrqwRyTcj3O7p9SlHUG+wNJq2qWQ2VaJNIklE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538666; c=relaxed/simple;
	bh=NKijCGseoH9fukhfOPC2D+CZNyQ8xeupzisdGZBKEgk=;
	h=Message-ID:Date:From:Subject:References:To:In-Reply-To:
	 Content-Type:MIME-Version; b=hUctrFtEw7n+kl3HYOOfMcS7t0ECV1Q7Wt6Rty1e3N3Dc09CdI0OvQMB9zSipwWtBuo6BjkrqZrRz/WavGGFoFV0981ySHBpE8E68HqJ/EG4G0Uq6BsxobppZrxww2PPFMhx9b8O27kcpQuI8QtKPRvJ3pykTIvQHD36JAePqe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DeT3Mqkk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MR+UaYHK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DeT3Mqkk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MR+UaYHK"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684BfoKJ2674078
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 16:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	corp-2025-04-25; bh=t1PnnahiugWJ2b5v292e6Mplq0XAFsuFHNp0/70ACBI=; b=
	DeT3MqkkJH0zc/WFjciTlYesuimOOxMErngxHVq912uM5gU7Mf7pcGW4DveHrhw/
	UpMpYMdcbja0NBdIXYXEARqi77MQS+sBNxmlrdeho5gD+N2xnzlcEBk1vaCAyC6I
	AtIyMuk1sp+enlX4X+DK2TfzfGv3sYqTZoi6orQxC8UWYtpPClGti7pyY0zhAri+
	IX4GSKxuV1T3zfhfZafJJev7ce7JJWRD2dzLx9yT7mzPj3n5FQt+xZ7ZtuIvfet5
	03ZWvtZn5N1OILr6zmUVy3eN7tXR1BVCAFBkqYzKXjOapya99OPGkus+FA4f1vqn
	h5YB5FmA7cm6W2c0+7PRlg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp72k0yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 16:17:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 684GFW0R026410
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 16:17:42 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvj996p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 16:17:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcXeS7jIAQEJSBM2diB02c0fZ2PRIRN5jYjK6hYfdYN+GVAbd9Xd/OuKuJ8QSU2qsGH0Qq7NppSbi50Wi0aaBdjIqM6lMdRLIM8UrH9iASL4+924CXhQV8AqGU0BuQOBYu5c6vcgmA48wJLJ0ARvvlhqpz2YMGssFGGjN6H/0N4x09RovXYlRhouxFMfZAWfesoBiweipAN8nYAekDIKS8HdUTaGQzhbQNq2zvo4JMdICDl8Wl2g+F6UjYND4aFZqsum5eKMOrwDsDgdNVN4C/wugmabU7hqDLT0JnYJ6S/rtCrA9aGC2p+cNnVWiwkaWVqhZUAggZcLwn8TBsaHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1PnnahiugWJ2b5v292e6Mplq0XAFsuFHNp0/70ACBI=;
 b=P84YZx2s7pxWp/yBn6Q5iIn32pUGpGtsGUTbyB54FmSIn+2LqZBd4Irjad9FyVpIkMx6BccVO0XWdzi0uJJbhbwJBwbJh7PG8Rxd1NxsHQFL5aZLyj5qvAgjJPLzppfWeyh3Acp33gmnvFZDBeIs4b5Dze1Pjqb8pK8vGTOhK2vzbY3kCPTjveBGjIetcSHwyN/qc5Tk7mqlPChy2vYp6wy9HpN+D8xZlSkEp+OFxBuKk2kkyRnQvrIWMZqchornw1T8Pm+kPSXNUMM2zjCT/P1H+8Vx4GOHXdn5oamSYQ0vCoRqlLjJ9K7mZLn+opCSZB82pWJW5WwUlDOuTlBI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1PnnahiugWJ2b5v292e6Mplq0XAFsuFHNp0/70ACBI=;
 b=MR+UaYHKxGKxz2RXxk7uDNCA809WbsE3/6uqFBlCA+cn7+02TGRO6xWAkjrM3+e4XE11yw8nzKy7SJQ2i+OnTATZRuOkl54DlK/5S8CudJyQmw6r6qRTy/iduVC4WC8a61KYWA7/S81m1U3eR+vXtgwWtHFgPbVCrGoyyj9Q05I=
Received: from BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17)
 by SA3PR10MB6997.namprd10.prod.outlook.com (2603:10b6:806:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 16:17:38 +0000
Received: from BY5PR10MB4337.namprd10.prod.outlook.com
 ([fe80::587:3850:b94b:3577]) by BY5PR10MB4337.namprd10.prod.outlook.com
 ([fe80::587:3850:b94b:3577%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:17:37 +0000
Message-ID: <8f3c4632-19c3-4dfe-9e86-3f015d6e8181@oracle.com>
Date: Fri, 4 Sep 2026 11:17:35 -0500
User-Agent: Mozilla Thunderbird
From: Mark Tinguely <mark.tinguely@oracle.com>
Subject: [v5.15 PATCH 3/3] xfs: fix unmount hang with unflushable inodes stuck
 in the AIL
References: <20260904161002.51054-4-mark.tinguely@oracle.com>
Reply-To: Mark Tinguely <mark.tinguely@oracle.com>
Content-Language: en-US
To: stable@vger.kernel.org
In-Reply-To: <20260904161002.51054-4-mark.tinguely@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::26) To BY5PR10MB4337.namprd10.prod.outlook.com
 (2603:10b6:a03:201::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4337:EE_|SA3PR10MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b282f4-3b0c-4bb7-7d3f-08df0aa008e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qfLL8g4Ad12PkQwda5HdliEE5j2jA5mVrUcWlqDNXR9BQ/1mqq3/jMXZOQ94eiq1nO6zpbwbKMAGKAinOuIS6Ms9ySyanYlIxqiaVXwwnJp7jy5Q2kvljPtytlSfAHHQxlZkTBtdiHKMxdLhmScyfkHBoqOM142ApHT5STBxsUQwDSQOuvcQqw22lZMcBwVpCRLmqpd2bjTlevP4cJF9Vzq5ACVUZvFqjGon5ayr/Qqm1A0mI12KFSDgqVjrf2USgWMilQX8pKLIB2RLhR3X+vruFA44W5mBcKjSYqYz08PE0czL/viajAO42zaTiuvAouFFayFA/kz6gnyw1Cy3ELdF6xHoYud2K2jbOj9APvbLGkCeiKr3L0Hz6QuSz6iHD88TNbsVugzQPyg7+17a6+A5ej4PP/+WYc4XDYnMADHA4jF0WxojBMaJ6gCZD5GIk5KeOrOkHdnNxQJhYmD28E1AZhfSkQhbHNyzOgbXQdOIPsSLMO7SFZl7ewCg4V5tGGszFz6Yvavpdg46PaBCXbKvFA7JGy8Dep7evn702nV+lV28G+dN2r+CA1pF8PVdFModyRtdawJAj+/DQdG7sJGUwORBjgcESzPr8vM2fSEQ3/wmKacgBMN52QthjHOjCABVMzLoR2/YQ5H2qKvrjk4N9N+w82qdPYm0V+5xk5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4337.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTUyM1hHVWZBZm9xVFA4VVQyYTI5bjRsdjcwaHNvazEvUXNrSXRvcllhMXBS?=
 =?utf-8?B?VEtsZzlkMFQ4QmdDT2RpeVI4bTcyTGJFa2lncjRScVA3RXJiYTN3SzArOVdw?=
 =?utf-8?B?WVlmZFBsSHJSTW1qa2lSUFJ1TjJjcHJYcUJJL1ZpMDBIS2xpeGdtbGdNaHlM?=
 =?utf-8?B?bnFDeFZBeDd4L0Q3WXhiQ0MyT3lBVnJ1Mzh1L3R6b0hnTysza25LRTh5Y3JF?=
 =?utf-8?B?QVV5NDQ2bUJvL0p4Vmd3SHpMbklRZ2NFTFBvTVlOSmlQOHdua21BQm9nQW9w?=
 =?utf-8?B?Y0c3M3kyZHB0cDdXN1U4Qk1MVFp2RjNWTGZWckRpdUl3eDJiSDNtazJVNWpP?=
 =?utf-8?B?RjBPMUwxVE1WOS90NDh4M215d01JMFFjL05SMktVZzQ3T0FpWGFGelRuV2JP?=
 =?utf-8?B?UmoxLzNHN3NrWEhNNWFSMHV0Q3pjeWZST0FodkoyQjl5OGpLRVFtUldxR2R6?=
 =?utf-8?B?c1p3KzdPTkZyQVd1UGFaY0NzQUZvVUFoSktOS2xnbGg0ZXpmL2xvMjhJa3Uy?=
 =?utf-8?B?NzJnS0VIYTFObUFsUXEzY0J4MVhpdlRMaXAvYWphdHRWUXVBUUVPTGJObTkr?=
 =?utf-8?B?S0lWL0FmQ3pyOEYrd2QzRGhGa05kVmF4R2NEeVRzbUMxbmYwakVRaDJKYUpM?=
 =?utf-8?B?Vlk1MDY0b1VMWlQ1bzE0WDNsVWZEek1ydEV2SjVkN2J5ODRpNUhWMHNBOURM?=
 =?utf-8?B?MmZVb0J1NUwxVENCN0xPemQ3STE5WG9MdVErbWh3ZjNjK0tLak5HTkFFUEtv?=
 =?utf-8?B?NmUzNWRaeWpheDQxSjdjSU4yZkt3bVFjMGhZM21PM1lvYnJBd0hQcm1tUkJi?=
 =?utf-8?B?WU5BM3NrWWJ6ck9ldjV2WEJHOGNpK1VEMFZnRnJuOUJGRys3TFZhT2ltUFFm?=
 =?utf-8?B?dXJ3MFNRQzdTZVRoaXlnN2s4RHRYbkV6a3laMlJmY0lMdXpuV0o3UWVxRG05?=
 =?utf-8?B?SHByMkJSVWxOMGd1ZThRdThncGtCbVQvSEVQU2lveVRsbFMxZlNBS2RUaW96?=
 =?utf-8?B?U3VieXY0Z0ljeElVWHU2VHhIQ1p5R1NvM1VYZ3cxeld1MmdvLzB6VUlsQlR1?=
 =?utf-8?B?RU1sMXJHM2JzNUkxMEkzV1huK2ZBTnFka3FmTUJCeVlPSkdjckl2cU95U0Jj?=
 =?utf-8?B?SFNOSnFTd0xkbFZVdjVJc3hLbHB5SFVxOFNSZ2dpMEpXUzNxbVhUTU5KMS9w?=
 =?utf-8?B?RCtCVnhPNUhvd3ZXOGRkeXdXVk1mMTY2eFpXcW0rcWtENHJVNDhJSUZhLzhJ?=
 =?utf-8?B?WmlGdUxIMjhVbUU4ZjdGYkVDRmd5UVBUSURsalM2aHErRG1jZE5EMWI5RmJL?=
 =?utf-8?B?bjNwQW94aStiTld0NVdxUlBDbXM1ODUzR2l3MVhKUE85VGxlVFhsaWdNKys4?=
 =?utf-8?B?OGRsMGNWOTMxcEhyZ0NhSlZhT1ltUklvYjBNSGpoLzN6S3J2V2gvQlRmMm1l?=
 =?utf-8?B?ZTRKeDBBc21oNDRXR3FiU0Yxc1JhMU4ya1N4VDB6czJlWWFyYSt3SUtMcm1R?=
 =?utf-8?B?a3UrZVBiVWQ4VUtMWlNuako3aFpjVnFHdDBQcE1SQ1MrM3hxNGNIL3ZGbFhm?=
 =?utf-8?B?NUdWQlFmdWYvR0ZyaEJkL3JoN1p6YnJoUzJQSUxWU0xHN0VYMlhldXhxQjZv?=
 =?utf-8?B?dzVQaVp5QTVpQm5oVll1TEtuN0NZbG4xa2txQmNudUU5RktvVFNxRWEvRmdB?=
 =?utf-8?B?NlNKeVV3NDlYN3Q3NG1iS0hSTnErcURQZ0dYS3AwZUsrd2k3OFVFZDRhdWVz?=
 =?utf-8?B?RmNoQ25pQmhrRGFjK3ZhT05wR20yZXFwcVZibHRpdFg2L2xuYk5JNUNvK2o2?=
 =?utf-8?B?Z1lMSndPdzdXOFVHQmZwR3p1czAzd0pXbm56QVAxWUZHNFZqa2FHUWZoSU1K?=
 =?utf-8?B?aDBFVTVyWkpYakd3dWM5ODNTQmxkRkFaejVTV3dYQU56ZU85aktUYU9pRkpp?=
 =?utf-8?B?UXV1MVZ6MmtQVUsrU1NaWEtYdnNHVEtCU29XQXkyZ0FDdWxJODRjNmp4dFhK?=
 =?utf-8?B?WDdicVZWbGVTbTFib3BtZFhOcUVmcDRPeWJZM1dJMWhQMnpTalkwcG1aOVA4?=
 =?utf-8?B?Y2R2VHp4dDdiL2ZyeEs0NXBINVZINlhtNnEyN082cy9nczN5eVIrTHZIVkgv?=
 =?utf-8?B?Y0xXMTM5V1kvUkYzMjdxdDdVTzJSM1FwR3NEK1Vua0NuRGkrcVZhVnEwdXly?=
 =?utf-8?B?K01nV3FEdlhCV1E1c2dMTXZ0RGlQMFI3U2FxcGxWbmJOaDQvbGpxY2dSNVFM?=
 =?utf-8?B?azBXNDI3UnhSUVAydVk3TGxYSU5GU2dVT05GK3M1WVd4bGpVTGF5NURPOEV1?=
 =?utf-8?B?UlVRTzN5dXl4M3NYRFA2RHZuc1l6ZFU4cDRjVEU1akUyWXJlYkQ3UDFoUW1U?=
 =?utf-8?Q?zESCADJ+G0u5nQik=3D?=
X-Exchange-RoutingPolicyChecked:
	0bxdi3Z3Plq+fgvobqqyvs0U+Y8qXfQkqUfHf7J3HroSBpeK9y0KQ6ko97bHwWwgNu03eOcjPfKncIGSoQgMdW1LG5YPc5sHjheg3Wfey4Cf3bPE0DaSOKj5ly9xK0IJ3rMwx1Ez4NYGLukBiO3SilDk2L30QLMopE5dKoR5OjBsOg4Kc/7tWOr+zXmlTzJN32UkWQwDAA+/bU7TP/C4M465eKWESGFDPV4cqx6MrQrgG23ZWme6kGS/4DhH8orHyyz/7+g0V4cdVcQrSCW6nmRawxw41jqgVEATJAI2l6H+dEdrxcHflvuLCAfCmwqjJ0wlxfSxXwaUKPYY3A/7PA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4rMbP2BjX6EfsTjobWrPvIOqX93IDdmgJ+1fF808T4dKAzwZpkmaglF3twWhSmug99NGfGrlZAFplw+jyprVDvj1p+LDF0DPTsbSOmFSnalQAEf/Pfukr+tuGkERn+S4LcUa9I9nmDkzMHLIYuNrIATh9UUg1JzDUppBK5xrQADzqBDZS52THbonivswLH89XwJQDZEd4qu5aJZZmHtJcKhWWwCcCbF3mATzKuCDhzXF6Zt4vz50QRW7duY/l/GKIV8unobalrC5HIBvxcfdSTOP5kn0KaLfOOkJXzJ1i6OJvSC67CncyY7xxWJGuqWdXOpvCnc6TxSnSM1l1C+5WEuY7oSp1ZflrjidvfjCvwbcp+NibkzubP2xXACTzswIOu3cA0J7hapz6Ip+G/wSTQMFx1N2j1HC+LbH8xgWGztz9MBSaEn+SZ1hyRh8w39q+zBBoNuM8/K+koPahRlZ/tFsFwFVFz1f/50cSy0ZwHYDCt7OgUcLjZ5uX9Wf9IafxM/aOSzx0DcTml1cgzdH065JauwS9uXG6+9vduBWCqaS5z0DCdXMLn+35kyiuG9sNG+ECB4dQbYZMlPeOOWCVzNOvMv4EP1IvOV688d+JVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b282f4-3b0c-4bb7-7d3f-08df0aa008e4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4337.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:17:37.0771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn5ofkqrArrFwTkb9JeFy8gq4GanJyKzgiC3qXL6TTXIxZwO0W0uvxqBjMvrnMoaB3FII7EBRyP6uU1G5dYvoqLWagMRbh4agd2kIogXtJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609040148
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0OCBTYWx0ZWRfX385YdiC2KJRV
 1TUi5vCsIwb0Y8GYzhNDUlBjD8XOjxKW94NlY2oQbdSPpJzejSURl++tiU1+0DsFuNvl+O5taC/
 U/cnNsRHj1xvZh2MnR2rQG/6SQNe329ZzMsD4auA1325vB5TrTZr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0OCBTYWx0ZWRfX+xXAs51mMec4
 75be6x7wvVWzhvLrH7s+6a4riEKmMJKM9fKugh1w5ELLW3NgnVal3GRATto2CvkZ0i6mYFcXO+H
 VqRCyrRuAaILL/Iein1c7SV9WdYT76kqauHnsF9gRowOhGFT/NO63ujI8lIGUVXsW0o4O2zum1Q
 dEbP/1rp1yo38DCSNMrPLqU1TvYqHCxEV2wEqq1ljKJ0ocXwZ6Tuu2kYyMZ7NR+nYDWOs/VoU2r
 TQnaNjZgjTPrrTbH6poK8GZk+gVK6gEiZdxBiNWIhCkAv1buHUZvAesqooRYY8MP5SLe6gqllFx
 4JcqVVZ+TKuWi/XRoEWkF+d14Sa9jBdDZZ7XfJGXrdqCAmXaCpA4uTsr82L7Drm1zVTeXVhRtyk
 iWy2hM2uxASOe3SMukwddaQjkBTCB4547sbNW82F9bRy+Jw9ZZpAgPQDJibc89hoONmfH6NBvsA
 QeObj431R/ba7qdRcMQ==
X-Authority-Analysis: v=2.4 cv=G7os1dk5 c=1 sm=1 tr=0 ts=6a9aef27 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=kGPDooFuvBrjL3bSUbYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: P6Zljfu8vw4jJa_QBoKAv4KZMSr2Njjx
X-Proofpoint-ORIG-GUID: P6Zljfu8vw4jJa_QBoKAv4KZMSr2Njjx


From: Dave Chinner <dchinner@redhat.com>

Unmount of a shutdown filesystem can hang with stale inode cluster
buffers in the AIL like so:

[95964.140623] Call Trace:
[95964.144641]  __schedule+0x699/0xb70
[95964.154003]  schedule+0x64/0xd0
[95964.156851]  xfs_ail_push_all_sync+0x9b/0xf0
[95964.164816]  xfs_unmount_flush_inodes+0x41/0x70
[95964.168698]  xfs_unmountfs+0x7f/0x170
[95964.171846]  xfs_fs_put_super+0x3b/0x90
[95964.175216]  generic_shutdown_super+0x77/0x160
[95964.178060]  kill_block_super+0x1b/0x40
[95964.180553]  xfs_kill_sb+0x12/0x30
[95964.182796]  deactivate_locked_super+0x38/0x100
[95964.185735]  deactivate_super+0x41/0x50
[95964.188245]  cleanup_mnt+0x9f/0x160
[95964.190519]  __cleanup_mnt+0x12/0x20
[95964.192899]  task_work_run+0x89/0xb0
[95964.195221]  resume_user_mode_work+0x4f/0x60
[95964.197931]  syscall_exit_to_user_mode+0x76/0xb0
[95964.201003]  do_syscall_64+0x74/0x130

$ pstree -N mnt |grep umount
              |-check-parallel---nsexec---run_test.sh---753---umount

It always seems to be generic/753 that triggers this, and repeating
a quick group test run triggers it every 10-15 iterations. Hence it
generally triggers once up every 30-40 minutes of test time. just
running generic/753 by itself or concurrently with a limited group
of tests doesn't reproduce this issue at all.

Tracing on a hung system shows the AIL repeating every 50ms a log
force followed by an attempt to push pinned, aborted inodes from the
AIL (trimmed for brevity):

  xfs_log_force:   lsn 0x1c caller xfsaild+0x18e
  xfs_log_force:   lsn 0x0 caller xlog_cil_flush+0xbd
  xfs_log_force:   lsn 0x1c caller xfs_log_force+0x77
  xfs_ail_pinned:  lip 0xffff88826014afa0 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
  xfs_ail_pinned:  lip 0xffff88814000a708 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
  xfs_ail_pinned:  lip 0xffff88810b850c80 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
  xfs_ail_pinned:  lip 0xffff88810b850af0 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
  xfs_ail_pinned:  lip 0xffff888165cf0a28 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
  xfs_ail_pinned:  lip 0xffff88810b850bb8 lsn 1/37472 type XFS_LI_INODE flags IN_AIL|ABORTED
  ....

The inode log items are marked as aborted, which means that either:

a) a transaction commit has occurred, seen an error or shutdown, and
called xfs_trans_free_items() to abort the items. This should happen
before any pinning of log items occurs.

or

b) a dirty transaction has been cancelled. This should also happen
before any pinning of log items occurs.

or

c) AIL insertion at journal IO completion is marked as aborted. In
this case, the log item is pinned by the CIL until journal IO
completes and hence needs to be unpinned. This is then done after
the ->iop_committed() callback is run, so the pin count should be
balanced correctly.

Yet none of these seemed to be occurring. Further tracing indicated
this:

d) Shutdown during CIL pushing resulting in log item completion
being called from checkpoint abort processing. Items are unpinned
and released without serialisation against each other, journal IO
completion or transaction commit completion.

In this case, we may still have a transaction commit in flight that
holds a reference to a xfs_buf_log_item (BLI) after CIL insertion.
e.g. a synchronous transaction will flush the CIL before the
transaction is torn down.  The concurrent CIL push then aborts
insertion it and drops the commit/AIL reference to the BLI. This can
leave the transaction commit context with the last reference to the
BLI which is dropped here:

xfs_trans_free_items()
   ->iop_release
     xfs_buf_item_release
       xfs_buf_item_put
         if (XFS_LI_ABORTED)
           xfs_trans_ail_delete
         xfs_buf_item_relse()

Unlike the journal completion ->iop_unpin path, this path does not
run stale buffer completion process when it drops the last
reference, hence leaving the stale inodes attached to the buffer
sitting the AIL. There are no other references to those inodes, so
there is no other mechanism to remove them from the AIL. Hence
unmount hangs.

The buffer lock context for stale buffers is passed to the last BLI
reference. This is normally the last BLI unpin on journal IO
completion. The unpin then processes the stale buffer completion and
releases the buffer lock.  However, if the final unpin from journal
IO completion (or CIL push abort) does not hold the last reference
to the BLI, there -must- still be a transaction context that
references the BLI, and so that context must perform the stale
buffer completion processing before the buffer is unlocked and the
BLI torn down.

The fix for this is to rework the xfs_buf_item_relse() path to run
stale buffer completion processing if it drops the last reference to
the BLI. We still hold the buffer locked, so the buffer owner and
lock context is the same as if we passed the BLI and buffer to the
->iop_unpin() context to finish stale process on journal commit.

However, we have to be careful here. In a shutdown state, we can be
freeing dirty BLIs from xfs_buf_item_put() via xfs_trans_brelse()
and xfs_trans_bdetach().  The existing code handles this case by
considering shutdown state as "aborted", but in doing so
largely masks the failure to clean up stale BLI state from the
xfs_buf_item_relse() path. i.e  regardless of the shutdown state and
whether the item is in the AIL, we must finish the stale buffer
cleanup if we are are dropping the last BLI reference from the
->iop_relse path in transaction commit context.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit 7b5f775be14ac1532c049022feadcfe44769566d)
Signed-off-by: Mark Tinguely <mark.tinguely@oracle.com>
---
  fs/xfs/xfs_buf_item.c | 122 +++++++++++++++++++++++++++++-------------
  fs/xfs/xfs_buf_item.h |   2 +-
  2 files changed, 87 insertions(+), 37 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 677c564cfd1d..8798570a8b6d 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -663,43 +663,43 @@ xfs_buf_item_push(
   * Drop the buffer log item refcount and take appropriate action. This helper
   * determines whether the bli must be freed or not, since a decrement to zero
   * does not necessarily mean the bli is unused.
- *
- * Return true if the bli is freed, false otherwise.
   */
-bool
+void
  xfs_buf_item_put(
  	struct xfs_buf_log_item	*bip)
  {
-	struct xfs_log_item	*lip = &bip->bli_item;
-	bool			aborted;
-	bool			dirty;
+
+	ASSERT(xfs_buf_islocked(bip->bli_buf));
  
  	/* drop the bli ref and return if it wasn't the last one */
  	if (!atomic_dec_and_test(&bip->bli_refcount))
-		return false;
+		return;
  
-	/*
-	 * We dropped the last ref and must free the item if clean or aborted.
-	 * If the bli is dirty and non-aborted, the buffer was clean in the
-	 * transaction but still awaiting writeback from previous changes. In
-	 * that case, the bli is freed on buffer writeback completion.
-	 */
-	aborted = test_bit(XFS_LI_ABORTED, &lip->li_flags) ||
-		  xfs_is_shutdown(lip->li_mountp);
-	dirty = bip->bli_flags & XFS_BLI_DIRTY;
-	if (dirty && !aborted)
-		return false;
+	/* If the BLI is in the AIL, then it is still dirty and in use */
+	if (test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags)) {
+		ASSERT(bip->bli_flags & XFS_BLI_DIRTY);
+		return;
+	}
  
  	/*
-	 * The bli is aborted or clean. An aborted item may be in the AIL
-	 * regardless of dirty state.  For example, consider an aborted
-	 * transaction that invalidated a dirty bli and cleared the dirty
-	 * state.
+	 * In shutdown conditions, we can be asked to free a dirty BLI that
+	 * isn't in the AIL. This can occur due to a checkpoint aborting a BLI
+	 * instead of inserting it into the AIL at checkpoint IO completion. If
+	 * there's another bli reference (e.g. a btree cursor holds a clean
+	 * reference) and it is released via xfs_trans_brelse(), we can get here
+	 * with that aborted, dirty BLI. In this case, it is safe to free the
+	 * dirty BLI immediately, as it is not in the AIL and there are no
+	 * other references to it.
+	 *
+	 * We should never get here with a stale BLI via that path as
+	 * xfs_trans_brelse() specifically holds onto stale buffers rather than
+	 * releasing them.
  	 */
-	if (aborted)
-		xfs_trans_ail_delete(lip, 0);
+
+	ASSERT(!(bip->bli_flags & XFS_BLI_DIRTY) ||
+			test_bit(XFS_LI_ABORTED, &bip->bli_item.li_flags));
+	ASSERT(!(bip->bli_flags & XFS_BLI_STALE));
  	xfs_buf_item_relse(bip);
-	return true;
  }
  
  /*
@@ -720,6 +720,15 @@ xfs_buf_item_put(
   * if necessary but do not unlock the buffer.  This is for support of
   * xfs_trans_bhold(). Make sure the XFS_BLI_HOLD field is cleared if we don't
   * free the item.
+ *
+ * If the XFS_BLI_STALE flag is set, the last reference to the BLI *must*
+ * perform a completion abort of any objects attached to the buffer for IO
+ * tracking purposes. This generally only happens in shutdown situations,
+ * normally xfs_buf_item_unpin() will drop the last BLI reference and perform
+ * completion processing. However, because transaction completion can race with
+ * checkpoint completion during a shutdown, this release context may end up
+ * being the last active reference to the BLI and so needs to perform this
+ * cleanup.
   */
  STATIC void
  xfs_buf_item_release(
@@ -727,18 +736,19 @@ xfs_buf_item_release(
  {
  	struct xfs_buf_log_item	*bip = BUF_ITEM(lip);
  	struct xfs_buf		*bp = bip->bli_buf;
-	bool			released;
  	bool			hold = bip->bli_flags & XFS_BLI_HOLD;
  	bool			stale = bip->bli_flags & XFS_BLI_STALE;
-#if defined(DEBUG) || defined(XFS_WARN)
-	bool			ordered = bip->bli_flags & XFS_BLI_ORDERED;
-	bool			dirty = bip->bli_flags & XFS_BLI_DIRTY;
  	bool			aborted = test_bit(XFS_LI_ABORTED,
  						   &lip->li_flags);
+	bool			dirty = bip->bli_flags & XFS_BLI_DIRTY;
+#if defined(DEBUG) || defined(XFS_WARN)
+	bool			ordered = bip->bli_flags & XFS_BLI_ORDERED;
  #endif
  
  	trace_xfs_buf_item_release(bip);
  
+	ASSERT(xfs_buf_islocked(bp));
+
  	/*
  	 * The bli dirty state should match whether the blf has logged segments
  	 * except for ordered buffers, where only the bli should be dirty.
@@ -754,16 +764,56 @@ xfs_buf_item_release(
  	bp->b_transp = NULL;
  	bip->bli_flags &= ~(XFS_BLI_LOGGED | XFS_BLI_HOLD | XFS_BLI_ORDERED);
  
+	/* If there are other references, then we have nothing to do. */
+	if (!atomic_dec_and_test(&bip->bli_refcount))
+		goto out_release;
+
+	/*
+	 * Stale buffer completion frees the BLI, unlocks and releases the
+	 * buffer. Neither the BLI or buffer are safe to reference after this
+	 * call, so there's nothing more we need to do here.
+	 *
+	 * If we get here with a stale buffer and references to the BLI remain,
+	 * we must not unlock the buffer as the last BLI reference owns lock
+	 * context, not us.
+	 */
+	if (stale) {
+		xfs_buf_item_finish_stale(bip);
+		xfs_buf_relse(bp);
+		ASSERT(!hold);
+		return;
+	}
+
+	/*
+	 * Dirty or clean, aborted items are done and need to be removed from
+	 * the AIL and released. This frees the BLI, but leaves the buffer
+	 * locked and referenced.
+	 */
+	if (aborted || xfs_is_shutdown(lip->li_mountp)) {
+		ASSERT(list_empty(&bip->bli_buf->b_li_list));
+		xfs_buf_item_done(bp);
+		goto out_release;
+	}
+
+	/*
+	 * Clean, unreferenced BLIs can be immediately freed, leaving the buffer
+	 * locked and referenced.
+	 *
+	 * Dirty, unreferenced BLIs *must* be in the AIL awaiting writeback.
+	 */
+	if (!dirty)
+		xfs_buf_item_relse(bip);
+	else
+		ASSERT(test_bit(XFS_LI_IN_AIL, &lip->li_flags));
+
+	/* Not safe to reference the BLI from here */
+out_release:
  	/*
-	 * Unref the item and unlock the buffer unless held or stale. Stale
-	 * buffers remain locked until final unpin unless the bli is freed by
-	 * the unref call. The latter implies shutdown because buffer
-	 * invalidation dirties the bli and transaction.
+	 * If we get here with a stale buffer, we must not unlock the
+	 * buffer as the last BLI reference owns lock context, not us.
  	 */
-	released = xfs_buf_item_put(bip);
-	if (hold || (stale && !released))
+	if (stale || hold)
  		return;
-	ASSERT(!stale || aborted);
  	xfs_buf_relse(bp);
  }
  
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index e3ccbf3ca801..c39202c0135a 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -51,7 +51,7 @@ struct xfs_buf_log_item {
  
  int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
  void	xfs_buf_item_done(struct xfs_buf *bp);
-bool	xfs_buf_item_put(struct xfs_buf_log_item *);
+void	xfs_buf_item_put(struct xfs_buf_log_item *bip);
  void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
  bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
  void	xfs_buf_inode_iodone(struct xfs_buf *);
-- 
2.50.1 (Apple Git-155)

