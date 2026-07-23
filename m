Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F242669A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800417; cv=none; b=taLaH/FVkawAa1rSMPHCNMmnSt621NdP4hwSwE0Sa7VxKfnajwE5GrSZ2mA9s1sPxPQ9PYEwGmA8MeJODLFkRFrY9IN4NRl5aakDtXGkhynilFU2X7UrGSh9l4nmcQNv6IihWgbrnEg8DuhNwE4RWV1yOc8wBHlOgsr7ViGsFJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800417; c=relaxed/simple;
	bh=S5NqPnzf9E34AKXV08SNWUM/EqZ02c1hhZmCkSzJqcQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iz1AniiGp/ZwB99prEv2z3QcxmfKh/3Sd59sd7i9AwiJNZOWYMdPdrFtQz7lfZozcFlUfeXzpUOFf56EReQH83p6nTKSWACGSIDk8eyOQMNi3X0JeqGofhWZaNya1J7Hmgk7KS4RxhozeVxjVRfY5vAWBWUTADa7OYV7T+FvnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDC61F000E9;
	Thu, 23 Jul 2026 09:53:35 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7DD64F40078;
	Thu, 23 Jul 2026 05:53:34 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jul 2026 05:53:34 -0400
X-ME-Sender: <xms:nuRhal_UUsYSu4hxoIcW5tkU-5QAVkwhKGmuPhrqXHUqHqd3MPAc3w>
    <xme:nuRhakiaNOH2-kPOG7c1H2gGgQNNQE97r4PO8ILsr6FZbWMN-UTb8yV3V8gn-P-vp
    c1wzifr_EvqlYL63cZkSgQcI1RA-UDaRrBK9XdLeLELBHP6v-UVFQ>
X-ME-Proxy-Cause: dmFkZTFHZDEhc6/KMefjmMp4uMeeE3Zcb9mfs+V06mdxw3F5PEChH3KemwCyws3jce4Mqz
    r9y+127SMPJFdIWF1YwFK9JBClNfqxmhNrJQ3CTMT06b4ew2B6pnn1U7m2heye/pLt0t33
    yIacOoENbTlAHndzSlpi6MA6leuJWy0j4LK2nHoja1f+q81tI8AzboB88nxK/WQLxrC6II
    wdKaz7tgJFFljSrLD8ubTOg9ZnJu+g/yY7wxQzbg3uTDao4HSUgCTrKn6rM9DHR9mOFcXu
    9oB0yPjJUSpsqYCYYpyoxeyeJgzFa8aH18z40rAf2NyB80rrQzkBKeftHAn0RRwmQzYiUp
    nSsATbUjtnrbeX0DKpAklEn+h8bq5gK81uRfyV2eG7TgOHlvvj8nciPN9J8hQNFWPSqW+m
    F3ac8sjnNFwFwgu65VWvkX0UXJ32WuN5dY4Mwm8Nfk4HHHapIRnpX5ZbFHiTEr3c0NsYER
    38ffc/JDfh6MpEmr8ErH03NX+zrTWRKc3vIYZFiKwQCIknFJJd8bnV08Upe7NSZERj3G3p
    f4pBuNI/Xyjz04xloT4DpUf5IjYgnua5CY6zHjzCdcdRHBh0Zo+H4aciIU9j5cFve8MqLO
    vjmcxg5CpjW5NfFt3SQ8vyh+xCSkBzgbhDOPT7WrrpIg1zBA1o+tm0rgzVfw
X-ME-Proxy: <xmx:nuRhappbi0LEylwvyeq7Fkf4xAQ2NmUUkiC-dXydIGLJAgko6bvC-Q>
    <xmx:nuRhaqKaIGcfq-QXhiZ5ZrzcnzkDtJdUsBACQPgT0KeLVLAwAuUmrA>
    <xmx:nuRhatB-I7MJ0d0hafgvQ8lqdp_DVCZMdEDBYalBDjwFkbihmG63MQ>
    <xmx:nuRhak4qMkNrazX96NHh14lR3Nklsy3n_xbXQxTLI1j-ZwJ3-nkl_g>
    <xmx:nuRhahFVRSK-nkqJFeDnSEuTyJjTntoREXzbHJk_FIdsarhAhew9yYMX>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 610A3182007E; Thu, 23 Jul 2026 05:53:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADJgN6ak6HcB
Date: Thu, 23 Jul 2026 11:53:14 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Akari Tsuyukusa" <akkun11.open@gmail.com>,
 "Nick Desaulniers" <ndesaulniers@google.com>
Cc: "Matthias Brugger" <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Nathan Chancellor" <nathan@kernel.org>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>,
 "Yingjoe Chen" <yingjoe.chen@mediatek.com>,
 "moderated list:ARM SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>,
 stable@vger.kernel.org, "Ard Biesheuvel" <ardb@google.com>
Message-Id: <ef007a23-46bd-41d6-83ff-264831341093@app.fastmail.com>
In-Reply-To: <amHYO1c-5vzqSekt@buffalo-ssd>
References: <20260722172443.534251-1-akkun11.open@gmail.com>
 <CAKwvOdnbPKoTy72EvfpKtT9Ne-r+O0j99KFX8OvjGk8ZxsuEGw@mail.gmail.com>
 <amHYO1c-5vzqSekt@buffalo-ssd>
Subject: Re: [PATCH] arm: mediatek: fix secondary CPU boot on Thumb-2 kernels with
 Clang
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026, at 11:15, Akari Tsuyukusa wrote:
> On Wed, Jul 22, 2026 at 02:03:31PM -0700, Nick Desaulniers wrote:
>> On Wed, Jul 22, 2026 at 10:25=E2=80=AFAM Akari Tsuyukusa <akkun11.ope=
n@gmail.com> wrote:

>> Can you perhaps help test/verify that Akari?
>
> I tested your suggested patch and confirmed that it fixes the issue.
>
> Device: Lenovo YOGA Tablet 10 (Wi-Fi) (MT8125)
> Toolchain: Clang/LLVM 22.1.8-2 (cachyos-v3)
>
> Tested-by: Akari Tsuyukusa <akkun11.open@gmail.com>
>
> Can you send your fix as PATCH?
> I think your approach is better than mine.

I think we should wait for the llvm issue to be resolved first, to
document whether this is considered a bug in the kernel or the
assembler, and to see if any other kernel code may be affected
by the same thing.

Looking around other .S files, I see the same
pattern in stext(), cpu_resume_arm(), mcpm_entry_point(),
all of which start in arm mode but end in thumb.

     Arnd=20
