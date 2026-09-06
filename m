Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE42361DA9
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788702207; cv=none; b=MAu3GYAFQvzT1GSfl2t0Vqj+uq86Ha7xsva6IaXHMdxIsLX1Jw+ejAtLnbxugRQF4yJRjjzGuTZ5y5YNHV73/dmGlWPDla9wp3Uowd4EyUzyP4bRiT3aivQZFVpvx/qWhNfu6kp+XcWBzLo79/p6P+v//t/iBivzYVMNPkP1MKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788702207; c=relaxed/simple;
	bh=i1U3f2OULVvaptf5UmZ/mMQwfAOg8c/J9E1inAU81Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQzDfnRkgRPPzAYLPdF/28FNkv7GXyYKChuE0+a+lIK/5kngxtktysPznW6m+Tz1tiR1+RfOcbUFLfLOHfzWIZlDLpR3SzD5XNYvd0CBucED6WfR8XOYQPJpAoRLHWVmWMlKQ0ZkPD0Asc9Qacg+qM5AkB9ppHB3bKOoncJ5O9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQxHKE3i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQxHKE3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C663F1F00A3F
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788702205;
	bh=MJrULltJVytx/1A1hejUzTPGkBOyVLht9YAT4kHHTx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TQxHKE3i9E/GWqhHOPvxJQw220UgQ+1dY6wzMTZSt9SLqyAG3mm/t2zY2yS1WvwGd
	 4f9mPNFRwaLRkGxXK8QTvel35dVyhFegVy3wjuDlhejJUx2eoKBu3id4dRoxRoyvDd
	 893flws+xZh9VhudJmqsPRjVXWuv2c3kUzitQ6+WeRmqMriAFgTeKNFM+R4vUwXl1o
	 tLYSK0pEZJmv2UTleiJC56FeWWdhjvdFX7U9S3XSiKTJTxi+XE/271SsjmZo8hf2oZ
	 MNmEh29cdy0NlEkxONYSmNSosN2xCijajQK+ZYEAqwV0vn3MwlU+1wPHFBYoMxwz3e
	 +mbDWyMRjePLA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2533d83e3bso422672566b.2
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 06:43:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwE8w9RXCe5HY7x2Cy7QeJoMttjeQVglBL9Gla1psP0ph9nhhRYCtaLkyK0pETDPDWNHSEu1rs=@vger.kernel.org
X-Gm-Message-State: AFuF++nOSYz4JiSLWC7TBumbgyPzMtLd/zwSwvxcgIlG28k4yRWEjxph
	cMj/PUtwvkW+xiIFkfMUoKetAtkUcN0Kw5MZkmgqd5YxfwRFIkhgYkt4CH4deSd29gLrHUNFiRV
	5mrCss+Pvv5asqcDJ7gLUlgqXdoW2ZHc=
X-Received: by 2002:a17:907:3f93:b0:c25:4f7c:8ec5 with SMTP id
 a640c23a62f3a-c260cd4dab0mr1142344866b.23.1788702204625; Sun, 06 Sep 2026
 06:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zPC4v_S80Gn5M7iiAujebP9QHdRur9fL1ECh8ZDxOov7Q@mail.gmail.com>
 <20260906133601.3563324-1-xialonglong2025@163.com>
In-Reply-To: <20260906133601.3563324-1-xialonglong2025@163.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Sun, 6 Sep 2026 06:43:13 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNPckJzpC2ecOew1B=MNbFSMsUpmHgVu=_D_+osFFVFSQ@mail.gmail.com>
X-Gm-Features: AcwNN1XXId-nItsS1kCZPEhUVKzt7OsFcHZczRETRWL-U_2270jVLl9hSByTuos
Message-ID: <CAO9r8zNPckJzpC2ecOew1B=MNbFSMsUpmHgVu=_D_+osFFVFSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/zswap: enable zswap_ever_enabled in zswap_pool_create()
To: Longlong Xia <xialonglong2025@163.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	stable@vger.kernel.org, xialonglong@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 6:37=E2=80=AFAM Longlong Xia <xialonglong2025@163.co=
m> wrote:
>
> From: Longlong Xia <xialonglong@kylinos.cn>
>
> If zswap is enabled by default at boot and pool creation fails, then a
> pool is later created by updating the compressor, data written to
> zswap is corrupted on swapin.
>
> Enable the static key in zswap_pool_create(), covering boot-time and
> runtime pool creation with a single site.
>
> Verified with fault injection on a stock kernel (compressor builtin,
> CONFIG_ZSWAP_DEFAULT_ON=3Dn):
>
>   1. Boot with zswap.enabled=3D1; pool creation fails, init completes
>      pool-less (static key off).
>   2. Echo an available compressor name to zswap.compressor.
>   3. Enable zswap.
>   4. madvise(MADV_PAGEOUT) a pattern-verified 512 MiB region, then
>      fault it back in and verify.
>
> Step 4 reads back 131072/131072 zeroed pages (zswpin=3D0, zswpout=3D13107=
2)
> without this patch; all pages intact (zswpin=3D131072) with it.
>
> Fixes: 2d4d2b1cfb85 ("mm: zswap: add zswap_never_enabled()")
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Cc: stable@vger.kernel.org
> Assisted-by: Zcode:GLM-5.3
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
> ---
> Changes in v2:
> - Enable the static key in zswap_pool_create() instead of adding a
>   second site next to the compressor parameter update, as suggested
>   by Yosry; boot-time and runtime pool creation are now covered by a
>   single site, and the zswap_setup() site is gone.
> - Use the high-level description from Yosry's reply to Andrew for the
>   corruption scenario, and rename the subject accordingly.
>
> Link: https://lore.kernel.org/r/20260905125101.2970456-1-xialonglong2025@=
163.com
>
>  mm/zswap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 37f34e406c8e3..6dfb6ae709e97 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -324,6 +324,9 @@ static struct zswap_pool *zswap_pool_create(char *com=
pressor)
>
>         zswap_pool_debug("created", pool);
>
> +       /* Enable the key here so every pool creation path is covered. */
> +       static_branch_enable(&zswap_ever_enabled);

I would drop the comment, otherwise LGTM:

Acked-by: Yosry Ahmed <yosry@kernel.org>

> +
>         return pool;
>
>  ref_fail:
> @@ -1805,7 +1808,6 @@ static int zswap_setup(void)
>                 pr_info("loaded using pool %s\n", pool->tfm_name);
>                 list_add(&pool->list, &zswap_pools);
>                 zswap_has_pool =3D true;
> -               static_branch_enable(&zswap_ever_enabled);
>         } else {
>                 pr_err("pool creation failed\n");
>                 zswap_enabled =3D false;
> --
> 2.43.0
>
