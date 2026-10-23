Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764755;
	b=3jb9/y3n4Pdi2xuNXy53rIhJ4cT74oNdTJl/EEzIQk43R4r8yjGljnMyznIX2h8M4Bb+
	 KptjoLCr998PwODVtDEfzZugDXuKpzAavef+jwxI0/80yE+8rhy4mGNFC5nhKESoRvCpE
	 8wWO6m/QOTXeJ9ownIQUQiTBFW+sAnJElmkcxu9B7q2JOdsoSm60V2KDO3Y8OwbJgr9/F
	 Le9EAtuykC8Sy7fzBNl5pY6PZL56SbUos5/kzWOmAVHkQ/1D2VbBm2JhQhlv3msLxP2pw
	 HxX7ghNrKAqIJOtuhZGEHmQCPvI4WLoSikByrz783bQEuxA2XhHXDFvBA6PJrkJHMAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764755;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=rl+LBmXMt0s4R6vFRBmArNwMRS9jkmPZ2VnKxQORHGI=;
	b=QsqV+tICO2vgtnZscnd+J2tsBjjzD7iDT3y4AnwmmdjcnxlqOBq28Fg+F8C58IlbaCmU
	 6FJ6T4rAvaYa/CuqFMdaI+5Ebho9b4vBo3cccgXNy8wlGcIKInl5WZmS0sol8HI6BOkVb
	 qAKd2YaNfW/OTAv5asKloMDV8r8jA2ioNkEAk0aM7Pqt38n7aIQnB4wrbl6BCR3bJuGk8
	 dzwJjemIIEBVXBN3T5Ay+p/DVnGe0K6Qy0LtoCmIwI6k3zT4zELht2ZfdZWMgG9oxICGC
	 +i/9VEBD2C4sNQxYrQQaAkB0K3fTrdU1RmQHt2BopKEkfKLHe+bojenCyZy7gabg1eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QLXWZEuz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KE86RIWK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QLXWZEuz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KE86RIWK;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB7606A31A;
	Fri, 23 Oct 2026 14:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26CB7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QLXWZEuz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KE86RIWK;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QLXWZEuz;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KE86RIWK
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCB111F458;
	Fri, 23 Oct 2026 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792764753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rl+LBmXMt0s4R6vFRBmArNwMRS9jkmPZ2VnKxQORHGI=;
	b=QLXWZEuzbWd4F8pz1RX9mmEyV4TVrx+MGR3a3/xl4xQdtNYfcGHjWFjLXi+gfIq+1Axxko
	wpX2jjdlyMXFrisCV+8DOydUi7ZbAG55eo13tgWAHb0UphTBUcF5ftMUp/p569JxFS2nH+
	+3WJDuqs9dReDQNIEWqKv8Dmx0CFcVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792764753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rl+LBmXMt0s4R6vFRBmArNwMRS9jkmPZ2VnKxQORHGI=;
	b=KE86RIWKV+CI+WvEuTZ9vNcscQgVpPTexnCUfAp6Nj2ths/XV3rtCyPtUIymp+NK0D5k2Z
	jZpQGJaVi4w6nsAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QLXWZEuz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KE86RIWK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792764753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rl+LBmXMt0s4R6vFRBmArNwMRS9jkmPZ2VnKxQORHGI=;
	b=QLXWZEuzbWd4F8pz1RX9mmEyV4TVrx+MGR3a3/xl4xQdtNYfcGHjWFjLXi+gfIq+1Axxko
	wpX2jjdlyMXFrisCV+8DOydUi7ZbAG55eo13tgWAHb0UphTBUcF5ftMUp/p569JxFS2nH+
	+3WJDuqs9dReDQNIEWqKv8Dmx0CFcVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792764753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rl+LBmXMt0s4R6vFRBmArNwMRS9jkmPZ2VnKxQORHGI=;
	b=KE86RIWKV+CI+WvEuTZ9vNcscQgVpPTexnCUfAp6Nj2ths/XV3rtCyPtUIymp+NK0D5k2Z
	jZpQGJaVi4w6nsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7BAA133F3;
	Fri, 23 Oct 2026 14:12:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xP5FIU9r22q/dwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 23 Oct 2026 14:12:31 +0000
Message-ID: <5dda588d-e6fa-420d-a73d-b5278094b59c@suse.de>
Date: Fri, 23 Oct 2026 16:11:25 +0200
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
Subject: Re: [PATCH net 2/5] ipv4: fix shift-out-of-bounds in
 ip_rt_send_redirect()
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Joel Granados <joel.granados@kernel.org>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su
 <yuuchihsu@gmail.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
 <20261023091419.167088-3-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20261023091419.167088-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,nvidia.com,google.com,nokia-bell-labs.com,icloud.com,gmail.com,stressinduktion.org,suse.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: DCB111F458

On 10/23/26 11:13 AM, Jiayuan Chen wrote:
> ip_rt_redirect_number is the max number of ICMP Redirects we send to one
> endpoint; once we hit it we stop. Before that, ip_rt_redirect_load gives
> the redirects an exponential backoff:
> 
> 	if (peer->n_redirects == 0 ||
> 	    time_after(jiffies,
> 		       (peer->rate_last +
> 			(ip_rt_redirect_load << peer->n_redirects)))) {
> 
> n_redirects only stops growing when it reaches ip_rt_redirect_number, and
> both redirect_number and redirect_load are plain proc_dointvec sysctls
> with no upper bound. Set redirect_number past 32 and n_redirects climbs
> past 31, so "ip_rt_redirect_load << peer->n_redirects" shifts a 32-bit
> int by >= 32 bits, which is UB:
> 
>    UBSAN: shift-out-of-bounds in net/ipv4/route.c:949:6
>    shift exponent 32 is too large for 32-bit type 'int'
>    CPU: 1 UID: 0 PID: 1845 Comm: ping Not tainted 7.3.0-rc7+ #364 PREEMPT
>    Call Trace:
>     <IRQ>
>     dump_stack_lvl+0xc1/0xf0
>     dump_stack+0x10/0x20
>     __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>     ip_rt_send_redirect.cold+0x2c/0x146
>     ip_forward+0x1ddc/0x2430
>     ip_rcv+0x2b1/0x320
>     __netif_receive_skb_one_core+0x16b/0x1c0
>     __netif_receive_skb+0x21/0x150
>     process_backlog+0x37e/0x1200
>     __napi_poll.constprop.0+0xa5/0x5e0
>     net_rx_action+0x4c0/0xf70
> 
> Fixing this from the sysctl side would mean bounding both knobs, e.g.
> redirect_load to [0, 65535] and redirect_number to [0, 16], which gets
> in the way of users who legitimately do not want to cap ICMP redirects.
> Instead compute the backoff in u64 with the shift count capped at 31,
> which cannot overflow since ip_rt_redirect_load is an int, and clamp the
> result to MAX_JIFFY_OFFSET.
> 

I think we should cap redirect_load with a minimum valid value of 0 on 
the sysctl. If the user want to disable ICMP redirects or do not cap 
them, they should use 0 or -1 in redirect_number IMHO.

What do you think?

> The clamp also fixes 32-bit kernels, where the same expression goes
> wrong long before the shift count reaches 32. With the default
> ip_rt_redirect_load of 20, from n_redirects == 27 on the result is
> either truncated or too large for time_after(), which then treats the
> deadline as already passed, and from 30 on it is 0, so every forwarded
> packet gets a redirect again until ip_rt_redirect_number is reached.
> This needs a raised redirect_silence to be reachable, otherwise
> n_redirects is reset long before. On 64-bit, ip_rt_redirect_load << 31
> stays below MAX_JIFFY_OFFSET, so nothing changes there.
> 

Isn't the same issue in 64-bit kernels too? In essence, it would be (int 
<< u32) which results in a negative value and that is later 
sign-extended to a corrupted 64-bit value. Am I missing something here?

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>   net/ipv4/route.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 595a3b7f1783..76807b757046 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -907,6 +907,7 @@ void ip_rt_send_redirect(struct sk_buff *skb)
>   	struct inet_peer *peer;
>   	int log_martians;
>   	struct net *net;
> +	u64 backoff;
>   	int vif;
>   
>   	rcu_read_lock();
> @@ -945,10 +946,10 @@ void ip_rt_send_redirect(struct sk_buff *skb)
>   	/* Check for load limit; set rate_last to the latest sent
>   	 * redirect.
>   	 */
> +	backoff = (u64)ip_rt_redirect_load << min(peer->n_redirects, 31U);
> +	backoff = min_t(u64, backoff, MAX_JIFFY_OFFSET);
>   	if (peer->n_redirects == 0 ||
> -	    time_after(jiffies,
> -		       (peer->rate_last +
> -			(ip_rt_redirect_load << peer->n_redirects)))) {
> +	    time_after(jiffies, peer->rate_last + (unsigned long)backoff)) {
>   		__be32 gw = rt_nexthop(rt, ip_hdr(skb)->daddr);
>   
>   		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST, gw);

