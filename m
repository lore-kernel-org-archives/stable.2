Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE143B995D;
	Fri, 17 Jul 2026 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301237; cv=fail; b=dwi6JRo+9mB0viAXqA+T5QCMQmDNKoYrW+CeAwgndA8DUubgqtMhsG3sXLiVy2b7cT4ZB21S3Ih/pFE2GgqddoWUrm/loglYQLUjqeTMw4ixPEZSFanyN1mgqIFCcOTJnv47jX4mDc1/PC4/Da9ck13EogWHYY0qH/sWpItlTCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301237; c=relaxed/simple;
	bh=/ghtQE6wEtWNx8CcqTplXHEAyeybgT6JevS3v26Qqzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dAwfKrrE9DzuMr2Wu5LDkJtT7OWf/Y74/nUjq9rrTdjLJrCKZuLUExumqLcIcPXBqOqlKGFsHzwWr1kvnlMZN0v18Xf/KZxBAw7RhsD4Ptcf25mqMQ6xY0Tt2i9LAt9NI1esE5sTi8zt8L7/kdk6Nxj46aSsRAYtEXL1LwT3ZpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gdb8o8Ab; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eSUOAMAB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gdb8o8Ab";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eSUOAMAB"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H3BniD2128064;
	Fri, 17 Jul 2026 15:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WLwvkQr0+8OfXt4gO2hr2U9wMxspXYTEUHk7tntG1pk=; b=
	gdb8o8AbFFC670rR8OWpWudZg8mJAIwROxTG98acl30MArxXEdh8i4oj7AH1SUiD
	JErqQ1gjMDoGP+IYNFa9EONlvNcEQarYxmebXVMKlSjDZ7ufHv1A8KTvKOeVsAeL
	xKHzoTTAw+GqJvp9Cw+HaUq8ssl0LmwYY6sXpOOsJEfAWs90cRgpvfuezov09AbU
	u2BNTHcfi2kBd37ioKa/VcSsM+5bhFNJXLQ+6QSx/Xcpmrb2gvNyGSIariVv97lu
	tjkBrNavNmCX/VxFOAv8omqMBkXu3rDbh32C2rrUBBOlZjiePinOQ2ogC5VAyoCD
	w8XmBp3e4abejy/zq3OPqA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef12e31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 15:13:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66HFD64t015144;
	Fri, 17 Jul 2026 15:13:44 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4feqydtu3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jul 2026 15:13:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbTe3YKeEp08U94O4KpEfW0cvhdJowqcl5/VIgjDJGtBPUq7aoWsgEoRgB6BWYeUjRPVaFbIUfVSnE5PhMXUKCgAD8bRk8svvE93rQleA54ztD9M2pLypZatLp/KjteFA79FkBjAyAbyJW1Mmt9LiH/lLrTzYFWcYHwPu1OpCHN2+BMMDQEAqg9h0nPqUb2QQE2qYbhSQVZGId26KyXX4KZ4264+x1tKB6aEW8pOhsXgZak9tgf/J/9buBfhfyqxAEeJYl5pZb95dW8RQL1p+eI8OdbhxYFIQ3r7qPwck8+5zTiQTizzbWPMjQC+tl9/mRduIRKIxabe6dMgFuScRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLwvkQr0+8OfXt4gO2hr2U9wMxspXYTEUHk7tntG1pk=;
 b=wVvVVrJb0npgJsd75uw9wHWaGHCVVpuHjhIKIco4sb5qyXz0aIrowW3EGW/TQksJMdDLzYZX66yd/xTpCoT4PQJ+kGDlM1bozxfjuxcmVPCsnTgIDQewEPDQj4Co1WQgiwYr3ofF9Ov5212+GOrBqlJhycnqc14ZyZIkAPLdgOh6uNk6izfWIv2QxT35rE0EIGT2u2tY2ubCglkIR0EbygzdMoymCSdh5mqPZuBDylnuPxbSVEifxZohpAVd+BAlah93fupRHyrKLaorw7WAAVZ1N+PBy0OJeN/Z7F+2pXV10h3xEpmUIc2nYkUdVNB6CPx9DRMhij61t4pG1YhG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLwvkQr0+8OfXt4gO2hr2U9wMxspXYTEUHk7tntG1pk=;
 b=eSUOAMAB7ZrSN8mPsSeGtdVPovOlKhIsOW42bjZCMOx20TrSz9Z/EyYlGMmqalGuPS9smhtmFSsy2bXZUSPB8Zj8qtC60ibRUm42OWzz/As2VzSPV9+P8yttSlunakLRYGrItiWlWMygsV8DgWQ3G014o7nEuoYvrTLRDISFPEA=
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c37) by DS4PR10MB997645.namprd10.prod.outlook.com
 (2603:10b6:8:31d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 15:13:39 +0000
Received: from DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::4713:6549:d8c2:52b5]) by DM3PPF905D77450.namprd10.prod.outlook.com
 ([fe80::4713:6549:d8c2:52b5%4]) with mapi id 15.21.0181.016; Fri, 17 Jul 2026
 15:13:39 +0000
Message-ID: <8f5b5350-0be9-4b79-a6c9-069d418dee30@oracle.com>
Date: Fri, 17 Jul 2026 10:13:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-scsi: Prevent OOM from invalid protection SGL count
To: Jia Jia <physicalmtea@gmail.com>, mst@redhat.com, jasowang@redhat.com,
        Linfeng Sun <slf@hdu.edu.cn>
Cc: pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260717142205.103515-1-physicalmtea@gmail.com>
Content-Language: en-US
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20260717142205.103515-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::9)
 To DM3PPF905D77450.namprd10.prod.outlook.com (2603:10b6:f:fc00::c37)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF905D77450:EE_|DS4PR10MB997645:EE_
X-MS-Office365-Filtering-Correlation-Id: c01ccf5c-93d7-479c-c8e2-08dee415faeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	u4KLfU5CYiQ4yCL4cejCtD6PT892AyygWu96g97s6UI3kYQg6I6q2IVMPkH1o+xFXJRvEqVkkSQTOKtE2W9kbUe7ojLbJlV/klL54LjfDSrcI0l4OirwUGfIhDDUeBfHUaSypuEgY6p8XEcLXw6C3vn0I3yN2VLaWfwUWTSpX3HKGyfAZznXP6kDU8FWp9XGkunj9R+okwu1MkXlS8S/Coh4dYvvJrRUHVTAbMdJYti5BAP9IeaA0b21VSUt0g6WXsE8pECQuhA+qLWTmvQYbZWIHajtWhOVfjnjG5f3AbPgoFfYJYN3qis5hMZc04xmuuAodNh2wTEuJtknfipWxkOidlgJIQhymUyXxiz5xmtJxUx/cKmMHtl7XtvMxTGrCdXMhkEokrJV7X3amaXmhVPXrfOOIKt5GxeT2zkZlOq7dMeA4Ol6OyVf6Pe5aQIl+oNVUsbrzN+I7VuZuX9wq/Yidcro64TyEt9uLzJC5eYpGR3nASiHQ2MSMVsccCCTV+bDj3OSeiwZF9leF2hVSaxkJA7xoKTwrTksngDffNHLciUXNNJIQFSbU3AxE/fDEH6Nd1K9QWw4qbYcbeuC4qyqvWrBojsfja6EoHb45GlLJV+7Fc8zmllcfqhaoVgkgiALM9VacLUZRzY09J4ME4NDr5iTZqqgrrOvb2ixIFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF905D77450.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHIvdldPZElsMDZYTXh0Z2JCMXQyR2xBUmh2VWEyRDFGRC8rQkIvUUlWVkk4?=
 =?utf-8?B?c2NqUVl4NmU5RUdKcktkR21yV2k1cmZIQ21EQTAraUdBNFZ1cXhkSEZ5eVhT?=
 =?utf-8?B?Y1FYbXFZOU1TZUhHM0NVUzNHcGFCU2pQVTNWZGNSalhJaHVic0pDbWVFaVFJ?=
 =?utf-8?B?Nm9yVEQrRHcrdmJvNVpVOGt6YnZpcTd0S1BnakdkdXpPNlByM0s1andCUHhV?=
 =?utf-8?B?Y0diUG5mRkN1enlKejlmS1FQaTl3SXh5eWNYMTV4Z2tDWmMrU3dwYk9vdTk1?=
 =?utf-8?B?dWdVN2JnbURXTmhwc0wzVWtYcFFRc2NUY2prV255ZnVuamFKNytJaHVpa2Fm?=
 =?utf-8?B?UzNiZzBpNUhQZllOdWh6bTh1bjh0cFNNOXdTUm1nbXdIRWpJL0NaS3RxTGNy?=
 =?utf-8?B?amdpNTlreXV1YVlDVnBId3g0OUw0bmVvOHJNQ1QyQmlBZ29LcEJCbW4vTVJH?=
 =?utf-8?B?aHF4aU4rYlFQRmxqWWJNQWpLcHpIaHV5S1dhMDlZV1d4V3pwaUxWV2NOd3JZ?=
 =?utf-8?B?ZWU0N0JDSWV3bWRNd0M2U0ZxcnNKRUY1dnYrMXptUU42b1Q5U3Byc21MNVNJ?=
 =?utf-8?B?RHYydlplSUQyc1NlaExGOW9KODgwY3R3NHZ6QUdFN05PcHR1YnNlR3BrcmdC?=
 =?utf-8?B?Q2Rac2N6MmN5bXhBeEcxdEJaN1VJRTdxMXErQXFZZ2RZbmtWOHNLdEYyMFk0?=
 =?utf-8?B?MHhFTGZURnFZZjhneWRSV3R3K1U1aFpaTURIdjByRCtHQTY3Yk9EMzlFTXNT?=
 =?utf-8?B?a2ZHVTh3MElUeks4UGg3bldwVENxK2ZxTWgzWURFWCtidTR5OUVadHZjNDVB?=
 =?utf-8?B?SFdwQzhRS3hwYUdBNXhaZk4rdU5OVHdTT1NpbFVRdjN4SVFSdjlqdm1EdWFi?=
 =?utf-8?B?ekdtMUtlQWRUMzU5a0J6dWtxMUNhaWpaaExXbXlWenBJVGdyNEk5UkUzWXgz?=
 =?utf-8?B?aWFtc0wwQk9OOUpzYnpuRW5tZVR0VzhodEVrY1NML2VtZVJ3TThJQStuSDRu?=
 =?utf-8?B?RWpLR3hLci9ZektmcmFWVlc0ZlpCeEJuajBybGR5ejFWS2NWczJFZ0xOQWVD?=
 =?utf-8?B?YlhVV1F0OGxNd3NOUFJwdUZsdXVNNk9xODVJc2ZvTHV3Yml1bVpCaUtoWmo1?=
 =?utf-8?B?Rm1HcmhvcnVQVnViTUZDa0MvMnp4dFpNdDNFSzR2b3I4SmltVlRSVmFMRTUr?=
 =?utf-8?B?SWdiU25PVm1kQU1VNk9UV0lzcnNOc2g3d2pGL3hSL3hCOTlnODJnbVZjeG1P?=
 =?utf-8?B?ZTRkRC9YUEhDbUg1RjQ4aGZZZEE5bk83QTFySDN0OFZuRWtKdnBsSmc5OVJ2?=
 =?utf-8?B?bTNZemZrMkpPVUdDSVRuVHZHd09pZHFpL2Z5U0Ryb3JsNzRiU3NTZmpZSVhP?=
 =?utf-8?B?cWtXSnBxVnV4ZldBcXllNVR0VXo0UGlidXBaUVBPbDFqY3FWVXEwcFNOeHJN?=
 =?utf-8?B?OFVZcjZxSlFwb2FlV0wvN1JUaVc4N3A5Y2NMYjF5Y1VpSFhWUVpQUkw0WjhZ?=
 =?utf-8?B?WWU2SnVoOWRwSlJSZ2pKbytCTnJwTzJMWldYZU13WmFyZ1dxZ1JmYVpTWlNE?=
 =?utf-8?B?aVhaaFRYZnNuaVNDWEVlMVpkQ3BvN0djclVkd05YeUFRWjUwNEIybUJsWW5P?=
 =?utf-8?B?Z0pYaHBvZ2IyTHl0ZlNjRkVwa2pvUzlGaks5L0RuWmYyV3Vad3h6clhBa2FD?=
 =?utf-8?B?dnZkSEF3SUtETDJrUlNQeEVQNUtsRHVHSEp2ajFBVzY3djN0K0lVNG5zeGc1?=
 =?utf-8?B?STlmb2Y2cVN1ZDg5VnRFYVh4RE9GUUkvWHdTZm0yYnNxV1hzMkRHMGtQc2Fq?=
 =?utf-8?B?T0hDMU91ZFdwWk5FamhSSUNGM0Ztb3QvelJtaFZrVHAyRDBqdWprSXgzbUhi?=
 =?utf-8?B?NmdQOFRNQVRxVmFOMzBlMlBoeElIU2ZSQnZZUGlGQXNxWVlZS2FHamJiUjdm?=
 =?utf-8?B?ZHhSQ2haMHEvYlNlOEloZEM1blFPandWdm1BOVJINC93eFJ6bmdtRVErRGk3?=
 =?utf-8?B?Qlk3VUFnWnNadkltdWViOTdWcjhwZlN0NEtBcXQyL3g4TjY2aFI4a3NvVTZV?=
 =?utf-8?B?YjBwQ1NIMitXM1NwZkt1T1pWVytlT2tibitXUnVIY1hzcEJ2cng2b1p6amsr?=
 =?utf-8?B?TExJQ1k5blNKc3Fvcjcvam5ma2wvc24yTndHK2psVzZwU3lkek85ekRkQ05h?=
 =?utf-8?B?b3BuTCtPRE5kcjY2b2daSExaZmpXN0VhVEpMdU0yTklZaHE3Y2tXVzZiZUlT?=
 =?utf-8?B?VndEYkNvRkt4VFluVGNiUnFmUFY3Y1lrM05ydTlVSXVOWkpoNjNTSjFVUzVs?=
 =?utf-8?B?ZXhrYjZjRGJWL1J1Vmx3YTZ5R250V01IQUVlOXJFbG9KRWlpaW40L0liWnFI?=
 =?utf-8?Q?6tAxqSRLijdk7SJo=3D?=
X-Exchange-RoutingPolicyChecked:
	nQH3OOaAula4CZpUobMlir91lBZuuffHvKKUTbjmihs7yp95Zsr7Dvp9wHQFU2Tpcf7djZXOudSBvkZBgEGVHTyOrRK1gmvmb/fsJbIqRUR4j+7ISHqo2SEM5546msk7hjsHp3+TVURlKjLSWjt+CvlTPlX7/UqTGMZi8ULleG52lKLPV29NwfNtQV1cK4a9Dcruz3nL3B37tQ6jHAvfzyv4SH2QxwtU/bz2Gm00KJng+wRdvIpsX/T0XvgHrIae1DpvTnJLM01kIIyONG96slBGSwlWes1QycSw++hcUbBSdsjWsHjpoGwo18Wo39/IWaOchHehQuJ9pc6y9rF7QQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	viOqSRwbN9qv0HSmaijqHjd20HgcodXZmyByDZXLVlsKRVsE6ImIFy/oxsdwzPLSkAJY/M8I0MWW81/6D9SNpxEJVkkqr/nbcuoodkULmDpiCqajxCenx1M6QzGa8JxNps2c+yogKOePpoAPi1N7mdd7WcCvNhtMjeD37krLmOShB+YSxmFRlpZpsqb5EdNm4qIs9ofL2g1F9kSpATJjI3gHmX8W+59j8uLNVnffViszkBhyyYHZDJMCCLki2euZHRPo6UeYxw6YgAnUzZBEe2JCtc28FHkDbUlVDGq6eKC/yIBKjt0EG6bD1r6D8PLRZwFYannxC3LxLsZ2yuVnodpjdSK9Lhzxp1QkN4wfHCZjZod3CKgdw/rNW+50euxmJRy5IFIKuRw5E4K0scS67j3eBdWKPTJrHUohRVrFAFVZMN7EYKDwsj6Lrjl3oojCxYNlM7etlgfWntI5cywWkwLJqDFGD0DlIXLTHE6VSFpyOwxpqDcBFQYDGd9jQu2PYox/1PZGdMn3d/pjKszOTi7Y6e+Nyw4gBjTz8gcQaekIbdU6DXLspOyiObm05Cn+7btL99RvR0U738B4vuXD2GDX5oPmRtYgtDPH9yiGsaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c01ccf5c-93d7-479c-c8e2-08dee415faeb
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF905D77450.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 15:13:39.0079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx0Ig63qOEPHgnCfsYka6yZBqCu8QuFiQYtdepznQzAqaMm6i5iHDf2j3j/cYWk4P8z5KeWKKjkcBN2fZU3DipXJol7o/A5JVwVvfe4GB3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607170155
X-Proofpoint-GUID: mI-ZuObXPrVjbhbMab7a30JlHg_fTY9Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1NSBTYWx0ZWRfX2zgBYFR9NcVF
 bxYbQZuy7XGoQ1ikQpM1oxkLicw0oequr9/SMD2ikA5UCpVFl2ysVy8V6HgzMvvOF0U1XCh+qS5
 8l1TdNImy1TCvFk911RWV9VDCqxDjmrSPyq1QjXoYx9QVDOisaUt
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a5a46a9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=CWZUECOaxHUXl4LXcaAA:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1NSBTYWx0ZWRfX3fO+YZhJJFkX
 Di9r52dNTpGMRW4bWTxgiAu6eh8JPZMp+2FHqlDD6D/bW3e+oi22Ej4XRjurK61aKYBdhRAKXvg
 IalyAdd73Q+wtbaGfGEso6WRHo0W293KHWeCJJKaTDBKUqFiT1zEzJ+YgwPlIBjOcpQJ3l4OHSx
 B/C8XQicdzVkmWeqye7ypfNWroxax7p249Rtepia12j5jvd3lPS1mCSTYle0IYr9o4blOWN47c4
 NP1AwXVl4GEB2wkeT6GrKzKnyykb3u2iMBaHme3138xeFtGfj7Z2qoMeUEz33+Er0NRBPdAFX0W
 XluWgF8qu4X5ifLQ2rq+0xE1P0Ny7WOB28yCBcY18t7HU9hOAtutJwBrraHvkLvwAmgL1wVHVgV
 vsgczBwHwEMw3fkZD6H3N8DTwgpU1Pq47tSq+RnB+G9En1SaQk2JGjhGKAdKWnSTc6DAdjjK1gS
 1ddHcOPE3POniT0yQ3g==
X-Proofpoint-ORIG-GUID: mI-ZuObXPrVjbhbMab7a30JlHg_fTY9Z

cc'ing Linfeng.

Linfeng also reported this bug and provided a patch that has your check 
and an extra check to avoid calling into the function in the first 
place. It's been stuck in some other list.

I think it might be best for Linfeng to re-submit their patch now so it 
can get merged. For that patch, I think there was one outstanding 
question left where Michael had asked if the issue was found with AI so 
the proper tag could be added. I don't think that question was responded to.


On 7/17/26 9:22 AM, Jia Jia wrote:
> The protection SGL path passes the result of vhost_scsi_calc_sgls()
> directly to sg_alloc_table_chained(). The helper returns a negative
> errno when the iterator is invalid or the request exceeds the segment
> limit. The negative errno is then treated as a very large unsigned count
> and sends the request into the SGL allocation path with an invalid size.
> 
> Repeated malformed T10-PI submissions from a host-side application caused
> memory usage to rise sharply. MemAvailable fell to about 200 MB, and PSI
> full avg10 reached about 1.46. The OOM killer terminated several userspace
> processes before the endpoint cleanup completed. The kernel log included:
> 
>      [17036.451028] Out of memory: Killed process 2345 (systemd)
>      [17036.493325] Out of memory: Killed process 2349 (sd-pam)
>      [17078.265127] Out of memory: Killed process 1793 (networkd-dispat)
> 
> Return the calculation error before setting up the protection SGL. This
> keeps the protection path consistent with the data SGL path and prevents
> the invalid count from entering the allocation path.
> 
> Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>   drivers/vhost/scsi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d..8486652fd 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -972,6 +972,9 @@ vhost_scsi_mapal(struct vhost_scsi *vs, struct vhost_scsi_cmd *cmd,
>   	if (prot_bytes) {
>   		sgl_count = vhost_scsi_calc_sgls(prot_iter, prot_bytes,
>   						 VHOST_SCSI_PREALLOC_PROT_SGLS);
> +		if (sgl_count < 0)
> +			return sgl_count;
> +
>   		cmd->prot_table.sgl = cmd->prot_sgl;
>   		ret = sg_alloc_table_chained(&cmd->prot_table, sgl_count,
>   					     cmd->prot_table.sgl,
> -- 
> 2.43.0
> 

