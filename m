Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795704846;
	b=kKfAYppF1qXU3MihRzbFFrkFDrRkltR/WjSrfW5BdrxmmU7ghPefODSfgKjwDtmqfZuT
	 NPrKn0gfz0GeVt/dGq6xT+COTTMrzkElBro19XZKGx9Vx5O3BJB6hUfGFFMdBDFkeqkXQ
	 9ZdxRsMH8iVqlWaf2Vi8ZPjYCMgj6qccUT1lnWFoOviUrK54bFKO40N9XU7kPImGL+wxc
	 TgH9bbIjBOJq54DVPgmN0Kzt+J9hP068TYujeEgTfXvQbzYb4Kva2iQcpjr1Ffgr+DTAQ
	 RaEpjAjMr8MBkiyHOABB94N5HDn6dUsyKVl+W+lP31sYdQ67s2lfl8e4V6pA8CHW2wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704846;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=PxW5Ip6bnn1HXQbQQkJY2bKdBlffOqurPbvGujLUmSs=;
	b=oWwuTBg35Qz3PrVxpv0brkjF2Dsi1EuQj6ogDKYtY+ZfdR8nUq/wmISrVkeQc6gmZB2v
	 NACU6RGnW5LBHHfHZdJI0xVJbvMgusdFJxXT6DYcut6sJdEONdYply9rqn0YKYoaM3Dr2
	 HDUO6AG7HORkDE3acERWkZhbq1uEVY+9DHUM9/rqlq3IrY8wHVyIvH2jICU5oL1sdi9UF
	 b1IjuFIGLaPDFXII2RWfTyIlMst6tdk9pinihHPle0aj8wspb8F74eBUEZlsfRrIdqMnG
	 8Ww5aB/1tq8O65RGiHfX0138/h4FWaYfy2ObWpiXZow33sGisoObwSYIQidaiBQsWzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=ZVjNDYgP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.78
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022078.outbound.protection.outlook.com [52.101.96.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E0606A321;
	Thu, 26 Nov 2026 14:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 937E0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=ZVjNDYgP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVY5y1l3BU9KYO0JPLWudDqf6nZL7PaHQ4YPqJlwma4daJ9SHNX//H8d67xFvXMyYt5mPjQhkR1cTFweE9ibRhAp9z4KhtU8iFC6D+gFQsT7jvpW01SWbVSn0ECRFzT8gfkulrw9A5uJVuh+N8ZBpTovNlkkNnL02qxG7k9FkrSLAXzJaV9Sxb3/4vjw2/Rc6bIP4X2EkuHHt60Q1yF35PH6N3mU2Jb4P2SG3aCab4pfOgLwHdwzSQqvrZr9DwtobuNanNO9AJZ5kORi9pQxrf2mnO/ytySx2bwy+gSUuUD1j+5kdHck7NSIWTi9Bv3Z62h47DE4L2TmTOY6kb00KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxW5Ip6bnn1HXQbQQkJY2bKdBlffOqurPbvGujLUmSs=;
 b=muiyqyvuqbYls3gQlt/5yQ/40WTUSUstxo+8nLekS5DtEvR07XWfa09fRF4e3xQKLdIpdTEVsdLU4xniWL7ri+bEcTKnU9j0b98XfrI6otpw+rt8/9Vp5Ec0WLpFNV+sqRaSdQvK/i4660i8ehZrU+a3oMxUcE0qE3sxU1pWrnqIRWxgzwUriEVpWhAYtAfshXcyCvaleVmmsh5QiYc486plBpfaAXiDIC86IyeTIzF3+PfiWBqZ9N/I7F6Tm5p/V4gMPZ6ttkhc8g1pUPPkdvZm1JMOJzRDyqfxbq5zY/5hfrOCXBWdlwxeB2PfBNbt6lL6s17t39dBnx93DRoACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxW5Ip6bnn1HXQbQQkJY2bKdBlffOqurPbvGujLUmSs=;
 b=ZVjNDYgPRBqB2cIID6BYTv0Nkmvx1OU8YYLJGmBKr3S6Pt6JpvfhBR8d71m4izZz1oQbmIF2zj1HToiv/orhw5mDmlceAHjLPR26xfST81GapgfDUekY4QUV8bwHf/xv3j+pMTrKXXUFK8eArMBLnmHRG+Lwcrv3sHhnAPAuRok=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO6P265MB6825.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:327::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 14:54:00 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:54:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 14:53:59 +0000
Message-Id: <DN588MZEFFDT.2Y4U95SAKPKUK@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: init: clean Rust 1.102.0's
 `clippy::large_unopt_stack_frames` lint
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <ojeda@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261126131456.87524-1-ojeda@kernel.org>
In-Reply-To: <20261126131456.87524-1-ojeda@kernel.org>
X-ClientProxiedBy: LO4P123CA0497.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::16) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO6P265MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 256e9697-9e3d-4fb2-64c7-08df4bcd1afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|23010399003|7416014|376014|261102123227099003|56012099006|10067099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003|261028144727099003|261009223327099003|261009220027099003|261009223027099003|261009221727099003|261009221227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DGKdUKIHGY5fb0h2dn53/e2nU5np6uSQeqUji4YKv0l3pjQxwcq9cW+4Db5MsVIE4HMDGnBIC+eaSVE5KDxI49g3P2/ioQmUPe/2TwcMng861lNTWOLam7fIRyaFgpN1ZUjl5sG9Hu7wUYUFvIuwRgnXaW75lsAyZL/lg749JLeBZQ4pOJqs9/cgMwPVhjYfhfOxFRjf09H9B18JLfJXBjUq2Py5BO6S80skK+OGl4/L6wnqPH3CqlAxDQCLCLeQbuK4c9HsGWbdGGUpECKkZ+g5wIYGHtjzKD9ADNPESktGdAe/7Vnhc1bhVnqcEbtgGFj8oymi99Htl8Z/ZDDI323thS8xSN5VrxDs9B07JYfsGhlNWECw6H4eRR1DPChHM4S/0bUuMGHylkPvI61A7f2jZTfS/FY124h6VGpgScybNGC+NB92y9N+k0j0F9G9anMPKsNLCZEmKKJJTT3e5lTVH9XaDhXSLyEdRL4YXZv3EEaCJrXaONBCbMoy1S5PkHQ9wtt/Lxr0iBMOhqzcd6lYenIC0SZI6PqG8+NYCrrsyeQQj9bTZxbbmtlTrw4MmViTNRidtXNRpzfy2jG/QB+glAV6rnTOrLacNYepywU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(7416014)(376014)(261102123227099003)(56012099006)(10067099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261009223327099003)(261009220027099003)(261009223027099003)(261009221727099003)(261009221227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YS96TTRFelpsVTVmSnRpL01ibnd0Z1RyekZ0a2VoQWNWL0k1V2tkdGlIQWhk?=
 =?utf-8?B?K2NFSFoxTmJ2cWkrcXRUbzdUYnZUVkQ0a0hqYTBNWklYeUF2aFBSa0FScW5B?=
 =?utf-8?B?Q1UwYnpJQ0xFRXFvSUovbTRDYW9hL0Z4V3JsK1gwT28wOU81UzQwOXh1bFky?=
 =?utf-8?B?d3E0WTd0ZnU4Nkx6ZXdSZmgzdGtlZC9RVjAvemROTU1wN29NT2xTNXdZL1Ra?=
 =?utf-8?B?b3MwYmJWdmxUVmdPNG94REpSNkc0RDJVVkVSN1EwamU1Z0wrWitML2xCUkJ3?=
 =?utf-8?B?cmFHeUhRenBKbzhZcUR4bzNHTGhEU2U4MnRYN2VZWXpqMVhuK3BkR0drZTVs?=
 =?utf-8?B?VEhvRGNiNC9WTkYvb2JNdnFKeHNvL3UrdW1oa0NZOW5TeUtsRXhhdk9IS04z?=
 =?utf-8?B?MkhRTjhQSTlwdS9EWk9rK1VaNVdlUU5XQ3RnT2RuMW1pUHRzSWNuOWFzMkNs?=
 =?utf-8?B?VEUzektwOXF3d2ZWbkxmZytrYStjVHZtMnBING15Szhsb1NRQm9OMEdHbVBj?=
 =?utf-8?B?MTdXSFBJRFJzSFZPb2JWajQvYzFwaVNFanFuN2VvMkl2RWV6MFd6MnFnZGJE?=
 =?utf-8?B?TmFSN0JpWHV1YmMxQnZUdjNZaGpVelYyaGczY2dhWHJNcVozaFJ3VHgwUUgy?=
 =?utf-8?B?c0VobldqajRnR2t6VTRnVnpjS2xUODFyUFpCelVOdlpLZTVaQUdmMVVZQ1hU?=
 =?utf-8?B?aVRqbW5wWHlCczBZRm5GMmtUR1N3YmlwNlRKUmx0Vkx1RU1NbG5sR1NqRWpq?=
 =?utf-8?B?MldzRDlGVEl0RlozaVBWYnNvRzZHaWNET3prMzJMcDhKTUdmNG92UmdzZkR0?=
 =?utf-8?B?b2F0ZkphTUw2bVJXTDczcHRrd2hMdzBGRXl1d0l5b0U2UHVITndrd0g2SjBl?=
 =?utf-8?B?TGFmMmpDRnUyYUpvWVBIb1liajVRY2hsMzhxSWY2Y1k2RHJvVy9tS3p0TVVi?=
 =?utf-8?B?akFvR0orNUNTd2gvMmkvdkVTS0dMZnRtdDZQNnJLT1NzNDVtQjRNa2YyeUJt?=
 =?utf-8?B?OGs3L0dYL1d6alY4c01oU0kwQlAxSHJWNC9Jdy96TTJXaUpFOGNoU0x4bEx6?=
 =?utf-8?B?ZDQvcmtYRGMrZnp2RmJ5TkhiM1V2SFc2NlVpUjA5dlp4RjlONmJzS2JhQnJj?=
 =?utf-8?B?MkVMemNmOS9OSkFha0kwNTNxTTJEVExsNGFLdmFpMCt3NzU4MmJFVHZTTXo5?=
 =?utf-8?B?cUk3TmpaL2lFTlorSEZreVN1QTFFdXJ2KzN0OUNGR0tFQysycjR3cWZIMHFG?=
 =?utf-8?B?VmJIR1VFT3hUcXdxY093S2RwSlB2R1JkQkNUbEx3azhGVE8zbldMeERPRmxa?=
 =?utf-8?B?Rm91cjVDR0x3V0dyWitMd0hQOVpQYmNLQ2NVQzAyRW1oQzQ5ZDJUQTlSSVpJ?=
 =?utf-8?B?aHJyc1Z0dnIzbWVBQzE5eTJOOHhFbkRLRWoyTzk3WDlEa1dMNHQrNEk5Y010?=
 =?utf-8?B?SGlGM3Y5SDgxb095eE1SdjZoS0pNNzJiV1lXYzBKZC9sVUZUZEt2eXVqNWVk?=
 =?utf-8?B?RnFBR0dZb1VWb2QwS1c4bThmN2FMdFczV2JncTQwZXhYMWpRVEozek9nVDFr?=
 =?utf-8?B?VXJDeU1jaGhhTXNRa0FCWUhFZlBhWTF0VWRmc3lObTk5TnBXMG9KUHViQk11?=
 =?utf-8?B?ZlNGbitrNWlmSTV5MC9VRjU0RDlYYkh0VGpKREVpWE0xQ3dEYlZScnNCazdL?=
 =?utf-8?B?UDVaYnEzRGFFWUZZRTI3TXpwSDdsSy9vUUp0OEVyUEt4alRTaCtZZjZFUU4x?=
 =?utf-8?B?TWI5RER3Q1RPdkFsWDUvWEUyZE53Q21qcXp3czdsRUhzY2RKNW9hN2l3bWJL?=
 =?utf-8?B?dlIxVkdJdWRDSUZDTExWSFhEWFJTb21EbElXY0JNRWpaV2NCVENhbythMFU1?=
 =?utf-8?B?KzU0NlFuUERpUWxvdVhyMGJIQXgyYlFUSUxHVmdaeEYwODlScXJUbWd5MzdD?=
 =?utf-8?B?OWJZclJLaGlkNXFEYkRJZXhLdU5KRHo5ekM2d0ZncFArSkxLUjF6bkJuaTFz?=
 =?utf-8?B?dnBldmY0VHVxMDBHK3BCeGJLejN5SW5NZGV2Y25YeHUyRGt3NjJpOWpIMkZt?=
 =?utf-8?B?YnZGYkpyREk5M1VORGlpYlYrYlR4R2NZa3paQWVLcFZMd1RnNWd6aGZ0bWV5?=
 =?utf-8?B?OHMzVzdxTVEwTGpMUFFmaGxBaW1EUEpjUWVDNjVTc2pxQ0U1aGZOdUpUcFls?=
 =?utf-8?B?SzNPZ0FqNVo1bUxlcjBSRHQ3dno2bXpvdVZmdG95YmwvRVZwTkUwRzBRWVFJ?=
 =?utf-8?B?Q3MxR0ZZYjVPeW8yRDNsazVWK3lXNEpKRFJhWlJ3M21VRmZkTllMdWpReEVu?=
 =?utf-8?B?WmtlTnI4VEtpSmN6Y1JPbUlOZDVJUHBFanFFT1l5aUVucW5vZUpJZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 256e9697-9e3d-4fb2-64c7-08df4bcd1afd
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:54:00.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1r4xtTE71LqJVtMJWH2snWC3euXnzN1uXUBOGz0yDRWEYs+FbLTqyo1guUhQePfu3EuhxFfmmgPBeLfbmvHH3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6825

On Thu Nov 26, 2026 at 1:14 PM GMT, Miguel Ojeda wrote:
> Starting with Rust 1.102.0 (expected 2027-02-04), Clippy renames the
> `large_stack_frames` lint to `large_unopt_stack_frames` and moves it to
> `suspicious` from `nursery` [1], and thus we start to see it in the
> examples of `try_init!` and `try_pin_init!`:
>
>     warning: closure generated by this macro may allocate a lot of stack =
space
>         --> rust/doctests_kernel_generated.rs:6716:9
>          |
>     6716 | /         try_init!(Self {
>     6717 | |             big: KBox::init(init_zeroed(), GFP_KERNEL)?,
>     6718 | |             small: [0; 1024 * 1024],
>     6719 | |         }? Error)
>          | |_________________^
>          |
>          =3D help: for further information visit https://clippy.rust-lang=
.org/main/index.html#large_unopt_stack_frames
>          =3D note: `-W clippy::large-unopt-stack-frames` implied by `-W c=
lippy::all`
>          =3D help: to override `-W clippy::all` add `#[allow(clippy::larg=
e_unopt_stack_frames)]`
>
> The 1 MiB array is initialized by value, thus the closure that is
> generated would need to hold it in its stack frame (without optimizations=
,
> which is what the lint goes by).
>
> Thus initialize it in place instead.
>
> Note that the warning only goes away together with commit 5a2024c03eb6
> ("rust: pin-init: internal: allow `clippy::large_unopt_stack_frames`").
>
> Cc: stable@vger.kernel.org # 6.12.x (Rust is pinned in older LTSs)
> Link: https://github.com/rust-lang/rust-clippy/pull/17749 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/init.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 1fdc3963e3e3..238ebb3b1a71 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -211,7 +211,7 @@ fn init<E>(init: impl Init<T, E>, flags: Flags) -> er=
ror::Result<Self>
>  ///     fn new() -> impl Init<Self, Error> {
>  ///         try_init!(Self {
>  ///             big: KBox::init(init_zeroed(), GFP_KERNEL)?,
> -///             small: [0; 1024 * 1024],
> +///             small <- init_zeroed(),

Given this is called "small", would it make more sense to just change the s=
ize
to, say, 128 and keep the stack init?

Actually, I wonder if we should do:

    big: [u8; 1024 * 1024],
    small: [u8; 128],

and then

    Self {
        big <- init_zeroed(),
        small: [0; 128],
    }

So we demonstrate both big and small init without extra allocation.

Best,
Gary

>  ///         }? Error)
>  ///     }
>  /// }
> @@ -263,7 +263,7 @@ macro_rules! try_init {
>  ///     fn new() -> impl PinInit<Self, Error> {
>  ///         try_pin_init!(Self {
>  ///             big: KBox::init(init_zeroed(), GFP_KERNEL)?,
> -///             small: [0; 1024 * 1024],
> +///             small <- init_zeroed(),
>  ///             ptr: core::ptr::null_mut(),
>  ///         }? Error)
>  ///     }
>
> base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f


