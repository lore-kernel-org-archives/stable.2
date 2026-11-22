Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795318634;
	b=UqMrZYKeG3yx52SzSkczVLT0K8RlYsLifdB3LGU/PYR/zGniI0GeyVPw2hmEOD8ElmRg
	 0t/3CnmjHlNY9w0BKRbijQswvumjvTd1w9KBE46eaYoVBCJ20SkJVJoErTnlzpz8u45gD
	 +zvFljMU2Sqpq3TDBe9gkbEb6v/qsCjMtfxMPpXr5RinKrFjsPFsQWmQL0rMahrSL3MF/
	 hXNrCXLAC8QIAeMElDDuAh9ASWSCpJuQoXaXMiwkgsyuQqYzrBmQahSRB2kke+r48Vhx2
	 HYEXtlFi3So2tnmHlhvFYZfeMo7pl0gP1o4rX/w1XiGkmXqz9eUYNNDwIuJCRGSWRUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795318634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2LfQyaKPdDmtAwB9hpMWlkNP+E6RdLGt5t+eKHjqhEM=;
	b=GUn4faFGbcpa3aDpkLXhZWwALMX9EUpgpVOs1wAxl9HVjyHTVZJvb3JHY/B9trOi2Uu6
	 NF0xaImcqrjYOXRIMWzk26JCsLDUVKOdQPDXoEC6iaD+WpFpIEM5bLAs8mTgQto7tWwJC
	 dNzGwRua9ESBC0T3iB+2odkf4fl9PPhLJicGxUoBA+7i9z3M1N5hk3srYXEAB2OVxMEbx
	 YanN5v7vbeN7JU3O8BeBGAufwG/1HpFWEE2TLt0KeW5qL3H5zDe7foDobuE61bLHYkfyd
	 l4AILof+xvZrkpMi+jZoix2En+4hcGDcDqAsfAOsQ98h5sDboHaJ82blBnjU/Pg96Hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gPj5+bLy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2E606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C2E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gPj5+bLy
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-54492d8a988so215331cf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 19:37:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795318633; cv=none;
        d=google.com; s=arc-20260327;
        b=Wto0d9I12JldmmvJocRndUG9d6NB9XJEfFrgy1Du44O/vquTtGKSWT0fJHwFY+EqFi
         LE0xyGmLDAfWaa/eq3qE2Nt3LEfJnANsOJ2bl7p6BxUhjoudxsel29Idzk+PXV2afrff
         D205y9i4gFbEc6nlhINnwdYZzMu06O1QbO/DXH/kA2gGIecKcyCQgWos4njT/6Xks8N1
         fJ1pIGoBVRPZZ3BkGfrJgbr0cdXRyOiiUmaDOMC8bJeEKcw8o4LbnEICwfz1PZqIyO9V
         cnzkejQNSEQFDYjitOpLfhd+2WNKfukLe1lJiTvIMFRPiUDg8ap7rAyRCSClAsDKvQ3r
         YW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2LfQyaKPdDmtAwB9hpMWlkNP+E6RdLGt5t+eKHjqhEM=;
        fh=eYlGq1X9LfbiMlQoM92xPo/w2pwcW5Jo2qmg937XzPE=;
        b=SxDkUK60XTDJQoYJyfsVIFfFa/THB3G7vzlw3Yv1fixNUGqhlqhfTzloeRIpaHsH+y
         3Tux68jKVzgUox+mA1iu3JYXnQgNlmbB/9dBuJ0/BKRJqgWwslddnZomlGLgNAlFa+Fh
         q7x0ukG9C3t2uy76cuZ1i1530vd59gi1uIuU991zggU4ZuUi07QpGw15AKOCaXxtiCrh
         /sCCR2tHTfkd0iJDnGIdqaY8rLDWes/BWIgSK/fKZL5nQTgCU2SKmCfR4NZG0xF6rJqN
         MwYznSiZac2xMO2f3vN0NcoD3Cb5n4etDCak0rCW05sCyffD6BfvUMwUuKbvw+EpKOmr
         g5Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795318633; x=1795923433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2LfQyaKPdDmtAwB9hpMWlkNP+E6RdLGt5t+eKHjqhEM=;
        b=gPj5+bLyHIkySJ+45Ei7iiP1rcGI7nsIgcwQUQLNJ5k7rY9q0/mFSjfXUT78KUdoez
         Xz10VszdqvnH58F4kJkDyfLjyeqef0O30dIuNkrAEfddVg4Lod99NGdR5QeNMXjwS1Z6
         7gasPwcnsO+fP+jMgWqINBXEE/VmeJJkGv5cyRORbtcFQSw3+bm+K3W1B3MG28kiDELs
         KM04xdUb/+MFeyrZx+ioeyrB8FXIIzAvH7kZZzMZOyrcMep24chomKkaAOVohXaHEJB4
         8tQHzdbUAzgBWAib9x4ZuPg2R3Ou3oBdUjBfLZO6gAQjepinNg//HUlp+EFx44zZzCNC
         BM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795318633; x=1795923433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2LfQyaKPdDmtAwB9hpMWlkNP+E6RdLGt5t+eKHjqhEM=;
        b=zzz0lxvRd6chI2/9d94mtG+840lU7L0d0CL+IOu/PU1fuw+rjY61qGKzG07A+28qEz
         V2FacjHAWwWkpmg/mbg1CEte2pCHaNrfZZse/5kSkU1MBpImNmRdE4Ko2yS/uNBw5Sxp
         7vLEcWDWS1UYrLLLbVF9vKhRRGtb8FsfwLlzyzUHmNTjaP3GfMW94KJ3yag7RxjlImZ/
         zrNZNFI3djFIcIIPyj+BjLiKzI0YQI0uwEZAjqO90P9IrQBYzw1FtVyQUWNKD655on7k
         OkGFRm97asyZFGeG6hQ42ZwV9Su9i6VRBKDEdfhQ7pMokRyb6d2/MjwLr57TYenUT7hU
         OQvg==
X-Forwarded-Encrypted: i=1; AL+hErFr+wzkdJia57/xw6pgdhkQ0rW5cyo6mb5YlqZxgwLFUhHWslFVsFIuYfe4b6oPN+RhGhhkjWc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9K4CD3ThsT26+uY5gPH33DFXJYhuRfVAbpiiJWQog0S0XKCEip
	AhhobB4s8xTgFrHUtMdxqk56Mdaj40FT128Tg1tNdy5thYxYPMX9Mfy3Mg7GZg8idbBz8M5vwsd
	YkUO7Dkf5CY7/1fNQms+7HSPN1wlwM+xvO9iY1umd
X-Gm-Gg: AZFdTZcF3ejWHU3Et0ERfF/uPI9Oyxk/CdP5FPdF6c8R3gzhkR5uUybe/XayHhvLJPW
	N/1oj51MtjIiaRQxcSuzEJr592nRNYKKAt1yOuWfvOQf5wzaDxlJ213T0jsw2yIsqCmsVkY+8O5
	WApCBsGKWTo8YzQMoV+JBryaqFlVZ1X9EeVmmFve6sYN45rRm8KJ+MBwshtlxja4L52vwlblwo4
	+Jz2mvWC0aOt5ZJPmqW9bjhdrodl2RNQQ+WcDnvRTJldypLCsb08/K9i6IZqLbeobvN9L7fhcyo
	HF2Oy9zHseaCHbXABQ7XcRr4gEmzsgCtth03TAd+uOKNO98J78wSdbXnH7+Iq8Yr8QcoYd8WdAw
	1VlCTabN/VoG5nr0fz0YUSJHx+dO0giPz2tcUFkh4OPU/8cLzK6zcQyjLOnnPLM2b7MJ7J2xnec
	xHj+wXPgj4h6nhPzsp
X-Received: by 2002:a05:622a:544d:b0:535:ce3:ee07 with SMTP id
 d75a77b69052e-55d89061678mr17270921cf.13.1795318632302; Sat, 21 Nov 2026
 19:37:12 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org> <20261121-some-more-ai-fixes-v1-5-236e925d9b64@kernel.org>
In-Reply-To: <20261121-some-more-ai-fixes-v1-5-236e925d9b64@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 21 Nov 2026 19:37:01 -0800
X-Gm-Features: Aa3M54qOE2eAiS_4WrdIE1htjEWK1zJnqa2hRoPrBF_s_15MhPGp5CEUFjZBJkM
Message-ID: <CAJuCfpHAw6GJuMrbHZG37u3mPx7MZ-DkryQXQBf=F+aNcX4Y8w@mail.gmail.com>
Subject: Re: [PATCH 5/7] mm/mremap: apply the mmap() offset limits on expansion
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ollie Wild <aaw@google.com>, 
	Adrian Bunk <bunk@stusta.de>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 8:03=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> From: Chris Mason <mason@kernel.org>
>
> Commit be83bbf80682 ("mmap: introduce sane default mmap limits") made
> do_mmap() reject file mappings which extend beyond the maximum offset the
> file can support, via file_mmap_ok().
>
> However mremap() can expand a file mapping and only checks that the page
> offset does not wrap, so a mapping can be grown past the limit that mmap(=
)
> would have enforced.
>
> Fault handlers rely on that limit. For instance dax_iomap_pte_fault()
> converts vmf->pgoff into a loff_t, which overflows for such an offset and
> defeats its i_size check.
>
> Fix the issue by applying file_mmap_ok() to the expanded range in
> check_prep_vma(), failing the mremap() with -EINVAL if it exceeds the
> limit.
>
> This means that mremap() now refuses expansions it previously permitted,
> however no file can have data at these offsets, and mmap() already refuse=
s
> the equivalent mapping.
>
> Fixes: be83bbf80682 ("mmap: introduce sane default mmap limits")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: fixed up commit msg ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/internal.h | 2 ++
>  mm/mmap.c     | 4 ++--
>  mm/mremap.c   | 6 ++++++
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index a09dbdfd615d..aa7fba0a1c41 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -941,6 +941,8 @@ extern long faultin_page_range(struct mm_struct *mm, =
unsigned long start,
>                 unsigned long end, bool write, int *locked);
>  bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
>                 unsigned long bytes);
> +bool file_mmap_ok(struct file *file, struct inode *inode, unsigned long =
pgoff,
> +                 unsigned long len);
>
>  /*
>   * NOTE: This function can't tell whether the folio is "fully mapped" in=
 the
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7618e72766a5..79702841c06c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -264,8 +264,8 @@ static inline u64 file_mmap_size_max(struct file *fil=
e, struct inode *inode)
>         return ULONG_MAX;
>  }
>
> -static inline bool file_mmap_ok(struct file *file, struct inode *inode,
> -                               unsigned long pgoff, unsigned long len)
> +bool file_mmap_ok(struct file *file, struct inode *inode, unsigned long =
pgoff,
> +                 unsigned long len)
>  {
>         u64 maxsize =3D file_mmap_size_max(file, inode);
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index fff0465f5e06..8043c425b5df 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1791,6 +1791,7 @@ static int check_prep_vma(struct vma_remap_struct *=
vrm)
>         struct mm_struct *mm =3D current->mm;
>         unsigned long addr =3D vrm->addr;
>         unsigned long old_len, new_len, pgoff;
> +       struct file *file;
>
>         if (!vma)
>                 return -EFAULT;
> @@ -1870,6 +1871,11 @@ static int check_prep_vma(struct vma_remap_struct =
*vrm)
>         if (vma_is_fixed_mapping(vma))
>                 return -EFAULT;
>
> +       /* The expanded range must obey the same offset limits as mmap().=
 */
> +       file =3D vma->vm_file;
> +       if (file && !file_mmap_ok(file, file_inode(file), pgoff, new_len)=
)
> +               return -EINVAL;
> +
>         if (!mlock_future_ok(mm, vma_test(vma, VMA_LOCKED_BIT), vrm->delt=
a))
>                 return -EAGAIN;
>
>
> --
> 2.56.0
>
