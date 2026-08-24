Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE546C84A
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589857; cv=pass; b=PWGBExzXc2Q3TsDTdG3ic7UAlFXZ5PSg0poX1UuPMlOpVPsg0zAOr6qNY/wI3i83l0ATBSrKVpsmGXzXybRYDgGxJn+uKBj+yrkNX8qzu3HzBC0XoCFjbH2bQoyNQntnb/VbmPS0NEObhZPT5G7dYPcCeqaWFz/jSF8ajXPZQXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589857; c=relaxed/simple;
	bh=lw34RtAtd/YERqTty86PxKqroI5yIeZ/JFzLOy9obKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSfjruSy+fbB1V27GNmfh/e+m1m73DGZkDGm7wN2MK8qLece4ZMDWDYPBqDbGQb1jOIvXJJgK0LhSvg3B62+SnlWa8hVdpQffVbsTCnhv2m4tDMCEKow7rbgqUfOXpRDQKr0c0+2YQSGUm4ThZFO3iUU/7+u5I5Vs6bbx0hASiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHecTTe0; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHecTTe0"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c10ed63c0so469881cf.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787589855; cv=none;
        d=google.com; s=arc-20260327;
        b=YFyC92wNluyusBcaWsFB5DvXBzJesgtQK6Qx87xVicYioOtEP8euzq2z/eWsVZdcg4
         JTcExNICK4TE1+GL+sSmyuRQNzcgll5spE5cv7wKao7e+cdwZ9Zi0bQ+70h0azKKEeE9
         K0NqMTcH2OWTer6L2Gp7HRSp4UoAgUfp8VpWRduU++kaDO+ZE0v5HX7E9rpml6sawuaj
         h6l2T0zk4EP6gNN5oIub6AVIGEnHNWgm23YjCQSEaCxvxZqsrMCxPEoboA5QfeVcJI4b
         4c8HaBFHXeKNT3ha6NHOFL0l7RDokExhniDjZM5z1UaUcbZYQSXYU+h613AWH55O/p6d
         fA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v8n7u4Av3FZDgQp3mwzYnpHadYzCcRvADEKN8iR0SUI=;
        fh=PO9rvLc0exGwylPPtgWJOc8616fWia9iopg7rnrIV0Q=;
        b=ST00YcWN/44AalPAJ4JFhSVQqoIvcAKzfSwljmTaBWu1KJEZqGcxnZ4XHpdT868C9I
         KfoLwMNV6D+Q9pJy9SwEqcZGP7acGEIToadGkUYx7emaVkh+gbi3qzZL0pDknM08Vz8X
         pwns/Q8c2wuV5n/yyaG3MOvfsD5r1GZxOCqrR5qaUD5rkEtzt++Sxf3Y9D4ziCKvXyH/
         EdH102RmFJ+P2GVsnzGcy1W1WCcP0Uct7rZ/wLqZ6/ZcdmAsXCScybzumYXvW04SKOUX
         6EfZZpAGOS9BY11C2FHga0WdvuhvFYgqLNzmEuYObGo6iUNiDIM0ps02SsaOXqWuTl7L
         i1xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787589855; x=1788194655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v8n7u4Av3FZDgQp3mwzYnpHadYzCcRvADEKN8iR0SUI=;
        b=HHecTTe00eVx/iTBpuUNIVtaCYe/u8LZXqND+Q+N4daO2b3MrtciWpimg5Uhq8fp9S
         niwXr2ejWxG6E16RTOyu1YukL694IfeBpQh/Uu60pa3nLJsC9LRUGWgFHRHUOQJlXnz+
         dfcX6PS91S5gqhKekLUpHwmzZajVL3ZmrH4vbSddJWbw9cnYdpN430xMUwGX60QrHdDU
         E2jb9NC2S1Cv+sUZNvaXdytRDnSu9IDCQ1jR7n8IbzeqWiKyQw1AvOjgYPri9j7oRCWU
         SmgXxxe3i7VlpWbWWem3NxXJvVjrk1HCa49ccZc4TXtTzA1PNOwbv0nzjFPRfGPe3rrY
         cjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787589855; x=1788194655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8n7u4Av3FZDgQp3mwzYnpHadYzCcRvADEKN8iR0SUI=;
        b=MmzGgTxfS/3TC72yyhbHaDVHuYnLvtS4bCBFXIAa0YJaxdGHS4GeWVnlX1hIxtTslJ
         lxqgfQ1AkqgnHz53Oza6Zx1g3uFgRcrn9FLKc3DgufUKHFA7G2ACAhwSxN/9xQbBrdu8
         vSsvufiSno6v4Aq0TBMqfa85GvfABUNg+kAcoVQpzn2DQ2+lkF/cA8XNlfos3zn5rhCu
         LaMF57dFexnfYqYbyMGTdvdyUROpJ4UWnAMWzEwEWWMo56/c1a4rf8L2+z72PWb8aZMg
         AspSEQ+jcaCTkQ4q1wCh+kfoWNE+gLKW6YiYMPst7RDbdzsBc1QntJOtMnr8EjNXCG4w
         xP6A==
X-Forwarded-Encrypted: i=1; AHgh+Rqz55aXcZgh81ydNb3o8tIwaqUHdO1xIqM5vO+fDlkXsgYJNA007HjpcSXysZchM8j0KpjnSAo=@vger.kernel.org
X-Gm-Message-State: AFuF++n8DWakwHgfaoB1j0vMHGIgRY0PBi4jBiltLiHFuk3dHnmp6Bph
	M3AowzVKwmjshh99k4y1jLiNS83tau7rhTLrzuDJFfsf64loWhdEa3Jjxj+nI5RFmUcyjsbf5JO
	AngTYic8h/9iUfiKYpWjz/xJNaZ5C2uIlKgvatoL3
X-Gm-Gg: AR+sD108hjqRk3TeCmoIie7b+g0rj8KHS3VY6x9UUiUqjL0wt3o42EjMppoC2jpEFEe
	2hTpHInXprM2EHdqJzgKcDzwVe0PLJJSYeDwdnD9HoZ0e65d2f4AvYNajuBV6mY0GAh+PwAwQQN
	BFD6tqRJyhNqduI33TeXNaf1wKnAwWcdIX9hMQQqdXY7Mha+JlVYfbtV+iCZqXCWKHDA0LVl7TL
	gW25rK+J8qVuJ0wDxjZLmqS34Yaeq2VcAvVdgXZiTM8v01pVXIWyZYYRpRS/yTy2Kj/YfbEMdbN
	/FJjB39bMPWk3h38vUuWVQHRJixKV3k+OqXXhPtY+BA=
X-Received: by 2002:a05:622a:1b2a:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-52e092f16e4mr42031191cf.4.1787589853987; Mon, 24 Aug 2026
 09:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817062726.106511-1-hao.ge@linux.dev> <20260817062726.106511-2-hao.ge@linux.dev>
In-Reply-To: <20260817062726.106511-2-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 24 Aug 2026 09:44:02 -0700
X-Gm-Features: AcwNN1Vt8cECV76f4DrYdyxlek4yoLVqyMGuasMmaWPxXTrP285P-kcpJdRH-s4
Message-ID: <CAJuCfpHbcJVQVpGx-0CYR9W=axy60FtiaPK0G=B=U0KmGWiyvw@mail.gmail.com>
Subject: Re: [PATCH 1/2] alloc_tag: skip percpu counter allocation when
 profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 11:26=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> After shutdown_mem_profiling() clears mem_profiling_support,
> needs_section_mem() returns false, so later modules have their codetag
> section placed as regular data and never enter the alloc_tag maple tree.
> codetag_load_module() still called load_module(), which allocated a percp=
u
> counter for every tag; release_module_tags() could not find these modules
> on unload, so the counters leaked.
>
> Return -EOPNOTSUPP from load_module() when profiling is off:
> codetag_module_init() drops the module's cmod, no counters are allocated
> and the module loads without its tags. codetag_unload_module() now always
> calls free_section_mem(), since a module whose module_load() returned
> -EOPNOTSUPP is not in the idr but may still hold a reserved section.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  lib/codetag.c  | 10 ++++++++--
>  mm/alloc_tag.c |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/lib/codetag.c b/lib/codetag.c
> index a9cda4c962a3..a0b600720afc 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -240,7 +240,9 @@ static int codetag_module_init(struct codetag_type *c=
ttype, struct module *mod)
>
>         if (err < 0) {
>                 kfree(cmod);
> -               return err;
> +               /* -EOPNOTSUPP means we can load the module without its t=
ag. */
> +               if (err !=3D -EOPNOTSUPP)
> +                       return err;
>         }
>
>         return 0;
> @@ -388,7 +390,11 @@ void codetag_unload_module(struct module *mod)
>                         ++cttype->content_id;
>                 }
>                 up_write(&cttype->mod_lock);
> -               if (found && cttype->desc.free_section_mem)
> +               /*
> +                * A module whose module_load() returned -EOPNOTSUPP is n=
ot
> +                * in the idr but may still hold reserved section memory.
> +                */
> +               if (cttype->desc.free_section_mem)
>                         cttype->desc.free_section_mem(mod, true);
>         }
>         mutex_unlock(&codetag_lock);
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 52aece27b00e..80eccaca665a 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -975,6 +975,10 @@ static int load_module(struct module *mod, struct co=
detag *start, struct codetag
>         struct alloc_tag *stop_tag;
>         struct alloc_tag *tag;
>
> +       /* Profiling disabled: load the module without its tags. */
> +       if (!mem_profiling_support)
> +               return -EOPNOTSUPP;
> +
>         /* percpu counters for core allocations are already statically al=
located */
>         if (!mod)
>                 return 0;
> --
> 2.25.1
>
