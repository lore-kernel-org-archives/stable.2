Received: from va-2-59.ptr.blmpb.com (va-2-59.ptr.blmpb.com [209.127.231.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040131618C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789221871; cv=none; b=Xn1I3iNtWI0nhQj0Nt/6G6tlcZHJiBbJWgfQpEOfutYtcWdyU6E6kqPXONQi5IUuBRDfyrk8yLUWFdJCTwSpcRlEgVSdjgl3428BXKALGyX84+GhcyDguCVj4Rn0TalLvwa2dREi+V/KNnNvc2Dt+3GJv+dXByUlJRwDvV8hxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789221871; c=relaxed/simple;
	bh=4ZVerH78wo5qLuv8nfINl/jI65zReuAdmOl2xZZBoKU=;
	h=Subject:From:Content-Type:Cc:Mime-Version:In-Reply-To:References:
	 To:Date:Message-Id; b=u5OiT9tfcbdw+T6M5Db5v90F11VjTiCQDxtG2a2kH0EAETm5mOsJ9XAlo5iZH9Vv4isNRHEWG8qk3gsDh6CjCjUZF7E3rEy014fnP90a0a5inb76/MKz4Jx5VAdVwoBaE7Qzmmadwit3xqFQRhrwowxCwfDFH05TyZzLRAfeDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=aZ/LV4uM; arc=none smtp.client-ip=209.127.231.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="aZ/LV4uM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1789221857;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=SN67MfKQzWhNa/imCV5LxYu9NDBZlih7iFUSWzTxIuA=;
 b=aZ/LV4uMGyWFfVKvLrFD8Ce5/rf16GEzbk9moOp1d8WUZWi7PSj0pXwBY/3MKRDI41wkD2
 k7UUL+PkepFvkyre18qxjVmpfwZI+zJBVYXeR0NxfZSN+D2P6us+zYg04sf734KwQrOkwv
 F672xXBq4m1lv5DgGtCVOr5gmeusIcb0+QKNUUeCR75qrCmFo/XvkgBc6MCROkOLniD6DP
 xKlZ5fbVHMDHiDOYJDtr7PEhIg943lgjjIWWi0OjUQz0jpFlT+h5S3C/1eSz21xmuupk/b
 /hGUZzefel6LaZx6hs67OszShwgXc9UUlUuVaQdvZCf2aFrSVYqmcBhm1aGk9A==
Subject: Re: [PATCH] md/raid5: serialize plug list add with device_lock
Content-Transfer-Encoding: quoted-printable
From: "yu kuai" <yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8
X-Original-From: yu kuai <yukuai@fygo.io>
Reply-To: yukuai@fygo.io
Cc: <song@kernel.org>, <magiclinan@didiglobal.com>, <xiao@kernel.org>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Li Youhong" <liyouhong@kylinos.cn>, <stable@vger.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <6edbeca2.341a.1a079e5507c.Coremail.dayou5941@163.com>
User-Agent: Mozilla Thunderbird
References: <20260902095307.358569-1-dayou5941@163.com> <826d82e9-0f0c-450e-a5f9-ea6675b7adc6@fygo.io> <6edbeca2.341a.1a079e5507c.Coremail.dayou5941@163.com>
To: =?utf-8?q?=E6=9D=8E=E4=BD=91=E9=B8=BF?= <dayou5941@163.com>, 
	"yu kuai" <yukuai@fygo.io>
Date: Sat, 12 Sep 2026 22:04:12 +0800
Message-Id: <116efada-45f3-4c68-92d9-2bf56fcc7629@fygo.io>
Received: from [192.168.1.104] ([39.182.0.161]) by smtp.larksuite.com with ESMTPS; Sat, 12 Sep 2026 14:04:15 +0000
X-Lms-Return-Path: <lba+26aa55be0+13c1bc+vger.kernel.org+yukuai@fygo.io>

Hi,

=E5=9C=A8 2026/9/7 11:24, =E6=9D=8E=E4=BD=91=E9=B8=BF =E5=86=99=E9=81=93:
>
>
>
> Hi Kuai,
>
>
>
>
>
>
>
>
>
>
>
>
> At 2026-09-05 11:17:58, "yu kuai" <yukuai@fygo.io> wrote:
>> Hi,
>>
>> =E5=9C=A8 2026/9/2 17:53, Li Youhong =E5=86=99=E9=81=93:
>>> From: Li Youhong <liyouhong@kylinos.cn>
>>>
>>> raid5_unplug() can spin forever under conf->device_lock when
>>> raid5_plug_cb.list still points at a stripe whose sh->lru has
>>> already been reinitialized (self-looped). That disables IRQs on
>>> the holder CPU and causes multi-CPU hard lockups on waiters of
>>> the same lock.
>>>
>>> This happens because release_stripe_plug() sets
>>> STRIPE_ON_UNPLUG_LIST and list_add_tail(sh->lru) without
>>> device_lock, while do_release_stripe() may concurrently move the
>>> same lru onto handle/inactive when the last reference drops.
>>>
>>> Note: a 2020 proposal tried extra refs / checking
>>> STRIPE_ON_UNPLUG_LIST in do_release_stripe() without serializing
>>> the plug enqueue:
>>> https://lore.kernel.org/linux-raid/20200108163023.9301-1-guoqing.jiang@=
cloud.ionos.com/
>>> That still leaves a TOCTOU window where the bit is clear during
>>> the check and set afterwards, allowing two list_add on the same
>>> lru. It was not merged.
>>>
>>> Serialize the bit update and list_add with device_lock. If
>>> do_release_stripe() still sees STRIPE_ON_UNPLUG_LIST, restore the
>>> reference and let raid5_unplug() own the final release.
>>>
>>> Observed on production 9-disk NVMe RAID5 under MySQL AIO
>>> (io_submit -> blk_finish_plug -> raid5_unplug).
>>>
>>> Fixes: 8811b5968f62 ("raid5: make_request use batch stripe release")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
>>> ---
>>>    drivers/md/raid5.c | 33 ++++++++++++++++++++++++++++++---
>>>    1 file changed, 30 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>> index b91545ce090d..c9197b63b1c4 100644
>>> --- a/drivers/md/raid5.c
>>> +++ b/drivers/md/raid5.c
>>> @@ -229,6 +229,17 @@ static void do_release_stripe(struct r5conf *conf,=
 struct stripe_head *sh,
>>>    	int i;
>>>    	int injournal =3D 0;	/* number of date pages with R5_InJournal */
>>>   =20
>>> +	/*
>>> +	 * Stripe is owned by release_stripe_plug()'s cb->list. A concurrent
>>> +	 * last-ref release can reach here after the stripe was queued for
>>> +	 * unplug (lru may already be non-empty). Do not re-add lru elsewhere=
;
>>> +	 * restore the reference and let raid5_unplug() finish the release.
>>> +	 */
>>> +	if (test_bit(STRIPE_ON_UNPLUG_LIST, &sh->state)) {
>>> +		atomic_inc(&sh->count);
>>> +		return;
>>> +	}
>>> +
>>>    	BUG_ON(!list_empty(&sh->lru));
>>>    	BUG_ON(atomic_read(&conf->active_stripes)=3D=3D0);
>>>   =20
>>> @@ -5760,6 +5771,9 @@ static void release_stripe_plug(struct mddev *mdd=
ev,
>>>    		raid5_unplug, mddev,
>>>    		sizeof(struct raid5_plug_cb));
>>>    	struct raid5_plug_cb *cb;
>>> +	struct r5conf *conf =3D mddev->private;
>>> +	unsigned long flags;
>>> +	bool queued =3D false;
>>>   =20
>>>    	if (!blk_cb) {
>>>    		raid5_release_stripe(sh);
>>> @@ -5775,9 +5789,22 @@ static void release_stripe_plug(struct mddev *md=
dev,
>>>    			INIT_LIST_HEAD(cb->temp_inactive_list + i);
>>>    	}
>>>   =20
>>> -	if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state))
>>> -		list_add_tail(&sh->lru, &cb->list);
>>> -	else
>>> +	/*
>>> +	 * Serialize with do_release_stripe() on device_lock so sh->lru canno=
t
>>> +	 * be added to handle/inactive and cb->list at the same time.
>>> +	 */
>>> +	spin_lock_irqsave(&conf->device_lock, flags);
>>> +	if (!test_and_set_bit(STRIPE_ON_UNPLUG_LIST, &sh->state)) {
>>> +		if (unlikely(!list_empty(&sh->lru))) {
>>> +			clear_bit(STRIPE_ON_UNPLUG_LIST, &sh->state);
>>> +		} else {
>>> +			list_add_tail(&sh->lru, &cb->list);
>>> +			queued =3D true;
>>> +		}
>>> +	}
>>> +	spin_unlock_irqrestore(&conf->device_lock, flags);
>> Do you run some performance test on this patch? I believe this is from I=
O hot path,
>> a spinlock is not acceptable. I know there is already some spinlock for =
raid5, but
>> I'd like not to introduce new lock contention.
>>
>> Can this problem be fixed by a new llist in stripe_head?
>
> I agree that adding device_lock on this path can bring some
> overhead; I will follow up with performance numbers.
>
>
> Regarding the alternative: did you mean adding a dedicated
> llist_node in stripe_head for the plug/unplug path (instead of
> reusing sh->lru), so that release_stripe_plug() and
> do_release_stripe() no longer share the same list node?
>
>
> If we still queue the plug list via sh->lru, switching that list
> to an llist would not remove the race, because do_release_stripe()
> can still list_add the same lru onto handle/inactive concurrently.
> A separate node would avoid that, but unplug would then need to
> move stripes from the plug llist onto the existing lru-based
> release path, which is a larger change.

I mean a new list for unplug in sh like unplug_llist. And I think it's
fine to use the llist directly for unplug, there is no need to move
sh from unplug llist to lru list first.

>
>
> Please let me know if that matches what you had in mind.
>
>
> Thanks,
> Li Youhong>
>>> +
>>> +	if (!queued)
>>>    		raid5_release_stripe(sh);
>>>    }
>>>   =20
>> --=20
>> Thanks,
>> Kuai

--=20
Thanks,
Kuai
