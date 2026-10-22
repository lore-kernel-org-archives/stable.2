Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674159;
	b=bmXyi8Pwl18Nb9eTJ2BendWB4syehvPa8ZW2Awd2ev/m2I63EZEvh+jMfLQIzOm8N1Wt
	 CC71cT8Ulq9lfPZCwS3a9NCw7s3L/bQxqaIGujNPzPAQOa1dEUYHD0/IP+tE6FIYxhTsF
	 xqjbOpnZgH16xNlTT2EcZq/JOpSFqPRQC4Ns+L/kNp9hvk0Pfvw+5wgv59YQQNSdpxPuR
	 BFjUKGyNidRJIDI8jXcvWNBpDsVjGQqsFOTIPdlB8rGwe9aX6cAyaqHq1I6sTK0ZM29ee
	 txpH9Nz6uSruWjXpnTqRanotq8UyijqvXixCYo888lALCCAEckIRLrI1OQdXHe0Ts5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674159;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QaSV8A+DkRJxdjBJ52VGx2q6CxzJmPLWhUU+QwPg4ks=;
	b=SD/+ozcPsYGYe7CJKriQ3IrmLp6E7Cfj3nFs0tk12Ixm1wdqujMnAX45waKMgcXeTa+o
	 O89mn2yJEqlALzUQp9x9K49lgfKVWhJKXmIAGfB4E9xMcWe3TBYH2YgHpGksHu5K/Vaxd
	 MtkyiMy2ni1WgRMickUu3oi8Go6aYuubZ+lkecuAUfvEvQ1l0PvWdlGMJi4bjRHt8/X9R
	 JahRrfP5ZklBc8h6be+LPGAbmVyDtT8rpWcVPnLlekM0mbDLxck8e/yFwlONE0w4bvedC
	 plTFjRGSMDiM+EJEPnZeKOpkSuWl1uCIuaRasr8RLZou1zAn+O91m3CxVBBOdiD5ACQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NYiOL2aH;
	arc=none smtp.remote-ip=95.215.58.243
Received: from mta1.migadu.com (out-243.mta1.migadu.com [95.215.58.243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD67606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DD67606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NYiOL2aH
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Blk5PcHa+mtRw2PyDvEKfMHAEAMT011jjsUT7gNzPRI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792674156; v=1; x=1793278956;
 b=NYiOL2aHwYbhphng9Va624cVzGa0vU0DNgH3SgHqUB+tthpnyr2mLU6qsIBU3yl5atyh+dg7
 TlicbWLP+HDJ9ZOCn1VMmGnk+981CDRjr6QpseqGt3xNC9BOAKxB8FeUP+zQg0fWq0q3crur27N
 0+VjArtJDc1l43XJDYR7qpos=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9a0127de9735825e;
	Thu, 22 Oct 2026 13:02:36 +0000
X-Mizu-Trace-ID: 9a0127de9735825e
X-Migadu-Flow: FLOW_OUT
Date: Thu, 22 Oct 2026 15:02:30 +0200
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Daejun Park <daejun7.park@samsung.com>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <dgc@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Sergey Bashirov <sergeybashirov@gmail.com>, 
	Andrey Albershteyn <aalbersh@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v4 5/9] xfs: limit the count of a pNFS write allocation
 to one extent
Message-ID: <atoImJxtg70XcIjS@quentin>
References: <20261020-xfs-pnfs-batch-v4-0-9230fa2ca4a4@samsung.com>
 <20261020-xfs-pnfs-batch-v4-5-9230fa2ca4a4@samsung.com>
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
In-Reply-To: <20261020-xfs-pnfs-batch-v4-5-9230fa2ca4a4@samsung.com>

> With pynfs as the client and a 32 GiB XFS, an RW LAYOUTGET at offset 0
> of an empty file for 16 TiB shut the filesystem down: "Corruption of
> in-memory data (0x8) detected at xfs_trans_mod_sb". With this patch it
> gets NFS4ERR_NOSPC, also with XFS_DEBUG, XFS keeps running, and less
> than 8 GiB of the filesystem, one extent's worth, is left free. One
> for 100 GiB ends the same way, where it got NFS4ERR_NOSPC with nothing
> allocated before. One for 16 GiB, which fits, is granted the same
> three extents as before.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Link: https://lore.kernel.org/r/20261008154017.GO2705364@frogsfrogsfrogs
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/r/20261015060932.GD14035@lst.de
> Fixes: 527851124d10 ("xfs: implement pNFS export operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>  fs/xfs/xfs_pnfs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index 19eb18e129..401a790299 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -224,6 +224,14 @@ xfs_fs_map_blocks(
>  		else if (nimaps && imap.br_startblock == HOLESTARTBLOCK)
>  			end_fsb = min(end_fsb, imap.br_startoff +
>  					       imap.br_blockcount);
> +		/*
> +		 * xfs_bmapi_write() maps at most XFS_MAX_BMBT_EXTLEN blocks
> +		 * in one mapping, so don't reserve blocks for more. The
> +		 * range comes from a client, and its block count may not
> +		 * even fit the 32-bit reservation. The rest of the range
> +		 * is mapped by a later call.
> +		 */
> +		end_fsb = min(end_fsb, offset_fsb + XFS_MAX_BMBT_EXTLEN);

Isn't it better we add this in xfs_direct_write_iomap_begin() instead of
adding it in pnfs?

Something like this:

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 329c745e3120..50cf7b0cfc76 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -284,6 +284,7 @@ xfs_iomap_write_direct(
        int                     nr_exts = XFS_IEXT_ADD_NOSPLIT_CNT;
 
        ASSERT(count_fsb > 0);
+       count_fsb = min_t(xfs_filblks_t, count_fsb, XFS_MAX_BMBT_EXTLEN);
 
        resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
                                           xfs_get_extsz_hint(ip));

-- 
Pankaj
