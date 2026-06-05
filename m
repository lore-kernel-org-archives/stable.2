Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022087.outbound.protection.outlook.com [52.101.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F0395AF8;
	Fri,  5 Jun 2026 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647241; cv=fail; b=B1EmJ/THkPXjHlCLmAsV/6CWTAUMrL3j8WIhtrd/bAA47tqHFzck7eEuUJuRj/liegQO/En+Lrta0OkMN7R90iEaxp+hz2lScbg5X0BXStop8vynldcdxIBuNKI8wJEUWJo+4CneYoQa8RBIuhNStPXu23nnePVafDeyhvqt+gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647241; c=relaxed/simple;
	bh=FoXKTsVq/lhueIfn1GlY2gR9o1TlTvEQBNhKvNTAXLY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=rR11sjV/I9gwvu409POl4pZmxLHdItg2zHdq2ykfXTSQtiNgYgmfOPaNhtND4QMXqE7fufESReNdGHJwOpLuoOtzBhE51FY5lVKVw7HBZxRql6pua7YBKj57uIiofOHjCQxyRXZ7ZFWlAvfE27hdg/HX4qL2zBPcG5DOhhQKMgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=0hZfJUyz; arc=fail smtp.client-ip=52.101.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="0hZfJUyz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7WNV6AD0v9AnFujIMpsVfDvgHadGVTzSeZhEK+39TPCGzn2Hb2wl6XTdC8wCl+KOsT+4RUM0O+kncqsdpKNGpirSvO5ikfw87w/+PUviabLeq20f6djjCpssuv5JjQ/MJb/LXoLfILAHzbxMnrvCmJJXYMcVB9pzyuYHei6RSGCw8896Sbw8FaqFnUjCoWnHsffMByKf9+ZbJ8HK1ecnwMG3TU+3M/FT4qej3F8tjdBgUSYzLNVJ/HWjqwgw2m/hvg8LKBY2DP0jYO8Tm9BOJjxaL6hbBBlcHqp8BJfZyd/WgKPqa0NLcEdvxXQ23xFoJGHcnk9dztB1l1a3IrSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cRUHB6nC798Z/o/GQl0vCuVPdB40rPofyUQvudlYtM=;
 b=wfEDwJwc4FUgy5PZp64crvA35vJcjWWpEQ4f8yeuN9aoK3dJiyu3kK+MtYr8rzUtiI6TaxufSe0InNfdAEJcpA40fnVp1HDLiK//AtNqfHNx5bxGIumnfN+OTGabs/qfDEZbLLXOpLPn6J7VtUWrTx8ps7ahwbGvqiNlISHk2OtRg0GiR6i3q7Yig5NiiGK40FW5rA7gnYTsi0oVtQNCT5Uc67WitZa93X1RRu61ZJ8lPSBslJxMh7sW3RrhqILLRbOlANpBZBpRVxaLf/vfZTSZv4JEpf6Kd547ZNpP+SagS/bqdThMDxe4W0+UcsiEI/cz/BHpaijoJMr4gyWGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cRUHB6nC798Z/o/GQl0vCuVPdB40rPofyUQvudlYtM=;
 b=0hZfJUyzEsYXdnFqxVd8jbDelyfryzoFjyUctQ6lZlTS3/1MaFVh959GZr7bJlYmJlZunENdtmLe0CvhFfsE3yKWlOFjbFHN0XQLWe1fW/pQImLI5CmSmS3W7/CsKylJ6NPOMvKKbKRS1cT9ywcsByBedaxJli9FC2lOxNOXWKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB9189.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:492::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 08:13:56 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:13:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 09:13:55 +0100
Message-Id: <DJ0YRJ6MHAU7.WVR4P2MQ4HIX@garyguo.net>
Cc: <ojeda@kernel.org>, <boqun@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <zhiyunq@cs.ucr.edu>, <ardalan@uci.edu>,
 <pgovind2@uci.edu>, <dzueck@uci.edu>, <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: firmware: return empty slice for zero-size
 firmware
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Yuan Tan"
 <ytan089@ucr.edu>
X-Mailer: aerc 0.21.0
References: <20260605041134.38290-1-ytan089@ucr.edu>
 <20260605071104.135675-1-work@onurozkan.dev>
In-Reply-To: <20260605071104.135675-1-work@onurozkan.dev>
X-ClientProxiedBy: LO4P123CA0506.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ed76a9-f760-46b5-6f78-08dec2da6398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5sYb8lVyvIcMJuPTvOF8fb38sfJ6pIhftBAuwdzEdJV/QlPdeA/AKRcNJF5pALbnfE68/9Z84fqxg2QtxXaP3byD9QetH2gq8XP9929sFHBGY5zSRkV3o2NbVgNFr27LHLzMDFaSXJzW808wKQFhfOMOVNJJxFPPDWJr4h3S1sIwTBxFAP/WLMtzn6oYasYQvgS2opP7ZPG8m7UJrmcNDl5Me+qnLx6yb7f8/keklqGrTqbiaLhyEyIvwORBdqSHLw8nmJzqaggdc6B6yqPmsByJ8q+tABJbI8jDXi+7Bh3qBxVArraOWX8jlR+lHY6lzC0DfcuXpPgvLU9Z1WJEB+4AM/ipPXw/mDYn3A+KBkvFA1jC5+q6DA4ypsDrdWSWGmKx4rCNs6QORiWvkD1FAfMNhu89j9MLUQ2j9+ex7J76yr48XvSrO7gmGGykg8o8B8EijNuqw+D6uXNa2YItFvlMo5gVGZgHUM0GyI4XcP0IPCaDGPAAnhDnqFY+Z35Q5fvQ69bene2O5kNXpbbc8chSDSKJnmL+lRandMjjZmdZD19D+MAIQUS5sRSlhMIRtDu28Wabz3X3mi/A7Nog2YyjzxUWnos9n8310+6Uj/6f6eJL6j4VExJqiMwjTVmIKNFWKQwdP3DzLMd+OlsLpS439VC0bgemaCMHbmUZpI6JkR9KV5VhztAa9t+O2n26
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0N4RGF2WU1CaFVKU0JsUGdnRUZUWmtKOUV5S1BzaVJyU0tsNytIaFJxaytV?=
 =?utf-8?B?OW1jd2J6OUYwUjlLVXY4MktaWDdOUURTK2ptYVl0dmhmTTN5MWk3c2x3ZEk4?=
 =?utf-8?B?V3hIZ1hMV0lVVVFBb3F2MlhSSExFYTBoRVZ5RHUzYUtDYVhIdXg5UEZ5UWJm?=
 =?utf-8?B?Mmt3WmxnRzk0TW9ZRFYrSGZoMHRBdXg5eUtzZWdKU2RwbStFK3RwU1p5ZlFx?=
 =?utf-8?B?UFhoTHJwMjI1MEZkZ3I0YjJFSFRQUVd1MWZCUm9Gd2dTTW5LcXVoZnJXaWtM?=
 =?utf-8?B?dHdLWUZhcmJmY3F2QVF5WTZRd0xPWmNLc2c0MElyVDZQN2N1MFRBNGpheTNK?=
 =?utf-8?B?UGoyQ0I0TEU1TVFQMGM5NVFBYVBvdTRrcWxaeFA2UnZBUHRxdGkycDBOeFdF?=
 =?utf-8?B?YndRMjZhU2U1YzdYczlyc2MrYkovYlA1YTNwdGlERXNGWGttKzBhMnBjdDJ2?=
 =?utf-8?B?QThGTTJTRVFlM0pwdnpzR0NoVHlRWmwzc0VHYkU3Vms2Z01NbXhwcFVUVFZC?=
 =?utf-8?B?UHVENjhLMVVjdlV0K0RBMU5ibEREa2kxUzN0MWVoaDFtMS9KN3J6WVBtZkpY?=
 =?utf-8?B?bDVSSFMrd2k2SG1ITmhDQTFQZ21TUGVLYkdudkdNUjdLVjBpVDhBOHcvSlpu?=
 =?utf-8?B?Wi92T2NCVHRqUG9FVnVZN1NoUHYwZGVuOU5HK3NLTHN3clhGbjFDb1hKY2tx?=
 =?utf-8?B?REo4SFB1anF6NVpLbWpFYVRqQktuUUFObnpxQ2l4b3dDTU95Qzd5S2t1UW5o?=
 =?utf-8?B?YlpMRy9QeWxVTnVFU2I2VmhnTXpWQ05IQkthVi8zNTdFOE1HdW8yQXBMU3pw?=
 =?utf-8?B?Y25sT1ZVK0hjQkJlaUlvVTFHSXlsRXJDWnNEVGxPdGxHdzY3ZlJ4WXJiWXM0?=
 =?utf-8?B?NzVFZzIvV1ZTZDdzS2ZOWmdrZEJuRW10NGVrSkdreVY5cFpSR3NqVDhiajRH?=
 =?utf-8?B?Q2hzSjZ4c2lpTEtlOEcxcnFLSXM4Ym5rSUxmVTU3bDF2RThpR3BOekc0aEFq?=
 =?utf-8?B?a0h0K3dRVkRIbFZaRlh0VVFYUm1tNUhZNUVoN2w1dUtOR0pjbi82RUpPVGpQ?=
 =?utf-8?B?YVJlcVd4R2NCd3NXRjNHR2ZpYVFBU3gwNHVtR3FrUmxBK2xnSmNmeFFXN0E4?=
 =?utf-8?B?ejRubEVqdnhrMjFNNFBBNzNwT21ybmtrSnptSnFNMnZ0OHorV1VYNlNKd3Jj?=
 =?utf-8?B?TzZDaWNmeHRMTVYxMTNXTEhnZ3dVMElua1hxMWp5SzlBOVVuSDgyTHdRZWlv?=
 =?utf-8?B?ekxzaXdSZVBKL29DNTJDajM2cXVPT0U4RE9aMEIrdWlGWlNFSERncmk1ZWlF?=
 =?utf-8?B?WlNKL05heFltWC9ZbE13cTVDQ2pqTHI1WVdnaGs2RzRGSlhFNkVzTkhTWjlS?=
 =?utf-8?B?YlhuRjJlQ1ZTYzgzbDZHd05NUFpmQi9zRkhoQkJYV0dBeG56MlRTZkJDZFZt?=
 =?utf-8?B?bGJ6QkpQZ2p2MUxHNWpkYlVjcFcwWWExUE1kaFdzTGQrTmRSOFRmbTRzTC9Y?=
 =?utf-8?B?RGJMa3NrRGIyQjVpWE1leWpLVUpzNTJnMEkvdi9QNmE4clczdkZCVGFoSzdh?=
 =?utf-8?B?U0hCdkVzMGx6VWsweHdRUXk5RGFhbG8yTktLTi9uUGs3b0NoU0pFbU94UUNX?=
 =?utf-8?B?bk85TWtITVpRZnRTeDEvODJLWmVtQU9IZGpzTUF0QWEvV3RKVHo1Rm92dHN5?=
 =?utf-8?B?cHhzQWlqZjZ3a0lCNFJiTnBaTkpVMDZJVTA5SDc1WjZPemRRWkJJTDYzcjFj?=
 =?utf-8?B?MmlQSnpOSktwTk1kWlJEYjBXTHZPNDdPZTZBc1N2eURnRjM3SEVPT1Q4OXY5?=
 =?utf-8?B?UjNNWkFWRHFjZlI3NkVTWlZ1Zm04QWRaSS9iRmoxSG4vMEtkYUF0bGtxSmxC?=
 =?utf-8?B?K2pYRDZqNTdML29LWnZUMTFob3p3R2hwSk9TMjM2ejdUMnBUTE9RaEdBd3B2?=
 =?utf-8?B?WFNUaE9YcmdDWGExOVVGVk9GdFc3L2lwcXZvSVQ0aE1udWhzU0YycmFqeXJU?=
 =?utf-8?B?TnlWa1Zwa1NYM0ZQYkczeCtwVHV3a3NRb1ZqZldaT2s2VEdYVHVTTndNTFBs?=
 =?utf-8?B?ajNxR0daRnVDNTdwbWMwK3k3eUFsMGNSbHZvUTFZOFZpR3VwcWVaYk5Wc1M0?=
 =?utf-8?B?Tk51RUltSEZtM2dnWlJ6Uk5JQ1N3eTBHZVRqY3hPUm5RdG5XNTJoQ09tcXFU?=
 =?utf-8?B?WDUyNklQcnJkZkF0TlpNNytsK1QzKzdja2N6L2VkcTRiTndFY2pmWjFKYmUr?=
 =?utf-8?B?eXZYRnpqS280N2QyVFBFRVRSL25UV1ErY1dIY1k4NkFXVW5rYU8vRkltQndI?=
 =?utf-8?Q?rvydb6uum5ksmieopo?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ed76a9-f760-46b5-6f78-08dec2da6398
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:13:56.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOirBjP8tqFyd4agLTW+vwt2ysdJCzc3CYiJdqOR+RNtmHxg18FFtsGZ8EjbhsfkYvC/4yO5ay+JM24/rAz3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB9189

On Fri Jun 5, 2026 at 8:10 AM BST, Onur =C3=96zkan wrote:
> On Thu, 04 Jun 2026 21:11:34 -0700
> Yuan Tan <ytan089@ucr.edu> wrote:
>
>> Firmware::data() builds a Rust slice with core::slice::from_raw_parts().
>> Unlike many C APIs, from_raw_parts() requires its pointer argument to be
>> non-NULL even when the length is zero.
>>=20
>> The firmware loader can represent an empty firmware image with size =3D=
=3D 0
>
>
> I haven't checked in detail yet but "empty firmware image with size =3D=
=3D 0"
> sounds like an invalid image. Can such an image actually make it all the =
way
> to Firmware::data()? I would be surprised if the loader accepted it.

`kernel_read_file` will return EINVAL if file is of zero size. But I think =
the
decompression path might produce this? The zstd code just does a

    out_buf =3D vzalloc(out_size);

which will trigger a WARN but still return NULL.

That said, I doubt any valid firmware will be just a compressed empty file.

Best,
Gary
