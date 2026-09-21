Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011005.outbound.protection.outlook.com [52.101.70.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620924DA9DA;
	Mon, 21 Sep 2026 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017000; cv=fail; b=sTR4h15osocUMvJ4boCas7popibJGFTwYiICtD9xjG0FUog6aNhkON/5MHQ61MYB7N28lI4OSpvt4MHnfpoC3+qzGohll09lUawmaxnvW+yVbx28q3DDyjr4IWqBoKaStUVc+Bbw3z1Fot/+CMMKO5F3EppoTojT9fOV+eejEeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017000; c=relaxed/simple;
	bh=EIr5UXQU0b7g/LLxeIHNqsGy/CoacU3DxwbUuT20ROA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IjgwQJL9bRMM28Oh0WvNHsIIRC+6ZBytpnKuK5K9D0vhIL1Ji7pcBnQkk7PTtIlQykk7EY6mgBFiW2cWmi0gdEbuQX7ioDR/zWSYbtJWNZUitIoTjeHmTBpi2SPkB4/LNgQgu6Nc3cduKMoifHDwCMqi38oFdSbRqKUUj2rzfvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=zn6oCp6m; arc=fail smtp.client-ip=52.101.70.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="zn6oCp6m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLSNIoN6Dr/gcjiddm1HJIE6doy3FYFojXmjDrSopVrjIXcC7g1Swsc+pzMhHmiP0nORptVji3Qgmvzv16l3Upv09WbgxSACFTBMFok3jCAnGsbd1ceegnXDex1NevLxWDNlb7uIBTagaxiKxotrb0SPFvk0Rrr1/7lCyOL7zx1hoUlpwW12zNonbAW0pBxReVAA/ESFd+XBxt+f1iyo/kw/wTAJiEq+iaTCAQxn58M8bh+Yk+cqAZEb7V/rTX87c5DUA9lLvz4c/3Rf8msjshTbEMlexoKmvOH7apuYZm0YoKukVoUMsmurEQ5YmBNZ66M/htZAwFi873HezD80Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm3cQ1iNKChkG0mBYFN5BLFZtzlLXmrNVoVHyS/8ZIY=;
 b=ISi/vc3t/Tz9sDJX+3gbByb5CK9VYPtimdlTx6HgTBauRkAD2UUuXTtrWChcD7W/TlkAV/85OOYDMBB8tchbCjBOfPDdLOGvI0gJ0vmRo0+zv5M21+LefcWjaGuNofcpFnvtFDBH3jkXVXTSstiU9KBywa2CuEjHc1+aPLJKQvmsB+gwKfQ25yYxN2+5ijiXKf/C89lMVY8wWhJe3fKEgiiBdooFeuyxhLr0eHjs1KEXqcQFUsmIDD/dghvKupZ1Zo5NC30uq/b3PJLwvpi8oZaG2SU4CcsR+Vrt/jAbaIKGawas2pzCKUlcL44GPoWpLhOm46nhBWlM5YDk16n2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm3cQ1iNKChkG0mBYFN5BLFZtzlLXmrNVoVHyS/8ZIY=;
 b=zn6oCp6m6CRKcVDDiUNCc1h7ZPaI+qvB0iqFhS95aN83bzgSWtCczoR9nLdDKzgaczNTHJZ9NkbtJsqiUHok9phqtLpQ9G04qSdYKLSxEZVQinVlS6bD7Zg1uPF8fI2iq5olZNkNXRNdCtNu/NXp92DpvBQzEWMUCsaOqgVBSPW0q3cTXMdUyo24z1osBN6OCUTB0gxng75KsXpyOcZzZ5yb1lrw0POVP3vT5vERKAGfwZwYadhSuNZ9niMLRyXwHj9ZJTk2aGEdmRZc5Rp6hE3IA9H4TrT3BRow0HyLqThBZ+q7fA8uFHWBgQT6awdibUzb3T9pYHiKcfkIvfm6Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by AM0P189MB807956.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:808::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:56:35 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 18:56:35 +0000
Message-ID: <b34db10b-6a0a-4fc3-8ce5-cd4c23566033@est.tech>
Date: Mon, 21 Sep 2026 20:56:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv4: guard inetdev_event() against a NULL from
 inetdev_init()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Taehee Yoo <ap420073@gmail.com>, stable@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <20260921155522.679350-3-yunseong.kim@est.tech>
 <CANn89iLpT1hqqNS2vWM1xL_Y-Eqpj5UBxjJwyfVc5JuFhSZcjg@mail.gmail.com>
Content-Language: en-US
From: Yunseong Kim <yunseong.kim@est.tech>
In-Reply-To: <CANn89iLpT1hqqNS2vWM1xL_Y-Eqpj5UBxjJwyfVc5JuFhSZcjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0168.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::20) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|AM0P189MB807956:EE_
X-MS-Office365-Filtering-Correlation-Id: eda551ad-6daf-405f-ad8b-08df18120f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|6133799003|56012099006|5023799004|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	fG6L2yxrAr2zLhsAxAyZ9x5UoDn1VHBJdIY3I/y9vbwK+/qkORzFs23c15ahMn7Ng7isiuwcuTu/po4eTu3V0ZSb7+nDlsOJbKVdframvwpBUGm6XQvRzba8tPAm7Podd16ctTRxT0QfWL/cAMZdd0612gBA3NBLUwM0K8w32dE/DrvBiAzDfgS3nDPYA/qEbuIBcDaVeC/vt2+Id0v7nKQHR3ulqpUCk/OdcMwVdLW328iNO2rWl1k7WVZ/ULzyLBOdY6MYqI77wyd6wro9TDbRRScIepoMaeb/LAiUwJ3Q3I3Wmoj2CN4NfMrEiGLR2G/G6peEgIC0RlcH30rQMUI7MqNzlGHTKvoJWpQwET5BtElRW6UaE6ZyuJXgfMSl/2I1wh8ymtqtid+F+iwzGnfAs7SbnBodOHGijJk6o7pZ5ko3Nx1cYEHpWluiSj8ab5YdGtzkuBz2s7AgBEEoqdiopa/8ABzPptgNDxXveKkXxAXJ68QXot0SgkYiaQtqEqB6qpQvBEsxkF5zqmPFpKwO5blCrfrEdIDJfx5xyyCt27uFJxQ8MFpSTtcXdKYrlTCwFLKuhphcLNbNVlSrnCa20+yQRaT2TCn0ae22ooVfuP3kgUc6Fzpkvk8rx/CucUTjNTWzt/+u8W5a6bFNhoWbvM+ZxrQfoXxtSAmii50=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(6133799003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHNHT1lFNjZyTkFxQXJaMnFleDY2WkVVbnZ0elpxNXpFaU5qUUpsL1NlYkFp?=
 =?utf-8?B?NFByeURsS2lBVkJJbnhnUnF5Y08rcSs3ait5MjhsbmNZTmh4Vkpza3haRE10?=
 =?utf-8?B?dXZHUHo1Z2hRdTQyZ2NGdVVkZ3o5OWRqRlhtUjk4ZE42Q1hFai9wT2o1bDc4?=
 =?utf-8?B?b2htc2FFemNpbEdFcnVjWnROWmtXWlUyb29qd0dSYzZKSHUva1A2eXFSOTh5?=
 =?utf-8?B?WmtQM2hWYkdlbHpheTBQNE1WdFBEWjNpcHlTMzh3VVRycHM0bFI3WkZ0YXlJ?=
 =?utf-8?B?MlUzK2dWMEVwUk1HeWQ2T2ZyeVFmSkhWUUpndnpuQS8wMzgxeE5EeHo5a0kr?=
 =?utf-8?B?VENoT2FTWmxPQTR0c2pEb0dQWjQ3SGZQc29Ja2V5ZnFjSHhpVFFsZ0IyekxK?=
 =?utf-8?B?MnFkMDhpaEVITW9OWGM2NFExRmg5QUVoVWpLa3puSi9Qb1FidWZndWVJWGhE?=
 =?utf-8?B?dDBtWWhwbmlCZ1AxNmw0Zy9yUmlUbjQ4Ym94cU5zakhaV0JpY1Z0blh6QkNp?=
 =?utf-8?B?dnFHWklFbUh0dS80MVdvK2lTRGhOUCtBMEZDYVR4N1NNTnAyZHBobHF5aHV2?=
 =?utf-8?B?ZktobXdCZzcySkY2M1dvT3gzb2lmclVmY3grNkxVNXpTNk1VV3JMZXJWT3Q0?=
 =?utf-8?B?MW9IZ3dPZnVDSXF3L0VZNjgyQnRsSiswbXNqU09JS0h3VStOcXdlWUJYUHBU?=
 =?utf-8?B?Ym05Skw5ZFc5STZvSndBRThxVHAzVTRZbkt6aEc0aG8wSlQ3NDNyemRxejRp?=
 =?utf-8?B?UWJCZjFmaG5MUW1OTmZpSmdQNmRsOUlXWUlCdk56YUlObE4yWVJ1ajllZnlK?=
 =?utf-8?B?UU9pa1RHdGlSaEJVOUVqSU5nV29Nc0o2ZzhvRlA5bHlaMDRCQ0FHaW9mY0xU?=
 =?utf-8?B?Wm1ZVmdIRENVMGswa0c0dFBJd3M3TGFQYzBNQ0QxL0FPckJ3NE83NkxTYWFE?=
 =?utf-8?B?VFloa3JQM0kxbmQ4RmZGUnZSbVAvcHFSY3hVdTVCVm1uRVdTUmRQRVJKT3NF?=
 =?utf-8?B?YXJPc1pKbHBWMHhjczQ1VEsvT2NTaWVSYjNpb0Q0d0FJS0FHZHpSUkRxQmww?=
 =?utf-8?B?Z3NwWnpRbUduL0t2bFlmUk9Ydmx1OHVBVHFNTlFmWG13TnZJNXc4bmgxU1dZ?=
 =?utf-8?B?SUt3N0t6djM3L2hpSE9RN0tPUHpiUFdrL1lnSVU5UTNZOS90RUhobG5DNVNO?=
 =?utf-8?B?UmN0bEtmUEdCUUxpangvc0hGbTlVRUZ3R1pyOFZmaFJWd3E1SWFTMVlBeEZ1?=
 =?utf-8?B?Zkg5NWN0RHJ5UjFGUkNqNmpPaDZoeWEzNVRUcW8wRDhtN3lpMlhJVWtIYUhB?=
 =?utf-8?B?Z3ZaV1FnbDFZalpZQmN4UmxhNEdWMWE0cmc4YmV3dERSL2RKbGQ4VExMVW8y?=
 =?utf-8?B?bC9qTEZ6eU5OUlhlWElnSTdzNGxxc1k1SWQ3N3JKdDVHQ3d0aGdSaFVNUjlv?=
 =?utf-8?B?bDB1SmNQNXJYUXV0ZUZETzc1SEtHQXQ3Y3VIS2lJeUQxSTl5YkhLVmF5VWps?=
 =?utf-8?B?UWhpTHBRb1NrcUExNzd0R3VacWhCR3lxVzNZSC9lbzhzUlBYRXBsMERZU0Fj?=
 =?utf-8?B?NUFTQnFGWmRBakNEK0xNVno4THB3ZUtCaVVZellhb1ptNXFJMkFVOExQWFNs?=
 =?utf-8?B?YlhGRjBHZUdxdVJJemlheGtYZ3hONmlPTzM4azd2MWY5UjFXRmx4Vk9nNkpm?=
 =?utf-8?B?YzdVd1h5bjJVTTAyZmR5eEFhMzVCQmdpdHM1Z0h0anNVQ0JMUjAxSXZCQ1lY?=
 =?utf-8?B?cU5hRWM0U2JCaEh0ZFlCb3NDaWdwd05XSHdEUXByWE5ZRDhJMy9HeHlrTUVj?=
 =?utf-8?B?cVQ0Y3lId0E0dEhkQWVZNys5cWVXU3NNeFNhWjU3OGEvRmQ4N0JVbFJWcVpX?=
 =?utf-8?B?eTdzZXd5UzBua3hOb3Jhem0xazcwSlE5aVlibmFGT1l0MTJ6bjduUUFZYlp1?=
 =?utf-8?B?Y20rUWI0bWhlY1lsSEo3ZUdtSlFqV3J3T3kwODI0ekIyMzFpMWFJTHZ1S3Rv?=
 =?utf-8?B?MDlzNVdXc1FsREVpSGcxbS93OVUxYTVpeldyZE80YlA1eldvTW9PRVliRWw0?=
 =?utf-8?B?alg0UVhaejdMQkFXNk5WZTg3WWVjTk55Q3RTTS9yN1Nyc01xaDVFVm9NdnVS?=
 =?utf-8?B?WGlNZFVYd1ZnRldZdkFUbnM4NVc0QjJVMlJGT2lJWlAwdkRPOU9hOWJGdlhG?=
 =?utf-8?B?ODhBOXJtaVpVejZITHZtb2UrR0hKMHEvdG0xVVFiZTc3UGtjejZEaExLRDN0?=
 =?utf-8?B?L3BtSlpBMXp5dEVMcHBZSlRJSFpEcHI3U0xSVHdaMGJDemdsZGF3Vk1FTVph?=
 =?utf-8?B?azNNSEZUOGkzazJ4L000Rk85NUxiNkNCdTdCUWE4Yy9SNmNWeE4wZz09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: eda551ad-6daf-405f-ad8b-08df18120f14
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:56:35.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ip8M+Wj+ZSGExtIkHhn6VXdEJkj/IWYu48jFHBFv1ZkDSbmBPMMA+kYNMQLNCT3OGcXBE8O/2N/JSx/Mks+vGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB807956

Hi Eric,

Thanks for the review.

On 21/09/2026 6:09 pm, Eric Dumazet wrote:
> On Mon, Sep 21, 2026 at 5:58 PM Yunseong Kim <yunseong.kim@est.tech> wrote:
>>
>> On NETDEV_REGISTER, inetdev_event() only checks the inetdev_init()
>> return value with IS_ERR():
>>
>>     in_dev = inetdev_init(dev);
>>     if (IS_ERR(in_dev))
>>         return notifier_from_errno(PTR_ERR(in_dev));
>>     if (dev->flags & IFF_LOOPBACK) {
>>         IN_DEV_CONF_SET(in_dev, NOXFRM, 1);
>>     ...
>>
>> Because IS_ERR(NULL) is false, a NULL return flows straight into
>> IN_DEV_CONF_SET() -> ipv4_devconf_set(), whose
>> set_bit(index, in_dev->cnf.state) dereferences NULL.
>>
>> inetdev_init() is only kept from returning NULL by its trailing
>>
>>     out:
>>         return in_dev ?: ERR_PTR(err);
>>
>> which relies on every failure path that leaves in_dev NULL having also
>> set a non-zero err. That invariant is fragile and lives in the producer,
>> while the consumer's IS_ERR()-only check silently depends on it: any
>> future inetdev_init() failure path that returns NULL (directly, or by
>> leaving err == 0) becomes a NULL dereference at this call site rather
>> than a clean error return.
>>
>> Before commit 20e61da7ffcf ("ipv4: fail early when creating netdev
>> named all or default") this call site used "if (!in_dev)", which caught
>> a NULL return; that commit converted inetdev_init() to the ERR_PTR()
>> convention and switched the check to IS_ERR(), dropping the NULL
>> handling here.
>>
>> Decouple the caller from that invariant by using IS_ERR_OR_NULL() and
>> translating a NULL return to -ENOMEM, so a NULL can no longer be
>> dereferenced regardless of how inetdev_init() signals failure.
>>
>> Cc: stable@vger.kernel.org
>> Cc: syzkaller-bugs@googlegroups.com
>> Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
>> ---
>>
>> Syzkaller reproducer:
>> # {Threaded:true Repeat:true RepeatTimes:0 Procs:8 Slowdown:1 Sandbox:none SandboxArg:0 Leak:false NetInjection:false NetDevices:true NetReset:true Cgroups:true BinfmtMisc:true CloseFDs:true KCSAN:false DevlinkP
>> CI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:true Swap:true UseTmpDir:true HandleSegv:true Trace:false CallComments:true LegacyOptions:{Collide:false Fault:false FaultCal
>> l:0 FaultNth:0}}
>> r0 = creat(&(0x7f00000000c0)='./file0\x00', 0x26)
>> ioctl$RNDADDTOENTCNT(r0, 0x40045201, 0x0)
>> r1 = socket$inet6_udplite(0xa, 0x2, 0x88)
>> setsockopt$sock_int(r1, 0x1, 0x1d, &(0x7f0000000380), 0x4) (async, rerun: 64)
>> unshare(0x42020000) (async, rerun: 64)
>> truncate(&(0x7f0000000040)='./file0\x00', 0x9) (rerun: 64)
>> ioctl$sock_SIOCBRADDBR(0xffffffffffffffff, 0x89a0, &(0x7f0000000000)='syzkaller0\x00')
>> socket$inet_udplite(0x2, 0x2, 0x88)
>> rename(&(0x7f0000000640)='./file0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
>> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\x00', &(0x7f0000000780)='./file1\x00') (async)
>> ioctl$BTRFS_IOC_BALANCE_PROGRESS(0xffffffffffffffff, 0x84009422, &(0x7f00000004c0)={0x0, 0x0, {0x0, @struct, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @struct}, {}, {0x0, @struct}})
> 
> 
> inetdev_init() can not return NULL.

Okay, Thanks for pointing out.

> err is initialized to -ENOMEM, and the only place it is assigned is
> inside "if (err)" after devinet_sysctl_register(). Therefore every path
> reaching "return in_dev ?: ERR_PTR(err);" with in_dev == NULL has a
> non-zero err, and IS_ERR() is sufficient.

Ack, thanks again for the review. This issue is always reproducible, and I'm
currently trying to figure it out.

> Please do not send patches for bugs that can not happen, especially
> with a Cc: stable and no Fixes: tag.

Ack, I will take more time to why this bug happened.

> Also, the syzkaller reproducer you pasted has nothing to do with this
> code path, and there is no syzbot report or Reported-by: here. Please
> do not decorate patches with unrelated material.
> 
> If you used an LLM to generate this, please verify the claim before sending.

Oh, This isn't an LLM slob. My misunderstood the code problem. I didn't mean
to cause any extra burden by misusing the LLM. Sorry about that.

> See Documentation/process/researcher-guidelines.rst

Okay, I'll read the documentation more carefully.

> pw-bot: rejected

Thanks!

Best regards,
Yunseong
