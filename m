Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E915369D42
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127067; cv=pass; b=ngdSaUDW5lLJW2AaOFTjAv8hTph07kQpFTnNeQ2zPbmZN/KURgCMp2TRJU09tYQHadUBCLFar6svck1kw8czZX8/8YngMZEUK33GDbPJV/PCok1AG0S/3aNEyI5ZozzU2nTjLYIrx8tJ5gLwzh+d4Da3O51XIpoxIYiEkGI/TeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127067; c=relaxed/simple;
	bh=UADlG41M5thctfgmS6ugHJOYzI+CaH8VYjB2Qk3aRNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOB2Q3JYm1L5HSUvuiwWV6F4nkXyeMDJRfp6VyCl3KPcC62dXAQ6dtsrXL9wObjaw6QhZxT4kf5cRPMKLWqMhYU+b3oyMv4/KbA0b1EkAVRdGz7W4TLOM2pl3DLKQ24E22rF/ljks1Bry1J9anLUn/0jdXtRkX6pBfJB9gYRhWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFuwcDxB; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFuwcDxB"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69fdfd98eb8so484711a12.0
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 11:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786127063; cv=none;
        d=google.com; s=arc-20260327;
        b=aXhBbvNt1N8b8eEUbmeaLDVvm8eCX2t7Elc2SFvs968Czf+X62ToxaL1WO8Q8SfmHN
         1va2qk70OFVBDKfgMD0Q5dpcTw7PuRyCSUSZVuwSd1q6hs5iV4mtY3VIzngwzo1nY9VD
         /wIW6gte/1UlHrJBGGW9zn7SqL5oRdhGlbK42NERDWzBheSdYzP6VMKKkAtJ4mA8dcXr
         ZKnbtYGqorF/CRB460OXGHAJiOfnqJl2REE9KcI9gpwxKbBS66T+jASo9jLKKgRwXgn+
         Ou3+I3C1wZ7YVrZWGIggWhY7+AcyZr6gWexYqWERvRiD85nIjEV3WhuZ9AORvk9aA4nb
         sxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUwOEzdPWu8zymOmaEkTRLskubFdeih2HqEaKUwkN9U=;
        fh=paD5URV8JXS2klpSatJgpbtBfAY3znDxIoYqQxiA9oE=;
        b=gN6RnF0+HBsLUDTiFCZ48n0OflgZbpKju4ol3BCqYpsxsVchcVywLfd241Nxxs+xQM
         QBdGc4GTjI21l/JchJOkXisQCWk85IshQbSsKS4LxtK03dN6r/dn7DXWtAtTme/98kA9
         ALNl7tYMkzmgFdU0YwBofZPP7nCDE1Tl0fQkpxYSZwsvpcxtsIKHZCMix05J+YFBSbYl
         a9EqDODAbT8jBYHv6VwqBOX5NXxwiSvML/RQIt1eX0UGjLO6fyxedGyiezgDfuI9BLVn
         IiiTMSYSTZmisx7KbBXe6OrApiW9wAI42n/f+/mCrYNV6EEUXlOFFEcGbFV/YjHJpU41
         35wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786127063; x=1786731863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dUwOEzdPWu8zymOmaEkTRLskubFdeih2HqEaKUwkN9U=;
        b=QFuwcDxBiiK9+rEFH6Ixe9sEfBT93KPwRcETWINbwg5m/z5fwisBzT0fcyl4qxnnwC
         8aQ+tX2udbRy2yPW1FPdNtVg1k//EAxAebjxrrUceMSZ6zNIMdy/iDsHmC1iSocHi+wS
         7trGtZ1JtNjjcGvupaOgcOYM9hy+ePvdsZijyM0Bu93hbPkDO+mY5LwUdF+MJ5y9Kmtx
         dNmMs5GlasUnnncGZs09Nv8eus+Uf9qbJ9cT9RJDjOy/oHOSOw7oehN7SncLP1XDcgsO
         P2eGC9KVC9VtXQacDODyoCbiL7hoijDuvTD+RjGtJEW4k1SMAb3asl+bke654u3VWnQv
         lvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786127063; x=1786731863;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUwOEzdPWu8zymOmaEkTRLskubFdeih2HqEaKUwkN9U=;
        b=svJdvvrsXSDVQgpNfTR2Zs5OIP+go/hC12hvpOJjv5VP9/9VpqOxS1K61Vkw9XAPlW
         qeY3ZIktgg4fXnQ0ZeUsL1UKha5hk3RkgtveQP40H7leURfnhwrH80IeJz2dX5I0r/xr
         AjW1WbFTtoUxC87c8ggAkvUBvEqwrNI11gykH8u05AqW0XCLyZ2B7or2HhvHVAN2jpYC
         meCtgFf9eSi4gnGV1g+zHmPr2FFpkOz9qRp/1YWkhAf1jSbTve4LFbzo9h9mrDKxbyUy
         0STQi5arhDhVJXN1a2XHI3iW3yK/MVZyYYsM19X7rQ4i6NOsHa4oWmTvEBRNBlFryxXY
         Vanw==
X-Forwarded-Encrypted: i=1; AHgh+RrBs2uNfZcM8c97okCSEFACbBwBJpo58Oeput8t1M/dBjKYQnfoL2Qnm/TIVU6WXVHaWMb19zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtAPdxJf2yt90btOCQL+dEmfI7Ex/UgonJlZOW7LqloyFFVRr
	k4Qz+JpeYjtJn7tgL0jx8yqfROTe0Xk9qcmrvrOQSO21kOWGrnvv6aO065E6N8WSSRvJqrv9qta
	QPLoWoOnoN73uLvk+YvYGXLVY6o3AL/A=
X-Gm-Gg: AR+sD11D2pdFtlEdmrYIhPEe3PN+xgqrezkvlJE3+VfURw49lvxlr4wapbPqjWKeFat
	CLoU6cFJslhZN6ztU/uzUuMSluv0lqtP9VrP/U1JBBFDdA9Up0FiXZFqfByqkImqM1+UMPT4/BD
	Q1ZXiTr2fhN9bf/pDkqGIEzXCS/gQ01eKzJ+B2L6i1RZ58SGLgsOQ5+FKG0N59Ciy9Y85eZ3zrt
	ePLFZzywU5RywfGk1hdeGx9SAFo2rm08EffcJXX0+FKvQ1wuUrR8a4bQESgZdtgHgHYZyLKd/yG
	zxHRYh68ocPFiFIvfRganm/F1/o0eExVjfMxq+ghJ5fqF6b23Jj0cnmdKYGX2qkIko8DpmZKLQ=
	=
X-Received: by 2002:a05:6402:3506:b0:6a0:f1f9:e026 with SMTP id
 4fb4d7f45d1cf-6a14f2a66a8mr6336836a12.4.1786127063387; Fri, 07 Aug 2026
 11:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806133309.731709-1-nicoyip.dev@gmail.com> <20260806144225.GA1940054@shredder>
In-Reply-To: <20260806144225.GA1940054@shredder>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 8 Aug 2026 02:24:10 +0800
X-Gm-Features: AUfX_mwI3opsf-KUy5fEjZu1-_oNK5jjwxAyCm7penD7Up_h_DON19HI2hd2OA8
Message-ID: <CAAo+4rUVQkHhKupHOx-x4dq+qxkeeqs+nS=OK0pELZVzgeWTgw@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv4: fix use-after-free in fib_nhc_update_mtu()
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Ido,

No problem, the patch looks really good, and I just posted it as v3
with a few minor comment wording changes. Thanks again for your
detailed reply.
https://lore.kernel.org/netdev/20260807181710.1178747-1-nicoyip.dev@gmail.c=
om/T/#u

Best regards,
Chengfeng

On Thu, Aug 6, 2026 at 10:42=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Thu, Aug 06, 2026 at 09:33:09PM +0800, Chengfeng Ye wrote:
> > fib_nhc_update_mtu() walks the nexthop exception table under RTNL, but
> > RTNL does not serialize this walk with PMTU exception updates. The walk
> > uses rcu_dereference_protected() with a constant true condition without
> > holding fnhe_lock.
> >
> > The following interleaving can therefore occur:
> >
> >   CPU 0                              CPU 1
> >   fib_nhc_update_mtu()               update_or_create_fnhe()
> >     load fnhe                          spin_lock_bh(&fnhe_lock)
> >                                        fnhe_remove_oldest()
> >                                          unlink fnhe
> >                                          kfree_rcu(fnhe, rcu)
> >     <quiescent state>
> >     access fnhe after grace period
>
> [...]
>
> > The same walk updates fnhe_pmtu and fnhe_mtu_locked. These fields form =
a
> > pair and other writers serialize them with fnhe_lock. RCU alone would
> > prevent reclamation, but would still allow concurrent writers to leave =
a
> > mixed pair.
> >
> > Expose fnhe_lock to fib_semantics.c and hold it across the exception-ta=
ble
> > walk. This prevents entries from being unlinked while they are visited =
and
> > serializes the paired PMTU state updates with all other writers.
>
> Looks correct, but can't we use RCU for the traversal and only acquire
> the global lock when updating an entry? Otherwise, whenever a device MTU
> changes, we acquire the global lock (and disable softIRQs) across a scan
> of 2048 buckets and we do that for each nexthop using this device.
>
> How about something like [1] (vibe coded, compile-tested only)?
>
> It also avoids exporting the global lock.
>
> Please wait at least 24h before posting v3.
>
> Thanks
>
> [1]
> diff --git a/include/net/route.h b/include/net/route.h
> index f90106f383c5..45290177a33c 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -276,6 +276,8 @@ int fib_dump_info_fnhe(struct sk_buff *skb, struct ne=
tlink_callback *cb,
>                        u32 table_id, struct fib_info *fi,
>                        int *fa_index, int fa_start, unsigned int flags);
>
> +void fnhe_update_pmtu(struct fib_nh_exception *fnhe, u32 new, u32 orig);
> +
>  static inline void ip_rt_put(struct rtable *rt)
>  {
>         /* dst_release() accepts a NULL parameter.
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 4f3c0740dde9..61286948c5d9 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -1864,42 +1864,30 @@ static int call_fib_nh_notifiers(struct fib_nh *n=
h,
>         return NOTIFY_DONE;
>  }
>
> -/* Update the PMTU of exceptions when:
> - * - the new MTU of the first hop becomes smaller than the PMTU
> - * - the old MTU was the same as the PMTU, and it limited discovery of
> - *   larger MTUs on the path. With that limit raised, we can now
> - *   discover larger MTUs
> - * A special case is locked exceptions, for which the PMTU is smaller
> - * than the minimal accepted PMTU:
> - * - if the new MTU is greater than the PMTU, don't make any change
> - * - otherwise, unlock and set PMTU
> +/* Walk the exceptions of a nexthop after its first hop MTU changed.  Th=
e
> + * chain is only RCU protected here, fnhe_update_pmtu() takes fnhe_lock =
for
> + * the update of each entry.
>   */
>  void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig)
>  {
>         struct fnhe_hash_bucket *bucket;
>         int i;
>
> -       bucket =3D rcu_dereference_protected(nhc->nhc_exceptions, 1);
> +       rcu_read_lock();
> +       bucket =3D rcu_dereference(nhc->nhc_exceptions);
>         if (!bucket)
> -               return;
> +               goto out;
>
>         for (i =3D 0; i < FNHE_HASH_SIZE; i++) {
>                 struct fib_nh_exception *fnhe;
>
> -               for (fnhe =3D rcu_dereference_protected(bucket[i].chain, =
1);
> +               for (fnhe =3D rcu_dereference(bucket[i].chain);
>                      fnhe;
> -                    fnhe =3D rcu_dereference_protected(fnhe->fnhe_next, =
1)) {
> -                       if (fnhe->fnhe_mtu_locked) {
> -                               if (new <=3D fnhe->fnhe_pmtu) {
> -                                       fnhe->fnhe_pmtu =3D new;
> -                                       fnhe->fnhe_mtu_locked =3D false;
> -                               }
> -                       } else if (new < fnhe->fnhe_pmtu ||
> -                                  orig =3D=3D fnhe->fnhe_pmtu) {
> -                               fnhe->fnhe_pmtu =3D new;
> -                       }
> -               }
> +                    fnhe =3D rcu_dereference(fnhe->fnhe_next))
> +                       fnhe_update_pmtu(fnhe, new, orig);
>         }
> +out:
> +       rcu_read_unlock();
>  }
>
>  void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index fd688e1f879f..604cc51dfd9b 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -741,6 +741,35 @@ static void update_or_create_fnhe(struct fib_nh_comm=
on *nhc, __be32 daddr,
>         spin_unlock_bh(&fnhe_lock);
>  }
>
> +/* Update the PMTU of an exception when:
> + * - the new MTU of the first hop becomes smaller than the PMTU
> + * - the old MTU was the same as the PMTU, and it limited discovery of
> + *   larger MTUs on the path. With that limit raised, we can now
> + *   discover larger MTUs
> + * A special case is locked exceptions, for which the PMTU is smaller
> + * than the minimal accepted PMTU:
> + * - if the new MTU is greater than the PMTU, don't make any change
> + * - otherwise, unlock and set PMTU
> + *
> + * fnhe_lock keeps fnhe_pmtu and fnhe_mtu_locked consistent against
> + * update_or_create_fnhe(), which sets both under the same lock.
> + */
> +void fnhe_update_pmtu(struct fib_nh_exception *fnhe, u32 new, u32 orig)
> +{
> +       spin_lock_bh(&fnhe_lock);
> +
> +       if (fnhe->fnhe_mtu_locked) {
> +               if (new <=3D fnhe->fnhe_pmtu) {
> +                       fnhe->fnhe_pmtu =3D new;
> +                       fnhe->fnhe_mtu_locked =3D false;
> +               }
> +       } else if (new < fnhe->fnhe_pmtu || orig =3D=3D fnhe->fnhe_pmtu) =
{
> +               fnhe->fnhe_pmtu =3D new;
> +       }
> +
> +       spin_unlock_bh(&fnhe_lock);
> +}
> +
>  static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, str=
uct flowi4 *fl4,
>                              bool kill_route)
>  {
