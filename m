Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0666449B3A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976866; cv=pass; b=AWlSLmhhP09UkE/jh+mG9ytmLgAzz/GtuVhhcvN+bj9vhMT7Msge3tIxklkTPfYcTgn2/TNY95xtV+dKbQAmXQADo4braQzRdYOBAk8hST1tl+lfdYznDMAME2ixcAJeg/bxhFYHus5JW36FWEb4/Z+YaFUpzlMGRwjg9l/9HNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976866; c=relaxed/simple;
	bh=KXxGTuxzh5HQFPptUgQ65qoWgJYcpw7UQPKggFX9gnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiRAFkGiUfTVFMG/8xPcdlmK+DrdR5myt1KjGMWzDUNQ3J3DtDpna9AtoiuMDdB2qgzlR1Xq1CX3i7TLUnVaLs3+8KMis4RVeoy3r7kPJTW7s9BqNeaX28H21s8Y6YYczvbaiKSKxbcBAtN2H9JWJJ05AKw6x06x0AoFT7eaVpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESN3o5oy; arc=pass smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESN3o5oy"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a5e21a5408so18982061fa.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 00:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789976862; cv=none;
        d=google.com; s=arc-20260327;
        b=srl0SDHBKmVF58X4nSvTVjJW6q8BnCjI7qs0grmFEgVU/d9AQNEVfOziYoMpLT8Wdv
         BguX1ATl8wD914Gpgv4GuoLQ6wYH7aaZr/tDqmKm7ZyYywgW/aer3nWdPYv1/QSJMCoy
         1EUI+/rpus2dKhRCBp+rTNWJh4Ej660F/+x6fviWe3bkKS6lsoqILX1du6JrUHAiu7Ch
         C7h9NNBTZW5rY2v09F2YAwe/J2GOjHpPXbXhH1ZIP0SKUyTsHl7ALJin4I+eZXHEJYRp
         Kc19yuQcoWhjaHsadeLSeWMXmFuQ0pQ/1qc9/qIwDX4JBgG2OC9HIRfius86w7jYoFY+
         LEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ql+wH4qVovd9jAggtOkZvhGPFd9egOe0LH+fm0OHgS8=;
        fh=HqiWTnsKW74IM9wXfLgCKYd7qe9OS5IsIBQGWi/g7MU=;
        b=DXm4CE6Ijczhm5VMp4WbbuyZksbilnvXvGhVzMa1ZTsG+S/qT7+u/LOTXWjXfuRDqq
         PksAL+35UzxWAYuw6CmcNdQ2BWN9/UnPu47afYeth2+C+kJH28b0E6bYiFO+bT+f/8yP
         tvShELx9Sg+hwvES6FZmscWstaamVNByfI+ZI8iZx6VATxL/j2NEZmmO+CqY8Ggxd+vP
         FZtpSeq8PZ7HBsOIdn87aa7rrDvDTva/2zPTzUW0tGPdK+6P5FOaShewJYOTCVaLgeaY
         tJc0/RV7H9Vi1kumsGaFJo+sEoQjt78+V3/R8CfZuVWAnI2nejeLPvCSLCp5YoQKpr5C
         KTQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976862; x=1790581662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ql+wH4qVovd9jAggtOkZvhGPFd9egOe0LH+fm0OHgS8=;
        b=ESN3o5oyt4hVhz3mwTfI+vJ6xtOiROi/WsTjZSeKXZ22ndjPtcfhVLpMT1qco6Y474
         1Gf5q+RV8TcwLrmQgRt14p4VJmMmIYw0Za8RAcwBA9obV0RsXY8QPQ09GglIuni5Virm
         /VxAUrduUQDfNZKL/GUcETPZXUP8mA+36Da8EhrIMyQAO5DjUdNA2fEOxEm2yZDwzRgG
         PmQ0lJY9EG8EszQDYK4PWauiCbsO8Lb6WDcyuw68nov0Fvf+k2KZ/o7yDT2EUX32ccaj
         JTOSkXCMLGgarEMXfXjHK+xsNORoJP5P5I5g4i06Grq4R1ZJkR6z0j6Tl9qleFVVwC6u
         vIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976862; x=1790581662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ql+wH4qVovd9jAggtOkZvhGPFd9egOe0LH+fm0OHgS8=;
        b=RIbsPWsSpULKenj8sQ6QwLysw8iuYCK+M8OQaeC/aJjfe3DFgyf9eFnNLesADknCDP
         OleiciAgGHWjXJ46oMnz9yjJoedtKnxaCgwgK/MpeUVF7OCJSWkKKG/mFyMJjPvNCZn+
         D6pQuASvuZ5f5cZJwnH7Ff7oAkEPuR8QBsqbst63TAVzhmpKNYTDTdRko/nQoYF5cLfI
         AGmypmnpAkDI/hsmsIvtVI/X/ax9E071ivMSUPnmm9Is+gL41ULAxJsiZtKrqQX+bzQC
         cUPo+zF/Z+2cfp83wrPNOp+yKL3UGNb5UmMDrqLNbMFCB2UtxzGLe+Yp1DbxCI01Ajy2
         7nTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwB/4UXptqIo32S3wB550ykmsuHrM9BljjaGeCesgenezz25KeQI2CQhrV+l3x2vj12L/M9Vb8=@vger.kernel.org
X-Gm-Message-State: AFuF++llTQT6e0k8veQmXl7DtmIE3rbjV5NimkRUd/BNv1n+lKwYMRdq
	pvzUGHR4lA94ybS7Z1HtjqL8NZULtCZHE/IVY3EDE0gI/HcUpLjoIjCvAc8ZRPGz0IMHr3qo/xb
	qGwPiyLJfp+Np9Am3zVClRDfgG4vwdHQ=
X-Gm-Gg: AYBFou1ut8rGoPXwEnoA3A3eIA2grTEUMQBRlwNupiNzR0xPhTastM9af9/+AcgSx57
	twTDBnlP3CgeD5MRH1vyo9EAUOHse5UZ4o0MaXd/HkWGg0+TbxiH61k1fBlr3ec5JXSdWgdbd1E
	TE2+VXf+YY15lwtcCKGvKOn0ZqqiTwOrPPUlfHqmVtoXhxaRouM9iHGZNF1Z4ugjpLvhpRSijHz
	bTutsAoEfhvm2z4xWIAMJLjJuq/eIAd9mDzzs6w5GUGK5imzl2xooXOm9hHCW9ABJA63PSeEOzv
	lYPOwMcAR5FXU4G48LslbwESfXxveB6/YtRBJ3Xu50GO5Tvzo+ddEEcp
X-Received: by 2002:a2e:a9a5:0:b0:3a3:476:2e37 with SMTP id
 38308e7fff4ca-3a5fbe36d88mr21411961fa.6.1789976862279; Mon, 21 Sep 2026
 00:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13b330df140a2ee488952b4c7145e261ec884555.camel@dubeyko.com> <20260918212153.23651-1-qwe.aldo@gmail.com>
In-Reply-To: <20260918212153.23651-1-qwe.aldo@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 21 Sep 2026 16:47:24 +0900
X-Gm-Features: AcwNN1XF1zg9V9W7pIcfaTTC797llgXNMo377_BEL2cpbxL6SjSpyOdv0GuJxt8
Message-ID: <CAKFNMoneRHw=-hsGvzY+Mdktm3+EtodSU2vpNoaXZnheu+VjgQ@mail.gmail.com>
Subject: Re: [PATCH v3] nilfs2: fix checkpoint root lifetime on sysfs errors
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: slava@dubeyko.com, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 6:22=E2=80=AFAM Aldo Ariel Panzardo wrote:
>
> Hi Slava,
>
> No, wait_for_completion() without a timeout is intentional here.
>
> The kobject subsystem guarantees that the release callback will
> eventually run -- CONFIG_DEBUG_KOBJECT_RELEASE only defers it, it
> never drops it. So the wait is bounded in practice.
>
> If we used wait_for_completion_killable_timeout() and the timeout
> fired (or a signal arrived) before the release callback ran, we
> would kfree() the root while the kobject release is still pending.
> When the callback finally runs it would access freed memory -- a
> use-after-free.
>
> wait_for_completion_killable() (without timeout) has the same
> problem: if the wait is interrupted by a fatal signal, we cannot
> safely free the container because the release callback may still
> reference it.
>
> The unconditional wait_for_completion() is the only safe choice
> when the caller must free the container of an embedded kobject.
> This is the same pattern used by other subsystems (e.g.,
> blk_mq_tag_set, configfs subsystems).
>
> Aldo

Hi Aldo,

Thank you for the patch.

However, in my view, introducing a mutex for synchronization (either
by replacing the spinlock or adding a mutex alongside it) is
unnecessary and suboptimal.

nilfs_sysfs_create_snapshot_group() performs memory allocations and
sysfs node creation, which can sleep.  Holding 'ns_cptree_lock' across
this operation causes concurrent read-only callers like
nilfs_lookup_root() to block unnecessarily on a lock that originally
protected a very fast, in-memory rbtree lookup.

Note that checkpoint and snapshot mounts themselves are serialized by
'nilfs->ns_snapshot_mount_mutex', so strict mutual exclusion between
concurrent insertions is not required; we only need to eliminate the
race against nilfs_lookup_root().

Instead of converting 'ns_cptree_lock' to a mutex, I think it would be
cleaner to keep 'ns_cptree_lock' as a spinlock and structure the
creation flow so that new is fully initialized and registered with
sysfs *before* acquiring the spinlock:

1. Allocate new and initialize the basic fields required for sysfs
creation (cno, nilfs, etc.).
2. Call nilfs_sysfs_create_snapshot_group(new) *before* taking the lock.
    - On error, wait_for_completion(&new->snapshot_kobj_unregister),
      kfree(new), and return NULL.
3. If sysfs creation succeeds, acquire spin_lock(&nilfs->ns_cptree_lock),
   link new into ns_cptree, and drop the spinlock.

In nilfs_put_root(), we can keep refcount_dec_and_lock() with the
spinlock, erase the node from the tree, drop the spinlock, delete the
sysfs group, wait for completion, and free root.

Could you please update the patch to keep 'ns_cptree_lock' as a
spinlock and complete sysfs registration before inserting the root
into ns_cptree?

I think this approach should work, but please let me know if I've
missed anything.

Thanks,
Ryusuke Konishi
