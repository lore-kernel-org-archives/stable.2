Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC453C0630
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152771; cv=none; b=bOjIQKJ9AgEH8qjW2o1d9bjInP8iN4crLHABG611f+OHkw9QHVLD+42JltGmVvoPwlID5p9NMYiD1rbMtApwU1VIH/ZcpLK2MeTkHsiR31wDpvNjqyj0D6UkIHJIr/1JKEK3PoF7rKekN5pcD2xCwJ7XsvIJjcpWZM21v47cVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152771; c=relaxed/simple;
	bh=fFvJv1Zt/u80U07COJui3/88+QeLpRmvKtlN+o/oM3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvzjyKXoZgC6FYZTBCv2oIaavYvk8Gvh2HgTSYi5kaMrFzt+3iy2vQeemG4idQuSVQeKc1I69IHpwMWGqsPXpIvmXnwKtWnuNh1zeHD8TfktAYW0ZU8OTuLYlHpJ7m7FnbVxlXECkT9SVP9KG3pzFJlmijLelZs5w45XW6yIoU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=sZHnJl70; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOh7Sm3r; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="sZHnJl70";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOh7Sm3r"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 54D30EC012D;
	Wed, 19 Aug 2026 11:19:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 19 Aug 2026 11:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1787152767; x=
	1787239167; bh=PJqYWBGhIO/ApIjLOU/ir9yauEuDs0PeseaQtZOAAnI=; b=s
	ZHnJl70yyk+sFvZ3i13EfZ6E+xtZQVk+6ZumBe0XSZfNXyj9TSqIRmEA6PO1MSHE
	rRzg6VAkZSkjd1JMA2olrbPURIekbmrFZT8Kbx8+J1T/d2/erat6UZOkPOFg+L54
	HXzAk1HyZUTSCJt+k6P01Ad5QHJD49mYiJVmm1NjlcNjRzWhfS1xMY+cRZPMaKz8
	rQpABpUrnCRVXkRnSS5Dgba6jIWHURH+IDuvQ/rVowKqH62CiWRguhEXYKzCzUaV
	Kn6lmox5ytWAKGczGMNiYfNSC/6Rh780RYiEZw/ArYXhSzoawf7xUQOxrk7cRnrx
	se2Q5n7tqyG2PMXLPt8iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787152767; x=1787239167; bh=PJqYWBGhIO/ApIjLOU/ir9yauEuDs0Pesea
	QtZOAAnI=; b=LOh7Sm3rp8E4Ts6Q2UwRP4jNIpwfnhIRsRkCGqecgB6w+2uctIU
	irUDQ1MRb6vZvs5u66KZTZ1PwhIjjGuH6+lvzqiLjKZXnFKyamqk1ftSYuQaaUAt
	5lnl8m04fRiBZuRLpPTofk4ntR9yOMT1O5mPI2Sd0s336EApd62oG8/O5z7wbNEy
	g2p1/iMMlcqIV/vIOGTqhenx0iykXvoikuSkhg1SEEnhOQu6pJ28JwDydoTkCp65
	//f1V0vxypiPOGTx0dALdWwLRnzC2/vTVP5Rwlr2FQA4PVoAbjaa1HIHwfbQKzou
	26z6O6+O8ya4+oDj3tsiOpZLMyRdpghS3cA==
X-ME-Sender: <xms:f8mFatZGxZk3f030AY51g_gp8YaJNKQ3Y48SZmm74vBOX1_puENLUQ>
    <xme:f8mFar1kvUk4xTls9vH2I-kWw67MGMx0LanAgLLiZvlw9gTn1xNcHFp0xXDRlesL7
    Xh9B1rB8ROphRhhsvYqFRZ5LxOX9Ij7480jNMXGaOyYn69AeoYnbw>
X-ME-Received: <xmr:f8mFatW634Y57ysbB8yruaDLaiZZe2tlSfkOVNpw6XTSEs9t6c_asNne-FA>
X-ME-Proxy-Cause: dmFkZTFnC/HYFo4iXEnvoOres8PrKgWw0UjhaQM3Oe6n9emiZgmBjG0+pc9903RX5gKety
    DCVn0l/gyGf/qFNtNuNYtxNHPRmZ44R+JO3MkL8WPTcRdmzhCo1d9U5RdqFQzl9oElfy66
    dh7cQCpq+Lx+3VOI5VGTEYJebp6CEgDt8IkGSas+jc0hJJIGrQU1DAZSQkD8qADkWdSIxc
    aO+Tn+J2iEvy4K3I4vlH9pQSI7H6aR1pWheguhcslSn9s4brUN9Mn7wss93iZOEX91aEZt
    R5XksaXa3EFMOKB7Ge5d68XuTQAVCvP39oEOzynA0I3wnNobPiyI/Ali0jd69eeM/sedLW
    Z/0e71tink5x7cg6xf0qdSOMjXAV3eoB9EVQXqYoe9Ej7cYNnlDhA1jszlTeFIdWureeeU
    BtXpLTdNwVp6FRnk8evx2yW9Iq2HZdSQ3JVFQ30PjTCGb+jx70xpwZrOv3JCJM0jMtvTIv
    YpTUWf2SEoMJ+yLJyevB5Vy6rq8Wp8jahfnI/2D2phbCNsI1bNQcRz9lBPQuxonD4sZR68
    xrPmQq/hrr/SEwqWaEbjXHrl4iXrKx34jWz/V9UOlbS7XLREGh5GmvOkyMixpfjYAFgHLm
    Oub4E08ivzIBcxbQSMvv6B1Tx+wZWU+ppvFTU021Gyw0De93gol1G4rL6rXw
X-ME-Proxy: <xmx:f8mFalVuREq7p9usikLVcK7RO7R1T832ixgNs1JoHegsqBZk_HTIWA>
    <xmx:f8mFasfTAPG53C_mHtqLMhYH9r0apuzc1D2xRv2l2Eoj8XOWqD0Tiw>
    <xmx:f8mFauV2pDOoZmZc_b8MyvRdED2hb5C4pFQjt-UNjJO04iBu-EvZdg>
    <xmx:f8mFaldnx15x-g_Qotmit5VDI_LQQJ_qwr4QZo_6fTzXOKTfvsoMPg>
    <xmx:f8mFageoBeF1Oe9Zth3unrw7tJlQDayAyIKao8H6CcVsJW6clRgGvltB>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 11:19:26 -0400 (EDT)
Date: Wed, 19 Aug 2026 17:19:24 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.12.y 1/2] selftests: tls: add rekey tests
Message-ID: <aoXJfMDP52O9vZVY@krikkit>
References: <2026081717-verbalize-stylist-2627@gregkh>
 <20260819113944.3620902-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260819113944.3620902-1-sashal@kernel.org>

2026-08-19, 07:39:43 -0400, Sasha Levin wrote:
> From: Sabrina Dubroca <sd@queasysnail.net>
> 
> [ Upstream commit 555f0edb9ff043196655a5b7cc65f67dfd05b530 ]
> 
> Test the kernel's ability to:
>  - update the key (but not the version or cipher), only for TLS1.3
>  - pause decryption after receiving a KeyUpdate message, until a new
>    RX key has been provided
>  - reflect the pause/non-readable socket in poll()
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Stable-dep-of: 1c8629651cb5 ("tls: rx: restore msg_iter before TLS 1.3 optimistic retry")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/testing/selftests/net/tls.c | 458 ++++++++++++++++++++++++++++++
>  1 file changed, 458 insertions(+)

All of those rekey tests are going to fail if you don't take the rekey
implementation as well (which I hope isn't getting backported to any
stable kernels). You probably don't want that.

-- 
Sabrina
