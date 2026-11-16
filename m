Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=184.106.54.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824098;
	b=kGYjYarZ9dlY9nv6QeXiFKYRsjZzwgwxjl8a/yen+ID8pq3/wsD1NUl5AHr6iE0MGlIh
	 kWglAygT9+StcSCZs76R7oHbSPbwhO5gd98WFrw76Ekm7Pef7EjROsCbHHCsss6ypHBu6
	 0KpZp/RtLKmAg44l2O/ztMMZ+XlhjLtl7dmVc5Bn24R47QOgL/xWQHd9NsPMwjj7nWks4
	 za5Gvw6EFuhIuuYc88SmOSYCeOmNcpGrICv9HQQ1bviPwIT3KSdKmquewwSITWv/QN/AL
	 ADOsD3J4bfkn3gHnbPJULMJ77sWxu08sbY+BSt2Xmy2P3YyMnEGXrcHKawF+bmJ4U5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824098;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Classification-ID;
	bh=SQ/dI9dsVM147KmQyCu8940dPv7eiRNbyoonkE+v7wY=;
	b=od/TXrxJ+ZCFUJqBxSwgeCcTbWNeRpYTm7T9Zb+HRpDcO9HstzgB2EFKlu/WOKhwTLaf
	 sM/bkfOwsoYixSVSusWKhgHrjdpOWLs5NQBvF5JvrLg0G3HrS4noTCpntDjfSKv/FDiNy
	 2tRSZKTOgmnzk5KjTZWik8j+Zs6IbFWMKcpCgxgbbtgYTwtmxIgdr6y2kMc5gQEXioGsW
	 ZZVoKk1OEQ0QWh68oDsArxAVSZ8evoLjWu1JPJF97kTaCxvo/bZf9jjRCJYoiNBY3Qxi3
	 NlmH5OB5R8bq7nwRvei7bSWtdhhjyW8tvm1XUjKS/nXzv/xOnLQFFUg/LHjEVgHF4Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=niRxiDUG;
	arc=none smtp.remote-ip=184.106.54.120
Received: from smtp120.ord1d.emailsrvr.com (smtp120.ord1d.emailsrvr.com [184.106.54.120])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803F606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9803F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=niRxiDUG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794824090;
	bh=eoWnZRZmALCF+kIvIYZxN9W8oA7hh9Q0a3aJPfpZ4ck=;
	h=Date:Subject:To:From:From;
	b=niRxiDUGNCRJ7A8iSPYeqfSkHs+QNzNTzGQND1Jbilp1adIoaeHvB1AxHDgZKE03f
	 iBkr7hoblP83/DEEjmQogWb2Ggjmzffqpu3PyGV9+L+shZZ892WqspPHWhD8QvpY5/
	 7miQSRNiSqMix1A9MzeFGB8qJFZHNn616z8tdofs=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id A6C81C01F2;
	Mon, 16 Nov 2026 05:14:49 -0500 (EST)
Message-ID: <68cfd12f-5e86-45d6-b186-46058cbacc1b@mev.co.uk>
Date: Mon, 16 Nov 2026 10:14:49 +0000
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
Subject: Re: [PATCH] comedi: defer freeing async areas that still have pollers
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
References: <20261116085328.11090-1-25031212351@stu.xidian.edu.cn>
Content-Language: en-US
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20261116085328.11090-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 36dd1f15-91be-4f68-b55c-f259251cbc73-1-1

On 2026-11-16 08:53, YuanZhe Liu wrote:
> comedi_device_detach_cleanup() frees the async area of every subdevice.
> The async area contains the wait queue head that comedi_poll() queues
> pollers on, and a poller is not removed while comedi_poll() runs:
> comedi_poll() only holds dev->attach_lock while adding the wait queue
> entry, and the entry is removed later by poll_freewait() when the poll
> system call returns.
> 
> Detaching through the COMEDI_DEVCONFIG ioctl is guarded by
> is_device_busy(), which refuses to detach while the wait queue has
> sleepers.  Removing the hardware is not: comedi_release_hardware_device()
> calls comedi_free_board_dev(), which detaches unconditionally.  Unplugging
> a USB COMEDI device while a task is polling it therefore frees the async
> area from under that task, and the task hits a use-after-free when
> poll_freewait() locks the freed wait queue head:
> 
>    BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave
>    Write of size 4 at addr ffff888004508498
>    Call Trace:
>     _raw_spin_lock_irqsave
>     remove_wait_queue
>     free_poll_entry
>     poll_freewait
>     do_sys_poll
> 
> Every task that can have an entry queued on async->wait_head holds a
> reference to the COMEDI device file, and comedi_open() holds a reference
> to the COMEDI device for as long as the file is open.  The device
> therefore cannot be released until the poll system call is done with the
> wait queue, so move async areas that still have waiters to a list and
> free them from comedi_dev_kref_release() instead of freeing them at
> detach time.
> 
> Fixes: 2f3fdcd7ce93 ("staging: comedi: add rw_semaphore to protect against device detachment")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
>   drivers/comedi/comedi_fops.c     |  8 ++++++++
>   drivers/comedi/drivers.c         | 14 +++++++++++++-
>   include/linux/comedi/comedidev.h |  8 ++++++++
>   3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
> index 9a65dc5d62a4..932e35d7f68c 100644
> --- a/drivers/comedi/comedi_fops.c
> +++ b/drivers/comedi/comedi_fops.c
> @@ -106,6 +106,7 @@ static struct cdev comedi_cdev;
>   static void comedi_device_init(struct comedi_device *dev)
>   {
>   	kref_init(&dev->refcount);
> +	INIT_LIST_HEAD(&dev->async_free_list);
>   	spin_lock_init(&dev->spinlock);
>   	mutex_init(&dev->mutex);
>   	init_rwsem(&dev->attach_lock);
> @@ -116,6 +117,13 @@ static void comedi_dev_kref_release(struct kref *kref)
>   {
>   	struct comedi_device *dev =
>   		container_of(kref, struct comedi_device, refcount);
> +	struct comedi_async *async, *tmp;
> +
> +	list_for_each_entry_safe(async, tmp, &dev->async_free_list,
> +				 free_list) {
> +		list_del(&async->free_list);
> +		kfree(async);
> +	}
>   
>   	mutex_destroy(&dev->mutex);
>   	put_device(dev->class_dev);
> diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
> index 3f75485338a1..f91535fccd2b 100644
> --- a/drivers/comedi/drivers.c
> +++ b/drivers/comedi/drivers.c
> @@ -168,7 +168,19 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
>   			comedi_free_subdevice_minor(s);
>   			if (s->async) {
>   				comedi_buf_alloc(dev, s, 0);
> -				kfree(s->async);
> +				/*
> +				 * A task that is polling the device file may still
> +				 * have an entry queued on the wait queue inside the
> +				 * async area.  Such a task holds a reference to the
> +				 * device file, which keeps the COMEDI device itself
> +				 * alive until the poll is done with it, so defer
> +				 * the release until the device is released.
> +				 */
> +				if (wq_has_sleeper(&s->async->wait_head))
> +					list_add_tail(&s->async->free_list,
> +						      &dev->async_free_list);
> +				else
> +					kfree(s->async);
>   			}
>   			kfree(s->readback);
>   		}
> diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
> index 577a08f37aee..54e324c0614f 100644
> --- a/include/linux/comedi/comedidev.h
> +++ b/include/linux/comedi/comedidev.h
> @@ -15,6 +15,7 @@
>   #include <linux/spinlock_types.h>
>   #include <linux/rwsem.h>
>   #include <linux/kref.h>
> +#include <linux/list.h>
>   #include <linux/completion.h>
>   #include <linux/comedi.h>
>   
> @@ -365,6 +366,11 @@ struct comedi_async {
>   	unsigned int cb_mask;
>   	int (*inttrig)(struct comedi_device *dev, struct comedi_subdevice *s,
>   		       unsigned int x);
> +	/*
> +	 * Link in &struct comedi_device.async_free_list when the async area
> +	 * cannot be freed at detach time because pollers may still use it.
> +	 */
> +	struct list_head free_list;
>   };
>   
>   /**
> @@ -558,6 +564,8 @@ struct comedi_device {
>   
>   	int n_subdevices;
>   	struct comedi_subdevice *subdevices;
> +	/* async areas waiting for the last user of the device */
> +	struct list_head async_free_list;
>   
>   	/* dumb */
>   	void __iomem *mmio;

The patch looks interesting, but I have already sent a patch that fixes 
the problem in a different way, by waiting for the queues to clear 
before freeing the storage.

https://lore.kernel.org/lkml/20261112173314.118594-1-abbotti@mev.co.uk/

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

