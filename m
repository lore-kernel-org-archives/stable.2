Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331DC1DDA18
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791150759; cv=none; b=iaqyeGjtggo8MC/nkh4c2KAz7VHvaGYOsY+zUx4Ul4TUm2zOBBky92IGGcQx3j+zLcFCgwf+UWQneSMOvvOrtBce/NzJsuQOlhFGEkB2fU/+kaIbSXV01XMLpyWWrPkhS9umBf0KaZU2BhO+mGkdJzHLhqRa4BnPNHqpYsgacXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791150759; c=relaxed/simple;
	bh=LHkjvCKwcJJYIrVWirqkuYvEDSFnpbKHR8iSmvZVNWM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=KSzG9Vp/g9SHJZP6wiX5sANFRM8qMZ5VyDqAjYg+WPP7j/MivC9aIF4fp3Pz8jCOCq5dk1XDvJ/j2QNEtg4rnyeN+lEcx20ehytv77WOC01L8V+McSuBKiYXxch5mL/bnCeE/y5ERGQzBpGlDCGnzTgK4ZQpk9PQ/uQKN1Lcg/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZdIjL6h2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBNWqStq; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZdIjL6h2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBNWqStq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B1957A01AB
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 17:52:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 04 Oct 2026 17:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1791150755; x=1791237155; bh=3iy3gzplFIzK0oo8x5TzMGzgroYAGejdHKC
	gp9FixDs=; b=ZdIjL6h2yB2k8w/kE1K7PeMz5csrzboWtsYNmgvLuecyt4LMvN8
	QEWdupOIoVh83H5c+g8csuPzRAue6IuU3S8DqIgqpZkX1ZDgfJMFsTmSzzIEivgh
	lLwyyfouSFMuKw+Hv6lFfczmkh55mcI6qYyLUWAeMosl1MtgHprnf5mydv6QiN8D
	9/ZaQvn4fcScUwy93Fb9KyZENBYiXb9kCZhoKenRfBgpWayAUocEJxWfZUr0VpEA
	ljTq8BnhBGaQoCTt51ynGRQr5Nu8oTOtWZSCw3VMwBhBZTUxel+PF0T1PFsHUFOv
	o47L7D024LfJa9mmm79y06Xlz95dQSzTapQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791150755; x=
	1791237155; bh=3iy3gzplFIzK0oo8x5TzMGzgroYAGejdHKCgp9FixDs=; b=t
	BNWqStqn7SCevUZ1a5O7V/ot+H7XjzaGoRA8rijd9cjHNelNvmPBWA0uTdPlsnJ1
	pIjDYSzxlHKAmFDrS1tHhcKxncqGgIaR5FK5d5KcYlW2ewwpE3jZ6UVtG2vMNxVu
	lsxwnUDP8zmj35lVN9Ga5LTQNX98Izmkoah/zyfej/DmbAgrqX2YyIbcjoqJbO2K
	sfWn96HgJZbeYsNTV/Vx+9OSyVtZck++sgqAoXHBAH/HfJePW0cXrhR1OyT8IMYm
	mVwml1dHlVXo6mGJYbKqZVBvxOV0ryf8hIAe9biIUuua8diTRBiLgYN/N8Y9SgRB
	9MFT2LEGlkt9f7/luiE8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791150755; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JR6IL1cYwXIxeM3xNQK/1RSmY2I2Qd17N49ya8T+xg+6kSA
	V/vkq2CpuLLhAKYQ3fIbZAaFKNa5GhXiNesNg40bZUAKdVLojmTFadKQ7GwOeo61
	G3IT6D/IP0EiHlTe/ah6UC+ACFjrj1l3bIsaPo84QqY/5uAZf84wRv9q2JNugyk3
	B8hYrzr6BeCaNhdNWbGdR8lEFWO2A7qmBRtdQGjHMa24LkS/i5LtV0OgfBatLCuk
	WF32sBgHUHN/tocbebkAvIqItN/E9Oa8A9I6Nqtu78fFKI2Oz/LjShvc6ZUwwNJP
	12UYGyyvdKr5KyNXK4OGU1YhHEFRx3krcp3ehVg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:5j24Q3aiayJpCkb82bY2/76Y4ZmOqVdd8Ysr+rbMniI=:LHkjvCKwcJJYIrVWirqkuYvEDSFnpbKHR8iSmvZVNWM=;
X-ME-Sender: <xms:osrCanX_lZvwunBGhmyGGWOkXxa4pfRzyD8KM8SxMSIfrOLZfU8N9Q>
    <xme:osrCairksShLasa3EmLxyR8OC5C6nJ7gP2loBd9QvArYS9cfzOjwDeGA7Rl6akA-O
    iMNvSXdmMb_PLGq784OhE5tb6yE58OpyWUuA51Oc3i3DGGF7A>
X-ME-Received: <xmr:osrCauC5kUWJ-5En3V_z0HhhXfH1IHxIWHQXhHfGu0Y54lg_1yCye472MBCWhwikAlqNjwCLILCxLEZ0haXEBN0OS2O8KfI>
X-ME-Proxy-Cause: dmFkZTELw3NzVe4CSdyd/3EeOMxy34RMNfvct+a14iA3L+E4I4Ey7qTxw/G9k1c02o8BP4
    mTbdxFZkS5RX3R7a8tB2YfXCzxQIPUxmxqPdXf1YUJd7neQygY5BKkNZoX5nC7b4MNiPn7
    rOs8bIjCwqzcCctsfNbvJbApjyH/pcT/hbGPc47ArFWHuo1C6gnbi07lJ8AUOL6uMfrRa2
    Yzx+5/ncZXtKkskY7Lin2aBE35tJz8lSgz50WW/2MF2t4eqloVKyh6Wm2vhn5JUy9GYwc0
    eyFM9+ucXjERtAOJgHqtJ37ruyWBm+W46/I3I8sW5ZdMRzg33zlpgONx8YF2DCHGfqmtUZ
    zQ7vESdGQUBrGN2GIwA9yh62x8L5IoajyfzNFi26u0ZPgLSN09MNGIAHrsQnyVX2X4+TUe
    EBSh8R+pkdElDuRkPyRIY9yEEtE/eR2Ta9oSre697fv+HKzbP8P9+u5I7em6UIaFHS9CoA
    GJYlgIcbvnCQKD+E0p7+05o0bocVlHd4FbjwxJLOGA9y2JteDvio9L7qWSUeMsqSSYT7n2
    eROgkl0/kAcMrARk9da6IpDK16t7whiJmeShQBeFlwgR/4fG0LSZVqlAI+opmQm42kuFZd
    6oY0nN1P89fRQhU3l1qdYu+MYpEeY8kgxiNNPJ6UV+/jYaStTT0yDNmfFXGA
X-ME-Proxy: <xmx:osrCaujbjf8Ywhy__C1gWnhPkMIu7mZ_qpzjzS1krN3nIKmmCeLL0Q>
    <xmx:osrCasZ6mcABoZCIN2sZBt5W9_Dg6Lk9hiT-LH7INE3LpWzJj25DUA>
    <xmx:osrCavk6oYqZ7IC05J5Ud778wbGTLbHgFEvFMgxdh3fIXrri4X7HVg>
    <xmx:osrCaiiUqLZzlBHkxi-jb9poiEH2DMm_4Zv6hbfCBFbHC2bgzK5FIA>
    <xmx:o8rCalW-nsszH00SiIg-etaMZCGL1whASqmWNeA4V9c0NYG_4-T24btX>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 17:52:31 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Jann Horn" <jannh@google.com>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
Subject:
 Re: [PATCH 19/21] readdir: take no inode lock on an immutable directory
In-reply-to: <20261002-work-mount-fixes-4-v1-19-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
  <20261002-work-mount-fixes-4-v1-19-dd44b89d44ce@kernel.org>
Date: Mon, 05 Oct 2026 08:52:27 +1100
Message-id: <179115074757.37859.15037820357119617398@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 02 Oct 2026, Christian Brauner wrote:
> iterate_dir() takes the directory's i_rwsem shared and holds it across
> ->iterate_shared(). For a directory that never has an entry and is
> never removed the lock keeps nothing still, it only orders every reader
> and every writer of that inode behind each other.
>=20
> For the directory of a nullfs instance that matters. The instance of
> the initial mount namespace is the root of every empty mount namespace
> and the private instance is the root of every kernel thread, so one
> inode is shared across users who have nothing else in common. And a
> reader can hold the lock for as long as it likes: back the getdents()
> buffer with a mapping of a file on a FUSE mount of your own, let the
> copy of "." and ".." fault and let the server wait. Queue an exclusive
> taker behind it, a mkdir() in that directory goes through start_dirop()
> before the read-only mount is reported, and from then on every lookup
> that misses the dcache in that directory, every create and every mount
> on it waits until the server answers. One user of an empty mount
> namespace stalls all the others.
>=20
> Add FOP_IMMUTABLE for the file operations of a directory that never
> changes and is never removed and let iterate_dir() skip the lock for
> it. The flag never changes for a file, ->f_pos is protected by
> f_pos_lock since directories are FMODE_ATOMIC_POS, IS_DEADDIR can't be
> set on such a directory and neither touch_atime() nor fsnotify take
> i_rwsem. Set it on the nullfs directory. The placeholder directories of
> libfs never have an entry either but their owners remove them, so they
> keep the lock.

It isn't strictly necessary that the directory never changes.  It is
only necessary that the filesystem doesn't depend of i_rwsem for
exclusion between iterate_dir() and directory changes, either because
there are no changes, or because it uses internal locking.

This flag would be good for procfs - those directories that need to
d_alloc_parallel() any name they find that isn't already is dcache.
My current approach is to drop the lock and reclaim it after
d_alloc_parallel().  With FMODE_ATOMIC_POS set there would be nothing
left to fix.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>=20
> Fixes: 9d4e752a24f7 ("namespace: allow creating empty mount namespaces")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/nullfs.c        |  1 +
>  fs/readdir.c       | 13 +++++++++----
>  include/linux/fs.h |  2 ++
>  3 files changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nullfs.c b/fs/nullfs.c
> index f76b87cf1841..bfc04bca3940 100644
> --- a/fs/nullfs.c
> +++ b/fs/nullfs.c
> @@ -44,6 +44,7 @@ static const struct file_operations nullfs_dir_operations=
 =3D {
>  	.lock		=3D nullfs_nolock,
>  	.flock		=3D nullfs_nolock,
>  	.setlease	=3D nullfs_nolease,
> +	.fop_flags	=3D FOP_IMMUTABLE,
>  };
> =20
>  static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *=
fc)
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 76bb1ae3a450..f2288841337a 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -87,6 +87,8 @@ EXPORT_SYMBOL(wrap_directory_iterator);
>  int iterate_dir(struct file *file, struct dir_context *ctx)
>  {
>  	struct inode *inode =3D file_inode(file);
> +	/* never an entry, never removed: nothing for the lock to keep still */
> +	bool locked =3D !(file->f_op->fop_flags & FOP_IMMUTABLE);
>  	int res =3D -ENOTDIR;
> =20
>  	if (!file->f_op->iterate_shared)
> @@ -100,9 +102,11 @@ int iterate_dir(struct file *file, struct dir_context =
*ctx)
>  	if (res)
>  		goto out;
> =20
> -	res =3D down_read_killable(&inode->i_rwsem);
> -	if (res)
> -		goto out;
> +	if (locked) {
> +		res =3D down_read_killable(&inode->i_rwsem);
> +		if (res)
> +			goto out;
> +	}
> =20
>  	res =3D -ENOENT;
>  	if (!IS_DEADDIR(inode)) {
> @@ -112,7 +116,8 @@ int iterate_dir(struct file *file, struct dir_context *=
ctx)
>  		fsnotify_access(file);
>  		file_accessed(file);
>  	}
> -	inode_unlock_shared(inode);
> +	if (locked)
> +		inode_unlock_shared(inode);
>  out:
>  	return res;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 784fa20217c4..deb411e86661 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1978,6 +1978,8 @@ struct file_operations {
>  #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
>  /* File system supports uncached read/write buffered IO */
>  #define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
> +/* Never changes and is never removed, readdir of a directory takes no loc=
k */
> +#define FOP_IMMUTABLE		((__force fop_flags_t)(1 << 8))
> =20
>  /* Wrap a directory iterator that needs exclusive inode access */
>  int wrap_directory_iterator(struct file *, struct dir_context *,
>=20
> --=20
> 2.53.0
>=20
>=20

