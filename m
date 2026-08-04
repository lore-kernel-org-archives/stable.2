Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D42383C88
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844024; cv=none; b=bcU9VvYC0jzxSU2UEd9G0k1W+gdKIKRFz3SpACEtoXfjZVG2RLKMeW/C5rmRM+ek15zxAjq5gVf3CCbV0gJlYP891vw31+OQcPg7z7aFZfdLq9qZ4elx9eSXBWrzzwmfTJhgy72D+FSEUPTMH+xbwBh98oyBHDeHDfa55Sw6Sog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844024; c=relaxed/simple;
	bh=XxqNS50tBpxlE2P29zTDYXh7Xwj62CrJ08IlelI2hk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtmANtS3I3e7623DY6tsxh9yZrAl2UVEv00yYI4jWdVD1Gb2wAOz2H9Uuj15dqg4U4FHS/3ygwtM4OQvNwJHwcCbo/xqdGIwp1Mmwk+VvO0HcQyQ11atfcVjtnejNuSSZByEU4/YjirqhL7EMc/skqS21wJ7KV4ZIc+6F0hMAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT62ObCd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT62ObCd"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caced6038eso11299215ad.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785844022; x=1786448822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9tB62FksLX7ZQ0iAAw6nUq5NKmSatJoxx9sauneOGhA=;
        b=cT62ObCdeBUSqpxcFXDeB0uwsMFF4OSp9kkrSRWv8gPn3509GZuP2Qc32X1n8mvKtG
         8Q7rMinJdZ5mEzCFoB+4gWbvE28UAXZWhLi4J9TpWTm5pPxuBv7MnScHzpSfHJ/d/Z6f
         KRQNRLWiippd9tu7Q5dUCFZKU1WTgrcbquO9buKbFZQar7Ar9KSBLz7aTZrNehFGh79O
         FeAbBXXQK7caryojF6gakiGQ4vro5582wU2rvGkh0q6OAz+CgnlN4z5WRTzNf0PiQQ9I
         m63mRcqmCKECcoA09Waxw7b8Ifyx7/wKkm6/dzYDTpenHoSVuls4Ie/Ee00KFbW21J1T
         MQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844022; x=1786448822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9tB62FksLX7ZQ0iAAw6nUq5NKmSatJoxx9sauneOGhA=;
        b=n9rK6MrSZoMSQSkeVZCR4hL1r5JdZeOn5ZFmnARVjM0okM4NtUwu3GjKh5tRlBGnoP
         RxVg2Lz2JcBO/IMNfUa+4BVVAfPm1dzDTDlo7smF4W3spfrcx5X9c3DCjodUNEN/nhb8
         b6+18RPD0ctSVmC1uP7tELt4NuayUhaP4N/303I8Qfdswm2UxXccrj5PAhpTYvt6rIVm
         ttrbvQzg7Pr8RxYuviO2VdGenmmhkN7P7mBSim+m4LuicVG+aqQ5N5N3gtkObOyyyNJu
         jdq2qymNZI42vn6CugdIvysKzfk3vRiTBLGF7hRtuO5J+3p9UzqCeSw1WFPPL6eX0fzR
         a0zQ==
X-Gm-Message-State: AOJu0Yw8GE0evMuWLEsrqoOluq00Bph4pgSXY+nluyDHpOcEoIiVZ6Uk
	cwu+Jh8eacfwyfn+JevWoqrM8wjasC6thWPq9X/dvsPBdWU9qRJ3jQubQYTmQQ==
X-Gm-Gg: AR+sD12sYrQodpCQd07QIFwKsEFYk/eCqx0QwWrCVxNd0Vu+p1rB5PIYosqd3y9JRsH
	OgwpthoI5pR6PqmJEpBmwCwS6R84shFaEnKU8biXqE25sEcwQH/rDItbMyOTLZZxMtoHtn6bAGF
	DElzFf4aVAQrqX/dT9mFGsPV6z8ZloWlx2Q/XyGRi7cuOcQvXnNSVHkZfmQR/w+h3w82o3jCDEo
	CftOEEd6/LOPlqCKg4nv8+Phqe7g3oqgTNPVgvQhWPLjcTpP2E7Xb+UnZyzxZUeMbJBKXGXh8Gz
	BfO0CC3d2gomVqzE9MrCIT72JJ5fi1Qx0EPSCkTgzHE/MAxMPCsMBAyUk2oGVQmTStzsGsBS7Kt
	pKhuecUlBuQLO8oTPFV3oun3eaT4d6c2SKdH2SGka1/7SydWtjpM6sbRkH4euV29C3w7s37t+RV
	WZdEFgemEK9wvU5yohvkW4z/zBo8o9UhntfgSnMhn3U0o3GPG4koweKJkypRa5CgIj1Bdip+eyE
	PU=
X-Received: by 2002:a17:903:98f:b0:2cf:461a:3863 with SMTP id d9443c01a7336-2d08ab8bec3mr32019075ad.22.1785844021710;
        Tue, 04 Aug 2026 04:47:01 -0700 (PDT)
Received: from online.mioffice.cn ([43.224.245.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa013dafsm5778535ad.35.2026.08.04.04.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 04:47:01 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangpengfei16@xiaomi.com,
	Pengfei Zhang <zhangfeionline@gmail.com>
Subject: [PATCH 5.10.y 6.1.y 6.6.y] ipv6: fib6: fix NULL deref in fib6_walk_continue() on multi-batch dump
Date: Tue,  4 Aug 2026 19:46:54 +0800
Message-ID: <20260804114655.179105-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 9facb861dc6b9b9ea9793ef5032a9a826f7a4229 upstream.

inet6_dump_fib() saves its progress in cb->args[1] as a positional
index within the current hash chain.  Between batches, a concurrent
fib6_new_table() can insert a new table at the chain head, shifting
all existing entries.  The saved index then lands on a different
table, causing fib6_dump_table() to set w->root to the wrong table
while w->node still points into the previous one.
fib6_walk_continue() dereferences w->node->parent (NULL) and panics:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  RIP: 0010:fib6_walk_continue+0x6e/0x170
  Call Trace:
   <TASK>
   fib6_dump_table.isra.0+0xc5/0x240
   inet6_dump_fib+0xf6/0x420
   rtnl_dumpit+0x30/0xa0
   netlink_dump+0x15b/0x460
   netlink_recvmsg+0x1d6/0x2a0
   ____sys_recvmsg+0x17a/0x190

Fix by storing tb->tb6_id in cb->args[1] instead of a positional
index.  On resume, skip entries until the id matches; a concurrent
head-insert can never match the saved id, so the walker always
resumes on the correct table.

Fixes: 1b43af5480c3 ("[IPV6]: Increase number of possible routing tables to 2^32")
Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20260625070517.965597-1-zhangfeionline@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Adapted to 5.10/6.1/6.6: inet6_dump_fib() there predates 22e36ea9f5d7
 and 5fc68320c1fb, so the return variable is "res" not "err" and the
 RCU-protected hash walk exits via "out_unlock" instead of "unlock".
 Context-only change; the fix itself is identical.]
Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
---
Notes for maintainers, not for the changelog:

This fix was picked up for 5.15.y, 6.12.y, 6.18.y and 7.1.y, but
silently dropped for 5.10.y, 6.1.y and 6.6.y, where it does not apply.
Those three are the only maintained trees still missing it.

The two mainline commits that reshaped inet6_dump_fib() are

  22e36ea9f5d7 ("inet: allow ip_valid_fib_dump_req() to be called with
                 RTNL or RCU")                                  -- v6.9
  5fc68320c1fb ("ipv6: remove RTNL protection from inet6_dump_fib()")
                                                                -- v6.10

6.12.y and later already contain both, since they branched off after
v6.10.  5.15.y had both backported as prerequisites together with the
fix, which is why the unmodified patch applied there.  5.10.y, 6.1.y and
6.6.y never received them, so the upstream patch no longer applies.

I did not backport those two commits on purpose: they are RTNL
scalability work rather than fixes, and 22e36ea9f5d7 touches six files
including common inet code.  Re-contextualising the fix is the smaller
and safer change for these trees.

The race is unaffected by the locking difference -- it happens between
netlink dump batches, when no lock is held at all -- so the older
RTNL-held shape is equally exposed.

inet6_dump_fib() is byte-for-byte identical in 5.10.262, 6.1.180 and
6.6.148, so this single patch covers all three.  Build- and boot-tested
on each of them.

 net/ipv6/ip6_fib.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -625,11 +625,11 @@
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	unsigned int h, s_h;
-	unsigned int e = 0, s_e;
 	struct fib6_walker *w;
 	struct fib6_table *tb;
 	struct hlist_head *head;
 	int res = 0;
+	u32 s_id;
 
 	if (cb->strict_check) {
 		int err;
@@ -687,25 +687,24 @@
 	}
 
 	s_h = cb->args[0];
-	s_e = cb->args[1];
+	s_id = cb->args[1];
 
 	rcu_read_lock();
-	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_e = 0) {
-		e = 0;
+	for (h = s_h; h < FIB6_TABLE_HASHSZ; h++, s_id = 0) {
 		head = &net->ipv6.fib_table_hash[h];
 		hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
-			if (e < s_e)
-				goto next;
+			if (s_id && tb->tb6_id != s_id)
+				continue;
+
+			s_id = 0;
+			cb->args[1] = tb->tb6_id;
 			res = fib6_dump_table(tb, skb, cb);
 			if (res != 0)
 				goto out_unlock;
-next:
-			e++;
 		}
 	}
 out_unlock:
 	rcu_read_unlock();
-	cb->args[1] = e;
 	cb->args[0] = h;
 out:
 	res = res < 0 ? res : skb->len;
-- 
2.54.0

