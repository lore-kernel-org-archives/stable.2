Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795385654;
	b=bvuDq6rws1AzbtT0HOJz3jsQO/gvQ7xeeKE4t+qqkAqjz8IJAPyZMB9SFJ1nRrs5EqqF
	 6ob28U3RTMz6Df69PsLlE+1u9chm5p6ESk28thBkwN4koqSturvBZvvIqKMah2WycLQoy
	 C9WcDxccjNWjxTtgC/KbV7qzlxsUN2I31BdzZfJqC7/0HWmy9Rw1W7eD22scdGCymfUq0
	 j9i2x08TMZrLZF3IdJDB9/g1zhg1sfUZo1nC+5wpg+LGVo1wrT6Ms1ahGB2W1RcVkWWiS
	 nWOZR+bDvCMTYRur0Cd3Z0RbkOXrXQEGPwVv9rRuuhuhAmZprkT2CMDi1qktQAhLA9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795385654;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=jvCxwlOVxvnKYhMHTmlKe3u7SgksgRLz0kN7w/QcZLA=;
	b=gKUJykB5NgK9aCbTuWHtLxCWep84fU7/1xJxyAJjZFiXZGI6SK8YZPSAMkH60uZmmpLm
	 gmTZ48fKaJJZLwUKhS8YgbAxtZewLt6ZBtNx6fsnhBz2zFCSq5x0qfB6NhPhhqEIPfwbh
	 ccelq+dfNFmvLW9bekMywK84GM7m0wLG2iHrxr4l7PCoL67H3MLc9zZ/Ls47ADhEuDotN
	 /I5mH9jOaSjbuCWN/qIRsVEiFn6RY1ns1QOVrURMTYmbTYHFtqJUeDGXWL/MuEQmrDYoX
	 uuYdCAXbGqKc91x1ynzhdsZ7UyclLj0rGgh/u869noMySY+vxFraYsED5a9s2KxLiSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=PlUv11zu;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B4606A31A;
	Sun, 22 Nov 2026 22:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C70B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=PlUv11zu
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 660FCA1583;
	Sun, 22 Nov 2026 23:14:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1795385649; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jvCxwlOVxvnKYhMHTmlKe3u7SgksgRLz0kN7w/QcZLA=;
	b=PlUv11zuZmjCQ9XkkO0TWMYVaLHEBdR/ZEwNEQwGvaTjoK2mf3tmATDiyebZKtUBELRIbr
	C78c7ckRSlxFK2m+88dWVkS63z4qDLMgW/Pm15Jw9IsbWwzPCNWZCw0V1ghfzATIcrV7pI
	mzoHTGvMTV20Z/ktP0eVnAIyP0osVNs5UreK4vEkbC2bDd3qzcMWtsn0wcpl6Mqv/xOjMU
	BxSsXhcvF6bmc2zN2h94JOjZDVVHRxJ6Bb5XFU+ZTU0+9R1yIqD9Q/NlBiNSe92L+O/ix2
	Wd0OiBjCjSJSi1gn2oELSg2xWcUhpZ62fvwUxIUxOTDDeVTeqxPE5UosZMPyAw==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 22 Nov 2026 23:14:05 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Anandu Padinhare <Anandu.Padinhare@electrifex.com>,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>,
 stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
In-Reply-To: <CAH5Ym4ijMNSAWZ8k3GmwOoLDBVTy32B1uhS_fE-dGhsPkgozeQ@mail.gmail.com>
References: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
 <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de>
 <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
 <CAH5Ym4jkX_tD58Gtd-mzruB+hqHK7s_9knNWh+gMqUjwuYyVPA@mail.gmail.com>
 <3303844cdf7c00c5369453eb91027c1b@tipi-net.de>
 <CAH5Ym4ijMNSAWZ8k3GmwOoLDBVTy32B1uhS_fE-dGhsPkgozeQ@mail.gmail.com>
Message-ID: <8e7b5bd372934d85ff890a6da7ca93b8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.11.2026 22:34, Sam Edwards wrote:
> [...]

>> Only if the ring is no bigger than the NAPI budget, right?
> 
> Right, but as pointed out in b6cb4541853c7 ("net: stmmac: avoid rx
> queue overrun" -- the commit that introduced the "leave one behind"
> behavior) the ring can be as small as 64 and that commit's author was
> seeing budgets larger than that.

Fair, a 64 entry ring is enough to hit it.

> 
> Perhaps NAPI should only be told to stop polling if we either:
> a) Reach the clean tail of the ring (so we *know* there are no further
> packets for us)
> b) Run out of memory and have to arm the retry timer
> 
> Thoughts?

Agreed, simpler than refill in the loop. If stmmac_rx() stopped at
dirty_rx and the refill worked, return the full budget so NAPI polls
again.

Anandu, could you fold that into v2?

> [...]

Regards
Nicolai
