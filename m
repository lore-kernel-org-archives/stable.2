Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020103.outbound.protection.outlook.com [52.101.195.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6794192F1;
	Fri,  5 Jun 2026 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651708; cv=fail; b=TcwPXlQVrdFRWYZ1XotBKoxKdk7WHaImdRSW8XtNFjl9plHHdda572OIFSqggVQiCQkbyJWIGJ0byhnARz0khlfqu4lzrgsrB7txaOI5n3g8QLsZjXI86juepOQrvDNRjhgtqA9DQJSRNW0/sEEqk14n5onW2rL1J2BwArasTbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651708; c=relaxed/simple;
	bh=E2uvcotJMV4KxZNqYzp/GfqQIhsxVBGfcdirIIMLpw8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=lTLfyFfhyqdcLiyaTaHTdiRf7FL+jQ3ilVvO2ro5gNaxuS7V1R1hWrFWGsCnnbTj+ddh0ma3Ad7V+YpczUV3iP/bYwjrPo80jP4AYcjp7hXobuUANOzEpEhz/jeCF93xXqX43KuMgcLF65aS4XCa+WAegrdr4gNK82oBkDludco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=eHYFEZeM; arc=fail smtp.client-ip=52.101.195.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="eHYFEZeM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj75eSpqoCZqkrNHp58XnXbO2KO//uUBbljU565BfJJsoIwwRQkLN6ZIbxwpCEAElzEgoYSL6ex0Z0jH9dAZhRMs9VV3RBRByNDA9tJSzuQr9T+WRxxDdmL7NDy322Ke4UnaqhAmUEhzRu7NV9fZLiXGBkEzZfxLExd5btxDyD/AnI/NlXFWrDqMrIO7m+k8jWNiSjQOPgfUTVgMyLLSTytq46CYlTulOpBSO7pZooR7LPAWYgrV0bPCv2eyrZrHN67akqkJxxnYEqRm7E4xbq4gUTQrwSiACHqQNW2UdOt9DCu8cqukkL9D63GYUTfbMaq20WAiaDh6j354usRAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ncXLTIyBcKaMm+fGYQxphJvebVpb6auBEBYbM9QW+4=;
 b=AvgdQ18Ek0QKqhgEEsdCPZZsOsi3SMqvxuy4bYsLXwFBE2XGERJNA8laafBEG1snfhNowCZVAB2rVMPMLf9Pwnqu1h1GfLvEG62vg+1ekd1JcGXh9O0VeVIgHxEXGozi4U68A21kELTPP5YLlBb16n6WgdDAS//UVSy2g8EWwR4gt2pg8lBttVQ9TOcigsiXb7UO6Mibd/HEbVF7+npEONrjxaKTwY1NIeANukOAjxf+n3mH+U5ZYHJxVJVTI8LZiJ2biNQfv96ULyr9uP8TWTJWH949tGwVeDe8i34rsAzKxbjLWMfXel8zKVEXpLmyrBpHUZqV9iwN7Aa7n1ZWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ncXLTIyBcKaMm+fGYQxphJvebVpb6auBEBYbM9QW+4=;
 b=eHYFEZeMdXu10n1mFBtlyuHI7xX+htqa+cqVOSqs67O6p4De4x9Km0dcqmfPw2ZtfrMgzXRhpnqexKSb+RI78xcBTznNf5586pwVMNOJ9PCbFEAWJd7VW4SgQ5qrOheQvU2GU5Bu+B4PS1nQDPjr37/x8bl1pD+QxUXmIE3u2NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7624.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 09:28:23 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 09:28:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 10:28:22 +0100
Message-Id: <DJ10CJ31GS5I.1ZD6WPPWGZTQN@garyguo.net>
Cc: "Yuan Tan" <ytan089@ucr.edu>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <zhiyunq@cs.ucr.edu>, <ardalan@uci.edu>,
 <pgovind2@uci.edu>, <dzueck@uci.edu>, <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: firmware: return empty slice for zero-size
 firmware
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260605041134.38290-1-ytan089@ucr.edu>
 <20260605071104.135675-1-work@onurozkan.dev>
 <DJ0YRJ6MHAU7.WVR4P2MQ4HIX@garyguo.net>
 <20260605091632.313084-1-work@onurozkan.dev>
In-Reply-To: <20260605091632.313084-1-work@onurozkan.dev>
X-ClientProxiedBy: LO4P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 181ad80a-251b-468d-9dad-08dec2e4c9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|4143699003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5eGOoRhOYSAHoAZzxqL4yLHwhX00peesxFMPQEfhH/6pz47f2DszmEvQj2pLHn9HPwk2aqfyCMWudnioiGdex6Jjd4pEZ8UoKxpwgcp1iNvI4Uj/0Myby2vBZ0oGtVgB/rGM88Tf0x8vOQDeyk8WjMU8I7VTFx84Kk4diSpytRk5Sknw1qbduKYFpmtDIofK4J2IHcg3XBFr7UsOE1U9Yg7ALsaPX69Cs3B1MsFXHBUC1wxVPCo1qGFifJbPJFNMRYnwCSy0FuLYHM9Ri3zJNotZmYYyVXa+UMT1uGDQ6ITt+lLPyu98GtFz1SEkqq0ND6KjdnZQ82LPlfcISaiXVnpRriJBqOy63C2TWZE1lRyH+V/pkhtBBhKV3UEYQqM+DYowpkEMg09zcIf+f8l4PaSml1UPIu6Y6JwLqpyKEiNafeFdZFq9L3UPviwNih/dTBeilNFHISNmov39KidkVQrg4AsBmi63NBvRHtIoksDc/O9fgXMCq7szhbdiX6ZfaTFylY1vJrO4QS1J4hT770LtbTwdLjmcb9VjNOHUc9B3DLFbAuFqDbLS7M5QEjbR8xro0gQMysq1NeCbMtBGF7ZVQj7QTrQCSxTEU/9rEXb2pvHAAO/GG366xKsmpXynnJ5AsZykwLgqPNVn8XQ2RpPfJWpmouo9QApczhFWlC5kB6p1QFaXfsqPjQnZ9Lgg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzQ1UnI2cC9mMklYUmVacm5sdDJiVmNBVW5YV2V4YVZMVDg2ODJMemZhYjVO?=
 =?utf-8?B?VHo5SlF3NEJFSEI1ZnBMYnFpVVRnOUZ4bjZaZTc0enNHZXFvNjJBUUU1K0xZ?=
 =?utf-8?B?bnZMU2dXT2R5eXozZk9SbkhkeWdkdU5teW1Qc2R5aWpKYTdZbXdJcm1uUzRC?=
 =?utf-8?B?VjRWakhzSGF2Zno0ek5JZmNOMWpQSVZPUE9QQVBpTDlmbzF2Y2dLYmZ4WDR4?=
 =?utf-8?B?M05OWVZpNXpXWnVFYWJBNkl2OVBvVmh5YWVYQ1lCYnRGWTgwVks5QmUvRDNy?=
 =?utf-8?B?K0pKUFhVWjZmenVQWFkxa3lHZ2h6eFdCZzB4c3IvMzhXUHBJY2lnaHl6ODE0?=
 =?utf-8?B?Yjd4dWwwRmtPMFd6b0E5d2dxbDJQMm1HbUpsL0x3WHZKVFlJa2FXRXVpZTFm?=
 =?utf-8?B?Ry9ZRnVDTzlFQkVMbnFWYlhXZ3JRZ1hhMzZSSFZ4TXI2Q2VWR0VxUGpBdkJQ?=
 =?utf-8?B?Z0F1YUhnTnFDeUdOZDNiNk5GY0pWYklQdmtCL3Z3VzBRL0NEVm1VRVlmclgz?=
 =?utf-8?B?M2t3R2hYbHo5RmRRRTdCYXRwU0o5aVh4WnViOVJ0VG1kZ1UwazRtZDB4S05h?=
 =?utf-8?B?SlF2azVMMjNRZ3Ntd0ZHTUR0eno2Wlg2OWV0VlVpRlRWTldCUE95c1ZFZzBz?=
 =?utf-8?B?WlMzVXRuaTNNRHBiVWJKM3hFZmJkZGNNRW8vUzRvYlduZDc3b2hIa0xiNTBD?=
 =?utf-8?B?QlFPcXJsdC8wckh3dTRnOWpLbHdjZUZLMHdnSld1NDZkTlUvbGVLZjdlOWtt?=
 =?utf-8?B?RU9SN0NvZlROWE9NWFFOeTI2azREaFdyendmTHE2bzR2K2tYRk9BMUVzbXl3?=
 =?utf-8?B?NmowS3FUZS9JeHJvR1oyQjN0V0ZLbnFoUTM2UkloSFpGN0pKejBkQytBS2dj?=
 =?utf-8?B?czVpa3VJbUdVaGlKY2UrK3FkSkJEby9vbEZIUUFwYktxS3VSNWQzQldubHk3?=
 =?utf-8?B?UzR3Ri9obEw5MENKMGhxKy8xVmh6VUlMcXNDaHJSY0RKNW8rSS8za2FKb0lv?=
 =?utf-8?B?cTY5K0RsN2tncUoySjQ5dStqTmNobDRxVGQ4akIwQk8xVUNhRytLU29NTnZx?=
 =?utf-8?B?VHNFSFlnQXN1R0hIZjR1NThON2FUZ2paYmJMWmFTcWZuN1FrYVlZQjM2czRU?=
 =?utf-8?B?ck9ERnhIbElCRU45YUhjMU8xZ0Urc1lTUVI1ZTUzQkQxZzhqTEUrNHRVQUc4?=
 =?utf-8?B?bmFoWU01MFVMUlE2RmlVY01VZWd5NlIxY3V1ZnE2Q20yZWY5RXhLOVVrbEdV?=
 =?utf-8?B?bFhkNHRPRHAvamVGVFFUQlZqdU5Wd3ZkSElkY2VFTVFGRDgrVG9KKzFoT25W?=
 =?utf-8?B?R3J6bVlrV1cyUkVjQkJXa0ZFMGtqRGtNVjlROSt2enZVcGdRbnhKR214QlpH?=
 =?utf-8?B?cGVWVFdiaG5VaTU3RDBTd0kraGd3SW15Q2JuZmJ1b01RTFZuYmd5OVBHMGFa?=
 =?utf-8?B?SE1yaTZmN2JydWlncXNCNEVyUjhNT3pTVkpCRGt6dG5iSVdLRlpRQkJ3amlY?=
 =?utf-8?B?K3l4bmJRaGhUbzFXZjg3QUIzaXE5SlBoUjB4cEhMM2RnKzlPeEJBNEVPRnR5?=
 =?utf-8?B?dXpCZTZWMmc0Qm5oR0ZBWUk1cXBGaXJ1eTNRa1d2MXNlV3dKOHRxTUdiTGY0?=
 =?utf-8?B?cUJGc25ZVTlldjZ6d0pFZ2F5citiTTVHeTNCaXFOazl3YUlNRm1vV0hUZ25I?=
 =?utf-8?B?SW1FQjRUdzVXcStDeUJVRFJvQmRHc0o3VHlPc25selBMT2J3Q1pTeGk2bnkw?=
 =?utf-8?B?MWlYZTQwQ0RTY0VuRVhlK1Z6OUVxZEZRdllQTU1jSzJQYnc1a1RHS3hONkhT?=
 =?utf-8?B?VTFFaGIyU0QxVkdOcnZ2VEt0NFhyL2pQMkxJRXNUeVBhRWtLR3YyRy9KMHZs?=
 =?utf-8?B?MUZNYjVzejY0VGJCcGRPNjVkQWtIQjFQT3dNOG9keUVCUkJGU3V0aU1VOStO?=
 =?utf-8?B?R05xZ2JiL2tWYXlQSHg0eWdKa3hpclU1b0JCQ00xNGxEcjVEWVV1eHZodVdH?=
 =?utf-8?B?encvNjFPdXdDTitaZXNWVGFzZlhjS0ZCTjlYNFQrTXJwZnJ6OUZ4aHo0Wkoz?=
 =?utf-8?B?T1F5b0ZyQzF4WklLVzZKcFdiUm1FcENST25nU0tpSDFMWDAzR2VrQThzK3ls?=
 =?utf-8?B?NUlVOGVTUk1UM2NyTnFrZGZVenBCUFRPNExVdEpHeC9namROYi8wZWxGaVpN?=
 =?utf-8?B?RmZGTHZYcS9sUjc4d2R4d0h5WUMxK0VSQ21QaFB3NHlOcm5aMmxPNEkxRis1?=
 =?utf-8?B?UHpweWJZREdMcDBQT1YwZ2xKTFpUcWRSbnhQb1hYSFVJT0E5TVhnS2dzVCtr?=
 =?utf-8?Q?k+4dYX3q6HhLl6pPSS?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 181ad80a-251b-468d-9dad-08dec2e4c9e1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:28:22.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aloGLwSeEGv/Y3xVzjQmfjt+N59ftQ8fHkmNl5qMshvkE1ozQbe5d0BErt3vcpLZOeMGwyj1LlVdGdsru7WdYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7624

On Fri Jun 5, 2026 at 10:16 AM BST, Onur =C3=96zkan wrote:
> On Fri, 05 Jun 2026 09:13:55 +0100
> Gary Guo <gary@garyguo.net> wrote:
>
>> On Fri Jun 5, 2026 at 8:10 AM BST, Onur =C3=96zkan wrote:
>> > On Thu, 04 Jun 2026 21:11:34 -0700
>> > Yuan Tan <ytan089@ucr.edu> wrote:
>> >
>> >> Firmware::data() builds a Rust slice with core::slice::from_raw_parts=
().
>> >> Unlike many C APIs, from_raw_parts() requires its pointer argument to=
 be
>> >> non-NULL even when the length is zero.
>> >>=20
>> >> The firmware loader can represent an empty firmware image with size =
=3D=3D 0
>> >
>> >
>> > I haven't checked in detail yet but "empty firmware image with size =
=3D=3D 0"
>> > sounds like an invalid image. Can such an image actually make it all t=
he way
>> > to Firmware::data()? I would be surprised if the loader accepted it.
>>=20
>> `kernel_read_file` will return EINVAL if file is of zero size. But I thi=
nk the
>> decompression path might produce this? The zstd code just does a
>>=20
>>     out_buf =3D vzalloc(out_size);
>>=20
>> which will trigger a WARN but still return NULL.
>
> On NULL, it immediately fails with ENOMEM:
>
> 	out_buf =3D vzalloc(out_size);
> 	if (!out_buf)
> 		return -ENOMEM;
>
> Thanks,
> Onur

Oh right. Arguably the wrong error code, but it does prevent the path from =
being
hit. xz decompression always grow at least 1 page and thus won't hit NULL c=
ase
as well.

So indeed under no paths we will have a sucessful `request_firmware` with
`buffer` is NULL.

Best,
Gary
