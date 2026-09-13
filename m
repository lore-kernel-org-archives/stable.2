Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EB53E2AD1;
	Sun, 13 Sep 2026 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789305049; cv=none; b=rphbMC38n23O2AJrtSvXjKv3rafh55P3PRz6tpgTOMXVQHZli49Ly0ZNwW2b8g2azvTtlP8EeCzyNFJ92jCYLswNZVYmyYOaDsCmaX/losLlYFRNFrH1wpSjRIMIVQOZptJhyAWA+UCZCtLtrczDXkPIHL6sWfO1djibvADqzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789305049; c=relaxed/simple;
	bh=oKRATY12sMnEnSjWFEGAAU0cx7hfiK0kmulnJCGbS60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgtjzkCI64t3lotZ7N4T3RMB4ZTWy74/6tCOZ1bkBbioCbPD7JyFbOp6Z52oLp+XStHSm4NM6oBDi7Ba41vEMxlhHqFo6rnDB8768C5ZCYZtqJzhpGI5K58WofhoQHiVJS0Xw9O6VDfi520H4WdwO3Rh/jV2hvBU+hYdrNpxets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=cvprfNXy; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="cvprfNXy"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C41B814C2D6;
	Sun, 13 Sep 2026 15:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789305041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8eLEPccw6mZF4b+5Xtr8EKUEwESuHcReeXBXIeuoGe4=;
	b=cvprfNXyLKf3GM/tCddF6/dDAJ+r63auAWsUsQ9iLf+cx3XCCSTFrP2e3cmyQNtnzqAICB
	YJFts1YqTFxGPGt52fs6+RYo253FPuE3iMLydIWoG7NnKWietWPe1EvzuBY+ygUnabijvo
	1v8WI9QRDid2D3fnl4GtQGq5GVan8AZCJKDt32vwO7in91dlEeN4lHw5nEjYhbUa4PVdiz
	IuXtol0wS5lGRrcaMDopTWSZPmQfhmIZ4RON96vEyjRWHGVGkyPLu9Y/dW7hH0Ei54+kL6
	FUyphgDsIfqZJANop+F/5CHiUA3+I//y5fZ20Dc2HtdM9Q2tk7nVA9H70JYubw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e8935d42;
	Sun, 13 Sep 2026 13:10:36 +0000 (UTC)
Date: Sun, 13 Sep 2026 22:10:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	Stefano Stabellini <sstabellini@kernel.org>,
	=?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [PATCH] 9p/xen: drain response work after unbinding IRQ
Message-ID: <aqagvTnrIOGl8nfi@codewreck.org>
References: <20260609155202.1706-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609155202.1706-1-zhaoyz24@mails.tsinghua.edu.cn>

Yizhou Zhao wrote on Tue, Jun 09, 2026 at 11:52:01PM +0800:
> commit ea4f1009408e ("9p/xen : Fix use after free bug in
> xen_9pfs_front_remove due to race condition") added cancel_work_sync()
> to keep xen_9pfs_front_free() from freeing a ring while
> p9_xen_response() is still running.
> 
> The work is currently drained before the event channel IRQ is unbound.
> That leaves a race window where xen_9pfs_front_event_handler() can run
> after cancel_work_sync() returns and queue p9_xen_response() again.  The
> following unbind_from_irqhandler() synchronizes with the IRQ handler, but
> it does not cancel work that the handler already queued.  The teardown
> can then free the ring and private data while the response work remains
> pending, and the worker later dereferences ring->priv and priv->client.
> 
> Unbind the event channel IRQ before draining the work.  Once the IRQ is
> unbound, no new response work can be queued by the backend event channel,
> and cancel_work_sync() waits for any work that was queued before or
> during the unbind.  It is then safe to release the ring resources.
> 
> Fixes: ea4f1009408e ("9p/xen : Fix use after free bug in xen_9pfs_front_remove due to race condition")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

This one makes sense to me and I've picked it up, but I think
"9p/xen: fix use-after-free in p9_xen_request"[1] adding a refcount to
the front_priv is too much complexity vs. my understanding of the
current threat model -- I can pick it up if someome who understands xen
better than me has a proper look.

Stefano or Jürgen if you care / have time?

[1] https://lore.kernel.org/r/20260529103416.81378-1-zhaoyz24@mails.tsinghua.edu.cn

Thanks,

> ---
>  net/9p/trans_xen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index f9fb2db7a066..73c75fbdfa21 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -281,14 +281,14 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
>  		for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
>  			struct xen_9pfs_dataring *ring = &priv->rings[i];
>  
> -			cancel_work_sync(&ring->work);
> -
>  			if (!ring->intf)
>  				break;
>  			if (ring->irq >= 0) {
>  				unbind_from_irqhandler(ring->irq, ring);
>  				ring->irq = -1;
>  			}
> +			cancel_work_sync(&ring->work);
> +
>  			if (ring->data.in) {
>  				for (j = 0; j < (1 << ring->intf->ring_order);
>  				     j++) {

-- 
Dominique Martinet | Asmadeus
