Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ADA3CF1F2
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002754; cv=none; b=ZSLtkU61aP6uVdZQzE+DbecLxaxYrO/JrPxdBFFNcRIkgqOW8XeJNIGwNg2028GA0sfSvd56/7T0UPC5+bDgwHjDH0QVMhHKkwtH7qaaPQsngzqM7CA55yARPWoRI+FBTVZA8rjf1EfWlfp95bTViXA9+JJ2fUPpTKAvTSk7eL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002754; c=relaxed/simple;
	bh=WG7M7t8uq10tRrcWEkMwDHyBDYPKNUdhhypPEMUioXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elOTM+DuDN9qz9gLn1WrXH756h6UFhP41njzlHJB7kYwUkiIF1ykm0C3CoFOQ/27uePJ5bUBSSB5keDSJHiNlyvKbjS2MojiBf3q14HD/T0Z6MoRwsWDPlRv3zz63hVQfS6sRB2yY+fGU62aEFCRJa4+que/0HLpYMAB7YiXgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso695241e0c.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 00:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786002752; x=1786607552;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n88N9TJQ8fRDATD3f1A4f8qTuYNPAnmP62DPfn7h0E0=;
        b=bkFeOhbJ6H9IYHV/NAQS8LFQYFaQswKp1IgwcjgoNh8WKIKCw7LEcJm7UV6T5sITQb
         OP2o2i3rfOlgNmRvwXm/+P1VTpIOLwIssxGIFZjlbKZpdtR3VsiumGFezM5X0DSzMD4M
         Y1JMRKw9XD7nK6bYmLFCTsKaTnb0N/al5Z+aHSFf+a+9Y6VGXKZLDG+R+zBNjQaM+L1w
         oyMru2eHMr87v2/+NkJfHgR+H9a449Nh126kE7EOKafoe5GOrxZdR3tzM++113sdori9
         DoDO6ztGFJPc5wZ6o8mluzEj2tds2O9gvQDyVh6YcY7Yl5m1upBzzSIbVoc7jwX9tKSb
         4F9g==
X-Forwarded-Encrypted: i=1; AHgh+RoJlTMBFFtor8w4wrsybE12L/w5MaI/yoGxhbdK7USbZY+6MhKhSxWmV7vSd9Ub9McaS6s3EhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSDzV7rh7qXZulZjxLiZt98PjjX0CPBJAcn5/+X0UTDtoJvzRE
	jvgrvUTdd9eKVSYp8EtpbvvjD1TnFCsm0GMuOWp6M86XuXB8qClvyCNkiXTt/hIh
X-Gm-Gg: AR+sD10q/+kxux6riI3AjxJshJe7R4snVvT5zgkQ85tJrWq7OP7Cwe9BC5YosTMxzfE
	MW3yGzxQUaJd0U4XB6xUtzUnL1fGLtivWj/spv2qPPENpA9mZc5M/NeXkFvANUKqJz6OiFDSaTz
	F19FORikEFFUvLOeYE+9pSeY6hagmhDJxn4JJZnlLUXcrCS1Fl0m+T1rOsjAilJcib8V3dm1Pa+
	EjphUnD24elR/zcpzlcF9SzUJ48dv+3VZwYlzEGHgdnVKWnZ7BIVU385oZ/NTecJkC2PBhSm/Vt
	JS9DqqE5aAmWHpS/fIHodkEE6f51x5Bybudpbe5fqQC+Euic59QoQlVFvgAGtLCDJdrcfOudnfw
	eJsUveMWLowjm0paxeZ+yt24Wq7hf0AYfHBJgTjvhzsdOPzOLJPFgOHkQfNxK1DePZb7gbosOu0
	1syucX1qGNdepOIyob9pi/UoncYxrWY1A/+pdeb4fBBah4zMbuKwDI+3mXx5d5o/rBk702POH3C
	rGU4c7c63Co+9KLqflbBDFyD2vt6g==
X-Received: by 2002:a05:6122:1d45:b0:5bf:9f77:477a with SMTP id 71dfb90a1353d-5c3d9087aefmr1544449e0c.2.1786002752368;
        Thu, 06 Aug 2026 00:52:32 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d050f8c1sm2902654e0c.2.2026.08.06.00.52.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 00:52:32 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso695239e0c.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 00:52:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp/vNm7tMDo5urMkickMPLAT/pH51IV+lxZi312gyQaLss/Oh5jjVueqe8C9vHFtieDdADbpGQ=@vger.kernel.org
X-Received: by 2002:a05:6102:4bc2:b0:738:84c:6b3 with SMTP id
 ada2fe7eead31-760e6ed510fmr3062569137.3.1786002751900; Thu, 06 Aug 2026
 00:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805-nh-of-alias-overlay-v6-0-74f21d440819@nexthop.ai> <20260805-nh-of-alias-overlay-v6-6-74f21d440819@nexthop.ai>
In-Reply-To: <20260805-nh-of-alias-overlay-v6-6-74f21d440819@nexthop.ai>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Aug 2026 09:52:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7bk2vMM2DDmfsqfWcY+jOjqyY2Se+XKSXa_BW2JPPHw@mail.gmail.com>
X-Gm-Features: AUfX_my0cyhHKr77GIDyKss0dA1Fh55Wy4MieFIvBzFx2HcgPgpOu-eXIpjsSOk
Message-ID: <CAMuHMdW7bk2vMM2DDmfsqfWcY+jOjqyY2Se+XKSXa_BW2JPPHw@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] of/overlay: only treat a positive changeset id
 as registered
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Shawn Guo <shawn.guo@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Aug 2026 at 22:31, Abdurrahman Hussain <abdurrahman@nexthop.ai> wrote:
> of_overlay_fdt_apply() stores the idr_alloc() return value in
> ovcs->id before checking it. On failure the stored id is negative,
> free_overlay_changeset()'s "if (ovcs->id)" check passes, idr_remove()
> is called with a negative id and list_del() runs on ovcs->ovcs_list,
> which is not initialized until after the id allocation. An allocation
> failure at that point dereferences NULL.
>
> Make free_overlay_changeset() treat only a strict-positive id as
> registered. The rest of the function already copes with a
> partially-initialized ovcs, so the error path stays a plain
> goto err_free_ovcs.
>
> Fixes: 61b4de4e0b38 ("of: overlay: minor restructuring")
> Cc: stable@vger.kernel.org
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Assisted-by: Claude:claude-fable-5 [Claude Code]
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
