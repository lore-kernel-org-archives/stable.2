Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020141.outbound.protection.outlook.com [52.101.196.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7CE45040B;
	Tue, 18 Aug 2026 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050463; cv=fail; b=i+Ra/6IHz8oSZOnl0Iaa0crTusGSKvIP6uQnfUSXo03HjjVtVisCj2lwoxHf+IzsCwvJ6eeUZQRH7VrtH9Iy7dEodL/PWTtPXVxwGdR/V4K57L4MJb3hTJonLXi8cK/MC48dp0I3Jj0TGP/zoWG542l/ZPT0kxTHBzBz6DcB5mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050463; c=relaxed/simple;
	bh=KNIhILLBYfztdXlUVH44UZcqqLKctA5vZ9/Wh6yHkMY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=OXTPxcucVrM3O6AzJtEX7XyXNF4OfgDhrfrQBcaWW0LGY1WhVSDewZ5u1o7CAcGU0n2pJnT+Ns3MFE2O/juShUT+JbUc48rUUyCfhlRwmGeC+RDpQto29vkoiPRD4Hj0IpGPssTYxZwQ9cB3sI6QP06lSsi5kDWv2+CI66JTVB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=IIgJ9wq0; arc=fail smtp.client-ip=52.101.196.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="IIgJ9wq0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmDd+R0t/dBhaqVBMsP0HPSKZV6o2IF0K+YklByVP2NBDdXj4Ydxxyrq4n77rT5Rp2d0xm4HkfzGRYgn8ac17JRrFuISh81AOUP/j6rcDsLp/EJl4qmO6pyuEzn4OQufIuqAun1fehvvR6ACbQZBSKPAGLHsOIzh458RQJk+te9xamaNGA6DsILhU938KW31sj/i4HgWGz66XD5eiz83vKELJfkBAd4GGSYiggycopHJA6NVP5wRW1xJvDw826igwsFRQoemcpnbeW7eWU6ZI1ksJuiPbboVxDm0UIkeqtz5cZCFOwn1y+bCB0K5I57IqwvRGo78Olf1smXSJfv8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/AK2Kn17MsLDx+kPG7ak0FjfVdkHRtRfHgxHLpSIIw=;
 b=sOspWFfi1a0kOvNbqazHwbGG95lSHgUFmN2th9B8OPeAk3SnXi33H7IbhBBNpI63SBcS4X78Zva0uxN21/4Qy5N+WoC0EaxDO+oM8drDWUwThalb/M/sOeyQQKIrffW0YuvKr/11t+sEoET2WjXR6D+ze3t/Z6KLTGFGNOgJjTDoh1iR3OZZTBkwh/1GYPDVhbNq6fTY20ambQUc7VpLjeGA7DqVIVKN5mZdSQuPytphvRZnU7x29n9VrrfVA//+3h54k8pk7ZwpVDF2+ibQr0m76QQ+zsHU3LEui66SpbjbjP4vM/QtEwOqeKwGhhvsC4TXxi75R+o8QgnyZj8x3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/AK2Kn17MsLDx+kPG7ak0FjfVdkHRtRfHgxHLpSIIw=;
 b=IIgJ9wq0SDe/u8pwTRybwWyWrd/raP0b54CdmgohCtfnSKQgxkemXgcEaOdHnxBEP52CAqX0oWabxWxzcOqyFjli1MWYthA5HDXOR6l413RwqJNi7nHPNnTntoQ9NNC0TMS0knU2/H/xK0oF3J9Xj8i0T7gKik3sdXcMQqKMb/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO3P265MB1916.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 10:54:17 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 10:54:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 11:54:15 +0100
Message-Id: <DKS0ILSW36D1.20JOSTOVBQZP2@garyguo.net>
Cc: "Nathan Chancellor" <nathan@kernel.org>, "Nicolas Schier"
 <nsc@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Matthew Maurer" <mmaurer@google.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Peter Zijlstra" <peterz@infradead.org>,
 <linux-kbuild@vger.kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] kbuild: rust: preserve unreachable traps with
 inline helpers
From: "Gary Guo" <gary@garyguo.net>
To: "Josh Poimboeuf" <jpoimboe@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260816133233.197500-1-ojeda@kernel.org>
 <aoPOqlGAlLOJ3wgx@jpoimboe>
In-Reply-To: <aoPOqlGAlLOJ3wgx@jpoimboe>
X-ClientProxiedBy: LO4P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::7) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO3P265MB1916:EE_
X-MS-Office365-Filtering-Correlation-Id: 456ed17a-bfa4-4aa2-8d3c-08defd170c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7416014|23010399003|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	daainh9tFEtBRQc7F3GRpcvPwkfSJnvt2Wj77BNsdpLet5pxal/dUFK3d9uUzEhsnHlQ7WqqVBDKGGLs5/aaGCY33x3NjT8SB9Pr0QNhmnZvCnqS3dVWPPZzn3OjpHHFmDmYLAsagNaUd0GpZLeNmlJ21aq4/0vTh97tJaVVskgu1gK4mwrzc1ERNfxm+W8awUz7U0usDNS2leu1ADSnBRXRi9XbMcUi9YCMRLQm2v4QiIqhzhdUxX7Kgy+I+oR+Qu5rTT6oJl0xws8P8HI1vs9IoTXISLO1oz3nm0bgQMJX9YYr93UfM8+6Wo9bHeM74QGMKMAosknlgbK9xRtzmTv57O/h/v7SFieUVS20+uXlRZ7lu+iwJ+xvzqKApJ5wOp0CKBHcILDr2gJxMCHgZtdi0sC24pAq8uocIMg+fuHgelE78/JRamtxOTLtoFSbk49hrAs6GM2FTt8E4o8Avodtsyl9E3mylSlzZIStJsoPvNvbuFkNlLSiTeq0AK1P4oWRPKy1u2wKAKEciIIjV9eNE5IUAuNhTc1tLcsKGn42PpbOWQQ1WJb156pHAZZhngFggYxdE4CIjuUtXfmo+uwpbFYeYwr1IqR3YjQ4SHr/RpJJFCe0sr9rbX0yGbPQ4vAQclYMG4wNNUQulmak0WHXVYcz+q9HcyQ5GUojwz8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGtzOTFQVWFDM2Z4VXhNSmpOWkxTTFZETGJlZ2lGME0yQ0wzdStBQVQ1dHFW?=
 =?utf-8?B?VVRFck5haEVSN0tZRU9XRTljK3cwK3dibVJCYlpXZXpIYVZsZUFoRnBLcm02?=
 =?utf-8?B?SElBZnQvR25wejdnNWNqRjVFTVhRTGN5U3Q1VkVpcXBQcFI2S1UvRmhUUWV3?=
 =?utf-8?B?c0xtdUdvOW9FOXI1blQyaGRtNXplSmFCQ1IyVHNPaVhtQUJEa3JxL2lXcThI?=
 =?utf-8?B?SURUS2Z0UWVFNFVRcFZLTVFnNzFXakVvR2F0NmgyZmFiZjB3UDNsblRMM202?=
 =?utf-8?B?WkdHUk4xNTVlNGxiOGRiazJNYWc5MzBRNExTdmw3YUFlVVZWL1oySmozVWRC?=
 =?utf-8?B?QUVKMEd5WXRvckdOSlFXdmt2RWpoY3FQc2ZvaFVieEMzTGtmSHJzZDNOMlBk?=
 =?utf-8?B?eC9qdE5SU1Q2WFl0RVlsN2ZnZTltaWQ5c2lpeXF0bjlGRlRKMjhlcmJERisy?=
 =?utf-8?B?dkEwMW1kVHlGVWRCR2xTbjFyWTJ0ejgzaTNTMGlBSGNZWVpBYVlzMjZBcEg1?=
 =?utf-8?B?SXQvZ0xWdTR5RE5IUFdCa1RTK1pHcFlUaDhmYWxpbGkzbU81cWNLYndWd3ly?=
 =?utf-8?B?S1c0ekJXR3ltQ0hNOGxuVUlHc0NxZ3JKak5kUk5DekRHR1crdE53NEI1RHl1?=
 =?utf-8?B?ZXJ2ZmZCOW5BaEJLWDRlQ1h4aHl1OUJNU3VGdXRxVmlsNXZQd3ZTVVBxM3VZ?=
 =?utf-8?B?LzF3Mllhd00zYWl5RzY4RGs2cE1aOU1qQVh2ZG1xdVZFeXN0Q3VMclpjcnM4?=
 =?utf-8?B?TGpPTkVIbS9IRHRUaWgxMlU1Q21uK1UrcWpRUnZVWkVhdnd5cGJ1T2NpU2pt?=
 =?utf-8?B?aHoybHAxMThLMndvakQrSGNFN3ZqVFIySlRuVmtEVFdHY2F6ejhxS3hTL29O?=
 =?utf-8?B?OURkMHhreVVuOHFVS2VraUlobjQ3cmxTY3ZDY3RuVzhNbElhbUN6UmgrNkpT?=
 =?utf-8?B?UVB0UEtwWVo0R0hrNkFQMnVINU9GNzdSdi9mWU9ndTJFMUJHekR3amhpZ2VN?=
 =?utf-8?B?a3c2azN6NW5Wd1ZHOEpPYW51cHZMSk5SMkE1eXFYdnhiZGtjL0VjaGk5TzhC?=
 =?utf-8?B?Mk1ScjFWUzJsc2tYYnlEZkZnV21HdVFES1d6d2tsenprbDlSZDViTDVKWENU?=
 =?utf-8?B?bTJNNkQwL0pMOGRQb2prL0RNem52bzJxNHVsV3pTOG5OTEEySHNXa2g5U2ZF?=
 =?utf-8?B?OWJqMEMvQmIvUnFJd29uZXVlRDJYMFFRNFE4cC9mRTdUS0xWZ0MvY01lQU5T?=
 =?utf-8?B?SkIyVHp1U1RnRXNVYU80Q3g3aW1sYWNMQkxtZjFOMjVhTnE3U2ZvSFlOZHV4?=
 =?utf-8?B?QTloMDFXbkZMc1BSK2VkNWljMDl3RTMxcDZmSC9MSDJNditoaEFpRFZHOHd3?=
 =?utf-8?B?U0Z0eVdxYldqMlBKbzhRVjgvY1c5UlFDUi9XQStNVGdHTE1OWUZRajQ1dnpC?=
 =?utf-8?B?U2V3Z3VCVUN5MlZEam5YY2JhZDFQQ0hhVkppOW9yTE12dWdPYWJNZjMrLzlC?=
 =?utf-8?B?Qmp2M3IxNzljVXo4QWxvN2JiUDBWVStpYWNaRjNGRW5Pc2tYYis3Um94SGxC?=
 =?utf-8?B?V3FycGV3dGdRQmIwSDRMOGlUem53OFpWcDVwNC82ajI2aHZrMGhSeWIvZXBB?=
 =?utf-8?B?NVJwdXpPOXorUmIrcnZ3VWtyczZFR2ZHaXo0T21vRmJiTzlIM25ieDdxcm9t?=
 =?utf-8?B?L0FRQkJQNlRQOWU5OGNabFBnR2dTV2lSaE5DSERqanBFMlkrK20rQzdMdE9L?=
 =?utf-8?B?RnFhK3doaG90ZXdjekdiWlA2S0xzcUFvaWJjS1Q5MG02N1F0dDB4VDdxSy9U?=
 =?utf-8?B?NGxvRlZ6ZzR4QThDQ1czdnhKSWJnTGtjSnM5YVp5ZjRVZjR6QXdtdVNwVnVE?=
 =?utf-8?B?ZFdqdTl4SWZjL1hXUlV6RUtCZzV1dFBRa0ROMmtxaFBRdWlmRHY3OVRveTBk?=
 =?utf-8?B?cVhRUVJ6QUNYbm9DSkN4SjhIU1FCZkdzWS9STldvWVRxeUxUa2FDbm9udnJw?=
 =?utf-8?B?aHFpeDJkSDJPNmx2UjI3aTllZTAwdGZOMjRHNVRlSUhuZkQ5a1QweWFIV2RM?=
 =?utf-8?B?VzJaZlB0R2Ntci9zTDduVzA3b1krZzFYWDFvZzYzRGJxNjQwcGhiUzYwYjhB?=
 =?utf-8?B?czBaalZ1MThkUjllZlNLaXFsNHEzeVRYTm5nc2tQcGcrREVtbDE0WVFwa1dT?=
 =?utf-8?B?UEMwbURieFFGOGVOTGVCQVNLdTBjQm52V3VNbzRWeHdsQTdiK1RkT3NydDhi?=
 =?utf-8?B?Zk1BdEttQjVXSUNOL0s1eGVZLzlhWHBEM2VUalE3TC9KaUp6SGR5aFlnUURV?=
 =?utf-8?B?SHhxd3JLdzh3eHV6SkhUNWdaUnBSVmpvaFFsR0NuVnk4NnBpVXhEZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 456ed17a-bfa4-4aa2-8d3c-08defd170c19
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 10:54:16.3013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xO4010TIbN/EV8j6sa3/0kH2P4v/k5ranmviuP102lRJEjehQRPRR3606zBpogB+3Zhwv3IgFp8+fRXRUNVlhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1916

On Tue Aug 18, 2026 at 4:18 AM BST, Josh Poimboeuf wrote:
> On Sun, Aug 16, 2026 at 03:32:32PM +0200, Miguel Ojeda wrote:
>> When `CONFIG_RUST_INLINE_HELPERS` is enabled, it is possible to hit
>> `objtool` warnings like:
>>=20
>>     vmlinux.o: warning: objtool: _R..._4cmdq12CommandToGsp4init()
>>     falls through to next function _R..._4core5array4iter8IntoIterRShKj3=
_EEEBa_()
>>=20
>> `rustc` normally emits traps for unreachable paths. However, under
>> `CONFIG_RUST_INLINE_HELPERS=3Dy`, `rustc` emits LLVM bitcode and Clang
>> performs final code generation after the helper bitcode is linked,
>> but Clang does not trap unreachable IR by default.
>>=20
>> In turn, this means `objtool` follows compiler-generated impossible Rust
>> `enum` paths through alignment padding into the next function, resulting
>> in fallthrough warnings.
>>=20
>> Thus pass the LLVM `trap-unreachable` option to the final Clang invocati=
on
>> and suppress traps immediately after `noreturn` calls, which `objtool`
>> already recognizes as dead ends. The combination of both flags makes it
>> match `rustc`'s behavior.
>>=20
>> Rust 1.85.0 (the minimum supported one) supports LLVM >=3D 18, and both
>> flags are available in LLVM 18.
>
> FWIW, I've been working on some patches that should hopefully let us get
> rid of all the objtool hard-coded noreturn lists altogether.  I'll try to=
 post
> those soon.

That'll be nice. I once prototyped a generator for such list by using dwarf
debug info, but obviously that cannot be part of objtool because objtool
operates independently from dwarf.

Looking forward to your approach and how you solve this. Please keep me (an=
d the
rust-for-linux list) in cc when you do.

Thanks,
Gary
