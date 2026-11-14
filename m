Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794661778;
	b=w5BkGVQhIGPsJ5bjh/dQFbOGLupXbHKVXCzIIdpyjGopxLv5zKaS4NKUtR1yjjAPWoR3
	 wwp7pG76yopywVfOJTEu76qsVoAz8o3cqu0GO9ctXnTmHnazJN/7ama4BdswuBKIMgj/o
	 DP5o8i8LWB+6CHq7y/eRbR+hAOsHQRvXUh5SwCETR7GVeeI1FFXScBn96R2SOr2X+ee1X
	 R6CGNVlcejEsNg7n6LEjwGQ19Ohmf8PBrHP2SEcbwNqXKRFePpH8uycQjIttyklrbYktd
	 x7huPTTAVSz4GfKMk1AdPMi9oQq0WGwMMMhySAPVMcbSjJYtHJAy/V6PJxHwFq1xlXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661778;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yTztLTqw12rdN7/Uw5DEdcju+OrXmRfrHG3yaxKlPWM=;
	b=M2D17kHaKg/CIvQQah7D6KinjOlv/eytkbNyHUXoQgpK6L3A/SCwSMmgmBRG2mj0aoPu
	 El+PcyUM/QSpSe0C4lh6IRM+qt8/FEqaKFKtwD2dUgEq/0oTscBBZrQ3GlQUyMI5MfiGW
	 M5ar84CWIcsV2xw2w2p132eqfTtFrVd034Qg/UiTywhKV6OtoMieoaEWYHP+qhN4wc8+t
	 vBC2PkNd0HhuzBvxE60Td9AuUZEMFXKdfKD4AigcTpyjkd5r73M2TyzOwutCkKP9cCU8L
	 EiBfh1Vo0/3c4lXkxKN2fsWvRQU1FvbjFah1+kdd/D/SL88B7k40g+yOur9KUCwcDfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="JLH/p4+a";
	arc=none smtp.remote-ip=203.205.221.164
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CB66077E3D;
	Sat, 14 Nov 2026 13:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34CB66077E3D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=JLH/p4+a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794661775; bh=yTztLTqw12rdN7/Uw5DEdcju+OrXmRfrHG3yaxKlPWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JLH/p4+aEBwFkkI32rUuo+ynCUteBbQVDFloAkKjfk5naEvFQH4l8QDZxBxQcy1en
	 EU318Hj9JIKq+NGER6D49rODtRpTgjyZOmrbL+5/GRQpwnX7MUFClbOQpZyx0IlYqg
	 RwrAQ0TtnRZoNwT31efc8UrvPXEBLXgl4lARqPYA=
Received: from localhost.localdomain ([2409:8d5c:8f0:65e5:7443:873c:1230:8af8])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 25C3B2E4; Sat, 14 Nov 2026 21:09:28 +0800
X-QQ-mid: xmsmtpt1794661771tdqou28dd
Message-ID: <tencent_CCBF2706A4D1AFF8F48632FE8B56FB67E207@qq.com>
X-QQ-XMAILINFO: NXvILt21hDllwcpAvgNDyJaP3Mj2Oh3Q+AM5iYKyy9Ic5OJiZvts7IvEZZIi7y
	 MkaIJPwVXaXBc8Bk2BaznScevLgueoqpT/7ArIHa/FoABY/8Du9wMa8ldUAda2F9SPSrplr6SlDw
	 arQwl310dptb7AP3phS/0dsbBEy+MBvUEsN5ZzkV7wcRUG0LaOqtfzVSEkgDstL1mWbgTmt2THl2
	 HazgXxt1UpcAz/XpJGwpfZEHd9fECsA6FehL8vFzFUST4hEtC/syyNmkyAnAQ7evqZwEO/7w1TK0
	 59+URA7mG95/8eTDkVIddn28x1XAbcwZqOPB2BbdmhwaBFhy/8jgA0z16a8vkfisEjEU/YU0WKzK
	 PzWj/ADlKZnf9Zk3fHHSn7BrXHPm9llMPjj5p1+4WosOvuqCuJic/cOhtPL+XYF4kobYAjm9asxZ
	 f7+T1dxfnNmasTDDYnT/XhCCE0nKtS0To8+H1BAC87h3rOEgqWu8Mk4lfKdRlR8MJJzP3daOjME+
	 Tr6QDPEsZgJ8cMKtIPKwCjUC3HbT+AeIUjDQu0JQz3Ch46QyjLKBM4MNSrBIzRoQ+tnp2m5xRR9N
	 +eLeCdtM63JqmkbtZW7Gpc7HmRZ3Zs9BctCna2K7XwSHFZj5oqZzhxU+hHvy+qPgQ4E0SIKwg2Yj
	 8fGx+Ic+x1J0guK/OPXFN5CEdyl+AP/fhDSaEUjb10CIXiEd7ofaQxD8rXXTx9WeQ9NCzweL73F1
	 c+yAawEhtKTIku+a4OM9oRrVCatZlApkSKobi2yB+YWgTThBX/uc18FbYCzv8u3wt37xoZjLdOyH
	 i8diLSFkymjsPiVbykWy9NRIS2SJd+/mf3fHjgszfodI/r45TBC+XHZ2cKk7vvvZMCV3Ru4QTgkD
	 af0ExYRXoiJ8l0NP1tAUbWGExPxhyRG4Iob+MpXjLoyLM10aYE4B2Z/QevA1MMZF/mAhsOIZmnJj
	 4iVy9HfAaT4ZodUuiwxYcJdPXMXwYtWIlmG71zmAUjwJMC9Hioefijn/5MvKtetBWs6drTDYDbU7
	 +28mKYxvljXbtL86GZBj8fKJaAsZxu1JiIl8t6ev190i05neFvx3AWeyWy0wziNpRnj5f9/43RuW
	 XLJrvBT0EAsVPRaF/u5MMXAZqXT7W8VshYntxXEIYoF2CQkJiflu7URo+k2L4JugK5osuz
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Hang Nan <2122295973@qq.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	2122295973@qq.com
Subject: [PATCH net v3 1/4] net: mptcp: take token lookup references with acquire ordering
Date: Sat, 14 Nov 2026 21:09:24 +0800
X-OQ-MSGID: <20261114130927.91839-2-2122295973@qq.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114130927.91839-1-2122295973@qq.com>
References: <20261114130927.91839-1-2122295973@qq.com>
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

mptcp_token_get_sock() and mptcp_token_iter_next() take a reference on a
socket found on an RCU-protected hash chain and then re-read state to
decide whether that socket is the one they were looking for.  The
re-validation is only meaningful if it is ordered after the reference
acquisition.

The sockets come from mptcp_prot.slab, which is SLAB_TYPESAFE_BY_RCU, so
the memory a reader still points at can be freed and reallocated as a new
mptcp socket while the reader is between the chain walk and the
increment.  The new owner publishes itself in sock_init_data_uid() with

	smp_wmb();
	refcount_set(&sk->sk_refcnt, 1);

and initialises the rest of the socket only afterwards.  A reader whose
increment does not carry acquire ordering can have the re-read of
msk->token and sock_net(sk) satisfied before the increment, that is
against the old object's contents, while the increment itself succeeds on
the new one.  The lookup would then hand back a socket that belongs to a
different connection, or one that is not initialised yet.

refcount_inc_not_zero() has not provided that ordering since
commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t"),
which removed the ordering the previous atomic_add_unless() based
implementation gave; refcount.h names this exact case as the reason the
acquire variants exist.

commit 5b5d8f351dd9 ("net: restore refcount ordering for lockless socket access")
restored the ordering for the IPv4/IPv6 established lookups,
inet_twsk_purge() and bpf_sk_assign().  These two mptcp sites have the
same shape and are converted as well.  There is no behaviour change on
strongly ordered CPUs.

Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
Fixes: 96d890daad05 ("mptcp: add msk interations helper")
Cc: stable@vger.kernel.org
Signed-off-by: Hang Nan <2122295973@qq.com>
---
 net/mptcp/token.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index e0f2823f92ef..3429b43a9f7c 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -309,7 +309,7 @@ struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
 		    !net_eq(sock_net(sk), net))
 			continue;
 
-		if (!refcount_inc_not_zero(&sk->sk_refcnt))
+		if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 			goto not_found;
 
 		if (READ_ONCE(msk->token) != token ||
@@ -370,7 +370,7 @@ struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long *s_slot,
 			if (num <= *s_num)
 				continue;
 
-			if (!refcount_inc_not_zero(&sk->sk_refcnt))
+			if (!refcount_inc_not_zero_acquire(&sk->sk_refcnt))
 				continue;
 
 			if (!net_eq(sock_net(sk), net)) {
-- 
2.47.3

