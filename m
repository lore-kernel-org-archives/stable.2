Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BB1DF248;
	Sun,  9 Aug 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236652; cv=none; b=ZufbEouLA/g0UZFrWK1StmmxHInUQKgDQMSQaEd43CpcOzKsJ0oFOFbQNwXA+2MBIGwvXDVT5Whm41RmV0stazyp0pz8vYwClbKbp/SlJGB71aQKqY/2Q1qB91CNEgQwj2FLyOwFBcn6SkhNQIq2Brv5yBVjsObPEIpHqfNpD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236652; c=relaxed/simple;
	bh=UEhJ4fOnP6NvvbztpOOHCgRbwBRf2/ifUuwzgPha3lQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qUTeSDWIbKZPLOEmJq6QZ5KxsRjEwQPBCYMHxFov/PicSFSDUu5ILd2D4BLUc25hiRiOgOEdYWPB3lJvj9ndOrDCdNyy5BOAXpsp+Y4Wp8bTR+qxxW/QSQ2cNIRE847i9RB9M1UnT/HIsVWTwzVZ2ehH/Tqu2uxjbc3dM2gFIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=NU29sH9Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cP0PZJUq; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="NU29sH9Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cP0PZJUq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id A53A813003E8;
	Sat,  8 Aug 2026 20:50:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 08 Aug 2026 20:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786236649;
	 x=1786240249; bh=xCkSTHTpye1HwdVm99z+AnyQrg5wWGU9aIxGyfSTlQk=; b=
	NU29sH9ZsRImhMnP8aT4p1yQuwbjPQGMO/KabwgRq2yYxQ/ry+1Z1Vn+aKswp0jA
	72ClGAM+RK0CQbBBeNZoFnugrY5/elsoMjjCUxL3pA5zBDlm6jLWNbqUBYL41f67
	qgDYhH/yx+ZZwLI3zLz4969SjC3Hkzs7OCF7+t7vBCb7HqeZjNkk229mhr6p/lmY
	ofVWspjaKMqFx4U7KFt0wkexc8lm5XJzdfsl9ynow10v4Z14sNyO3MeFVTcyLQA1
	WjDOG7H51LRjuwr8d4UA8IhwusSfUQ1QEcwc/NJhpbWu+E0RBf6I/XzedDPtAnCR
	ZukGehUwfRxEDr4N10drrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786236649; x=
	1786240249; bh=xCkSTHTpye1HwdVm99z+AnyQrg5wWGU9aIxGyfSTlQk=; b=c
	P0PZJUq0RL8Rlvcc1fesfcEMhNL6Ow9lK6nfrSGwEflLRYBFoLkzE1Yr5WMGJPYw
	6Ls8irExU3Ub5sFTx5NcKRAH5xucWJFNRRvkhBduzCdqecm6LWGDrXtoGpRlheXG
	UFpcHlztpRcjsaONfnp3vPT+8vfMpXaAfrIR19+vZMdYnDXfubUU4eupOvjcIaV4
	R95/pGjewQ23PSePQl443aNXWIfsQ3xYKTpj+NGD3gg7BeA8hkv88pef8q7vCOHc
	uIJqmRnetmYNvbFXUd9WY00og5FNwR45IRYTuMkmtVxMmUD0Ji1P5QW5iU0wfdhs
	WDeCMFaGEthDDbIKAxoWQ==
X-ME-Sender: <xms:6c53arGSkqmk3IqBNnnQ2VKcHffefbAAip61EJHMKqdmHgKe49MqKA>
    <xme:6c53ahqtvY3uC-Hfvkr5IP-xm6o0Pileb7gQNwccdKBZKzJzhBjqdpIQ4cylfo457
    xtuy5QOh6rmIIzNQtjutLHENNBv18XYy4-EnU7K8TUJ0q73feH64Os>
X-ME-Received: <xmr:6c53alJ5ES3-_J3P-YGMPLo--aGyaHVuglFfyg0kYfADERmZrUU2geEkMC3ojc-Ixuau59UkdNyymLQWD8k7HpOO>
X-ME-Proxy-Cause: dmFkZTEWyeKTFTOJEnerKErAGQhxs6jY8ZIIz/VM/JukQDWudLXGVHslkG7D0P1qYkOnvC
    p/N/lf6zobEs4R09BmnLvcyKb6KEUV8BUTXqUMer/pYJTS3yxadkjhC7zWSmUyqan7H6wr
    iOv96fl5zT6jrqOPwMso0ETzEouIFpNVaqEmeJP6dRigdDAu+IZwRJj3PRqh95KibXDSbH
    Of4jjPRZQoMGfXL2I60hA+xQxKCbr/Il0tBfaPmtJlZB/9gh2yaivzrZ+UEJhRUq2avrt/
    6MNUfnrwFjZeD8nPUgpooCWsWDJWaeXgePQ7pwjcD8pNyMNO3hgiId+X/6f2GyobvqrChX
    NgkPoQKFCUKOdPrSSKZZaMsWyrbXtBaD570Fno2K/4e5Nb5VitmSOsXELC6wzq1o+MMDWY
    BDRwN8HUmt9AECIMyFVNpR973AKW7u6uPbtbGxU+dTKN1KX7lX/ZxmF9ahMCplvW2k9Dce
    3Wj2yJqgmIm4lxeGRLk8czefQ+PqJVNwKyd2c5DDek8AwYdsaBtjBXoESSJCZL126CgnZw
    rh13jAEcLls9u8D5VHKwcbJvvTqbDM+mo/Yit0Ddsv8oXXiRSOEjzRdCiYx27+csmM/vgK
    hVPN/Z9TSjlgnoTExldLSqYJPnlu92K0CYW1f/ZUOTAU2VW0QljkT4ZNSYpg
X-ME-Proxy: <xmx:6c53aiyzFxtDYEEDIAstGaAJXGXzDY_IQtzrTj8ejlUY2ird5uDvow>
    <xmx:6c53asZ7ksw7NU9kx_h8FiWRleYvZnx3smz_-wtFzjvcNQJrn2sdMg>
    <xmx:6c53au7uETwpLa9d-ku27TH1Z02VJoAkMJxEJcp0Z_5NIXILFSfXrw>
    <xmx:6c53atClWOEO2nw6sx0n4TuPtVeL-p1G5s-AlrhTW5lZwR2IMp7Zlg>
    <xmx:6c53agQEeP9Ahk4NyUtA6jCafbY03DdegnZvbcQlkorROei3L2sIXvzX>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Aug 2026 20:50:43 -0400 (EDT)
Date: Sun, 09 Aug 2026 09:50:41 +0900 (JST)
Message-Id: <20260809.095041.602618436881623934.tomo@flapping.org>
To: miguel.ojeda.sandonis@gmail.com
Cc: tomo@flapping.org, ojeda@kernel.org, arnd@arndb.de, krzk@kernel.org,
 alexandre.belloni@bootlin.com, linusw@kernel.org, chenhuacai@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 rust-for-linux@vger.kernel.org, fustini@kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 kernel@xen0n.name, loongarch@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] rust: bug: fix `dead_code` warning in `warn_on!`
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <CANiq72m70uWCRFnhs3axdymSTGCirBrYAvKh2BiT0xqW2j_3jg@mail.gmail.com>
References: <CANiq72n4=fz=JNKY0Jdm8BnLa=RmHB2B7s0bO47YTJ7hygqBZg@mail.gmail.com>
	<20260808.143013.1251068388254615351.tomo@flapping.org>
	<CANiq72m70uWCRFnhs3axdymSTGCirBrYAvKh2BiT0xqW2j_3jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 8 Aug 2026 21:40:49 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

>> I posted a `cfg(testlib)` split for it:
>>
>> https://lore.kernel.org/all/20260808022608.1125174-1-tomo@flapping.org/
> 
> Thanks! It seems good to me.

Thanks!

>> While at it, a question: what is `rusttest` meant to cover when
>> `ARCH=` is not the host's?
> 
> `rusttest` is meant to run tests on the host, regardless of the target.

Then `jump_label.rs` needs the same treatment?

`arch_static_branch!` embeds the generated arch asm too. It is not a
problem today only because, like `warn_on!` until now, it has no user
inside the `kernel` crate itself.

