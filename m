Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EC44C4F6C
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280590; cv=fail; b=h+rL3Ue1l6wLGo3VA/1lDxcmxBspHkTVqKbykrCKFj6b43u8ylQkClK85N5iBE3TUD46J2uLFQxoTSqtdkcnZfKQQcMevZnNNpNHkDgcoTxgBoGwHOaMBW6Myff9RI0xk91ZJzbZr3g/ZmZ3PFFEP1f2vBs4WTi1rLRVW5vsTUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280590; c=relaxed/simple;
	bh=Tu5FOv/+xYcdxaBCoCKjZljpn/fUjgKX4AqbIoiLU5A=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=HK5utVsvpok1Yzwe0evoViQPojS/pzD7eh4VXxro/B5LuhyuaNDOrJU9av7ykvltcqMP33Hdo/u7bRBICrqRx1dyLJeJMpfSmO4fnTVO7A4344K6rlPIDU1p5erWsckJcyfdswpummWtwMfaVchUmF6URYZ3YXSSiPkstvXbE3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PAsZiDMZ; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PAsZiDMZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFoQYLckOfv+CmxtNQPW+l//vv00jBtsNzOTvVFQaxmI97oa7r1cVnUuNp0dHB4715BwasAE3E9/tEUGZVlTV7L+QTrL+BAVEGy3kzpf58Y46884aBR1WmmnTgNLRKAUJ8XCk7k2yd+6pJVwXauAN8i1SxKwKSdn8W24K3UPAu3ss3dE1ct6NbIW9WLypZJPHn0tLDRGbjEWtVtyVLG5SE64cIuB5Co3rE2sHDyHa3VKbLTMA4yojUWWuldLYdLldRmsrnnbiCwYtWGIywheqSjXoH7u+4lcNzAV7evjBqhNS3nlbnePg68IfdlZeI6HrVipZLZ3Yex9C8N79vKKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK5OJJUtDmm0/hSZuTgYIBBcoIVNA82+OxbAzEfJoB0=;
 b=Rc6uc1DfEdCjFuJll/0HLJxXoVxO2yMpp+kPAdxs9t3iPcS2J7AhgxnDL9R+/oazrnfhfg0I21uWC/81WtMJbKLnnaI8G/9+BFcMJz/WyWZydZoX94bQwVbUPUqBOsODcEAGe7svaC7S6Z1w4D/PtZjDXLC7gJxuBohl5U28eBgGq7z4QS8pN8wR7PCkDJyAoRaFTda6+tF7uJe+50cdm+JrIYkeWYQsuAecu7W0QcrApeVHDS+VyZDSR8oa6wmKEQmgzhl3ZO/gra6cEtsqG25oE5VEyc739olH7bym4xJ+9+TGztalj11y3lKM6hJzOaUkPDV7AHhEyLfjHwb07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zK5OJJUtDmm0/hSZuTgYIBBcoIVNA82+OxbAzEfJoB0=;
 b=PAsZiDMZAmieh2amt8anocTibTUFWwjKisQKDyDE6Ckc9YK209ti7POWvbxLpwByJJFLeGMvLCFMNBGeCbq0Rgc9vPcjS57fmfyEg2PAD+NLeQ1iRhSYpPOLVQDvYqjX5qEf9f9c9XL8httA/WUksmqjQhba6l5w1zLbIAwxCYY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 20:09:33 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 20:09:33 +0000
Message-ID: <cf67c71d-b34f-4b28-bdfc-6a1742e5c756@amd.com>
Date: Thu, 24 Sep 2026 15:09:31 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [7.2.y] NULL ptr deref during DPMS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:610:118::28) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: bf17e586-7945-419b-687b-08df1a77bfad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wi1xVWLoq2WhIjReXDgj0Cq5JMk74U8cDZNOGZRyhx7gkswXkvTQSc6SMLcdavKDzGAQdPmgB9vDdMTp+QTKPrdAID3y80CG64YryE0NwL5TzC+dnQb7TpgP7wn5TrKChfXz7Wj2dl/dZvst23MK2YMk1NDeHx0j9QylHM+AoPkitK7dl6JCQpHvsse87qS/XzPn8z12gVEbnL8fZu8ny2M0OXcZYBV4G7yx/oGCrRP2Qp/ic4hPfWDllIPFL4tRfhLGE0O4BeFfaddIsfKQ3K84AcCfZ9sJc3ae2fZDFNtGq/HLZrnoWWjt6OmGv35L7hFCcNU26Dt6m61DZJdhPChfrC6/4Dd2Z/E6FlEfu4Y1NI3R4sLQlf8eX+ueCOXT4DAC8R8OQyM84TrSGX1BAN516HQtcNoiwmLEsaRd86hGhybYuTmGLRJbMSkY1KTrQw/boyKGcE8ClGTKfkE/wjfRPdYy6LDBAZYMo8tvyX2Ukb5JUbA2yD/oOTs+VkFmgpl/y3vhMJUFXU4wwhV8qYoYsd4lCg2PjC++ycrUsUQNk8/2yF7gINjtiYVCNWC6KhhCF7OK2qb8HM1jQpA0QDe2qWUu0hgQVnWeTKcVBa19hJO4N/RctWzid6v06qyz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1V4SVNYOW1DTThsZWZmWWdkOVR2NmNQcElKUHpYOEQ0bHhZbXdiVm9qMkRx?=
 =?utf-8?B?cm9kSkxMUlQ4bU84dWNyNHhVRFdFL0N0dmxZU1J3RGNlT0MxY284clNSckZw?=
 =?utf-8?B?dHFQakxTcExnL0lobllhb1Q4Y3ZkMHJ5YjloWWVpK2cwR2kyalpiRGY4a2VZ?=
 =?utf-8?B?akRGWEk3YnZoWWdaQmVZVlZsUHUvTUVOZlc2aHBySmlFOUl1cGlSMUNXRDV1?=
 =?utf-8?B?SUp4azlqMXlDdzdab3dJb3NTTktHS0VhSytJdytKRG1OQ1Zud20zTUdlNW44?=
 =?utf-8?B?Zk1lR1dIL0g4Y2gvQkYxUTQ1VXVtMGF4SjNmeWNtZnloaktoTjZNU3h6ZnZv?=
 =?utf-8?B?RjJqRGwxK2R2M3NCeXkzSVNVYkNDM3JPamhtdzFsYW5Gb1R6MW5GcjZQZGRy?=
 =?utf-8?B?MjBOUFo3bVphbCtCZEovaXJvQkZmTHVsN3ZCN2FuOXNObGR4ejltS3liVnow?=
 =?utf-8?B?RngzUzNiOU9kdjJTYWhQSGM2b0g5WHplcHdCc3FkTjU0eEEyTy9SU1RVRVZ4?=
 =?utf-8?B?U2VYYXZWYjdSai9zWjM3YzRmLzBBcm1QT1FnbkJUREJMdGgrZGtVTmFnUU5Y?=
 =?utf-8?B?YWFLL2l0UjNHUXRPU0hZcE5sbnJ4czlDTDdEUUFCdXR5OFZuaExGMVRzV24x?=
 =?utf-8?B?YkVHRUpRamFJRFEycFZQMzFnOTB6aDBmaThad0RHUXJRa2ZpT2I5TWk0Z0xC?=
 =?utf-8?B?b0tZcVpRcEpNRGsvYWJBb1QzWTlrYUdLL2FXcTBkOTVMajVQRHlSY05JeWpO?=
 =?utf-8?B?bUplRzZUcy9tNDNFdHFIa2ZidVJVNDgyWUlZVDlJWlFJb09qalBOM0daVk5k?=
 =?utf-8?B?dXVqSnducHRCcU4wWFU4dkFmd1dJT3pVRk5UK09zbmtmSFViRHhJYTMvTVdQ?=
 =?utf-8?B?VGVhUGRLM0N6QWh5M2NXNmcvM3lxTW80Ukh1Vi9oT0F4UWNoRkIzYzQ1NDdh?=
 =?utf-8?B?T243Q2N3d3UvL2FVVU9ZOFBjSXcxVXdLUjg5TGlucE96c1pjc2hFQnFaZnhX?=
 =?utf-8?B?S0ZiMjlTUUdkOHhVYkJSMUpJM0lIa0l5VE0vbW1JcmNtWG5zQ2xMLzlrRTRo?=
 =?utf-8?B?YlNWRFo0SlA1VGQ2ckJrSE8yOGQwNjJEbDZxWkhmLzlqcmVuektsa0dSYVVV?=
 =?utf-8?B?QXlHL0QwMlNJUm85a3RFNEdjYmxyNzdhWkV6dXJUak9rTGwvR200WXJ6Rk1v?=
 =?utf-8?B?Q2tMUkcwMThQYVhZbDVrMjM1b3pJOG5XRUZlQTFpL29zbFU5VUpTNjhSNDky?=
 =?utf-8?B?TEwzZlFSNG9lT3NCS2FGeW5NTFErQis0TDkySEIrbzhBcEQ1ZUR3cUp6b3NY?=
 =?utf-8?B?bDdMRFRFUTVQdVNqWmorNnlHT1B2VUcxcnFFbkxHR2FRWDU2WHNTQmpoSERw?=
 =?utf-8?B?Z0YxQ1JoN25IRTdibHd1Qlh1ODdncE9iODE0KzFaSEE5V3pranduN2hkZ294?=
 =?utf-8?B?WjFHb3ZoUjQ5WnB1WGtZMHY2TzgvdGwvL0JKTm5lN1NCMWpjb3VoU2MwZDYz?=
 =?utf-8?B?YlVJQmN3TUJjS3lvdFVxTERzMW5tZUdnZ3hncmdOcUVVcnVISXl2VUNXcmdJ?=
 =?utf-8?B?THNON2hTV3F2MHRsUm52VWEwaWFlNmkyNVJUK0Urd0M5ai90YXk0SXBEQmpT?=
 =?utf-8?B?WjlHQWZhNWFvWThuYW8xVHZuMjZPMkR3VW1RRmpqT2ZKMm9sTjhFT3NoVkp4?=
 =?utf-8?B?RVJKREVwZ2ZubzVwRlhSVVFIOCtQWXBna00wemYyMnhLcERIYkk2emp6UWVN?=
 =?utf-8?B?THdHc2xDRGQxOHNMbkJtVHp3Q3F4L0xJdy9aTHd4dlVFZEs5ZW5WNWJrbWZU?=
 =?utf-8?B?Z1QzaUJ0M3VOTERwT3Bad3hSQjVCTm9Rc3kvMGU1bnJLd3lSS0c1Q0pyQldz?=
 =?utf-8?B?R1lqbXQvdDR5STcvbHNZS0svblo3TjN1M2tXYitSWk84WFpFeDRodzZ1by9l?=
 =?utf-8?B?VDhsOHY0eUkvNXF0NGNOMU5QYXM3UUdLandvZHoxTk9aNXBJc2xoYlBPY3V1?=
 =?utf-8?B?bFo3N28vS3FHM2llS09EeUJuYnVCTDNqcHJaZWRUeVlqTEt1OTVQZ1ZmNEpV?=
 =?utf-8?B?RTZySnFaVkZBUVJHZllHQ3gxdEpjNE1FZUhmY0dkL2lBV1YvbUNqaERjZFFQ?=
 =?utf-8?B?UkRRUDBpd3RmbTlmamk3TzFZaGtJZDhYak0xQUtrbDJKL3daU0I4NHVtUG05?=
 =?utf-8?B?d1BmWGlHeTBtdERJQlBkU25jYVJxeGRDQkxROGVnUEhuZHpnY2gxVXVRSFZ0?=
 =?utf-8?B?ay8rbUhJUVF3N1RGYzdGdzI2K2JNMDBwcCt2TDBNZm82MEJRWVNoTFhCWEdP?=
 =?utf-8?Q?twK46mMvYhX5IDvDYS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf17e586-7945-419b-687b-08df1a77bfad
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 20:09:33.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kh5IMnS1bejPUZbGOPHS6rgl6DDxN6/aX5c2TvzKg+KGo0LN6EIwY6agdOfbcEYMTmdqZGtM6C+wtKlyWEhVuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

There is a report of a NULL pointer deref during DPMS at 
https://gitlab.freedesktop.org/drm/amd/-/work_items/5875

It was identified that commit 8fa813b7fd1ec ("drm/amd/display: Remove 
sink usage from DPMS") should help it.

Can we please backport to 7.2.y?

Thanks!
