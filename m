Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077128;
	b=ArIRTFcdVK7NBWsYf5Al0Lan5sUOYAVXPVPOFHllyMzal0/qOdvgZKe0SZboDTBuirq6
	 ukUWtua3YmISt3CQeL8pkSyF48mVKWWMLIqcjKYNuarADbHSHM1bHeyrHOXAq+Nf4dZMF
	 afmwsk6o93qLwBIHrmDWi86mUNJvr5J9Ym/fYmoyPODDtfimoLFDfI0H6CBX3Xl3eLrh8
	 q4ZPg0ZIxWSt0b8PhLYgg3ZZtnQnKnRD3eL3S3zqKQOP8KYcSwKb+i1OMheXx5i/GZTdU
	 2tsAsJt9dObwHW1eb0zmCq6ohn2k5k9FUvqMMZ8xuFr6xZkKDT9++l+uPuXtV6b47cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RlzMTQzCFpxVROwXqnNvs3tp4ryHSFfSB1hSKsQ7qqQ=;
	b=cIt84UQSncCl1RDxq1LOm0BT3490TboNg6RXXaWsw9EO85cwDEVMxhBxx6L5tWl/KSk1
	 TUnFVyvCxoHyQXKFHboNjOeoTF3XBl5JE/XROAtbnEAyRgm7YgLqAuOe0ftLy3eWmggIs
	 onqJH+hKxbCkFLzjbSCQt+14o4T061de1UYvWKJCAZ9bxdi3/8c8UFARzcKmwaB5KvcY5
	 EXToFuhQ59NiuPORFkopzJKWNip1z3GoB/Bfs67dc+T+4L8IAgdcoP0J0UGUqUgzwPnjo
	 xMRzmnt+u1iRD2bdefVxL9riXRj3vwyEy5a89+WtqHiAe6bmDxiivK/bAXAoc4J4YAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWcgAdHO;
	arc=none smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660EB606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660EB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hWcgAdHO
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c14f3dab0cso1370788e87.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795077126; x=1795681926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RlzMTQzCFpxVROwXqnNvs3tp4ryHSFfSB1hSKsQ7qqQ=;
        b=hWcgAdHO7ELlc+BGrTfeWsm8KT9TUWWSbRQcYfhW4CaCbAkySLZ65r0ZWHFZh30V8Y
         iXRPKmmkTlO80wi2aU27GFCkGYBJFki6qOwBuB2Qw0rvKSPoJyUudH9YTVL3vIYVpO6Y
         rvp0aL6HKso7NF/HxxKljwlk68fABbdbn/z5e6cA/aLTWhXj1evLj2y1nKnZjEemMZts
         +iQV2ky/K3Ox9/f6PrKMa00m8yexW8aqN1101M8rZgP3a5OT7ZGx4qe3h7Q6il2iubQc
         VoL1KyYTHKWh0Ry1WJ5cxEohFAHWYn+a92Q2JdRONpw80LJ7n2FSssuWRvU9b7HahQho
         rbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795077126; x=1795681926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RlzMTQzCFpxVROwXqnNvs3tp4ryHSFfSB1hSKsQ7qqQ=;
        b=bK+4MN03OtXsw1CxLZRCSOQNfU93gG2NGYmCDIjLuqvFk+slbnWAf9WV7cyBC+J13/
         G8pHfTgFwwqudCd2AnUKQcDOPpOcdjrdQwwl14PemD+/RRxjV4tERD6TG7Dy2h+25Ga+
         R6eh7h/72B3Q+pQI6IlO3dvhcfZwKJI42jnksExxHpS7f/pTHSATso19JjWtmBbipG3A
         sHcBy+EVvmm2ZzjkRV9i5QZze+un423Pxa0lzQq4ra/i8Gfdwbh/IeYS8298oqfh4+G5
         SYUCf9iB5WVxSz29YLmx77WZc9RWYv3K1M3cijWdlaE8QrSKpzxHZpN+6nDag/F3EkFL
         TNNg==
X-Gm-Message-State: APuU4Z9iqm0psodzmZ2vl1JpUZkuM5K+xagJLUfAvjwTlfhs2LNTPXC5
	GfZx0NA7fc/JkoQrsTzBMz5kxh6gTUC3aGRjfgFASHQUAwxWOLPDByY6n0OQgDl9H3tbhZAP
X-Gm-Gg: AYBFou1XSBvnRVTxC3YG3LLK81LxMN7nJQLy69uQ/pRPv34MtwXTYcAfuXbfv1khjNS
	DbjkH9BC+vbKPgP+i8g6p7WyuG3xnxOFEBpK3fzpfIuN3r8Pj2UeuM1S3n+AO/OfD/hlLjrZnGE
	AaD4d1WtObuioG0ckjW0zB60hAUPHrA2nyts6wh7tqt+bUmd1JZ7RogDL+mpvuqPCHeKCedwz55
	cUnfUhtFYE64E8+K/HBK3Kl2Y8gLDLUO4p+OoFSa3XfpU1x5rH8Rg5NUA7Q+W93HRKnjPNMcOFp
	sY/P7IjeRzmibJXkQjY/GUdwHmyfEVZ8Kg3KG0sqTK4PEExKXOhzJPD7RML1QYZbPEYemTCApZ9
	5CG3n6TStAsMqGPX3KJJ07s/vZbJhqp0RDVvPZmhXmTHWddb6VtE7SC1LcN88SJnm+tc/y9ndsu
	ofY7qu+Ym7K7RHKcx68+cInG8Ugm9ty0VO50PBccyuDNKirGoKHubtyLakXi9vKniCSZaz6ej3Y
	JA5X178JTFpYZvrAXqkZbT3F8rrEnXDAXPZnVCyjzZCRG9mPRVUNtGn13XMg/VRofMnE27pFacg
	8F4QG/DHUxb8kAoo9qDsKxjdXEhkuDblBrt9Vsh3Ox8OS9Ck7X7ushxxqSzFqvlmcL8AkOAGipR
	MPuzVe5VfGKhwzR7XN0cs/9mcrEPJGYI9UHFIyw1XmbRim8p1
X-Received: by 2002:a05:6512:1286:b0:5c1:57b9:90cf with SMTP id 2adb3069b0e04-5c1a9a6fedfmr1806970e87.3.1795077126193;
        Thu, 19 Nov 2026 00:32:06 -0800 (PST)
Received: from DESKTOP-DIIS71I ([5.18.141.223])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1aa055a1asm1262306e87.0.2026.11.19.00.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:32:05 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: stable@vger.kernel.org
Cc: Hariprasad Kelam <hkelam@marvell.com>,
	Nitin Shetty J <nshettyj@marvell.com>,
	deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	shda@confident.ru,
	Jakub Kicinski <kuba@kernel.org>,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH 6.6.y] octeontx2-pf: tc: fix egress ratelimiting
Date: Thu, 19 Nov 2026 11:31:19 +0300
Message-ID: <20261119083119.1413-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit bb0d96ebe5f4d1acccf4dc36ca7f01f9a8fa1ba1 ]

The egress rate calculation computes an incorrect mantissa and exponent,
causing up to ~50% deviation from the configured rate at lower speeds.

Rework the computation to follow the hardware rate formula:

	rate = 2 * (1 + mantissa/256) * 2^exp / (1 << div_exp)

Keep div_exp = 0 and derive exp and mantissa from half of the requested
rate. Rates below 2 Mbps are floored to the smallest encodable step
(exp = 0, mantissa = 0).

Fixes: e638a83f167e ("octeontx2-pf: TC_MATCHALL egress ratelimiting offload")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Link: https://patch.msgid.link/20260717084349.2227796-1-nshettyj@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Context adjusted: RATE_MANTISSA_BITS is placed after the CN10K TLX
  defines, as MCAST_INVALID_GRP does not exist in this tree. ]
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 29 ++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 1d1e5cea9..01760e22e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -26,6 +26,7 @@
 
 #define CN10K_TLX_BURST_MANTISSA	GENMASK_ULL(43, 29)
 #define CN10K_TLX_BURST_EXPONENT	GENMASK_ULL(47, 44)
+#define RATE_MANTISSA_BITS		8
 
 struct otx2_tc_flow_stats {
 	u64 bytes;
@@ -87,28 +88,30 @@ static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
 static void otx2_get_egress_rate_cfg(u64 maxrate, u32 *exp,
 				     u32 *mantissa, u32 *div_exp)
 {
-	u64 tmp;
-
 	/* Rate calculation by hardware
 	 *
 	 * PIR_ADD = ((256 + mantissa) << exp) / 256
 	 * rate = (2 * PIR_ADD) / ( 1 << div_exp)
 	 * The resultant rate is in Mbps.
+	 *
+	 * Use div_exp = 0 and compute exp/mantissa for maxrate / 2; the
+	 * leading factor of two yields the full rate. Rates below 2 Mbps
+	 * are floored to the smallest step (exp = 0, mantissa = 0).
 	 */
 
-	/* 2Mbps to 100Gbps can be expressed with div_exp = 0.
-	 * Setting this to '0' will ease the calculation of
-	 * exponent and mantissa.
-	 */
 	*div_exp = 0;
-
 	if (maxrate) {
-		*exp = ilog2(maxrate) ? ilog2(maxrate) - 1 : 0;
-		tmp = maxrate - rounddown_pow_of_two(maxrate);
-		if (maxrate < MAX_RATE_MANTISSA)
-			*mantissa = tmp * 2;
-		else
-			*mantissa = tmp / (1ULL << (*exp - 7));
+		maxrate = maxrate / 2;
+		if (!maxrate) {
+			/* Rates below 2 Mbps map to the smallest step */
+			*exp = 0;
+			*mantissa = 0;
+		} else {
+			*exp = ilog2(maxrate);
+			/* Clear MSB and derive fractional bits */
+			maxrate &= ~BIT(*exp);
+			*mantissa = (maxrate << RATE_MANTISSA_BITS) >> *exp;
+		}
 	} else {
 		/* Instead of disabling rate limiting, set all values to max */
 		*exp = MAX_RATE_EXPONENT;

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.39.5

