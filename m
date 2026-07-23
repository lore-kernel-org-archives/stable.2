Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB05276041
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773794; cv=none; b=qKDDT82s/5hVlIiBSJylIoqEuoJAMyfF52T3vV5Clzb/Yynkg3BJSt9BmoDyhb+RlC2PS+h2hKRVbfxtdGIVTWEAY5VE/jJVWT4gKe8Q/CZIIM5zq1pVuh2JrhNv0M61IjbszVlkJ2cPU2j9GwSmI4E8TcRy6pSuTkyta+htW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773794; c=relaxed/simple;
	bh=4vYiVVksyldn7swIpfllG1hkNNDW7P+IPr9Ajbx6HE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BL0uycCmTP7uAGWmpBMsNArAZ3oyaBKfiuSjKGKEwUrL+CAR9gCHsUD4S27leYF5VCpmN9Goj4WgWFe1gThIOBORrX+iCCRGXOcLm/ayMrcPPeEYdjh+S7LrO1K0UBkbDd6fCGqR3TgBC0CBCcsS8Zrlt/I5pEVAPHogSoxGiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtwz2ZVI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtwz2ZVI"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84874b52eabso200424b3a.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784773791; x=1785378591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p8LvT3IJZd7EJrtc9YjjpZEfucaV4n9NX3Db71UzcA4=;
        b=Wtwz2ZVIQFRkBFEWLXJGG3ciDgy8i76mJmZMfVMFQN5acHvmXxy5Li8sHrzgtxKV+8
         YDjUkIKsRwj7N2U3G6ccnsrhbn7KZR52kv4CHK1FusfukKWHNh1ubXUYZ+j5QK0QlEiH
         Tm/fAY6TXaye+NvvN5o+qQ7I7d9Qsbs374mF968saXKCJJX/wWS0l6oR6AsstfYCtVFN
         py0LYra0xfES1KQwgRHubqIAygeHXu8jGP0H9I7pjzyaRQ5TTZDQ7ccVYupWZ/uG4PtR
         7xHofAnNo1XhLw5ncB05UlRIZaEr7H7FAjNmF9/I0CMqKPR8XjNXm7aoLiKE363BNvYh
         Y3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784773791; x=1785378591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8LvT3IJZd7EJrtc9YjjpZEfucaV4n9NX3Db71UzcA4=;
        b=jvJtXNCdjwjKGJRcO8qxf9i1pjAjh+W/8akarcHoeO26Q6+Vq/4u9Hnqd7IzovYnMr
         Vynb0G7Zz9+dAKSdGhF9FQspOvuNFfiXEgWcaOJbcZeNc8ahgjpqBwunKmYQ3MDYOsb7
         yaxZ/Z8o3zk7o6GYNykccEVBanu0RcxWR7seeAGaLzgJnSTASAAitD7XyxqRpxkAvW/x
         bl6IfKA2JPkqauf4P/C8H/9tlVPLQPzZ/Inj7ooF/7qyFZc9yYp4Cs674YrOJjtPe2ba
         NGoU5cdK9n+S0pEwUm0IuPz3s5sm6mP2vy5Z8M+Zb1l/BOg7Jw2y/dWdSt0QswaknX/t
         H7hg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+tpoMXhWvKmaXKpFagDr+yogJG0JcH2Cv8vCcBzNLqV+xlAkqxZa7jBbB8So89tONUiRhf7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgssek1GEgWa0Kzr57dCm8hCtYGVk/wWnkrT4LP+s2nNXMffh
	CbiHcQEKFbM+doAglJawX/NTNNk0kV3tw8t6bCxaPcJDAKEYHclEXgR8
X-Gm-Gg: AR+sD109dXHBV3p19H+PZkIDrpdpIomp0W07Wn1dIoAMSX4Ko0xUzPUiB+k9LCH88c8
	f3Oel0ZRVfcwiEaFXt5W+xZjra9mcByCuGG7gf4qTlkjm+HqrWWD8l/T5uw9E7LHutOEgU6resd
	mjsVjwSBDOre3pUgkp682YX1uoaeKug8bs7fLrTqKtrKf/KIY7KMgedCA1G6eRjKvHTVCJms7n3
	RWwiUNEGHKwJO//yCsxXEP4miJn2FLl6H5gsqRHsb8Z8RUEzRJiI6wpuOYfTBIS/flLri1L6HNX
	EV0HnYeH7zVIFhywaQ3gDy4xB3mSxLX0tNxSFjDhWgQvZ0DziP+RXUextn8uB0XX2a/yRlKuuwO
	Ec/kySFbd310ruQeaT93oxe+jw52gh8xn1NUdN98xbAHGhSRs5ayK/Az5zY3PxwbKORvS5mGTT9
	irBa/9KlpC2JUbbUSMcnrEa6/vqZa4owLmyE55VT981lTzOATI5ii1jAfOBf9IZZE=
X-Received: by 2002:a05:6a00:9501:b0:848:2f77:e2d7 with SMTP id d2e1a72fcca58-84e2c2208fbmr1505866b3a.64.1784773791358;
        Wed, 22 Jul 2026 19:29:51 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17578345sm2129549b3a.39.2026.07.22.19.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 19:29:50 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org
Cc: tipc-discussion@lists.sourceforge.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ying.xue@windriver.com,
	tuong.t.lien@dektech.com.au,
	linux-kernel@vger.kernel.org,
	Sangho Lee <kudo3228@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tipc: validate Gap ACK blocks header before parsing
Date: Thu, 23 Jul 2026 11:29:47 +0900
Message-ID: <20260723022947.1569915-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An established TIPC peer that negotiated TIPC_GAP_ACK_BLOCK can send a
STATE_MSG with fewer than the four bytes required for struct
tipc_gap_ack_blks. Basic TIPC message validation accepts such a message,
including one with an empty data area, because its declared size still
contains a complete protocol header.

tipc_get_gap_ack_blks() then dereferences the record to read len,
ugack_cnt, and bgack_cnt. Both callers compare the returned record size
with the declared message data length, but only after these fields have
already been read. The late checks therefore cannot protect the fixed
record header access.

This was reproduced on current net-next with two live TIPC nodes over a
veth bearer. Replaying an established peer's STATE_MSG with its message
size reduced from 44 to 40 bytes produced:

  BUG: KMSAN: uninit-value in tipc_get_gap_ack_blks
   tipc_get_gap_ack_blks
   tipc_bcast_sync_rcv
   tipc_node_bc_sync_rcv
   tipc_rcv
   tipc_l2_rcv_msg

  Uninit was created at:
   __alloc_skb
   alloc_skb_with_frags
   sock_alloc_send_pskb
   packet_sendmsg

The uninitialized record length then reached tipc_bcast_sync_rcv(), where
it was used to decide whether the STATE_MSG should be dropped. Supplying
four initialized bytes after the declared end of otherwise identical
messages also changed that decision: a trailing len of zero continued
processing, while a trailing len of four dropped the message. Protocol
processing therefore depends on bytes that are not part of the declared
TIPC message.

The KMSAN finding was reproduced for declared data lengths zero through
three. After adding the minimum-length check, none of those four inputs
reported an uninitialized value in tipc_get_gap_ack_blks() or its caller,
and bytes after the declared message no longer affected the decision.

Check that the fixed record header is present before parsing it. The
callers' existing size checks continue to validate the complete
variable-length record.

Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
Cc: stable@vger.kernel.org
Signed-off-by: Sangho Lee <kudo3228@gmail.com>
---
 net/tipc/link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 49dfc098d89b..8cc30ebdf575 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1418,7 +1418,8 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
 	u16 sz = 0;
 
 	/* Does peer support the Gap ACK blocks feature? */
-	if (l->peer_caps & TIPC_GAP_ACK_BLOCK) {
+	if ((l->peer_caps & TIPC_GAP_ACK_BLOCK) &&
+	    msg_data_sz(hdr) >= sizeof(*p)) {
 		p = (struct tipc_gap_ack_blks *)msg_data(hdr);
 		sz = ntohs(p->len);
 		/* Sanity check */
-- 
2.43.0

