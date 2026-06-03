Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F3A328B61
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476727; cv=fail; b=FcgIXzi4YAV/b2Nf2EJuXBUbOGGFNxJr2t1FDq7T12n7MglOQo+6KyV89P2SXoltuxFcXfUmpJU1oq3PCyCp+0Gcat42wvg0q0HNQxDrBrbLLr6O3tXn1YiI2Uc0ANMawMyWkVpNjaL7Eptho6jghaEo2vb1B1EPSRIbLFSKMOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476727; c=relaxed/simple;
	bh=ZgMYPXIN/OiJgehnvK51iwtLzizVLy7ULmEIS+e2Q6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XAEae0ACrm+E/yXD4wdwXxFp6+sRpamJKc+y5Q/yFsfv9lmOzXlBzij/q8FLgI7AQ91HtZGpWjUgJKJfBGd23D2L9nrNHU8rlMDZ5PD6xZFJVMjrSMJzwGv7+wKuqMMDt6z6J18+H9x0JjLxC5oXCUlpU5IG48Aj9GAaJUnMawk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Tz/upeS4; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Tz/upeS4"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537K0SV3579755;
	Wed, 3 Jun 2026 01:51:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=eP1lxEMxu/MehY/uqtBXHun7zp9S+od+i5d6WDoHop0=; b=
	Tz/upeS4qRDGq4vmlPlAVsgomPpcSc4793w0NFGmt4PqWtj8e6gFNBdTxASBFDPg
	tViYkQho3bZQp3OB2O7POn0RYsFhwy+pctYtRGtX+3hKerCDTjf35s6jzQEe+gVc
	9EVLUsbjt50Az44L3n3i+vmkPGcSZ3vA2fbbAH8xbGIv2Ore2ZDfx906j6bcrORU
	i5OYjCLNeZ4D7tUY/dQSrM+2Rm4dWG2mPNb+EK90WEykvy2MDPPysW4LOE/C9KOF
	95V+xoeKQve3/y4L157YnwZB36r0/wV+pxTGszeKYUaHKuk9lsCNm2ee/V5e6Wgi
	hDaMj1JJd5+x2kjXCGUmCA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efu61x84e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 01:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCZE902RM0xyQOZ8eKGTMZNyUNBIY3g82YC4SKjIOu2/JuOsvKfN6nw/iW0fPD8FGbK7qc5EymXCsHn8kC+5AVF8bvkkQhEvCbU0Qb/UPKp876yOPSZn0336DrQ2kXrXCD+WQYfjHyAXG1p6XDCNlHpQZRoSlWy/Gl36KZYaqulzWnmthkUvIx4ILKEgd6n0CNVU/ntnZ0fN20LGuohTKeq4KShCUeKzOhj+txQsHmI4E9bfnuYPhvIha1IYxkS2rucgZZNSniELrzMvC2bhDFurEctPknrbQZvIev4GxZBH0kumGMEYLCaFiieJvfexJQ6THgYYnEFYrrdX8IgJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP1lxEMxu/MehY/uqtBXHun7zp9S+od+i5d6WDoHop0=;
 b=fyFSbsxFalBcdx6JLTUymyebe2H2iJUHqpUd2BtwirTlVdXhEp1pvoZvkqbxEmwnbEuFzu24XtogRGkvjkPaI3TEUoRO5N/p2A3A3SsoKXPWOnozd+c7JgXOHq6LnwgHKoZd5fBcAa9pLCQurIGqpLwkLxTrqIKz7xfPeHTr7/ewmf6DKiHu9ne2T42te3DSfoW6MdVZRMuBJ3zTpFtRiAn4K0nRNxF8Huec5sprL7vaWq0J7ys3ZbRyxfPtoZYBfAPpDmVcTZW2ZuwEmVel9YZDM0jgl+x7IEFBiCgQk+xrPWi2FyLmRBDr7L0Glzhy1wpQ1sd4yitKuvn3zjIZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26) by PH0PR11MB7470.namprd11.prod.outlook.com
 (2603:10b6:510:288::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Wed, 3 Jun 2026
 08:51:54 +0000
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6]) by DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 08:51:53 +0000
Message-ID: <57933300-7e7f-4f83-a55a-1b938cdb7856@windriver.com>
Date: Wed, 3 Jun 2026 16:51:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6.12.y 0/2] proposal to fix CVE-2026-23346 on 6.12 or
 older kernel
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, will@kernel.org
References: <20260603012314.4100773-1-xiangyu.chen@windriver.com>
 <ah_muKGPxsrhG_98@arm.com>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@windriver.com>
In-Reply-To: <ah_muKGPxsrhG_98@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF641CF4859:EE_|PH0PR11MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: bf823535-f70b-452c-7553-08dec14d5c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|4143699003|11063799006|56012099006|3613699012;
X-Microsoft-Antispam-Message-Info:
	Ny4hPvLEmR04VtFGLBejkwFD8XnY85nDAbzf8MNSZAn8L4FGx5V949iBezPcN01yp6AEKTd0XJHpQEObWnZAkhpoMcfEiNXRKnsFlG2JuS1ba9ofR9YPH2Aq59HVsqPMneNh+8rfJT7bcephiwevVLfYpvKw1cHFdFHQNWRRMF1EcsZsJUTKmPqOf0cDtNjH2Fr2wynr4GjtDwf42cPAaETUxraZxs2KP28REpH9BWt2ImLaAtWaiXhexpCnjHjuGJY7TuMUMNb/Y9X5gfmwALLLeX84Lj5IMBm+g1woKlg2xwtKoXzptSQHUEeaZGfQjQactsrQRWeNEOpqrDWTjnCqyRZMwa180gvwzvLe756rMYRnqUnmW9HBMXa+6GcEzFX5/Nq7nGRn1yHs65R/nXHWlhy+DSU+poVXsD7DE+gUeLkzLr0XtNkaVwFwahqCWOjnR/zpff+CBmhpzAxNfrHE4nxDWo8JLAzwieRn3K1gax5v5z+VorRSyopjsEjfEa7aotOxWAeAQ5uLmNFjizRdiSOrunsjD/odLEVH7rpe+9J19wO8kK4a/TGp6JhlzHHhVNUoB61xQ2ZD517G4cfsZHw1cPEOD1sK9pSb5LG32jswm0p+nZWYDv9AYg+O794jKN1zlauPySW7byIofcbkOd/i6YcSP7E1TQWOJfwMXfge25c3tg58M9qoGp5agRRxQSP7ZzIx0J7EeWliSnoXckYoIQzXiJGufDbx5hqWcKit/6oSzp1dUWRR5VlX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF641CF4859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0VqcldqZUx4VksyS3FpeVlZblN6M2V3Q2V6UjNhckFsSHhLUjVxM0dsclpj?=
 =?utf-8?B?NmErUHJWNTZFVXgwUmpaMjRPUGtLZGZReWUzbTcvd2pxakhlVHBsOHlIa2V6?=
 =?utf-8?B?U3BHQ1AwUHdBQlBKbXU3djRJa1R4cUZwUDNPOXJBWGZESmlQaW5Ubm5EdUtM?=
 =?utf-8?B?UVkzeUh6TituU2VJc3l1YjlFd1BWNFZGbzBaK2g1S0pjY1BERytqaEFHcmZC?=
 =?utf-8?B?ZEFqSW5yVGcrOFl2WE5yOTNLNzcvL1hWZ2sycjd0alp3Z1pEL285S3NlRGJX?=
 =?utf-8?B?N1Y1YjFEVjQ0QXJUL0NYNzNaL3dPWit4a0JSZW40c01oOFBBVTNjWGdWN2Vh?=
 =?utf-8?B?SWxFcENkVi81STUxQzdCb1l3QVU2TkJXTk9HQWw1d2wyTFptMnVWY0FUS1hB?=
 =?utf-8?B?UStvWEZockNFTC85YVMzVEk3UXVsQ0tPcllVL2k0Umtab3lxR0Rza2RIYWU1?=
 =?utf-8?B?ejRKd3J4UGRvYTRqYVdFQUdmRExTYlF2ZExrWTdJa1ptMWVsNG12Mm0vNGVm?=
 =?utf-8?B?VHg5OWdwZEpTb1MzTUtQV0xTems3Rjdwc2ZGTjNaN2g5SzN3UEVTbXBwTUFJ?=
 =?utf-8?B?RVk5L1UrSVQ5bXdocEVkdTJuTmxrUnpBcmgzM0dHYkp4VWNkdzBCVWp6OXZx?=
 =?utf-8?B?T1p0TmoraDkrZnBLRjVTcDllbUpsZ01NYzV2clRzTWF1ek1vOFNubGVWSUVo?=
 =?utf-8?B?dFJ5U0VoallXTGlqa0VpQXZqZ0ZuS0xoMXVONHd1MytUUmFwWWRLVjBRNlc4?=
 =?utf-8?B?ZDBDeTZ6NUFGYTBJNlB3eG5kWExnVnlRV0k2YlZGVy9NQUpjaktBb21rZC9Z?=
 =?utf-8?B?elVQN0U4TE1GdDJERTZ0NzZERlNQanYvTGdHclhxd1lqcXloVHV2aG0xS1M4?=
 =?utf-8?B?dkxwdzZ6eU10OXFzS2hIc3U5WHpyL0txWFdIc2pXcUlJVEoxU2dTNnZwUzVh?=
 =?utf-8?B?Z2w1dzROOTdqT0hZZk12aStMYU9XcklKR0VqdWU4aGwrZUxacHRGc2M5VCt5?=
 =?utf-8?B?YURsQThnNXlMUGw2c1dqMlJ6MXlLeFZTdHJBWG9DR1VIK3FOQW5qVVV0N2lL?=
 =?utf-8?B?UFRRWjVIYUdEaXBKeFUvVlVjN1NueTErNUpBZ3oyVnM3ZHNFYVRUWWthcU1K?=
 =?utf-8?B?UVh5K2wwSEdEU1k5R3BmaUxoaFg0ZmpNUEJhOS9HVWpKemV4Q2lGTzRyeDdM?=
 =?utf-8?B?V21rU0JMR2plVUwrSVVRejFsTi90OFNobEtJb0NFQ2pXS2gwOWdWbS9RR2Rh?=
 =?utf-8?B?THdzV0pLdXljUWZrRVdTYmtwOUExMXVsdW5TVE9Cbzhva2R2U3VtNVVGSkQ4?=
 =?utf-8?B?WlJITzd2V3NKZEszSU1OVHJuc2lCVEtCSTdBaTFYU2xaZUNQa0Y3WGt6MER1?=
 =?utf-8?B?MlllNzh1cGV0Rk80RHpYYWlQa0t2dFJFOTZEYWVBUVVTeWNiK2VDMUdaRDAw?=
 =?utf-8?B?YjNVZXRaeWZpbXZsRXEyNGdUbzVyS2NxeTUxZzNYbXp3dnV0Mlg2TDlFU1Mx?=
 =?utf-8?B?THBzWDlaQjRuNHdpQXFtcmVUQ2VJZzZnT1crQmZETkozU3k1Zzd0SkVSL2JT?=
 =?utf-8?B?dFJIOVZiUy9mcm5aZ2VsdllqWTAweWF6eUFUTkJHbzFHaGJ2YUltTFNpRFky?=
 =?utf-8?B?ZGo4Kzl4VmJLUmtPbzhsMXhULzdyR2lRZWp2OFExc3o1c0k0YUFCcjFUSTNs?=
 =?utf-8?B?dVN1bVNoUEM5Z3l5S1gxbjc2dHFLbGVDbEduUHNIREhZM0V3TFQ3MmpOeEcw?=
 =?utf-8?B?NWdqc0pCdHZTdTl4WkRFMnRlNVdWSCtuR0FKd1JJdzE2bWM1OThOR0xFbjlM?=
 =?utf-8?B?cHFtcjY1TnpOL1A1UWUzYlhrYmJVYkxNUkNocUg5b0RjckNnQTJmOFI0Yitn?=
 =?utf-8?B?SVZWN3AvUnZpeU1wRC9YWGIvSE9RMXN2cEwzc2VBZWV1aXB6MnlYbmc2SjMz?=
 =?utf-8?B?bWlwNXFjRjNVWks0RkhTK2IxazB2NkoyOWFwVGlvTWhWdWgyTTNNM3hYRk1X?=
 =?utf-8?B?Z1dRV0cyM1JJZ3IzUmN4bWJRWkFMRjBZMHp1ZzBCWXRuLzlSaVFPdWJsMld5?=
 =?utf-8?B?ZHdKc0o1c0hhVGVYVUVhUTFYeWl0T2RFVVRBMmtpVDJoVHpnRTE0Z1A2SHRl?=
 =?utf-8?B?bjFsWWt6aUlNMUN2NHNpaDMvT2JJTlE4UjBEWEsrTEI2djAwekNCSStwR0Jt?=
 =?utf-8?B?dlh3N0NJTzdpM281d3JGK0RPQTdyb2duT0p3RDd0YmJQVzhVeStNL0hrekVO?=
 =?utf-8?B?SUhUQzFhRXprZ00wb25NMmFBZWh1MEdpaGZzQW42TGcrVm5uT0tsdjF3ZTBs?=
 =?utf-8?B?eHl4ZDMzYmw0TkFEdDRwaTZkQUxNcjE5QmdZWmtHRGFCUW9rVFNqd0pCQzFN?=
 =?utf-8?Q?ZbPElfOfgfovvrQY=3D?=
X-Exchange-RoutingPolicyChecked:
	IsZ2FePoj+rox1xp/5jm/sK0eXBAUhVGUjcGI+DQ2eMqId9QoVZ+PdyecKSxrgIpxGR6fvJE6yTJ4/Ijz3eKukmi6VphFAcRt0nVcQYpQanrXb+SqE50zA7V3Bh01JyABioZki1n3Y+weN/LgGl/sP+coSutA/otCsKcutIJzgvoyjWDkBSup369pTbtXTZEYwas70MWl7lMu2oKk49CBEYZ4ZF8CuHDWl0zgBpQisFhp8t5U9fWewbYAkEoi/DbtzesRlFhaY9FJ56pCdNqCsP4EGYprPzISIz0YvLjdothmaFbXyw0/ZIMYhoOYtt98fI5nymfceFbwPBEY0p/6w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf823535-f70b-452c-7553-08dec14d5c38
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF641CF4859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:51:53.8541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlycBwtGTsGgvXawkY3btCZzciaSMHVewPigfo/VpKoMIOYPyhiateZkiK7ymg0ppsGNgo6luYj+WD+o9sOYWKTaurAO9v1aVNmSYnSIIw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
X-Proofpoint-ORIG-GUID: RAprNug5b3kPaP1vykDcLZ4BI7rotQg1
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a1feb2d cx=c_pps
 a=XDLC/QdwmM9eY7nDu63Q8Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=9M5Nqk7xmsyMC1D4vU0A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-GUID: RAprNug5b3kPaP1vykDcLZ4BI7rotQg1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA4MyBTYWx0ZWRfX0UJxk8KIpk5M
 59xqlQ1cU7hB3v022W94U7GpV6PfFAeQ/YMSRcRilKvKfppeEiPE3k2BTFoqqu0u90HUK1e42uV
 WpoKMhyyQJY9iOSrZTFYPQh/TlBXPhbPwidR1HQZqo6sBlBFCT10f+qeLN5RT2BMBQ4jkVrnIQL
 l+rAjvwY4R7sCp+skXZSddWMk+pUCWv9QUqd/vRA1EGULPexQ7YXl0h8mKC+m8JvbyJDQ6XRcm5
 fGeDhk5R280jb9Mptelpq1mEkA6MNtbYBZ2LdvKPwFM4IWX7S640pNy6jVS6L6VT1vP8IS3u2t/
 pErsf/PgMGpHB4VDYomR+uzX1eVq9m/CGym5P5oD8NNBvwgJyP203VRDrdaCgb3yoV0KjaBpbWH
 8r5LCFITXijEvzgXRvKtWt2zsHk8qYaehh/aCOyInrfidNHWuNcGbLtKMBXJIgyslN+a3DdiXjZ
 VEPQvoWFf56Ofg+suGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030083


On 6/3/26 16:32, Catalin Marinas wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Wed, Jun 03, 2026 at 09:23:12AM +0800, Xiangyu Chen wrote:
>> Changes:
>> V1 -> V2: According to Catalin's review comment, using backport instead of reimplementing fix.
> [...]
>> Will Deacon (2):
>>    arm64: io: Rename ioremap_prot() to __ioremap_prot()
>>    arm64: io: Extract user memory type in ioremap_prot()
> The backports look fine, they are nearly identical to the upstream
> commits apart from the pgprot_t and ptdesc_t types.

Thanks. I will use these insights to backport the fix to kernel 6.6.

Once testing is complete, I will send the patch upstream.


Br,

Xiangyu

>
> Thanks.
>
> --
> Catalin
