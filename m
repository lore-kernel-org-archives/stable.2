Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792615498;
	b=Wi6XeEmhrA5PUtiuFpwlShr8R4qierF5mlro1enLp/CzqYwf4Qy69OBV94NKHs4HgzUY
	 VCJBLM8hii5z91oodMAP09mhg81cj7mFtMg6Nv/ToEDyshOP/3XrNZQp7CarLApm3FQbx
	 i9EhLPu34kHfiK1TaCasQ3zBGrAd0RAJq6T9Rzv0MsWznnKUMpPCqVuWl3nnyTppQst0P
	 JdZt2NPUt9DkASeDeqj6kK9d9F/LiaiLSI+uao0gGSZzXiiiY62HHAPo2E6NLiNtHAbSm
	 AExp18WrrS8T2b5pzrPmaqCba8W1oJrNxonB7IFWadMJm7T/cwRO6OBkoZhgKiBNQYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615498;
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
	bh=vKSQp6kUHtIJuf0/fU0LJ4rpNWIJBe9h7Kn6Ik78Hcc=;
	b=1eZa+XID8bOfFewuOmSnho6Lwm+DfzCGf6C6KNct5bufVNNG7t6IOwtuzbLoc3HP/tfo
	 0F+Tm+TazeAnLrLVJYTMDK9dnsQ0wVZ7aS4MHo1PVrSaRN+4dcxEF9XFoGpO9etvMmFdt
	 Xf8qAXnlcVHcTLzaacZkG0Hbdzg90uiMwbLctmNW35jpXeuCoPRwdctzubIOuBmP7L/yR
	 s4jf8mZQVK0G/cxaA5bddIuSx8weYxlV93kTlzzj7z6+vcaQc/e07gjHu5Vz2LuN1w3z3
	 AL5XvzJ455tqR7qL3GiRVzf+sBLz/yE0gtI/+MgreQ2blFSq4gCZMXItPMEJSbE/JsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=OlAPnpR7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.79
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023079.outbound.protection.outlook.com [40.107.162.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF260606A31A;
	Wed, 21 Oct 2026 20:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF260606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=OlAPnpR7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbvxNEN+8HG8a3RmCLk8l9w21VTqVlMXwbyGkGR3g3Yyx1Omvj8ctZ1kTVSjhQ+CjpqwpSZuOEb9YrJSKBBWK66f7N1yOnfQE7V8U+bd4CYN24djUmDIYmjk4c3qYPdjb6CuZcGRMugll5p05d1eF9ROGsYd7OfbxyASvK6b3DLIPCFVhWRWd71o2rqkOuXpQNiKdbeWN+r3D2thtb6NFSjWcz/C/TrflXqGkmD7mzrZDln37rsM7DCg9aq7uxi804/kADFcsGckNiKzvqpyi9ZWYU2b67i0P6veqzUmguzcqwb0R+sSPsEgQ6qKiy/xSdFZahfnJz4WMly6H9l/lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKSQp6kUHtIJuf0/fU0LJ4rpNWIJBe9h7Kn6Ik78Hcc=;
 b=lFy0Z2cRLie8gh2paWm7e6nufXNoNft4mo58sVpRosSMbMv/gKz6cQ3VYSwbZleRgWXtYdBl7oocM7bfCXL0CNVB1UYc6NH9qjeyGWkrjG4PyulhpSv+MfFwS8Flxn6xlHtZFmnFASryo/kYxDiQ1ql1JpKHYEocg7RjIOtw6rSXbhXSyomZaev98XZJJITGe+7dW7N2/OS1AnN0nhhL6CFZ94U7K8E7hGd4eE9ZSpHdn3OwBpvK3/Veaskh2eZoQlQCNLpvj0Kt+oHF3NP+Pv8UAA6LCz0oF18kA9u+Dw3Hv3M8s1a4Z/H7agWFqDsGEXPZtsnjRCyhuC8Svwrz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKSQp6kUHtIJuf0/fU0LJ4rpNWIJBe9h7Kn6Ik78Hcc=;
 b=OlAPnpR7i0/eEmnKPJZz+GGGKPPOV/oEK1iKWEmWPMPxcQg3Vk4TyGzmaEiKRlJSXepb/0Q/y3lh1O23LFAXlxpJjFk5HKbzjDmpDFgcLGT37F9lVkcui6Fc4VzHAblf1uThM0ooMP91t91H8UBh6DIHg6BgImAphIWLCa/coB/Bb/0XZAM1eGhIiOPfi6yWBXL1/AKhqtyGpXuHwoU4lic2Mf5XcZLGE2ot31z+Ctoziy05GzeYxtbhjE8toI3RT4oHVQoIl5c8iSOsJDcb3xohh9ucP7RsKfs6u6UefinoA9BWrKU/1wb/P+wCSCvdtIFSqMV1Dr2VlIKLXRnI1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by DBBPR08MB5964.eurprd08.prod.outlook.com
 (2603:10a6:10:20c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 20:44:54 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 20:44:54 +0000
Message-ID: <7b4b5d25-d955-45d7-aeab-eedce9f40bd1@virtuozzo.com>
Date: Wed, 21 Oct 2026 22:44:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/huge_memory: recheck a special PMD under the
 lock in copy_huge_pmd()
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
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
 <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-1-85eaec8417f6@virtuozzo.com>
 <5800bc6e-7671-41eb-bb09-7fbc8f2d085c@kernel.org>
 <03a10e8e-f14e-4612-9c23-70f94137a29e@virtuozzo.com>
 <973fd409-64b7-4c62-82e1-c75c784b80f7@kernel.org>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <973fd409-64b7-4c62-82e1-c75c784b80f7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0021.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::9) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
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
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|DBBPR08MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: a70e5904-5641-4de9-998c-08df2fb428fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|261009223027099003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9LSHIL37mWnf9zZATmMuw+PLBIBLEzBQNolC8fkfOrVUCk3bdS3pXsFfOU7bSIzB7Qt91BG1pwswZ+6d7F5omJDHwM/0sAhv86C+moc7Y1mKCtrk2RzL4kD01Ft4lCRnH93+123Bh5TfFtg9V4Y0cogVZi4xc8ap/eC9BsnyKksp2sfZ5/uQ4KQygvt58wctt9qJNknW3W5QpjHLVzyNTeovnK3dSTnxUgjBZHRcVgOTAImlHwWlRG88gPiQ1SB5Dm/UQY98M9DGEPIww7y7Fb1voHyHvTqUMF3/dTaQjVz5W26HFiLsSj0rfT27oLV3dM7Q6D6MkZSWN9/CsfnpLOZZhZRsWtptjRdwkEu41tnf71X2j4QQZ0/wbPbjaDictFdUzxCyoq2w1R5MZEypCOX3yW3a6ASTGgF6V4pLWprJ/45qjyLZJktrKme4GpWpR9I9SmTprZ+AJg4HZOFHD5iHQgOYj9lTIx/IgIPE5nzQTF0CYFjLxMNxsY8hwaOXGJUD+koPhionGVYM8ZW1qOZO/F14NvpaQJU5mUnqD6s0ZzFamdcu6TrSHFrYzaEMvSvKfobr7IJSz/Fr2U+ah0YDDCQ2NCbBwIGyyTiPwH3HvbsyoHDCsDCcKVppaLaxtgTmnZ1TY7ojgqA/3UgHOCa+vOEoShMl5eDnsx2a1LA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(261009223027099003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWxFdElpNUc3UVc4cURWeURhaUdpejA2TXp4ZTZ5S0dTN1BOQ0lWRWFiU1Nh?=
 =?utf-8?B?ZU40NzZ2ZjFNT1Y1eXFwL1JndzlkbzFma2gwVVdLQnl5ZWRQVTloWHBmT1Rl?=
 =?utf-8?B?L2lKbFJ0NkdtSFpaS3ZmellHU1E4N2gvRmdIYkNpaVRLWk1ndlMraUF4SXdo?=
 =?utf-8?B?Rzc0TVR6eWVpYWo3RUdab2ZXbFhJelR5QVdLVjlVZzFsY2FaL0x0MXpZOHlB?=
 =?utf-8?B?SUhCQXBwTElkNURBQmpNNXRaT21pSmVHYS92bVhGTXN6eUJ1VDdZd2t6eDU3?=
 =?utf-8?B?ZnpjSjJSYjBGTjdsS09oRkcyd2EyaDNRWDZMcUV5N2NZNHlHY0dYL2ZCYjhP?=
 =?utf-8?B?SFFqQ3FJK3BMN2o2cmRMMm4reWxEcnY2bjVmQnVPdXM0K1hNSm5KbStTeHhn?=
 =?utf-8?B?R0FPUkZzdmdZRzNuTmdRakN2cllGR1lKdDlqSVNWRU92eUtrcjQxM0YwWmVa?=
 =?utf-8?B?TnVaMk5BanlQZzY0LzloNFlpZVRCU1gzR1dSVFRXK2lmakJRSW5IN2piUFJO?=
 =?utf-8?B?aURBZ2NvZEk3dUVGRDlud0xUOXV2YWxEcmprV21VcStDN053cmpwUDNCTE4w?=
 =?utf-8?B?Q240TGwxZDMvVWwxb0FzbTZOL3lJanpVaHc2UkZUQ3d4Z3JEU0ZpL2MveEl2?=
 =?utf-8?B?dDhlSG5CNXR6cHZtbG91VVl1M2pudXBKd3RscXRVc2JsdXo3Z2J0TnBleDVp?=
 =?utf-8?B?VmRuT081TDQwbHhMVnJEZ0ZjbkcrWDVCSVA1YTgyWUlwZ2Jjem03elRFNG96?=
 =?utf-8?B?TGJaZ2cvcnZyMzVnUlptTFhpY0hkRFArakgrZExWd2RnU1VWRlN6TXZVS3R3?=
 =?utf-8?B?UzNXaHlhbHg1cm03MGkzdWtTZE5YK0hnZHpQUEcwdzhKb0RkYVc0MmNXSVI4?=
 =?utf-8?B?VlhJTXpnbDNNeittUXpIK0NkdVovaVZxOVh0S0daVGFtNlVjbXltcUpHMTF0?=
 =?utf-8?B?OW92UVlUakRUR1BtM09ucHcwUGpVL1J3aXpUdUdDOWxHK2plL05GaXk1cmMx?=
 =?utf-8?B?ZTFZTndPVmhUdEQwZ2EvVXVWTkhXNk1DeFl6S0RSdGZaaVF0S0FCYkhVOEdX?=
 =?utf-8?B?YzEvM2FZRy8wKzlXNWFPU29yeXJuWjBSZTdHM3MreWZ3blo0Uk5BLzBUa1JJ?=
 =?utf-8?B?VFZJVG45b3VyaUpiZXRlSFZJdndxTkx5OWprcCtvUkFUd0ZqaVFXSEhMU1Q0?=
 =?utf-8?B?cnljcHRldzcxajA4ZkJxemdYM2JsTkdZaDdCdllaQXZKVWdYMVlvOGxmaWtw?=
 =?utf-8?B?L0swSXJpeTExQWZmcmljKzF6OEFJUGY3S2ZTVGJ3NGJVR1Jib2hzcmFCcC9x?=
 =?utf-8?B?b1E1enV0cENaZUNNOGplSkV1ODF0b0JGMUZYQjVnNTJ6bVNYUEJkN0s4QkE0?=
 =?utf-8?B?d1FaTHNHVjdRcUxOQ2UzU1Fhd0JxVTRqSzYxNExudElGUUdzRDBnMFlONVN4?=
 =?utf-8?B?bW9CMDJQd0dMWStTQnBmTmtmQUFkQXV5UktGYmpvMnZEZnkxaUNVOUJUeWhm?=
 =?utf-8?B?SnU4Vi9ZTEcrK25kS1B5Sm9tV2FqSlNDTXo2S1RjU3ErRk5Zdms0SmxLOFdr?=
 =?utf-8?B?am0xQ0RNUjV1USsxQXd6bkZMQ2FxMzBHQWJDNWFDT1d6ZmloRlBkaG9HaGc2?=
 =?utf-8?B?YTZXS0ZlVW1Oa1dNOENTV203eHcwbWJOc1BkZVBYRmoxRis5akluTWJpWFor?=
 =?utf-8?B?d2ZLeXNoRjVZWFIra3ZpR3crOXlYa3RRQ2NGWFBpUUJjKzUrS2kvbEZFcE1C?=
 =?utf-8?B?RVliZ1k2Ui9WU3plNmUrTmhsR1hUeTVRYjNrZTVBSC9FcmNRVWpQRG9EeXo4?=
 =?utf-8?B?NTh1ZHNnQnFVYkM1clVpV0d6T2trV2dVd2JmQlBTY25MTG52YTU0ZGlKWWF1?=
 =?utf-8?B?YkFJUDBSL2crMmZwa3hxUkt4bkxKaU5JekVOZHczNGRrU3dvN3ZPd29QaXpx?=
 =?utf-8?B?NmVQbnYvZTRTR0JKTW5CVm5NK3FjT3FhN3N2eHV3SlpMY1U4VEtuc3RmMzhP?=
 =?utf-8?B?SE5xR0ZVdmk0eTA4R25FN1VqZWJCcTVXdEZUZXlNUE4xdGlpQjkvVEJCRjZm?=
 =?utf-8?B?aXkyRjQrVHM0eE93SmF3M3lWNWtCaHJHZGRsMnNvWElsOWxTUTEvaDgvbTdm?=
 =?utf-8?B?TEZJUUxmUkFuN2NnSVJEZkVDRFU2ejRyeStPd0hhVVN2OXF2Vk5TRVF0bkpi?=
 =?utf-8?B?R2Fmb1ZUdEhyVmtnUE5mSHdmWnhVQytmMTBsblZmd2hsVzFKYmFKaTAvelFr?=
 =?utf-8?B?KzlaZGNyMUdPQnp5eENYbm5iVXVOaExvb2g0SkY2K29LNlRXZ0tjYlFTMEdj?=
 =?utf-8?B?cVEvTjZreFlCUGhSMHl5d2Zqbmtha3dOWlZKclI0R2x1elpUOTZ5Zz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70e5904-5641-4de9-998c-08df2fb428fe
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 20:44:53.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eh6VxmK8vngJyhi9bYGHBRwrGzJmvRoJxMAmiR+fPRlMSQex+aFJPzwZtCiu5720ht7439IzAUyAxHO6xTmx3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5964

On 10/21/26 10:37, David Hildenbrand (Arm) wrote:

<snip>> We should likely do exactly what we do in the PTE path: copy PMDs that reference
> file folios. See copy_present_ptes().

Done in v4: copy_huge_pmd() now decides under the PTL with
vm_normal_page_pmd() and copies file THPs like copy_present_ptes():

https://lore.kernel.org/all/20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com/

Thank you for the review!


Best regards,
--  
Konstantin Khorenko

