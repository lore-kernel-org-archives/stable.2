Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15B3128B8
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021619; cv=none; b=EhzsHgOJjdSlpIfL1jN9rKzUejr9ZRRyA6RuAPBWWeaEF2X/esV69/LYqTnXy4GX5st5qgMx65j/s/OvT5HeYZH9O75xhk5yKb9SnFpGDABvrD8OoT4pkNr0naVMhMeszcqp89cTT4VEYWr+7Z+FyqSd9iodR2sonX3h6GzGdyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021619; c=relaxed/simple;
	bh=yVRR7HQWDAtDxhP8EEL0+cb90kUT+O0wmfNEC/haeMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1hlNJWGSnD7DXOE+44ugNG9E9JBsh/iEcxKlwNOyNELhNwvx7L0nH6X3t1CTbybVa+sAXD0BCnz+fKFp2mvcNT5vpSO1e8E39fZfGobE+xUCkhe58aGxA8eqBYY50EYTi4N5pELnfLks0/Xn/NZ7mcTttCBZf9z/DcWsN69oiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec90Vrae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec90Vrae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F751F000E9;
	Thu,  6 Aug 2026 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021614;
	bh=VHIyHLcGIKl2hS4qx83hploHDLwQTVKKgU7p4LLlVWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ec90Vraeqnu4LLJOCgJ0zgL7A6/RgwLA52D/zzM6KC+szqGW0WQXdQ/1wrH/rKTYD
	 jIYxfZ/JmHqMqzRXrMmRGHaCN+fJutiH9IrTkTrnpixRfHVxlajJTHTFpSJUagoGRd
	 ubc4JNAvsPVZb+Tby3w75Jm/IM7VO8KC/LqdeYtClqvvpkPNov3oljaOXu2CrAcsvx
	 3x8WsQXWeNr53ZPsejOSHuIWkWQuyhelt0lnU2iqVh6ZGEDjFNzRw8zQrU8SKHFFrG
	 o36++hO1K+7WkXNlJuctXW3obUen7qf1EKXObrsshITr1l9wNZbxRJAcjLoIEYwmpr
	 H2aA6arnBjZIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	syzbot+4924a0edc148e8b4b342@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] netfilter: nf_tables: clone set on flush only
Date: Thu,  6 Aug 2026 09:06:52 -0400
Message-ID: <20260806130652.335098-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026073005-coerce-divisibly-805e@gregkh>
References: <2026073005-coerce-divisibly-805e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit fb7fb4016300ac622c964069e286dc83166a5d52 ]

Syzbot with fault injection triggered a failing memory allocation with
GFP_KERNEL which results in a WARN splat:

iter.err
WARNING: net/netfilter/nf_tables_api.c:845 at nft_map_deactivate+0x34e/0x3c0 net/netfilter/nf_tables_api.c:845, CPU#0: syz.0.17/5992
Modules linked in:
CPU: 0 UID: 0 PID: 5992 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:nft_map_deactivate+0x34e/0x3c0 net/netfilter/nf_tables_api.c:845
Code: 8b 05 86 5a 4e 09 48 3b 84 24 a0 00 00 00 75 62 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc e8 63 6d fa f7 90 <0f> 0b 90 43
+80 7c 35 00 00 0f 85 23 fe ff ff e9 26 fe ff ff 89 d9
RSP: 0018:ffffc900045af780 EFLAGS: 00010293
RAX: ffffffff89ca45bd RBX: 00000000fffffff4 RCX: ffff888028111e40
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: 0000000000000000
RBP: ffffc900045af870 R08: 0000000000400dc0 R09: 00000000ffffffff
R10: dffffc0000000000 R11: fffffbfff1d141db R12: ffffc900045af7e0
R13: 1ffff920008b5f24 R14: dffffc0000000000 R15: ffffc900045af920
FS:  000055557a6a5500(0000) GS:ffff888125496000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb5ea271fc0 CR3: 000000003269e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __nft_release_table+0xceb/0x11f0 net/netfilter/nf_tables_api.c:12115
 nft_rcv_nl_event+0xc25/0xdb0 net/netfilter/nf_tables_api.c:12187
 notifier_call_chain+0x19d/0x3a0 kernel/notifier.c:85
 blocking_notifier_call_chain+0x6a/0x90 kernel/notifier.c:380
 netlink_release+0x123b/0x1ad0 net/netlink/af_netlink.c:761
 __sock_release net/socket.c:662 [inline]
 sock_close+0xc3/0x240 net/socket.c:1455

Restrict set clone to the flush set command in the preparation phase.
Add NFT_ITER_UPDATE_CLONE and use it for this purpose, update the rbtree
and pipapo backends to only clone the set when this iteration type is
used.

As for the existing NFT_ITER_UPDATE type, update the pipapo backend to
use the existing set clone if available, otherwise use the existing set
representation. After this update, there is no need to clone a set that
is being deleted, this includes bound anonymous set.

An alternative approach to NFT_ITER_UPDATE_CLONE is to add a .clone
interface and call it from the flush set path.

Reported-by: syzbot+4924a0edc148e8b4b342@syzkaller.appspotmail.com
Fixes: 3f1d886cc7c3 ("netfilter: nft_set_pipapo: move cloning of match info to insert/removal path")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c     | 10 +++++++++-
 net/netfilter/nft_set_pipapo.c    | 11 +++++++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index aac4e1c543008..4056d22724873 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -302,11 +302,13 @@ struct nft_set_elem {
  *
  * @NFT_ITER_READ: read-only iteration over set elements
  * @NFT_ITER_UPDATE: iteration under mutex to update set element state
+ * @NFT_ITER_UPDATE_CLONE: clone set before iteration under mutex to update element
  */
 enum nft_iter_type {
 	NFT_ITER_UNSPEC,
 	NFT_ITER_READ,
 	NFT_ITER_UPDATE,
+	NFT_ITER_UPDATE_CLONE,
 };
 
 struct nft_set;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index fb469623f9cf6..2c894a7d8a401 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -655,6 +655,11 @@ static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
 	}
 }
 
+/* Use NFT_ITER_UPDATE iterator even if this may be called from the preparation
+ * phase, the set clone might already exist from a previous command, or it might
+ * be a set that is going away and does not require a clone. The netns and
+ * netlink release paths also need to work on the live set.
+ */
 static void nft_map_deactivate(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	struct nft_set_iter iter = {
@@ -7396,9 +7401,12 @@ static int nft_set_catchall_flush(const struct nft_ctx *ctx,
 
 static int nft_set_flush(struct nft_ctx *ctx, struct nft_set *set, u8 genmask)
 {
+	/* The set backend might need to clone the set, do it now from the
+	 * preparation phase, use NFT_ITER_UPDATE_CLONE iterator type.
+	 */
 	struct nft_set_iter iter = {
 		.genmask	= genmask,
-		.type		= NFT_ITER_UPDATE,
+		.type		= NFT_ITER_UPDATE_CLONE,
 		.fn		= nft_setelem_flush,
 	};
 
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 4a6561ba6061c..7c8d28a031ad5 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -2199,13 +2199,20 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 	const struct nft_pipapo_match *m;
 
 	switch (iter->type) {
-	case NFT_ITER_UPDATE:
+	case NFT_ITER_UPDATE_CLONE:
 		m = pipapo_maybe_clone(set);
 		if (!m) {
 			iter->err = -ENOMEM;
 			return;
 		}
-
+		nft_pipapo_do_walk(ctx, set, m, iter);
+		break;
+	case NFT_ITER_UPDATE:
+		if (priv->clone)
+			m = priv->clone;
+		else
+			m = rcu_dereference_protected(priv->match,
+						      nft_pipapo_transaction_mutex_held(set));
 		nft_pipapo_do_walk(ctx, set, m, iter);
 		break;
 	case NFT_ITER_READ:
-- 
2.53.0

