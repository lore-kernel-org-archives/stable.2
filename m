Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013561;
	b=vLYzhNoVMb8csXhwyzu2OgLOmNsEPP1FBHL9UizmgNkky3PhqxatRclWHYkjqWzksCXA
	 6lFS+LYsFQwqBqXuMeT9TqQ5pIfRzSkrH5IwnGgeCMeS1Ngi/cDM6Xu9jx40qFvdB8HZF
	 rB0GBIQnWvTjMq4yMyTiM7Oa6rzG2RLJekufiFYRJSM6Ggav0KVjddWIukMCyVm0/RGM+
	 X4ILFEO7csfQhM9X0P4zaXdsyB1RyRVUKDAXTnfGc3BJxwP+znB4yjrIM9MbA0DzF1BGO
	 uoPOodiUN324SCQYX5l18zMmoKGSpvZbO637SlyPX9q2Gi+p97ZzVgIFm8VU/56MyKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013561;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=pnA9abm8tKCVM9tIK3l/Su5BC83HTMGiHZbk93iWfqI=;
	b=nCQXQXYw2z6tE4h8MdB/Kfpufz+Fqe1BrDfxsyIn0FnpZSUryRwHpbZyhjAPqpvTE5xO
	 8fiL/tI9lFZu4S7T7a5no6puJKBbalP4Kp+jmukDDgvMdEnymhubFgmaHuOlvXPqyKS2V
	 xqflMghJsYWYza6ARmC1nuG8psUQwM9fgrLCXQ8xqFyUUwYzvkZ9kKtnsxCMSq9hSYNao
	 zIhZD/EDHOMRkBD0FmTqCDmSzS0t2Gdgw5XM1jGyiTchCA4rqTwF6RpV/kObvRFjvt2VN
	 AaA7FAf/kkU5AjNPRD8+Y9F6qE2Jh3IFouXRN1RCk1XdBAUKFdTw9dv59mAh0KF79IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=EmsZyBQW;
	arc=none smtp.remote-ip=195.10.208.42
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB460A2613;
	Wed, 18 Nov 2026 14:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AAB460A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=EmsZyBQW
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jV4MM4M4hz5wkr;
	Wed, 18 Nov 2026 15:52:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795013551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pnA9abm8tKCVM9tIK3l/Su5BC83HTMGiHZbk93iWfqI=;
	b=EmsZyBQWl3mIWf54qckm4AL2FWnWPQltJ16v4suq+m6zKB5dVSyasZC9x4pZnAgWiua/n/
	qSHiG+NYJsV/y35oPsTl5upz2YjsZPhO377xLqE9m1cO5GgYVEdYOZ7ANXinkgemGyW9Wq
	ZLGB6TZYzCqTP9OeSvFB35JHqy+/SJF2gkztz+2t20L1WfHHItZZ0TRRl3l/hzpzxE5AxC
	SOfLwz0PK8yHXKqXGn+vjooG57KIJGMloU95Oi5zCisHK6NKNl5+Eulk9U8qtzhg9VwC+9
	FFLJdMPaWsAxqs5lQGYP6OrXkoCQI3w3oGotOaYAcd5f3K6e4GljlrMT3n40RA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <3f6b535c-fce1-41d7-90a4-b15cfa20db52@mandelbit.com>
Date: Wed, 18 Nov 2026 15:52:28 +0100
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
Subject: Re: [PATCH net v2 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
To: Janis Edvarts Lacis <janislacis06@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261116153041.3002666-1-antonio@mandelbit.com>
 <20261116153041.3002666-2-antonio@mandelbit.com>
 <rab7ustlezklu43vnjkby5mqh33bgqoztlz6bv5wxkjqfvbtfd@imjngi6j72nz>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <rab7ustlezklu43vnjkby5mqh33bgqoztlz6bv5wxkjqfvbtfd@imjngi6j72nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jV4MM4M4hz5wkr

Hi Janis, thanks for the review!

On 18/11/2026 14:21, Janis Edvarts Lacis wrote:
> On 16 Nov 16:30, Antonio Quartulli wrote:
>> Since commit ac8c58f5b535 ("igb: fix deadlock caused by taking RTNL in
>> RPM resume path") __igb_resume() doesn't take RTNL for runtime resume,
>> but __igb_open() still calls netif_set_real_num_{tx,rx}_queues(), which
>> require it. An asynchronous runtime resume (e.g. after the link comes
>> back) then triggers "RTNL: assertion failed".
>>
>> Skip them when resuming. The counts are set again on every regular open,
>> which happens under RTNL; the only case left out is a fallback from
>> MSI-X to MSI during a resume, which leaves the stack with more queues
>> than the device uses until the next open.
> 
> RTNL is not held only on runtime resume, it is held on a normal resume.
> __igb_open() skips netif_set_real_num_{tx,rx}_queues() for both resume
> types. Maybe it makes sense to skip them only on runtime resume when the
> RTNL is not held?

You're right.
RTNL is held on normal (system sleep) resume, so the counts can and 
should be set there.

> 
> May I ask why is it okay to leave out the fallback case, can't it lead
> to trouble if the counts are not updated but a fallback happens?

Ouch..you're right again.
The fallback case can't be left out: with fewer rings than the stack's 
real queue count, igb_tx_queue_mapping() maps several TX queues onto 
tx_ring[0], each under its own xmit lock, and igb_xsk_pool_disable() can 
index a ring that doesn't exist (Sashiko reported the same on this 
version....).

To summarize: in v3 I'll set the counts directly on normal resume and on 
runtime resume from a work item that takes RTNL (as patch 2 already does 
for the NAPI links).
Until the work item has run, igb_xmit_frame() will drop packets for 
queues the device doesn't have instead of mapping them onto tx_ring[0] 
(the stack drops them anyway when the count is lowered), and the XSK 
disable path will skip rings that don't exist.

Best,

> 
> Best regards,
> Janis

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

