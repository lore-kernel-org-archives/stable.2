Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986F4519B0
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467999; cv=fail; b=YUWSTjXFKtiGAStCtcKY18obu0GBZW/U7YZQqKZc8QGokpm0voSRhY129zk6t9OK83/SAUnukhpILb3K0tf1dGSlro0iM5CrA0t4Yp4kaSOKLMWIDlTs81xp/AvYWNi1xk+VVV9dDkUpkkF4OorHFlM/lGpHEWw9PJg3icIyxaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467999; c=relaxed/simple;
	bh=1oa5leMmwjMODEs0prxF+rhQ0B+rl2ZmbXL8xcxzszw=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=CF0ySChe/PwvA57SubyMBMnPPiHSmo4/3TSVQS4OG/h9TeTq96mukUv9/AXi+44ipQH4hbAgX+up40R7ClgzuVs9Ql6Klqh50wr1NqBmTZhxCA+U1GqNZWLXI9HWMvkKHxi2Jo50G/iSWh33X5RyWMYXFZOz8nhP5c6+JeXDaaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZA7dF04+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c82yUoqG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZA7dF04+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c82yUoqG"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BFMqQu2905667;
	Tue, 11 Aug 2026 17:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=lI2O8e3/QF/Qtxe/
	E9O0SynDm77zrJjxVXCXG/RNMXQ=; b=ZA7dF04+Ux5Qo36A3ZpSnj+nkPo4nO7p
	VFolgR5r9+zqJIrGTNIMeOJoZbxgzBYMmkLGJuz0U9g74gxQw1qOVsmh7cG3q6ii
	8EcYrEc4KjO52bZr+0lqEOJvhwlrR5tjXe12A/xGErKuX7JQxvawt12PK17S4UAx
	ggPyaY1LPGCEkp/Hbkk7iVHG6m5HCgt4gCS6QkutulsdD/JNIIBQ9+QZPYZe7Eu1
	bIGBd4nSu7/ehQ2HAYM5VUHyv4L1Mg1a90z0wioC1VyFXRqi9VhMb8s1UtVPQKQB
	I0qycCzjHkZAMXTikQaL243lDlXmZiMXIePsAKSBIiFyELbMKpSBqw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvkcna1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 17:06:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67BH5rCw039153;
	Tue, 11 Aug 2026 17:06:34 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwquh9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Aug 2026 17:06:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koXjO2qmjwIT3c8kEl2JHTWSFi0qkTt39UBI+pg6YJXjUoRioDfXyFqFyzSuKkDBLkbKKBLSiuU2rIikffgPMInmiLGpF1qWMMuB3HBZOFDUsgYRnRB9p+1cI0Qg4Arg3lOlxD7sDYBMwZ4ueBI/I8Hqet+D2SzqhdPmToD0cm34GxANSSzpD1AV4QBS5MhvtLvrwu25fj/FvoqzsiU61pZ45PdLPuFQGYav0rVs7bLfvi03R33bbyQQdtA43EwLAMCwnpsjY84ck7Rlz+dqQwEnwK0OX9OhS999QK8+4194kHqntAt+PC0T0RjLchAKAUo5KyiGV64rtKks1oCvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lI2O8e3/QF/Qtxe/E9O0SynDm77zrJjxVXCXG/RNMXQ=;
 b=GV2iRZMCADG5UVw9e+quNE0/+7UvTVYE+IDGJ+CK4tiTcVxby/xKZwx0lf8JrVOf33a1y2eP8+LKIaZflDLX4+Clwzv6prjZvM2yNuGkI2bxGxnAHFel7IMk11uOsODofjNT4nEN+3nuSm2LqVAuPBdSXe302oFcRLFviyljC8vymAXsuJ5XS5nVWa4h7wzNdRpYpRPpQ1QxzPKj8HnsH+gk0+l1FsOgXUWv2wEUqL5Q3OnD1gtukxH00iJ48dq8TcqYfYB7YRvJH5WRN6xmXZKKlJrz5WBLBctI0/FqK7zZvUJkzQIDH+uFenrgmle2TYoyabrhpuF7QNnOSbGAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lI2O8e3/QF/Qtxe/E9O0SynDm77zrJjxVXCXG/RNMXQ=;
 b=c82yUoqGWDr4QcqwvWU45nHSOWCO08ZNSDoUm+ekoM+W4F0XQOu8F6jCRFQhOZlMBzfuNg/GHw2uvUOspnk8JeIjDeloMm2uEfJPXexLcVSQiebIwm/T6uU33dhHjF5Rwncd7mTM/UAeyCs1PXdTjtroQksxxBDqVR7NacudHKk=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 17:06:30 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 17:06:30 +0000
Message-ID: <5b4ec416-804a-4bd6-aa12-5c317741977c@oracle.com>
Date: Tue, 11 Aug 2026 22:36:25 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        vegard.nossum@oracle.com
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Question: Why don't I see FAILED patch notifications for commit:
 622ebfac01ba4f9c0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::14) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c13358b-8284-4f63-97f9-08def7cae322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hhGNwE7k4XBp1mje73GNdI/gN282hgvSZgImjbYAGNHNSvQr0+t4wDTiK7vcYuMDkjJ5WWSa4NW6RUu/0zplsudr0a76hKw+cAkR5bKVQn27IIcnPUdCIsUOud1Sk8jMeU67WxqxH4jNlZwJ/cXbkvTZ9Oex2nHDGpmglMsMu2zu8xACho9AxCLa3H4awyvpCFC0hwJqQE7bhOcu9UpUvLc2Oo+SgtiwcsBnkLW/bu/wggSdKRzYb0S/JBN1+/CPCTwM4WG6nN33brbnrX2Ykc2l0QYYgnP0HOKCwEk+dF7sHPs+31BTW65sJ3xbe9NtZKIi/al7MlgQo60N3YvPH8jwaTdmT35mYS+XiNH+pov7sPw0K45MlaTQkk7rJypakFSZ5u116SkCUbiyEL5Atu2LeJjRi8PI71H2rF2pGw9xv3OL+SBLoTHliFDqU+PeTOzItEzpeUP1NkufsVNAKU9vJ78mPo1aIoOj3CB8X/Qe5uHvlyaCChFDHzciIVX0J4izArp2/ufvQYDkyTezN2PMeFP58noxD3nE96xbpnEGiQkG+RxDBu1nP6tVxbRs6Mz1826g8QC6zwQLTak6om7ZQ/9BbE/KI7BT0BXYnD4PDCSc+/0QA3OMO7JsizSOUm+gw1T2/bxsGM39anKwVxWtOQOBCTf4ZwAWB4TIUWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWsvTUpGS2FMcWVPMW5lNjRoRFhrb3pUTmkxUXJpSE1iU0s0cHNKZlpwQ0Iy?=
 =?utf-8?B?TFBCc2EydWVkS0NUczlyd1VDcmt0SW11K1pTVFdyY0xDVVBPVW1ab0JGZ0hH?=
 =?utf-8?B?ank0ZFl1eUhHcHBLY0hIOGRVcTNWVk84OHgwTVZSODEydXp0WGxKelJpWXFo?=
 =?utf-8?B?SG52SmNDSWlFK2lLK0Q0UDJSUURYU241OXkxbjB6SCtwcXNJZTR2SFdkZkZi?=
 =?utf-8?B?alIzME5yWEVPYnExZFRiWEcxM3UrMUpwclRQMHFHOHhDeTZkMk1Qdm5yT1hF?=
 =?utf-8?B?K241S1l5bmphWkJCMGVGeWZSeHBwZXpKaGFXWHkwemo4aElmcVdlZzNteElL?=
 =?utf-8?B?aFVvR2tkS25HNkNnbitrQmFicU0xSGdidTNtdDUrc0xod1NvV2RRREtiK005?=
 =?utf-8?B?d1M4ZW40SW03cFpnYy9kRVV0WmRNaWw1aFppRUxxRVM2ZkVYc2crNk5sVWRo?=
 =?utf-8?B?bkM5a2k5czVNNVdCRmo3RzdSZDlrSkJtejQ3YU5Vamk5SVRJZ09GWEVYRWFs?=
 =?utf-8?B?SVU0dGJZM0dTNnVKM1g5NEFlSW5vbnh1WFN1K1NFNE54QVZVMlBza2plVHE3?=
 =?utf-8?B?VC93RzRIbHMwRzVjZE1YcGVHR2FQLy96QTNDMkJOa3VaY1lXb1YwQ1Y4bkpC?=
 =?utf-8?B?cHdtVFZLdytpQWIwVFV1cWdrK1Y1Nk95QTFFK0RQUzRpblVXWkhQaXRydDJ4?=
 =?utf-8?B?cTVFa0picW9LT1RQaE9hTEw0Q0hOaGpmdnVZTjBVcW91NW8vRDdaTlU3UkZt?=
 =?utf-8?B?TklROU5udFpibVNJVytaMUk3OU5YbDFsMVVwYSsyZE16TWs0QmxJbmZzREgx?=
 =?utf-8?B?UldmWlJTSFVrT0VsVll2TGN5cE5uZHY1RE5yZDJEaXBzUGRONDBzZTlmSmZR?=
 =?utf-8?B?cmZoZFM2cElyeVZ3cmFpTkx5NW9CYVREck1ERnJjVzhUSUovbUJiM1EyTWVY?=
 =?utf-8?B?KzFmSlpPaXlpK0pjNDVocmNtTjdWNjNtc2luWDN5eDVUM0MyNkcrY0FxZ2tz?=
 =?utf-8?B?Myt1d0diaUVicTd3N3hUb1Q3MmMxMy9kaUdNT2daL0hWaFFLV2tKVU96blZu?=
 =?utf-8?B?UUtrOXhKMHU3Z3UwNHQzbDJCWGxocDBpajhRdzkyZmV2bE0reWV6R3RJbW4v?=
 =?utf-8?B?Tzdkd3VDOFpySkhwQWNGL2YwMHRaaEwxMzVZRzd1Yi9jTW1NblhKM2gyRnRL?=
 =?utf-8?B?SjIvTytyNTg2SWtpUGZuVm00OU1GbGd3WE5wWURCclZObStwUnVTSGlPVVFN?=
 =?utf-8?B?STNFSmlQbWxZbE92NUxvZ3MveTFQUnRqRlBxbFN5b2ZRZ3M2Tk84dStBWWU4?=
 =?utf-8?B?cFlnVVMxWWljRzJHaytLY3dmYnpGci9tOGIzdEcyei9OUzNuK1RUdUx5MHM3?=
 =?utf-8?B?OXRtM3BYajJUTjJmMlloZEx4dTBFb3N6bGVmM3FNclI3b2k1a3UvZU9Kc25v?=
 =?utf-8?B?R3ZoOFh0R0x0dDF1Tzg5ZnQwR3Vuc1pocEE1NjI2c1IxTjBBQWp5RmNrdWdC?=
 =?utf-8?B?NlA4Y3ZXeUNCbGtreDZmSURpemhNRDN4WjRCOVhEb1Z1MmFZeUlNZThSVGhQ?=
 =?utf-8?B?aGNmbnZrQkIzdXFzcjVxVXQvcWczVFgrcDV5cmJSdytmb3dJNURObTNWanpS?=
 =?utf-8?B?TXBoOWhlenpMWnJ4UjZnVlVLUnR6OGlGN2ZKY0xXRS91Qyt4ZGhkMXRVRkdM?=
 =?utf-8?B?eUpLU2xoZ2xwL09UK3pGaldERU5KR0I4WGJ4UDgycTRnVC9NaHNqeHN2UHpY?=
 =?utf-8?B?a0YvcnUvR05oRDNpT1NaZVo3QXdKZnc3T1BPcWxGaFo0NldpUllXRlNCS0lv?=
 =?utf-8?B?WnhoNzlUN1gxcGF4UlNTUmhZRjhBNzZiTWN4UGNFV1RFQVAvalF5aVRYeGRS?=
 =?utf-8?B?WXlvSVcyd3RqdmsvaXJvK09JSFVUdmxxWWU1MFByZVJXYkp3K2xzcHdRbXg4?=
 =?utf-8?B?MWhVMHpqKzdocXF6RVlSUFRtQWU0NGZpN3J1alJmUUN5ZXVoY3NQNFpqb05n?=
 =?utf-8?B?Q1hvMlNvSk56TTRkR1FEWW1GbjJyekw1WCs1c1VlemxxSDdEYmtYR3JwbXpH?=
 =?utf-8?B?Zlc0SzN3dStITXpjMlVZYkhNNktzMi9kVi9SZlBrZWFUYmkvTzMxL3Awb09B?=
 =?utf-8?B?TzdpOHZVTTZlRW8wUVY5b0x0cmdzU0JNbFhPaUJ3V3JxSUhGWmZ4MXlpbHVz?=
 =?utf-8?B?ZExyNm5uRDVBT0loNTZZa25KZVFlR2ZUaGZmQTQ1WGtYTlFleVQzTXlrYmZU?=
 =?utf-8?B?SGZVMmc3Yzc3aDNkdWVwcGk5eEdMSEtYZ01WNmpIRnNpb1VFQmFzOGoyMEQv?=
 =?utf-8?B?WE1Bb0tlYTNhYXN1Z0E3aWJvSmJHc3V6bVdiUmNRYzN1QXpTK25adWp4TjBM?=
 =?utf-8?Q?eJyTzZXSdj+rKThj+uDNHm12iqjNen84Y43g8?=
X-Exchange-RoutingPolicyChecked:
	Q9lb32nsf3T5G5JcmIPX5CAmj8JXhbQelIcBBR/o4TrkuOUZWw1jFUTwAXW5IcD6YLkhEPcmdr9U0iUSVimMks6XoQ8Fuyi8D4lfFQO1snGE41UQuNhQD1ceaibmEasbi0Yco4A1ybmkykXtfa+8Ak48qwocxYvazZ/OQ0KqLSotC6MZ7pJDEKMAqqil6cEfv42xcDE8jZsDSDetetybfXzSwez+3mgdbbj/NHCraFp+XJDWQ0OV29zznrE/Z30+vj8tqmzUQ8FZHFV1UGrtiG7aVne1zi12FV8/+aaRNH0A6r0JoFMX3EHauqSbLkeGHx//PV4Vwfs+M0+rzBSnIA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bcF12UvRToqaxs86phaESd9uzIwjLSXKecA4fJvI2n2TAybGDWOwsI6Y9X/1SzlbsEc0srIsG9OVWSi9ew41vfoKcVmFiNDB7f0SbFgE234ZEZBchFUruBwc3K4EzJ44GztZls2aBKhFuUafdFy1CDDyVLVqLNXeiH0qQievQOkaRZ/vpYpj+gC5E+BpXtJBRslZT6PpFdGhEOZ/ZRrJKt965+yx9lcgUeJ2LObcgZnIV5+ExWxtwlXnDH3jBwFKiDWXD7wxOmkyrgKVgQ/GXd8eeumYvgljsvPml56HInwgmFsFtTbUoPmSKEHBUWhDju3jPetQM0xQPal5a9LdHprvl9iT69kewyEDSDkf0tDme8S/EPV4GqGEAbwK1ntxd/p75L5xDQWDJaGBZGg/v0xrP/fNaH5PxjhqqkN6DTXb6mCmtz0DFG619OCDwRhxRvBL8AJbK3Btsw3EJFSbJtYDau4a8q1Adk8jGZiCj1QoBx5VLaax0RqqYBc58EXUFl2RIXWB1Mg84t7GsbOFQuYeRmbwIk+5dLCa3v0KT/K2x3cjr7zKkRFwc+KUmSxHYbc2hSYFMW3nhP1xjpPBdsF/QRibcZeG4gpMEqgJOUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c13358b-8284-4f63-97f9-08def7cae322
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 17:06:30.0628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IK0axMLyVFHyW/4B9y5OOc9LaeWZhIUeUYFdNbs69QFHcmfelDmrrRZ0s3JubpO2KwrX0UDOzm5Dm+FZJKaaE70BIWLsG6jwYns83/IbHXe5Uj6Wki6S2wfkvs87oDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=902 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608110143
X-Proofpoint-GUID: jqwHYmsUDh8jo2tXz_fknWyVkIZsqe8q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfXxnVmZGvSFu2b
 +z7rkzdmr1iaZidlJjmIyvZAkORL6XFGwsu5MRnJ78mANCNUiktgcu4idsNJUJppWWbtU/2h8QU
 hBp9VBLTtN/YIZc2wo2kL0A9JBGg21zAiVnJlKjmLYKte26mOgNE
X-Authority-Analysis: v=2.4 cv=aepRWxot c=1 sm=1 tr=0 ts=6a7b569b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=PTzr-snw8A0WOhbonX0A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: jqwHYmsUDh8jo2tXz_fknWyVkIZsqe8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX+IjhsyTybvLM
 lOwqpWidP3eqbv1TxhOkwg0YMYaAU2/X7LCO7B/2DM6JU+7qUzF8PJgPeNvjLC6oxmuok7SZnZU
 P2lovg2PuPkXbsJu4+sXzzrM5tZA/Lt/sPl6D+5Gl6+vswe5DkVmNMm/0WKzHawelPYOkiPMCvf
 lqKDa6wDi1YS1+ksbPvnaQwXximhwhs4LVoogOZf7JwfqBN7iANV7i83I2i5deUKE9o/dKc7nn7
 o1f14yf/0ACMdol+4gohTeZI359p87GGWLveb6w332gv5cVidPPJV6SlKpBwLNYu+yNEiSByr5x
 HvX87335WQAM3UODf5ubbb6f3fFb9mli8cOz2V0PVLcVv5MtAfyG00hwfy71Yp/VYLVEHJ86B6F
 g75FLutrmY18kASHX92epifAZ8ghjomPgAOgpauS2/IRI7Zu4vQMaK9RVx+cOJuj2yJzPxS99jx
 K6Eoaip5eC6sjZ2XMUMnJLUHFH8BR+XmzZw34a9U=

Hi stable maintainers,

I am curious to know why I can't see FAILED patch emails for:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=622ebfac01ba4f9c0060cebd41257fe46fc4a0b3

the broken commit is in all stable trees:

Commit Data:
   rev              : 355f4fb1405ec29d0fac49b4d41fcd78cbd455d5
   subject          : kvm: nVMX: VMCLEAR an active shadow VMCS after 
last use
   stable patch-id  : 67a5f1f0e5c07f4d579e84e2028f04fa5d0a393c

In Branches:
   mainline             : v4.9-rc4 - 355f4fb1405e kvm: nVMX: VMCLEAR an 
active shadow VMCS after last use

and the fix has a CC: stable in it.

So I am wondering why FAILED patch notifications are not seen on 
stable@vger.kernel.org.

https://lore.kernel.org/all/?q=KVM%3A+nVMX%3A+Hide+shadow+VMCS+right+after+VMCLEAR

thanks,
Harshit
