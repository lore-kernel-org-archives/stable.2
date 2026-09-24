Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37024356747;
	Thu, 24 Sep 2026 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790224393; cv=none; b=nIbJS/8PEWj2mXxdyXTSHhbnBHEDTugzll00cxeHSTOLe/4WlZ8hL5V7dXGFkQiobiDofFy9bDocSe7+ZDjpG+R5ArGxnDZiv4dOCX+fJaTboyJ1EVafcGs5QcRKZIp+SrGkNMh/BGyE8j/JmOhELuv7jeFfDZyo5V+3f4sFImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790224393; c=relaxed/simple;
	bh=uX1rQEz/DQPqwnMt1TgfUGScOkJ+rvzCpJD+kcswAUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nc7/s4FuR4TZu+b1XnKTHiECwXqDscDRr7rQ/9f9iJE7IjVDAYxxmCgatqdVaRPWLY7Dpq2llTk0C5vK81eTG7wfnCMO+8J7b/rbuwiNY0Xcj0RNlzyeNj6oyyxtu7Fo37AUvDBLTvmZG5JLtTQEbdLOCDV9ehYbnik1O1iQaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsUtjgoj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsUtjgoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE441F000FF;
	Thu, 24 Sep 2026 04:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790224391;
	bh=CcNwL7xRwOV9aWxBCz320PcsLt2UGmXCGMzZht9hwDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CsUtjgojaBrtU9hln5KGYU0lX2Fizlvya9euFa9GR5Ik6Y6KqsbQmYRFNAOtId5n/
	 mGtGf3lYj23X9Wg2W+T0WCwVrEw5A+eywzQZx8wc3uCFbxbCmBJgJbnPX4lZMCFKUv
	 7jvCtN6D7McOmqOYGW1h/A0eB1s2LMpYk/9hAAbDzU23X5LL6qCg5a1x01RIGpm2Ei
	 4l8O4CcNgBKccOs3/1FuoaAuJkV2DMlhyjcNAIa475JQHuLKta6xFY1ewUmtqjOsX+
	 FTBvj1fDLGg3WHEX0BTe1E4N8tHukTQShqVOoTV4PxPxNEb0TSgeqV4mi+ad7O7dBt
	 xKr/Gsgs9Cqaw==
Date: Thu, 24 Sep 2026 06:33:05 +0200
From: Gao Xiang <xiang@kernel.org>
To: Artem Dinaburg <artem@trailofbits.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sandeep Dhavale <dhavale@google.com>,
	Will Shiu <will.shiu@mediatek.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH 6.1.y] erofs: Fix detection of atomic context
Message-ID: <arSoAUX4jDzgY-rG@MacBookPro.fritz.box>
Mail-Followup-To: Artem Dinaburg <artem@trailofbits.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sandeep Dhavale <dhavale@google.com>,
	Will Shiu <will.shiu@mediatek.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
References: <20260922200448.27724-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922200448.27724-1-artem@trailofbits.com>

Hi Artem,

On Tue, Sep 22, 2026 at 04:04:36PM -0400, Artem Dinaburg wrote:
> From: Sandeep Dhavale <dhavale@google.com>
> 
> [ Upstream commit 12d0a24afd9ea58e581ea64d64e066f2027b28d9 ]
> 
> Current check for atomic context is not sufficient as
> z_erofs_decompressqueue_endio can be called under rcu lock
> from blk_mq_flush_plug_list(). See the stacktrace [1]
> 
> In such case we should hand off the decompression work for async
> processing rather than trying to do sync decompression in current
> context. Patch fixes the detection by checking for
> rcu_read_lock_any_held() and while at it use more appropriate
> !in_task() check than in_atomic().
> 
> Background: Historically erofs would always schedule a kworker for
> decompression which would incur the scheduling cost regardless of
> the context. But z_erofs_decompressqueue_endio() may not always
> be in atomic context and we could actually benefit from doing the
> decompression in z_erofs_decompressqueue_endio() if we are in
> thread context, for example when running with dm-verity.
> This optimization was later added in patch [2] which has shown
> improvement in performance benchmarks.
> 
> ==============================================
> [1] Problem stacktrace
> [name:core&]BUG: sleeping function called from invalid context at kernel/locking/mutex.c:291
> [name:core&]in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1615, name: CpuMonitorServi
> [name:core&]preempt_count: 0, expected: 0
> [name:core&]RCU nest depth: 1, expected: 0
> CPU: 7 PID: 1615 Comm: CpuMonitorServi Tainted: G S      W  OE      6.1.25-android14-5-maybe-dirty-mainline #1
> Hardware name: MT6897 (DT)
> Call trace:
>  dump_backtrace+0x108/0x15c
>  show_stack+0x20/0x30
>  dump_stack_lvl+0x6c/0x8c
>  dump_stack+0x20/0x48
>  __might_resched+0x1fc/0x308
>  __might_sleep+0x50/0x88
>  mutex_lock+0x2c/0x110
>  z_erofs_decompress_queue+0x11c/0xc10
>  z_erofs_decompress_kickoff+0x110/0x1a4
>  z_erofs_decompressqueue_endio+0x154/0x180
>  bio_endio+0x1b0/0x1d8
>  __dm_io_complete+0x22c/0x280
>  clone_endio+0xe4/0x280
>  bio_endio+0x1b0/0x1d8
>  blk_update_request+0x138/0x3a4
>  blk_mq_plug_issue_direct+0xd4/0x19c
>  blk_mq_flush_plug_list+0x2b0/0x354
>  __blk_flush_plug+0x110/0x160
>  blk_finish_plug+0x30/0x4c
>  read_pages+0x2fc/0x370
>  page_cache_ra_unbounded+0xa4/0x23c
>  page_cache_ra_order+0x290/0x320
>  do_sync_mmap_readahead+0x108/0x2c0
>  filemap_fault+0x19c/0x52c
>  __do_fault+0xc4/0x114
>  handle_mm_fault+0x5b4/0x1168
>  do_page_fault+0x338/0x4b4
>  do_translation_fault+0x40/0x60
>  do_mem_abort+0x60/0xc8
>  el0_da+0x4c/0xe0
>  el0t_64_sync_handler+0xd4/0xfc
>  el0t_64_sync+0x1a0/0x1a4
> 
> [2] Link: https://lore.kernel.org/all/20210317035448.13921-1-huangjianan@oppo.com/
> 
> Reported-by: Will Shiu <Will.Shiu@mediatek.com>
> Suggested-by: Gao Xiang <xiang@kernel.org>
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> Link: https://lore.kernel.org/r/20230621220848.3379029-1-dhavale@google.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> [ Backport to 6.1.y: the source change is unchanged; only its location
>   in z_erofs_decompress_kickoff() differs. ]
> Assisted-by: LLM
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
> ---
> Hi Greg, Sasha, and EROFS maintainers,
> 
> I am continuing backporting CVE fixes still missing from 6.1.y.
> This fix is inherited by v6.6 and every later mainline release, but 6.1.y
> still has the affected code. The target-specific adjustment is described
> in the bracketed note above.
> 
> Could you please queue it for 6.1.y?

Sorry for late reply.

Thanks for your effort, this commit has a follow-up commit
commit c99fab6e80b76422741d34aafc2f930a482afbdd

erofs: fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC

could you please consider backport those to stable kernels as well?

Thanks,
Gao Xiang

> 
> Thanks,
> Artem Dinaburg
