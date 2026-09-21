Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEDF449B0B;
	Mon, 21 Sep 2026 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027507; cv=none; b=fODhculj211S6naqsAp92PGEbHgOv3IjV50ax2QS4CzO7RGYwVtmwOzafJn/+hv+MRrPlV3TEuHfx+2TsFkF5QDmQZ7blbyuAyVPjkggX00IVBRU6Phsv7RZlpBDHgebsTQCW8NQIgfpzFjeNDge+oc8ZjxnfcSTm3/MCzlqe4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027507; c=relaxed/simple;
	bh=a/n2UTTUxtwDJZqReWTKaIcCW71MmmAPwmHvV28mSyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU6LGwGkZFTa70ti2tkNjpEurvbUWpL2/rUpOqINIdHfW0cpuN6CCx86zmPUzlrmXx4nWPCid4PFKlsnXnBKqqIMzHIjlNxcl5iqdvU6eTKoFatBMk2wvSWLO6qQfStqMeCmBzdtY25X4UhoV7KWiOPWT6c3tZ6TSmHkizmi+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzP1PNhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzP1PNhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DCC1F000FF;
	Mon, 21 Sep 2026 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790027505;
	bh=11rtVWeJe4knvCd22hAf+3zv2TxYKKAoQehr7JU3Km8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IzP1PNhViS2I9gUhsbOzZeUOGiuxYW/51y6djd1jLLEfvBI7pYg+ON2TWc5Zt8KE7
	 WkxHPXsAfgLEoCPYkhCPdtQX4WQjH6v69dJWkPu5QVZ5rn6VpNUL+HySOGB4V1khgr
	 6yr/sZozz3iNgZkf9m689X7bmux6Lk1eZLUhhZsYyA5utg5Wsqe+BYn9IsCvWLO5CF
	 oyiR4TcIxcjWszPtYpjA9qcgKRAAPn5PM1KgClS4SzNXxj6yLc+SC0nbU+huuT0s+0
	 mLxAnlFT5HVxYj6tmqfEyTs0ilNdDRFuCR5nAXToc1peVADFEQVKnO4qLZa52i9S56
	 8y+jUQsvIOixA==
Date: Mon, 21 Sep 2026 23:51:38 +0200
From: Michael Grzeschik <mgr@kernel.org>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: v9fs@lists.linux.dev, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, linux-kernel@vger.kernel.org, 
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>, 
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] net/9p/usbg: Fix use-after-free in disable_usb9pfs()
Message-ID: <arGmyo5RRAvWer5F@line.checkpat.ch>
References: <20260607130118.16579-1-zhaoyz24@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607130118.16579-1-zhaoyz24@mails.tsinghua.edu.cn>

On Sun, Jun 07, 2026 at 09:01:16PM +0800, Yizhou Zhao wrote:
> disable_usb9pfs() frees the IN and OUT usb_request objects before it
> disables the corresponding endpoints. If either request is still queued,
> the later usb_ep_disable() call cancels the endpoint queue and the UDC
> driver can still access the already freed request.
> 
> With dummy_hcd and KASAN, this is reproducible by queueing the OUT
> request and then disconnecting the configfs gadget:
> 
>   BUG: KASAN: slab-use-after-free in dummy_disable+0x2b4/0x300
>   Read of size 8 at addr ffff888009702400 by task sh/1
>   usb_ep_disable+0x8e/0x1f0
>   usb9pfs_func_unbind+0x193/0x350
>   gadget_dev_desc_UDC_store+0x135/0x280
> 
> dummy_free_request() also warns because the request is freed while its
> queue entry is still linked.
> 
> Disable both endpoints before freeing the request objects. This lets
> usb_ep_disable() cancel any queued transfers and invoke the completion
> callback while the request storage is still valid. The request objects
> are then freed only after they have been removed from the endpoint
> queues.

Acked-by: Michael Grzeschik <mgr@kernel.org>

> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: GLM:GLM-5.1
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
>  net/9p/trans_usbg.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
> index 1ce70338999c..5d0d6add150e 100644
> --- a/net/9p/trans_usbg.c
> +++ b/net/9p/trans_usbg.c
> @@ -278,6 +278,9 @@ static void disable_usb9pfs(struct f_usb9pfs *usb9pfs)
>  	struct usb_composite_dev *cdev =
>  		usb9pfs->function.config->cdev;
>  
> +	disable_ep(cdev, usb9pfs->in_ep);
> +	disable_ep(cdev, usb9pfs->out_ep);
> +
>  	if (usb9pfs->in_req) {
>  		usb_ep_free_request(usb9pfs->in_ep, usb9pfs->in_req);
>  		usb9pfs->in_req = NULL;
> @@ -287,9 +290,6 @@ static void disable_usb9pfs(struct f_usb9pfs *usb9pfs)
>  		usb_ep_free_request(usb9pfs->out_ep, usb9pfs->out_req);
>  		usb9pfs->out_req = NULL;
>  	}
> -
> -	disable_ep(cdev, usb9pfs->in_ep);
> -	disable_ep(cdev, usb9pfs->out_ep);
>  	dev_dbg(&cdev->gadget->dev, "%s disabled\n",
>  		usb9pfs->function.name);
>  }
> -- 
> 2.43.0
> 
