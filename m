Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3363B71DD;
	Fri, 31 Jul 2026 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490208; cv=none; b=dl4YOBaWph9jbbCFj+HorhYAxtxVD2TiMojmq+EwIkuo3LTGfZ34nfwga4UPWBfWwnzEclwTmk2iqJaVza2RSGMSqUdxRFxxtve8LLoqv52NnyM9ZiY6a2kecW1DRqzXOwjVaNLCvEK+6vWy+6D5TmRydFFJo/rlk+dj7ti57y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490208; c=relaxed/simple;
	bh=G9LZZLqQ9WufccGrSqRstXPxeCaVqtzA/U3pxO8KdFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpwPMazZgBl4DsVsLfHaSSNBsywmkMbkPmOMngedWiNv/5mNOyZmCHTOk2G2ypCtGMVb/s9/Uq/3p0PEut89EwxdW08hss13WryT9BkqSXHnHCx84zlX2BRYrTJTmetui7Hh6tQlLTy5rAc67qYmzlhDbjF6mffIYOqajjzMfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=V7iIhQ1E; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="V7iIhQ1E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ltpYBu4SRBTohcTeFLu8qN7Nj02+Xqt/jM/F7tVbwz4=; b=V7iIhQ1ET5V+E/kNtmmv5Le8Sl
	VZ3YKxF2hFnVqEZ8WSNJPyTz7cYL9ioy8EavX+w+sNjSKFtKgJQ2MNGChYLGDS5GxHRuQQEih4s4E
	SZ7ZwZnWdxc1P4hejJRY5dNrAnpKTV6Hrey7WYNQU1oX2v/fp0/TZ8UOuHpT40eFpI6puSxienYVt
	8pXNz6mL4hL+MPkYpL9DHdQEPo4Iq8GDtuPl902bxBxn8kUd6GO022CppqcF9q0dXDoaRBBIhMYVC
	rNaNp10swL9FL+U+0KkLx0N6ZXjdvvUld6FvxeyO8R07oJmisPINcAHzVnKlaCLgS6EllOAvxFwKV
	cSQvKkog==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpjZ3-009uk5-1o;
	Fri, 31 Jul 2026 09:30:01 +0000
Date: Fri, 31 Jul 2026 02:29:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] configfs: unhash the dentry before dropping the item
 in rmdir
Message-ID: <amxrCqfgaWnoWcte@gmail.com>
References: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
 <20260730093435.195441-3-vasilisalmpanis@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730093435.195441-3-vasilisalmpanis@gmail.com>
X-Debian-User: leitao

On Thu, Jul 30, 2026 at 11:30:25AM +0200, Vasileios Almpanis wrote:
> configfs_get_config_item() treats a hashed dentry as proof that
> sd->s_element is a live config_item.  configfs_rmdir() breaks that:
> simple_rmdir() leaves the dentry hashed, the last reference to the item is
> dropped right after, and the dentry is only unhashed by d_delete() once
> ->rmdir() has returned.  configfs_symlink() resolves its target holding no
> lock on it, so get_target() can land in that window:
> 
>   BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
>    get_target fs/configfs/symlink.c:128 [inline]
>    configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185
> 
> Unhash in configfs_remove_dir(), while the item is still guaranteed to be
> there.  A reference obtained just before that stays harmless, as
> create_link() rechecks CONFIGFS_USET_DROPPING, already set by
> configfs_detach_prep().  Both configfs_unregister_subsystem() paths
> d_drop() after detaching, so this only makes rmdir match them.

Is the claim that "a reference obtained just before that stays harmless,
as create_link() rechecks CONFIGFS_USET_DROPPING" accurate?
