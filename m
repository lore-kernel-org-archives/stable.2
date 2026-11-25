Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596768;
	b=Vn6sc65Htz+tQouuXZjch6f/IpsRDVk+YOHpIOZ8bbcF4DFEBQyixR0jHkxwHnJM8lBm
	 1HvLdu+P4FmYM3b1CV3Bs0fJJaJQ4nZS6jusuXWGNSEeJzQd8oL0X8OamZDIP0ChO3gAn
	 +KJ0oCNUUktna8BtfbtIo6zdVkh7Ffr0OEu1eVkorSSn5v0d29ep8TbCJ9PzSVf25UH4J
	 j0RYzV9NJ4TwlMmzBgXfX8SWwf/kJ5/Mvk3e7jbIdGuDVdVA+BEdx7dAZETyuL8EeTcoC
	 wIFaD9WuFXYCo5ZyXpfXvWKKn4RZPFC+llLuLjpLte+11RZ8SWDJk50Hj8yS1I3+p2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596768;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q3lKpz2ipOOP0omCIbHOv++J2MjbYMuVpWHGa/q6ZSY=;
	b=CozfuzqqgTfjAz2W9C4FJB1LdmrXPR2zXFJrI9ULqgnjn6oQMigLPNmoIP+O5Ku5o4a8
	 VIXVLUWB32E9YXkqX9ixBesn0MFQ2rPKI5YxAhkNXzofzsAJhIAFoeAoqRe1GiSQlFCbm
	 EswHrCfp2RRAUj/waFWVHT3IAcfS/LjeYY+9tHRoK0ycnFOi9QhLwE6sWZgdtMAAhfA/f
	 kV0ZCZhu7LVaYxPRWticQK9WWtYzX3wiZs6CQmFkC8woAz2TNIkPVkOu7M1znkr40xlsd
	 6bdFj/CkhuJMUaMUMNsVG30eSRA+D9e5BkZTlRGdfEEf2sL6Kow/AMEc8Zc3X4I0EnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vwgi/s4B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D56606A326;
	Wed, 25 Nov 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vwgi/s4B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FA51F000C4;
	Wed, 25 Nov 2026 08:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596767;
	bh=Q3lKpz2ipOOP0omCIbHOv++J2MjbYMuVpWHGa/q6ZSY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=Vwgi/s4BgqpM1wnT1yOBVqSVV9uOCMtqJ7cD3SI79O6iy+di3kvZhBnTp+1G82ujV
	 rsqlSCVBUNXOuOg/5he8xry8YW04XuwQ6Kr3MyXamJS9wG/A9ds/hDOxl0qIdtRC1/
	 mkMCDfMPoS9S4R9LHUpo0IVuAvD/Du2g+pV0Kz8JxgTebaL5ngOSWXeeXCEghdMHlJ
	 djLpH0F65kB+IGkK3QKx80Nz3Eiu15bBb0wl9obGcX+cctOg2OtUXJgTVHOvn8KVpJ
	 0KW3VwD8oNCZ/5XA++cpdwZPalpJ5iiTNxcflLTOmkX9XHmDb6Ld3Hli0RoM+69PCk
	 1EpzJhXY2eUGw==
Message-ID: <54864d0a-4356-4f00-9b0b-8b9b22329afe@kernel.org>
Date: Wed, 25 Nov 2026 09:52:44 +0100
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
Subject: Re: [PATCH v2] media: go7007: return queued buffers on
 start_streaming() failure
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
 Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
 Cheng Wen <wencheng@xidian.edu.cn>
References: <20261112140556.5230-1-25031212351@stu.xidian.edu.cn>
Content-Language: en-US, nl
In-Reply-To: <20261112140556.5230-1-25031212351@stu.xidian.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2026 15:05, YuanZhe Liu wrote:
> The vb2 framework hands ownership of every queued buffer to the driver
> through the buf_queue() callback before start_streaming() is called.  If
> start_streaming() then returns an error, the driver must return those
> buffers to vb2 with vb2_buffer_done() and VB2_BUF_STATE_QUEUED.
> Otherwise vb2_start_streaming() fires WARN_ON(owned_by_drv_count) and
> forcibly reclaims the buffers.
> 
> go7007_start_streaming() returns -EIO when go7007_start_encoder() fails,
> which happens for example when a USB transfer cannot be submitted because
> the device has been disconnected:
> 
>     go7007 1-1:1.0: error submitting audio urb 5: -2
>     go7007 1-1:1.0: error starting stream transfer
>     WARNING: drivers/media/common/videobuf2/videobuf2-core.c:1797 at vb2_start_streaming
> 
> but it leaves the already queued buffers on go->vidq_active.  Give them
> back to vb2 with VB2_BUF_STATE_QUEUED before bailing out.
> 
> Fixes: 7955f03d18d1 ("[media] go7007: move out of staging into drivers/media/usb.")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
> ---
> Changes in v2:
> - Inline the buffer return into go7007_start_streaming() as requested and
>   drop the separate helper.
> - Drop the redundant go->active_buf = NULL: active_buf is still NULL when
>   go7007_start_encoder() fails.
> 
>  drivers/media/usb/go7007/go7007-v4l2.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/go7007/go7007-v4l2.c b/drivers/media/usb/go7007/go7007-v4l2.c
> index 2087ffcb85a5..030a127cb9ea 100644
> --- a/drivers/media/usb/go7007/go7007-v4l2.c
> +++ b/drivers/media/usb/go7007/go7007-v4l2.c
> @@ -409,8 +409,26 @@ static int go7007_start_streaming(struct vb2_queue *q, unsigned int count)
>  	else
>  		ret = 0;
>  	mutex_unlock(&go->hw_lock);
> -	if (ret)
> +	if (ret) {
> +		struct go7007_buffer *vb, *tmp;
> +		unsigned long flags;
> +		LIST_HEAD(buffers);
> +
> +		/*
> +		 * The queued buffers were handed over to the driver before
> +		 * start_streaming() was called, so they have to be returned
> +		 * with VB2_BUF_STATE_QUEUED.
> +		 */
> +		spin_lock_irqsave(&go->spinlock, flags);
> +		list_splice_init(&go->vidq_active, &buffers);
> +		spin_unlock_irqrestore(&go->spinlock, flags);
> +
> +		list_for_each_entry_safe(vb, tmp, &buffers, list) {

Why not just walk go->vidq_active? There is no need for list_splice_init AFAICS.
Keep it simple.

> +			list_del(&vb->list);
> +			vb2_buffer_done(&vb->vb.vb2_buf, VB2_BUF_STATE_QUEUED);

Looking a bit closer, it seems that go7007_stop_streaming() fails to return any
pending buffers to state VB2_BUF_STATE_ERROR. It just re-inits go->vidq_active
instead of properly returning any queued buffers.

Can you fix that as well?

Regards,

	Hans

> +		}
>  		return ret;
> +	}
>  	call_all(&go->v4l2_dev, video, s_stream, 1);
>  	v4l2_ctrl_grab(go->mpeg_video_gop_size, true);
>  	v4l2_ctrl_grab(go->mpeg_video_gop_closure, true);

