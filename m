Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4B3DB33C;
	Mon, 17 Aug 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958285; cv=none; b=on5/1WyBg4ZrjZIC3aaxJ/I0g+WJ2LMxqOy+frlg9gjY1OZefxaYCJPPwXkxvedOqU7GfiDnF+6Xxl1HU7MzGEJOkpNh9GcGbbKAg912nMgJacOtUwDPQA03NTBz34yuOP6taz0JtwgVSJH4C8k7llg5qe1OS+c0BWGraIgetnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958285; c=relaxed/simple;
	bh=UHs6IDBjNkc0HenuR0X3Z46jN92fQ6pA8qmh0JQhhKc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=aQob+QmELfdzEHq5oV+hMTxmzwWgkKB69ORxOKuamJqszQZvsSlmnci87gjPPsHkA3V6iSw/cK+57XoEfstApYR4cFP6b3gDchlNJNF7Mr1fpO2Lc5Po4I1WpkfbBEtvxFAY4J1A4H9gvWy41bxIQvV2D5bZ8lk050iauNgBIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=UA2o3nlc; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="UA2o3nlc"
Received: by dvalin.narfation.org (Postfix) id DFE4D1FE24;
	Mon, 17 Aug 2026 09:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786958270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcIx67Fbh9+8js56pY025rLngKW6LqFCTkIScQJflJI=;
	b=UA2o3nlchwDgRh6ZFaKnSp4NqZzsAxuVAwA07ezaQR54iYdWxCF9+8KKYQhp8PX3myZrsE
	Yybh3OdemXsU8hpFWfUk2zCe3czMZ4rvLsg3VU+lwHYLMh55oYUwSavAAyzaBbDk7IF41+
	WCf8NrREd5DfZV9BmifyR+mJIkIfz7A=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v3] batman-adv: reject unrepresentable multicast
 TVLV offsets
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com, 
 sven@narfation.org, Kyle Zeng <kylebot@openai.com>, davem@davemloft.net, 
 linus.luessing@c0d3.blue, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, horms@kernel.org, 
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>, 
 netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260817084955.944189-1-david.lee@trailofbits.com>
References: <20260817084955.944189-1-david.lee@trailofbits.com>
Date: Mon, 17 Aug 2026 11:17:21 +0200
Message-Id: <178695824178.1497243.16045312752677179315.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=sven@narfation.org;
 h=from:subject:message-id; bh=UHs6IDBjNkc0HenuR0X3Z46jN92fQ6pA8qmh0JQhhKc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlNF9c5cv1fF271K/Li1eOb51ybeypO8FJ2v+gC1x6zK
 j6xeJmjHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJmEUw/GJacGRZ52vWQKGn
 Nq2zulcZ6q1NMT9151nAWqc52XNqrrxkZDiyyjC0P4hlz9R1fFMbl1otjNwfkqzEbXP/S9zT+e6
 iU1gA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF

> The network and transport header fields in struct sk_buff are 16-bit
> offsets from skb->head, and U16_MAX is reserved as the unset transport
> header value. batadv_tvlv_call_handler() sets both fields from a received
> multicast TVLV without checking whether the TVLV end is representable.
> 
> If the end offset exceeds the field's range, skb_set_transport_header()
> truncates it so that the transport header precedes the network header.
> The negative difference is then returned by skb_network_header_len() as
> a large u32. batadv_mcast_forw_packet() consequently accepts an oversized
> multicast tracker and accesses memory beyond the skb data.

[...] 

> ---
> Changes in v3:
> - Rename transport_offset to thoff so the comparisons fit on one line.
> 
> v2: https://lore.kernel.org/netdev/20260810145754.828936-1-david.lee@trailofbits.com/

Looks to me like you've also dropped the
Suggested-by: Sven Eckelmann <sven@narfation.org>

b4 diff -v2  20260817084955.944189-1-david.lee@trailofbits.com

Acked-by: Sven Eckelmann <sven@narfation.org>

-- 
Sven Eckelmann <sven@narfation.org>
