Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD541D11B;
	Mon, 27 Jul 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164306; cv=none; b=b1r98T3YygW+Tgy7Ysa9pkrvMsxwvKrKlxJW1vVAoU2jgbq/7KTSyG/hmio3+zL/3Y8/Bxl+TNgb8OE3Q2DxfVEoLYnFPCrzVAOemOyCCIDX+B2Vvr6LNptbOJr9mJl5qWSWnlTyS3IHhhwtmYDD3fJYOQxQz0TCL3Ukpkve5Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164306; c=relaxed/simple;
	bh=IfxuBVVWRE8yIrtOZQGOUdAPnGaxZ27jvH2VfPNNmgM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BCkXnc1dlZNbpZFZemvnGAsKZMj0BGH6DolPUpxWZtTcriLJKexelsk5qoYC9YmbX3mMAqbcJlRgZXUb9aUwkuvlsVxvE2v4pd1MkQRrbzHQIU1fFlGJYZHRG7DVjc+zuZIEEVkK7VxVplUDAyaT6qQw8QXmnCnT91GZPTLRhaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeUmyYuv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeUmyYuv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497AC1F000E9;
	Mon, 27 Jul 2026 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785164304;
	bh=xJGg9eL+TxDraqM//3gyBgvH0nIQQlKASgr4sKIWhwQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=JeUmyYuvMhdP7+tKpHXr2KvBLLIXs+Z36hClVBwFV4I2olBuuTEx0uqOkktCsuKSi
	 B94XvjaxEqCwgoTjina0K5rQ/W6dsJklB43406futE/fsqZZuvPzEBZaIpmUTRvAc2
	 pGhgpBpOkVaIYU1CihCb7M7WAWHwPkmYKapPiaW2R/Aq35eh1Do3OhUYV/S1Kg4B5B
	 nkRBqfhAgRyaKKlXpoE5s03EsSVbLmqgzDNTv6Q4ktB9B2ljLD7L6TZVt1gYaMDoUp
	 SpmkYxxVVR9x6o7Oal/OUXvDhZ5kNewUKU4QKNUx25L0gTFwIuyBdRZgED7BD7JWeq
	 YBShtWZ9NOMQQ==
Message-ID: <e3a1f432-4638-4295-b55d-31e2d121f09f@kernel.org>
Date: Mon, 27 Jul 2026 16:58:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v2] media: v4l2-event: limit number of event subscriptions
 per file handle
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, mchehab@kernel.org,
 linux-media@vger.kernel.org
Cc: kees@kernel.org, linux-kernel@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
 kys@microsoft.com, stable@vger.kernel.org
References: <20260722042308.75939-1-blbllhy@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260722042308.75939-1-blbllhy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2026 06:23, Cen Zhang (Microsoft) wrote:
> v4l2_event_subscribe() allows an unbounded number of event subscriptions
> per file handle. Since the subscription id field is fully user-controlled
> (32-bit), an unprivileged user with access to a V4L2 device node can
> create up to 2^32 distinct subscriptions, each pinning a kernel
> allocation (~200 bytes). This can exhaust kernel memory, causing an OOM
> condition and kernel panic.
> 
> An unprivileged local user can trigger this by issuing repeated
> VIDIOC_SUBSCRIBE_EVENT ioctls with incrementing id values. The allocated
> objects reside in kernel slab (not accounted to the process cgroup), so
> existing memory limits (ulimit, memcg) do not prevent this. Most V4L2
> drivers are affected because the framework function v4l2_event_subscribe()
> enforces no limit, such as uvcvideo (USB webcams) and the vicodec test
> driver used to reproduce this issue. This leads to:
> 
>   Kernel panic - not syncing: Out of memory: compulsory panic_on_oom
>    is enabled
> 
> Fix by adding a per-filehandle subscription counter and capping it at 256.

Hmm, nice catch.

But the problem is really at a higher uAPI level: the VIDIOC_SUBSCRIBE_EVENT and
VIDIOC_SUBDEV_SUBSCRIBE_EVENT ioctls should check the id field before passing
it to drivers.

Only two event types use the id field: V4L2_EVENT_CTRL and V4L2_EVENT_SOURCE_CHANGE.
The first event already checks the id field through helpers, but the second doesn't
check. And for other event types than these two the id field should just be set to 0.

Also, v4l2-compliance must check against this.

I'll post new patches for this tomorrow.

Regards,

	Hans

> 
> Fixes: 6e239399e580 ("[media] v4l2-ctrls: add control events")
> Cc: stable@vger.kernel.org
> Reported-by: Autonomous Code Security <AutonomousCodeSecurity@microsoft.com>
> Link: https://lore.kernel.org/all/20260722004818.72310-1-blbllhy@gmail.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v2:
>  - Add Cc: stable@vger.kernel.org
>  - Add Link: to v1
>  - Wrap long line in commit message
> 
>  drivers/media/v4l2-core/v4l2-event.c | 14 +++++++++++++-
>  include/media/v4l2-fh.h              |  2 ++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
> index 9dd2aaa95a67..fcd8ce4addc1 100644
> --- a/drivers/media/v4l2-core/v4l2-event.c
> +++ b/drivers/media/v4l2-core/v4l2-event.c
> @@ -18,6 +18,9 @@
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  
> +/* Per-filehandle limit on the number of event subscriptions. */
> +#define V4L2_MAX_EVENT_SUBSCRIPTIONS	256
> +
>  static unsigned int sev_pos(const struct v4l2_subscribed_event *sev, unsigned int idx)
>  {
>  	idx += sev->first;
> @@ -218,6 +221,7 @@ static void __v4l2_event_unsubscribe(struct v4l2_subscribed_event *sev)
>  		fh->navailable--;
>  	}
>  	list_del(&sev->list);
> +	fh->nsubscribed--;
>  }
>  
>  int v4l2_event_subscribe(struct v4l2_fh *fh,
> @@ -251,8 +255,16 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
>  
>  	spin_lock_irqsave(&fh->vdev->fh_lock, flags);
>  	found_ev = v4l2_event_subscribed(fh, sub->type, sub->id);
> -	if (!found_ev)
> +	if (!found_ev) {
> +		if (fh->nsubscribed >= V4L2_MAX_EVENT_SUBSCRIPTIONS) {
> +			spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
> +			kvfree(sev);
> +			mutex_unlock(&fh->subscribe_lock);
> +			return -ENOSPC;
> +		}
>  		list_add(&sev->list, &fh->subscribed);
> +		fh->nsubscribed++;
> +	}
>  	spin_unlock_irqrestore(&fh->vdev->fh_lock, flags);
>  
>  	if (found_ev) {
> diff --git a/include/media/v4l2-fh.h b/include/media/v4l2-fh.h
> index aad4b3689d7e..65a7f31af889 100644
> --- a/include/media/v4l2-fh.h
> +++ b/include/media/v4l2-fh.h
> @@ -33,6 +33,7 @@ struct v4l2_ctrl_handler;
>   * @subscribe_lock: serialise changes to the subscribed list; guarantee that
>   *		    the add and del event callbacks are orderly called
>   * @subscribed: list of subscribed events
> + * @nsubscribed: number of subscribed events at @subscribed list
>   * @available: list of events waiting to be dequeued
>   * @navailable: number of available events at @available list
>   * @sequence: event sequence number
> @@ -49,6 +50,7 @@ struct v4l2_fh {
>  	wait_queue_head_t	wait;
>  	struct mutex		subscribe_lock;
>  	struct list_head	subscribed;
> +	unsigned int		nsubscribed;
>  	struct list_head	available;
>  	unsigned int		navailable;
>  	u32			sequence;

