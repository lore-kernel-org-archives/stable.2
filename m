Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892AD3D669C
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987900; cv=none; b=GqGCr4ceJA6kInLWr9xYZSMnR9MGzFU1tkXxZvWN7PSJKRvApVxIhIyKkIpgTrhrR42PM2ThlZ3yRNC5jr+WshiIXCrWSP3Dk36j/Hh7/iALbsa1YzoBLG2jny4fzYr+QNcelGHcFUSyHMK1+NM6BkfnoXFeiMxu0EQaEbxfo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987900; c=relaxed/simple;
	bh=lEUEg25rsA32Xkzwc4nFMsodCUpYIehOznK4Cpg/mWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMMFwjp1fuEHo7qRSKkITBIZdSuO3RnjUoacuZ1Capu/qoLVIh+dBujCU+UtWYKMhB/3aDz4Rvp+TaM5p7mIgxTwpoIOKjuA49VZjUQbLtNdpnj3K+FOb0mFd7jEjvc9SQIhcz2mh3WBr9twGmEGJXbzaguBA8gwXRXpyQWNayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cSO2iyb2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6WIRBEPi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cSO2iyb2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6WIRBEPi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cSO2iyb2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6WIRBEPi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cSO2iyb2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6WIRBEPi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3221B6A7E7;
	Tue,  9 Jun 2026 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780987894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5X06zig+UKxVMDIfUi6G+f9hwbst8eY+SMVRqeH3Nr0=;
	b=cSO2iyb2hcz4MDgQjRsck5RkT/Zr9C3V6fG4Kb099ITt6Id+elqENRWfmx2QRg23cIIfh3
	FzPw2wm6kSVbPCS4Sw8vvmCf1VDUEkGmGfQW1pz8ueWhu58gLTZAGLF5qA3DSv4qHmh9mj
	eI1IqStVhIc9jP+sWeJ1CalL/dMNGYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780987894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5X06zig+UKxVMDIfUi6G+f9hwbst8eY+SMVRqeH3Nr0=;
	b=6WIRBEPi0LxEYJMQMNQA6CNWraQOvjw9ABRVaXnb0DsZyqRB/sQhXKJnS+zzN5DkqmwlLb
	yLUsb88VGhvffACw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cSO2iyb2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6WIRBEPi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780987894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5X06zig+UKxVMDIfUi6G+f9hwbst8eY+SMVRqeH3Nr0=;
	b=cSO2iyb2hcz4MDgQjRsck5RkT/Zr9C3V6fG4Kb099ITt6Id+elqENRWfmx2QRg23cIIfh3
	FzPw2wm6kSVbPCS4Sw8vvmCf1VDUEkGmGfQW1pz8ueWhu58gLTZAGLF5qA3DSv4qHmh9mj
	eI1IqStVhIc9jP+sWeJ1CalL/dMNGYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780987894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5X06zig+UKxVMDIfUi6G+f9hwbst8eY+SMVRqeH3Nr0=;
	b=6WIRBEPi0LxEYJMQMNQA6CNWraQOvjw9ABRVaXnb0DsZyqRB/sQhXKJnS+zzN5DkqmwlLb
	yLUsb88VGhvffACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE890779A7;
	Tue,  9 Jun 2026 06:51:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ouOvNPW3J2oeeQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jun 2026 06:51:33 +0000
Message-ID: <f5d8e307-83e6-48e1-bba6-4d9f88d5fa7f@suse.de>
Date: Tue, 9 Jun 2026 08:51:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: reject short AUTH_RECEIVE buffers
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260606181306.1651139-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260606181306.1651139-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3221B6A7E7
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lst.de,grimberg.me,nvidia.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/6/26 20:13, Michael Bommarito wrote:
> nvmet_execute_auth_receive() trusts the AUTH_RECEIVE allocation length
> after checking only that it is nonzero and matches the transfer length.
> In SUCCESS1 and FAILURE1/default states, that lets a remote NVMe-oF
> initiator reach fixed-size DHCHAP response builders with a kmalloc()
> buffer shorter than the response, so the builder writes past the
> allocation.
> 
> Reject AUTH_RECEIVE commands whose allocation length is shorter than the
> response for the current state before allocating the buffer. Keep the
> existing CHALLENGE variable-length guard in nvmet_auth_challenge().
> 
> This is the AUTH_RECEIVE response-write counterpart to the separately
> posted AUTH_SEND read-side bounds fix in nvmet_auth_reply() [1]; the two
> paths do not overlap.
> 
> Link: https://lore.kernel.org/all/f4aca9b14e74a7f7f8cd9620e13cc32a6a2b7746@linux.dev/ [1]
> Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> A temporary KUnit harness, not included in this patch, ran under UML
> with KASAN enabled. The stock run crashed in
> nvmet_execute_auth_receive() on the SUCCESS1 path with "memset:
> detected buffer overflow: 16 byte write of buffer size 1"; the patched
> run passed the same harness. The harness source is available on
> request.
> 
>   drivers/nvme/target/fabrics-cmd-auth.c | 27 ++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index f1e613e7c63e5..77c7b412a8691 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -487,11 +487,30 @@ u32 nvmet_auth_receive_data_len(struct nvmet_req *req)
>   	return le32_to_cpu(req->cmd->auth_receive.al);
>   }
>   
> +static u32 nvmet_auth_receive_min_len(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	u32 hash_len = 0;
> +
> +	switch (req->sq->dhchap_step) {
> +	case NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE:
> +		return 0;
> +	case NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1:
> +		if (req->sq->dhchap_c2)
> +			hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
> +
> +		return sizeof(struct nvmf_auth_dhchap_success1_data) + hash_len;
> +	default:
> +		return sizeof(struct nvmf_auth_dhchap_failure_data);
> +	}
> +}
> +
>   void nvmet_execute_auth_receive(struct nvmet_req *req)
>   {
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>   	void *d;
>   	u32 al;
> +	u32 min_len;
>   	u16 status = 0;
>   
>   	if (req->cmd->auth_receive.secp != NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER) {
> @@ -524,6 +543,14 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>   		return;
>   	}
>   
> +	min_len = nvmet_auth_receive_min_len(req);
> +	if (al < min_len) {
> +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +		req->error_loc =
> +			offsetof(struct nvmf_auth_receive_command, al);
> +		goto done;
> +	}
> +
>   	d = kmalloc(al, GFP_KERNEL);
>   	if (!d) {
>   		status = NVME_SC_INTERNAL;

Please move this check into nvmet_auth_receive_data_len().

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
