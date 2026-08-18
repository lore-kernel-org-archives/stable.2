Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558A451980;
	Tue, 18 Aug 2026 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061543; cv=none; b=erBtRDqN2JBUnOyBnxARFlC28dD+GYquph9buvlrmrcW3vThXghCEv7RBnOK2wm70yc6t7vGJ66A1AXoZnING5jtdiY8tyJ8MLkrj0T5c2rcKLyllnGtlEf93mlJsX8WQ2Mq1NKJpREIkqZ8jWs1J+s2954SNIJUZN+3Qnxlu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061543; c=relaxed/simple;
	bh=HkRqaq1bppOapJdI6Znqno4j3pC+nLGwmFM6kH8Rja4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6do32dmNK55vNQrQy2zIL15cabqH2DPxlHM+6olkB+2QfZVA3NwOsrJPGzqt8yF5fqkR3a0OOHsAoeneQjADE+CjagB/F8OgagUmjG0V97BFAvhZk5EQhaFhJsXC5t99rOwP9K8/ZovgRSN/ExUOnb7KN5oE9p018PYBVJL1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIG0vdbQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIG0vdbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961071F00A3D;
	Tue, 18 Aug 2026 13:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787061541;
	bh=IUwCSKDdvc2Hd6HBWRbeUXBKw/UjY3Ju8eE9RP9agVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VIG0vdbQsIQACw9W71TaQkhdzpEtJhF+ZqIlu3U3jZxBcEXkDXHosJPnSXjBNtxGz
	 HRN3ZkdX+C2VR8OXaa9/+gifwH3kEE6OHotB1qG+9WzzNAl/GhyG4M5YCFgf76ME68
	 Bo6ZO/+0jfzWndEk6E8bT+uRdyrCT5o7Gp2Te7fixHal+jwPT4xscq3P2eD3fFcpG/
	 y9xpiE0c5qWEoJJyau1c6LRtp1KQQgUGfFx8tSSuPukz+5OBQ/FOtwPStU7+6dirjL
	 2HSJnthgwZk6jmxKQkEhzDVNQ18dI+h0x4BCrMbKbrBVNpr23B+TAjOpC8Dw0pZUss
	 8zFFa4q0nwX3A==
Message-ID: <151c7b8e-8ae7-4355-81bb-51fd487ef418@kernel.org>
Date: Tue, 18 Aug 2026 15:58:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virt: vboxguest: fix use-after-free in balloon work
To: Fan Wu <fanwu01@zju.edu.cn>, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260818081139.399994-1-fanwu01@zju.edu.cn>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260818081139.399994-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Aug-26 10:11, Fan Wu wrote:
> VMMDEV_EVENT_BALLOON_CHANGE_REQUEST is reported only after a guest
> userspace client enables it with VBOXGUEST_IOCTL_SET_EVENT_FILTER.
> The interrupt handler then queues the balloon work, which reads and
> writes the mem_balloon.get_req and change_req request buffers.
> 
> vbg_pci_remove() calls free_irq() before vbg_core_exit(), but
> free_irq() only waits for the handler to return, not for any work it
> has queued.  A balloon work still running on system_wq therefore
> touches the request buffers after vbg_core_exit() has freed them:
> 
>   CPU 0 (remove)          IRQ handler              system_wq
>   free_irq()              schedule_work(...)
>                          return
>   vbg_core_exit()
>     vbg_req_free(...)                             vbg_balloon_work()
>                                                    req->event_ack = ...
> 
> Fix this by calling cancel_work_sync() on mem_balloon.work in
> vbg_core_exit(), before the request buffers are freed.  The worker
> does not requeue itself, and the interrupt handler, the only place
> that queues it, can no longer run when vbg_core_exit() is reached:
> vbg_pci_remove() has already called free_irq(), and on the probe
> error path the irq was never requested.  Draining the work once is
> therefore sufficient.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 0ba002bc4393 ("virt: Add vboxguest driver for Virtual Box Guest integration")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




> ---
>  drivers/virt/vboxguest/vboxguest_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
> index b177a534b6a4..884e69d00f72 100644
> --- a/drivers/virt/vboxguest/vboxguest_core.c
> +++ b/drivers/virt/vboxguest/vboxguest_core.c
> @@ -1048,6 +1048,8 @@ int vbg_core_init(struct vbg_dev *gdev, u32 fixed_events)
>   */
>  void vbg_core_exit(struct vbg_dev *gdev)
>  {
> +	cancel_work_sync(&gdev->mem_balloon.work);
> +
>  	vbg_heartbeat_exit(gdev);
>  	vbg_guest_mappings_exit(gdev);
>  

