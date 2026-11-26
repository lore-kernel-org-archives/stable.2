Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699623;
	b=EfRcmCDPCU0OE5Dz9Z5flesRk9WJAE98tWmZ6dHk0grvMqxUO5PzhjtVg2UucMpI/k7p
	 3KpZkZHEj6UAEf+yUCNdG3dk2qXunRsyjDDB/quqwEZc9ozvCCgZVcCUU/7D/laoezQU3
	 8GM3mSJI6XmvmzP5XWTzntOIJyQ/D+8TXdn1hcVzysMmoQk7moiJC9MLxyinkv/pg5wf9
	 wzcJLQ8adYnLx59FYRDxhhC1NbPxw2GhaN9//0Q8GorLFPi7XpV7rmsYcq6HG3Z/D989r
	 Ia2XgGXCBR9kAkhZyLNj/LtpKgI+EvZIv/iWbYeUEUY0ajWJhJeB0LRE/40MYPtkfbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699623;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZokuwfU4kATqyfaTag6SaT3MT9q8pH3IyIO6M5PAlLQ=;
	b=tFEew/v0KhLXVLcNk2ikapz8oC0B2M/E2GOutr6k7h21sTmVFZf8bbcrjR2lL8OydFAZ
	 0t9pfk3RBvC87FYQ+Jl5zhKNTfilxgGvXvF0JqV0k0dHO/kbrMYhgGFSr6/3mvj1+yYJb
	 0WbEUSLadClUewngYlzMvQEYeTEsI43gv/1h7Tf3p5sOtZm9Wlj11N61yNYojyff7eL0x
	 OfX8xEkOu/5+Q9FJJY0X/NRkLDn4OmPBliYv37x6PjcIWIGe6zRj+lzOHhVpo0pIIbb4l
	 38GwXi29IMA42TyVQy2pAx3oHMxVWPKVB731lElfXWueHurdlv75vLQ979h1ztwMqzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhloDf5h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534F606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhloDf5h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE36B1F00AD3
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699622;
	bh=ZokuwfU4kATqyfaTag6SaT3MT9q8pH3IyIO6M5PAlLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RhloDf5hjViDM1wa120MCgd7yIwpKXtodHert8PQGCu3nBm3Jhrb09TaNG4V8Vs5/
	 d1vXZiZry4y/sMZO+BHWZqI6I8kbwDjJ5tj7eo69vxWr3+mO790EUTeE93erN6DUug
	 /+Xrz1C+FBXYxu00wHMRsUx0TeB7gI6IBwCtH6p4ScNc3/1sNZ48q1pUb+ZpywnDgZ
	 XVRPR+txQwLdlqSwSwgjtDaLOXnffR1tbfJNLZDhTgUKD7e3Yw05AETznW/H3wSsTH
	 XVEdiem2CXwXSMkBzP2IING/Njo/LlWbqYyIccI4XEG2KwHon9RuKWhsn/TqVpF2si
	 RlvpUjUD9LcsQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5c14f3dab66so6883858e87.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 05:27:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGU/gSRZsXnsbKs9dmJdn9YwfxJpgXOoqd/bKM+nSE1bsOL76NVt99WxzpHOxghdGPHZvKoDWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8e2OrrCjqr10XgefwfPtQLOeciGas2HO+Q9uB6EDCCdzsb9ZLu
	F/kMhuN8pPmXcFB0hK9xa2AOWtLvqlV10Ul3CMMFBKomJNs+8V+DD09Az32CNZbhCbiJcR2lP/l
	Qz0qVJKxfPR1wJDD9BJsECqnuQA0qhKg=
X-Received: by 2002:a05:6512:23a0:b0:5c1:5a42:37ad with SMTP id
 2adb3069b0e04-5c1b7beabfcmr5752337e87.16.1795699621444; Thu, 26 Nov 2026
 05:27:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116124832.662455-1-arnd@kernel.org> <20261116124832.662455-4-arnd@kernel.org>
In-Reply-To: <20261116124832.662455-4-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 14:26:47 +0100
X-Gmail-Original-Message-ID: <CAD++jL=TmzH8tm46CvCd1=B_YMyiZM=f1vys_NhDZOM4MdxzFg@mail.gmail.com>
X-Gm-Features: Aa3M54oJhuqbanKDTHMwhtXUm4eQYbQ6svpItwvRIwSjJelTST1VrzQM13SDhkU
Message-ID: <CAD++jL=TmzH8tm46CvCd1=B_YMyiZM=f1vys_NhDZOM4MdxzFg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] ARM: pxa: support arbitrary PAGE_OFFSET
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Malin Jonsson <malin.jonsson@est.tech>, 
	Matthew Wilcox <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Nishanth Menon <nm@ti.com>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 1:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The pxa3xx_cpu_pm_suspend() implementation hardcodes the default
> PAGE_OFFSET value for CONFIG_VMSPLIT_3G. This has always been broken
> for other configurations but becomes much worse now that the default
> is changing.
>
> Fix this to use the correct compile-time constant instead.
>
> Reported-by: sashiko-bot@kernel.org
> Fixes: c4d1fb627ff3 ("[ARM] pxa: add preliminary suspend/resume code for =
pxa3xx")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/sashiko-outbox-212719@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
