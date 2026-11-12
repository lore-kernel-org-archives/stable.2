Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510620;
	b=EMXE7RhHg3Yo9MJKoG8pTdVFnnWJxq6nzVOPLWlC9U5i+Y7OoQ/qlpoRpfov9oVeIp6A
	 CfSxM43vXVB/1u2uN4Am9y6h/emO021XzG132vGlIfRBXZJNNJDghqR3PrGEJdfNAc9Cw
	 D9sp/xIdRr3hXsjGoiOEStsFC9mf60TfwpASI++L5815vywQHyddRN/FB23TkG06tGTxy
	 zrNHEUuEL7OaPHD6G4Jw0KE91Rr4+qkc+b/VSfQAQLBuWQ17rYq0ThlvsdJVmwK5zmEMZ
	 vZY9KSnLnjAWIvIgwC0YhY+30Tc/Q20uvE3FMRbQf009zYD+d8WBPnRqny0jyU/ZkXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510620;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=BiDOWQWnXjiTVlwWz8It4XU8j0IkMRXtLOxSJ2sBmUk=;
	b=m3KbtbGXoxZ+6PSFJiQEUOHAbvM3dj/JKMrTgdWydoyFtqpTMI5YZC0MFz8PELSXqx9c
	 MGv9XdKrxZRgC4H2zOouZ9IxrT07/xzOnqbMmVmIKM+jt6rfMP9iUNZG8tJJn34HhaC2T
	 xY8PMaVqU7fQ7W+anpuzpJdZeC2n+Zt/E8/YixAHR94dLXF6HtQ2mJQUdiESojnNY6gOa
	 7ikpGMNTx7jkvKjZy8hAX70vO/d4wcbMTEq01O9LlbU6qN26ZssY5ohE/UTIb9Qvfoa3I
	 MJ1tiVKx/ugrNV9YS8Tj6bUEl+0q4pB4Yql7i0GMKgwAN/wOBfzVsofxChcSnVQFMJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126D606A337
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E126D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5ecda93627eso78176e0c.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510619; x=1795115419;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BiDOWQWnXjiTVlwWz8It4XU8j0IkMRXtLOxSJ2sBmUk=;
        b=A0lZaEeRiEK+X31mIn6SqHw+qPk3+tPNk+w3+w9Y31yDJW/Px9xQRfxc/y5L1yZXJF
         Lbl4xkTF0Sqf+GUXzBPCpT+ievFSpPaRZKv1hHMK9H17zDu2LbKy+H8hwWCLO7QKhRPg
         H9vlH6UbPuva8FthIKFe01NBXo8RH66pS60SzSm8N7mYEt9naLQbeEQ0CryyJLLMjhrc
         bLjAiQkz1BTo/h5e29kxunsJgm4wraS1j6pckaPtY8bbyxKJxkGpup69Q1znlROlh9zO
         6e8ay09ap4ivK16UkZhhxnWQCF4RcDXrx7hBSn1hJrMiVz7Y1TOmHfNDUm9qGln2ETpE
         FP1A==
X-Forwarded-Encrypted: i=1; AL+hErGoyTrVaf7R64yrszMhLa8LYumUhto+kIdAe6n+2k9Rk44jAk+t0ScR88L0KgxeO7xOwavwY2g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4WHRq2zbh87RrVJGfF+DhbxJfCrCtZ+pWBGqc1YSxLt/AodaH
	Y68iqiqrxdX6NKeGTjS2AxYLHyhnxncmO9xH5+2s6ANF/lHgXs9X77b6h9bdw3yTnd4=
X-Gm-Gg: AYBFou0tlwkJ+2KQaNHBWu0yhmHkUlx324dW8AbNhT9NNEV0+R+PsIa1Z1jBwNnMLcO
	DpHwzS6ZULayUb8kYfYKdDElvw4dARGxKee20D3rJxFEXKV0aQ6n9Qb5qHma//ZE5RUyuvqP5pZ
	U2a0lB58pCOdLKRCU/8tM72oiar1PITm7b003wSf291HmwfYI1LBfbmieGmQTXoHqQd3O0RezSw
	7PCZqDU6woz7AmZrJ1Kr8X970TfqaHBSjRUs4I96xD8+gzoBg6vZVpf/HCLe82ystzzOBPnzZ4i
	p481FnUdBxW5zXVvTcm5lsAqWPecDoJ+GtPgT5MwPStanfXdfDVrF1vikKdGvC16Q+vPomeaivc
	aFFj4I+0BuJVQK7otfN/4AaQCP5Ke+nag+GhNQw1cJVq4mvd7CigJlEG/Sgz/7aNE3WmtVVPrht
	YZyNq618Mf6wsQrGQWLkithrN4dJBfTAYnaqDjOnXRz3N0K5nNuKJZ0f4YL0GiqJKByP3GR1++G
	PBBjfV432sINA3pSgEWGYD/mKJyY5lB5zqDVpnIFWG/pPVnXnUg4O6Qk8e0SGFnYsJrrgf9fG9v
	HfaCnifkJ7fCYyrgB2gjRfOk4/0/euFL5+XK7lyAny7o3YELsxvo16OCWuwUBI0KwLWM+Y7LBcD
	L7ceOphGPDIeP
X-Received: by 2002:a05:6102:504e:b0:7a7:19aa:f0d4 with SMTP id ada2fe7eead31-7d64d9eb4cfmr49597137.33.1794510618826;
        Thu, 12 Nov 2026 11:10:18 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c544d6asm223347137.11.2026.11.12.11.10.18
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:10:18 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc81984fceso32288137.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:10:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFa6H7ZpPmN0thH+LHAbMoe9qbKjXp5VC7ecCwB0XH9TvmHPEQCT8jkEKo84WtWgfLZ3fXMPCY=@vger.kernel.org
X-Received: by 2002:a05:6102:5ccb:b0:7ce:5952:125d with SMTP id
 ada2fe7eead31-7d64db29605mr42432137.36.1794510618289; Thu, 12 Nov 2026
 11:10:18 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org> <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 20:10:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgM_TMX7HrpsvDaQi96Ht-K6KTBu5PPRRBpcCegf3Q9g@mail.gmail.com>
X-Gm-Features: AclHuK-k7G9fpVKu6BhCbcWfXavvnldoQZhCl9e2eioRf49lg5T7xpzAfc2z5gM
Message-ID: <CAMuHMdXgM_TMX7HrpsvDaQi96Ht-K6KTBu5PPRRBpcCegf3Q9g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in copy_oldmem_page()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Chris Mason <mason@kernel.org>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 17:39, Christian Brauner <brauner@kernel.org> wrote:
> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without checking
> whether the mapping worked. If it didn't, the copy reads from an offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent copy_oldmem_page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
