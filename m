Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D31A268
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726679; cv=none; b=nOEAwYzQTmyM0a7/oGoHDLDaWayFl1/r9aRK+XBMPSWuQRQ8jJWBPYKm9kbvFZqu7g15BHT4iVOLv1KE3TZRboi9bL71ktROUb8OiKWSNOb+eUNuR9bcAD499gjpm+C1qt/m2o6UeZ99lCDgeZrAMg1mAeQRA2plNpDcrx9mTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726679; c=relaxed/simple;
	bh=U7ODC03SLBfdmrRQEivJ8ZkdcSYBk1qJiZvFhCZwXJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQOyr3yiO39byRFxEhmXIyMQKZUQD1YURKX1PLUZQSPOVNU5KdWSVLg+AXKVYxFI4MoZbri7A59A02AQqIh7WlC6NWEIMDttoBl7MdVME957nPetbrEc9m5l8WMZ1e6C+mwb0B8c8NhxHI+dP3WzccrN9bbsY8oecw9BqsQxVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTTHdYT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTTHdYT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D8D1F000FF;
	Wed, 30 Sep 2026 00:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726677;
	bh=6h/xhcxon1D7dX7gFB5puvqgvnaqcU3EoxKTZBs97WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nTTHdYT6Ia8e0QNR61xy4N2/XK0rtvAM2t1yn400yLSYBWNrxp4NoAMP4ug4B+zid
	 fnoIC8Ukb2fP7iqY6WemGLK3b4ev2yV0TSIzfA8Bq5UD8VU2TBkgMH3r0IQUdZwl6R
	 jr90hYV3qt2v8Ypc8kO2N95WCFA9i6TjU1rMI2hx1WTJR2cvSdfsc6/t2YurJOUeyz
	 G1wPARqw3FclJdTZdSaNIPTBIUHatfY0P8SanqhvodMqIM5bq6VgNmKpjbomTHbLdw
	 4rHpqp5gMKnMONhy46tSg0RFm583TJqJuFBAA9vwY8iF14mFVVCyoQ3nug6Fv55jIo
	 8N01yUiXeutLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
Date: Tue, 29 Sep 2026 20:04:34 -0400
Message-ID: <20260930000435.2867626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092927-fencing-hypnotize-05db@gregkh>
References: <2026092927-fencing-hypnotize-05db@gregkh>
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
index bc42dd0e10e65..c39425e54d87d 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -185,6 +185,11 @@ static inline void nf_ct_put(struct nf_conn *ct)
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
index 757cce7a658e1..93c1b499ab4aa 100644
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

