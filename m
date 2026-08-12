Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533902C1586;
	Wed, 12 Aug 2026 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541601; cv=none; b=S+bby554vfkzrUTq/eaMTHct62gE8dFfdtce2mvvKdS16Keda3pXfwxCw/wn5C2cKaZYawLQ1CKQDPI9GL8HlxClsi3yNuL9zZZ5L3HOQOjUwmmmshX30YD33dy9xGNTBATYT3052UFjQj4anfkYdg9kS4z8xLE9wXNRDH04OCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541601; c=relaxed/simple;
	bh=2KhnZvXUWsa5df4X/viuvLHn3Urh7W9Rp7EEPN084fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFTEKpA538LpJjOk/lsShd/6S2fehdHRigKoElkdTzVn34/M8RSe8UIGU02wI8/umIJJ3HOSIlXd6nTAzYAtSFCmL6utg9VONBv7eJhMLctN1wCdDijU6My65fxfrgDNMVFcUp9cfcXCg7S6o/4icyAQmbIiMkjQPbyMnLNjxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CnmHwh5N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CnmHwh5N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hNVgISifczc1OreKthTHVApvqfa7CGhqBOdhL2XQMIM=; b=CnmHwh5NkoT0V4A0yeSw6NZ2Kn
	KPFpYX71n7wTu8LPc/ejiqhuNttd4hqPDWu9H3Cw9+t5gIzOb8L/sJJVD9BaeCTXaLrZiHYFQmyls
	86wEL3Ks2coo2Po8xmmZD5CACFSH8V14Lsufd1qc1pcjkeUvn6/5ne6jvd+HgxIIuy+iztuD4/7PG
	Z/bZnK0uT7kO/B2Kr/KV2dP0lcTHGEbUnoNoXiqVEYOsBlxqTJer1gKZgpxNv7RvLlSkcMPKUMuOg
	r70JESdXasqhUQQnPOnteW9GEKgSg8/2UQnrwEQbrdsKdG3lST+WziqyJzcscocsU+5jwgPu8aN3B
	1L/S1YNQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu954-0000000GIbO-25n2;
	Wed, 12 Aug 2026 13:33:18 +0000
Date: Wed, 12 Aug 2026 06:33:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: daan@amutable.com
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, nbd@other.debian.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] nbd: drop stale partitions on NBD_CLEAR_SOCK
Message-ID: <anx2Hqm51MyhH-6-@infradead.org>
References: <20260806-b4-loop-nbd-stale-partitions-v1-0-67bb75a8d7be@amutable.com>
 <20260806-b4-loop-nbd-stale-partitions-v1-2-67bb75a8d7be@amutable.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-b4-loop-nbd-stale-partitions-v1-2-67bb75a8d7be@amutable.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 06, 2026 at 12:36:58PM +0200, Daan De Meyer via B4 Relay wrote:
> From: Daan De Meyer <daan@amutable.com>
> 
> Commit 267ec4d7223a ("loop: fix partition scan race between udev and
> loop_reread_partitions()") stopped disk_force_media_change() from
> setting GD_NEED_PART_SCAN. Besides requesting a rescan, that bit was what
> removed stale partitions on the next open, as bdev_disk_changed() drops
> all partitions before it consults disk_has_partscan().
> 
> nbd_clear_sock_ioctl() relied on that. It zeroes the capacity through
> nbd_bdev_reset(), but nothing removes the partitions of the disconnected
> device anymore. With the default max_part=16 they linger until the next
> connect sets GD_NEED_PART_SCAN again. With max_part=0 nothing ever sets
> it, so they are never removed at all, even though nbd does not set
> GENHD_FL_NO_PART and partitions can therefore still be added with BLKPG.
> 
> Set GD_NEED_PART_SCAN in nbd_clear_sock_ioctl() so the partitions are
> dropped on the next open. Calling bdev_disk_changed() directly is not an
> option as it needs open_mutex, which nbd_open() acquires under
> config_lock.
> 
> Fixes: 267ec4d7223a ("loop: fix partition scan race between udev and loop_reread_partitions()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daan De Meyer <daan@amutable.com>
> ---
>  drivers/block/nbd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 8f10762e90ef..cdafe9d39369 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1612,6 +1612,13 @@ static void nbd_clear_sock_ioctl(struct nbd_device *nbd)
>  	nbd_clear_sock(nbd);
>  	disk_force_media_change(nbd->disk);
>  	nbd_bdev_reset(nbd);
> +	/*
> +	 * Drop the partitions of the disconnected device on the next open. They
> +	 * can exist even with max_part zero as they may have been added manually

Overly long line here.

