Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047221;
	b=qyR/sRTxVA6iKH1hA5/nuhbIvwqKRVcVWI0bm3nccD6ZgKTyPAtdy1EHG5bqMP2d1axu
	 Iqlkg+qN1Ltxpd4mcCyv+MW20rDmrIBplIFmAupud4ECohDUqYVCJqiugjfcZRnd1GiIS
	 8M7R63qgp2Z0QVxjwPe1Y/UjWwZA+M1Pou8Sc9+YGSurRCkP4VFH/MtkIfsrS+5+Mt1Ri
	 g7aCbBgqe61N8Kjfk9kj668H7k6h7bpnrkr6yIyRwfQr7oJlBsEivqrXCeoxRsOQ0+d8/
	 YnCq+pM6BDcEgAGYQjtCCBgzfvbQBzZD+zjm4WHXYD81XWZriOydRcy1w583IOp4wmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047221;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ckQTNgRYymUQU7XCzqxrH7D/NGUePJ1i5UXtKEahd8U=;
	b=qie3hpe4jfEs7AoCJ6JVjD+7x6sNUAAGk/kZsMTLX8pgcKVQgBilzxBvpBoPov+VaWVn
	 n7lv09qjcgzjoN+HiZxYbxLXbcEOLMQ3Qxx98zDC/6KvV8wWBUY5faxABG978o5hvoV1V
	 QlwF+ffgQqLZywx8JyAM9pszbZuKv1CaDVvsw7MIN4Z3CkSRGZWYJA3Yatl5MvPnW2xxw
	 q6dP14HUzAO76tYnvyEgiUBa41MWXxhsJ2aOVC3F7jGZHNh5/TdfbbgyjF+IS2+QSGH48
	 GnfMw2QxJH2Cb8t2Oy9YwIO+Rp7tI38MPKgqa5RG1PGwkTy+1ykPTGeV4yqF7G3GD8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IP1yIQQ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43307606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IP1yIQQ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7414C1F0089F;
	Sat,  7 Nov 2026 10:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047221;
	bh=ckQTNgRYymUQU7XCzqxrH7D/NGUePJ1i5UXtKEahd8U=;
	h=From:To:Cc:Subject:Date;
	b=IP1yIQQ3QUNoZLzaOBlEG/Wi12fOm6386FslMMV86zmETy5fm6VbzQEL/smlDx/G6
	 Is7+X9T2ZWkfFEgKO+ob+3IVRkGHuuT9FZFW+I5kiLzH2OKvnoXIBieUeWDW0A8LSZ
	 CgpqT7vMvwd66482/lGwo8vj+HU6mVeB3QZqrYcbr1QbDwWSWLXKrA4fPYgRCA2a+a
	 OmsbpKcNDON4ZkKWMHI31UP+2T/qcqEeQhqVjl/Z/pTOJynlajAb+ltV5f9lGuBCdN
	 Zx1qrMlPItTWum1TP3k2LUqnPcyOfwn4mUDDFIpkdQapSxWnHp+LSGOusUFYD8PlVp
	 kWRXcuI/GtXBw==
From: Sasha Levin <sashal@kernel.org>
To: zhilinz@nebusec.ai,
	vega@nebusec.ai,
	idosch@nvidia.com,
	namangulati@google.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipmr: drop packets with unknown ingress VIF" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:59 -0500
Message-ID: <20261107052659-failed-6.12-09280680f2ea@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 09280680f2ea060514be2a39ea84209fb6d721d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052659-failed-6.12-09280680f2ea@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 09280680f2ea060514be2a39ea84209fb6d721d4 Mon Sep 17 00:00:00 2001
From: Zhiling Zou <zhilinz@nebusec.ai>
Date: Thu, 22 Oct 2026 03:01:16 +0800
Subject: [PATCH] ipmr: drop packets with unknown ingress VIF

A packet can race with VIF publication and make ipmr_find_vif() return
-1 even though the VIF device pointer is already visible. The parent VIF
device check can then pass with an invalid ingress VIF. For (*,G)
entries, this can also let the packet be forwarded back out its ingress
VIF.

Drop packets whose ingress VIF lookup fails in both IPv4 and IPv6
forwarding, before checking the MFC parent device. This prevents
forwarding with an unknown ingress VIF and avoids the (*,G) hairpin.

Without the early check, the negative index can reach the IPv4 offload
lookup only for an skb marked for L3 forwarding offload, currently done
by mlxsw. The race is rare; the supplied PoC reports only the UBSAN
negative-index diagnostic.

Fixes: 4eadb88244d1 ("ipmr: do not acquire mrt_lock while calling ip_mr_forward()")
Fixes: 9b1c21d898fd ("ip6mr: do not acquire mrt_lock while calling ip6_mr_forward()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Suggested-by: Naman Gulati <namangulati@google.com>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Reviewed-by: Naman Gulati <namangulati@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/5271fcb94a4d9e697ed64a348e92ea9e74faab1c.1792608753.git.zhilinz@nebusec.ai
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ipv4/ipmr.c  | 3 ++-
 net/ipv6/ip6mr.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 915b210c4512b..e8f7d3b573d0f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2089,7 +2089,8 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 	}
 
 	/* Wrong interface: drop packet and (maybe) send PIM assert. */
-	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
+	if (true_vifi < 0 ||
+	    rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
 		if (rt_is_output_route(skb_rtable(skb))) {
 			/* It is our own packet, looped back.
 			 * Very complicated situation...
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index a628acf50b0d8..af968a2c2a784 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2225,7 +2225,8 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	/*
 	 * Wrong interface: drop packet and (maybe) send PIM assert.
 	 */
-	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
+	if (true_vifi < 0 ||
+	    rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
 		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
 		if (true_vifi >= 0 && READ_ONCE(mrt->mroute_do_assert) &&
-- 
2.53.0




