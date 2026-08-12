Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EFB4248DA
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535221; cv=fail; b=RDe7W0G1RBBuhx+AP1qBbMv/sHPgrK5sGwLYfVPJp/oJUzHRsMKP+TM7wTJollSXxfPIbVLgtN9DNL2PXlpkKnLEYQnuANE50HOGnKx79Us5tEF+WDksKItFDhWBP8bHAWVnA2EJAP3AC9UCCy0hI2jVj3PHRkBwcTrAmHPxwpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535221; c=relaxed/simple;
	bh=+RkS1/edslRKdc0h6F4lCyKhtwJG238Mzy5Faw7C3Vw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mjA++tyhLFZEtDSut9cvCvOJ6j14G0/nsu99gYxdZw+G4g0WtvsKAE9oFuL/Arw5/fhe2VWsf/n356ajvJpJD+DO1LWBgoXP41E73aoG2oBSfvzzs34Zh7TopxcOeETc8fNSZGtL0OVITxK0pwv0EDneQXoDHiDejZ6vcm4PPdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QKZStoTz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nOR4lEYn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QKZStoTz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nOR4lEYn"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C3Bnje3884468;
	Wed, 12 Aug 2026 11:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mI3w9zUZgo6xW2gpWkzNVRQH+2HqPqqTRBrEzJygdQE=; b=
	QKZStoTz97BeUj84RgGCT0vt4wyAbqCLdUZ/Eg3Pa9F7IQe/vb5YuFVDCWaBNTfT
	l4Ny31gUEyUa5wjjgDlqwzrHCPK2qGUVk/vcMH+I47J/kDfiQcROdhcMWW4Gv9A1
	R/By6kbd0hGU076ZDxSMBCxmdxgI9xujsmRgppiN5WtYs/0Bw7s7o3jaZ+34Mvef
	KZ7iGrT+CTSyhVRvmEE3VGzyi9GWJAITDiZ3JfK/7SWj+DvQaygy7R/sWkmCMQ6y
	6+IqH0S2GLhr03O9yAtSGVh7BMZzZeqUUE+Doi+LyU8j8YuperBgqgfDnNxceyT2
	XpNIbBfW7USQoK0+6XG1lg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvfxxjts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 11:46:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67CBZflx000825;
	Wed, 12 Aug 2026 11:46:55 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwsp9ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Aug 2026 11:46:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py4OsR27VjEUPZf1Qey4qVAaQCflU3z9ckTZbsFw5Xuegry/BwMehL5voCaL/cd2nnih/R9L0NZjkRncrZI+W59N2K5wA3iL/JXbhesQx+AQpE6KOMMV/nMxSgkPwBtprc0WW7mvrPVowvbAeHxyBgq8IT8USFY7PofdPoN1jMtJmME/Av8LUGZ8V2KMMx1WXGKLYEaH3EXkKjF8hMxhZLmlS6fj/YLgaB2c95kRHj1IAQ7kOqjqJezWjpfDvWlIDuIqeYLtje8jhX1rRpk6AIjW9S8ZQlExG8LxuBswqriQW25aSQLdlSKtE/8BD1TRxQuS1VACfHmvrqtDdPGd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI3w9zUZgo6xW2gpWkzNVRQH+2HqPqqTRBrEzJygdQE=;
 b=STxznpxry+d7o6+4A+GSlRbXcTZ8MANzzSUI7y759h53Rr/UiSHCDlp5POL3gI9UnGcj8xHmHC7ZG8OIEUJG9A2xaesULvdASA//0d9tHiRKZveSMbhF5++dXhLPQtJX5ctWzfHsgD1C6mdRc5MeBQ22wwJcR0YHGyHMR0w7JcrxXoYW7G0ZTVMFlgYU7Lhfd209r09/LqQ2uS3+UAJI9IwvMv96Qabb3vfrOaOonFK50Xq7z7uFKXjxDhfgNwMlafUXXW9anpBgwm/oN0RIop1dUt6FlDhue9bbR8//aahlZDYH0qd5Lhp5m69O0F7PcyB8gc54Hvi/zOooP/figw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI3w9zUZgo6xW2gpWkzNVRQH+2HqPqqTRBrEzJygdQE=;
 b=nOR4lEYnhxdnmRCCFjoLYeidkEf8NNR/pKSMt1cg5DdMRZ2DDncFEM8uBuy7SyZhmudjvwv0HJxz2bzZBP+N2wj6LajgIHCqqQlHHWg7M9jL1zFQTY+SjD+I1hllKuAHHlQRphJ94aSzXjdRU+nF+t+5WfBLaxxuN/4gbCE8YJI=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by DS0PR10MB6152.namprd10.prod.outlook.com (2603:10b6:8:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 11:46:52 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 11:46:52 +0000
Message-ID: <075a8087-1cf7-4b45-98c5-6a4c717549b8@oracle.com>
Date: Wed, 12 Aug 2026 17:16:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Question: Why don't I see FAILED patch notifications for commit:
 622ebfac01ba4f9c0
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        vegard.nossum@oracle.com
References: <5b4ec416-804a-4bd6-aa12-5c317741977c@oracle.com>
 <2026081210-lugged-bleep-94ba@gregkh>
 <7b89b098-61cc-4788-b7b6-69bd232f770d@oracle.com>
Content-Language: en-US
In-Reply-To: <7b89b098-61cc-4788-b7b6-69bd232f770d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::15) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|DS0PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d44772-7e07-4080-eb4a-08def86766a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|10067099003|56012099006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Nvvb0gK0sTV88jdg0tHR1FvfCM8wxLmS+tQLutcAJviW0wvnXQw7Nop/W6vJXRQPRE7a+c/MNcIBga0Bssvkh85L+J37wcVBFcfQi4n8lGrbE+bI0DNt087nKVMxqWpYA5aFnNd0ipSYXvWI3Azyze497if14tBBE7M2Kl6xt2N8PxP/Uz/Y6YNDJ6nCxmwwVT+5WXc+lBOHK6U1dYG5fwStTVHdaJkBUkC8GH/xQqSJVHLJoSSR5RNJmm8ZGXm8E32C/2T2xUlszHn1xA4q1OoKwP9NTh76YEvw69kWSVytnvKjfrEAb8tqrNeaph/4dgElaCXWRYzbh46rwC9GD4aVNsULDL5nhX8Plqo6XJxMCjqe1aSTXgz/JaIu7EeAf2yQlTPruQSdZ0yisAQLApEk1MKTO6dT2M6QOEOfVHJ/dzetYScjEJHTbKT1Wg2fZ7Zs1hGq6JxeG1UxgmqZogBo3b+dBe4edQx94eTzPE7X4WyfmZEAcEMR8mby6AOKmIoHIwbyL6PFWdwECeG6vUk75DKbQVb93q512X6WzveAtHJLGY/lwRnQmrxaKkdHA2FBA69magFKph3kWyGgKLTn9PrK50GKTg74PQu5I5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(10067099003)(56012099006)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFY2bjV3ejRDNTlSY1RuV2xOTGlGaDlZVDV3WWlYWnFRZkVjUmdqUi9aOVFD?=
 =?utf-8?B?bWVuVC9HdUpIN1p3WEQyQjJJbXZwZXVkSHZQaS8xdVRRbUZ3UnRYVWRmTE1N?=
 =?utf-8?B?d3FQWkdRVFh6eDZJR21zU1RLUWN1K0FCNDFWbDQ2SWFtcGtCU3ZST2NQdUc5?=
 =?utf-8?B?MmdiYnNjcHI5R09SZ1V6eXdxamxhb1RBVG9HcE5kdFBKcnFLMmdreXBzNGxi?=
 =?utf-8?B?TDREbjV6MHJ2Z3lyVTNnMzRUdzcvUXhmUXZEQmVuWHI1UXpNU294NFF2QTZE?=
 =?utf-8?B?Q3ROUEdEbEpSUUJjOFpOZEwwZGRuQ0pHRW0xTmJPODZPYyswaE5vb2xNQ1FF?=
 =?utf-8?B?RGhuVi9OZTNlWEluZEwveVdYckdTazBSSnBRSFBCQkFqT2daWTJ0RTk2Vks5?=
 =?utf-8?B?dDhJQ3ZodTY5K2U1UTljOTlsMnZRY2R0ZzVCWGVaYjlvekp5V1Z6YzdORG0v?=
 =?utf-8?B?YkFkK2ZjK3hVZEhPNnlNQXhsR0EvTDduZi9hMEhTeDUySFlaZnplU2JFZVd6?=
 =?utf-8?B?OHd6ZVRJd3V4ZWZvY0hFamZFYjRpVlZRdjNjK0hlREdBaXdCTFFFZEdYZlc1?=
 =?utf-8?B?Q3hLUmc4ZGI5WWRZbzhmMjFWSFdDbXp6MEVqbjd3ZEI5c3JtTzdlditSZW5S?=
 =?utf-8?B?Z1RJK0c4VDlTallzK080STlmR2ZJaGZJS2VoK2p5d0x2SFpvbFhPdWlMOU1l?=
 =?utf-8?B?cU5RNk8yMUIzWFh5WGN1S2o3T0JFNWE0b002dmZaVER1bXdGN0ZPS2dkNU1L?=
 =?utf-8?B?dnFsdFdEOVhYWTNGREtrRmx1TzBMRjNjcG5GR2lTaGlOdXNGQWdNcm42SzlT?=
 =?utf-8?B?dTlCS1BaUU5XeU5iZEJnZ0VOcmxUei9lOHl5Tk5tUUx2a2VqaktJVHduUld0?=
 =?utf-8?B?QlJ1cHptZU02UG1oeDlXd3FwN2VIaVFPSXhXY0RWRWdtT2srTjRyZ2liVzB2?=
 =?utf-8?B?ZXE2R2JmY2wxMGRDazJBTlk2K0pMckNzMW1uVzR6WGFLTWx0OUJtdHkyTGxJ?=
 =?utf-8?B?N2t6ZjF1RkkremdpWnlVY3A2d2lLSXd5QTZ1UTAzbU1hWUVNY0ZPQmhiRDhV?=
 =?utf-8?B?ME1lVEp0M0QvYy8xY3JkRkNDdEI0eXZTTXM5dUc5UzUzSlR3NEg1dUx1azdM?=
 =?utf-8?B?RDUyTkJqcllZRTJ6bGFyS3F4L28zRFpycU5vbitIc2tKM0hVa0VuOHV3bDla?=
 =?utf-8?B?blFxT1dyNXRsSG5kTk54REhrYUkwVFR6elhCVWVHSU1WRmxkT0dxMG9aazBs?=
 =?utf-8?B?UVNxYXBrNXlqZEd5bHY1UWdZQWovSTVIV3FoMjIvMnZMMHVwOVNNQ2R4cXIz?=
 =?utf-8?B?M0NXS0Y4dUV6TzUwYzd0dCt6Z215YkgxWXVSR01jdFk5Q3ZOWVN1ZWVPT3Rq?=
 =?utf-8?B?cUYxdjEvUmQwRjhTWWdkMkRwanJuRmxPZlh6OXJDa3RidGdhMXhrK1JRN2RW?=
 =?utf-8?B?bjRUMmJ3dTFTNElTTGt0RE05YVBSZkNRM3ZXMklpTmwwMmNpUUtGL1hyV0ps?=
 =?utf-8?B?a0JwT2pLOTgwVDlRMFVKY0p0YjIyZHkya1Q1THloV2VYSkpVM0FseEZPYllH?=
 =?utf-8?B?UFAvVXRFY3FIcFdFSy9ubkR1QWdSV3UrR2lZZ0dLYzRyanFSRVBXT09RcFla?=
 =?utf-8?B?OEZDMDF1UXVHZ1M1Rk9uVWZObkdsSDhUY21qNW14N241aEIrNUlORTBuK3hn?=
 =?utf-8?B?V0RYVFZhR0FUU1N4YVZwRmpNSzM3RzRiQ0dtOHE3MmVJK29USG1nV1d6S0dp?=
 =?utf-8?B?eXoyK2VLSnNtNUlpV2k4VWVRME1wU2xFckM4WVE3NTIwNk1Pa3dTM3Fscmk5?=
 =?utf-8?B?aEZOZWhMVHREYmZ1bVF0VE5paFc1MXpUTmM3NGhBc0kvWXNqVExYSHBjYzM5?=
 =?utf-8?B?anNlb0gyK1IvSzNtVG1wVUtQZVlBWVBUOFgrU2k3Wmlta1Y5STVnck5VckN4?=
 =?utf-8?B?SG9NL1FZRkttUHgzTEh5K3dVVDh3ZTlRWG5FTWdxZUJsSG1ybG9vOTRlbmFi?=
 =?utf-8?B?SVZIRy9Wa1BmbVJ0ckpobXllbWQ4Q1FWYituOExsakpLeC9SanVKSjUwS3M0?=
 =?utf-8?B?V01ZVlNzcUdqaEM2QkxSVHZ5WFF4RjdDZnZvNm9vR1FiNEUwUkxMa1VabCtK?=
 =?utf-8?B?NVBEL21KZElSS1ZUSitIK0ZVVlQ3Z0VWQzdJYWxVSENBYm54Qlc0MmEvYzhI?=
 =?utf-8?B?ckoxNzQ5a0tqVzZaLzU0bkZXK2cyYjl4dXpJbEsrMUFVZ0V5TXdnSjJlQUQ1?=
 =?utf-8?B?YTJNeWN2UnR1T296Y2FHRVBQRlNOVUZwQzFLVzdrZGtudnAzSVpZQVJIcEtk?=
 =?utf-8?B?UlpnbURBOFlzTFRjMHN4STZveFNaeDltWUJqeERMaHF0bHhUWmFYb1ZrT2Vt?=
 =?utf-8?Q?3ZSmpVsYfq1zO3LiNGjaS4beypW37a7uZkW1i?=
X-Exchange-RoutingPolicyChecked:
	gqUyKSR1I3vhXwJf7cWTFe9Mm6k4pf06u1MXZ/JntxSkF/PesTYS2xhmz3Pu+p6+apGPE1Mq2DcNnvErx1Omns/IegiJlpQMuKCPnm8Z0yivm+2cfHhg9wxEcNHUpGZLjraEAgmrMo3HFB8SuFeYzwAgQPFCFsA2tvq71HyhLMrRC9wfyKWYRZ24PgBbEZY/lXAdkj3xufSdOChrbEYTaSjl3xWfuTKL7Us2W75N6qs+3GlRhgQXKK1e2GHBgPBjtRJG8Kw5BkvAdY9BGQIU4vQr5fCa6zyJ0h9EkYT4nELppaujOa4p7yqB6fBPRveHfZduWZX37ZWTBjkuBjMejQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jw0OlPEa0b3W2hfyoE+jFura8n61WO19NZiS+7k3L4pBVUP4PCJA/pirOWIKgzLL375NQ7bMODbBJHVDACQ/xhVJyLiPhDXTK88j2e7GBT08E21Y6xtwbFwS6ZRDBXnHM7/ZPXFXTi+ItFFbxmAxA7K2GSyP8r3yqPCqhJEJUO+fcmhXUDpD9T2o714iz0Ui9BM9l1nImj27D/9wrWrLqcv3OCiF8muJGlb/JNy6f8T/kt2G/tfXCTpErMGqy1BHxQeDfB0KJCfVznGH2vqEc1BzeTr7CQ3pEcs8HS/JtuhJu9fLePBAQVarOBkqq9Y7oomGWBS1I3yc6qZBUajl/1NUTYo7+nSVLEeotgOTZP+cjk7009XVmY8fAqdLUyvafAGmSruytAK3s3LkDpwDFdPv4gKHyCkKbscGTnJ3jeW4e6uJLBtC1dtRO57B7ITxPG6v7q1HLThvN/AsYe1Vvn7PnBg5AlaYxYlG4gJiCtxgbeFGRzlzlZkg4qLWo861rqT7E64Eqtwj+gwLS73iHjKBlT5DNTEBVUpgT4RGSl9mfZ8mA5qdXmLN7d1N1rsfJ+r1HafBHa5JE8DlRTBio2Osy6Boj7ZeLKMZKyawAyg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d44772-7e07-4080-eb4a-08def86766a4
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:46:52.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPfXqowDluk5WaO7c2RCThDiGdoZ+LL0mYfx1Mhtr11mB4ywGyBK5U17tDeKS9v03fpqvHwxsWfILys1X/NdXPHTkc2WKq4XUdAJ2fX7uD0xoIYCsCwIoiYC/jUB+rs8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608120094
X-Proofpoint-GUID: LJg-0feRY1dv09O7bhMqcMgrNrvucMB9
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a7c5d30 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=6kOAOWsrWpn3sw8y:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=VwQbUJbxAAAA:8 a=Li_hwI5cp7aN0h4iEBQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13509
X-Proofpoint-ORIG-GUID: LJg-0feRY1dv09O7bhMqcMgrNrvucMB9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5NSBTYWx0ZWRfX0voo7GuwuaW5
 uHRXq7xkzNtBMG/4cdsCaueKAE8awUYlHSHtxI4N2gvsLV87LMwJJtlmeHZ4ZWjnxJmM9QjiX1s
 ka1KATb8O8OdA8lygLSaIBrVSDp8Q58DJ+YBV0d/1HnCLouAka2quYNjG0XFcNJMgTAXejOQsTg
 ehgkz8Rt3muwPmDk2c3fvrGr1eky5kD8qRr4iwMBWYlupgea6j9XqY06wBGySVi2OjrV/A5zL5h
 7A0dhHUonA4Mhek/9eIhjG6ZuLzjepOAX3PfvpHrHcf0jd7OJQ5uJyNYF7jD6FExnjaJr/tdnfi
 jlNp/Yto/y5th0e2g06vzWqW0MhjVpzQYa+Vrw3agfPmWD89mI6/dhFqJ3+siRV/gITEyh4dF/y
 BSU+HHnDrQrmg053gvHYXuMIa90fDrGqdyOx4IMCQJafQmGHFy3m/xBRgYrpD+TW4fsPXfE+2YO
 4pbzB7HsG+cijcr6r8VqeB8O4iG0hKuqYg0Q0wOg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5NSBTYWx0ZWRfX+/Pc0qMvrgMU
 hbhD3vPZ7/luxBUPj4n7q3zYHfhTrOgZX0LHPrX5K2L7T8+s1viiv9lFiuNJe9U2GAa/GHeXWzz
 i2f3BXuRcgbwQ8bClq3KwD6Lry9C0jQiqB58+Vucwjemd1pFnTng

Hi Greg/Sasha,

...
>>> So I am wondering why FAILED patch notifications are not seen on
>>> stable@vger.kernel.org.
>>>
>>> https://lore.kernel.org/all/? 
>>> q=KVM%3A+nVMX%3A+Hide+shadow+VMCS+right+after+VMCLEAR
>>
>> Because it is in a bunch of released kernels already:
>>     6.6.148 6.12.101 6.18.42 7.1.6
>> And queued up for the next 6.1, 5.15, and 5.10 releases, it's in the
>> queue.
>>
> 
> Very sorry about this.
> 
> I made two mistakes here:
> 1. I should have specified I was looking for 5.10.y and 5.15.y, 6.1.y
> 2. I should have checked stable-queues.
> 
> Source of my confusion was it got applied to 6.6.y+ kernels on August 
> 03, 2026. And we had a stable kernel release for 5.15.y -> 5.15.214 on 
> August 06, 2026. But I just realized that we can have few urgent fixes 
> queued up and released faster.
> 
> thanks a lot for explaining. Will be cautious next time.
> 

I checked a few more cases for eg:5.15.y:

eg:
1. commit: 7258770e5814 ("KVM: arm64: vgic: Handle race between 
interrupt affinity change and LPI disabling")

the broken commit is:
   rev              : 5dd4b924e390af426e424d5e52c1b4d1566af817
   subject          : KVM: arm/arm64: vgic: Add refcounting for IRQs

In Branches:
   mainline             : v4.8-rc1 - 5dd4b924e390 KVM: arm/arm64: vgic: 
Add refcounting for IRQs

so fixes tag(broken commit) in upstream commmit(fix) is in stable-5.15.y.

Don't see FAILED patch for this commit: 7258770e5814 ("KVM: arm64: vgic: 
Handle race between interrupt affinity change and LPI disabling") or 
stable-queue patch.

Was searching for FAILED patch like this: 
https://lore.kernel.org/stable/?q=7258770e5814f15e8308ebda82ac9acf6964ba8e


2. commit: b240f792ae02 ("drm/amdkfd: free MQD managers on DQM init 
failures") fixes Fixes: b7cccc8286bb ("drm/amdkfd: fix a memory leak in 
device_queue_manager_init()")


Commit Data:
   rev              : b7cccc8286bb9919a0952c812872da1dcfe9d390
   subject          : drm/amdkfd: fix a memory leak in 
device_queue_manager_init()
   stable patch-id  : b77e273174d23e67b63515c660e3bff7d5d133ea

In Branches:
   mainline        : v7.0-rc1          - b7cccc8286bb drm/amdkfd: fix a 
memory leak in device_queue_manager_init()
   stable-5.15     : v5.15.199         - e11e8a29b304 drm/amdkfd: fix a 
memory leak in device_queue_manager_init()

so fixes tag(broken commit) in upstream commmit(fix) is in stable-5.15.y.

I also did not find a FAILED patch or a stable-queue-5.15. entry for 
this commit: b240f792ae02 ("drm/amdkfd: free MQD managers on DQM init 
failures")

Was searching for failed patch like this with upstream commit:
https://lore.kernel.org/stable/?q=b240f792ae02e9b687eafff934a39e57d1e45365

Also was checking in stable-queue: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.15

Sorry if I these checks are useless. I am asking mostly out of curiosity 
to understand this process.

thanks,
Harshit


> regards,
> Harshit
> 
> 
>> thanks,
>>
>> greg k-h
>>
> 

