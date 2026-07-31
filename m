Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F2314B8C
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533720; cv=none; b=tJB5Mi9xd+etS4sbnVZfUHd0PwS2FwZ9Qe0NGLKrY//cz1c4Ebb7wK/PuTplHx6dwWYvCvtrmyNrAjODKtb/XXO15lib+XBo8YZ3wMEvHpvd0nHn1E4szAPUnNuIGtmL3JcdzyTw6OkdeImHKFeL1cAyq+v+MztacjyWZnUUcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533720; c=relaxed/simple;
	bh=J/kGI3wtDitATrzes4Gqn7Tt3F2jt25zLLNXjf+kR+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwOxiVZx660Nugeu2mvPKqiHp9agTxs0kqCyO1WLQjPw2SMbfGRuzOqA4nzPphp4QTJ+5wEXd/W67aO6C+x60sYvWwhsZ4unC+01lzJQpBMU1OLgdjjqYK/qXYl3VdBR4ycIMw1pMXQNCWCVlokgZltKsDJZj13UqhpJ5W18K04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QInFUAuP; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QInFUAuP"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBfVr1JvzzvDP;
	Fri, 31 Jul 2026 23:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785533715;
	bh=AwTCll62+KANpmetbo605FQbigGdaJ2r3atoEflxxag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QInFUAuPGkqRdZMN7QPIA8XycINdPkiTLJN9nfdmVyefFZ5WWmV/pj+4VGfvxOPLz
	 ar0oVq93j/WALIVVdh92chRqDzpsta1Ih6cOurFDZZhRjqQKF/xNa2jYcY5j6fUgRs
	 82//p1VEG/+EAv3aupx4lLbKoI6UOfpgG9UL1ziQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBfVq0m6rzXNs;
	Fri, 31 Jul 2026 23:35:15 +0200 (CEST)
Date: Fri, 31 Jul 2026 23:35:14 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v5 2/5] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
Message-ID: <20260731.Shalee5tiiki@digikod.net>
References: <20260731154353.1790268-1-gnoack@google.com>
 <20260731154353.1790268-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731154353.1790268-3-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 31, 2026 at 05:43:50PM +0200, Günther Noack wrote:
> Whiteout objects are used in the upper layer of an OverlayFS to
> indicate that the file with this name does not exist in the unified
> view, even if it is present in one of the lower layer file systems.
> 
> For the userspace implementations of OverlayFS (fuse-overlayfs),
> whiteout objects can be created from userspace as well:
> 
> * mknod(2) with S_IFCHR and makedev(0, 0)
> * renameat2(2) with RENAME_WHITEOUT,
>   creating the whiteout in the old place of the moved file.
> 
> This commit guards whiteout creation in both of these cases with
> LANDLOCK_ACCESS_FS_MAKE_REG.  Whiteout objects are *not* considered
> character devices and are not bound to a driver.
> 
> For the mknod(2) case, introduce a Landlock erratum.  The creation of
> whiteout objects through mknod(2) was previously guarded using
> LANDLOCK_ACCESS_FS_MAKE_CHAR, and it is now guarded using
> LANDLOCK_ACCESS_MAKE_REG.
> 
> For the renameat2(2) case, fix a bug: Before this commit, renameat2(2)
> with RENAME_WHITEOUT would create a directory entry even when all
> LANDLOCK_ACCESS_FS_MAKE_* rights were denied.
> 
> This does not affect normal renames within layered OverlayFS mounts:
> When doing a regular rename() on a mounted fuse-overlayfs, it is the
> fuse-overlayfs daemon that exercises renameat2() with RENAME_WHITEOUT,
> and only the Landlock domain of that daemon is checked there.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Cc: stable@vger.kernel.org
> Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> Depends-on: 49c9e09d9610 ("landlock: Fix handling of disconnected directories")
> Depends-on: fe72ce6710cb ("landlock: Add errata documentation section")
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  include/uapi/linux/landlock.h    |  1 +
>  security/landlock/errata/abi-1.h | 23 ++++++++++++++++++
>  security/landlock/fs.c           | 41 +++++++++++++++++++++++++-------
>  3 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 7ffe2ef127ee..9c1102ebf06e 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -351,6 +351,7 @@ struct landlock_net_port_attr {
>   *   device.
>   * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
>   * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular file.
> + *   This also guards the creation of whiteout objects as used in OverlayFS.
>   * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX domain
>   *   socket.
>   * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a named pipe.
> diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
> index 3f099555f059..e0d543d9d508 100644
> --- a/security/landlock/errata/abi-1.h
> +++ b/security/landlock/errata/abi-1.h
> @@ -22,3 +22,26 @@
>   * from their original mount points.
>   */
>  LANDLOCK_ERRATUM(3)
> +
> +/**
> + * DOC: erratum_4
> + *
> + * Erratum 4: Creation of whiteout objects
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + * This fix changes the access rights required for the creation of whiteout
> + * objects through :manpage:`mknod(2)` or :manpage:`renameat2(2)`.  Creating
> + * whiteout objects is now guarded by ``LANDLOCK_ACCESS_FS_MAKE_REG`` instead of
> + * ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
> + *
> + * Whiteout objects are used in OverlayFS to mark the absence of a file in an
> + * upper file system.  Despite being created with ``S_IFCHR``, whiteout objects
> + * do not count as character devices.
> + *
> + * Impact:
> + *
> + * Sandboxed programs that create OverlayFS whiteouts (such as fuse-overlayfs)
> + * now require ``LANDLOCK_ACCESS_FS_MAKE_REG`` instead of
> + * ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
> + */
> +LANDLOCK_ERRATUM(4)
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index f7e5e4ef9eac..c12af17cac9e 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -20,6 +20,7 @@
>  #include <linux/falloc.h>
>  #include <linux/fs.h>
>  #include <linux/init.h>
> +#include <linux/kdev_t.h>
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
>  #include <linux/list.h>
> @@ -983,7 +984,8 @@ static int current_check_access_path(const struct path *const path,
>  	return -EACCES;
>  }
>  
> -static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
> +static __attribute_const__ access_mask_t get_mode_access(const umode_t mode,
> +							 const dev_t dev)
>  {
>  	switch (mode & S_IFMT) {
>  	case S_IFLNK:
> @@ -991,6 +993,9 @@ static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
>  	case S_IFDIR:
>  		return LANDLOCK_ACCESS_FS_MAKE_DIR;
>  	case S_IFCHR:
> +		/* Whiteout objects are guarded with MAKE_REG. */
> +		if (dev == WHITEOUT_DEV)
> +			return LANDLOCK_ACCESS_FS_MAKE_REG;
>  		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
>  	case S_IFBLK:
>  		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
> @@ -1007,6 +1012,13 @@ static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
>  	}
>  }
>  
> +static __attribute_const__ access_mask_t

The __attribute_const__ is incorrect here, you can just drop it.

> +get_dentry_access(const struct dentry *const dentry)
> +{

const struct inode *const inode = d_backing_inode(dentry);

> +	return get_mode_access(d_backing_inode(dentry)->i_mode,
> +			       d_backing_inode(dentry)->i_rdev);
> +}
> +
>  static access_mask_t maybe_remove(const struct dentry *const dentry)
>  {
>  	if (d_is_negative(dentry))
