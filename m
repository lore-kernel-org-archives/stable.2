Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047984;
	b=so62ggvRFrn7LTlC2LrNK8nGEBhlHVAVsa1lbLTb8sOrP/a7dzdAto78DxQ2/SA6nmrb
	 4wubs7SZKF6CkWn62coDjPCF5x4FfVP2DYJIWNWVU0MOwMYoiP6XoNr9imIaJDQoDQH3H
	 OiB1yXT/v6ozwsQNfGr2n2bbRHOLwJrJ2Pwyvf4BxeM6CxOMwOB0EbdltoGhjDEcToIcM
	 cLJWCiKG8FRx3w0VKh+VbGDO/B+Tb9z7wpfm2lmPXyk0dQkdRMSeA0ZxzTfvkUudekLxV
	 PIsOsHs/W6ruKqL5JpJ4Cm+oH07O9YF4jO0batcF9yk4Lu3cfi3oqitTcC4zdlxrh4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047984;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wtznuIau1JYsPOqe5nv8nU1BE7KmUwUvQORtqirvl1A=;
	b=hEu7C0KatT9JGhvDN/v48UU1bEXBk5LC0c5QIh7WiXnJdzlmYHT99c1ruj47dgbMhf7C
	 Fj0vaMPLJl2M/z3GhFoS6xr0GwfR1E4ZLD7cWXNSzEjEKbp5T8Y/JdkGPFTb+3B1Q03st
	 vHXTjoi580HLrYK6656M1dhBo2nMQbv+LOoKIizyv3wMoAWtSD2Crsl3Nix2ur4VYNt4p
	 T3gvUhas5nDpoj37c5mYfMa7o8SJrL4yT9syPKGBH4boGbNzjFlnQkaQvLaOrzb7qV8bN
	 1K/l9liP3BryRe2mYwdoPW0LLB4N1iTwE5Oq1IeIpRI3OXQc2tNZEQI+fs4EhhPIhqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3Duvwp+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3Duvwp+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2A21F0089F;
	Sat,  7 Nov 2026 10:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047983;
	bh=wtznuIau1JYsPOqe5nv8nU1BE7KmUwUvQORtqirvl1A=;
	h=From:To:Cc:Subject:Date;
	b=c3Duvwp+OqKe6QvrIxbuae1K9yYnF71ADVbSJB2ZaImvmV2sBmWg6YWvSI9Q8yeT2
	 jJoPUKWv8G1zpWqO0Mg7WdHsVAtsdqzVAUlRkcOTN9qmDDz7z30x7Pgggczo3MXiAg
	 d+gWVuyMzZ4kFdOE6cbogd/ySjzVtAa7rtEg5KDoIEc4bV1IkgWIabj8ACBhamY1Zw
	 4Dimbfsxub/eDFgywKlChqgmeUtTlcZT/47GGHgQmsN7BdsL8sJU5o98sgfdjnqLmL
	 yWwzkIOsrBZ2371D/Yo0x7fN2x+OC0NFVf04WCMvW5Bj3552aIUmN5DUHzg4XXcKf8
	 vSCSSasBIuRTQ==
From: Sasha Levin <sashal@kernel.org>
To: zhilinz@nebusec.ai,
	vega@nebusec.ai,
	idosch@nvidia.com,
	namangulati@google.com,
	kuba@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ipmr: drop packets with unknown ingress VIF" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:42 -0500
Message-ID: <20261107053942-failed-6.6-09280680f2ea@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 09280680f2ea060514be2a39ea84209fb6d721d4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053942-failed-6.6-09280680f2ea@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




