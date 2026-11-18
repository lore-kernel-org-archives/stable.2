Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035145;
	b=UgUQQ/nRAIWGRcMaTixudk/PUKfuMxLjeXwFrRSKdfVbtmQMKn8x8oxiA13G5GNDb6vF
	 SK5zTT4GAmWX99+DwpOj0S7dE6gjt1zYxtHiR3BjqQ0WqbXU+X/zq7kbQYC1ja8opjj4W
	 gKGfK//XT2vdxJo/S9fN3EErsIzfd0OAA3OoYPumSs2ngDIlh9qKDRCthVN6MIXNyjUTZ
	 yOV+cmy8VMIKA9THV/E4w/eY7W5qIIdgAtwtK4FAmpcDh8EYJPnxaKg2mNHn3BdJTeJe6
	 SwL5mkA951Qpyz9cZWRIxT91nG8fwRH3lImHHXjHAq4UsPxLxjdnhYlVioryfgFnLUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=dxmySTmEZ3hib+9H5pqVDEDQRI3wIZljNjzSSTwZn7w=;
	b=VZaPetWXB4Sv6ntguXxDPQRCEHx750N0fLu+Ieodipf11Kiu53ypfWi/UJwZFGV184w3
	 UlxIRcpMv8XSoqdzV25tY8iIcBg6I4uBO1vysI6sWnN2w98tlB9kSLRMrL5bA+V++D9o3
	 dS/9B5x8OWoihJ9V0sSlJokYcSEanzQxtoYuRwf3nJeeUlxnHdTM4cpJz0rIB3UoM9StC
	 tBguoBuwCY0orOKWLQYT9gKQ3DV9d64P6U1fTWKudNFSRMB7evTD6mHUiMzhTfSH04job
	 MEHW9GLA9kEPP8ocgWZiNNNqIZjowEoo6R0rQSx9VvUlajWStNR1bU9C9D8nJRoyrjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SqHUcWGu;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F545606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 20:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F545606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SqHUcWGu
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so945969a12.2
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035144; x=1795639944; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dxmySTmEZ3hib+9H5pqVDEDQRI3wIZljNjzSSTwZn7w=;
        b=SqHUcWGuBJ5iPjwuoExkJaVT/UVpfdPBxDUFOXh6mpiQuWiJKjjQrPeuXpWMmMwI/u
         soWYK+E2+ktGyN0Mz0Y/0hREtps/a3j0GpYhuBoacNC49w4L3fbdbfPmwLRrhgBUxom/
         zsFLmibB8/aUwOgVfsoKnxJ48Wg/ZX8wwMZkIxFkXgN/13l5erXTN1NQchLap+467x4c
         LCR3snF+qsFzpxzJx547CpICfIsqqVjRXbemsyTJ97tlHu3vMXz0w3VotAin2HXQMLVk
         F9I4XGQ2sfHYLYsTlk2h/KNSgRqNnjIIIS8lmZtgsWecH4GG6FpElOb4rFYA1+uwN4pm
         irLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035144; x=1795639944;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxmySTmEZ3hib+9H5pqVDEDQRI3wIZljNjzSSTwZn7w=;
        b=OUwiWLA/H4fEPEC0Ywo8uOVkw6YsGeyYP7ZjFMYCiSNgK6XgxS5LDTpTRnij7sbevu
         Q6r6JsjzcnitRxToIOevuOxWcKX2Dc8NerfVNt4n/9Y1WHKIItmwPNJZi4aOxnhsu7iQ
         UnbOZf0ZBgpIHZzQFAhxdOp3TjZHtY3czLXnimQudRubyXUrM6v9XVoBXfNVduXeY9EF
         sCeTzU6vvtOsoCBtx/h4UVZRSVRyVA+1sH3+XXVjZhi3IMMq+IVPq/iV6cuDC0XN8kSN
         2N/9GsNiBdag+d+hmTwNDysvN9yvdPaWqw8aJn0XVF0zQ729ByWfA6moAbgtOyRediGQ
         dijA==
X-Forwarded-Encrypted: i=1; AL+hErG+Igi/mCqBtJGFFXVOBL3505gt69uc9xXm/E3B1fz+uDoHgOSk61CBOwZpoWIATcOZuXDygWE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xuMsJCDfqWPk+epEN8QvXQKRckVojbqIeAyyNGdAn9h1+H5wT
	Hkne308VzLnJI93qkrHs7VlKMIDRhieWgCm4Vx+HwBOzNjn/1N12PqPU
X-Gm-Gg: AZFdTZehFhgoyjpLv795vPlN0EViyon77tiIhv9DbdWGcCZS4yifILBhZ4qLHcrDxB9
	z9i2Aj5t59bsGUmOwF8u4oQpW5eGjXXhuqha3Y85uiAhiDJ2qQiu25pGiRzQCU/zZeObtb/TjaC
	laKUTuHuOTuHfTbYLhwgWbVz9PzjqFlsaRrjq7TTtTLkJCF+NJBS8UrJcxmd+tl3widgptjCNIu
	Epw4an0QBJFDohsVKlFnlsmeFcklHtt26w5Y1ahOQwmbJ78YR4xjnT1JCRFB/sgVFGNDSz0j3li
	5Jh0tJeFIDaHbF2djTaoH4YOaMFWMaElSqbwBjd6V+USeEi99KHQ+Pue/ijoOHwuPyRnWys1csj
	DegZBXyiYkabQa1+oWXRgWtOLLPOup0q2dypnDqJquL86V7X+MuqySWNsRiH0b1BWajIJA40W0A
	nF/St10in3gP9G4KSfzx7aZWfvLCnoQy6ie3MNMfxEW1r4cXOphiMRAB6ENiEVzOG/dMwuQSu89
	ZAzoMn0ItjdPYqmR+XI+Ovf6TMLlFQqpUlTV/XTlFiIe3DlOuc6sbkGIAY+IB4TEvIA8eItFoSd
	OKtGv2fXzoiWeGdaL96JVGewK9dvp9h1sO+wo+FAHatIbOub4/kjBx+JYTLLD6DMuh3t8t/3QQ5
	dxiZyqZ6z7BSI0zI3iSvgalwJYBXtLLtk+g==
X-Received: by 2002:a17:90b:17ca:b0:3b3:c00e:56a7 with SMTP id 98e67ed59e1d1-3b3d07d458bmr3354393a91.42.1795035144417;
        Wed, 18 Nov 2026 12:52:24 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d56a3f93sm2644508a91.2.2026.11.18.12.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 12:52:24 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 20:52:23 +0000
Message-Id: <DMYMUOTUYZIC.3CG88B0ZSFU7E@gmail.com>
Subject: Re: [PATCH] bpf: Fix cgroup link update after a failed effective
 array rebuild
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "J4f J4f" <shlomojune6@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Tadeusz Struk" <tadeusz.struk@linaro.org>
In-Reply-To: <CAE_LbwmtogEFvk5jDUcYhjSaX7_5bsHy-OWxCKPxmiBVDcjj_w@mail.gmail.com>
References: <20261112134942.288831-1-shlomojune6@gmail.com> <DMTHXFS504S9.2BU4PDLEWG3PX@gmail.com> <CAE_LbwmtogEFvk5jDUcYhjSaX7_5bsHy-OWxCKPxmiBVDcjj_w@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 18, 2026 at 06:41 AM J4f J4f <shlomojune6@gmail.com> wrote:
> I reproduced it on f66469d9905b39 (7.4.0-rc1).
>
> [    4.307527] BUG: KASAN: vmalloc-out-of-bounds in
> cgroup_bpf_prog_query+0xdf1/0x10a0
> [    4.307589] Read of size 8 at addr ffffc90000073050 by task exp/74

That's the last step of the scenario.
How did the alloc in compute_effective_progs() fail 4 seconds after boot?
It's a small kmalloc with GFP_KERNEL.
I think it fails only for an OOM victim or with failslab.
So it's still wont-fix.
