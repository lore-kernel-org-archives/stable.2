Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255039AD3B
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463388; cv=pass; b=qgbFK2OuiNX7+2pqn5zuWUjKecyrfk2Fv3/AZRa7/A2elZzN3ATyBQfGu6/HT4xvn7EEuyDDKxFnoyqjuq1nia97LLX0FF4kTWfL4OaTsaqujfFCUOSMvUkN3jbCxbNTkLuFytJadUMQVGcWC9DD6p2nPxm1rhK8Ca35jJXXrBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463388; c=relaxed/simple;
	bh=/GNCjh2VClNPbopBZqXjrtavlnfuHerSez0P0Aw/4n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHagpGDouXHiP0IcJuvfeesucXZg5QfPBCxS9xTSoz7DziLWqcXTXAfqYofZslAamNiMqyKy7zMYm+V6NqbfaQMWgKESj9dEBjCMkz17Y4AFbQpYd1C2+RbchVEHjv8ImHoHCVO0FlOjDgAhjVmf/EV35j3cQo6WbEguCsQbGNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/IIMMi+; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/IIMMi+"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c01c79467so283001cf.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 08:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786463386; cv=none;
        d=google.com; s=arc-20260327;
        b=XYFYmIQ8IFi7gQBxQxwxDEds6A6+XBoXqg3wXJ0nkq3l/RA0Bdks5AIpn1xCGU9kF7
         jpXZtUfBLGo4gAqxZbmEtyTlS07CZqr08mqGP4KBr6SUI2ig+66/w1+QOoCwp5ASO6Zy
         JvqhfHxroOPhtzkOFNZKOJJeLcvJ7M04ZtR+XWdSkXZ0I6jWLJl4yHoUDXhntpxkPcNe
         qINbpjs2tRMAxz2rKCYz/xkRsUCcMhbTYVNQ3MR/1/nATPYsDZrk9Z0N63Q1aTdS70ug
         m1yYssQsg8yUqSiF8tIXXK27biODuooycluolG+atSIjgmqMu8oZMQwnPpfJO71beATc
         us1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i1QueQhDv1Ra4n5xMfAFK9oxmv0TskKSul/4mHoLow4=;
        fh=THx0fa9uhhDb6TUTOk9Qe49Eo3WkVrhHsDH2u3EWh60=;
        b=Altm0IVQZU0h3WXiqJCSZH1KYHrqfFzLQDeZcK8vifLPaX16BlJryxmzTh8otokOLi
         XyG6rHJc+zjELeE+5ZU7R8Hh9k406t73IsNlj4MOl/tyIrdJ4hBx2fuSKbaWS9uQDO9a
         7pNa1qR5Uknkj4+Epim88r2fJMLbIZFNOyJaL0wsYC94xCXwaWlfR341J+gp15lgpzLo
         w3qo5TGH76YEivO4bVD3AhTkOTs/ZlD6uhMAyWyi+UFpKiJl9kH6DP3IHFLrP/iZg7u7
         KH9MTq0HzeQQ/I57cL9YOb9YnjuaU4F+1n6O+qMvNzcAIRMsW4Igp/rnfLT+88tUw1Rw
         zhtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786463386; x=1787068186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i1QueQhDv1Ra4n5xMfAFK9oxmv0TskKSul/4mHoLow4=;
        b=g/IIMMi+FycdugdRYBhBiPI0MU3PKPWo3zsVh6Nc1y7WjTN+XAVh2mP/vOxQKd/JqW
         h0tkt0lpx0TNYrcZBmpSIsZkeG6RaCd8lLvVd1cBYlCOJ67igGqhAaT6vbuEXZjpTYot
         6cAgsflzs4vt1TylbvfJQbfJhOSE5nUKt1a24FkNzR9fKNTxehLvzary8y5a8v2vObuy
         ZCi7fHHo4hBPxuAvELbrPLhut5aEH9BMaotNYcjYAks7l6yfC+BkaHCPsgmxSBjf64rg
         1S7CqKg84uzaGCcw+1aZTAaCUkwnTrFrDx0qdicNYFYTOmNMHDtgq/PVjRGhJd2w44V2
         UBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786463386; x=1787068186;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i1QueQhDv1Ra4n5xMfAFK9oxmv0TskKSul/4mHoLow4=;
        b=jI/4RRkM4oqHaOKDbxFNL4BekgMR+kefiho2BjBwP2HAtXvKkg+MgcHLu9+EWu9RB8
         gg9wjbHh2L1uX5SlHZK0DcqKgL9mS3qTU1Roxh8v/uiNmu2TWi2djCH/xQOee/R9+pcA
         2OEPuP9QXW0hcdePmLN8HlbLyAPpaIY3e9WA+0YG75Mv623ybQfnZldWgTfbK6Fc5bYZ
         gkUxgXOFY129CZlKpTPrIfTWTSB3YekCMCZfDjI/slMvf61eq1ElZyTihfZOn5wOa3JL
         Cp/iNGYcPQPXSpiMLuRb+40JR1Jnf7AcEK+8TvJvmae/1I+jcnLdCfDx7/KSvMxdh0sG
         Isvw==
X-Forwarded-Encrypted: i=1; AHgh+RpHSBlMSmT8WFbufQrLb9UndrxryFuSUAczTYJDd5wx16I/LodqKG49BPOkZoJ8GFcAVW9TW7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8sT1m+mjrU+7j+BUw63vQM8LOYLBNfTZikt/86CmE8MAeAOhr
	KW1oiPpzidrj95nh8e/sQe4mYbRWG3L9ZIah5X8YpGZLNMpqeLzzwAQ8HeOe55G52XJ1k+YvW+U
	RSk4FgbmyyWuW9uIjCgOvEEFOutpbT6sKZuJJ39k/
X-Gm-Gg: AR+sD12Zo2/op+QJEd6RubkZfEK71KI1BUqPCOukTH54JV+yNZ1koQKUECFWiLVKDZq
	DjQCuhKFIiFSM6k24+Efjy0gPLXpgY1IuPP+bYLEInX1RLv8/QGHgQ0zQ5y5JhJ9EFH8CZHfM4u
	LXm6LCwcKH+KtnZdbYghpUDWiJVz5cuGOPTTW1wVq+3XdGzY1ukXkRK28BibAQHlmYNGgkN0tee
	TR4LO300Ak8/88GtZ3cx/a2B7esuwKxlvagZbZbUNOBeirNnHHBuY3Dbq8+4/OEYnBXQkXaEHZw
	qfcCWU4K+LeOo7O9Kwmm7LLaLmLrQIcFOSccxaPcTjGuwTPisRug5G70ufi97++kZYjyCHiBZw=
	=
X-Received: by 2002:a05:622a:17cd:b0:517:6dc0:698d with SMTP id
 d75a77b69052e-52d57d2efa7mr15038101cf.0.1786463384814; Tue, 11 Aug 2026
 08:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810071518.115381-1-hao.ge@linux.dev> <20260810071518.115381-3-hao.ge@linux.dev>
In-Reply-To: <20260810071518.115381-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 11 Aug 2026 08:49:33 -0700
X-Gm-Features: AUfX_mwT4hAPkBMj2FjRuitd35bQlWvhWAW5BMq-HUekUvt1QEpfys1Rj8CfahY
Message-ID: <CAJuCfpFO1=HaN-DVqqpQPHKC9utAMKSCNUNRE3cwi5JvrL-e=w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: gehao@kylinos.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 12:14=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> In reserve_module_tags(), the tag overflow check is gated on
> mem_alloc_profiling_enabled():
>
>     if (mem_alloc_profiling_enabled() && !tags_addressable())
>
> If profiling is toggled off at runtime and a module is loaded whose
> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> skipped. vm_module_tags_populate() still maps memory for the tags and
> the module loads successfully, but the total tag count now exceeds what
> NR_UNUSED_PAGEFLAG_BITS can address.
>
> Once profiling is re-enabled, ref_to_idx() computes each tag's index
> as its position in the alloc_tag array. update_page_tag_ref() masks
> it to alloc_tag_ref_mask before storing in page->flags. Indices
> beyond the mask are truncated and idx_to_ref() resolves them to wrong
> tags.
>
> This silently corrupts /proc/allocinfo: allocated pages get attributed
> to the wrong call sites, so the statistics it reports are wrong.
>
> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> independent. Once compressed mode is established at boot, it stays
> active regardless of runtime toggles of mem_profiling.
>
> Remove the mem_alloc_profiling_enabled() guard. On overflow, shut down
> profiling, release the reservation, and return -EAGAIN so that
> layout_and_allocate() retries with profiling disabled: codetag sections
> are then placed as regular module data and the module loads without
> profiling rather than being rejected entirely.
>
> Skip percpu counter allocation in load_module() when profiling is
> disabled, as those counters would never be freed on unload.

The approach looks correct but we need to address Sashiko's findings.
I'll focus on the pre-existing issues and will post fixes later today
or tomorrow.

>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  kernel/module/main.c | 17 +++++++++++++++--
>  mm/alloc_tag.c       | 11 ++++++++---
>  2 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..c32bb47a573a 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2971,13 +2971,26 @@ static struct module *layout_and_allocate(struct =
load_info *info, int flags)
>          * this is done generically; there doesn't appear to be any
>          * special cases for the architectures.
>          */
> +retry:
>         layout_sections(info->mod, info);
>         layout_symtab(info->mod, info);
>
>         /* Allocate and move to the final place */
>         err =3D move_module(info->mod, info);
> -       if (err)
> -               return ERR_PTR(err);
> +       if (err) {
> +               if (err !=3D -EAGAIN)
> +                       return ERR_PTR(err);
> +               /*
> +                * -EAGAIN means profiling was disabled but the module
> +                * can still load without it. Reset state and retry.
> +                */
> +               rewrite_section_headers(info, flags);
> +               for_each_mod_mem_type(type)
> +                       info->mod->mem[type].size =3D 0;
> +               info->sechdrs[info->index.sym].sh_flags &=3D ~(unsigned l=
ong)SHF_ALLOC;
> +               info->sechdrs[info->index.str].sh_flags &=3D ~(unsigned l=
ong)SHF_ALLOC;
> +               goto retry;
> +       }
>
>         /* Module has been copied to its final place now: return it. */
>         mod =3D (void *)info->sechdrs[info->index.mod].sh_addr;
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index af44f90379f2..3eba6331174d 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -950,10 +950,12 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
>                 int grow_res;
>
>                 module_tags.size =3D offset + size;
> -               if (mem_alloc_profiling_enabled() && !tags_addressable())=
 {
> +               if (!tags_addressable()) {
>                         shutdown_mem_profiling(true);
> -                       pr_warn("With module %s there are too many tags t=
o fit in %d page flag bits. Memory allocation profiling is disabled!\n",
> -                               mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +                       pr_warn_once("With module %s there are too many t=
ags to fit in %d page flag bits. Memory allocation profiling is disabled!\n=
",
> +                                    mod->name, NR_UNUSED_PAGEFLAG_BITS);
> +                       release_module_tags(mod, false);
> +                       return ERR_PTR(-EAGAIN);
>                 }
>
>                 grow_res =3D vm_module_tags_populate();
> @@ -975,6 +977,9 @@ static int load_module(struct module *mod, struct cod=
etag *start, struct codetag
>         struct alloc_tag *stop_tag;
>         struct alloc_tag *tag;
>
> +       if (!mem_profiling_support)
> +               return 0;
> +
>         /* percpu counters for core allocations are already statically al=
located */
>         if (!mod)
>                 return 0;
> --
> 2.25.1
>
