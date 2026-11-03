Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691329;
	b=DeFxObznr4O7YlSh8jjY83DUxcJU/UJExuoNlT7auX8umxfGW5yCHaFo/dHpkPCKRP50
	 zYDDwQlDEsqaltCKDOUrwdVucz8p4nxf1sxpzGYYeA5nZl2SJgAJMr2wsZzvEHTFuAQKx
	 xp9oYWBx6wjanKycsKFWYC0a/2cQeY88DNaZjOD9GzQEMTawm61dQP4e6xUUEl7SK2jLg
	 TBnY7iu+355OysEiTYNZivPtm0EQ2Uy0Ywv+okJX6F2VAY0l4UVuSk9HGiZHPBSrS98FL
	 JYe8aurjV/OmlZ1WmX24STCWULXGW+DKgvc5vDpOZeaZuEH6lcNadM7OhSOrrJXGlyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691329;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=uVfbMmvBz7pvBTdrjpzcHYT3zLJmw9EbDDH1lVuVOEg=;
	b=iRt0svN26NrO696QlnktXCQZqZfIczBq/t1MQQq02FCLrt2CxBay7JGk5kdVMxZz8T0q
	 00VQ1CgspWs06lSCoWDPTvsKBgmNVFtBehPN68TfD41u2x34NNTp2zKeUGm7DKZQFD65z
	 0uq9coKNpPZfxQ5I/qxR6Eex+iIznmKBVYrg/oIJzE1d1yBJtCLn/KOTrZa5VoXY1P8A3
	 UGHqEMjLzm2cANw6ELh1dc1uEL+KjRsU8ECf9fRG4AvdtKPw6zA2QlXAAXNVy4Y8v76MW
	 clA9398p6Oqw4XdolYvosKF06uma3vEV854342c62nLkxRVDrM94pPGOYjPETBaEgIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zSxcL1io;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UTQ9roF2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zSxcL1io;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UTQ9roF2;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5F606A324;
	Tue,  3 Nov 2026 07:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDA5F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zSxcL1io;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UTQ9roF2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zSxcL1io;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UTQ9roF2
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01CDF21FC7;
	Tue,  3 Nov 2026 07:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793691327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVfbMmvBz7pvBTdrjpzcHYT3zLJmw9EbDDH1lVuVOEg=;
	b=zSxcL1iojpUe5ZdrCvindIxiwo/ggMbXdgrcbF+2k/LAwGM8B5guAJFzxbgFBvVUsK9OkT
	pqg5MtjCwVB2LJpACi+phHN7vbCBpJII8HZ87xlUXeS6UIs+G1hhbNMBy4QQLfNPDO72sg
	PSk5glhRTYob+yO+BGrG/6m+BdERxtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793691327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVfbMmvBz7pvBTdrjpzcHYT3zLJmw9EbDDH1lVuVOEg=;
	b=UTQ9roF2y2PxQUzcLRcfNIJ46shaQXncRJkXD6xBaEMB9mKI0Md0WAB9ZlSEf5e02WQfMP
	Daj8jnVUlpAkDKCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zSxcL1io;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UTQ9roF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793691327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVfbMmvBz7pvBTdrjpzcHYT3zLJmw9EbDDH1lVuVOEg=;
	b=zSxcL1iojpUe5ZdrCvindIxiwo/ggMbXdgrcbF+2k/LAwGM8B5guAJFzxbgFBvVUsK9OkT
	pqg5MtjCwVB2LJpACi+phHN7vbCBpJII8HZ87xlUXeS6UIs+G1hhbNMBy4QQLfNPDO72sg
	PSk5glhRTYob+yO+BGrG/6m+BdERxtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793691327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVfbMmvBz7pvBTdrjpzcHYT3zLJmw9EbDDH1lVuVOEg=;
	b=UTQ9roF2y2PxQUzcLRcfNIJ46shaQXncRJkXD6xBaEMB9mKI0Md0WAB9ZlSEf5e02WQfMP
	Daj8jnVUlpAkDKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AA3D134B8;
	Tue,  3 Nov 2026 07:35:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2WcBHr6O6WoaUQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Nov 2026 07:35:26 +0000
Message-ID: <311b1a91-24b0-4864-91c1-6801ca558e2b@suse.de>
Date: Tue, 3 Nov 2026 08:35:26 +0100
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
Subject: Re: [PATCH v2] nvmet-auth: reject incomplete DHCHAP messages
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261102132419.2306396-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01CDF21FC7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50

On 11/2/26 2:24 PM, Jérémy Jean wrote:
> Commit c9359401036e ("nvmet-auth: reject undersized AUTH_SEND
> payloads") only ensures that AUTH_SEND has auth_type and auth_id
> before nvmet_execute_auth_send() starts parsing the payload, but the
> DHCHAP path reads t_id before it verifies message lengths. A two-byte
> DHCHAP NEGOTIATE payload can therefore still trigger an OOB read that
> KASAN reports as:
> 
>    BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_send
>    Read of size 2 at addr ffff8880030d8364
> 
> Require the payload to cover the minimum DHCHAP message length
> before parsing it.
> 
> Fixes: c9359401036e ("nvmet-auth: reject undersized AUTH_SEND payloads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
> 
> Changes in v2:
> - Check the minimum DHCHAP message length.
> 
> v1 (2026-08-11 18:03:35 +0000): https://lore.kernel.org/all/20260811180335.4161138-2-Jeremy.Jean@oss.cyber.gouv.fr/
> 
>   drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 70136f6c22e8..a15f21fc41e4 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -301,7 +301,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>   		nvmet_check_transfer_len(req, tl);
>   		return;
>   	}
> -	if (tl < offsetof(struct nvmf_auth_dhchap_success2_data, rsvd1)) {
> +	if (tl < sizeof(struct nvmf_auth_dhchap_failure_data)) {
>   		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>   		req->error_loc =
>   			offsetof(struct nvmf_auth_send_command, tl);
> 

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
