Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760176;
	b=JIPTu050tkGM7EungOBIN9QqmfgbXEFlGXYhCGTV6lJJGo1k+o+ltSZmfRltRAK7QMg4
	 invxwzDDlig2eggle23cSZO9ix7eE8AgjnQg/YDi4rcCDx4evbXfm5vAsiquy/9xzVVd9
	 gWUdLgeaQKjIhVo3jyapjLMAcnGHQz9vVR3g0GUpl4PzxP8MsLfwUvG9xJ+BjkdvBxNSN
	 e9qm7i/vey2WEb/NaZlZ5kguuaFZg0aZkhcM1QRuRLLQLSmGuRi/E33zMOyN9OJ2eyZf/
	 FYuBwcguUVOW9xRPlfX6HW2AEfbnRutKZflv86frNuAWGI2JMH4jZnMHBd2Ks4Tb3ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760176;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=Qjok9whtVXP/JIWF5OA2iF1QeRN9gsKuPI4QosshLeo=;
	b=M0OSqI9+19Ddsq2drBLU/4lBcih5cKxNTt7UNKQfEs3AKMytQRcA3Euf/Uc1aR8Y3aqh
	 8WQmIey9bETK6zG77McawHxq9nrPq2rhdV/a/IcH7yifP+mOFu3esQih7ldkd32bBTUB8
	 9dCphk+cUxbDXTIILuQRz9jkxN9kxaNzcJRher8x3p69WJeBf1FYi9so+3M5FP3xY+F1C
	 IglLL3lvZESN6ayX7KlzKe9OnDatXX1lg9RSbrp/jVLOpli30DnFYmauW0keYigB0cRzT
	 EC+aQ5ulD6EpxxEsTjCnDVFsXIvrN9bcUvCRxNrp2QqHs0INIeHCzLp/lX6075DmiaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sCORC9A0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yF7qk4a9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sCORC9A0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yF7qk4a9;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64B606A31D;
	Fri, 23 Oct 2026 12:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF64B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sCORC9A0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yF7qk4a9;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sCORC9A0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=yF7qk4a9
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03D8D1F74C;
	Fri, 23 Oct 2026 12:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792760174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qjok9whtVXP/JIWF5OA2iF1QeRN9gsKuPI4QosshLeo=;
	b=sCORC9A0SeWII1iihSjufIuC0tARKKnumQVnN9dPzVccCQX0hDCVVVqyeNEoo4CtqHWnfZ
	ds6xW0utRR083zFRrDR7mXYVty2b0Jr/Sb8t4nv2PY8Rx3rsmMa1yLvrVIZnLf3oYupr1F
	bGnX94Jmhqe79BfVUt14Fav/zVAzZWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792760174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qjok9whtVXP/JIWF5OA2iF1QeRN9gsKuPI4QosshLeo=;
	b=yF7qk4a9xA31Q/doMvYp2i1x2spE9PxgiPZ+ANe7Qqn/l6Ko523gMa8kHnQR5yVpUrbd5G
	sdkgy94B6s3zcAAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sCORC9A0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yF7qk4a9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792760174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qjok9whtVXP/JIWF5OA2iF1QeRN9gsKuPI4QosshLeo=;
	b=sCORC9A0SeWII1iihSjufIuC0tARKKnumQVnN9dPzVccCQX0hDCVVVqyeNEoo4CtqHWnfZ
	ds6xW0utRR083zFRrDR7mXYVty2b0Jr/Sb8t4nv2PY8Rx3rsmMa1yLvrVIZnLf3oYupr1F
	bGnX94Jmhqe79BfVUt14Fav/zVAzZWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792760174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qjok9whtVXP/JIWF5OA2iF1QeRN9gsKuPI4QosshLeo=;
	b=yF7qk4a9xA31Q/doMvYp2i1x2spE9PxgiPZ+ANe7Qqn/l6Ko523gMa8kHnQR5yVpUrbd5G
	sdkgy94B6s3zcAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D61C8133F3;
	Fri, 23 Oct 2026 12:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c27IKGxZ22q3JgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 23 Oct 2026 12:56:12 +0000
Message-ID: <27876dee-435f-4ea7-afed-69f8366e1c62@suse.de>
Date: Fri, 23 Oct 2026 14:55:10 +0200
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
Subject: Re: [PATCH net 5/5] net: restrict message_cost and message_burst to
 non-negative values
To: Joel Granados <joel.granados@kernel.org>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su
 <yuuchihsu@gmail.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, Petr Mladek <pmladek@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
 <20261023091419.167088-6-jiayuan.chen@linux.dev> <attQGnJGhzTPFsMd@hobbes>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <attQGnJGhzTPFsMd@hobbes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
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
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 03D8D1F74C

On 10/23/26 2:19 PM, Joel Granados wrote:
> On Fri, Oct 23, 2026 at 05:13:31PM +0800, Jiayuan Chen wrote:
>> net.core.message_cost and net.core.message_burst feed the interval and
>> burst of net_ratelimit_state, but neither has a lower bound:
>> message_burst uses plain proc_dointvec, and message_cost uses
>> proc_dointvec_jiffies, which happily stores -1 second as -HZ jiffies.
>>
>> Since commit a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are
>> negative"), ___ratelimit() splats on such values, so the next
>> net_ratelimit() caller warns, e.g. a martian source log:
>>
>>    Negative interval (-250) or burst (10): Uninitialized ratelimit_state structure?
>>    WARNING: lib/ratelimit.c:43 at ___ratelimit+0x56e/0x960, CPU#1: ping/3218
>>    RIP: 0010:___ratelimit+0x578/0x960
>>    Call Trace:
>>     <IRQ>
>>     net_ratelimit+0x1c/0x30
>>     ip_handle_martian_source+0x1bb/0x340
>>     ip_route_input_slow+0x1057/0x3650
>>     ip_route_input_noref+0x104/0x260
>>     arp_process+0x109b/0x2510
>>     arp_rcv+0x381/0x460
>>     __netif_receive_skb_one_core+0x173/0x1c0
>>     __netif_receive_skb+0x21/0x150
>>     process_backlog+0x37e/0x1200
>>     __napi_poll.constprop.0+0xa5/0x5e0
>>     net_rx_action+0x4c0/0xf70
>>     handle_softirqs+0x204/0x9b0
>>     __do_softirq+0x10/0x18
>>     do_softirq.part.0+0x49/0xd0
>>     </IRQ>
>>
>> Negative values never meant anything here: ___ratelimit() treats them
>> like 0, and 0 already expresses both "no limit" (interval) and
>> "suppress everything" (burst).
>>
>> Reject them at write time. message_burst can simply use
>> proc_dointvec_minmax with extra1 = 0. proc_dointvec_jiffies ignores
>> extra1/extra2, so give message_cost a small handler that parses into a
>> temporary and only stores the value if it is not negative.
>>
>> Fixes: a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are negative")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>   net/core/sysctl_net_core.c | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
>> index 473c162736d6..8146ed819695 100644
>> --- a/net/core/sysctl_net_core.c
>> +++ b/net/core/sysctl_net_core.c
>> @@ -378,6 +378,22 @@ static int proc_do_skb_defer_max(const struct ctl_table *table, int write,
>>   	return ret;
>>   }
>>   
>> +static int proc_do_message_cost(const struct ctl_table *table, int write,
>> +				void *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	int ret, interval = READ_ONCE(*(int *)table->data);
>> +	struct ctl_table tmp = *table;
>> +
>> +	tmp.data = &interval;
>> +	ret = proc_dointvec_jiffies(&tmp, write, buffer, lenp, ppos);
>> +	if (write && !ret) {
>> +		if (interval < 0)
>> +			return -EINVAL;
>> +		WRITE_ONCE(*(int *)table->data, interval);
>> +	}
>> +	return ret;
>> +}
>> +
>>   #ifdef CONFIG_BPF_JIT
>>   static int proc_dointvec_minmax_bpf_enable(const struct ctl_table *table, int write,
>>   					   void *buffer, size_t *lenp,
>> @@ -544,14 +560,15 @@ static struct ctl_table net_core_table[] = {
>>   		.data		= &net_ratelimit_state.interval,
>>   		.maxlen		= sizeof(int),
>>   		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec_jiffies,
>> +		.proc_handler	= proc_do_message_cost,
>>   	},
>>   	{
>>   		.procname	= "message_burst",
>>   		.data		= &net_ratelimit_state.burst,
>>   		.maxlen		= sizeof(int),
>>   		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>>   	},
>>   #ifdef CONFIG_RPS
>>   	{
>> -- 
>> 2.43.0
>>
> 
> I would prefer something like this [1] (not tested and not compiled).
> This is more in line with the patterns inside the jiffies.c file. I put
> SYSCTL_ZERO there, but I have a doubt if you actually need SYSCTL_ONE.
> 
> If the interval variable can be zero, then leave it as SYSCTL_ZERO, but
> if it cant be zero and can be one the use SYSCTL_ONE
> 

FWIW, I also like this solution and indeed we can convert other users in 
the future.

About SYSCTL_ZERO, I believe it is the right choice. AFAIU, it just 
disables limiting.

Thanks,
Fernando.

> best
> 
> 
> [1]
> 
> diff --git i/include/linux/jiffies.h w/include/linux/jiffies.h
> index bbd57061802c..288ba81ed53e 100644
> --- i/include/linux/jiffies.h
> +++ w/include/linux/jiffies.h
> @@ -646,6 +646,8 @@ extern unsigned long nsecs_to_jiffies(u64 n);
>   struct ctl_table;
>   int proc_dointvec_jiffies(const struct ctl_table *table, int dir, void *buffer,
>                            size_t *lenp, loff_t *ppos);
> +int proc_dointvec_jiffies_minmax(const struct ctl_table *table, int dir, void *buffer,
> +                                size_t *lenp, loff_t *ppos);
>   int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
>                                      void *buffer, size_t *lenp, loff_t *ppos);
>   int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
> diff --git i/kernel/time/jiffies.c w/kernel/time/jiffies.c
> index 9b3487d40cd6..cf91996fe4e3 100644
> --- i/kernel/time/jiffies.c
> +++ w/kernel/time/jiffies.c
> @@ -165,6 +165,14 @@ static int do_proc_int_conv_jiffies(bool *negp, ulong *u_ptr, int *k_ptr,
>                               sysctl_u2k_int_conv_hz, sysctl_k2u_int_conv_hz);
>   }
> 
> +static int do_proc_int_conv_jiffies_minmax(bool *negp, ulong *u_ptr, int *k_ptr,
> +                                   int dir, const struct ctl_table *tbl)
> +{
> +       return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, true,
> +                            sysctl_u2k_int_conv_hz, sysctl_k2u_int_conv_hz);
> +}
> +
> +
>   static int do_proc_int_conv_userhz_jiffies(bool *negp, ulong *u_ptr,
>                                             int *k_ptr, int dir,
>                                             const struct ctl_table *tbl)
> @@ -263,6 +271,15 @@ int proc_dointvec_jiffies(const struct ctl_table *table, int dir,
>   }
>   EXPORT_SYMBOL(proc_dointvec_jiffies);
> 
> +int proc_dointvec_jiffies_minmax(const struct ctl_table *table, int dir,
> +                         void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +       return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
> +                                 do_proc_int_conv_jiffies_minmax);
> +}
> +EXPORT_SYMBOL(proc_dointvec_jiffies);
> +
> +
>   /**
>    * proc_dointvec_userhz_jiffies - read a vector of integers as 1/USER_HZ seconds
>    * @table: the sysctl table
> diff --git i/net/core/sysctl_net_core.c w/net/core/sysctl_net_core.c
> index eb35da3556f4..7226697bf7c1 100644
> --- i/net/core/sysctl_net_core.c
> +++ w/net/core/sysctl_net_core.c
> @@ -538,7 +538,8 @@ static struct ctl_table net_core_table[] = {
>                  .data           = &net_ratelimit_state.interval,
>                  .maxlen         = sizeof(int),
>                  .mode           = 0644,
> -               .proc_handler   = proc_dointvec_jiffies,
> +               .proc_handler   = proc_dointvec_jiffies_minmax,
> +               .extra1         = SYSCTL_ZERO,
>          },
>          {
>                  .procname       = "message_burst",

