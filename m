Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2AD1A6835;
	Wed,  9 Sep 2026 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940160; cv=none; b=ZqFno8spsGrGJCa8KA3zVQLGjX8QDXNI49WodrLwev9ga3MAhCxymvtUOx2V0tGHht9gxuFmVtDdKZAAxOAWGt8a3ji6sf14IihH6/ULdMgsYr7NpCZAHG/gIarMtQagZkpkVyrd9EgevUtRLXX/nBSBZyhBmYtTcoeOEWWsUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940160; c=relaxed/simple;
	bh=0uIdegXlGCDD7vAxvb8llLpTuPgZpjk/VvtpaggYSyQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L7A1VevxtNFWvvyj0rM7ULplh+tRkOf6mjJuCRXgveqFphMMuzSPFwEeY/L5VE9g74SWkqXZtWF9qr1tsx3fRosnuNUrr5kW05bLR6r41jE1abeMILICR+mHUGqpHoOxuxNQq/tOoRmXm/arBW61+2hcG8F2WpXDWtlDbFUrfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=CV2yIYLm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJ6YQO3A; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="CV2yIYLm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJ6YQO3A"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B688C140006D;
	Wed,  9 Sep 2026 03:49:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 03:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788940157;
	 x=1789026557; bh=4NH7DFSnpb/q5t7A1jLrPBi5gmQR/IXFpF+VKe1QfMQ=; b=
	CV2yIYLm2RdszT8QHVjHywN0JNSd0a1jqBC2kyGfKEFyih/8aRkJxw2PmvAA/r5K
	fL+U33crudoqL/cNyYbxrvzs0r1yxZP7Zaf00N2rqOD6/BGBe0E+S1XXd7wnDuLg
	UQ+nSp7xSfDN1mr3kdQBy+iI+X1oUt3qXqf+PIExDL6vGT0W2GmzyGPU3TiRkdWB
	SQQtejMVNQNWPQ9R5NipiH/tvUQVVajSF/BmAL/ZwfXLPzjk9+JvgwofXDRwXaCw
	hyuGv0Pc/naYeJ0t9okaUq5hW3CwDl8kya/7tZD3uieYNjixoD93+wONM1B8ZMX7
	phEE6TkONuGM5h/W7uu4Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788940157; x=
	1789026557; bh=4NH7DFSnpb/q5t7A1jLrPBi5gmQR/IXFpF+VKe1QfMQ=; b=Z
	J6YQO3Ag5qzao5xrpfrzYXALE5WeOwxgXaDww5WK7awkeoBCJlsurcmFdvs1run9
	NPHA47Z7xAbMeCaPrG+DSaqA7Vz44yrR00bmv0mu/yMtlP4XfguzjCpxPGgjVAfB
	WTKogzYndd1y0ooPEeVAzxuyqIKemx7mxsbMkcigIylbbe6L+lVNEKzLPo7bxrEm
	1XhXQnHHd6sDVc+Byzy/YWIb94tgy9qD0xHxx791RA3alj6LnQ8M8Jj+YvqvhV9L
	IazDXD42FDoYerIOjFz5uPQKvhOAJilKJydkKwIbnWJnr9xFrQ68NUadyqLmoqxA
	dIC54ISV+53Q9rw9vzunw==
X-ME-Sender: <xms:fA-hamyj8Ed7VEXsuaSYqWqMNLNR807LHiGS1ooPP9TB-V-Xr3KDCQ>
    <xme:fA-hajMbEWDd5-7WaY521XW6-IPE46-otpsXHLk5vx2pufZ4h68hOBlDWFGDAa_n3
    DMWbxVRYdQ5ff1YMVILXOlp_2TUJv5vno-kyYisP7HFIFQKjDd7dKI>
X-ME-Received: <xmr:fA-haopsaXHbzSNaZh8InI1oV1ppwB27-SZdPpchbaIuzzPGoOuZRKv8hd6liszJEjjpoe4oNoY0F4LiHO0d1CLB>
X-ME-Proxy-Cause: dmFkZTFyZJtxQHxEmKA0c5uw898wco3bNEi1GS6gdG5Oc3TwCXmt2VDbWlwEfVvjod3bTi
    ej2qcI6R8AaHLpcR8MaL9hBl3L0w9yYDYBdc/mnV26rPzluX4ERNPuEYkt8LRIIS7Qc6Dp
    CYKjFEVbR5zB3ADMCYO9P02FH4m/gxawY4tE3Y5ffsgl9U4eppfKgFJrk10Va2AZOqYeP2
    uR7+KPFR1L205E3DFAv8Yn9RJRIl71YPkH13TKCoaxCDdB51j6K7xAThOicVf1GTLV4RA/
    DlT896CkZ0Cf32yH+zH+WQLHFcAgJDq+MJt4z9XKLUh7ZSBmRpCN5dteBkkg3ORZxXpHJQ
    74XmbGbTeJIugU/lRym/CZtYYsLxjiHcubyr9IpVDuv+C3Z06Pv7sMMyfb11fs96yR6Msv
    z3fpHdLvXta3tdwUpSO/A/R6ba3oAQdr8IePTMR7x2XeMwAt2iwNiMxNalN12RjY1BR112
    ER4MEJAtU1DL/ttZ1vdY2FYdM+9U7sZiiUrlTCFYfpefmlw7Sn/r8A1yeJ4UWjHBXNqAlD
    dewigh//NaSDwJK7zpKLsjjBgucoBtB7mrbwW0Ox/KKgHKnGewMzALtZ3fCiuzjtkJtWrM
    EVpGIM7k95F/6CSNUxwJsMTKUrsnMRU60OEvpYLMvqPxv37084rGrU95+SkQ
X-ME-Proxy: <xmx:fA-haq_8IGomnwdjNcAzHD9uJZpmXxNIceyBV_wK9At2uhHX0Sc-Lg>
    <xmx:fA-hau1yWkBiYB2HG5xVx2CkVAl0dB9jJYoL9K-1H2I2xD48cZ3ZSg>
    <xmx:fA-hatCbhGu1Ua9lUPu_GBwHH3dYCkMFgfzdaFUqUjqJHw9uJq9SqQ>
    <xmx:fA-hatDTFLKSDSuVIJzc6hQCSRQTP3tn3237OdqGRxH_GwaKupFz8w>
    <xmx:fQ-hatOr-6IeIXRzXF7wq_q9pntwIg29vxguZ3p81OaPzwxDD9Mp1SXE>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 03:49:13 -0400 (EDT)
Date: Wed, 09 Sep 2026 16:49:09 +0900 (JST)
Message-Id: <20260909.164909.180036819630013679.tomo@flapping.org>
To: springbreeze@stu.pku.edu.cn
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, rmk+kernel@armlinux.org.uk,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 fujita.tomonori@gmail.com, tmgross@umich.edu, stable@vger.kernel.org
Subject: Re: [PATCH net v5] rust: net: phy: fix off-by-one bit positions in
 device status accessors
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <20260901143251.136378-1-springbreeze@stu.pku.edu.cn>
References: <20260901143251.136378-1-springbreeze@stu.pku.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 14:32:51 +0000
Chunfeng Song <springbreeze@stu.pku.edu.cn> wrote:

> The hand-written bitfield offsets in is_link_up(), is_autoneg_enabled()
> and is_autoneg_completed() were correct when the abstraction was
> merged: at that time autoneg, link, and autoneg_complete were at bits
> 13, 14, and 15 of struct phy_device's first bitfield unit. Commit
> 2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct phy_device")
> later inserted is_genphy_driven just before autoneg, shifting the three
> fields up by one, so the accessors now read:
> 
>   is_link_up()           reads bit 14 = autoneg
>   is_autoneg_enabled()   reads bit 13 = is_genphy_driven
>   is_autoneg_completed() reads bit 15 = link
> 
> The official ax88796b Rust driver uses all three accessors in its
> link-change handling, so it inherits the bug.

"link-change handling" is ambiguous. The driver uses all three accessors in
read_status(). It also has a link_change_notify() callback, and that one
uses none of them. Can you say read_status() instead?

> On genphy-driven devices
> is_genphy_driven is always 1, which masks the broken
> is_autoneg_enabled() check.

I don't think this applies to the ax88796b driver. phy_attach_direct()
sets is_genphy_driven only in the `if (!d->driver)` branch, the one that
falls back to the generic driver. The ax88796b driver is a real driver, so
d->driver is set and is_genphy_driven stays 0.

With is_genphy_driven == 0, is_autoneg_enabled() reads bit 13 as 0 and
compares it against AUTONEG_ENABLE (1), so it always returns false. This
code never runs the following code:

        if dev.is_autoneg_enabled() && dev.is_autoneg_completed() {
            dev.resolve_aneg_linkmode();
        }

> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 956cda573ddb..256f939c5098 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -123,39 +123,43 @@ pub fn state(&self) -> DeviceState {
>      /// Gets the current link state.
>      ///
>      /// It returns true if the link is up.
> +    #[inline]
>      pub fn is_link_up(&self) -> bool {
> -        const LINK_IS_UP: u64 = 1;
> -        // TODO: the code to access to the bit field will be replaced with automatically
> -        // generated code by bindgen when it becomes possible.
> -        // SAFETY: The struct invariant ensures that we may access
> -        // this field without additional synchronization.
> -        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(14, 1) == LINK_IS_UP
> +        let phydev = self.0.get().cast_const();
> +        // SAFETY: By the type invariant of `Device`, `phydev` points to a valid
> +        // `struct phy_device`, and the caller is in a context where this access
> +        // is safe. The bindgen raw accessor does not create a Rust reference to
> +        // the C struct.
> +        let link = unsafe { bindings::phy_device::link_raw(phydev) };

The last sentence does not describe why bindings::phy_device::link_raw()
can be called safely. It describes the accessor itself, and the commit
message already says it.

link_raw() can be called safely here because the pointer is valid and
there is no concurrent write. The old SAFETY comment covers both.

> +        link == 1
>      }
>  
>      /// Gets the current auto-negotiation configuration.
>      ///
>      /// It returns true if auto-negotiation is enabled.
> +    #[inline]
>      pub fn is_autoneg_enabled(&self) -> bool {
> -        // TODO: the code to access to the bit field will be replaced with automatically
> -        // generated code by bindgen when it becomes possible.
> -        // SAFETY: The struct invariant ensures that we may access
> -        // this field without additional synchronization.
> -        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)
> +        let phydev = self.0.get().cast_const();
> +        // SAFETY: By the type invariant of `Device`, `phydev` points to a valid
> +        // `struct phy_device`, and the caller is in a context where this access
> +        // is safe. The bindgen raw accessor does not create a Rust reference to
> +        // the C struct.
> +        let autoneg = unsafe { bindings::phy_device::autoneg_raw(phydev) };
> +        autoneg == bindings::AUTONEG_ENABLE
>      }
>  
>      /// Gets the current auto-negotiation state.
>      ///
>      /// It returns true if auto-negotiation is completed.
> +    #[inline]
>      pub fn is_autoneg_completed(&self) -> bool {
> -        const AUTONEG_COMPLETED: u64 = 1;
> -        // TODO: the code to access to the bit field will be replaced with automatically
> -        // generated code by bindgen when it becomes possible.
> -        // SAFETY: The struct invariant ensures that we may access
> -        // this field without additional synchronization.
> -        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(15, 1) == AUTONEG_COMPLETED
> +        let phydev = self.0.get().cast_const();
> +        // SAFETY: By the type invariant of `Device`, `phydev` points to a valid
> +        // `struct phy_device`, and the caller is in a context where this access
> +        // is safe. The bindgen raw accessor does not create a Rust reference to
> +        // the C struct.
> +        let completed = unsafe { bindings::phy_device::autoneg_complete_raw(phydev) };
> +        completed == 1
>      }
>  
>      /// Sets the speed of the PHY.
> 
> base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
> -- 
> 2.43.0
> 
> 
