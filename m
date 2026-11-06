Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981779;
	b=Sxx6jy/DPuUMx6xkKVFxArlp2EzltKjXXps+WDobiqfSXUYWUeEem6WR+hdSI6koSf93
	 liM3b+slHokuA+TF7apA1rQxSEHAWumaU1vEgMA/8+ckwpFi28fnFipHyr0RcZeUiAp9+
	 /U0NTCP1a700XqJ8bv7Gwe/h8Q9Og7NkRDydSii9MuxklxYOIpu8pFR6jnsKnVxbSuVmj
	 sZNF9QRKQsd2myytyyWxSKOoRLIXNIxZOk+K/tE1kOsCFp0YSgTsshDeVo+Tz706694ie
	 r7hNRG1cKBr/qJmkAch8B6GXSyGBMxAKHDlVBv2naVX44z5Rurvi9D58PZcPRLlrPaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981779;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=fjiYEUT6lXuZx6H+F7ly7EelTdqZsb5rfOdFz2QSe+s=;
	b=5AMNeVZ/VveXtH/z2A5WZh6mRu4GCN7RnvOY8Xwk06JM+J/KXQ3U4zkgp0cWqsV/lt9R
	 FNAfD00OiJ2R8eGcprNgnf2bjjqC6siOpr9zq6aw7Iv3EM2wlJj5gbW4jRQjM0JTAypDQ
	 hKzc2P3Nq6V05eMHoeOABmzFnTETj48QYdm2+udX4Ef37Njgn0Sij1sUR5nlMlc11r7qQ
	 ZqjlskClbu/H7gzFCJX7+VA/KOgGgPGXn0lYf7/yzDa3aEEikA7jtOsX+JuKQOYO/RvR1
	 3TcbK9cWYgfdTvr4TUrvFvkeGHwOINlzHCbLHYD8TBYsydluuDB7SXdSFuV4wOolUOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=fC0vZy4c;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129F606D810;
	Fri,  6 Nov 2026 16:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E129F606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=fC0vZy4c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fjiYEUT6lXuZx6H+F7ly7EelTdqZsb5rfOdFz2QSe+s=; b=fC0vZy4cKUrBB5V5L218c24PL8
	k/oxRlySNr8UJVlYQtovyrZgCFMuj/6sPM68tdd2IWBaWro7RMCanMVUtzl7HwkgQZtupuJM9D3V3
	ThC7nOWNJYCavdjc4m5ejOtYhddZUGWKreMGfwpe/aqF+qGkNhFIUWXFt8TcHyblaDwIxw+PcGYkI
	At5xHvQZ+qfMmPH9RmPpLyqz/XwGMF5wft/XGoXS6t2VDkIrHLIugKTVGtNbtOyrkhoKWl87ODHXX
	dQsYhl68ASQGYGP+akYAL+5E2fjxS6tCODRqdc8UAUQefSdgYgUqiixDff/8IakzhG+k0Kg4ApW27
	BfKn+KYg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xPMbq-009PF0-2g;
	Fri, 06 Nov 2026 16:16:11 +0000
Date: Fri, 6 Nov 2026 08:16:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Yingjie Wang <x-professor@outlook.com>
Cc: "a.hindborg@kernel.org" <a.hindborg@kernel.org>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	Yingjie Wang <1075151112@qq.com>
Subject: Re: [PATCH] configfs: protect symlink source callbacks from removal
Message-ID: <au39EinX6Xhj4yoj@gmail.com>
References: <20261105134514.2890692-1-x-professor@outlook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105134514.2890692-1-x-professor@outlook.com>
X-Debian-User: leitao

On Thu, Nov 05, 2026 at 01:45:17PM +0000, Yingjie Wang wrote:
> From: Yingjie Wang <1075151112@qq.com>
> 
> configfs_symlink() drops the source directory inode lock while resolving
> its target.  A concurrent rmdir() of the source item can take that lock,
> detach the item and clear its ci_group in unlink_obj().  configfs_symlink()
> then reacquires the lock and calls the source ->allow_link() callback on
> the detached item.  Its config_item reference keeps the object allocated,
> but not attached to the hierarchy.
> 
> The UVC gadget format callback reads src->ci_group->cg_subsys to take the
> subsystem mutex and faults on the cleared pointer.  Racing symlink() into
> a UVC format directory with rmdir() of that directory produces:
> 
>   BUG: KASAN: null-ptr-deref in uvcg_format_allow_link+0x2a/0x140
>   Read of size 8 at addr 0000000000000060 by task configfs_race/291
>   Call Trace:
>    uvcg_format_allow_link+0x2a/0x140
>    configfs_symlink+0x3f2/0x870
>    vfs_symlink+0xc0/0x2a0
>    filename_symlinkat+0x118/0x2b0
>    __x64_sys_symlink+0x50/0x70
> 
> Creating the items needs the privileges required to manage configfs.
> 
> Rechecking ci_group after relocking would cover rmdir(), which holds the
> source inode lock until unlink_obj() returns.  It would not cover
> configfs_unregister_group() and configfs_unregister_subsystem(): both
> clear ci_group in unlink_group() while the source inode lock is not held,
> so the check could become stale before the callback runs.
> 
> Take the source fragment read lock after reacquiring the inode lock and
> hold it through allow_link(), create_link() and drop_link().  rmdir() and
> both unregister paths mark the fragment dead under the write lock before
> they unlink the item, so a concurrent removal either waits for the
> callback to finish or makes the symlink fail with -ENOENT.
> 
> Built from the same configuration, the kernel without this change faulted
> within 1,000 iterations, while the kernel with it completed 10,000
> iterations with no report.  The reproducer covers the rmdir() path; the
> unregister paths were checked by code inspection.
> 
> Fixes: 351e5d869e5a ("configfs: fix a deadlock in configfs_symlink()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <1075151112@qq.com>

How this patch was tested?

I applied this patch to next-20261104 and raced symlink() inside
ports/1/subsystems against a mkdir/rmdir loop on ports/1. KASAN fired
within a second:

    BUG: KASAN: slab-use-after-free in config_item_put+0x48/0x180
    Write of size 4 at addr ff110001068d64b4 by task brute/170
    Call Trace:
     config_item_put+0x48/0x180
     configfs_symlink+0x4eb/0x770
     vfs_symlink+0x25b/0x4b0
     filename_symlinkat+0x10d/0x2f0
    ...
    Allocated by task 168:
     __kmalloc_cache_noprof+0x26c/0x4c0
     nvmet_ports_make+0xcc/0xd10
     configfs_mkdir+0x44d/0x810
    ...
    Freed by task 168:
     kfree+0x150/0x4f0
     config_item_put+0x139/0x180
