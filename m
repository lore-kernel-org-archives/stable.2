Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486750;
	b=aJYb8mgBGxEb8103GnfhMf7NVofUWIaRnRVlBYXOTZ/Y1fPH5AC93jzHkKBU5HTBvrEg
	 YutRAozQiVV0MiaDXcwJSif6KSfINgJoTffo2ZoZ1QTyObtMtWddETfOXvdj14R7ft3K0
	 rOgD3xesZYRvw3NvsmeXBcv+aGXlzLOND6zM3bf2+RzmU6IdxJgjiH3rPUU/9AgPb9zaS
	 UlyF8H4r74fNOe6bOwkRp9/L7ogh+gdZkJNK4qC+HEEIwDCxBeWbhuF5L+513kFuJBfa6
	 RXXY+81qZ+0fCMhoS2f/tyFYcYJLWzK+XotkVBMoNJtQD7k3v285ior6UOc3OHV4Mcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486750;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=VrzCEXTItTgWU3isMMl++QttF+TZDkdN61/UdJRYkJ0=;
	b=ogHAgDHB170he0Bfyddgw+Si+UIGUpk832YVUhEcMqJ7iFulEWoC6HYujkAXKDpAkkPe
	 064Ks/PoCZJXqriCp8EpbLUeGItKajattor8BQdr3MfweakZArQnXez6aDw2A5g/1Cz8n
	 3t/5zIeyyosRupGjZi/DOF3u9CXwupQrIBcy95DBiWVNO5w5U+tHWCIFHuYU29XhmSWrp
	 8xyORJkPHNI9UiarTNm3AJo/Bhh0PPRKeGD7AswYsDum8VeONKbO35pCsVW0ElKPIfP4l
	 5OpcvJVJimd8jMqWk2YjRkgu+QBMfo5dlHvaUGr0+BKQTZqXQtOJZlr/mnMht3g89CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2O0DXevg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gXxrNEgl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2O0DXevg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gXxrNEgl;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D3606A321;
	Thu, 12 Nov 2026 12:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B1D3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2O0DXevg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gXxrNEgl;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2O0DXevg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gXxrNEgl
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DC7021E77;
	Thu, 12 Nov 2026 12:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzCEXTItTgWU3isMMl++QttF+TZDkdN61/UdJRYkJ0=;
	b=2O0DXevgyuu/jUp2+yew4muEA5AQKrGz8ZgkZUqPSXdKFq5Jz0W3ld2Ovg00Dur5r1Edja
	uXl/PlzMsxsruDYFvCLgtRoC2a6nE6z2Luym7bVnjeebUYLSy+/xaFLoEP8RJ5p74TpwyC
	9c9GMJ/We10WnQb3wl9cXeAMCVHXLXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzCEXTItTgWU3isMMl++QttF+TZDkdN61/UdJRYkJ0=;
	b=gXxrNEglvE6pCoMrIGfLl4HfT/gCxHBBqh7FW6gs/emGOLtb0jUqpNPJViQ5AQ5ey+sRX6
	c1nq73aUswFwDUCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2O0DXevg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gXxrNEgl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794486747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzCEXTItTgWU3isMMl++QttF+TZDkdN61/UdJRYkJ0=;
	b=2O0DXevgyuu/jUp2+yew4muEA5AQKrGz8ZgkZUqPSXdKFq5Jz0W3ld2Ovg00Dur5r1Edja
	uXl/PlzMsxsruDYFvCLgtRoC2a6nE6z2Luym7bVnjeebUYLSy+/xaFLoEP8RJ5p74TpwyC
	9c9GMJ/We10WnQb3wl9cXeAMCVHXLXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794486747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzCEXTItTgWU3isMMl++QttF+TZDkdN61/UdJRYkJ0=;
	b=gXxrNEglvE6pCoMrIGfLl4HfT/gCxHBBqh7FW6gs/emGOLtb0jUqpNPJViQ5AQ5ey+sRX6
	c1nq73aUswFwDUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 068C213432;
	Thu, 12 Nov 2026 12:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YfV7NNqx9WqjRwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 12 Nov 2026 12:32:27 +0000
Message-ID: <8f7656ef-2730-484b-98cd-701616ef1a8f@suse.de>
Date: Thu, 12 Nov 2026 13:32:26 +0100
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
Subject: Re: [PATCH v2 3/3] nvme-tcp: consume TLS records without application
 data
To: martin.nvme.dev@gmail.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
 <20261111-nvme-tcp-live-ctrlrec-v2-3-6295202b84de@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261111-nvme-tcp-live-ctrlrec-v2-3-6295202b84de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4DC7021E77
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -12.00

On 11/11/26 9:42 PM, Martin Belanger via B4 Relay wrote:
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
>   drivers/nvme/host/tcp.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index c3bf345c4e92..cc6a46f118b2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -123,6 +123,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_IO_CPU_SET	= 3,
> +	NVME_TCP_Q_TLS_RECORD	= 4,
>   };
>   
>   #define NVME_TCP_OPT_NR_QUEUES(opts) ((opts)->nr_io_queues + \
> @@ -1450,6 +1451,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   	return ret;
>   }
>   
> +static int nvme_tcp_recv_tls_record(struct nvme_tcp_queue *queue);
> +
>   static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   {
>   	struct socket *sock = queue->sock;
> @@ -1462,10 +1465,31 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   	lock_sock(sk);
>   	queue->nr_cqe = 0;
>   	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
> +	/*
> +	 * kTLS cannot pass a TLS record without application data to
> +	 * nvme_tcp_recv_skb(). It returns -EINVAL and leaves the record at
> +	 * the head of the receive queue. recvmsg() takes the socket lock,
> +	 * so read the record without it.
> +	 */
> +	if (unlikely(consumed == -EINVAL && nvme_tcp_queue_tls(queue) &&
> +		     queue->rd_enabled)) {
> +		/*
> +		 * On a poll queue, nvme_tcp_poll() and nvme_tcp_io_work() can
> +		 * both get here for the same record. Only one of them reads it.
> +		 */
> +		if (test_and_set_bit(NVME_TCP_Q_TLS_RECORD, &queue->flags)) {
> +			consumed = 0;
> +		} else {
> +			release_sock(sk);
> +			consumed = nvme_tcp_recv_tls_record(queue);
> +			lock_sock(sk);
> +			clear_bit(NVME_TCP_Q_TLS_RECORD, &queue->flags);
> +		}
> +	}
>   	/*
>   	 * nvme_tcp_recv_skb() handles its own errors, so a queue that is
> -	 * still enabled failed inside read_sock(). Handle it before
> -	 * release_sock() processes the backlog.
> +	 * still enabled failed inside read_sock() or while reading a TLS
> +	 * record. Handle it before release_sock() processes the backlog.
>   	 */
>   	if (unlikely(consumed < 0 && consumed != -EAGAIN &&
>   		     queue->rd_enabled)) {
> @@ -1665,6 +1689,74 @@ static int nvme_tcp_drain_tls_record(struct nvme_tcp_queue *queue,
>   	return drained;
>   }
>   
> +/*
> + * Read the TLS record that read_sock() could not pass to
> + * nvme_tcp_recv_skb(). The caller must not hold the socket lock.
> + *
> + * A KeyUpdate needs new keys that nothing here can supply. Other handshake
> + * messages, such as a NewSessionTicket, are discarded.
> + *
> + * Returns the bytes consumed, or a negative errno if the connection cannot
> + * continue.
> + */
> +static int nvme_tcp_recv_tls_record(struct nvme_tcp_queue *queue)
> +{
> +	u8 buf[NVME_TCP_TLS_REC_CHUNK];
> +	union nvme_tcp_tls_cmsg u = {};
> +	struct kvec iov = {
> +		.iov_base = buf,
> +		.iov_len = sizeof(buf),
> +	};
> +	struct msghdr msg = {
> +		.msg_control = &u,
> +		.msg_controllen = sizeof(u),
> +	};
> +	int len, ret;
> +	u8 ctype;
> +
> +	len = kernel_recvmsg(queue->sock, &msg, &iov, 1, sizeof(buf),
> +			     MSG_DONTWAIT);
> +	if (len <= 0)
> +		goto fail;
> +
> +	ctype = tls_get_record_type(queue->sock->sk, &u.cmsg);
> +	switch (ctype) {
> +	case TLS_RECORD_TYPE_HANDSHAKE:
> +		if (buf[0] == TLS_HANDSHAKE_KEYUPDATE) {
> +			dev_err(queue->ctrl->ctrl.device,
> +				"queue %d: peer sent a TLS KeyUpdate, which is not supported\n",

A bit awkward; maybe 'TLS KeyUpdate is not supported'?

> +				nvme_tcp_queue_id(queue));
> +			return -EKEYEXPIRED;
> +		}
> +		break;
> +	case TLS_RECORD_TYPE_ALERT:
> +		ret = nvme_tcp_recv_tls_alert(queue, &msg, len);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d: unexpected TLS record %u\n",
> +			nvme_tcp_queue_id(queue), ctype);
> +		return -EPROTO;
> +	}
> +
> +	ret = nvme_tcp_drain_tls_record(queue, &msg, MSG_DONTWAIT);

Hmm. Doesn't this assume that the KeyUpdate is always the first record?
And we do have similar logic in nvme_tcp_skip_tls_record(); can't we
merge both (ie just call nvme_tcp_drain_tls_record(), and drop
this switch statement?

> +	if (ret < 0) {
> +		len = ret;
> +		goto fail;
> +	}
> +
> +	return len + ret;
> +
> +fail:
> +	/* read_sock() left a whole record, so none of it can be missing */
> +	if (len == -EAGAIN)
> +		return -EPROTO;
> +
> +	return len ? : -ECONNRESET;
> +}
> +
>   /*
>    * Discard a TLS record that arrived in place of the ICResp. A peer may send
>    * a NewSessionTicket as soon as the handshake completes.
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
