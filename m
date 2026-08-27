Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7AD3FFFB3;
	Thu, 27 Aug 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851787; cv=none; b=jU7Tv9xLV3wWNK6yP6unh9Y/XnFC3tJs3fC96RSPME4dk/GAzfFR/agRP57gMmHBJIXIU9mxcvjnhQFztWYDvArjcEJJLeId6mK16DVBJvFKk8vlI5TrzryQ2DcCnBVvJZu5D758rssLxDpm69btcaPSTX+zuH2e0nzJzXO9B/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851787; c=relaxed/simple;
	bh=nmKLQpBXVvRkfcZL6nXsJ4TQXK6bcfQXLa6Q7bgEQV4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uGhvM3EyC8wL1dVtzV2O8uWhh7Q3Kx09v+ws86anuQITD8LgkHxx69TQdAC9HJDcqim3AWEUbx3YxTsT1hcW4LHvYayRkWnC1gXs3xa5VIBOnmsEmPSbReEqXrd4VybXJlyVU8JK6cRUvt0fdfROv6oFpG5NBSOG3ho2K06DvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xt5BWeuV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xt5BWeuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EB11F000E9;
	Thu, 27 Aug 2026 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1787851786;
	bh=4jzWefjFgm0stKBxYcV7Y1ItnNNRQhMMDOv7W8UlIyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xt5BWeuVVReseTy1oxgnCxUEi7ggfPYT+VOtJf/UEqDOhf6wSfzPpxwF+xIvXySS3
	 sOVt40YSi/JbCXsMs9nVRDU5poclv68G1PR0Esij2fFgUwUendKGYammJoU8wYn4Hw
	 ETiGa/jXEK3nMRtgf1/OLpsilzJzOfQS24OqZLSU=
Date: Thu, 27 Aug 2026 10:29:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kazuki Hanai <hnkz.64@gmail.com>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, =?ISO-8859-1?Q?Andr?=
 =?ISO-8859-1?Q?=E9?= Almeida <andrealmeid@igalia.com>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH v2] tmpfs: fix unicode_map leaks in casefold option
 handling
Message-Id: <20260827102945.998982ccac58119fbe35edd7@linux-foundation.org>
In-Reply-To: <20260827152516.805622-1-hnkz.64@gmail.com>
References: <20260827151426.796843-1-hnkz.64@gmail.com>
	<20260827152516.805622-1-hnkz.64@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 00:25:16 +0900 Kazuki Hanai <hnkz.64@gmail.com> wrote:

> shmem_parse_opt_casefold() stores the unicode_map returned by
> utf8_load() in ctx->encoding. The casefold parameter can be supplied
> more than once for the same filesystem context, but replacing the
> stored map does not release the previous reference.
> 
> The final reference is also leaked when an unmounted filesystem
> context is freed.
> 
> Release the previous map before replacing it, clear ctx->encoding
> after transferring ownership to the superblock, and release any
> remaining reference from shmem_free_fc().
> 
> An unprivileged user can repeatedly set the casefold parameter on a
> tmpfs filesystem context from a user namespace. This causes
> unbounded kernel memory consumption and can result in a local denial
> of service.

Thanks.

> Fixes: 58e55efd6c72 ("tmpfs: Add casefold lookup support")

It's best to cc the people who were involved in the Fixes: patch.

> Cc: stable@vger.kernel.org
>
> ...
>
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4508,6 +4508,7 @@ static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *
>  	pr_info("tmpfs: Using encoding : utf8-%u.%u.%u\n",
>  		unicode_major(version), unicode_minor(version), unicode_rev(version));
>  
> +	utf8_unload(ctx->encoding);
>  	ctx->encoding = encoding;
>  
>  	return 0;
> @@ -4976,6 +4977,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	if (ctx->encoding) {
>  		sb->s_encoding = ctx->encoding;
> +		ctx->encoding = NULL;
>  		set_default_d_op(sb, &shmem_ci_dentry_ops);
>  		if (ctx->strict_encoding)
>  			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
> @@ -5073,6 +5075,9 @@ static void shmem_free_fc(struct fs_context *fc)
>  	struct shmem_options *ctx = fc->fs_private;
>  
>  	if (ctx) {
> +#if IS_ENABLED(CONFIG_UNICODE)
> +		utf8_unload(ctx->encoding);
> +#endif
>  		mpol_put(ctx->mpol);
>  		kfree(ctx);
>  	}
> -- 
> 2.53.0
