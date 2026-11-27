Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769940;
	b=V6+/7FSrWbN2t3NTR9pkpof6tu7Yb7ODhJc7w8y29lhYhTPL85WjVAFRzPZIxk1q9j7d
	 51VEBr48YtAQpVsUP9uymRy+5c0l5RuebMJAZK0Kof7YplFwRCcLbpz/+xBxhNi9Kn/HI
	 ZKX/wBe7PGwamotkHeusWPaFnBhWGb9/+vHQvD+zRIB0/lpmbrCCMibW98RrdoiVa/5ST
	 73Qg8DfkxTu4f1UDG58mhjZzitceYpVoVLJotTwO49Uw9IptjeopskOJQotUGuY4zHUJi
	 9raNs/v8Kk/4fBlBwnEh+TPqxRE+DeLc1l7XK0w7ra9bY4enSj72vcGFvjzJO4x2NMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=g58b3SLE2EWJpKRt/jVtxSJonlTryZjWNcM+t1Wmi/c=;
	b=udeeiL0qU+pq1SfCePUohIXqHWuaRAL56cubvIzZ+V2mBa9ZKbc0ZqIBHV0JvZ9pcoJ+
	 WykDAOUntkgFLZrmyvlpx/BGfTkerohRsk8FcZL0ZL6SIPUopn/8cKMAbUhCpGIHB0CIZ
	 KjmOW8mZYMx03yV+2AURSjLSqDQUY5sUPqU6e/zEknQtcEKwEQIwaXDJ4UKImcy+PAKA9
	 2YtVd6DwOF7LNWw30vgO7nfazqNQjbZpdGwVZds0hIM+vg5V4Kvq3Kcvxfu1mIEkt1yMu
	 seXZD+tnWWDtCdEKeV97HVAW0+NGWeCyPlqXF8Na/dzrQqvpCHjPAEUUrZkub4LiCsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SwnHo+eU;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6454606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6454606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=SwnHo+eU
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso406703166b.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 00:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795769938; x=1796374738; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=g58b3SLE2EWJpKRt/jVtxSJonlTryZjWNcM+t1Wmi/c=;
        b=SwnHo+eUoEz7etL1l6BRKcZ26/wJTbUbULuHh9q7XREOFWaR04m7gXaY7+zOHsys9j
         xFuyA+Hp6yuwYKIZsOWPzShIBisVZ4xORJJmG/B9saQof2d2hoCfHb4ZpA6yWZx7Jh0o
         Ue7ktzm0Z+Iz1jjtjyF14eYwfb9auMqUS12t7Z8vwkfW9zb/3MuJF0oCFwNymSaLTHtc
         /xkNC5Sbj0dxGCmtUkmbSr69v7sO2VwUrJIiYP/Mtatz7TjGYinhRl3G+G6Pm1ZGjxp/
         CcBjWI6js7zF7K7mKxFYcWGqW9r4KjaXGDMsYP2cIiH+GTCoWmF4SwYCi42m1gWidYK8
         k9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769938; x=1796374738;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g58b3SLE2EWJpKRt/jVtxSJonlTryZjWNcM+t1Wmi/c=;
        b=KptU2iyWSv7r6rHfrQq4sr8cmYJt5eicKfkcPNEREbMgnn8PS550mI6XTf6fKB/q4f
         cJJdqN73kLgzfzxvjsjJ/e6uZdFmHZZ35JCHVxdzFtGMZNkyTifWtuvRu8hpY6JkJahz
         Ni31DdfLEdpRhMqklL3C2GcdT/xto/Z0OVMqofzzWdsOwZHxh8UpN4t2donnqmLPF/8z
         7X84jtN8w29P+/7CQHM5GaWFsfRV1zRaTXQprAMjm4AnjW7Bcq3pl5PfIE4DP+Kab4B8
         hTcjhkMHPJByo7kU5B/AQ2H+aotHs/Q8HzODLiNXpNqaGFi9x+UyzvDJYXfi0mSItCFm
         OgOw==
X-Forwarded-Encrypted: i=1; AL+hErHUAZpRBzrNBfIADM/8yBsfdwR+5hdFn5O0ItWgKDx3ki7cN0kjaBbNcP8a69QpFzaDiNGhTMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+MX8RWFrCIWVqXy5YssOdb+rSGO/0/Ng1Zf2NfCplaID9ZCYP
	M3zTzkvjVdFIOsAGrgC59hD738q7N1255ECZf+T8pxTz16zM3m20z+6tCqrBInbCkGmN
X-Gm-Gg: AZFdTZed6jXlTce6H2//iSkDSwwFWaqVnYnwzAPef142D2wUvLbtxzrerqy1aQ3gWcl
	ZVM9FVBpnEdhLiX73agHDIiQY5znUDdm+djxO+td6wnV0PlhEI3Pj522/Se9y3bd0Rh7e+1Q7ZD
	lpjjxRkRSZDijO64PccldthDuKqxWJ0LuJWtQiAmKsepFbpZGcWcCdrdU+XUCWY70/EL2Tkw4nN
	peZyUqq1AgWcsrr8XC1KAK9v7ClH/3azaXkWCHEbu4z/Yi9xI2DObuIhXiop8DaSlMAawE9kXGy
	r1bS21lEnBjVRHahKuSb8pyTbKpvCCF+SZlVUWe88UcJfx8q1JYmJR81WPiug90Au0d6tV3Sq4P
	ZgN5W0kiekj186p6QkUbk83d2zOxSP9zTL9lGN/Lbl0720RdardAlRDHZWK4/hJxa2+itD3ZUeY
	SHuNQ3J4/w4sQSgQOuegl0oOSrqyGG/juvDdhv4SruwAe6qf8c3SVzmsLx/WvQ+jM+ytioZHwWs
	4TpIOUsvk3mXsZEJrmY3hSSjQQkC+u+Dr3AeKDhunnB+SnbtUmBLO+P+/0lIrO+AzPHvrmet4Ih
	oO1fFCKs9LIXKuH8WTP+1Ye/VJrAYXL5e2BAOJVGEFmPHonsSViu3jKBarz2h9AuLmUaUW7+aQW
	zCfjCpClMo9mZ
X-Received: by 2002:a17:906:140f:b0:c49:bc1f:fe2d with SMTP id a640c23a62f3a-c513a880a2emr1586623566b.28.1795769938110;
        Fri, 27 Nov 2026 00:58:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-240.customers.d1-online.com. [80.187.84.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51beef91efsm204872566b.14.2026.11.27.00.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:58:57 -0800 (PST)
Message-ID: <df0012048defc0f646155d0a164da1d9e8b823d3.camel@amutable.com>
Subject: Re: [PATCH 1/2] namespace: allow bind mounts of ephemeral procfs
 files again
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 09:58:56 +0100
In-Reply-To: <20261126-work-mount-cant_mount-v1-1-781d911a32e1@kernel.org>
References: <20261126-work-mount-cant_mount-v1-0-781d911a32e1@kernel.org>
	 <20261126-work-mount-cant_mount-v1-1-781d911a32e1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-26 at 12:40 +0100, Christian Brauner wrote:
> Commit 75f4197f1e11 ("dcache: don't put a mountpoint on a dentry
> that's
> being removed") made d_set_mounted() refuse dentries that
> dont_mount()
> was called on. I overlooked that procfs calls dont_mount() on the
> files
> in /proc/<pid>/{fd,fdinfo,map_files} and below /proc/<pid>/net when
> it
> creates them and that attach_recursive_mnt() makes a mountpoint out
> of
> the root of every source in case it goes beneath a mount. So
> bind-mounting one of these files fails with ENOENT now. libpathrs
> does
> that in its tests, e.g., by bind-mounting /proc/1/fd/0 over
> /proc/self/exe.
>=20
> Nothing may be mounted on top of these files but they can be the
> source
> of a mount. So drop the check from d_set_mounted() again and refuse
> such
> a root only if the source or one of its copies would go beneath a
> mount
> that is already there. attach_recursive_mnt() checks the source and
> propagate_mnt() checks each copy right after making it. The root is a
> mountpoint by then so either we see the flag or detach_mounts() finds
> the mount, same as before.
>=20
> Fixes: 75f4197f1e11 ("dcache: don't put a mountpoint on a dentry
> that's being removed")
> Cc: stable@vger.kernel.org
> Reported-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/dcache.c=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++---
> =C2=A0fs/namespace.c | 25 +++++++++++++++++++++++++
> =C2=A0fs/pnode.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> =C2=A0fs/pnode.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A04 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index ba17f49f8a636..b734ce65e6377 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1628,8 +1628,7 @@ static __cacheline_aligned_in_smp
> DEFINE_SEQLOCK(d_set_mounted_lock);
> =C2=A0 *
> =C2=A0 * Only one of d_invalidate() and d_set_mounted() must succeed.=C2=
=A0 For
> =C2=A0 * this reason take rename_lock, d_set_mounted_lock and d_lock on
> dentry
> - * and ancestors.=C2=A0 Likewise for dont_mount() which marks a dentry
> that
> - * is being removed under d_lock.
> + * and ancestors.
> =C2=A0 */
> =C2=A0int d_set_mounted(struct dentry *dentry)
> =C2=A0{
> @@ -1647,7 +1646,7 @@ int d_set_mounted(struct dentry *dentry)
> =C2=A0		spin_unlock(&p->d_lock);
> =C2=A0	}
> =C2=A0	spin_lock(&dentry->d_lock);
> -	if (!d_unlinked(dentry) && !cant_mount(dentry)) {
> +	if (!d_unlinked(dentry)) {
> =C2=A0		ret =3D -EBUSY;
> =C2=A0		if (!d_mountpoint(dentry)) {
> =C2=A0			dentry->d_flags |=3D DCACHE_MOUNTED;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index aecd05ac01705..443a8e3b74f9b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2561,6 +2561,21 @@ int count_mounts(struct mnt_namespace *ns,
> struct mount *mnt)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/*
> + * Would @source_mnt or a copy of it go beneath a mount that is
> already at
> + * @mp on @parent? Call under namespace_sem, without mount_lock.
> + */
> +bool mount_goes_beneath(struct mount *parent, struct mountpoint *mp,
> +			struct mount *source_mnt)
> +{
> +	struct mount *q;
> +
> +	guard(mount_locked_reader)();
> +	q =3D __lookup_mnt(&parent->mnt, mp->m_dentry);
> +	/* a moved @source_mnt is gone from there by then */
> +	return q && q !=3D source_mnt;
> +}
> +
> =C2=A0enum mnt_tree_flags_t {
> =C2=A0	MNT_TREE_BENEATH =3D BIT(0),
> =C2=A0	MNT_TREE_PROPAGATION =3D BIT(1),
> @@ -2677,6 +2692,16 @@ static int attach_recursive_mnt(struct mount
> *source_mnt,
> =C2=A0	if (err)
> =C2=A0		return err;
> =C2=A0
> +	/*
> +	 * Don't mount on top of a root that dont_mount() was called
> on. It's
> +	 * a mountpoint now so a later detach_mounts() will find it.
> +	 */
> +	if (cant_mount(root.mp->m_dentry) &&
> +	=C2=A0=C2=A0=C2=A0 mount_goes_beneath(dest_mnt, dest_mp, source_mnt)) {
> +		err =3D -ENOENT;
> +		goto out;
> +	}
> +
> =C2=A0	/* Is there space to add these mounts to the mount
> namespace? */
> =C2=A0	if (!moving) {
> =C2=A0		err =3D count_mounts(ns, source_mnt);
> diff --git a/fs/pnode.c b/fs/pnode.c
> index 5f07fa14099bf..4514e75311972 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -351,6 +351,12 @@ int propagate_mnt(struct mount *dest_mnt, struct
> mountpoint *dest_mp,
> =C2=A0			err =3D count_mounts(n->mnt_ns, this);
> =C2=A0			if (err)
> =C2=A0				break;
> +			/* what is already there would end up on
> this root */
> +			if (cant_mount(topmost_overmount(this)-
> >mnt.mnt_root) &&
> +			=C2=A0=C2=A0=C2=A0 mount_goes_beneath(n, dest_mp,
> source_mnt)) {
> +				err =3D -ENOENT;
> +				break;
> +			}
> =C2=A0			type =3D CL_MAKE_SHARED;
> =C2=A0		} while ((n =3D next_peer(n)) !=3D m);
> =C2=A0	}
> diff --git a/fs/pnode.h b/fs/pnode.h
> index b029db225f33c..0fb217c48f17a 100644
> --- a/fs/pnode.h
> +++ b/fs/pnode.h
> @@ -59,6 +59,8 @@ struct mount *copy_tree(struct mount *, struct
> dentry *, int);
> =C2=A0bool is_path_reachable(struct mount *, struct dentry *,
> =C2=A0			 const struct path *root);
> =C2=A0int count_mounts(struct mnt_namespace *ns, struct mount *mnt);
> +bool mount_goes_beneath(struct mount *parent, struct mountpoint *mp,
> +			struct mount *source_mnt);
> =C2=A0bool propagation_would_overmount(const struct mount *from,
> =C2=A0				 const struct mount *to,
> =C2=A0				 const struct mountpoint *mp);
