Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021127.outbound.protection.outlook.com [52.101.100.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4D31353C;
	Wed, 10 Jun 2026 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122968; cv=fail; b=kAvsH0y2mZp3o2LSQqbqpkWXsSBDvkRhTpKl/30QNTvXTqV+RdpNFdMjPKGeWqtMymUNwRNEc+ZlV6D7fW53UwefmFCz9pD0Ta+o68gMycpmhgRAp8OFmYtZkld/0SadOuGfZwmx1XbsyNUClKcOeNE6aCGuEabLaIJ9Nnk1w/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122968; c=relaxed/simple;
	bh=qRTGV7hk+QMiwNXZmVEq7kvcZu63+Py0ob6P3nLvL08=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RWH8Kqb1pSco5MTwQQDVi3b630ZCQvv++s5pQKO5RPg/etWyuRzUw4VAx0SzGeG0HQUMOiQ+MHRiqYQcY2ILegJLB8PTaYehyTwSKep3dh5IN2orgKBzeOy7jnEwcr9df77NH/VtxwURrjTiIn6bblSfJK/XTHWaWsQVaO1QrUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vi0PZ+Y9; arc=fail smtp.client-ip=52.101.100.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vi0PZ+Y9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjTLZ58O48zKxA+TgXiuA+HaFAinQ6d9jWNzm2KF9TA/fnBbA848ueYWLW86mC6WbbS+8svZiAfpYxE3P+WkN95+9XTZXqcJ1INz39dl9e6mdJagPP/1BW+vuk89tGISaRtfLLXJ2tEO/vFNTWXK9w6v8VcpA2NrvgpPneL+GqQjj+ya9vRYCsfK64NFf6HVyysKNVzvn7B9cL0JZnP8KR0b7PDIMpgVQ3I+XXYSRpKuSAM4NwghHh0M+WJYW6J84cVa6tWAwqq2+bDowquWZTO+6ssxjr2Ds5B2yaP0Giu2534s2Yco1rHiv9SexpXk9Mg1nq4ilmHNPUoIP10NEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1ZQvN/zKJVdMITeQdE6jIqYT/IWpdjNS97lwaBqU1o=;
 b=uk2bxqqdIDoBk/OC/pOGspNi+NDTfk9lkXSMV+HSEsbU5wvRMSn8KOj6PI7lY4k1zA16jUQOjfIWnxbif1KGzG7RtzjF9sxK3p4hu1Nx7u8XB3wYv5l3QKk2Ah7Ii24RbgF/jvK899mhwobXSRXvF19NQlUupp6xy5SiWQ9DF3+h0/hZrimAKqM1MWAycsnUaI1dZqJIEoH8/v0S49hRyuCe2pmIwL3PG6l/5Z8X0NA09lU5BwsMkOU8fqt0qCrTDVU9LMM+hjHkkfzT8CbNCusLKkK1QJC9VIfZ1ag+bvPsWae3sgovu1VPeMPv1wr50enp1+dLL9S+s1v4oqxUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1ZQvN/zKJVdMITeQdE6jIqYT/IWpdjNS97lwaBqU1o=;
 b=vi0PZ+Y9ExKtq3DNSlBJ7NsW1d1b9PpDmF07Qy3jLQYOqifipebsjpzxrIEuI8HSqmhAbvEfcJ1BaDkeoIk8C0xNsO0yEZn62ewSj7HZExPpPDpCEdGWVX0f5njgXX5zDx29mSh2eUIU3NMhcyIXoTaY/DG4NrB869zO6QB2vpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWLP265MB2051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:67::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 20:22:42 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 20:22:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 21:22:41 +0100
Message-Id: <DJ5NE8Q0PG6X.1Z63LDHA2Y95L@garyguo.net>
Cc: <peterz@infradead.org>, <zhiyunq@cs.ucr.edu>, <ardalan@uci.edu>,
 <pgovind2@uci.edu>, <dzueck@uci.edu>, "Yuan Tan" <ytan089@ucr.edu>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] rust: sync: avoid leaking the lock lifetime from
 Guard::lock_ref
From: "Gary Guo" <gary@garyguo.net>
To: "Yuan Tan" <yuan.tan1@email.ucr.edu>, <ojeda@kernel.org>,
 <gary@garyguo.net>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260605022400.31489-1-kentertan12138@outlook.com>
In-Reply-To: <20260605022400.31489-1-kentertan12138@outlook.com>
X-ClientProxiedBy: LO6P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::17) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWLP265MB2051:EE_
X-MS-Office365-Filtering-Correlation-Id: 345cd074-5eee-4de3-c960-08dec72e0665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|23010399003|366016|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ByLwBfy0FGB3Sy32J8JsB/SoZ262wOXkWJyaeR2I2cIaigQdjGcu7RjtvZ9fyufICW6IhDd+t7SLPV0G200vdKeFUdAZwzhb4hn65epw0fuaH1gABV8FiHWBAtRYeC7qSwBZJLnTviPao5KwzCtbIcs9wYPRPQnp5QZXect/p4U3JKmR2aewBpldlXvVJG23w8RSucHaZSekvmh0Q6aMsTxDokCR0LomSpC/mYhhWTKFIJx6PXbP9Ug/+kUZOTu6IjZlfBtQvPhGtwF4n/UST07g4Frf218XECQvryCNm95V1rgL73LWnByax8tUwkas+ovU/KLfEMdxRcv3kFDVoMi3fBlzK+vhBp9FZPjWSST7I7FEc9UO+COLsxcFjEBLBRZlW9+2JS+igIJ+YZDiiHE9I0IEr1WazCQ/q50PRFFhJ/1qZwipzCHphsOFZF2YmRrRfLcn+iHr6YbAer68dS47/lm2FnDOg3QZhSd+sjDoP56Uqxo02+4+fbFCTjAc3JL4P6ZkA1n/FvgQgmOkHH6xwFDr3w1R0vYpAcUlLqIcajjIiYUFfeH8Cb6WencXyW0KDvwqwj20gvjj78QwPUMmq4xCeCTB7gOI0nBewJPZyltVe4KoklpVwL8JzqQMlYFF8sPeJs2cfLgVxdi6sKkRXLoC4Z9r4Dz19dhpJ2gPm7DXmFVV9z5xMkSCsFa9VynUaQ5oR1qsCeS1LUc5JQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkVaQSszdGtPUTVqaVdRRCtpcGVaVEZ1a3ZNbzhCVGU4Yk9IK1dzNzhYOUFv?=
 =?utf-8?B?WmlFSVo3UjNRUnV0YTUyWWhMbmp4SmM0bTZlV21OOFQ3SkNHbks3KzUwckpC?=
 =?utf-8?B?YWdxTXBjVkwybjZjK21henUycDZlUUdSSWRFZENSUjlJTTMrdUVCYXpsMC9F?=
 =?utf-8?B?V3hGVDRNYzFleVJZcDZWRS84bTc5N3psQko3dmt4THZuVHl0bW91cmtubC94?=
 =?utf-8?B?bkVIOEJHUkpKM2lMdzVaWHRrVnVITlg2ZXRZK0JCcDF4UEVyTmM0c3BORTcz?=
 =?utf-8?B?VkdqZjd4UFVOYTZFMExzdXQyenZFbFYxbXg3MjNkdWVFZ05aemM1d3RQYUVt?=
 =?utf-8?B?dlRGcDZhdFZ2OVQ4RXFVb0t3Nm44YlVYdzd0QVhCWUZxZVNObXJ4R1dMOTN1?=
 =?utf-8?B?YWhRN3pRM3VOQi9USGpHemlFVTBKWnA2UkNPUEVZWXZkS2VqTXNzb0ZZVXlh?=
 =?utf-8?B?MVNZRCsvTjhSbi80VXZ4VlFYWjFvK1JreElOSUp6U2lsTzY0dFlFTUZIQWJV?=
 =?utf-8?B?Q055MzhEZ0NaV0xWOTg0Qk9KeUJzcTIzVmhFeG1McUpvRnhpNXF2aEkyV3lj?=
 =?utf-8?B?SStBRzNobW5WbkVPU3d5RjY5R2J4ZXozSnQ4eWdvYTlleHgxK1BHZXBacTNo?=
 =?utf-8?B?anRkVmZOQTJ4ZUZKcGlWQyt1NkpVYmZGMDVqUFNPNC83S1lYSHEwQnlBM1NW?=
 =?utf-8?B?dnlyZGh3YUh6TDdRMFFVV0llTTF5VU1TOE1hMTF0RnBrRHl0elNydldweGRw?=
 =?utf-8?B?dFNESDNYMnNuL1N1dld1bk1ZNnJsUkVKazl6d1kvV3VPb3A3NHNsbG5VS0ly?=
 =?utf-8?B?WS8xdWkxeFQ3SHFhUnUrbW9BNWFDdFRxcmlFTnk3V2c4VStOb1p2SEZrVEI2?=
 =?utf-8?B?MzNpdG03TzdqNHFZVmMvTjhXNUkxKzBCK2lNL0JiNUFxaTVTVmp5TTF3eVBC?=
 =?utf-8?B?R3NNMS84cjhrYUdWZGxvSC9MdmdwVUkvWFBwaDNIUlcrekZubGpsN0I3djla?=
 =?utf-8?B?aDg3bmFnZ3RuU1VLSEVWL0h6Q3JZaml4Yjd3bUdjWldSOFZ3Uy9DaklPY0x4?=
 =?utf-8?B?d2U2THFQR0JhRnVsYUVoSkVxT3czRk9SUVpHQnhjREFZbmV5MlRXdE14ZmRv?=
 =?utf-8?B?U2s3cWtTeUpINzQ5Wmt4QXRpdVZqR3ZONFlhcFliUEkxd1c2bCtSNmYwa3BN?=
 =?utf-8?B?V3RaTGFwUEljQWpNN2tlMkJXR1FKNENlSkR3SFc3bnAwZXdmQTV3eElUUHBy?=
 =?utf-8?B?WGtSdW5ualZvRWpYRVFmRjBIM3FMZm1qeGZ6RG9NTGJlU04xbDQxOGpUd1ZD?=
 =?utf-8?B?T3d0NkJBVXZ0ZTYzTWcvMzl2OHFoMEFYZTQwek4xVzZ0eWpRQ2czVVp1Q0tJ?=
 =?utf-8?B?U3M5RDd6NHVnSXVpZFlEbk5wOGpKS1J0QittZDhHVU1DWUlQV1paWTA4ZW9D?=
 =?utf-8?B?L1FiZlg4V2VRb1pzSFMraTlYSmdibkFRSWRTc3Q1YW94YzR5cmlFMm85MUdT?=
 =?utf-8?B?WE1JbldVaHBHZ3c1MUNUdGQzZ0p3endaeFgrMEhlbFJycDZhZmV3Q3RwbHh4?=
 =?utf-8?B?MTN6ZGRNNi83RmUwUVZTWGtic2w0d0Y3UDBnbkRSSkJwdWNyU2psYjVBUWlL?=
 =?utf-8?B?OTU0Z2xlak96NDA5ZHc1Y0xWYlpzZUlWR3dOTXVsbXFRRGpjUk5QdklFZmo4?=
 =?utf-8?B?WmsxMUllWW1IQzdmNzlGWnFFd0tBQjUvaUJUSkNCRS83UmFlV2xRT2dicFlw?=
 =?utf-8?B?L3h6bWE5TGxQNU82aEZXQnFtblNtS1dsVmRmVFA2K0tzaWo0aHUxWkdqNjFj?=
 =?utf-8?B?eUFqMjRSZ0Jhd2tnUW9SRzNIRTJmc1hFZk1MRFRTTHhLcU1vVTRPblBJRVZp?=
 =?utf-8?B?ZStDbGczK2E4WEZraTFEbjZ3djdnbkgreWsxK2xiM1UyQ3ZlZ01OdGdqUzVr?=
 =?utf-8?B?d3kwQmZMTld6bmk0SUc5T3pWVUlOTkI0N0JMRnZSWExtMGFBeDNHdFUrZnpL?=
 =?utf-8?B?Zzk5Yk41MFlqcHpJcmlMcmdkSERYVWpkRWVWeFdkN0E2WUdmZzI0VjlnL0ti?=
 =?utf-8?B?VjRHQWVEc25kMGpCSVQzZHhNMC9TL245OCtiNVZ1UXlEUVdDR3U2bDhoYStx?=
 =?utf-8?B?ZlJ1RlJWL0NKK1VNVkNIc095T1d2Q0ZoRW5WbWpnRmc3TVpvWndORzNzSS9F?=
 =?utf-8?B?eHF3TTJKOWp2NGZoMWNRL2lnTko5KzVvTjVVWUplYlBpUTNCaUVMZDhFZVBu?=
 =?utf-8?B?NWlkRk5tSXRXZDZPYU9XVURJT0FqM0dlNWd3VlhHOEZqelAxK3V2ZkZwejFj?=
 =?utf-8?B?aFVUVjdqV3hPaUkySjk1L3BnbmtKbDdLRk1QSCs5SnhvMVkvOGRTQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 345cd074-5eee-4de3-c960-08dec72e0665
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 20:22:42.4305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKB+faOnPGpORolgK/p9pjB8gqGBj1c+DCkk47tEr5g+FXNBizUeqlwlLf2ewM4AaVeifNdX8wK2DIT+Am7JAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2051

On Fri Jun 5, 2026 at 3:24 AM BST, Yuan Tan wrote:
> From: Yuan Tan <ytan089@ucr.edu>
>
> Guard::lock_ref() returns the Lock stored in a Guard. Returning that
> reference with the guard's internal lifetime lets safe code keep an &Lock
> obtained from a shared borrow of the Guard after that borrow ends.
>
> That is unsound for T that is Sync but not Send. Guard is Sync when T is
> Sync, so a shared reference to a Guard may be used from another thread.
> However, Lock<T, B> is Sync only when T is Send, because a shared &Lock
> lets that other thread acquire the lock and obtain mutable access to T.
> Leaking an &Lock<T, B> from &Guard would therefore let safe code share a
> Lock whose Sync requirements are not met.
>
> Tie the returned reference to the borrow of the Guard instead of the
> guard's internal lifetime, so callers cannot keep the &Lock after the Gua=
rd
> borrow ends. Also require Lock<T, B>: Sync before exposing the lock
> reference at all, so Guard<T: Sync + !Send> remains Sync only for accessi=
ng
> the protected data through the guard, not for sharing the underlying Lock=
.
> Make the guard fields private as well, so crate-local code cannot bypass
> the accessor and recover the longer internal lifetime directly.
>
> Fixes: 8f65291dae0e ("rust: sync: Add accessor for the lock behind a give=
n guard")
> Cc: stable@vger.kernel.org
> Reported-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> Reported-by: Dylan Zueck <dzueck@uci.edu>

To me it looks like the bug report (and likely the patch too) is LLM genera=
ted.
You need to disclose it per
https://docs.kernel.org/process/generated-content.html and
https://docs.kernel.org/process/coding-assistants.html.

This is also not the correct fix. I am not sure how the lifetime change is
needed here at all.

Best,
Gary

> Signed-off-by: Yuan Tan <ytan089@ucr.edu>
> ---
>  rust/kernel/sync/lock.rs | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 10b6b5e9b024..6c4ebe7c6072 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -199,12 +199,14 @@ pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
>  /// protected by the lock.
>  #[must_use =3D "the lock unlocks immediately when the guard is unused"]
>  pub struct Guard<'a, T: ?Sized, B: Backend> {
> -    pub(crate) lock: &'a Lock<T, B>,
> -    pub(crate) state: B::GuardState,
> +    lock: &'a Lock<T, B>,
> +    state: B::GuardState,
>      _not_send: NotThreadSafe,
>  }
> =20
> -// SAFETY: `Guard` is sync when the data protected by the lock is also s=
ync.
> +// SAFETY: `Guard` is sync when the data protected by the lock is also s=
ync. The lock reference
> +// returned by `lock_ref` cannot outlive the guard borrow, and `lock_ref=
` is only available when
> +// `Lock` itself is `Sync`.
>  unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
> =20
>  impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
> @@ -219,7 +221,7 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
>      /// # use kernel::{new_spinlock, sync::lock::{Backend, Guard, Lock}}=
;
>      /// # use pin_init::stack_pin_init;
>      ///
> -    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lo=
ck<T, B>) {
> +    /// fn assert_held<T: Send, B: Backend>(guard: &Guard<'_, T, B>, loc=
k: &Lock<T, B>) {
>      ///     // Address-equal means the same lock.
>      ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
>      /// }
> @@ -234,7 +236,10 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
>      /// // `g` originates from `l`.
>      /// assert_held(&g, &l);
>      /// ```
> -    pub fn lock_ref(&self) -> &'a Lock<T, B> {
> +    pub fn lock_ref(&self) -> &Lock<T, B>
> +    where
> +        Lock<T, B>: Sync,
> +    {
>          self.lock
>      }
> =20


