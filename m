Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A82222D0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729051; cv=none; b=irQosp3hpQqmTy+AiC+ZYHb5vMt2PrvJhSDlHu9A9aic36DnTl/luNugG7tkj+FzSinUcJRsSkpygqxY17I6bFibSQTn6oKrAqtkESPE0lOs5r8pAGDpNV7rtuFqsduiP0bJEexfFhXuCivqV8gI9snTRisTaMgnUBVJI+Xi118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729051; c=relaxed/simple;
	bh=a4Am9JnVu33bLzqGhH8w7ToyMYS3FfVOC0e0NJT8jCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9UUsrXQzDRrvTVtViF+kqDziyqfsOIa1vT7om5wVdp8ElaMaOieZLvBcqT7B5BknZVTZZCul7AH3AYBbypAPzxGQiTXXuKqBQFOEsE14nS62eHMYDcq2ZurWq8HActw2hxKvfrvS+93xv0R1V9LFijaVMfE/KLa5btTtrhcqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKEnCpwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKEnCpwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994E01F00898;
	Wed, 30 Sep 2026 00:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729050;
	bh=3KDTtug3pJpIUvzyPoeQFiOA2ykeEele4UFVH/mr7Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DKEnCpwTiLsmX3x8o1VKJvi0zqvZMCB9BqVIWGPBcfYuW24mcg65/Md1XVCDstyqp
	 Gyy4c6edrD9pDKhQtmjGjXkqraWumRwDZeUpVQGA7BZdrHUZs3D0RRHrvK6vmblxq0
	 GXFA7nxRFJo8gD8o7DaggZ0ZTk6ijESyeDzPejUhPXspPoqhCAz+LrYdnooAPV/zSn
	 1jp47iQqdz71YoDcl8ysqBLeDofZKcj8YYcPowcvWVzndYHNscPN41uN311pdMXmJR
	 /EOPOWDVOd1FPZwiEoQZhTJswOWPwuJD79p1RV/uWuY+a8Da1PMKqJSBFO8KkENd54
	 IwTSstwgp806w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
Date: Tue, 29 Sep 2026 20:44:07 -0400
Message-ID: <20260930004408.2953522-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092928-preacher-reconvene-df6d@gregkh>
References: <2026092928-preacher-reconvene-df6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 26b2bd70d22457556e2fa01cbf1192cb1a94d619 ]

In a case where skb with an unconfirmed ct entry gets cloned, we may
end up committing both but with different sets of extensions.

The series of events:

 1. The first clone wants to commit and runs the helpers wiring up
    the extension pointer into the expectation list.
 2. Then it looses the confirmation keeping the entry unconfirmed.
 3. Second clone now wants to commit labels and adds the new extension
    for that breaking the pointer in the expectation list causing
    UAF on the destruction path later.

While this is possible to trigger, there should be no practical
network pipeline where committing both clones without modifications
into the same zone is needed.  So, let's just reset the entry in case
for some reason we got an skb with a shared one during commit.  This
doesn't affect any known use cases, but avoids any potential problems
with sharing and modification of the unconfirmed ct entry.

The fixes tag points to the introduction of helpers, since that's the
main UAF trigger for the sharing.

Fixes: cae3a2627520 ("openvswitch: Allow attaching helpers to ct action")
Cc: stable@vger.kernel.org
Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260921145655.3167436-2-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: f85009dfcd65 ("net/sched: act_ct: avoid modifying shared unconfirmed ct entry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack.h |  5 +++++
 net/openvswitch/conntrack.c          | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index a2c987289401e..3b41312cb0b02 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -190,6 +190,11 @@ static inline void nf_ct_put(struct nf_conn *ct)
 		nf_ct_destroy(&ct->ct_general);
 }
 
+static inline bool nf_ct_shared(const struct nf_conn *ct)
+{
+	return refcount_read(&ct->ct_general.use) > 1;
+}
+
 /* load module; enable/disable conntrack in this namespace */
 int nf_ct_netns_get(struct net *net, u8 nfproto);
 void nf_ct_netns_put(struct net *net, u8 nfproto);
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 6ceec146e694f..ac8d19779d287 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -716,6 +716,18 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct;
 
+	/* If the ct entry is not confirmed and shared with some other skb,
+	 * e.g., a cloned one, we can't just modify it with the commit as we
+	 * must not modify the extension set.  Reset.
+	 */
+	if (cached && info->commit) {
+		ct = nf_ct_get(skb, &ctinfo);
+		if (ct && !nf_ct_is_confirmed(ct) && nf_ct_shared(ct)) {
+			nf_reset_ct(skb);
+			cached = false;
+		}
+	}
+
 	if (!cached) {
 		struct nf_hook_state state = {
 			.hook = NF_INET_PRE_ROUTING,
-- 
2.53.0

