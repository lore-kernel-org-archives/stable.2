Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601738;
	b=3k4VXxs4FL91iFGZMHvXX7kH53V4051htQTuxkBmvm1juoh5vNV3yxnoSby2dW5vqav1
	 mdGSTvvpQqhfce90yOlnYwQ7t01R2ZyPcfnb1DZBDwgx7JqFOayMqSQORYMGPQNYjVnF/
	 r9oRTHaT4/RNmXLvdXODf2yWrlwc3P1LTDfSD3fWc3IHXWOZMx06mdq28EesKNvAuT3Mr
	 nkWlQGmPoDhpdy0c/D67ZCa3VZM29e6mdifomDTe9IaSbgkVmHJ9GyhRTIN4YW+ZwDTEm
	 oeZbdDU5zZ5oq2QimmX5Rpq2ry5pJipDaNqsJxdGSimc3jgTTN1Yh1+LP2CtEoJWrAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601738;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=eqHXyc8WJEin7dgT8XNE7C77zQYt4IAJAZzyBASlFd8=;
	b=VJKCbd/JkxLbW34CgO/NMnkPnP7Y7bEAuaFwE+W3xub5r4mEnEQNfNrR3FyU3mgaldAc
	 g/8PBOFqcZktX3K60KTe1aRmMSoXx8AJLCWjqW9hTcV32Db19a1h/0+6gqwdtRycAJAMH
	 uzgrnFcjbL9sglt+2tTCazgfHhET9HAD9yhyoQm9nKzGzj/0TpmA3VvbzFHIEnk5juBcU
	 pzxQri/Ih0IetxoI8+PZ2XqzpqAeoCuXJY8oBNLk0Tda9JBgKT3uPTKL2QmRHFgru6x48
	 yP4PXQHUvpTcpstLnCw6ICbqBGi+onmnKgvd0JKVTGtcyKTwVGtrSKzYTb3+4ShU3MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHQjKMNv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD658606A335;
	Wed, 25 Nov 2026 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHQjKMNv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AD41F000C6;
	Wed, 25 Nov 2026 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795601738;
	bh=eqHXyc8WJEin7dgT8XNE7C77zQYt4IAJAZzyBASlFd8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=UHQjKMNvOiHYUyjVzNV0kB45H4NH1B6EaI9P4mzK4PUeT+a4j4j7Wqvjv7AcA20a9
	 NG9dG2KeGflAE+/JYN+XvSdydgMLmGIZSKJs2sLj9NX6k2fdlkrML8ASlHrnXemiIi
	 27X3b3lRP2aZWPVo3WFzurKKIxHugrkrgjYrf4kiLgChbtVhPfEjJ/soW5Yci20fa7
	 JyylEBJw+8jJNdQGWOHo08+sQgSpnFQj9LPOkImtVHizwfHaHccN2K3OofBi5jNUX1
	 OAYlWueVzsadXA7b6UK9CRC6d/tEF4YpKePH5DEhmzCWGl+fPt5zDHUEdqE0AiWbe3
	 YBpBwVqBf94Xw==
Message-ID: <99e34b24-95b2-4153-9d65-1fded8f746cf@kernel.org>
Date: Wed, 25 Nov 2026 11:15:35 +0100
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
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v5] media: hdpvr: fix out-of-bounds read in hdpvr_read()
To: 25031212351@stu.xidian.edu.cn,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
 Cheng Wen <wencheng@xidian.edu.cn>
References: <20261121102551.11263-1-25031212351@stu.xidian.edu.cn>
Content-Language: en-US, nl
In-Reply-To: <20261121102551.11263-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2026 11:25, 25031212351@stu.xidian.edu.cn wrote:
> From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> 
> hdpvr_read() computes the number of bytes left in the current buffer as
> urb->actual_length - buf->pos and uses that as the length for
> copy_to_user(). buf->pos is a plain unsigned int that is neither reset
> when hdpvr_cancel_queue() recycles a buffer nor protected by
> dev->io_mutex.
> 
> After hdpvr_stop_streaming() has killed the URBs, the buffers are put
> back on the free list with their old position, and the worker resubmits
> them with urb->actual_length reset to 0. If the next transfer completes
> with less data than the position a reader has already consumed, the
> subtraction yields a negative value. As rem is an int and count is a
> size_t, the comparison "rem > count" is then true, so cnt becomes count
> and copy_to_user() copies count bytes starting at
> transfer_buffer + buf->pos, which can be past the end of the 8192 byte
> transfer buffer. Two readers of the same video device can corrupt each
> other's position in the same way, and buf->pos is read twice, once for
> rem and once for the source address.

There cannot be two readers active at the same time. I think that is
actually the core bug: hdpvr_read does not return -EBUSY if another
reader is already active.

vidioc_encoder_cmd has those checks, but it is missing in hdpvr_read().

I did some testing on my HDPVR, and I can confirm that it incorrectly
allows for two simultaneous reads.

This must be fixed.

That will probably address most/all issues that this patch tries to correct.

So make sure you can't have two readers at the same time, and see if that
fixes the kasan issue. It might be that you still need to init buf->pos to 0
in a few places, but most of this patch can be dropped.

Regards,

	Hans

> 
> A KASAN slab-use-after-free read of 4096 bytes was observed in
> hdpvr_read() with the source address 1281 bytes past the end of the
> transfer buffer; the pages following the buffer had been recycled as
> slab pages. A second report with a 42 byte copy was 25 bytes past the
> end of the buffer.
> 
> Fix this by reading the position once, by using min_t() so that a
> negative remainder cannot be turned into a full-size copy, and by
> accounting the consumed bytes in hdpvr_account_buffer(), which recycles
> the buffer once it has been read completely: the position, the status
> and the buffer lists are updated in the same critical section.
> 
> The helper only acts when the buffer still holds the transfer that was
> read from. A reader can sleep in copy_to_user() while another reader or
> a stream restart recycles and resubmits the buffer, and the new transfer
> may start at offset 0 as well, so every buffer carries a generation that
> is bumped on submission and is checked along with the position. For the
> same reason the head of the receive list is re-read after each copy
> instead of keeping a buffer that may meanwhile have been queued behind
> the reader's back.
> 
> Reset buf->pos when hdpvr_cancel_queue() discards the buffers as well,
> otherwise a restarted stream either skips the first bytes of the new
> transfer or drops it entirely.
> 
> The buffer status is printed while dev->io_mutex is still held, as
> print_buffer_status() walks both buffer lists.
> 
> Fixes: 9aba42efe85b ("V4L/DVB (11096): V4L2 Driver for the Hauppauge HD PVR usb capture device")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
> v5:
>  - Bump a generation on every submission and check it when accounting the
>    consumed bytes: a reader that slept through a recycle and resubmission
>    could mistake the new transfer for the one it was reading, as both start
>    at offset 0.
>  - Re-read the head of the receive list after each copy instead of keeping
>    the buffer, so a reader never waits on a buffer that has been recycled
>    and resubmitted behind its back.
>  drivers/media/usb/hdpvr/hdpvr-video.c | 86 +++++++++++++++++++++------
>  drivers/media/usb/hdpvr/hdpvr.h       |  3 +
>  2 files changed, 70 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/usb/hdpvr/hdpvr-video.c b/drivers/media/usb/hdpvr/hdpvr-video.c
> index 4290b2367fa3..c7b55962d986 100644
> --- a/drivers/media/usb/hdpvr/hdpvr-video.c
> +++ b/drivers/media/usb/hdpvr/hdpvr-video.c
> @@ -92,6 +92,8 @@ int hdpvr_cancel_queue(struct hdpvr_device *dev)
>  	list_for_each_entry(buf, &dev->rec_buff_list, buff_list) {
>  		usb_kill_urb(buf->urb);
>  		buf->status = BUFSTAT_AVAILABLE;
> +		/* the data is discarded, the next transfer starts at 0 */
> +		buf->pos = 0;
>  	}
>  
>  	list_splice_init(&dev->rec_buff_list, dev->free_buff_list.prev);
> @@ -210,6 +212,8 @@ static int hdpvr_submit_buffers(struct hdpvr_device *dev)
>  		urb = buf->urb;
>  		urb->status = 0;
>  		urb->actual_length = 0;
> +		buf->pos = 0;
> +		buf->generation++;
>  		ret = usb_submit_urb(urb, GFP_KERNEL);
>  		if (ret) {
>  			v4l2_err(&dev->v4l2_dev,
> @@ -246,6 +250,42 @@ static struct hdpvr_buffer *hdpvr_get_next_buffer(struct hdpvr_device *dev)
>  	return buf;
>  }
>  
> +/*
> + * Account the bytes consumed from a buffer and hand it back to the worker
> + * once it has been read completely.
> + *
> + * The buffer may have been recycled and resubmitted, either by another
> + * reader or after a stream restart, while copy_to_user() slept. Its
> + * position and its place in the buffer lists then belong to the newer
> + * transfer and must not be touched, so only act if the buffer still holds
> + * the transfer that was read from. The generation tells the transfers
> + * apart even when both of them started at offset 0.
> + */
> +static void hdpvr_account_buffer(struct hdpvr_device *dev,
> +				 struct hdpvr_buffer *buf,
> +				 unsigned int generation, unsigned int pos,
> +				 unsigned int new_pos)
> +{
> +	bool recycled = false;
> +
> +	mutex_lock(&dev->io_mutex);
> +	if (buf->generation == generation && buf->status == BUFSTAT_READY &&
> +	    buf->pos == pos) {
> +		buf->pos = new_pos;
> +		if (new_pos >= buf->urb->actual_length) {
> +			buf->pos = 0;
> +			buf->status = BUFSTAT_AVAILABLE;
> +			list_move_tail(&buf->buff_list, &dev->free_buff_list);
> +			print_buffer_status();
> +			recycled = true;
> +		}
> +	}
> +	mutex_unlock(&dev->io_mutex);
> +
> +	if (recycled)
> +		wake_up_interruptible(&dev->wait_buffer);
> +}
> +
>  static void hdpvr_transmit_buffers(struct work_struct *work)
>  {
>  	struct hdpvr_device *dev = container_of(work, struct hdpvr_device,
> @@ -415,6 +455,7 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
>  	struct urb *urb;
>  	int ret = 0;
>  	int rem, cnt;
> +	unsigned int generation, buf_pos;
>  
>  	if (*pos)
>  		return -ESPIPE;
> @@ -488,10 +529,25 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
>  
>  		/* set remaining bytes to copy */
>  		urb = buf->urb;
> -		rem = urb->actual_length - buf->pos;
> -		cnt = rem > count ? count : rem;
> +		generation = buf->generation;
> +		buf_pos = buf->pos;
> +		rem = urb->actual_length - buf_pos;
> +		if (rem <= 0) {
> +			/*
> +			 * The buffer was recycled and refilled with less data
> +			 * than this reader already consumed from it, so there
> +			 * is nothing left to copy. Give it back to the worker
> +			 * if it is still the buffer we were reading from.
> +			 */
> +			hdpvr_account_buffer(dev, buf, generation, buf_pos,
> +					     buf_pos);
> +
> +			buf = hdpvr_get_next_buffer(dev);
> +			continue;
> +		}
> +		cnt = min_t(int, rem, count);
>  
> -		if (copy_to_user(buffer, urb->transfer_buffer + buf->pos,
> +		if (copy_to_user(buffer, urb->transfer_buffer + buf_pos,
>  				 cnt)) {
>  			v4l2_err(&dev->v4l2_dev, "read: copy_to_user failed\n");
>  			if (!ret)
> @@ -499,27 +555,19 @@ static ssize_t hdpvr_read(struct file *file, char __user *buffer, size_t count,
>  			goto err;
>  		}
>  
> -		buf->pos += cnt;
>  		count -= cnt;
>  		buffer += cnt;
>  		ret += cnt;
>  
> -		/* finished, take next buffer */
> -		if (buf->pos == urb->actual_length) {
> -			mutex_lock(&dev->io_mutex);
> -			buf->pos = 0;
> -			buf->status = BUFSTAT_AVAILABLE;
> -
> -			list_move_tail(&buf->buff_list, &dev->free_buff_list);
> -
> -			print_buffer_status();
> +		hdpvr_account_buffer(dev, buf, generation, buf_pos,
> +				     buf_pos + cnt);
>  
> -			mutex_unlock(&dev->io_mutex);
> -
> -			wake_up_interruptible(&dev->wait_buffer);
> -
> -			buf = hdpvr_get_next_buffer(dev);
> -		}
> +		/*
> +		 * The buffer may have been recycled and resubmitted to the
> +		 * tail of the list while we copied, so re-read the head
> +		 * instead of keeping it.
> +		 */
> +		buf = hdpvr_get_next_buffer(dev);
>  	}
>  err:
>  	if (!ret && !buf)
> diff --git a/drivers/media/usb/hdpvr/hdpvr.h b/drivers/media/usb/hdpvr/hdpvr.h
> index 84519c962cb4..4504fb58855a 100644
> --- a/drivers/media/usb/hdpvr/hdpvr.h
> +++ b/drivers/media/usb/hdpvr/hdpvr.h
> @@ -139,6 +139,9 @@ struct hdpvr_buffer {
>  
>  	uint			pos;
>  
> +	/* bumped every time a new transfer is started on the buffer */
> +	unsigned int		generation;
> +
>  	__u8			status;
>  };
>  

