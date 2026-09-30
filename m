Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5526FDAC
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727625; cv=none; b=BtuDimZ9nhIgCET7JCxOuNpOwn64/onUIb4nbXae8urhq102q5DuX08bxtlnwIR9eeIgBwKjkIB9xFqdz8HzlbNyn5zLgu6QmPkFV3UqU/rVXR3w6eCfTVx+i4MlI3PTdbzhGNRcfeybwjA7ZpidHP/Tv5yi6drRDtsq4z1jK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727625; c=relaxed/simple;
	bh=xYO5zq0vRXDZgQCbfTHMEJaeKe6TBuKgKstHt2h4KVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tp35rprQKwD9i8gXzbzT+rToI8TByJiajzbblig6PAtqfJaPY7iGxdVSnGMuuyPCQCcdOJU9NUp40+MkJhQVUZayLKjN6YouxngUl9QKu+EyVdV2WiNNZu0M3PcYlgJVK8qjTUSCgmo7TQZCZMLfajz0zNNdCya3w+2NuuG84mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNdI6yci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNdI6yci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25C81F00893;
	Wed, 30 Sep 2026 00:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727624;
	bh=p6Vz+EoUC+bXEyrwSeP+tNGCrmiL1iaMzRB4fhRUCwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GNdI6yciJ3SY4vsPkdfaeS3pN02uo2bD+FKc06fVqE6TGyw+YNb87qsNg8MoYaLL9
	 7VPDNGkDsqkGhC+0Qryn+hy5Zj1TTi/SoiEnIROEWCvnid9+UHPwDo9yEcCxemoAu3
	 EUccwAfbL6H9kX4Rct2lit8BM3ZCeY7cf93dFrHUhwvUMmC+hVtRvOnnpYEIk1MiHT
	 zolCqNhTQFxbphazeoPkFdoDK3gxfPdDcdHSFkjRlRpOAELsyqxw1dKzh1IBwWc+yd
	 r5jIiWP01Zm/gU210lX1+mOLbpTI87nqkgQowKNp/2k/fkh/t3sZppKtgOgmjHyp3O
	 VZv8CBhfX3UBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
Date: Tue, 29 Sep 2026 20:20:21 -0400
Message-ID: <20260930002022.2934083-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092923-during-buffalo-09b7@gregkh>
References: <2026092923-during-buffalo-09b7@gregkh>
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
Stable-dep-of: dad19b59da05 ("net/sched: act_ct: fix helper UAF due to extensions realloc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_conntrack.h |  5 +++++
 net/openvswitch/conntrack.c          | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index aa0a7c82199ec..7e26611eb3c4a 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -184,6 +184,11 @@ static inline void nf_ct_put(struct nf_conn *ct)
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
index 89ef350ca91c4..a3d839099fdb3 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -734,6 +734,18 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
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

