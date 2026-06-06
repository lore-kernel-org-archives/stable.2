Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962EF2F5468
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761075; cv=none; b=nzP24H7PKTiGVE9GDX0ntb7pJoZtoploEpdJQD3eWpcFw+x4YFWkZ1tP9c+Fhb9tk4qzA3ZwumtBixUNvMqrDmbd52z9kvIo41xs4oFMQrEsQ8xhhAEWDBM6ZSZUBSFk+dYQoUOhKNPr3ciHLRPcukfFOknQWVXAcK9d1BRpwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761075; c=relaxed/simple;
	bh=EAZnvXVTdcXAnOI8owRz/vI0NaBiCWDPGMCDT2ybPiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dT/vcvSopdf4/FF+X2O/tyrmqjSpdVpcdYvvLTlDImgoEKv9ktILv2ttpDCWMi/KlsEXx3/ooGTYn0DYuO6MZBosni+BSvdgZDEIDPyvx/FRk0QXtBXBIQb+jT7IiAKup0qivWdmMqlNOkbGe4QhcXSEdcoNNwnWjQls5Goc6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCPQ/w6W; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCPQ/w6W"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso21157065ad.0
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780761074; x=1781365874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B145KD8e++H5H8gOSlDhp27emRCyB3jiBGAu0/EtMIQ=;
        b=hCPQ/w6W326xbnN9FI2VLhSRqbZ7XYaoNwNN101tXD4ZXjWZx2gEhjq+sw4xTgQIkq
         trPDhTMJwq0DZw5V6pOyo3NeeJspHuRxmguFPZy+tP9APOZ7MdjU4CYBDswwrG/nVcoC
         lr5ZEvtX1yCkXy5+QgubcmiHF7O4wjMpUaysNBjs+t/Ky9ejuj8+xjsZ+ccEma0k7r+X
         7o/S448gslkag1+fXnIWUiDQhtKZJ0R5gh5fYCbENUZIlxAM5bnQnR/IPzp2Qilz8WYI
         wuMKZdaKnL161ui7k983h0sM1Pnyrm7T4eqFauFPyJnbwhooUPEaD1hTPHzkZcM0BkEL
         VFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761074; x=1781365874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B145KD8e++H5H8gOSlDhp27emRCyB3jiBGAu0/EtMIQ=;
        b=cvtscr1cas012HeCvLqCFcBGQQcoPzTfBwkb7HFW+kGoIhitqwpff1gpr4o4V/t/aT
         nMo7AQXwjuicRN/MaYjIpERDplH4MauXr0M9hNs8w4f/hGfEY6gktbydgyHF7taUego5
         2GKa6+lJrzgzrow66qslm+Kk9an5GjwhQLclgGn+CtxG9pqoK13uI1fwSLQZgr2qi6g3
         178Znfq/U7P38pcThYb3rJLmXsBDN2T5sPuzmx1WTj6AZVHql6Abm+6wGRpDxD3PkNYJ
         GHJxxhHLhd+AJXFQZxvvcVMsq4kzV8T9j3vHNjX3iE+klSrEMOpIh5nPbBgCDEYLftB7
         QWZg==
X-Forwarded-Encrypted: i=1; AFNElJ8iXf/GlHyj9pItb+5Z8/hAopemRujVP+BhoYnPNyildJi6v9Yix37JiK//C5BFpEfw1mnXDRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7MfAKXEx2D7eTE4Csh5/3lg7Lem8kWfz9QPculjao8eBvZV7
	jcPCpGdB3sMji1v+paHI5tgJ8ff3pqx7ZFXVnUj7s8ui1hvTpYyzolYQ
X-Gm-Gg: Acq92OEpbRsgEGgxIYZoqn3ZTllRhlCH3pvWRksmH2qgESUFfhMGOhlKOozncEsRYl+
	oKfk3oEwaL28Wwl5zAE90eX3yNFV08OgzRreQurVsdwxbcGjjoYVGQytmwN/iHFEgx3L/a3hfaB
	uYHykAm+7twXMDi+hZ+5BKNgK1xZVokXkktACYpslcmNnJ7GFzGAahIa6jCawmSobZkh4PjZDXi
	iUDwxuj7KkeoTlW4ikcJFdPq3NaOVk4CF9wV4EkMDI8xPoLjg1JIq1DtvLBnGgKsa8yhR7AHO0L
	ot9MrsSf/YlFi5hbV/JD++hBzgfB8nO+cHrJm2EsdUyr3OrVvz3C+s0WcD3dGhTZydGhP7u9j9L
	MYog2Y9qy1ZgYdPWbuUhzOY6sjSa0A5nOh5Ug5I5v8D1KPgvag92BRrT8/Wu1tGWLqeJrC04FZR
	PGjBMgRpoiSe0b8qwDbrAiwRAQf8GtBfWEAsqqMvWt8w==
X-Received: by 2002:a17:903:1b44:b0:2c0:c262:b925 with SMTP id d9443c01a7336-2c1e7f9252fmr104566115ad.25.1780761073850;
        Sat, 06 Jun 2026 08:51:13 -0700 (PDT)
Received: from [192.168.1.111] ([223.122.38.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649ab01sm121917285ad.71.2026.06.06.08.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 08:51:13 -0700 (PDT)
Message-ID: <9ca8d72c-af36-43a4-90ab-90f13b02f4fb@gmail.com>
Date: Sat, 6 Jun 2026 23:51:07 +0800
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
To: David Laight <david.laight.linux@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Yuriy Havrylyuk <yhavry@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
 <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
 <20260606152930.6f2bf4ed@pumpkin>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20260606152930.6f2bf4ed@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



David Laight 於 2026/6/6 晚上10:29 寫道:
> On Sat, 06 Jun 2026 21:25:26 +0800
> Nick Chan <towinchenmi@gmail.com> wrote:
> 
>> From: Yuriy Havrylyuk <yhavry@gmail.com>
>>
>> Apple NVMe controllers require tags of pending commands to not be shared
>> across admin and IO queues. However, on Apple A11 without linear SQ, it is
>> not possible for either queue to skip over some tags and must go from 0 to
>> the configured maximum before wrapping around.
>>
>> If a pending command tag is duplicated across queues, the firmware
>> crashes with: "duplicate tag error for tag N", with N being the tag.
>>
>> Instead of partitioning the tag space, which is not possible without
>> linear SQ, prevent tag collisions by keeping track of which tags are
>> currently in-flight across either queues, and return BLK_STS_RESOURCE to
>> temporaily block command submission when a collision would have occurred.
> 
> I look at using the atomic64_xxx() functions rather than the bitmask ones.
> The for_each_bit_set() loop is then an atmomic64_andnot() call.

That does in fact simplify the loop code. However, using the atomic function
complicates the apple_nvme_reserve_tag_t8015() and
apple_nvme_release_tag_t8015() since those functions deal with set/clear a
a bit in terms of an integer (the tag).

Especially in the apple_nvme_reserve_tag_t8015() function the function body
is then

	u64 tag_bit = BIT(nvme_tag_from_cid(cmd->common.command_id));

	return !(atomic64_fetch_or(tag_bit, &anv->t8015_active_tags) & tag_bit);

The function would need to explictly convert the tag to a bit, and then
explictly extract the bit value after performing the atomic operation,
both which of could have been done by test_and_set_bit().

So I do not see any overall benefit for using atomic_xxx() functions.

Best Regards,
Nick Chan

> 
> -- David
> 
> 
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
>> Signed-off-by: Yuriy Havrylyuk <yhavry@gmail.com>
>> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  drivers/nvme/host/apple.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 65 insertions(+)
>>
>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>> index c1115e27a0d6..6354edf27225 100644
>> --- a/drivers/nvme/host/apple.c
>> +++ b/drivers/nvme/host/apple.c
>> @@ -203,6 +203,20 @@ struct apple_nvme {
>>  
>>  	int irq;
>>  	spinlock_t lock;
>> +
>> +	/*
>> +	 * Tags of pending commands must be unique across both Admin and IO
>> +	 * queue. However, on T8015, unlike T8103, without linear submission
>> +	 * queues, it is not possible for the either queue to skip some tags,
>> +	 * and both queues must go from 0 to their respective configured
>> +	 * maximum.
>> +	 *
>> +	 * Instead of reserving some tags for the admin queue, use a bitfield
>> +	 * to keep track of pending commands on either queue, and temporaily
>> +	 * block command submission by returning BLK_STS_RESOURCE until the
>> +	 * tag is freed on the other queue.
>> +	 */
>> +	unsigned long t8015_active_tags;
>>  };
>>  
>>  static_assert(sizeof(struct nvme_command) == 64);
>> @@ -290,6 +304,28 @@ static void apple_nvmmu_inval(struct apple_nvme_queue *q, unsigned int tag)
>>  				     "NVMMU TCB invalidation failed\n");
>>  }
>>  
>> +static bool apple_nvme_reserve_tag_t8015(struct apple_nvme *anv,
>> +					 struct nvme_command *cmd)
>> +{
>> +	u16 tag = nvme_tag_from_cid(cmd->common.command_id);
>> +
>> +	if (WARN_ON_ONCE(tag >= BITS_PER_LONG))
>> +		return false;
>> +
>> +	return !test_and_set_bit(tag, &anv->t8015_active_tags);
>> +}
>> +
>> +static void apple_nvme_release_tag_t8015(struct apple_nvme *anv,
>> +					 __u16 command_id)
>> +{
>> +	u16 tag = nvme_tag_from_cid(command_id);
>> +
>> +	if (WARN_ON_ONCE(tag >= BITS_PER_LONG))
>> +		return;
>> +
>> +	clear_bit(tag, &anv->t8015_active_tags);
>> +}
>> +
>>  static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
>>  				  struct nvme_command *cmd)
>>  {
>> @@ -652,6 +688,8 @@ static inline void apple_nvme_update_cq_head(struct apple_nvme_queue *q)
>>  static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
>>  			       struct io_comp_batch *iob)
>>  {
>> +	struct apple_nvme *anv = queue_to_apple_nvme(q);
>> +	unsigned long completed_tags = 0;
>>  	bool found = false;
>>  
>>  	while (apple_nvme_cqe_pending(q)) {
>> @@ -664,11 +702,26 @@ static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
>>  		dma_rmb();
>>  		apple_nvme_handle_cqe(q, iob, q->cq_head);
>>  		apple_nvme_update_cq_head(q);
>> +
>> +		if (!anv->hw->has_lsq_nvmmu) {
>> +			struct nvme_completion *cqe = &q->cqes[q->cq_head];
>> +			u16 tag = nvme_tag_from_cid(READ_ONCE(cqe->command_id));
>> +
>> +			if (!WARN_ON_ONCE(tag >= BITS_PER_LONG))
>> +				__set_bit(tag, &completed_tags);
>> +		}
>>  	}
>>  
>>  	if (found)
>>  		writel(q->cq_head, q->cq_db);
>>  
>> +	if (!anv->hw->has_lsq_nvmmu && completed_tags) {
>> +		unsigned long tag_bit;
>> +
>> +		for_each_set_bit(tag_bit, &completed_tags, BITS_PER_LONG)
>> +			clear_bit(tag_bit, &anv->t8015_active_tags);
>> +	}
>> +
>>  	return found;
>>  }
>>  
>> @@ -790,6 +843,12 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (!anv->hw->has_lsq_nvmmu &&
>> +	    !apple_nvme_reserve_tag_t8015(anv, cmnd)) {
>> +		ret = BLK_STS_RESOURCE;
>> +		goto out_free_cmd;
>> +	}
>> +
>>  	if (blk_rq_nr_phys_segments(req)) {
>>  		ret = apple_nvme_map_data(anv, req, cmnd);
>>  		if (ret)
>> @@ -806,6 +865,9 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  	return BLK_STS_OK;
>>  
>>  out_free_cmd:
>> +	if (!anv->hw->has_lsq_nvmmu)
>> +		apple_nvme_release_tag_t8015(anv, cmnd->common.command_id);
>> +
>>  	nvme_cleanup_cmd(req);
>>  	return ret;
>>  }
>> @@ -1165,6 +1227,9 @@ static void apple_nvme_reset_work(struct work_struct *work)
>>  	if (ret)
>>  		goto out;
>>  
>> +	if (!anv->hw->has_lsq_nvmmu)
>> +		WRITE_ONCE(anv->t8015_active_tags, 0);
>> +
>>  	dev_dbg(anv->dev, "Starting admin queue");
>>  	apple_nvme_init_queue(&anv->adminq);
>>  	nvme_unquiesce_admin_queue(&anv->ctrl);
>>
> 

