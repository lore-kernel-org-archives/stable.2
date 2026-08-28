Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB235837C
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902422; cv=pass; b=SR4IEZUE4K65Q3I1D3VprT0/93sHoPcK9uXjBy8PdvKfH9oKsUkgwDX1XwOe+LcLWrBG/UDI/jcIyFqfcBACmt8pHAduP22PvQbG99MFIn6m/qTM4BeohSx1wCUDdq7D1kvqbVYJO/JrqNMN3OHbnFcJvQWd82qzQNkZZEEdUIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902422; c=relaxed/simple;
	bh=YBA6hTBM2zJKMcOv5B6eXA7s0EUOJ3bOStZg17l1SVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKAhGkxaIets/GME7ck99/8V65F8Jyr5PzfLvCqAf/b1G6LTNdfF6M8HC6tY8XFbEIM+rFwx+k+4wja4P3eLaZvc3qFoiSOQp5+nKj8dPD5o3ADqQVR9PGtVrI6XFoDeCrRObBwJTZ2nh16F4mBWLVSjsEzW/8jKLLoXsEl/uRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rr98YIHm; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rr98YIHm"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90c776f6c13so8251826d6.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 00:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787902419; cv=none;
        d=google.com; s=arc-20260327;
        b=sHyK9bh1FHebxUhpzNoOMWxWhdLmV1MbsL4BDEXwaEdQbmb5yQaHvNfDCTnM2OxEeG
         Cly4gkYBRzEy61sVnHTtT1czeG5Q4nVA/cYCoA3jpVz94OHWM2iZT5rfwldZ0p+IQsdR
         Vib5leikTbdpZI5xH2o+b5rtDzx99IT0umjNTE18+d8ncmT3c2Ii4H7MVKPPZJFIP2I6
         rPqO6U7GXpunDGYiSSvwKak4nu/1+1GLmz/rXlqesKdQcM5lAcym7vTOwKWlrH/gSeaT
         UVasQEGsQzttTgzGESJtbEc/Zv4QrWgiBBaTpfjkkuOF+YzZhBKs1IlMT7wESLItrZ/O
         zrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MaXt8bgzgCbl3MVunftubpe4nSjxrU+2s/qgfZJp7gc=;
        fh=u96fgOnOwK0qdhURNiZSqAk7DRzydgpX9LXFgfOL04c=;
        b=a2sBAIfzweNq/bmVAy2pybv/OqBVKmImYVAi97KlKhXgPT5e+OpFfO+ipSHggjK9DC
         V1UYKHUEEIS1M2Ghe9pxbMfSpMEUzWyGIGmucgDQc+z5JCby8dG5ztHO7v5s9BjtOHLQ
         mOOE+xwWlFkrb16pTSttOLzhmcgnhe6sxKKir51vs396r9YlVNfGf7zY88AnkP/KL1Y5
         r3jh4oEjRL4cPh/TSFLxVlWHSYvvMmhFU+XsWGypeGpE4Dx3HFCON7Hdt0c9zCzEf2IS
         BB9bnvQj1vTpVGQxz5cdx23ZdRxUrXkJOzp3rmY/c3bGI/awSW055UvXfaaGQz2JN7dD
         FPDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787902419; x=1788507219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MaXt8bgzgCbl3MVunftubpe4nSjxrU+2s/qgfZJp7gc=;
        b=rr98YIHmIvdYQBvxdtfM9wI+6XhcIxjTJwNrT2UEnrL+6yn5X0RpVeXpCOx4RLhg5M
         TpEITtxitzrShxM/Z5Wte2gmkdXqDrkCIXEt/xgY7T5dh5L8YpNeVvVLi+e8HRlJqv6d
         RlJisXMOzueTLBkJKzCgCKBxVjLaIVOK8zEoH/UNAnqlHmMvQ/NQ3vWUO6wunNJrwo3d
         O2Qpsbu1Ae3gi1Q5XToXQCZyMnT0Jh0Ple4a+QubeOwgjnoxi5cq2lFmeboKgCWaSaWH
         JxO8HN4qKexPd1OVIjNE/3jaaHgNp/9JBuxOSWsvBrH//s2ve7ccm/Dct60jTv2vg+Rl
         W0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787902419; x=1788507219;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MaXt8bgzgCbl3MVunftubpe4nSjxrU+2s/qgfZJp7gc=;
        b=FaWmGcMi3EwfglxwW9+zVIG2Z57F5Td4sepTSjhmR0VXX5bkrv/O9ApcQ1yCaS3BLn
         Wdchx/6wHCLtTzq3uuTi4IVp+8yHpzAoZvVX88IxtMzNm5J4WhpkP1MoKy9iRrUxZSco
         6jvUgHY8PrLZ1RYpqsOQ1itlTS4axsO1A+e1yoNZLKsSkpZrwF18/xc5TQS9PagW7Gni
         DsbGHrEJdemIo2uc3Tm/MS1AFoiG6alAKVD84wORK7XLhXluaAANuxaZFZeo7Ebg+/C6
         0kdkxr8nPoaJnCVw675ojt4uwWCwcAJnSLHILyaxJcsJBjCEOa/EFYmvI/0JiTjM4LMf
         M3Sw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+bRlBMj65exzOXJKwtnmNoXBwZVNGIgoT5iQIYDjVW9Ijpg+ve3inmWuXC44xGYnVhZQ/GNI=@vger.kernel.org
X-Gm-Message-State: AFuF++nF7oDlMOQcC7LPvZ9c+ASlv4oVTdz7Zhr+RXa8XfbwxEOsm/GP
	yre1OOvmWS4fzR+nLFlqe63Xr8629KFgFOQcuFcuvTt1RAqVFwyN2pq/X42zOTSsmFtH4SW7xC/
	+bPgETOaNCMiJ9B/AivXVBa3t3531wHiQEF6tdoWg
X-Gm-Gg: AR+sD12RDVuVqkQYr3wBuaC5Lawh5Pt491onAa0BCpj+tsrTxOJrmm4f99aL3oLIklw
	TYBZXLdmkn4CMlwThbLqGS/nk2oWIVB7W+FX7TRwEJV6GZq3SkU3xdH9+dwteLrzj6vnkV9tIyp
	EzuaibhtehhByojr8NldzXSx4C82jucq+tn2k90lfBwPAUjF9PpD10wW5BD+dQ+DZpxhvLozfdA
	vbVqm190RFgd1tS8FYm8u/rZ6c878scYroPblqrrOPzMGkmo/KGgC+yw6WosJJw19YRcwTCbyJc
	LVl7jBSk0zB2z+iZJtdhE6VHVTVE4NiB2A3b1DObXKq8++vJ0L+osg6ON6YxQObj0I5JkAff6sz
	j6DTr+VZ/apdwIYys+SfyO8YL0ZGOcQKppfziDA2eXZnAqdGmpiTz1bjcI7I=
X-Received: by 2002:a05:620a:2852:b0:938:fd59:cf9c with SMTP id
 af79cd13be357-93913904373mr529822085a.24.1787902418813; Fri, 28 Aug 2026
 00:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787854085.git.zihanx@nebusec.ai> <a31c6fb1ab9846c85e245fcf34948ac2bc27e521.1787854085.git.zihanx@nebusec.ai>
In-Reply-To: <a31c6fb1ab9846c85e245fcf34948ac2bc27e521.1787854085.git.zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 09:33:27 +0200
X-Gm-Features: AcwNN1Xwt8ZkRbVLESHeyULoFgOkxvi-Dh5BUkpOANwSgHRWFFlEenhIbtckd90
Message-ID: <CANn89i+1xLiL=nZOwoSH+OwX1+8io_Cd2_5b4s-_NcN+kBh+8A@mail.gmail.com>
Subject: Re: [PATCH net 1/1] ipmr: restore a limit for unresolved cache entries
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 8:52=E2=80=AFAM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> Unresolved multicast cache entries retain up to four received skbs while
> waiting for userspace to install an MFC route.  The cache entry count was
> tracked but no longer bounded, so a stream of distinct source and group
> pairs could retain packet memory until the system ran out of memory.
>
> Restore the unresolved-entry limit for both IPv4 and IPv6 multicast
> routing.  Reject new cache entries once the limit is reached while keepin=
g
> existing entries available for normal route resolution.
>
> Fixes: 0079ad8e8dc3 ("ipmr: remove hard code cache_resolve_queue_len limi=
t")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
>  include/linux/mroute_base.h | 3 +++
>  net/ipv4/ipmr.c             | 6 ++++++
>  net/ipv6/ip6mr.c            | 5 +++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
> index 4d55827e9705..af9247bb3f4d 100644
> --- a/include/linux/mroute_base.h
> +++ b/include/linux/mroute_base.h
> @@ -224,6 +224,9 @@ struct mr_table_ops {
>         void *cmparg_any;
>  };
>
> +/* Bound unresolved MFC entries and their queued skbs. */
> +#define MFC_UNRES_QUEUE_LEN_MAX        10

Wasn't this very very very small limit a reported problem in the past?

Nothing will prevent an OOM to happen, even if you set the limit to 1

If panic_on_oom is set, it seems to me that this is working as intended.

If we want to silence the OOM, just change ipmr_cache_alloc_unres()
to add a __GFP_NOWARN?
