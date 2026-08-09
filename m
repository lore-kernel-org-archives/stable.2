Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022120.outbound.protection.outlook.com [52.101.101.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747223ED5E;
	Sun,  9 Aug 2026 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786286491; cv=fail; b=WTPZPKviizz8YxDaxt+xffpUlY0yImzNyrsCsh00iEE3QdAAF2iPH0wNn3r8O7CbW4cOOzZnOSa2jYlCysqKO9S1/VxuPAQEVrBb6ftusXaWpfOUVShv+uaabBb2J/+xvsg7R5agEYYYG6wLmJM/ZfVKnrcmBPeB/F3yoXhgI9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786286491; c=relaxed/simple;
	bh=w6h+Eb5FwJWQ/8OOeLCajJN3vuk93eQWvI7fKgtTJ/w=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=FT3mnoX0Kk7OZS1ZIW8AjDcNF3AVwpwKJQ4Amcf0vWuSiojBW8xXhGknDafc/6j8he82lmcFpQHNbxRTFG5nwz0b9cn5tLomfe/20DidZLEER0R6glPzok01P/iOI07qFYeVFz3E7mfkhxd2Ol5xylTGvocPdknHFmRsTT+2lms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=i+Iulx7L; arc=fail smtp.client-ip=52.101.101.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="i+Iulx7L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnkMS1t/p3Kvel1em+T/OyaBxTCoeFDiJNM2oLvGotMLvHawzkgCRx/UQllV+4lwFy1rC6L/dR8oWP3nRfR8ftjs4u/f4D27ryplzRGQLrj/2/ucNPiY4eOBT4DDHMvMjZ+ke7maW0hbhdUCcmqlvYcX/3FeSi6lk8n6zAKueIGXRc92rRXBYFsltUFOmz5hzo8QSJcTTON+6eLzyPHJ8r9UfVRFBIPxCzrImf/YewnGFF0sV90VoiuQwVLrv9RvY0IO7yqmEPhRglrjkdRXQlBIPEmt/8GSoGK+haCRQMuoO5t9FmJu2ak9u192xO6kKws+T+Qz+LNluV+U97vwJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6h+Eb5FwJWQ/8OOeLCajJN3vuk93eQWvI7fKgtTJ/w=;
 b=ZawAKCHmSza+S7xmxr+1oz6dFi3EYKE+TbBHzbqmPbC7ydvdSfRwwX4T9lsfsENHcuEUagsRALWfYKt05vTMs3nAL7fmzxWY9N/0fq0LXZ4e6+1pwgdHj5XKDTHk2kT7LGrem/zLXNKMQTM4Nw90But1D6Bu+LSlNHAwEG4vuK+SiVVI7hCJ2KHorS9+RxBwUbAigpGcePQBeKIBRBU02SI6rthK/zKxG8S+XzAnpU3CNheCsmyWR+BQOywmIGwmehX5E7YQYCzcOtA9A+FMX4WyVJP6tLVkrmXtrftqSvBkFAr9AfUsM4hnp9yH2PI9Ch+XiSxmhrV8Oc0euwUt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6h+Eb5FwJWQ/8OOeLCajJN3vuk93eQWvI7fKgtTJ/w=;
 b=i+Iulx7L9c1FZM1IuOd+lLCzhUET280qUVK4tJ3z1MFgkFYxpUz0NjenyjTEZ6XvHvjU/NgIsDI3VO+hkw7uaShcDkTGdTCtA2VJXCLSSVRvJxXidf9WmJSTRMG16Ni2F9WTaNqv7gHdrVAqn3SmuYpcBOtYzG8PuSyk/J6FdmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB7213.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:346::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 14:41:26 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 14:41:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 15:41:25 +0100
Message-Id: <DKKHPMXA030Z.M58PRIVY8LC9@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "FUJITA Tomonori"
 <tomo@flapping.org>
Cc: <ojeda@kernel.org>, <arnd@arndb.de>, <krzk@kernel.org>,
 <alexandre.belloni@bootlin.com>, <linusw@kernel.org>,
 <chenhuacai@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>, <rust-for-linux@vger.kernel.org>,
 <fustini@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <soc@lists.linux.dev>, <kernel@xen0n.name>, <loongarch@lists.linux.dev>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: bug: fix `dead_code` warning in `warn_on!`
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260807221429.155946-1-ojeda@kernel.org>
 <20260808.074341.1056015191905819805.tomo@flapping.org>
 <CANiq72n4=fz=JNKY0Jdm8BnLa=RmHB2B7s0bO47YTJ7hygqBZg@mail.gmail.com>
In-Reply-To: <CANiq72n4=fz=JNKY0Jdm8BnLa=RmHB2B7s0bO47YTJ7hygqBZg@mail.gmail.com>
X-ClientProxiedBy: LO0P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ba31f1-2d5d-4ba9-ef75-08def6244aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10070799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fdom1D3nwLxLUueWAIx59B55b3BflY9ng973cDpW5yf5MMXPPxKzssZquUEKaHzYRKlOX5DzLokF794MqyBSf2OlT2APCjW+QhxtFzzMgxZpKzXuRR+DQoDVJ6WAaP3Ew/4XEQ1XsFV8laxIOeBKyLOMNWLcb/v87D/TNDjc7juKwFJ1/Ci1r7afwOsbYBR3iyjLuwIgQqDiWFcepHt9e7wSyzGSCi21wdXscwEmaupNB5kvPgA3KpiBNfTOAH0JRzTGvVbWQLrOm9poVDffG3mK7MeX4GasLBpJS18LvWAKfrbdtmodoeKc3b9ScuZkKdAWHb/D1knEfNQ708XkYBZSkmWlkt3T7WLnphNtXWs0pcttWEFoh5V6cfjYxL8ppkmsFbniuzASvWjJxt9tqXYLpKOcpB3jYiZKUZFOr8Mcu7ZbbzGdPdU/sQSkqbemKItHUWQvrbTr4IUKPig5IsTlmFY4TZ93NC8SrTcLD0UQQXQijxR6aNDD+9EhbLEWYO8i5j5xKg//cTX5w3wQeewVTl5Jcsh8p/EuKF9eoxBtLfgO9UOFpt3WXXFkiigcCErjR4Ly+HtKOrIc2N/tDcENas72TLCFNN/HJxDUB/hT9rYXzL3gMQmBghxccVGXMMCh/PBRIQTBnC1ny5u6z19kqdB5g/t6Dnu/i7K5kWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10070799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDJ0OUx1VjNRdVluMXVodHhSMDhiUnZmNFVDMmd4TDFtalZvblR0REFjNW1S?=
 =?utf-8?B?dUhyMjNkWFJ1M0szWk1EWW9xRFhOUFFjUitXNTdzVWs5ZlM1Qzc5bWRUbENX?=
 =?utf-8?B?cXRFWXhnc2s2bHlMZThiRFBUSzJnOCtVblBLMUZHRXlmajVJMSsyZEg0bnk3?=
 =?utf-8?B?Y1U5TzdNbDVEdU5ZK2U4WWJJSVVEbXZ4OXIwa1lsWGVwZFlqR3lMdFdQMWta?=
 =?utf-8?B?eHp1emo0dXRqT2hOYXRyazdGQ3RrUktrcytaSHh3amJubGRwR3ZKWGxMemRw?=
 =?utf-8?B?a0VTQ1RRYzEzcGQrOHZCZStGbFZMbjVab21tLzZ0ZExqbU9pamVVeFROaU9F?=
 =?utf-8?B?bHRDSjFIMTl0eSt0cXFoV3NvYnhEZDF5SFFTTTBEYm00VjVycmczNXZhZ1Rs?=
 =?utf-8?B?aHZuSXVkbnkvZWxNNXBGS2JESDZRSDVYakRaR0dKZ0J2azQ2VDlWeW9iTTJV?=
 =?utf-8?B?c0pmV1ZqZyswUWJxTzNqa1dpL2x3NW9odTJCQlcxZlI0cnovNzlwY1huNDV0?=
 =?utf-8?B?L1hJT3ZSZHRHa01oa3AvRjBGdnFScVQwSlJpZzU2aGtOamFCdFhEd3NwWnFK?=
 =?utf-8?B?Z0c4TDRXZFpRdEx0a2NEZkFCRjJndVRqeXdIMHFxWU4yREMvd3VqZ0VJVEg0?=
 =?utf-8?B?dStJQ3ZhQ1U1dzh0ejk4ZmcwR1dXSlNTeDhkaWppWThxQ05qUE9qMk50MXN6?=
 =?utf-8?B?RE92eVMxMGZ5N1R3SVkxOEN0UDE3cmFRYXR6Rnd2emUzSnhibHBnaGl5eFJ4?=
 =?utf-8?B?RGFQLzgxWnhTaWdRQytEdVRhYWcweXJxeDB0QnVIRzJKb2p4U0t4OWFadUVY?=
 =?utf-8?B?bSttdHFicWUveWtXNUl2N3lVVldqN1BnSWpldU5PaCs3eDNmVkxxOWgxdXBx?=
 =?utf-8?B?QU8rb24zRkdJbVpXVEo2RExMcG1SNktud2d6cDJUdTJINk9DdVJueVQyN0dJ?=
 =?utf-8?B?QUhsSUxNV0pWeHIrcFRJaFNEMmw1VlF4ck9jNzdZaHBJeEFVVEdXSWs5VHhv?=
 =?utf-8?B?Lzh5dWx6WnlYR3l4Y0duTDNXVTZ0Qlh0SHp6dmR0S0M2Y09uZmxqZFZuWDNM?=
 =?utf-8?B?NkdYVGFRME9PUEdDeXQzVlBaQitIdm1YYlY2YlJKeUlPQUFVendyK1ljK2c2?=
 =?utf-8?B?cG9kS3VablliWXNSUVRXMWZIOEdsR0xreWh5UVFxWUtZckdQajNwVEpqR2Vh?=
 =?utf-8?B?YVc4VVlQUXJ4UUdqSHhQVHlSaVNKREdMSjV4SklZdUZHbk0wUXRMMFY3bnN3?=
 =?utf-8?B?WkdCV0hUS1VvdWFOQ3hrdlVRZENtcTJqQ1dCOFFPRWtiK0lIQzVNR050RzJK?=
 =?utf-8?B?N1F3MWpTUG1sdzdKYlIwNWdMcUVMam9KTXovb2JBU1NEZUMraWRCNkVTTlR3?=
 =?utf-8?B?R2lHSW81YXBqSGZ5SWZoNVR1YlpnNk9Wa2Zjd0lSWkg1d0ZodkRtenZBc2Fa?=
 =?utf-8?B?cmg5Q2kzQjM4SklISnhId0lhNTQyUXlsL2xDam1WTXVvT2R2Q0xSVWcwM1ZY?=
 =?utf-8?B?U0xLc1hhZDFCOG9Dd1d4SFdENG1WS29SOWkxS0l2djhiM2MrbkhQOXY4clgy?=
 =?utf-8?B?Vk5PZjhsUko1UUlJRmhFdHVDeFZ6UXVkZFJrbFA5THJ6WVRleTArM1NuTmxv?=
 =?utf-8?B?TVRzZVdUeG16Y3RIRE5GUnpBQlZtMGRVcFE2QU9BSkM4elhGMGJHRjhjczF5?=
 =?utf-8?B?S0Ird2NLdS9VYWZPYzIvNEVpRTZYdUd2UWNnUVVqY2NmaTNUcjcwTzRUdHVU?=
 =?utf-8?B?L1IyN3c1Z1d0cDU2TURDdFVyQS9LQW5KL3BGU0M3TWVaKzFvN25jSS9Xdy9w?=
 =?utf-8?B?K1gvZFZUV2J1VEZsSHlhQURaVVFmNE1KdFlkVTkxbzV6anNzdzVzMU83R1Ji?=
 =?utf-8?B?cGJPMmVPVjRXS1VmMXlXb05lZUVFdElrL3pleXRReUtIZ29LWVczbWh3ZXFW?=
 =?utf-8?B?QW9Tb0wxK0dWN3p4Y0M4WmVxenhCMTY5RjFhWXcweE9Ma2tJdldGdXhoSlY0?=
 =?utf-8?B?MkZlWTlLMmV6d2wyRlZkMTAzWUZWZ3BBUEZPTkxxaGFZNjN5SFY3ZUFsdnZl?=
 =?utf-8?B?VFFPdTlLZ2hONURIMHZlWjlCc2d5TEx2VnlGUXZiZDRMM3ZJbkM4SWt1eXJG?=
 =?utf-8?B?cHFqWVc5eXBqWCtrdGo1cjFObGxRQnFIbGdOR2pYb2NnVUtpbUFiS3FSR25j?=
 =?utf-8?B?eTQxTHVGS3k2eko1emxla1dSckxjREhrMWp4cXZSUVpGb0NiWHdtVXF2Z0k3?=
 =?utf-8?B?UC92RUdXU0h0RFpIb29RK0hWOVE0Wi9xVS91Tmo3c0hQYlJKV29QdEcwUjFP?=
 =?utf-8?B?ZHN1ZFdNc0lCdDJDTXhwZndNUi9yUytGdUJxbm80TTdKbUZ4aDlsdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ba31f1-2d5d-4ba9-ef75-08def6244aa9
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 14:41:26.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIWYeJc3xdyjBe6NauTnUvSYOKa+jp9YVE4/BZoK2G9YuGJMCoRsynX8WWp9fLfOuFyzROe8PW32Uvi7hlb9MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7213

On Sat Aug 8, 2026 at 12:21 AM BST, Miguel Ojeda wrote:
> On Sat, Aug 8, 2026 at 12:43=E2=80=AFAM FUJITA Tomonori <tomo@flapping.or=
g> wrote:
>>
>> I sent a fix for this bug a few days ago:
>>
>> https://lore.kernel.org/all/20260801024841.786664-1-tomo@flapping.org/
>
> Ah, right, sorry! I also saw another one with `rusttest` for arm64 and
> riscv64. Did you see that one? We probably need a `cfg(testlib)`
> split.

I am not sure how much value does `rusttest` still provide, given that KUni=
t can
test much more stuff in an actual envirionment. The fact that we have to do
special casing does suggest to me that we might want to remove it.

Best,
Gary
