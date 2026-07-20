Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E30437134;
	Mon, 20 Jul 2026 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560413; cv=fail; b=ArqEcGPGSwx8vYeU3iLzI24WSsvm4n8OBHZvsx3c+j9RYTao9nAEkDroBTWuQXNUNI53/+f0bnorDNciEe3O+o4hlEaKCD0JGISNs1PVOwsXnmMjSK+5loF5kbBUmbw3BwW4nBIdjC4GR810snz2TtLmdDiyiYNjL7OyVb81K+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560413; c=relaxed/simple;
	bh=JDYe6d6c90IxNpyDXrD6UjSYin+fvhKR2XB2hmLy1ts=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WeIIMy4S2MKFgIVTdKndf/ZRT8TLOQ+XgKONSRwtX2i5BTVlsF7ky/zjAKYXGCDvF+I8PvimRbBvDqKYr1Xkoqi+dh7zxRrEv+60FecXKkvGaKQld4QnmC9oB3y8fYfbyLT25H5yAjWVwTz0yDixMLzKWmB/IKlyJNHGd3t6fPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rX3/5FSS; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="rX3/5FSS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFBuPW6yHPtou9PrIjPfeQyogh+ERev6RE1JNPYDzJBDlxqkE7z8ndJwqsPIC8m3+OA4u/DH7G0RA8ZddxLeqauH9WJ5JDdTi6JFFDYeI4AYgDbXSnzt4k/nab0K/khxynYn13+fzR8aTnMIsoc3SjB4ZNVn2E2NRVAQvOSSaVY8n4BmonQFvS30IbNrHB6iW6sloGk3779yCYyba8HuyNs8+lFjpXYMefe3LDaSDO3tf4vlaVMJtVazFSVn3zFm43Pe9krsr9mOxJuqC08UjrjpYeoGjL5SSEiybYBdSkyf6PZCsCP9Lso4USIclVH95dsCRlAsqwIeUI07lgiOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EappbCdSrZOxaB/hTNRXkvBexZZcOdqQZUj70wBoxkM=;
 b=GEqeF5Kk+W7TXqteD5yhoZjKXJG282+TGvis88KipaJOOaDzOHpXabJbuU1I7sjnX+usJaO1LOLZbDGjwJYRcgceGvmkEi+6r12pfxj1FvvrFndkgAvso5VVS0hY8L5FShohxH9xZT3syXHtMRrf6wtSuBgxt+43XJbR+80iJc1zgPE6q3hi3gORWzVovlbFFn6HQS0gUFAHXw0jCV51rxBv03tFuNcAVZpOGGCJA/5SjITgpvwdhBZ2ioE5uAvSYT9Q6LydedRf+wo3eZG6oCX2z8kDuDk7rx0Lv3te9SoESBAyQ+1E1sAL01/kN+kIjybuK8WQvi5lkktsXas+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EappbCdSrZOxaB/hTNRXkvBexZZcOdqQZUj70wBoxkM=;
 b=rX3/5FSSKIC6tfj1Lp78162pAWfwiB5z4gI3YQFn5ILhbMKcJuX3NU0Fyk0oivY60CJwsP0+CCmgD63zHFs+g7PRqAnSLpuXvXYVjLBDpok+Ws6fLgJFXiJd6aYTEaB+J8ZWH8vwB0x6pwFMlUz/QNIIjF52y8slClM4gZ3VpQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6755.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 15:13:26 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 15:13:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 16:13:24 +0100
Message-Id: <DK3HV8BJG6G6.1URBMSOVVLT7@garyguo.net>
Cc: "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: Patch "rust: pin-init: internal: suppress `non_snake_case` lint
 in `[pin_]init!`" has been added to the 7.1-stable tree
From: "Gary Guo" <gary@garyguo.net>
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>,
 <adzicmirko97@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260720105951.247306-1-sashal@kernel.org>
In-Reply-To: <20260720105951.247306-1-sashal@kernel.org>
X-ClientProxiedBy: LO4P123CA0283.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd8a412-f849-46f4-c34d-08dee6717216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|7416014|376014|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g4tHSEsy04BTfQc48sWVZiKg5Jyz+r/OwD2LZ+lLprvfY5cUNXnm4FhEvxX6s2bjIibBACIxWc3NbXNA2SKBctqO4a+OTK9Zo/f051X3pKO86L3Vw8EWLi4LZoTlOmZErIjkgTR02kySX3o93BqnOjA043QNenfjYrq00mbNJBAlN59Qd54lgtYa4JXi8rMntjOCBklsuvY4ZM6goXb/0esbzvHLnLL+DONSp+pcHP9JVO400w/XxNBehdyIE/azRCzOyyaDOdTuYH3sVwQWWrxjSidpaaXgsiGfOX/qvxjveTEyay9LiWplZwAfX5TPitR8gOibwfuKtisTDvgyg5fP3eHgMZJTScD/HrzIKDf9m3DQownkGXFRBh95sYoTbc+SiE/8tyoksFHOYS6IPnlFeeLtXlI6W+ZQRkRXzUvRZTcS7lSDFdl4GGqz6bL/kKik4ebaChMYmalSigX546LkKCE5BLJ3a5ACkROtp8yBJnukUhCvRE0AJayGbaNok6U0WT8bB/TmsYt9sYJMB97qu62UNY5rq3GbNLOgqnyM4zrT/Z8X82VQMFlyFiSPifcvCME8yrlmcOb6wTEHwbE4BZUEedN63m3sdDpdGN79RkiJx32j2JKt1aBQDj92
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXNKbkxuQm1LZmNETE80YXB6ZlFiUlVzU1lxNFVCMHUrS1Urd2VWVnJPVHk4?=
 =?utf-8?B?Z2lqUTBQbzlFWGJJSkpmQmZWS2NWc0hmMlp0K3ZIeFZmZkRwV1oxNHBrcVl6?=
 =?utf-8?B?KytLTXpBRlNPM0FPdDBVMFZjR1RwNkZDY2tvdTYxMjJCU2xrNkIyRTMwN1lO?=
 =?utf-8?B?TStsMEs1V3VqY1RmYkNFdytjQmduSzV1Y3Jpd25OSWpsT0trRHJlNXJ1d1dN?=
 =?utf-8?B?Q2N6REJyWHdFTUVVbjU2dWxNbkdEMjBUZXZzQWxTU0wrckw5N0dQUW1XVmh3?=
 =?utf-8?B?RU9yNGljRHd2eEZUTTc4blN6SSthRkJjaXNVMXljdHNlTk00NUNETXZ2ZW03?=
 =?utf-8?B?SEQrKzRuQStQVzZRMlVzOFdxSGxwaWZ6NDVvVmFDWk9oaGVvVjE0OEVuQTk1?=
 =?utf-8?B?TlhrOFBDK3lEMWZQSGp6bk9HUXVTTE5qVmdmaXFiM2QrT01zQ2NLRi9PdGdZ?=
 =?utf-8?B?YjBtSGdkcStlMGdyTUdHK2RxeHJ1NWpBQ1lpLzhtSXVFVHFydE1Vc3dWL0xt?=
 =?utf-8?B?NDVMNjg5VVpPQVY3ZzRpdGNjYy9kTi8vUkpxRmFGQXBuYTF4dEZGMlJtcmxY?=
 =?utf-8?B?cVRJRjlhNzRzaW5VN1IxUzFTYzhsTzFaR2F4WmdTNGFSWm1kVGZENlZXM1NM?=
 =?utf-8?B?aUk4dVphcy9LMmVnaWpRQlRYaytXME51RVlYVnY1Tk16b3EwbVFqSkI0QWFl?=
 =?utf-8?B?TDlsS1hmNS9LWmI4T3k4bldEVFdxTlp3dE00Z3ZnN3MzUk05bFBQZlBTWTNL?=
 =?utf-8?B?N2JOMEpJMlVOV2wxTXI0MFBHRFErbVJZeUtmak9lMGx2V21DVUY5bHBUNlFp?=
 =?utf-8?B?Z2hySXhFUmJBSnZWSXhPTXlocnFBaCtOaFhFa2QrMDcydkozSWpmTDJTTUZk?=
 =?utf-8?B?Ty9rUWV3dmxEWENKL1hicVpCcDZ2S0NjY0hUakQrUGUzbGRMTkk0cE15OVdo?=
 =?utf-8?B?UXFHR0krS2podUxnRE5xWjI5cWFvMHBYek83ckdGekQ2MWJiSFdJZ2pnK2Uy?=
 =?utf-8?B?VlMvcFRGSG9GamJLMmJoWHVUNDhDNUlzSFMxTVAwTDJQL3kvbjBUOEJvYmpE?=
 =?utf-8?B?U05tdmwzeFp1NzNuVHRHMHNpcGNSS2QrOGhhV2E3UXJtSVk0MnZ3VmNTb2Zy?=
 =?utf-8?B?cXd3V2t6MDFQZGI4c25nUm0zSkIyNVhlbC9Gb1RQb0pRR3poek1qcXBQeG5G?=
 =?utf-8?B?cWFqRFY2Rm5PR2NCa1ViNUlVOXhzYy9YeGU0emduY2NyUGxRRFZhQXNMTklV?=
 =?utf-8?B?ak1iZDhoQVFIS3htTUw4Y013bGh5QzlReCtnZDUvSmxKTDBPcFVqWnkzZlFY?=
 =?utf-8?B?T0JpRHpMaVl1VEdURm5KYVRSbFdZYW9ZWGJWWjBxaTFSRGpaRDB4dHpiZUU1?=
 =?utf-8?B?RnhNTCtmMWU5Wk1TSml2WkEvVWJPaFZUWnRVaVViaFcxQmtOTHZnUjdYSmZ5?=
 =?utf-8?B?bU1EalNvRVpDYVhiTU9zOW1LR0dsWi83NlZ5N0xCdlFPOE16QkZGQUpvdDQ5?=
 =?utf-8?B?TXQxUEtPMTBNazZyNm0vSDRWRkNzdXhRc004VEswY0dhVG45bXB0b3dHSTNX?=
 =?utf-8?B?YTB2RnRDLzF5WUp6U1JHYUs2V2VtSk5KK01iZFY1L2R3dHFEblhjSExwN0c2?=
 =?utf-8?B?WDA5aHpkWnBiSSsweWY3V3hxV3prTlZHRjFtclkvTTJ6WVZQUDREaS85UFFF?=
 =?utf-8?B?QzhmVUlNR1l1ZTNjc0E2SmU1Y0JKUTB6VVIxdEJWTUI2c2tRcFQxYU0wc2J0?=
 =?utf-8?B?YTBPOHpsaGVtdlJ5RGgrNitqOS85dUZtdDV3VmMwb05aOEVlS2piLzY0UUxt?=
 =?utf-8?B?L3ZjeFhjT0MwdkxDSnJpaUVMWnFKSWhoOEo0T1NEb3NuZDloTVRGY01HYVpO?=
 =?utf-8?B?UTFzMC9yM3NQS2xwRXBDQmxDRWFZa0M0TlNueDdPUFFtZHZQVmN5TFYwSFVi?=
 =?utf-8?B?VUwrS3h2bE05K3c1U25QSWZCVjFDTk5xbE9LYTNLZXd6VHcxYm9LWjRkOFo3?=
 =?utf-8?B?cnI2THVaUUFibUFacWhNMW9GWVhGVVRpZE8yZlExU0xZSHhFUk16WHR2ckFY?=
 =?utf-8?B?M3UwQ21JcldjcHBNVlRFMUFFLzRFMWxrbzZuVTVLanAwY1VwYkozV2ptVjJu?=
 =?utf-8?B?ZmgvWEN2VlNoQWkzUWREWlZidk9UUXdDVG8zYlpBTHdZR1ZKVitlbGFjUkNp?=
 =?utf-8?B?VWJZVllQSTZTTFFRNFlpcDVzT1Z6aTdNakxvZktmL0VFNkxPaHk3b3VnSm42?=
 =?utf-8?B?ZS9md2RWWEozVUtkSldRN1kwTjZGV0FMWTBLTDFnaU9mekJFUnpmMm9DazJR?=
 =?utf-8?B?MGlyUzMwQzdISm40Rk8yYlNOOUJvdWZZcnYycDc1S2E2YU9NOEo2Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd8a412-f849-46f4-c34d-08dee6717216
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 15:13:25.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rApnaaCWsuAg4yKip+aArpxbbWgempUkQqdmLtAXNaHGhPkz8D05r9fRsqzNFCnmMW84fjg5ElxO5jtpBk2G6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6755

On Mon Jul 20, 2026 at 11:59 AM BST, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>     rust: pin-init: internal: suppress `non_snake_case` lint in `[pin_]in=
it!`
>
> to the 7.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      rust-pin-init-internal-suppress-non_snake_case-lint-.patch
> and it can be found in the queue-7.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Hi Sasha,

Looks like quite a lot of patches have been picked up as dependency in orde=
r to
pick this to 7.1.

The warning that this fix addresses are already worked around on the user s=
ide,
so it probably isn't worth backporting.

Best,
Gary

>
>
>
> commit 54db70c2ed9fb176f2f097a04c55b67071dc0db7
> Author: Mirko Adzic <adzicmirko97@gmail.com>
> Date:   Wed May 27 18:19:54 2026 +0100
>
>     rust: pin-init: internal: suppress `non_snake_case` lint in `[pin_]in=
it!`
>    =20
>     [ Upstream commit 5423ef9d4db852835746001d0840231227bb0e39 ]
>    =20
>     Allows `non_snake_case` lint on local variables generated in `[pin_]i=
nit!`.
>    =20
>     Conceptually the identifiers in `[pin_]init!` just references the fie=
ld
>     names, and are not defining them, so the warning should not be genera=
ted,
>     similar to how constructing a struct with non-snake-case field names =
do no
>     generate these warnings.
>    =20
>     Reported-by: Gary Guo <gary@garyguo.net>
>     Closes: https://github.com/Rust-for-Linux/pin-init/issues/125
>     Closes: https://lore.kernel.org/rust-for-linux/DGTBJBIVFZ2K.2F1ZEFGY0=
G7NK@garyguo.net/
>     Fixes: 42415d163e5d ("rust: pin-init: add references to previously in=
itialized fields")
>     Signed-off-by: Mirko Adzic <adzicmirko97@gmail.com>
>     [ Reworded commit message - Gary ]
>     Link: https://patch.msgid.link/20260527-pin-init-sync-v1-3-e20335ed25=
01@garyguo.net
>     Signed-off-by: Gary Guo <gary@garyguo.net>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/=
src/init.rs
> index aba32825fef477..45528ab82f6a82 100644
> --- a/rust/pin-init/internal/src/init.rs
> +++ b/rust/pin-init/internal/src/init.rs
> @@ -307,7 +307,9 @@ fn init_fields(
>              #init
> =20
>              #(#cfgs)*
> -            #[allow(unused_variables)]
> +            // Allow `non_snake_case` since the same warning is going to=
 be reported for the struct
> +            // field.
> +            #[allow(unused_variables, non_snake_case)]
>              let #ident =3D #guard.let_binding();
>          });
> =20


