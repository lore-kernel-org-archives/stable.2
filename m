Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F882FD7D3;
	Mon, 28 Sep 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599952; cv=none; b=r14Ub5nG1AZ0XtNC5AYHn0X9EvP7ofUzsu+/B5DdKAQI6XuWMSZ6BMOgblYlB/s8WxpvS2Qp07yCf+KuttStvlSRkDyQDDlqTot6A2yy+6ChppIOMx9BlS3rWfydAPpJqhMQi5HsO4ZuC3Tls+ab9tqNQv5pg37lUdDj7vvMFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599952; c=relaxed/simple;
	bh=sJTvNC7eTsOZIfYAtlpGFUfYRVo00biUkNxLqcDdZg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s18ZO+dXAOSZWQTGhbCjLtOC8GiUg1NFifSd8YbI5LXgbQ56zzHfG9YXIuv008Dfz4/S8PebtIByLcf6VWMMnPc1+lL8UUopUTksaEYvA5L0t2Toc2/ZYPc0hTOUt8DKA+946rmIeopZnFmy94bj0npslPweJ377v/3mu5ahAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=in8AMUEI; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="in8AMUEI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=DTPIj+A/kdxPu3UNXQlL6Hsn+maL+UgLjUd7u23pb2U=;
	b=in8AMUEIsjWOJ7MpIDhT/wxSAhUAmg+wKdqWDfD1kzYmTC4E/0W0ICSgmeRgmZ
	dAAxodCUyDee3xouXqLlVeChEJfg4ymQVaEb4e2n8mkx9a8bt+CJkjLLzqJ/asxM
	ZmCQ7UjzxYHLISuB8IpqhZ71WC6Po1phw8n5Kp+KTQvgw=
Message-ID: <382899bd-1502-4e65-8c38-67924def204b@126.com>
Date: Mon, 28 Sep 2026 20:51:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: stmmac: do not keep the new TSO MSS cached on
 mapping failures
To: netdev-bot+sinfo@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260928123422.1698785-1-xiaolinkui@126.com>
 <179059916708.31693.15841769312205825846@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179059916708.31693.15841769312205825846@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PykvCgDXv8a+Yrpq6_ltAg--.55804S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyrGw15ZFW3Xw4kAFWkJFb_yoW8uF48pF
	Z0k3yqkF9xJF1Syr4vvw40va4rtrs3GF45Gr4UKryYyws8GF1agrsIgr15uasrGr97Za4F
	9w4qq34qvryDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZZ2-UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQAS6Gq6YsCWTgAA35

Hi,

Thanks for the reminder. Here is the missing information:

How discovered:
The original issue was found by code inspection of the error paths in
stmmac_tso_xmit(). The v3 regression - deferring tx_q->mss = mss until
the context descriptor OWN bit is set - was raised by the Sashiko AI
review of v3, which noted that a concurrent stmmac_tx_err() could reset
and clear tx_q->mss before the deferred store republished it. v4 avoids
that by keeping the store in place and clearing tx_q->mss on the DMA
mapping failure paths instead.

Triggered:
Not triggered on real hardware. This is a code-inspection/review finding.
The ring-wedge part requires a DMA mapping failure in the TSO transmit
path; the stale-MSS part then requires a later TSO frame with the same
gso_size to take the mss == tx_q->mss path and skip the context
descriptor. No stack trace, error message or syzbot report is available.

Testing:
Not tested on real hardware. No hardware test was performed.

On 2026/9/28 20:39, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
>   - Whether the issue was actually triggered, or is only theoretical
>     (e.g. found by code inspection). If it was triggered please include
>     the symptoms, like the stack trace or error messages.
> 
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

