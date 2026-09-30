Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785A36C9D9
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735678; cv=none; b=NlJ2pj/JBJvmwj3mEasSlBMPgu3k8FWeoLpJEAYkPYq0ynoJKvONFQBq30fwN8ztmdbL8N33CXfasCFBzv1hQf8p0abvqRYntCLR4WZz/bLCn2yJvPN5BVFCHeLDAM5uHOcdC812H4nzfpfTq34qnwTMzEsnS/O9VBbVYjETAnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735678; c=relaxed/simple;
	bh=39+GHqYQUkgpWMHTA3Yg9DFuHfJ+4xDXgKz3hyBr5Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LG6B5KBOAcriNDvOoxo8fawkfeYg3/DII6iU5Pp1s6a5npRaWo/L9VAW57zoFz6lIpGjp+WayVn2jdyFB1xSYuZe4nWcDfMTbuSvxFSo/b1wehS9jMMS3Sw8FWlGBpJy2FAICd05KGRbKbDfahx610U3+xAGIYJ8FuUZT1MRUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj6EDE46; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj6EDE46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F651F0089A;
	Wed, 30 Sep 2026 02:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735648;
	bh=/SfZscoWnHP1Zq64kWYQmOuU6X9sRFqkAUS1Kl6Lw9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cj6EDE46xRrJak7vdMB7bqCePMg7DxqWwj+bziaLDR/FTNT509wVd+bILPb3CJKXu
	 Jq6eSmAjAkW+/MxGSQOEdMz4HzGxSU4bxy1q2eLBg1wfZd91bqAD4HjN9srrk8LIkf
	 YukLtss9hsCgQyjLWC5pV6wh3P63AV/ETbYpxBKs3mVLBZiczsBw6/r9wfVmZb31LY
	 ekdmFaaHQEWIQGVYqO6sGVeHWStJFaok5+igmQ8WEnf7XinQtx70g+1gNYAwlovQIf
	 3syATXg8dgNYS3U2xWm/MC08+M63sCPJoheFep/9ER3N+L/vaQDECg1+bI8ZUxu3ol
	 GzohQgTfAc5Iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
Date: Tue, 29 Sep 2026 22:34:05 -0400
Message-ID: <20260930023406.3421456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092940-dropout-pebbly-3736@gregkh>
References: <2026092940-dropout-pebbly-3736@gregkh>
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
Stable-dep-of: 00df72e39f30 ("net/sched: act_ct: remove 'add_helper' dead code")
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

