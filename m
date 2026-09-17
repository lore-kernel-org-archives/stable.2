Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE831F996
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606795; cv=fail; b=PzjFZsrcWPdSYg1ExWFLiPbNgKBM4hXv0Ll9TmDwlv+fLKb0LVmyblqhVPDY9sfzzKqP9e0SCIc0MNySsLK5yRm9yZcdzKyIY6ZP1lReeahEXMp1Y1Cmn7M/YCPUAKqAinXuni+CAOpuld7C58Rf5Z3fvJGJ6Bv1dQKH28NX7+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606795; c=relaxed/simple;
	bh=o/VZLco7Ay1a0WJQ4WGcGy89we7LZimlfFWvIPT6z3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A4I96WPXgeeZNHhpQIcFlMm9S8+DHzz95tB9alCWv5Ooyhlds/3Tkl62YaTN6X1iXYcF7YgbpEpzmZxG5Q34khDDBF1Ei2y6/VuXDF00t0SIoe51LAD1Rs3MU7+3NJpr6c6Isk9dTIiSz/sCt8apdR2/HzSfnzRMg/rzdN4Po2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OuJUnPYl; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OuJUnPYl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mp5Bkon521NpJOVfsKH/ZyUjk5XOR+4gwYRCMQ22RfCtc2FDdezaXKX17qf4jZRhqGnGJz0d4VJ8QprB/G6tGV3jxzeWS5mIB5T7WoOVo59+Ic2gx0AJqkR22uYtzvfLD4AC3Qq9mMcqOrUczGy9pD5s5in75y0swBf5WWh0p5DBFsB8KWxSgI79xH4vI+hOhIK28imo3jZyeehMzisoUOA1lwFIQ9RoeE2NaZ0zfQK0CQUackTzU7Zlr68DQgnPIK+CqV1g1lSFNZuqUTh0f6XQJ74nj9zTn8UFHLuU/Wl+3sDlUDu4M96t3oEfeu3f0EVqLj5WTSd3GrYPsfLRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ziv36t/DTUQrlKvtDB2Ynh1Q9q30Srr91zxov4XPyIc=;
 b=efjilmGckQwYt/EzIqeGwczRAeIIaBRlHViDkIONYwigzgIQGwON4JxYaf2FDZWlXVO9qE1eSSzlPcnD6b6zDUZ549Zuk8Vy13wD+g3Aor6yDt8W8OKZapl49a8K3CLlIxN33zfL44VwVJ3e5N03E7Lr4rTJeYZPo0V3uUCBLetK+dJkW/pK3/Y24LenYDeOwvpYMbI0Ur1G5dY3hursgC2qQhAebIsJa4J/hNum6uUKB6N9bWxM0jb4/LHW9xa6FxOPT5X5kDuA9wfmLZ8kENkrkPDzmR7BZcVLEqtfJdu8A1XuUkoAb2aK2dUsIEGnqwzXA1M9mXPlXofSz3ILGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ziv36t/DTUQrlKvtDB2Ynh1Q9q30Srr91zxov4XPyIc=;
 b=OuJUnPYl6blKlOzngerG4/zbgvgR+Bcvjkx+lsCqMeyL7WXLIXkyBuCw6N23lNLPqKDPu7/q2z1Y2s2BXxBPjrwONKufyQ6gzFGGx1JW4u1e6HGk1hWUBdZdU6E/REHNYqKXmkgyWFhIgft5mwdpGrD3CI6pAX5C15oBJv2ojeMqtXWLV1XpHie0TC1MDe61eavL5TK4fwaB4QkmapAYo6h6MEnLUCRjqJidDKvuzw4NsN+VoQfwVtgOVCj2iEbbFv3Pb6mcgLMZTSyIBtsEBAQIVr0/2juXNTBchoPL0e9xG4WD8ytEVZRiXi+kr015VFKMuY8GsIqrILC3fqJg3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 SA5PPFC3F406448.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 17 Sep
 2026 00:59:44 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 00:59:44 +0000
Message-ID: <a94a954d-3776-4e56-9a51-f6efaeec5036@nvidia.com>
Date: Wed, 16 Sep 2026 17:59:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] rust: allow `clippy::as_underscore` in the
 generated bindings" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, ojeda@kernel.org
Cc: stable@vger.kernel.org
References: <2026091618-barrier-dexterous-aa2d@gregkh>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <2026091618-barrier-dexterous-aa2d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|SA5PPFC3F406448:EE_
X-MS-Office365-Filtering-Correlation-Id: dfaeb66f-ab19-4b93-8f74-08df1456f667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|10067099003|22082099003|18002099003|6133799003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	36vt760i3SupkmqdVk1CN8UCbZPJt0Dcc2pXaQbI3sNgxVf9f1tNsFELCjA5k75DGHxbz0+je10j2X3Sbl3mayOLAtTgC8GGPwsbDwHBWbumB+8jmjVxcJLPq8PFsbuO/KeOT4wn2HjXvh/QyVaZj4incj+QevdlUUA09ds4D0w+VDWtYgZKbQE+VA9iy72Ej9fcm/5MjGHO8oraihlTb/nNdvv1J1yvJVDUG2WvhPJpSx0nBOfrsptN7dAqUHZUAGDpI8SMVPrkpED4xNCHy1t14IZjIpbyJ9AhWyEvQ4g2vUaQOa0QQo3/6V33vCPda/XlLLeAHvT9LI0PRdXjS7HAoDdpY/+BD445RcLzvQl6xIHUmWNheKcaQmRhsdEquO4leD2QZGz8BNrlrLDh/Zn3GRrmb5cCzxkqmePWrmpLM7NALYYZeIxoAj8QiDHrMBGCf7PIx8/EYXyPXoTeV6IVlxjPDdDLBTMTT0b2SCy90Umu8iHQco2dYD+xhp6nVcpaJHi8y1T0NLwGbzfDBweG7XcG9fvsDr1RkoBiY0kBBYXVRtD7BjbU8wXLwfZRUbk4t0wqY+jnNKPbZInLB+wfq3GOzFgD8bB86Y1W98XPxCG5JybEqvHRJYWodAb+q79YRFfjDgGoM2U9yES/wfgwCqqv/AutqmiJFKll+5c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkdrSU52SUpNVXNJN282WEFQOWw5cXVkZnVQdU1ZSlZubGxZeExMUjVvc21y?=
 =?utf-8?B?WkppcWQ1dDk1OU42NTlsSEtoaVVOeFFUaW5PaXk4QW1MbmtmQVR4dmNVU0dS?=
 =?utf-8?B?QWpnNGN1LzFqZnhvYkJBNUJHa285U0h6T0dkNTR0SndQOUJaUFVqZlpxUTlo?=
 =?utf-8?B?T1RPdUkxd1ZINll2blNteVREd2tXMi9xMk9rbFBwS1JlcU8xZkdBYnlrUkdH?=
 =?utf-8?B?OUxMT0lkOXRBSGFXcjBNdWFSMXpxTUIwYUIyZXhDSmJHVXhZOXVCL2xhekww?=
 =?utf-8?B?THJORFQwd3VueXZEQ1pFQWpnMUp4MkVTSlJLOEtjc2d5QVpwMnNPQmpJMU9s?=
 =?utf-8?B?b3FsVnJlOHhHN3lOUTRud3VPNFNqdGNoaU9UOS9WU1lFcGlYSVBUb2Zsbk5x?=
 =?utf-8?B?dnNkMGREaDdVanZ2bGV3NEZKU1dVd205b1pUWU9takU1UXFKNUhDRkNJOHJs?=
 =?utf-8?B?TDRxVWo5MXE4bHdMWXVUSVhYWnRVKy9XcHJ3ekZIZ2JkM2F4QWQwam1RSFVD?=
 =?utf-8?B?cGdlV1FOSkpDU2JOMFhwWUptL3dGYUpUSmQxSVRkTVFteUR5SU40YTZwc3I5?=
 =?utf-8?B?WUsra05EdTUxTE1wMWt5dHlDOWZYYS9ENlRhT3kzbnJ3ZDhrMjlETG1YMFgw?=
 =?utf-8?B?MnFDbTFvR0NoMTZTazIyWTNXVDF1STlkczI0Z2cvUFd5RDRGRHhpM0IvbE94?=
 =?utf-8?B?OUM5STBpSWxRQnBQanJFdUpjdnJaWWllRERxYnU3elloOVI4dFVsV0UyR0ta?=
 =?utf-8?B?M3Z3NmF1Z05hdTBJTmQ2Q0hoUTRibzEwcVBjT0NCdnJTdXB0eUxlM2tYZ1dR?=
 =?utf-8?B?dmxoQnNyQ3htbG9wMDZjaUJMcWpzeldkTzN2YjJCUnlWK2dKU25Kb1prd3BM?=
 =?utf-8?B?aklWdk1sREVzVFhMQ001d2IwWnptY2o0OXFVQVhXRzNnV2NPUWdVaG5LYXFW?=
 =?utf-8?B?QTBRRG5YYk1wWWMwRUJBYlpub1I0OTVQaDVEQmtsTkNkS0lzaXNaSElBT3FS?=
 =?utf-8?B?TXBZUWpUcVBjdlJuTXRsamRIelRLbkRWVlpJK3RDTk85U3NhcDRCZ0RDL2NT?=
 =?utf-8?B?UGxxTVlic0NZT3NiSXlNNGQrTWZhTzhaSFNBSVZOWjIyWWlydFBmNkpjU0ZQ?=
 =?utf-8?B?czhvY3RIZStjUG1UUjJqRnVGWnpaVzhjTkRHcGo1TFNzL0R4V1JiN2NFNVlO?=
 =?utf-8?B?MzdKQU1haWZxRnFzcjRNcnVORllOTFl5K3hzaHFqQUtzWmVCYUNmN3NuZDdK?=
 =?utf-8?B?VFNiazNJMzRiWlg1TU5xVHF6QTJjTVJ5bjlFNm42ZVRlMTk5c0lBN21ueXdX?=
 =?utf-8?B?UGY3ZGNtcGYwSnVaUVo4R1FBODhyM0xhdEJMcGFqNTUwTWcyM1N4d3pWdE80?=
 =?utf-8?B?L2VvREZ2YlNVVlYxcHNhdHc1cGNpR3B3Um5JaXR1aUdhSis5VDA5YkVFWVVj?=
 =?utf-8?B?Z1psRWFGeFZkdHF1czJ0eHNyTytKNEMyTk5manV2bzJoTHgxVHBlQ0NNaTlF?=
 =?utf-8?B?OUlkbHVXZUVDZUx0dTRORU9OVGVTdjZoTVJHZS9hZmdRUzcyQzVNSTZyY3Vx?=
 =?utf-8?B?WU9CZVR6bnE1a3VqaFFlNW1BaGdsa2dienpBV0FNcmZ0NXM2dG13WGcwTkFV?=
 =?utf-8?B?T0JMQ3RIWXA0blJIZSsxaDV6VTMyckRRSGN6VERFV2laTVBrVG15Z0FsT3Nt?=
 =?utf-8?B?eVJrUzVNVFh4N2dLNTkvMFVCelplN0dCcStYMmU1R2dLOElIM0I5eUtsRlpI?=
 =?utf-8?B?eFJ6MTBya3d1em56Y1h1VVBLNjQ0VE9sSDZjcFRxLzlUUzFSTzJlcW1YaEdn?=
 =?utf-8?B?ejFLUXZpUDZicU5BZnNpb21BbTJnelBrTUFzY3dRRzFjTHBaa0RHbDUvVjVr?=
 =?utf-8?B?Mjk2MEp5UVUvZndNdkVCTmNLRFNQdHpCVm53Ym5FcGxEQmVKR0VJMGh1QWpk?=
 =?utf-8?B?ODFpODQzeU9CZTRhOFkxWWdRWk5GbWJ5czFZQjdwVGVNQ0Jkcm1NUWptQ24v?=
 =?utf-8?B?L3ZpVzE0RWh5R0prUXdUODVEUTMxM3hPNXN1d1VVWjAreTVXYjJzQnN1TEdK?=
 =?utf-8?B?NWc1WE13eTE0VGR2VUFlVW81QW5ZclJzODl1QitkTWpzdWFONm9hZDJKS240?=
 =?utf-8?B?bU1aTUNsZGNPeGlqMWxNYWR1dVR4WkZsNlloL2h5MDVFcWt6bm5VaHlGdExS?=
 =?utf-8?B?SEdhUEFJUzRSaHZHdG5veVFBWU5BRmZvWkE3OGwwVG9UdjVpcnFuRjhlU1Fn?=
 =?utf-8?B?NUxvb1ltV1ovUDVCblliN1N0N0VDSEpFZ3pDNFZFblQ4TnhJazRjSjFBVkEx?=
 =?utf-8?B?M2RhQmRtWDg4cUJMM0VDbFVYRGdLZFhHYktxNmQvR2o0MHBLVlFTQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfaeb66f-ab19-4b93-8f74-08df1456f667
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 00:59:44.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBQIXm72s2LYiYntIQ567tMmTbXduC0TuQK/kEGlzjvAwPIcgAg0Jb5MzIQSY3iJtkHHiccvlVknZBJwwVzD+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFC3F406448

On 9/16/26 2:13 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.

Please drop it from 6.12.y instead of backporting it. It would be a
no-op there, and my Cc: stable line was too broad.

`clippy::as_underscore` is a restriction lint, so it stays off unless
the build enables it, and 6.12.y never enables it. A CLIPPY=1 build
there cannot emit the warnings this patch silences. The flag arrived
with commit 5e30550558b1 ("rust: enable `clippy::as_underscore`
lint") in v6.17:

  $ git grep -l Wclippy::as_underscore v6.12.110
  $ git grep -l Wclippy::as_underscore v6.17.13
  v6.17.13:Makefile

The conflict has the same root: the patch wants the allow() lines for
cast_lossless, ptr_as_ptr, and ref_as_ptr as context, and those only
exist in trees that enable those lints.

The tag should have said "Needed in 6.17.y and later". Sorry for the
noise.


thanks,
-- 
John Hubbard

> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 2ac74c6db40adaa29c50cbb281ae9a6f63de18e1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091618-barrier-dexterous-aa2d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 2ac74c6db40adaa29c50cbb281ae9a6f63de18e1 Mon Sep 17 00:00:00 2001
> From: John Hubbard <jhubbard@nvidia.com>
> Date: Sun, 6 Sep 2026 14:58:22 -0700
> Subject: [PATCH] rust: allow `clippy::as_underscore` in the generated bindings
> 
> A CLIPPY=1 build emitted about 15000 `as _` conversion warnings, all of
> them in bindgen's generated output and none in hand-written code.
> 
> [ The lint messages look like:
> 
>     error: using `as _` conversion
>          --> rust/bindings/bindings_generated.rs:18947:9
>           |
>     18947 |         self._bitfield_1.get_const::<0usize, 16u8>() as u32 as _
>           |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^-
>           |                                                                |
>           |                                                                help: consider giving the type explicitly: `u32`
>           |
>           = help: for further information visit https://rust-lang.github.io/rust-clippy/rust-1.98.0/index.html#as_underscore
>           = note: `-D clippy::as-underscore` implied by `-D warnings`
>           = help: to override `-D warnings` add `#[allow(clippy::as_underscore)]`
> 
>     - Miguel ]
> 
> bindgen 0.73 returns each bitfield read through a trailing `as _`, and
> 0.72 returns it through a transmute, which the lint ignores. The
> bindings and uapi crates allow `clippy::all` over the generated code.
> That group does not cover `clippy::as_underscore`, a restriction lint.
> 
> Allow `clippy::as_underscore` by name in the bindings and uapi crates.
> 
> Assisted-by: LLM
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Link: https://patch.msgid.link/20260906215822.1201022-1-jhubbard@nvidia.com
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> [ Removed CI sentence. - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> 
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 812f8e5a08d5..ad24c920b919 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -22,6 +22,7 @@
>  #![feature(cfi_encoding)]
>  
>  #[allow(dead_code)]
> +#[allow(clippy::as_underscore)]
>  #[allow(clippy::cast_lossless)]
>  #[allow(clippy::ptr_as_ptr)]
>  #[allow(clippy::ref_as_ptr)]
> diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
> index 797ead5b5626..2df0340e63d1 100644
> --- a/rust/uapi/lib.rs
> +++ b/rust/uapi/lib.rs
> @@ -10,6 +10,7 @@
>  #![no_std]
>  #![allow(
>      clippy::all,
> +    clippy::as_underscore,
>      clippy::cast_lossless,
>      clippy::ptr_as_ptr,
>      clippy::ref_as_ptr,


