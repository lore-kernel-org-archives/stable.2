Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292581;
	b=zyWoD66mItugmCjn52rtoRqCpEb7GgLO+jJeewX2RP/SHsBnQUcTAiPmXXfIvaf68AUF
	 KD7mSbP7hepdBOftp6dZpgMsdBm318y2BDH9rpg3GRpd50Rv+zzakpSTAu8z/ewIQ6Rfb
	 xtBtK7qbXQL7wceUJtBICIfvm/tGcMK8L4JcHToq9BIYwiXpbnpCoTppTwi4a0Xg4hYX6
	 Fh4M2x4l7ywj90jsS6SP/tuWKTUNck6O8BnzHy9txyInLqFZInB77btSw4p66oLN4lVWd
	 xSMKviLBddpa2ORb9gdKsVaegNjROBFOVUyuGaYi1sgKcI45kPLMRac9FWVlBowxBWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292581;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=IwZOJTDMawQ4UNnA78gZHvTpYkIrlTeCJJMbG+5ZzWY=;
	b=U/5hUhYCYlSxFHIHVdlunKUEzvT7FDf/kkz4LCC8rOZ4VlQiTbe/TfHI1eJ/KE1ri5HV
	 mbssJHiTT8pV63k5ct+Q4haU7bF0TVvNcjWFUl/leLM8e8/qVBJYSwOputri03+l5mEJ2
	 ZfVCs2iHKbpANwTjgbhnS/gZENjK6T2aqCAv1VA5VrW/PIRdOLn1yFSio6RIuGE1Bp7s6
	 JL2vDlCsYzv/R4XxQdAn1xArKHs5ozc187cc+w/vmqP7lcl4gIgMR1dGemRZAddczu6DS
	 ExAEC1hWPGsOaoSjzgLi6z4O1u4szn7a31f/x3NwC/N+nnKYi1/+Wb4/nwdyjOddSfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ii8G05K+;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B76606A326;
	Tue, 10 Nov 2026 06:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33B76606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ii8G05K+
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794292575; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=IwZOJTDMawQ4UNnA78gZHvTpYkIrlTeCJJMbG+5ZzWY=;
	b=ii8G05K+IsAD3FmxhhLMbpYIsLJkyiliSZhUQnCskY+NahyXG8GPuLP4qClgu+vS4GLTgfKWOyTU83NVPVTLnXKpHjVpziN+8zALZaSGoWGQObxhyBqNFIX66jbaMmp9b+xT/7VVr5kaKiPsY3MhpPP/75Wc4iD5I+wS3qyEu5o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XEUO5Jc_1794292574;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0XEUO5Jc_1794292574 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 14:36:14 +0800
Date: Tue, 10 Nov 2026 14:36:14 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] net: free_netdev: exit earlier if dummy
Message-ID: <avK7XqLvdaeWlp8o@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20261107161415.1917665-1-dust.li@linux.alibaba.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107161415.1917665-1-dust.li@linux.alibaba.com>

On 2026-11-08 00:14:15, Dust Li wrote:

Hi Greg, Sasha

Can you pick up this patch for 6.6 ?

This is a prerequisite that was missed when 6.6.y picked up the
dummy-net_device conversion of the mediatek driver.

6.6.158 took b209bd6d0bff ("net: mediatek: mtk_eth_sock: allocate dummy
net_device dynamically") as d5d57501f543, followed by 16f3a28cf5f8
(as 81e82340170ae) and "allocate dummy netdev sooner" (efc91ab1d97bd).

alloc_netdev_dummy() -> init_dummy_netdev_core() sets
dev->reg_state = NETREG_DUMMY, but 6.6.y free_netdev() only special
cases NETREG_UNREGISTERING and NETREG_UNINITIALIZED.  So every
free_netdev(eth->dummy_dev) -- mtk_remove() at
drivers/net/ethernet/mediatek/mtk_eth_soc.c and the probe error
path -- walks into

    BUG_ON(dev->reg_state != NETREG_UNREGISTERED);

Upstream f8d05679fb3f and b209bd6d0bff both landed in v6.10-rc1, so
mainline was never broken.

5.10.y / 5.15.y / 6.1.y - alloc_netdev_dummy() does not exist and no
                          driver creates a dynamically allocated
                          dummy net_device

So only 6.6.y need this.

Best regards,
Dust


>From: Breno Leitao <leitao@debian.org>
>
>For dummy devices, exit earlier at free_netdev() instead of executing
>the whole function. This is necessary, because dummy devices are
>special, and shouldn't have the second part of the function executed.
>
>Otherwise reg_state, which is NETREG_DUMMY, will be overwritten and
>there will be no way to identify that this is a dummy device. Also, this
>device do not need the final put_device(), since dummy devices are not
>registered (through register_netdevice()), where the device reference is
>increased (at netdev_register_kobject()/device_add()).
>
>Suggested-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Breno Leitao <leitao@debian.org>
>Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>Signed-off-by: David S. Miller <davem@davemloft.net>
>Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
>---
> net/core/dev.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/core/dev.c b/net/core/dev.c
>index f9436563a2e84..0d88d285c713f 100644
>--- a/net/core/dev.c
>+++ b/net/core/dev.c
>@@ -11093,7 +11093,8 @@ void free_netdev(struct net_device *dev)
> 	dev->xdp_bulkq = NULL;
> 
> 	/*  Compatibility with error handling in drivers */
>-	if (dev->reg_state == NETREG_UNINITIALIZED) {
>+	if (dev->reg_state == NETREG_UNINITIALIZED ||
>+	    dev->reg_state == NETREG_DUMMY) {
> 		netdev_freemem(dev);
> 		return;
> 	}
>-- 
>2.43.7
