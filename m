Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089946;
	b=kLW6EHtMPG+1DtpkxnzqsIc1gbjlEERxE3m3mJ6yvN7XOxsbNHGWx6HQsgQWO/KA/vfL
	 AtR/CiKX3L9HqWO8kMcKH/CRvcFRZ+tJo0auRiRXM47jVu8LkfS/gNBypHlRqdXPsmHRW
	 xpQfPPZ9jf5oxN8gXV1Rg42vxPC0hfq4SYb7FzfmTR6nDiNdT3AE3j+PYakA7pre876kY
	 kX3gl5RSevF0PZ8GKP443hOo4/xruTSM3FZ1F3xcJPGKRvImF3bblTJx5orfyW6E5Dov2
	 Zejt3EDYrteJXR5S1rhWJ3xDYG9wZtqTSqlE6TTI5MAdpINwhP2yOiYVa/Sb9h4YPtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bBDjCRfYv01l5K9nHrY3/Hd2EiV/PHl9OnpVwXCk3ew=;
	b=dp/oSADcYvQdLZumuk3MVpRaPiyFhRWVuJ7tGTKis1ZeWpZVX5egv0AuOjwZZ0kTeMSL
	 OzRa0UGTmH6XYsd/3H2H05R1YGikh9Sa+Sir+mSLi59/16JJV/St8Iqm2aZzv9FNSmHbb
	 VkFrST0qrlOUwUDd3oQFgv7iA+cDwvUIc5HVz5sJPdhh950Q23Yh56vYeo5mY7MlfJgAp
	 YdJRdL0UlqQM2As0L5BukNhmsAv++hrxigun1G3d+2Iyvrhq7BTJmTW0k6/nAC5sYXyUj
	 aKYDsDe0clKTIt6+4e+fB7AMFUmVQP/qhX00BDjMIPPfR6DcsCdWqVW8iaL03aQB7mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JGPWpZne;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40D606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B40D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JGPWpZne
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so2681133b3a.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089946; x=1793694746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bBDjCRfYv01l5K9nHrY3/Hd2EiV/PHl9OnpVwXCk3ew=;
        b=JGPWpZnejBl2k0E3x5C6PtwzodNl+Q6b5PjhKtsnInQyZ9bj2wkbTtLyQLZAowYhh+
         5VJM/JanbOo9njybFJ2DtZ28HRUDUyyqMPexFCPDyRFJ05VYZdlPn0g6m92b6zow6/k0
         PlQRpYhg/LeNrmbo0xy3ezH/CSGJ9Qce7+SegQRopKlzGMqP3202+L7N5xweQTOwDB8O
         KQsh54mTMnqvlHdLmMkf9ON9q1xGT8HFNoeYDZ4LOdzLXVYYBrkQoJ/XBZdk5EGkKD9T
         mai0dKeO8Y1pinqQZXi+FkGAN9IwN3Y+Q4kenrHua35qOCJAMYWb4qYP22np3BhqfBwF
         kVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089946; x=1793694746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBDjCRfYv01l5K9nHrY3/Hd2EiV/PHl9OnpVwXCk3ew=;
        b=M042DfVnzJPsN1Jd97b74K0eozx8r95LjvjHrh6nbhaWVBVXaPHJ0YXP1vSW8xkkbF
         HYvcDuqEcXl1oBp3sifRahBbWaqXsH1Sh1ZpG2G9mW3TuqUe+UAzKHJ75Kc7YwXbXg+4
         eVh79uZuLIBOf9lh8Ucj2V7qkZ6anGj0DfS7GmdMprqPLILVgcoBV45t/6+3WXQYLSNC
         Rk/pYdAG+u7iDd7f60D5SBFs2xDH65wOOEyK6OBdMx+ge17iNyn+g1sbmqU8rPQX2C3q
         LadydA7fFtS/0tVtneKmFqCTgIUbJFzfbA2EAydCKqzEB9Mcnjhe8PrmxlapM6mz+Osi
         F3CQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzcVIWVosuFHeNXGPgewhJ3ggtYeRLRX9ESrSAXFdV0H8xIC0lQIZJOTzj/Ack+HcDt0OZbx8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqN4WruvOFTYeGNn/VD9BCBJcTSZZz54qxOnUW9n1n/QV6u3X2
	kABH2IiZXjN7CXezPIreibWI45vTP2kaEWBMSOGyDXhmc7zQFDqT1qLv
X-Gm-Gg: AYBFou37ok76McFY4YYOK4HdQi5RYmLvfsXne1HJNkQG4LrY3I+ZmlCHuexuNRuOPqW
	zXf4RSa56D17305+d+wV3I5fBdyNLLMjj6c8FGrXDQidxxbDoNO7Ugiu0RMVjPIbkgEQ9aVVn14
	O+vDZahxySwxMZeo9yY3fkHW7n+8oKuttjls7Pol546hzR7zK7vStyBCH8o2FpF4DJI2aNTdBS3
	DVn9B63DSFowObV1RZyfnXoLM2jzJy2g+rzs0SoEKbkWUByB8ltZKq5p3Ln6sKgsR+vL31z1Bxv
	16DP6Dy58Qxt9PvcRspvj0fsrtQaLf53IqcryZB/Yt/jNxL9fhojxWFWb1mubLaBnoQ/dZE/6S+
	sQSsEA/xAK38gag+b3KuqzTchfoKD5P9IvuhQRzGOWtipQm8AiCvUShlZyYMRi+VwoTZ3JyjMnp
	0rw8/Yp6uOMnMhsfpiWhIrg151XIillS4G8uHc3Nv6GQkyXPfSsoblgDnXLYoXv8mSEeoivMynw
	NDhVJAQ0m5sjco3SaTFLhah7jJ+dPCdBjpQPgOJFZ5vqCkD32elkVO+7E7rliCBbD9KZaprvK+6
	oTgUtDBzDMfww7BOhSDH1LSETaiT/s62iX3TLbTcvfYQOb1ildw=
X-Received: by 2002:a05:6a21:880e:b0:3e1:c1a4:91f6 with SMTP id adf61e73a8af0-3e7cd4d9db9mr6517172637.13.1793089945941;
        Tue, 27 Oct 2026 01:32:25 -0700 (PDT)
Received: from WIN-L6GHNQALH57 (1-21-119-227.east.dxpn.ucom.ne.jp. [1.21.119.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b37251fsm2018741b3a.27.2026.10.27.01.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:32:25 -0700 (PDT)
From: Masafumi Suzuki <shengshilingmu97@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masafumi Suzuki <shengshilingmu97@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: account for chunk padding in sctp_init_cause()
Date: Tue, 27 Oct 2026 17:24:05 +0900
Message-ID: <20261027082405.1297-1-shengshilingmu97@gmail.com>
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

sctp_init_cause() accepts a chunk when skb_tailroom() can hold the
cause header and the payload. sctp_addto_chunk() then writes 0-3
bytes of padding before that header so the chunk stays 4-byte
aligned. The check does not include the padding, and the following
skb_put() calls skb_over_panic() from softirq.

Count the padding sctp_addto_chunk() is about to write. The cause
length on the wire stays the header plus the payload.

Fixes: 8914f4bace3f ("sctp: add sctp_make_op_error_limited and reuse inner functions")
Cc: stable@vger.kernel.org
Signed-off-by: Masafumi Suzuki <shengshilingmu97@gmail.com>
---
 net/sctp/sm_make_chunk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 84a4c97d0f75..8933caadcdb6 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -133,20 +133,27 @@ static const struct sctp_paramhdr prsctp_param = {
  * cause codes will be embedded inside an abort chunk.
  */
 int sctp_init_cause(struct sctp_chunk *chunk, __be16 cause_code,
 		    size_t paylen)
 {
 	struct sctp_errhdr err;
+	int chunklen, padlen;
 	__u16 len;
 
 	/* Cause code constants are now defined in network order.  */
 	err.cause = cause_code;
 	len = sizeof(err) + paylen;
 	err.length = htons(len);
 
-	if (skb_tailroom(chunk->skb) < len)
+	/* sctp_addto_chunk() pads the chunk up to a 4-byte boundary before
+	 * appending the cause, so account for that padding here as well.
+	 */
+	chunklen = ntohs(chunk->chunk_hdr->length);
+	padlen = SCTP_PAD4(chunklen) - chunklen;
+
+	if (skb_tailroom(chunk->skb) < padlen + len)
 		return -ENOSPC;
 
 	chunk->subh.err_hdr = sctp_addto_chunk(chunk, sizeof(err), &err);
 
 	return 0;
 }
-- 
2.47.0
