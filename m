Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077AB3BB104;
	Wed, 26 Aug 2026 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735823; cv=none; b=p7cs6G1fwUGsV7+SWZICWJb91bNQ465dOqKkL5+rejBktc0f63qpUYuytWA5vJzYFFZfuywzZfL69BhlhCu2MfdR///OlSR7N1cZwmwKQYIwG03mQJmmSFXuxB2ABsnkgk04ju/NppO603mSDUjJeHDC8xqE1f8i45SwgqhJpGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735823; c=relaxed/simple;
	bh=TZFkoGguAxaKTrBJEZAH1aJT0cUMr3yA2w7N0G1PK2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVtb0+tjr6TTLmt1iQNwzIvzikHE0eCb80H/zlUDjOfZXFZp9wdj9kVrUTkxLvX76LJFk9XQJsHOy/VruImYOZM4XVR0kQdUCpA10flsKp+G0kLmy6Il6Nl3VMwrxeyRwqgmH6i0rjBST+Q65h0Gchv7PSlwsuSqxaeNN6oAazU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=O1dKm7Hz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="O1dKm7Hz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FLIA9VrOYvHmRrxCXpzJcg4ozOhZiGxCnihocBAYohA=; b=O1dKm7Hz4dyl2hoWgk/treujgn
	x9GEMcoOSStKUxLfljzKbr4qnpy4hiROPGKaA4TonKAqOIej3EyAHJIIrTW4A5rP6dHYuVbxBaQpX
	H4MuB67U8t7oxljb/kBso63RYOStAsLPYK98BnLgUBFORAtE+whkOvnmHNiB3zpkDEBvashZ5ETvM
	UlLSlashF8j1khZ8UKO6wgogcQs8JQ6DK2mGZnoVt/Zo8B4/p2JWY6cXO8osc5AFy+udIenm3kZYW
	5Y/12G93D9kDtb1caNZTmb1qQyRVxlDc1pIOXkoJFPqbQGQKVijR+oWgGARgr6+FAMb7qhfVpDIhA
	XhTvArGw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wz9ke-00F6qu-07;
	Wed, 26 Aug 2026 09:16:56 +0000
Date: Wed, 26 Aug 2026 02:16:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] configfs: fix use-after-free of symlink target
 racing with rmdir
Message-ID: <ao6u5LxY6kp-wbtb@gmail.com>
References: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
X-Debian-User: leitao

On Thu, Jul 30, 2026 at 11:30:23AM +0200, Vasileios Almpanis wrote:
> syzkaller reported a slab-use-after-free in config_item_get() when
> symlink(2) races with rmdir(2) of the symlink target:
> 
>   BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
>    configfs_get_config_item fs/configfs/configfs_internal.h:127 [inline]
>    get_target fs/configfs/symlink.c:128 [inline]
>    configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185
> 
> configfs_symlink() resolves the target with no locks, with the idea
> that a hashed dentry means a live config_item. configfs_rmdir() drops
> the last reference to the item before the dentry gets unhashed by
> d_delete() in vfs_rmdir(), so get_target() could take a reference on
> an already freed item.
> 
> Patch 2 fixes this by unhashing the dentry in configfs_remove_dir(),
> before the item can be freed.  Patch 1 fixes a second lifetime bug in
> the same path that the earlier unhashing makes easy to hit: an item
> reference does not pin the item's dentry, so create_link() must not
> reach the target's configfs_dirent through ->ci_dentry.  The patches
> must be applied in this order.
> 
> Tested with the syzkaller reproducer, which no longer triggers either
> the KASAN report or the s_count warning.
> 
> Vasileios Almpanis (2):
>   configfs: pin the symlink target's dirent instead of chasing
>     ->ci_dentry
>   configfs: unhash the dentry before dropping the item in rmdir

Tested-by: Breno Leitao <leitao@debian.org>
Reviwed-by: Breno Leitao <leitao@debian.org>
