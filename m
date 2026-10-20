Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511879;
	b=AXq3G2SX0GVEq6NLJpW/eS2G6e1aTB/wDSWH8uiuGK81fDX35h+hsYQwUQRx7EYfTOkr
	 Usa2cipn6BKvwl9hO+jdprDISF7uNRVh3DgyFvkQEKhgHYtnDBhmFyqK76ZU8fqNPDIaL
	 FgUYV2J6mJWM/xXHsKGFXmg2VMqEbgQI1aKB0nLqZ6qdThoNeN6yndr9c9CnCkwr6TL56
	 BGxywMzoib+7lSGljLALCJPnqs1KsQR3KYsa9ESKN51U2PGOIVkZUWrUBLvw+l5Fjldr0
	 iis6P4JVNRquFKoVkzVhoOSKZ4nPsGl+Ha0DmA+DvYBSGUvyDPHxlaVcKGy8Lt2IFzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511879;
	h=Received:Received:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2o93XxMYB/n87rEXmmkyQV39aYB1EujyaYhqwJ1Wo0w=;
	b=lAMJU6jlvT3k1yfp9LOS7BgXDC1EEvYMB7epSKU04l9l0uTI9MFYd1UTpAoA0BiEQSZ7
	 0bMEiSNDecMiD9jnaTJP3IDP8lQWyZQt9FwTihkGLtci1wbj7DBqyrN6vz9LQwEzXAv9S
	 a6B0CVnCv8RqZHtJdueSeCClQ47BF+ALxDWt8mVFFggDxGcy8+Ox1V1MvXTYpd5x56WTa
	 55Rpz1mduc8+jztZj+n+BrbTqACkTsDxOaUl9rxS5m6K1I3Yxd1L2YeVo2iWw28SmrDn4
	 bMKH+jfrRz1lC21EGCKvMGRIDn5/ozD3cxXSRzT3rojf9LrD3SNdmLXOwNEhD2jrEsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C4606A319
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7828F1F000C8
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:57:58 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b3f7763d88so618571a12.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:57:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzMDUnTbBG8tBWbHujM3W3+9qlhpzjBDSsy5Y/qBgkhwItc7Mrg+AhcHbEIvV22Gp5B4LE7/yE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8Dz82eJYvYWQxXqymQR2kn9xpBheCea5vkvA+acvI0PMl0Vut
	kTxsMWA312CrNFO7UI83E6K1OaPjqf2YTuPv4g/9wRPmoZdyLRUDSL2CpH5UJK2cojxPIoVcy4r
	2GkEleKB+WCNUjuyP5dy7trwGSsCDDyM=
X-Received: by 2002:a17:907:930e:b0:c40:f296:4d43 with SMTP id
 a640c23a62f3a-c4199970845mr803586666b.3.1792511847509; Tue, 20 Oct 2026
 08:57:27 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020122942.3477541-1-hwenwur@gmail.com>
In-Reply-To: <20261020122942.3477541-1-hwenwur@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 20 Oct 2026 08:57:15 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNgnt=9UXN_FJ3zByVtC18MNe94-tXssAS-eAQfutNXRQ@mail.gmail.com>
X-Gm-Features: AclHuK_EDOXSgUtKkVYdbD02JtxAHuI_On9M20AyiaPbLRXhfIG1wXrQNdG4FME
Message-ID: <CAO9r8zNgnt=9UXN_FJ3zByVtC18MNe94-tXssAS-eAQfutNXRQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: set zswap_ever_enabled when enabling zswap at runtime
To: Wenwu Hou <hwenwur@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 5:30=E2=80=AFAM Wenwu Hou <hwenwur@gmail.com> wrote=
:
>
> zswap can end up enabled without zswap_ever_enabled being set, which
> leads to data corruption. With CONFIG_ZSWAP_DEFAULT_ON=3Dn:
>
> 1. zswap_setup() fails to create the initial pool. Setup still counts
>    as successful, but zswap_has_pool stays false.
> 2. The user writes a compressor name to
>    /sys/module/zswap/parameters/compressor.
>    zswap_compressor_param_set() creates a pool and sets
>    zswap_has_pool =3D true, but never enables the zswap_ever_enabled
>    static key.
> 3. The user runs "echo Y > /sys/module/zswap/parameters/enabled".
> 4. zswap_store() now stores pages in zswap, and swap_writeout() skips
>    writing them to the swap device.
> 5. On swap-in, zswap_load() first checks zswap_never_enabled(). It
>    returns true, so zswap_load() reports that the page is not in zswap.
>    The page is then read from the swap device, which holds stale data.
>
> Fix this by enabling zswap_ever_enabled in zswap_enabled_param_set()
> before zswap_enabled becomes true.

Wasn't this fixed by
https://lore.kernel.org/linux-mm/20260906133601.3563324-1-xialonglong2025@1=
63.com/?

>
> Fixes: 2d4d2b1cfb85 ("mm: zswap: add zswap_never_enabled()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenwu Hou <hwenwur@gmail.com>
> ---
>  mm/zswap.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 37f34e406c8e3..d2b4c248baa67 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -629,12 +629,29 @@ static int zswap_enabled_param_set(const char *val,
>                 if (zswap_setup())
>                         break;
>                 fallthrough;
> -       case ZSWAP_INIT_SUCCEED:
> -               if (!zswap_has_pool)
> +       case ZSWAP_INIT_SUCCEED: {
> +               bool enable;
> +
> +               if (!zswap_has_pool) {
>                         pr_err("can't enable, no pool configured\n");
> -               else
> -                       ret =3D param_set_bool(val, kp);
> +                       break;
> +               }
> +
> +               /*
> +                * The initial pool may have been created later by the
> +                * compressor param rather than by zswap_setup(), in whic=
h
> +                * case zswap_ever_enabled is still off. Flip it before
> +                * zswap_enabled becomes visible to zswap_store(), otherw=
ise
> +                * zswap_load() would skip stored entries and read stale =
data
> +                * from the backing swap device. param_set_bool() treats =
a
> +                * NULL value as true.
> +                */
> +               if (!val || (!kstrtobool(val, &enable) && enable))
> +                       static_branch_enable(&zswap_ever_enabled);
> +
> +               ret =3D param_set_bool(val, kp);
>                 break;
> +       }
>         case ZSWAP_INIT_FAILED:
>                 pr_err("can't enable, initialization failed\n");
>         }
> --
> 2.43.0
>
