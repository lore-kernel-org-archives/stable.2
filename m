Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01B4F55BE;
	Tue,  8 Sep 2026 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861786; cv=none; b=uhxE183xL7d74AnN7xnOaXJ/HHLY4GS/uFfjNULDiH0VYk4qM7RFF8NbhUtiWHNchfrAf7baP3DYPXGk5W3zERlgndlvivCMCjO1X8oJ6dtCVXBfD2wbtK4iNroTbNFYpvhVSlRUOPXha/8MJN6wRr1nNat1zjJ1O/IHiqSweJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861786; c=relaxed/simple;
	bh=SXyKFCdIQt8kaqPN6SJqTdYQ4FAdZmPdgnKh7go/7rM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fnpzkmCz76iqzZL3yHiNaovCJUglT2A5jr2d4dPHCoi88BF11RRsQSPK3HG/vpkWn8H9ijHH4vzOHY5gDPO4AMZl07m0tzw0RZQgHNI3OiukrN1BnXuiNT+epcxpsMtmGxCrXQdH8mjVUfHj+bnL3XIKXVzIwriZDs2T9CvHaos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB691F00A3A;
	Tue,  8 Sep 2026 10:03:02 +0000 (UTC)
Message-ID: <a2b33cbd-f16e-4e42-ad5d-053ad94f7a46@kernel.org>
Date: Tue, 8 Sep 2026 12:02:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: hverkuil+cisco@kernel.org
Subject: Re: [PATCH] media: vim2m: keep transaction buffer count stable while
 streaming
To: Nicolas Dufresne <nicolas@ndufresne.ca>, Younho Choi <gdool88@mju.ac.kr>,
 linux-media@vger.kernel.org
Cc: mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
 sakari.ailus@linux.intel.com, benjamin.gaignard@collabora.com,
 ysk@kzalloc.com, kees@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260526122205.1019913-1-gdool88@mju.ac.kr>
 <71a3fa9710cf1afbb80ebe850878557c3e95a1b2.camel@ndufresne.ca>
Content-Language: en-US, nl
In-Reply-To: <71a3fa9710cf1afbb80ebe850878557c3e95a1b2.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/07/2026 00:14, Nicolas Dufresne wrote:
> Hi,
> 
> Le mardi 26 mai 2026 à 21:22 +0900, Younho Choi a écrit :
>> V4L2_CID_TRANS_NUM_BUFS controls how many buffer pairs a vim2m
>> mem2mem job processes before the job is completed. The driver stores
>> the value in ctx->translen and device_work() uses it later to decide
>> whether the current transaction should continue.
>>
>> Letting userspace change this control while streaming is active can
>> make a queued job observe a different transaction length than the one
>> it started with. That leaves the transaction state inconsistent with
>> the buffers currently queued for the job.
>>
>> Grab the transaction buffer count control while either queue is
>> streaming, and release it only after both queues have stopped
>> streaming. The V4L2 control framework then rejects changes with
>> -EBUSY while the value is in use, while still allowing userspace to
>> configure the value before streaming starts.
>>
>> Keep the control handler alive until after v4l2_m2m_ctx_release(),
>> since releasing the mem2mem context can call stop_streaming(), which
>> now ungrabs the control.
>>
>> Fixes: 96d8eab5d0a1 ("V4L/DVB: [v5,2/2] v4l: Add a mem-to-mem videobuf
>> framework test device")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Younho Choi <gdool88@mju.ac.kr>
> 
> I think this patch make sense, though I was pretty surprise of the private
> control offset, which I've tracked down to an undocumented change made by Hans
> in 2017. I've delegated this patch to him so we can sort this out first.

Actually, that was 2012.

I suspect that at that time we didn't yet reserve control ranges in v4l2-controls.h.

In any case, we're in a bit of luck in that the 0x1000-0x100f range is reserved in
v4l2-controls.h for the removed meye driver. Best solution is to just add a new
#define V4L2_CID_USER_VIM2M_BASE there. No control IDs have to change, so this is
safe.

I'll post a patch for that.

Regards,

	Hans

> 
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> 
>> ---
>>  drivers/media/test-drivers/vim2m.c | 29 ++++++++++++++++++++++++++---
>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/test-drivers/vim2m.c b/drivers/media/test-
>> drivers/vim2m.c
>> index bb2dd11eef0e..f4a2c4083829 100644
>> --- a/drivers/media/test-drivers/vim2m.c
>> +++ b/drivers/media/test-drivers/vim2m.c
>> @@ -205,6 +205,7 @@ struct vim2m_ctx {
>>  	struct vim2m_dev	*dev;
>>  
>>  	struct v4l2_ctrl_handler hdl;
>> +	struct v4l2_ctrl	*trans_num_bufs_ctrl;
>>  
>>  	/* Processed buffers in this transaction */
>>  	u8			num_processed;
>> @@ -1258,9 +1259,27 @@ static int vim2m_start_streaming(struct vb2_queue *q,
>> unsigned int count)
>>  		ctx->aborting = 0;
>>  
>>  	q_data->sequence = 0;
>> +	v4l2_ctrl_grab(ctx->trans_num_bufs_ctrl, true);
>> +
>>  	return 0;
>>  }
>>  
>> +static bool vim2m_other_queue_is_streaming(struct vim2m_ctx *ctx,
>> +					   struct vb2_queue *q)
>> +{
>> +	struct vb2_queue *other_vq;
>> +
>> +	if (!ctx->fh.m2m_ctx)
>> +		return false;
>> +
>> +	if (V4L2_TYPE_IS_OUTPUT(q->type))
>> +		other_vq = v4l2_m2m_get_dst_vq(ctx->fh.m2m_ctx);
>> +	else
>> +		other_vq = v4l2_m2m_get_src_vq(ctx->fh.m2m_ctx);
>> +
>> +	return vb2_is_streaming(other_vq);
>> +}
>> +
>>  static void vim2m_stop_streaming(struct vb2_queue *q)
>>  {
>>  	struct vim2m_ctx *ctx = vb2_get_drv_priv(q);
>> @@ -1274,11 +1293,14 @@ static void vim2m_stop_streaming(struct vb2_queue *q)
>>  		else
>>  			vbuf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
>>  		if (!vbuf)
>> -			return;
>> +			break;
>>  		v4l2_ctrl_request_complete(vbuf->vb2_buf.req_obj.req,
>>  					   &ctx->hdl);
>>  		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
>>  	}
>> +
>> +	if (!vim2m_other_queue_is_streaming(ctx, q))
>> +		v4l2_ctrl_grab(ctx->trans_num_bufs_ctrl, false);
>>  }
>>  
>>  static void vim2m_buf_request_complete(struct vb2_buffer *vb)
>> @@ -1380,7 +1402,8 @@ static int vim2m_open(struct file *file)
>>  
>>  	vim2m_ctrl_trans_time_msec.def = default_transtime;
>>  	v4l2_ctrl_new_custom(hdl, &vim2m_ctrl_trans_time_msec, NULL);
>> -	v4l2_ctrl_new_custom(hdl, &vim2m_ctrl_trans_num_bufs, NULL);
>> +	ctx->trans_num_bufs_ctrl =
>> +		v4l2_ctrl_new_custom(hdl, &vim2m_ctrl_trans_num_bufs, NULL);
>>  	if (hdl->error) {
>>  		rc = hdl->error;
>>  		v4l2_ctrl_handler_free(hdl);
>> @@ -1435,10 +1458,10 @@ static int vim2m_release(struct file *file)
>>  
>>  	v4l2_fh_del(&ctx->fh, file);
>>  	v4l2_fh_exit(&ctx->fh);
>> -	v4l2_ctrl_handler_free(&ctx->hdl);
>>  	mutex_lock(&dev->dev_mutex);
>>  	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
>>  	mutex_unlock(&dev->dev_mutex);
>> +	v4l2_ctrl_handler_free(&ctx->hdl);
>>  	kfree(ctx);
>>  
>>  	atomic_dec(&dev->num_inst);
>>
>> base-commit: 5d6919055dec134de3c40167a490f33c74c12581

