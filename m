Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486323;
	b=Lg9jCzTcsn3k/BiL8KZmvErjWlap7EY+G43TCb9EklbduuwUHuJwbhQ5TQ1MU0J27coy
	 kqAsEXE02786osFrwvryg1Z9Y+QNOGiSvDfwtu9lnY2e3LlaW7v0FNFuAX5biiqMbjZzh
	 sjVpQek16faIMRtK9khZWL4QM2w/ZhREjbOQkAJE+3za761Qo6fg19CyWuY5jQDZ+TdNc
	 2f1/ydmAcg7zC6EOQ8WbkLeF66srr32ZyJJPfoxKcHTQKqyX4kRR6fGnbL5vS+R0usnEg
	 wW4tYcyvQUqDsjw08uo3PntlKyQOPNNMfTqmtCva3qN3WQCRMbiiA7niibFQcl9vnUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486323;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=aqcyP1dXYi9gDE41XYmdJNC4CQxinWLLJ2ag0eWhu/A=;
	b=pAF9Kk7K0PEbwOLSdLYiL5mAbWAejg0Mo1zQPUvGe2/hsiKwUDt+Ri+mfo7gmabzwsGh
	 rZ58o5+F9nkh0ghfg4vJ7wDB48Z+aAZCGWZW2UYDeU//tPTcNt2l+/OTRpQrhqrNvHW/c
	 cfjPiBJPpbqzpWhCRy98hoR4k55m+MTJB4Eg0M09WS84+JRZ/xx/z88TzGQPqoaGVfmJX
	 PmzCAQ79a9G8M9dUSlIqhX9ndkfQ3A3CoWmca3O7PJ/RsC0gwA79XJxoQP1mnt/ehoKXQ
	 tuRZP+S1RzFhL55lMojDgXfe6DaFOvm/useHnkXHrXb7mqLLYx3ky5NLERZj2xj4Ucg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VqR22yqK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TmadDybq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VqR22yqK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TmadDybq;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B2606A31C;
	Thu, 12 Nov 2026 12:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E3B2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VqR22yqK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TmadDybq;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VqR22yqK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TmadDybq
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 839F021E6E;
	Thu, 12 Nov 2026 12:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqcyP1dXYi9gDE41XYmdJNC4CQxinWLLJ2ag0eWhu/A=;
	b=VqR22yqKDevMvzXOf9iTjjFDJtsCUG9O11Ph1tfN5IhqX6NmdslxBUroIhMcXDwb4B0EvA
	xhL0CH35eyTJRbo4nzMCspBO9pU93Yeh3KT8RuTIACFV3pY4dQjR6lZS55jYYEVq+epxBu
	zJKWfy6qN594I2wJrXkcKxxrWMKFkNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486320;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqcyP1dXYi9gDE41XYmdJNC4CQxinWLLJ2ag0eWhu/A=;
	b=TmadDybqb6heupZ7Jsji2Z0xSsv6JSN2WhkG4vzHWLui0z/AjPj/w2PAnnl4MhlVKbpBYV
	fMfK4gGzId1337Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VqR22yqK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TmadDybq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqcyP1dXYi9gDE41XYmdJNC4CQxinWLLJ2ag0eWhu/A=;
	b=VqR22yqKDevMvzXOf9iTjjFDJtsCUG9O11Ph1tfN5IhqX6NmdslxBUroIhMcXDwb4B0EvA
	xhL0CH35eyTJRbo4nzMCspBO9pU93Yeh3KT8RuTIACFV3pY4dQjR6lZS55jYYEVq+epxBu
	zJKWfy6qN594I2wJrXkcKxxrWMKFkNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486320;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqcyP1dXYi9gDE41XYmdJNC4CQxinWLLJ2ag0eWhu/A=;
	b=TmadDybqb6heupZ7Jsji2Z0xSsv6JSN2WhkG4vzHWLui0z/AjPj/w2PAnnl4MhlVKbpBYV
	fMfK4gGzId1337Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FD4C134F4;
	Thu, 12 Nov 2026 12:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DyX3My+w9Wp/QAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 12 Nov 2026 12:25:20 +0000
Message-ID: <5319a2ac-a65c-4ca9-bba4-9fef0a9b4893@suse.de>
Date: Thu, 12 Nov 2026 13:25:19 +0100
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
Subject: Re: [PATCH v2 2/3] nvme-tcp: move the TLS record read loop into a
 helper
To: martin.nvme.dev@gmail.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
 <20261111-nvme-tcp-live-ctrlrec-v2-2-6295202b84de@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261111-nvme-tcp-live-ctrlrec-v2-2-6295202b84de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 839F021E6E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.00

On 11/11/26 9:42 PM, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> Move the read loop out of nvme_tcp_skip_tls_record() into a new
> helper, nvme_tcp_drain_tls_record(). The next patch uses the helper
> to read TLS records that arrive on a live queue.
> 
> No functional change.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 60 +++++++++++++++++++++++++++++++------------------
>   1 file changed, 38 insertions(+), 22 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
