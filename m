Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6779D377EA7;
	Wed, 30 Sep 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780836; cv=none; b=qRuDBnqWdjNqVWUVOJPkULebryDguqW1h4aLIwdNAk8g8Vl2Tzz3/aPtSi4hG4+pzilsk2tfrEZEv6NB6mlBX8QjaP0zTGxTB6uhO6DvFn4mDRG30wjYL01qZbqXrdWWgFY8Ollv31FhnVcDWSXKpn1RkGq7qj53qVrnSs9X+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780836; c=relaxed/simple;
	bh=4RYQtrTyByMaLR/K3iG427DVCQsrqdlhcPpcha2V1oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3B5djCqMq3xEuMN7Smyfthal2gJTRri4tXIVa91YjDjvpL2fjgFHUxlVJ6oFMtHLGv7zN1mmB1i+J6ac9I4IR+p55vysiLZZgg6ENAWTZiwVkkVEciFT8yawTDGmRTnlIWNoG41ZgPNpph0oSsqz88RRalsvg1eizrQ5zFYcuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=GgHG7ulH; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="GgHG7ulH"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hvz0Z5ht1z6MjV;
	Wed, 30 Sep 2026 17:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1790780814;
	bh=4RYQtrTyByMaLR/K3iG427DVCQsrqdlhcPpcha2V1oI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GgHG7ulHvl5J8HNonh10bszOE9InC60PyWxVf4//Y+al4FCSbShmjBxsSu6nPZH9X
	 nP4Yudlwn7h6FPVRXsrlL8+tPNqn2YR+P/l/5+PpdSpHddPPOp9Ygqf+c5bBCchhIK
	 5yT7PS/9MOYVVmcTI/qBxYFv5gi7QaEGcLNZv8gjpNLve/Mv02XR7fSq6HOhGV3Xib
	 yhwHhEZdfrmoYlk/dEiXZd4NnP2+h9KhsICGN2pgM9BmRPhY5IAudbPPc701PLRO8w
	 5gxAvnoy3kOc6f1Ml1KnN1ctbIeHTGglVyBI4VuwZskko1w5UALff4IwpJy6w31ew6
	 EFrxbu7saLJ4w==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hvz0Z4wLLz4yjD;
	Wed, 30 Sep 2026 17:06:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hvz0W2n2Dz8tgC;
	Wed, 30 Sep 2026 17:06:51 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id BEBF15F8BB;
	Wed, 30 Sep 2026 17:06:41 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d1381ed8-eab8-4fd7-8b15-1e94876d7099@leemhuis.info>
Date: Wed, 30 Sep 2026 17:06:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL PATCH 0/9] Rust changes for v7.4-rc1
To: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>,
 stable@vger.kernel.org, Priya Bala Govindasamy <pgovind2@uci.edu>,
 Dylan Zueck <dzueck@uci.edu>, Yuan Tan <ytan089@ucr.edu>,
 Sophon Z <aiqubits@hotmail.com>, Qingxiao Xu <qingxiao@tamu.edu>,
 Malte Wechter <maltewechter@gmail.com>, Mark Brown <broonie@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
 <179068244058.1205226.1765319338142659278.b4-ty@b4>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <179068244058.1205226.1765319338142659278.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179078080275.1056943.224935166895197584@mxe9fb.netcup.net>
X-NC-CID: kbBO8J0k4cD0MZBqNVVuRQit6Wi9e3jYf30p7DpF3SVolywOZEA=

On 9/29/26 13:47, Jens Axboe wrote:
> On Tue, 29 Sep 2026 11:33:58 +0200, Andreas Hindborg wrote:
>> I have a number of Rust block layer patches I would ask you to pick for
>> v7.4. I have collected them into a patch series as well as a pull request
>> so you can use whatever is easier.
>>
>> The changes cover
>>
>>  - Style and formatting changes.
>>  - Documentation fixes.
>>  - Fixes for missing trait bounds that can cause API unsoundness.
>>  - A change to set the owner of the file operations vtable in `GenDisk`.
>>  - Two bug fixes for the rnull driver.
>>
>> [...]
> 
> Applied, thanks!
>  [...]

This series showed up in next today and broke the build for me on
various Fedora releases for aarch64 and x86_64; reverting this series
fixed that from a quick build test limited to drivers/block/rnull/

The full error msg is quote long, find the top of it below. Full log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-aarch64/11055137-next-next-all/builder-live.log.gz

Ciao, Thorsten

"""
> error[E0277]: `UnsafeCell<MaybeUninit<blk_mq_tag_set>>` cannot be shared between threads safely
>    --> drivers/block/rnull/configfs.rs:57:18
>     |
>  57 |     type Child = DeviceConfig;
>     |                  ^^^^^^^^^^^^ `UnsafeCell<MaybeUninit<blk_mq_tag_set>>` cannot be shared between threads safely
>     |
>     = help: within `TagSet<NullBlkDevice>`, the trait `Sync` is not implemented for `UnsafeCell<MaybeUninit<blk_mq_tag_set>>`
> note: required because it appears within the type `Opaque<blk_mq_tag_set>`
>    --> rust/kernel/types.rs:332:12
>     |
> 332 | pub struct Opaque<T> {
>     |            ^^^^^^
> note: required because it appears within the type `TagSet<NullBlkDevice>`
>    --> rust/kernel/block/mq/tag_set.rs:32:12
>     |
>  32 | pub struct TagSet<T: Operations> {
>     |            ^^^^^^
>     = note: required for `Arc<TagSet<NullBlkDevice>>` to implement `Send`
>     = note: 1 redundant requirement hidden
>     = note: required for `GenDisk<NullBlkDevice>` to implement `Send`
> note: required because it appears within the type `Option<GenDisk<NullBlkDevice>>`
>    --> /usr/lib/rustlib/src/rust/library/core/src/option.rs:598:10
>     |
> 598 | pub enum Option<T> {
>     |          ^^^^^^
> note: required because it appears within the type `DeviceConfigInner`
>    --> drivers/block/rnull/configfs.rs:130:8
>     |
> 130 | struct DeviceConfigInner {
>     |        ^^^^^^^^^^^^^^^^^
>     = note: required for `Lock<DeviceConfigInner, MutexBackend>` to implement `Send`
> note: required because it appears within the type `DeviceConfig`
>    --> drivers/block/rnull/configfs.rs:124:19
>     |
> 124 | pub(crate) struct DeviceConfig {
>     |                   ^^^^^^^^^^^^
> note: required by a bound in `kernel::configfs::GroupOperations::Child`
>    --> rust/kernel/configfs.rs:518:27
>     |
> 518 |     type Child: 'static + Send;
>     |                           ^^^^ required by this bound in `GroupOperations::Child`
> 
> error[E0277]: `*const blk_mq_ops` cannot be sent between threads safely
>       --> drivers/block/rnull/configfs.rs:57:18
>        |
>     57 |     type Child = DeviceConfig;
>        |                  ^^^^^^^^^^^^ `*const blk_mq_ops` cannot be sent between threads safely
>        |
>        = help: within `TagSet<NullBlkDevice>`, the trait `Send` is not implemented for `*const blk_mq_ops`
> note: required because it appears within the type `blk_mq_tag_set`
>       --> /builddir/build/BUILD/kernel-7.3.0-build/kernel-next-20260930/linux-7.3.0-0.0.next.20260930.545.vanilla.fc46.aarch64/rust/bindings/bindings_generated.rs:105198:12
>        |
> 105198 | pub struct blk_mq_tag_set {
>        |            ^^^^^^^^^^^^^^
> note: required because it appears within the type `MaybeDangling<blk_mq_tag_set>`
>       --> /usr/lib/rustlib/src/rust/library/core/src/mem/maybe_dangling.rs:73:12
>        |
>     73 | pub struct MaybeDangling<P: ?Sized>(P);
> [...]"""
