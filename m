Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4926B2D2
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780758506; cv=none; b=Y9k5c2tARheCpw8z4UksznzWwQKODPPcrVJcD1nLKvio2gpGpob7DuEs4RFWLCPbdOLjv0BRHe9rlCLXd0bfyqPgUffeUlIwBNyu8bi9U7zp3JkLFcHSsgA2M8ucXS3CWVB56Wk7S0LfxQ11g7YzmcCH1jSDex31w4CZ6AyBZT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780758506; c=relaxed/simple;
	bh=R/EumiybEpmrJYWh/tM22ml8KOrqEcUT3PkRsTmgtdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tedZg37/EDdVAt5+K8Pu6FeusdRDNUlSGkzOMfrzECz3s852F5A93fLAfZlM6fWwYaCjkxU3ppFWpQjoUo8umLbeYYihmWxik9EDJM5IwyZYb2ICJz32/mGOm59P0juQJEfCbwCWEhlwEN8cISg9K/bn4mgpLLvCluAuocaaZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh0Yk+Z+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh0Yk+Z+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84232e83ca9so1308400b3a.2
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780758505; x=1781363305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z56ZvvEiHNN1gkYTK+8/eqIg8fgyCPdSo7V0PEkdypI=;
        b=eh0Yk+Z+oZH2GF5Dt2f/7M0TvDmYPXPq6yojarwQUAZAbA1bNqIAcoRjWv6ZG565qk
         SowM67OQPRZYuRJMxfKFRO81h3lJG2VsW80lBxSs+7uKCvMARgGj6bhUC6pAIkpIwMr+
         QAYM/XJji/uh4c9OkwEBUcF737IPscYoTCMyhq/hl1/U75V1c6cmH57fAcFFMNNAak+O
         3wllQv/bR1VDuEJdKVL41M0faEoUce/913j52P/Yfw20GLVN0QfYcXfRAnoN4wT4IoSv
         kZMC6CGD5uAbYNHpGP/MQCMl/nn4faxEZpClMRQYTH+vSIBmAyY+y5ceacbcTO/H1w0Y
         bLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780758505; x=1781363305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z56ZvvEiHNN1gkYTK+8/eqIg8fgyCPdSo7V0PEkdypI=;
        b=LMZUAF1A8i1vNra+ZS0UwKQZqtSvDjnNuT+thua9bYV80zQM3+cRSFWVfUdgmT5rpP
         2SLFxXgIs3TkVWkfHgV6eml/Ph0hOI/Bx7z7eU2bBvkX6hSq9Dk1kfEl9gCbh9lSmRw9
         yL4Aijn9jjutDz1cw64EBzkWCmyLHQQhwpz7Ghian510T7lXrXYznUTdYHNndbBmTt/T
         ETWlpUgS8sWNoWTQt1l8Muetwxr2BR7A02CtLUp1NYFk1BJtAW4HyFfPsWR8H4eJu73G
         cbD8qtN5WxxsanVfHrdJc3q58ybqk2gltTy/KWASUY/pCzofPiU0nQ9j3bSMfAoZ4ETW
         MYeQ==
X-Forwarded-Encrypted: i=1; AFNElJ82RJsVtUFiy/uAsdJhiVKktJ2CHUw3XehlO8z6s4cApzluqCb45N9BdXvIQZZEZQTXw0JQgrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpCzdUOAS8mwnaai33wPDSYIGaeJHCC8F66b1tuH73D5YDHGQ
	5g544UyVUyuuu9Ws8N85gOaVvMItj1MQq8OXxp+lZe+rQEjzMlkAwP54
X-Gm-Gg: Acq92OHCmN3kYAo/KJNYkPaum40V/o/TsckMCfR31oK9Cks266lYMgWKU5JzZMcIXWt
	Pv1kwbslIR9XWIdrMoMzHi0EDFwGN5s8eM8re41qHy9yTi7dI5jFJI+5euCMyn/mQlL2FLa7mM6
	HfnZN0ehBERS7kLAYHvjGnoVmYuvB0b+Yj44TecJgovBSL6YdHVmR+c14hiP8SWoh78fsd4yr40
	KnDbj7R4nQXTdFShgq8yHtjYazRPRYGoo8Er1fSWJuaOHiWPVc16aZjE16r1B0eHKrpsDFx+Ff7
	YJ+CBCFAc5qB0DNs0pdNhQgpwLQO+GJXAu9/Ckfpo2Uqy0e4uqONzp2tD+dJ92A1/8TYmMnYQ7S
	o5s06HdTOzOgACrStNjoQN3v6toanY0NnEa3UKK4650oo7U8SUT1We7f4P5TZr7X9yvkO/1+71Q
	8rd3Y4AvPiAy4YkAxIlt1pe/RO4SLiw5Fffy6sWafnuLfEGqFemdMu
X-Received: by 2002:a05:6a00:2e1f:b0:842:5b63:610f with SMTP id d2e1a72fcca58-842b0f25497mr8656172b3a.4.1780758504899;
        Sat, 06 Jun 2026 08:08:24 -0700 (PDT)
Received: from [192.168.1.111] ([223.122.38.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282494285sm12015997b3a.25.2026.06.06.08.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 08:08:23 -0700 (PDT)
Message-ID: <8861022e-97fa-45eb-99fa-7b56225a6423@gmail.com>
Date: Sat, 6 Jun 2026 23:08:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-apple: Prevent tag collision across queues even
 if tag space is shared
Content-Language: en-MW
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
 <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Nick Chan 於 2026/6/6 晚上9:25 寫道:
> From: Yuriy Havrylyuk <yhavry@gmail.com>
> 
> Apple NVMe controllers require tags of pending commands to not be shared
> across admin and IO queues. However, on Apple A11 without linear SQ, it is
> not possible for either queue to skip over some tags and must go from 0 to
> the configured maximum before wrapping around.
> 
> If a pending command tag is duplicated across queues, the firmware
> crashes with: "duplicate tag error for tag N", with N being the tag.
> 
> Instead of partitioning the tag space, which is not possible without
> linear SQ, prevent tag collisions by keeping track of which tags are
> currently in-flight across either queues, and return BLK_STS_RESOURCE to
> temporaily block command submission when a collision would have occurred.
> 
> Cc: stable@vger.kernel.org
> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
> Signed-off-by: Yuriy Havrylyuk <yhavry@gmail.com>
> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  drivers/nvme/host/apple.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)

There are some issues with this version that make it not actually work, so a v2
will sent.

> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index c1115e27a0d6..6354edf27225 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -203,6 +203,20 @@ struct apple_nvme {
>  
>  	int irq;
>  	spinlock_t lock;
> +
> +	/*
> +	 * Tags of pending commands must be unique across both Admin and IO
> +	 * queue. However, on T8015, unlike T8103, without linear submission
> +	 * queues, it is not possible for the either queue to skip some tags,
> +	 * and both queues must go from 0 to their respective configured
> +	 * maximum.
> +	 *
> +	 * Instead of reserving some tags for the admin queue, use a bitfield
> +	 * to keep track of pending commands on either queue, and temporaily
> +	 * block command submission by returning BLK_STS_RESOURCE until the
> +	 * tag is freed on the other queue.
> +	 */
> +	unsigned long t8015_active_tags;
>  };
>  
>  static_assert(sizeof(struct nvme_command) == 64);
> @@ -290,6 +304,28 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
>  				     "NVMMU TCB invalidation failed\n");
>  }
>  
> +static bool apple_nvme_reserve_tag_t8015(struct apple_nvme *anv,
> +					 struct nvme_command *cmd)
> +{
> +	u16 tag = nvme_tag_from_cid(cmd->common.command_id);
> +
> +	if (WARN_ON_ONCE(tag >= BITS_PER_LONG))
> +		return false;
> +
> +	return !test_and_set_bit(tag, &anv->t8015_active_tags);
> +}
> +
> +static void apple_nvme_release_tag_t8015(struct apple_nvme *anv,
> +					 __u16 command_id)
> +{
> +	u16 tag = nvme_tag_from_cid(command_id);
> +
> +	if (WARN_ON_ONCE(tag >= BITS_PER_LONG))
> +		return;
> +
> +	clear_bit(tag, &anv->t8015_active_tags);
> +}
> +
>  static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
>  				  struct nvme_command *cmd)
>  {
> @@ -652,6 +688,8 @@ static inline void apple_nvme_update_cq_head(struct apple_nvme_queue *q)
>  static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
>  			       struct io_comp_batch *iob)
>  {
> +	struct apple_nvme *anv = queue_to_apple_nvme(q);
> +	unsigned long completed_tags = 0;
>  	bool found = false;
>  
>  	while (apple_nvme_cqe_pending(q)) {
> @@ -664,11 +702,26 @@ static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
>  		dma_rmb();
>  		apple_nvme_handle_cqe(q, iob, q->cq_head);
>  		apple_nvme_update_cq_head(q);
> +
> +		if (!anv->hw->has_lsq_nvmmu) {
> +			struct nvme_completion *cqe = &q->cqes[q->cq_head];
> +			u16 tag = nvme_tag_from_cid(READ_ONCE(cqe->command_id));

Reading command ID here is too late since cq head has already been updated.

> +
> +			if (!WARN_ON_ONCE(tag >= BITS_PER_LONG))
> +				__set_bit(tag, &completed_tags);
> +		}
>  	}
>  
>  	if (found)
>  		writel(q->cq_head, q->cq_db);
>  
> +	if (!anv->hw->has_lsq_nvmmu && completed_tags) {
> +		unsigned long tag_bit;
> +
> +		for_each_set_bit(tag_bit, &completed_tags, BITS_PER_LONG)
> +			clear_bit(tag_bit, &anv->t8015_active_tags);
> +	}
> +
>  	return found;
>  }
>  
> @@ -790,6 +843,12 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	if (ret)
>  		return ret;
>  
> +	if (!anv->hw->has_lsq_nvmmu &&
> +	    !apple_nvme_reserve_tag_t8015(anv, cmnd)) {
> +		ret = BLK_STS_RESOURCE;
> +		goto out_free_cmd;

Note goto out_free_cmd here.

> +	}
> +
>  	if (blk_rq_nr_phys_segments(req)) {
>  		ret = apple_nvme_map_data(anv, req, cmnd);
>  		if (ret)
> @@ -806,6 +865,9 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	return BLK_STS_OK;
>  
>  out_free_cmd:
> +	if (!anv->hw->has_lsq_nvmmu)
> +		apple_nvme_release_tag_t8015(anv, cmnd->common.command_id);

Combined with above this makes any attempted use of a in-use tag release that
tag, making the workaround ineffective. (and allows nvme to still "work" if
the tester is (un)lucky).

> +
>  	nvme_cleanup_cmd(req);
>  	return ret;
>  }
> @@ -1165,6 +1227,9 @@ static void apple_nvme_reset_work(struct work_struct *work)
>  	if (ret)
>  		goto out;
>  
> +	if (!anv->hw->has_lsq_nvmmu)
> +		WRITE_ONCE(anv->t8015_active_tags, 0);
> +
>  	dev_dbg(anv->dev, "Starting admin queue");
>  	apple_nvme_init_queue(&anv->adminq);
>  	nvme_unquiesce_admin_queue(&anv->ctrl);
> 

Best regards,
Nick Chan
