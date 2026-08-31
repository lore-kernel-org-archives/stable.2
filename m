Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68613391E59;
	Mon, 31 Aug 2026 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217718; cv=none; b=r6qBpSsWVe3KK1EfrpuPnllW5//znec4QDwzYEHBLAx4VnBU7/pc9JlGP8gXZ7aqAOocS7auJO8imhc4+Kib3RX1KyM0qB6LajWgt4tb9xIzYvlnWCQi1Lv/EbjTsUHvSX0cPZrtHa8H+LlafpAOBBLVU3QxzLeHaoQ61jRSLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217718; c=relaxed/simple;
	bh=si4nfzQKobwAWhCHXycCi+aHA+aJpvaIwHyzrOKQLUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRnK+LUvBx8ftQmQHYIn1uc7xYaQKSk2q4nNphhf/l30aZWw5Zk2ymqrRLOlVDEcU3/yE5Q1rGugXZ+14RbRX+we64e4traEgYZyyDhaArnAJDXQ1Vp4qjBySXcC9xtf3Pll3xCsLapHtzGyM/Q47tCIUlc/a+ty8GXTqahQbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg0Z/wH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg0Z/wH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BF91F000E9;
	Mon, 31 Aug 2026 23:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788217717;
	bh=GtfBHxTIDD1ugdSqWBTJa3a6H0kN/BtZTPNQKhcmieY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zg0Z/wH8uVkGp+KS1iMUzY2mCcH4Pr4RMMw0hyFTFeeDsL26hHrVIdLBjxfRFy3b6
	 rY5j6pJSKl3MvssWqGHl4U4YrYiK85Y4SW1sfQhE2zMf2AHPTW0t5rUZVC5C1q08vf
	 pBoSNn3Bd8BierxA2uIii7sjfNryVDFfq2OOm0xAUD6qSsxOF20g/rjGd9536OKGKE
	 sam11ICa2awX+MSFMsT2PM/1XzLeU8OInqZhF6n1deLuVZunrW5Xc5LDGqLIcNzu88
	 d5jkOWiNH0SHh/EbHpMjnSgxfoU4NSISmGGnBHHmiOLMLjBIckPdaUMTs6bvpDINQK
	 OMkZ1oVulmZGQ==
From: Jakub Kicinski <kuba@kernel.org>
To: springbreeze@stu.pku.edu.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
	fujita.tomonori@gmail.com,
	ojeda@kernel.org,
	boqun@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] rust: net: phy: fix off-by-one bit positions in device status accessors
Date: Mon, 31 Aug 2026 16:08:35 -0700
Message-ID: <20260831230835.1436976-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825111334.795732-1-springbreeze@stu.pku.edu.cn>
References: <20260825111334.795732-1-springbreeze@stu.pku.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
rust: net: phy: fix off-by-one bit positions in device status accessors

This replaces the hand-written bitfield offsets in is_link_up(),
is_autoneg_enabled() and is_autoneg_completed() with the bindgen-generated
link(), autoneg() and autoneg_complete() accessors, so the Rust side no
longer depends on hard-coded bit numbers for struct phy_device.

> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 956cda573ddba..14dd1e6cb3802 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -124,38 +124,30 @@ pub fn state(&self) -> DeviceState {
>      ///
>      /// It returns true if the link is up.
>      pub fn is_link_up(&self) -> bool {
> -        const LINK_IS_UP: u64 = 1;
> -        // TODO: the code to access to the bit field will be replaced with automatically
> -        // generated code by bindgen when it becomes possible.
> +        let phydev = self.0.get();
>          // SAFETY: The struct invariant ensures that we may access
>          // this field without additional synchronization.
> -        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(14, 1) == LINK_IS_UP
> +        unsafe { (*phydev).link() == 1 }
>      }

[Severity: Medium]
Bindgen emits the bitfield getters with the signature

  pub fn link(&self) -> ::core::ffi::c_uint

so writing (*phydev).link() auto-refs the receiver and materializes a
&bindings::phy_device covering the whole C struct, not just the bitfield
storage unit that the previous code projected with
&(*self.0.get())._bitfield_1.

Is forming that whole-struct shared reference allowed here? The pointer
comes from an Opaque, whose documented contract in rust/kernel/types.rs
says:

  /// * The value is allowed to be mutated, when a `&Opaque<T>` exists on
  ///   the Rust side.

and the Opaque example reads fields through the raw pointer
(unsafe { (*ptr).val }) instead of taking a reference.

Concurrent C-side writes into the same allocation look possible while a
PHY driver callback runs, none of them covered by phydev->lock:

drivers/net/phy/phy.c:phy_interrupt() {
	...
		phydev->irq_rerun = 1;
		disable_irq_nosync(irq);
	...
}

That is a hard IRQ context write to a bitfield member without taking
phydev->lock. In addition, the embedded state_queue delayed_work is written
by the timer softirq and workqueue core, the embedded mdio.dev kref is
bumped by get_device()/put_device() in phy_device.c, and the internals of
phydev->lock itself (wait_lock, wait_list) are written by contending
threads.

Would reading the bits through a C __rust_helper accessor in rust/helpers/,
or projecting to the bitfield unit via a raw-pointer path, keep the goal of
dropping the hand-written offsets without forming a reference to the whole
struct?

Also, the retained SAFETY comments still say "we may access this field",
which no longer matches what the code does. Should they be updated to
describe the reference that is actually created?

>  
>      /// Gets the current auto-negotiation configuration.
>      ///
>      /// It returns true if auto-negotiation is enabled.
>      pub fn is_autoneg_enabled(&self) -> bool {
> -        // TODO: the code to access to the bit field will be replaced with automatically
> -        // generated code by bindgen when it becomes possible.
> +        let phydev = self.0.get();
>          // SAFETY: The struct invariant ensures that we may access
>          // this field without additional synchronization.
> -        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)
> +        unsafe { (*phydev).autoneg() == bindings::AUTONEG_ENABLE }
>      }
>  
>      /// Gets the current auto-negotiation state.
>      ///
>      /// It returns true if auto-negotiation is completed.
>      pub fn is_autoneg_completed(&self) -> bool {
> -        const AUTONEG_COMPLETED: u64 = 1;
> -        // TODO: the code to access to the bit field will be replaced with automatically
> -        // generated code by bindgen when it becomes possible.
> +        let phydev = self.0.get();
>          // SAFETY: The struct invariant ensures that we may access
>          // this field without additional synchronization.
> -        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(15, 1) == AUTONEG_COMPLETED
> +        unsafe { (*phydev).autoneg_complete() == 1 }
>      }

[Severity: Low]
This isn't a bug introduced by this patch, but after the rewrite
is_link_up(), is_autoneg_enabled() and is_autoneg_completed() are one-line
forwarders to a binding call, and none of them carries #[inline].
rust/kernel is an abstraction crate rather than a leaf driver, so the
coding guidelines ask for #[inline] on small functions that just forward to
a binding call.

The neighbouring accessors in the same file (phy_id(), state(),
set_speed(), set_duplex()) are equally unannotated, so this is the existing
style of the file rather than something the patch changes. Would it be
worth adding the annotation to the three touched functions here, or
handling all of them in a separate cleanup?
-- 
pw-bot: cr
