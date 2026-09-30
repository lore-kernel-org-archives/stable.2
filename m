Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B23112DA
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732143; cv=none; b=caBETerVa9cUETiF91p1Sm4v6MfH0CScvrr9HNvlXMlb/nppDgQ1NAfbM20ade2sfd+NH3FAXu/V5Ms+PY9mWYtUrzIeI/y8cd+qntrJqzaNeJbU2KxI3VAH2pReiHZ5kELhwY/dwqpsRWPO5XCgBfOthi56/DxjOdsCvQhpHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732143; c=relaxed/simple;
	bh=iUAxtPS74fIHqLLOvrGowfEKkubZ0Hy5GW7MqeQm24I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUJM4VZt6RGq/xs0ZjCRax/zx1Ml0owCVlscqY6aT/lKsYFPMC9++Mm+0Wz7BGjUoaQ5PITKE3BtYK7x42crs9FqyloR8rVc/SN8VcGg7NZwdrWsoxAhSeL3KO4EOC9Gw2fpmRAVkZKi02Cw3MWlHxrbIm2+9j5AJvrecoSFiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9Yivltg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9Yivltg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAB41F00898;
	Wed, 30 Sep 2026 01:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790732142;
	bh=RkA2fdH0LCZxKWhI44cKhuzkQ7y4SIL7PwerjvKEhtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C9YivltgeaD1JJfoW4VkXsHY7xPWNlZWTQbAd6YpbtIiDNZ52oYRlE+Fg4oHenCly
	 tib8spEm86LUX2SSGqctUdfRPi93AH8IMGCflCllRN17SqAhyv8HdfkokhwH1wK4YU
	 SRuE0HIyrDL6XusOo6yD9B0LizKc5ZL6B8OZxS3iz/DMf/U6XxEFCZNWE5kBDCIxZY
	 VQqfe3o1Yq/z4xnPz4Oo4c5TR5MnwtY0zIcTMQlxMlwmprstmk649klVzCZm9A3aEm
	 ZWgm5siyomTHBeBW44wbWTbCx3d180wGdyvMjwv3p1tkdNSWCwqwC/kWwf8uHuw5Rf
	 3ioFqWQmcoziQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] net: openvswitch: conntrack: fix helper UAF due to extensions realloc
Date: Tue, 29 Sep 2026 21:35:38 -0400
Message-ID: <20260930013538.3274673-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930013538.3274673-1-sashal@kernel.org>
References: <2026092936-emporium-roman-a509@gregkh>
 <20260930013538.3274673-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 1a4151e6be57b098b7a5ebfbde58585e83200cdc ]

While calling the helpers, a raw pointer to the extensions area is
wired into expectations list:

  -> nf_ct_helper()
   -> helper->help()
    -> nf_ct_expect_related_report()
     -> nf_ct_expect_insert()
      -> hlist_add_head_rcu(&exp->lnode, &master_help->expectations)

In case the connection is not confirmed yet, more extensions can be
added afterwards with *_ext_add() calls reallocating the extension
space and leaving the now invalid pointer in the expectations list
that is later accessed while removing the expectation.

Make sure that helpers are called at the end after all the other
extensions are already added.

Note that the helper rejection now leaves the mark and labels set,
but that's not different from how the NAT was handled before or how
the mark and the labels were handled on confirmation failure.  And
there are no atomicity guarantees provided by the API anyway.

Fixes: cae3a2627520 ("openvswitch: Allow attaching helpers to ct action")
Cc: stable@vger.kernel.org
Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260921145655.3167436-4-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/conntrack.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 00c499540ff38..f3238f715989b 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -806,11 +806,14 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 			}
 		}
 
-		/* Call the helper only if:
-		 * - nf_conntrack_in() was executed above ("!cached"), or
-		 * - When committing an unconfirmed connection.
+		/* Call the helper only if nf_conntrack_in() was executed
+		 * above ("!cached").
+		 *
+		 * For unconfirmed connections it will be called later during
+		 * commit as we need to have all the other extensions allocated
+		 * before the call.
 		 */
-		if ((nf_ct_is_confirmed(ct) ? !cached : info->commit)) {
+		if (nf_ct_is_confirmed(ct) && !cached) {
 			int err = nf_ct_helper(skb, ct, ctinfo, info->family);
 
 			err = verdict_to_errno(err);
@@ -1013,6 +1016,14 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 			return err;
 
 		nf_conn_act_ct_ext_add(skb, ct, ctinfo);
+
+		/* Call the helpers now.  We couldn't do this before as
+		 * all the extensions must be allocated before the call.
+		 */
+		err = nf_ct_helper(skb, ct, ctinfo, info->family);
+		err = verdict_to_errno(err);
+		if (err)
+			return err;
 	} else if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
 		   labels_nonzero(&info->labels.mask)) {
 		err = ovs_ct_set_labels(ct, key, &info->labels.value,
-- 
2.53.0

