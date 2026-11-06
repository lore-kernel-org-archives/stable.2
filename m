Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991133;
	b=dr7Tk9/fIu2cR3xhqggl8yfAQ3ZM/lxX6XnOVxf43jbpFMVeN97FfgNqIOFn5tKyHLHL
	 mIIINhFo8ewwgIXyVd10qbPVXdl4kwy/6ELDlMUGXdqBk2J25etzSjzqNjzo04hwyCL7M
	 auBNyUV6SP8adooER2Wxt/GD84pTiEEzcjueJSAxfN2fJrq8/dvNg3OANSKhWoO6xAFbr
	 oZ+zAp25VYOUJgw6k62XGfzG5bnESyeBJccsZ7ToM8teNDMoGOeihA1chQaKH+kgkLGI0
	 GohchNY4hhldlhfgJg8u+fmyNjpruMafM7GPmgj1SSRZKVLIWsAiVXFT5jp0EiZxXzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jkr/vXjba9Z3zwOiGq9O6qe7GzW0wTcrHSexSQcxSGE=;
	b=o4/tZJoGbAdUuZ7KPZ6zqDlUDa4otMJdRpxEZn5/D9Ex+6tQO+dbs/mIxBG6KVBVxa17
	 uMHKs8AwoIypkW1WkClZ7HsV2GmwY/XHRekc9KyNJxf13f7euVq8uVjLq+3N01mCGnMV/
	 wJarx1/lOaNeD7qAQTvuzNoUxLa/9/8Naqm3Jf/6ZiYcFId+OzmBgbBr04VwuZKgB+j4M
	 F45P/S6vOW/NkkaxRU88f363swAfCW1stE0JVfNZVDkxX2TcX9yq3gCVGWlJ+7nR0D59L
	 BhsTS01VQtLiFZ3hg+SndpCh8HhmBDttOLX0eQStnglclT+nah+OKuKvqOsMSBJmMFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jySbVnZm;
	arc=none smtp.remote-ip=74.125.231.134
Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E2606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867E2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jySbVnZm
Received: by mail-oo2-f6.google.com with SMTP id 46e09a7af769-8217177c5daso274744a34.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991131; x=1794595931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jkr/vXjba9Z3zwOiGq9O6qe7GzW0wTcrHSexSQcxSGE=;
        b=jySbVnZm+1AV5VJLdKjudU4bDQgXjripk4/WPWfN2IuT9kWha6DIBZ51q8fjTnB9Za
         5IKiHFgDtEP8JX8Eak9CbaB3xjArWYIjugVii0/OTMMDAWg3nuALGDp390U86YyhCrs+
         iNeIRpYcGn8SCy5c2vQzO9OCT3viYYjrqkLxW7xOrjJUrEqA9uRo9lWHmEb4eh3ugiDn
         5sV99QblolTqwccSQYAM5pwlZNmBYW062mwK7P/n3HYD1b7KJA0LLoZV4/GaXXJg03Z9
         Mo68HwOiGl7ge+H+PLNAfdXKRV/Szg+dUh11bLP5lSnueAc7qo1icq9qeykO3tWLHB+q
         A+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991131; x=1794595931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jkr/vXjba9Z3zwOiGq9O6qe7GzW0wTcrHSexSQcxSGE=;
        b=NpThf/uUE2JlcYPvi9S5W/tWad8k56KiJX7e80m+wEkx6cC0A+NT3xh7TGR7di3tHr
         eq/dht4ZHKcXBx4ZMNvkBKV4FWPsPUDFkkgWjpivDdpWW7/EEIz3fFEoAuHjwj70kL+Z
         aBe2nhabnwJI5g+dqEJh/54gdHfZIRYTHUpEcskFrTyIkNpylfEnp03qEb8nkNLLP3Vv
         tLXfFQGC7uhLTAP0FKpB0EmIGg0Q601FQIdXlMDPKkjxy5dXVdvgKdyWQtmuqAhONOTs
         57lPdSxjEn59ZdOXkmm9ElmHRzC+YUhJDe5RHRgj04/A0ecd3mF/hRwKFtcHhaZEF3F+
         HNrg==
X-Forwarded-Encrypted: i=1; AKwUvBzK8VD4b0cKjdKHDn1JPwa23XyGJ7dYskiRJr6lwDP/L6K9R4yb6sHqGGP3Ve2mexu3BPrLMRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6Wd5i4KMD77jZHV2omM38G6W3Y1B0rq4K5nURqaa4MuXvSZZm
	57eCDZ8819nmhcSKBomaES+Z98fFnCUFjN8brHcu8/dubRCtgLaJefqk
X-Gm-Gg: AYBFou1/Q5p3aGm8pquDQh8bw/DGSDfUmQy8rLFtAOJ2BSHYUNZaICm+I6B64hlzuhY
	wEcMr3ARGwAqkkwglIL+FOPx/cym5KjVyrReXAQc0K1XoXyu4YD8PGHiWNCC37P5cgWzeDcZAHP
	YNwDJdWmlg4E5Euw5qBUblU1R2GgAcsa+lfRi6iv/CEKLhr+v+qQlBSraYAzHtik0kYvCwr+eDn
	N5kyfp2XjRs+22LYZMyb6ITnDlru0khOHjkKj/pEq2VV0Aa9EFnOf4tkYMFek5MUoRzb6IjnJzo
	ovALcIT5MtSCofHyp/nGhoGVCUOh7SbJwypfDSaKLam9l4bcJMSFy/IN2WSxw9ANL+9kHqClP9J
	DUyaCJq3xbHBUhJ+Wlx0OZNoEnSguwke8ApITLdjpmZc2BQGH6mDsuRfFZohKKMPaAruBcMkLjg
	bpLOxcYKGSYcXoTnXAAP6PAZhqMhwUyt/bJ5uqwiaUiqyIj17xFKTvEeZSqKZqhZbQ2v2NVebb6
	XV5sMfOzJy5Yxm3eiH+8Yxu0qfstFtKVF6glpVxOdKr/efLsFioQ1TadQi35W0D/m4U87fhWhZd
	2wXQs/exN/nfv0wfbLSvzfSmaUgq5Nlq8pGMo5aK+WMGSfNK2sqP19loYyzIFtGA+5Ki
X-Received: by 2002:a05:6830:7192:b0:818:56c:a8f6 with SMTP id 46e09a7af769-85f1d04dc99mr3163517a34.26.1793991131373;
        Fri, 06 Nov 2026 10:52:11 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1de8fdebsm2533411a34.25.2026.11.06.10.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:52:10 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	edumazet@kernel.org
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] sctp: fix skb_over_panic when adding addresses with a pending delete of another family
Date: Sat,  7 Nov 2026 02:52:03 +0800
Message-ID: <20261106185203.3326303-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

sctp_make_asconf_update_ip() accounts for a pending DEL_IP
parameter by reusing the length of the address being added. The
write-back side instead serializes the pending address itself,
with its own address family. If the pending delete is IPv6
(20-byte parameter) while the added addresses are IPv4 (8-byte),
the chunk is allocated 12 bytes short and sctp_addto_chunk()
writes past the end of the skb. E.g. on mainline (05441d697f7f):

    skbuff: skb_over_panic: text:ffffffff84859c77 len:392 put:20
        tail:0x188 end:0x180 dev:<NULL>
    kernel BUG at net/core/skbuff.c:215!
    CPU: 0 UID: 1000 PID: 379 Comm: poc_sctp
    Call Trace:
     skb_panic
     skb_put
     sctp_addto_chunk
     sctp_make_asconf_update_ip
     sctp_send_asconf_add_ip
     sctp_setsockopt_bindx
     __x64_sys_setsockopt

Requires addip enabled on the endpoint (net.sctp.addip_enable=1).

Account for the pending delete with its own address family, as
the write-back side already does.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 8a07eb0a50ae ("sctp: Add ASCONF operation on the single-homed host")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/sctp/sm_make_chunk.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 90de272842512..18947ec5ff9f9 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2886,9 +2886,17 @@ struct sctp_chunk *sctp_make_asconf_update_ip(struct sctp_association *asoc,
 
 		addr_buf += af->sockaddr_len;
 		if (asoc->asconf_addr_del_pending && !del_pickup) {
-			/* reuse the parameter length from the same scope one */
+			/* The DEL_IP parameter is serialized from the
+			 * pending address itself below; account for its
+			 * own address family, which may differ from the
+			 * added one.
+			 */
+			addr = asoc->asconf_addr_del_pending;
+			af = sctp_get_af_specific(addr->v4.sin_family);
+
 			totallen += paramlen;
-			totallen += addr_param_len;
+			totallen += af->to_addr_param(addr, &addr_param);
+
 			del_pickup = 1;
 
 			pr_debug("%s: picked same-scope del_pending addr, "
-- 
2.43.7

