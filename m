Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD141D219;
	Tue, 28 Jul 2026 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230464; cv=none; b=tjyf1OL3n5uxBgPneUkQDhb4g5PK2pSSN/mnInNPGrT7ws5zfg6TMEIVAdPSe1SXIITL5U+uu5TlZ16eK26XoQmnNIMbplx+MTAHHFDSZA1i4qLYpXZ2HWkFSoJG19iNrcbRf+xUc7eZSsZEDvYh5CzpMtK++Z/b0g2p7X03LIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230464; c=relaxed/simple;
	bh=xSFfOkuJ1+Aagxw3Ur4/KUIcyge2Q1a6hlYYSK8ZWRI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EOPsf+AOT48m3wWz0mp5Tetp16koo4NoX1I6Ak9Y68inSxk6a4mao9FjSuW7NgExdq1gtVDU7X4KkMKh6xbBqDQGO5/qCCpzeuReTOsMZmCGFt7m9JjKgj8HFI1QXEvfD+T6ycJCxlPwYkGFesUh7sQPBoamzQAHFHeMk5Vs8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqqKVoT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqqKVoT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC321F00A3A;
	Tue, 28 Jul 2026 09:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785230463;
	bh=9IfMsx0XCGmhcRLHjtzpIcycreRMqL97MRi49jIPcy0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=TqqKVoT47VOWwRFmcOs4VVGAsa2wJTxSlG6f4hDAs7Oml1XgEJLss6FYZ2OEml30s
	 7Ea45DFc3LgPlqWJ/SksvMM7+/Zkd7M9dWtX1Z3VF6Pt7Uwm+5khFM5UbhE+5gkD47
	 51IdKoiT6dF0oUTmvwLEVFuWZqBRqBqZp9RrKmMzS/Oz3qAJXGpBPxuN3aUXBstHxX
	 2BB4vmF9IVyMa04iIly4R7nX17OWfyjjCynjtmw0h20C0FCT5bVwM0NXBg8DyKhG02
	 eTMQ2+Unn4lUwb4WPnibI1Tqu49LzKuTQphlWAAtK1oF4ngvdOBAXFAx7jXiIrOHQL
	 dExwDglHMifBg==
Message-ID: <9b97f819-cfdb-4ca7-afae-74e66c854a27@kernel.org>
Date: Tue, 28 Jul 2026 11:21:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v4 11/15] media: rc: Use after free in
 ir_raw_event_handle()
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1785158244.git.sean@mess.org>
 <3f498e032c1a5849dbb37eb016a82282ebc7fedf.1785158244.git.sean@mess.org>
Content-Language: en-US, nl
In-Reply-To: <3f498e032c1a5849dbb37eb016a82282ebc7fedf.1785158244.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/07/2026 15:18, Sean Young wrote:
> If rc_unregister_device() is called while IR is being processed, then
> ir_raw_event_handle() could call wake_up_process(dev->raw->thread)
> after kthread_stop(dev->raw->thread).
> 
> Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
> Signed-off-by: Sean Young <sean@mess.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/media/rc/rc-ir-raw.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
> index ba24c2f22d39..96849faafde3 100644
> --- a/drivers/media/rc/rc-ir-raw.c
> +++ b/drivers/media/rc/rc-ir-raw.c
> @@ -637,6 +637,7 @@ int ir_raw_event_register(struct rc_dev *dev)
>  	if (IS_ERR(thread))
>  		return PTR_ERR(thread);
>  
> +	get_task_struct(thread);
>  	dev->raw->thread = thread;
>  
>  	mutex_lock(&ir_raw_handler_lock);
> @@ -648,8 +649,13 @@ int ir_raw_event_register(struct rc_dev *dev)
>  
>  void ir_raw_event_free(struct rc_dev *dev)
>  {
> -	kfree(dev->raw);
> -	dev->raw = NULL;
> +	if (dev->raw) {
> +		timer_delete_sync(&dev->raw->edge_handle);
> +		if (dev->raw->thread)
> +			put_task_struct(dev->raw->thread);
> +		kfree(dev->raw);
> +		dev->raw = NULL;
> +	}
>  }
>  
>  void ir_raw_event_unregister(struct rc_dev *dev)

I think this patch could do with some comments in the code explaining why
you need get/put_task_struct.

It's the first time I've seen these functions being used, and I'm not sure
why they solve the issue or whether this is the right approach.

Regards,

	Hans
