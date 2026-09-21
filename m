Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76813C1D64
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002640; cv=none; b=scPbVgA7j61J3EOYfzAStSu4jQYmJl5V4chyWRlO3jPQN9tMf5F+2gwKFXyo/JqiNU6WPMZor88SOJA9iQt1MyfSOL4MiLXrcpWvEqFxK3Vxf3o86oLo+83cZJDPZeoHVrA8fZqzmHcP8m9qjvcUh4WWl0TTxw1mPofR20z3m0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002640; c=relaxed/simple;
	bh=GewYnmEL4DmNXoNcMZj/SIhw9+Nkv+8Qj+/vw7RBrBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsbMTDHLog48VnQQyuokbrznJtlxtWSUNQ8IzViJpRcTvt7DTX1/ageXFvYLZu+YHwI3tBMWfogFAEpMlp3m+9/rpQhwWVtzsRdPwrQYO5mpIWgmmZa7xmFJiU0+UnHtcNWxfK7+5ps6wO93nCP6VGPQ5BKw93Kh2cWPFelXf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6e43b9d8so11352045e9.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002634; x=1790607434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQTMqBWHnIAoQBjOra2YMizNpxK4ySQgVrZe7YnTaiY=;
        b=rLQWCOxQIfIy2gLuAqJ/wQUsKXqzq9hhe6CtiGRNOOIqnBOz34g1BhrQGG3HG1l+Pg
         CJG8H7pWSkrSfojNcTtGPpxPSuD3uWFWIfDCI3NsIXRZz6k8kjt7UqTNrQqLrcsle23q
         frkTQQJUAf7p708oNnVQ0OJTcweucB3uT6ntpFpLdajWqSsRr8fGBcLGseRSpppGEUZv
         GAIQ+bKvhZYQC5Ui2ot+GkYmHezf6d1YrVGKzzQc+Gyw5NpbMKaDjXlxenL3bKOWMcd9
         07OIA20HLCy0NoPKOu3At2BYH5RlOl4zxzlQYiBmwJ0wVFUIfNuLk0NtHnZHpyoRxijk
         pZrQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+XL6Rkg+nBUWuWxk1sdXt4tapyihWdDiWU/UnCG/2PWy8hpEi7jcpcZ4RJe4CDtcM17qF6ow=@vger.kernel.org
X-Gm-Message-State: AFuF++kXnEoj5KbfRPjB5kkw+zzaNKHKQZmDdy1iTAio7JuaMaBlkVRh
	CxGuU9Mh2YPgBmZirlpNeMY/gr2a6RxA+EUZUA46S1GxFS/zg9cGx/f2
X-Gm-Gg: AYBFou1yI+MSG6VU5cfUfowpw9y9JsnmlJR5m27l/NNiizEThD+joRdJgpXf7xOpQB5
	xxY+X3VXNzuiMZwEJrdmYcEmziF/k42EJwaKQhxO7S692HzrJNXWhnDfGKMEmrngqYtsIAyyij3
	ZvYdSVRz2jxfZZZp796s9rtcSGen86vdLzGaUbZ12aej82L1a+K4eCk2KpqAT9cHM2hHJyebwsL
	w6mgkQ7K2emxNMj/IfbHdTq5rTUTS4Hw4tNDjCEwall3P26bgTACQkDKGgHfzLt7yAHndR8rXL2
	VCLIpN5TXl7MESBZe0QL4IM75dl62OkrxMPSw8lLIRqwWq+s3qVKcfqmsXjOyc1nR7ET2t9vgj6
	rzUakgLwimTq3snBdd/VDW08jEJxNi7Lz/MvRyHV4kOGs0jEXtCfpXz71ygwsEV7MlS8mmB7hJS
	PekpdwymFrFKW8rw6xwyV58QZiYMVSKZeBwv1DIM2zMqp+hdJ5p5sEppTcaNAwQRChtFYd+YpPo
	Ay79XsNNuXmtylXXvr5vC2cx1PdidROwrzxDG/LqosyZYqgZYLs
X-Received: by 2002:a05:600c:4e86:b0:49c:d52e:d0ea with SMTP id 5b1f17b1804b1-49fc566e6efmr144949645e9.4.1790002634076;
        Mon, 21 Sep 2026 07:57:14 -0700 (PDT)
Received: from im-t490s.redhat.corp (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm243153905e9.3.2026.09.21.07.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:13 -0700 (PDT)
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
Subject: [PATCH net 1/6] net: openvswitch: conntrack: avoid modifying shared unconfirmed ct entry
Date: Mon, 21 Sep 2026 16:55:43 +0200
Message-ID: <20260921145655.3167436-2-i.maximets@ovn.org>
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
index 0f433688e17b9..a733029c28dd0 100644
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
2.55.0

