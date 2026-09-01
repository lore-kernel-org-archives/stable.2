Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F7147D44B;
	Tue,  1 Sep 2026 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788305736; cv=none; b=cNr0S/xeBPsdPJOoAsQfrSdnNLWFMcrUjzJTV7Piu0GYImnxk1XfEH18I3K5jRZrurC9RMlR4v6wNylK8R+aib/79e4KoiuYSobl4kXYTfWC85ycaHrjESOqroyTMkHcncq7pr2vL4F+mAeAyQp4oOFhBQNTTGdJiYbmcYKx6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788305736; c=relaxed/simple;
	bh=W9LLC8FfvHMuvJAkLfv07T7E/8KDkTWl9BRYWaIUK7c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JWcaHhVuQb95MYujZSF4ThyUtGpw//I9vnFxKTpaIHSuxmVg1xA6rczKSxgEg6yVvDx7+p/MkHydabtmv9syuBzIVR9PdFvjq6602jCr7+x1EcFaSUJOzgTuhNylM90XQzvRk99pp9W/zSNjMFovjrkK08Ak3wnM8JgmicZVY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JMNep7hN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JMNep7hN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CE81F000E9;
	Tue,  1 Sep 2026 23:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788305733;
	bh=+Ni6n6k1vIR9OHiOuQjKPVy5Nm8gdO4PfNYpzEdD/lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JMNep7hNw/wj60MKCeBrfjyYz+gQooXrFn8aqvlLmms17+WBHuYTXYJ4lRlr7B/cC
	 /+yzaf6xvhCXCHPtYTOEi7QSmvQYlyqSbqADiBNIGUAAGOTeCMDeSLG0ryFFe211O4
	 xTFyEEaOX0ybdhmEt8b5LBcCGBV53szn1hI0MPQ4=
Date: Tue, 1 Sep 2026 16:35:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: YANXIN LI <fadouse@pm.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ufs: use u64 for directory size in ufs_last_byte
Message-Id: <20260901163533.b1e7d802d709f79e10730f3e@linux-foundation.org>
In-Reply-To: <20260718190300.867109-1-fadouse@pm.me>
References: <20260718190300.867109-1-fadouse@pm.me>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jul 2026 19:03:07 +0000 YANXIN LI <fadouse@pm.me> wrote:

> ufs1_read_inode() and ufs2_read_inode() copy the untrusted 64-bit
> on-disk size into inode->i_size.  ufs_last_byte() then truncates that
> value to an unsigned int before calculating the valid extent of a
> directory folio.
> 
> A directory size of exactly 4 GiB is truncated to zero.  In
> ufs_find_entry(), subtracting the requested record length from that zero
> forms an endpoint almost 4 GiB beyond the mapped folio.  A crafted UFS2
> image produces:
> 
>   BUG: KASAN: use-after-free in ufs_find_entry+0x583/0x6e0 [ufs]
>   Read of size 1
>   ...
>   ufs_find_entry
>   ufs_inode_by_name
>   ufs_lookup
>   __lookup_slow
>   path_lookupat
> 
> The KASAN classification reflects that the adjacent physical page was
> free; the source-level operation is an out-of-folio read.  A controlled
> UFS1 test with CONFIG_UFS_FS_WRITE enabled also made ufs_find_entry()
> return a directory entry from an adjacent anonymous page.  unlink() then
> passed that pointer to ufs_delete_entry(), which cleared the adjacent
> page's 3
> 2-bit d_ino.  This write result reproduced three out of three
> times.
> 
> UFS normally requires a privileged mount path.  A relevant boundary is
> a privileged automounter or image-processing service handling an
> attacker-supplied filesystem.  The write primitive additionally requires
> UFS1 to be mounted read-write with CONFIG_UFS_FS_WRITE enabled; the read
> is reachable with read-only UFS2.
> 
> Keep the intermediate size arithmetic at 64 bits so non-final pages are
> bounded at PAGE_SIZE.  With this change, the same controlled tests reach
> the real on-disk directory entry and produce no adjacent-page write or
> KASAN report.  A reproducer and full validation logs are available on
> request.
> 
> The vulnerable helper is present in v7.2-rc3, v7.1, v6.18.38, v6.12.95,
> v6.6.111, and upstream master at 1229e2e57a5c.  Runtime reproduction and
> fix validation were performed in an x86-64 QEMU guest running v7.2-rc3
> with generic KASAN.
> 
> Fixes: b71034e5e67d ("[PATCH] ufs: directory and page cache: from blocks to pages")
> Cc: stable@vger.kernel.org

Thanks.

fs/ufs is far from my comfort zone, but since you cc'ed me ;)

I'll add this to mm.git and linux-next for testing and shall forward it
on to the relevant maintainers.

