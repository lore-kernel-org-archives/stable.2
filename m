Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818994A3F34
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002652; cv=none; b=nfAz96uwPEHMPDOL1sVdb+qKdMTHmFRHy+9IItyQhQCQL0rZa4hZUHf+dwMDpxywCVS+3CAnYoi1CdJT0D/SWfUaGmkDGfR5Y+3lDPzyNRK1YtNIxUJvQDQ6KTnCPDc6h0nTO3bIGaGtJItzJ8KaHmPRX0/i/DDBXSs1MBmSOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002652; c=relaxed/simple;
	bh=agbzHpR/PKZ0LLlY2lgVEH4d4x1op12XsKxqX/dfCv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/x8sdykRSf12Azuy15Kk4srCbmPiSQOsgEmcnruXct9a9HJpXL9AsRDTU98AWBtWxlv2JFe+z0342VjIZwSU8pYHR/VqKpnls54B3yFlWN46LQZW8R0mH3/FEq3xmHFB/96LeaHiJgb0ffXGkva/Et3y9MowAx1n2vU4GxrRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so16720175e9.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790002645; x=1790607445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0GaJZ+uFEU0tQWZqiav7JnKznavtITsSwryC+6XFRoE=;
        b=QUy3rhv/rPUE6wYPOIYHt4PAZAcVVXXoBUQty36Q/3Z+rhXLbcUCHk4igT9b/9O3Go
         yFQ9Kyq6I4ZqgJGItq5iAW9+yiyD4Bb8m1Vm92KPeXBKIsxq8zgnjKFJNh7+L7piAw/F
         IRnotuAydLz32XbxEWtfUUMTUjqLuHCjT3tbVkhvyI+l7kgklVosDUdWLux5bo/oHnN/
         l88k2ev0okXM/GOWcCV83iC0PlI2OtBwLU4foQJm0ihN+sqnNhMS4GQcwWsyDzfqyPD0
         aJdBoyBYJCZafopWPQFIzBAZJBic53aF0GH9Eya0+Q9hYD5xq7N0Fi1VnGM+p66Ik/FI
         2Wvw==
X-Forwarded-Encrypted: i=1; AKwUvBxwQjcGYzne+sk07jE0Tx004C8bHE1VJhohQmAD1Strz23rP1Xx2h8VfL5GLReBKG/gpG1trNU=@vger.kernel.org
X-Gm-Message-State: AFuF++m8OVI3o6MQe/ALuLvGaKbbQpzpm8qrxoDvuIoZ8xS/AWxZogbF
	G0VA0GQ7VcqUVJ2LBzch/6THTwJqpwICWlWotauzBW4OU5mFJJ/44UWj
X-Gm-Gg: AYBFou1QHn+UWnUYVCcu5Hk+NGT37yBbzYHkcPiSO30GsfQ6Qps0mwdhb2RrpLH7KlU
	1Rt18fSuDes8c/VAMmUNlMWRNlb5bI3c6fhawpy9Qs61iYj3JBEEhsbAYevnKDgUVmfiDov6jq0
	VURwwkjt3JsiWjIR0Rsw7I6De0ld0VKg+zNsE44mFZKlPPwX05yP414kMcCBetQODCe07F8gWUk
	ZGhFgK9ePfiqyYADTK3W7eYnWC1JBi42v99JG6559amiof5xYahZukduDeGfX5ft7JY5i7LciWq
	ruVgIccXK94eMsnwuLAGCWcDM5irBzPPzFBCtSqcmVDZ6ziGyqbvlCIszyTSOMsgcGVTZ8tzbKJ
	p4xh4K5QFfH/kzPYAgs9uFqJrfIskoasznDlms1LX8WrLmpKnU3bW0x1Zbzb/mK8UquHudmfzAd
	zJn6jAfI2Y1Kh8FnV5XTHQ8rJRle40u40Zv2QgR9axbkbo3X/kWvRYsGKXsxHjniTa/PIpJnESr
	Gr39o0twoYuquatDvwAZoHcgVz1DI5AJYaRh+rK+2csJTymH4OJtnHAomQ7B8s=
X-Received: by 2002:a05:600c:530e:b0:49c:cfbe:5a76 with SMTP id 5b1f17b1804b1-49fc568157amr140231615e9.2.1790002645153;
        Mon, 21 Sep 2026 07:57:25 -0700 (PDT)
Received: from im-t490s.redhat.corp (78-80-107-225.customers.tmcz.cz. [78.80.107.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eabfcsm243153905e9.3.2026.09.21.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:57:24 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH net 5/6] net/sched: act_ct: remove 'add_helper' dead code
Date: Mon, 21 Sep 2026 16:55:47 +0200
Message-ID: <20260921145655.3167436-6-i.maximets@ovn.org>
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

This variable can only become 'true' when the connection is not
confirmed, but it is only checked when it is confirmed.  So, it can be
treated as being always false and just removed.

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/sched/act_ct.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index e72143d36b119..f62051ec9d57d 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -986,7 +986,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	struct nf_hook_state state;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
-	bool add_helper = false;
 	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
@@ -1096,14 +1095,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		err = __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC);
 		if (err)
 			goto drop;
-		add_helper = true;
+
 		if (nat && !nfct_seqadj(ct)) {
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
2.55.0

