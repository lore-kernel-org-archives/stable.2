Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662956;
	b=A1fRWVaeErbHcRdDSACdxtyO7TIirA1RykCwSr3jyi7gR3YJKxo2txvIFLuk/XleQFxj
	 Hpm7hQmiOS0Dn0Mkv/Y7F0NKNDs4Nj9u+4xXSN+KpbGVY68keqpkDJ1NaX7lzHT64E0eO
	 14ynsuInh5mcNLTwDomHKJgbp99Gu6/AbxDhrYm/cpe9osBWjDg92YHEp3YLtxdanfHkB
	 MqkF+FN2vRxE3rqH2kAi1e4BzhXmlmtzlnj17lLv2tFYJXGqfbfDmdSweZBz1STMsj+p6
	 D/sj4waaScy9LOoyZdUF1T/XSlMa1dh/hwx8qxXWmlR/vy0Fo5XbYg4IY/rVTxQ4GWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662956;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=qaKCa+TjoD1OzgCla43bUHaZNaOHmxBbECmuWAdteZU=;
	b=OUwhChYVm6l0F1RaGKFSKV+35kizMKdytXYJ1AV4B/W1PaW6CrsOjZ1NslSqqDq+NgXF
	 /MohJ0fDOryt/mtYlqZh9b/Rpb0t7JPkOOsIYq879VSR9RaV4TmfvCg1RJSmZf7S9IsSi
	 P8a2Xj880aMhGrGvoHiQUlZBlBxupDmp1qkvSk4oV3r78nMe01uy8PysquMVg2oKkyVDt
	 VEsKF0YwgMmcw4+uz4wLV3QEwZpNnStQQKw3kDURXwxJIUjbiYzjpR3FaQEdxl2+3pXvQ
	 oDnXw+OfgKFTze0NyWj54JHt0BHBGJPWE8e1KVjtX7uXfkUaxNHQUCpSCIg9kNFd/Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=jkGd8yDi;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E95606A31A;
	Thu, 22 Oct 2026 09:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6E95606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=jkGd8yDi
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7DD1DA002E;
	Thu, 22 Oct 2026 11:55:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792662952; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qaKCa+TjoD1OzgCla43bUHaZNaOHmxBbECmuWAdteZU=;
	b=jkGd8yDibczG1IzorFlU0eIzFeR7ouTn8kpjRjh7Z8+AH6tILxsPy7X8E6zi1qSBFO3315
	jQlgC/jX1h+tP+NaF80fxQlpB8233HvEKYYKL800t+7a4eKgLcXQR2u8HzuPl1gDTMsHzz
	SbuOVUx5ThCI120xgTHKGO+alPwUBXrcwj2lJh6sPxzUTMuQ34ZbLN+XkJgYdC4lOKq9On
	S/X935HMwWM3CjrtsQS+LxSbro1EOAqgNMuJDxX+kLIiGC2r1HZhdit+DfyxjJ4QQM3z2w
	nRmDL/QS1EoyeIDeuP/hln1d3WluMMJ2ILpq7LHM2WnI1LG3GqhAoy9hyZs7Ww==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 11:55:49 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Steffen Dirkwinkel <lists@steffen.cc>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Conor Dooley
 <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kevin Hao <haokexin@gmail.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Christian Taedcke
 <christian.taedcke@weidmueller.com>, Andrea della Porta
 <andrea.porta@suse.com>, stable@vger.kernel.org, Steffen Dirkwinkel
 <s.dirkwinkel@beckhoff.com>
Subject: Re: [PATCH RFC net 0/6] net: macb: fix TX stalls, IRQ storms and a
 lost NCR update on link-up
In-Reply-To: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
References: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
Message-ID: <21335ef00521312c158b0a71bf8ef08d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Steffen

On 22.10.2026 11:38, Steffen Dirkwinkel wrote:
> Hello Théo, Christian, all,
> 
> I've been looking at RCU and TX stalls on macb devices (Xilinx ZynqMP 
> on
> Beckhoff CX9240) for a while and have been carrying downstream patches
> similar to Christian's. A while ago I let Claude try to reproduce this 
> on my
> devices, it was able to reproduce and found some fixes but I wasn't
> happy with the quality of the patches and my understanding of them. I
> briefly talked to Théo in Prague and he suggested I send what I have as
> either the patches or the reproducers may be useful for ideas.
> I've finally gotten around to it and also ran some more testing and 
> improved
> the patches in the meantime. The series includes Christian's patches in 
> the
> original form (should also at least be reworded) and I also have Patch 
> 1 in here
> since the bench seems to have reproduced the issue on hardware (see 
> below).
> 
> If anyone has other ideas / patches for these issues I'm also happy to
> run tests on devices.

Thanks for posting this RFC. I will go later through the details, but 
wanted to let you
know that I'm also investigating the macb watchdog issue on RPi RP1 [1].

Yesterday Théo also shared some findings in the thread.

Three things from that work which touch your series:

- Patch 3 changes the IER write in macb_tx_poll() that I need a readl 
after. The write
   is posted, a TCOMP landing between the ring check and the write 
reaching the MAC is
   lost. That seems to be the RP1 stall, masking TXUBR does not change 
it.
   The two patches need ordering.

- The watchdog only recovers a lost TSTART. With a missed completion 
TBQP == tx_head and
   macb_tx_restart() does nothing, the queue never comes back. I have a 
patch that
   schedules TX NAPI from macb_tx_timeout() when the tail descriptor has 
TX_USED set.

- RP1 has a single TX queue, so the starvation from patch 6 is not what 
we see.

I can run the series on an RP1 board with my reproducer if that helps.

[1] 
https://github.com/raspberrypi/linux/issues/7661#issuecomment-6322904343

> [...]

Thanks,
Nicolai
