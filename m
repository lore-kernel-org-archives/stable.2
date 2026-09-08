Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010023.outbound.protection.outlook.com [52.103.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F746531B05;
	Tue,  8 Sep 2026 12:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869883; cv=fail; b=G2EIMb/J8y/trS4SLUxHgJjF4Vn24Qs01JECRkDDEEGwgXPoc/H6XzoHfvaaZq04IHrtbKF7sxNAs7m2krrM+sxjQQlHYOJqGGCIK/DZftFfKykEcOIQdvJCvCQ1HtTqf3NgyOrIZENOAIVJbpAJ1wQHN0brJ0zBUllOnrXDon8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869883; c=relaxed/simple;
	bh=aHVqaJ67mucfqbz+m05efTZm6Ual4GrzGQcSx6E0FaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwwTTE17+iY1HbDCnEpVJh/sUTxhlT2Db6dEZeIpf3P2zMSkKdqfGj1q7yQ0zrSuTZ3+H/ueeOePoozDgzg35GyCjA0FUA6lUw5xfCzoRho1Y7DBLLMBi090RtggiPqDrGzznTVvmAL1Nu64Zm2fEz0TaKwMDQFuwIkQ34DWS14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.kr; spf=pass smtp.mailfrom=outlook.kr; dkim=pass (2048-bit key) header.d=OUTLOOK.KR header.i=@OUTLOOK.KR header.b=bzGtBXUs; arc=fail smtp.client-ip=52.103.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.KR header.i=@OUTLOOK.KR header.b="bzGtBXUs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUk/9Tq2hkrlG+3WrcTxADvp6aQIhMSz1qkV5KuPmUrOiWICFfYI2tZp6lxFzj8s0yESrG2ZqYW41cqlXuBD+uljimKE4oTLrm8C3BGahq8/YBFE1hAh/I0VUy8NNPxSjUDZjCWra+6yG26/zecUTncBSFLeVw09zcvcV9OAcCykcccCJdRQPS/NT0hjFpI8lBPGhl2EX2z72CjXgzr+z5H7/7z7AHmivEnVdagS5VU50QtmSjR71ZAZyKz65qpVMRVu6VPymAYlTOp9WDLzGHeNo8V04cxu4wXtrXn2lDOKjqSoyQAjlaeemVlarn4Reg7T6XyFDhvcVPbjLItI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHVqaJ67mucfqbz+m05efTZm6Ual4GrzGQcSx6E0FaU=;
 b=ZZAEpoaDW4A9fuHghEp8SXq3rcen1DQCu3QK6u5WUsn3H3dP3JFRggiVH86HDPJhbpmOs/Zt2JQScqF/j5q3zrnM6js5Kh50LVXUStBouKlKKZrAfHLHND2reTWPIy8+WyeDaaEb/t0h8/1pOmIWaSr0Sxfk4YcW48kZ4WXTv/9NM55qoO1YBxN04JFQdeFRAxfl6AySV2ih16IPcC5P3yf0KnbyLBi1MZhxHCGg1h9hbEYVadQBgcHjcHpyL7d+5px9hLrCgqI1G/yIhtOKXQc/+gmzi1T+ed/did3DlHagmDvbPjC8l2vLgxhsKI+kckn/X3h7S0SxiCtBFClvfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.KR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHVqaJ67mucfqbz+m05efTZm6Ual4GrzGQcSx6E0FaU=;
 b=bzGtBXUsfTl4QSDAfxSNzMMXqsXacKchTmfqFH82xMvSe8mT8hkNrENGsVaaA8IbV0sabI7me+cbgIG9nqxATp/povpV5SIoUX3bpqpEajHTcRsaRK6P7p6HLzcXz1AWRpk1zFD+jqmqMLZBGPj41TnM8g8j26+Uy/Tc75rA1fWU4o2cQDr5TMalTUqfPrHkr2nEoR14sIJKMJOCNQp/fI/fswcguxBY5/UT2Cz/FuuToNzkSkCTu+h+iSDWBEk0uWkCBTUNaTDyTARD0hgHAsdwXl0ZDw0Kw2OQGYq/25dyjFiX/KRKe8G41LRG/2wrNjyWt0/vMfeweuFkQd9AQw==
Received: from OS7PR01MB13914.jpnprd01.prod.outlook.com
 (2603:1096:604:36b::13) by TYCPR01MB9749.jpnprd01.prod.outlook.com
 (2603:1096:400:20b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 12:17:52 +0000
Received: from OS7PR01MB13914.jpnprd01.prod.outlook.com
 ([fe80::641e:83cf:743b:85bc]) by OS7PR01MB13914.jpnprd01.prod.outlook.com
 ([fe80::641e:83cf:743b:85bc%5]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 12:17:52 +0000
From: Eric Kim <seohyun.kim@outlook.kr>
To: seohyun.kim@outlook.kr
Cc: juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	qlsdnjs236@chungbuk.ac.kr,
	stable@vger.kernel.org,
	vincent.guittot@linaro.org
Subject: Re: [PATCH v3] sched/fair: Reset NUMA fault locality after scan period update
Date: Tue,  8 Sep 2026 21:17:37 +0900
Message-ID:
 <OS7PR01MB139146F4F1879F2194899866496B12@OS7PR01MB13914.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <OS7PR01MB13914CB69D682A599970F258C96A62@OS7PR01MB13914.jpnprd01.prod.outlook.com>
References: <OS7PR01MB13914CB69D682A599970F258C96A62@OS7PR01MB13914.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0143.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::14) To OS7PR01MB13914.jpnprd01.prod.outlook.com
 (2603:1096:604:36b::13)
X-Microsoft-Original-Message-ID:
 <20260908121737.6398-1-seohyun.kim@outlook.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13914:EE_|TYCPR01MB9749:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b2df78-6087-4c64-d0b4-08df0da33495
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|21061999006|15080799012|51005399006|23021999003|5072599009|25031999004|8060799015|19110799012|25010399006|40105399003|2607281247196008|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQ0wf0tcjeVAjojM+EMzJR4NmVKsiBvV3c/9zE0vtI39z/ebWndS5B1YOC0p?=
 =?us-ascii?Q?6dbVnJ5EleOQ5F0syk5jsWfaeSMeq0kinvgydfFPZWZdTV9KSaEXOcxvtN59?=
 =?us-ascii?Q?iuDsp/f6pdNaaI2tzKUIgRGeNJHtDIYv9U8fmG5ZUW20zZF0EzsE3/jq30mp?=
 =?us-ascii?Q?zg6hTGbE2q4kKK0TQ2MX25l74tq3qDEXtN1KQBegVUSQndrTHCydHZQCUW7b?=
 =?us-ascii?Q?qKX7jfppQRJlI8u86HInlRg7pV0xfqjVqcAT5mfv7NC01GL10id8umc9B5gK?=
 =?us-ascii?Q?tu6GjvI4ml9vMKBUS8LTQZjx5aRC8z9VP7zYmHfrklIYGj9nd58w8q8cpxQL?=
 =?us-ascii?Q?SJHU4xh8i4fDsLTkAwBPEkzMZ+I4uuhXVg3nwH4ZF19I5myeEdq5prbmGOt0?=
 =?us-ascii?Q?+ix5hhRWC5BB88rzsNs2JrL9vUWU233WwotLU7GYb1QiuDfZViYvVPSDB1iv?=
 =?us-ascii?Q?P9cae+uOfYPROYAgz1Tsz2eNczFHuIhNBOV+5Ncx4ZuAfVe1ADJYHsdpeiwd?=
 =?us-ascii?Q?QxyBRbNOn4RqFnNS+vKfiHltbtDoKl/dWFu2480nDCwcIlk65zOnolKx7amB?=
 =?us-ascii?Q?I6G/ScS1xYOXyzAMsMyAHV371kOF9GjBLj0rI9jWVSepeVIFFPsSCYkNTs5f?=
 =?us-ascii?Q?GXZlSzeMAT73vh3FqcSxfrZ30sJ/WUwtVNfsXV8NU++bFOtGbKchCNAwvxLO?=
 =?us-ascii?Q?Wbe8jDzkSSthuxYxO4olfpxgqL2KD7XJnsNmyhN5ZvGyfU10EMg5IV2PAxVb?=
 =?us-ascii?Q?7f2UtSMl9nZQJqvRVoKXvO3nOIF2hkIia+cBTviTN1noY8igs/LhiuBDl8FH?=
 =?us-ascii?Q?UoJAzifPi7giVbhVzlSjgRxBfm2IbSdEOtA1zsk8t+j1/PFUw3qxe6dtw2p8?=
 =?us-ascii?Q?qrTqTx57toRvhx2Pajra4kLw2RNrKQpkpEGwdavqTVlXlEDtS5e5tK6pAaVl?=
 =?us-ascii?Q?U1uFyREs9V1xIciQZ32VEcazwQLYtyNDgm3gotjUcxYao9kyNblQqf/1hVZJ?=
 =?us-ascii?Q?AIGSnSJEyr/TuN0oN7CkLCdwvA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+WDB8vnoPBxfXBp/Ph1smtWdKzLLGtacLg8buEmEswATz/Ldjxu176BEvBiO?=
 =?us-ascii?Q?WHLUpUqSpvCDFz8AZuZRz4btR1wygsPb6I4K4CmJXNTzTh8efYPHo98N0nT9?=
 =?us-ascii?Q?N9eDco9pZ+qa33iTrpUBPZr9CmFxrunx4xaoQW++s1aolzxZ74uYm/6KepyU?=
 =?us-ascii?Q?T7mvYi0LMxp+bFIf7ZpW3d7UdcQthws7s9pQcfjF4L1HdLnNmjFNwayc5U8x?=
 =?us-ascii?Q?iI3sM3Y+RR99EfcqkgATgHXpBlElXvQcvDoksOk0Udw/ZQI8ZihD5lS+fdna?=
 =?us-ascii?Q?84Ov5Qh2ESPKQSUik+XksdqHBKydMR8IHfolgcdkQUEJNKDCnPpO3jSl3ynh?=
 =?us-ascii?Q?dGJY0nQcYZJ2Z2MS9xgqmnnnVUE4MqUfH1WhCM8I1ASAGRVbs+U2ODiBHuwS?=
 =?us-ascii?Q?IAAgHWyd1mLs0Iq1wAnqpIlpyEnEwBciRvTZkPq/49ER2V+nDMcp/HeIfFDe?=
 =?us-ascii?Q?OJtsfT88QEdMQdspv2OmecTmXBhWgJJJUCZY8jH6EnG5M5kMn4Tra7MTKFR8?=
 =?us-ascii?Q?FR/0NZi0BlywgUKIjIVIFlUoJehuRqN8BPvI38H+88SKNUF3RuxkrQQ/mtmx?=
 =?us-ascii?Q?F6ldQlC6/pcAw22nK0foKmcPckSOwD/PbKuyHF+6i+WG5STr1JujK0otlCz3?=
 =?us-ascii?Q?6zfiNIc1YUHsQrycy1YCe+l/4XB01xD4DJsuYutYe6rd6gJY4JwZYa0fGNx8?=
 =?us-ascii?Q?13QCQ3L8HB6ioRC0UXl1d/K6ZCe/oUUQSJa9SpgdoF/0ostNqJIGRhHjf+PE?=
 =?us-ascii?Q?ycKkpWlDn/6ks5pZvhzH0gKZfRE19bQnB9EKVwDtBMrXdGhmIeQqLFM72Av1?=
 =?us-ascii?Q?7clEhvKFt8xo9M0MJwRvhPdCQNcbhMONSxgYmjh6AtrULPR9o83biji5t5y9?=
 =?us-ascii?Q?RhkNhXL1GQ2ETt2iiC2aJXWBjt/gP3MASdYUuCzlK5wUrqdImJbaj+B67gbb?=
 =?us-ascii?Q?naWlJtKk5FwmAmCFR3efLbTRfjUdZMSRQqh3ljfYI3WgbsAys/DeYXZSQnwS?=
 =?us-ascii?Q?1OTrU3BeLBgMsBqRNWcVJC8EGT6IdvJlYBIV+gsT3gLZmlEmKxto0weGZfPM?=
 =?us-ascii?Q?2O8mxDkjcbt+rPonEI6uKHZoocYJChiwU1gLHf164msRNBYfgOVN1/kjrc9h?=
 =?us-ascii?Q?aJrIib9l0TDnpYzAbzO40obUFQLFijXPxk9uPoOMPDsvV9nV+PyImA8hdQxL?=
 =?us-ascii?Q?HDmvAGtY98QrVfgl5fx/w/OErhHVZgKVZisFWN1KFzlG2c9urs1BqaCuqRXM?=
 =?us-ascii?Q?mRRXzz5Crmtp7F9jc6au59kKuTp+gRM4EfQ+jZcP/cBP/flPgbhmAp9jvlpk?=
 =?us-ascii?Q?LkydFMKlwhARjzrKCmw5ZXCLy0dwqWrCOAwzXo/oe+qPk1/b0NM3dO7Ff70v?=
 =?us-ascii?Q?VU2OYwX01ZlfH+AK7l2JwxhiD4iQ?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-b83fc.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b2df78-6087-4c64-d0b4-08df0da33495
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 12:17:52.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9749

Hi Peter,

gentle ping on v3 of this patch.

--
Kind regards,
Eric
