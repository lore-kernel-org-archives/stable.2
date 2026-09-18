Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32AA37AA9E
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693760; cv=pass; b=YOV7ozc7Xro4AIJq8jwGzt5YCvWFyYZKNVLrOlbYyztW816+GLasUh0xFRydhgJyslMirjCuirwGghnF/ivkTnFQriCsL2Pc8MD4mo+q31njClyBknnUdLkMRFtxZqRVWwilmZtIViJzeeKaPuQZGjzVLbhCgGYqd8yhKGIuCJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693760; c=relaxed/simple;
	bh=VQGIa5OfAJMQ4r3GsmpmN36ZDjm6tlTvjyCikjUyEUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSr6K6hCmYHmkeB+fFo/qwp1zUgPsceX6TtXWrYNIxeyHKESDPpcv6E4GXbeoR8ecBbEthheAhIOIPSx3W4fbwbvKDZzSBYJBZYNrWMDshfao4iVZcaG+xegLsndsMlUR/2t9LBu7d2UenWtVZlAw9A58K+7xnY+MS7nSdLQ89E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6Ow9wej; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6Ow9wej"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-530e8c6fb80so89021cf.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789693754; cv=none;
        d=google.com; s=arc-20260327;
        b=cP08wUz2kgmcGKWB5MyAP45wa56riP2DAdWXscwEn5SPGMXUDDoHbfmzZD/fnTp6Y5
         N0YV4GCH/lsHhk/FcHHlfd+PVI2D21FW3Q81V4k3XM1GhzNRJvquDueMDHoCVUwTt03x
         0BbOCa5XvIRPzmO9R9xFrgmTJUpnWnTZgpqz8qWjcJQxwgE3SpMPPvL2eePXmfoyeMEy
         rzWHef0f/3EGEpQ7X7cL5MEZ2zjB7lyu1/iJA6CzA53ta88lwR+lc0VTPvCiIvds4VY6
         TVcygXKQjG4kd3f3ZIayMqIIF7eKzaZ8dqI9/DXKfoCGkjUC8l6RwKkoYubmle8fGhNO
         mREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9OH+vRLumsrAn2s1eXS41G1CuSBMFEgYn9wTdjASFyo=;
        fh=aWsJjnzxCFkGGUsmbetHkRjeD4icolkQXreWwqDOvi8=;
        b=WZXZ7jXEvOmdqRdnPn8iiQmBiNqG2YSe+ARbPNU/HwOhTOn8AqR4qauhxOb1sctfHV
         jLwJBBx/dnSB1cHb6XU+3SVoz7ZiH2SQG4SBg0q11qUnULEZB3+TpQj7KoUnC4y/s85T
         HjvZCAl2kMbRy3nBTpR2JbWm0RTxabbfl/yh8ciIBS9KvVzZ51DGv2Rt28YcxMfhS/hV
         /4pgeHL9d0+w1ILFFIWs0kx32gq05gI4Wo0Y+ZUqkx6NP17R5GVN7nGPznwGCdkcpkBP
         letxwKnGCoMRwd+/VR6IgZSUzv/DozUAn2P4LfariwBeiT5l/FS6W/HDLL833gPhvpGf
         8CVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789693754; x=1790298554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9OH+vRLumsrAn2s1eXS41G1CuSBMFEgYn9wTdjASFyo=;
        b=t6Ow9wejpsaNY3SU4XpVe+Zw0+ZiIQ09b6+mUxgxsFQx3nC86ClPH4yLjBFJjB8fhR
         5W7gdoCXu+FHW6Lnx7fV/RIUtxwuOTC41T5A3CDR1vecCUfwiyFs807NLZdOGp8pNawr
         JoGzjyOgp2/8sgXPlX0l6PcdzHNA8nYsJyQWlstqJpoLlXjhzQHhCEWup31W47pzOkQt
         5y044f19rSQyXhl3Jgtprq5I9D5vhqhe831v7pd5d3jq1UwCis8gK7WSWG2iUBJEQInD
         teur1dAy00Mx8L4HVGxWhlaMwhqQg9j+Ye0Ksfz0Qp9hQqOHdS1McpiQBWFIAfKv6dY+
         TRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789693754; x=1790298554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9OH+vRLumsrAn2s1eXS41G1CuSBMFEgYn9wTdjASFyo=;
        b=m/UQhdZPj8xCpEgB/n8Apre+UONc/GZdxOEqWTNfknL9bg0zK7TIsRQx/EUnd58uGZ
         UuL7deNQOPTYFGzJ90T23bhlz5yBFo2B5LV/rDVdeeAadxy2JS8WZpVEuHjco951+Rct
         /aS9aMpAFS3ikZB00NCktN4HC2gFpqix/0yIxF5xjTAWGMqqwC/SBKs3fEqmveDUjgtm
         dWxLZpubKiMEgwHDFuRAzvfMvyMAgBgALJNDoh0C/iDYHPzTue4a86O8NjF+zMqbiqvP
         x5PwaWPulCbCi4g8Cv6FLdQBAGw+fXFSLP097t8B0s9SqcRDgDQ40L406ZXlxL+oQ1tI
         iyNA==
X-Forwarded-Encrypted: i=1; AKwUvByfEr74clYsZgFzw2AV5Snp6Ml80kliqcD9/LtCxLHxU8EU6Y3DNj18Z3w3yH07mQ/7Cjj5HF8=@vger.kernel.org
X-Gm-Message-State: AFuF++l2ioLeQCTL7kggfV0ChlbhglDfmps+e55HCDHHXvxjE7A+0Ayh
	DaXbXGQtTchFK+Ic8/L+74t9jzCmBz6ZYCVf/IizNsAws9nF4nuR84Jd350OCRaF87vmHJSnXgJ
	gvd23m9DxRLfGm8r5v2Q7JRnYzVm/EiiHH0VKm0zp
X-Gm-Gg: AYBFou0IRPW92LNDhlq5y+STpGN3YSy65TKerrr5g3SWJYmDAoStPHPi+mwXAN/wblP
	bbKyseUBEDa/APiTS545t6lWpbA+W1QvsuUPAduL2sSoLuhLVmvyhdoE1r7997znfd6/uoxjsgD
	NvoOPycv31F2o/+Wfo9ZOcCR9y6i6yloU+2CkvvOmpj/oizX6W7uGqFxAJ1O34tXUGB7o24fE0i
	ezS+xkq/w8rHQvNlk9Vrnjvdwol/8JEbgTvsB6dTqvaadiC9aFcxsNKlXI31qvyAFhV6DMuLCW5
	SugKfeN+MxOYZWvLztjP/qMuSkvONPfylJNPBRLKRwZ/3AGuvWu7+Q==
X-Received: by 2002:a05:622a:2d0:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-5329d7a87a3mr7686831cf.12.1789693753565; Thu, 17 Sep 2026
 18:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915070001.113559-1-hao.ge@linux.dev> <20260915070001.113559-7-hao.ge@linux.dev>
In-Reply-To: <20260915070001.113559-7-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 17 Sep 2026 18:09:02 -0700
X-Gm-Features: AcwNN1WpdwzfsuEi7atSbmPcBeuY9CTLz0TyEvuZKGkV5swWnf0AU7r2YB5LThc
Message-ID: <CAJuCfpGMQqjHsAvW=XUA1Q3AyaVJKM2bKYVja_fgn0wa1tk7DA@mail.gmail.com>
Subject: Re: [PATCH v10 6/6] alloc_tag: Defer /proc/allocinfo removal to a workqueue
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
> shutdown_mem_profiling() calls remove_proc_entry() from
> reserve_module_tags(), which runs under mod_lock held for write.
> remove_proc_entry() waits for readers, and a reader takes mod_lock for
> read in allocinfo_start():
>
>   CPU0 (insmod)                      CPU1 (read /proc/allocinfo)
>   ----------------                   ----------------------------
>   reserve_module_tags()
>     down_write(&mod_lock)  [held]
>                                      use_pde()            [in_use++]
>                                      allocinfo_start()
>                                        down_read(&mod_lock)  <- blocks
>     shutdown_mem_profiling()
>       remove_proc_entry()
>         wait for in_use =3D=3D 0         <- blocks
>
> Move remove_proc_entry() to a workqueue.
>
> The file creation is moved to the end of alloc_tag_init() as well.
> If alloc_tag_init() fails with alloc_tag_cttype still NULL or an
> error pointer, a concurrent reader of the leftover file would
> dereference it in allocinfo_start() and panic.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/alloc_tag.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index 1ca0409b492b..cfa0fc84b68f 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -15,6 +15,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/string_choices.h>
>  #include <linux/vmalloc.h>
> +#include <linux/workqueue.h>
>  #include <linux/kmemleak.h>
>  #include <uapi/linux/alloc_tag.h>
>
> @@ -591,6 +592,13 @@ void pgalloc_tag_swap(struct folio *new, struct foli=
o *old)
>         put_page_tag_ref(handle_new);
>  }
>
> +static void remove_allocinfo_file(struct work_struct *work)
> +{
> +       remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
> +}
> +
> +static DECLARE_WORK(remove_allocinfo_work, remove_allocinfo_file);
> +
>  static void shutdown_mem_profiling(bool remove_file)
>  {
>         if (mem_alloc_profiling_enabled())
> @@ -600,7 +608,7 @@ static void shutdown_mem_profiling(bool remove_file)
>                 return;
>
>         if (remove_file)
> -               remove_proc_entry(ALLOCINFO_FILE_NAME, NULL);
> +               schedule_work(&remove_allocinfo_work);
>         mem_profiling_support =3D false;
>  }
>
> @@ -1358,16 +1366,10 @@ static int __init alloc_tag_init(void)
>                 return 0;
>         }
>
> -       if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc=
_ops)) {
> -               pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME)=
;
> -               shutdown_mem_profiling(false);
> -               return -ENOMEM;
> -       }
> -
>         res =3D alloc_mod_tags_mem();
>         if (res) {
>                 pr_err("Failed to reserve address space for module tags, =
errno =3D %d\n", res);
> -               shutdown_mem_profiling(true);
> +               shutdown_mem_profiling(false);
>                 return res;
>         }
>
> @@ -1375,10 +1377,16 @@ static int __init alloc_tag_init(void)
>         if (IS_ERR(alloc_tag_cttype)) {
>                 pr_err("Allocation tags registration failed, errno =3D %p=
e\n", alloc_tag_cttype);
>                 free_mod_tags_mem();
> -               shutdown_mem_profiling(true);
> +               shutdown_mem_profiling(false);
>                 return PTR_ERR(alloc_tag_cttype);
>         }
>
> +       if (!proc_create(ALLOCINFO_FILE_NAME, 0400, NULL, &allocinfo_proc=
_ops)) {
> +               pr_err("Failed to create %s file\n", ALLOCINFO_FILE_NAME)=
;
> +               shutdown_mem_profiling(false);

You need free_mod_tags_mem() here.

> +               return -ENOMEM;
> +       }
> +
>         return 0;
>  }
>  module_init(alloc_tag_init);
> --
> 2.25.1
>
