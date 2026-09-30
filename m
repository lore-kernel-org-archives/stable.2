Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA9443E28;
	Wed, 30 Sep 2026 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797814; cv=none; b=PiLf5ETrCjNwC53Y+XcoJ/Iy4uLn5m6Ilksa4WqMpG0y4evvTEvxbWIhyJI8rKEWx+EGgt4gTKssmO4YHINvsRd650579wTajfKBv4uR1HH0m/9wd4OLip5OjAwX+0ZTQlEoaxXAwCw932W8eWQYQGCllaD1u4+ZXcqJSy1k5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797814; c=relaxed/simple;
	bh=r64/YGNqeKa/6cWMFRJ2ShfQThhxpAU8t2rpVlkX/xE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQdOrWV9RnOpcZbFjSJk55SIxvmeiYqxcKYb5zdq/yaDN3nWQ5QiZ397iyXDIuS38J1GJIOKG2FGyoB3HORX8WyL7Q6BmYPinqiHp5rHFo0uyxWc6qwecdLGAAPqp38CRLbklgJQckQ/JTCw85VnQ1Tx5gqWbtx80oVQKpDcjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMCJ/Vfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMCJ/Vfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311641F000FF;
	Wed, 30 Sep 2026 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797811;
	bh=RdjWz/lV3EZK739lTtEqZ4pnzC5Y8vW4LYebFMoQQmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=WMCJ/VfnLq/+bhqf9NwAj05iZJwhJMSV9tlZ8zUMftderxjWUyAAMtL0oQ0DrWIn4
	 fcOYSZ3xUU4T6JdNQnTB/vCSrLNzIGd1JCKe0wXiAxgoSFZVECg18PNQPDJV5r/Cub
	 k2/miVS3iqdFK2jNmAskwfpOQCMkevMWPPjVQeaBdx5zO/3eqT7uUHkNigsht7qoSz
	 SZhsn1BniXa3ASqkWpi2vk8psvkLJ/kvjGV/hc8GUL4IlOj0sonyrm9c1bVWfziTBL
	 f7Nw/S7oB/B7dbFOP1ZUAKE3SAiI4zzBIgF129FB+jYGbtEq4fTPC0znG9akaphUqI
	 X/ixEouMTuZew==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Thorsten Leemhuis <linux@leemhuis.info>,
 Jens Axboe <axboe@kernel.dk>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alvin
 Sun <alvin.sun@linux.dev>, stable@vger.kernel.org, Priya Bala
 Govindasamy <pgovind2@uci.edu>, Dylan Zueck <dzueck@uci.edu>, Yuan Tan
 <ytan089@ucr.edu>, Sophon Z <aiqubits@hotmail.com>, Qingxiao Xu
 <qingxiao@tamu.edu>, Malte Wechter <maltewechter@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linux kernel regressions list
 <regressions@lists.linux.dev>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: [GIT PULL PATCH 0/9] Rust changes for v7.4-rc1
In-Reply-To: <DLSRC2ORPMSV.2W8O7S95JLAXM@garyguo.net>
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org>
 <179068244058.1205226.1765319338142659278.b4-ty@b4>
 <d1381ed8-eab8-4fd7-8b15-1e94876d7099@leemhuis.info>
 <DLSRC2ORPMSV.2W8O7S95JLAXM@garyguo.net>
Date: Wed, 30 Sep 2026 21:49:56 +0200
Message-ID: <87zewya597.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> On Wed Sep 30, 2026 at 4:06 PM BST, Thorsten Leemhuis wrote:
>> On 9/29/26 13:47, Jens Axboe wrote:
>>> On Tue, 29 Sep 2026 11:33:58 +0200, Andreas Hindborg wrote:
>>>> I have a number of Rust block layer patches I would ask you to pick for
>>>> v7.4. I have collected them into a patch series as well as a pull request
>>>> so you can use whatever is easier.
>>>>
>>>> The changes cover
>>>>
>>>>  - Style and formatting changes.
>>>>  - Documentation fixes.
>>>>  - Fixes for missing trait bounds that can cause API unsoundness.
>>>>  - A change to set the owner of the file operations vtable in `GenDisk`.
>>>>  - Two bug fixes for the rnull driver.
>>>>
>>>> [...]
>>> 
>>> Applied, thanks!
>>>  [...]
>>
>> This series showed up in next today and broke the build for me on
>> various Fedora releases for aarch64 and x86_64; reverting this series
>> fixed that from a quick build test limited to drivers/block/rnull/
>>
>> The full error msg is quote long, find the top of it below. Full log:
>> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-aarch64/11055137-next-next-all/builder-live.log.gz
>
> The `Child: Send` bound is introduced in configfs:
> https://lore.kernel.org/all/tencent_05937A22D2DA2BAE808EF19E491AA109BC09@qq.com/.
> So this is more or less a semantic conflict.

I did not consider the interactions of the two trees together. Good
thing we have linux-next.

> However, the fundamental issue is that TagSet never implements Send/Sync, which
> means that "rust: block: fix `Send` bound for `GenDisk`" will unconditionally
> strip away the Send implementation, which is problematic.
>
> Something like this should fix the issue:
>
>     unsafe impl<T: Operations<QueueData: Send>> Send for TagSet<T> {}
>     unsafe impl<T: Operations<QueueData: Send>> Sync for TagSet<T> {}
>
> That said, I am not sure why the GenDisk need to carry `Arc<TagSet<T>>: Send`
> bound in the first place. Removing it should also fix the issue.

`GenDisk<T>` has a field of type `Arc<TagSet<T>>`, so for `GenDisk` to be
send, so must `Arc<TagSet<T>>`. That `Arc` may be dropped with the
`GenDisk` if it is the last reference.

> Also, the `QueueData: Send` bound should be part of the `Operations` trait and
> not carried around everywhere.

`QueueData` is not involved here. An unconditional implementation is
fine. I submitted a patch here [1], hopefully Jens can pick it soon so
next can be unbroken tomorrow.

Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/r/20260930-tag-set-send-sync-v1-1-51acdb36f4bb@kernel.org

