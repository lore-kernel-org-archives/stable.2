Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239A41228D
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376684; cv=none; b=tSy147OWS+qK3FR8ttfn/ySR5rjU9c25uNSqZ6nwgVd4jABpByncXNlsSDHgFBG0UBquX9jUBnkWVF4Jl6AuMqqRVu+pcDN4R0Ftq4gxvZkEVSvms3CYstoqGaU1wpyRMqk2PhismHz0l9n9MdKGavcUl1JPr/rLALHLJwIDQ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376684; c=relaxed/simple;
	bh=gyJC0b7hJECF7fJ8CFQosnxeuVtyVlQMTv/hlVGegkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY6tHl3psZ+v/2csxhfYvi+1xRdRwN9S+wBeAwM2RMj5T/rSn6eS6DzR7knYZY7yulAdTmUoQrAwTPcbUz3iKoAYLQHkme81jsV0/Qbzr9BKE6Iuja3J0irhRHmACrwfiglvrRxHizykP4Lu7woz8mO/PM3TZ4p+hT2ZJST+Lc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il; spf=pass smtp.mailfrom=mail.huji.ac.il; dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b=Q1rTI8UX; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.huji.ac.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.huji.ac.il header.i=@mail.huji.ac.il header.b="Q1rTI8UX"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48436686a40so267576f8f.3
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji; t=1789376679; x=1789981479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AAgSKAAxXcQr8Y2vgjRRhe3XjvoOC28UTrglxB/skkM=;
        b=Q1rTI8UXiF8QRRi0LJYc2vmt+A/LOrNNETT5fdy4qsEo+H8j9aMyap3kFXihcnhsVV
         u9OGPa8s0c8ueZF73P832Q5KDZQ1GmZHvjSuyPY1hyY0jn8P7tgQCD5Z/LW31wtFMzFl
         YCAetz+2oR6wKOs4exe8u4bmPwSosntVB8pjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789376679; x=1789981479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AAgSKAAxXcQr8Y2vgjRRhe3XjvoOC28UTrglxB/skkM=;
        b=AnxbbAWgHtZvnxeD4DOrx9zY6Su9HB19eC1w5DH/q+4+3Myu1tiPdeHSsIqoILc+ah
         BYeGzXT0mW5h52Z5ob1Mz7/iCALyo5ko4GBgYr4az+oTKQPmU6ukNDSK2V5v0RJzeiOG
         owwF6sJGnR6fsi3PwgOYzjfj0717Z6cOrW/kafE95f9/7gzWUdJtxTbf/S+X2uxmIK7a
         Oya1+eI0qTS5fXTtNxoyiNNnzNFg9HMIsqO8DD0KD8L5TKRt/n4m3eAi+aDAJpPgRhYZ
         5X+H6QnIexIpo+AzkHmx/AKTKnw7KJb/jHDwL+8RZRdJbIzQXCmmIzs54zsJfbwWGyAa
         aDAA==
X-Forwarded-Encrypted: i=1; AKwUvBwnKjxLb1ZmlmejU9wbKm8Fyhf+fDVE1bKuHbofil22JBRyKd2lz9wd9h3+TdZpknNXnOoxTcE=@vger.kernel.org
X-Gm-Message-State: AFuF++k3NjBFfFXCGxLjXAwwqcIFeKiWI//G+Ikh5F2Wedwa4IwTXt/H
	anP/ampG8DLB719k0TYXB9HOD1jhhM2nggVxKCUTOtMXqm6ZZhQgXrjFIf5x9QyKvg==
X-Gm-Gg: AYBFou2Bebb+E7zpT+AABLqHs851aFvtEhbomxIkmpvodeOkFVTJ1ySnoXTLE63Q5b0
	/hnZJ0Da2vsd+n7bTEAU430pPj+HJQrV7nG/m3ISLwjf3ppKJIBajTrM+nz+1Eh+9UfH0NY9PhI
	o+/iZTDStc8lcfMLFaJRDznDLQSgsF6mObomF48RaFEJ3xgNzSQzkhUL8xIWPQY9J20tXFaClnp
	RfS1GCR4LxveTb2zdYE9HUFyHovJNzqeCUNsN1oCQuUMFwd1PAVXzU6nVz4AQuLIHU06mQVGYST
	Nq+PO3oTuFmg25HfDD3FvA99YF1JnPE7sPnxu9DRhr8Nk+0PWszsztU7AmVfI1/He6rophhCfRp
	CRPIhJcdqRAyZ//FC+lGLVBVkfZ+febeELfF95ve4JjJrzZjzkFdHWxcn6apDvpwT1gXGhxBbei
	ZolzSWdLK6RD153WMamiunj0v+F8TZZ7gxWwF2yu1ZbrHc/idnMRCtR8coOlQp0ZpnKSIzj+NZb
	mgKeFhAmJNcCxrT4VEDCpkK5jyYvSz51QULGsFF9N30/RA=
X-Received: by 2002:a05:600c:3b9f:b0:499:d95a:41f with SMTP id 5b1f17b1804b1-49e7a5f41a5mr21428035e9.0.1789376679039;
        Mon, 14 Sep 2026 02:04:39 -0700 (PDT)
Received: from inbal-OptiPlex-Micro-7020.tailf3f5b8.ts.net ([2a06:c701:c272:d400::7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm227502585e9.5.2026.09.14.02.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:04:38 -0700 (PDT)
From: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	amit.klein@mail.huji.ac.il,
	Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>,
	Tamir Shahar <tamir.shahar1@mail.huji.ac.il>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] tcp: exclude old ACKs from tcp fast path
Date: Mon, 14 Sep 2026 12:04:07 +0300
Message-ID: <20260914090408.1435080-2-inbal.lipshtat@mail.huji.ac.il>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914090408.1435080-1-inbal.lipshtat@mail.huji.ac.il>
References: <20260914090408.1435080-1-inbal.lipshtat@mail.huji.ac.il>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exclude old ACKs before SND.UNA from the tcp fast path
as well as ACKs after SND.NXT.

Such ACKs will fall through to the slow path, where tcp_ack()
performs the appropriate validation and challenge ACK handling
according to RFC5961 and Commit 3d501dd326fb1c7 ("tcp: do not
accept ACK of bytes we never sent").

This prevents old ACKs from being accepted
or modifying connection state as part of the fast path before
appropriate ACK validation is applied.
In particular, this prevents payload carried by a segment with
an excessively old ACK from advancing RCV.NXT before the ACK
is rejected.

Fixes: 31770e34e43d ("tcp: Revert "tcp: remove header prediction"")
Reported-by: Amit Klein <amit.klein@mail.huji.ac.il>
Reported-by: Tamir Shahar <tamir.shahar1@mail.huji.ac.il>
Reported-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
Suggested-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Inbal Schussheim <inbal.lipshtat@mail.huji.ac.il>
---
 net/ipv4/tcp_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index daff93d51342..03d317a58132 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6490,6 +6490,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
  *	  or pure receivers (this means either the sequence number or the ack
  *	  value must stay constant)
  *	- Unexpected TCP option.
+ *	- ACK sequence number is outside [SND.UNA, SND.NXT].
  *
  *	When these conditions are not satisfied it drops into a standard
  *	receive procedure patterned after RFC793 to handle all cases.
@@ -6539,7 +6540,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 
 	if ((tcp_flag_word(th) & TCP_HP_BITS) == tp->pred_flags &&
 	    TCP_SKB_CB(skb)->seq == tp->rcv_nxt &&
-	    !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
+	    between(TCP_SKB_CB(skb)->ack_seq, tp->snd_una, tp->snd_nxt)) {
 		int tcp_header_len = tp->tcp_header_len;
 		s32 delta = 0;
 		int flag = 0;
-- 
2.43.0

