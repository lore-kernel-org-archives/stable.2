Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020130.outbound.protection.outlook.com [52.101.196.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1083537F5;
	Sat,  5 Sep 2026 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788618126; cv=fail; b=ZavwoXzhAorLMQqzUTpWxWTw6ejth6MEYwEV8zIEI/l7yhgt2zgAmTNusSFKAFiKvL30DH3yEJb5Bwwk3LlqWCrMfJenQldpFiWBf9kOQWWz48u6LHqjRBR9KMMSCMSWKr/Az/6K8dyGN5mdzGM+A3xI9crVK37ROgYxi3mKfIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788618126; c=relaxed/simple;
	bh=TpFJlYo5S7SGWOT+JrLHA6nZjctb0ezpjn7UeFqoplE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ItKS5pdwr8EUb3xAcGVf06dSfxvwbEYs+NS6yA/o1ednygRAYIIPNIK+qqmG7wHrpFHtCWHCWKqI+1sGDeZQ//yJfADUlIP78CaeMAzI+L20HrGZaY9NaXRHapFQgNNLAnmjRUjHR+19phwlTCqmqEvTSeny5ITsRsNfmBuSS+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ljIM5TA1; arc=fail smtp.client-ip=52.101.196.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ljIM5TA1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsMmdWpsP50nMzOqoLXS3SDgn+uWdSUDhUlbL4ovQRH33ZPVq82mdcIdy+XIAmApzyj08F8AJZRQNf/MEX9sk7kHhAxrpEkiExrt3YLoi4IVVfkOfqMqnrM/IE2fJWhLzbSsD93Zeg7db9qAyJYWaq5uLF3jgQqWx1GmRfjrdgn7kf6tfBw/2aCZhOwOvV91pT7TdLH+2sSbjlgHQQnrb7TpAl1NMJfSHxvdFjtMdX1XeI8sD5zbiXE9QxHIyDs2kc7m/gI9cNxRORr5o9m4NVFN5cZkcYTkt7liyivszGxNQRNdcABsnkPEEaFgR+5WU+IJZ2ZjggHixwcCMqIwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ839ooM6BjEGZmrHBy0lEWeEymzdQxjMHUqfIG2Duk=;
 b=JpkGYAKSSR3Dg790U39Lic7AqnFXMwD32nzmSI6vVuOzI1Y74WUDBBK9At3/Gm5hFCxLT1dPej74PC63GFJzQ4Ug/q/VztJN8UVxtqKr4pqDSfwZEIEeUtZnXITZFh3+lKwCKc37FnqSFqlSXKWl9jQh548VKYjewUQDyV6pGRj2qPaV/palkmAia1cs/6nUEIaWXNHcfbXObl+/L4aUik6lJd1KdQ6TfYnG7jHI76oLLTMsigHQ5NyiZgHzaAFPffHbwEE+5IgAIFSgR2Mbew/1y2AMI+SNRPaDl/OyRie1Zfz/s2CKbxf4NfXlvSoFyuGjGzH05WZCeOe5aRFVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ839ooM6BjEGZmrHBy0lEWeEymzdQxjMHUqfIG2Duk=;
 b=ljIM5TA1LCQE6P3CBHKV2IK4EgF+BEYgFTR3YXbV36CNnyFlHq5lu5uhqnVOHADY7lgWjOnSiSXX2wqNv4RsXwRnGGwCpvvM1l1CYCfEd6V08LszKAcdGwewI12AfT7DA+xKbWtLynT1KmuFCuMnWOMDMgbV70zcn3MZnSOhJco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB7225.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Sat, 5 Sep
 2026 14:22:02 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 14:22:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 15:22:01 +0100
Message-Id: <DL7G7HLTDOR3.3L6QJOQL43KP5@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: num: seal Integer
From: "Gary Guo" <gary@garyguo.net>
To: <git@younes.io>, "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20260905-feature-rust-num-seal-integer-v1-1-83096115ad64@younes.io>
In-Reply-To: <20260905-feature-rust-num-seal-integer-v1-1-83096115ad64@younes.io>
X-ClientProxiedBy: LO4P302CA0026.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 376e7d66-b49a-4b2e-5738-08df0b590da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|921020|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2BIAVasvNrbajkyNvyvRF6fblHmUXa3hx2W2h2SStltdlYCzFsxV8anjJKDSOSsX87TCM7urJYFhjWlFZwCt/4BgfT80oHXEyyAzUe5jShbwliGX8g4YLeKEc/Yb6aFTY+0QAiBIHDa/3jmpYjOct2MtQ2E3wELi126QW68KRG/dnrY00bao8H29w+qV+bUnAY4gXPKZGUyPxsys67hy0pv0C3YufPReh8AuaD741quKT0Bsi4OZ/iguboIhMQj2PsaxamGbJ488NqBqPMlHzJoI3umVfnX2omWXKO4KfhgIS9AlOR6guM42qXeChyIsnAYRDohS1dRFljTvkHuZtbtRn8FDy9s9u1lurCKYgitcV5CVNgm1haHGXlkRIXi8fd5ctloY4WGFeLFWlYt/i0HcVUk4OeTcE++dv2CeSoxhEDic9Pu1n6AF9Q+8BBuV36vAm/gYhEqCT94PyuFraa5IrLJgacyROVoYQdIlBg3bNUNT249p/icA19mi7KuGtS5BSO+Ogt4nR8o9DFhdymK5CtdGAQtHsP8P6+mMXv4xcXVNZ9ljawfjTfECamEZm9GPxd0owYw+NIva28z+RZMC5GvM/9/VnuOgcTDJYz5unU+Kogr6YFO2PWgjm1s6H4ssH8NJQ1FHlErT1kii8GzNDuwE2eIGdYOeval6if4oPKC9IPbvvP8RF/8MaNL5EHM4YfXo8JFcx76fZo1TdQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(921020)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2MzcHFVcVBIN095OFFtSzJnb3ErdG5TVG96NzlBalZvM3c3NTB0UFhCNmFG?=
 =?utf-8?B?dktlaS9kTWlOTkVNZmpnK1BvVThQOW9EamZyV3crR1RrTXlscnEyOFF0STdS?=
 =?utf-8?B?VFVtWWdZbU1IclMwUGc3WTFCVVptSVo0WHlWcStuOFZrak5mRWw4MW1aWU9u?=
 =?utf-8?B?aGZoMVgyYVJONkwwOG9SR3dzMjBMQjdxaE42aFFsTUQrL1Arb1NFbkdUWUJV?=
 =?utf-8?B?UmsxNkFRYnM3c0FOYzFPdHphMG9wMU9HTWV3cExZa2lHNkdOMVBPYWw4Z1VT?=
 =?utf-8?B?ejR2ZlozQU9tQThGOTRuaU04Z2FIUkJaRGIzMHNaOWJJQ0p0d1hWYVg0Rk5m?=
 =?utf-8?B?KzM5VGJsOHhjWmR3dk9GeXVMZW44K09GeGNYTG14S0hCYWQ2aG1LWlg4MWFK?=
 =?utf-8?B?UE1NVFY2dWRNR21rdkJlQTBialRnZ3NPK2p5dGlzVHpZZWJKL2lRaytJanNq?=
 =?utf-8?B?c0dMUEtBOG8zalAxTlBFTG1JSG5pMUZjMGRQTFJMbEMvWHJZYmpmTXcwTGha?=
 =?utf-8?B?Zy96VUpaY3QyMm52eXc0bjNVMDBlQnh1UVV1eXVTdm5GdHJXbmJMeURMRGhQ?=
 =?utf-8?B?OWNadThOVWUvZ3V0bXRLR3FFV2R6QUxVdGIzUm9OZWVzOTVUVkpuQXdoc2NZ?=
 =?utf-8?B?RFl5ZXNqOHNEUTdnUWxZeXZaSHY0b0JSU21lbk9PTWpveldNcDN1WEsva093?=
 =?utf-8?B?dGdjaC9GaFFkUG1lbHhURUVMMDBUazJYNXhCRHNpbnYyei9XZXl3a2JXNXBn?=
 =?utf-8?B?TGlYaEJuR1hldGc2TXJranovZi9lckd0SXVUaDZxQmExNDBJdmFHM2tBdWJE?=
 =?utf-8?B?WVdqSmxtM3I3ZVR0a1laVnBoam4zZ20zMzFhVHNldENDVTB2SHJ5UStoOFZV?=
 =?utf-8?B?K3djbkYxVkRDQkVzdlc3eDJUOSsvVlNQMDYzSEdzcnNibEZ0RWlkTXM3b1Fs?=
 =?utf-8?B?anRZTXNVenJQSW9CNTB1ZmxpKzJtV3owcnJtV2RuSnFiMlYyUHNmOFoyR2g4?=
 =?utf-8?B?OWNjUVhjUDdDVm1lN3QvRDB1VTFjeFZEU2E2SzQwdW5FcmZjcllWNHpmY1RF?=
 =?utf-8?B?aE80RlZVaEpJWm55NU1acUcyUndibzUwMVNEY01vbXJuMFlRNXNGS3JwRWVy?=
 =?utf-8?B?ZWFoUXJpRHU3dm54endidmhiSmtXaTRCVlhoelEyYUxyaU9vdnJ4ZzV0cm4x?=
 =?utf-8?B?aXBsaytTaWtaYnR2Wlo3UjZLWTZRb0Z2eVRNZDdoaVYvcHlGSWFQRzQxd1pz?=
 =?utf-8?B?N1BwVzhkdFZrRmxEV3RFVTl5TUJaeE8vMEl4bjhkemdObHJDUStxRm10bU56?=
 =?utf-8?B?cjUzcTd4c2FNS2oxNjFZMTVXWXFKdHVZQjR4SVMyd2RVZ2prekxTN0J1RnZs?=
 =?utf-8?B?aS8zTFNBQjBXVTFzVlBBdnE1emVzMDZnUTRNVVVVeldRSnNmdnI4dHJHa0VY?=
 =?utf-8?B?MmxnV0h3ZDltb1F6TVNqVEozekVuQWZTbi9ZWkhFcFFCTUs2OWlQQzNHS2lD?=
 =?utf-8?B?dkhKSGtpdStOdGpaNDFFeXhzWFF5dG0yeHdtc1g1Rjk5V2ZnREQyNkJ6VXBB?=
 =?utf-8?B?aWc1bFY4dGNwREl1eG5INzA3cDlpc1VrR1dYT3lGdFd0S2tiaU9ZaWpEek1I?=
 =?utf-8?B?N2dDSnhKWkxtTFR0SU1KYVAxVmN0N21nSlBMRTh2TWFJS0ZkcVJLWVN4THNT?=
 =?utf-8?B?bExjVlZmdVc4bzlWSGpXTTh4Q0JzTVdPV0UzUTRwWTZVZG1pQXZIdmF3WjEw?=
 =?utf-8?B?aTFPOU1rRTBoTEFNRzZnbGFBVW80aXZ0OG4yNlg3YzU4MDluMW81Z1ZPNE5l?=
 =?utf-8?B?UzJCaEdsYmd6R2lBcHZVTnBZM1lqdG1CbklSME1wWThxclJyTXc0c3VTeEEv?=
 =?utf-8?B?aTlxcTlQRC82SkYxb3cxQ08vS2lFVFFvTTF5NEVpcVJKWlF0ZlBEaWx2Mmdp?=
 =?utf-8?B?eHlCdFhKdjlpamkzQXpVSzBrN1hKQ0xlM2p0d2dUTGxGMEVRZFAwaUdxblBo?=
 =?utf-8?B?aGdTM2d0Sk9TWE9FT21jaHAybi9LcDVJeXRFRFJyYTZEbHlTSFg3TkRpTFhk?=
 =?utf-8?B?SWtiSERjeUFDcER6TzFndlVZUUo5aVpvNHZaWEgvMWZQSmErbUVwSTRHQ2pU?=
 =?utf-8?B?UUVoNTYvWkZ1Z1VRNzV4UVhjbmFtUkE4azhVK1dMWmppV3pjMWkydWg3WmtW?=
 =?utf-8?B?ZU5ZMitJRjVHSGNVeXAyNEJ4ZHprcXpndmVCNjBNUXRQdFRaU0lCeTJaY0g2?=
 =?utf-8?B?TjZSSjNkem93MDdRNzdpZFVQZVFWWDJrNjR0NTFyZmg3ZmdCWkRsVUxtMkpt?=
 =?utf-8?B?YWRtZWtTRGpWWTU3L05ZT2xXS2VGaWFmVERaL2NWdkp5OXpYVllpZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 376e7d66-b49a-4b2e-5738-08df0b590da9
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 14:22:01.9781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgMgYiGk3wzdH2qOzhrqP5ajlkBCTESvbbDLzoyyKFJ6HcQKHY0q7edujdM0owsnNX7B/pjg/9sinZYqHUq9Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7225

On Sat Sep 5, 2026 at 3:17 AM BST, Younes Akhouayri via B4 Relay wrote:
> From: Younes Akhouayri <git@younes.io>
>
> Bounded relies on Integer implementations to describe primitive integer
> semantics correctly. In particular, it uses Integer::BITS and Signedness
> to justify unchecked operations.
>
> Integer is currently safe and externally implementable, so an
> implementation can violate those assumptions and make safe Bounded
> operations reach undefined behavior.
>
> Seal Integer so only the primitive implementations provided by the
> kernel crate can satisfy it.
>
> Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
> Closes: https://lore.kernel.org/rust-for-linux/CANiq72mOfR33s4y+Ueivd5NrC=
5yre+Pcp57ZOBz0msw9A4AP1Q@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Younes Akhouayri <git@younes.io>
> ---
>  rust/kernel/num.rs | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
> index dbe848e30efe..de589792a77a 100644
> --- a/rust/kernel/num.rs
> +++ b/rust/kernel/num.rs
> @@ -15,9 +15,14 @@ pub enum Unsigned {}
>  /// Designates signed primitive types.
>  pub enum Signed {}
> =20
> +mod private {
> +    pub trait Sealed {}
> +}

I feel that it's time to add an attribute macro for sealing.

Yes, more macros :)

Best,
Gary

> +
>  /// Describes core properties of integer types.
>  pub trait Integer:
> -    Sized
> +    private::Sealed
> +    + Sized
>      + Copy
>      + Clone
>      + PartialEq
> @@ -56,6 +61,8 @@ pub trait Integer:
>  macro_rules! impl_integer {
>      ($($type:ty: $signedness:ty), *) =3D> {
>          $(
> +        impl private::Sealed for $type {}
> +
>          impl Integer for $type {
>              type Signedness =3D $signedness;
> =20
>
> ---
> base-commit: e510334fbaeaa016ac76d80b4c5f47611c5f7860
> change-id: 20260903-feature-rust-num-seal-integer-a4262df429c6
>
> Best regards,
> -- =20
> Younes Akhouayri <git@younes.io>


