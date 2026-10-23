Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792762348;
	b=Aki7Q1omIRLbKRg/VAxyYipAB4QMePE0iDvAGDI0JAptjDEkk8A+bWLF/tSlvf8vADHS
	 DETaFViMEA2ZxGFIq5U+VyLL27vFTbb6D9+GoCJwRkTg9VKJ+ZXotnwp2kbGkQI2ovJPh
	 vZk+bX0/XL4PqbaYOfjuM/NGTOb/KAenVmesZ5l0B6PtyGKsAjkjRyTuI+t8mwdiVg5sO
	 U9mMM6uINxYYasO+PDzxliXWdrMSDUJoZ+Hg1HSWcPn2dOoD0Xn8qvdb3HUwL2xbts3d/
	 g5LjQJPm9m9O1C9r0edc/uOQvrou2eWrka9sofLWWsqu0jajF4WckVUT0bAYAbfKLyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792762348;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Flag:X-Spam-Level:
	 X-Spamd-Result:X-Spam-Score;
	bh=A6+jz2LGChmKSShBjipTzMEdLOMmKYeMdnFVh1ZvRjM=;
	b=C7JfSJilCfWy2oabu7N6nV/B/7jexTBDsngaIbUg5HdKQ1tti9peBmM7DlIdZ6NfnaXh
	 XxFKfZ7btGIaWzfBE1n5FXRNw+i3Tiw1V8ZNhf2iH/CiZC2n+YP0L4mddOZxsuwh1WHc8
	 Z7Nov7+d1Ymtnxh+/N2UGeOBS01RiUUD4v6vy33rZYROXO1SxD3vEQMzDVfGMKER6H2Fq
	 BR5eWEow4Al/XU6izV31UQ/1YuuUsFJH5T16CXrATbvIgsoRSySPBc8OjUUASUSy2eViI
	 saIPBMdp7BJKma5eurT0sS5YZ2BIGcg6lARS4DnDPx2wGA8NhK4PEJBDyMXhBA2zhbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dBp08XEs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=G5gj3KiN;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dBp08XEs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=G5gj3KiN;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984A4606A31D;
	Fri, 23 Oct 2026 13:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 984A4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dBp08XEs;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=G5gj3KiN;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dBp08XEs;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=G5gj3KiN
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3F6D220D4;
	Fri, 23 Oct 2026 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792762345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6+jz2LGChmKSShBjipTzMEdLOMmKYeMdnFVh1ZvRjM=;
	b=dBp08XEsblvd5CFBGtTShFlD2cvEEP7pabF1dx5HIgB3Y9OWGcRHa7FeMmsllY9rwyWdh6
	pzL5gduDFe5trasTScu3GtuUUr8sPw+zikOUWJkBDr/Inor3+/aIb40Q6iYCCXuBxRiu4D
	npSFpKaAxl+J+OFb8f3sJVZkv8EP7pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792762345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6+jz2LGChmKSShBjipTzMEdLOMmKYeMdnFVh1ZvRjM=;
	b=G5gj3KiNajer/v5zNAC7rbPp4wtOwZCOSAE/D0rrh5On+Blv8ShEceceNFiiG/PPZ9iqtr
	6UoxEfn6MtqJWGBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792762345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6+jz2LGChmKSShBjipTzMEdLOMmKYeMdnFVh1ZvRjM=;
	b=dBp08XEsblvd5CFBGtTShFlD2cvEEP7pabF1dx5HIgB3Y9OWGcRHa7FeMmsllY9rwyWdh6
	pzL5gduDFe5trasTScu3GtuUUr8sPw+zikOUWJkBDr/Inor3+/aIb40Q6iYCCXuBxRiu4D
	npSFpKaAxl+J+OFb8f3sJVZkv8EP7pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792762345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6+jz2LGChmKSShBjipTzMEdLOMmKYeMdnFVh1ZvRjM=;
	b=G5gj3KiNajer/v5zNAC7rbPp4wtOwZCOSAE/D0rrh5On+Blv8ShEceceNFiiG/PPZ9iqtr
	6UoxEfn6MtqJWGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98FD0133F6;
	Fri, 23 Oct 2026 13:32:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sDISGuhh22oyTQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 23 Oct 2026 13:32:24 +0000
Message-ID: <bb1fc73c-84b3-45a8-86e4-458498d0f80b@suse.de>
Date: Fri, 23 Oct 2026 15:31:22 +0200
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
Subject: Re: [PATCH net 1/5] ipv6: restrict gc_elasticity to 31
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Joel Granados <joel.granados@kernel.org>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su
 <yuuchihsu@gmail.com>, Flavio Leitner <fbl@redhat.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
 <20261023091419.167088-2-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261023091419.167088-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,nvidia.com,google.com,blackwall.org,nokia-bell-labs.com,icloud.com,gmail.com,stressinduktion.org,suse.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29

On 10/23/26 11:13 AM, Jiayuan Chen wrote:
> Every counted IPv6 dst allocation runs ip6_dst_gc() once the number of
> live dst goes over gc_thresh (1024 by default). ip6_dst_gc() decays
> ip6_rt_gc_expire by gc_elasticity: the smaller gc_elasticity is, the
> smaller ip6_rt_gc_expire gets, i.e. the more aggressive the gc.
> 
> ip6_rt_gc_expire is a u32, but gc_elasticity has no upper bound, so
> writing >= 32 shifts a 32-bit value by >= 32 bits, which is UB:
> 
> 	val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
> 	atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));
> 
>    UBSAN: shift-out-of-bounds in net/ipv6/route.c:3369:53
>    shift exponent 32 is too large for 32-bit type 'unsigned int'
>    CPU: 2 UID: 0 PID: 615 Comm: ping6 Not tainted 7.3.0-rc7+ #364 PREEMPT
>    Call Trace:
>     <IRQ>
>     dump_stack_lvl+0xc1/0xf0
>     dump_stack+0x10/0x20
>     __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>     ip6_dst_gc.cold+0x15/0x1a
>     dst_alloc+0x4e0/0x620
>     ip6_rt_cache_alloc+0x189/0x7e0
>     __ip6_rt_update_pmtu+0x68e/0x1160
>     ip6_update_pmtu+0x30c/0x3a0
>     icmpv6_err+0x1fa/0x330
>     icmpv6_notify+0x303/0x770
>     icmpv6_rcv+0xc12/0x1670
>     ip6_protocol_deliver_rcu+0xb4a/0x1520
>     ip6_input_finish+0x19c/0x400
>     ip6_input+0xd4/0x240
>     ipv6_rcv+0x1fd/0x330
>     __netif_receive_skb_one_core+0x118/0x1c0
>     __netif_receive_skb+0x21/0x150
>     process_backlog+0x37e/0x1200
>     __napi_poll.constprop.0+0xa5/0x5e0
>     net_rx_action+0x4c0/0xf70
>     handle_softirqs+0x204/0x9b0
>     __do_softirq+0x10/0x18
> 
> Cap it at 31. 31 and 32 are equivalent anyway: ip6_rt_gc_expire starts
> at 30*HZ (~30000 with HZ=1000), and such a value shifted right by 15 or
> more is already 0, so val - (val >> rt_elasticity) stops decaying well
> before 31. Values above 31 add no new behaviour, they only hit the UB.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
