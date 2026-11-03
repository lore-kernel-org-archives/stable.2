Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717769;
	b=yda4VqgaBkghk1NrY6O/obdK1AxcdEp8xfbrvvcSKarpjjaTAHGg+Sne3Bi4/RpevvvQ
	 DMr7Ys+VLgKEq+DGqbt13iIeYxeLwxhecE0dOdIBdIXOZsT2QczueFittFRM6P3OxVD0X
	 Fj50KNk14zzOyDSirghsW+nLVWaIy5iJH8QbDJP9Yx6QbGnyJEh3TIUZJo27+bt3gOrLF
	 oDGoJACZABmp28ZMVFFkazU9cTeDMMA1t6MjJks/US8S/3xodbLa1a/MZaX0mwhG6p0ST
	 rBeT+6E1/r+G2j70Py4Tc81BFRPSgFCHKbQ4Nw6pAb3psiFrq3YbWe19IO7mTvJ49vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717769;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vebAuFRic18JYj0ceFy67NLDnQtwOl1/tHyfOqhU5xg=;
	b=T0Xc5gycyU1YJ13kSyUwVOVHl91GMi+346kjtDo30rDK9Xae3J4rgavBwrWhBtsSW3Al
	 waJAiA7xxy5N9ygrOhuK/8W9a6s05OBSwJE93SKAbMMungwpnvbREtacI7LP1veNG5hrQ
	 h2eKrJZe0kzOie53q8uN8CBPIjZxTbNMnPgL5Rtil7Y6bdmKeuHK7m4wd/5MRqh9ccNYF
	 FweKI0tlx+wtVgEs9LhqCrG4I7RRC34myppdzV0W6JMWvvkbOQWau5k0CViekRcjtgHMe
	 wkhXbOrZ2URLZ6GzxVJRTdKAp1tGbjxLf5b4toaY74TVSx233Kug6tbaOim7nQ7If3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=El05i11B;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC4606A32F;
	Tue,  3 Nov 2026 14:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22DC4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=El05i11B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793717769; x=1825253769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZpeTG0rBnmzRLYcZp0cYQM8/3s5qDdobT3m1WWFTXNM=;
  b=El05i11BRc51IK454Di3Iwt7T7KlSWbea4PtVXy1yXsM/NSAi0q6jUqZ
   752Cpu2XL9zK23kKi6qkhSjAApOxYcg6ud5oCkM+8UwIeQLbgBY80YQok
   xHZf1Vyu7trS/qcVtUo5A6GHsePMdnpai01ulhCQlSXerGTtF+uBtkKBf
   2vm79tAa7OAgeUS9q+S+seznslZDXlr7GybIM2LODisXE9Bg3+oxA/yxw
   CYGmcl0xc8Re9086JIvMqnazxrtKp2Yf0pfLe5Z4deYpS5fHp3v8q2M50
   NrhCAkP8gNV0QPPC2kpTO3Y/iCTei2ioRobiPBgPN4shmIgKWOzMxClhW
   A==;
X-CSE-ConnectionGUID: M9eWUd2rS1WiHZM70QWB3Q==
X-CSE-MsgGUID: eHqUMTd1RAiEvUh4pw8VtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2323537"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2323537"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:56:08 -0800
X-CSE-ConnectionGUID: y2qZUdDxTi+LPkiTnKGi6Q==
X-CSE-MsgGUID: PiB7GEVYTJ+Csp0vNOpFcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6814335"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.245.138]) ([10.245.245.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:56:06 -0800
Message-ID: <3ca5cced-f429-42d9-9bbb-f5111acd9665@linux.intel.com>
Date: Tue, 3 Nov 2026 16:56:02 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: xhci: Fix use-after-free race in
 xhci_stop_device()
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
 Cheng Wen <wencheng@xidian.edu.cn>
References: <20261026123628.7493-1-25031212351@stu.xidian.edu.cn>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20261026123628.7493-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi


On 10/26/26 14:36, YuanZhe Liu wrote:
> A KASAN slab-use-after-free read was observed in xhci_stop_device():
> 
>    BUG: KASAN: slab-use-after-free in xhci_stop_device.constprop.0.isra.0+0x395/0x430
>    drivers/usb/host/xhci-hub.c:479
>    Read of size 8 at addr ffff88804e85d2f0
> 
>    Freed by task 585700:
>     kfree+0xf8/0x390 mm/slub.c:6566
>     xhci_free_virt_device+0x3f/0x50 drivers/usb/host/xhci-mem.c:881
>     xhci_free_dev+0x286/0x350 drivers/usb/host/xhci.c:4131
>     usb_disconnect+0x6b6/0x910 drivers/usb/core/hub.c:2391
>     ...
>     usbdev_ioctl+0x6f05/0x86d0 drivers/usb/core/devio.c:2826
> 
>    Allocated by task 572283:
>     xhci_alloc_virt_device+0x171/0xb70 drivers/usb/host/xhci-mem.c:986
>     xhci_alloc_dev+0x475/0x840 drivers/usb/host/xhci.c:4271
>     usb_alloc_dev+0xe8/0xdc0 drivers/usb/core/usb.c:661
>     hub_event+0x1c82/0x4050 drivers/usb/core/hub.c:5953
> 
> xhci_stop_device() reads xhci->devs[slot_id] without xhci->lock and
> keeps using the pointer across xhci_alloc_command(GFP_NOIO), which may
> sleep.  All callers (the port suspend and bus suspend paths in
> xhci_hub_control() and xhci_bus_suspend()) drop xhci->lock before
> calling it, so a concurrent usb_disconnect() -> xhci_free_dev() can
> clear xhci->devs[slot_id] and free virt_dev under xhci->lock in that
> window.  The endpoint loop then dereferences the freed virt_dev.
> 
> commit 88716a93766b ("usb: xhci: Fix panic if disconnect") added a
> NULL check for this case, but that only helps when the device was
> already freed before the check; it does not close the window.
> 
> Re-check xhci->devs[slot_id] against the pointer fetched earlier after
> taking xhci->lock and bail out if it no longer matches, or if the
> device is already being torn down.  The tracepoint reloads
> virt_dev->udev, so it moves under the lock and only runs while the
> device is still attached.
> 
> xhci_free_dev() clears virt_dev->udev without xhci->lock, and only
> later detaches the device from xhci->devs[] in xhci_free_virt_device(),
> also under the lock.  Take xhci->lock when clearing ->udev so that
> xhci_stop_device() can rely on it while holding the same lock.
> xhci_free_virt_device() frees the device under xhci->lock, so a
> matching pointer while holding the lock keeps virt_dev alive until
> xhci_stop_device() drops the lock, after which virt_dev is not used
> anymore.
> 
> Fixes: be88fe4f4dda93e3 ("USB: xHCI: port power management implementation")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Thanks for the patch, good catch.

I have some small minor adjustments that would make final code a bit cleaner

> ---
> Changes since v1:
>   - xhci_free_dev(): clear virt_dev->udev under xhci->lock, so that
>     checking it under the same lock actually synchronizes with the
>     store.
>   - xhci_stop_device(): bail out with -ENODEV once ->udev has been
>     cleared, instead of queueing stop-endpoint commands for a slot
>     that is already being disabled.
> 
>   drivers/usb/host/xhci-hub.c | 19 +++++++++++++++++--
>   drivers/usb/host/xhci.c     |  3 +++
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index b0264bd8577a..f4401f2fcea0 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -467,13 +467,28 @@ static int xhci_stop_device(struct xhci_hcd *xhci, int slot_id, int suspend)
>   	if (!virt_dev)
>   		return -ENODEV;
>   
> -	trace_xhci_stop_device(virt_dev);
> -
>   	cmd = xhci_alloc_command(xhci, true, GFP_NOIO);
>   	if (!cmd)
>   		return -ENOMEM;
>   
>   	spin_lock_irqsave(&xhci->lock, flags);
> +
> +	/*
> +	 * Callers drop xhci->lock before calling us and allocating cmd
> +	 * above can sleep, so xhci_free_dev() may have detached and freed
> +	 * the device in the meantime.  It removes the device from
> +	 * xhci->devs[slot_id] and clears ->udev under xhci->lock, so while
> +	 * the lock is held a matching, still-attached device stays alive
> +	 * and keeps its udev.
> +	 */

Comment above is not needed, can be removed

> +	if (xhci->devs[slot_id] != virt_dev || !virt_dev->udev) {
> +		spin_unlock_irqrestore(&xhci->lock, flags);
> +		xhci_free_command(xhci, cmd);
> +		return -ENODEV;
> +	}

No point in keeping the 'virt_dev = xhci->devs[slot_id]' before taking the lock.

Just move that part inside the lock as well:

virt_dev = xhci->devs[slot_id];
if (!virt_dev || !virt_dev->udev) {
	unlock
	free command
	return -ENODEV
}

> +
> +	trace_xhci_stop_device(virt_dev);
> +
>   	for (i = LAST_EP_INDEX; i > 0; i--) {
>   		if (virt_dev->eps[i].ring && virt_dev->eps[i].ring->dequeue) {
>   			struct xhci_ep_ctx *ep_ctx;
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 5c759ad28199..9e375eb48f38 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -4128,9 +4128,12 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
>   	trace_xhci_free_dev(slot_ctx);
>   
>   	/* Stop any wayward timer functions (which may grab the lock) */
> +	spin_lock_irqsave(&xhci->lock, flags);
>   	for (i = 0; i < 31; i++)
>   		virt_dev->eps[i].ep_state &= ~EP_STOP_CMD_PENDING;
>   	virt_dev->udev = NULL;
> +	spin_unlock_irqrestore(&xhci->lock, flags);
> +

Should work, we are now using virt_dev->udev as a flag to tell xhci_stop_device() to
not queue any stop endpoint commands as we know a 'disable slot' command will be
queued shortly.

Another option would be to add an actual 'disable_slot_pending' flag to struct
xhci_virt_device, and set it in xhci_disable_slot() when we really are queuing the
disable slot command with lock held.

While looking at this I realize that xhci_disable_and_free_slot() might also race
with xhci_stop_device(), but that change doesn't need to be part of this patch.

Thanks
Mathias
