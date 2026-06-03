Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42D3D75A5
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454538; cv=pass; b=Jd5JJ0AAFZgq9rA3SCvvmRxP5RIIx09i1HwgGXiXOicqjTVctlEzB3QGqOnyRFZKrOpR+j6Ke4Hj3dfE8WRCdB7YFN1ZF5LV6MnPb2zLQbUYtEFW/nuj2YmB6YZXZFbRCuxMNpVl6oKX1bcoEg5KELNR8AiLzS6+ZnUF+SFz5sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454538; c=relaxed/simple;
	bh=ihFZZuCs7IODZ8u55MXd8Ulki5C9zpanTBs91LETwvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpQWt5N/tLY+Axm3pPDIuMvEzJOG3vWqYW+ow+CmyveGaWMPt0rZckeFikwBk+rmqhoN2WMqPCk15+IuC+4xxVyTq46kAsgbTJRzKssrA+bcrXR1D/DI6825O2l32aDIrIvkZz+crkwtzxmL9pBGQ2vs2y6BvqZk+8PxRApG8Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciewMRTW; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciewMRTW"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so544315966b.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 19:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780454535; cv=none;
        d=google.com; s=arc-20240605;
        b=Pq2X5TQfXHirZ+lxAK8HxGRSTqYzqoQox96aUIqBOjXRfLneHEqpJ2F1L8zXy6C1rj
         uGI5tB9ToZuoq/PgyRiQH30I1k3vEBNKTL9M76/b+/fk9S4s77y5Y9rm3GeWTAa00OhF
         blnyQj5HIYNN8gEMFwdObWFlQh97z8IDpUPai7VnPPu7l+j8XZuzXwzGMZ4YsdsX9QA3
         KW3pLH5YbpexB4GsWRZQEE953Oyl3kZ32IUGdzEMuDjxN2LnFpvNFiqqKQ7/i/45eDzj
         8sgfxyVhUrEeD4e3MBYqOGSpZIURyWK9jzgo75Nze87fTY6qt+gbMfs5Yyz25KbP5bxj
         AhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dRTVSL2FYqphxoCdU85m6PQz9L0mnepXYX/edVhZi6U=;
        fh=z2+amGfiuqZpDLsmX8QthwC+Ouds4xs1wfUX+ZOqbI8=;
        b=a+tuvD4ibGWiuC4V+H4CvL5hlLEeZ30w2G49g5i0bgI01oIMCXyJd7nOW7+JhuIl7+
         5KvjeQZqkWBMqIxyUzaBbMeE93jA4/av48yjOkhUxEeCyq2ugUREVmDd5VUs/S2Qfrb/
         mCcgqGUhCRyyrgcmIbbPYUeuYHsuBYDpujJGfsJc9NYBR+MnIrfAblYuxE/cutYi92b5
         RPHYJTLDCVanOyrUylhjVIu6XLp3qoY76X8aWck/q3ImU2sHevnMukLpz6uWKfJ34rPk
         y7z2J41MLiVRkj1w86LOotSZpKNWaONtBQBhgezNp7Y+Il94GfdLChc+STqwST7FPLNu
         lLhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780454535; x=1781059335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRTVSL2FYqphxoCdU85m6PQz9L0mnepXYX/edVhZi6U=;
        b=ciewMRTWsPj3fb5tkHAHYhui8RALxrpjP3/7vi9R9PofuY1hr/evCBh0DyNUGP74hL
         jdgmeSxuh13ZltfoyoOySquDigrCnfTsTgx0LGLuDmV499fH//83RERnE8SRzA6jmY0Z
         vS8P5pUgd1DdB1r/fUzQMPiDA+wlde3+VMKUNrdYY2wUzSXF/6kQMv1J77vb5J5PTaor
         VIbqLW3cSTo8+ckwc1qv64AEfbgfPkaN3JUDFFZSk82QcJthua9FT1Ff3wIb9w1Eb37+
         jprgGMDL29v47tvaY46YiggnxpYM0u/4xf4Imw78oXS1lGozDZ9iBz5ZQDiM6xGv3EAs
         5eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780454535; x=1781059335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dRTVSL2FYqphxoCdU85m6PQz9L0mnepXYX/edVhZi6U=;
        b=NVPaFuNMPPaJlHV0y82QodfmKN9ObFWhPIcRPLHeMsC4ykyZUIPBCo04T+rr4J9q5A
         cWlFzpUw3flTTIO7Ex6n2i1N48vpJtTIRj29f23jZiD6C1XPzNCvGsAdOTmx4vEyh1z+
         R6S1Z929ngS2VOh2tJMg0A5CPgeN/VkDmyIY9IRM+qsQ63pNN951biIvinLdn9+v/CUl
         EehBMpH3lVGsSeFmc+OJTUHQWJ72TqE+RuX0Apq6m7hb2YGq/J0xOTpvMZwBzaF5ufgg
         MbCx9FgP853+zshacm7rH9+q2J6QZHh2JbkM7A6A3quVP9lDE+AxIcZfNhi49Ziq+ykp
         tvlA==
X-Forwarded-Encrypted: i=1; AFNElJ8avw+5FYtnE7QxglZI8kHiV5HRE5tDGsH7E+JcOs/G3BvzJ3Vc0F+QDSbVvQuolH2xxOP9tHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCNL274hdlbTsf6OJe1hPx4vpl++yc1KZ6UONCIOWogQBBpjT
	o2AJ5E1Ry6qVUC5xR2ylbBiFEPKnR4wSLFW4n/MQn1chufWgsYZrAMyZtoETjOnGtN9pitv1nAg
	H0cwaE+F2CyOeMBNdIm/4a3xoVjAZRC8=
X-Gm-Gg: Acq92OEELmO5fEfSr1egDvZ9zHS4F97xJFycFh7bCuV8HCKsmYgXqmh1GhG2SWruXc8
	0nLRPqxYMuzox5Lpp2y/mTg6iGECFpDFQYNN4tbHopvJ+Bz54IuN2WiXkdC00Eg+PZ5ojV15weB
	FCcTEfpFRXh7KVXQv6sZXaYRF+Xqlbtn4o6kZyCIUdv+Q7BWzB0Y8d0czl1t3LyI11tpB5qRJWr
	0kjKOkf8NQOCYD5Ay+vJmmainsYagTgNrzPQeQx22i9C6Ka7DEDtQL2EpNZXsGtKVwAGaggpTpf
	rXYwcz8f3VFcXwUqfG/1Cq1jSax2BubUy9wkUvFx//f6h6O8bfpG/WQr4Rgc
X-Received: by 2002:a17:906:6a11:b0:bec:4906:44d6 with SMTP id
 a640c23a62f3a-bf0b10d7768mr46147766b.11.1780454534926; Tue, 02 Jun 2026
 19:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602222358.49061-1-devnexen@gmail.com>
In-Reply-To: <20260602222358.49061-1-devnexen@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 3 Jun 2026 10:41:37 +0800
X-Gm-Features: AVHnY4JDQDFGMk0a76EICNZZMssNiBFMqpzLzNdJeFfcsLQfcgQ8GLAQzkv6TUQ
Message-ID: <CAMgjq7B5sSjJPG7bMyEf0=c-W9heiPL6SQsedicyp8ahXWrYPA@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: free the cluster extend table on teardown
To: David Carlier <devnexen@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+deedf22929084640666f@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 6:27=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> swap_cluster_free_table() frees every per-cluster side table but
> ci->extend_table. That table is only released by
> swap_extend_table_try_free(), which the teardown path never calls, so a
> cluster can be freed with an extend table still attached.
>
> It can also linger while the cluster is live. swap_dup_entries_cluster()
> drops the lock to allocate an extend table when a slot reaches
> SWP_TB_COUNT_MAX - 1, then retries. If the count dropped in the meantime,
> the retry takes the normal path and leaves the table behind, all entries
> zero; only the failure path frees it.
>
> Since a swap_cluster_info is reused in place and swap_extend_table_alloc(=
)
> skips allocation when ci->extend_table is set, the next user of the
> cluster inherits the stale table and its leftover counts, corrupting the
> swap count of any slot that overflows. CONFIG_DEBUG_VM catches the

There won't be a corruption, extend_table is all zero at this point,
the leak on swapoff is real though.

> dangling table in swap_cluster_assert_empty(); otherwise it is silent.
>
> Free it in swap_cluster_free_table(), and also on the
> swap_dup_entries_cluster() success path to match the failure path.
>
> Reported-by: syzbot+deedf22929084640666f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ddeedf22929084640666f
> Fixes: 0d6af9bcf383 ("mm, swap: use the swap table to track the swap coun=
t")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  mm/swapfile.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 615d90867111..a69a26aec4c0 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -432,6 +432,9 @@ static void swap_cluster_free_table(struct swap_clust=
er_info *ci)
>         ci->zero_bitmap =3D NULL;
>  #endif
>
> +       kfree(ci->extend_table);
> +       ci->extend_table =3D NULL;
> +

Still a bit too late to avoid the WARN? The WARN is already triggered
at this point, swap_cluster_free_table is called after
swap_cluster_assert_empty.

>         table =3D (struct swap_table *)rcu_access_pointer(ci->table);
>         if (!table)
>                 return;
> @@ -1711,6 +1714,7 @@ static int swap_dup_entries_cluster(struct swap_inf=
o_struct *si,
>                         goto failed;
>                 }
>         } while (++ci_off < ci_end);
> +       swap_extend_table_try_free(ci);
>         swap_cluster_unlock(ci);
>         return 0;
>  failed:
> --
> 2.53.0

I think we have already fixed this?
https://lore.kernel.org/all/6a1eac8e.fbc46276.3c3783.0008.GAE@google.com/T/
