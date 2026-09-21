Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF749BD6E
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002648; cv=none; b=SxTOpUDJL6CThasrfjAYyWWyEnNWKAx/5tRllRjGBSvhWPXJ4rma4y48O5fwMOqXRjPCF6QkIWqwPR2Ia05tUdylCou1WK4pWR419It1MQvUb1tT3ckrnnn8kOuiNvkpvI2lrplDXtJfcZxyKF46DrCXYMqROEjCaTrEl2sg2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002648; c=relaxed/simple;
	bh=TzIqUe2bPr+rCrYGN26hULTVXKps5YUGqZ1r3naQPKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phcsOckqyNfRMVFi6ZE3nMP51XJOgC0IW+4BcDeftlzFp9wkng42cO9BN06ElYJzNf3gOj+EQi7BIQH4MzcDpn068u8Xs1qjsSfrKqHjK+mXjfT+gycvGLY3N/GBbiK/PJ7v2ulSKmIyPO/q1ItvidoHey1EtbZQJvXO5pdQ3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso14239995e9.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002640; x=1790607440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r/iG3o43oIJZJaCYcUSYeC2n62gq4cdWVmWrUdZeO8U=;
        b=0HwiVbGEchxO9clJuxS7X43QCdCuCXjiW0T3y6PUX9ZiTxNuAgecpTVm/q5xLrgUSc
         4ABxF41oJfNiGgxsDxNFoSr6HXQfatrUrfV3xofSUq5TkX5CsA8f2MOVIBkvl0XsdvFd
         uZPUVh4bCxOxAHNSLfP276ZmK78g6QAcx64TLzgew9bSPHzKp7n5eb105iQhcXMdCrzR
         T9NqsPObzf/bOTieNmt2dIL6MHvkunA+CafSO3L8gYIq9Ha8pWf+BQpRUoKCNyVTYrBR
         sq59S6xJunJvOLOh2mWfX5v5GaWrtcePsPbdmX6HDjV5yoen7XbiVJ0NAe+DOPuyhg5l
         yMKA==
X-Forwarded-Encrypted: i=1; AKwUvByaTMFHYF7Qc1eCTPkKAEpjyjxu2oIw/eji2eJTMyy98iseodC+t91yZ5gboZ5EvCeOMxLR970=@vger.kernel.org
X-Gm-Message-State: AFuF++kaz8V+8FGSeMk8TEJXrI9lJaoUFAYWN62neo1YkAKF6/p52P2H
	I0IOEskvXZqvJ+qv8PO3I0ydmDnrQ60JrV2EVoUhFBF/xITSNuU4NTqL
X-Gm-Gg: AYBFou1RJLkIKBqBEwbMqqYlbzM0SyZFJ12M/5/lSTqta53uqOy1j7lUQDFD44ng0n4
	HYEjx373h8VhKoQY175TybJn/e/1eZHqhOV/bVF8t2615nxy46f+upBwrd0BeelK0ZJ7sUKsLU1
	0F9luXgotxrTc01X7m1qeth0QnEQv7ZUBdJk/vIVHVvnR902H9tUgVUfm98Fddeob1Yjpyo1Cbh
	QTTBpNJ5F0IFR93a8vH31hNu+Hx/0HoOEJPBeI1ES6xY89lHRiFYFEQLvn7ANou+ZH1cFjslGoH
	fNKWVSC9L1uocuOTibohiSbNGYpzw0MLugP3jl00A0wYgzQ9woEugS9pPlr/wD8tQ7biiLHfgB/
	LpSoE+cbpvg8BBWXJks1bwASYa4fTZUbQkkK47LtXEpKxqq9MvwppnMpFItedULIy+DKpFKCMOg
	vvOhwZbIxXgznNWEnoRuFiQzHithmp5/S6eIRcpy4EXF/oezz3+5VfncdHsTHbI8WYbT4E0Nk5A
	h67vx9tIteQsEnQewa0Z4Dl47v5lyv97qlbIYuQCilSBwGOd3KnrkAXsZXCheE=
X-Received: by 2002:a05:600c:4e86:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-49fc56715d6mr143236515e9.4.1790002639706;
        Mon, 21 Sep 2026 07:57:19 -0700 (PDT)
Received: from im-t490s.redhat.corp (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm243153905e9.3.2026.09.21.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:19 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	stable@vger.kernel.org,
	Axel Mierczuk <axel.mierczuk@1password.com>
Subject: [PATCH net 3/6] net: openvswitch: conntrack: fix helper UAF due to extensions realloc
Date: Mon, 21 Sep 2026 16:55:45 +0200
Message-ID: <20260921145655.3167436-4-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921145655.3167436-1-i.maximets@ovn.org>
References: <20260921145655.3167436-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 net/openvswitch/conntrack.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index c20f096eef40e..d3326edcabf76 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -817,11 +817,14 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
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
@@ -1025,6 +1028,14 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
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
2.55.0

