Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564576;
	b=o25rxDNmy1w22PAGvYO1rFXdHrHq7rA5QX4OFzL+TYmRes6gwzuvKBYVK/+6mlqWCTNy
	 7GtsdkSf8cxU7U+KDndZhN7KPHQLZvTNosILQ/pLk9gxYp4M87zOqBmiOi6myububZ5Ci
	 3obY5Llh1hirHJjsiSYv49cjV849O996gDW2dmE9wi1vFfDOO3E8CCxdfkqx+zRiQOkL1
	 kcPRVsIa6FUIr+Fum18rOHCpV8TW+LxWHwi9Gk5C4NezUcYrClOxhstWmYKLIqHe12jlh
	 HET3qiFwvtFzEUQoJTi/5R8NXT9PT6k6vHB6Hg5QiKewzUtFJgrC/VeAEZU7NZqfOTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564576;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=f7qkQ+T8kTFhbMBMr1htmxGo+zFUKR6gX0ZGbilJ+so=;
	b=N1YXXviCdLSzgOxkr1/d1PyhTwKmJ1uyPAf8yQCdf7v8t6MCm9iUOuJeyklYBAez2MXw
	 dSEbA3/a7N/XAEOn4i74+ExylLaGzdJlGC58pq6V9aYL58oj2H5q0aQSIWYCbMkYXHOzn
	 D1dselZCCevE/IA7hbkrvE5qfZf/4Bq3IxM0t/+RKNpVC/2Izs2JHeqgr5UnBaoKAF3Ce
	 NVav7zNB7lCKjs1zR1mOgIR2RBcYRo2Y5vftoc/1nRnzO9YUDgPCnBO99RhCbYnmdu/0W
	 bVA9tTSsDml7e/qBndi0SVWFAFHu97f3F3v9iOdJwEJcP66SpyWmLsPaj32e/zaEg4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=vnVxoAp8;
	arc=none smtp.remote-ip=195.10.208.50
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA6C606A323;
	Tue, 24 Nov 2026 23:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BA6C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=vnVxoAp8
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4jZ07n3SVwz9tsZ;
	Wed, 25 Nov 2026 00:56:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f7qkQ+T8kTFhbMBMr1htmxGo+zFUKR6gX0ZGbilJ+so=;
	b=vnVxoAp8hmESv5VQ6obmwalRuoWDM6Xt/gryYkIWU1zCA2bliAZFS1XaYGh+1H0E0zDsuO
	8qtGK5T7THYi/qFiL5OSdzjdVxpwfjeXLTx1nXb4xtMMGx7eQlzkmhZFG9D9KYpTqAf56B
	KPNicU/1qqwOxT85D/L8L+6faz+00drGID6D7wqD0NY7Kp1tpj0G7C0EACCjFb0jAOv+R0
	8r9JzZEuZH0FwDpIA13ThM5ThPVlo4TjyfkVBl7UMQoHiIviZFscXdnacFdHlaNijEtKWQ
	FVLzjnNJtz071GAA8W+T228Hcdh/cEIqCjVnPl4TRTzlLrjCC6oXc1aEDyik6Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <61cf5263-6d8e-4981-95a2-7e6e00afe159@mandelbit.com>
Date: Wed, 25 Nov 2026 00:56:02 +0100
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
Subject: Re: [PATCH net v4 1/4] igb: don't touch rings that don't exist when
 disabling an XSK pool
To: netdev-bot+sashiko@kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261120210134.133238-2-antonio@mandelbit.com>
 <179555632368.3135.16785834510606239982@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <179555632368.3135.16785834510606239982@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ07n3SVwz9tsZ



On 24/11/2026 22:38, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new `qid < adapter->num_rx_queues` guard in
>    igb_xsk_pool_disable() (and `qid < adapter->num_tx_queues` in…
> 

The race with a runtime resume is real, though it predates this patch:
v5 adds a patch that resumes the device for the duration of igb_xdp(),
which also covers the same race in igb_xdp_setup().


> Pre-existing issues:
> - [High] igb_txrx_ring_disable() and igb_txrx_ring_enable() in
>    drivers/net/ethernet/intel/igb/igb_xsk.c only stop and restart…
> - [High] On error, igb_xsk_pool_disable() returns early with the queue
>    half torn down.
> 

The two pre-existing issues are real too (the Tx NAPI isn't stopped
when Rx and Tx don't share a vector, and a failed buffer reallocation
leaves the queue half torn down). They're independent from this series,
so I'll fix them separately. The zero-copy tests ran without queue
pairs and didn't hit the first one


Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

