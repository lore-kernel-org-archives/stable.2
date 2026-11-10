Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339972;
	b=kNEvaNg4QwD2C87Iib1kQMBSuNDncJ3nbdwOf2lju0/jwQdwUqt46Iynpx0I/tgjAJKh
	 727yxwwSkz2Y6RSMGlxQ71RtavtOeetkGS4RDq7qdFgXGcl8RsC3Z0M7agUqla+Dfz7Pf
	 C34Q/lrZkQ4PFueOyLHayjjDGJrsUrY5w55Vg8V50jeMlD1KwBe8OWVu9w/1F5gjX5Xkn
	 c8LQbEgg36K+PdAtWul7Qg2i8X1Yd9ZldHkAbvqTK+KxbD6IKmrv2EJGRaBuJ62pXoi2p
	 r+Ta4kM34C2sQkdXGfz2LpnVr1VZLUECHbIyL28xs8HTdCeWGE7RsPowLtYGNQEBLiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339972;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kzFnsRRUDNlAE2+m41DsMO85QJ//N64+gMcBAOh8hWg=;
	b=mvH0LfPbz83G8rb9+rlu07pP7HxdZul636PIK6Mh4BUXCUO7TzL9AXOoKR8a0sUuk52i
	 psZfFe/AokmKme6hxMWDMjDSBUPjehsFir6tIxM55oyHlfwuWyaMeLGOZ7MNNXrTubbv6
	 ZeyRuKphP8DwMHqw3m32mIyp2TaJQs7/AI3rEW/hgCLpnRsp907Wt5nK9G5PE0C0o6MfK
	 C1l8UrWcgUzCcBADP4+M1zlUXgBtsD8HTUTv911DbCmnO1ZJHCaEPDjEfvSDL6oecpPwI
	 1BdT9lXAuDIvnV/XA812yDBJSHm7Dc/L+pOwvapofVmG68Jz976DljNWLmBpoJ/k+hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=2SvKYeQz;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id AF0F4606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=2SvKYeQz
Received: by dvalin.narfation.org (Postfix) id F22B620292;
	Tue, 10 Nov 2026 19:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794339970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzFnsRRUDNlAE2+m41DsMO85QJ//N64+gMcBAOh8hWg=;
	b=2SvKYeQzrlVxSWuJ+saYglsb1MvfxiY3fD+V0B16GwZObpL77qTJJkKWeK/poxuQNuHaNk
	2cIprgnjUhsAKIfQyABzNPX3kD7Qo+5l8uKoxBs8bkYMND4E4NT9wGSffcIKv+SuOSySrM
	RGj5VRZgQCCIafKTuR3Zy3uYmmo2Leo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5.15.y] batman-adv: tpmeter: fix u32 truncation of reported bytes
Date: Tue, 10 Nov 2026 20:45:48 +0100
Message-ID: <20261110194548.357110-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202022-failed-5.15-1025b76d1328@kernel.org>
References: <20261109202022-failed-5.15-1025b76d1328@kernel.org>
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

commit 1025b76d13288a311e8259a0eefde0854fa63c41 upstream.

When more than 4 GB are transferred by the throughput meter,
batadv_tp_batctl_notify() will cut of the upper 32 bit of the u64 counter
and thus under-report the actual transferred bytes.

The data type of the temporary storage variable must therefore still
continue to use u64.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-08bb3be4-6c6a-452d-b4e4-606940c6cfa5
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 5514fef54b0a9..1c19da01fa2d0 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -226,9 +226,9 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
 				    unsigned long start_time, u64 total_sent,
 				    u32 cookie)
 {
+	u64 total_bytes;
 	u32 test_time;
 	u8 result;
-	u32 total_bytes;
 
 	if (!batadv_tp_is_error(reason)) {
 		result = BATADV_TP_REASON_COMPLETE;
-- 
2.47.3

