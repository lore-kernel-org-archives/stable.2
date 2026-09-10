Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E33BC664;
	Thu, 10 Sep 2026 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033406; cv=none; b=oWnMjp3urSpdcEjO5iGq8HlBftaSh7CTSWb8NGzvjcYoPlgcx0Hir/r/TVtmhZzUWXfQoYfvdkkUOFLjl99cdC0xju1hp+BjEwnWlW26OC44vq2tivBKfUCNNV8LJRZ3bsZcK19R2VhVTF230sZ8b4mitxeiMy/zROdvW6zLeGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033406; c=relaxed/simple;
	bh=+6oSOjLmvlGXeBraeldI93DGcjqsw53UdWyMNY0eAZ0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PeUQfoi8DEvYNZ0ZHu8p4LYpLu7BYgCw5QqauWJhnMZEuAsNQu2vOTzNzLjPqdFtg66uLwtte+gOlIT0L0hRG5Iu4JYCHMqeXUdq9R2hE6DyLs5QvxfMoidkTRz0CtDLcQM5oUKfOwO0nY1DQBnQeRcilfHF9tF9OHV2w4wrOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=J/z6XktK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZBetrq6h; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="J/z6XktK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZBetrq6h"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A2F8DEC01C7;
	Thu, 10 Sep 2026 05:43:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 10 Sep 2026 05:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789033393;
	 x=1789119793; bh=rGpCjTTaXk/1OjFn96aTdp97nAqNN9TOBbQgQXpBgLE=; b=
	J/z6XktK3lhj8a8wcp9Tzabwseta0a3ewoJAUV2PsGbmfn0eiveZ/YeV0mARlWj2
	OOLXIXfN/b7GaZXDVCZ9Q6YHKukJdBPNzYgBFDwp24JZ8cNfJnOCCvAIzEX4QQRJ
	T6ZBXXFZiuiT+JwicCTe/+XguMggG5QoQAnH+AmRsuntbtrGZEJ7QfR4eNjzqJqi
	yhvajAaaSz77I0PQ0NryE6vIppZrcxtBai/ROcgJhbbw5vGlIXHjUiLdLIehaU6q
	ORPSrFtJHeAuYdo088rXpoJirb9LgebfBaGak7CbKEBYnQot87msfBMwg/zbfGbL
	16H2HVhq+pwpa/LfXWXoAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789033393; x=
	1789119793; bh=rGpCjTTaXk/1OjFn96aTdp97nAqNN9TOBbQgQXpBgLE=; b=Z
	Betrq6h3syUZMPHebTfykwsXNxihHJOVuAXp2d7cOup+aPnodLBr5WfEPHvWC0wr
	uIE8GVr9+zjqbw8F23/+O2hwOCztjj2M2EhE6nIBLY52RJsGoqt/9U3/ljCYa675
	0yZGVLuGxIn9/o5z1pjjx9sMRwFl1YFa3gpWotL9CQis3S6Xg4qGAO4okOtn/TwW
	Mg0Qo0gwy+v+1rlGgBFfEVST5ldnkdaXH1uNhgrEvkgj1A1NkOFabVrSiD+4zOB5
	S9fJ0E7QZ9t9Mrt+8Nw8m+4Uo8y5n5Tmli/3xOv/GKCQGaxy0MZE/x+8NZ38S7Y/
	YyANE42O/AHXkIvFBxMCw==
X-ME-Sender: <xms:sHuiauOLbZf5D0OayaR55D-cymMRK2YFWbSAkfdTUBgGCY2UDYzawQ>
    <xme:sHuiat7_zvALGkmZxvNG4okfCUHbdjAR7IcxGqBAuf2s1ApDw6b9au19ZF9Tspgs1
    mPnifT4GsvRpy5RomzxbL1bTfAD39eGQuHYkUg6yQCZgBgIHTfNRoQF>
X-ME-Received: <xmr:sHuiallrWcUj6tdr5QX-N1EwfVJ6_Pd3VrhpnR8Ctz1mGVFR2IL5sdEyVgTd4hXHpiZzXlT2C7YWbtfP2OdhTdXa>
X-ME-Proxy-Cause: dmFkZTE16hG9w6wxs93DPArtrnIuDa+52j6xSwqM2XaR5vsTiQ3JKiRT5LuN88L6NZGGEt
    P4KQaKl2ykpDTdYt2Xdo+nlQTjPe9nNHq6pCMK5+cBYN30tCVZBu5YecwOTByoV7wTKnqd
    p/wdU/5EsZ3CGrzycP2asJcmkm6x2UMkByd+APfMi8gklxjiUANvaqcwhC3MIhZEOu5/Sg
    57nFqh/frQxdpvubOd4DxiUj7ozouSgvdHIjll3EIAHyBRNib+IYEN0Vzh3tdVHCrn7N/9
    +9w4YhMsNBDOzTDciy3S9tEDMCcqxH8NEDLvDK9YKqbeperSIZwSU1sYE8oQ5IuItT+GBe
    KUNhpTzSTP6DvmXKYoH9RatGrHJxMbotl0O9NZjeN1aATenK6BTwZdqXmCpmurH0DUQyfQ
    iUjeX74m0IbCKFhLXCOljGuFmyit2P3NIO/2UgJIHrzjRg36MskVvjg0BwSvSo+BLLKZCR
    f9Sa1N4nb7E0MSx2HKUx7j1Nv5URgyddl6KJvZJlseA4etTZ5CFdi+vdxetvifRb4C87Bg
    FdbU3BKsHEFPhcVvS239HNM63dgbUWFwxuB310geq5sbW1sa1vhtqGEwFM4ti+IjVKQmby
    bY7PPLgVtVipsJNKmSyIjlqVh4QQPf3+ISwstdkC6KE7beH/XQ+3EyR8RPgA
X-ME-Proxy: <xmx:sHuiatJ0Ei8tx3xzGBqFX8V11cXK0OcsDCrggxWn1Yc1VUVs_TZEcA>
    <xmx:sHuiatQLXieLhgD2BeEXByyan2d6i9LPvU9yLk3Eo-d8uKml0HgzMQ>
    <xmx:sHuiaitAYErpZKn0K4QA1gEYlacDlOJj-dN6P0dCx-HrzF6rlYKkGg>
    <xmx:sHuiao-QJ1mYwRTwH58kkjRn_Rifrk-Lt5LSVkz4xxL_Lp3hKJQEnw>
    <xmx:sXuiapJtYPJAcC_1tsKpBIqMnOQR15Bei_zCletiM1VwwYmhph1BA5Rf>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 05:43:08 -0400 (EDT)
Date: Thu, 10 Sep 2026 18:43:04 +0900 (JST)
Message-Id: <20260910.184304.1524423111546318369.tomo@flapping.org>
To: springbreeze@stu.pku.edu.cn
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, rmk+kernel@armlinux.org.uk,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 fujita.tomonori@gmail.com, tmgross@umich.edu, stable@vger.kernel.org
Subject: Re: [PATCH net v6] rust: net: phy: fix off-by-one bit positions in
 device status accessors
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <20260910055110.167110-1-springbreeze@stu.pku.edu.cn>
References: <20260910055110.167110-1-springbreeze@stu.pku.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 05:51:10 +0000
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
> read_status() implementation, so it inherits the bug.
> phy_attach_direct() sets is_genphy_driven only when it falls back to
> the generic driver, and ax88796b has a real driver, so
> is_genphy_driven stays 0. The broken is_autoneg_enabled() therefore
> reads bit 13 as 0, compares it against AUTONEG_ENABLE (1), and always
> returns false, so read_status() never reaches the
> resolve_aneg_linkmode() call.
> 
> The ordinary bindgen accessors take &self. Calling them through
> (*phydev).link() would create a shared reference to the complete
> bindings::phy_device, which is not appropriate for an object wrapped in
> Opaque.
> 
> Use the bindgen-generated raw accessors (link_raw(), autoneg_raw(),
> and autoneg_complete_raw()) instead. They retain the bit positions and
> endianness handling generated from the C layout without creating a Rust
> reference to the complete phy_device. Drop the hand-written numbers
> together with the TODO comment that marked them as a stopgap.
> 
> The raw accessors are only emitted by bindgen 0.71 and later, and were
> added at the Rust-for-Linux project's request, so this fix can only be
> backported to stable branches whose minimum bindgen version is at least
> that, hence the scope on the Cc: stable line below.
> 
> Found by a static equivalence audit (C2RustDrv, a C-to-Rust driver
> migration tool) that compares hand-written bitfield offsets against
> the bindgen layout of struct phy_device. Verified by building the
> bindings and checking the generated accessors; no runtime testing was
> possible without PHY hardware.
> 
> Fixes: 2796ff1e3dca ("net: phy: add flag is_genphy_driven to struct phy_device")
> Cc: stable@vger.kernel.org # Only 7.1.y and later (requires bindgen's raw pointer accessors).
> Link: https://github.com/rust-lang/rust-bindgen/issues/2674
> Signed-off-by: Chunfeng Song <springbreeze@stu.pku.edu.cn>

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Thanks,

