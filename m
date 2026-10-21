Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572415;
	b=Zvzexa2k3ZTm2NDWKTp/tX8c+1v5h7GYRFHo+uPgNojSP29p35dg3JEjvm3FomHTbIAt
	 NWNfh6iSvrXmJQnA0Ncfwe03fEi7Ks5loIdLkCySQTsUr3otT49GsUpEUiJGw1B08oStt
	 nVn4AQCVZuk64YYuQvrJOfwpAOybb9FrvVgzfn2ef7mMxK6pFH0htnC9WZU5/IAunXYz0
	 pijC9oCdAIesxTDYPRaQREmLcZcgyRVGeqTGFkM4wzPlYfLYrbCJOheZ4/BCjRZWdogCx
	 NlBN4HtzEa//e52Vlns4boe3phwjKrMxWDEpmI8+ohu9LqkAEhhFz349P8TrTpg6elw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572415;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=NkqF54CnIH/ZwLGFMyKxniR3ooIyGzv1otRZIrnrBOM=;
	b=iRyhBGOU14n+GAvxueTzKjLmvMN6DG/bJbegDUS64J7lvNAKpvWu4zn3usfXMtAv2k+M
	 +LpLynQa92os3G+8ugtzWwpd8RkIeNw7/AeOmJL5/p5W6Thsf0FF6Hxe1ZwK0+qxs/5yi
	 BTEugDmXiQIsmYIrMWL7cZtjtS6U18hPaRKk0KJuDaWYK3u3oV3dzCbirf33cNfh56V5s
	 XIEmW4jRFik9JQLOjB8HeIU2oLEzzemUaaBUATkfwiHV3WcK0lxQmrblD2eLyapq8kLWD
	 vEczLHAvkTs9YYmdxwIZ3gaAvnNsTDYxgPKR9b5lwGYbCOVZMhBL1JoguT4E4BCu76w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ex469Kdo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53126606A31B;
	Wed, 21 Oct 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ex469Kdo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5878B1F000CA;
	Wed, 21 Oct 2026 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792572415;
	bh=NkqF54CnIH/ZwLGFMyKxniR3ooIyGzv1otRZIrnrBOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ex469KdoCo6C9Gkr8Nb8x8pK+05HdzI4bzGiSt3e8Qmd7gVa8Vfs3My+CwD+wTLHD
	 zkCwxuUj3QFsjQF1FZS+DSPQgyKC7olPZME9lVym8dpIROEm3D+4LmLVHFCoSbz34m
	 5SQfgap8IRnKCcLbxxfDNPiDjKmWQagShBcpOY10KqGkA7uaV2W9mBi8ylDccmrfEF
	 i+jnfF7ETJx/q611zRqHymvyRG8SOhm3X7q1X1hk+foz6UFgdACqH91eWigRXCe2PL
	 u4fgKzGDqtzjmiZyuDWHN09NFB4f14c51bxJRjE4Rab2Ba72qopx7z5qhgQBjZu5N9
	 ruwI8EcOIwhtw==
Message-ID: <8f914911-8453-4f8f-b02f-384114f9d4ef@kernel.org>
Date: Wed, 21 Oct 2026 10:46:50 +0200
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
Subject: Re: [PATCH v2] virtio_balloon: drain update works on probe error
 paths
To: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>, mst@redhat.com
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, stable@vger.kernel.org
References: <20261019084406.162-1-zhaimingbing@cmss.chinamobile.com>
 <20261020035744.1131-1-zhaimingbing@cmss.chinamobile.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261020035744.1131-1-zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/26 05:57, Mingbing Zhai wrote:
> init_vqs() arms the stats virtqueue callback, so an update work can
> already be queued on the system freezable workqueue while
> virtballoon_probe() is still running.  If a later probe step fails, the
> error unwind deletes the virtqueues and frees vb without stopping the
> works, and the queued work runs after the balloon struct is gone:
> 
>   BUG: KFENCE: use-after-free read in virtqueue_get_buf_ctx
>    update_balloon_stats_func+0x121/0x300
>    Workqueue: events_freezable update_balloon_stats_func

Did you manage to reproduce this? How? (forcing the probe to fail?)

Does this require the device to trigger us even before virtio_device_ready(vdev)?

> 
> remove() already handles this via virtballoon_quiesce().  Factor the
> stopping of the update works out of it and run it on the probe error
> path as well, before the queues and vb go away.
> 
> The same hole exists when init_vqs() itself fails after
> virtio_find_vqs() succeeded: the stats priming can fail with the queues
> up and the callback armed, yet probe jumps straight to out_free_vb and
> leaks the virtqueues while the queued work still references vb.  Unwind
> inside init_vqs() in that case, stopping the works before the queues
> are deleted.
> 
> The drained work takes vb->wakeup_lock in process_wakeup_event() and
> finish_wakeup_event(), so this depends on "virtio_balloon: initialize
> wakeup_lock before virtqueues are set up", which moves that
> spin_lock_init() to the top of probe.
> 
> Fixes: 1f34c71afe51 ("virtio: Fix scheduling while atomic in virtio_balloon stats")
> Reported-by: syzbot+0f659760bac1ecb01812@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0f659760bac1ecb01812
> Signed-off-by: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>
> ---
> 
> Changes in v2 (from sashiko review):
> - unwind inside init_vqs() when the stats priming fails after
>   virtio_find_vqs() succeeded, instead of leaking the virtqueues on the
>   out_free_vb path with the callback still armed.
> - spell out the dependency on the wakeup_lock initialization patch:
>   the drained work takes that lock.
> 
>  drivers/virtio/virtio_balloon.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 8c1b47ec1..dd2056882 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -554,6 +554,17 @@ static void update_balloon_stats_func(struct work_struct *work)
>  	finish_wakeup_event(vb);
>  }
>  
> +/* Stop queueing of and drain any pending balloon update works. */
> +static void virtballoon_stop_updates(struct virtio_balloon *vb)
> +{
> +	spin_lock_irq(&vb->stop_update_lock);
> +	vb->stop_update = true;
> +	spin_unlock_irq(&vb->stop_update_lock);
> +
> +	cancel_work_sync(&vb->update_balloon_size_work);
> +	cancel_work_sync(&vb->update_balloon_stats_work);
> +}
> +
>  static void update_balloon_size_func(struct work_struct *work)
>  {
>  	struct virtio_balloon *vb;
> @@ -633,6 +644,12 @@ static int init_vqs(struct virtio_balloon *vb)
>  		if (err) {
>  			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
>  				 __func__);
> +			/*
> +			 * The virtqueues are up and the stats callback is
> +			 * armed: stop the works and unwind the queues.
> +			 */

Do we really need this comment?

> +			virtballoon_stop_updates(vb);
> +			vb->vdev->config->del_vqs(vb->vdev);

I guess this path is very hard to trigger.

>  			return err;
>  		}
>  		virtqueue_kick(vb->stats_vq);
> @@ -1075,6 +1092,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		destroy_workqueue(vb->balloon_wq);
>  out_del_vqs:
> +	/*
> +	 * init_vqs() arms the stats virtqueue callback and primes the
> +	 * queue, so an update work may already be pending: stop queueing
> +	 * and drain it before the virtqueues and vb go away.
> +	 */

Do we really need this comment?

> +	virtballoon_stop_updates(vb);
>  	vdev->config->del_vqs(vdev);
>  out_free_vb:
>  	mutex_destroy(&vb->balloon_lock);
> @@ -1115,11 +1138,7 @@ static void virtballoon_quiesce(struct virtio_balloon *vb)
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		virtio_balloon_unregister_shrinker(vb);
>  
> -	spin_lock_irq(&vb->stop_update_lock);
> -	vb->stop_update = true;
> -	spin_unlock_irq(&vb->stop_update_lock);
> -	cancel_work_sync(&vb->update_balloon_size_work);
> -	cancel_work_sync(&vb->update_balloon_stats_work);
> +	virtballoon_stop_updates(vb);
>  
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		cancel_work_sync(&vb->report_free_page_work);


-- 
Cheers,

David
