Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A629E10B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728225; cv=none; b=uEDg+t7GrITuJbWjNkaAchMA122vU6T30ua5Ko8qj9AS5pQBIPsXEJlgCehfnCQPJLMIyXQ1H9T+rbKkvRwa9x9UUwZ1LnxFtigwVRgnpnYDs0IYnbmDl2ALoGBWeFsLhzmVtAAg0aU49way0puw6MQ3TmG2M31jz9MApoTu51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728225; c=relaxed/simple;
	bh=QJD3Ts9VuphREdQnMjfW7O8OIztnxyKKp7ueT/U7NSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2dY5BNYnFe/xDgJoL07XMjodgbH653hjy3uQBtyV8SHMXf2xYQ0SCtdDQVPDILctUVSil5rx5PyBnCzfBmFaSKxtsKHHy2dsXE5YxoCpaW7Hb5XCBU4rWV+Hyrgw+642lSRbXw7/KHVGPR9Slj3UaJvfh9Y5axF2sRn/s4M9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0W6JfF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0W6JfF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B251F00898;
	Wed, 30 Sep 2026 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728224;
	bh=BLkzddqPpFSY49IGsqlppuINRfhD9jeC/lJMltLWYkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0W6JfF/tWbNUHTYc4onzQy1Xm6bCB+Q5wvsRP0Dee/ORTcXjcAHqm+40xhPJxsXd
	 YXP9t+3ui6sAUwaJX+D0G2ljC/I4y9rg5yKYIpaKONYk1PgVX0PzXBBMwiTQH3WrmK
	 GsOfqqDscIvih2j66sCI8Y+e2W3E7H6QkxWCVqm85luNURUxnuZaZNssKI+m/axAbS
	 q2dyO2dWJZTIab6UUlvQzbsvJvFPa46xE+EJGKeBjEgg054vN8KeqmZQPee2x7MrmX
	 V4MeZ3VI3J5Bi19w6NL4R8rTk9F1c8r4Phyf8A6otGBa2zga6wOKoHPw3QFv8XtJ9d
	 z1rj02zGN3lGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] net/sched: act_ct: remove 'add_helper' dead code
Date: Tue, 29 Sep 2026 20:30:21 -0400
Message-ID: <20260930003021.2941963-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930003021.2941963-1-sashal@kernel.org>
References: <2026092956-canine-emblem-38a5@gregkh>
 <20260930003021.2941963-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 00df72e39f306e2f7adb68528a5c92109da6a0a9 ]

This variable can only become 'true' when the connection is not
confirmed, but it is only checked when it is confirmed.  So, it can be
treated as being always false and just removed.

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260921145655.3167436-6-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Retained `p->ct_action & TCA_CT_ACT_NAT` in place of the unavailable `nat` variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 8aed25cad9eef..e1e4f18d3c461 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -985,7 +985,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	bool cached, commit, clear;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
-	bool add_helper = false;
 	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
@@ -1081,14 +1080,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		err = __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC);
 		if (err)
 			goto drop;
-		add_helper = true;
+
 		if (p->ct_action & TCA_CT_ACT_NAT && !nfct_seqadj(ct)) {
 			if (!nfct_seqadj_ext_add(ct))
 				goto drop;
 		}
 	}
 
-	if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helper) : commit) {
+	if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
 		err = nf_ct_helper(skb, ct, ctinfo, family);
 		if (err != NF_ACCEPT)
 			goto nf_error;
-- 
2.53.0

