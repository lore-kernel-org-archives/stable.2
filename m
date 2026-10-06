Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4B3CB557;
	Tue,  6 Oct 2026 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791321080; cv=none; b=nbjxRoKeraeBqaL2GpnCu3E6WseOFmJzR2cTiJCtcTWI63AtbbyExvLBLMZe7uk1OummsVEf2cAhgLhfVH28SLGpR4DmFqQ7+v+LR4CG5zBsFOtBtYybu4MvQ1QI4T3/oPvTiqBfyxzck54zwgTYeGYjk+2DaXveRLFDMDq/pY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791321080; c=relaxed/simple;
	bh=eJqOm82J5R97HC3hp/za/6cr1vYqL7mkBxRsrF7MZYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlLxoROw5C9YGAr6kPcZimm2vpSSHA6jMeSa5vBa3YtbNZnFCe4vN6AtzypA6uoof2NnH6pyBET7QQO42sGDjwhbR3HV9m5uIb4e7+YEVdpwgSM1sj9wLMJxepWJK2io0o47B+2ldfxw6iGjwjQYqAxHQi6TKUj3nA2iJjz9txM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WFY9ILpc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WFY9ILpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E0E1F0089B;
	Tue,  6 Oct 2026 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791321078;
	bh=s67wcmLdvo6Va5riA42IT5CjgvqjWz2QO0DX2E+Vc6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WFY9ILpcu8vuCmq1IJ7t1QwNcC+ULQTEEUJwfMx8idPGp3hYtsaAzaxVjHnVIr1gQ
	 nTyAZD+nOMdbQ1Nop+D+FBqdvvfVGNXAE52ckG1ANs772zaWoRM4MEb52ldaXY0XOn
	 gfI+jV8IDmDa1ASaQGfBjaX9oVUHsc5eW1JTotlM=
Date: Tue, 6 Oct 2026 23:11:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: sungbyeongchan <tjdqudcks0424@naver.com>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] virtiofs: validate fixed-output response length
Message-ID: <2026100633-roping-stardust-a6ab@gregkh>
References: <20261004123405.586168-1-tjdqudcks0424@naver.com>
 <20261006182408.1301152-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006182408.1301152-1-tjdqudcks0424@naver.com>

On Wed, Oct 07, 2026 at 03:24:08AM +0900, sungbyeongchan wrote:
> A short successful virtiofs response can leave the fixed-output
> portion of the request argument buffer unwritten. The completion path
> nevertheless copies the full declared output to the request destination,
> allowing stale allocator contents to reach callers such as
> fuse_statfs().
> 
> Require successful fixed-output responses to contain their complete
> declared output. Continue to permit a shorter final argument only for
> out_argvar requests. Reject positive and internal restart error values,
> require valid error replies to be header-only, and do not copy output
> arguments from error replies.
> 
> A header-only FUSE_STATFS success returned stale fields in nine of
> nine calls across three boots. The fixed kernel rejected the short
> response and preserved complete replies, valid error replies, and
> variable-output controls.
> 
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>

Real name please.

> ---
> Changes in v2:
> - Reject positive and internal restart error values.
> - Require error replies to be header-only.
> - Rate-limit malformed-response warnings.
> - Rely on the existing FUSE pr_fmt prefix.
> - Add Cc: stable@vger.kernel.org.
> - Use the reporter identity consistently.
> 
>  fs/fuse/virtio_fs.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index f15e516ebcb5c..fffbe08d9114a 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -4,6 +4,8 @@
>   * Copyright (C) 2018 Red Hat, Inc.
>   */
>  
> +#include "fuse_i.h"
> +

Why is this moved?



>  #include <linux/fs.h>
>  #include <linux/dax.h>
>  #include <linux/pci.h>
> @@ -20,7 +22,6 @@
>  #include <linux/cleanup.h>
>  #include <linux/uio.h>
>  #include "dev.h"
> -#include "fuse_i.h"
>  #include "fuse_dev_i.h"
>  
>  /* Used to help calculate the FUSE connection's max_pages limit for a request's
> @@ -730,6 +731,10 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
>  	unsigned int num_out;
>  	unsigned int i;
>  
> +	/* Error replies contain only the output header. */
> +	if (req->out.h.error)
> +		goto out;

But no error is returned?

>  	if (len < sizeof(*oh)) {
> -		pr_warn("virtio-fs: response too short (%u)\n", len);
> +		pr_warn_ratelimited("response too short (%u)\n", len);

Isn't these ratelimited() changes separate from the original issue here?
That should be a separate patch.

thanks,

greg k-h
