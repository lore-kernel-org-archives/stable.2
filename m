Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67150352022;
	Tue, 15 Sep 2026 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789455031; cv=none; b=rgXBzebuRU15X5VKolOpgln9fOGypFusBFeDDzFJTq7Jq38hZfmorLzP62KUzEKclunIXicHv+jHliqrWyDS50EmvehxRfbTBNdok6mBDlZwoResLZMFzHhaWPZgyreu39/87Brtp/hkEHqGe9xkwUTpSkZkr/Z4M0B6D2Fjow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789455031; c=relaxed/simple;
	bh=vVfFMXWFIKCa7TUacLMmOUEwUf+WoT9zwsVFEb9qZf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjHEyOTVaWgZUNa1tKGSniu49GL+5N+Ar+6Mv/XNOa6lY2viq9Bobg6ZOdfkexwb3LGv4JnCW4C4n49wtkSE/IInvMhAh7M5oDKebau4Of9jf+2eLA3QXfaEOAKLgnUmCOY652YGL/4t/J9dqKQ+ELnrCSfrc9ccHJUJQEEM/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m89d+Fb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m89d+Fb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C707D1F00893;
	Tue, 15 Sep 2026 06:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789455030;
	bh=PfpFJrFJqJOm/t95RYZqbpWAhj05M8B1QD4+wWm0lrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m89d+Fb/7ut5BSBLySdppucBtFAmbfZlviV5V5qlguiHLYYWuBFZLiT0BzFVGXiKE
	 fQmxx07mesoddT6vHWhDrFs80wrgMCQPuE+fDU33FduB97Px6K17b2Ql+yZ6yNzVld
	 HLpfJc30B8DAQ+6DAJAWiEisEmIobIj7Cnv161Al3HqtU6Y3Qz/zYsMCDd8n8lqAwy
	 66MHHydWFl9Tbrgd1egT3s/A88PinXXYy13iI4amlWrkeo0R6F8pqlw/AwepInTJZ0
	 CK9jajnqvWFoPz1DaDr+IXnEdZxujgwWxekvYh4b7den+9w2bLwplsnG2YHq3UgDD+
	 WJKAjjSGi/QFw==
Date: Tue, 15 Sep 2026 08:50:24 +0200
From: Michael Grzeschik <mgr@kernel.org>
To: Qi Zhang <marsy12010123@gmail.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Chengfeng Ye <nicoyip.dev@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] net/9p/usbg: clear stale request context after abort
Message-ID: <aqjqkBjTGt5S0azU@line.checkpat.ch>
References: <20260802152148.810390-1-marsy12010123@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802152148.810390-1-marsy12010123@gmail.com>

On Sun, Aug 02, 2026 at 11:21:48PM +0800, Qi Zhang wrote:
> From: Chengfeng Ye <nicoyip.dev@gmail.com>
> 
> usb9pfs_clear_tx() serializes access to the active TX request with
> usb9pfs->lock, but leaves in_req->context pointing at the request after
> p9_client_cb() drops the transport reference.  A later teardown path can
> therefore retrieve the same request after it has been freed:
> 
>   CPU 0 (p9_usbg_close)        CPU 1 (usb9pfs_disable)
>   lock(usb9pfs->lock)
>   req = in_req->context
>   p9_client_cb(client, req)
>     p9_req_put(client, req)
>   unlock(usb9pfs->lock)
>   request reaches zero refs
>     kmem_cache_free(req)
>                                 lock(usb9pfs->lock)
>                                 req = in_req->context
>                                 read req->t_err
> 
> The lock orders the two callbacks, but cannot protect a pointer that
> remains published after its reference has been released.  KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in usb9pfs_clear_tx+0x166/0x1b0
>   Read of size 4 at addr ffff88810e7420f4 by task poc/94
>   Call Trace:
>    usb9pfs_clear_tx+0x166/0x1b0
>    usb9pfs_disable+0x1d/0x30
>    reset_config+0x9d/0x200
>    __composite_disconnect+0xa7/0x140
>   Allocated by task 93:
>    kmem_cache_alloc_noprof+0x141/0x370
>    p9_tag_alloc+0x8f/0x5b0
>    p9_client_prepare_req+0xff/0x350
>    p9_client_rpc+0x1a5/0xac0
>   Freed by task 0:
>    slab_free_after_rcu_debug+0xa6/0x1e0
>    rcu_core+0x50a/0x1850
>   Last potentially related work creation:
>    kmem_cache_free+0x1db/0x3d0
>    p9_req_put+0x164/0x1f0
>    usb9pfs_clear_tx+0x120/0x1b0
>    p9_usbg_close+0x7e/0x150
> 
> Clear in_req->context after the callback while still holding the lock.
> This matches the consume-and-clear pattern in usb9pfs_tx_complete(), so
> subsequent teardown calls return without touching the released request.
> The existing callback and error ordering remain unchanged.
> 
> Fixes: a3be076dc174 ("net/9p/usbg: Add new usb gadget function transport")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> Signed-off-by: Qi Zhang <marsy12010123@gmail.com>

Acked-by: Michael Grzeschik <mgr@kernel.org>

> ---
>  net/9p/trans_usbg.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
> index 419cda13a7b5..9a83dff6f3dd 100644
> --- a/net/9p/trans_usbg.c
> +++ b/net/9p/trans_usbg.c
> @@ -439,6 +439,7 @@ static void usb9pfs_clear_tx(struct f_usb9pfs *usb9pfs)
>  		req->t_err = -ECONNRESET;
>  
>  	p9_client_cb(usb9pfs->client, req, REQ_STATUS_ERROR);
> +	usb9pfs->in_req->context = NULL;
>  }
>  
>  static void p9_usbg_close(struct p9_client *client)
> -- 
> 2.43.0
> 
