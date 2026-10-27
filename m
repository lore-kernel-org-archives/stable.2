Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102287;
	b=GGY6WZkyxW4tZ/iP7z3V8qUOzCTtfGVb90g4MS2UXLi0lpTzMR8kjAMIZi/BG+G14ehr
	 MLSdYdICe9WQEwuHJwwYTlZtHbclNrl+eWYmJTC2+rAM+oaNVubLQmUW2vS+7P6E6CkQ7
	 vnMR4ElwtJd59cqstRb6EaKj1LUpkcApJ7OdHT8yzvlGIaKjMWmGrrb7cVgeWoHD0Q+QD
	 miV49PjE0vYEhMpwK3LRa0lrKHN98Kfhe1xlAVzYbLb0I1GDkI8yrYj02e3vtD/00tzdi
	 szumHRppKxmbYW89HMxbMho8C433q7r0P4eFvYK0PNTAL8fjZDdvzQ0KaZM8gmsgO0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102287;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=vNqRak6R0NOXOPwZ8K7M7qsowzZcmzyNUaJvV33gtt4=;
	b=T2sXjfqQQtU5RLTJyJAUQFXgT3YjNoiOyH8NJWMoTs62utWHCEvh5R3pNAlbAEDVzP0S
	 7Wgw8OUOOTyfHEDeUn1T5W1BfWwa3y7QeUpK0toM/PLeR5OggZLIMrqu8hiKqhxuf/kTD
	 /Z9hqJDC7CWIKIsa5AOmB0J34DDV6a9jdnxaCN+4WvA6oBKEGHVfdRsqVVLyz3di9elNn
	 tNUxJFNBhRd8CwvvFjRFjazSmoV2fbylc4K81LK8xXnDdxyOwgj2ct0GVIymr4p45G2iF
	 Zpg7xX2eVpiU2X5bE2CBsMmMpvuG0LQh8S3eXwMiDdmlFKReoZJ8laOCngpLNwXmsrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mKhmBA0t;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xV5guRrs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mKhmBA0t;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xV5guRrs;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515CA606A31A;
	Tue, 27 Oct 2026 11:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 515CA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mKhmBA0t;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xV5guRrs;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mKhmBA0t;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xV5guRrs
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CF8C21F22;
	Tue, 27 Oct 2026 11:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793102280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNqRak6R0NOXOPwZ8K7M7qsowzZcmzyNUaJvV33gtt4=;
	b=mKhmBA0tiWVXGtGZxRRdqM41EeWzPK1qlHp+yOdEuRezlkRrX3Ici82uja9Vu/A+8cEpzT
	MMbfDO6KL0jzikb4yhLRfbvrTsBFD/F/1RcWDJNxwGm4p3PgW4O/aVWI2UdypPzC7XoBgO
	Y2VhfaOgjMz4BzxsjSC01HdhIiydItc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793102280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNqRak6R0NOXOPwZ8K7M7qsowzZcmzyNUaJvV33gtt4=;
	b=xV5guRrsWz2oeB6vGqPBGdPzgA4V7DUGwNy/kAhe1NvG5KLbgMgxYB4cB8dUP5FOfKId1u
	KIzEcQ1vkC0magCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793102280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNqRak6R0NOXOPwZ8K7M7qsowzZcmzyNUaJvV33gtt4=;
	b=mKhmBA0tiWVXGtGZxRRdqM41EeWzPK1qlHp+yOdEuRezlkRrX3Ici82uja9Vu/A+8cEpzT
	MMbfDO6KL0jzikb4yhLRfbvrTsBFD/F/1RcWDJNxwGm4p3PgW4O/aVWI2UdypPzC7XoBgO
	Y2VhfaOgjMz4BzxsjSC01HdhIiydItc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793102280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNqRak6R0NOXOPwZ8K7M7qsowzZcmzyNUaJvV33gtt4=;
	b=xV5guRrsWz2oeB6vGqPBGdPzgA4V7DUGwNy/kAhe1NvG5KLbgMgxYB4cB8dUP5FOfKId1u
	KIzEcQ1vkC0magCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FDD41321C;
	Tue, 27 Oct 2026 11:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YZZIDMaR4GpOawAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 27 Oct 2026 11:57:58 +0000
Message-ID: <baffc5da-c794-4c78-ba9b-ec1a2dec0a9b@suse.de>
Date: Tue, 27 Oct 2026 12:56:47 +0100
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
Subject: Re: [PATCH net v2 5/5] net: restrict message_cost and message_burst
 to non-negative values
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Joel Granados <joel.granados@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Thomas Gleixner <tglx@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>,
 Gerd Rausch <gerd.rausch@oracle.com>,
 Zhan Xusheng <zhanxusheng1024@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng
 <bronzed_45_vested@icloud.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, Petr Mladek <pmladek@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261027104701.296240-1-jiayuan.chen@linux.dev>
 <20261027104701.296240-6-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261027104701.296240-6-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,infradead.org,nvidia.com,suse.com,google.com,ntu.edu.sg,oracle.com,gmail.com,nokia-bell-labs.com,icloud.com,stressinduktion.org];
	R_RATELIMIT(0.00)[to_ip_from(RLrr9ek4ud4f4qwi71m7motjzt)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-Spam-Flag: NO

On 10/27/26 11:45 AM, Jiayuan Chen wrote:
> net.core.message_cost and net.core.message_burst feed the interval and
> burst of net_ratelimit_state, but neither rejects negative values:
> message_burst uses plain proc_dointvec, and message_cost uses
> proc_dointvec_jiffies, which happily stores -1 second as -HZ jiffies.
> 
> Since commit a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are
> negative"), ___ratelimit() splats on such values, so the next
> net_ratelimit() caller warns, e.g. a martian source log:
> 
>    Negative interval (-250) or burst (10): Uninitialized ratelimit_state structure?
>    WARNING: lib/ratelimit.c:43 at ___ratelimit+0x56e/0x960, CPU#1: ping/3218
>    RIP: 0010:___ratelimit+0x578/0x960
>    Call Trace:
>     <IRQ>
>     net_ratelimit+0x1c/0x30
>     ip_handle_martian_source+0x1bb/0x340
>     ip_route_input_slow+0x1057/0x3650
>     ip_route_input_noref+0x104/0x260
>     arp_process+0x109b/0x2510
>     arp_rcv+0x381/0x460
>     __netif_receive_skb_one_core+0x173/0x1c0
>     __netif_receive_skb+0x21/0x150
>     process_backlog+0x37e/0x1200
>     __napi_poll.constprop.0+0xa5/0x5e0
>     net_rx_action+0x4c0/0xf70
>     handle_softirqs+0x204/0x9b0
>     __do_softirq+0x10/0x18
>     do_softirq.part.0+0x49/0xd0
>     </IRQ>
> 
> Negative values never meant anything here: 0 already expresses both
> "no limit" (interval) and "suppress everything" (burst).
> 
> Reject them at write time. message_burst can simply use
> proc_dointvec_minmax with extra1 = 0. proc_dointvec_jiffies has no
> minmax variant, so add proc_dointvec_jiffies_minmax(), mirroring
> proc_dointvec_ms_jiffies_minmax(), and use it for message_cost with
> extra1 = 0. Note that like the ms variant, extra1/extra2 are compared
> against the converted jiffies value.
> 
> Fixes: a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are negative")
> Cc: stable@vger.kernel.org
> Suggested-by: Joel Granados <joel.granados@kernel.org>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
