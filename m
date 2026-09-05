Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C901F78E6
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 03:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788578303; cv=none; b=r+B+sFB8GvGhdAmqnwLbk1Dxdc+Q4+PpLPh+A2sG/24ZeBN1+Z3jobIcmmii0o5IF2cCu4JWHbMAkcPxG2bSZqw/ber4KrIGV/BBNRJvAfZ8hDLa67iIaZW8ANO21uyj5NEW12E8hUIuf2BLx+6I7nAG5libBQ28wNY451G/ZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788578303; c=relaxed/simple;
	bh=DK2cQEis3KVkcqXm8bpzd17Xk3EyX9uX/mFmYfrQW6I=;
	h=References:To:Date:Mime-Version:Subject:Message-Id:Content-Type:
	 In-Reply-To:Cc:From; b=s4NJ0sCy6LV+NxbQkh0airlkHGyBi8L5lMf/3K7+PgNQNqw2GoKo1EC/EM5b9uAR7VwRD39Nh00QkmVddWpihiJ4VG3z7j9pTRg26tfQmI5uqgblovG7iP0RRmnkdNCEpzFQ1z4J4LHCj1D6msLbhbmqC7STq5aD8C7ZWOl3dp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=Y4gLhq0R; arc=none smtp.client-ip=209.127.231.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="Y4gLhq0R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1788578284;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=QepHmHRXKxDaFStFMuxMtj/OCwtBjnK85AwkNR/yQX4=;
 b=Y4gLhq0RJIl7s6hA4dD5xBo+6uFyeEIuTeruQtJFn+nGuAUvqSPC/8+VFvLKIY+OpKNDQi
 +QAYZEhyIWIM+6L1X0E2fduhCTb5VnGd8CukDWP9FIufAGJLrIBkjYyric+y3lFGv5yCwr
 0FhkCjdXXYCKKSdqEWscj/nWvmMeCN9Ycs6hW6Fn+942Vfqj5TOpguayzuDdqIZAgccgD9
 cXK/ZIoo1LdLUZ4ikM6R2e5wtfxYPJSPT8j6wn03ZyUH/OHcr29DDKgrbMt1YYmOzP1wgv
 ZL67wXPK3AfojpeiLwrZgQ2HdPbXQp0j8Usrm0uqHxA/W+SqZRu2SuTai6VlvQ==
References: <20260902095307.358569-1-dayou5941@163.com>
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fygo.io
To: "Li Youhong" <dayou5941@163.com>, <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
Date: Sat, 5 Sep 2026 11:17:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a9b89eb+d8f617+vger.kernel.org+yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.178]) by smtp.larksuite.com with ESMTPS; Sat, 05 Sep 2026 03:18:02 +0000
Subject: Re: [PATCH] md/raid5: serialize plug list add with device_lock
Message-Id: <826d82e9-0f0c-450e-a5f9-ea6675b7adc6@fygo.io>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260902095307.358569-1-dayou5941@163.com>
Cc: <magiclinan@didiglobal.com>, <xiao@kernel.org>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Li Youhong" <liyouhong@kylinos.cn>, <stable@vger.kernel.org>
From: "yu kuai" <yukuai@fygo.io>
X-Original-From: yu kuai <yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2026/9/2 17:53, Li Youhong =E5=86=99=E9=81=93:
> From: Li Youhong <liyouhong@kylinos.cn>
>
> raid5_unplug() can spin forever under conf->device_lock when
> raid5_plug_cb.list still points at a stripe whose sh->lru has
> already been reinitialized (self-looped). That disables IRQs on
> the holder CPU and causes multi-CPU hard lockups on waiters of
> the same lock.
>
> This happens because release_stripe_plug() sets
> STRIPE_ON_UNPLUG_LIST and list_add_tail(sh->lru) without
> device_lock, while do_release_stripe() may concurrently move the
> same lru onto handle/inactive when the last reference drops.
>
> Note: a 2020 proposal tried extra refs / checking
> STRIPE_ON_UNPLUG_LIST in do_release_stripe() without serializing
> the plug enqueue:
> https://lore.kernel.org/linux-raid/20200108163023.9301-1-guoqing.jiang@cl=
oud.ionos.com/
> That still leaves a TOCTOU window where the bit is clear during
> the check and set afterwards, allowing two list_add on the same
> lru. It was not merged.
>
> Serialize the bit update and list_add with device_lock. If
> do_release_stripe() still sees STRIPE_ON_UNPLUG_LIST, restore the
> reference and let raid5_unplug() own the final release.
>
> Observed on production 9-disk NVMe RAID5 under MySQL AIO
> (io_submit -> blk_finish_plug -> raid5_unplug).
>
> Fixes: 8811b5968f62 ("raid5: make_request use batch stripe release")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
>   drivers/md/raid5.c | 33 ++++++++++++++++++++++++++++++---
>   1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index b91545ce090d..c9197b63b1c4 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -229,6 +229,17 @@ static void do_release_stripe(struct r5conf *conf, s=
truct stripe_head *sh,
>   	int i;
>   	int injournal =3D 0;	/* number of date pages with R5_InJournal */
>  =20
> +	/*
> +	 * Stripe is owned by release_stripe_plug()'s cb->list. A concurrent
> +	 * last-ref release can reach here after the stripe was queued for
> +	 * unplug (lru may already be non-empty). Do not re-add lru elsewhere;
> +	 * restore the reference and let raid5_unplug() finish the release.
> +	 */
> +	if (test_bit(STRIPE_ON_UNPLUG_LIST, &sh->state)) {
> +		atomic_inc(&sh->count);
> +		return;
> +	}
> +
>   	BUG_ON(!list_empty(&sh->lru));
>   	BUG_ON(atomic_read(&conf->active_stripes)=3D=3D0);
>  =20
> @@ -5760,6 +5771,9 @@ static void release_stripe_plug(struct mddev *mddev=
,
>   		raid5_unplug, mddev,
>   		sizeof(struct raid5_plug_cb));
>   	struct raid5_plug_cb *cb;
> +	struct r5conf *conf =3D mddev->private;
> +	unsigned long flags;
> +	bool queued =3D false;
>  =20
>   	if (!blk_cb) {
>   		raid5_release_stripe(sh);
> @@ -5775,9 +5789,22 @@ static void release_stripe_plug(struct mddev *mdde=
v,
>   			INIT_LIST_HEAD(cb->temp_inactive_list + i);
>   	}
>  =20
> -	if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
> -		list_add_tail(&sh->lru, &cb->list);
> -	else
> +	/*
> +	 * Serialize with do_release_stripe() on device_lock so sh->lru cannot
> +	 * be added to handle/inactive and cb->list at the same time.
> +	 */
> +	spin_lock_irqsave(&conf->device_lock, flags);
> +	if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state)) {
> +		if (unlikely(!list_empty(&sh->lru))) {
> +			clear_bit(STRIPE_ON_UNPLUG_LIST, &sh->state);
> +		} else {
> +			list_add_tail(&sh->lru, &cb->list);
> +			queued =3D true;
> +		}
> +	}
> +	spin_unlock_irqrestore(&conf->device_lock, flags);

Do you run some performance test on this patch? I believe this is from IO h=
ot path,
a spinlock is not acceptable. I know there is already some spinlock for rai=
d5, but
I'd like not to introduce new lock contention.

Can this problem be fixed by a new llist in stripe_head?

> +
> +	if (!queued)
>   		raid5_release_stripe(sh);
>   }
>  =20

--=20
Thanks,
Kuai
