Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27151199947
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506571; cv=pass; b=oOfpvRfRMZWiAvc8W1hONdXUJHRnc6C/M4GzoSKXdvXRSyd2DOmL1BmonMx4vz5qHIjGF2QtjLQZ9w7i09/wJfQSlQdYpa6KyCnuFMOg96LmgCMcwC4NVlTpCIaXt7Ha8yBRVA87u5rExCPC7BdlSo45eIgXuPY5Sv4ZzsmmYvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506571; c=relaxed/simple;
	bh=1QRE8JagBvXkhtro25uEoq7Fl1riQZiJGjJXvowWF9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCqRQ+Sg2QrsAQadN60vZyfSWj6osbHACedAIM1PwCNvyjrOrL7i3JGo85eJXHfNin8F4dJQQB/9gdZTk4Tc6nmE6vUJ+Qjj8oNtGVkfsm6z0qMEZtbYeLka12QBi1l8uswZNfHR2ZNCHimGjOpgqMUUFWHdxVy29DZuqWmYXdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEKHDM6F; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEKHDM6F"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so26681cf.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 14:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789506569; cv=none;
        d=google.com; s=arc-20260327;
        b=lRI9T3gB1SHbOTmBkO2Nrm9vstDiKQwZm9cDQ6ZAwZaZCAX53QZpU9dVn61MRQ4tX0
         3fNNCN8axKMiXaasexhTTUKJl+1DkPBDTvIu7KvkJG/+c938XzflXaO2hZgzd/N5+cwt
         stW+/JEXV8uvyXgzJIzIM7DfGNa0DP1jCXK0yGjZJE4eu9fjPOhPqk3EGyan+hbvCV+Q
         e7NusUVVh5NWLzCyCxWtUa+qGcyzVsv2+LF7xUulagL+/MtSTMRZlurLqzg7hISn/pze
         pR16dyRVPPsJzEqlJpJ/MRHGfJurp9eeppVoSqBxMcC+eGqaVqaZUHHtxteSoMOb6eU+
         YGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OAM/MHo0tjYo/TgHknUbcGsVAWd3749MCucVMwwVJms=;
        fh=Z3nnXMoGMSv3omM6g0LkAKii+AUUqSQA5gleUVdHZ1E=;
        b=gTWKtHPOmD7O4SwgNj9QVXxcZL+iZTttGP4gbMmkT9t/lBPjw/VErVijRCX9pO7p3O
         YHZcVPuiUEyT9Y7Fx8peHXXE830+tYKQYWvyy37nCVxi6541EkcvQFfVdnQfTaJnz6hO
         eyi1+NVlRz8IIWeDHbpPcRYqCKDjyIKtQRVTWlArsOQxVBztQp3TuFkACQ16SZKbtih0
         ybwGEk2u+Mnez8hbmXK0Vw0sthJnOBHHoXMvAXD6KbFUdaTSHrdWy3T/cOv2nUPFdyV2
         dzMRYCkh6216iX7yTwrbhw6Yw/Y3Sz7dul4bdwJ5Wt1tUp3H3wsEj+Jztg008H9DxaRw
         sJIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789506569; x=1790111369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OAM/MHo0tjYo/TgHknUbcGsVAWd3749MCucVMwwVJms=;
        b=tEKHDM6FifXwjFChe+TECRqENPdukEsPyRb9Ex50YFNTMwwTo6lTa27mxkxkEUYbGB
         gyHW7LFPO2k7FoJiraqCA70QZXHRE5jff3cg05yrvcs+vATQXBC1yLJWhitxMwyF/1kE
         cPJHdLc+AyhMvg/hwRauCuupEuVxzG8R73oOMQ3AziF2k5W4TjCGGftn4muqaTesk6SB
         nKaSGid6l7Lk9YW6oILo+A/iuqGXQEFlPo0BWNtwghj02TLreoyV9FhMknuBFR52cVX/
         noS13iL//5U4R/jij3Cvv0Ob403g9ZGHP4+9avqendkE7XgeqEeFFXzeSFXdCUDoDVHK
         pvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506569; x=1790111369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAM/MHo0tjYo/TgHknUbcGsVAWd3749MCucVMwwVJms=;
        b=yx0Xfmw/bXeNYyPH7uKTpAjMgIGfLvfQdNPDzQnJ5rCAVJJgAm8gU7lOHxJIZ9qYiO
         zod/L1qfbRVZBWnZJa2tqMJlSW5HT0LXnZ9MZ3cYV+Ng4MjZWg1sBrbx1TPzI7MjNQM0
         EeQHc1uiYbLbXAhILQV4XYCXebUrRRAUZ64IroggPFxbv8GB5115l5byK7CSbDN516i5
         2AIVNao8UcOm2V+4Ia2lLpjNt6rS5xPCOi/A/hPZpvd6wpBqogZattDprF7QGv1gbpbY
         XUQL9pVLeatsBxzI2PLXcTIvs44eiBLrFoZtutpsnPK3R3l5m7WfyO5IE4h5aDDQ3eeB
         5PKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwKEfHvn3Pyg6wxsf3puYCcBhbI6UqTz50WPynIlRviCNfwW67tVHDZ/ee167p9F9qf/K5u8A=@vger.kernel.org
X-Gm-Message-State: AFuF++lCOrJDAZ3GgOR8S8MEvtY7jnSR4GNm9roqEGZHi2QHCneVbyy/
	aklzs1yKzqigsqglgHwYwOttOvqQ5F0RJ8n8N+OAgQbmaCaWc0K7+MpPJtGmX09tbgJTLzjkvrY
	8Gn/UTQTQPjjYwKIVwIEVEGjjh5nENiywZeCNBWSuyZzS3YwmV8WmgRy765g=
X-Gm-Gg: AYBFou34k4NKBNOnoGVmFvG7UDDGwusqiq+OPrHrh+o9VScgoGW7e7H4jIkhiOTM8i3
	HQBHAhOulGU/IeKIM8f0qjTZ+8umCaKcLzow2HYg6O3kFXdbX+aKaYSLAbSVeS2EafRl9Bz57pi
	YHpGsN5iWXMNBQIei2thREqDFIuGKhTuK/eM1SgUQFbh1gV+ZNDxMsj47C3f26SRlXmIlnC0zG+
	0LjcjD//EAxvwJI0o2iTH1hGZIs1khbHlNueZJLThHseXpzZJVjpVmp1j341hRf0jOnxLcqVDKH
	tGGYqsfz16fssGGprsI33nJ+6UlTM3l2K/P4X93OcWKSR/AuMaigCEWHaL4GcPV5indKLAdqcdU
	Q92eYHpTXDOaQYC1TTW1A
X-Received: by 2002:ac8:6f0f:0:b0:52f:9ed4:8d75 with SMTP id
 d75a77b69052e-5327ea623fbmr753851cf.15.1789506568256; Tue, 15 Sep 2026
 14:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-3-hao.ge@linux.dev>
In-Reply-To: <20260915070001.113559-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Sep 2026 14:09:16 -0700
X-Gm-Features: AcwNN1W8v3TTrRxzwemLVzpv82f0jC7eBKsciqbn6XlLizQdqhzOL-UqObB-lQI
Message-ID: <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
To: Hao Ge <hao.ge@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> The reservation is already stored in the maple tree when
> vm_module_tags_populate() fails. A failed load never unloads the
> module, so nothing releases the entry. Release it and roll
> module_tags.size back. Without the rollback a concurrent load that
> already passed needs_section_mem() can reuse the freed gap, skip
> vm_module_tags_populate() and write to unmapped memory.
>
> vmap_pages_range() may have installed some PTEs before failing. A
> retry to populate the same range would BUG on them, so undo them,
> but only if vmap actually ran.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as neede=
d")

If a patch fixes two other patches, it likely needs to be split so
that each part fixes one patch only. But read on please. I'm not sure
if one of the fixes is correct.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/alloc_tag.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 2070e682fe10..95ddf5b743d0 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
>                                      next_page, PAGE_SHIFT) < 0) {
>                         release_pages_arg arg =3D { .pages =3D next_page =
};
>
> +                       /*
> +                        * vmap_pages_range() only runs once all pages we=
re
> +                        * allocated, and it may have installed some mapp=
ings
> +                        * before failing. Undo them.

If vmap_pages_range() failed to map the range, why should we need to
undo it? If it indeed leaves some partial mapping when failing then I
would argue that vmap_pages_range() should be undoing these partial
mappings itself before returning the error.

> +                        */
> +                       if (nr =3D=3D more_pages)
> +                               vunmap_range(phys_end, phys_end + (nr << =
PAGE_SHIFT));
>                         /* Clean up and error out */
>                         release_pages(arg, nr);
>                         return -ENOMEM;
> @@ -947,6 +954,7 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>                 return ret;
>
>         if (module_tags.size < offset + size) {
> +               unsigned long prev_size =3D module_tags.size;
>                 int grow_res;
>
>                 module_tags.size =3D offset + size;
> @@ -961,6 +969,8 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>                         shutdown_mem_profiling(true);
>                         pr_err("Failed to allocate memory for allocation =
tags in the module %s. Memory allocation profiling is disabled!\n",
>                                mod->name);
> +                       release_module_tags(mod, false);
> +                       module_tags.size =3D prev_size;

Yes, this one is a valid fix. It fixes 0f9b685626da commit.

>                         return ERR_PTR(grow_res);
>                 }
>         }
> --
> 2.25.1
>
