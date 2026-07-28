Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8E135E922;
	Tue, 28 Jul 2026 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785223458; cv=none; b=bnOAebmP2avRlaBwQJQEGiIVH1b1hyMBqg4POM7L3FlwtRQuvlIgu8DbMjafXVIfPAnAhJhQ/C5jbvmQHcgc/SLDRYDnEgeK4rm+yOB1sgyI1sOhv/tMc59MQuqqVgxIytDw/sBXPaRm2/yMQ/FkeIlm3evt91d6/uSXN07isYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785223458; c=relaxed/simple;
	bh=Ihrebgr6xkxWO1dlGAahZLpRPZek5kIvTvZKdsX/joo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Y2xogQwWD1hgFKaZC10QllEnjU/dJL17v37EPI3nn3pvM9Eq5dyTC+fteVv84vRJbw4+cKQIeNNrTINZZ0TawMBx+YCxMh/1nro4bLsFGVlkkH3Gmi7DMJtGZ1evJhGS8JPrXEqyxeMtMKV+osZjlPz57uYR9HqVNA4NdO9E02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpaCadhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpaCadhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6781F000E9;
	Tue, 28 Jul 2026 07:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785223456;
	bh=E8SRul2G1HrGQJcr066YGOHz1y5cWjA8Zr8/M3ZYP1w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=KpaCadhgfFJhn/uEvG8hxcA+gC2z1HjEp9WQkgt5w4L4afiq0Rra3A+2x5+bkfPGE
	 /iKs+9RupXFMrs0xwt65vFORu066JIjNIS2a0I2MLY9sdL/1Sn2AMPIvwKYkl2XS/+
	 a1d4JL5toh79taO3A7quefnlzL+pC1lElNC1yv6E4D2wODsCxv3CpYeBzIznqCNjZF
	 wab9IazK+LQAt4Y8w/FMZTj7EDdzXS9ipLrVpaUz1jUVEObFKSNMTEtMsE1VL4f4OI
	 BDk2iCHylu2lCCRHkeDi+HJDGPuHCRr4OSQj2U1NJ0S1F1UEZwgCxNAafHUzuznaO/
	 wguypYjOouHfQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] freevxfs: fix off-page read on a crafted dirblock
From: Christian Brauner <brauner@kernel.org>
To: Baul Lee <baul.lee@xbow.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 hch@infradead.org, federico.kirschbaum@xbow.com, stable@vger.kernel.org
In-Reply-To: <20260726062514.43756-1-baul.lee@xbow.com>
References: <20260726062514.43756-1-baul.lee@xbow.com>
Date: Tue, 28 Jul 2026 09:24:13 +0200
Message-Id: <20260728-herzton-fanshop-oberen-7ae890df5b67@brauner>
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=2799; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ihrebgr6xkxWO1dlGAahZLpRPZek5kIvTvZKdsX/joo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlRMrLuNQ/87S0eKzywez58vf6fhum/znawLBlBqdgx
 92gSu+WjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk472JkaNFZ//3xGQGOpOnr
 W0VXBMg+C7BOySqNXnUh2fbG1X/mQBX7Gva7GW0zmC76XFxg60+LCRE5rScC/mrbPl6arX+2uZg
 XAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-26 15:25 +0900, Baul Lee wrote:
> vxfs_readdir() and vxfs_find_entry() both advance the intra-page offset
> pg_ofs by VXFS_DIRBLKOV(sbi, dbp) at each dirblock boundary and then
> dereference
> 
> 	de = (struct vxfs_direct *)(kaddr + pg_ofs);
> 
> without re-checking pg_ofs against PAGE_SIZE in between.  The enclosing
> while (pg_ofs < PAGE_SIZE && pos < limit) test only gates loop
> re-entry, not the deref that follows the addition in the same
> iteration.
> 
> VXFS_DIRBLKOV() is 2 * d_nhash + 4, and d_nhash is an unvalidated
> on-disk __fs16, so the overhead is attacker arithmetic of up to roughly
> 32 pages.  kaddr is page_address() of the single order-0 page-cache
> page returned by vxfs_get_page(), so nothing else bounds the addition
> and the de->d_reclen load lands off the mapped page.  Directory pages
> are consumed unvalidated: vxfs_check_page() was never implemented, only
> a commented-out call survives.
> 
> Both sites are reachable on any mounted crafted freevxfs image, the
> vxfs_readdir() one from an unprivileged getdents64(2) and the
> vxfs_find_entry() one from any path walk into the directory.  When
> d_ino is non-zero vxfs_readdir() also feeds the off-page bytes to
> dir_emit(), so they reach userspace.  KASAN reports a 2-byte
> out-of-bounds read in vxfs_readdir().
> 
> Re-check pg_ofs against PAGE_SIZE right after the addition and before
> the deref in both loops, restoring the invariant they already assume.
> The added break leaves the page the same way the existing zero-d_reclen
> break does.  Well-formed directories, whose overhead never pushes
> pg_ofs past a single dirblock, are unaffected.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 12495ea3ac47 ("freevxfs: refactor readdir and lookup code")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>
> ---
>  fs/freevxfs/vxfs_lookup.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
> index 138e08de976e..b068f93359fb 100644
> --- a/fs/freevxfs/vxfs_lookup.c
> +++ b/fs/freevxfs/vxfs_lookup.c
> @@ -87,6 +87,8 @@ vxfs_find_entry(struct inode *ip, struct dentry *dp, struct page **ppp)
>  
>  				pos += overhead;
>  				pg_ofs += overhead;
> +				if (pg_ofs >= PAGE_SIZE)
> +					break;
>  			}
>  			de = (struct vxfs_direct *)(kaddr + pg_ofs);
>  
> @@ -237,6 +239,8 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
>  
>  				pos += overhead;
>  				pg_ofs += overhead;
> +				if (pg_ofs >= PAGE_SIZE)
> +					break;

There's valid Sashiko reviews that you want to read through.

