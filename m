Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD24779AA
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136542; cv=pass; b=TpjER6gwcB0d+5n1opyTQLW15mTJz2aJKkBv9nJ7oYqjUeff2GTmxD+uJ5pyHE50XN8TLohLea98p/jvrOV+Sf39OG7SrxmswEcThZbf1gXuTS9gAf1ySnDeEIESDI4o7KMyr+++ZvGH46f18mFkH6nT23lUPJZ8SKyZ+XZaM5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136542; c=relaxed/simple;
	bh=JS/DfHmzCQBktqfBDcLgWFGsP1pDN4vWax4Q2BX0O+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeoiMqUJ15TnR95BvvgD6k83FIwZUrWFSzKddetv8/dE7OaxKcJn7rlv30rcenkk4dZ+k4qWusn5ZaKc2hnv7lXHalbyAImZ7yaG4QFu/PAyN3uHMaPy0Xa0mTNrUxd5bxt/W344oNyeWbPgYjKJD2Ap/FeD7nqZCwPV1Z5UfS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eo7Lxbwq; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eo7Lxbwq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-533202fe429so249391cf.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 10:55:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791136525; cv=none;
        d=google.com; s=arc-20260327;
        b=aid2jkI1ixp2vg29KcIJVKlgvZjoxqvUsi1Y0yOqdLRRnGPATgytXSyE/iw74Ckhlu
         GG0hRwEKsx+RZVtEiaCpi5v3CqcKHQkr+9tN5tSSlNf7f4BrQLPstCCXb4/yWv+yLtp+
         aWcs3E1DzMUOgqj7zh2pXfJWFhvuoFmh/GzfBeNTWMi7gkIr7/w7BQCL7pcGa6PfHQZ9
         M28W6RbJpZvAAwpR/4lMF4AdaezxpyXJyLi5a9zABglpip2TVIVfMrOceZqu4XBOQDwV
         KwrrEvdVjirNHWU73QiQb8XSfi0BO2MNKssDZW7cSD0Wo+9Gd4kdAtUgi9NnCavveaSs
         5G9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TFRiHWm52m67lLPZ4QttIFc2/s9ESzUdGTCBMadUb1o=;
        fh=cgo08jWFl+Kt8V5H8IoYCmCkX4yPL4Z2dEisvy8yL/8=;
        b=fZXcLrwvcybSMGxPghp2eEDDAqk3scJV5e1HrGrPZHM3//FnM8u8AJ5NW/H9uNOf0p
         3iN5kNp6S7DHNLTyO1/W1MPJWUNjYA9Rs7ju0VBlKna+x45H45ClHyRj/9vAp9m53jWb
         luPhT54p7kQ+xYVAN33hu6QEzYxxVwkxe5KrTunck6VTJhqGEQkQd0AZsZh8mKDoCEh7
         O3iMXUNySd3FG8vicbdK+IUE7GILG8CSHjZqywgtj1cX78ThqheUYq2Yrqw6KCm98zcE
         88bIhAEG0dAH/l7GVscudJ95uTrzIcyvqeDZDFiO3oSsZw7qZs2kM7/8+YBIKjLfy0u4
         rlQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791136525; x=1791741325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TFRiHWm52m67lLPZ4QttIFc2/s9ESzUdGTCBMadUb1o=;
        b=eo7Lxbwq+tvykVl3jsl+khAQDgShQ2Tccxz+XQGYPbszWI5v6dRbn9UKzEjJ7snPhZ
         bc4wjz2ApoF/eY3f37u4KH0OOxFVgIB3VIdirmzC7kKVpG4dSygLMlbny5EMLja16fw3
         GBP6leu7UZPutM1QXufrPRm8hLdOws1SCk6Q5l7IikMQkl+u8NbKtWUjAhEVof70x16u
         daDFFMtqnK+tlrmiKN16UdbYKHLSdP8YcnMWEb9o/Mj3go9K4sWDPUWUq93kMW2Qxae9
         GRGxJH9i5j2TKyFo/C+ycnreJwp3KVdAZI6mYzAshvw+onBYLswzrYrNIPj1NPxi80CV
         sRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791136525; x=1791741325;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFRiHWm52m67lLPZ4QttIFc2/s9ESzUdGTCBMadUb1o=;
        b=b/eLzUMenfKwENJLtrdTyX57MfIg2qYYsu/bB9aLJxRc6UsEj2WmPuiUOMp8qGmn/t
         IWokyJf2fP2KruEQCZ3UdGQUJB2w8oAgV2dqwJMWYWe7zHAxhGB/LwrSgDcjtzMnr7JH
         1yeaWMDaaglwPTkgb01OE6szwx/XkAd0nkoL06MwU7a0nZE8rn/tPNp72R0pxs1K7fwQ
         och2OjSOhwZNEFumaqHfNAPXTLHg250Gva2H4FqLAfcd2PRKYcy63c3w2N25Aa9ivyAb
         aqY9XDrHg9T4wcuQTWxb0v3KuxT63pfoujhLyFKm1JwlzaXR+AK6CxbY/HtRNHVrj1lO
         Zpkw==
X-Forwarded-Encrypted: i=1; AKwUvBz/juMq2Z345dhG/4NVEHzMoAMzQVgsaSgCXGy4dNmoYGUS1RyAW53ya6MgcqK7/CacZQtq2oE=@vger.kernel.org
X-Gm-Message-State: AFuF++kgr1FoPCm7tZk+DklCDKyRgAbiZjAgBe66YcpyZTMk46IG4k3n
	RDjh9yY8VcwcVhN+iUtr6JgtYV8hqoYfyjVMCNUmsIicEJ7HW0gqwB2MJBFXzywBxlOh22kfYt3
	lJ1d6LHVdimhxbDhrAuIMpTnSh4GlyO5aRMGChP6M
X-Gm-Gg: AYBFou2Uc9Oazu5+rkiiKS828OyoptiQgSqzHwH8seYXsSfhnBUhSgHYiFx5Xsem44V
	GOCEeKNNUi45QujtOfX2E8n9ay3nFnt7uuFd42kga5xekEAtsXyGXEPoKTW4eznmgAHNtOxgIDm
	PI13nbGgpWTr2w4HaLBOMx0c/mFknwUFiInVYhrtFUj9LSRqEpRCG2CsFLLiCZUhBYHjNsSw53Z
	JIIzeQtHcbQVqvtCbWqJEUJUR9Gq6fL5jEzyaH2UI5VGlYff9pwxKvdwl9V3GafUbdkmIziKirU
	1CozgS6JwHVauWgE7MfcL7tA2wypE7C2r4zKwotm+0JReSSiWXE3/rcscbugymR7Aik=
X-Received: by 2002:a05:622a:191c:b0:532:9003:35b1 with SMTP id
 d75a77b69052e-535146541aemr3824271cf.2.1791136524268; Sun, 04 Oct 2026
 10:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929082014.160587-1-hao.ge@linux.dev> <20260929082014.160587-4-hao.ge@linux.dev>
In-Reply-To: <20260929082014.160587-4-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 4 Oct 2026 19:55:12 +0200
X-Gm-Features: AclHuK9GuJ1R4AG2eys0TOfTlndz5Q1KT7n5Xy5IteGOVBALshKC8Ehhj3tDVOw
Message-ID: <CAJuCfpHXT41Y3N70xOF3MXtZm118-mR2DuXP=vt1M+TuMG2Uqw@mail.gmail.com>
Subject: Re: [PATCH v11 3/7] alloc_tag: clean up the populate failure path
To: Hao Ge <hao.ge@linux.dev>
Cc: "=Kent Overstreet" <kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 10:20=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> The reservation is already stored in the maple tree when
> vm_module_tags_populate() fails. A failed load never unloads the
> module, so nothing releases the entry. Release it and roll
> module_tags.size back. Without the rollback a concurrent load that
> already passed needs_section_mem() can reuse the freed gap, skip
> vm_module_tags_populate() and write to unmapped memory.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as neede=
d")

I think 0f9b685626da is the only one being fixed here. 4835f747d3ed
contains the issue simply because 0f9b685626da already had it.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/alloc_tag.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 2070e682fe10..3e6306ee0764 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -947,6 +947,7 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>                 return ret;
>
>         if (module_tags.size < offset + size) {
> +               unsigned long prev_size =3D module_tags.size;
>                 int grow_res;
>
>                 module_tags.size =3D offset + size;
> @@ -961,6 +962,8 @@ static void *reserve_module_tags(struct module *mod, =
unsigned long size,
>                         shutdown_mem_profiling(true);
>                         pr_err("Failed to allocate memory for allocation =
tags in the module %s. Memory allocation profiling is disabled!\n",
>                                mod->name);
> +                       release_module_tags(mod, false);
> +                       module_tags.size =3D prev_size;
>                         return ERR_PTR(grow_res);
>                 }
>         }
> --
> 2.25.1
>
