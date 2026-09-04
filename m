Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667D3B4EB6
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538616; cv=fail; b=bf8rxBoA3TgykMPoBfhN+pC102QdD5Vh3Resx8Ze9GXgV60/L7/0f+JMNpCXtpoY4wlZB58j4AnBH2axN01D6o/i/BIXkWuvb761NuMxHKyyCk7uOlmhu2pOy4ECuiUHCp7o3YP3k0a9+A/bH7SfdVzyQU8++JeAvBtcv5L6XMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538616; c=relaxed/simple;
	bh=VLyj9Qx6p9fcmXjL0QUaWXaujljdXw8QGJ1CcDf3FBs=;
	h=Message-ID:Date:From:Subject:References:To:In-Reply-To:
	 Content-Type:MIME-Version; b=mQ3BFNjSqFOb8BxbEvjcwefcSwaTSG/p4o5NECP88il+fHsIAcld/yEVVXzO1uCeymZxsTQt3+T+20CvqiMxxZFScLldPk/5BFUYXr6fPkxzDDCuBIggPkrwAwYgsXyvr4UQZRve2oa35iCG4I8Gwx7smru+SFsCK5238q8UBdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OA4/+4aW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AplbR4lt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OA4/+4aW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AplbR4lt"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Bg5JR2674393
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 16:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	corp-2025-04-25; bh=sMkylwuh0nE8Q8tzUV6pldsZIqz2ezRLw9En72XPapM=; b=
	OA4/+4aWUK98dCndG6EV/llbhn8wRLbU6pQZyDjTjqO8Z6QKvLcbUxGO+BtUdEEM
	6F5vlM8DahgeucOpHEK0rfeRyTHXoV3DJHvaTnwp4go4jWWCncjzVRHsV6M7UsHt
	wLj+xPbVGYw8B39ZIgXrTvx/xzNwOOzTuB1Ps/eCyKJCSXi1ofD4TECFocYnC+G/
	vjaLjPCmJJqQufaBYbzizU9ZY0DbjslDvLZ4YgtFgiohgsRENvkWV1km1vfvZONC
	ypUH45fLPoGMHV1gmaI+TnMfmkoSyy6Omxa4kKvpNmIdhlrG+6F3Exm3GZA+BEKr
	0R3iIedxSazEVj8/27FZZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp72k0x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 16:16:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 684GFXBG020949
	for <stable@vger.kernel.org>; Fri, 4 Sep 2026 16:16:53 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvv05jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <stable@vger.kernel.org>; Fri, 04 Sep 2026 16:16:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrmzemgtJ5w/jt9Ktxj4T6kVh1gg0zRS3SU1DaP6UbJQSs1Wqi1VAEMQQ6L4t7eoW5fSN2oBWnHd+N3Kd8wXJow+RmU2qyrbKPYm2Xl4uzgA6jgswVRoXdSygJySyENB/rHz6Le9SEJ9j+J+gDh6VGmRDkvUgECpgBWF0l7NRjosvEKQXnrFxvA6mQ7uXnd9u8ZGlr8gCG9tPm9x+h9y2Frl+DPD/rcr4NwYcm05R58mDcn+Lzz03zO3GhuJ6qnVCwt7C1DYcczlDUmgBHaG05gRu04pJ2LDPoCUqW41nzkmYZ/MQaH/9/lNHy/U1TadTPLSVb2+AMr3nyH65mOVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMkylwuh0nE8Q8tzUV6pldsZIqz2ezRLw9En72XPapM=;
 b=L1WoWNFW/bW2iTayCXvM70GRW/aHmQ2zVompADFH4PbhXj0QvcC2gNrTvuiDMF+lNB+wxrr1JboYeUK71V0M1gubap8byTqml05yAcKTw4ezC8/PDaYlD7DIuKKkKuELyG1eEIe8+23frf/4d8n+SqTjFDmEGqUiwCD3LrLJciYtKnC6+jm1GOqbAfYjTvbS3ihw7tXwKi+4ypKibOxfZCW+bVNIedYhACEyI+iXfyB1Q4k+H07e3s+M2JFlArrd0cUUaXG1d7nEKayayIiTc+JD2Jsjye7JNuitOOV4MXw/HYHegP8hNmFKrIpUHOLkhUdddV1EaS/W1UhD6p2q9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMkylwuh0nE8Q8tzUV6pldsZIqz2ezRLw9En72XPapM=;
 b=AplbR4ltT5cnsKNC7DPer8DaZnjR6BZr+jB5095WnVeuVrAUfBOlr9Lcw65rpN4rSVx0JJeGFFL9NLqPaC0DbuvXJJp0U4qXzrkW1GjN0hZPDQZqJbU8SIRwLSfcPInl9U43sputzwkkB5zUieggKOAlKW4dwS+YZ6FZ7mskc5E=
Received: from BY5PR10MB4337.namprd10.prod.outlook.com (2603:10b6:a03:201::17)
 by SA3PR10MB6997.namprd10.prod.outlook.com (2603:10b6:806:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 4 Sep
 2026 16:16:48 +0000
Received: from BY5PR10MB4337.namprd10.prod.outlook.com
 ([fe80::587:3850:b94b:3577]) by BY5PR10MB4337.namprd10.prod.outlook.com
 ([fe80::587:3850:b94b:3577%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:16:47 +0000
Message-ID: <4febf4c9-4e93-4559-b375-42071ae2e4ce@oracle.com>
Date: Fri, 4 Sep 2026 11:16:46 -0500
User-Agent: Mozilla Thunderbird
From: Mark Tinguely <mark.tinguely@oracle.com>
Subject: [v5.15 PATCH 1/3] xfs: rearrange code in xfs_buf_item.c
References: <20260904161002.51054-2-mark.tinguely@oracle.com>
Reply-To: Mark Tinguely <mark.tinguely@oracle.com>
Content-Language: en-US
To: stable@vger.kernel.org
In-Reply-To: <20260904161002.51054-2-mark.tinguely@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::19) To BY5PR10MB4337.namprd10.prod.outlook.com
 (2603:10b6:a03:201::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4337:EE_|SA3PR10MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: c758528a-7a5b-45f9-0099-08df0a9feb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fnowS/lWWaPED7lWFUceDR2gm7gqBE2p0QRoZtiL1lfHtqrMC0giOs/6W2yGOY0+5DFCgdEfNIvvObZZMFf4k0Bd0bF/YzyOjbtGrFs9N6a4odOqjFzRPz47QCdeIN92gSBbUSSALDkGTicwiYfo33ULhAGVewgglzXBn+HMIW2uZz7G+tyKji2a7oaPSRyOFM/ahOQ5MtLLhJmsMl2dleIaOCP1w0k/ba4D8MkYeTzcjuHBvKZKXTzxZMjxurd5ike7Y0hYIhCH/EBIMIwqbQ5Uvp8reHDT0vsFFtfGTquc9wllXBlYmEVWPmxvfdOvbCZa3OT4PGy1Z7I48deBi8poQnvub9s8Yn5oFfvzRsyVsu6W1Nxc1eW9/rZNvAr4KNhmE3L/6DEiprDSi17Jq130nZA7UfyLihpK0/QUTQZqskaRJGWN8YEys4fIPvPB5d0R3JsWYlG56GAmJsnXyWaML/ASIZVFPoUijJbw43M/9azvQMeLmtMjTxYtrX8KjRZVsIwFHrACAud61UwDj8Y1JMuZraaQf12AZ4MBRFoFEVfag0oFJ3sr4pjFMp+1BrH4kiDXLsdOs91mMOwzOJzTLGgmE2fABSf3JpniB9UoKFc37j056vAysRNxL6cb+Q6WCVGiC4sfwyIYIYj4aVi8/cQzh2TvXB2bnkE/Dzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4337.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW5kaWcrVmpvc3NzV25pMElBUzErOWQ0dzZ4d3FZMkxhOHFmazBpYTd6dmRx?=
 =?utf-8?B?Nlh0ellNQlBTSUw1OWpoaCtsVlhnWVhWYjZ3QlJKWWpmbkZkTjdNN05EU2wr?=
 =?utf-8?B?bHBkU0NvMUY1RHlQczZVNytyZUlRbEthdzZsRGRWNk1QOFBpajJaeHM0WEZz?=
 =?utf-8?B?ZURzK0FFNElNeDlJVlFEUEJWVlo4Sm1LS05WM3ZJcXJkRnp0U0gxcnc3TWlm?=
 =?utf-8?B?RDJPaFJEa2dkdU1nOHZrZDBxQmUvSjFWZW9icGdGNXpTZHJneGNXY25DVGdi?=
 =?utf-8?B?U3o1bk8yaTUwQU8zRHRQRmp5MVoyRFE5eFc4aFlnT1V4bjM4MFp5dVhRcy82?=
 =?utf-8?B?MitxL241ZWROUStWM2VaeFdyNXVoemdiMVE5ZlpIZWc5ckREZzAzemtCb0pG?=
 =?utf-8?B?QzhoLzRleTg1M3Z5ZVpBcVc1RzR4ck9iWGpxWGU3eE1HSUU0d3RrNTM1bEpU?=
 =?utf-8?B?SjdLVGI2c2RBMU8zK3F2a01oVVh4VnRLMG43Z3IveGM3RDVFcEZuM1lKdk00?=
 =?utf-8?B?b05ud1pvYi9Hb1VNcWlDOE5VZWNWL2VPZU1FdSt2ZkxaK2ExYWVmakprQ2Ju?=
 =?utf-8?B?NVhaTzBYWGdldThsTk9OR1RienM3bkg4NzJ2L1RRV3ZzVDdTckZKYVNYWnRa?=
 =?utf-8?B?ZlFWczlDZ2JTSzJJeGQ1aTBHNWs5eXZwQWtTWk55eHVjUzkwb2xDT2pjaG1G?=
 =?utf-8?B?VmczZGdPRVlLS1Y3dUhmSzl2elJEV1BYR3hBS3pTSk4vM2dWZTBteGRRQXlD?=
 =?utf-8?B?RG9VazZDTW9oRm9zM1ZzbHpXNDk2Mnd5TzQ4V3NFYjB6SU1RSHJXL21uY1hQ?=
 =?utf-8?B?UWdzMU90Mk5HMGEwYVl0S2pyeEltRHZTTFJia040S3VtdGc1VzEvdkE5U0RG?=
 =?utf-8?B?UHBKOGx6anJMTDB4am9QTFFRMkRpMnAwUUxmQ2lKdzByVTd6NUFPTDU3SDZw?=
 =?utf-8?B?R2JxVWFjR0VNOUU2T1BuZVoranhlK1pLUnVTaDZCWVpjNmlVbEk3b2YvNC8z?=
 =?utf-8?B?MVg5cjlIempLcDVHY2swV0Q4QkdTTDJHajRnSU9PdGNqcDNES1N0Nk5ZUTBQ?=
 =?utf-8?B?blVhbDkxQ2NqSVlQRkxUeDUyVzY3UnhEQnZET3B0RjJYdElNQ3hqMnBUenlh?=
 =?utf-8?B?UDEwaStOekVDakJXTG9neU02WjFEMlJlRjM5dVllOW56NVFsbVFrUCtBRW00?=
 =?utf-8?B?ZXNKdWwzek8zK3Z6ZDdOTGdMamhKakdJSVBBeklWVVBZZitnMnlpK0NmWi9K?=
 =?utf-8?B?K0FSa3BacW5EOTM0aGVYRitlakRlZGF5STl3bHhXQjdhRFVZS2htVSsvcnZI?=
 =?utf-8?B?M0cvV2RBR29scGVodWxPRnlWeVhHN1JYcVkxdFFwOW5rUlRGQzdwWWMwQ01s?=
 =?utf-8?B?NEVTaWVwMU1nMTQvdkNQajR6RUVzd2EvS1ZDT0tZWjlRMlhaZWhkSVRLb0F4?=
 =?utf-8?B?b2w4aFQrdnV4UU5kN0JaclRTOTdEUmNDK0IreHBlNVZGeUlCWnhEVEQ2Tjdv?=
 =?utf-8?B?SGphSW5zMUV3bng1dXI2MUpQeFJZVFVyVXVHM1pEalRkb2h1RDMvTFh1a0tx?=
 =?utf-8?B?T2tjU29zdW0zS3pWL1NObWM0MmVnRTJIVEM0M3FVd3QrK2FjVGRhdFVoNXha?=
 =?utf-8?B?ZklNeDREVy9TL3pZdldmZ1dMc1ZHTkpZUDlCU29xb2dOZzJRVWhaem1pQXdJ?=
 =?utf-8?B?VUNvTnNOL2FLMjRYWEdQRWJKSVFYeERWYXlTWEk0alBjK1NRZFFyNlNTL3ZS?=
 =?utf-8?B?cjRDN0tjUzRGZHM5dXJMb1htWEhxNUpvVWpURW1KQ0ZQaHl4cEhyUzZZL1Vm?=
 =?utf-8?B?RHdCUEh5TVV0V3NyS1hVTzVUQnJ5REdIbFYrdXg1aDR3R3BkUVRTMFRyVVls?=
 =?utf-8?B?QUQ4TjhGZmk4UDZlTUplTWpWUkJhNTFWUzEvSnlSbGtqOUNROFFqdGxZdFZ6?=
 =?utf-8?B?b3RhK2dseXEvODFXRDViM2JXMTMvMitmaDJSVzhJZm81SUhtMll2ZFd1cjh2?=
 =?utf-8?B?a1ptU1NYSkxBenBsU25STGgra0NQdDBYcTZlV1hKeTE2ak5TbFBNSTVHZkx3?=
 =?utf-8?B?cDhuVHlHSkttL3JSbGl1YlkvNlBFRHpGUGFqWUVRVHkyUnE2U1dLMi9Vd2hR?=
 =?utf-8?B?Z0s5QUsyWEtyNUVVaWNiQVNIZmpMTFBUK1FVcG84aHdHbFdCVm9sTERKeXZp?=
 =?utf-8?B?NnVJMUUwZVBmSlNRSzc1VWI5N1IydmJqeTYrTzNTSWVlU082ZXR4aXBzT1Uv?=
 =?utf-8?B?QkJ2d2xic2xjRnVOSjE3NEFucXd0WnM5dVhsMmZzWHhmOGNkQU1yWllmN3Vo?=
 =?utf-8?B?ZExzd1NrQ0M2bVF4WWJhUnhhUG9LVURwc1hTTmNyQ3VlQXBjN1VvTFJiY0NI?=
 =?utf-8?Q?ai5DPtY3yrWDcmHc=3D?=
X-Exchange-RoutingPolicyChecked:
	q/6kq9qOVMG9zV87o2Mazs5+k7qEUQID8VggWwqsplk0IHSFa3ldabd/H4j673xkL69o+KF0Wjosb/70zjzkPYEOjlVPRJmXMTB9HGh7BINzgKsCnJZVR1u5pjfV/3WOzOXFIMpb4HQg5r7b9F2KT7l7NU9imSUv2rGahNV7JrSg4pz+eV4jjcwAS077zExlJiqWah3t3prj/5sUPCFIuPIFuH3VUvna62F9Socnz8CF3PyDxQyxqBoNIgD7AT8FcevBgYlFbyMtwB0t4mhK3f4Y4t03/p+QJUdHSyOoq22zeygqDRDAFJsnLilUazvC8+1IhG9Sc4exQUn1mGlntw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CEqBUeF7ZXgbmkSJDeSVstHkpGM5HWFLvgq0SWWiEiJzfub3c+dbEGcxgPHJj14rZaXSDdQy/iixHVO7bLMaSfFRHZt9Z76ksRAdQ31Q7vS4VpcZlFMPme6gQmtFtwDAyb7OvKT+66fywGjyPk7qmxwkNiGMzom+wzIjq79CPjjvADWyP4DboVvNm7PvqZZjAN1a5hAfwchLZ00azu2FaL96djU3h9dUlZgESZFubo0Gy4oGmUiJr9TUOVji3D2Quv3TgtA4cU6LYKQdnr6nDEihQUcqQAn8WksBidXiSCQGDsgddFajUsSAuUKcWglC2ncINSH5/THxsCIBBi2SKUIVnTvvK9810eYMoqzXEA6g+6bahtqqwQ79BqD1CzIdxR85tOq12Ac7weF1WtYjYVSDtlrQL7U8fLrqmKhKQP/r6xjR+4llTYOcgH47fwHIzQb8M/YrtqlGaTlus2QJPdx62GgrgRRA1BS+D64RaMGOpoSlF2rgJn8stN7IpLENOT4ZL+/k8zgeaJ8mc9VuPNgYh+TLB4eo487nv6yHvOthmq4DgtbMZO68CnOhohA6Zx2jgoNirUfA2684x4OhgmP5nJGyo0dXVAnwreIn/eg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c758528a-7a5b-45f9-0099-08df0a9feb86
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4337.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:16:47.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoZFr7LkTzMtzEJaYTZhOAlJnc6qLw7/vAnA0woMAM5qgDq54S8x6cA6m7GDuZkk5j32Af8rK4cIQb2u30jIQqZGH/4n6Sgz6Z3iiz7GL/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609040148
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0NyBTYWx0ZWRfX+KyfiMvtM8Zu
 yxErldScI+omOMPt+Vo+6ndpkIc9LuoD3+11pY0D9wB6JwL4qNivJq5m95cdXtEq0eceqkkT9tM
 Al5cOq/R8/XmfVRfGQyNX/62Lk4cbGYutPuTyHgnI7fN8h7wr3Fd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0NyBTYWx0ZWRfXycGydkiQHbz7
 a5uxbuc07nZzEYioFlukYKhGfJN35AK++gchlN7aVjUvE+Gy4o+oKeJMBDKjP/ocjh64gpEsAyj
 QMEGO4kfc0t4DwmDERPLZGEq6DQjvZ3F4BOUFsI9MbSDAxeF2HomPnHXsY+be4AvT82YNtKDY9p
 P8dr1Y1ywlRC+uBGWvA6wBj1IkMh8W1SbestQlHrnMpvFK6cRjaVCU2YcEvGPba3sSK0A3lRLI8
 ye6F7kOMVtWEfNlfoeiUZuImdMnz02A3XF0OAi4HaIZJc8+Kd0+5uBwaU3itMRmlepCh+aIJ2s2
 CohPNQ0qloXJEQ88mSV+ZmE1LdLSTwNnaV11xo3VSLL1fDIYxChGZfSKU83plVXQN2bteULc1Mq
 RKRYvg51peRHjBxybbjXFVf0BZXEMOOGrAhdZzslHzEwlEEyNLkZEntn3BY2n0s3e3iQCVQvZ44
 IbiGzM6xR0U2HkHzuQbiUw5c4AE2xSVOVeObwpq4=
X-Authority-Analysis: v=2.4 cv=G7os1dk5 c=1 sm=1 tr=0 ts=6a9aeef5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=-BFCJ2bJgao7vN__fc8A:9 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-GUID: 1LPuM52ELjiQi-E2xBGNZDzBHaWFo8JP
X-Proofpoint-ORIG-GUID: 1LPuM52ELjiQi-E2xBGNZDzBHaWFo8JP


From: Dave Chinner <dchinner@redhat.com>

The code to initialise, release and free items is all the way down
the bottom of the file. Upcoming fixes need to these functions
earlier in the file, so move them to the top.

There is one code change in this move - the parameter to
xfs_buf_item_relse() is changed from the xfs_buf to the
xfs_buf_log_item - the thing that the function is releasing.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
(cherry picked from commit d2fe5c4c8d25999862d615f616aea7befdd62799)
Signed-off-by: Mark Tinguely <mark.tinguely@oracle.com>
---
  fs/xfs/xfs_buf_item.c | 114 +++++++++++++++++++++---------------------
  fs/xfs/xfs_buf_item.h |   1 -
  2 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 9f8225ed234e..3e2b0346562c 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -30,6 +30,61 @@ static inline struct xfs_buf_log_item *BUF_ITEM(struct xfs_log_item *lip)
  	return container_of(lip, struct xfs_buf_log_item, bli_item);
  }
  
+static void
+xfs_buf_item_get_format(
+	struct xfs_buf_log_item	*bip,
+	int			count)
+{
+	ASSERT(bip->bli_formats == NULL);
+	bip->bli_format_count = count;
+
+	if (count == 1) {
+		bip->bli_formats = &bip->__bli_format;
+		return;
+	}
+
+	bip->bli_formats =
+		 kmem_zalloc(count * sizeof(struct xfs_buf_log_format), 0);
+}
+
+static void
+xfs_buf_item_free_format(
+	struct xfs_buf_log_item	*bip)
+{
+	if (bip->bli_formats != &bip->__bli_format) {
+		kmem_free(bip->bli_formats);
+		bip->bli_formats = NULL;
+	}
+}
+
+static void
+xfs_buf_item_free(
+	struct xfs_buf_log_item	*bip)
+{
+	xfs_buf_item_free_format(bip);
+	kmem_free(bip->bli_item.li_lv_shadow);
+	kmem_cache_free(xfs_buf_item_zone, bip);
+}
+
+/*
+ * xfs_buf_item_relse() is called when the buf log item is no longer needed.
+ */
+static void
+xfs_buf_item_relse(
+	struct xfs_buf_log_item	*bip)
+{
+	struct xfs_buf		*bp = bip->bli_buf;
+
+	trace_xfs_buf_item_relse(bp, _RET_IP_);
+
+	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
+	ASSERT(atomic_read(&bip->bli_refcount) == 0);
+
+	bp->b_log_item = NULL;
+	xfs_buf_rele(bp);
+	xfs_buf_item_free(bip);
+}
+
  /* Is this log iovec plausibly large enough to contain the buffer log format? */
  bool
  xfs_buf_log_check_iovec(
@@ -533,7 +588,7 @@ xfs_buf_item_unpin(
  			ASSERT(list_empty(&bp->b_li_list));
  		} else {
  			xfs_trans_ail_delete(lip, SHUTDOWN_LOG_IO_ERROR);
-			xfs_buf_item_relse(bp);
+			xfs_buf_item_relse(bip);
  			ASSERT(bp->b_log_item == NULL);
  		}
  		xfs_buf_relse(bp);
@@ -629,7 +684,7 @@ xfs_buf_item_put(
  	 */
  	if (aborted)
  		xfs_trans_ail_delete(lip, 0);
-	xfs_buf_item_relse(bip->bli_buf);
+	xfs_buf_item_relse(bip);
  	return true;
  }
  
@@ -749,33 +804,6 @@ static const struct xfs_item_ops xfs_buf_item_ops = {
  	.iop_push	= xfs_buf_item_push,
  };
  
-STATIC void
-xfs_buf_item_get_format(
-	struct xfs_buf_log_item	*bip,
-	int			count)
-{
-	ASSERT(bip->bli_formats == NULL);
-	bip->bli_format_count = count;
-
-	if (count == 1) {
-		bip->bli_formats = &bip->__bli_format;
-		return;
-	}
-
-	bip->bli_formats = kmem_zalloc(count * sizeof(struct xfs_buf_log_format),
-				0);
-}
-
-STATIC void
-xfs_buf_item_free_format(
-	struct xfs_buf_log_item	*bip)
-{
-	if (bip->bli_formats != &bip->__bli_format) {
-		kmem_free(bip->bli_formats);
-		bip->bli_formats = NULL;
-	}
-}
-
  /*
   * Allocate a new buf log item to go with the given buffer.
   * Set the buffer's b_log_item field to point to the new
@@ -997,32 +1025,6 @@ xfs_buf_item_dirty_format(
  	return false;
  }
  
-STATIC void
-xfs_buf_item_free(
-	struct xfs_buf_log_item	*bip)
-{
-	xfs_buf_item_free_format(bip);
-	kmem_free(bip->bli_item.li_lv_shadow);
-	kmem_cache_free(xfs_buf_item_zone, bip);
-}
-
-/*
- * xfs_buf_item_relse() is called when the buf log item is no longer needed.
- */
-void
-xfs_buf_item_relse(
-	struct xfs_buf	*bp)
-{
-	struct xfs_buf_log_item	*bip = bp->b_log_item;
-
-	trace_xfs_buf_item_relse(bp, _RET_IP_);
-	ASSERT(!test_bit(XFS_LI_IN_AIL, &bip->bli_item.li_flags));
-
-	bp->b_log_item = NULL;
-	xfs_buf_rele(bp);
-	xfs_buf_item_free(bip);
-}
-
  void
  xfs_buf_item_done(
  	struct xfs_buf		*bp)
@@ -1042,5 +1044,5 @@ xfs_buf_item_done(
  	xfs_trans_ail_delete(&bp->b_log_item->bli_item,
  			     (bp->b_flags & _XBF_LOGRECOVERY) ? 0 :
  			     SHUTDOWN_CORRUPT_INCORE);
-	xfs_buf_item_relse(bp);
+	xfs_buf_item_relse(bp->b_log_item);
  }
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 50aa0f5ef959..e3ccbf3ca801 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -51,7 +51,6 @@ struct xfs_buf_log_item {
  
  int	xfs_buf_item_init(struct xfs_buf *, struct xfs_mount *);
  void	xfs_buf_item_done(struct xfs_buf *bp);
-void	xfs_buf_item_relse(struct xfs_buf *);
  bool	xfs_buf_item_put(struct xfs_buf_log_item *);
  void	xfs_buf_item_log(struct xfs_buf_log_item *, uint, uint);
  bool	xfs_buf_item_dirty_format(struct xfs_buf_log_item *);
-- 
2.50.1 (Apple Git-155)

