Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016294503FF;
	Thu,  6 Aug 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026802; cv=none; b=MfJQUyBJhZALMAtkJIFbuURr8Y0C50h8GAEVR1yzINhh3LElOQz5bQVXCJnmNX83uvgSv6qtmg8yzuBkSjRZR55KxJ+WZP8ji17yb9Ugr5ubsFP7Gn/lVYcJ6g4HEF5DDrdF2bQZOsK0ltWE7Y80rAJj6IxxOFgtH6bKIWgS/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026802; c=relaxed/simple;
	bh=Xw5Gv+4AFBTztJ8Q4VFFOlJMdd5u63dYb1s/SY6tiqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knUpbg8SIwb5TtTsQF/mxDjtGyqx73gXiIa9CU8RNA3rh1afRh4xClp+FRCo9F8prlYqCap3OrgA7YSSZiby9h6Z9nRhUve6sdhkHhBQT/0BqyyRWnmufNJHLand0F+hNtfRmab82f4Wq4gvoe7wUawhphamhh4pkNvf/rqqeB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0/woCMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0/woCMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1629F1F000E9;
	Thu,  6 Aug 2026 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786026800;
	bh=o1FmE4WKCoL+f0uTzUBGVRUXeJU64T6VaMnr77RHMm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c0/woCMYmcuAChw3qkLZmjOpHdCl+V8FEHBwV0FkSLlmxrwdmnL3/EkjSJQRbnmNn
	 uHFHdF6c3gFRP0zSiGPbXjcjh5uzAtg1teHBjZkXR7AAQi5adKc8DH5NAU2hvKOS1+
	 83b6TW3yftYEs/SYbEL1XJd8RsktZ/PLaJ4vP8vw=
Date: Thu, 6 Aug 2026 16:33:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Xiaokun <shinnkka1@gmail.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] Fix memory leak in io_wq_create() on success path
Message-ID: <2026080644-suffix-earthy-2f30@gregkh>
References: <20260806142314.557312-1-shinnkka1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806142314.557312-1-shinnkka1@gmail.com>

On Thu, Aug 06, 2026 at 10:23:14PM +0800, Chen Xiaokun wrote:
> The commit 657ca82526d0 introduced a temporary allowed_mask cpumask in
> io_wq_create(), which was freed only on the error path.  This caused a
> memory leak of cpumask_size() bytes on every successful io_wq_create().
> 
> Fixes: 657ca82526d0 ("io_uring/io-wq: inherit cpuset of cgroup in io worker")
> Signed-off-by: Chen Xiaokun <shinnkka1@gmail.com>
> ---
>  io_uring/io-wq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
> index 66fdd69fd6cb..34a1a9067cc2 100644
> --- a/io_uring/io-wq.c
> +++ b/io_uring/io-wq.c
> @@ -1218,6 +1218,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
>  	wq->task = get_task_struct(data->task);
>  	atomic_set(&wq->worker_refs, 1);
>  	init_completion(&wq->worker_done);
> +	free_cpumask_var(allowed_mask);
>  	return wq;
>  err:
>  	io_wq_put_hash(data->hash);
> -- 
> 2.55.0
> 
>

Why is this a stable-only patch?  Was the backport wrong?  Or is this
also in Linus's tree?

thanks,

greg k-h
