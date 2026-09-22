Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7282FCBF6;
	Tue, 22 Sep 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080987; cv=none; b=s33Oub4aPcae4g/ganRa821jlAKTg/CiGPX79phMnjDiTiUlLSZ59KfdpA9iMNIaeYGsv7IkK0BfdBCKFrBZ6GU8IzTO2zfPIhBKuOMTViSqJ6lmFQ6pDZ43Nmzr1j4Sx2B0NmIBztPXcT6b1SWNMUii2KVN7wUjfBKwqmgRm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080987; c=relaxed/simple;
	bh=L0BFb0MRMWNJAEyVL4vg13EtcNccoadLPCaffIUTt2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtxKLPAt8KEZnTaweOQOo49Ul5uQ1oQzFM1jUhW7fhYEFEQmwGoikkahIvS35gdFRfSXa3kKCpZOzsmggefIji5eVA9yhvwpSEYY0w2rZJJXJvzMlnfCqFxXf0ZPjLhTntDAVCxjtMyf+NcH3Y6nstgdcBKsUR0j+RLU7anU/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bL6aXDMr; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bL6aXDMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=UQMVZR7bVQz/sE2rQ7Oi7HxPrv/jQ3e7sAgi8F8An/U=;
	b=bL6aXDMrst6lk2NFKD6Ol0yi5HnAthxMTQGNKz/L1lzaf/SFtIGtLmRJq6JFgF
	IsbpJAPLexX6oLZIXKcvOhB30Liap0aRj6cTeoUe5lunRMgvCCKxdC4ME2GskHbf
	jakLG7O5nlEVjaBpcbS1EoDFFAbvsmy4VMv1KLZNiy86c=
Message-ID: <6ee07707-a1f2-4f3d-8ff7-d309e94c3dd6@126.com>
Date: Tue, 22 Sep 2026 20:41:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: do not cache the new TSO MSS before
 it reaches the DMA
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn, stable@vger.kernel.org
References: <20260920061609.1919876-1-xiaolinkui@126.com>
 <178997153300.2160803.9722094587431911734@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <178997153300.2160803.9722094587431911734@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3955_d7JqnfIhAA--.28161S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1DWr1rAw1DuFW5tFy3CFg_yoWDKwc_ur
	yay3srG34UGF9agFn29rn8ZrW29FWj9ry7tw1kJayIgrWxXa95uFZ7Wr92vr17A3yYyr9r
	CryYq3Wfur13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1hID7UUUUU==
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqB9EG2qyd3-d8QAA3U

- [Medium] The commit message of "net: stmmac: do not cache the new TSO
   MSS before it reaches the DMA" describes a failure mode that cannot…

Agreed -- thanks for the analysis, the on-the-wire symptom I described
cannot happen. After a mapping failure the abandoned context descriptor
stays at OWN=0, the error paths never advance the tail pointer, and once
a later xmit publishes it the DMA suspends on the not-owned descriptor;
stmmac_tx_clean() reclaims the slot in software but pins dirty_tx at the
first descriptor the DMA still owns, so no later frame is ever segmented
at all -- stale MSS or otherwise. The real pre-patch consequence is the
wedged TX ring you describe, recovered only by the reset path
(stmmac_tx_err() -> stmmac_reset_tx_queue(), which also clears the stale
tx_q->mss; reachable from both the watchdog and the DMA error interrupt).

I will respin with the commit message rewritten to describe the stall;
the code change is unchanged (keeping tx_q->cur_tx on the context slot
and releasing it on the error paths is what prevents the wedge).

pw-bot: cr

