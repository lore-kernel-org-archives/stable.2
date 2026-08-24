Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A30466B77
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588815; cv=pass; b=Gne2Zw35I5Bb0Mz6Y8gU8rUnVpht5IDeViQSK5nnrK1E/MuIYTESGYTpXa57EPrfhF5/vJyyIAfHpJ8buo7/euZRnenU1YWMQt4ynWMQNzMNZXukHL25qOX6QV6paYV6xfGBsCz067S9MPlUTyJuW82oRSzKp30kGDlnYtg9n/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588815; c=relaxed/simple;
	bh=YXQRKWB2V+T8ESPOJ2XFbSjXMS2trXCGCoVMfipD1ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4ivhSRyymft/kaw83fQ3ovEcgxBNkZmOPpqYlfbuEYbxBSjCBmuMKkQfoffEVS2amiM159TGE9zPP7Zn3WTYH10xbV3g367e1rnPCMxSERPvJvnKkfK3RUcMH0yt8MjwLYcGA8lZgoGFvwHQ5Lbh/fPuilXkS2XyV+OUT5WNE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/ZgctKe; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/ZgctKe"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c15a5b265so592981cf.0
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:26:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787588812; cv=none;
        d=google.com; s=arc-20260327;
        b=Ew3yVFxXBMidCN8eclGiJsC6KuH4T2HYZsEe1++EF+uT1PtGHaWjkHiL2g167llNVf
         8o8AUVeBbSV2OHlcuDZvPLImZ4PkR4g43DzhIUs7OcWL2MutmxRUhDggbClW3P9RiqfR
         6nhrCEp/FzHc/OUM8usnEmXoD8C1scRP5vzLCcsyryiNHFn1ta37NHj36EYkzNgkulVv
         Y25zNIDaHY+G7j9LbTeUEaXVsCypuO5ElxEPogdFNPWcta5Dc5kRkv10HTRDb+NdubSG
         J+OaxJfurBrFIF8txJbh3eNxZv6ytM2lvoc4osAcrwjZLDmLQLphs0vDQhQFjvf7xepu
         QIhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5EKtL9SkX+iCe5X/rOV+4jxySIvKYwH338zXIa8baTk=;
        fh=knpb+F81PvlhzAIu5zSvWg06psUzYRTod8HOl3kEOhk=;
        b=kkGhrFCDGXZneUOU9fgNhMe2LQbh+bUkjU1xm/hq70F+93mavclhnw+PmRffT6aBqE
         QgjUBgLZc6N9ssWNzgvg1K3HAv/5puu+5CJz9lQtd+lBRKlKHJe013pbJkl2Z3iPZkr1
         SB95u4MCfG+125sAqFcx2GVeexnQubCS7q37OrO7x+6P9q58erG9C89ZQWHxsu254JNp
         Mq1iw8g81M446Re0uptd+pbmCc8rfbNGRLvu4TfhrGmYX6xTUwaNJHKkm2DyXbUI9Uod
         9ouQKkHUZIb43+uAvwwDKmEX2sG8A3M/raslssLU3p7WooXh22dIouYme1VPyty6itzX
         jLvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787588812; x=1788193612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5EKtL9SkX+iCe5X/rOV+4jxySIvKYwH338zXIa8baTk=;
        b=m/ZgctKeO3nbAr6t05kBRie8mhjcwEtmTBkavm2c4C6EKAbpXhKsAqMhYynPxknya6
         zRzhj+B9f9r5vmBEDdW2RrZobAy4rwaA4U3L0uzcAHqgfu5a1nPSmYjDOZaf41nEPcXM
         6eUCjgh7lwp7JQGZCkDTmnDNoY3Ow6AgHnc6SR+4I4EB9fHr07nICuvWHnD28U2YkrQY
         CkyDHqAjyIhJtyKnPMekYQHQwUfm35/qo42A4LnVhUDMET2lS45o9cLyKHEpBu6zk7mM
         Gom4popxTK2+6So8TLQYhp5wZRxokCj9DpX/2fYdoU4wa34UMdSBxAWzwp+tFiqH43ZB
         lt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787588812; x=1788193612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EKtL9SkX+iCe5X/rOV+4jxySIvKYwH338zXIa8baTk=;
        b=LxpVctqo3q5Xk/t2AvUU+inH0jW2HSKaYiTMBh3DCtcoi0/Kd1RzZJw9TQCjYdgiy/
         rm2TuOf2l0TzzMrABRVTofwhfBGziJRCgYL1qbFWf3TWWfQqM0HQAZy2Q2bjKnbZH11N
         uo4v8TtgLtG0Sv78KoSW7CS2fIgKm0MJeAaxTLlJbvHxpK0SlddDinpmawQzTdcCeb+7
         qxtUfkVj14p5ZhvERBipS1u7Pd5q9+prM3lgoiYLAuE7Y4GVJciN8i7+2RQe5GOHez/p
         n/9pmRA3wcH+32R84SI6jDSJYerAu7oih/BxlZ8Kid4hXKXk38yBAzkfbF9xSgeTZbYe
         M6VA==
X-Forwarded-Encrypted: i=1; AHgh+RoDrnzd7Ok8/5P28eIhpBnpVNhGcLIPUq2fZ43svovXURJE9BFKSBEHgglU9EHBvaCG2u87syE=@vger.kernel.org
X-Gm-Message-State: AFuF++ksDZ6DjxqoT8KK7wCOrdLSSjEYbx7tKbcvn7ZGtXRpjnEzQ7Pc
	vRFMxVOWhFux32OPvgHuORHMEfh3nlst8Ax83W0+IQRJqfb9TMJyyYuzc3RR9WxGR9imTqfL0FG
	+mOmdv0Rg0QltiopC58zg6aItW6zBHDPPp8dWoNen
X-Gm-Gg: AR+sD13PeEcPBf4Kd/Pmct1QfSY8qYU1NIKU+zodstZpY0wvmc7JAbwEN9WY906HoqG
	aeBh5LTiiRcA5byHM1+J/K0A+9U7P+6J5msCrd2GSM6QTIPowwJ3Ya9M78z8euOUUs5XTztSTbs
	3grsz008wcT052wjlPJ6qfwSjYB5DvjPQBYNSBEkDCVuSl7pG1hafDCABZx01EVOYIkq0e69dzy
	pOYwdEVVuonTEqrN1+5Fdlj7N0hownQllYuhAT6BPS6mR5lNWcqCElpZvpganKiJfkN3eI0VBOL
	nxwUKY25yWj8zRok2lW6Y9khjiutpQ/RveC28mUAsRM=
X-Received: by 2002:a05:622a:1f91:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-52e0941062bmr39983391cf.6.1787588811060; Mon, 24 Aug 2026
 09:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824014736.35026-1-hao.ge@linux.dev>
In-Reply-To: <20260824014736.35026-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 24 Aug 2026 09:26:37 -0700
X-Gm-Features: AcwNN1U17Yy8Z5X6Y-Nyi5K74blzunXrSe6IaeRqrJ9yuxZaN3xLDsfiRO6rgu8
Message-ID: <CAJuCfpG_wQs776EU1bGfUyP8=YDgh2r9=AHc0TB7YjKKN_ksVQ@mail.gmail.com>
Subject: Re: [PATCH] module: fix lost error code from codetag_load_module()
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 6:47=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> If codetag_load_module() fails, err is never set and load_module()
> returns 0 after the module has been torn down.
>
> Fixes: 044d2aee6c57 ("alloc_tag: handle module codetag load errors as mod=
ule load failures")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/module/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 46dd8d25a605..afb810f0154c 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3568,7 +3568,8 @@ static int load_module(struct load_info *info, cons=
t char __user *uargs,
>                         goto sysfs_cleanup;
>         }
>
> -       if (codetag_load_module(mod))
> +       err =3D codetag_load_module(mod);
> +       if (err)
>                 goto sysfs_cleanup;
>
>         /* Get rid of temporary copy. */
> --
> 2.25.1
>
