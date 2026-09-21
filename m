Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B83C65F4
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978600; cv=pass; b=RcsXWH/xzgHyC3uGPVtIUnhORYJeq9jbHwpoiiOMIWzrC3WfDU0OEz+mTr5gD7HWsyyQTVQ6sfYmD2S1sRyGsjv2gKNRPzhcVG5vvdrU8tVcAuIgq/T05USXQz6X/agbimFhUxM1WWYDzz405uExtWJvA5jY3tC3gkJ4J6eNrMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978600; c=relaxed/simple;
	bh=D6DRfvYxCcRfM+fDUxunHOyYs/QC9j3cuNqk1/dHOcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d03W1l9URmDKLfxEqXkTim3ILE/6DrtORIAKGSv/c3mzjEkMade6ancl5dW4Yv9yn34UslbBhXmPjbqk1AzNzCYB1tfsjiIfKJk1dQnstw4cgxURu85Izium/A+gMHczQRWXLmyAAAZ276LKgG/3/aRqjxflMxgl3OYxvf2HeJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm3zmTwo; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm3zmTwo"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a5e21a5408so19165131fa.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789978596; cv=none;
        d=google.com; s=arc-20260327;
        b=JfgwMdOuINUMIoxkU4lz7/b1it0XCKh2javM+QwMx24UtqGG2QYXoav6zyr3vJHEVy
         GjskdZRNeE2TecqFx66sluWVCNIhiH1I8BI2x4Vp/L3IdUP5x69CtNmXhTHjV//n/PVD
         7rNTda/ZUVJU/UpwHFr/RssAn9KWPT3zgNx5CELy3EppJGclru3Y5WlqpcqAcRhVCWP/
         29i8HkR8ZnsCpololnvG2C+DM5/uOTqg+vyJ6VHnUXbYcH/20O0UVzoH8MNBV6UCa7Oa
         GdA78sIDL0yFQpf5FI/X/kedp1aT8jy+0a09yaGNqcHW+kCJcB/nF8zwZ9VU5NgYSQZC
         esPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RHg4F4dbnUs0jRR7Pqqe34J1QjlGC1UbSYllDfPgOOY=;
        fh=T/nrq9BkviC6suSO/OJ0hzkg1fzdMLrpmT9O3JAYDg4=;
        b=CNtfgGCNtDjOUYX6wsbhPtnfulgFmC/MMoc+qLvOskxiUtO/PiJ8suMyoras2Vcn1b
         ylsIiVFvCftrmK0URK6B5GZYhj1uZfz5tzB9hPlwmGp/fDEvXn57tXSvIBbW1FT7oVke
         lNNDZwjqJc31eOAojY0TczXbyRvfjydWlExxhJXUAf2+QLCytKvSMunQUGcFUmUV2yZG
         DQ61+UHRgoYB1v5KJimnSdPVK76oChVuw3ugN1kkzdMfIxqjouFDW5S8ij7fnXdnrR8G
         A6jmaxMQLv3WczYDAv9ZwLsG9Qdu7hDnsgsF/0JR6ekSjG8Z4AW1doUXBasqfdzNcFJ+
         Kt4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789978596; x=1790583396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RHg4F4dbnUs0jRR7Pqqe34J1QjlGC1UbSYllDfPgOOY=;
        b=Mm3zmTwosn1a8mVO+ePxmmKDtjvZ8yuUriXugbusmVmARTorkXP+Xoy6HkVzdd2mtZ
         kuJejpF5OD4YDkIgJr0jmIMLCJKeNIXcba4lYePhVkgeVA7HJy0v3FT9mqP0POO9JoNG
         uVsunp3u+EXvYIgf+CEVEhWu/dtR1e8WcLOsIgSta5EFKwSUYws2/JcQ+pz8Uw/T0Wpq
         0/BFg0TtLs+8acOsmSiurz9cRcu8y8tNcMWKb9HMHMaydfuFZh6ygj2LkEdoywjbDKyT
         +wjDyx4+sWSudMtgrQ3bACPWIIym5LIinVV2l/3OZxZjz22OAEOADI3eoPOilLugr69K
         03Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978596; x=1790583396;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RHg4F4dbnUs0jRR7Pqqe34J1QjlGC1UbSYllDfPgOOY=;
        b=QpCV4pUpk6QeyNpOFrnAXyKONZLf96eixV8YuoHOP/ffr+UZoK6T72BEzaosfwCMEl
         gV2AVTPDyxd3Br5dOIzqjLcStkapG/PHu60tcL+VTEU2b/qxdJLkwoiBzHLcgBxPiNBv
         /KgRwkwExn3VpboH4xV2osW8HIgr/Vc7iNTMSDgT+Z1AXpCVDHl3Vq5Tii9aXmKchCjM
         dADPTpxnqafUPrmxUb+Dzg1mFIVLmK467HRtirWyBtshj9WrsMPnBPyrTiljF58lMC8e
         qu8L0u3oNTsHaxMw78AEXWYZmxk2D9TAm5XVGocnKP/gwg2F+U+ZK5cp1eWZXM6Jl8F0
         b2UQ==
X-Forwarded-Encrypted: i=1; AKwUvBz/KCRurdPRsMmkS068TtM77rh81MTxDrkPVkAobD/rO6Fn4gQBgeb1y6VOtuYZFX947b+4Rnw=@vger.kernel.org
X-Gm-Message-State: AFuF++mP4q0AJ8+mjTuPqK/a/4tRJmkazARcHAt/u3bsEjzsfkkmi3L2
	3BOqVfTQqKG9TjlVlnXMLpX47kw9ZbcGMEyxoG4K7VADhYPuY6HmfP52Rel7V4dOcfuRaqbCysJ
	viGMap4cSPCNZKsNDyBEzcljn2K7dMcc=
X-Gm-Gg: AYBFou0cunQbyqaALnFaQ7SFGqkptVtsiJyCaVMB4XmPD9VAJz7sxh5PK35nQV9lM6U
	gG4Vme0Hf7wMnjJsnKNtoQs7iaw2Yp3y3SW175GNo93YmFJtKXE322Wi100pr5aoC8QvpaGAyUn
	ZKWTKo21gpIhtG2GUDD1NPmMycn+JZuTmjY2g09/7H54NsmvfD/Q3M+HUM3JsrtmzcMPrJEt9PZ
	o4xAkkgPC4DBH/yQDWqKuYrekiPqmiIXgzZqWwwMANm6QYUGj9J/gfvNhoEusUDxs/7pg6leVAZ
	KHJHKJImqXXl7RSaG3PldSvw6Uu6EeuCOffyRNSXHNhuYJil431WsKYa
X-Received: by 2002:a05:651c:199f:b0:3a5:ba1e:8b08 with SMTP id
 38308e7fff4ca-3a5fbe3743cmr19815651fa.3.1789978596351; Mon, 21 Sep 2026
 01:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13b330df140a2ee488952b4c7145e261ec884555.camel@dubeyko.com>
 <20260918212153.23651-1-qwe.aldo@gmail.com> <CAKFNMoneRHw=-hsGvzY+Mdktm3+EtodSU2vpNoaXZnheu+VjgQ@mail.gmail.com>
In-Reply-To: <CAKFNMoneRHw=-hsGvzY+Mdktm3+EtodSU2vpNoaXZnheu+VjgQ@mail.gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 21 Sep 2026 17:16:18 +0900
X-Gm-Features: AcwNN1WwxAMKnzF-5FQ6dVTd1yEQiTnVJxiKOF9pPoF6TlvX_ggfBDydnl-UtF0
Message-ID: <CAKFNMonYVUbzjYm343Aw-=xjUk78x4EdUwGBfNRwE6zfmRVhvA@mail.gmail.com>
Subject: Re: [PATCH v3] nilfs2: fix checkpoint root lifetime on sysfs errors
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: slava@dubeyko.com, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:47=E2=80=AFPM Ryusuke Konishi wrote:
>
> On Sat, Sep 19, 2026 at 6:22=E2=80=AFAM Aldo Ariel Panzardo wrote:
> >
> > Hi Slava,
> >
> > No, wait_for_completion() without a timeout is intentional here.
> >
> > The kobject subsystem guarantees that the release callback will
> > eventually run -- CONFIG_DEBUG_KOBJECT_RELEASE only defers it, it
> > never drops it. So the wait is bounded in practice.
> >
> > If we used wait_for_completion_killable_timeout() and the timeout
> > fired (or a signal arrived) before the release callback ran, we
> > would kfree() the root while the kobject release is still pending.
> > When the callback finally runs it would access freed memory -- a
> > use-after-free.
> >
> > wait_for_completion_killable() (without timeout) has the same
> > problem: if the wait is interrupted by a fatal signal, we cannot
> > safely free the container because the release callback may still
> > reference it.
> >
> > The unconditional wait_for_completion() is the only safe choice
> > when the caller must free the container of an embedded kobject.
> > This is the same pattern used by other subsystems (e.g.,
> > blk_mq_tag_set, configfs subsystems).
> >
> > Aldo
>
> Hi Aldo,
>
> Thank you for the patch.
>
> However, in my view, introducing a mutex for synchronization (either
> by replacing the spinlock or adding a mutex alongside it) is
> unnecessary and suboptimal.
>
> nilfs_sysfs_create_snapshot_group() performs memory allocations and
> sysfs node creation, which can sleep.  Holding 'ns_cptree_lock' across
> this operation causes concurrent read-only callers like
> nilfs_lookup_root() to block unnecessarily on a lock that originally
> protected a very fast, in-memory rbtree lookup.
>
> Note that checkpoint and snapshot mounts themselves are serialized by
> 'nilfs->ns_snapshot_mount_mutex', so strict mutual exclusion between
> concurrent insertions is not required; we only need to eliminate the
> race against nilfs_lookup_root().
>
> Instead of converting 'ns_cptree_lock' to a mutex, I think it would be
> cleaner to keep 'ns_cptree_lock' as a spinlock and structure the
> creation flow so that new is fully initialized and registered with
> sysfs *before* acquiring the spinlock:
>
> 1. Allocate new and initialize the basic fields required for sysfs
> creation (cno, nilfs, etc.).
> 2. Call nilfs_sysfs_create_snapshot_group(new) *before* taking the lock.
>     - On error, wait_for_completion(&new->snapshot_kobj_unregister),
>       kfree(new), and return NULL.
> 3. If sysfs creation succeeds, acquire spin_lock(&nilfs->ns_cptree_lock),
>    link new into ns_cptree, and drop the spinlock.
>
> In nilfs_put_root(), we can keep refcount_dec_and_lock() with the
> spinlock, erase the node from the tree, drop the spinlock, delete the
> sysfs group, wait for completion, and free root.
>
> Could you please update the patch to keep 'ns_cptree_lock' as a
> spinlock and complete sysfs registration before inserting the root
> into ns_cptree?
>
> I think this approach should work, but please let me know if I've
> missed anything.
>
> Thanks,
> Ryusuke Konishi

Hi Aldo,

On second thought, regarding
wait_for_completion(&root->snapshot_kobj_unregister),
wouldn't it be even cleaner to keep it inside the sysfs helper
functions instead of exposing it in the cptree functions?

Specifically:

- Inside nilfs_sysfs_create_snapshot_group():
  Call wait_for_completion(&root->snapshot_kobj_unregister) directly in its
  error path after kobject_put().

- Inside nilfs_sysfs_delete_snapshot_group():
  Call wait_for_completion(&root->snapshot_kobj_unregister) after kobject_p=
ut().

This way, the completion logic is nicely encapsulated within the sysfs
subsystem, so nilfs_find_or_create_root() and nilfs_put_root() don't
need to manage the internal completion state explicitly they can
simply call the sysfs functions and perform kfree() when needed.

What do you think?

Thanks,
Ryusuke Konishi
