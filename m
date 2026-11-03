Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701571;
	b=TZBBtsA9NZRsv3Nvx5EJBnIt9RzwlAwrhkOsyihkVkflCysUIko4geIQXJSPMtovLoSC
	 xAh+HK8OauQD3rQTThFQ4Xzrv69EtDruCnmluj6z+5GtEWYfjbKets9c54eNPO0Xgl2+w
	 nhdvpa0u2Wcdmk0qQAbrtfbksaNwW9MwRqZy8vNwKa+c5qlndRhRT83jWXhgpjRLEL83h
	 ZLTGYopvAyQ7rUBwtuhQlWPBzerNzv8fsjr5vaBWKU9QbaClhwuwgbQv1Ao5atrjINhMP
	 3NQI3bm/ZyFSCc7blrrGlqs+Zh0ngCDP/ODbCfqjV/iQ9yLq6i69XyFw0Ve9EQhXtGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701571;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+tVXS2qXFnFcTdFlcoUpcMZROLwvP5rjxvPBVj72EVo=;
	b=mQKRLpBvEc3NkURKf/gkt3F0njI3hOgSbdOwbDev3zP9HFZONmubD65d6dvZSJCwBI1I
	 xnKHOl9rhVEGo0WodvqOyE8n07A/nMl16Aw5oDDgqcrziW1/nZ5mEBA9QLtL/KxxPIh3s
	 zyBekJzqR5VVfpock2i4NTvyNxtVLZsGq313lHIauBsTXuO6LQ9/BZumLgfVUbym/6q4/
	 2P4R/+EQ5Thmr7UzLfeJDITKzTraMbPHvXmmyqkpBsttKe+JtSDEnhYqcXq/FTYQfaAi8
	 FQIiOU7+reZR9nPKUarmpVGxziC+pHaPTIFvJtuTKs3oM6ggudCSB+D8CxdAl296zfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V96M6+aW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5797E606B13A;
	Tue,  3 Nov 2026 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V96M6+aW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2141F00A1E;
	Tue,  3 Nov 2026 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701571;
	bh=+tVXS2qXFnFcTdFlcoUpcMZROLwvP5rjxvPBVj72EVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V96M6+aWiTTHVj6EbJcdFT+MAlD9HNzEDEOOfCOKlXGFDP6zXRe6tkbF3v7ACN0r7
	 k+uFpQjxwLofHgDmGv3P2OtzI0xREeFM34cKMgZ9Bw4WmtgQ2Tn59o1R+Qfs82y6ih
	 DvHAKn2o3h3XKQy9pAbxQLgPzxtvHsU9sso4ngt3/vRR9OF40hhVuSzNHm+V3Oj/C9
	 zJmJ7+g7zjgveisL8ZhYoYuoR/alUTsef9VNo2TPK4BHDnikvnTPe9/wy+fkEA81UE
	 PHfSc/Pvw2oSzCLx6cIM9sjCMKqY8XxUMkSzScA0hM/amQQZpmoSzVlnOzsVBxPlpF
	 75ldcgmtL4uZQ==
Date: Tue, 3 Nov 2026 11:26:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] net: cxgb4: do not leak a PTP skb when the Tx queue is
 busy
Message-ID: <20261103-astute-literate-malkoha-251bce@quoll>
References: <20261103100530.1309928-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103100530.1309928-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:30 +0000, Wentao Liang wrote:
> cxgb4_eth_xmit() stores the PTP skb in adap->ptp_tx_skb with an extra
> reference before the descriptor credits are checked.  When the PTP
> queue is full the function returns NETDEV_TX_BUSY, and later failures
> such as an unsupported FCoE offload or a failed DMA mapping jump to
> out_free.  None of those paths transmit the packet, so no transmit
> timestamp ever arrives and the extra reference is never released.
> 
> Only take the extra reference once the packet is certain to be queued,
> just before it is handed to the hardware.  The initial check for an
> outstanding PTP skb is kept, and PTP transmits are serialized by
> adap->ptp_lock, so only one PTP packet can be in flight.
> 
> Fixes: a456950445a0 ("cxgb4: time stamping interface for PTP")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/sge.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




