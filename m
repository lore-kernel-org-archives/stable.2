Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469116;
	b=h5Yh3GXVPisQpJ8aaKQDJJexJLQJ9niocmCewptc4Udo73yys+voBl9x3oR25+cJ9fbg
	 g1UMvOOjZTB+RKiJ2Y7C8yaYQ9shXJEwdRhLlxo+ApNAWaMpvZDJkEfKGLBBF5nGLhZey
	 etLxKc0MqxudG6pmh2Bej5ltMZKhhyaQjzvBkJBfPPOKqE3zNgnlQr9JTPbc7uXjC/rKR
	 h7iCMx+fV+w1bY06p70BJVt4yUsA5n09UPy4Hb/qTAIoSpgB9Kq1XO57qR8EgUcuwepgK
	 xTCUU//kgcnLRi/jfREgt/R2Asi5dojSNEMF5j9e//VKyi1BXaWM/WtrJU5HX/h8Tog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469116;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0+wehHBGkyeWvPM981t47dy46vlkddnR/+kt8BkCiH0=;
	b=e9zoqEQVRbKt+f9jrZmG5NQ2jcFv2V4h7CcknClVGSOujjsDJwXUz42dHpOmuoLN8fhc
	 gOkawz4lgPfiOZPVrXRRolR7GAlYjBlwD9r50MxTD3UcUe+gciNX3LSDgQeuFmhQ8D3fL
	 ARJ08CDqjfpIAmgUDt+5EDD+M4JqDY+vTXS4oe/BLxvJ2yDNm1QGMWbJM7UNUcz5NpDjH
	 UcMsU65u7IiW+nIQfG3fSd9QxbMrO+24FKBJD42ODcP9lJ1wZFZSIBbxm12ncIiUfBaqK
	 qOVjcWqQ9qaDM9LCZnm0Q70dh5eEhTAs+xdCfJ6etk6TtCJgeJktOAQN0sPxVxF4dgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TSvWwbk/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF000606A321;
	Thu, 12 Nov 2026 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSvWwbk/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4B91F00A05;
	Thu, 12 Nov 2026 07:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794469116;
	bh=0+wehHBGkyeWvPM981t47dy46vlkddnR/+kt8BkCiH0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=TSvWwbk/ReR9rKKjXF7ql7DrfD1dyuGdR4leBOo5fyZKZIIGxs6uXZAR3bsPVWDYo
	 QSxCtyGO4tQk8uLywVdqd4HoDy7acmzO1DVLAFm5K7t5S4nwZJRtsunEUj/mXmZe4O
	 jdORUB6rjm1yw8fyXB6aB9grCN6ju3vMJV0c8Mu7zywVAuKsHpSICYf/2DhKn6pWzY
	 QmxSemomHGmwcAXFOcPTcAAXS3oauXH5oy7x70wQISsH5PvVQSr777szkKZ49DQHjW
	 PhF/3CehROJfX0+dMRg4CZz68zScz0gAac2B1mGdQhRqMYNMaUqnE63lGMjhRMIdfl
	 UvuDURFs4S6nQ==
Message-ID: <a931e754-ab4e-42d8-8555-9a432fe42a1e@kernel.org>
Date: Thu, 12 Nov 2026 08:38:32 +0100
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
Subject: Re: [PATCH v2 media] media: v4l2-mem2mem: cancel job_work in
 v4l2_m2m_release
To: Tristan Madani <tristmd@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
References: <20261104014248.3761373-1-tristan@talencesecurity.com>
Content-Language: en-US, nl
In-Reply-To: <20261104014248.3761373-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 02:42, Tristan Madani wrote:
> v4l2_m2m_release() frees the m2m_dev struct without cancelling
> m2m_dev->job_work.  When a job finishes, v4l2_m2m_schedule_next_job()
> calls schedule_work() to queue the next run.  If the driver tears down
> concurrently, v4l2_m2m_ctx_release() invokes v4l2_m2m_cancel_job() which
> handles per-context state (TRANS_RUNNING, TRANS_QUEUED) but does not
> drain the device-level job_work.  A pending work item can then fire after
> kfree and access freed memory.
> 
> Add cancel_work_sync() before the kfree in v4l2_m2m_release() to ensure
> the work item is drained.
> 
> Fixes: 7f98639def42 ("V4L/DVB: add memory-to-memory device helper framework for videobuf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

This email differs from your gmail address. Which is correct?

Regards,

	Hans

> ---
> Changes in v2:
> - Expanded commit message to clarify that cancel_work_sync() complements
>   the per-context v4l2_m2m_cancel_job(), which handles TRANS_RUNNING and
>   TRANS_QUEUED flags but does not drain the device-level work item
>   (Nicolas Dufresne)
> 
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index a65cbb124cfe0..311e2e08d066d 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -1207,6 +1207,7 @@ EXPORT_SYMBOL_GPL(v4l2_m2m_init);
>  
>  void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev)
>  {
> +	cancel_work_sync(&m2m_dev->job_work);
>  	kfree(m2m_dev);
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_release);

