Received: from sg-3-43.ptr.tlmpb.com (sg-3-43.ptr.tlmpb.com [101.45.255.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0A386571
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516320; cv=none; b=V4Iy8b+4VyY+ct1UUmAPXD8jCjem54Lzw5E/ZcuVRbTLo8BRsWxXoJgq3jtlCCOIiOq6bBspPexpDEFWgV37GKYDl8PPBKafGM4yR9AWQZuFL88GxXDPcsIiHcn8ra67CHKYJWliAgwsydugtBdhvRiOOuCVUENVqCzSJPGqzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516320; c=relaxed/simple;
	bh=/zRbQ4G2JIzgNGW0NdOCTn3fDkacZ/12Bf/PAEdG3J0=;
	h=Subject:References:To:Cc:Content-Type:Date:Mime-Version:
	 Message-Id:In-Reply-To:From; b=SVUAWmEQIPLC543nJGKVn1E1uHt5tAN2vzhfUvwxomvRHbDdvf2FniQkNb5AUy16iK1OZJ0jwoSv7urrLO5iWQWNJ/VMKBxncLPhOX2Qb5CXXlWStOhtoezXTOwMC/8BUBjVjEpdet1vT0+uUj0cYeuq3cQyx1JlKZ/6hVNhOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=XbAZQNiq; arc=none smtp.client-ip=101.45.255.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="XbAZQNiq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1791515558;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=cnjFrYqnLgXOVQZ2ilR00iyrNd4zwdoaGYzKoAoPYcM=;
 b=XbAZQNiq3/ZPRAU5/m9tVdP8bbEtF7ZA5t03HfIyMCltyV19mNpKRpQrUT+vA3Jala+aRB
 yvhhv+mJEloy+6QLiaz2yCemMuCfh8b4ITQtGodBbEgfQeOd80zio1r6b3eM+/i8avNwe/
 qexy+HkZ/KQ8qV7dUbTQeJF2DWUDy9/7m6qrUtIvg5XlHIG8lLlzDnEz5yL6ULX5z25mhI
 HuplLQHkvXIRQSpMYOXskvdvSRSGfks90GQUGrRis3cXm4u87xCsO7/xxKKGeMdTJ/iYws
 TIezbjSz58zPWxGZo6BYAnlRm9zcN9WXKVz5IyxL/HbUzhVNx4wUAc741u8G4g==
Subject: Re: [PATCH v2] md/raid5: use dedicated llist for stripe plug
References: <20260922060928.3486799-1-dayou5941@163.com>
To: "Li Youhong" <dayou5941@163.com>, <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
Cc: <magiclinan@didiglobal.com>, <xiao@kernel.org>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Li Youhong" <liyouhong@kylinos.cn>, <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 9 Oct 2026 11:12:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26ac85ba6+64aba2+vger.kernel.org+yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
Message-Id: <fb8edfb3-ce4c-4b3d-87f8-70552626311f@fygo.io>
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.35]) by smtp.larksuite.com with ESMTPS; Fri, 09 Oct 2026 03:12:37 +0000
In-Reply-To: <20260922060928.3486799-1-dayou5941@163.com>
Reply-To: yukuai@fygo.io
From: "yu kuai" <yukuai@fygo.io>

Hi,

=E5=9C=A8 2026/9/22 14:09, Li Youhong =E5=86=99=E9=81=93:
> From: Li Youhong <liyouhong@kylinos.cn>
>
> release_stripe_plug() and do_release_stripe() share sh->lru.
> release_stripe_plug() sets STRIPE_ON_UNPLUG_LIST and
> list_add_tail()s sh->lru onto raid5_plug_cb.list without
> device_lock. do_release_stripe() holds device_lock and, when the
> last reference drops, list_add()s the same lru onto a handle or
> inactive list.
>
> Two list_add()s on one node corrupt it. sh->lru can be
> reinitialized into a self-loop while raid5_plug_cb.list still
> points at that stripe. raid5_unplug() then walks the list under
> device_lock with IRQs disabled and never finishes. Other CPUs
> waiting for the same lock hard-lockup.
>
> Add a dedicated llist_node, unplug_list, to stripe_head, as
> release_list is used for released_stripes.
>
> Fixes: 8811b5968f62 ("raid5: make_request use batch stripe release")
> Suggested-by: Yu Kuai <yukuai@fygo.io>
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
> v2:
> - Drop taking device_lock in release_stripe_plug(). Add a dedicated
>    unplug_list.
> - v1: link: https://lore.kernel.org/linux-raid/20260902095307.358569-1-da=
you5941@163.com/
>
> ---
>   drivers/md/raid5.c | 52 ++++++++++++++++++++++++++---------------------=
-----
>   drivers/md/raid5.h |  1 +
>   2 files changed, 27 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index b91545ce090d..9dabbf9743d7 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5710,7 +5710,7 @@ static struct stripe_head *__get_priority_stripe(st=
ruct r5conf *conf, int group)
>  =20
>   struct raid5_plug_cb {
>   	struct blk_plug_cb	cb;
> -	struct list_head	list;
> +	struct llist_head	unplug_list;
>   	struct list_head	temp_inactive_list[NR_STRIPE_HASH_LOCKS];
>   };
>  =20
> @@ -5718,34 +5718,33 @@ static void raid5_unplug(struct blk_plug_cb *blk_=
cb, bool from_schedule)
>   {
>   	struct raid5_plug_cb *cb =3D container_of(
>   		blk_cb, struct raid5_plug_cb, cb);
> -	struct stripe_head *sh;
> +	struct stripe_head *sh, *tmp;
>   	struct mddev *mddev =3D cb->cb.data;
>   	struct r5conf *conf =3D mddev->private;
> +	struct llist_node *head;
>   	int cnt =3D 0;
>   	int hash;
>  =20
> -	if (cb->list.next && !list_empty(&cb->list)) {
> -		spin_lock_irq(&conf->device_lock);
> -		while (!list_empty(&cb->list)) {
> -			sh =3D list_first_entry(&cb->list, struct stripe_head, lru);
> -			list_del_init(&sh->lru);
> -			/*
> -			 * avoid race release_stripe_plug() sees
> -			 * STRIPE_ON_UNPLUG_LIST clear but the stripe
> -			 * is still in our list
> -			 */
> -			smp_mb__before_atomic();
> -			clear_bit(STRIPE_ON_UNPLUG_LIST, &sh->state);
> -			/*
> -			 * STRIPE_ON_RELEASE_LIST could be set here. In that
> -			 * case, the count is always > 1 here
> -			 */
> -			hash =3D sh->hash_lock_index;
> -			__release_stripe(conf, sh, &cb->temp_inactive_list[hash]);
> -			cnt++;
> -		}
> -		spin_unlock_irq(&conf->device_lock);
> +	head =3D llist_del_all(&cb->unplug_list);

Is it possible that registered plug from task A can be flushed concurrent b=
y unplug from
another task, and later unplug_list is empty for task A's unplug. If so, a =
NULL check for
head is needed here.

> +	head =3D llist_reverse_order(head);
> +	spin_lock_irq(&conf->device_lock);
> +	llist_for_each_entry_safe(sh, tmp, head, unplug_list) {
> +		/*
> +		 * avoid race release_stripe_plug() sees
> +		 * STRIPE_ON_UNPLUG_LIST clear but the stripe
> +		 * is still in our list
> +		 */
> +		smp_mb__before_atomic();
> +		clear_bit(STRIPE_ON_UNPLUG_LIST, &sh->state);
> +		/*
> +		 * STRIPE_ON_RELEASE_LIST could be set here. In that
> +		 * case, the count is always > 1 here
> +		 */
> +		hash =3D sh->hash_lock_index;
> +		__release_stripe(conf, sh, &cb->temp_inactive_list[hash]);
> +		cnt++;
>   	}
> +	spin_unlock_irq(&conf->device_lock);
>   	release_inactive_stripe_list(conf, cb->temp_inactive_list,
>   				     NR_STRIPE_HASH_LOCKS);
>   	if (!mddev_is_dm(mddev))
> @@ -5768,15 +5767,16 @@ static void release_stripe_plug(struct mddev *mdd=
ev,
>  =20
>   	cb =3D container_of(blk_cb, struct raid5_plug_cb, cb);
>  =20
> -	if (cb->list.next =3D=3D NULL) {
> +	if (!cb->temp_inactive_list[0].next) {
>   		int i;
> -		INIT_LIST_HEAD(&cb->list);
> +
> +		init_llist_head(&cb->unplug_list);
>   		for (i =3D 0; i < NR_STRIPE_HASH_LOCKS; i++)
>   			INIT_LIST_HEAD(cb->temp_inactive_list + i);
>   	}
>  =20
>   	if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
> -		list_add_tail(&sh->lru, &cb->list);
> +		llist_add(&sh->unplug_list, &cb->unplug_list);
>   	else
>   		raid5_release_stripe(sh);
>   }
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index cb5feae04db2..e314f17eb949 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -201,6 +201,7 @@ struct stripe_head {
>   	struct hlist_node	hash;
>   	struct list_head	lru;	      /* inactive_list or handle_list */
>   	struct llist_node	release_list;
> +	struct llist_node	unplug_list;
>   	struct r5conf		*raid_conf;
>   	short			generation;	/* increments with every
>   						 * reshape */

--=20
Thanks,
Kuai
