Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617540;
	b=22m1YeLM2ZzhK2PSfo3RWWE7H7yVjzsqAOwC1KHmyFn2DV7Qec9HOzW9hIOPM9Cj1+L+
	 kdTBG9Ec7NjD//o+1ZiqxOYr3Q691Kg8VPcGHoVwr7txPOxLrSuFf1GKrszbEh0bwvr/z
	 xtr5N7yXQISV4nHGiSGCSsxg+NYy0mG4K6uwPY+INqKsH70rIA65EUIIwx26sfIIC/T1b
	 6N3RFaSQ88SZMGxtnbwzkB8djXcMZQxfSi9ZUqT9OUSAfDLjZR857UDSo6soZhzlN0a4K
	 tz34EQcwkrY3GeoKXzIBzFB6119cVYDlOdxGuCpISmehGaZ5zls32FigKouq6cxMlLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617540;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fgFYftCXF6S4E/Oh/AUz+tD4AxAuxhNeFxHre40o5Ro=;
	b=jTHlg4VY6+M3cteQf8AMSeJ/u1nCn8H45jVNVMtPFcju0TUeEBueVLApaMi8ap9cc+1i
	 XXtlPLK7YRWpXMlemhwRH0aa60oDc3FHe/3+KIQ8ancCDcoh8b00YDx1HTyZVHjp1FW2a
	 B2DorHxUJG4YQW1usaMDrI3fSfT2rZqmD8xumPnMTbDJmW2WAQnIN9X6+kRkbAb84bifj
	 lCjR5Js34Z8kVHKfNHvlx8EENbgAk1OlGMCsra8jLxI8icjd0v7cP0qrQj9u9k0Dg1YTm
	 5pCPAu5OsFW/L5ZY1y34f5UXFCtbbW7tQsZG9LE7Hv1c9HVAqBDaEGL0rGNmpsqngFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXVgxocq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD0606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXVgxocq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A79F1F000F4;
	Wed, 25 Nov 2026 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617539;
	bh=fgFYftCXF6S4E/Oh/AUz+tD4AxAuxhNeFxHre40o5Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bXVgxocqMqMg5Va3uBl1xX/uQpkq1bRXjHno773Ub031tz3mdkp7FwERoC6TFaEtI
	 3BN11o79vP3cdIy5pvOATifjK5ueeYp4Db9xhzIAvk8fRiDTCkxTiAfrxw1QQKgGwE
	 YWGPkE+I8mI7ZiDVZzFCarN2lXcD/56kMAkN/QjukxmQwdPsmkCF1LIeJpcMpKstD5
	 Hre+D3elhdUIO25KmAyUEopGGwkzMk3UXx3Om5/koIitn/uA98sf5VpcUGyKqkcwhZ
	 Kypl2uuRQnMdPL/neFVzfoqamSIjjx8JsMeTHW32Z5vd54yh5t/zgP6Sxsne65o748
	 QA3y9CGSw5scA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] tcp: AccECN support to tcp_add_backlog
Date: Wed, 25 Nov 2026 09:38:54 -0500
Message-ID: <20261125143848.4131839-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125143848.4131839-1-sashal@kernel.org>
References: <2026112553-cresting-chimp-b365@gregkh>
 <20261125143848.4131839-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ij@kernel.org>

[ Upstream commit d722762c4eaa918d3d2f78b41cca3f480a616d65 ]

AE flag needs to be preserved for AccECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 1c46780dec48 ("tcp: do not coalesce segments after FIN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f0dcfa5af7fc4..52e5dc438999e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2059,7 +2059,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	    !((TCP_SKB_CB(tail)->tcp_flags &
 	      TCP_SKB_CB(skb)->tcp_flags) & TCPHDR_ACK) ||
 	    ((TCP_SKB_CB(tail)->tcp_flags ^
-	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_ECE | TCPHDR_CWR)) ||
+	      TCP_SKB_CB(skb)->tcp_flags) &
+	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
 	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
-- 
2.53.0

