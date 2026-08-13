Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3547ACCE;
	Thu, 13 Aug 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624991; cv=none; b=tZ+RWRwG+Guvm03N+/CymWppuNXj+NDArYBszXoXV9IpZ5lKqVEwatqRDcbcPWkxrDru130qeXCtkmKowLOaw6yB597Zm89/m8npMrxDPwdNJZcIEMStSTtaF/bWbU4OyrolFGRQlgLT7DYWWkTe/uIgY242Dv+bakyZ6XKh2/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624991; c=relaxed/simple;
	bh=hVu5xy1a7SNFi6gpS3eXjCFQU2BsgjqhlxKAOm0PYsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b470NUWBDn6hj4u8zQKN+7Dv2hQgI7IpfisFg/i7ItQ+tbQ032eikfnx8XmCJID3oxer7d5XsnFNTDDvX954mCKI38LWN0rfOYhs1+adu/20GBI6x+XemY0A8aY9RD0kVqlqunWpcrXdeGZuSJGuteOS8+ghEX7QhTlGmAn2Uuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xu4/VhY8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xu4/VhY8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786624988; x=1818160988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hVu5xy1a7SNFi6gpS3eXjCFQU2BsgjqhlxKAOm0PYsU=;
  b=Xu4/VhY8BXcLCwtgZHWf2bT2WfzOKjEd5SkMFf1IB648L1PCNYziLn4z
   Ons47kLF5LfHs0910ZkdRqJ7EYM0cLs0+2QHIFyJCAfp60rl4p5KFu/Dd
   pP4iimf5cZPTVG8DUOuOnar5fjWfIRCHDJJ2EKXyLAz4GTYIC0C5nj554
   609p+i2BaIS0HDtT/iN1gamLb8qNrJngX4SNp+Yt8edVjVMUGpcoYumkw
   8jkHaUPt3lUEVvNv4g5DqFUbwcrPai6KcVQdsmfouyA3aqqHiCYZ/RAyo
   Pv2Q5xtPGwP4n23HTA+ushUknBSA6rw8cW3rNFxJ5pBEjoqPur6I/3Q0W
   A==;
X-CSE-ConnectionGUID: d12KydpPTyabPcmdGp7+oQ==
X-CSE-MsgGUID: Lu+Et7yvRQOe/02WSrdLdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="91071671"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="91071671"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 05:42:53 -0700
X-CSE-ConnectionGUID: xYoW8mN1Q/ugN7NNkxNf4w==
X-CSE-MsgGUID: s34NRCOeTii1yHSXPlnbJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="262177580"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa006.jf.intel.com with ESMTP; 13 Aug 2026 05:42:51 -0700
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
Subject: [PATCH net v2 3/3] net/sched: cls_u32: remove erroneous refcount_inc()
Date: Thu, 13 Aug 2026 14:22:42 +0200
Message-Id: <20260813122242.1690024-4-jedrzej.jagielski@intel.com>
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

Remove the redundant refcount_inc(&ht_old->refcnt) in the
u32_replace_hw_knode() error path during filter update.

Commit e8d3d78c19be ("net: sched: cls_u32: Undo refcount decrement in case update failed")
added this increment to "undo" a decrement performed by u32_set_parms()
on the original node's linked hash table but apparently this decrement
is already balanced by u32_init_knode(), which increments the same
refcount when cloning the original node:

These cancel out, leaving the original hash table's refcount unchanged.
The additional refcount_inc in the error path has no matching decrement,
leaving the tc_u_hnode refcount permanently elevated by 1.  This
prevents the hash table from ever being freed, leaking memory.

__u32_destroy_key(new) already correctly drops new->ht_down's refcount
(the new linked hash table set by u32_set_parms), so no manual refcount
fixup is needed.

Cc: <stable@vger.kernel.org>
Fixes: e8d3d78c19be ("net: sched: cls_u32: Undo refcount decrement in case update failed")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260807100356.1083774-1-jedrzej.jagielski%40intel.com
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 net/sched/cls_u32.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 9539dce217df..69470d49ee9b 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -938,14 +938,6 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		err = u32_replace_hw_knode(tp, new, userflags, extack);
 		if (err) {
 			u32_unbind_filter(tp, new, tb);
-
-			if (tb[TCA_U32_LINK]) {
-				struct tc_u_hnode *ht_old;
-
-				ht_old = rtnl_dereference(n->ht_down);
-				if (ht_old)
-					refcount_inc(&ht_old->refcnt);
-			}
 			__u32_destroy_key(new);
 			return err;
 		}
-- 
2.31.1

