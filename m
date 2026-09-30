Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793DF457E7D;
	Wed, 30 Sep 2026 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755480; cv=none; b=IJpiTNwPTuJqkLRG7Uks8pPkaaFYFVcFa1SeuDSdbe4lNUn4nZoeyQFYyS6tjxjCFkP/AUgjQfXU71V/9q25XetNPETzBgqGn869zJIazmmHdUCeZS2/nuQWyuC/9MRHSHV3ek4wZyAnFj4sINuf4tAJK70axxaiLmHaJ9VwjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755480; c=relaxed/simple;
	bh=6QnaOwsgJhq/PcSEb/P6lCu3R7QuM9PpF729v9cvMUI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LSoYJ/5q/8tMca1wRpE0y3MUJ37bEiwcTFyyF87da2JpEKZZ4foCx6XCrTEBh9SV5ycEWLb7W/QNaUClfMCeoNlOOE7Co3AxMJM7LyAJ3sHDLgfXu9UFLWIEBHS1Mb6iXLKRY2EZvZy3a6sSbjoCWZZeZhGyCEEJhE7l8wPM0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goH7Gb4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goH7Gb4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1651E1F000FF;
	Wed, 30 Sep 2026 08:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790755478;
	bh=rLeIGiG34MJBhQKyQ3shHNm33v2I+f07Lo5JWEha5+8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=goH7Gb4NThy9TsJxO5sNAg9/0BbauKLBPhy+yHPrbPON2Uhw5eMAYw8t1imy7leHI
	 Pr8ESUAz1oZdTGY1nPbLmtdAdIW0Pngde0htrZ+xMGpT/HhrccPhX4UV8yFwq2lP3X
	 PIY9+IBPSpgXA41kBVwoPnXpBjXtiYypIzgus3y81EivcjLq9ZviVcWOvzNpmLlS6z
	 UiFwSvN+bjIwDmDpnDFvmSTv9C6GsHN7duqccqFLAHRySTnMno9gqL9VP6B1XW6HLE
	 FSd8ybMF+ADVNrWkQ2j+zQsZR5yisqn/fCQ3z5uEo8rITaWFF7+/wvTiZ/Ih7sc1+P
	 F4J0VqnoVugzg==
Message-ID: <d2c9da65-ea4a-403e-8512-26897e0bc26f@kernel.org>
Date: Wed, 30 Sep 2026 10:04:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v1 1/2] Input: sur40 - don't wait for buffers nothing will
 complete
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 dmitry.torokhov@gmail.com
Cc: floe@butterbrot.org, linux-input@vger.kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260920113949.12726-1-ngocthang2710.1999@gmail.com>
 <20260920113949.12726-2-ngocthang2710.1999@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260920113949.12726-2-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/09/2026 13:39, Nguyen Ngoc Thang wrote:
> sur40_stop_streaming() calls vb2_wait_for_all_buffers() before handing
> the queued buffers back. Those buffers are only completed from the input
> poll callback, which is gone once the device is unplugged. Closing a
> video node that is still streaming after a disconnect then sleeps
> forever in vb2_wait_for_all_buffers():
> 
>   vb2_wait_for_all_buffers+0x20f/0x330
>   sur40_stop_streaming+0x45/0x310
>   __vb2_queue_cancel+0xc5/0xf70
>   vb2_core_streamoff+0x5d/0x180
>   __vb2_cleanup_fileio+0x6e/0x190
>   vb2_core_queue_release+0x1f/0x190
>   _vb2_fop_release+0xe8/0x280
>   v4l2_release+0x280/0x430
> 
> It has not been noticed so far because sur40_disconnect() frees the
> device state under the open file, and the close then crashes earlier.
> 
> Return the queued buffers first. A buffer that sur40_process_video()
> has already taken off the list still completes by itself, so the wait
> afterwards only covers that one.
> 
> Fixes: 6a8588156657 ("[media] sur40: fix occasional oopses on device close")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
>  drivers/input/touchscreen/sur40.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index 09d8c5f8d09f..7020bcf9b81a 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -929,11 +929,11 @@ static int sur40_start_streaming(struct vb2_queue *vq, unsigned int count)
>  static void sur40_stop_streaming(struct vb2_queue *vq)
>  {
>  	struct sur40_state *sur40 = vb2_get_drv_priv(vq);
> -	vb2_wait_for_all_buffers(vq);
> -	sur40->sequence = -1;
>  
> -	/* Release all active buffers */
> +	/* Release queued buffers first: nothing completes them after unplug */
>  	return_all_buffers(sur40, VB2_BUF_STATE_ERROR);
> +	vb2_wait_for_all_buffers(vq);
> +	sur40->sequence = -1;
>  }
>  
>  /* V4L ioctl */

I think you should make one more change: replace the video_unregister_device calls by
vb2_video_unregister_device(). This ensures that at unregister time all streaming is
canceled and stop_streaming is called.

Having streaming continue after unregistering a device is in general not a good idea,
which is why we added that vb2_video_unregister_device call.

I think you still need to have that change in stop_streaming for this specific driver,
but it might be worth testing without it.

Regards,

	Hans
