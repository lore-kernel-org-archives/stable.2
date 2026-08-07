Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6559F4B0485
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064956; cv=pass; b=TiUoCPQkrPcbuYst5qQ7nIq9FJYClGB2w4Pb2aiJiDDOBcZhjPwuz8XJPWwehJtLo36BXcndcivxr5LcCExkkYWqjIAisHAuJqkeumjciztfIiKggS+FOdegE6418d4m+uuWZgpXBQaTSTp41KGrHQwBpq6ODZSiWd/fwR9byUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064956; c=relaxed/simple;
	bh=jD0GUq8Tj6+YkU3YTw+0FfIy35cl663L1H2tBWQH1GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hk8SZ1rubXgOHCmUevaAUjQSGvv2RsnermmT9PfAIMvljLYCRB7RyD5AupKGIAcoKvomECdaclcCuKoeZFVIxAg34/DU9GPhQoRPdBakWWHPdJTkvQBmU2YxRyhV4LgwoepCbTvduyXyVHL0zaFSZopGWvPGewG3Js9UIJmma5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HderQwTv; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HderQwTv"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c15a5b265so133371cf.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 18:09:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786064949; cv=none;
        d=google.com; s=arc-20260327;
        b=c2XRhujIQsL4KX6mccZI2kwFzBp5JtrkHSNdu0Jbzc+NHcpOly0C9ZrwVtH1YMJgx0
         WS0KWrb+6qvOzruTsPZl3KRMri0ZUjEa/6pnZYU4ki+mjJjoEqPv0Hp/KxrbiDD057qk
         9AvaPB4kF7RaAIRsrqW28QFAnubelRONq8pL5GoKL2iQur+TxttGFAJabRmF3By63lit
         JpLxlbmDPGUgXUuwfB9OB88LcSvkhRN/cGkyd+6eA1owjbdGUCPp9AEBiHsh54vxSYUu
         2swlII/iCsNN5F40ka6HUGkzfBwcYwHAWSCa7wkFk43xBfj3dFGRwyBPQJ3Rp1lTx7/J
         eSmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SFWYXxn5mX3aRAqaZUoImbgrzlPlEe06IR2UE0VpByE=;
        fh=mCKRJCScrp/EKVvjKRmiPJLyIVlJ8H3e/3iQHxtUAPg=;
        b=PuH86mqaNO7kOLXUOeLaZUm5ksTtiNegx2YbeecqGxxud6HuhbWiefNYK0NsXjdMLa
         j4yvg4VAN9/XWZ1sJWjWflgelkdv0xTAfpatUI491/hMwueF5y/lIIuohneSKQUgIpWq
         INMqwQFceqJYqr0ouYu9qOO9YJ/iv6uI9BfPVM61t+OvRyZj3kUIs4T/zYl/yEazTgOH
         IyarZvzxBUsMXkjvOkIL9d8pL9O/1ZQbW9WWLd9RrVrgZWwTOdp0+mME7S6qDGHar59a
         /dpzRCxjA5K5gmlDNzNR7kInavlu4cQDZNJ6rp/DUY+VDUl/QFM+CO/VUlaM/5ri8luA
         aYuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786064949; x=1786669749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SFWYXxn5mX3aRAqaZUoImbgrzlPlEe06IR2UE0VpByE=;
        b=HderQwTvstAOz3fUx9qFXTjlx6tBX6CC3yPj8FVq6nKp6hDL/3MBrU6m7hoGG+dMk4
         tB4BdEH7WvGQzKl2W2O99WS51PMqrsGXagg5qRsphdLCCNYtYjYUkDWTWxrkTKbGI4XJ
         bzTSQl6patQfdim2DmItETGHaqb/zDtS6H+2EVmIpL5vORv7D2VaZR2dEhY1ADb1U1dg
         seba0SYyFLu+WbjaaWPtnvlLwhjno+l4XlnkSCF+vnyBcErmTuz5oJtP34axHZZNRkuj
         mRr8gbv1mMgcR7Purg+QnsGj+y1f59QA3/YE2jkI2ZzFnIAcq5VcqGXDAs1IdqQyLaWa
         +UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786064949; x=1786669749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SFWYXxn5mX3aRAqaZUoImbgrzlPlEe06IR2UE0VpByE=;
        b=Xpr3IY/MKKkaI28mO+hCm2vd+2a/rwvHzfLFNbZGln0+LL5FOiF0TpwGB4vYzD9iPa
         DoCuMX+hthBH/+egJ0dqaAOplFYg0IHN41Hz9Pu/ZdRms28W9YrryqzxG5RcI2kLVBTv
         l0eAEa2CFSA/2+oAhDJGVmXCJNCo+G/hl60xEIod45ukRsz+rD5Lb1zpILDowt0xRR/f
         89iRWBxFvF1fB5unHnD/AZxJdtEWOnfZFeSbwy48HcWzB8pE4lGaDZqNPf/cjxJAGN0q
         EfEy7icFt8EmELcqOMxTaLpiHfR/sZ61UsooxZt8Wx8TQ8YEnnJdUm+1KQHaI18zix+A
         cvWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqohawJJbHj8qtHz2UpCjfFl3zJdNWzpWBM8ujvSmHcndvVCGpQloQVAWuNAy14r6IgEYs7w98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTYeuFLa9mEajn8Ko0+AwuVJQylMnEUzcERe6WzLjGd6VuLJJO
	7zR5GKu1ERZFDPXUqTzsW2zVL+izVFGuEZ7Rhx/WRGmH4dTQYe4egV4KfJcBmN8FV7qL32n4/na
	Ut48VTazjm9DJW8oVNV9EkHHlvPe11X1+KLA3oJST
X-Gm-Gg: AR+sD11eeiSKcKZbc2gVlfkLZ8xKc2DxQRC331IYE3X/ZLVA1ordv0u/g8UXMGS0vr7
	NMPM8kF7WA3N3Lwy+uurzPyU56AQ1wk1/41LwupcOgsDJfggESO+/A+yBtS50c4aQu4P+MI26G/
	s8SgeFw0r2qI/mdd3BgiafXLY7aSIbETHWBCLRxbGviO48noyIbNrhRbFRAXfXvmT5Ymiyioyr4
	G3vT7F4SCyLW+F5gpCaKAON5KWPUbxPSMeFpV4N+3Za/roUfdYGRG/si6VHN8cLP1inG3lCexpb
	KTJDmqOdwo1yt+eP1DWAYHcfCxWInANu+NC6KhH2qqI=
X-Received: by 2002:a05:622a:2b0a:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-52d1537b77amr4672671cf.5.1786064948220; Thu, 06 Aug 2026
 18:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805090633.141001-1-hao.ge@linux.dev> <20260805095505.1c2cbc150441cb20a74ba9bb@linux-foundation.org>
 <CAJuCfpG_XX-Hwy=TCrJ+g6yiMxGXLB=LvnPN_WLP3WQktNZMbA@mail.gmail.com> <e96d8a13-8f9a-49f4-ae4c-a14c6de5ae66@linux.dev>
In-Reply-To: <e96d8a13-8f9a-49f4-ae4c-a14c6de5ae66@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 6 Aug 2026 18:08:56 -0700
X-Gm-Features: AUfX_mxBaPBw0NNhQsaxZ_CDj1g6HM-fQ6St7Kg8vy0drI_vqZEKxUNI36LMIc0
Message-ID: <CAJuCfpFyTaqLnyi11PtAj-ouJiLcfxZoYDRUUKSZbW3RfDFOUw@mail.gmail.com>
Subject: Re: [PATCH v3] alloc_tag: fix undetected compressed tag overflow when
 profiling is disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Abhishek Bapat <abhishekbapat@google.com>, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:36=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
>
> On 2026/8/6 01:47, Suren Baghdasaryan wrote:
> > On Wed, Aug 5, 2026 at 9:55=E2=80=AFAM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> >>
> >> On Wed,  5 Aug 2026 17:06:33 +0800 Hao Ge <hao.ge@linux.dev> wrote:
> >>
> >>> In reserve_module_tags(), the tag overflow check is gated on
> >>> mem_alloc_profiling_enabled():
> >>>
> >>>      if (mem_alloc_profiling_enabled() && !tags_addressable())
> >>>
> >>> If profiling is toggled off at runtime and a module is loaded whose
> >>> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> >>> skipped. vm_module_tags_populate() still maps memory for the tags and
> >>> the module loads successfully, but the total tag count now exceeds wh=
at
> >>> NR_UNUSED_PAGEFLAG_BITS can address.
> >>>
> >>> Once profiling is re-enabled, ref_to_idx() computes each tag's index
> >>> as its position in the alloc_tag array. update_page_tag_ref() masks
> >>> it to alloc_tag_ref_mask before storing in page->flags. Indices
> >>> beyond the mask are truncated and idx_to_ref() resolves them to wrong
> >>> tags.
> >>>
> >>> This silently corrupts /proc/allocinfo: allocated pages get attribute=
d
> >>> to the wrong call sites, so the statistics it reports are wrong.
> >>>
> >>> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> >>> independent. Once compressed mode is established at boot, it stays
> >>> active regardless of runtime toggles of mem_profiling.
> >>>
> >>> Remove the mem_alloc_profiling_enabled() guard. Also return an error
> >>> after shutdown_mem_profiling() to skip vm_module_tags_populate(), as
> >>> the mapped pages would never be reused - shutdown_mem_profiling() set=
s
> >>> mem_profiling_support to false, so no future module load enters the
> >>> codetag path.
> >>
> >> Thanks.
> >>
> >> AI review points at a cpuple of possible things, one pre-existing:
> >>          https://sashiko.dev/#/patchset/20260805090633.141001-1-hao.ge=
@linux.dev
> >
> > Yes, pre-existing issue can be handled separately, it's not directly
> > related to this change.
> >
> >>
> >> "Does this unintentionally result in a denial of service for module
> >> loading, preventing critical drivers from loading when they otherwise
> >> could have just disabled profiling and gracefully continued?" sounds
> >> pretty obscure and I doubt if we care?
> >
> > Hmm, I think Hao considered that in his previous version
>
> Yes, I did look into this.
>
> but now I'm
> > thinking we might be able to handle this more gracefully and not fail
> > the module loading. When profiling is disabled
> > codetag_needs_module_section() returns false here:
> > https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L28=
22,
> > so if we had to disable profiling, we could return NULL instead of
> > ENOMEM and change the condition here:
> > https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L28=
25
> > to act as if codetag_needs_module_section() was false from the
> > beginning. IOW code at
> > https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L28=
22
> > becomes:
> >
> > if (codetag_needs_module_section(mod, sname, shdr->sh_size) &&
> >      (dest =3D codetag_alloc_module_section(mod, sname, shdr->sh_size,
> >        arch_mod_section_prepend(mod, i), shdr->sh_addralign)) !=3D NULL=
) {
> > ...
>
> The primary blocker is __layout_sections.
>
> https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L1730
>
> This is because __layout_sections controls whether we reserve space for
> the codetag section inside EXECMEM_MODULE_DATA, the same way we handle
> regular sections.
>
> When codetag_needs_module_section() returns true during layout,
> module_get_offset_and_type() is skipped, so sh_entsize only gets the
> type bits with offset =3D 0 - no space is reserved.
>
> If we bail out with NULL when compressed tags overflow and add a dest !=
=3D
> NULL check here, we'll end up hitting the later else block.
>
> if (codetag_needs_module_section(mod, sname, shdr->sh_size) &&
>      (dest =3D codetag_alloc_module_section(mod, sname, shdr->sh_size,
> arch_mod_section_prepend(mod, i), shdr->sh_addralign)) !=3D NULL) {
>         ......
> } else {
>         enum mod_mem_type type =3D shdr->sh_entsize  >> SH_ENTSIZE_TYPE_S=
HIFT;
>         unsigned long offset =3D shdr->sh_entsize  & SH_ENTSIZE_OFFSET_MA=
SK;
>         dest =3D mod->mem[type].base + offset;
> }
>
> That'll cause the following memcpy to clobber the leading data.

Ah, ok, now I remember how the areas are reserved there. Yes, my
suggestion would not work.

>
> If we really need to fix this, we can use dest's return value, with a
> check like:
> if (codetag_needs_module_section(mod, sname, shdr->sh_size)) {
>         dest =3D codetag_alloc_module_section(mod, sname, shdr->sh_size,
>                 arch_mod_section_prepend(mod, i), shdr->sh_addralign);
>         if ( dest =3D=3D sentinel_val )
>                 continue;

You can't simply continue here because during the next iteration
codetag_needs_module_section() will return false (since we called
shutdown_mem_profiling() and set mem_profiling_support to false) and
will take the "else" branch you pointed out earlier, which will
clobber the leading data.

>
> But that would also mean extra work on our end - for instance, we=E2=80=
=99d need
> to stop the per-cpu allocations inside codetag_load_module.
>
> https://elixir.bootlin.com/linux/v7.1.5/source/kernel/module/main.c#L3571
>
> Could there be a simpler solution for this?

Hmm. What if we return something like -EAGAIN and propagate it up to
load_module(). load_module() will check for that error and retry
calling layout_and_allocate() but since now
mem_profiling_support=3Dfalse, both layout_sections() and move_module()
will work as if profiling is disabled. We need to make sure
codetag_module_replaced() and codetag_load_module() do nothing when
mem_profiling_support=3Dfalse but that should be easy. WDYT?

>
> Thanks
> Best Regards
>
> Hao
>
> >
> > I think this would result in a better handling of this situation: if
> > we can't fit the tags anymore, we issue a warning, disable profiling
> > but continue loading the module. Hao, WDYT?
>
>
>
>
>
>
