Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03724EED8
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790726664; cv=none; b=Atp9lz/nM4CY5ZDC/qIyq71mI8slFgaQ9XinpvijUdqsnOWHQfyZ0h3DsKrFfuaTbdsUmVcRT7zwSD+eJDJbU4Zb0eIoiRH+/NOiOE3f2KrJgOxmtvEJo8aa/xX5KWv8+G57dGMUU0YLhqGuZVoitdqgGA47y6fXw7uxqX7UPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790726664; c=relaxed/simple;
	bh=6svuO8REy5VxBuy7wajeAR4B6e/s47v9DB542IcC2Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2LsHzXo6pRZ943QlNsMnjFnPBrTwFwQOOphYRCZFxy3bCR2jSQHm+HxDxjoWRujDOXCbFB7mwjTw+y1MT3/s+YKa5AOr5VYkZd+4qOPErLNOxZuqcKXYnhzlyiLUCUxLIBtwhiW7xb6Wypn4nC3n+T7k4GFvhpw45cJWCgFb/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSkop6hZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSkop6hZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3351F00898;
	Wed, 30 Sep 2026 00:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790726662;
	bh=PvLIoQ02U6gmDhs757CjRoB/enKftAfk7kQGAsR/CpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QSkop6hZAJLKATk8DYTPHHaWfFu8mCw/dANhJOw6DvnkiaCzZ1lAVBsHJLnmQAg8L
	 i4Ai6r/+LRollPu1IlkdX7EsdeAnvl8Nygnt6e/ejdlV10kt/tjrZOQHbZWk1uDohx
	 rgxk1RFqtm+5gWyumPzLth8zU1VmmWrRZ0Uqwx6L5QDsDhV8BIrvarzYuE1iXSe/H+
	 fduXafj0+2COSHyhT6tvdMW5VaZ5kbKk/zBFK7zJiMITKLLZ51Q/lCHzH/mZGORLoC
	 lJuttdK1OBgD6Ruio0k8we0OIZ7U8HtBBuUOv5keEcOy7JpMbWitZss7jeBGsUS8g4
	 wTh0XCRiwa/Sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] net/sched: act_ct: remove 'add_helper' dead code
Date: Tue, 29 Sep 2026 20:04:19 -0400
Message-ID: <20260930000419.2865290-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930000419.2865290-1-sashal@kernel.org>
References: <2026092903-headsman-ominous-0529@gregkh>
 <20260930000419.2865290-1-sashal@kernel.org>
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
index 370085ab6ea41..86d8e19682fe2 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -987,7 +987,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	bool cached, commit, clear;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
-	bool add_helper = false;
 	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
@@ -1083,14 +1082,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
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

