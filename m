Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024C4F4059
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776166; cv=none; b=VwKoUya/ND70rapGug42fldNx/9f1NZRjuPfY01PRo/GdzaIaTjx5UBBR4oJ3KPXZo/9tZY24AtEXgP6aRmE1pm6fXT2WBZQwSeeiAezEDUzvRueg/jJK32n4/moj75V++pkOLS89KMNVm27qN4AJ1vX3iNOJHz2Xsj5G6ZWWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776166; c=relaxed/simple;
	bh=1HeYn2vBqBt7mSWjMrFVCHOgMQtHR0UpPOpmpCl+Yuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFQ6T7XnJEMSqByDW7l0SEsuifVABUnV15IvMhGzIaHE/DZcDOarHTaOdPfjLOfSBJzNSYC3HdNdYVBgPrFJvJBj1B+O0EuWv/p8RYWKvhIFwqoone/O/dW5qLG7yBQ61tjoQZxm06p107YhLjLX/H3NzkAKwRdTaPIz0Oj1iE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=E0KwRFtv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JadpYvZd; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="E0KwRFtv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JadpYvZd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A131A1D006C6;
	Wed, 30 Sep 2026 09:49:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 09:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790776150;
	 x=1790862550; bh=cmYPuBEprU7f9+AdD7zMdKvAWh7vzcegmqS82LCYVUU=; b=
	E0KwRFtvM0Ij+jeUjUScGddVFHrIrNoBLI5VNS3cOn8DRa+P7C/3t0R/yQjlVR97
	C1jIARrAkWpJYlZ9Y887PD6kh7U7MzO+8LxP2Qfi4o8rVzhIPp6qeiYurADgn6Iy
	L+4o4m0ji5s3sflVTK9osRzDbBF/gABZIeY2z9q/PYKP7P4sCBDQ5ppFE9NNvdUQ
	vfDzLQ24wSWH/69s8dE/5Y7JyXPNOKIZRJ7nIeuvvJb8bDaOF+r2fXzZJF8h+tQm
	tzBQu3/pfRoRnagiFmGHxzFc266/BBi7lprdNnwIOO49Yo7PWp7eywmyUsI3k3sp
	lHdLA6dDVukfEugHuxkdDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790776150; x=
	1790862550; bh=cmYPuBEprU7f9+AdD7zMdKvAWh7vzcegmqS82LCYVUU=; b=J
	adpYvZd++noUTgxWdsKQv6XvMCDgR03K4lc+om+FgUtmFUhuHaT1bEsvMqutGXHw
	SXZHmWLp4W3+kfbR39LxaNDd+049JbLponM2tJHRJOtmwr0fsULc2mqnmeI3gCK9
	AhLvouP5PJmflHTOp6Rdq7lD98Eyx7IKZwS1GqqSZG4KS/qA3ZHtOtPgljKOLj6D
	+6AR0VIMdBBs2ubCBK8OUpMSjAOfFEQijww/Na+N2w3LJixNnhyglflR2EMnAry9
	1K8MkiCOAo6XOLSAZ8RIdj9fA0DOrx2IG1ZWVGWykmllXS4vdFA8YwYp37cHwUsB
	R1TY5QA8Ibh/L88S+UIgw==
X-ME-Sender: <xms:VhO9audK6YaMGU6q2mMK7xdTx7NftN0AeBjyss8343dXjz2DTgrizQ>
    <xme:VhO9arRvCZpSaA1EWmvy3sH0wTv0_8tTv9zNu3Tv4_dyadZr2KPPucpeJAmSm4Spk
    hXI--zSZK4xrGs5iOnsj8xl3UJPvVik4-eOLkg2snX2YSf2PHk>
X-ME-Received: <xmr:VhO9aqIfbn690_lApT4Zw81rdzZ4Y7ymnm_yLXOdjtgHLVbGJbaf8bsBPSmdO_RittnRwqvgwU1D1yFSvKmDD_7vxRDrCpU_Q3oDP1dfFok>
X-ME-Proxy-Cause: dmFkZTGm8YVUcO2t4FuFPT8SoTkvlG4/ho2J5SKyXmSA3Fua9TlfJgqKhFtf2oa/TzyEi8
    VHGwgnl+p+W7PoR93gubJ+FMyyk79ukon0qLL+WNqacRmbMzxyhbXiGIKG64KRDIpRmwiJ
    mKoapTlai/f9LF/26sEiAsGQP+Vt6jln7nSnI/ytlvrRlCiwRIvB9Gveomm0vL3zJZ88Ym
    t10wJLALv7F2d8UoQB9sctj2l1jkV0jfCelwwFYQlKGkJvGtonG0YP4qc429rJKWByGa+O
    J6R7BeBr2AZRnJPq+whf17IWW5BnKTatVBnN70uMq0Os4SEJoUifoa8gNfUHugEBwOfPN5
    5nTykaAeIyFCR2iM9I+cN9AGDcH9sgLGwYii7+Dkob5zS+aCA/zGBI53yt4aZZhKdMyCPv
    EvkA/h2SJGSGR84cgYYA22ga9UHEq0zA4wxpDWwGjmKPZbNXBIwylqWq5vTNcmjfU98HCV
    8zupBgzpKfvUC9pAhEOjBvFPid2A4Uvgcp1Wjb/MTOKsxFUd9vgUiQ67SDSjHvvbhzoG9L
    KYx1dokxOPMNpmpxU3m/7Tb+m8UdzIomr+HjdfQOHpYcDy0X+oCdKY6sUfGADCb5A2UNV1
    90Jfyg4P49XjoHHtXAuy7BJAglL5mZ3ZfcyDR06xNajXKhINMrPNpOgYY+PQ
X-ME-Proxy: <xmx:VhO9aoJ7qUMdvsntxrr7vm_ouz8RVjxZQ3UoMpUCsP0ef9kNtLDtuw>
    <xmx:VhO9aljLuD9Fs7E8yp0hOgB5gSfujyxRKVLrf_xWcUR6d37jjYbUQg>
    <xmx:VhO9aiO18a_wtzOHhKNi4dfSYf7BDfBnW-YD6Alu-CdLD2LMkzsPvw>
    <xmx:VhO9agpUZvIYe9qaL0oSNAL_x8sbobw2nz49Z6ZH-vaGRFcdMzG_Rg>
    <xmx:VhO9as-phAtOiPO1lO5t85eEAoJVjImMjERvS8837OTuW6qSW_QpeZWC>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:49:10 -0400 (EDT)
Date: Wed, 30 Sep 2026 15:49:05 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Baineng Shou <shoubaineng@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 6.12.y 2/2] misc: fastrpc: don't publish fd before
 copy_to_user() succeeds
Message-ID: <2026093034-backward-baguette-32e7@gregkh>
References: <2026090820-pasta-equal-9989@gregkh>
 <20260910155546.1134527-1-sashal@kernel.org>
 <20260910155546.1134527-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910155546.1134527-2-sashal@kernel.org>

On Thu, Sep 10, 2026 at 11:55:46AM -0400, Sasha Levin wrote:
> From: Baineng Shou <shoubaineng@gmail.com>
> 
> [ Upstream commit a4a1a2bfcb29785292d634d7787edc6fb550714d ]
> 
> fastrpc_ioctl_alloc_dmabuf() calls dma_buf_fd() which installs the fd
> into the caller's fd table before copy_to_user() copies the fd number
> back to userspace.  If copy_to_user() fails, the fd is already visible
> to other threads in the same process but the ioctl returns -EFAULT.
> The existing comment in the code even acknowledges the problem:
> 
>   "The usercopy failed, but we can't do much about it, as dma_buf_fd()
>    already called fd_install()..."
> 
> Now that dma_buf_fd_install() is available (introduced to fix the same
> issue in dma-heap), apply the same pattern here: reserve the fd with
> get_unused_fd_flags(), attempt copy_to_user(), and only on success call
> dma_buf_fd_install() to publish it atomically with the tracepoint.  On
> copy_to_user() failure, put_unused_fd() and dma_buf_put() cleanly
> unwind without any user-visible side effects.
> 
> Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
> Cc: stable@vger.kernel.org
> Acked-by: Christian König <christian.koenig@amd.com>
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
> Link: https://lore.kernel.org/r/20260817050457.1005285-3-shoubaineng@gmail.com
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/misc/fastrpc.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 576cd9e5b8079..f09702eaa3915 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1682,24 +1682,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
>  		return err;
>  	}
>  
> -	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
> +	bp.fd = get_unused_fd_flags(O_ACCMODE);
>  	if (bp.fd < 0) {
>  		dma_buf_put(buf->dmabuf);
> -		return -EINVAL;
> +		return bp.fd;
>  	}
>  
>  	if (copy_to_user(argp, &bp, sizeof(bp))) {
> -		/*
> -		 * The usercopy failed, but we can't do much about it, as
> -		 * dma_buf_fd() already called fd_install() and made the
> -		 * file descriptor accessible for the current process. It
> -		 * might already be closed and dmabuf no longer valid when
> -		 * we reach this point. Therefore "leak" the fd and rely on
> -		 * the process exit path to do any required cleanup.
> -		 */
> +		put_unused_fd(bp.fd);
> +		dma_buf_put(buf->dmabuf);
>  		return -EFAULT;
>  	}
>  
> +	dma_buf_fd_install(buf->dmabuf, bp.fd);
> +
>  	return 0;
>  }
>  
> -- 
> 2.53.0
> 
> 

breaks the build :(
