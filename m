Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF194A689F
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002654; cv=none; b=ZQ4VxC/I3+dp2J0zhymjIJRjTfFMSWA2+zqtEf7tY8Hucy9mi+N8PWqS2c9DEjH/vaqOMY4QHYBzFJU92AxnjZzCz+cnkB0qQ9UijwiIgFFjfi28vPrKMobwOjCqXBw63RjbSidTyNRbq4qojCHANPFMYX/8pV6PykN+YLLO4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002654; c=relaxed/simple;
	bh=O84UlgIt22qVXOTeLEKlJ+J21Nne9exAai0M6IVznd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZbvopg3qi11QdxH41Phd9Xwwai+eVIPSoTaKeu9qkHupHqovQHDakZ/ihoyxPwlA43ZkphbLPPuu5QWvSbkM3m0oEaLIyzfpv9MePzLkquSFGwUFNfGvHp7EuQHASelC4D5X4Mg2QQXDHflUOk7dBuRBcc34ojxolSN7QfA6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so13081615e9.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002648; x=1790607448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D5yxLi0HeeDyCNaoa/cXH7lPCvNUM8Mh94Wvp96R2LI=;
        b=ZoX+bAC2BIkvENiEfKB3ud5Qqru5LA9/qCD7sTrVEI4xa5+jah8PItxsAN4yHL/D9S
         HZRH42MeY5pQcPHvlsPjuYP1APw1bGDaPkLziV7G0pBUCfSdOkesTMHiR75GYPZnH4fP
         LXsfCB0g8KzCxDcXCesHKs3c9AE4Nqqf76yhSmYV66OZF693NPLDS2tim+lIAu027n0V
         HCbRs6q4HqU3RwDhb5JjcvhgnVAI8mK2/HS1Ow/LNSctj4BLWtDEGTRO0fULWwU1edCM
         1BXkxwjhQhMEA2T+hOyiNIyfFsqCgFlSnogV6T6btzmDuRqodlyVxvFD4PSTB1ASTY3S
         vtiQ==
X-Forwarded-Encrypted: i=1; AKwUvByJSqLywCfqE9Uo/uUBUnR0mn0kuYnakXNynQzX0nXkvNM/aCCuYMuWcvYejyG0nwJZpe89I6g=@vger.kernel.org
X-Gm-Message-State: AFuF++nqjgf+kmjuvt8pylGqNuXwFTid8K62RVeenJLOve/B9zTU4BAi
	gERblcBCwZtft6k24rA2xB4TUCdZv54mieewqmbmy+uw8yH6eaXtN8Cc
X-Gm-Gg: AYBFou1f4A/M0XbzSyPzqw2EnhK4M7LgjFOrzxvObepEWL+N+oPVuzazfWinvEjDGrm
	5nBk/C+pL1188+E86FJKxzzl4SJ/zGOr553/NNMhu9tUxI4Cqtcqy0yyxhoZz5VczLqLi/OPpQH
	QZGOtgTrYa+y0vA7YM58vaRGvlddvho59ntOZIU47GNLOxOY3B9u3gUHW3H1ZAeYK18dkmBLPwN
	uWhV0U3RkxsKmXN67M9/WqXbyWusDIhbk8Ao+wIi/JNOo0o/0ZIFfDjefQrCpaT0C6/t70uonVy
	4hoaCCaDH+XKWhVLOumNBHvdVnAlqjNnLGQmXNavFrxFMJj+ff7En1aSrnuqU/MxGZO0+EeN8+P
	5ZdpjWtyjKQPY9UPZeAOksm0PFNud1FHd9j8HSAXT4q/PmJCDkvj5wPfoztgZDs90AR/yNSsjaJ
	UaaYZW0S5tkb9CQMW4O0Nyl3O6MkAuwrQuOynBnqRoSUL50wFu3+WqV3eQJOF2wazb1608XoQgq
	IwcTLNvNBvxz9Jv2X83YG7s/OCBGEydfE8RMVObMideW7PxoX/LHTA=
X-Received: by 2002:a05:600c:34c3:b0:49c:fa21:e74a with SMTP id 5b1f17b1804b1-49fc5757f73mr156995365e9.32.1790002647731;
        Mon, 21 Sep 2026 07:57:27 -0700 (PDT)
Received: from im-t490s.redhat.corp (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm243153905e9.3.2026.09.21.07.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:27 -0700 (PDT)
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
Subject: [PATCH net 6/6] net/sched: act_ct: fix helper UAF due to extensions realloc
Date: Mon, 21 Sep 2026 16:55:48 +0200
Message-ID: <20260921145655.3167436-7-i.maximets@ovn.org>
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

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Cc: stable@vger.kernel.org
Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/sched/act_ct.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index f62051ec9d57d..411e3dd92d072 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1102,19 +1102,25 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		}
 	}
 
-	if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
-		err = nf_ct_helper(skb, ct, ctinfo, family);
-		if (err != NF_ACCEPT)
-			goto nf_error;
-	}
-
 	if (commit) {
 		tcf_ct_act_set_mark(ct, p->mark, p->mark_mask);
 		tcf_ct_act_set_labels(ct, p->labels, p->labels_mask);
 
 		if (!nf_ct_is_confirmed(ct))
 			nf_conn_act_ct_ext_add(skb, ct, ctinfo);
+	}
 
+	/* Run helpers for the connection if nf_conntrack_in() was executed
+	 * or if we're about to commit.  This has to be done after all the
+	 * extensions are already added.
+	 */
+	if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
+		err = nf_ct_helper(skb, ct, ctinfo, family);
+		if (err != NF_ACCEPT)
+			goto nf_error;
+	}
+
+	if (commit) {
 		/* This will take care of sending queued events
 		 * even if the connection is already confirmed.
 		 */
-- 
2.55.0

