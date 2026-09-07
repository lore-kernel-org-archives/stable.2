Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE92479879
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787115; cv=none; b=i0uIVyjq6qGlgBZ8ELERmICQm98+NcZm4vRTKeN4rQUGHIQEVoX2Q9PhszwBdStmXu8bIo2X0lOmTOL4WVyZWgFUq0AttLVvl/e13wAi1l+0vhJQoupeqKkfITUFz9E8auPe6+w4qGAqGIXQ1TJd1gZrEUYtG9uhAdwB19VdLhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787115; c=relaxed/simple;
	bh=ZHT1nwRV+EF2Mm8bVfNXYmPeTXEgGItvBUgZF4Bfnrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkuwqziXIyuOUnn2V9FPvQiwL3n3x3d3y/vLE/qRRdxWNmUvyoGmIe1XHVmGj2iq8vV72HYmpAMo0+DooAYo0NBTvGL4QYi+WEoCp2DzMN81GpfySjqCiAH6MOvZawAjRCPqY0FBAYQJ8EwEBcgEzDWiNfSPw74jJ/rPpyJ1n1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7CNazp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7CNazp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F471F00AC4
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788787112;
	bh=hEWmuW7cufMWV2/b01w8XaTQOw/m9I21NgDQfNHpcUA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y7CNazp9aYy+PdY0qNLl0B7UHZGVyc8NYIl94q4rS75a7fb8BfHqZHqCpHGBY7ozT
	 bpCYs8vIAFiWTPcNj/lChvaKSivlCaFedS6Ze+NtCFryS34HzgcrXFVtO2tOcXATXj
	 aknvYJ11xVYV4y8yNd8VziMCP2T0lBncq/esm+x6+QSPmgy5nksNQSNEfaMp7IoRP9
	 vYRpAABEdC4+WP2xtBFi4jX9ngfv44GbSba9HP9kVPFnxDWZslemR+Fl1L1buFOYDw
	 tuhIDnqUDLUhOdvW78rdgfXZPJD3XBxfgdDBeEEUMsAOf4bwV2JQol8t2DBGFTlthI
	 YPyUwMljIZjdg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a7ea0046deso4404406a12.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 06:18:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwJtVyMaROqgN2Fj/N2H4VAL7I7nXQu2kL3YvfdV1tPOBN5XYDxk3Bc70gw9dpaNXXj2HuyFvM=@vger.kernel.org
X-Gm-Message-State: AFuF++k5hHl381grk15YEi8JeQgwFNRA2aJTfsOgf88PzgXfbLgSOB3d
	j2Tp7JK2z0FmH1kjPc9jncGSD5DieCf8HqXOyvR1Pdpht4mXbG79pNI1jDp3P/NHjlsa6/k1KfY
	KPidv4YzO9C/16LF7SxeYv1KfoKfYc8M=
X-Received: by 2002:a17:907:7294:b0:c26:19de:9139 with SMTP id
 a640c23a62f3a-c2619dea0f1mr784114966b.44.1788787111068; Mon, 07 Sep 2026
 06:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907130821.1726595-1-xialonglong2025@163.com>
In-Reply-To: <20260907130821.1726595-1-xialonglong2025@163.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 7 Sep 2026 06:18:19 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMhs_DQGah6mRfh2=Q_9WU4tm7SsWWGguUt4h7mXiOFRg@mail.gmail.com>
X-Gm-Features: AcwNN1VW7ax0yb2yZAzS8soWDZl4_rah1ysY0avA1R2-TIGVjOCZmj9VVC6GuJ4
Message-ID: <CAO9r8zMhs_DQGah6mRfh2=Q_9WU4tm7SsWWGguUt4h7mXiOFRg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/zswap: publish the initial pool with list_add_rcu()
To: Longlong Xia <xialonglong2025@163.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Longlong Xia <xialonglong@kylinos.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 6:09=E2=80=AFAM Longlong Xia <xialonglong2025@163.co=
m> wrote:
>
> From: Longlong Xia <xialonglong@kylinos.cn>
>
> zswap_setup() publishes the pool on the zswap_pools list with a
> plain list_add(), but the list is walked by concurrent RCU readers
> holding nothing but rcu_read_lock() through zswap_total_pages(), e.g.
> /proc/meminfo and the shrinker count path.
>
>     CPU 0 (writer)                          CPU 1 (reader)
>     --------------                          --------------
>     zswap_pool_create():
>       pool->zs_pool =3D zs_create_pool(); (1)
>     list_add() -> __list_add():
>       WRITE_ONCE(zswap_pools.next,
>           &pool->list);                (2)   zswap_total_pages():
>                                                 pool =3D READ_ONCE(     (=
a)
>                                                     zswap_pools.next);
>                                                 zs_get_total_pages(   (b)
>                                                     pool->zs_pool);
>
> If (2) becomes visible to CPU 1 before (1), CPU 1 finds the pool at
> (a) but dereferences a wild pointer at (b). Publish the node with
> list_add_rcu().
>
> Fixes: 91cdcd8d624bf ("mm: zswap: optimize zswap pool size tracking")
> Cc: stable@vger.kernel.org
> Assisted-by: Zcode:GLM-5.3
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Acked-by: Yosry Ahmed <yosry@kernel.org>

> ---
> Link: https://sashiko.dev/#/patchset/20260906133601.3563324-1-xialonglong=
2025%40163.com

This should probably be:

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260906133601.3563324-1-xialonglong20=
25%40163.com

>
>  mm/zswap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 37f34e406c8e..cb5a0855fd2a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1803,7 +1803,7 @@ static int zswap_setup(void)
>         pool =3D __zswap_pool_create_fallback();
>         if (pool) {
>                 pr_info("loaded using pool %s\n", pool->tfm_name);
> -               list_add(&pool->list, &zswap_pools);
> +               list_add_rcu(&pool->list, &zswap_pools);
>                 zswap_has_pool =3D true;
>                 static_branch_enable(&zswap_ever_enabled);
>         } else {
> --
> 2.43.0
>
