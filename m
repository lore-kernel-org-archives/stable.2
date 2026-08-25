Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9920481A8B
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680090; cv=none; b=gzDytr1t0QawjUxT4ISTVrjDbN0PuSXiFK1B7RuEscWtY5A81KfEmJjL5h7J+OmwwtlOptTN+96aOWLXbn6mAYW3kq/K+oMEbhlshR44jat9WX01COKvNMCN7kIcT4Ye1f29V5lqpHrmtEq1DQf5luQO+CZQ+9SqMycMSgKie7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680090; c=relaxed/simple;
	bh=DoBE1YutqmTTeNqPPKUxHpIV8RPgRggMKQh0GHBX96E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/x8OyDOllW632Tl6pvNufDqia4J6nYe0mQgYubO1PD/DZplfT2ovY+Q6F9IDoKyekcg/DuivdVGtDi9V27oh2UdJfCsz+gmmllz+fVieSEf8445qiOOcw6dBAAqvJHWN09ndGXxPTRz6qACmhdVXwKAk0ZPQfnvdAz17y4mlDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cS5H4QMT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yKMvnmn/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cO5cnZPy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n6jUiyID; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cS5H4QMT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yKMvnmn/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cO5cnZPy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n6jUiyID"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EED9C1F809;
	Tue, 25 Aug 2026 17:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787679955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cRWZ2ihwPGc7wHslWZjtP2QXTAhsIigq4YW6g65IrQ=;
	b=cS5H4QMT3FA3bAi3wnInOpZZIG54XK7d0w/OnKn9B0y/vO/qbO2Pwr8Qj9gvEW0/r0LWl2
	dV2bfv+CTO7DNW7pr8qabqKoh5B9l9MFbTdHVaO+7fcDCfu1BiMqYiU9i2HgS/oahjvM5V
	m8NvRYDKaxI6WG7LxHr2BA+qfPEMBgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787679955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cRWZ2ihwPGc7wHslWZjtP2QXTAhsIigq4YW6g65IrQ=;
	b=yKMvnmn/8Y5Zab0P+mXphkg2Pq20cN349VSCab2w5yzj8G+kgpnmh7Pt2KuLUTIy6g8XiX
	E6wtHYdEJokpXkAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787679950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cRWZ2ihwPGc7wHslWZjtP2QXTAhsIigq4YW6g65IrQ=;
	b=cO5cnZPyLFOVPEOYynLVkrniyu3gfVFnJ6FQw4Q1oPyjDJNC6wc5NqxD97gxhCLiLFUs5n
	AK+YUXNvECg46boKPuJC8bNdCSE1wMyg1L0qMou80fAPiLeNUJ6kMy3ogv1GiVCVMsgm4Q
	fkWHGvm8yr4OWjZFtRyVIKBpwxDHQ0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787679950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cRWZ2ihwPGc7wHslWZjtP2QXTAhsIigq4YW6g65IrQ=;
	b=n6jUiyIDyIjxBSFS+levErxoEj/mPadp59Imkq+QhQEjrm/PqQjpzbYoPeSNS8EIGHePv5
	9hWkb4VwsD+yjJAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DD8313332;
	Tue, 25 Aug 2026 17:45:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8WQkJc7UjWrvNwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Aug 2026 17:45:50 +0000
Message-ID: <8911970b-f6b7-4b44-b71f-47a942633790@suse.de>
Date: Tue, 25 Aug 2026 19:45:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
To: Niklas Cassel <cassel@kernel.org>, Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: stable@vger.kernel.org,
 syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
 linux-nvme@lists.infradead.org
References: <20260814143833.1953415-2-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260814143833.1953415-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.66
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.66 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.06)[-0.282];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[f58e57380a6083c4041d];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,broadcom.com,gmail.com,kernel.dk,lst.de,grimberg.me,nvidia.com];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 8/14/26 4:38 PM, Niklas Cassel wrote:
> nvmf_create_ctrl() owns the fabrics options and frees them whenever
> ->create_ctrl() returns an error, so a transport must not free them on
> its own error paths.  nvme-fc tracks this by testing ctrl->ctrl.opts in
> nvme_fc_ctrl_free(), which requires nvme_fc_init_ctrl() to clear that
> pointer on every error exit.
> 
> The coupling is implicit, and commit 1a9e218195a5 ("nvme: split device
> add from initialization") broke it by adding a second error exit.  When
> nvme_add_ctrl() fails, nvme_fc_init_ctrl() jumps to out_put_ctrl:, past
> the "ctrl->ctrl.opts = NULL" that only sits on the fail_ctrl: path, so
> nvme_fc_ctrl_free() frees the options and nvmf_create_ctrl() frees them
> a second time:
> 
>    BUG: KASAN: slab-use-after-free in nvmf_free_options+0x30/0x190
>     nvmf_free_options+0x30/0x190 drivers/nvme/host/fabrics.c:1284
>     nvmf_create_ctrl drivers/nvme/host/fabrics.c:1374 [inline]
>    Freed by task 5534:
>     nvme_fc_ctrl_free drivers/nvme/host/fc.c:2374 [inline]
>     nvme_fc_init_ctrl+0xe17/0x1450 drivers/nvme/host/fc.c:3605
> 
> nvme_add_ctrl() fails when dev_set_name() cannot allocate, so this is
> reachable under memory pressure or fault injection.  Without KASAN the
> options are freed twice.
> 
> Rather than clear the pointer on the second exit as well, derive
> ownership the way nvme-tcp, nvme-rdma and nvme-loop do, from list
> membership: their free_ctrl leaves the options alone unless the
> controller made it onto the transport list.
> 
> The list cannot simply be populated on the success path as it is there.
> nvme-fc runs the initial connect synchronously via flush_delayed_work(),
> and the controller has to be reachable on rport->ctrl_list for the whole
> of it: nvme_fc_unregister_remoteport() needs to find it to signal
> connectivity loss, nvme_fc_match_disconn_ls() matches an incoming
> Disconnect Association LS against ctrl->association_id, which is only
> assigned during that window, nvme_fc_resume_controller() needs it on
> remoteport re-registration, and nvme_fc_existing_controller() uses it to
> reject a duplicate connect racing the one in flight.
> 
> Keep the insertion where it is and add a fail_unlist: label, falling
> into fail_ctrl:, for the error paths that run after it.  The earlier
> error paths never reach the insertion and keep using fail_ctrl:
> directly, so the list is only touched where the controller is actually
> on it.
> 
> nvme_fc_ctrl_free() cannot use the plain "goto free_ctrl" the other
> transports use, because it still has to put_device(), release the rport
> reference and free the ida entry for resources taken before the
> insertion.  Sample list_empty() under rport->lock instead.
> 
> ctrl->ctrl.opts also stays valid for the whole teardown now.  That is
> not the bug being fixed, but it removes some fragility around the old
> idiom: nvme_free_ctrl() calls nvme_auth_free() before ->free_ctrl(), and
> ctrl_max_dhchaps() dereferences ctrl->opts without a NULL check when
> ctrl->dhchap_ctxs is set, which nvme-fc permits since NVMF_ALLOWED_OPTS
> allows the dhchap options.  The nvme sysfs attributes that dereference
> ctrl->opts, such as hostnqn and address, evaluate their is_visible()
> test once at device_add() time and stay readable until
> cdev_device_del().
> 
> Fixes: 1a9e218195a5 ("nvme: split device add from initialization")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f58e57380a6083c4041d
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 04363b9c4489..7e1794f054d6 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2358,9 +2358,15 @@ nvme_fc_ctrl_free(struct kref *ref)
>   	struct nvme_fc_ctrl *ctrl =
>   		container_of(ref, struct nvme_fc_ctrl, ref);
>   	unsigned long flags;
> +	bool owns_opts;
>   
> -	/* remove from rport list */
> +	/*
> +	 * Presence on the rport list means nvme_fc_init_ctrl() completed,
> +	 * and with it ownership of the fabrics options passed to it. If it
> +	 * failed instead, the options still belong to nvmf_create_ctrl().
> +	 */
>   	spin_lock_irqsave(&ctrl->rport->lock, flags);
> +	owns_opts = !list_empty(&ctrl->ctrl_list);
>   	list_del(&ctrl->ctrl_list);
>   	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
>   
> @@ -2370,7 +2376,7 @@ nvme_fc_ctrl_free(struct kref *ref)
>   	nvme_fc_rport_put(ctrl->rport);
>   
>   	ida_free(&nvme_fc_ctrl_cnt, ctrl->cnum);
> -	if (ctrl->ctrl.opts)
> +	if (owns_opts)
>   		nvmf_free_options(ctrl->ctrl.opts);
>   	kfree(ctrl);
>   }
> @@ -3569,14 +3575,14 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
>   		dev_err(ctrl->ctrl.device,
>   			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
> -		goto fail_ctrl;
> +		goto fail_unlist;
>   	}
>   
>   	if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
>   		dev_err(ctrl->ctrl.device,
>   			"NVME-FC{%d}: failed to schedule initial connect\n",
>   			ctrl->cnum);
> -		goto fail_ctrl;
> +		goto fail_unlist;
>   	}
>   
>   	flush_delayed_work(&ctrl->connect_work);
> @@ -3587,14 +3593,22 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   
>   	return &ctrl->ctrl;
>   
> +fail_unlist:
> +	/*
> +	 * Leaving the list hands the options back to nvmf_create_ctrl();
> +	 * see nvme_fc_ctrl_free().  Re-init so that list_empty() there
> +	 * reports the controller as unlisted.
> +	 */
> +	spin_lock_irqsave(&rport->lock, flags);
> +	list_del_init(&ctrl->ctrl_list);
> +	spin_unlock_irqrestore(&rport->lock, flags);
> +< hare
>   fail_ctrl:
>   	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
>   	cancel_work_sync(&ctrl->ioerr_work);
>   	cancel_work_sync(&ctrl->ctrl.reset_work);
>   	cancel_delayed_work_sync(&ctrl->connect_work);
>   
> -	ctrl->ctrl.opts = NULL;
> -
>   	if (ctrl->ctrl.admin_tagset)
>   		nvme_remove_admin_tag_set(&ctrl->ctrl);
>   	/* initiate nvme ctrl ref counting teardown */

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
