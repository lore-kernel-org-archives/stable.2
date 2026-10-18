Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56203B4E8F;
	Sun, 18 Oct 2026 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343136; cv=none; b=gQ1jL7YN3xyi+W17Fx9xY//bNA/xiYfglcxibJ4CtfBiYAzdSJcCd/lSX9jYImO3JTXch3PaDbmWXaHV1LFt0VuA03Sk/abpOCtL9aEYidw1fswWh5xy2bRgfC3E2SbvL32ejI1qwTUEY5XP3GdGci66fKHU2JXxYLW6yDCrEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343136; c=relaxed/simple;
	bh=sv5UIdnnKbvFM8wAL1VxgEDtqX6UqRxvUMkVZYxLR90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=al3uussJmn+th5iTcUJAyEONEKhgvXikNQaYomnZFtmECaXTbXCDTMKekUJcg+n9tU3l9/1e6LCErOlH7KnIF59zn6vnV8hKRVCOP51fvEYBiQakLoW9vgUfGQDhFgkk6x9CEqPXBrY73VRuPKKGPgguci0Di8cPAKyxDke0m7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tAy9H1St; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WPkOMlM6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tAy9H1St";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WPkOMlM6"
Date: Sun, 18 Oct 2026 19:05:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792343132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXRIhKqp7p6mjXufeJEV1PkBtP6sj31ZyFXrbBHAoKs=;
	b=tAy9H1StdBEcMqaKjyOrqAtsnokQFrzlwJElFTkaHnAuB+h3WOKUiLnqnip1U4SMbX+qUo
	jF5OINXK0XeFewmO10lKZ0scpUBv2aG2vyDfBbQjQelUrjpN18TDDbsOIVRoUPCE5A3jlU
	1gR0bHTHIf76ZIysMu5fKrk6/jbpnUPRmjzcRL2tjqd6ozpzSvBYuklE9IXHapld1/LcVJ
	QkuYZnmBH2MV1BktPOt5jf06ry2bjLMr/LMgB5RQg6wFktI1WiHloR50vwDWwN5cxnXuh5
	MfELyZddkwJTITM8dzlxdeUxVsrC1rCdte9q16BfNo/apuJXnLKZaa1c85mfgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792343132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NXRIhKqp7p6mjXufeJEV1PkBtP6sj31ZyFXrbBHAoKs=;
	b=WPkOMlM6tdboPyJXMr4TGyGutKlAxTAQFHzNRYj4vpD/rq6GyMFs5SKU/hvrI7h0KqsecF
	fA0/cHR/4xwYGACA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Fan Gong <gongfan1@huawei.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xin Guo <guoxin09@huawei.com>, Gur Stavi <gur.stavi@huawei.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hinic3: bound the Rx fragment count to MAX_SKB_FRAGS
Message-ID: <20261018170531.bILLh5Zw@linutronix.de>
References: <20261010030901.1712792-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261010030901.1712792-1-yhlee@isslab.korea.ac.kr>

On 2026-10-10 12:09:01 [+0900], Yehyeong Lee wrote:
> hinic3_rx_poll() takes the packet length from the Rx completion
> descriptor and turns it into a fragment count:
> 
>       pkt_len = RQ_CQE_SGE_GET(vlan_len, LEN);
>       sge_num = pkt_len >> rxq->buf_len_shift ...
> 
> RQ_CQE_SGE_LEN_MASK is a 16-bit field, so pkt_len is up to 65535 and
> sge_num up to 32 with the default 2048-byte buffers.  packaging_skb()
> then calls skb_add_rx_frag() sge_num times without checking the count
> against MAX_SKB_FRAGS, so a device reporting a length above
> MAX_SKB_FRAGS * buf_len writes fragment descriptors past the end of the
> skb's shared info array.
> 
> Driving the receive path with an out-of-range length reports under
> KASAN:
> 
>       BUG: KASAN: slab-out-of-bounds in hinic3_fetch_rx_buffer [hinic3]
>       Write of size 8 ...
>       The buggy address belongs to the object ...
>        which belongs to the cache skbuff_small_head of size 704
> 
> The length is chosen by the device and an skb cannot hold more than
> MAX_SKB_FRAGS fragments, so drop a frame that needs more instead of
> overrunning the array.  The buffers it claimed are already posted on the
> ring, so return them to the page pool and advance the consumer index
> over them to keep it in step with the device.
> 
> Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

How do you run into this? With the default 17 frags and 2048 buffers
your packet is larger than 17 * 2048 = 34KiB. Is this with a large MTU
or does the HW merge packets on its own? Ideally you would like to avoid
this from happening. The user gets just a dropped packet with no clue
what is wrong.

Sebastian
