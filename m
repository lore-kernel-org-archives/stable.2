Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854969;
	b=bDhRz9qsdzd4iG+8uUxHMZ/kG2tT6YlmgtCn4GHLtoZiKWgTaPmgFDzglJgIYAoDjYvu
	 lDaACGVXMqSUY9f6W0aL1FGluo0lfMz/T73p7QNp4FnXIEGjGq1KgStWmR7h4lpyg9U/N
	 EdGkpU4nm04tP5fK+pbKvLOoqq3ARk/E6irEZZ4A8oDUKLLwp7FLd5NTUQQ0h4MqEaBB2
	 LsFn9xGzZkBDanoUT49AS8+3ZNS1vGpepGPsO1MsIJFglCllIb68lOEsHKPywqNIwvL+v
	 bRUurE80sEClJPMGlzbrnb/+Xxqq6KXqo3SyFcccbvBcLkFnLlAVk1uzekwI0v4KMEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZvR6TskZdWW0qqXirA6k1L3BiqLi1sfGsfq7tJ5wLss=;
	b=t4a5Xczue0xb8gtprxz5rSsmU601o2jvnoQwZCxa+69PSKmwp7c2BVFXLuBUr4BTJOcf
	 FZvLwcuHznFDKhjBLbdW5a8sotq8ZcyXiX8u+m/YkUwHo41cH+l8FlHzEjcxvf2qNcL25
	 hxIUr1e9ZEonwhzIFQo83bMU4bK7DJhFunOgrSb2dFCzZEeKQcm9jsJmk0Z/ejtpscRAn
	 lrrgLKHrYNwdVM3fmFZwFDPWKBarbJ6jJjq7NLxopxqgpn5ORkliPS90mLD2/NI2ogxij
	 HP22uqqPginJu+yUhfwidi+HUmGfTFjYbBV9N9l/LJxRHklC8Dn8G9uAEI3hZ1nZzfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVqH7DZb;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950BA606D804
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 05:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 950BA606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVqH7DZb
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-15dd124bbe7so601367c88.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 21:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793854969; x=1794459769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvR6TskZdWW0qqXirA6k1L3BiqLi1sfGsfq7tJ5wLss=;
        b=iVqH7DZbiXYw9I1iVCOjZ4e9C4Zj9/4MJHBezBN7pD87q4SvUWBwXrtJ0712sceVUR
         gTEj9SaTAXSRg78VMKO4rSzGIfEO2ZIsAhKT9Lqersq8HIbzx2VfuBENhnYee6LUWo89
         Mzg5IVoS2EbjHSPJYEnrLr9ysmuj3LZBkFFEv/iw8HhzS/ss0woub3STdsy4wtFVaEr/
         CfPkxVsI2GMqdOmgw2y+ixrXPdzoeBktMtV9flcUiuk3csIXxTkESHrHRxV6RwZj7Ajk
         ff97Mr2c5lUhf8VKXAZY/9FUMhbt4fdBemrTWsuvFmY2Ok75cUH62NKj0dfX8ogFPceX
         3dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854969; x=1794459769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvR6TskZdWW0qqXirA6k1L3BiqLi1sfGsfq7tJ5wLss=;
        b=C06A778eE4lxyReDTxPcRzRIF+OtlNDRdoiJuUmHdwUFZ+YDh64TBsGR8LCZPp27tn
         Q348yzUhdrFYdM2X0hOzdY5ijPBOuEbWtHdQdjo8jSOd6X0A8lzn6qm0UOZripQKyk/B
         wV2UFQnxQ0w+qmS1c1IkLMxlfNuSoiH3hyM85OFSU4RN5TqLFUIQWpsV8BWFqoivMzJE
         ySfgTQcvKHJt33AkUYK6ZojSa8JCa6WYTwsXlerB0Vz8yKS1Q7aOMzX1etsxB4tac/ll
         Dk6SjJubCb3jyUSpVfuyYLixliPPzJtKR0vakgmSlXuj0IZIA1skAS/dvXqztfCok+5J
         mThw==
X-Forwarded-Encrypted: i=1; AKwUvBxUAYKeXGMyOGqQZLr1Llt7GjN7s+JFKIxwowjwdJ6BkyrmXfDEoGCMzCimW8l2wc+DPD1hFi8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+pKZxFIMVZkWBEnIcX4+kC0sCV2POc0CjybrXZR6pucWvgEJus
	SHGrCjCVUWdR0QiiZvPnnBu3QbhOw8ExmptG7ea+29LTEXinfL5/SxqM1jggqJV1lX8=
X-Gm-Gg: AYBFou26OnRgEk5MPyUB3WF80ail2ETtxfzxzzNRy/WKJWvuRZNoyg7XeBXYZMkI50U
	BLHXuqZZZ+YfACHdWgMaDjLdihoSH2/uiE+YTpd5ClkYTPM9rXHLVMKHygiEiQqXot5axS08NYq
	ADg6WCNsyzdpqcgEpQpL9C9Cy9s3E5+a2nnrePze9fdgOUeoMb0uAKPoMgXRChqAb3KBy4M9T1n
	83TrXtr1Zs6dFE/ETCKeE208LMAD6eR3vefNm5B9S9hMp5QnMio+9X7AoTm3kNhURUamJ+Cq1ib
	vTNyu1Ugzo9t05I8FikWn2xRp3Hfvsn/yE6YraB5FCO5VXa8Ij+f6kHZs4SoN9Mq6XRPDnnRxuy
	JRDWfkxvFZEyS6S+K+Ypx7NrPPqfp6kyznxY33j3rMRikXZTyX81tjYWjTciG+nuH3Vs8e+c8bG
	7lPPN8RnkcK6FD2c2ERfVENFYm/ETo1tRyo8tK5VV+Cud1FAQaxDw9mEZRfjA44gW9ohNWuHf4L
	JmRnsDIAJISWYx1aCsJxtGGu8yE7hCPt/PxgsWqZalBh19hLevT62rF8vRlsTqAn0sv1s0p3SR9
	2VyjB1kDrSvpbeyYviqUGVfhvFGmh5crb0orrVtZsB8HzAZ5VQ/SAn5S5/qSSR8Do/jYfjGM4Bs
	=
X-Received: by 2002:a05:7022:29c:20b0:15a:9834:73f2 with SMTP id a92af1059eb24-1ac5c5554eemr25709808c88.38.1793854968501;
        Wed, 04 Nov 2026 21:02:48 -0800 (PST)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c283sm13626735c88.4.2026.11.04.21.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:02:47 -0800 (PST)
From: Tim Budding <tim.budding@gmail.com>
To: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Budding <tim.budding@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/4] sctp: abort unordered partial delivery when its message is skipped
Date: Wed,  4 Nov 2026 21:02:22 -0800
Message-Id: <20261105050225.49292-2-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105050225.49292-1-tim.budding@gmail.com>
References: <20261105050225.49292-1-tim.budding@gmail.com>
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

When an I-FORWARD-TSN skips unordered messages on a stream,
sctp_intl_skip() only aborts the stream's unordered partial delivery if
the MID being delivered is lower than the skipped MID. If the skipped
message is the one being partially delivered, partial delivery stays in
progress: no PARTIAL_DELIVERY_ABORTED is sent, and the next unordered
message on the stream is delivered as the rest of the abandoned one.

Abort the partial delivery when the MID being delivered is at or below
the skipped MID, as the ordered case already does.

Reproduced on an unmodified kernel with the uo_pd test of the
sctp_ifwdtsn.sh selftest added later in this series; its partial
delivery checks pass with this fix. Reproduction and fix done with AI
assistance.

Fixes: de60fe910543 ("sctp: implement handle_ftsn for sctp_stream_interleave")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Budding <tim.budding@gmail.com>
---
 net/sctp/stream_interleave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index 840f24045ae2..869940001588 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -1255,7 +1255,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 	struct sctp_stream *stream  = &ulpq->asoc->stream;
 
 	if (flags & SCTP_FTSN_U_BIT) {
-		if (sin->pd_mode_uo && MID_lt(sin->mid_uo, mid)) {
+		if (sin->pd_mode_uo && !MID_lt(mid, sin->mid_uo)) {
 			sin->pd_mode_uo = 0;
 			sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x1,
 						  GFP_ATOMIC);
-- 
2.34.1

