Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457A37EFFE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791843; cv=pass; b=fNYQccVXj8gsKNDN8d/EGque+KZ492/ijC+i0vnt2mMSfoDOiDr0WGU+T/++IrF/+Fs6cu+WvMdKC6vyVD5gbERMrKX8W5inlM3USoekwFRhnWhUVxhcN2kKUv+n4FBa6r0qRfI4SX2FG7Twe3yf/L4cd7UT8pW7Jd/WE9qlBuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791843; c=relaxed/simple;
	bh=IAF9rQ3F4twH9diAhxEPNqxyfLHNSPaVCmmIYi0LgmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t07UF4ti0AUaz5RwxxVCLNpoCJftUZ9WmAMytTMC0iimZhIGFwf0jatRVXCnFMfOUzkIhFIIDnYKANrk++KCugwzGtdL6wOGObQ7sjCaiX/hCikM0m8AK2M4BfPoHetfLATHSqzt9K8jtv9YaSbVZa+t0CcHrxiwcDIt3tmyZCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek7VBR/x; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek7VBR/x"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac9a5236b3so577962a12.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790791840; cv=none;
        d=google.com; s=arc-20260327;
        b=p7Ty7lEt0rGtu0z+ZzXgezz1BjbF63zYi8X92K/1BmICEmCLO9wdBSLL4DHCyNurpW
         1mbtTN0X5GL4JDCQUWLZvm5+06tc7Zh41NfcIif8BAE0djSSW6rF7S9WX0x4pUVhZzWN
         J/07GGtVQK/LMaZoC1vSWBYD7bo6q5M7LWtAgERLH8o4Q8gpLLd+4To2YSH8Ee0YXH6m
         e9URyoRGdFqG6aqwGHlHxJmoKVpUy0wL2JLlN2808DsmP5QxCBdpPSzVGPCbRYpfiLfJ
         4HGE8p9FTRhhpO6NmZ/SMBsryO3q+JzDSfeQxellgGSJ2e1flOxTTZ2nGmRwghKyF/Yk
         TCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XsAeTJI3+nuFUQ7aBRpF568Y0nyKQPNERKkT7Ysunxs=;
        fh=iUCiazD0NFoDz2Trge+iGYhaACN0imsofLAXqYDDuhk=;
        b=cLmhNy+RLlmmW1aYKah528OvOd5RuoFVQbsbtlSe2E/5EvBZYl76Du6JR11vsH0aTG
         kSLRiRcKV1nmOJiAGh9P4OZYG1QnQYBNCcc7gzgZfMTLyzrBNQnMr73Tw4GBHQ2ugE7d
         ay32cNAL0GoYw8AnM0i1kFJ3dKLA939ECC9i5YbnfcjI1iJnGomhHTN4fucVllI9FP8G
         LUjW5wNAZj5c0h74N0BKysLgnc/TI3IoROrtkFabmLCg+DcUCfVhaEEevD8zdl+wQyuT
         WVwseVWgzQCnOYg6SYqrwQO8AeIhF4BTqpaKvR4GvJLKjFTrTrUPwvKq24SF1kOhLDgj
         KiVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790791840; x=1791396640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XsAeTJI3+nuFUQ7aBRpF568Y0nyKQPNERKkT7Ysunxs=;
        b=ek7VBR/xG44bGh/TPoxNfYR+DvwI3XpTPMEldlg/ik5gEXfzfPKMr3vmqzYcFGVfcu
         /ZEZqOXuryVTL3kYcqQn2aTP5LXa7S0iIBNerFCib1SjW3K+aTRQ+GOZdFMXdG7Po9bv
         Fx/Cnv4Y26heoWU0IUhn8pDAMzR4pugUKikcQGvAvDiXRikYw8nYjIBslLAGJWZL58cL
         ti2aM2Qj8jk7C2iU21fD1umuk7RAyHF6Tw2/7X3Ju0FBiGsoG21oE8xM61FDqmFM4cfI
         iRy0M8AUPaBH69S51ZRY0SVUNe3DRLiM1RirEwHKN7JwZO5ki4juBZGde2fpJ7d1LKqQ
         egqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790791840; x=1791396640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XsAeTJI3+nuFUQ7aBRpF568Y0nyKQPNERKkT7Ysunxs=;
        b=11KraSfK+BSpG68DTf5pT14jKEWYhhApdNaCbDIi3Y9RV2ckXXJlEUD94vnNmTIPyM
         p1BI80Iubn74CBOpicDmIsUiZ3bCzwPfhOQcMHW72Qf6KfXrhqSM8f9XmTI5C0yIVm35
         Yvxx7GXsmS+lX5CxWcTKDiKW8xykkKcFaKbB+jc5OiOJmLUn4AuyCnm3oN9z0UGVFMZh
         G7aFPqn0E47GklwaDutBLOHvV9I6jJiGDujpUsfPvaeBz3GXuar/etz3QLD8Itpkhn3D
         xFMO86HXj98o60ml0y5LVoW0QYrs/6pE+NfgKAJWaw+NvNcdx0v0l/cL5QFJiAeXyCzV
         2ckQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIzS62gbOgT9uCle2XYvUBXnexHcAupPh7EDclD0dV/FvPBUoVI5EE6O3H0U7VXnEkCHfh2Qg=@vger.kernel.org
X-Gm-Message-State: AFq9FYINTCkkNw3WDgnLiIechaYx281PkfRSriJudQZNG6EjHEFwz1SA
	JrbtwxMP9YyDo4aCHb9+8UilqSWQ38/YRmIc7Lo/sWa+7BT4r9tp1W5FmHlwF5LJOUhjUfDKmBI
	K+911vz8kBU+rpZkwGDRSYGsrGxZzxjs=
X-Gm-Gg: AYBFou2H0IL3RnQ7qIInjXDZ4iA9qRboY/WdRS2+8puklbpqVh+XK0zfffokD8NQpTR
	8FGZvuusIr/ptK/bBippA/m5S1l/GB+Ci9mvTOUnpm/jA8XvsK5vR9zA+59JwwwwgGXjiDoQKtc
	615yS4qiD0acA28LESc1UrHg4HoEv3fVRH9fsUVLj4/LWwooI4eIsWU9AjPRzjm+7unp4VT+Fyj
	rFynslS5Zbxmn0Gw6bLP0HZ+3qzhjEDFjNMOEX8EOGmdTGHKNr4o7Lhort7VLAFgeoVzBmkQ8UT
	6678xn2YMksVrNrKj1Abb8B0NpBDlRY45ZkE2yavMxhtt54VsR5iq5JMg55hnAO4G4IbHcjzTgN
	2INFl+GCuQPCfbEPD/V5dxA==
X-Received: by 2002:a05:6402:320d:b0:6a9:b062:f0c4 with SMTP id
 4fb4d7f45d1cf-6ae198b82dcmr2131622a12.2.1790791839680; Wed, 30 Sep 2026
 11:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926173315.2452612-1-nicoyip.dev@gmail.com>
 <arty-oqohbGiefgS@kwain> <CANn89iLzwsrka1MUS64RKxx9TbKxGdwzB63nzs6v9endCwUahQ@mail.gmail.com>
In-Reply-To: <CANn89iLzwsrka1MUS64RKxx9TbKxGdwzB63nzs6v9endCwUahQ@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 1 Oct 2026 02:10:27 +0800
X-Gm-Features: AclHuK9FyLMCIwx5kr8OOKxcEPry1zVrMYH2FfXqBJhPscfcAGTrJCKmhfdp0Wc
Message-ID: <CAAo+4rUaPQA_+hAsTYv+fdMnM-5KFZa5RTQxyL+N_gSMgd13Cg@mail.gmail.com>
Subject: Re: [PATCH net] net-sysfs: release the TX queue tracker before
 allowing reuse
To: Eric Dumazet <edumazet@google.com>, Antoine Tenart <atenart@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks all for your reviews.

On Tue, Sep 29, 2026 at 5:28=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Sep 29, 2026 at 10:13=E2=80=AFAM Antoine Tenart <atenart@kernel.o=
rg> wrote:
> >
> > On Sun, Sep 27, 2026 at 01:33:15AM +0800, Chengfeng Ye wrote:
> > > An interrupted sysfs_rtnl_lock() can drop the last kobject reference =
to a
> > > removed TX queue without holding RTNL. netdev_queue_release() clears =
the
> > > kobject before releasing queue->dev_tracker, allowing the queue to be
> > > re-added while the old release still needs the shared tracker slot:
> > >
> > >   CPU 0                               CPU 1
> > >   netdev_queue_release()
> > >     memset(kobj, 0, sizeof(*kobj))
> > >                                       netdev_queue_add_kobject()
> > >                                         state_initialized is clear
> > >                                         netdev_hold() installs new tr=
acker
> > >     netdev_put() releases the new tracker
> > >
> > > With CONFIG_NET_DEV_REFCNT_TRACKER enabled, the old tracker is leaked=
 and
> > > the new lifetime's tracker is released prematurely. A later queue rel=
ease
> > > then reports a double release. The numeric device references remain
> > > balanced.
> > >
> > > The kernel reported:
> > >
> > >   ref_tracker: reference already released.
> > >   ref_tracker: allocated in:
> > >    netdev_queue_update_kobjects+0x23d/0x5c0
> > >    netif_set_real_num_tx_queues+0x111/0x820
> > >    veth_set_channels+0x327/0x930
> > >    ethtool_set_channels+0x3ee/0x490
> > >   ref_tracker: freed in:
> > >    netdev_queue_release+0xbd/0x130
> > >    kobject_put+0x1f9/0x280
> > >    sysfs_rtnl_lock+0x18b/0x1f0
> > >    xps_rxqs_show+0xad/0x250
> > >   WARNING: lib/ref_tracker.c:322 at ref_tracker_free+0x49e/0x6d0
> > >   Call Trace:
> > >    netdev_queue_release+0xbd/0x130
> > >    kobject_put+0x1f9/0x280
> > >    netdev_queue_update_kobjects+0x3f9/0x5c0
> > >    netif_set_real_num_tx_queues+0x111/0x820
> > >    veth_set_channels+0x327/0x930
> > >    ethtool_set_channels+0x3ee/0x490
> > >
> > > Release the tracker before clearing the kobject. Use a full memory ba=
rrier
> > > to order the tracker access before clearing state_initialized, paired=
 with
> > > the control dependency from that check to the new tracker allocation.
> > > Keep the device reference until after the reset so that the queue sto=
rage
> > > remains alive throughout the callback's accesses.
> > >
> > > Fixes: b0b6fcfa6ad8 ("net-sysfs: remove rtnl_trylock from queue attri=
butes")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > > ---
> > >  net/core/net-sysfs.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > > index 352173df7578..b9aadc4c000c 100644
> > > --- a/net/core/net-sysfs.c
> > > +++ b/net/core/net-sysfs.c
> > > @@ -1906,8 +1906,11 @@ static void netdev_queue_release(struct kobjec=
t *kobj)
> > >  {
> > >       struct netdev_queue *queue =3D to_netdev_queue(kobj);
> > >
> > > +     netdev_tracker_free(queue->dev, &queue->dev_tracker);
> > > +     /* Finish using the tracker before allowing the queue to be re-=
added. */
> > > +     smp_mb();
> >
> > Can't you use smp_wmb() instead as it's used to order two stores?
>
> I do not think smp_wmb() would be enough: ref_tracker_free() only reads
> queue->dev_tracker, it never writes to it. We need to order a load
> before a store; smp_wmb() only orders stores.
>
> But what does this smp_mb() pair with in netdev_queue_add_kobject()?
>
> The changelog mentions a control dependency, but netdev_hold() is not
> inside the if () clause, and state_initialized is a bitfield, so
> READ_ONCE() is not possible. This works thanks to the early return,
> but it is implicit and fragile.
>
> Please add an explicit smp_mb() in netdev_queue_add_kobject() after
> the state_initialized check, with a comment pointing to
> netdev_queue_release(). This is not a fast path, and will help code
> review/understanding.
>
> if (unlikely(kobj->state_initialized)) {
>         netdev_warn_once(dev, "Cannot re-add tx queues before their
> removal completed");
>         return -EAGAIN;
> }
> /* Pairs with smp_mb() in netdev_queue_release(): the previous
> * lifetime must be done with queue->dev_tracker before we reuse it.
> */
> smp_mb();
>
> Also change ( /* Finish using the tracker before allowing the queue to
> be re-added. */)
> to the symmetric one (pairs with smp_mb() in  in netdev_queue_add_kobject=
()...)

No problem, I added an explicit smp_mb() after the state_initialized
check in netdev_queue_add_kobject() and made the comments on both
sides symmetric in v2.

The sashiko report on the rx_queue_release() sibling path looks to be
possible. I have applied the same ordering and barrier pair to the RX
path in v2, although I have not reproduced that race.

> pw-bot: cr

Best regards,
Chengfeng
