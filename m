Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793189005;
	b=gAiZbinf2aOfdIH13MFjzOMAlMIhEPNbNftm8dw6zbm6edpbfztunRByHpaEZQT+u0i2
	 FdsPjyPsRnq5+W6a/PO/5XwlhDFJLjJ++6sNxzTqdLnoszbRMe3YsSOrZpk9zyDjCgnag
	 IPZXDoUaIgs1RQ6nxYANV8L3DI7MORIN6PJDjR05sCx63BO29WeFLk2xlr09W2BdEP7pp
	 //fD088LprZsA6FdgfP2bEexGQUCMZn9hI0+uew9yytWDxh2eMr78xzK/MuUyUFT1IBN7
	 ncszahRj7eaYmxex2pL1a0fvfIQqAqmhNyqXe4LY7wRUsgyCZI9euDhKd2VqMsdTJlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189005;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=78YrWNBjFPUJ/rfjtCJQ1848U05YgSyGICYPO5oye7Q=;
	b=QySIF+CVxBD6KIrOoUUOZFa55vq6VqQPFbjNpE6kA355LQhHkgeKudhI82SR35+WQuAu
	 MgXOg84jhiOlppx28NdcubJv5li/DsaG/bPgDZ4NoAeB3AZrgeXz5B6RdRfWV694lcpwF
	 yNKCyZOywI0M0JINWA5VebjyLnoHrgcIrnTP8z2di+juesn5kpcjpmClmWqzhfSjMUt8g
	 1b0pFNiTCXZpydXZpFO/1x2pZ/984roimjYTHQ9Qr7wTgb/kDVfDY5XvctPpmVc54Oss+
	 rTeebbSSWPU6W2XOvTQdTdOaB8lVbtMWD4/fMOK25TMGKBgxN+DyOYnqQnLIjnMapAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Yw4WBGmS;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A6606A31A;
	Wed, 28 Oct 2026 12:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 909A6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Yw4WBGmS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=78YrWNBjFPUJ/rfjtCJQ1848U05YgSyGICYPO5oye7Q=; b=Yw4WBGmS8DyjEYEgr1tyegbftO
	EUsTQ1rIjPYYKr7UELpOnuGe29K12ZKyq9hZjlRJoHq0TVPYzpxUidFl3xpJJRsIGXATTtTWlWD/v
	r6H9k+fUoDcbFNeFk9on0phxi8n4K3+40VS9OO+gVZzX4RpQB9GycBucgfqrRo3FCTTLrEsZo9ifO
	2dGnkaIhn8XcKGL34auO4E2HaVeyrbnjBXlKn0yTFNVEf+0bdOktmiDMint8d8m45TOxQW8vrrSDJ
	EQhUqhXOYILe1HJCutjc3XY/PuMmaEXkyd31CP97aqogl65dFcr5zIXTiOdMyoc1XYCHFil+FkL4o
	DzPNrH8Q==;
Received: from [188.250.79.109] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xM2NA-00Cq9K-DU; Wed, 28 Oct 2026 13:03:16 +0100
From: Luis Henriques <luis@igalia.com>
To: Leon Ming <leonming@meta.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  <fuse-devel@lists.linux.dev>,
  <linux-fsdevel@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  Joanne
 Koong <joannelkoong@gmail.com>,  <stable@vger.kernel.org>
Subject: Re: [PATCH] fuse: set dentry epoch before making the dentry visible
In-Reply-To: <20261026201101.3915217-1-leonming@meta.com>
References: <20261026201101.3915217-1-leonming@meta.com>
Date: Wed, 28 Oct 2026 12:04:44 +0000
Message-ID: <87se1qhvz7.fsf@igalia.com>
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
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26 2026, Leon Ming wrote:

> fuse_lookup(), create_new_entry(), fuse_create_open() and
> fuse_direntplus_link() all record the connection epoch in the new dentry
> only after d_splice_alias() or d_instantiate() has published it.  A new
> dentry starts with an epoch of zero (fuse_dentry_init()), and the
> connection epoch starts at one, so in that window the dentry is hashed
> but fails the epoch check in fuse_dentry_revalidate().
>
> d_splice_alias() hashes the dentry and wakes the lookups waiting on it
> in d_alloc_parallel().  A waiter, or a concurrent lookup_fast() that
> finds the dentry in the hash, calls ->d_revalidate(), gets 0 and
> d_invalidate()s the dentry the original lookup is about to return.  The
> caller still gets a valid dentry, but it is now unhashed.  One visible
> result is that readlink() of /proc/self/fd/N for an O_PATH fd opened on
> that path returns "<path> (deleted)" for a file that exists.
>
> This shows up when many threads look up the same uncached path at once.
> TypeScript's native compiler (tsgo) resolves real paths with
> open(O_PATH) + readlink(/proc/self/fd/N), and when it type-checks a
> project in a FUSE-backed checkout it intermittently caches the
> "(deleted)" path and fails to resolve a package that is installed.
>
> Before commit 5a6baf204610 ("fuse: fix uninit-value in
> fuse_dentry_revalidate()") initialised the epoch to zero, it held
> whatever the slab left there, so the check usually passed by accident.
>
> Set the epoch on the new dentry before it is published.  If
> d_splice_alias() returns an existing alias, keep setting the epoch on
> that dentry afterwards, as before.
>
> Reproducer: N processes start together and each run open(O_PATH) +
> readlink(/proc/self/fd/N) over the same list of files in a freshly
> mounted FUSE filesystem, counting results that end in " (deleted)".
> On this tree under UML (16 CPUs, squashfuse_ll, 6000 files, 32
> processes, a fresh mount per round):
>
>   before: 3519 of 10.75M lookups "(deleted)", in 51 of 56 rounds
>   after:  0 of 10.75M lookups
>
> On v7.1-based production kernels with EdenFS the same test returned
> "(deleted)" for 5.5% of lookups.
>
> Fixes: 2396356a945b ("fuse: add more control over cache invalidation beha=
viour")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leon Ming <leonming@meta.com>
> ---
>  fs/fuse/dir.c     | 16 ++++++++++++----
>  fs/fuse/readdir.c |  1 +
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 28516a1760e..b7af3f5a3bb 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -644,13 +644,21 @@ static struct dentry *fuse_lookup(struct inode *dir=
, struct dentry *entry,
>  	if (inode && get_node_id(inode) =3D=3D FUSE_ROOT_ID)
>  		goto out_iput;
>=20=20
> +	/*
> +	 * Set the epoch before d_splice_alias() makes the dentry visible.
> +	 * Otherwise a concurrent lookup can find it with an epoch of zero, fail
> +	 * fuse_dentry_revalidate() and invalidate it under us.
> +	 */
> +	fuse_dentry_set_epoch(entry, epoch);
>  	newent =3D d_splice_alias(inode, entry);
>  	err =3D PTR_ERR(newent);
>  	if (IS_ERR(newent))
>  		goto out_err;
>=20=20
> -	entry =3D newent ? newent : entry;
> -	fuse_dentry_set_epoch(entry, epoch);
> +	if (newent) {
> +		entry =3D newent;
> +		fuse_dentry_set_epoch(entry, epoch);
> +	}

I believe this is very unlikely to cause problems, but we're slightly
changing the behaviour here.  Before we were setting the epoch only in one
of the dentries.  With this patch we're *always* setting the epoch in the
dentry being looked up, *and* possibly in an alias returned by
d_splice_alias().

Can you see any possible issues with this change?

>  	if (outarg_valid)
>  		fuse_change_entry_timeout(entry, &outarg);
>  	else
> @@ -907,8 +915,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, =
struct inode *dir,
>  		goto out_err;
>  	}
>  	kfree(forget);
> -	d_instantiate(entry, inode);
>  	fuse_dentry_set_epoch(entry, epoch);
> +	d_instantiate(entry, inode);
>  	fuse_change_entry_timeout(entry, &outentry);
>  	fuse_dir_changed(dir);
>  	err =3D generic_file_open(inode, file);
> @@ -1030,6 +1038,7 @@ static struct dentry *create_new_entry(struct mnt_i=
dmap *idmap, struct fuse_moun
>  		fuse_chan_queue_forget(fm->fc->chan, forget, outarg.nodeid, 1);
>  		return ERR_PTR(-ENOMEM);
>  	}
> +	fuse_dentry_set_epoch(entry, epoch);
>  	kfree(forget);
>=20=20
>  	d =3D d_splice_alias(inode, entry);
> @@ -1040,7 +1049,6 @@ static struct dentry *create_new_entry(struct mnt_i=
dmap *idmap, struct fuse_moun
>  		fuse_dentry_set_epoch(d, epoch);
>  		fuse_change_entry_timeout(d, &outarg);
>  	} else {
> -		fuse_dentry_set_epoch(entry, epoch);
>  		fuse_change_entry_timeout(entry, &outarg);
>  	}
>  	fuse_dir_changed(dir);
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 83a1cc46fe4..ffce4031892 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -239,6 +239,7 @@ static int fuse_direntplus_link(struct file *file,
>  		if (!inode)
>  			inode =3D ERR_PTR(-ENOMEM);
>=20=20
> +		fuse_dentry_set_epoch(dentry, epoch);
>  		alias =3D d_splice_alias(inode, dentry);
>  		d_lookup_done(dentry);
>  		if (alias) {

Personal preference: I'd move the other fuse_dentry_set_epoch() into the
other branch ("if (!d_in_lookup(dentry) ... " ).

Cheers,
--=20
Lu=C3=ADs
