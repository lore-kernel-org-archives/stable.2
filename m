Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795211389;
	b=k3/O3y7Uop+ogkzbkzuf8xtzWWHJmATwiQtdlLYRlTzPl9jZ+9j4iBTWcoTwtfLRUCrM
	 PtQvdFzm7lMX6VIgLpkn+/90hEqW0xO258R8mFBrvj7D+7Gi8yzqz+sqZFTNJb4VO7kxC
	 ovOmnKxg0tTgeCb+Tw3PTBAfzJhT19b/EJ1g5xR4ckPrnOTECqjfZZqR1+ACUmq/oqtaG
	 ih0GGcbFnpV9w6fTOztZMLgRSbvN4DtIkAJwyg/K2KoCHxCNe4BQvPVB5XRwnH+m317me
	 Dj1UhECxz6HNbFoQQeJWorVBOswhDLMrjWNQNQlaiXrCk8PW5oT6GpzDGLlOjB0BiIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=E5uDN/vzQdjrsq85f8uIb4z/yYhd7+ao5rN+lXxRb7E=;
	b=nBwjcC8b0WLcn2spFwKjun89MX5CTUZ9VyjpyqrHazE2PRXKKtlp6OBcd9XPFK8/8C4A
	 /ejut/j4pkLXeSmDK5AkBZSUgNTp+yatrE2GpVu0PoTeZ46jF5/qJ4GDeJCDVZ8maEx1H
	 v1kX45l3zs2EYeyy2u5Q5N25GkSR/AWhQtPBd/qEklf690YGYG+bqpV1zoyFgZzRMkbYb
	 9qyOzO0irZnhltjvJPBqIeCAmNSUChqlQbV5OFLYe6+aJMKxqu5G7recyJXt0PIRhLVL7
	 usx5JZxOZ4ZhDK6URZlGEjStuXaUpWm91/UpMm7JnhlfMhvSpEWDI9pee5yTHBDOhkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qJz+Mnps;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF95606A6A0
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AF95606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qJz+Mnps
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ba2a448540so3371a12.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795211385; cv=none;
        d=google.com; s=arc-20260327;
        b=mrneb5cfFtOeq2Y3vzlnEuvRy/0IdSq8A0gAzq649/J1yKt6Y2bc1kzXEbfyM/91Tj
         1V5Pm2h99KRwaMrH6UHrpWb3Aut+kjHOuG1lSSCgv1hbCNQwNjct91n2q+aVp3LvZdII
         ii9wPoMBeoGKMncxp5KgqaFtsS4iANNrPFiP8VXZtfS10Yv9Ak4FSIR6Ee9FglVUvCji
         MIHCQG5+3BNLvUjIDeEH2efsqNpzvAuP8/NwTrMUj1V6a0nIghwq2/VmC23srdbZZ2zy
         WthYci64CDNqKYpz0lr8DEuB3ziS6zWP85BZpyUqvd+cg5sAuiuLN5wivibU/gTdhqKo
         JbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E5uDN/vzQdjrsq85f8uIb4z/yYhd7+ao5rN+lXxRb7E=;
        fh=RbXz/Sw7QxF3qD+jn1GV+qDfcM2dOocGhp8XNzS3Gis=;
        b=qzawr1roqAeNyvnuT7M/TcqxAPSs0twGHKZ97xzOMv1Lv2pi5Squcvgov0ixdZVIEn
         2cQOdc5x5n5vC9Ktv/FNa3ECCNJ4YybMVa6BfgFkIz4eg0E1Ni+q6ELIvVIvv8ohEH1g
         HU58hJteCyR2d61ZATELAeuwYt+D+abAxCj0Rv/DD146pj+UYrRtZQG+K+K7KG0FsRS8
         EwoRCF/KIj36biXrEwbTEjs1ooQQQgDExNAXh2qM+sU44WlXH2TuZYHlOv3ymB67I2pr
         05Kq+dwwZwg2nyPjdxv48V2mFuBrMs7s0c8zwNMbyjlibnKeJDH3dFfzrv2+18S6oVYL
         Fz3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795211385; x=1795816185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E5uDN/vzQdjrsq85f8uIb4z/yYhd7+ao5rN+lXxRb7E=;
        b=qJz+Mnps1I/Xh/CqKRpVPCeeCwuORxO8W2dXz3iZcVzJKj7O9Rci4ZqwCCt/jp7YH4
         YxL8FrL11v32wAgYC2ugM1Oqyv9Yx3oPl47IhMIGufygdqe340OU9oZCXJpnkzP8i3l7
         RLcxqOR527m+EVkU0UhyYqgz126edkKimX+lZuM7OIsiiphMZRkp35aKD8HuCfgBq/IC
         3pE41C458OXsnTw57Hfl0NnKtXak6JxuUIIKexTKZX5nvlnZsbuGtI80igOW2OiqKpNa
         NEoFCU1v5Zp6rJwKCP4/prT/mi6VZowqkbl0gm+zTiIfmOSEQHFDmdj3ywTov8KEml+O
         UI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795211385; x=1795816185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5uDN/vzQdjrsq85f8uIb4z/yYhd7+ao5rN+lXxRb7E=;
        b=nbqXxqs5H737TLM513wzozQ8bj7g1ww6m1/LzFo2Fof0Cv4OLj4nwj6sSuY5DiD01h
         mz3yHQn3L6g58VQq74yXxGKDaaeOXSLXAcbvD7AXq+DkBUW/n+WryAnVxL2j5XYWBOrN
         bR7/jORyIf6kZOhFY8fE4utB52IuqpFIVv0xNfcTG6F68iYrj2lHsrvZuJCcs/lpf0Ru
         qVnLmT19TAdg60GEjQbl7qxb077qLer2BAshzhkO2artQgwvu6cZVLGA98Sz+4g/CThn
         9jY9piClbrabcReH8VXyRhOgBRLlG24XP4xKiL+YVK7MjN81yuIqSlXH0/Yu7RBtIFoU
         iP9Q==
X-Forwarded-Encrypted: i=1; AL+hErEcRvlu4hSZV04xclt/242kNSofu3GOfHe/A1Q37xcomGKCgEQEpNxq7kQQ3PKK4ICQzB1mT7Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9h9y6z9KVyN1/DUu7Q5bVMdOVCEzIdJ+PlSAY0lL490N4dvl9M
	YprtY1yO3P9NcPmIQ4o+SDMyxquUYKt5Hbanrh+pZB1QJRBN8Z8PPILCeP8iWJnj7sXMsHB6T+j
	6eHXoAJw55OscGF9Wp8NORo93CvnLaQJ47lq+vgZG
X-Gm-Gg: AZFdTZcz1QAIwmphOmGqrxBpU1NA+yyOX0+HBHrSGJBz7/EcyWj3ijKmL53VXWh7ZXx
	a5FkU0Eq27MHew0k7XH8SHGY6IXjMVQ0Xi4nO1/twO34DXIHjFlrTdUJasiSZ3H3+oyPQ6b8NuR
	88UqOi+cJGWZSBEw4SP8C5FgEXpHYV82XBfQFmb3iqBZ09YqegCz/YH5Y70lZsUAIIZ+tESElRJ
	psy6a5c4wYBDU7QQ+u9et7dh8GgHi2v0dlKLTXAWwkoSyFCySogOcJ1WxYhVpBdGqj6qnnQRaae
	CwcYa9AKV9KrUtNw3Lra/QHzkruTVB2FhiCVtkadul90L6IGEsGCfp15vd7qVItuW9U9+kArs4M
	dmH57blPT9PPs2fZ4MIvDlRhvxcRLMgvNmuysPzXS1D/HgFPNL2PW16NtNxrl9FHKMkgVRQm35v
	talm6GaSBYstvJNyG9MeS6Z2Fey2fMn1lanuqZu1te43pi9Q==
X-Received: by 2002:a05:6402:1ed6:b0:6b1:c6fc:aba0 with SMTP id
 4fb4d7f45d1cf-6ba6edb6b8dmr7974a12.7.1795211384379; Fri, 20 Nov 2026 13:49:44
 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-3-hao.ge@linux.dev>
 <CAJuCfpHOZS6mp_no3wKmU3-S4HKspnbriUw8Mwtxf3nmw0-pfw@mail.gmail.com>
In-Reply-To: <CAJuCfpHOZS6mp_no3wKmU3-S4HKspnbriUw8Mwtxf3nmw0-pfw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Nov 2026 21:49:31 +0000
X-Gm-Features: Aa3M54qncu_g5WX6d_gqnAW-RhgHGus495VL2_o1wphopDeOUeDevYVBGMQXiF4
Message-ID: <CAJuCfpFv=sCeib+SDWJNW6oqbNnhT+m3YjnfKh8jNkquzuYORg@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] mm/kmsan: undo the shadow mapping when the
 origin mapping fails
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 9:14=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Nov 16, 2026 at 7:13=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
> > the origin pages. If the second mapping fails, the first one is left
> > mapped, and the callers do not roll it back. The next vmap of the
> > same metadata range hits the stale PTEs again and fails with a
> > WARN_ON() and -EBUSY in vmap_pages_pte_range().
> >
> > Undo the shadow mapping on that error path, the same way
> > kmsan_ioremap_page_range() cleans up after a partial failure.
> > __vunmap_range_noflush() only clears the PTEs; nothing has touched
> > the shadow mapping, so no TLB flush is needed.

After a second thought, kmsan_ioremap_page_range() does not skip TLB
flushing. __vunmap_range_noflush() comment at
https://elixir.bootlin.com/linux/v7.4-rc1/source/mm/vmalloc.c#L497
says:

The caller is responsible for calling flush_cache_vmap() before
calling this function, and flush_tlb_kernel_range after it has
returned successfully ...". There are no mentions of guarantees that
mapped PTEs require explicit access to be cached. Please double-check
if this is safe.

> >
> > Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pa=
ges_range_noflush()")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Hao Ge <hao.ge@linux.dev>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> > ---
> >  mm/kmsan/shadow.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> > index 0c88d89bf0d6..212449db34a1 100644
> > --- a/mm/kmsan/shadow.c
> > +++ b/mm/kmsan/shadow.c
> > @@ -258,6 +258,11 @@ int kmsan_vmap_pages_range_noflush(unsigned long s=
tart, unsigned long end,
> >                                             o_pages, page_shift);
> >         kmsan_leave_runtime();
> >         if (mapped) {
> > +               /* Undo the shadow mapping set up above. */
> > +               kmsan_enter_runtime();
> > +               __vunmap_range_noflush(shadow_start, shadow_end,
> > +                                      gfpflags_allow_blocking(gfp_mask=
));
> > +               kmsan_leave_runtime();
> >                 err =3D mapped;
> >                 goto ret;
> >         }
> > --
> > 2.25.1
> >
