Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794647566;
	b=KXvSwyeBHBzPQCiCnz3snakXXyFJraO8xXdAazhCykoKHLIbCv1/c86OloHczlqLC7H/
	 QMBo0Nte5j7TKLWrDKtdleNSuGMI60uU4aLuNzgWnyzkbhK5vaP4xJNBh05NwdqIw+riT
	 lWPyNFId+oGbqGCBBy1I89N/Xz0S8HX+IfvA0DHVKc3QHsgfESIkEjiwjFUXyaufrjmB2
	 5pBHm2duqo3UfUXfYCJmaILPDH8+K61z14Ro48ZF4QYOa/r2g1v42jvEa7UoDyOP0n3pq
	 5c/6WPc01+UO19QZaRAphBk3vjQER3dkA0HjmYT2aSAIdGaXz2bekayTS0LWvlxjzZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794647566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QTbQToynBqwf3n1SZSg1pf/eN+ziaT5I0ox1EckFMS8=;
	b=1WgBl+CRDWHOFS2/3bUuBg+A5pNABNjpM9SlUqqOVlOPWtFq76rF1zUUI+Xadycc88gM
	 22RjYySUDdNeTtsOiBrkNCjtYjwZONGJQYPFnx0t/sVMuUn4jqW8j4dkkfAfwqXxLX20E
	 j4QMv/gdRlwv96WBdf19F7Wr23hw+YhIie7IMYnd4D773zOCGkgSeBRRAOIjk0KVRzDiA
	 sNzmJEIwLVpH4MsLD/ANfsKM3EjEjm6sHrSo0Sl2RR1UZQrWmoI8AmC+V6c07TrtBIh7D
	 RsG4l5LddQgrlx1BkFsGIW74AMhpAvgBv9pPb8T/FiX0JYWe7EXIFmcGct688ea/w6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RV6mQUGj;
	arc=none smtp.remote-ip=74.125.227.137
Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C902860A2608
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 09:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C902860A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RV6mQUGj
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-3b1a38a5088so519005a91.1
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 01:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794647565; x=1795252365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QTbQToynBqwf3n1SZSg1pf/eN+ziaT5I0ox1EckFMS8=;
        b=RV6mQUGj7+F93NrSqCxxKeUED01cOhim5hASqZ3AYiS1YT0y21Kl3GdKHKu1t9l44t
         GSQ37UxZasL+fHnTpBsopAbYWA903/H4/llyno2eMbaCzFwjioBAJ3jm5EseGU8Oud3r
         OwE5LQPoW2sTjoOPLTS7t5z6j/aTatIHwVuOjyFblgKtjfE8HVpYYHYcljsWeUC0zB2z
         38H8L4C31ZV5BOP2BiGXW58+M7b1OgIt0VnoSK2dzT4vepwOIeVumpezx1CXurFoWicV
         0bApP5+CmlF1jpQmgBpMhJUlu0DqVwao0lCMUtf3vwZ1iSNCAXUlGQ7ugD/V0VNLSluF
         HHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794647565; x=1795252365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QTbQToynBqwf3n1SZSg1pf/eN+ziaT5I0ox1EckFMS8=;
        b=bQLifY2V4LnRLiFvRvuggcF81HRoiEdkgvHNWBTsQC/jXotIAD2WoHlcIXw7iepT6K
         9RinstRpODFCc2br7ZRhMvDPOtjEXrgbCoKnSn7mOhHULC3tZ7uZwlvCb+wVw1AspmoU
         iAvH2cJWoJwcwJgXSvj1OZID+Aessk6pMlHchm29L12ko9WDZTw9E38qesYjirdpgTTr
         4tJCO4ycg4ax83EZG1Jsa0+XTSjFYP30v+XbJWyxANEyOUCx7bQiBLRLd+rb1GM3loiC
         BzDldBQnuEUm0pMw8iSfUnB4MA0nRPFWWMOvKwvlRA8jVRMcgVnCoK7siPofPzy+a8Yx
         KGLQ==
X-Forwarded-Encrypted: i=1; AL+hErGsbFVRnAiO8FsI51YS0Jy5ElG3avqtdJ79gGOGW+WlDl91Qf6L70LA7DYDldxneqkdnempQYg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8x1WB9drXIGxEEQcrUOAOyuJFKwXhqvLXOmv98k3JU0rLkkg9Q
	kguHoDZJ23+poasFO12cWPuN7FYuIBTd36RFXRN3vc4UuWHszHgDKrrLkBt2fPSbR7Z1Lg==
X-Gm-Gg: AYBFou3ysw8xZAbLcZe5wLMDlNQdy+Slm54pt76PfbRNBm4U8sez0pIIpqVI96hHGOc
	oV4RCQkjVqLcAhQ+9bHdZsG2alSOlt0s8FANN7KYyOOz18PKgV6VIKHrGAaeMx16lNwvk25YYGE
	4WQ5oD0mMLLwA1OpPgaE2C+QerKDRJGyQCbGekc+TFkX4fr4czs34VzBAFGO1kDANPP8ykJB/hh
	l3NpAXLH93j8crOayORFXTdWUQ34VPL9/exHFGw/S8bOHw/Qzhb152hGZtjuYRAbMcAa3WO3KAH
	npFeM1ppHPn5ApczhgRiLQNSywpN1vduL4O3uLM+Yr7NbZMKqz8sWaidNp+c/wtrHay7UtePy8p
	+xdNl93ll6l9Nr/85gMpqvB/BUPXUf1UTlH5GEhC1kZJ7bNs+/topMEgkKfysdetQqlwF4J+84d
	arerXuKEJwE7bsT9fxEl5hBWKOgvVcQu4VgSAg4M77ZqD/DYq4nHYxIVMKFrLxkKISJgTZCSWcU
	lHeNoL1/hY+EdLT6JRFFmaku5ZG1yUx1b8tibhWbjz8bnReQCKww5Nc5NTXg9Zv1JjyIc/ca2LY
	jhvEh7VO3muLg0t5/Nt/nudypWpMwb5dak70abGeEDFsp6hHLpNb
X-Received: by 2002:a17:90a:c88b:b0:3ae:6fda:78b1 with SMTP id 98e67ed59e1d1-3b1b0b6049emr4722150a91.43.1794647565057;
        Sat, 14 Nov 2026 01:12:45 -0800 (PST)
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:2b6e:fd48:7485:9720])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb179fasm8311897a91.4.2026.11.14.01.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 01:12:44 -0800 (PST)
From: Yingjie Wang <flashhhhha@gmail.com>
To: steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH ipsec] xfrm: avoid wrapping AEVENT timer thresholds
Date: Sat, 14 Nov 2026 17:12:39 +0800
Message-ID: <20261114091239.780633-1-flashhhhha@gmail.com>
X-Mailer: git-send-email 2.43.0
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

net->xfrm.sysctl_aevent_etime is stored in 100ms units, but the
conversion in xfrm_state_construct() multiplies it by HZ while it is
still a u32. Large values can wrap before the division by
XFRM_AE_ETH_M, disabling the replay timer or turning a long threshold
into a short delay.

Do the conversion in u64 and clamp the resulting jiffies value to the
range representable by replay_maxage and safe for jiffies comparisons.
Use div_u64() so 32-bit builds do not require compiler runtime helpers
for the u64 division. Use widened arithmetic when reporting
XFRMA_ETIMER_THRESH as well, so large stored values do not wrap during
readback.

On x86-64 with HZ=1000, setting xfrm_aevent_etime to 536870912 made
XFRMA_ETIMER_THRESH read back as 0 on the base kernel and 42949672 with
this fix. A normal value of 8 read back as 8 on both kernels.

Fixes: d51d081d6504 ("[IPSEC]: Sync series - user")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <flashhhhha@gmail.com>
---
 net/xfrm/xfrm_user.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a5fbe38839c4..4a676a6aa53e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -924,6 +924,14 @@ static void xfrm_smark_init(struct nlattr **attrs, struct xfrm_mark *m)
 	}
 }
 
+static u32 xfrm_aevent_etime_to_jiffies(u32 etime)
+{
+	u64 maxage = min_t(u64, U32_MAX, MAX_JIFFY_OFFSET);
+	u64 j = div_u64((u64)etime * HZ, XFRM_AE_ETH_M);
+
+	return min_t(u64, j, maxage);
+}
+
 static struct xfrm_state *xfrm_state_construct(struct net *net,
 					       struct xfrm_usersa_info *p,
 					       struct nlattr **attrs,
@@ -1022,7 +1030,8 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	x->km.seq = p->seq;
 	x->replay_maxdiff = net->xfrm.sysctl_aevent_rseqth;
 	/* sysctl_xfrm_aevent_etime is in 100ms units */
-	x->replay_maxage = (net->xfrm.sysctl_aevent_etime*HZ)/XFRM_AE_ETH_M;
+	x->replay_maxage =
+		xfrm_aevent_etime_to_jiffies(net->xfrm.sysctl_aevent_etime);
 
 	if ((err = xfrm_init_replay(x, extack)))
 		goto error;
@@ -2782,8 +2791,10 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
 			goto out_cancel;
 	}
 	if (id->flags & XFRM_AE_ETHR) {
+		u64 etime = div_u64((u64)x->replay_maxage * XFRM_AE_ETH_M, HZ);
+
 		err = nla_put_u32(skb, XFRMA_ETIMER_THRESH,
-				  x->replay_maxage * 10 / HZ);
+				  min_t(u64, etime, U32_MAX));
 		if (err)
 			goto out_cancel;
 	}
-- 
2.43.0

