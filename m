Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009746;
	b=JDZDj/t287f2wivTlbD4FzZZo8ftswNUQT3WAZdr6gAnioeLHVcbTY+h4zQ2bSHoLu1u
	 dE+bOMGIct/CAeVItQegzSydtAXI0kpCYJcpBaO6foyMZbjlQxcu5lJHGa95MjvHBJHmx
	 TbetOm6cnxNT0fHNumY7wx/LQz9zqijirU8zJI/OKMIVjAV8Lh2l4CW+msYAP4M9wGn2m
	 r2llB+EreoEImxnEkWq1ioP2/lMIaWBzUvgWkb8KloFuFcwGXZEpCirUzTyEiVD8Sq++s
	 2yTVnKxslo70HE4yYoZzxD4shy9h1sFYZ8f505vClgISNLPy7zEVtUR7yZ/xf6K+t0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009746;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=mozPZSQtN0QveURs63dtmDqitSS+mYtI9DEO83tr0VU=;
	b=xu88HpXrp29Eu3MiwyhnjRvmp/iNK8Mv0txXg7PRVtk3EG4YM58iM6x90nBUkwkISeWY
	 AvOIVoOxjNo/abt3nqo9gAF1H+azJrwg7DlMBabBlXmi19XGpaeIiQEPZBPzGqM7opJDE
	 jdON3ZXqLc7R8hEkim/VicRmc6PiQINAlIjfR9x4EOINjdcWLnKjb76EvAjMXDEwiC8gZ
	 xfJGs16wrFy3aizVXqhk+U2bcw4vhNiV+9C7OkszwVHcpJblPa6RBAHYUKwH3dS3rvLVu
	 LqCl+SNDLVKQcKM0LXfTCexvjfh3KmdpRbB7D+it9KJJY2TFbpAUMn4Y2r7FFu2HSOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=cnXh14SM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.103
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020103.outbound.protection.outlook.com [52.101.196.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C0606A320;
	Wed, 18 Nov 2026 13:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D79C0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=cnXh14SM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGr8dIWY2VnKgoJVNInU1wN1S7zUPWjFfRdkTaai/2iHagZUlLJ1DHU/xfXbnoKbqj+fqeT5/iaGzzpZjIpnRz8DQThbAn0RScuikTZQFYqDD/RBlnmSoHizQ8fUXesWWdGbG9hHqUOhUExojwlL9jujZl9C/DTPLIJxemgSETxINc2B24RdR9VaM0ip+mffKrZ5SJqvDW834cS74NEqlIcuUeCm9vItmbQnR+E/qzuLm/a3oRjvQOCCRD9d2NIhGeiSvHufv+2S2hx3MOUORCu8N7gaEWhHLsaHoCkKyOgl0JaXli6i3N3nAdld7tPCfprvAoZxVJFBC/yGI32Cbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mozPZSQtN0QveURs63dtmDqitSS+mYtI9DEO83tr0VU=;
 b=Xoe8cKiNrQ+7Yn9dBxvfqD3HY2qpZhlq7ek/aW9GFLUjCPWbdR2hbe8WVRxu5JXH3W3EX8Gel1m5GrdmiPAsjbU+lww382iJORfgsvogmdGVkBp5wy2eFiqLJSrHvqifxCOz64N6JAC1M018EbaSDuqnIxH4pwkpXQwiBLshS8FRCriec390TUHIs/S1P9lhln7mBheDeWgMYGlwiAJdFllgcatWtnjIlOeGW32CR1q0B9p0jxdqw+AeY7VwmcKVp5aDV+PTuYP4loVRRLu9Tc/95wsZo1rRS9ercdwkMY5tgl30clKRBSsS5iWIbdhlcS/kwLW6GIJbPAkSYplntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mozPZSQtN0QveURs63dtmDqitSS+mYtI9DEO83tr0VU=;
 b=cnXh14SM6bqp3ERtmBl+opjARd0DRPPGMoWNBG+kxnr3nwj0zN2fLsDcwmwKVam5PqJs8nfw/silc8d0ChPvjzENsuzod5y5a/Tbm+8+XPr3+pg0Cglv5cdaRNcDBP0bxevFTCQXmKQbxcgK47l//wqgGPzl+iIpNZl6ezFu+24=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO0P265MB2761.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:14d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 13:49:02 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:49:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 13:49:01 +0000
Message-Id: <DMYDUJ95PGL5.1QXZ1EK86KC5R@garyguo.net>
Subject: Re: [PATCH v2] dma-buf/dma-fence: Prevent misordering for error
 checks
From: "Gary Guo" <gary@garyguo.net>
To: <phasta@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Simona Vetter" <simona.vetter@ffwll.ch>,
 "Chris Wilson" <chris@chris-wilson.co.uk>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tvrtko Ursulin"
 <tvrtko.ursulin@igalia.com>
Cc: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261118110914.1471416-2-phasta@kernel.org>
 <DMYCSXNA6VQ9.22FS1PMBBYWRO@garyguo.net>
 <3792b7f8f4729820a924e0d60d17c97489827732.camel@mailbox.org>
In-Reply-To: <3792b7f8f4729820a924e0d60d17c97489827732.camel@mailbox.org>
X-ClientProxiedBy: LO4P123CA0242.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::13) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO0P265MB2761:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb662f2-f9ee-4a9f-4648-08df457ab414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|10070799003|376014|366016|921020|261009223027099003|261026140227099003|10067099003|4143699003|5023799004|261021121427099003|56012099006|261022105027099003|261022075727099003|261102123227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZAHSCdg+Mw+hPgLMbaO3LlVq145hqpe9bQIgQMw+qBllh7g54TI/yx4XpxFb2z8EwpyeTl+C/48YF/kiNuO0IWhsfEGOgqhWMIXatL/lgLkPyJvaYRFwGSIca1QJ6gFZxbXTUpzEYyz8MWOakVi2Lze9S7H6AHcZr3gMWUhbqs9KQ5TQvADigKL3NP68TGZEh92rjXZ4bri4EHzsmB+yYVsu27jCsGKsh8vRwbdORfqxoWRaC/FG/dZM1/b9xOw5RsO9rJ7kSBww8qpNORVYSije++dBGenSw26BQvqwP7XGyD+292b7N3WCsm+yh30AlHzNRKPeRqMA0UBdtCe7+43X8Vw5AmOTF1N9BnyPyPW0u8Ec45adZoarWgPObcpbl7RdtSyaFTDod5M0lxJAu1j23dXkjhVuu9XtbtCqNL/kY7x0L0MIBt+tf5bFCiK/fLALEcxlGs+WaIbUgL+C6bcW3wJaoiJtRjXgIKKXeoDzzU3KgXPRzEIT4GksJHecOnTtrrnGCD2IdQtF/FDPUrzbANj1lTtJicrIz/+Nc7A8qXGCHsIr6JvJjrBULFdg3w92gzN8JGnO3fDYEsYrrMVyFhpbGqj/k09ij87UCNE5XYdCY6niG316Ja2oK3Nbz60Rig3fBaLOzT+EdCztxPGwxM+IYJKrLxUrZLBmsIUzAoogDW3WcNvJsUlV9dCFL1t/YL/Fm3TD0ney6LSZyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(10070799003)(376014)(366016)(921020)(261009223027099003)(261026140227099003)(10067099003)(4143699003)(5023799004)(261021121427099003)(56012099006)(261022105027099003)(261022075727099003)(261102123227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3h1TFNVQW0wREFoQVY0Qjlvbi9WMVdTOTJOUlBjcGYyVlBuSFVUcDEwdXV1?=
 =?utf-8?B?SVBiSXN4MnRueFl4ZUVMai9KV1BaNWVRaTdiY2hHUVF1R1lwcldJNUVDeXdQ?=
 =?utf-8?B?WTVydTBUdFFpTCtYT0JMR3VHODlIdWFMU2RKRFd0SG92Y0d1M0hJcFRMNUpw?=
 =?utf-8?B?ekRaS1d2dklxcTVSVlF2ZS9RcEttbUpuMDJnZVQxR2lNM1ZHWVJpMm5JU2RH?=
 =?utf-8?B?M1YraEVWS1ZVdFltQUFDRGFHMnpYQ0N0OFZRRmR3K0VTQjVlZVB5T0ozQ0ha?=
 =?utf-8?B?YUxhQkRqUkdqRU9VS3hRbU92b0pkUlBkMk1HV29ONFlXd2JKNHkzYUt2M0px?=
 =?utf-8?B?WHphQm5DZWlqeE5IZ2VBZ1h5ZGkvS1hCdVh0RWdxVDNZTDFaZjM0QjFSZ0dl?=
 =?utf-8?B?Q01LVEQza2YzcENsMndoWWhzaEhjY09EQVhPejUrTVZySnl4R242LzZkdXBD?=
 =?utf-8?B?NUFzVmRFQkVmVDYwMkU2UlFnRk1QZGg5c0hxa2c3Nlg4Sm1tclBWbTRlSis5?=
 =?utf-8?B?RG1zZW82bHNycitkZ2lseG1RSVQramJvdDNhNDVDaGthQTlrWlNCZDh4cmZa?=
 =?utf-8?B?TUl0emRVNlVYcHE0VkFPUUtXSUhhZitWc3lCWUo1ZVFaNWV4MGRCR0lxR256?=
 =?utf-8?B?T091L1V2bEZjS1ZsNTI2a3VUM2c0OTZnYytaTUxlLzA3UDQyeDBQQjNnT0Yx?=
 =?utf-8?B?SWhEOEorMDBNRXBBUmZjTGlzYjU5N1lkS1FkTnlheXRoR1lIU1RaVVIwZEJP?=
 =?utf-8?B?UDZaOXEwQTFCVFhvQUZ0dHREVjduMzgzbUpmSE5weFBuN3NDcWh2L0YwLy8r?=
 =?utf-8?B?blBOYUVyN25NS0JuczFxUTFyTWM0U216YkUyQmlLMzNhM1pUUC96SW5tRmtD?=
 =?utf-8?B?c0JWTTRBelJLRURVNStEdnkzeG85Q0NkNFdBYS9TeTh2MUpTMkJoUENLekZO?=
 =?utf-8?B?cUxsTElSMnpyQ3YzbGplbVlIY3RZTUdpakRVM1NtdFRITTdHWUlLNFRneUUr?=
 =?utf-8?B?dUpOaEErWVpicVJZUGlFME9hWjBoZThTSnJ6TnR1WTl2WkZxMWFHcjFuQkQw?=
 =?utf-8?B?Zm82OFRHME9nYzExUnZ1bUd4RVh4T1lCWTg1amYvdms4S2E1VkVtR01hdDZQ?=
 =?utf-8?B?VjFEWGw2V0gxdERJU0NnMDA5WjNXV0EzQ3JXTEtRWUJZaW55end1TzNhM3Bx?=
 =?utf-8?B?dG9mcWpablVzbTVBVW9MamZaQk9pZC9wdGtUaXNPV1FXVC9EZ21wN0xMbTR1?=
 =?utf-8?B?ZDArRkZ3SXRDcDR1ZXY2ZjZYSVo2eHRWK096MnFrcG5HdFhOZEVON0tLZ09j?=
 =?utf-8?B?RWI4citkbkh2dVpQc3huRUJITDJTZktIR2RsNjNEYmRRa0crd2ljL2ppcUx5?=
 =?utf-8?B?d2dkQ3VYTlZGLy8ya0NxOXpyOThORnFjYzZhVzBURWc1dVVjMWVXRE9uR0g5?=
 =?utf-8?B?WnhwUU5xWndzdlhPREhjYm1SSTZLNFEyODdPNDIwNkNyaEJSY0NxWGs3VmJK?=
 =?utf-8?B?aUM0NzFTaFlkTHIwSzNGYmhUU2FiZ1gyWGoxaUk1UFRwQWJyTGtDUW0xNGMx?=
 =?utf-8?B?WUxlcGpuY2ZwS2FUVTYvcnV6ellIdWlUa3BqZzZhQWJ6QXA0QVlEVkdOVUdE?=
 =?utf-8?B?bFQxZ1lIeGdYUERBVUhXRE5IS3RlQ2hENFJJeGU4N3FUNHRTa0dBZjFjR2Ra?=
 =?utf-8?B?WGIwNERMM21aM3N4L1dTLzFTejVjNE1tY0RVaHNBVWtqRlkxUTNYVWJZb0Ey?=
 =?utf-8?B?dXpienQ3V0tMamQ1bHk0RWNobVZ6R0pyQ1hBb1VuWFdDaUl4V0tsR2lVWWNy?=
 =?utf-8?B?a0ovUlczM1grZW5xOG5RMXQ2Z3Q4cGgvcS9iSTlleGFySW5IdWNNaHZvVzFl?=
 =?utf-8?B?amxFUFJlc01ZV2JVWUhJOFpucWRpa2ppWEMvdmVJakV0U2w0MVNSTmIxdVgy?=
 =?utf-8?B?eXZLRDNZeU5HcWgyMjB0M1VHRzRUcnpjd09ERVNDeG9vVzhEaVd1RmlJODQz?=
 =?utf-8?B?ZmJGcEN3djBzYXlQdDFFWWJKUnA4YnQrR1JlY1pHYmZVbDVpQWN1NUtuS1BU?=
 =?utf-8?B?cXhqQkptZVhnYnIvbnk3SzBiSGRad3Q3dWkvV3Z4Y2w4a3JaTWpRWk5ZYmNB?=
 =?utf-8?B?VFZKemM3dTJsVnk2dzFUU3J2ZGtmbWRnZ2FLd1c1OTFaMWxTS2JveFlUT3hx?=
 =?utf-8?B?eTZ2Rm9IcEhsa2dFZnJSZ2VnL25VeVFKOWt2bEJkSnJ4T3gxZjFBOUJNV09m?=
 =?utf-8?B?VEUvVGdzRlpMbnQ1OThZdDRvYmQ4NUw5WVVReXR1a1NyRVU3Y1hiV1kxSlc5?=
 =?utf-8?B?R1MrU2xyT2dJUWNzYlVDWWxpWlFudEtqVGlKNnZMQ00yanNYZTZFQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb662f2-f9ee-4a9f-4648-08df457ab414
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:49:02.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R23sSVnizHrU6DRYTeGFc6GBYShRHowicgqwoyMaEAJV8xqg8jzIzn8eRhsCBvKe2QbJ95zWZWnoVMbMogFUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2761

On Wed Nov 18, 2026 at 1:15 PM GMT, Philipp Stanner wrote:
> On Wed, 2026-11-18 at 12:59 +0000, Gary Guo wrote:
>> On Wed Nov 18, 2026 at 11:09 AM GMT, Philipp Stanner wrote:
>
> [=E2=80=A6]
>
>> > =C2=A0static inline bool
>> > =C2=A0dma_fence_test_signaled_flag(struct dma_fence *fence)
>> > =C2=A0{
>> > -	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>> > +	/*
>> > +	 * Best-effort ordering of the locklessly evaluated signaled-bit,
>> > +	 * especially so that reads of fence->error are not misordered.
>>=20
>> I am not sure if this should focus on the error, or it should just provi=
de a
>> general guarantee that anything happens before dma_fence_signal is visib=
le when
>> signal test returns true. I would lean on the latter?
>
> See below.
>
>>=20
>> > +	 *
>> > +	 * The release counterpart is typically ensured like this:
>> > +	 *=C2=A0=C2=A0 a) Error codes must only be set before a fence signal=
s and
>> > +	 *=C2=A0=C2=A0 b) The fence's spinlock's barriers effective in dma_f=
ence_signal()
>> > +	 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ensure ordering.
>>=20
>> Spinlock has nothing to do with this. The only thing that guarantees the
>> ordering is test_and_set_bit in (c).
>
> Why not? A spinlock includes full barriers. If it were set_bit()
> instead of test_and_set_bit(), it would still work.

No. spin_lock is a marked acquire access and spin_unlock is a marked releas=
e
access. The order guarantee for these are restricted to the spinlock variab=
le
only (there is no acquire or release barriers in the kernel).

If you need to establish order using spinlock, you can only establish it wi=
th

    CPU 0  A --> spin_unlock=20
                            \
                             \
                              \
    CPU 1                     spin_lock -> B

You cannot establish relation just by putting some atomic operation inside
spinlock critical sections.

You can make spin_lock a full barrier by using smp_mb__after_spinlock(), bu=
t
it's not there. I also think it's much easier to reason about test_bit_acqu=
ire()
pairing with test_and_set_bit() than "this code will only be executed after=
 a
spin_lock".

>>=20
>> So probably easier just to say something like
>>=20
>> =C2=A0=C2=A0=C2=A0 /* Pairs with test_and_set_bit() in dma_fence_signal_=
timestamp_locked */
>
> It is easier.
>
> I am, however, unhappy with the unclear state of the API contract. It's
> still unclear what the signaled-flag even is supposed to mean. So this
> comment was also supposed to hint at the unclear state.
>
> The desired meaning aimed for by Christian is that it's only meaning is
> "hardware is done".

Hmm, if the dma-fence doesn't provide ordering guarantee, then how would a
consumer get ordering guarantee without knowing about the implementation de=
tail on
the producer side?

To me it seems that providing ordering guarantee that "when a DMA fence is
observed to be signaled, everything prior to dma_fence_signal is visible"
wouldn't be that expensive to implement (practically just need to upgrade a=
 few
test_bit to test_bit_acquire).

Best,
Gary

>
> But as we see here it has implications for the entire semantic, too:
> a) signaled =3D=3D true -> the error code is valid (what else?)
> b) The fence has either signaled or "is still signaling", i.e. running
> callbacks
>
> I still maintain the position that it is inconsistent to run
> test_and_set_bit() under lock protection and evaluate it without the
> lock. Should be one or the other, not both.
>
> Note that this patch intends just to hot-fix the error code evaluation,
> not to make the fence API fully consistent. It's currently not even
> clear whether manual flag evaluation is legal. It used to be legal. I'm
> the one who added dma_fence_test_signaled_flag(), but mostly for
> readability, not for semantic correctness.
>
> It should be illegal to evaluate error codes with anything other than
> dma_fence_get_status(). But there then the meaning of the spinlock is
> currently also undefined. The lock there, with the current thinking,
> would seem surplus with this patch here.
>
>
> P.


