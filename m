Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343A4052D5
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766881; cv=none; b=uwFNXFXNekbkjssIF/6eHIpuoIroIQWLangPG4Qf1EvbJouaEkuhQKSXbx2897EC8jO5jgJg55suUGmdrZADFYXPDcOs7QjjJBCfAQHc6uwNRyvu+YWC9vs0CjSNfGVHpXDKZNZIqNBPaRljjLRe4TY8anwHByeDnfVSWGGaOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766881; c=relaxed/simple;
	bh=7ht0I4hdBAYiOgh6th/1hvqPSdY6MvDX29Cgpxu9XJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BozElHphHKp4CWbtBVJiHNKve82UZyHjoF6z0fy9N2l4vziUF8F3zAcx9341DvfzUl3PrKGkdMBWTO0BF4zhfdj0Bn16jtY1o4Smv59yWmcTsT1elONK7PNJkDboGm3QPa+PpbS7EDQ+bCDdhyZ5h6vNhHMJMXQGmAXmrDHUHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww4HeO+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww4HeO+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9694B1F00893;
	Wed, 30 Sep 2026 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766879;
	bh=DP5lgAyGkjSI7OLc6HS88A175OA7jbwZPxzW8K6rXCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ww4HeO+oMyVfsuk3qgR6gdMPQkoMu4W569VtVyyYhtM+awgSXueyf4evvPlq2W36E
	 GSylWBdnroZ5AdOsWCMgpFER3vFGblA7Qo02rTRt78dBtP8B8Kf9by4BPoFkPrdjD0
	 ATBoiCe95IJK/gS5zZaAHxOLPV8DHtAHXeGdu6FfRtc3EPdStT8QbxjVHC/Mm++h4X
	 +sktPFu3w1kIXM3vTAun4ky2xj+FcXdEV86wq1r2lu90nng6EXuPA+T6mC1soiiJ/r
	 2n6gc2GwabhBBDhhNrAqf0v40w6GYkWQ3MWVk04lpD4ogItxQ+IyDlnp3j3jCcp7HL
	 3fc0QPRIGBUiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] net: openvswitch: conntrack: fix helper UAF due to extensions realloc
Date: Wed, 30 Sep 2026 07:14:36 -0400
Message-ID: <20260930111436.1209293-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930111436.1209293-1-sashal@kernel.org>
References: <2026092936-lizard-mockup-ae46@gregkh>
 <20260930111436.1209293-1-sashal@kernel.org>
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
index dc5cdbf2d125f..604d3fb03dc42 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1051,11 +1051,14 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
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
@@ -1278,6 +1281,14 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
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

