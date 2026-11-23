Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795461809;
	b=N9zTVZc1fjeijdUKsEPw23JBeaeptUcMwJ86K3wI7y3Y5g1JlSBMBHuomCD47HgusgDi
	 tEeQ5+k+WgSJlU1Un1C0KRSPoot3MpO5P9dXFWCG39qVwf4PGG/keQna17bKdoStJQBw2
	 NmjVHFa/wy7o4r7rVVpCBP13M5oAQrVimngMesz8U2R6BCpEXbOfkSU2ghPNCC+p2fVPF
	 sCLMUIVtIwE3fW9A4J0UClNZfj5a7BtoEn0GA1P4nJE5xgIdSVEiVHTecmARbBeBOngIM
	 j5oosELo3D2VwGQtS+0XbqIq2soc/Qi+2FJdASLzBjlL45irVfB50peisgjXQDfIZ1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WLq3MWKnDvfFRPACkCbZySTur7MfMMWz5unzYWon4qE=;
	b=39bsKHsKK70ylVv0RIcIkhj3QYK9E4Aap3g+fXAbe9sT3oYHq3rqu/6G69s3O+jRfnQX
	 rhGL41Km8xy/dZ0ogneWntUmSsLTr/Kq1PoLnFfjU3pLL8dxZkdtHD7xwjYWUUF+xkGFb
	 oLRYdSe1X7IZJcOlpWy3R2rmWB/uV2K8Eh2pue59CpClCda4YBdsenMUrHeg1bBdc4vvh
	 jmL7jBTqbYQrmAs1msbSVMfz3Txu0ad2U7BrfDIfqtPnXKG8800L9QsoYHtvVgHLC7wm/
	 KbSbhDjAf5pwZ/uy/mG8Ic8U72dSv0ejG/D/T+2mNAanXI7RiFVYiotodgntUob3rAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.tenstorrent.com;
	spf=pass smtp.mailfrom=tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=U9qvPAlU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3BD606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B3BD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=U9qvPAlU
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67db23d8892so3972297d50.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 11:23:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795461807; cv=none;
        d=google.com; s=arc-20260327;
        b=AFMc8dg+9moW8+I43NSb/jdfMGr66zYD7mS6rY3uJPCPp5r9YK+SLaoigDqzPAwu5T
         D7hmSySd15hDYBlAqJ7L5njAXOhkIXghPzbra9XQZv1Y5tIWzejOzQ//h94hlMnchIzD
         Kqi4d/JG/dc8V3CzUkvcEOGRhQou8iKynF/zdN7luAj9sgEF151N4KnaPcw9wMh72+VM
         31gaEgqjWqo89mdPq+GMaN86gptE0tw5VtINB6SMf0YDQu971eRcsE0VuZHJSaY8NFF4
         l1bi4xuQILiSJYftp4DiR/VqyJdoDwoIxjT5iN/uV7sv6hRh3HMUkDX94YUWOJLcE904
         dgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WLq3MWKnDvfFRPACkCbZySTur7MfMMWz5unzYWon4qE=;
        fh=T63Suss+qTZ8j1g3TxnETAbiFz5NaTg7Zeodjkh6cBw=;
        b=gTVkLk2gHtEVBc4L8hPWYjfbkAiH77SqFT98xDvEztyV4pqhXzohgHHGetrrLI+hUM
         lhHC+HAxxWICAv0VFy/t3W4GF69g7TDhboP5F4Hlk/BqHWq3zhaFLNwLpGI4xN8l2XoG
         5qLTJfg7rbD736q2KmuGVwdsEJoR25YthyVrPaGZWbYUrA7QKIIFaI1QVgJAXzXNau3v
         t9DnEirpobQ3BI515/KBxxa3WrM2lonORe4NahU+99jz3rjgQm8C8AxA9T5HYN95OGhU
         iTofuw2rSaTDNEgc6PEHrYmBxlGFqMWibLEk5hLiK3M1Y3rDNV0IqKmsDBZFvzvE7DlR
         2BFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1795461807; x=1796066607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WLq3MWKnDvfFRPACkCbZySTur7MfMMWz5unzYWon4qE=;
        b=U9qvPAlUpHtmFneiecRFsim+TvMaWm4ZsmGwmpXG/Ehz+i0RIkTrHKownmbVxN7ntu
         ewHOXyDL/whyikpeAFOVehJ4UHeMw6uLqf114NMytXrCR/sb9KzCZbUXC/RleVV2Q8dd
         SS9m8kDNjm8igh1CW8i4HD/NOMSDg9/TVJbGvQiZUeqLAm0xR7in1WFJERYgQHNE89df
         qgWH6YaFnPFXgnpqtBUYZihFSSOiN5Dz1UND8bm5zxQl60sQTInzwS/J+S8KC8FI4aCF
         MBZKDNvWOLLCtuTQnLKb1/J8TxECZzFgYLblKHyVk4uAemVtHrJelnwLbBC2QNGu+aZq
         5Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795461807; x=1796066607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLq3MWKnDvfFRPACkCbZySTur7MfMMWz5unzYWon4qE=;
        b=LpM85E1EkmBk4sLsfR1jz23TIqOhoHC4OUv/pK4XFcyKPgVARm39vk2AtU1tvqsP9a
         v1OirM09ncHqKvqlF6mkZv17bLyPCRNLdREBbKbVQpo2tmIZAbgMxewygOlYU1604vkM
         ZxLM6PDGXCcmvZVlSPjMjY1MkQSCx5MUGoyNnO+qPwSJ9ihFVBC+xH39enI9QOPZL2pm
         FrHrR0fnD7WMA09fF1InnRjfRrut1tAAOO8N63+dC4xqnqiK4dgs3+Vygo08+cA61d7d
         4oIPaTK96+tnz9FRoHHDg8hQtUz0TF1Ux7f+9gL92eFHkudjQM2N9+1i7bmKqwUdRkWw
         WyLg==
X-Forwarded-Encrypted: i=1; AL+hErFfYq8GSZqUTrjYPjYgcySlX5jDQHxiC38Tz0WrxeIskwT7ERSsnADK82A99jLAYjE1x/hMA1o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xfPx14TqgpbYh1rYRFkhVbVaQWruUkNI9RAlifUErYWNkUlfm
	NrXtdTL7zWSAImXTbpj0UO8Z9vJslw+70N5wAw1Klyp1yT7O+hiWW0QlVarXCBBt2/Yk0c1j5ak
	OjTqWxJFZWtaZD44RRFkhHjfeqiyrX1kv1YPQv502lA==
X-Gm-Gg: AZFdTZehSH+XSWm9v0qfqgOqXYqAzOLhh6A0XE8/fq/ZzWFDlN8LWNAYQn5Ze/fF2a2
	RAYN+Xm+EDWkU7tNjrSRFg72TbCkrA7nfAvcIHbL9YiBzQJgbCunOsVKJpfud8pqHr7EE9AXdWA
	E9zkbmut3fNSz8MMGOFZD/ZcjaLDcCz21G2ygl0b5gihhvaSNkcH65eURIUHqhlkMyWnP2+Gm6x
	4065nZYSOTX3ff9oQqk1SUZWg+XKn6vLklE79rFimmK2gIf1hHvrlR9WJ2WFjrG7zK5RUFqzAqZ
	+2iPkgTLBuddfQxpwmRffj0SUegOynP0pwBnVY4cf2OXA5u8HTmddlQy1NGwim4yoycebO8pjJT
	JD+3G3X8g3AMZAhDBfqaa+zMoGKvEFN7dwCciFEff2sZkhtW+SKOcz/XtQy6+5utTFLvjRDVwCo
	M2C2ceMaf04iuFnxmcdBODAPVYYw==
X-Received: by 2002:a05:690e:47c7:20b0:67d:bbf9:11d5 with SMTP id
 956f58d0204a3-67df443ce21mr4010766d50.55.1795461807055; Mon, 23 Nov 2026
 11:23:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123164834.3330320-1-lee@kernel.org> <20261123164834.3330320-9-lee@kernel.org>
In-Reply-To: <20261123164834.3330320-9-lee@kernel.org>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Mon, 23 Nov 2026 13:23:16 -0600
X-Gm-Features: Aa3M54rXx5AsI23DPhI8Gl_apOGxLaDoOy7tWbjmJE6RhLCtQ26K-zDZRMPyVoM
Message-ID: <CAEev2e8KMaN+Vw7usWTiQk=dyOcV5n9PEHB1o7K=cQw=fyoBZg@mail.gmail.com>
Subject: Re: [PATCH 08/10] clk: tenstorrent: Poll atomically in atlantis_clk_pll_enable()
To: Lee Jones <lee@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, linux-riscv@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Mon, Nov 23, 2026 at 10:49=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> The Common Clock Framework invokes .enable callbacks in atomic context
> with interrupts disabled and enable_lock held.  In atlantis_clk_pll_ops,
> atlantis_clk_pll_enable() is registered as the .enable callback yet
> waits for PLL lock using regmap_read_poll_timeout() with a 500 us sleep
> interval, triggering a sleep-in-atomic bug via usleep_range().
>
> Since the PRCM regmap is backed by MMIO, use
> regmap_read_poll_timeout_atomic() instead.
>
> Fixes: 23c8ebc95284 ("clk: tenstorrent: Add Atlantis clock controller dri=
ver")
> Closes: https://sashiko.dev/#/bug/linux-980395a6-f282-478a-bf18-b5695a725=
735
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/clk/tenstorrent/atlantis-prcm.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Thanks, I was able to reproduce the bug on the tt-atlantis qemu
machine by using a kernel built with CONFIG_DEBUG_ATOMIC_SLEEP=3Dy,
CONFIG_DEBUG_PREEMPT=3Dy,  CONFIG_PROVE_LOCKING=3Dy.

[    1.895417] BUG: sleeping function called from invalid context at
drivers/clk/tenstorrent/atlantis-prcm.c:329
[    1.896093] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
1, name: swapper/0
[    1.896616] preempt_count: 1, expected: 0
[    1.896990] 3 locks held by swapper/0/1:
[    1.897251]  #0: ff600001808a7938 (&dev->mutex){....}-{4:4}, at:
__driver_attach+0x68/0x11e
[    1.898561]  #1: ffffffff81d70bb8 (prepare_lock){+.+.}-{4:4}, at:
clk_prepare_lock+0x1c/0x80
[    1.899134]  #2: ffffffff81d70b30 (enable_lock){....}-{3:3}, at:
clk_enable_lock+0xb0/0xd8
[    1.899750] irq event stamp: 25978
[    1.899968] hardirqs last  enabled at (25977): [<ffffffff80d12254>]
_raw_spin_unlock_irqrestore+0x4e/0x70
[    1.900552] hardirqs last disabled at (25978): [<ffffffff80767d00>]
clk_enable_lock+0xa0/0xd8
[    1.901195] softirqs last  enabled at (25724): [<ffffffff80053e72>]
handle_softirqs+0x54e/0x590
[    1.901798] softirqs last disabled at (25717): [<ffffffff80054132>]
__irq_exit_rcu+0x1f0/0x25c
[    1.902422] Preemption disabled at:
[    1.902447] [<ffffffff80767d10>] clk_enable_lock+0xb0/0xd8
[    1.903375] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
7.2.0-00071-g9a0518d4d70d #3 PREEMPTLAZY
[    1.903558] Hardware name: Tenstorrent Atlantis RISC-V Machine (DT)
[    1.903643] Call Trace:
[    1.903687] [<ffffffff8001927a>] dump_backtrace+0x1c/0x24
[    1.903718] [<ffffffff800024ba>] show_stack+0x28/0x34
[    1.903734] [<ffffffff80011262>] dump_stack_lvl+0x60/0x88
[    1.903750] [<ffffffff8001129e>] dump_stack+0x14/0x1c
[    1.903766] [<ffffffff80084b76>] __might_resched+0x23a/0x26c
[    1.903786] [<ffffffff80084be6>] __might_sleep+0x3e/0x62
[    1.903801] [<ffffffff8077fb02>] atlantis_clk_pll_enable+0xd0/0x1aa
[    1.903818] [<ffffffff8076d10a>] clk_core_enable+0x92/0x2fe
[    1.903835] [<ffffffff8076e130>] __clk_register+0x5c4/0x874
[    1.903851] [<ffffffff8076e558>] devm_clk_hw_register+0x44/0x96
[    1.903867] [<ffffffff8077f812>] atlantis_prcm_probe+0xbe/0x18c
[    1.903883] [<ffffffff80806eda>] platform_probe+0x46/0x78
[    1.903899] [<ffffffff80804946>] really_probe+0x86/0x234
[    1.903914] [<ffffffff80804b58>] __driver_probe_device+0x64/0x104
[    1.903930] [<ffffffff80804cba>] driver_probe_device+0x2c/0x98
[    1.903946] [<ffffffff80804e22>] __driver_attach+0x70/0x11e
[    1.903961] [<ffffffff80802908>] bus_for_each_dev+0x60/0xae
[    1.903976] [<ffffffff80804488>] driver_attach+0x1a/0x22
[    1.903991] [<ffffffff80803c36>] bus_add_driver+0xce/0x1d6
[    1.904006] [<ffffffff80805a5a>] driver_register+0x3e/0xd8
[    1.904022] [<ffffffff80806c0c>] __platform_driver_register+0x1e/0x26
[    1.904038] [<ffffffff80e31bc8>] atlantis_prcm_driver_init+0x22/0x2a
[    1.904057] [<ffffffff8001296e>] do_one_initcall+0x76/0x39a
[    1.904073] [<ffffffff80e01416>] kernel_init_freeable+0x2b4/0x33e
[    1.904088] [<ffffffff80d065d4>] kernel_init+0x1e/0x13a
[    1.904103] [<ffffffff8001440e>] ret_from_fork_kernel+0x20/0x3b0
[    1.904119] [<ffffffff80d13c22>] ret_from_fork_kernel_asm+0x16/0x18

This patch fixes the issue.

Reviewed-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Regards
Anirudh Srinivasan
