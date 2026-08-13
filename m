Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0147ACD3;
	Thu, 13 Aug 2026 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624991; cv=none; b=bESlD5WIaepjDa3M/KOYFIAFR4e2+syD4WLjt/OwLsciBB7ayg7XWqWlubhOFY6cAi2jKaDfpPMRZCRQsW5v58Q8RVFWE7/D+3bqdixQa4oQOujAypMl9iugL4ddZi17LemF+/ZoifTa5gQVoyk+xkBdZnS30ZRHT/3Fvp1B2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624991; c=relaxed/simple;
	bh=goZrJCQdbqFoMFq+5ROL10hTGJorfYKSkDKVYuF3PQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fh5nhcntn7ZJX0tuaCLNjg/BcH2bsXOuuXWona8t+5nIcphjXj7NaJt1spnKb6+4GG8jOQsBCSdr6hK83efSg0GGRRMn2NMNNKeAkq7gJxddyag2NKLxavyWvWWfakFH3lYsfskdFmqq8IDf4ERiFAwjnCfeTzXU/N2M9zN3sTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q33qSe3y; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q33qSe3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786624983; x=1818160983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=goZrJCQdbqFoMFq+5ROL10hTGJorfYKSkDKVYuF3PQs=;
  b=Q33qSe3yWu28UgPjtmHAWbaG8gPU476yCApuMUCGEEUBqj8yxMfCuOD4
   D+QiPCJpoNsSpC507D1V+RXMT/+YN3wcbTNsqK5/1zEdgbvxi/W8Ma8Yl
   mbieFKSKT5+rP5M4IB7e2rfJI/ukMRw2s3vD/FotFA3vZAyLn6eK9+Vvy
   kCevQKB2IYPigzoC/PWHxUYB8u1xcgrgG2WjZys2mWX/H8HHCoL25jkxs
   viMOAy00APORTYh3Mu2A4zVrGPUhM3WU6bFScETFXnC+LLoLktWb4N21Y
   u9cvl62EX6ydbeYLkNppta+tWRffb4VDN/pET10JgH+d77R5Ov23bVops
   A==;
X-CSE-ConnectionGUID: GmQfeP4pSCqSxHK3GYPIVw==
X-CSE-MsgGUID: 2pD4Zj4xSNWFD0aDzP8/eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="91071665"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="91071665"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 05:42:51 -0700
X-CSE-ConnectionGUID: XSImbRHiTB64EZOUNn+oww==
X-CSE-MsgGUID: C9I4q/jbSGWD65ubRqPKaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="262177574"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa006.jf.intel.com with ESMTP; 13 Aug 2026 05:42:48 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v2 2/3] net/sched: cls_u32: fix linked hash table refcount leak
Date: Thu, 13 Aug 2026 14:22:41 +0200
Message-Id: <20260813122242.1690024-3-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260813122242.1690024-1-jedrzej.jagielski@intel.com>
References: <20260813122242.1690024-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a new filter is created with TCA_U32_LINK, u32_set_parms() resolves
the linked hash table and increments its reference count, storing it in
n->ht_down.

If u32_replace_hw_knode() subsequently fails, execution jumps to the
errunbind label which frees the node with kfree(n) but never drops the
reference on n->ht_down. This leaves the tc_u_hnode refcount permanently
elevated, preventing it from being freed when the hash table is later
deleted.

Drop the ht_down reference at errunbind before freeing the node.

Cc: <stable@vger.kernel.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260807100356.1083774-1-jedrzej.jagielski%40intel.com
Fixes: af69afc51a56 ("net/sched: cls_u32: Fix reference counter leak leading to overflow")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 net/sched/cls_u32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index dc6e455e64ec..9539dce217df 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -875,7 +875,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		      struct netlink_ext_ack *extack)
 {
 	struct tc_u_common *tp_c = tp->data;
-	struct tc_u_hnode *ht;
+	struct tc_u_hnode *ht, *ht_down;
 	struct tc_u_knode *n;
 	struct tc_u32_sel *s;
 	struct nlattr *opt = tca[TCA_OPTIONS];
@@ -1185,6 +1185,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 
 errunbind:
 	u32_unbind_filter(tp, n, tb);
+	ht_down = rtnl_dereference(n->ht_down);
+	if (ht_down && refcount_dec_and_test(&ht_down->refcnt))
+		kfree(ht_down);
 
 #ifdef CONFIG_CLS_U32_MARK
 	free_percpu(n->pcpu_success);
-- 
2.31.1

