Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B5331ED2;
	Sat,  1 Aug 2026 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785576238; cv=none; b=fJ3ewFnv9VuMgqD52kHXKj+ueknMV0er4+wN4ggHOSiGVRdZj73DZAwY05XVJikAyK7OGCE6d7XveBHW3JYSDQ51uPjssy4hNyCupUhqGQcUMvGvBCjdWyvni9LwEHxY8Qia1E48TcE2N1Qh1gPN7ExN4Qv3ZQE5ISdLtEAF2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785576238; c=relaxed/simple;
	bh=majrXHYdXOCyGGs9lNN7t/Lsn8OsX0cIHG0/P6fPpZI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YumlwWsq5Km0J3a5Kdjmi5wK3EQaWGxrnXqVW+/gtTesW6rkz/xNK+1b+BbDFhv8awhi0ePL/C1RIcx7Zlz7yHN4aBTGoKoROzne+PC5jhumr1BoT/K3leaVixC6ODwuDP6HSZvEZ9WcViuCxu/8VuDAnZrGnXMh179QhmJ3b/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HoFwfir7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=brCHwv5p; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HoFwfir7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="brCHwv5p"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E92EC7A00C8;
	Sat,  1 Aug 2026 05:23:54 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Sat, 01 Aug 2026 05:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785576234;
	 x=1785662634; bh=majrXHYdXOCyGGs9lNN7t/Lsn8OsX0cIHG0/P6fPpZI=; b=
	HoFwfir7/63/7AvJBoIyvyHnCx6OZDGDNLiFiYs9Rv5rR7uj2MFzvCgcDGR3KmEJ
	qi/SALU4pHG8JVOy/SmbRZ6HYM2BsDwKExIgMehLBZ85TUeLuKtUO1hvkWCF/ZDy
	LSgm0hVsPha4+C/4P6+T8glp8Ez7nAeHrFZrlrRX8BP73jxh03iKVAqSFSXTu5cx
	po3WY/MkRc1sDAL05aVRn9eIESwYiAJa/pSo0BpLhrY+HiPtqJmkykOeHgAo8AjM
	EDbX0RxIfzhk9NqkGK1u1LpC/piueQXPe6vrjDIYL8TectDEoOCHAnq9ADvmEfEV
	Q6PDyiZ1W4H199nJZWw3XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785576234; x=
	1785662634; bh=majrXHYdXOCyGGs9lNN7t/Lsn8OsX0cIHG0/P6fPpZI=; b=b
	rCHwv5pDLcaYF0VLTC56eZd+9+X4WpC499yH0vgBe5snEzHIaaazMKRNFGowJeD8
	EE99Chbg5QIanJc2yFZct3ptW8ay/dw17vqIDSwSci1r11uIimkXaerOk9iP02xE
	CE8pEkEPGWE7TAQavwiw22hJkY7ws8cG73RYJyOmFCnfeFDy3z4GOLvAKPgFAG4u
	Rv0c6bxG0knZYeE+wXcR69z1Xa3LP9j2pI38PABvN4QtFm7bml7xWi23CSKwXEc6
	T8/lz6lZwL09TOUzcIbTnwDRzYlwjWUrxapI+OWgZ7PGWLFx+QoUkgKEFuVdDVWw
	TAL1U7GV64XyaznQ30thg==
X-ME-Sender: <xms:KbttamAydgDY00kHbTUD2x1CPlK7NfLUivhboJYffv2ayAo5BHqI5Q>
    <xme:KbttarWGpO8s9AjBfk9oWgEnGyxthtybfexm9neWHrPaoI0HgxDD7lwzVSt6aYdqE
    J_Zmb4LqkiqyzUg5kbjn1GXHaeAB1CEISKLgFCF8bQq1NuwcHW9PwXP>
X-ME-Proxy-Cause: dmFkZTGJO/NLPINBCAkugWcP2AmGUUy7E3kn9IKmwR4+klCYw2x++RAOSNNPKaFg2+ScqP
    z7SmznfHvD7nJ7psZ1aTt/q1Z0PahmdHnOK5bhmdyFHIKpIYXuKwXmGyP+et7+22qShYka
    oJz6y850evmAlVMTxhkM4c4Fg4VU5bK1dJ5jMLfGRvg9rhiF3Qj3iuGgSJ69FB6u8710Va
    lyXQmBh+M25wPZlBrunVmROmcJSRcx72W+c5sHcjYKj0DyNHz/vGLXE7TyLv3v388+WLwn
    /FkKUituQebfzUSWWlIdONPwJZA47NGAXuhnpHIGe27sFNQLwPvQRPPWjHdo/Vu255qWbn
    O5dDXt5SzMobT2zeA5cJx0iHvX3ZcG1NH/ad/AhpsnCWTCbcWhsSwn+iy/ohjkVMLk1/97
    Qx9Lo8Tnk6ALNBXB1JT3htWg/TjvLnJYP29wNCynU+uLcIiAUxLwo4l/+8UL3FvKIbPHYv
    qzroxTZXGaQNHD8UISqiLVR26YcTZPjc4W1EELDgbP/niIa1oyXyHBpPM/U/UQTtb/Sn69
    TOIWt+5d7GiB2EZqTU+XS0DGKy2JjGxOi+/YDY1aMBP5tQqaiYHSKdnH1C7RyNfsPcx3dK
    1RgXgCRbEBxN6uzWHQBLCaKCvsNg/aHCa25MCr3b+N9dlUr8bnXYq3utFjtg
X-ME-Proxy: <xmx:Kbttahtz0Jx3ce5iSJ3hzO_Jg7TUCN582zj6lKQIpRv3wxNyvbEW8Q>
    <xmx:Kbttajy0_HbFDnuHPjG95U0chKanVwptKwKBx63phc2HeYFB24jLZw>
    <xmx:KbttasB0TEkY0gwHnciElIG3-5jhsARO-1-l62Di8V93-4KNx0GmPg>
    <xmx:KbttapdUopaJH-loOZOmFD1MUtBx7gSs3tACAJQYLyjHgmW-UJYu6w>
    <xmx:KrttalYSzz4N-MMXQitTQeNeiTJXpYARL1zyC7PPS18Zc95GZTh09dx_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87F31182007E; Sat,  1 Aug 2026 05:23:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AF2q3JJUJyJZ
Date: Sat, 01 Aug 2026 11:23:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mingyu Wang" <25181214217@stu.xidian.edu.cn>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Kees Cook" <kees@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <f22ccf39-7d07-4b96-be44-89d86153402c@app.fastmail.com>
In-Reply-To: <20260801070756.161698-1-25181214217@stu.xidian.edu.cn>
References: <2026080153-unthread-quake-ce1f@gregkh>
 <20260801070756.161698-1-25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH] misc: ibmasm: Remove obsolete IBM Remote Supervisor Adapter driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Aug 1, 2026, at 09:07, Mingyu Wang wrote:
> The IBM Remote Supervisor Adapter (RSA) and RSA II were out-of-band
> management PCI/ISA cards introduced in the early 2000s for ancient
> IBM eServer xSeries machines. IBM deprecated the RSA family and
> replaced it with the Integrated Management Module (IMM) around 2008.
> IBM subsequently sold its x86 server business to Lenovo in 2014, and
> modern systems use entirely different BMC architectures.
>
> This hardware has been completely obsolete and out of production for
> over 15 years. Surviving physical servers using this specific hardware
> would be running ancient 32-bit processors vastly unsuited for modern
> kernels.

Technically I think there were three generations of 64-bit system
that shipped with this, not just 32-bit. I see that end of support
life for the x3650 M1 server was in 2018, which is still a long time
ago, but not quite as old as you make it sound. As far as I can tell,
SLES12-LTS still supports those servers until next year and runs
the userspace for ibmasm, but obviously won't update their kernels.

> Remove the driver entirely.
>
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Acked-by: Arnd Bergmann <arnd@arndb.de>
