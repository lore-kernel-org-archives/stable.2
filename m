Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89723F88BE;
	Fri,  7 Aug 2026 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142633; cv=none; b=VqDQZy9mpZKTcgqDOs6y6atEpkEgH6NU3r3rNhye2Ix408qQ/SZfez1CCuEg1fvTnaRZoV6MJ50uKmrAknz/qZKUsbZdXgKY1XaZwqnHVc55ydIH+Fkmjfxt21GsF4InKnczeHfBruZyaQDWzXKMFPkGL2JmFLx/cnt3UAERwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142633; c=relaxed/simple;
	bh=D8lIgPrgG6rAOPYKb8wrRvxHfHpo/BpToTVnvfTt6j0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RL8mkwblqNBjA1v9tRZou2yG99j51W/XAdtqmMrpTGvWOmkrvdszIyF4rdL36AWBNq2PoUwPlyVx02cf0EDMqBldf0ZBWQ4DqO+qTzFuh8gauQO49OoeOibQzeamfFKtb6z2CZsoulLQCxoa9ff8YNyoadI4r8o5c9QaBbU6Z2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=fXBdQgAn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PIYAonVj; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="fXBdQgAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PIYAonVj"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 5D31313001C2;
	Fri,  7 Aug 2026 18:43:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 07 Aug 2026 18:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786142630;
	 x=1786146230; bh=h/f00Z6KUstIES9yiLYFI4NCrcR5SeGiu9K0nWr0j3E=; b=
	fXBdQgAn+cpQG053rYeUyH9GrqcIinWLYXH3tdhyhI4K0HR3cUw7wVBOYGjyZdej
	qNdEyE1TOAFXfVEQN6ItCWLgXD8uASakQceqsLvEf7I9mNMxemUFWT5gWsSkwjzv
	z+5fkUK73RYSsb9K0tEcZmc1SoNcEAGESYfKDn+TzSF0GJG61VfcQ/moosOkwdzz
	UakzQQo4XYl25lTkcUXPF+KNK7b76fC3LugXHA0ekhyFzw8cW/OYnGOe46oFdLSb
	as9DbCCZJwAT6CpkZ52pSUhreP5cfRhgVB+rQ2UY4Z6I5Kd/7HkW/50RX2QcDar6
	XDbNzFVmmiFBH/8qUl5G9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786142630; x=
	1786146230; bh=h/f00Z6KUstIES9yiLYFI4NCrcR5SeGiu9K0nWr0j3E=; b=P
	IYAonVjpkOfE3Mw+VgjaAvcan5NwHoqxz0lsx7JKzNoFQZtILHvG9sbrUJPxmgI3
	5ROxZOOwLXLXzLyb8jq5gG1Q09tFaLnWxqYcmuLvHsecbOABwscv54x9nwGBiFCB
	U/Lq3ynwF8zXmlpYGwofGq6gPwT+UJGD+zNpMx5oaL6SeBi5qXz6gLxRcgHXZIbg
	6nU1vKWxjAJSSliJWqGNeqqUExu5jDYzdXMs6Wc6qF/VCvcNgnPqhJBzMrKxg/Ho
	Py8jGCyLDX2ZChXU7Kn7TixQtHtQBfeyGepzL0KGDmDvNf9CgTrqcRXFDvFVArP9
	Xr3xE37Ck1drtzY6Q/teQ==
X-ME-Sender: <xms:pV92ao8gIlSPqKA-P37qN2kGQ7tOuSX0NeyqhsCJ3XZE0oV0pisDSg>
    <xme:pV92aiby-BR5ks4W5mSw8MC3zZq_H0nIKmDMR5uizRom1tgnbGWhDpPOsm_PYXQIK
    E1PBvkrAVKFSrc2OeDI9WzCCPJS9z7jbO-SgeJdsuVEJ9P3UVWxhl0>
X-ME-Received: <xmr:pV92ahfvk8OAW-w2y48w6L5J9EM9K4uaJuQMfu_LnR4r-pxzChswNHY0DlrueqtaYCGyNTIUDS31L5OLANVBJAmr>
X-ME-Proxy-Cause: dmFkZTFNtd+sPmf/JeoA6PziLBAUf8s4YDDRZyJWi6VH4yI3jhHCvZda3JM9EEdCzEIeIM
    i9KDl853i6GsTQCS94EbjdZmRf2OOb9If/5js3+Onug5r3tYqLy/a8oiAUeMJ7Bc8oq9J8
    s4fh20cdfRN+rzuqNrpawZPCLG33R8XWJto4pZv5YIArQ6s++CwGMy1c0rxiahTgQzAfk1
    CxBeUkm4Q914HjWbzbYkFCCZx4XfS1o/ys33cLU+fhu1n9i1DzVsgihES0Cx0pr5bUDwOo
    qLuEFMl2oktFPU4K2zZFRKQhFIjCHbbrgcq/PLxdL0wldL4vbb52QzFCw3LqPyyDLPIqZ9
    ekRIDicbaYMZSEfO5NfCEZuQTVt6p6Fu8kzFPru016/1qQbnWQab6Hszr3nfnOEmFBbqx6
    RlNUTLBGvr5uTjTWy9F94+Wjds+jk1S+OkGl3qaRF/Ex1mZ8JmnbWsQq3aNIoTW9ifVlwJ
    2PVzN/PptQx5GXOJmD6BAny9/POuD08Rix/b02kv+xyOHS7Y7PmuF+DmajbPAwdPg4Y+L6
    ZH6fZ5Rw3Mni+66eqqpmWW9tpwpLx6SD0AXadGQOC8PysYPNVLi8GvOAPrBTl97U9Qz78d
    a/ISG5UF7iq3NxbdQXBHc+kiGsZkotNV/hxRiUkOJNflZ96DncwN33LshLwg
X-ME-Proxy: <xmx:pV92aoRsbuNVYA8eb1P42sDNP4FIgT27nt66SqQ_qHfClXvQvX9Q5Q>
    <xmx:pV92ajkpn5GLLHtoLhOy6qYt6KGr4VG_ZKmZoI3wgIXygFpQiylhGA>
    <xmx:pV92amtCPI-gL30rU3W1lnjCN1AVFDudqH7sDh5qxzq6P7Le1R5YUg>
    <xmx:pV92am9w0HsVp-82QjLA-1lstZjDcSFwFA9yRXmcfWy67dJ_xakmZw>
    <xmx:pV92alQXyHDVMvVThW5mTfV6oUo9wep1zrZCGPrYQRJxB_xKyeSzECpJ>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 18:43:44 -0400 (EDT)
Date: Sat, 08 Aug 2026 07:43:41 +0900 (JST)
Message-Id: <20260808.074341.1056015191905819805.tomo@flapping.org>
To: ojeda@kernel.org
Cc: arnd@arndb.de, krzk@kernel.org, alexandre.belloni@bootlin.com,
 linusw@kernel.org, chenhuacai@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, rust-for-linux@vger.kernel.org,
 fustini@kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@lists.linux.dev, kernel@xen0n.name, loongarch@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH] rust: bug: fix `dead_code` warning in `warn_on!`
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <20260807221429.155946-1-ojeda@kernel.org>
References: <20260807221429.155946-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat,  8 Aug 2026 00:14:29 +0200
Miguel Ojeda <ojeda@kernel.org> wrote:

> On arm and loongarch64, or under `CONFIG_BUG=n`, the upcoming SRCU
> abstractions from commit
> 
>   59cf3a5bda61 ("rust: sync: add SRCU abstraction")
> 
> use `warn_on!`, which in turn warns:
> 
>     error: constant `WARN_ON_FLAGS` is never used
>        --> rust/kernel/bug.rs:126:19
>         |
>     126 |               const WARN_ON_FLAGS: u32 = $crate::bug::bugflag_taint($crate::bindings::TAINT_WARN);
>         |                     ^^^^^^^^^^^^^
>         |
>        ::: rust/kernel/sync/srcu.rs:106:12
>         |
>     106 |           if crate::warn_on!(
>         |  ____________-
>     107 | |             // SAFETY: By the type invariants, `self` contains a valid and pinned `struct srcu_struct`
>     108 | |             // and `srcu_readers_active()` only checks the active reader count.
>     109 | |             unsafe { bindings::srcu_readers_active(ptr) }
>     110 | |         ) {
>         | |_________- in this macro invocation
>         |
>         = note: `-D dead-code` implied by `-D warnings`
>         = help: to override `-D warnings` add `#[allow(dead_code)]`
>         = note: this error originates in the macro `crate::warn_on` (in Nightly builds, run with -Z macro-backtrace for more info)
> 
> The reason is that `warn_flags!` discards both arguments in those cases,
> and so the `const` becomes unused. And since it is a macro, it went
> unnoticed so far.
> 
> Thus fix it by simplifying by removing the `const`.
> 
> Cc: stable@vger.kernel.org
> Fixes: dff64b072708 ("rust: Add warn_on macro")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Either this or adding an underscore.
> 
>  rust/kernel/bug.rs | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
> index ed943960f851..874adb93cdfe 100644
> --- a/rust/kernel/bug.rs
> +++ b/rust/kernel/bug.rs
> @@ -123,9 +123,10 @@ macro_rules! warn_on {
>          const _COND_STR: &str = file!();
> 
>          if cond {
> -            const WARN_ON_FLAGS: u32 = $crate::bug::bugflag_taint($crate::bindings::TAINT_WARN);
> -
> -            $crate::warn_flags!(_COND_STR, WARN_ON_FLAGS);
> +            $crate::warn_flags!(
> +                _COND_STR,
> +                $crate::bug::bugflag_taint($crate::bindings::TAINT_WARN)
> +            );
>          }
>          cond
>      }};
> 
> base-commit: dc01dfb37b34beeefcfe1c3055364d41a4070c7e
> --
> 2.55.0

I sent a fix for this bug a few days ago:

https://lore.kernel.org/all/20260801024841.786664-1-tomo@flapping.org/


If you prefer the simpler version, v1 might work.

https://lore.kernel.org/all/20260720035510.4048145-1-tomo@flapping.org/
