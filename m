Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021130.outbound.protection.outlook.com [52.101.100.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82D3E316B;
	Thu, 25 Jun 2026 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399074; cv=fail; b=CmMklpPhsjgw5kxwp96s9GcjRN3/6KcffWK5DxNyYlxDSPwXvV2sPGbxinYXE32morMhc0Q5ROw146BWNzTUNMp6qR7+BU4AVUXNiL+eJTMQJrgzic7Dy8E2B38nbiUtCmjcWo2qET6MF4T5/bUMOwGL1O1sHVG2/FcyituqMs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399074; c=relaxed/simple;
	bh=CvaTpUBtkiuvd1AYvmuckyQRSX1lbHJb6i4WqC0fPS0=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=ovNGJ3SiR+5ddfNq6260HWnPtdfmXNKl+HnyKLKGUUDiAg3masg58wB4JVxxEkq1Ph/PQrtAdlVfv4Hfoyv6NoyOJvr2jAWjY3Izo3Z40n5abj2D6onpWzpTZyIXk64h/4WGuOHugShCGiaPjSi2NHuiRr+5CgED8tBjBvn5TqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=DQxjU4Ki; arc=fail smtp.client-ip=52.101.100.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="DQxjU4Ki"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBm6PZR2LLGEshZUiFXb7IQFnhryGz4B3BeBrO5gw0HgTxuXKwhXsmfO04KGOR0gvwbFs4jcD4T3vEqn1QVeyuzUU+WJYsF0cVbeYl1zhSVVDUUoRxwtOFxY+6CFgNHqFniYMS2G5kOVCtJydKnpFHa+yV2ceR+aTWKN232rSwhrhpHnM6HgK19h9+ljmAXibjW/UX3H15qTEMEtazaG1DiVst2nqvYLvF3P8jMv3bJ93C4scl76Mqpn/rtHr1HyBwXPfGPkZQkusafUXmJY2577BrpRE0aJz1/zPuzI/hSws+L5nhQx/R6GDUB/vhJM0iYQVxXGrv9SguCsdJBWDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TL5OeIKPlATiM+CDJs7KD8oUz2zj/gcSJKIMAdUDE9U=;
 b=geO95pOERPZSL02GfY5UgRaUkuGkPP59IbJrZ5NC+KbgzLqQ+kL5WR9fMOeT6WMvYIaYGyG6SHRLpqX2E4PkK4fLLHDF7/sU+bjbkvCJFPECrgMgv2+eGF51trH6HsF40kWjnwFONXseTuqAR1+ZfmdbL1q9/vVdHvSDA4jl2HtjMWcvYlpE7+2sUhcUaFPINYXkX1t3ExlSS1BeyKVlBnqBWCpCeWzNaNFOBlGGGgO6q0cKdz2qSw3Axr2UmMTF/nRrJJ6wBVgeeaqexswF0U6W8xoBd2fnRK2/9sUfMI7611FWPn2BZVrOYFxqPv28P/HdlKh7dh02CDJs3OofBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL5OeIKPlATiM+CDJs7KD8oUz2zj/gcSJKIMAdUDE9U=;
 b=DQxjU4Kie32s7taz0Agry6dmLmsNGqbciGWwtdrJ6sH9jJWuMKtVzHcqO5kIMt4s6KAeX5nt9i6oS7FOlSo8AtEkPFdmCrHgJcALSiLluwqcr7EKgmNTEYwXf3I4gaMQVYQAnqoGbvzy27quKMtnFFtMPm710bkBGbcqz2A1sVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3618.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 14:51:06 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 14:51:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 15:51:05 +0100
Message-Id: <DJI7QIWNZL9K.1Z49I1QZIBIOA@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <acourbot@nvidia.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <lyude@redhat.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <stable@vger.kernel.org>,
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 01/16] rust: drm: ioctl: fix unbounded lifetimes in
 ioctl handler arguments
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-2-dakr@kernel.org>
In-Reply-To: <20260620184924.2247517-2-dakr@kernel.org>
X-ClientProxiedBy: LO6P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3618:EE_
X-MS-Office365-Filtering-Correlation-Id: 381fef89-970b-4fb1-cc51-08ded2c92fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|7416014|376014|921020|6133799003|3023799007|18002099003|22082099003|56012099006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	a+4ykgA48zgirTiFv1ZNtX1Tiw8oM7+BYL2/G0P1H0mRoRuWoAKwqa3Eah13tBU2uSwrCQ1kLkYRjHEKIW3H6OGqAztbmx62KgSxN5UryF9Wot2SeC6VBdAKFGYDepcqFiq3jMqPmZ+w8eRAny7qj53BeZgqcsUKv+sgxc2eFsB7BmKBvNpRkN10H/T6I4brB3jupgqftNjwGx2sJ2eqHxQgS0yjsO67gzyJp38EG2BqFYOnIEUJd6ZxE5up+N++d1cDKz4s3IsD5n/Ft1YwRAaf37zu1GmXrdfqZUG50LDPqStZ1ROF/D5H/Ge+OJmmqcG7pvTPs4M8ZLyAjkMYd58gfMr1/njXhPwJYftrEcpclpKB9JWgurFRaUCPoYYvdIpgUCU2yua3QpzSuO77NHS8bA+ed5KKsPbf/pAYUZx4oM3hWD45EM/ttlgUBa8CRLPgZt1r/Uvgsl0msaqVf3/RlBzRT7EL2a4FZ8a1zA23TDUl7o/9us5aNKWbxq3LNZebGzhBWpdIYfku83dIuI7WkDgvw80Qdn03x96yMulkihfCzWiV+nRoB3o5ukW5v9uGjqXoC89jEr7NYRe4enE4NWs6A7TcvshPQU3innTSDLRaUVeqZhbtMRqkFGHnagRKioFciEnKMeUSxzeG+UbzehIDDoCiLknntrMil73lgE3HD/GYFZ0lWD2hRRv32WyvDxTTNRRUEdDmwR8RrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(7416014)(376014)(921020)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(5023799004)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEdjeUtOTzBHbHhKR1hERXZnYmVKTVlzR2dsa0pPdWxodEdpUFE2aXNPaUNj?=
 =?utf-8?B?WWxDQTFRaEpSQVByVEdWL3Mzc1dqWjA4UzJpOGVYZFRyODQ0c2xLVTd1QmFi?=
 =?utf-8?B?Qk5VLzVNVmZHVFVpVXpZMS9ITFNnZjBFRTBzbjJCOEltZFNNN0tvRERxTmIy?=
 =?utf-8?B?aDIrNDlyOU4wRmhwb1VrZ3o3UzZ4b3JZc1BVS0dkeXREaFpINnRiWm03TkhS?=
 =?utf-8?B?TkNibUY3Y0F6YUYxRldZYlNCczFDREdGeUxaQVdGK08rb2JOT1FEcS9aR1dD?=
 =?utf-8?B?bDAxYWxQSVQwWUwzNFlWelg0aDg0b2pSUE95ZVZkNi9HdDJSbS9MOWhpdHJ2?=
 =?utf-8?B?djhJSmFLcld1YVZxaHFEZTBRRmVobGtYQmJVNElMRmlpbEtVbWU2RU1JNmh6?=
 =?utf-8?B?VnJpMEZYNVdtZC9WbTZQY1hyYXh4aUtHSzJuUWxwT3c5VkZJSFkzTkgvN0E3?=
 =?utf-8?B?MnN6bU9keUtBVSswRmtYVTNCU3hGdWlTUGdkK3dxQnhiOHp3clhadVZibXRM?=
 =?utf-8?B?SVlSV2NoczdwdThPMkFSOTVMMmZSU1djU2ZDQnY4T0Nha0taYTAvcFpka2l1?=
 =?utf-8?B?Vzcyc0tVcXJlTDFiMDZLb3VFOFhyNGZSa0ZTUWllL09UbTRnNUVGTC9hUEdI?=
 =?utf-8?B?WkswRGlMYVhTOFVSQVY4bWc4VEJGZWJ4dFlDZVIrcTR1d1lyYkloK0lGVHpF?=
 =?utf-8?B?Qk1zUXZ3UnQ5aWVyNjMveXFFN3hhaENEUnl6YVRnelQvVDhlbzMyY3haeTJR?=
 =?utf-8?B?M0ZUaG5xRGRoT0lVQnlZcU9YcEV5NE12aXJ3NkFINFVSeE5VWFNpT05DNER1?=
 =?utf-8?B?U0ZTYm5yUHgxNm1wUmlka0o2S1BaRGRDSXBrWUcxa0V0U2c2UkFoL05RYVZn?=
 =?utf-8?B?NjBzejBpSm1HVmZDeTZnOFVOTFFZa0VRZUV4VFRzeVBjcWZROXpUOGwzc1lk?=
 =?utf-8?B?aVFnMzkxWDZIY0dySVNKWDkrNFVjeUFET3c5MHJ2OGMybnlkYmkwV3ZrZjc2?=
 =?utf-8?B?ckFVeFcwMXZ3MGFqNk9Edk96cFBxTXVlcW5UR0ZWcitKblppa3BTSVZHU3Zj?=
 =?utf-8?B?ZmFaV3d4a0ZpdmZqWGlpOTN3dDZzSVlUWW1DR0Jpb2hqRzVPcldJSTNkWkxH?=
 =?utf-8?B?TFloNCtManA5OHZFUUNnWlErTjd1WlFCckNvYk4wTXk2TUt3ZDNYbzBQTFRx?=
 =?utf-8?B?R3FZUTFpVFFzdytxd0tOQW0weGt5VVFUdHVsVFJaQmtFVkFDU2RqOUR0SnA1?=
 =?utf-8?B?N0M4T3ZFQlBaajkyM0RFY1ZxOEFYV3BQTEQydm81WDY2eU9xUVU2VXBlL2FB?=
 =?utf-8?B?UnFVek04ck5mQW9ISUg2aTM5YXRSSXJwbU1OcU5nSkNoQnhNWlh5VWhRL0ZE?=
 =?utf-8?B?bWhmaTAyOEdVRjQ5UmxhV25zVU1Db0htRFZyRzdlYkRKeTRwWVgzNzdGV1Z0?=
 =?utf-8?B?WWdOKzZKUXZraDJNNTFTc3NiOVA5OU5PcUI1alQzdmtMdytDODI2Z2FXR1Rn?=
 =?utf-8?B?VDQ1dHNCUlE2SC8vM0RveXc1UUlCcGlKMUNvTTBaZ1E5MFZxbHNES1kzUksy?=
 =?utf-8?B?QTBLT1lMWXp5Y3V1clUrQk0xZ0theXdaQjJaVlRNY1Ryem5CMjVQODlzeTNM?=
 =?utf-8?B?dy9FVWQ3by93VVlxODF4c0h2cmN6QWJiT3hCZ2tNUE9OTE41eHRDTFNFVFJn?=
 =?utf-8?B?M0picXJ1WWE0Zk9ZUnp6SGZyYi82U0hrYXh5QkdqenZ0NVI0QUtwb1lpbkVM?=
 =?utf-8?B?eDVjYXdxK2IxSUVsSFF0Nml6QmRtY0hkL2FvaG92a0xzZW9Uc25uUEg3SGJV?=
 =?utf-8?B?M0xsZlF0RVJqT3NUc2pFNkJFdmV5T2U1Q0lPbVNCRk1LTTJ1dVdhUk5WWjM1?=
 =?utf-8?B?eFJHdDNGcnVCUHB3Mko2bnF4YnVtREoyY3JuMkxESHFEMVBiN3hDaHdYdi9h?=
 =?utf-8?B?YS9kQnA3TUk2MEJMODFNclpYREpwaVA1cytsQmJpUDdOaHlsaXM0WER3aFhl?=
 =?utf-8?B?ekNZRldBY2psWFVlMXBFSjRhZER1L0ErbkRCRDJDZlJ2R3JGT0RBTndrTjEx?=
 =?utf-8?B?VTM5TEo4ZUlIUnp6WEUzd2crOFVFSU95ZmhxNldpdjY3bkhtcjYxbnc1V3VE?=
 =?utf-8?B?Q3o4bmZVV21Bc2d1dk8vUUVwSjRPUDQ1RTBmenFJNlVnWmR6QVA4eFpMeGhy?=
 =?utf-8?B?MjJVSjRiUldWY2tscVRjM25OQzZvbUQrck5sYTNtK2pZQ1FHd0Z4UUZhYTVC?=
 =?utf-8?B?M29GdTA1TS9BQUVCZGQyN2s5T0VxMDF4eVJDaTQvVVVtVVo2UjdVRkZnY1ll?=
 =?utf-8?B?ajhYbHJ6Q28xMGY5aGpPL0xub0dGazFmdjdxTnhDamU2bHo1b05jZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 381fef89-970b-4fb1-cc51-08ded2c92fbb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:51:06.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3bmWIc3rbCG9gIuqBYfkscmfKEh7fYhkQ2goIXgeTVVqp7eL+95d8/6vCw/Vq+bsNsMKdUW04xdnUzA1pV7UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3618

On Sat Jun 20, 2026 at 7:47 PM BST, Danilo Krummrich wrote:
> References to dev, data, and file in the declare_drm_ioctls! macro are
> created via unsafe pointer dereferences, producing unbounded lifetimes.
> If an ioctl handler explicitly annotates its parameters with 'static,
> the compiler accepts this, allowing the handler to stash references that
> outlive the ioctl call.
>
> Fix this by routing all references through a helper function whose
> lifetime parameter 'a is tied to a local anchor variable. Since 'a is
> bounded by the anchor's stack lifetime, handlers can no longer demand
> 'static on any parameter.
>
> Cc: stable@vger.kernel.org
> Fixes: 9a69570682b1 ("rust: drm: ioctl: Add DRM ioctl abstraction")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260620011346.A47D01F000E9@smtp.kern=
el.org/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/drm/ioctl.rs | 59 +++++++++++++++++++++++++++++++---------
>  1 file changed, 46 insertions(+), 13 deletions(-)
>
> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index cf328101dde4..023e6da5c1e4 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
> @@ -70,6 +70,39 @@ pub mod internal {
>      pub use bindings::drm_device;
>      pub use bindings::drm_file;
>      pub use bindings::drm_ioctl_desc;
> +
> +    /// Call an ioctl handler with lifetime-bounded references.
> +    ///
> +    /// The lifetime `'a` is tied to the `_anchor` parameter. This preve=
nts handlers from
> +    /// declaring `'static` on `dev`, `data`, or `file`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `raw_data` must point to a valid, exclusively-owned instance o=
f `Data` for the duration
> +    ///   of the call.
> +    /// - `raw_file` must be a valid pointer to a `struct drm_file`.
> +    #[doc(hidden)]
> +    #[inline(always)]
> +    pub unsafe fn __call_ioctl<
> +        'a,
> +        Dev: 'a,
> +        Data: 'a,
> +        F: super::super::file::DriverFile + 'a,
> +        Ret,
> +    >(
> +        _anchor: &'a (),
> +        dev: &'a Dev,
> +        raw_data: *mut ::core::ffi::c_void,
> +        raw_file: *mut drm_file,
> +        f: impl FnOnce(&'a Dev, &'a mut Data, &'a super::super::File<F>)=
 -> Ret,
> +    ) -> Ret {
> +        // SAFETY: Caller guarantees raw_data points to a valid instance=
 of Data with the correct
> +        // size and alignment, exclusively owned for the duration of the=
 ioctl call.
> +        let data =3D unsafe { &mut *(raw_data.cast::<Data>()) };
> +        // SAFETY: Caller guarantees raw_file is a valid pointer to a `s=
truct drm_file`.
> +        let file =3D unsafe { super::super::File::<F>::from_raw(raw_file=
) };
> +        f(dev, data, file)
> +    }
>  }
> =20
>  /// Declare the DRM ioctls for a driver.
> @@ -135,19 +168,19 @@ macro_rules! declare_drm_ioctls {
>                              // dev/file match the current driver these i=
octls are being declared
>                              // for, and it's not clear how to enforce th=
is within the type system.
>                              let dev =3D $crate::drm::device::Device::fro=
m_raw(raw_dev);
> -                            // SAFETY: The ioctl argument has size `_IOC=
_SIZE(cmd)`, which we
> -                            // asserted above matches the size of this t=
ype, and all bit patterns of
> -                            // UAPI structs must be valid.
> -                            // The `ioctl` argument is exclusively owned=
 by the handler
> -                            // and guaranteed by the C implementation (`=
drm_ioctl()`) to remain
> -                            // valid for the entire lifetime of the refe=
rence taken here.
> -                            // There is no concurrent access or aliasing=
; no other references
> -                            // to this object exist during this call.
> -                            let data =3D unsafe { &mut *(raw_data.cast::=
<$crate::uapi::$struct>()) };
> -                            // SAFETY: This is just the DRM file structu=
re
> -                            let file =3D unsafe { $crate::drm::File::fro=
m_raw(raw_file) };
> -

This could be more simply fixed by just adding

    let _: for<'a> fn(&'a _, &'a mut _, &'a _) -> _ =3D $func;

here.

Best,
Gary

> -                            match $func(dev, data, file) {
> +                            let __anchor =3D ();
> +
> +                            // SAFETY:
> +                            // - The ioctl argument has size `_IOC_SIZE(=
cmd)`, which we asserted
> +                            //   above matches the size of this type, an=
d all bit patterns of UAPI
> +                            //   structs must be valid. The argument is =
exclusively owned by this
> +                            //   handler, guaranteed by `drm_ioctl()` to=
 remain valid for the
> +                            //   duration of the call.
> +                            // - `raw_file` is a valid `struct drm_file`=
 pointer provided by the
> +                            //   DRM core.
> +                            match unsafe { $crate::drm::ioctl::internal:=
:__call_ioctl(
> +                                &__anchor, dev, raw_data, raw_file, $fun=
c,
> +                            ) } {
>                                  Err(e) =3D> e.to_errno(),
>                                  Ok(i) =3D> i.try_into()
>                                              .unwrap_or($crate::error::co=
de::ERANGE.to_errno()),


