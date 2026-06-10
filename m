Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EFD3822A1
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075397; cv=none; b=iu1pzvKLB23Ha8aqRf4m5rzGxvL2loIunVRfw+r8eIkEE5JNAH5Kf47mW4GYT+d9lAwu62WJiqeg2YFp7WWf8olivbJkwBqZsr9kuUZ/i2Qk7/yEaq+P8TV57N9tVEPAXIHKQo1W2tbIbvOxjUyg8jmtdAftCffc9Gq98CDcqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075397; c=relaxed/simple;
	bh=mstHHZwmjZd/ScLrBFYUPongcW2KazuRaDi5NaXoAhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HqgkK3TPE2jX28yAavEV739JPOkaTUr+z5xWCVDDn3lbJRMc3U/bhJS6H/4eJiQdnjF1M5TJEw+97c/9OPlPUSsl0N212A8M78OimCdOF3NM8PUORVVye8jRUL9CMyhQydnDIcXqcsZ0HL6C1wOrrasDI9luSLkpG2480Z4Qdb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jg3f7og/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MJV5TbKa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jg3f7og/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MJV5TbKa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jg3f7og/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MJV5TbKa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jg3f7og/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MJV5TbKa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 081246A825;
	Wed, 10 Jun 2026 07:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781075394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMNe8fyVI2o7r/9cPWkfG5tsOo+jfT7QtdGfmzZl3bw=;
	b=Jg3f7og/95kF+0birZGlaJojAcnOgtXvDe5z2yJGH8J77lRbRaWHTRAWpieDNsGPWfcvaZ
	vQvmq1zt16kOUPhcQtLsxvaYHe/au4y2FboNGDBxJU8lMGKJNbrEduYiDkGv4BODtcxlF9
	iHcn1sdJfq53ytQ53FRmhTyQ3B+PoAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781075394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMNe8fyVI2o7r/9cPWkfG5tsOo+jfT7QtdGfmzZl3bw=;
	b=MJV5TbKa3xSKUIhb1z7hHyS13WZiYlgUyTI4HFW2LUUGkicl6GIW49G5A9gz0stYW++OCk
	KIvDfC6s0DtvW3Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Jg3f7og/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MJV5TbKa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781075394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMNe8fyVI2o7r/9cPWkfG5tsOo+jfT7QtdGfmzZl3bw=;
	b=Jg3f7og/95kF+0birZGlaJojAcnOgtXvDe5z2yJGH8J77lRbRaWHTRAWpieDNsGPWfcvaZ
	vQvmq1zt16kOUPhcQtLsxvaYHe/au4y2FboNGDBxJU8lMGKJNbrEduYiDkGv4BODtcxlF9
	iHcn1sdJfq53ytQ53FRmhTyQ3B+PoAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781075394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMNe8fyVI2o7r/9cPWkfG5tsOo+jfT7QtdGfmzZl3bw=;
	b=MJV5TbKa3xSKUIhb1z7hHyS13WZiYlgUyTI4HFW2LUUGkicl6GIW49G5A9gz0stYW++OCk
	KIvDfC6s0DtvW3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE3F4779AA;
	Wed, 10 Jun 2026 07:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uYs9LcENKWrBMQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Jun 2026 07:09:53 +0000
Message-ID: <eeef8a54-ca94-46f5-aae5-2d9933dbf922@suse.de>
Date: Wed, 10 Jun 2026 09:09:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-auth: reject short AUTH_RECEIVE buffers
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260609182431.2437882-1-michael.bommarito@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260609182431.2437882-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lst.de,grimberg.me,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 081246A825
X-Spam-Score: -3.01

On 6/9/26 20:24, Michael Bommarito wrote:
> nvmet_execute_auth_receive() trusts the AUTH_RECEIVE allocation length
> after checking only that it is nonzero and matches the transfer length.
> In the SUCCESS1 and FAILURE1/default states, that lets a remote NVMe-oF
> initiator reach the fixed-size DH-HMAC-CHAP response builders with a
> kmalloc() buffer shorter than the response, so nvmet_auth_success1() and
> nvmet_auth_failure1() write past the allocation; both only WARN_ON the
> short length and then format the message anyway.
> 
> Impact: A remote NVMe-oF initiator with access to an auth-enabled target
> can trigger a 16-byte heap out-of-bounds write via a one-byte
> AUTH_RECEIVE allocation length.
> 
> Compute the minimum response length for the current DH-HMAC-CHAP step in
> nvmet_auth_receive_data_len() and report a zero data length when the
> host-supplied allocation length is shorter, so the existing zero-length
> check in nvmet_execute_auth_receive() rejects the command before any
> builder runs. The SUCCESS1 minimum is sizeof(struct
> nvmf_auth_dhchap_success1_data) plus the HMAC hash length, because the
> response hash is written into the rval[] flexible-array tail, so the
> minimum is state dependent rather than a flat sizeof. CHALLENGE keeps its
> existing variable-length guard in nvmet_auth_challenge().
> 
> This is reachable only when in-band DH-HMAC-CHAP authentication is
> configured on the target.
> 
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5-5-xhigh
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2:
>    - Move the length check into nvmet_auth_receive_data_len() and reject
>      via the existing zero-length guard in nvmet_execute_auth_receive(),
>      per Hannes Reinecke's review. No separate helper, and
>      nvmet_execute_auth_receive() itself is unchanged.
> 
> With CONFIG_FORTIFY_SOURCE and KASAN enabled, a short al (for example
> al=1) on the SUCCESS1 path aborts in the sizeof(*data)=16 header memset
> in nvmet_auth_success1() with "memset: detected buffer overflow: 16 byte
> write of buffer size 1". After this change the same input is rejected
> before allocation and the abort no longer occurs. Validated with a
> KUnit/KASAN harness under UML: the stock kernel crashed and the patched
> kernel passed; the in-tree nvme-auth KUnit suite still passes.
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
