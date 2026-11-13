Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556240;
	b=YG/ocWvU86aXv0b8+Qvn21SPh5baFwKR9kTdpyGDe4kIk7q+i9x+7Vx8pZ20kV9ohDeg
	 VJqNs04hcSEc4TljFCqba/CS9OyQ8+33wUXCMldmAWnVba758wPWRUbuepKkVnc+GjCV3
	 csq+js16CBrySfeQKApdZk7sguHQQJ0Wk1slKcj/C270zJJqu+d4ryHwBNOxBNsn9Ak+P
	 UTneZh3NMAAVNgJKtI+xC5e0FoHMnrc4w/FkhU3/MDpU0scL4+GNgluPFicL2XICsVU8z
	 KQJyTorScXBnSnqOF7eCsqxK5L+QWxoFF+KgbEgK5HjptQ6zW6R6PQ0a0JHRU35qlcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556240;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=b71x4uZul/6b+3X6jLqjB42CxacMpuPRIUrtp5H8w/A=;
	b=oIXJ50gc5GC+dZuwEgiVsBotFp0bwmxtr3KLOJqQ9oUp6bVLSZ0JdrZc1VUlm6ob62h3
	 s8l6kwaJeyuTTwZwUEYVQOg90DQ4SGL0FWk3o+KXDoJwlvbFeBqHbLQNKeyUtEQ5p+8z/
	 MmSnBW378ZHwYWA4d40TfpjZn5uuWcISeZDmBOQ8pEyy8rC/KFBgmHhhYK7XvClWacSv2
	 lSm//fFy4jB5ELtHeEtnZsa7ST8+rde1th+3oJqx5d1gml637bqLkkhMr5vGhYJtRotKJ
	 5YD2XBRMKKar+roTv11hRY82v5y+kyBu4EXyvislxNYQXWqMu9ea82y+j+q5wWLhb1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xkqr1Qf7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=++VuCi8t;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xkqr1Qf7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=++VuCi8t;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6E606A31C;
	Fri, 13 Nov 2026 07:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E6E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xkqr1Qf7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=++VuCi8t;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xkqr1Qf7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=++VuCi8t
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 543DA1F7C4;
	Fri, 13 Nov 2026 07:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794556238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b71x4uZul/6b+3X6jLqjB42CxacMpuPRIUrtp5H8w/A=;
	b=xkqr1Qf7BocL1yDK529ZLgijmaviG94/Nq3VzRRiGVCFB74YlSHzKOH1J3Vf5AID1uwPRY
	aNER5hoDYq3tBFDgcnG0BC44xYFgSxedal9H1pMuZ5vbx6YObRJjk/6y8gxvlTTZsXK6lB
	GDSAovZWnJMTW6IgX60tO7NaotaYA0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794556238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b71x4uZul/6b+3X6jLqjB42CxacMpuPRIUrtp5H8w/A=;
	b=++VuCi8t9zj9I3gXaCvV1+87YxIKuicC5x7LQmKu9z9VhU7I1a8gUc88MHu1ibzYKACP+X
	rC04V0/tsRYMpzBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794556238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b71x4uZul/6b+3X6jLqjB42CxacMpuPRIUrtp5H8w/A=;
	b=xkqr1Qf7BocL1yDK529ZLgijmaviG94/Nq3VzRRiGVCFB74YlSHzKOH1J3Vf5AID1uwPRY
	aNER5hoDYq3tBFDgcnG0BC44xYFgSxedal9H1pMuZ5vbx6YObRJjk/6y8gxvlTTZsXK6lB
	GDSAovZWnJMTW6IgX60tO7NaotaYA0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794556238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b71x4uZul/6b+3X6jLqjB42CxacMpuPRIUrtp5H8w/A=;
	b=++VuCi8t9zj9I3gXaCvV1+87YxIKuicC5x7LQmKu9z9VhU7I1a8gUc88MHu1ibzYKACP+X
	rC04V0/tsRYMpzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6F481344A;
	Fri, 13 Nov 2026 07:50:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4EARKk3B9moIWgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 13 Nov 2026 07:50:37 +0000
Message-ID: <4ece1bef-cb4d-4a84-a2e0-bd3e3cf1e229@suse.de>
Date: Fri, 13 Nov 2026 08:50:37 +0100
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
Subject: Re: [PATCH v3 3/3] nvme-tcp: consume TLS records without application
 data
To: martin.nvme.dev@gmail.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
References: <20261112-nvme-tcp-live-ctrlrec-v3-0-49760bd9eaa8@gmail.com>
 <20261112-nvme-tcp-live-ctrlrec-v3-3-49760bd9eaa8@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261112-nvme-tcp-live-ctrlrec-v3-3-49760bd9eaa8@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -11.79
X-Spam-Level: 
X-Spam-Flag: NO

On 11/12/26 10:13 PM, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> A peer may send a TLS record without application data at any time
> after the handshake: a NewSessionTicket, a KeyUpdate or an alert.
> tls_sw_read_sock() cannot pass such a record to nvme_tcp_recv_skb().
> It returns -EINVAL and leaves the record at the head of the receive
> queue. nvme_tcp_try_recv() then starts error recovery, and the
> controller reconnects.
> 
> TLS 1.3 allows a server to send a NewSessionTicket at any time after
> the handshake (RFC 8446, section 4.6.1). Alerts can also arrive at any
> time.
> 
> On -EINVAL, read the record with recvmsg(), which reports the record
> type. Discard handshake messages other than KeyUpdate. Log alerts, and
> fail the queue on a fatal alert. Fail the queue on a KeyUpdate, which
> nvme-tcp cannot answer, and on any other record type. recvmsg() takes
> the socket lock, so release it around the read.
> 
> Handle these records in one helper, also for the records that arrive
> ahead of the ICResp. A warning alert ahead of the ICResp no longer fails
> the connection.
> 
> On a poll queue, nvme_tcp_poll() and nvme_tcp_io_work() can both see
> the record while the socket lock is released. A queue flag makes sure
> that only one of them reads it.
> 
> svc_tcp_recvfrom() in sunrpc handles -EINVAL from read_sock() the same
> way.
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 113 +++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 97 insertions(+), 16 deletions(-)
> 
Far better.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
