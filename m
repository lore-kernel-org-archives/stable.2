Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF924D0CE0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576338; cv=pass; b=XTxX9cv+d6UN5rZASPTmb+lVrTkB7vC93inuaVtmjQo46nHmHBLw7n9vJ6Amd9IHPTJOlto/kkEA3Y3TfJyL0EiTuWrpnBRFPUG9InZpQnp+5m3n8C9gNK8Gp0jSaYnRxsXtfnliok+H/eTz6BGP3cHcGqqEhEfW9wP5Y94m9c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576338; c=relaxed/simple;
	bh=jzI0/3psf3wVtPf9Shhf21d5CPCoSmdvQs1bzsuLWKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq4N0fcvnGren7ktVGeGssafLE9Fsk0SyDhqDWZR5ZcM4nVLwRUIUekkE77ZQaHv0iYECXH/CtjlfeWzcsANnV7BrLGQ/1qLSWQhiDFvqgfySQK80HrHY/a4Z5OSRMhZmWeu+i1bZGm0rvl0quxjcBEPRMH+eCXer+Ab/S6qbxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F07kgOph; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F07kgOph"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso323891cf.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789576332; cv=none;
        d=google.com; s=arc-20260327;
        b=GfmS24CqBjmQY8wA19/O9RzRiW06tgOBwixmaWImrBfdmq95CoJT5jzoNHAWhwEac1
         f3bY0jSunVZyMKlGoZPDCD8UGDCex6KqagzFEMj8Y6GIzSxUJKquOalLgUltpp9H/xLT
         y5eVwcmzkNqEeY0U6Sv6LGnMZR8MYvrB6WzHZMSpTFkBDCphRmAbSBCYANEgPLppw/QZ
         Bw3IwqLw7lZK9n2Nn1TYt9lkg/+rkI1oQpXwPky4bPaXxWiuQL14PxHa4uvxe275m3qq
         rfxNIRboeoxhroESPlevFc7Fpkv03wgWhHF14TD3mR0lM1I/QKyZAqcONFFhW1fVs6UA
         lvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tUDhjbftqgjAL9HivD9mk/nQ9a+7BLYF9Ygx6CAW0uc=;
        fh=KM8e0eI+oif6SMiG/eSLoOe3oWDNt8fACIlV9WnjuCA=;
        b=OxSItox4OYK6HH+QLlXZJQrqHFv/sRXlaMpb9NobMTU7V3FHbwbiiWPkV7VAGTMFu/
         dwxOK08d3riwathW3u5hbPJm62JMCVzHWtN0zGrHPd+Qk0TD89PDQ/DZBl27J6QGPbI8
         YspjE7LVzRQsCegjgeDB7QnAhXBKwJaAeQrxuXpp/ADWBv0Mlr3AdE6qwqOeosUmX6Pm
         R738PgLkQ+UK+gUck74hL/LOoRbjc4VkqKsNXacCAdWDKB5uMAMsFIuwG2iGf1ciqTlr
         PXRYt45+HsIdwmDQSec2mG6uDf5c3r5gGx2qIFla65AJc6qotJFhr6yjg68g2dkjEmiG
         rMJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789576332; x=1790181132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tUDhjbftqgjAL9HivD9mk/nQ9a+7BLYF9Ygx6CAW0uc=;
        b=F07kgOphtvstxHTeIRfk9tzPaTHdFOOfcA87RPB3qhohkjCnI/iOY8de/WTmTgSu13
         Y+1w7bCZ0nKqsvInqD+gqvfxmlQzjpo7PMuQFZrJTtkEYKODCCSLBRhvNEoYAyvc+o6h
         kRGS4ecDnjore9pezrbB8uohGN77nBSrubFFfc2Aj8pZHbQ5mr4OB570aPPKb59tC+vm
         fFz+MRIL3iAgEcfbyTu7Pwb0bXKMiVkl8CxztZK1UBrjI2AYPNuTgwAPXt9ZjN4Zw0iS
         KXncLBmFOqhfyIC57DqnhRzTMrPe0F/0n/AuodrE8bCdvIPaZhgh0ZIPvoBFS/LNVvWF
         XorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789576332; x=1790181132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUDhjbftqgjAL9HivD9mk/nQ9a+7BLYF9Ygx6CAW0uc=;
        b=bQXODbmilvPFr2kRnhgt9RFhiu4KHkbdDqAJpl8dRt41Ayz26HfRh/THTrJsxgU3mo
         PCX8z2pxmEKPC+UOUnrUQ7BCOX6LkOlG8dyE5DitTuUF1XqW6eTtlde5O2ymr9nV8cPW
         Hi53XjpbQDMb2zaovuTLzvNhDbFqfHX0ZeU62VZp2XoWuQapjTLpK9q06MDCgJT1KMuh
         3iTKG/8CKkEK7/lVUwt0/Cf38ri2CjMb0BRV+Bp3LYU4LZen0scLC+MQbOuNq4JOM/AY
         Ne+w/kwyic222uNBUGEeov9+4caeiX/WMUzJBW8CutWnW65mc8tM6hKSWpI9YdTbHj6e
         dVpw==
X-Forwarded-Encrypted: i=1; AKwUvByI1RopglC9WQzvBZsISWeEXbnf5YCwJOgS+58KEuzLdjUv2S3zHZLlgXJy2EKhEQFVXyGzUkY=@vger.kernel.org
X-Gm-Message-State: AFuF++nbUu5ZcbuAeOuUxCVC0oH4qrFps3RaRu0HAiVQOx295vS6qXJ0
	wshkXDfZwby/c0YC1AufudqhfEzD11jpPgRA/xxJyRbW1KRb7DhHhTBDi/Gz2RwES9wWJPMl7i7
	3B/EqjF+1GOU2vh4ocxicOzQYHGl7bJXen9MNR3u3
X-Gm-Gg: AYBFou24mL3voMdjT6uahq9OZWHyaCMhnOx2B4M7Ef0DmPmp832A9L2t3RWhhio0suk
	pFtOUddOtwrE7rXZa1aMl+U5/WhA451r6Ytd29WSA/oPhLFhJKLmG965IpRyZ/lUeweH17Eyhi7
	uX7O7VXdYixbMsQ0Z2VALhYoEkP+gMitpghJ0JBljo0TT7fuExYWqcyw5WD5nnBGILTPm6hbR7w
	GY2dnvHqA5FdO/R65A/TPOWSqgkvSRNNokQb+loF76xplpgwOOHL7Nv5hUykSgwFUpUDAkfSBT0
	rEuFcotmntSFLvnGAUb9tPhhA48FR2/+i/c/fc2PygFmPWXMo+ghZPEcdsxSy+VDraw10uQaNRe
	BYmsuHxpBOw==
X-Received: by 2002:ac8:594d:0:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-5327eb6f730mr14653271cf.0.1789576329678; Wed, 16 Sep 2026
 09:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com> <60642a7f-2949-428a-8290-40d69c989a77@linux.dev>
In-Reply-To: <60642a7f-2949-428a-8290-40d69c989a77@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Sep 2026 09:31:57 -0700
X-Gm-Features: AcwNN1Ui51wqsB_O4pl6c8tWHX6Ce9XwML9-1bQ7rL4qQiN8F18j46JxhZ3BkmQ
Message-ID: <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
To: Hao Ge <hao.ge@linux.dev>, "David Hildenbrand (Red Hat)" <david@kernel.org>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 11:00=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
> Thanks for you review.
>
> On 2026/9/16 05:09, Suren Baghdasaryan wrote:
> > On Mon, Sep 14, 2026 at 11:59=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >>
> >> The reservation is already stored in the maple tree when
> >> vm_module_tags_populate() fails. A failed load never unloads the
> >> module, so nothing releases the entry. Release it and roll
> >> module_tags.size back. Without the rollback a concurrent load that
> >> already passed needs_section_mem() can reuse the freed gap, skip
> >> vm_module_tags_populate() and write to unmapped memory.
> >>
> >> vmap_pages_range() may have installed some PTEs before failing. A
> >> retry to populate the same range would BUG on them, so undo them,
> >> but only if vmap actually ran.
> >>
> >> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compr=
ession")
> >> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as ne=
eded")
> >
> > If a patch fixes two other patches, it likely needs to be split so
> > that each part fixes one patch only. But read on please. I'm not sure
> > if one of the fixes is correct.
> >
>
> Kept them in one patch because they only make sense together.
>
> After a failed populate the reservation is released and the
> size rolled back, so the next load takes the same gap and calls
> vm_module_tags_populate() again, and that retry would trip over
> the PTEs the failed vmap left behind.
>
> Without the rollback a load that already passed needs_section_mem()
> just reuses the gap, skips populate and writes to unmapped memory.
> So splitting them leaves each half broken.

Yeah, that's why I think vmap_pages_range() cleanup should be a
completely separate patch with vmap_pages_range() doing cleanup
itself.

>
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> >> ---
> >>  mm/alloc_tag.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> >> index 2070e682fe10..95ddf5b743d0 100644
> >> --- a/mm/alloc_tag.c
> >> +++ b/mm/alloc_tag.c
> >> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
> >>                                      next_page, PAGE_SHIFT) < 0) {
> >>                         release_pages_arg arg =3D { .pages =3D next_pa=
ge };
> >>
> >> +                       /*
> >> +                        * vmap_pages_range() only runs once all pages=
 were
> >> +                        * allocated, and it may have installed some m=
appings
> >> +                        * before failing. Undo them.
> >
> > If vmap_pages_range() failed to map the range, why should we need to
> > undo it? If it indeed leaves some partial mapping when failing then I
> > would argue that vmap_pages_range() should be undoing these partial
> > mappings itself before returning the error.
> >
> Yeah it does - none of the paths under vmap_pages_range() undo themselves=
 on error.

Hmm. I wonder if this behavior is intentional or requires a fix. The
only possible reason I can think of is performance but I can't imagine
a failure to map is a performance-critical case.

+David Hildenbrand (Red Hat), +Lorenzo Stoakes (Oracle) what do you
guys think? Shouldn't vmap_pages_range() undo its possible partial
mapping when it fails?


> pcpu_map_pages does perform cleanup on its own as well. There may be othe=
r similar sites.
> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/percpu-vm.c#L255
> so I did the same here.
>
> If we really want vmap_pages_range() to handle this cleanup internally, I=
 believe that would
> be a relatively large change, and we would need to consider many more cas=
es. So I think we keep
> the current behaviour for now.

Yeah, I understand it would require a deeper cut but if that's the
right way to handle this we might as well do that. Let's see what MM
folks think.

>
> Thanks
> Best Regards
> Hao
>
> >> +                        */
> >> +                       if (nr =3D=3D more_pages)
> >> +                               vunmap_range(phys_end, phys_end + (nr =
<< PAGE_SHIFT));
> >>                         /* Clean up and error out */
> >>                         release_pages(arg, nr);
> >>                         return -ENOMEM;
> >> @@ -947,6 +954,7 @@ static void *reserve_module_tags(struct module *mo=
d, unsigned long size,
> >>                 return ret;
> >>
> >>         if (module_tags.size < offset + size) {
> >> +               unsigned long prev_size =3D module_tags.size;
> >>                 int grow_res;
> >>
> >>                 module_tags.size =3D offset + size;
> >> @@ -961,6 +969,8 @@ static void *reserve_module_tags(struct module *mo=
d, unsigned long size,
> >>                         shutdown_mem_profiling(true);
> >>                         pr_err("Failed to allocate memory for allocati=
on tags in the module %s. Memory allocation profiling is disabled!\n",
> >>                                mod->name);
> >> +                       release_module_tags(mod, false);
> >> +                       module_tags.size =3D prev_size;
> >
> > Yes, this one is a valid fix. It fixes 0f9b685626da commit.
> >
> >>                         return ERR_PTR(grow_res);
> >>                 }
> >>         }
> >> --
> >> 2.25.1
> >>
