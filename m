Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268663;
	b=3qYJuCgPpzh6nWq+56dVimF1/w/feIB7K4fTAMTtbKKFGZmGcjl25ammom29yVOXdzKQ
	 JF1iM6VmraqgO4qBpka0nlDUsa5+3SK6j1YpQGP3jWn0WGUXa5342hAAqa9Wh5vlrqUgN
	 VbX4q0zrxgFI82+yy1t03yUnAPHsChim2acEmPpBfJineHKpzFt5OApoyfp1GtcubplKD
	 rPICv4fc9fI5Km1n6hqSUfk2/Elq3OOiptkKvfiKKM+Ha8EVCgtb3vPDTGyVzEL7JZJ9D
	 7LaIvdJSHfnvB870f8dxugQYi/fc5IFi6DzE8v339HLgY6fPhtd8HfBT5QSSw1cFiuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268663;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=5/xKdXGvf0SwURHrf4BSTCHgQstFbzFxNucWmaiO7EQ=;
	b=TjWsZS6fPX5eOvEGpIsRc/dOYhJy75/NM9vLw3so21AnT5gjuIPB/F+GCXk2keDiP5/j
	 WL2NgW1md5Tir0KPFjUpJdDlvdZy1OOM+NTgshGVys3V9cml1ssIntA/2kc5Hbzp0uRr7
	 BspNyPQXdlzA/gKfrtVvmtvLADFrevLYzqy2C9ygU+L9JsZIUTUalVvz7V+J2n8e5Q052
	 7ViA3h1dCTSo9S7wnfqgfHG2H8JRFXYg1CzGU8dNgM0nTSFydGu9ylSseT3ajqN+blsha
	 dHvsYbpa6brXYYztR3v9LFvYsIFVTyVIKhwTXDC2ZksBzKSQowHuKmAvZLZ+BVr6P+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gECj2Zuh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RZmCdxqd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gECj2Zuh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RZmCdxqd;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BE3606A31C;
	Thu, 29 Oct 2026 10:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09BE3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gECj2Zuh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RZmCdxqd;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gECj2Zuh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RZmCdxqd
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 212F61F800;
	Thu, 29 Oct 2026 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/xKdXGvf0SwURHrf4BSTCHgQstFbzFxNucWmaiO7EQ=;
	b=gECj2Zuh2who74CABEKV+lSoEFUKJWj+JxBrxdAGG4eoLrTIA7IYKpJ4xLGH95f21Cjp4R
	Zpp/XkFdDFKYLo5YtJhNlSNY4EDufiNdHhVs3ImAGq3IJWZGExxl/PXvxjbwNkUWKf7+hG
	zbern4Hxyp3vMC8hdDSOhNGeNfVIQtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/xKdXGvf0SwURHrf4BSTCHgQstFbzFxNucWmaiO7EQ=;
	b=RZmCdxqdL7AOMYJmFik9wSNRauroZfGCWu6c98A7PbQai2vNMqtjx/qUM58voyKtbvALoT
	75TfhZeQUmNMMODw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793268661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/xKdXGvf0SwURHrf4BSTCHgQstFbzFxNucWmaiO7EQ=;
	b=gECj2Zuh2who74CABEKV+lSoEFUKJWj+JxBrxdAGG4eoLrTIA7IYKpJ4xLGH95f21Cjp4R
	Zpp/XkFdDFKYLo5YtJhNlSNY4EDufiNdHhVs3ImAGq3IJWZGExxl/PXvxjbwNkUWKf7+hG
	zbern4Hxyp3vMC8hdDSOhNGeNfVIQtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793268661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/xKdXGvf0SwURHrf4BSTCHgQstFbzFxNucWmaiO7EQ=;
	b=RZmCdxqdL7AOMYJmFik9wSNRauroZfGCWu6c98A7PbQai2vNMqtjx/qUM58voyKtbvALoT
	75TfhZeQUmNMMODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D823C13419;
	Thu, 29 Oct 2026 10:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9IQZK7Qb42rZMAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 29 Oct 2026 10:11:00 +0000
Message-ID: <67168d7a-4df5-4851-8df5-8b8a03097aeb@suse.de>
Date: Thu, 29 Oct 2026 11:11:00 +0100
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
Subject: Re: [PATCH 93/98] nvmet-fc: only send read data for successful
 commands
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>, stable@vger.kernel.org,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-94-axboe@kernel.dk>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028164415.1262013-94-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,broadcom.com,lst.de,grimberg.me,nvidia.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,lst.de:email,nvidia.com:email,suse.de:email,grimberg.me:email]
X-Spam-Score: -11.79

On 10/28/26 5:42 PM, Jens Axboe wrote:
> From: Andrea Parri <parri.andrea@gmail.com>
> 
> __nvmet_fc_fcp_nvme_cmd_done() pushes the whole data buffer of a read
> to the host even when the command failed. The buffer comes from
> sgl_alloc() without __GFP_ZERO, and a command rejected by
> nvmet_check_transfer_len() never touches it, so the host receives stale
> target memory, as much as it asked for.
> 
> The tcp and rdma targets only send data when cqe->status is zero. Do
> the same for fc. The ERSP then reports fod->offset, which is 0, as the
> transferred length, matching what the host checks.
> 
> Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
> Cc: stable@vger.kernel.org
> Cc: Justin Tee <justin.tee@broadcom.com>
> Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>
> Cc: Paul Ely <paul.ely@broadcom.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/target/fc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index eecdffefa24f..b95893adae36 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -2487,11 +2487,11 @@ __nvmet_fc_fcp_nvme_cmd_done(struct nvmet_fc_tgtport *tgtport,
>   	} else {
>   
>   		/*
> -		 * try to push the data even if the SQE status is non-zero.
> -		 * There may be a status where data still was intended to
> -		 * be moved
> +		 * A failed command may not have filled its read buffer, so
> +		 * only push data for success, as the tcp and rdma targets do.
>   		 */
> -		if ((fod->io_dir == NVMET_FCP_READ) && (fod->data_sg_cnt)) {
> +		if (fod->io_dir == NVMET_FCP_READ && fod->data_sg_cnt &&
> +		    !cqe->status) {
>   			/* push the data over before sending rsp */
>   			nvmet_fc_transfer_fcp_data(tgtport, fod,
>   						NVMET_FCOP_READDATA);

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
