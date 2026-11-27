Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769598;
	b=zCChF2l4HEwnXMtD+z3QfF/mr65q54LeWOoWCflSQ/RQKLK+wiufebnB5OBoq+QEZDJm
	 ILxgD2ujO348OrOe061LL4+EknKyFHS8P9Q1II+ytn+7aDlSMJwYBfxqdwBTN3HA5xa6S
	 XHbeLpfKR6Z6eGrTYqsgb3rT22YFWbwv7KlnRvUpgEpa3tA+mux63ZH9CJTgsAQZ8iUFt
	 eEEAqZD7/34J3EhGgQ6GSJKBfVoRx58yIU/EfRkRUZHAF91zj+bd6Nnew9WbJioOge2Xl
	 1ArOejEU9JhuYvuKAdHOO/ObWDGxre9fszZXj3o0GWbv+ynOIgjTB9lLFDkk/eaLYCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769598;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=J+jjduiNzCh5NUzPz3l6XXi61ckpOF03RHt8aLGC0fg=;
	b=tYOtKdI0/lGXpcClWd/pLXWuJ6gRRqYmyPA9moddBVo9pEmt5W8Eq4UkHdYEpOiP3Rds
	 m6kQljDfkm+2U9Lo5L6PSUmX8LweM8rP48z2vJHnv6oM89K3S4t1ND/pCdbd7sRzL1mi8
	 4PRV78LYxMIlnbehKmqwkcq/tmoWyiJ3ZrUnn/m/xScjNVqdPjFSoMFgjaZw6ojrri9Go
	 PQ7qVjYVL5f94Il+88H70b9CeyG6nahL2E58CCMF783xKvkcTMnr2jXWusS0YDjky+MAM
	 C6Nv8WRh+kuQmr44IOifXn8K5y0rUb+wumfISlukssN2ff6RKRwUmdVFxuD8ob5vEGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ef8On+gG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE0606A31C;
	Fri, 27 Nov 2026 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ef8On+gG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688651F00897;
	Fri, 27 Nov 2026 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795769598;
	bh=J+jjduiNzCh5NUzPz3l6XXi61ckpOF03RHt8aLGC0fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ef8On+gG1QPOhcfPF6FyNy9lar9ir/Zw/CKgQBYO0aK0lIkLGcjrvaMR5N7jb+TFM
	 R/v1+C3TYbIkfl72rpwPsuKeP5NHvxIt57nifZq8gTgRQNILZHehRkeA6lBIws4kI8
	 HOK/IHZBKRutCrXyXILomUFJ13Sp/JuvtzWUlfq0ZapQRh/5Qo0dVhJ/g92bUFigtH
	 Iai7sW3q2bMCXueBVcZDJQ2Pu4OgqIMQGaCBjwjLgmd8ArpleBRdv/w1YJCM/L4Pbk
	 arIFfBEnd5nKb7ArauJvqGBTiLPDa/4IkjLlJDqYC263QPkb1F83+wD+h79cqBsZCU
	 ikzOLN0zBV9iQ==
Date: Fri, 27 Nov 2026 09:53:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] namespace: allow bind mounts of ephemeral procfs
 files again
Message-ID: <20261127-pfauenauge-aussortieren-werft-b4cae52a8feb@brauner>
References: <20261126-work-mount-cant_mount-v1-0-781d911a32e1@kernel.org>
 <20261126-work-mount-cant_mount-v1-1-781d911a32e1@kernel.org>
 <2b0198ff605e865fa1b17df354511949bce70038.camel@amutable.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b0198ff605e865fa1b17df354511949bce70038.camel@amutable.com>

On Fri, Nov 27, 2026 at 09:22:03AM +0100, Alexander Mikhalitsyn wrote:
> On Thu, 2026-11-26 at 12:40 +0100, Christian Brauner wrote:
> > Commit 75f4197f1e11 ("dcache: don't put a mountpoint on a dentry
> > that's
> > being removed") made d_set_mounted() refuse dentries that
> > dont_mount()
> > was called on. I overlooked that procfs calls dont_mount() on the
> > files
> > in /proc/<pid>/{fd,fdinfo,map_files} and below /proc/<pid>/net when
> > it
> > creates them and that attach_recursive_mnt() makes a mountpoint out
> > of
> > the root of every source in case it goes beneath a mount. So
> > bind-mounting one of these files fails with ENOENT now. libpathrs
> > does
> > that in its tests, e.g., by bind-mounting /proc/1/fd/0 over
> > /proc/self/exe.
> > 
> > Nothing may be mounted on top of these files but they can be the
> > source
> > of a mount. So drop the check from d_set_mounted() again and refuse
> > such
> > a root only if the source or one of its copies would go beneath a
> > mount
> > that is already there. attach_recursive_mnt() checks the source and
> > propagate_mnt() checks each copy right after making it. The root is a
> > mountpoint by then so either we see the flag or detach_mounts() finds
> > the mount, same as before.
> > 
> > Fixes: 75f4197f1e11 ("dcache: don't put a mountpoint on a dentry
> > that's being removed")
> > Cc: stable@vger.kernel.org
> > Reported-by: Aleksa Sarai <cyphar@cyphar.com>
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  fs/dcache.c    |  5 ++---
> >  fs/namespace.c | 25 +++++++++++++++++++++++++
> >  fs/pnode.c     |  6 ++++++
> >  fs/pnode.h     |  2 ++
> >  4 files changed, 35 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/dcache.c b/fs/dcache.c
> > index ba17f49f8a636..b734ce65e6377 100644
> > --- a/fs/dcache.c
> > +++ b/fs/dcache.c
> > @@ -1628,8 +1628,7 @@ static __cacheline_aligned_in_smp
> > DEFINE_SEQLOCK(d_set_mounted_lock);
> >   *
> >   * Only one of d_invalidate() and d_set_mounted() must succeed.  For
> >   * this reason take rename_lock, d_set_mounted_lock and d_lock on
> > dentry
> > - * and ancestors.  Likewise for dont_mount() which marks a dentry
> > that
> > - * is being removed under d_lock.
> > + * and ancestors.
> >   */
> >  int d_set_mounted(struct dentry *dentry)
> >  {
> > @@ -1647,7 +1646,7 @@ int d_set_mounted(struct dentry *dentry)
> >  		spin_unlock(&p->d_lock);
> >  	}
> >  	spin_lock(&dentry->d_lock);
> > -	if (!d_unlinked(dentry) && !cant_mount(dentry)) {
> > +	if (!d_unlinked(dentry)) {
> >  		ret = -EBUSY;
> >  		if (!d_mountpoint(dentry)) {
> >  			dentry->d_flags |= DCACHE_MOUNTED;
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index aecd05ac01705..443a8e3b74f9b 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2561,6 +2561,21 @@ int count_mounts(struct mnt_namespace *ns,
> > struct mount *mnt)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Would @source_mnt or a copy of it go beneath a mount that is
> > already at
> > + * @mp on @parent? Call under namespace_sem, without mount_lock.
> > + */
> > +bool mount_goes_beneath(struct mount *parent, struct mountpoint *mp,
> > +			struct mount *source_mnt)
> > +{
> > +	struct mount *q;
> > +
> > +	guard(mount_locked_reader)();
> > +	q = __lookup_mnt(&parent->mnt, mp->m_dentry);
> > +	/* a moved @source_mnt is gone from there by then */
> > +	return q && q != source_mnt;
> > +}
> > +
> >  enum mnt_tree_flags_t {
> >  	MNT_TREE_BENEATH = BIT(0),
> >  	MNT_TREE_PROPAGATION = BIT(1),
> > @@ -2677,6 +2692,16 @@ static int attach_recursive_mnt(struct mount
> > *source_mnt,
> >  	if (err)
> >  		return err;
> >  
> > +	/*
> > +	 * Don't mount on top of a root that dont_mount() was called
> > on. It's
> > +	 * a mountpoint now so a later detach_mounts() will find it.
> > +	 */
> > +	if (cant_mount(root.mp->m_dentry) &&
> > +	    mount_goes_beneath(dest_mnt, dest_mp, source_mnt)) {
> > +		err = -ENOENT;
> > +		goto out;
> > +	}
> > +
> >  	/* Is there space to add these mounts to the mount
> > namespace? */
> >  	if (!moving) {
> >  		err = count_mounts(ns, source_mnt);
> > diff --git a/fs/pnode.c b/fs/pnode.c
> > index 5f07fa14099bf..4514e75311972 100644
> > --- a/fs/pnode.c
> > +++ b/fs/pnode.c
> 
> Hi Christian,
> 
> > @@ -351,6 +351,12 @@ int propagate_mnt(struct mount *dest_mnt, struct
> > mountpoint *dest_mp,
> >  			err = count_mounts(n->mnt_ns, this);
> >  			if (err)
> >  				break;
> > +			/* what is already there would end up on
> > this root */
> > +			if (cant_mount(topmost_overmount(this)-
> > >mnt.mnt_root) &&
> > +			    mount_goes_beneath(n, dest_mp,
> > source_mnt)) {
> > +				err = -ENOENT;
> > +				break;
> > +			}
> 
> Please correct me if I'm wrong, but shouldn't we do this check before
> count_mounts()? AFAIU, it changes ns->pending_mounts and then I can't
> see where we clean it up on the error path.

ns->pending_mounts is reset in the error path of
attach_recursive_mounts().
