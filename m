Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3A2E414;
	Sun,  6 Sep 2026 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788653849; cv=fail; b=dxZpjkMKzNkXbFHI8ktHZRI0EfhLvtAO++fIhQ7y9hMMPpsWKlXqsMvrLBo9l8nnVgYIUctfMjxn3IYUjYOvzLjMDB5gf0t45zXkiHKQaGbHmPTdm9/ab9GWU+0WANZVNAqnf+9TJJBZv9zOiJbTUwwfRZ3U6K+D3NJ3UjbF9R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788653849; c=relaxed/simple;
	bh=HkQPWOXhLfDCS/AUq3wMjS5No3e7TsEHkLtGILTUGdw=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=SnwnOn79QtZjT7UGXlekNDDSMNi5ZFe/KnU5Otz5f95BR/W32vp1ENsF2TWXNxB1NG5R4L/XKdJPRNvQ0RsvN6euArsVjbiCPoou2yB3JLjZibN3ZAa7peinuhlUdTLJZS+0vMj8Kh3Igo6IKfIShq6tdRX0BjsqWyRwr3JNnhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O/L6GEV0; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O/L6GEV0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quFafME2umB36tS7jwSPe/ncpRy/fbwHwC0dCXe+4opusnZPFagcu/ZU61iitdE68JrZmAGyUjhQcsUiJ798kLmbMoA2Wm335HgtbvAMeaDdqtYvLeZ1GdrotRyesjil1sMRTe/AlPdRsLaT7dNHzTWFXS2Yjy1F6X7i8it0Vk41JylS0dqw1szAkskDt12IFQqIb1fgW7MFnEM2kpiGuvlLsywveeTJGYJUVtUk/9MfBXQ/ytoxGp7Ei3aRNDZL+tg6sWJKhezZUhOi4y0UMPulLGH/kS+Tjfq3K3Uj3S1qv6djVAtWvwaMAlziC4Z0p91x0yxoDO+Anuy/qSPd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV35QDpQyMZlc8XzMvHzAoBs+20gkdyhPpV/F0r6Ixg=;
 b=trhXaQmfO7IXaGOYghtDBSy34Mc+pZD7EcpPazz1b3OVqtWBqdve+xSb92Qd3VQmO/dqgbNsetb9MBsEqTuia5FwX963QY/qrl3FMlouQ++C2Q/joYbc7vxmdm3D5FTUpCSqMeaLZjB45WUd9uzq58VI6P9vUy755yo6j2H2aM5xnwNWScbNLg7d/rjar9cBeNBJcHshUO0uExDNSt3Nd/8Yz+pxaeuLmDaYEs6FmlMUjl5fc7+00p8iON02XP2g4advhmzws7dZEtVgpY2Fqox2J5v31t3807zMa4/0hrdUCmoZgBu85Di1w/dozuRQou2sh43FPGDetnSfvPxsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV35QDpQyMZlc8XzMvHzAoBs+20gkdyhPpV/F0r6Ixg=;
 b=O/L6GEV0gMSTHsmj3YT+oVCghCSKjiH8mpmg7bL9B0GuBd05gjf7HxrmDk07OARPZhZ8J/HTYnYfNHC1+XpzdfCLV9Lj0OjND6Id8MBXIioEI/XtG66RIeHtc5YMmbrYmwz/0w+metC/UYCQVgh8m2C/stidFPK9Aahxm1fEiMBlNPxcf7m75ltulAo3+I0SxeBSFWPrCRoFsC0V8x4XVh50xm578riMYItUFzjbZkpWEr9Joer4oTY10OTYOiwp/6IeuCKKE9KIvnOnNSvn1On7PHWsCBC5hPONF8e6z+QnsY85hBRHzC0qBaVwQT4WVEkKgPQ4YyTEev+N6Azqww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Sun, 6 Sep
 2026 00:17:24 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Sun, 6 Sep 2026
 00:17:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 09:17:22 +0900
Message-Id: <DL7SVBIFUIBT.1ZWECZ7Q197O1@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: <git@younes.io>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] rust: num: seal Integer
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260905-feature-rust-num-seal-integer-v1-1-83096115ad64@younes.io> <DL7G7HLTDOR3.3L6QJOQL43KP5@garyguo.net>
In-Reply-To: <DL7G7HLTDOR3.3L6QJOQL43KP5@garyguo.net>
X-ClientProxiedBy: TY4P301CA0045.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 226f9074-6623-4276-5b9b-08df0bac3a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|10070799003|23010399003|366016|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EumVKZ9R9fkzWvg32dDTbJgf1V/DmOO4UjVAwAwZcruSfVKeJZ4UPiB4fT9F4Yst9Lb+Qijc0cHi/wxg5XOlV3ONQnxZwkq7di2UFt0embooHrXMu41yG/wVDHkbOfRXNrykejjVZaa5mZFESOZ0eT+NX66odQDPBqPs2259Nw9fH3UGKNg7CPuciy1AzJVnryPunGElp6QnIr92DiNyRbSYKfoA5fnAdgdZkqVV81SAtZV9ScBEu+cdokh5aSFBgeXJ0zXOtdslMQNzc2K0lhjmYMDrTyFxZBNL7EbgiAcOg67ue+YNzWMLALhoXcZjpqiNu8KjN1jPhIU/9bWlVsVizi7fjfsvgs27co5n+Fx3xXJETY7weBBvPvQZ+VhERcPArqy5OGx/FxdOHFKeyUnrLxfpAoyPzMtW7swn/zsbUpyZNpK5GAWk70A9p+nrVcmsUm7QgKcmHnHbrGdeA3Ypq2MM/WQZb1aOHmPUkJO8j6GLHGbOaOv7KCTuSMWj7jnWEiadCRh1uDpAsxdjpmv5Ebbcq6LDSL5ykeiJNahz0kL/NDRvKuQ9C1I5vkQscN6OfFUkYO3fPr1VFSfgoEL2VdzQxavPZnJaU4hSpWN8FllDJRGXnHxNFl7Z3//0jM8Ycb+/QK8D+SjMgucSRpPwp10et0af88UyhpjOK64=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0kvY0FHT2NTSWxoZEh4UzIxc2VFdjlTTlNabG5jZVZwMmtucVV0QVFYY2w5?=
 =?utf-8?B?MGFIK0Rnd2dQSER0TTBvdXpWU3pzazdsdUF2VHh4aWRWbm9XbjVIaS81S29j?=
 =?utf-8?B?VjZqdnFSZHhVbndaWjJzN1B4WFdyQmo1Ums0b1FkbFRUYWJNTjdjeURUMENk?=
 =?utf-8?B?R3FNaks3ZHBuQ3BoMnJzTmVMbVZMZGg4Zk52dXp2cVd3SlFyTTI0V3NOVENZ?=
 =?utf-8?B?VzQrbnNCNmJIUTkyVjNqbDRFdlQrSnBiTkRDZ1U3UkpSS0pKMFg4UmpWMGFB?=
 =?utf-8?B?QjlXMTBta0tmY053cWdtdno0MDdrb3lBZkgyaXNGN0ZwNUVmOFdPSWpTOHIv?=
 =?utf-8?B?cVoySnF5Z3RaUmRsZDhKOEdHRjFoTkhsMEdRdFppVkxTL29TNE8zU3Z5eDJM?=
 =?utf-8?B?NmRDa3BYdm5YY0sxSDBZZnNSN3E4V2gwVHhWRFpXaVpjY1RVYjlTWlFpUUpH?=
 =?utf-8?B?WDBjVFduKy9WTVJrSzgrZ3lXVUpqSGV0ZUVUaGcxemNTYlRHaHlSdksvR2tX?=
 =?utf-8?B?Nm1kUXhSNW1sMjB6TEFMWTV6ejJvd1RWVXhyVzlQNW1tSmREK3NCWVlyWnRT?=
 =?utf-8?B?SnNEY2FNbWZqWExhQi9BaVNjY0k5aWJpVGhFcW9pQWVFaTlIT3JsanpkMmlB?=
 =?utf-8?B?RTJKRGFlcFNUYjhuMDhXT1VET1gwTkREUGgrL2MvVXB6U3A1RkhsN3NEZkR1?=
 =?utf-8?B?cDhHYTFjSUlUL0twdmhrSVZUUUJKVUcrdXUrQkc0MW43czI0V2RUcStwQ0NT?=
 =?utf-8?B?djNqZFhaRnk4M3FLazM5bi9BR0pYZlcyKzRRTnhNSW9JdTZOdHB4Tm0xSFNF?=
 =?utf-8?B?T1FIV013WmQxb3pyZzdVTm4vNlZ0SnRicm8vSnl2Tnp5VlhLTlg0YVlSSHJH?=
 =?utf-8?B?VndoankzWEhYN1VIbVF3b3pxcFpuWFpERkNmaDBjeDFZd1lpRFpxeVJzdGtu?=
 =?utf-8?B?ZE1wcXRVZzhxQ2ZLUTJuZWNlc3ZGWjJlQUcrNkozSVdOcHNsdGZ2emZRZm5B?=
 =?utf-8?B?K1lFMkYzQ3R5MEtNNWRzOENaZDdRRnhIMy9zVU9VUzRiTk1XSkFqUWxwV2Ja?=
 =?utf-8?B?MC9HSENqc3pqa0J6bTFKME1GQkFwU2pJbHFObjhUZ2NLN1hKKzgxYWJRWUpG?=
 =?utf-8?B?WFlwcCtrWHR6a1JrSGFGK1RZNFh5SGhCOFFvUDhmUzdwOXdDdmhNWkxwV0Vk?=
 =?utf-8?B?U1c3TUVtRWE1MWM4Q01SdVJCVGJTQjhCRnpxNDlSSkZvZ3pwTTJGYkM5K25E?=
 =?utf-8?B?N1pHVEE1NGljRGdYb1RUemkxVGJJbEZuZUVMdy9ZSlBhaWtHWE5KR0RjQ00w?=
 =?utf-8?B?NHorUm9pVHhjeHBCZEJLL1VpNmMvR2FJQXZTZm85NUZKQUpHTGNCSU9aZzgx?=
 =?utf-8?B?bjl5anljQ3FsK2NLcXp0ZVNQR0M1WXl6UkFxM21OVkZhNXVQa2NaUmR6Z2Zz?=
 =?utf-8?B?N29mZjMzUUl0WEhzcnlOMGZhb2N6bXJYWW1TalE5VXkwQTY4YlQzVk9hSmhu?=
 =?utf-8?B?WEtnSEhWTzhtUmtDL3hXSGNsQkpvRTlqa2dCYzZta3Jjems2aElTUllQVS95?=
 =?utf-8?B?elVhcnVtM2Z0V3NwUWFmaWlIOEVLUDN4ZUNiVzRJbmFUb1BWeDFPMUxHbFF3?=
 =?utf-8?B?Zmd5ZFEyU0l5ejdhdWZhVFV5UlRLbkVFcEcxeTVCeGZJc2REUFUyWUMycEFo?=
 =?utf-8?B?eWZ4bDdFWjdMRm93WVZkNGF0cGlqMndIU3ZIVHdDVGRJNkRaZk9yOXhlMzZl?=
 =?utf-8?B?b3Q4MlpkWW0yUzAyb1V1VVlJTm5ZcmtmSGIrWTRFUnplV0VyRG4vNGJWM1dx?=
 =?utf-8?B?RURWUzhRV2ZNVVJZTDJyZHRQTi9sVStEWHFRYnBUbG9uYTlReFU1WDdoV1hu?=
 =?utf-8?B?L1JMNjRGd084YUt3NnZzQ3lxWFhteVc1NzVoYjhRcGxEemJlbEQzdjMvZURs?=
 =?utf-8?B?WlFlV3NRc2c4ZFcwbWRkVDl1NG5MTGdHcmErWStmQ1gxbTZXeGttVGlZTGc2?=
 =?utf-8?B?NTk3K0xLeWRHL1lsV1VpckF5UHl4ZFBBazc5UTZBTlZ2UXRneDNDdzdaWTBz?=
 =?utf-8?B?TG00VUd2Slc2R1NyL1krUkFVVktHdUZwL25sSEUydnZncEJLQThzZ2pQaTNL?=
 =?utf-8?B?VVNFeVIzWXpISEpFS2ZHN1YyUjZsUE5jYUpzQzRQT1RyYkhsdW9yYTlRbU5Y?=
 =?utf-8?B?UXVvZzRYcDdCVStEcGdDOExnem5oQW9mZDVnMVFTTDRCSFB4VXMvNmVRSHl5?=
 =?utf-8?B?LzZkeVl0dHQyUjlVb0w5ZTVpSGZtZGRzQWNyYVB3VHFaUThVb3dlUVV0L3Vj?=
 =?utf-8?B?KzAzZElhOXRTMDVCVWt1ODZQOHJQbjRiYjhKeDc4SWZPTUFGTjRsbDlFaDJm?=
 =?utf-8?Q?2313hWIqsdu+b8ds4AUXiEmMenpme/GGXdQxxV1L9rQBa?=
X-MS-Exchange-AntiSpam-MessageData-1: zYvFFRiYflor6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226f9074-6623-4276-5b9b-08df0bac3a1b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 00:17:24.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7I65pnTzyabpETNgyWUpIehuJetgRo4qeJNgg6xBOACs8rc5K85Lk8+lnFOtlvl55arHZEAJqx9HJ4To53e8eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376

On Sat Sep 5, 2026 at 11:22 PM JST, Gary Guo wrote:
> On Sat Sep 5, 2026 at 3:17 AM BST, Younes Akhouayri via B4 Relay wrote:
>> From: Younes Akhouayri <git@younes.io>
>>
>> Bounded relies on Integer implementations to describe primitive integer
>> semantics correctly. In particular, it uses Integer::BITS and Signedness
>> to justify unchecked operations.
>>
>> Integer is currently safe and externally implementable, so an
>> implementation can violate those assumptions and make safe Bounded
>> operations reach undefined behavior.
>>
>> Seal Integer so only the primitive implementations provided by the
>> kernel crate can satisfy it.
>>
>> Fixes: 01e345e82ec3 ("rust: num: add Bounded integer wrapping type")
>> Closes: https://lore.kernel.org/rust-for-linux/CANiq72mOfR33s4y+Ueivd5Nr=
C5yre+Pcp57ZOBz0msw9A4AP1Q@mail.gmail.com/
>> Cc: stable@vger.kernel.org
>> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
>> Signed-off-by: Younes Akhouayri <git@younes.io>
>> ---
>>  rust/kernel/num.rs | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
>> index dbe848e30efe..de589792a77a 100644
>> --- a/rust/kernel/num.rs
>> +++ b/rust/kernel/num.rs
>> @@ -15,9 +15,14 @@ pub enum Unsigned {}
>>  /// Designates signed primitive types.
>>  pub enum Signed {}
>> =20
>> +mod private {
>> +    pub trait Sealed {}
>> +}
>
> I feel that it's time to add an attribute macro for sealing.

+1, this is going to be a really common pattern.
