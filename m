Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0FA3932CE;
	Mon, 13 Jul 2026 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930814; cv=none; b=ewkIO9/RyBCi2wtcNmZ1xkpOGWQPqCMGQevx3d2VHD6tW37YDxOGwHP4K5+bmue6eLusC4N3gdGbjc+DjyqW7XFqCvQ3Y915VmryNE9+bvu90/CugTzQwDAP7T2X9S+c34XMWyPYVoUkogzkuhVAHL6hh1TjZ/x/tT/InGByZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930814; c=relaxed/simple;
	bh=BBqMnGi4wGTH9S1GDOdPt9fL8SQXpYQGHyQzDjuWEKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omRm+cYKmAdmenIs3PDN2Xe3Y6IKLI/abrYBYnVvL3eW16uIXY4aPE1laedMFGv4UVfLHehwM4hH8xMMXw1E8Rq75OchXOFCY7SruXaAu1CBVUm0Q/IMNuznTo1IhZH7YDwRulucrXBFSvou7XxTP4mpcd9x0mKnQYMb5K1v6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eBtNqezf; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eBtNqezf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783930802; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DiUBhTKFzNhpXGXkh49SffbTXZU5ygdNhcD76oDQdCM=;
	b=eBtNqezfRPXH2H4qB/GBzY52xKDBbtq4Odc0zUr7w370fz6i/a85t5twUf2MBePqQD25Bk4A4dXSVPJ8n9fOOuxifPyAUoWBcHj1zOVzsOjSur6fSIp3ZI8ul0QBDW6FCXqzXqO3s1Fe3mNy+SEOlg4jULoNoC3pQ2XT5kYUhUs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X6wbGFP_1783930801;
Received: from 30.221.131.131(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X6wbGFP_1783930801 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 16:20:01 +0800
Message-ID: <26a9a225-617c-4492-af1d-152d71414f4d@linux.alibaba.com>
Date: Mon, 13 Jul 2026 16:20:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] fuse: copy request headers via a stack buffer for
 io-uring
To: Xiang Mei <xmei5@asu.edu>
Cc: fuse-devel@lists.linux.dev, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Luis Henriques <luis@igalia.com>, Pavel Begunkov <asml.silence@gmail.com>,
 bestswngs@gmail.com, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, Kees Cook <kees@kernel.org>,
 Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>
References: <20260709211130.543773-1-xmei5@asu.edu>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <20260709211130.543773-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Xiang,

On 2026/7/10 05:11, Xiang Mei wrote:
> The fuse-io-uring transport copies req->in.h out to the ring in
> fuse_uring_copy_to_ring() and req->out.h back in fuse_uring_commit().
> Both headers live inside the fuse_request slab object, whose cache
> (fuse_req_cachep) is created without a usercopy whitelist,


Then why not allocate "fuse_request" with kmem_cache_create_usercopy()
to add a usercopy whitelist instead?

That would avoid the extra stack usage for the bounce headers and
the 56 bytes of copying they incur.


Thanks,
Baokun

>  so copying
> them directly to/from userspace trips CONFIG_HARDENED_USERCOPY and
> panics:
>
>   usercopy: Kernel memory exposure attempt detected from SLUB object
>   'fuse_request' (offset 56, size 40)!
>   kernel BUG at mm/usercopy.c:102!
>   RIP: 0010:usercopy_abort+0x6c/0x80
>   Call Trace:
>    __check_heap_object
>    __check_object_size
>    copy_header_to_ring          fs/fuse/dev_uring.c:618
>    fuse_uring_prepare_send
>    fuse_uring_send_in_task
>    ...
>    __do_sys_io_uring_enter
>    entry_SYSCALL_64_after_hwframe
>
> Bounce both headers through an on-stack copy so the usercopy touches
> stack memory, not the slab object.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
> v3: no context change; add Bernd's Reviewed-by
>
>  fs/fuse/dev_uring.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 77c8cec43d9c..0814681eb04b 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -744,6 +744,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
>  {
>  	struct fuse_ring_queue *queue = ent->queue;
>  	struct fuse_ring *ring = queue->ring;
> +	struct fuse_in_header in_header;
>  	int err;
>  
>  	err = -EIO;
> @@ -765,8 +766,9 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
>  	}
>  
>  	/* copy fuse_in_header */
> -	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
> -				   sizeof(req->in.h));
> +	in_header = req->in.h;
> +	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &in_header,
> +				   sizeof(in_header));
>  }
>  
>  static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
> @@ -871,11 +873,13 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
>  			      unsigned int issue_flags)
>  {
>  	struct fuse_ring *ring = ent->queue->ring;
> +	struct fuse_out_header out_header;
>  	ssize_t err = -EFAULT;
>  
> -	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
> -				  sizeof(req->out.h)))
> +	if (copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &out_header,
> +				  sizeof(out_header)))
>  		goto out;
> +	req->out.h = out_header;
>  
>  	err = fuse_uring_out_header_has_err(&req->out.h, req);
>  	if (err) {


