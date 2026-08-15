Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A468A2EEE93
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786765256; cv=pass; b=fFBnGbRgaJcE+LZciqakndYcalHFmNBefx6doCtL+of5HlH85HvOUbpW57TLrx/nxi2PxVlox99HlDh3WmhOL3Y9Mo0K6QAMNfRrrUaGhrO4KhY+71K5MuiIDRST1ODjAwyaVNy+9ygjXcs4kb61YnGb/cILeFKdS7tumc0XMIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786765256; c=relaxed/simple;
	bh=+5hLXBTYRoTMw1xaNCoIkX0kfZwmouQsDqdHDwqd5KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJJLIx2a/sGAE8SntMobiJCZrM/Rdfkbj+WX3XNbjsXm0rBAKhLpTsT28nYhJbL9RYul7stCIk+iRdghM1//hWBAl5ztWazjk7QYrkk8Ou9+aAX4tHUzpxFK/4NJajTdEHcirlMTRlplPuS8ScRHxILviUXaugsrRpB86VB/6Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjiR8ABk; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjiR8ABk"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c10e86e52so378531cf.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 20:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786765253; cv=none;
        d=google.com; s=arc-20260327;
        b=kIUnPSg4/+hPCfEzrX+AqB0TXshy/UIKTDYgLOS5FDHKMXwtSlmBam5NRbzs3ZAvWd
         kG33qN81k/DIn5Bac5R+qiupPiL7z6qykt56avdW0cViQSs1tD4eSQFqiYcLFjhq8POa
         g/nAZDdgJzX/goywEViE8PeXmodo1jfDBUvgmvvFv4GPV5MwMU3DsgIs9mI3skay7dW6
         U2K8PHNMZT+wUhfzEZpLtVqHVN+34T7wzJJgq+K6YDSxOZjyhyLBdJqhSTABsPri+QwI
         1lk/0RRufi8jykbvYcxPUcXSxbFDKEt7tOMtoFQTRXuPnq59QRcmao9y0VdDeSAZlxXa
         c2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vkBjXZgfE9QuZPVA0q0zgHjLQlsV7v8f9ZdsGtdUY+w=;
        fh=Qay31DMTXHZoK3JZqYo6ZXI/gTNijsWLhTJZIuxlWkE=;
        b=fgBPsAA48s70BSl7qCGfNoDWwHr3qh+Na1v7X8fw7e50GGw1mWJeAfIZLsPQJzqrbq
         InPZyYWCPpTcirmIGP5LDw5mS5TeQqPww0KPYuQ66tJxLFJg2FVRJi6zNNhwW+O2IKD2
         a8D9i42kryM7OcTkCnagcYYBeox8wheFgIwxc7QU2p5Alljyiko5izgJDKwaMmcrcgtV
         a1SPuldxbwPw+f43TYO9QFHWBybr4l5xLXykgYwMpt2eJEHrGq5b6ysQCa/qoSSSy3k9
         KnM0YL6JfCgyo3C7ghjiSjSHBNBYmKrJUT47xLbH+l8/ZC9aEcTkjuGompFs52hV8VTz
         Hjmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786765253; x=1787370053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vkBjXZgfE9QuZPVA0q0zgHjLQlsV7v8f9ZdsGtdUY+w=;
        b=tjiR8ABkpdqUfdhGVjqvPqF6OksfiK5cjhALxzvPR22FDSbBCMt2cGIg+5ARAmZARK
         glamKyG8qHI82fo09so2n8EJJb+BFJ/Ub29HXA+LhNVA7eucVsLQiKhAwshh8Ion6q9/
         8pJSTXfx8DhnYJyKw5VwnJdCzzdQkn8Zr0KG5K4JmHLO9KXBKGTHx6P0fT/4+HxPmBii
         RFm1tLJlu7QcazGd+ic/xURAOOCE0K+xilMXjIPcFKwcwG8pr2pP5zxbUFivN5ISNRo1
         HnHchcYOO7qNXtPDZEwiw2C8uF9lew3vf458s14nz4YaG1z+oqhp8bXKwDgfbiOCrJYm
         QAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786765253; x=1787370053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkBjXZgfE9QuZPVA0q0zgHjLQlsV7v8f9ZdsGtdUY+w=;
        b=SV5YTMah8VqglQe0skIJzf+Y6aY+QNEfRzt5rj24rmtSZ9IbzRplU3+bdWxpKPIwTj
         EnZacSwdruK2uyALtyD2VXj1LYgD53oD+JOWhWfYE/0YlAn7c+WfDtZiOWpmN68Ep8z6
         SZteJ/NoDHCI3cC2VoHbIc+13l41gvqvp4KWAThalWq18k8l8QQV/o/q9ruQHqvY6kRU
         l/GPmkJDODN5IAw5lX/k5PlZ65rO3Bo5Yx6XIyr4lG4lE6okToZ0eYfNeXZe71UVjfXo
         9PXf9Gxdn7Q95kfjN5cpTryF070zC/u4ce+dUnfbBkq+iccHPyGq1BVvjsUZFNHbZVHs
         T6eQ==
X-Forwarded-Encrypted: i=1; AHgh+RocsG5UBD0ROuG/XniY6ghqd/pusAOIvXYQbyt4jxteGPfGS69yi7vV4E/vEZn8whrglF5lBjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIypXNc8/hv39KzH8RgEVT7bjupTNTFlyfRZxfPcqI3ihCEyY+
	lUDm0VHUzZ2qmqYgn3fj9AU0Yy24drJNrpotthvzEHBCLQpWn3uIMXYwaA3LwWM4eLllfk3uaSj
	2ZifR2kJiAVKMoWbOsRabmyz2ubZHJXoynzTNfsyJ
X-Gm-Gg: AR+sD103IM3fjsZNXmzmc4PC1vg+4pEQbcwhi0ctcWIvQY2FiCyAga0vFCEFormCiDe
	8HuoPJQdnFk+MAhdcgcBTxiyFmiYcQ/sbtCZkZyaurVGNie/EWRSkES18s5/JZipdrezRjf6uV0
	ZMLk+t7nxBoxH10RShiNTGrGJZXV8bCzOLZlQKQCEOhwNmFB5swMRUjhFaXZrBPF0O8+P5PZi4t
	LZrHuvyhAmpGUO/e0IP/W27XgXEMWpk954qkQJae1YiHqh64x/5wFyY0PwNwb3dkQ/XPvtBbZgl
	+jpvtvmkgrKdO5SbynfIUOljy1Kkmz9HyxKxwGm0gpvRL4P1Fyz20w==
X-Received: by 2002:a05:622a:2309:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-52d863056ebmr33346621cf.13.1786765252641; Fri, 14 Aug 2026
 20:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812054105.102637-1-hao.ge@linux.dev> <20260812054105.102637-2-hao.ge@linux.dev>
In-Reply-To: <20260812054105.102637-2-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 14 Aug 2026 20:40:41 -0700
X-Gm-Features: AcwNN1VIChM5uS8AeDFgxDsAxr3cLyAQ5ichFcFG4fV7s7-Mxs0cUi0jsKmDMp0
Message-ID: <CAJuCfpHYnjhHh6mex5vuzwz=ggn8cuW_oR03KWih9vx+76a+RQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] alloc_tag: move release_module_tags() above reserve_module_tags()
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:41=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> release_module_tags() is a cleanup helper. reserve_module_tags() can
> also fail after storing the reservation in the maple tree, in which
> case it should call release_module_tags() to undo it. Move the helper
> above reserve_module_tags() so no forward declaration is needed.
>
> No functional change.
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/alloc_tag.c | 92 +++++++++++++++++++++++++-------------------------
>  1 file changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 52aece27b00e..af44f90379f2 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -835,6 +835,52 @@ static int vm_module_tags_populate(void)
>         return 0;
>  }
>
> +static void release_module_tags(struct module *mod, bool used)
> +{
> +       MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);
> +       struct alloc_tag *start_tag;
> +       struct alloc_tag *end_tag;
> +       struct module *val;
> +
> +       mas_lock(&mas);
> +       mas_for_each_rev(&mas, val, 0)
> +               if (val =3D=3D mod)
> +                       break;
> +
> +       if (!val) /* module not found */
> +               goto out;
> +
> +       if (!used)
> +               goto release_area;
> +
> +       start_tag =3D (struct alloc_tag *)(module_tags.start_addr + mas.i=
ndex);
> +       end_tag =3D (struct alloc_tag *)(module_tags.start_addr + mas.las=
t);
> +       if (!clean_unused_counters(start_tag, end_tag)) {
> +               struct alloc_tag *tag;
> +
> +               for (tag =3D start_tag; tag <=3D end_tag; tag++) {
> +                       struct alloc_tag_counters counter;
> +
> +                       if (!tag->counters)
> +                               continue;
> +
> +                       counter =3D alloc_tag_read(tag);
> +                       pr_info("%s:%u module %s func:%s has %llu allocat=
ed at module unload\n",
> +                               tag->ct.filename, tag->ct.lineno, tag->ct=
.modname,
> +                               tag->ct.function, counter.bytes);
> +               }
> +       } else {
> +               used =3D false;
> +       }
> +release_area:
> +       mas_store(&mas, used ? &unloaded_mod : NULL);
> +       val =3D mas_prev_range(&mas, 0);
> +       if (val =3D=3D &prepend_mod)
> +               mas_store(&mas, NULL);
> +out:
> +       mas_unlock(&mas);
> +}
> +
>  static void *reserve_module_tags(struct module *mod, unsigned long size,
>                                  unsigned int prepend, unsigned long alig=
n)
>  {
> @@ -922,52 +968,6 @@ static void *reserve_module_tags(struct module *mod,=
 unsigned long size,
>         return (struct alloc_tag *)(module_tags.start_addr + offset);
>  }
>
> -static void release_module_tags(struct module *mod, bool used)
> -{
> -       MA_STATE(mas, &mod_area_mt, module_tags.size, module_tags.size);
> -       struct alloc_tag *start_tag;
> -       struct alloc_tag *end_tag;
> -       struct module *val;
> -
> -       mas_lock(&mas);
> -       mas_for_each_rev(&mas, val, 0)
> -               if (val =3D=3D mod)
> -                       break;
> -
> -       if (!val) /* module not found */
> -               goto out;
> -
> -       if (!used)
> -               goto release_area;
> -
> -       start_tag =3D (struct alloc_tag *)(module_tags.start_addr + mas.i=
ndex);
> -       end_tag =3D (struct alloc_tag *)(module_tags.start_addr + mas.las=
t);
> -       if (!clean_unused_counters(start_tag, end_tag)) {
> -               struct alloc_tag *tag;
> -
> -               for (tag =3D start_tag; tag <=3D end_tag; tag++) {
> -                       struct alloc_tag_counters counter;
> -
> -                       if (!tag->counters)
> -                               continue;
> -
> -                       counter =3D alloc_tag_read(tag);
> -                       pr_info("%s:%u module %s func:%s has %llu allocat=
ed at module unload\n",
> -                               tag->ct.filename, tag->ct.lineno, tag->ct=
.modname,
> -                               tag->ct.function, counter.bytes);
> -               }
> -       } else {
> -               used =3D false;
> -       }
> -release_area:
> -       mas_store(&mas, used ? &unloaded_mod : NULL);
> -       val =3D mas_prev_range(&mas, 0);
> -       if (val =3D=3D &prepend_mod)
> -               mas_store(&mas, NULL);
> -out:
> -       mas_unlock(&mas);
> -}
> -
>  static int load_module(struct module *mod, struct codetag *start, struct=
 codetag *stop)
>  {
>         /* Allocate module alloc_tag percpu counters */
> --
> 2.25.1
>
