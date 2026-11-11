Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794400156;
	b=za4KjDaR2z4JoXT8NhX95Gnidq8w3ad2IRAq1yrBiaBWPQxnXYJ+2XEd40MfGc04Zk39
	 AvTlGVP0d0SE3DIXySG5Zl0pIdVQIpb9xI/TymdFovvyZe4cj7lSFu0MwrxY9YPvDIsCG
	 mmtslisOxYhOvDJ+DFAJAElSYKqBZCU0cvLm5ErOQbCUzY37JDQAChnWCz/zjzGJu1HEP
	 UrCSgwtKqBEp3Soe5NXddpVGQuoDCoYYSTxzcoPMUMDKLG1Jq/hg2zSZZVQILafXlWhKG
	 VMhx7jVg8T3iH59BOCI7sL5/Vw/Wzr5IJTqZw2ukRoXPmm1zEkPjtZFCRrJ7fKOKB2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794400156;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jGFnHp/uKGNPG6eXjwGHrK2QKoQXCdOfknclUfftapQ=;
	b=daOWIG9WnPU56wBE5Fuy0PVq1cMxR0LRAL1yee95AGfbgKHGI/QNHxGmAhILbgOUyrMs
	 jQbvM0JlOO3in1JCilc7prrIsA3APsTo8fb6+CFRMFT0uD5HfS8z5g6rEA36NkJ2ha8Z/
	 yBFtuIvdwHWRRoey7RSMdMLC7fbCTHwE7rkzIQGmLEWpqT04dsS4gvONRoeGhwvTUni7C
	 dzuvPIm5ieBPSnUyjQ68AL9Zj2qTIcczau/9BH7T1AKhcixwRk2/412laLYHIQRJmFQcd
	 rfCBn71DAZES4hUVhiSVEJfUiHXHbsCG+PCvzPUzn/YpScLPxuOSBo1skcobVc8qY7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSyhMgCW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357DE606A326;
	Wed, 11 Nov 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KSyhMgCW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7361F00A05;
	Wed, 11 Nov 2026 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794400156;
	bh=jGFnHp/uKGNPG6eXjwGHrK2QKoQXCdOfknclUfftapQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=KSyhMgCWYm1q9hjjpwyqSkQotfahEWnexALjRm3p1gU7WgNkKnOHdVyIFqXjH1Rx7
	 Y9zyp/LftysIhpC9MDKwXnIDuiqW0SWDEBdAXz0AiB66LV10H2zMQS/RsdT0k31ATK
	 YpcJYiYUx9tbcWvWZAhOaj+tB5QJBu7neVK0U/iBFVi6U8ZbgkacWZHUS8mrTxxmjP
	 c9IeoAz4/sEdfYZ5qnMqiVmn5K9/JJIoJ4apAsZ7ykjuwG2Kky2IvrQJ94rfLetLbZ
	 6NJOxCL4mA+IutCT7po5UqLldIqRJe17UvDX03qBKO1E3KFnO+SZXqbQfg4m0Y18JN
	 Ry5fPamXlT2gg==
Message-ID: <dc4b0511-56a6-4510-a4b7-311906c9fd69@kernel.org>
Date: Wed, 11 Nov 2026 13:29:13 +0100
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
Subject: Re: [PATCH] media: msi2500: return buffers as QUEUED in buf_queue()
 before start_streaming()
To: zhangdaolong <dlzhangak@isoftstone.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Antti Palosaari <crope@iki.fi>, Valery Borovsky <vebohr@gmail.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+930e6201080a31e9d0c8@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <1793954471.6AED92A4.003.4jLXhN6Cksz4Dr7@fangwg01>
Content-Language: en-US, nl
In-Reply-To: <1793954471.6AED92A4.003.4jLXhN6Cksz4Dr7@fangwg01>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2026 09:41, zhangdaolong wrote:
> When vb2_start_streaming() is invoked, it first passes all pre-queued
> buffers on q->queued_list to the driver via buf_queue() before setting
> q->start_streaming_called and invoking start_streaming(). If
> start_streaming() subsequently returns an error, videobuf2 requires all
> buffers passed to the driver to be returned with VB2_BUF_STATE_QUEUED
> and warns via WARN_ON(!list_empty(&q->done_list)) if any buffer was
> completed with VB2_BUF_STATE_ERROR or VB2_BUF_STATE_DONE.
> 
> If the USB device disconnects before vb2_start_streaming() runs (for
> example when v4l2_read() races with msi2500_disconnect()), dev->udev is
> already NULL when vb2_start_streaming() enters. msi2500_buf_queue() sees
> !dev->udev and immediately completes each pre-queued buffer with
> VB2_BUF_STATE_ERROR (moving it onto q->done_list) instead of adding it
> to dev->queued_bufs. Right after that, msi2500_start_streaming() also
> sees !dev->udev and returns -ENODEV, triggering
> WARN_ON(!list_empty(&q->done_list)) in vb2_start_streaming().
> 
> Fix this by checking vb2_start_streaming_called(vb->vb2_queue) in
> msi2500_buf_queue() when !dev->udev: return VB2_BUF_STATE_QUEUED when
> start_streaming() has not been called yet, and VB2_BUF_STATE_ERROR when
> streaming is already active.
> 
> Reported-by: syzbot+930e6201080a31e9d0c8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=930e6201080a31e9d0c8
> Fixes: 977e444f59ad ("[media] Mirics MSi3101 SDR Dongle driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
> ---
>  drivers/media/usb/msi2500/msi2500.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
> index 282256ab812a..d89db57f924f 100644
> --- a/drivers/media/usb/msi2500/msi2500.c
> +++ b/drivers/media/usb/msi2500/msi2500.c
> @@ -625,7 +625,9 @@ static void msi2500_buf_queue(struct vb2_buffer *vb)
>  
>  	/* Check the device has not disconnected between prep and queuing */
>  	if (unlikely(!dev->udev)) {
> -		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
> +		vb2_buffer_done(&buf->vb.vb2_buf,
> +				vb2_start_streaming_called(vb->vb2_queue) ?
> +				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_QUEUED);
>  		return;
>  	}

I think the real problem is that msi2500_buf_queue is calling vb2_buffer_done
at all.

What happens if you just remove this 'if' completely?

I don't think I have seen vb2_buffer_done being called from buf_queue before.
It's very dubious code.

Regards,

	Hans

>  

