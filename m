Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A83D47B3;
	Wed,  5 Aug 2026 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956067; cv=none; b=NpwZs+GH1PVr6EfAg6nIf/fORyDfv4zd3oaQDVTLNR0E3QkvwxSZQfGaN8WqNc9FIFRmmUVq4sJp90V3UxGr9wxV4U3vZx7xgHwK7NlYDswQJXSSxY1SSPSS33cMLhi3LJ/F2xNe8+VBVkbjGrIE3Z52NQY79Cs1x0XHQoWcVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956067; c=relaxed/simple;
	bh=4dkH06t8kMbZKzhwkDWAYEqopHV3AaBmksvGFtV2V1w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g6TUctT36PPEE8mDzU9hupssUpoDtyybP3nvKt1hwCBSsvzXT87naSJ5g0qSjixk+pR4yenV7TF6/YaGSnIrdZP8gjVDn+3l46RSR10KANnzbOCzGR4xzQt3t2oAQdDgBNlfKQ1xEcaVJXp3ZXAZHJE5Zbm/mrC2utkEd0mscgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kSqEmExH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kSqEmExH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CAB1F000E9;
	Wed,  5 Aug 2026 18:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785956064;
	bh=+Ye71OZjFFGiEsUrzq1nVIlLNjGqhCTHnFp8hU0wY4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kSqEmExHYguVQDLXobGPRjvlvwF09GVuCV/QqdcGKCjOZgJ862XVelokx9Z+JSD6r
	 iaJebHIdEXJ8y4HO5iwG1MbHSCKOqxh7C/siEPzIYaALxvscpSktisH9SkU6QJy86b
	 pkSwSJhkf+YQ6PkXMcCGIVMnwkzon1PlamuK4DW4=
Date: Wed, 5 Aug 2026 11:54:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Longlong Xia <xialonglong2025@163.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH 1/1] zram: reject disksizes that exceed slot index range
Message-Id: <20260805115424.a0c8abdb9bbd2f7caa6fb66a@linux-foundation.org>
In-Reply-To: <20260804143832.146129-1-xialonglong2025@163.com>
References: <20260804143832.146129-1-xialonglong2025@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 22:38:32 +0800 Longlong Xia <xialonglong2025@163.com> wrote:

> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> zram uses u32 slot indexes, while disksize_store() accepts a u64
> size. On 32-bit systems, a disksize larger than U32_MAX pages is
> truncated when zram_meta_alloc() assigns the page count to size_t.
> array_size() then sees only the truncated count, so a small table can
> be allocated while the original capacity is published. Valid I/O
> within that capacity can subsequently access beyond zram->table.
> 
> The same oversized capacity also lets full-device scanners compare a
> u32 index with an upper bound larger than U32_MAX, so the index can
> wrap instead of terminating.
> 
> Reject disksizes larger than U32_MAX pages before aligning and
> allocating the table. This keeps the table size, published capacity and
> slot index range consistent.

Oh.  Rejecting large devices sounds severe.  Can't we just fix the
32-bit trucation issues?

> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2876,6 +2876,9 @@ static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
>  		return -EBUSY;
>  	}
>  
> +	if (disksize > (u64)U32_MAX << PAGE_SHIFT)
> +		return -EINVAL;
> +

It would be helpful to have a comment explaining why we're doing this.


AI review appears to have found a similar issue in mark_idle(),
although it could be that your patch accidentally prevents it from
occurring:

	https://sashiko.dev/#/patchset/20260804143832.146129-1-xialonglong2025@163.com
