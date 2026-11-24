Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530293;
	b=jHKj5foJa+n4YUTZ98TPJF63sQC0QwtYFEyTA1w4nPBlpka16effrSWUOLhpVA+nz2QZ
	 44qoKRbeEgXNlocoAXaQwHQ2Tnd5DpnHzBmiOUt6EkzAPZl+GR/4tKs/wGM6GqEeM68y3
	 HMlgRF4l41U2u9QC9rfFd4/LgdnDX9Vo41NeZIKSMM0QnVuGlysfsgMsvcvtlFLUdPFNg
	 lkwzhs4J0wURvcHDJSNYkRWx35BGFesedCo+vswV1+9PjyUAFSRkO9Vokyei2A+FQAXHk
	 rltwe7XoYYyI7PdxDqAHIXpgUs/KuO+JWaJcwfs1LvfP5AKhbaqFMc5Lwg5O8QkKl7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530293;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=YSiUJXA7jP1X5fyNltCeT27Ku9O4ReEnxhpFpx6/UHk=;
	b=w+lqaKd6udnPXWZgl9SuGsp3TMQS2YJunUtfHBCOVD8mxKtG8qhn0Mv1mI2jSuam25eH
	 nq1gzE8pfZ6pIEen2g34uw5011myzRXVSWLtOwHONjTm2YyWgIYUQBt841WO+jDrnF4nj
	 wytRnF1brpEh37rFWqhei4eBDXslUfKIcN9VJYCuIIfFtg9YcD2GYND4UY019r+7jBNO1
	 Zwwwe6/HAMbYA6jdgd8ptAIJVc15hKf/ZJbKgshLaCS8OATQU+QEnKtHUokLuoBJxpdOp
	 zpMzOSlE3USQHZOxTKe8/t3ua+IGIYK6vqUGLr9NcIaaTsF9FKwG7i6sctKGEhWKz1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtRH6YKs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C56606A339;
	Tue, 24 Nov 2026 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtRH6YKs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBBA1F000D1;
	Tue, 24 Nov 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795530293;
	bh=YSiUJXA7jP1X5fyNltCeT27Ku9O4ReEnxhpFpx6/UHk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=gtRH6YKsamtR0aVi/9eOGDXcQx14AzLXV/2+2FHuztbKotP6nOxCMWXCidG62DRix
	 Iob6B/l07YW7Of8bOJLmeJR0QMgsoZiWl+maRfTCBISS2+FV6VG0KwQWFURGzunToW
	 DPBRpQjhqBoe9UujZ9gq+9LVUXQFZ1xrb7zZeoTy+EQu944lcrlXK/ob++s+meoMLX
	 C1NUCkVvpj49+I8Df1BmWJJYpKeMSDQ+SCZXpPDF2AvDhQ/gPGLbScotcOjMMsF4HP
	 pkDHT0lTaLnPhbKNrhWp2el1SQ0QBuOEA0m29Wlnjp5ox8CpD38uLO6oh+UCqZGcJU
	 sKu8fhIKmh8wQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8A8A2198004A;
	Tue, 24 Nov 2026 09:24:50 -0500 (EST)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 09:24:50 -0500
X-ME-Sender: <xms:MJ4FayrenX1n_QQ0UBReEj_-07DSJWaMmVBp2XvjFkCJ1tkDuU-QwA>
    <xme:MJ4Fa7cnGGhdnEL8OGcY7J7pVyM_DC431gulx6ANHeDPl9jUs7MESVUApfeMmxi71
    hEnv3w6QmPb-BLpk9UjY91NnagWQWJqQpH12ox2CX6M-lnacCrvbVqn>
X-ME-Proxy-Cause: dmFkZTEeI/VnZe3weSWJvKW4r0xqOAy6MhJ+KiOnoSatFvw6iRFZYsuXQhPELvhnCaRO+1
    JqSb2F5VWzYIFdhpnFcny4u4+3aL6ttqF8MtzE0N8SlJ0nNJYKq46flGe1YKof+yLnL0Wz
    eIWIbbvsRdGWkfh8UrW3nwlVF7uk4SRLwgtlbnPu43ADGDGgPe/TxSyXFKiWzqdUeS6zsD
    T5xNZTGCszj+x+ULiYehxvWxQGnQtMe/APAs9MfcHYnjitR4RLAxpab7l8kCuysqgEENbo
    b57SGYKzrA4wubz8KkpVKEYRw4tpb2RvyqzOgP61zipcHFvdmAYu+dppqsYr3ZxgoYP7Sm
    C46rafMMqhU2GamcpYuDPI4HisZ0cNhMCi3/dKSpun06BIDvlHEASXYaienwZkmLy/JGVh
    V9QpE92cOOHCVWvQlCxHGf8GFM0VLDzOqzc26+dWmZyaLMsd8IkhBtkxL7tNvTur9fEdx3
    taxce8jltwROINC960VBm9txVWG+o1HWrlvYxDR8rjLEWm63L1oE9bT9od5we6hm5l2IfI
    fM6sfenhyu185ozy8X12qsiZRB4FEC4A84kyqRIQLjfA6zuuE/2uOKVlmflrp5x3fNsWPn
    292TRVFsRjxi6KB3AJ5GpN4h78/XIMkewDc3fb/QF8GRG/5pVROERyD/yFgg
X-ME-Proxy: <xmx:Mp4Fa9tfHYrXTjLQZm_cV3iud42zmSDNuIAscAg_nNTbefjopO8xJA>
    <xmx:Mp4Fa1iN7QjcwxwND5oAuWBGtvu_IWGk3F0z2CaGx4zyVAkTkQpK0w>
    <xmx:Mp4Fa2_8zmoZMV0IpaoWT61EVDQxQpwgerMl0SYVgkYwnSNFfpAgEw>
    <xmx:Mp4FawtTKt6VP3ZIVGlIkoNvhElgAFrFm8vj9lJgbOV4sS_jiSE_Cw>
    <xmx:Mp4FayrMA9_19elOiI5ThEPT0njd2fc3dnj5jaswKgTYEBLhySNFQ5Pb>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9D78CF8009A; Tue, 24 Nov 2026 09:24:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ApnSy8YMrSZR
Date: Tue, 24 Nov 2026 15:24:28 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Sebastien WENSKE" <sebastien@wenske.fr>, linux-efi@vger.kernel.org
Cc: swenske@veepee.com, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "James Le Cuirot" <chewi@gentoo.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <c753baad-b5e3-4e9e-9af1-ae146bc908d9@app.fastmail.com>
In-Reply-To: <20261124140640.0f627d7e212c@wenske.fr>
References: <20261012133712.618913-1-sebastien@wenske.fr>
 <37c38d1e-03cc-44ae-b617-d45fbf80acc5@app.fastmail.com>
 <20261124140640.0f627d7e212c@wenske.fr>
Subject: Re: [PATCH] efi/libstub: Allocate the INITRD table in ACPI reclaim memory
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, 24 Nov 2026, at 15:06, Sebastien WENSKE wrote:
> On Tue, 24 Nov 2026, at 12:38, Ard Biesheuvel wrote:
>> There was a report recently about EFI_ACPI_RECLAIM_MEMORY being
>> problematic in combination with hibernate, as those regions tends
>> to move around.
>>
>> Can you try this fix instead please?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?h=urgent&id=6863183e8b65e833f8140e20d526282a725e040e
>
> Hello Ard,
>
> It works, thanks - please consider my patch withdrawn.
>
> Tested on x86_64 under QEMU/KVM (q35, SMM) with Debian's OVMF
> 2025.02, both the plain and the Secure Boot capable builds (no keys
> enrolled), the kernel booted as a systemd-stub UKI (initrd through the
> LINUX_EFI_INITRD_MEDIA_GUID device path), then kexec'd twice in a row
> with kexec_file_load() and an initrd:
>
> - v7.2.10, the setup of my report: without any patch the kexec'd
>   kernel oopses in tcp_parse_options+0xe7 again, 16 bytes of its text
>   zeroed at the stale table's address (0x1d4bcf98). With your patch
>   both kexec'd kernels log
>
>     efi: ... (MEMATTR=0x1d4b9018 unusable) (INITRD=0x1d4bcf98 unusable)
>
>   and run normally.
>
> - v7.3.6, with a debug print before the wipe: without a fix the
>   kexec'd kernels read what looks like their own text at the table's
>   address (e.g. base 0x74fb894800000002 size 0x7400000208b73b26) and
>   clear it, without any visible failure this time. With your patch the
>   table is disregarded and the wipe never runs - also with the flash
>   locked to SMM (-global driver=cfi.pflash01,property=secure,value=on).
>
> - v6.18.65: applies, both kexecs fine.
>
> Tested-by: Sebastien WENSKE <sebastien@wenske.fr>
>

Excellent!
