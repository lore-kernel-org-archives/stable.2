Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79394225403;
	Wed, 15 Jul 2026 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784081858; cv=none; b=gw1qjcdxlW+w5FTddcwzSMZN+SARYNV9JI9UW8QbWiwiqhWaeeuChxm0TbYDAsdgW5i4j8k+DL9uC4L1GvS8nwD5XEtgYbSqdOLNkzDW1wBPqxpxtNl1B6u4hr4LsCJaj/2r84Y6pFtLUyillYx3jRsUSaQTb8d1B0WpXGwfXWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784081858; c=relaxed/simple;
	bh=cOOejFe4k0KTdIQaW8F+K9w1mFZBWCguRU7Z+ka+fE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nafjgx2C+gwtOD1D8jrliawm93P/k3vatk5Co87vF2Vpz6rE5crCqvd+BPkMpqDWgHFTJO4E9QP7fhkGe0hixxM2xUedFojhVCitDvu3FPcgGEBLflbu0sA7Nfl6qMV3rzTMDXXTGDoGKz7KuYEgUkCllpjad536Jlp/fVyzg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Mj9RPp1s; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Mj9RPp1s"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784081853; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bVuX5Q4TeV1R+TtqVkuED8PpetVVHItpE0gtsE1t7Jo=;
	b=Mj9RPp1shDWHedHPHqWNJs/LbXKrMk4n7zlu1A+tSRJ5Y5BsBpm/jJj8aRyYSQPLj1sOmnYmXtNu9/WAGcU6fVaY/P5UV8BGQSniR3JhbU+LMQnNeyui0GRCN05gCaSzMgIigJfyDbyW/Ht97pq1dkUFRJoJHztx70dU1Pm2fWI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X77N9Ch_1784081851;
Received: from 30.221.131.206(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X77N9Ch_1784081851 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 10:17:32 +0800
Message-ID: <4c760c0f-0408-4b95-ab67-e4f027e34224@linux.alibaba.com>
Date: Wed, 15 Jul 2026 10:17:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] fuse: whitelist the request headers for usercopy
To: Xiang Mei <xmei5@asu.edu>
Cc: fuse-devel@lists.linux.dev, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Luis Henriques <luis@igalia.com>, Pavel Begunkov <asml.silence@gmail.com>,
 bestswngs@gmail.com, Joanne Koong <joannelkoong@gmail.com>,
 Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>
References: <20260714235408.1666063-1-xmei5@asu.edu>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260714235408.1666063-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/7/15 07:54, Xiang Mei wrote:
> The fuse-io-uring transport copies req->in.h out to the ring in
> fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> Both headers live inside the fuse_request slab object, whose cache
> (fuse_req_cachep) is created without a usercopy whitelist, so copying
> them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> panics:
>
>   usercopy: Kernel memory exposure attempt detected from SLUB object
>   'fuse_request' (offset 56, size 40)!
>   kernel BUG at mm/usercopy.c:102!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:usercopy_abort (mm/usercopy.c:90)
>   Call Trace:
>    __check_heap_object (mm/slub.c:8268)
>    __check_object_size (mm/usercopy.c:197 mm/usercopy.c:258 mm/usercopy.c:223)
>    copy_header_to_ring (fs/fuse/dev_uring.c:618)
>    fuse_uring_prepare_send (fs/fuse/dev_uring.c:776 fs/fuse/dev_uring.c:785)
>    fuse_uring_send_in_task (fs/fuse/dev_uring.c:1306)
>    tctx_task_work_run (io_uring/tw.c:96)
>    task_work_run (kernel/task_work.c:233)
>    io_run_task_work (io_uring/tw.h:84)
>    io_cqring_wait (io_uring/wait.c:278)
>    __do_sys_io_uring_enter (io_uring/io_uring.c:2685)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
> in.h and out.h are adjacent in struct fuse_req, so a single usercopy
> region starting at in.h covers both and nothing else.  Create the cache
> with that region whitelisted.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Suggested-by: Baokun Li <libaokun@linux.alibaba.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Looks good, feel free to add:

Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>

> ---
> v3: no context change; add Bernd's Reviewed-by
> v4: drop previous tags; use kmem_cache_args to reserve usercopy area
>
>  fs/fuse/dev.c        | 9 +++++++--
>  fs/fuse/fuse_dev_i.h | 5 +++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5763a7cd3b37..b8e43e374b35 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2404,10 +2404,15 @@ static struct miscdevice fuse_miscdevice = {
>  
>  int __init fuse_dev_init(void)
>  {
> +	struct kmem_cache_args args = {
> +		.useroffset = offsetof(struct fuse_req, in.h),
> +		.usersize = sizeof_field(struct fuse_req, in.h) +
> +			    sizeof_field(struct fuse_req, out.h),
> +	};
>  	int err = -ENOMEM;
> +
>  	fuse_req_cachep = kmem_cache_create("fuse_request",
> -					    sizeof(struct fuse_req),
> -					    0, 0, NULL);
> +					    sizeof(struct fuse_req), &args, 0);
>  	if (!fuse_req_cachep)
>  		goto out;
>  
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 668c8391d61c..b511aaab6bfc 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -81,6 +81,11 @@ struct fuse_req {
>  	/** @flags: Request flags, updated with test/set/clear_bit() */
>  	unsigned long flags;
>  
> +	/*
> +	 * @in and @out are the usercopy region of this cache (see
> +	 * fuse_dev_init()); keep them adjacent.
> +	 */
> +
>  	/** @in: The request input header */
>  	struct {
>  		/** @in.h: The request input header */


