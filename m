Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229038;
	b=Yo3Ed0wZjmkTrvdcQZq6egqnydUT+ZZlC9fIksm2bIkxIzKs8+jed3pJ+Fl6TNkXuZfD
	 03Rl894JSLevLx8wW2NnJnUDpY0N0jM2IaK776n6f8Q0Zrbi7XXLlhRJkRKYj1yRBem6S
	 l6vXMNCnV2fe0JoDWyO83uvDdmMKVsCEqjLWZDff+ru7+lzUA0Ta55NiVpPn3+VDyHwVi
	 rgdqYczyMED6fdDSEh13PE3KHm1xD4W/9scs0rq60cXUj++lv76EAUgeBZXhAS/d04z4o
	 SCgso9b8xV0hC6EPQNFXQwm0wZxz7wI03Sr11GuKovuBSQoMDtmKIQlfOSQe4FPV5Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229038;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=lg5cyUsM8ERQunHRYLgJbo+ATKTBMtf510Y3GOahvOE=;
	b=V32Rhpz5WxXpjrlDJ9waA6gAibyqV74aJOHXjjMdupXRd8YTu94ShyLWhMjDReHtEB3z
	 IMw9LiW1TNOPw/TaP4OzdGEHeHNdRpEacN6jUck+W3vY4oV7vZ/9MLQpU3R+0szeHfKjC
	 zFC1h8YZbkaj1i9qsph2c31KRFgNTSpyER7XN+nxX5s94kZgFVOZKwlXTDX52Ys6nJ3TZ
	 SDdR58TZA2uruURLUbKVUnWrTqZUmkZW1nwhTbX1eQjYl6js0jq+eIJ8xQ4L/sxod9JKj
	 Ms+4ASLCHD7vJXZzZeuGIk6CO1d86bnC9C21EAuAMwzKSbSyLwOfvK5FoTXv+yvAPXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cKyM1U/1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEFD606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKyM1U/1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472951F0089F
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794229037;
	bh=lg5cyUsM8ERQunHRYLgJbo+ATKTBMtf510Y3GOahvOE=;
	h=Date:From:To:In-Reply-To:References:Subject;
	b=cKyM1U/1kBRJHHYqeGHXFT1wOtdMoyWyMuLsPSmP01J3UEBj8BKR0zAkkAheq1KAF
	 VqxEqiON7M001uVaogoCrZgYO2n4h3hc1fYNV1/Ur046Q2cE5sIhr44nCVInAI92Nr
	 JRDO2pS+LT+GDzvHGHtiOGBjSNuVVGKmBuXjqUNKo5DRup+J+xmAQkhmo+H+Zov935
	 oNRurfnEzV89m7nzTktnDFUoUX9BZY57nfDi1XiFHgpoLZYJZ13tZ0rZB8mArncewm
	 3Qo5Pc5uoQV4pLRJBeaNTX2AATpIDiJQ+z8Rz9LqTz9aVcwEX/Ttewfst9+BM5eePQ
	 2teLw83g+B6Ag==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 85C92198003A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 07:57:15 -0500 (EST)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Mon, 09 Nov 2026 07:57:15 -0500
X-ME-Sender: <xms:KsPxaozJEng7FkGoDg5zGyDGbkijlFDyRjCnBlQX2FlqZg3d_VPgTg>
    <xme:KsPxanFsshF8k9aicqJo_3aaP3hpag2XSoeAVDoqD_CVEOtMu9GOAdL9tG81FHMWL
    CQeallTDxN8fe0U12Ril0WmlYD04lLLkncpLL2o3I1ztAtHuNyXS83E>
X-ME-Proxy-Cause: dmFkZTE5JxoTQavf6f4VYgLo5pD3pwLbuMver0RCU8WqgRI+zcthdgwYf0JrxtmEIPWvQ6
    DV0wMWr4CKi2zGPxlYk7jX+16LE33fy9y5agI4iZNumSHzca5rNDDtum/zYVMP0bMmI+dW
    0ETyJZmHikPrf1UqqXyQKAR/w8+E2HqC48SXIWS99BhwLkLyKbxAGwiBUB7/AjuV7i6Ssb
    RVvALxpyzExsrNCOR4ngSChxeed8eZoAnzNOVeOqPDcQkO6K0T+9x/qB33E3FCGhQR7zn/
    FBEvvGLEYhafdTmLxQu0r/cmKzRrGrQ9F3S98zRp7D3XckksSPAHoIgjSxww0e1yaYpGGJ
    FUotiuF+aNdWfHkcB1SeCcVKvNOusrN4OYtuXTkbS48A9tV9Zu+4/IF1ZldpqD5TIiRmWP
    0JiOFRuzzVRwpFrIbaYa00c40NcUwF0AUNxhzNQDnIz3A2zuRnzBSUSXGUyAGv1FFFHXk0
    1/hdk5o6go4A0w73lGxeXtF+CeAjNxoKuuA6IJbk7taA8tNSNKdA90R73/jFvkMwiPMghl
    avj9LVJjcq6KeDQXZZ5fsdukVsT8H2NxxIyUujKIC3pGOcDHqVlalPQiEUocDWVnVP1sIb
    z4qAVOUWUz8Eq5UCqpqmmTiRXqQia5YUhN5l7rkWLvHEkhqyWs0/tKBFW+9w
X-ME-Proxy: <xmx:K8PxasCkWxnJstetr-kliwJol-DEzmZMLSWNIYsdJQgqCeaXcAlymw>
    <xmx:K8Pxaucmf-v4R4h5lenjyyWrJmZTCfk6hXU73U_jjIYQ9PDXH1pBMA>
    <xmx:K8PxascPMFLFdyhzYTJELVT-kNI7nsD4QG2-ZuPwPMy-XBiknhmkTQ>
    <xmx:K8Pxaqhuwgt_2kSt5-Uxk-G0S2OcL9MfpKTlPXyzmn2TeRqkSWhQ2w>
    <xmx:K8PxagQXE3NaA-m3CeT0b1yuD6H_zbl12CHDRAr32GHy3uTk2JZ4FD-I>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 95954F80093; Mon,  9 Nov 2026 07:57:14 -0500 (EST)
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
Date: Mon, 09 Nov 2026 13:56:54 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: stable@vger.kernel.org
Message-Id: <4f2a615a-c9c9-47c3-9cc9-b5071e8772e4@app.fastmail.com>
In-Reply-To: <20261109122129.1396402-2-ardb+git@google.com>
References: <20261107052256-failed-6.12-4c86b5f3fa78@kernel.org>
 <20261109122129.1396402-2-ardb+git@google.com>
Subject: Re: [PATCH -stable] efi/libstub: arm64: Don't use the platform register x18
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, 9 Nov 2026, at 13:21, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> commit 4c86b5f3fa78347fa9cbc9e8ec06615b2f80e397 upstream
>
> The UEFI specification designates x18, the platform register, as "do not
> use" on AArch64, so that UEFI code is compatible both with an OS that
> assigns a fixed role to x18, and with one that uses it as a temporary
> register.
>
> The arm64 EFI stub and the EFI zboot decompressor only avoid x18 if the
> kernel is built with shadow call stacks, as that is the only case where
> -ffixed-x18 is added to KBUILD_CFLAGS, which the stub inherits.
> Otherwise, the compiler is free to use x18 as a temporary register, and
> it does so.
>
> So pass -ffixed-x18 unconditionally when building the stub for arm64,
> so that the image can be run by loaders that rely on x18 being left
> alone, such as a kernel that uses it for its shadow call stack.
>
> Cc: <stable@vger.kernel.org> # 6.12.y and older
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

This applies to 6.12 and 6.8 only - I'll have another one out
for the older ones.
