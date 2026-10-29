Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793282317;
	b=jya799OEgbveRQ/c2ZvuTWh4vqiE5Pvju2IFX42nurAiMDeTqygAKXnvTahNnvvzsSxt
	 Wi1A6cojskFg4vSqHtXKUjBN/E4w0vCvFDF0nn70gY28SZir8kdysKZxLw9zx99dYEbSE
	 TdCOUahzMUsO2r+AiXVOJdLkzvE7RNFd1LQB7CzAfTDm6mbxcnZxMIUS8tnFcXwDxxURE
	 ryZ3k1+AjV95vClcGR+dhp1yIIpyllXrMXDA9eO1xsVygL4QVsMOTrse4sa0+GJv2V8U8
	 bHAX70TdsB/PLALA5y3pNzdEzZt5ks+kH/IUyOJo9vynXknkIaIYhQ86jlbEkjpy5JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282317;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TKHPwAz92PdhTqProcfmSePBu6DLZeLwLhVUswgSLow=;
	b=iu7+ptZd3w740/8xZMVOZMyIk3TlxcJJNJhsRAChfj5qBu77Uki2yfePK3XPiuyQQX68
	 xK8E4Mx23XVDyAFoeR03qCFh2SPXNmZM2lNJOaNw0ItkoYVJ2cxPVwThLXNkKx+Q3WrC/
	 KKeNNrARI8p70lzY8uLlMPIXy5yqjZZ+OS13P6Zw0CcUB9vXIUQLT1JQHFrygQ0yiPoMF
	 3QbXA4VOyQuGg6KhydFyFkhyAEsF7F7LPZO/3/fulFJoPwaLeJOsf+IRlwfsujxT4y75l
	 jbboJjVpu/1Wwuhb9GIXGPTwiMXA2GrUAzlUFRx+R9qaHO3MIB8LxKKyD9RrgP5vJyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJT1d2UY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0BA606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 13:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E0BA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJT1d2UY
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afa651700eso3216186a12.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282316; cv=none;
        d=google.com; s=arc-20260327;
        b=GWcxUlodgnlimtZ3DWixkgZ6erkERG+cDbp4vFQMuyw8RDUvP8q0AznoWTgZ0EVaQz
         LZOPobFUaNpHzBA9LtjmlZHhRP/6cyuFKHsFvBBWpKxAhniZWc1i5oeoXD2Gg2wQcdwy
         ExANh55XVPbeQ9XGDZdnDk8LCsQl5ZuFxZCOIxfvzvvcVjJT3i+5O7WgmdIg7t1+D1yw
         3nLt8erwLEvXtC2IxxaFlhB/XzWaYhuP+BEU4K6G8nhUWYpqyZkIRx4tesXR2BrR0k2i
         rvOet6bR42TjKRtIkMkM5aY47qiTKmOxirpN7C4EeghzHfJOtRmCAjpOvdsLJADTKHdI
         BVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TKHPwAz92PdhTqProcfmSePBu6DLZeLwLhVUswgSLow=;
        fh=zZgjTjG4Ct+x36NJpp/4w11qxf/bm1SVx2vmrLVfItM=;
        b=rnAOoDmZBSLjTMTGKgIqjS7tW1PvUGAXX6VNAAFCvdirPFxHyshTa1MrcCgppYZ9T3
         jV59ewyiXSGtZRV3VRk1BTkwmmj2/clmK63CYwJOQZNRt8zHq1FwemU/w+TMN6ER7nTm
         /ww6jwRaWdy0ICYQPc5vbSsIZGsU9rPSRCMSlTF94rf5Gzc1+HXGXf5AhUoLJP/G5O7T
         mVw8lkbugkuHJE+cNTzp3d6B9e5o87tWqREqWmJx6PAuDM0kQGwLRPhLBkIKMx5cLZ5R
         nV/dI5o8d36nVJ4rFTkYn5Gwv7HJwBnBYOpuv64hocu2aimQK7wfw3Lt51d/bnnBEOFR
         9/ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793282316; x=1793887116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TKHPwAz92PdhTqProcfmSePBu6DLZeLwLhVUswgSLow=;
        b=QJT1d2UYEQriYuUW8735rNQI7Kxphg9w4E0o+RGF/kDVGLDQFuU/jYic3i8KCiwg1E
         9CfETBF3zvvJP02YEwh4ijalEzaGBqdm1YheiioDRc4nG90iE9PRzY7MoQ5vWiinolFP
         GQBfPxT7lQTnFE0Q+oMEn5/mUUQvWaIeyUAC1FpKDh9ICBl/KT6q/D5LOoKrKA144n0q
         ujlPp32k8bwbaIBy4xdM+B+fVD8ArY0OYZOaBD0qWZnYG379pS/PeNRbD3P9K0IBYUJS
         S0n7iYugWmlG64W8iEam8AHMRX3i4+geBI3LBQ5JjPWyiDBf1T2Wew7OxtsH4I9+PvWz
         KdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282316; x=1793887116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TKHPwAz92PdhTqProcfmSePBu6DLZeLwLhVUswgSLow=;
        b=GDA+N8NUGPbyR/oCe8wB/k54r9hayayqvjiYc1os+rvfs3p3dIV+j73UFe5Fvv4whk
         Y5iJELKV01GyDzXkftF94nlejpvIyQz/zCf9cEfZqlG2j3PJ4R8M/0Jv/4U/BGg6AIE6
         2Ur+/f++2vikePQyA7qHa9x1jbdj82yIIDkJ/Yh/ya88auNQ7ibe4zGkeEcc7Jxj//g8
         PuzQ8xLrHa0pDMzbFk/jtmz5eX12AZvom8v1qQT1jKWOs4U1Rr/iyRgyMVqsE6i83aWI
         gSMlIJjktd6yv1q2iamX+8N+jUNxo56g3kBIEx/LdNxiqUrM6ngRZ4XBQDAZu3bH7BuT
         ha8w==
X-Forwarded-Encrypted: i=1; AKwUvBwOO4bperBJGd8Pn6SEyiHbyj0MauKtuPcUu0q9dhVuDx8/Ea/4byxK63PGfD/wYvcENB38b3I=@vger.kernel.org
X-Gm-Message-State: AFq9FYITkuRsfH8NhjwAl3s88pzhnjMDGtKq/3ER56cu3DOYNI3JiMyj
	JcbcOb4ypdeXqdR7Q2ffxk/KJP70/3T2oEDvJ/iVfuhp2W/UCvCSMmVykByufp5QSEDZqSCfOrv
	BBCfMkp5D4Hqd8xnUgXpxtBJ+BkWjDqY=
X-Gm-Gg: AYBFou1p02QrYNE6I3rAujU8BXOBZtCunRc5I65ZyEMj9U+Ei4ufnz6xKnnkW5Sv1VA
	iitSwFS+r1XT2CjigyCUQL8CNBr6+EQpZbOrnbNF08fLnY9OvWEzkXSE/0L/iMHH8z7Oo4jS29k
	hB3/4rzaJDpcaij+XlGqLw2e68N9c94tXCAeL9G+oihntKSVvm8RuXmXmbDeDCbwQwAL/W+wUBy
	ol7HjJbTmLcjBVNXq5nlFaJNm6YVGbOrnulPZnf74JrTUf7XdRUUmyCS3SVMOrWGhUOhd7odfzF
	CS7488bsGIOs0BBeCE6/TkB3MaEgPSLBMV7QnDkG4oD5BctIlY0zRmtLm7O4C6WEtcNahzTw5rY
	JBapAl8i/zNLa9xFEVoa/wlzxiv51KwrKaSMRQYR7hu0jD1V1zcdmOg/hnIpvVNxeJoZEpw==
X-Received: by 2002:a17:907:d649:b0:c40:d762:feaf with SMTP id
 a640c23a62f3a-c49bdf380c3mr490800566b.21.1793282315466; Thu, 29 Oct 2026
 06:58:35 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-swapoff-writeok-v1-1-4f4cd420aa33@columbia.edu>
In-Reply-To: <20261026-swapoff-writeok-v1-1-4f4cd420aa33@columbia.edu>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 29 Oct 2026 21:57:58 +0800
X-Gm-Features: AclHuK_WpVrYhoxFjt0fFzoVltcEmX0dIv3cEJlmPJMkDPc9YKVqxhVZUIteE9Q
Message-ID: <CAMgjq7AxShdVC6Ax+5USBSCb3c92MC3UVGLucxN47W_EmVcwDw@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: stop cluster list scans once swapoff clears SWP_WRITEOK
To: mt4022@columbia.edu
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 11:21=E2=80=AFPM Mani Tofigh via B4 Relay
<devnull+mt4022.columbia.edu@kernel.org> wrote:
>
> From: Mani Tofigh <mt4022@columbia.edu>
>
> SWP_WRITEOK is cleared under si->lock when swapoff starts so that no
> new swap entries are allocated from the device, and try_to_unuse()
> then waits for writeback of the folios that still use the device.
>
> However, an order-0 allocation that chose the device can race with
> swapoff clearing the flag and then loop forever.  It takes a cluster
> from the fragment cluster list of a higher order with
> isolate_lock_cluster(), the allocation from that cluster fails because
> SWP_WRITEOK is clear, and relocate_cluster() puts the cluster back on
> the same list, so the loop keeps finding clusters on it.
>
> The looping task is in reclaim, and it may have set writeback on a
> folio whose write has been queued but not yet submitted.  swapoff then
> waits for that folio, while the reclaiming task, stuck in the loop,
> never reaches the point where it submits the write:
>
>   CPU0 (reclaim)                          CPU1 (swapoff)
>   --------------                          --------------
>   shrink_folio_list()
>     pageout(F)
>       /* F under writeback,
>          write not submitted */
>     folio_alloc_swap(G)  /* order 0 */
>       swap_alloc_slow()
>                                           del_from_avail_list(si, true)
>                                             si->flags &=3D ~SWP_WRITEOK
>                                           try_to_unuse()
>                                             folio_wait_writeback(F)
>         cluster_alloc_swap_entry()
>           isolate_lock_cluster()
>           /* allocation fails:
>              !SWP_WRITEOK */
>           relocate_cluster()
>           /* repeats forever */
>     swap_write_submit()
>     /* never reached */
>
> This results in a soft lockup on CPU0 and a swapoff that never returns.
>
> isolate_lock_cluster() used to check SWP_WRITEOK under si->lock until
> commit 07adc4cf1ecd ("mm, swap: implement dynamic allocation of swap
> table") removed that check.  Restore the check.  Since swapoff clears
> the flag under the same lock, isolate_lock_cluster() then returns NULL,
> which ends the scan; the swap slot allocation for G fails, and reclaim
> goes on to submit the write of F.
>
> Given that this is a race, its reproducibility is non-deterministic.
> We reproduce it by using a non-rotational swap device that is not
> synchronous, with 64K mTHP enabled, where one CPU repeatedly pages out
> two 64K folios and a 4K page with madvise(MADV_PAGEOUT), while other
> CPUs run swapoff and swapon on the same device.  In my tests it
> triggers within 20s in each run, and with the fix applied, it runs for
> 300s without any hang/kernel report.  This bug was found and
> reproduced deterministically using a deterministic hypervisor that is
> currently under development.
>
> Fixes: 07adc4cf1ecd ("mm, swap: implement dynamic allocation of swap tabl=
e")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
> ---
> Before commit dda8fb68b590 ("mm/swap: also use struct swap_iocb for
> block I/O"), reclaim submitted the swap write right away, so on 6.18
> to 7.2 the loop most likely ends once swapoff frees the slots instead
> of hanging.
>
> Reproducer: https://github.com/manitofigh/swapoff-repro/blob/main/swapoff=
.c
> ---
>  mm/swapfile.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 601979b97f95..2b03d14b5f52 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -627,6 +627,10 @@ static struct swap_cluster_info *isolate_lock_cluste=
r(
>         u8 flags =3D CLUSTER_FLAG_NONE;
>
>         spin_lock(&si->lock);
> +
> +       if (unlikely(!(si->flags & SWP_WRITEOK)))
> +               goto out;

Nice catch!

>         list_for_each_entry(ci, list, list) {
>                 if (!spin_trylock(&ci->lock))
>                         continue;
> @@ -642,6 +646,7 @@ static struct swap_cluster_info *isolate_lock_cluster=
(
>                 found =3D ci;
>                 break;
>         }
> +out:
>         spin_unlock(&si->lock);
>
>         /* Cluster's table is freed when and only when it's on the free l=
ist. */

Acked-by: Kairui Song <kasong@tencent.com>
