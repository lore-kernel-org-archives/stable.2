Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E03C873B;
	Fri,  2 Oct 2026 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944798; cv=none; b=Dxr2MKa2gEGWREtsZNzTUn6Pwy5jXsUsOumBK5Tj6ViEGREy4QTq5yf33mXUWIInTASly2cMe2dMHwv675lCLucsUqISemF/IaTjEhUMu+5bL+qaDc1ouFcCzngefWlYFS7udUWf0I7q6VjHd7tZhPHWN+HTnGgOOYSXAjShHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944798; c=relaxed/simple;
	bh=QSFxW8aZbRcZeyRHSJyzlFGW1Xn6PsfpvQGVq0K7kNY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FXkz2O4/HMpVXLnROD2TF8fDvCpAkGQidWYK6Kb1rY6Tmm/tkxK4iKFvkBACWmrwD68tUgWdksyRNS9XKb0d0YW1EW9J/EaBQWbAVzjdF+sl1OLYVjWsocRc0bLPtVsj3X9SfmJUcFL6WNiP/vnMmlFD7n9WMWZtUiMbKo2jSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=NaiqX9Jg; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="NaiqX9Jg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=84fyuy2HjoPKHj79k2kWOl4xW59cv0AASn+mFclpcq0=; b=NaiqX9JgJzkbwN5MENbnLsmzNj
	SZEjw/H7pZScNDYkBL/GANCD9D3WcKzfV+2hmLB4eJFDq+Knd+EMcBBnrOgEe+e73Agauh6JhleCH
	GCuc0Gj7TMnWoSsIENL0lrnGkbpuhlRXho2sybTFTXr5Gjsf/IvelyN4BZQyhMhi5X9uJsQc0l5Io
	jCfJ3F9b6XmtqjXKxBUeVu1w03a0TFRM96+ctzkQkjtCO7EAYDZZfUXjv/uDFPJ+HhTDJ7Nu/1fdK
	36AR4IXmwFt10dTPA8MCU6/ZiFbnWHTkpFvjJ6q4RmUtn2HHIwdxUN/s1HvCyMpNIHuVQIa0/2djj
	CHxnBUsg==;
Received: from [::1] (port=49064 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xCcYP-00000000KPf-1EBA;
	Fri, 02 Oct 2026 14:39:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 14:39:53 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev-bot+sashiko@kernel.org, jmaloy@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net] tipc: protect received keys from concurrent flush
In-Reply-To: <DU4P189MB3750DC372FE007A967A8A266C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
References: <20260930115708.349540-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179090984112.434549.12939052372850275600@kernel.org>
 <DU4P189MB3750DC372FE007A967A8A266C6892@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <cdd0515de3a6bb13c9d789740e4e7c4b@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-02 14:05, Tung Quang Nguyen wrote:
>> Subject: Re: [PATCH net] tipc: protect received keys from concurrent 
>> flush
>> 
>> Thank you for your contribution! Sashiko AI review found 1 potential
>> issue(s) to consider.
>> 
>> Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0
>> 
>> If you believe none of the issues are legitimate, please reply to each 
>> issue of
>> Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let 
>> patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your 
>> reply (one
>> such reply per series is enough).
>> 
>> - [Medium] The patch fixes the rx->skey UAF/double-free, but the flush 
>> it
>>  protects can now be silently undone.
>> 
>> Pre-existing issues:
>> - [High] This problem wasn't introduced by this patch, but an RX 
>> delayed
>>  work can re-arm after netns teardown has flushed it and then fire on 
>> a…
>> 
>> --
>> 
>> tipc: protect received keys from concurrent flush
>> 
>> This patch adds an skey_in_use flag to struct tipc_crypto. The RX 
>> worker sets it
>> under rx->lock while it attaches rx->skey, and
>> tipc_crypto_key_flush() skips freeing the key while the flag is set. 
>> The goal is to
>> close a KASAN-reported use-after-free and double-free that happens 
>> when key
>> exchange races with key flush.
>> 
>>> diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c index
>>> 4409bdb70fe98..eab2a66e22333 100644
>>> --- a/net/tipc/crypto.c
>>> +++ b/net/tipc/crypto.c
>> 
>> [ ... ]
>> 
>>> @@ -1214,8 +1216,11 @@ void tipc_crypto_key_flush(struct tipc_crypto 
>>> *c)
>>>  		rx = c;
>>>  		tx = tipc_net(rx->net)->crypto_tx;
>>>  		if (cancel_delayed_work(&rx->work)) {
>>> -			kfree_sensitive(rx->skey);
>>> -			rx->skey = NULL;
>>> +			/* A previous invocation may still be using the key. */
>>> +			if (!rx->skey_in_use) {
>>> +				kfree_sensitive(rx->skey);
>>> +				rx->skey = NULL;
>>> +			}
>>>  			atomic_xchg(&rx->key_distr, 0);
>>>  			tipc_node_put(rx->node);
>>>  		}
>> 
>> [Severity: Medium]
>> With this skip, can the still-running worker undo the flush after it 
>> returns?
>> 
>> Nothing tells the in-flight tipc_crypto_work_rx() that a flush 
>> happened, so this
>> sequence looks possible:
>> 
>> CPU1 (tipc_crypto_work_rx)            CPU2
>> spin_lock_bh(&rx->lock);
>> rx->skey_in_use = true;
>> spin_unlock_bh(&rx->lock);
>>                                      tipc_crypto_key_synch()
>>                                        re-queues rx->work
>>                                      tipc_crypto_key_flush()
>>                                        cancel_delayed_work() == true
>>                                        skips kfree, rx->skey stays set
>>                                        c->flags = 0;
>>                                        tipc_crypto_key_set_state(c, 0, 
>> 0, 0);
>>                                        tipc_crypto_key_detach() on all 
>> keys
>>                                        spin_unlock_bh(&c->lock); 
>> tipc_crypto_key_init(rx, rx-
>>> skey, ...)
>>  tipc_crypto_key_attach()
>>    tipc_aead_rcu_replace(c->aead[new_key], aead, &c->lock);
>>    c->working = 1;
>>    c->nokey = 0;
>> 
>> In this case the TIPC_NL_KEY_FLUSH handler 
>> (__tipc_nl_node_flush_key())
>> returns 0. The peer's AEAD is still installed at key_next(0) and the 
>> RX crypto is
>> re-enabled.
>> 
>> There is also the retry path. Suppose tipc_crypto_key_attach() had 
>> already
>> returned -EBUSY, or tipc_aead_init() had returned -ENOMEM, before the 
>> flush.
>> The worker then keeps rx->skey, clears skey_in_use and re-queues 
>> itself.
>> queue_delayed_work() succeeds because the flush cancelled the pending
>> instance, so the pre-flush key gets attached about 5 seconds later.
>> 
>> Until that happens, tipc_crypto_key_rcv() rejects new keys from the 
>> peer
>> because the stale rx->skey is still non-NULL:
>> 
>> 	if (unlikely(rx->skey || (key_gen == rx->key_gen && rx->key.keys))) {
>> 		pr_err("%s: key existed <%p>, gen %d vs %d\n", rx->name,
>> 
>> tipc_crypto_rcv() also counts the stale rx->skey when it computes
>> rx->nokey:
>> 
>> 	rx->nokey = !(rx->skey ||
>> 
>> Before this patch, the cancel_delayed_work() == true case freed and 
>> cleared
>> rx->skey (with the use-after-free), so the retry had nothing to 
>> attach. With this
>> patch, that case behaves like the existing
>> cancel_delayed_work() == false case: the flush does not revoke the key 
>> that is
>> in flight. The commit message doesn't mention this.
>> 
>> Would a flushed or generation marker help? The worker would re-check 
>> it
>> under rx->lock before attaching or re-queueing, and free the key if a 
>> flush had
>> happened. That keeps the use-after-free fix and still honours the 
>> flush.
>> 
> Agree.

Me too, I'm working on a v2.

Jérémy
