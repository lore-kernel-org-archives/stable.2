Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DF4F4746
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631186; cv=pass; b=XNWq3FLaArOoiyBB+E4kGCl4X96kfpi7QjASjaQAnfyN6WFI0t9wcEk1CH7ss8RY4+QVml+MQ+erN6GLxMng+pf6foC+91WsIS5bf9b4tAOeIG/0V8Oyh5vd2TB4ZB7LjPol0TibnmaCxLcZWq4q4SASTZNsIFQeGEHtNYyD6cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631186; c=relaxed/simple;
	bh=EA27YKz9impM5lVK/eI8Pn+cGv629ZkPNM+KYO0C0Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tv2CpNsb42O7IpNBqEFOrmiuXJVSTm+WnRWR4ZY+oKyh7Fk0esxm8vciRjJwNkdl2mJDTNFPTPyo7+q9LwQCkD5mx9BiRgf1h+69Z8NWjSldHO7UVJKc/0B8tQAry7nMchIiJ8j5MUroTd9su9EU5++Wj/xB7pFpTEhT+CDiLAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/qoVaES; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/qoVaES"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so547216266b.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790631181; cv=none;
        d=google.com; s=arc-20260327;
        b=GPs5PeQ67cOeGCd3ECn/clgnIXh9fst8mrkkSOF9c7TxWDNl5IJNRwCfip214raRje
         /nCh++IMsHff99SCRfa7qkPosL5uGWaLlvjgfWu7drEgUkxHXHGd+lws1vPapz/qYlOM
         3D+Q1RkexZESjaVTKZpB4GxsY15695lfzu/xx78RYdHGqqxMkepg2quM4ljOGJ+0iu0f
         WlQtufkUdiZxUXqugufPFRLLzdcaEZA/tvLW17b1/psAgftzqypoOk2cBGyrypW7AZqn
         rAKAIMLjRooJ8DkWgLnMmartH6/UT9yGdPJALBc0z5gOAV4cu+EfHsuflYupRB9eVM38
         Whug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgy0F69XgkRODojgxpYtLEioAZBN7GxAhb6l/0w25jw=;
        fh=0woyf7z5K90cK0gn+iR55fU2hD/goTtG/YgM/ICC4EA=;
        b=DCFWIaMaNg8eHGzNstoJELhA9Z64kSsyl80aI2pV8TVvsQgKRyeySOhfqgUa4k4Xun
         lCoDNEXZ8Qk1swxKnjA7s52/IeUCRzvdn3LIXBnSEiL2u3w95Z9SuanYPLnCvLV01suJ
         KpsUTQKLynRQyOh1o4eCBQcivzRkxFFyDWeMxhgzPbmqBOzxkCrjkdEG4nk9w0lbPv/A
         x9Uft7wDYR8ahtqZj7UXQGAm8MlSFXyfq2zZFJtHei9mdy3jR6LqSBsi27fbJS6OIxGW
         HLtw7Qudqv8ZG8yGxxy85sDuYdC1YT5xuLGNTwYV4F9904ifLtPrmF4p8L7ebk5BsKJ6
         ChTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790631181; x=1791235981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pgy0F69XgkRODojgxpYtLEioAZBN7GxAhb6l/0w25jw=;
        b=Z/qoVaESgQAUcg99LiBp4xtvNuS2mCiAwcVnWvKaHFqtekjNZ0dy3AEMqMxqbunmd1
         r5IfeVSXZF2WVFntnlifD4fRUeUu3RONK1QXXyFQT/LnPjzUFvNFjnLi1YvCGlae8wKk
         LNpbr4RzPTOnzcCBvrNSHSBcHMMzU1Jg2SaNtlv/n85Lu1yWoTb7Zvsxvyx+HfyVqRLw
         iMEry0mp4Lp5W/niNb/0i5nF05yqV2PTaapdFRJIDQLPeBFQXlBkoEdn1bT+FKUzW85o
         +2BGgRLSB8cykzavEO5tjEQbyfZS3/LOgd68GH4pVE9qlR+PfWyeSDPPdf6Y+2Q1rZeK
         NNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790631181; x=1791235981;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgy0F69XgkRODojgxpYtLEioAZBN7GxAhb6l/0w25jw=;
        b=cmjr9uW7QxFPrFAnuGc+vThyOKmnkNXZNVc4L5ogSEtim4LO3u7e5OOizMzt+812dG
         PRyWXGmyz+vckxvwhj91xkzey7nuSVxJGmzKAZ2ruePAtg0YD/l96GDsOiSakoW0FEIW
         /vtlncKTe8eEIvWBLxv6l9/hZBMX/46y78OvcbyKzX9ZYvqxdCnIjs4hLYb+OAWE/dyg
         feNwhySBK0YZLhabQuP5pcdr+j7uaTHTBdFk4knEreb3nhlxoesf4/xaBhl3jiQ3qLgW
         H6rsNlK2lQ9yQ4zXqzMQX2lRiPyFGqt3l0r2TuWza0vaXaxYrb+Yz8sGP157dvXo8KY7
         rdUw==
X-Forwarded-Encrypted: i=1; AKwUvBxb+syrWCAJPl05pQZBrF+9pJRp7xzHLi6atFvrrMqTq3oL4y8NvhvcSTMiE/y2twOYEYzsX2k=@vger.kernel.org
X-Gm-Message-State: AFuF++mvpB1yjX/22UONUXKdEyP8rIYcPxpfDgWHo9+qF0J4s0RQEqPi
	8vYwSfseqjyYq8Qraa0f1tLpWQgLBrPaC9HNz7xqeT4w3L3bQzedPktgTuNT9zkdUfttz/ga/8j
	3a2+A23TrTphISGgUyPF4rxOG/9VY7Ng=
X-Gm-Gg: AYBFou0TbSsScjJt+2Mm5TtoLbyw/XlIb4lbsWECfMMLVQtCokccnWjgXcijNDJbQlq
	rUNJnfD2u6aoY8EntzX8BxTViBYVPapjZdR5G5LSjaoWWmNyDRzm3I0hxJGPqH7X8vxJJmGH6Hx
	2fAFEdGCQVIx/Ewqee3sdrH4wLSZCWqcTenOOYi8U9AwQcEY+xD1vbh+ibph3Z2ZYqqVtW9+VY8
	7LM35x0ne42DTWPeRiqGkGmFIMw5Ebc1uIrD3UND72ZZ+67bhoaEdiOY7+TvpJCRMS+v70M5olL
	rOASnunmCSjfAxErR54o8no8MeP3Hx9Rlic4k1NYsUIMjpKpAGogOdclKqfn4euQry0VON0y705
	EA6nMWQIYq/ibRNY69d894i4zAULSj3aCZjFi7Yb2jkuupUDf6kwthva2u3xtbsABbOuxfnLEn3
	du4R2xK+70//kfqtoElpPUZcH1udwdUVTZ51+QWb03
X-Received: by 2002:a17:906:6a04:b0:c2d:d89d:346a with SMTP id
 a640c23a62f3a-c2dd89d497amr349572966b.3.1790631181365; Mon, 28 Sep 2026
 14:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928200318.63383-1-meatuni001@gmail.com> <20260928200318.63383-3-meatuni001@gmail.com>
In-Reply-To: <20260928200318.63383-3-meatuni001@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 29 Sep 2026 00:32:24 +0300
X-Gm-Features: AclHuK9jufUluVP0aI50nLvoQUmzoRhFid92QksQpAfKio6g-wKWdy9HiOsdwUA
Message-ID: <CAHp75VeLOAs_hZUk5aX8O0Cktj9oc0MP0QEd-eJPmA8s_6NSCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: hp-bioscfg: fix non-ASCII truncation
 in hp_get_string_from_buffer()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 11:03=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.c=
om> wrote:
>
> utf16s_to_utf8s() writes into dst, but the manual loop that follows
> re-walks src from the start and overwrites dst with truncating casts
> (dst[i] =3D *src), discarding the UTF-8 output. Any code point above
> U+007F produces garbage.
>
> Replace both with a two-stage conversion: utf16s_to_utf8s() into a
> scratch buffer, then string_escape_mem(ESCAPE_SPACE | ESCAPE_SPECIAL,
> "\\\r\n\t") into dst. Passing the four characters to @only avoids
> escaping quotes, leaving them for the existing strreplace() call.
>
> Tested on HP EliteBook 840 G2 (Fedora 44, Linux 7.2.7).
>
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Wrong tag. I have not suggested the (main) idea behind this change.
You're not supposed to arbitrarily add some tags without respective
consent.

> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

...

>  #include <linux/string.h>
> +#include <linux/string_helpers.h>

You can replace string.h with string_helpers.h as the latter implies the fo=
rmer.

...

>         u16 *src =3D (u16 *)*buffer;
>         u16 src_size;
>
> +       char utf8_buf[MAX_BUFF_SIZE];

Try to preserve reversed xmas tree order.

>         u16 orig_size;
> -       u16 size;
> -       int i;
> -       int conv_dst_size;
> +       int utf8_len;
> +       int escaped_len;

--=20
With Best Regards,
Andy Shevchenko
