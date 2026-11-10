Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340444;
	b=oSsU7sUz5LIn/cjjFtH/tUYjyBFkFe5nCQp4L8f6hrNzMQyqVTr3rlp/eqf0RYz2/gEp
	 dZbLsV9euDSOIdS6IXjqlG2cqJtjBKOe5/iK3pzhQ3cSFYVlNlGoYG5ylqpZgfCVug1U7
	 LgEUT8wLRBiGqpa5Mf8yAv/hohz3TRXGYx1jAWYo9nCqSIm6hyNTw0aDeRKD56jQZgLkG
	 LfdgnQGEQS/F4zPbFMjBEYwku6k5vSrMdpQcDWdLtcSOHM6NmM1EbXMkTHDjuhnC+N39j
	 8knTI5WqeVT0CfwQcQ6pfzM5Yq3cWmZ0+8Y4ObAyOoXujmVUVqjgsf7eGYus6u/aKug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340444;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LkN11f08LkQXG0Z4i2XEjrbGz/WKTj7CsKa4stpoFdM=;
	b=Cnn6XkHadYmPQrATX6IdgWf8EfTTBIDgp4w2L5nZXnQ+Oc8w16NBP1g9e7WaoXpUeUjl
	 1iiuHLrV0mjDXO36kUhWKBAzLZnOj1t53ZKlH5XPzlTISHFSQlSPin0S8d2S4RyweU1OI
	 HQXPGkPLn40NzX9JiztVa2T61DiSry6yMxcm6g1GTLxXQV8baUt7M06QdMKCwKS6SDWAt
	 IbKxw/ZrUMGruDMwLb8lk5bgmAyxZu4R/+czgnMPbQMNTaqih89acCD8I5k79JRYmrQLl
	 Of2pM6FrtLDCYvugtwR/Fo7JHe7p6Uzt3KrQIezHKikbLKARJwldf8XDvLGQm/L02Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=K38FjhYf;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 003F5606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003F5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=K38FjhYf
Received: by dvalin.narfation.org (Postfix) id EF2D41FD16;
	Tue, 10 Nov 2026 19:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794340442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkN11f08LkQXG0Z4i2XEjrbGz/WKTj7CsKa4stpoFdM=;
	b=K38FjhYfXzNaxq0/mTe5KcJiD+4g6DF1AMCj5Y2Kr3UerzdeBi7e/Q+OpKzxSJDfE3/Ylg
	WL2d4clY9jb33kcv+8h7n5yFnyQ4znsRWiccnjO95PmRGa5NFr1krmxfVLAqKnvZ58usBh
	cX/6njdbETmBkO5EZXgNRE9VTEVQR+o=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5.10.y] batman-adv: tpmeter: fix u32 truncation of reported bytes
Date: Tue, 10 Nov 2026 20:53:57 +0100
Message-ID: <20261110195358.412408-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202530-failed-5.10-1025b76d1328@kernel.org>
References: <20261109202530-failed-5.10-1025b76d1328@kernel.org>
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
index 3a1561f579198..7910e7a7f79fc 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -225,9 +225,9 @@ static void batadv_tp_batctl_notify(enum batadv_tp_meter_reason reason,
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

