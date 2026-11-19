Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.142
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795083536;
	b=lCCKwRQKqOs1vzjHhJnZsOPbplOhj3pEXkR+M8y1wCyLsml8pTt69gY+gxGeI/4xWfJo
	 uhrrCa0u0fJ+ThrWwoLh0sDQVp3XFwrZI5VXgirG/cAnqCj6E/AGxX8+HGV6sEd6skt5H
	 1pl4+Bt0zlxHmJ3dXNfMUme/I8ZiMjTx5nx7uivmPAeswgpYsDhkjW6Uh7buj+U+jzujS
	 HUMh19Xt07CZLd+iQi3VEHXfdOh7rN+jpNkF2vGS5LAySsZex8+bYyb7qJ8J13+Aot7sF
	 A26vpNULLXf2zek04F9asiMwRjljHmvUaxPwrg3m1GMwbi0MMZL7yfxwZnfL8yOW6zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083536;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tfxTFHEyluesyaBIpsmmWm8rq7qtETtH8efUGbR+L4g=;
	b=PviamHIDFkrujCAZqPIcpP92haJ8KiWGCZYxLedSEvcsleLzQ8uJe8Oav9JwOv1+MaM1
	 XnplqxQQJQ8BidpmFdoZjp1GUtygnJCX1GDvpgRNNpPVxByF1dOjiQJITPdkV4Frna59p
	 trqZIDVQl0dba2rn8wD3fB6QN76sxTad+E7+Yj0kvCTcTKjWrZa5AVkLSZleJmiNuGOMU
	 FWEyY5VOTVtRSNttxi171X+rgUbFCjpf0jmg+iW6cNCzRk3jmb78evltRBnQHfaQ+unJ1
	 8CPOLDYNkJGZsMV0hI0pq+lReH0ufOfbb4I0351T+4MYQqQB6bcR0yEGZoDUDBHEQkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=C85qvXLQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.142
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023142.outbound.protection.outlook.com [52.101.83.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DA0606A324;
	Thu, 19 Nov 2026 10:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64DA0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=C85qvXLQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX7HbMqJBq5/eWQbtiPAHNdfIe9kK758ilDW7ZgFvZnFwakhaQMqoHfinxaCDwc/wvNdP+Gb+NGmHddmbm8fTzEpWkz+E2Tm0+PbLaxP0Eh/Fbeb3n6MRWkJ+ldtZhhLlfBz5drk7OB4mM+6o1AJPJ+inUOqFLBORggXySo8Rbx/zfO4Ic3JB2Te4hR5MtBp/EhSAEqIhvU0xrYf7Ltdm2Kus4mKaU3LFCwFZwBEzlkV5kyA3/xliqhqBq9HpdTnTGH1+U0rbEPtimGggvNhUuSu321j3Jy9PVuE1MPClxGVOFBCn/kqiRp3+bKJHJK3ZHiz5x0jDG1rKgbLD6dH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfxTFHEyluesyaBIpsmmWm8rq7qtETtH8efUGbR+L4g=;
 b=xU5CFrAgne68LHzWGgO01/KvGc81+Tj9b1h1cbqgbm7qBEJObJTjlc+OhR65Upav+y8YtUAa07TMhJS2dKsSivaV02GBA5blt6b7G2qcKgUDronmmyqva3rn6jeaWNse210mqXzFfhEGbMlgIn9HzKzHJuQeXhiLLtCdF9fxfSK5J77Cbdhkyxl9anb0kHGqn57pq96iPh6LmUjV/R812QSZ88v7IhFZBE5RKv4VLfkChlenJ3Ih/pWTjvfIjuMNjkk4ONYRQDlda5cwnjzRcPZD9LLisK8HXOKFg6PSWegAkcOlrgE6cAnH59t13MDEvi2WHkTFpSPbDiQ9AaZMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfxTFHEyluesyaBIpsmmWm8rq7qtETtH8efUGbR+L4g=;
 b=C85qvXLQ+jSSrCoq1mXdrvp5iBbAUo+DCV3qWMbQfzdoYOXySmLkyWrw1gPSYZznLV3K09MviE1MoQdVuLGDsPab79BKyn/w8nI5CGKsjIVjkeL+vFwffto7JAaBz2ZSXXhFrwgqKdwy4VCeP0pOcz7kxUXM5Q9+boOeB2woHrSU0rg53hpKpZnAyzWDMv2uZFi0UyNTbRA0QN/JmEEisjuZa5V9THvBMO7Bc19M1iFc2qlbRYkVNRYtDU5CzrAPzELvd0GEyEW+JllakE/mCVeKgP+V8ZCfBlGOi0q6HbF8B537uWnIigzFj5YOzf5bCjG22qkSVsF6iJkO4922sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS2PR08MB9075.eurprd08.prod.outlook.com (2603:10a6:20b:5ff::9)
 by GVXPR08MB10452.eurprd08.prod.outlook.com (2603:10a6:150:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 10:18:48 +0000
Received: from AS2PR08MB9075.eurprd08.prod.outlook.com
 ([fe80::3f57:9ced:7a37:1bd8]) by AS2PR08MB9075.eurprd08.prod.outlook.com
 ([fe80::3f57:9ced:7a37:1bd8%4]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 10:18:42 +0000
Message-ID: <d9104dfd-4a07-4fe9-b1ca-5ff6541422f8@virtuozzo.com>
Date: Thu, 19 Nov 2026 11:18:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] mm/huge_memory: copy PMDs at fork like the PTE
 path does
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <9514b491-ce2b-41e1-b1c7-066855ed6fd7@kernel.org>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <9514b491-ce2b-41e1-b1c7-066855ed6fd7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0033.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::27) To AS2PR08MB9075.eurprd08.prod.outlook.com
 (2603:10a6:20b:5ff::9)
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
X-MS-TrafficTypeDiagnostic: AS2PR08MB9075:EE_|GVXPR08MB10452:EE_
X-MS-Office365-Filtering-Correlation-Id: 733ac57d-b07f-4613-c20d-08df46267cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|921020|261022105027099003|261026121527099003|261026140227099003|261028144727099003|4143699003|56012099006|10067099003|261009223027099003|261022075727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9mJKa8ifQpqcIiiD1qWI3uolMutHJQysRYfQ0A3NtyAYH97/Qv5BdRF6RxD3ZL1jdQHSHDUu7Lb85SAVxl8b0epM3OI5pKCwWrwHfZ0ttWe7SjkyOAL561zvHnuHMj8ZOZ4WHm6C57+DR/V/QoHPk/bpHL6iD4aoKzAZ57IUgED92RHC9ZxR1TbKZ4S6M9HmpqO103/eHscUrV5mla/L/KmVjiDQd70RsTX1nMOIA9CEVWoT6jDJK/CFuADGm0u3iOMRTz+wYuSNTVDbC7jHsbGQa/FKG7ZqNXkGGCDhSNB3lm/MDrLd/Li+SkZ18DMgE7fY+2z+i9cxLwcHNd8x1bDX8Uvdi/fxtc3Nr7a7muIUDUe0IsxLHAoc/DBHtrnnkEQxckBs+yb+6ysm0WxiEBN4a70K9OWRB/1zwXkxNew24svNtpMhAWCiXP5OCfJv0SRRcYWxMgpQoVWNyxnFMoZ5JBpbavgCrjj/oN1lmItLN8BwfBn3l7EoD5X9mkPphsvrQTGBIxZXfzBHBN8Ee+jdd8uYAXhXPF8BRNp2z2EUYxF1B1jEk3rjr6w5bTMq3LAO63n0/6mg6RftQ62F6NBwmJdjRlpNF0oCh3El7srkQSsunQZl7Ko4VY3LhpMSfCsHbmLBhSHOxMxLvMpgAFB29J6FUk0ZBF4bhlbv5tNXbNb1bkwP6INys2RT6acnipybzbZYL54dwylQf/0cCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB9075.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(921020)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(4143699003)(56012099006)(10067099003)(261009223027099003)(261022075727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VC9WRG0rQWZDcSsxSk9TMlcrSkJmUUszNkw0ZnN1bmt2ei9ETngrVUdwTXpX?=
 =?utf-8?B?NlpwTmR6TmNucjVMcGFGZlU4eUkrL0pyUE5rTUxXY2RIenhSaGNDR0lBVHl2?=
 =?utf-8?B?YkM1RTg3SjFLLzVNVkx6bWc3N0ZGWk1pT1NMVHhjQkdSVVM3eGdJeExGSW8v?=
 =?utf-8?B?RE1IU3NSeDFsUVprazAyZEh0b29MNVpTeHowQ2h3TlZENWNXcnJNOFJVZ3BJ?=
 =?utf-8?B?R1NzTitFbFFoSWtZcWR6YXlxSm9tZGhMZlpPOHlyb1FaSWxSSlJSbFArMWlN?=
 =?utf-8?B?VmhVN3J6Z0FNV0R4T2Z4UWFzR2JDRlFHdkdPaVd0NVRhNmtEbnV6UnhOT3dE?=
 =?utf-8?B?d1d1M0lZMnlLY1ozQVFJVDdoRFVERmxiQ09mdVNpYUVpUlZyd3duQWo5Qmkv?=
 =?utf-8?B?MG9rektaSnkzMEliK1pVb3BieldHOFlhZ1FsZE9ockJqNHlnZWhkQmQxQ2p5?=
 =?utf-8?B?UEtSSENVeEJCZC9oZ3o1YmZoTmUwREdJRjZHbXkwMlFkQXNNUW5mRlAwNlVx?=
 =?utf-8?B?WGM5UW1Wck4zcGtaQlorS2QxR2E4ZDB4VjAvNHJ3SkE0S0JRM1U4ckRMdFlT?=
 =?utf-8?B?M3lyZThUVFJTSlNGOHVNZmhjL2J0eFFkMEJxZWg5VE4yWHM2ZFRER0ZJOFN3?=
 =?utf-8?B?MVVlWWlVbGszWlRaQ3NDeGtPMlVzcFdOY29SNzlVUWNsdklETTArMGhzOGNq?=
 =?utf-8?B?Ti9JNWNENHMvQ1U5b2M5QkVaejhzYi82Q0lyYkJRenhWWDQrWTYzT3F0SnQr?=
 =?utf-8?B?Z2thaGtvN1VWOTBrMUhDZ1B4TU5EODhVTnEwc2IvRTY2ZTFuc1BBdzh2QUpv?=
 =?utf-8?B?a0c4ZE8yZEQreExmamtGdFduaE9sNm9rQ041cklZSDBKR21UOUZZUUFVY21X?=
 =?utf-8?B?V1N1SXFZNUdCY0JPQnUxUHV2K0ZtUE0wbW1JY055SWJmVTNoTUNIYmlhckVP?=
 =?utf-8?B?R0hNQmtzMUx2cmQrZmtrcTh0aFF3WmJIamwraE9EVVY5L25DV093bC9wb2xt?=
 =?utf-8?B?ay9tbHF2dW40aGNvUElZMW9GZTd6cjNaMmZJdHFtczdXdlovclJqK0EyZjho?=
 =?utf-8?B?ckJoaVFUdmxXOXJHQkpBK0l6UVBrd3ZKc0pvZ3NJK0hheE03eGVPclBST1lF?=
 =?utf-8?B?UHVKc0dmd2RnL3J6QVRPNDZhd1VMbXhJcHB0cExLS2MvMzBnVytuRmk0L1Jq?=
 =?utf-8?B?dlpNR25GeGFRZ3Fwd3RMdlBOazlMbzYrREJIaXh5QlN4R2tsU3psVkpMbE53?=
 =?utf-8?B?S211cFcyUDBuaEsvUjlOT0VRTXpoWVdYK0U0Q0dqbThPcW9lbW1YekVKYms2?=
 =?utf-8?B?VEc3OU5DNGRMYUh4WlJpUjZJbXpLbGNHbzZDTmhUbE4yUHdBemM5M2pqWk5w?=
 =?utf-8?B?c0lkWFBFcGZETWdkK2VOazluWnJTaHYwVW5mUmRwNUZIK1hhQ0VBSVU4V0pO?=
 =?utf-8?B?dEYyNU55cVpBcGNuM1RWNVBpSThjUlkzUTVhVkVGaFpGMnhnNGtmenNnWGJI?=
 =?utf-8?B?OU92Zk9oUnNsaVF2N1hLeGN6VGFoWkdaOEN2azdZSnZnTUFJM0xrdDljUlg5?=
 =?utf-8?B?R2hETDYwVmZ6NG8wdUpBNE40UWRtby9YNm5WcGVpTTkxa0ViNEw4T0txdGtx?=
 =?utf-8?B?UVNUNUJZMmF2MTQyVVVlcU1sb1c2ZGtZbWYzZDZ2RENvYkJDMlowcTdzWkRh?=
 =?utf-8?B?Sm01dS8yaGpZVTlyaTZDcncwL2NvU2dIa2dTV2RQWDdoazF2NEhCdVpaSWox?=
 =?utf-8?B?RUV1dld2M2swdDA0RDZvUHkxYWRHYWlqbTE3RHpBQVpwbjRjdEFxZ3gxVU1M?=
 =?utf-8?B?dHlkTHFaNW8wQzlVYmpDMW9uV1AvRXk0amxtWjBLOXlXTkYrNXlpVFNHQjg0?=
 =?utf-8?B?VVlXM24vWEtGd1JEY1BQZ2dQdEJONWs1ZVhyMzhtZXgvNlNPcTl4Z1R6UmNZ?=
 =?utf-8?B?RlluU0RBQnBCUXpvS2FaMVZ2OEZtc05pbXNXNjVTdFR6Sm1PQzl2b0NmMnhC?=
 =?utf-8?B?ampkQXFBRjM5UnZkQ2ZzY3p1S2ZQVkhqbWgwMFJxQmh1L3cwTWNRV0tyeVJR?=
 =?utf-8?B?TjlOd2g4S0F5cThJVXhWMGc1M1ZwSzU4ckRyOEx3OVV0VVhtQ3BuNTlHanBa?=
 =?utf-8?B?RzA5dnViWFdJV0hhelNxK2twM1phWHBHTXBwZEVJbDhWTjhPWVdsbW9BNmFm?=
 =?utf-8?B?bHY0aldmTVF6endWZGZZek9xZnVwQXIreElJVlB0UzgzMURrSjlUcHJvTGND?=
 =?utf-8?B?NXRjeU53TG9VaVBYa3pPU2FwV0duNGYzTTNkaDVRd1lVVVdKVjdKMnRCM2tD?=
 =?utf-8?B?M0s3UXU4eWF3MW9hdGVNVzd0STAvMXhPSTBNNTRENEJaRHhTQVBlZz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733ac57d-b07f-4613-c20d-08df46267cc7
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB9075.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:18:42.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGfyknBtY9SuhJtraBJgGSoLj8NOfuSNJc+ciFnV6l6h7Rr/Rd+yiWbsJkaeLzjonGSEQdMZm/NN18zkTB+odA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10452

On 11/17/26 22:49, David Hildenbrand (Arm) wrote:
> On 11/4/26 21:40, Konstantin Khorenko wrote:
>> copy_huge_pmd() decides what to copy at fork by its own rules, apart
>> from copy_present_ptes(): a lockless check for special PMDs, and a skip
>> of every file THP. Following David's review of v3, this series makes it
>> decide the way the PTE path does, under the page table lock, with
>> vm_normal_page_pmd(). That fixes the two bugs v1-v3 were about. The
>> patches:
>>
>> 1. folio_dup_file_rmap_pmd() duplicated a PMD mapping as HPAGE_PMD_NR
>>    PTE mappings. It had no caller until patch 2.
>> 2. File THPs are copied at fork instead of being refaulted by the
>>    child, as their PTEs would be.
>> 3. The special-PMD read moves under the lock. That closes the race with
>>    a driver zap (vfio-pci, panthor) and the missing page table deposit
>>    on ppc64 hash that Sashiko found in v1.
>> 4. A selftest for 1 and 2.
>>
> 
> Okay, the refcount overflow patches are now upstream.
> 
> Can you rebase against
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/mm/core.git for-next
> 
> and resend?
Sure, will do right now!


Cheers, Konstantin
