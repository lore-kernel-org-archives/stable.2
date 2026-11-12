Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486227;
	b=QinqlNwyQ/I8W2GJ9TvpOvNOOiD2zBBp8ZBmYPB8Bc5q5N5r/7AULvn32D9pr1v/6d5t
	 cQVNfS0wgU6vycxCPAPtqN35U2UwqMweA4vXENalM7izgnLp8t5ra8wS2zXNyvEnUCRbV
	 a8So+cFiAK+1sS5a0Iv2Wl0otau4h6+8YUYIjl9XVb9kVW2vJJApo5caV7vClKVSkDg6L
	 HIwl8tV5ck8Az0GQVqjI0Aos9w4y0HzBG0rfIJ6plhMlQjEBwLZkaiUwdOXwRfaIXEjFU
	 AC7KWH81LyQSfuR+zYXujIzmDOs5B+Qp20T6gfEqr1hrfTdUEnizOrIoqjuHY/6hs+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486227;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=aWg2g10tjTV9nIbKRh3Ck09drDxqIeEIHJCcrhiowKw=;
	b=rziOkgtR7On8Qktb6Fbax7pPEjtSkvSh7xeNmbY+Z+Y8xFhvz7mDltTjBvQp7a0bd5pw
	 pIgxNX4jdf4R3nDf00e91cLh7qa38IV3U1QcVjTN4iQNsXov7vO9WrYSoOxhhRO++4s35
	 Jaw4eaWjfjNPRDCicC1u575bQ6O0A1QIJvOtG4ZcCHN5Z+7Yn8+Er4zdWWqO4Kcyp25Rb
	 UAbWn+PGOHibDZAlmuCzeP5ARkrJeCjjkJtbP2vpFVseDt4dLp8rHiQJn7vrI2uS/FJVy
	 uOR1tx/4miq0LIVyNwR8y+rcYUsv6MAbSSQKXmkTVYeTIsSV11SInosfAiigI59GMKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vrqPUGAU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PrAvXBEc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vrqPUGAU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PrAvXBEc;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69947606A31C;
	Thu, 12 Nov 2026 12:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69947606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vrqPUGAU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PrAvXBEc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vrqPUGAU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PrAvXBEc
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1E7321E5D;
	Thu, 12 Nov 2026 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWg2g10tjTV9nIbKRh3Ck09drDxqIeEIHJCcrhiowKw=;
	b=vrqPUGAUS6KF2aJMvD+MUc2mWiUtdMZacNMISidJi40Q+CzWQ1oopwQLcnhHLkKdqWPqfB
	j512ispzHI9aKloDq9HwYMMtT+eEIBXiZ9HjWoAbKou88fYAdImVeKweAu1I8ofnmXPm0O
	2O1YsyoY16bMEwd9dgqYsGKdilH1ATw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWg2g10tjTV9nIbKRh3Ck09drDxqIeEIHJCcrhiowKw=;
	b=PrAvXBEccmylGlU9Kh5xIg8EBVXthgD+QA3n4XO6ILjyrl2AnZ6sqGMB2GUVUsMRqj/Tmx
	NX9rp3aZwVMl1aDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWg2g10tjTV9nIbKRh3Ck09drDxqIeEIHJCcrhiowKw=;
	b=vrqPUGAUS6KF2aJMvD+MUc2mWiUtdMZacNMISidJi40Q+CzWQ1oopwQLcnhHLkKdqWPqfB
	j512ispzHI9aKloDq9HwYMMtT+eEIBXiZ9HjWoAbKou88fYAdImVeKweAu1I8ofnmXPm0O
	2O1YsyoY16bMEwd9dgqYsGKdilH1ATw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWg2g10tjTV9nIbKRh3Ck09drDxqIeEIHJCcrhiowKw=;
	b=PrAvXBEccmylGlU9Kh5xIg8EBVXthgD+QA3n4XO6ILjyrl2AnZ6sqGMB2GUVUsMRqj/Tmx
	NX9rp3aZwVMl1aDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BE1213432;
	Thu, 12 Nov 2026 12:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eKxzFcqv9Wp1PgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 12 Nov 2026 12:23:38 +0000
Message-ID: <5a9623f9-48da-4aa2-9dcd-f7bac76d5911@suse.de>
Date: Thu, 12 Nov 2026 13:23:38 +0100
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
Subject: Re: [PATCH v2 1/3] nvme-tcp: use an aligned buffer for the TLS record
 type
To: martin.nvme.dev@gmail.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
 <20261111-nvme-tcp-live-ctrlrec-v2-1-6295202b84de@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261111-nvme-tcp-live-ctrlrec-v2-1-6295202b84de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.79
X-Spam-Level: 
X-Spam-Flag: NO

On 11/11/26 9:42 PM, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> The buffers that receive the TLS record type are char arrays.
> put_cmsg() and tls_get_record_type() access them as struct cmsghdr,
> which needs a stricter alignment than a char array has.
> 
> Use a union with struct cmsghdr, sized with CMSG_SPACE(), as
> svc_tcp_recv_cmsg() and xs_tls_read_record() in sunrpc do.
> 
> Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
