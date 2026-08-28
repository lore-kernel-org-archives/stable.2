Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20455175A5
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875503; cv=pass; b=IC4t1o3s4cSKQnTkkFZcy4D8PpKcRBw7W9aGK/bJVEzYjMdKSAWD7OlQtwCKwb1JO9wL4GyY3g+m7JcHu9Ns6dW6yMXvfoFvDM0PyhmPQYOftnacVcxLxuyStfOpQNhxeoep5kfLIYol86QspvXCVhzdB31iKa3Xi2Kjqhk1rz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875503; c=relaxed/simple;
	bh=PFyr2Yax0psAjbVNGRDUr1d6xTY3B4cnOPN1BhDgrd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRG5lp9Uvrf4P5rLcst/+r8XeeLjz+gjujnEYxJqZ+vGt3YG7HbFA4mwu6XYeEf2neVjG6ckFndHq1RapMcnEMaEqerHk8tROzQUZ6W78SDbhEs5IN/MzTbaYRjILJRCiYMAhhXe58iKLZTLtpb172Wr/RiYP++HierYT+LzGNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7a4nifx; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7a4nifx"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-851cbd64814so27336b3a.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787875500; cv=none;
        d=google.com; s=arc-20260327;
        b=Y2W8VYsWBf0vrWtsPzRWgSYPewif22HYDEnelGC+ymwJKky3Dt+KoCOx1cmpNiUtAz
         NoRtfvjrwNT/XXf7QuVBpeiNqIeT+Kaz3t4sDdT7W8HaJidkgCRbORB0vVRXYv9HItA5
         LIuuiYmGAddY5skvo9kxA3lwEYrIGfEcM7JAA2CRwbAZiUzHslrqfCR7NpI6TUM8XNlC
         bi3T3+vbWekkG7lD8uOqFpAspKbIGpIV+HZMefkdjGV7yfvRuFHIQCcXh4fyy04Bmc5Y
         Pb9Ot/bPDWQikCPaIPk6W78JCkfN+STfOKhy0Sl/SJDFHDJAJEKnObNNX0QDpzKkj7y8
         oAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yPMW9cNcy0b0Gxn9756IDFDtVnIcdjZAJDlCv5e1zT0=;
        fh=VBX2gd2Uwe3rYEhFdQGRrtjHOjcbTwDEx+zbykFIet0=;
        b=FQDZ1LoVANOsvSy5UCWcIRc65jn0e8jRE1Oxmo1KsB3HcaRIN13Y5fLPD8w5BI3jYQ
         Hmit9Xw+QarsrGXz7xvxJ2g6mgsaPqYTD0yaN4THe2sKQNo6DrEKxKEIttF/0g8p1/4f
         e8mzcaE8pvhfbvjquWvoXl7lvUtWgGm7DA0My7uhXUMxo96TsU6Ui+BDDk56bPOWbzI+
         0/2tTgpanbKWitEupxa7QdEcD6dCL6S1SWNHS9bIbR2FUcFoIN8dEtaQkiE271zbaH/w
         7v0KymUxahm98nEMlKwsgI+6Q0rZSK5vuw/DiHpseL3ehNBM4CqLdoRL3N/l/bVmwcWR
         SrNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787875500; x=1788480300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yPMW9cNcy0b0Gxn9756IDFDtVnIcdjZAJDlCv5e1zT0=;
        b=k7a4nifxqJ1hE3gMfPYwb05fzwmsB0oWkzDMau3cwCaQNfnYPz8mQRW74VDY7/AL0i
         w5tvACJF7CD9AIBrl/GE//9O3mE4ffwqPWmX/kmyaq7EYONLaG7TT8HrblxODDvkc9QP
         tCymoBN+2/ly4v0HSwsr1DVUTKOL2SXeb3W8IfGKEVoc1bm3NUAOX9LVyu8kRqZu9cv/
         Zt3QYBQGsqKe7X2IZ7otRwHgHw/xlBkyrrcqoa53dUgiRc1W1ASz5aVGKe851NtO+0vQ
         JevwzzgE40VSwS07a64pm0aAxbzetUNFs/b97wiAdml2mtCaGFgHSn0N9IQ3hKqFbvCi
         9vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787875500; x=1788480300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPMW9cNcy0b0Gxn9756IDFDtVnIcdjZAJDlCv5e1zT0=;
        b=E9WpzsA1T5k+063UtOBwQLUitUPyF5VKxlTjv5Mn8dWTYnHZgpAP6AOEV9QU4AuXle
         RNwF5UTSv1FLLt6mDVd7121mR76pqmasBlLuQ+OKz5YHinh6XcyJwWTvU2K3lESR2jbm
         2+Db9qXMMqEVBmezVWgubv3wawiH29vT+ocgWSBhaaxvvPcrPjDzj5WmxG7S3RDAsyBk
         7Pb5eM95ZEygemOiGOK2Hmu/RBvOVTKxM8KUOAlstnOcEl/sk3cxA1tbITR2+lQvGdOs
         fV7a9AqPbZTq2sKSZ7+cDjWcikKXRw3juCEGAmPYv6ySqmNIYBJPHymi4I3GvCj5J6j7
         0DyA==
X-Forwarded-Encrypted: i=1; AHgh+RqQeH8Z81WvfbyBO22LZnIsXg8WRJJuuq2QJbpvLJv/q2gexdaKWHESrAEAjS5r63rcP+ZvqgE=@vger.kernel.org
X-Gm-Message-State: AFuF++lKE+eQKqnd+/3DKd7xKehhqdwscKutvQ4CgJJNe0lFUVArcQRt
	LgvoZK/L7HyIDLSat5RqqsadfO5OEwo7cJ7lpiXlkPVGSI5N4CofQTL8+mqPT/EO82Ppd6yM33Z
	IFaJo9B+O9XJL7bn+CDzzLD8U97Z9PO0=
X-Gm-Gg: AR+sD10oCzowU5DIHgKwZrCh8Mm9Fnky475QUjQYH+bj2L4dnuHjqthxAqLuy43hEJ7
	eAKYOoa8FbAuJyxTQK7LrXUWg1bP3xJJ37e5qX29qjUDF3BpLOa0dktZnPzpW/X5IbgUJT8KJD6
	yIpMmCH+EN7EOAibxnWALQMy679dboWajPI16g/0L58AACagVrt0oMoFQNz7tIiOSNO/reAG2vl
	4RCNQPkgu4Mla/tBovQmZ1uzD2XTu+ZyscIbCr29NTsO7UaI1xRKO1hdOVjjyQVEditOkbGnMGz
	dBhFg7dUxXZM/0/v5NvhqYwf/gQZeTWBRKRGIovghfEPlmtVqR3LIOv5vZcjSCsHnT20yDQHqM7
	O6pMZosVX/KqvSlj/w6t/LsVhzg==
X-Received: by 2002:a05:6a00:3309:b0:835:6388:655d with SMTP id
 d2e1a72fcca58-8562ba7dae0mr6302793b3a.14.1787875500260; Thu, 27 Aug 2026
 17:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzbGe74OuUKiDz7oBrWzQCD54JVhYuCTQEWNHOHmnBEtbQ@mail.gmail.com>
 <20260824083327.1708560-1-chenyuan_fl@163.com> <20260824083327.1708560-2-chenyuan_fl@163.com>
In-Reply-To: <20260824083327.1708560-2-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 17:04:47 -0700
X-Gm-Features: AcwNN1UBYnS7FD610auS33NR1yghL6FPy5aMSeXhTY-PLjZTBWjuSmerZRMWxYg
Message-ID: <CAEf4BzYLUTO+6bcp8X8M_wbc=JaxZMo4PZCgS0e-t=8zMO9tSQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Fix queue/stack map u32 index overflow
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, Yuan Chen <chenyuan@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:34=E2=80=AFAM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> The queue/stack map addresses elements[] with the product of a u32
> head/tail index and value_size, but the storage itself is allocated in
> 64-bit arithmetic.  When max_entries * value_size reaches or exceeds
> U32_MAX, the product wraps and push/peek/pop operate on the wrong
> element, corrupting map data and leaking stale values to user space.
> max_entries =3D=3D U32_MAX would also make the u32 capacity counter
> qs->size (max_entries + 1) wrap to 0 and permanently break the map.
>
> The original bound check was removed by commit a37fb7ef24a4 ("bpf:
> Eliminate rlimit-based memory accounting for queue_stack_maps maps"),
> which deleted the bpf_map_charge_init() call and with it the
> U32_MAX - PAGE_SIZE check that had earlier been moved into
> bpf_map_charge_init() by c85d69135a91.  Oversized queue/stack maps can
> therefore be created again.
>
> Restore the bound in queue_stack_map_alloc_check() with a single
> comparison that rejects any max_entries/value_size combination whose
> element storage would reach or exceed U32_MAX bytes, keeping the u32
> index multiplication overflow-free and the capacity counter valid.
>
> Fixes: a37fb7ef24a4 ("bpf: Eliminate rlimit-based memory accounting for q=
ueue_stack_maps maps")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---
> v4: simplify the bound to a single division-based comparison as
>     suggested by Andrii Nakryiko; this also rejects max_entries =3D=3D U3=
2_MAX
>
>  kernel/bpf/queue_stack_maps.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.=
c
> index c1c9dee4dcdd..0d9e0b807a50 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -59,6 +59,15 @@ static int queue_stack_map_alloc_check(union bpf_attr =
*attr)
>                  */
>                 return -E2BIG;
>
> +       /*
> +        * The u32 head/tail index is multiplied by value_size to address
> +        * elements[], and qs->size (max_entries + 1) is stored in a u32.
> +        * Bound max_entries so neither the product nor the capacity
> +        * counter can wrap (this also rejects max_entries =3D=3D U32_MAX=
).
> +        */

nit: drop the comment, it took me longer to read it than looking at
the code would


> +       if (attr->max_entries >=3D U32_MAX / attr->value_size)
> +               return -E2BIG;
> +
>         return 0;
>  }
>
> --
> 2.43.0
>
