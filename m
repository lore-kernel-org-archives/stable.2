Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F58436CDFE;
	Wed, 26 Aug 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735869; cv=none; b=kcE9tWzlTmKEe+ok9NV7rfJUd82smazPdzIMhqKc2P2TCXHGZpumSm6E1CX+5RNpq5a9N4r96RbZ0t31aIOOxdALI1VApi+u/EozlOG+jpbUUiJZfAYPKxqsiG0GIeLtiuHFZVrzDM8cPaBQTcJ+bMPuW7qYnjcnjzzirdN2qGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735869; c=relaxed/simple;
	bh=h4xKRg+12nPQ1cNfmwCZIodUYzlNwr7bfdmGOAEnHzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElxBDa81fu1zBz2ONxwwyzrPBv0BhJZMSbt9NSdS1sMO3QjxmTR6TOEQ+IfxDBD/dk8hVaDFjuOCL4bzzryx5RptRuXGoQQv/cF207W/12TD1S2iyuVPfj0313sieLS+PFwjU7x6PimtBrgJxKd5dAk2WRwqB6LV/jnKxeQjZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jTUqe/L5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jTUqe/L5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kQAA7oYfOHqN1SdKBz2wmvFrJD0nP/XVhDf2LcIyPSY=; b=jTUqe/L5ZHEJiYFXJj/aBZnKwv
	aU6EU7UsnZJVFsHn69KDXs8kclN+3IZKWiTCBBaTbdH5GYS0XzBzkA5Bj+UyhkWB0osQoloToh7ar
	CF8Ik3T9ZtVeqf3FvPZwDB+e4pglgoYTI4sFNGFiWTS8D1n3GjV9Z6M/O6ha2Ebu+LWUpv+Srlay5
	qtEO977FwmPv4Yy6uVVbrOpBIWss0PAFkUTq+CYH+p4FT9h5hf+TgFCCwO1iT36LSmoKw8RNsw5AE
	BDogueCUrAT0JNHa2IQspYUFi5MvQZ8iTYxrdQpcOwscOZ0Qbr3vGJFNTJ3lkWdasU/82ms2S6oss
	t+x60t1w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wz9lO-00F6rp-2h;
	Wed, 26 Aug 2026 09:17:43 +0000
Date: Wed, 26 Aug 2026 02:17:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
Subject: Re: [PATCH 0/2] configfs: fix use-after-free of symlink target
 racing with rmdir
Message-ID: <ao6vFpe5MMCmkO-z@gmail.com>
References: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
 <c334a6dc-37bb-40bf-ad8f-19fd84386e1d@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c334a6dc-37bb-40bf-ad8f-19fd84386e1d@gmail.com>
X-Debian-User: leitao

On Wed, Aug 12, 2026 at 09:00:57AM +0200, Vasileios Almpanis wrote:
> 
> On 7/30/26 11:30 AM, Vasileios Almpanis wrote:
> > syzkaller reported a slab-use-after-free in config_item_get() when
> > symlink(2) races with rmdir(2) of the symlink target:
> > 
> >    BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
> >     configfs_get_config_item fs/configfs/configfs_internal.h:127 [inline]
> >     get_target fs/configfs/symlink.c:128 [inline]
> >     configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185
> > 
> > configfs_symlink() resolves the target with no locks, with the idea
> > that a hashed dentry means a live config_item. configfs_rmdir() drops
> > the last reference to the item before the dentry gets unhashed by
> > d_delete() in vfs_rmdir(), so get_target() could take a reference on
> > an already freed item.
> > 
> > Patch 2 fixes this by unhashing the dentry in configfs_remove_dir(),
> > before the item can be freed.  Patch 1 fixes a second lifetime bug in
> > the same path that the earlier unhashing makes easy to hit: an item
> > reference does not pin the item's dentry, so create_link() must not
> > reach the target's configfs_dirent through ->ci_dentry.  The patches
> > must be applied in this order.
> > 
> > Tested with the syzkaller reproducer, which no longer triggers either
> > the KASAN report or the s_count warning.
> > 
> > Vasileios Almpanis (2):
> >    configfs: pin the symlink target's dirent instead of chasing
> >      ->ci_dentry
> >    configfs: unhash the dentry before dropping the item in rmdir
> > 
> >   fs/configfs/dir.c     |  9 +++++++++
> >   fs/configfs/symlink.c | 24 ++++++++++++++++++++----
> >   2 files changed, 29 insertions(+), 4 deletions(-)
> > 
> > 
> Hi everyone,
> 
> Regarding this series, is there anything I could have done differently?
> Any suggestions or advice would be greatly appreciated.

sorry for the delay, we were fixing a few things in configfs, and I've
tested and reviewed this patchset and it looks good. I will queue it.
