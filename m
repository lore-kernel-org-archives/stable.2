Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004802;
	b=j1UNUExgBlO7cqALTH2xqq6/OCT5vMl5l3FkF2d7pjtzcOl1y3XypotN+WDEHagyxGQJ
	 g9Any/ZTHtjhxW0jKGZlA8ZOUb69CXyqf4BH/+trT3XSLgpwFWYvgktdgWhbqGt+DfA63
	 7dkAECb7RT/jXmic38eYd0lKrW2n9uX9EakoH9Yz2Fsl8JGYeRD20oKhu+EyIbP7TLTMh
	 IwGMuQbIxNzfhn9LHA0aJmVgXTMLLJfztjBywmmGQsvgxk5x9tIIVyzCFmERNKsiS0Wi8
	 53AIDHwcp98xfVL10shVXZJDjU5L1IyGDqR6eNRq1YSdecj4vjMdZdH59pzIHWfhyaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004802;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7RJrvzHfyRH2NludABJx8SkoHJ3QglEZ3QwWWnb4wDA=;
	b=Or/kz5LED/xBSWQYCkpyOs837YxS8phvdXFuoOqglBI4XLslnw6nCkSKcTBAtovW7qMR
	 SIcGBBDPnAV5h05p4kDoOeVNng6aRF2lQMTwQStgb67itj0ZTj9ixQfK1ad6rWVdBk0dS
	 ZqXw81SQ2G4zlPCYBRBVs35FgdPm9JTCldvurPumcB8j6a5Xo0Z4yqLP+jKjqBLHWtn2+
	 hSPQK4Ozi+BKS1lfljFjq7Y0kb7MpsXcjHzriIgKTi8jlKQk8jTtzKAsk3l5yRrRdJMrG
	 rRBp2HLp7jaXsaJurxK6dPpF2l7KjEbMC1GdRe5RTaOkMVDy/5tZ0a8mgL9fzAKOEnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=BSpH5Q1g;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7D0DA606A32F;
	Mon, 26 Oct 2026 08:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D0DA606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=BSpH5Q1g
Received: from kero.packetmixer.de (p200300c5973Ce5D80Fc8DfE94A24022D.dip0.t-ipconnect.de [IPv6:2003:c5:973c:e5d8:fc8:dfe9:4a24:22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 14259FA0E5;
	Mon, 26 Oct 2026 09:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793004793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RJrvzHfyRH2NludABJx8SkoHJ3QglEZ3QwWWnb4wDA=;
	b=BSpH5Q1gjJgaPjEeU69CRTXANs96+8PUv+2GFHU4S9QsYy3lPOyo5TJRxzmiDT+6VqIs/d
	4/Nx1+6SytFBH1RyrJl0aAi1hbH19HB5Puhwy1B7TJ/illVhP6MttibEckOYDtPb44f8z8
	dGu4z3sCB+uR5MVzE8SQne6wbhM5GF8LlCFbdNvHKtwxipmG1uI5W2lvysdJFlT/pyipmq
	JITBCi4KLXfBEykXmr60KgXPXGOmPPHbAWBkoIgmAeQRUkWE9L68uhCFmif2utFFW8fwQF
	uItBqqmwzDyo2rpMqDhh64UkmhgubTLfKgs7Khn57zICVadFJenWIuUT2ib8hw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 03/10] batman-adv: tpmeter: fix u32 truncation of reported bytes
Date: Mon, 26 Oct 2026 09:53:02 +0100
Message-ID: <20261026085309.1074911-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026085309.1074911-1-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

When more than 4 GB are transferred by the throughput meter,
batadv_tp_batctl_notify() will cut of the upper 32 bit of the u64 counter
and thus under-report the actual transferred bytes.

The data type of the temporary storage variable must therefore still
continue to use u64.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-08bb3be4-6c6a-452d-b4e4-606940c6cfa5
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 022eb13e8ec47..56feb02d2b7ef 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -221,7 +221,7 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
 				    unsigned long start_time, u64 total_sent,
 				    u32 cookie)
 {
-	u32 total_bytes;
+	u64 total_bytes;
 	u32 test_time;
 	u8 result;
 
-- 
2.47.3

