Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520447;
	b=CelI7NCr3VtMSzqC9xlpinw/QzNyeDP/wAWdDJDGMZZJopRn9Q/byRcw55sSMkMAYuJi
	 iFTd/U6M2CNrlbCL1x9mwcokoJ6emvNjpm+gYhyTHYXQHN9yX3LSyn779j4q1rRucaJQv
	 NdCGMYYkZMpa5HT1fI2lW7Nxo3jOKHNk41SYkDv92OepFKW9Jr1eQDuA2oq+cZXXLmUPf
	 wXug/ipY0GpQWPDhBzWXGXDM7Lx3NPazj+i4dtUAG29Q31kIK/9f1L1Xoqlj/J1tuIIF5
	 DiII/Z0QMuXT9NPY0YFIaoZ7sEvGip4JiOJuXHpsaKZAHbFSGMyvx/KbkmNB9/fUvnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520447;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=YNKB+l0kbHZ2LFgYHq1tz3KLItdS3YCyjSFJuwPFLv0=;
	b=UFaw3FHsfsBxHZ8GUmR0mypOGIxFiEVrJNJwqNM1KvLM4ZdJ34qrKRdh4wkRut46tWSw
	 0PJtsbuYIZZTQn54w7kQzi5mtvSV++QOybZ7TyVGCTDu4Oi68qLD8XKmoJ6rHvZmYnBu+
	 aHtUeljwXKTDt/y/Qx5v0WtBdVVKfpcPrmLmO83P2BVf2bvjz1ArXwWhVM3sB+5Vtoi9r
	 8NQaULDwOE98HRfeWCxTQTHOZ9UcZqzh+gh4n/Onrcq157AJlL44ppyL4SbsntslsbNGx
	 BE9x4JTezDOpWceHorXPxztcsoTnpuyUmq5uUj8ysGG+OrwAWP4nBUcQDNCRzY6ZnhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/KWG8/t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F1606A321;
	Tue, 24 Nov 2026 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/KWG8/t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF9C1F000D0;
	Tue, 24 Nov 2026 11:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795520447;
	bh=YNKB+l0kbHZ2LFgYHq1tz3KLItdS3YCyjSFJuwPFLv0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Y/KWG8/t01CyWXnuuxn5Fq6dG5U0E/DUCU9cLtTKyJCmyZpLPtz4H5tDoHmhjT0Y1
	 6LVawp8QEZn0HS8F9iB9sABq0TgEer9xApKgILOghCb/TWwQiFTwASnLtqmDnK7p9d
	 uJgGVhqzlPa7PnWK+5Ey6/Kb5r7XHf/MHKzE/m8edUN80AmhKmcTYbffqmuRec7uc4
	 d9mhARS3a9G6QwypWQJblwQB1kWsG89+ctM0xLetzNd1o6PD9CegiBD/LfWccVOPV/
	 mwmFaZY+FKMjMnznslikv6KFIdgbcvnwye4jOW7hxxlNtkIkQMnuklCiCZqRCsPY7V
	 o8COXWTCVS4RQ==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id CB8041980047;
	Tue, 24 Nov 2026 06:40:44 -0500 (EST)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 06:40:44 -0500
X-ME-Sender: <xms:u3cFa2WZAvaq-MEvL7K33-JMO8R2L3mYuau5n5hO2SMrNJWVXCfjFg>
    <xme:u3cFa9bhlu9ODSrVznatnlU66U-X0sdpA7b4RyfQSL4FyGhJh5d3MrwfKWl-EX0HA
    sXHlxQXvPDbgWoMy0fZq-dC9FFEENqFl2QrJ5Iv48L6_VfwgqhbPvA>
X-ME-Proxy-Cause: dmFkZTEMmXa45SeVrzxdc8lVdrKvq22c5nOCVcabUq5/b3DwR+SZOjCmU5hPlCMvPbD/jG
    xGX/zl+7UgdvrJtoEo2C2qX4tYzFehBttg3Q8pP42dTF1E6KmxXWfoidEoMJMsjro+itt4
    Dvv+paoMENJtR1YVe1RrOmxWDJu+Dos+BL3NJB36HHYZEWQoPEfd2f0f49jDOmEwPJ5GWP
    HzPV+D0S+5nz6CFwdVCwYRZ08IiLIvurA8XdTqHAWDn2e2iTnwalYGGrM/GMJlp2i9czsj
    82jckTGxIKmWMZZoZjXotXZ30EwOrPwkcptldPdi9BERQbuh3XwGbk+bNvIevBmPzeESm8
    kL3uHHbFpDKe/Qyr9qP7Bsd7LDWIe7a+gt6ZL+4J6xE+91VqGzmNCe+jrMdd0SKXcfAiWb
    PqwEqqVTb6q1ZRikefhsevZPrtcPGrWz6A43HiI7rzNIufnWqEW8dIGgqU3jjStfzPjTkj
    WU7PzjcqaagORtAW2YwEJSIS0dnpDAvF41+ytAJwUBRUeY9kHDr+exsb+ShZdtXPPwsW6v
    8O2uGG7oshIGaqwGKOpm++TsqBweO19oaOIEGOmOLONzIR9NcfhwgfT6qGw/s2lNNEKdlN
    G2lBH9CJHUyFnqUPatunvuFiUz83ZcNPj/ACHVAuvCdQddxAX9yskvkuzOTw
X-ME-Proxy: <xmx:vHcFa14LWtxuoXQSCXztkRGKGGXPr9Fhc0nRNZECL5mHK6cj9eTvcg>
    <xmx:vHcFa1JPA7ZCqMHIN6AcbZ9wj1llof3hXNUNdIwzaBx1q0zmqFfZeA>
    <xmx:vHcFa-tNiJ8O6EcYswXmUD32CLau-OR3Dc-qYFb1N917WyGLFFE52Q>
    <xmx:vHcFa0K9XZBHP6EtZCT73GFUDk43H4P62P4pZq7syHLXwfgabnpgwA>
    <xmx:vHcFa3-1f6wVJb3kq-WjMyorYBzmD6N_8sGUlMyiB6J2AJI-tp0_LE-4>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 75E98F80093; Tue, 24 Nov 2026 06:40:43 -0500 (EST)
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
Date: Tue, 24 Nov 2026 12:40:23 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Nicolas Brainez" <nicolas@brainez.net>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Lukas Wunner" <lukas@wunner.de>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <756a713a-dfc8-420b-8c70-76828e2b0bf6@app.fastmail.com>
In-Reply-To: <20260928072832.25399-1-nicolas@brainez.net>
References: <20260928072832.25399-1-nicolas@brainez.net>
Subject: Re: [PATCH] efistub/x86: Fix the size type of the Apple properties protocol
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, 28 Sep 2026, at 09:28, Nicolas Brainez wrote:
> The size argument of the get(), set() and get_all() methods of the
> Apple device properties protocol is a UINTN, not a u32. The reverse
> engineered declaration added by commit 58c5475aba67 ("x86/efi: Retrieve
> and assign Apple device properties") uses u32, and
> retrieve_apple_device_properties() passes the address of a u32 on the
> stack to get_all(). 64-bit Apple firmware writes 8 bytes through that
> pointer, so the upper half of the store lands on whatever the compiler
> placed next to the variable. OpenCore's
> Include/Apple/Protocol/DevicePathPropertyDatabase.h declares the same
> methods with UINTN, and a u32 canary placed right after the u32 size
> is zeroed by both get_all() calls on a Mac mini 2018 (Macmini8,1).
>
> With clang and CONFIG_EFI_MIXED=n, the neighbour is the protocol
> pointer p: the first get_all() call zeroes its low half, the second
> call jumps through the corrupted pointer, and the machine powers off
> before printing anything. A GCC build leaves padding in that slot, and
> a clang build with CONFIG_EFI_MIXED=y places the setup_data pointer
> there; neither crashes, so the bug went unnoticed since 2016. Talos
> Linux, which builds its kernel with clang, reported it on several Mac
> generations.
>
> Declare the size as unsigned long, as the stub does for every other
> UINTN. No mixed mode argument mapping is needed: 32-bit firmware
> writes the low 32 bits of the zero-initialised value, and the upper
> half stays zero across both calls.
>
> Tested on a Macmini8,1 with v6.18.51, clang 22.1.8 and LLD,
> CONFIG_EFI_MIXED=n, booted as EFI/BOOT/BOOTX64.EFI: the machine powers
> off without the patch and boots with it. Builds with clang and GCC,
> with and without CONFIG_EFI_MIXED. Mixed mode was not boot tested (no
> 32-bit EFI Mac at hand).
>
> Claude Code assisted with reading the disassembly, writing the debug
> patches and drafting this changelog; the tests ran on the hardware
> above.
>
> Fixes: 58c5475aba67 ("x86/efi: Retrieve and assign Apple device properties")
> Cc: stable@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> Link: https://github.com/siderolabs/talos/issues/13231
> Link: https://github.com/siderolabs/talos/issues/13579
> Assisted-by: LLM
> Signed-off-by: Nicolas Brainez <nicolas@brainez.net>
> ---
>  drivers/firmware/efi/libstub/efistub.h  | 8 +++++---
>  drivers/firmware/efi/libstub/x86-stub.c | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h 
> b/drivers/firmware/efi/libstub/efistub.h
> index fd91fc15e..1002c17a8 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -838,15 +838,17 @@ union apple_properties_protocol {
>  		unsigned long version;
>  		efi_status_t (__efiapi *get)(apple_properties_protocol_t *,
>  					     struct efi_dev_path *,
> -					     efi_char16_t *, void *, u32 *);
> +					     efi_char16_t *, void *,
> +					     unsigned long *);
>  		efi_status_t (__efiapi *set)(apple_properties_protocol_t *,
>  					     struct efi_dev_path *,
> -					     efi_char16_t *, void *, u32);
> +					     efi_char16_t *, void *,
> +					     unsigned long);
>  		efi_status_t (__efiapi *del)(apple_properties_protocol_t *,
>  					     struct efi_dev_path *,
>  					     efi_char16_t *);
>  		efi_status_t (__efiapi *get_all)(apple_properties_protocol_t *,
> -						 void *buffer, u32 *);
> +						 void *buffer, unsigned long *);
>  	};
>  	struct {
>  		u32 version;
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c 
> b/drivers/firmware/efi/libstub/x86-stub.c
> index cef32e2c8..87e142cae 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -158,7 +158,7 @@ static void retrieve_apple_device_properties(struct 
> boot_params *boot_params)
>  	efi_guid_t guid = APPLE_PROPERTIES_PROTOCOL_GUID;
>  	struct setup_data *data, *new;
>  	efi_status_t status;
> -	u32 size = 0;
> +	unsigned long size = 0;
>  	apple_properties_protocol_t *p;
> 
>  	status = efi_bs_call(locate_protocol, &guid, NULL, (void **)&p);

Queued up as a fix - thanks!

