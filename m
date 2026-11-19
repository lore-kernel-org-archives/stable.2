Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795077207;
	b=wg1ebflIHk6fCHECQ9HqRG8Lhht3qtl27Mg9mcEFtkEoA5S3lLjYMaFpcJtrvtbeJMOW
	 0jTjuqO8U2EXd8IcT/jsYjw8Xd1OSc+YLbq13k5LNGNdjGjsX1Qf9bR0Zyxgxm4ZyqDMf
	 oP3gtAiEgR9E3CdSHcL55LGVE99zplYRReu5DR/blX+M6lL0oT2oUir/51CnVqeiY6WEt
	 UtX9xKHgMu269n6fqmjDVn94belOwTzApXz+WuXAcB80SQbJHwbMxStvXMUyv2bFisDo5
	 KyDPWlLn3riG8V0K4t0AiAJDosSMwGUD8MPWOuTNkXNAsL6WpQHzQV51FtuTzJIVAeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=stFHLM2pJTSD0YyKlsGWjLZ0by/wW3YLv3iz6rew0gs=;
	b=YAOzVP0kmnz4q/sxzs+CREth60cHiE6wI4Zx9240dzv+52NKPX2QbwitwlV8FqUT2afS
	 OVsMNhkydm6Xxnv9xPN1A/XwISVCyLccqQrH4AvMVHeXo7OFcc5opgDW/WACOclVzKw+k
	 STWxqzPOWNVUSHdDNLk8sw1j8DwDg5UMM6XRWrREn5W4JJAeZN9D80JI9cOTqLAzth/M1
	 ULSa6kT+ajAtGe/QIGjuSMqdeQ7T/PkwcwLv8tJSQtIZU6pdXrjWz7ptABFQ5AmKIpmhb
	 iBd3DXKgbyHyK2S7U3bzUyvyCfiaf8fXqsJTaAvfjLTwnAlGXOVHek8yp9GBzyCBevw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQjwFivP;
	arc=none smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB99606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 08:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB99606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQjwFivP
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so18035571fa.3
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795077205; x=1795682005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=stFHLM2pJTSD0YyKlsGWjLZ0by/wW3YLv3iz6rew0gs=;
        b=uQjwFivPc5W7dFUXtWrz0oRdu7ORohn/9aka1qQo1dzTnN9ZWB8KkHQizQ4+Yx6+Hm
         b90/zihIBMI07rieyzeLPTJWs+16jUdp9JfN7tWIIQz2AO0bCggrLz0iZrV++O8l94GY
         VFUkNUiufyJu7a2SZEt7ll2FHT7AIfWWO7g5YEWfqNBLQF0lDnZ3Od5CF65pWx7cJe9P
         Txj98apq6gd886lgJ7anB9mPtYg/0BjrJoFQ2hqR3907E8laMvyLHLurNc/2xRIDS14t
         BIzs6NBHRdaERxJyk8SzKc8EgZuXAo347xDJEbrb+lFFWnsXP6v76qikjzRl+i37uXOL
         iuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795077205; x=1795682005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=stFHLM2pJTSD0YyKlsGWjLZ0by/wW3YLv3iz6rew0gs=;
        b=shuYdOXqpdnIFAFdhAuU6hQnCP2K4YcPXUvFidykaqpRihD+e3j9CqILjWDsUXmnOQ
         fUug+VxCCotimfbBRQZHHDzDV4ym8F8UvlLRKTvhKbrRVfZi/YgTcB7FyRiWHcLOPMh8
         Z9yFimZM/X7tpKLgFPY+y2IwrSvyDgfwYvcEDD2F6LymTOYKUfuWcTHz9pkFmWSlql4R
         LQwvrEmkvHQULPQz6bMmMy9efhsZ5/kVhuftCXFbN1NwbGTQJbAuXJDzV5r65/1SPfFx
         21rxomJyW0ih03rZn3/7zrpn/kmCoEUW7i+FGYi8Qba+I4bN7UBG+uavVYOdDX48fRSg
         TQoQ==
X-Gm-Message-State: APuU4Z9SFeEDCPhdxgRvLfk3W0dhJHTtMKOF7oB3Ko+RuaKKTN6lxDej
	fe7BOQQWhPlXYCfuRoWbZH4VU/tKgCUVOOWXpfj6onr75Q+HwAhbWTtUo6U9uZkBaSrNtmYH
X-Gm-Gg: AYBFou38PtJi/o3WItf8fmORF0m6vubJvrODx3G0orl/R/wxgQ8rndi/KzRDFuIDKQb
	uj339Zwktv26Qw20U/3w4hPFzDwRFbjzdvI+qw4xOV8EUf0OuAIhC3GTVHXLwiQPygvSLhzGWzw
	ccY68bx+wtJH0TQ7YvMlSwkOGfqm3Q4fHatV5YUCZsRmJoPULqDLmHEkhE6rfXPSERHG9OducE0
	EoYsXOQvptZv3TlPZDpMyoWYDQqBgedA+Cne3mXqiymST+Dv4adPSkPu+jjT/C2lQs0j1N+eXpz
	bZFC5Yl5XIJSWITe9LYI7s8c9RXbEHv2450mMr7MGivfpcntTl24pCcBLUAz4FPrr2/28oiWy2+
	X0SkwhK2cbCaK+UenXK3+XtCtsyn5CgQUJrtlXKXLhUeToba80CJwbnN0KvT0pkSGX70yK88MjK
	Sw0igJVfA/1lwtY4MiplAm38f6p3/q++BvyXNzVIGwG5FMvuvaGQOeEJJuravykXQe2CDNLhIUP
	JXZH3pCDeNiZXQYknRi/Xg/fkb0dWzGtxFC5tf9EezGvi0wDXg+gW3p9mqt6I8vnZXjtGG3WhMo
	n+eHlE/QdEJm9NWAPx+BB7wOc7KR176S4HX+mR6X4vQ3Ygh9MnSZ1nTVCHKkNDmJ5qi1fgPkClX
	FtXaA6K1/O4Ka3e+c9egsyu2iIHk=
X-Received: by 2002:a2e:ab07:0:b0:3a6:553d:cb1c with SMTP id 38308e7fff4ca-3ae671e5748mr16545081fa.12.1795077205175;
        Thu, 19 Nov 2026 00:33:25 -0800 (PST)
Received: from DESKTOP-DIIS71I ([5.18.141.223])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae6ebc2fd7sm7944771fa.24.2026.11.19.00.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:33:24 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: stable@vger.kernel.org
Cc: Hariprasad Kelam <hkelam@marvell.com>,
	Nitin Shetty J <nshettyj@marvell.com>,
	deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	shda@confident.ru,
	Jakub Kicinski <kuba@kernel.org>,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH 6.1.y] octeontx2-pf: tc: fix egress ratelimiting
Date: Thu, 19 Nov 2026 11:33:01 +0300
Message-ID: <20261119083301.1237-1-rand.sec96@gmail.com>
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
[ Context adjusted: RATE_MANTISSA_BITS is placed with the other rate
  defines, as MCAST_INVALID_GRP does not exist in this tree. ]
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 29 ++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index b23ac8f38..db67fb6b8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -27,6 +27,7 @@
 #define MAX_RATE_DIVIDER_EXPONENT	12ULL
 #define MAX_RATE_EXPONENT		0x0FULL
 #define MAX_RATE_MANTISSA		0xFFULL
+#define RATE_MANTISSA_BITS		8
 
 #define CN10K_MAX_BURST_MANTISSA	0x7FFFULL
 #define CN10K_MAX_BURST_SIZE		8453888ULL
@@ -101,28 +102,30 @@ static void otx2_get_egress_burst_cfg(struct otx2_nic *nic, u32 burst,
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

base-commit: cf82dcca96346600c7068cf3f841335f9fa08f54
-- 
2.39.5

