Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564637;
	b=SUHtG3JylGvwXCuupwD831XnZgB1lFDpAapHQnbw0stMp2numWDHrYvSDMwSg9BznHEh
	 9mI64fqDPPN0+s3ni72q/dze6m+XjEUTw1vP03fWPZwawr8kTaXxEE6PyfokgRmKwDf3Y
	 baoAbtvGKQ04zkFpZZINKv497hznVaojlIfQWcw4i6wVc6twq+2V8hzM/g2qJlXz3/hPg
	 BoCkRgjX6GtVrjcrGy8D8J+6/6adlJLF/F1JPzPRO6RrMn9FiyMhrt8KjNKadXSga1/yC
	 aL2jZgncB1GyJnPGJUrCfZjxv8YLNGRmjxFGNYoQSTVbgPtwMEnZwADYqh5EMipSKAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564637;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=FPGxYREIu5QBknQBTYCZT8SkLTQYnWSM7RCkrhgdZV0=;
	b=OfqolTBqnTP6KD7R8/5vWbct2PE+ETnYWrxO+GMBgWWTdDdFIAXT8QWbL1mnnxIItVpa
	 X2S20FKJD1Z8PEaV3tLSX8Q1EOKuZMu6Xx206qbce4I/Ie0riEeBM3+LAMR/x3CHt8qWT
	 4Ul2EssrVUxB7uVg3N1SHg0sjj5jkn5o/waDFJyJLjwjPFCcMVwSYsFHo+sV/1Jr4ZWp6
	 pQjqzWOTrU3g7u8dO5auhPToKutcv8WKCjSVVpRLC/CQmC5fI4f92daVEw2WOmBwDZDVV
	 h8GU6Z4NDOEXYEyxekOqlKXcOOvu1NOvHSLoyNkRrE9/gbzWGavvFY+onJ6FVxqqzxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=jhRuRnXH;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86023606A31E;
	Tue, 24 Nov 2026 23:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86023606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=jhRuRnXH
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jZ08y6scNzFqWZ;
	Wed, 25 Nov 2026 00:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPGxYREIu5QBknQBTYCZT8SkLTQYnWSM7RCkrhgdZV0=;
	b=jhRuRnXHKgLAEHTss96zJFJab56EGK+9ghs1SA42cJZGYE3lMIK5zLnUa/ks+oqNK8FMql
	Gbr/EfhYvhFoHkRJgd0TXI/wl+miqCsyiZ4P9zaK8gUAOmAc3virTnIPYz2dOJ7XQg//L9
	LwBsX3i0Ed193TMfltUkt3vx/s6RBqeVLLWdOlqTn1JxMksHqNSGt78r3iISB4DKV5s/iG
	DkzcJ/2dgd+rGILGuvDkG/7fuCTPKLQet/xnMlCs/sZZOkM6YXu39B8k1Y4HBdDHt1EMVr
	3EoS4K9ra9Mgy6URGZFyfacAbUWla+dSqvKGYCMj5vxhupNiMTsz1OaVsOpWyw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
Message-ID: <865b2952-d3db-4b51-93ce-28b3254d33c0@mandelbit.com>
Date: Wed, 25 Nov 2026 00:57:05 +0100
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
Subject: Re: [PATCH net v4 4/4] igb: only allow runtime PM if the device can
 wake up
To: netdev-bot+sashiko@kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261120210134.133238-5-antonio@mandelbit.com>
 <179555632736.3135.1658046091917963917@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <179555632736.3135.1658046091917963917@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jZ08y6scNzFqWZ



On 24/11/2026 22:38, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The runtime PM usage count can end up unbalanced, because the
>    same decision is made twice.

Right: pci_dev_run_wake() can change while the driver is bound. v5
checks it where the runtime suspend is scheduled (the watchdog and
igb_runtime_idle()) instead of at probe and remove, which stay
unconditional, so the usage count stays balanced.

Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

