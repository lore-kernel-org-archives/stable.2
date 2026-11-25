Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634622;
	b=d9qO/xgj2EDayL21izvqMMYuolJZwURBlL1oaYOY1xTPbocKr0HsuGVU2fEEAW40Iwas
	 IRLh6sCbX/GSNEczA6S/N63VlnRStadix//0o4SuUS/BaNa0mB9KZgFs3OI8J3D++gBE9
	 XShkl8qATA9r6kzbp/86g3L9C/eepjeQmMpEo7gfTOQ0bMR1rBzwM4sAXMLkhbN8fTd5h
	 fDdivWbvGYSYYmOuerI8JNvDnmRy+7g7503WrHlbw3FCBEKPgkV5LXszr08GtPYaFUuyQ
	 tErh42SAJSJy/8c+aXvQHIGOlTrFnX7KTSy08HOrNlPrDsvDGXkAAQ7SpFhDxbvvcMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xrbqO5ltApkYwdYD3qZQSLfK8KscIUV+8il5u80/3Pw=;
	b=dNC4FeS2jHQpccBuD+SdsAEmkuduQO5u7s0boGNyVrhIjrflKCUO37ARMjNzBwyDNvss
	 9Im9n5goCWREqTsgsHo0DhEz1VWS3JfoXGIvXuEw8lEQkHwDzZNrsv+mUn7b7mT/gSHPX
	 OjM6hmgPZp5pbpzXsMCcs21kbLCyxp7ePW7ilL/lHMcan4o9nvor/y1wtW+scg+LK7bKq
	 We9247f59PvR45vLo9/x8PNEZ2CJt8DL8lJqtiT7D3g0+jy8DliZ3+IRdZ6f7dYp6BQ4n
	 zSplSYtyQeIc/zMbAOOqAUG6N9IKB3EAd0005wg5u/RU4bEpmHqxIUPssb1+c/r0P8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=dL2qKoXf;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8F606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85A8F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=dL2qKoXf
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f02ee04378so49603575ad.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795634622; x=1796239422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrbqO5ltApkYwdYD3qZQSLfK8KscIUV+8il5u80/3Pw=;
        b=dL2qKoXfGzBI6B7NKOXigDwU5PxOzEuvWofo76UVvP/l00kjTMObxTIdZvjQy+Fe37
         hF9oBV4Y2IMTjh9PmVUR0K/knPY2pMi+TwF97lNrZLqxL40W7dKP4g9EPiomrsKxZLgM
         J/cps4/5g3h35YWPB3c6S22j8WlS8KnMf1upj4rUxWywQHOPMldJF+7B6uGugq9gT17H
         BeH2tWL6aP1tHOcv1zwe9NaJYYpsBm6FjoTecXSPqYHkVD3cME9B061HAgm3SVtO+NS1
         0DjbbElY5WlseYhgZBtRjVzS0ld+oANXealst7A7C9DHRCaYWObxxucH6u4x4EU1BkCN
         GzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634622; x=1796239422;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xrbqO5ltApkYwdYD3qZQSLfK8KscIUV+8il5u80/3Pw=;
        b=cRv2t7/0DX4qq3CmcLcndtvX9KzKGtNR/zYG3UjhzzsjkHE/mLcaDkhYmta7G35Ws9
         iBZDA7ETQc3W2F+AjDjpWwDbQg92Sf1ZGBtMMMecca2kpwGVFKF0cqtUTp4J0TKAWHjW
         xVfX21vT1t8YxQ6RE7NTGbCDWhs6nH7pwz+WYrtyAw18FkHSvtRRCM1UNadI+ctN4feu
         1PuQcPGMLTT4K1G5NTh91kBKa3KzSDyxpEgbhreGAxNAYLONmHnRF25EwRwluPdwXcs+
         fdpDtVXwwx+afzPvcufB9wv6x+kiLgb/pEfS4pBsQ1YrrzMo3zBXRXvJGzHLz5uXYZxc
         ZEaw==
X-Gm-Message-State: APuU4Z9krkJxCMDgrNg0TJHR2ebdjlZCPFK2zVtpeh26UVJ1f0yR/HXo
	AJCuAyG5U1vbMWr95VsoF82Tp/eq/Dxgq0hr4zRffBRevWN+aHKDV74cmDRGT6MImuoAPW74X4K
	MJCyYf+c=
X-Gm-Gg: AZFdTZe6hds/ZlXXNCxnJmwwBzittGsXmirOEGU/DT9y5RbgC8HEsoSp+E6cQhb1FIU
	gr0+khK9v1Cc6qzuwWuDGeZMeXYO+ECf6LGTEJzFHNakgwBXXXOtz1LqHqoMtwWHpLDv8QZlHSQ
	/yhYr0UsH7nbazU2pBPycSApy1pVTLlgLqIPPFS9TysukY8NmXTSBR391vaVcoLfVf11LbIE8Ui
	/ig20r4yGPM4exOzOwLDWbQbpTeLH1jo6MnSeTFGB6Sd+IekO+Q+tQY79DRgBpzfcfJwsycEaqr
	iWsMIcrujN1cFhiIFFzuY3AHy+gw4Jh25AhimMwQFXih6qBLToqG+WXnPp6CdWA7lVFYP2NiLs2
	BPySPRyk3wOj5ZBf18Z3/IhNffz6LyLpPtTt16rPfvQ99jshYqHRse5ftIl5SgSWLzTacnC+RTK
	88Efxr8Yk0HkeGFFPDQmWs+JWeH3Qxe74PGZ8xYgMGXfTjEc8O5zo6FgfQTeiPHgjfNW+QZ8GAv
	HZ3M1JcUBoeHexi4Y+w3noCR/Xo8U8AkmE/jNfW5LaEK8t3YuP8r/Xi2tdsbxz7aQoRi9wY8DWx
	mGPj8rXyXExoz3SWCl0o5VDfA6n2VQxk7sD5U8Ac8q8F2FpBDsGYKDGqPOxpYbCHyvE19P1cVYa
	FVun0Y85U+KQB11jT7gnqElxu+A==
X-Received: by 2002:a17:903:4b03:b0:2ed:ebc:460f with SMTP id d9443c01a7336-2f03f2118f0mr193132015ad.33.1795634621862;
        Wed, 25 Nov 2026 11:23:41 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dbe86sm91925275ad.32.2026.11.25.11.23.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:23:41 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jamesburton@meta.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH 6.18.y] netlink: do not free nlk->groups while lockless readers can use it
Date: Wed, 25 Nov 2026 14:23:38 -0500
Message-ID: <20261125192338.48141-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Sep 2026 16:08:04 +0000

[ Upstream commit ceac0de741bfb47ca255eee075257b3bb31f0651 ]

netlink_realloc_groups() uses krealloc() under netlink_table_grab().
Whenever NLGRPSZ(groups) lands in a different kmalloc bucket, the old
bitmap is freed immediately.

Two readers of nlk->groups / nlk->ngroups do not hold the netlink
table lock:

1) sk_diag_dump_groups(). Hashed (bound) sockets are dumped from the
   rhashtable walk in __netlink_diag_dump(), which only holds RCU.
   Only the mc_list part of the dump takes nl_table_lock.

2) netlink_native_seq_show() (/proc/net/netlink), whose walk has been
   lockless since commit 21e4902aea80 ("netlink: Lockless lookup with
   RCU grace period in socket release").

Both can read a freed buffer, and sk_diag_dump_groups() can also read
past the end of the old (smaller) buffer if it happens to load the old
@groups pointer together with the new @ngroups value, copying the
result into a NETLINK_DIAG_GROUPS attribute.

This is the same class of bug that commit f773608026ee ("netlink:
access nlk groups safely in netlink bind and getname") fixed for bind()
and getname(); these two readers were missed. Simply grabbing the table
lock in sk_diag_dump_groups() is not an option, because it is also
called with nl_table_lock already held from the mc_list section of the
dump.

Make the lockless readers safe instead:

- Allocate a new bitmap and free the old one after an RCU grace period,
  instead of relying on the implicit kfree() done by krealloc().

- Publish @groups before @ngroups, both with release semantics, and have
  the lockless readers load @ngroups first. A reader can then never pair
  the new (bigger) size with the old (smaller) buffer, and a reader
  picking up the new pointer while still seeing the old size is
  guaranteed to see the initialized bitmap.

netlink_realloc_groups() is called from process context (bind() and
setsockopt()), so kfree_rcu_mightsleep() can be used, once the table
has been released.

Fixes: 21e4902aea80 ("netlink: Lockless lookup with RCU grace period in socket release")
Fixes: ad202074320c ("netlink: Use rhashtable walk interface in diag dump")
Reported-by: James Burton <jamesburton@meta.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260911160804.917099-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Backport to 6.18.y: context adjusted in netlink_native_seq_show(),
  where 6.18.y prints sock_i_ino() with "%-8lu" instead of "%-8llu";
  the code change is identical to upstream. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please apply this backport to 6.18.y. It fixes CVE-2026-98284.

The fix is in 7.2.8 and in mainline since 7.3. It carries no stable tag
and so far has been backported only to 7.2.y. The upstream commit does
not apply to 6.18.y as a plain patch because of one context line; a
three-way cherry-pick gives the same result as this patch.

Compiled net/netlink/af_netlink.o and net/netlink/diag.o with
CONFIG_WERROR=y on 6.18.65 from a cumulative x86_64 tree, with and
without the current queue-6.18 patches. No kernel boot or runtime test
was performed.

An LLM was used to prepare this backport and to check applicability and
stable-queue history; I reviewed the result.

Thanks,
Artem Dinaburg

 net/netlink/af_netlink.c | 42 ++++++++++++++++++++++++++++++++--------
 net/netlink/diag.c       | 20 +++++++++++++++----
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index fb7785a59af5..e62c25865fd2 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -923,9 +923,9 @@ netlink_update_subscriptions(struct sock *sk, unsigned int subscriptions)
 
 static int netlink_realloc_groups(struct sock *sk)
 {
+	unsigned long *new_groups, *old_groups = NULL;
 	struct netlink_sock *nlk = nlk_sk(sk);
 	unsigned int groups;
-	unsigned long *new_groups;
 	int err = 0;
 
 	netlink_table_grab();
@@ -939,18 +939,37 @@ static int netlink_realloc_groups(struct sock *sk)
 	if (nlk->ngroups >= groups)
 		goto out_unlock;
 
-	new_groups = krealloc(nlk->groups, NLGRPSZ(groups), GFP_ATOMIC);
-	if (new_groups == NULL) {
+	/* Can not use krealloc(), because the old buffer might be freed
+	 * immediately, while lockless readers (netlink diag dump and
+	 * /proc/net/netlink) can still be looking at it.
+	 */
+	new_groups = kzalloc(NLGRPSZ(groups), GFP_ATOMIC);
+	if (!new_groups) {
 		err = -ENOMEM;
 		goto out_unlock;
 	}
-	memset((char *)new_groups + NLGRPSZ(nlk->ngroups), 0,
-	       NLGRPSZ(groups) - NLGRPSZ(nlk->ngroups));
+	old_groups = nlk->groups;
+	if (old_groups)
+		memcpy(new_groups, old_groups, NLGRPSZ(nlk->ngroups));
+
+	/* Publish the new bitmap and its content: pairs with the address
+	 * dependency in lockless readers, which can pick up the new pointer
+	 * while still seeing the old (smaller) nlk->ngroups.
+	 */
+	smp_store_release(&nlk->groups, new_groups);
+
+	/* Then publish the new size: pairs with smp_load_acquire() from
+	 * lockless readers, so that they can not read NLGRPSZ(new ngroups)
+	 * bytes from the old buffer.
+	 */
+	smp_store_release(&nlk->ngroups, groups);
 
-	nlk->groups = new_groups;
-	nlk->ngroups = groups;
  out_unlock:
 	netlink_table_ungrab();
+
+	if (old_groups)
+		kfree_rcu_mightsleep(old_groups);
+
 	return err;
 }
 
@@ -2718,12 +2737,19 @@ static int netlink_native_seq_show(struct seq_file *seq, void *v)
 	} else {
 		struct sock *s = v;
 		struct netlink_sock *nlk = nlk_sk(s);
+		const unsigned long *groups;
+
+		/* Lockless read : netlink_realloc_groups() can change
+		 * nlk->groups under us. The old buffer is freed after an
+		 * RCU grace period, and this walk is RCU protected.
+		 */
+		groups = READ_ONCE(nlk->groups);
 
 		seq_printf(seq, "%pK %-3d %-10u %08x %-8d %-8d %-5d %-8d %-8u %-8lu\n",
 			   s,
 			   s->sk_protocol,
 			   nlk->portid,
-			   nlk->groups ? (u32)nlk->groups[0] : 0,
+			   groups ? (u32)groups[0] : 0,
 			   sk_rmem_alloc_get(s),
 			   sk_wmem_alloc_get(s),
 			   READ_ONCE(nlk->cb_running),
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index b8e58132e8af..16de6618e0be 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -12,12 +12,24 @@
 static int sk_diag_dump_groups(struct sock *sk, struct sk_buff *nlskb)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
-
-	if (nlk->groups == NULL)
+	unsigned long *groups;
+	unsigned int ngroups;
+
+	/* Hashed sockets are dumped from the rhashtable walk, which only
+	 * holds rcu_read_lock(), while netlink_realloc_groups() can replace
+	 * nlk->groups and nlk->ngroups at any time.
+	 *
+	 * Read nlk->ngroups first : this pairs with smp_store_release()
+	 * from netlink_realloc_groups(), so that we can not use the new
+	 * (bigger) size with the old (smaller) buffer. The old buffer is
+	 * freed after an RCU grace period.
+	 */
+	ngroups = smp_load_acquire(&nlk->ngroups);
+	groups = READ_ONCE(nlk->groups);
+	if (!groups)
 		return 0;
 
-	return nla_put(nlskb, NETLINK_DIAG_GROUPS, NLGRPSZ(nlk->ngroups),
-		       nlk->groups);
+	return nla_put(nlskb, NETLINK_DIAG_GROUPS, NLGRPSZ(ngroups), groups);
 }
 
 static int sk_diag_put_flags(struct sock *sk, struct sk_buff *skb)
