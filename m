Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232233A4F4B
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780756175; cv=none; b=gRhgYOIvfQqtS74UtnBXZioNPCUm/ZIcdzrGVTm3lbABddpVsVW27Q37xvPPrDka7uMycpdyN66u16rvMSUCOGBqQSBIH0JtABMpsqJROHsJaBQiZRtMQo52L6VshQbsyNLYHgn3pYraHiPLKjWW9aLdV+Z04weSs+utbrWxqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780756175; c=relaxed/simple;
	bh=SMQTvcZ6BrmhlMD+3mEMoKUn2owCl+xIUyOb10rwEV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/rjY2FnZJmJg988p94Q/8AshYhVNkBUSemMrpoF/H1KMt4vF5QadQ5XEBmzub/b7fHn2RK32JrujyXJ0R1Q6azMepe22Q2uG4tq27jO8jj4ApClrQ5bfuO/szszXVS3+yLCBNPR9dLkYh8flhW7auH5c/VXRfeZrzCCHEInh/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMrs+fu/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMrs+fu/"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490c1915793so14615385e9.2
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780756172; x=1781360972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGwj67mAdvjyet/J2nHlIYGQH//k5ItlM0+5UXPSkLM=;
        b=cMrs+fu/ryEUMIg/+D86yJP/7Bzb8JKrO6NQ7PQV/EINo228QGz+k2J9DzDm52BXOa
         03pRIYEPruT0vrnKYfayxIOE2vaBpmFCxkWuuzxl2Y6dOIN8YM4LIenE4sXMADN8Neif
         TvYTeNy1Mw9It4EH7D0P8wHkNMzp7mK8pLE1cwBDM2nc3LWAZbpr0QUjv2mtd09AmLzD
         LSX7otO8EfBvCktoM4rReIsfj5fyGlRrCpnuANtlZQTqOzJHcNk/fYqIdBvhbWS0DwFG
         Ok/smp0Ub4IltoD/DmH5HpzZacQo8HyBUQF/a7KOKK+ueGtuEY1GtOS4A1s1uXOcJoXw
         C4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780756172; x=1781360972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGwj67mAdvjyet/J2nHlIYGQH//k5ItlM0+5UXPSkLM=;
        b=Q4OucRjT2NedwMaYNDUFlNisSwuB5AdQ5tGGm7gfg1GzWfNKutUz5u8rXRFm/uF6EJ
         9W1kGQ7coeMBDqyO5E5Ce676tZcMaxHr0AfhGUbUDSD580yHuW587uFwf+M9TCDOfATa
         XxTm5faeKU/v004KYVkv+8hddI1Lim/5mATsw8UtkHAhWB6qpBS4Y8Fdg3sHsXA+Vfx6
         WLZAXrqh+/I9Y0h1VGR0nV6BN701tiS+ZJWOP/1elrzU3uwqJQp94vPnPvCdpnUhoX+l
         LLC7UW2JnxR5xdPLgAd45I8/Xn3zd+AtvkknOfQ0Is1dUWj0Aeh2kBXwKVQ8PKcwE+jU
         l7XA==
X-Forwarded-Encrypted: i=1; AFNElJ9oIivjVz3DZiOjlLcepvtuwxn6OnIUEY0GwuqPSJD95BBKnZr37EeFvTE4+eSjKvPOjidKfgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdfw4bjGoCTdhwQT0IjYX9ec1/uGhduc++UCnA51KfeXcEaEt
	cf/zoyT+2aD7/Ln+i6YDHqPvw3s4nA7uWp/+fVv5/K2QYg1xueEElDZo
X-Gm-Gg: Acq92OH57MFg7IIF9jQr+eAclRFcKZRxnfMlCn7nkNYWFDAmxmdhwX39y8VgnTwT3gJ
	tTAVTRh+GYUxi5v/BznPav+O3kxqTHOjHrpsCYLRyHFr6rCsraseVx+IAq7c8aCnpsP70Yw9mvd
	McRDOi6HCoeBta+P5RzEwaGWHZ1HBFghdCiqAN5+2Kx8Nnlze3wwrVkZRtumnoF4HcDULTzSl8L
	eDxbBwZt3PclrudmuVkYQ9TrDd8TbR1XW5ccORv583gtih9daxkp1w91MQ7G1PfuMKkqeGGPrKT
	zDCNXAPNY8mUQQiGSJzSErXJWMCTrCJQNDAlbU/ZIgW5KbBYC3SKn8FNuS0p+K4JzCIuU8UsbJl
	/lAcp6/8I1d/oCdzWz3OD0fUrR5k1XNzI17ke6d8onyqtGKStPMWzhUgXgOmIXwRjA2RN6hRR2B
	Qq+Jxfbxiw5Zo/HURwkRAUZQs9V342f3iFrggbjDQfZrhkchvhsCCBeB5GJPAm30UTDIeCWow=
X-Received: by 2002:a05:600c:3153:b0:490:b8c0:d46a with SMTP id 5b1f17b1804b1-490c2604790mr138043675e9.22.1780756172286;
        Sat, 06 Jun 2026 07:29:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm36003622f8f.13.2026.06.06.07.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 07:29:32 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:29:30 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa
 <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Yuriy Havrylyuk
 <yhavry@gmail.com>
Subject: Re: [PATCH 2/2] nvme-apple: Prevent tag collision across queues
 even if tag space is shared
Message-ID: <20260606152930.6f2bf4ed@pumpkin>
In-Reply-To: <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
	<20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 06 Jun 2026 21:25:26 +0800
Nick Chan <towinchenmi@gmail.com> wrote:

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

I look at using the atomic64_xxx() functions rather than the bitmask ones.
The for_each_bit_set() loop is then an atmomic64_andnot() call.

-- David


> 
> Cc: stable@vger.kernel.org
> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
> Signed-off-by: Yuriy Havrylyuk <yhavry@gmail.com>
> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  drivers/nvme/host/apple.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
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

