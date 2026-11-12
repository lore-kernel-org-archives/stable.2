Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510502;
	b=5LRCidAyF5Zz5JpRSCUXMSYUKA6rREQYHo3UdxmnjaiRE+Hp+wGrnkT3MOrSPVB4rroU
	 GPQbfI030cNrqZn7b6I18gs9SU/px2hITkugNZRKkEbloi2zzrF6k6nM3EocaQlwEaNVM
	 2FVsTeynOhLRICWdw5pvpzxZBMvUxLPm8X+X8w/MZVfuJ6zL5F+n1jRsdwepxc520nvg8
	 s5n+jPciLiPKoWGyb3l3SuuAjzvL4dN7NxdbWZ1bSITvLoxA9mfrV5CKDzpyCTuuzCuX1
	 ipqaJVrV5eiNKeZJZUlCZjZ1yLhq6ZXRxslf44q5fQMsonf7Klx+dKgIcruJ4q0rkGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510502;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=x7avfF8CE7MQkedzx8waSCJsEYoj4qczcsv6b4mLDHA=;
	b=z3P8MXCZCsMm/BPVWfRapOrgjyUtLOMG2DK7HN4ypjzPeL8aq3pO47qFeto0a8xmyREN
	 9wjtkUmBJVWXuMJdyXZPpE/zGI1+AnJXN/XF+WmoyPQeSxorabJAz6RGbtV6m9Mx4moeh
	 tsLT6DedJ1fkmRUSx4xsXFukR7PxUawRx++NNV6NLoGJr25Hfabs+TjEChG+wUE3RR6FX
	 81aVVxxdmQ1mBNGnO0IlIhEiNIRQ5MOxzHbUXD8isLbXZQ2bIOr4/f6imZ1B/6rqpsvP9
	 je0hwiinNrQHc2BmOQWRgaoV/JeOWelPE+0cPtRQ7khooZyTBpeC8mmmGVhzWjqbJHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2B606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3D2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99075306daaso157347241.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510501; x=1795115301;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x7avfF8CE7MQkedzx8waSCJsEYoj4qczcsv6b4mLDHA=;
        b=dt30OZNJOraNEBxWxlQlNiH5Y/2xg3lyG8gtDwEA/HIn+4FqYtzq3qPNQrHOYZjixs
         u4Bojz+1J1WgacxLH+fAS8TiiFcdn8189Ki7yIKGcZ8uCjrhlnuB98qHGncWHniCRW2X
         FhG+x6N002C5Ge2Zp8X0lrJ08nSw/tVom7IY0tgirdiOa4mnm5YWHI+Q/mT2YaATa+94
         FUnZccF9U9Ef6iaijBCWjN91HUcssK9I+Wrq9ULaFhWZPv7fPblGXOb147tIVgXJLksM
         np7IiZEdqRYU6vsuH9/yUotY13VTRkUxxWIFQvXWlxGLQ+Iwzhh+8YgCN/pgUd9axa2i
         uBhA==
X-Forwarded-Encrypted: i=1; AL+hErEDDa58BO31x1e50mNZCLKLV59DSkzz9ChRcn9b2KkIo61BIxGw7fqZEs4RXKwebkAtpEzm7qM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Z1ZZfPpPpcNUn0/YmM5BP7VyntCn0BCiJghZ6PRxRZm1eOuN2
	IH9kIffNxU/a0jD23V2/MZX6wCpIZZlQlbDu+blPLIF57yuRyeU6hvOplPq6LI+MKPI=
X-Gm-Gg: AYBFou3UOQcLA1T/I7++7AVbJuS/dFdg1F7vJUR9r1j7A0dbu27UkWjv2JtoXLiIXUd
	Ke7CYFXbcc7GI4H77ch8QbYhHLhSlILt6ovvbAdlidwnDFio+jUNDbt9E6BskoaKS+FgUECAQaW
	JrSGEXZdFKJ98+oAcLQy2l1ZDQetHnHsHxwukyT8TItyP7gv/4Zpety/Y+kOHkhiV7OKioGQDQj
	a8Sp6yFICe8HcxAGmaJkigilptkVnZ9PixVaz+7krj5qmjoEOlMeUPS2OjQUx382CGhEYebKsbO
	VcjeEJQgBCPuzWAnaKgBgywZRx14kKM9nz9r1MCNMQOix6NKmirTG5Zl5dYPXaiB9X4K+IjuRSd
	8uepV0VjhPzB3mOBwiRZ5ILeiWUuX7IiMRzurPlnmMw816N58+I3g2ePGyKf6Kv9Nr/1MjEeNp2
	pxSy5bW6DZe6r0bjskD7li1PSvMR0WUXQ7F6dIR7niWXUfixopqUmi58LgAtarqMErIPHpw7y6l
	MCnxKu0SS22WzewXUp1u+TO/C+D0CnXZLdfmQCypFP1qRa6Brpio3pVHI0h4LCnaBx/maakufYm
	tpROFnuoSTM2bNNl4ZJzICHdZ5wp92Ob9qxW/q1PF4MULLN1yR4TeOv5VYYWQG3DBkI=
X-Received: by 2002:a05:6122:e1a7:b0:5ea:d2fa:c2e6 with SMTP id 71dfb90a1353d-5ee34a970acmr36715e0c.14.1794510501487;
        Thu, 12 Nov 2026 11:08:21 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee341da79csm90226e0c.7.2026.11.12.11.08.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:08:10 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-998569550adso141106241.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:08:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFfJRucKzyDC9S2b2Rk8T5CEVD2ubTiBkY0GMH9iooyFD0ZFTeCQa5XLi/Rj2FaTRNMAONgEcg=@vger.kernel.org
X-Received: by 2002:a05:6102:c15:b0:7d2:8dd0:2eb with SMTP id
 ada2fe7eead31-7d64d6ed886mr73919137.8.1794510481935; Thu, 12 Nov 2026
 11:08:01 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org> <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 20:07:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgOGjwOUMxSabUgtaVeKZW1wx78XOJL8joGKkZEj7RZw@mail.gmail.com>
X-Gm-Features: AclHuK8l5OcVstuPYNpoHJ657hIuMQK5i9ySH9sE9lHb16H-lVuh0fnzCqi0JCs
Message-ID: <CAMuHMdUgOGjwOUMxSabUgtaVeKZW1wx78XOJL8joGKkZEj7RZw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in copy_oldmem_page()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Chris Mason <mason@kernel.org>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 17:43, Christian Brauner <brauner@kernel.org> wrote:
> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>
> Return -ENOMEM like the other architectures do. read_from_oldmem() turns
> that into -EFAULT like any other short copy.
>
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
