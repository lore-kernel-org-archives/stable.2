Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA203F6613;
	Fri,  7 Aug 2026 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098237; cv=none; b=D7m3MHWFlp93hgxw9Q//CycUG2FgPfEtoVx6o0VvQLP1yd2lPO1PWfWH5LZwPCQnu0p6SbgMt4iOBjMAvm5b511SgJwyC3EFcZVNikRSUUwsK/U2SWQ2/Kgz6t1N03qZ8E7SRXh3stQfdYnrWzIT6bMp73VgYPWIlUlXccbnFy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098237; c=relaxed/simple;
	bh=KUpgVbn5nB2+AyKuxa3JNzzXGLajWAIhacWJDPIenwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=grpEsK+VDpS5LRGDI/NHTQY37+EOzZ8Ye0xyNWi+XjdNOe9+WQs/bxF7vDR89oX1hjBUMX9X7MHbIgnNmknnIqAUJin4W1x3eMncgLFbRxSSNGhEoWl6DjbUBc+BZG1SLDmKQIiYxk8XoBRmniZIQUcZbTTzqeNg/RJhRn7uNxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sz1q2J3K; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sz1q2J3K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786098235; x=1817634235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KUpgVbn5nB2+AyKuxa3JNzzXGLajWAIhacWJDPIenwM=;
  b=Sz1q2J3KRK8uVWLaCBSW24QfK3+ztsLXxEuftuja2M5RUFgPGvsLk2dJ
   hJVa15JZ6EiS3VGtCPIAfgt6+e8rcwKDA1qaW/kpiOdZXV6TjlIkuEWWs
   +IMDwGXleNN+gzb6cfYxLf7WuZ66hD66d8Z68mqNBcBGcNVN7IHgVZTIz
   sCdHZTYjqlNn7wnpxZPTcR0SPFYtxKOZZoqhvUL3P+hg2NJbl8UgbTKpp
   2whK7K/lZc6s3uHDp4SOeWphe4AqDNu7Tq7e6+eRQPmPc/wQi8lskoAfD
   eeo9yub5RTdmPMfyj7aQBxNJPIYFkmZmB8dxDNGJ4NZoYGIBLzpoRh4iU
   g==;
X-CSE-ConnectionGUID: wR3XonIrScWftd6ydKVC0Q==
X-CSE-MsgGUID: gWuC3fc7QRSDnb4HWWTcig==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90381233"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="90381233"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 03:23:53 -0700
X-CSE-ConnectionGUID: baiEERPRRHm0GOb6ZwJ49g==
X-CSE-MsgGUID: WG5fssa3SCGkU8OuGXMnSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="265835216"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa003.jf.intel.com with ESMTP; 07 Aug 2026 03:23:51 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	stable@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH net v1] net/sched: cls_u32: feed u32_replace_hw_knode() with correct set of flags
Date: Fri,  7 Aug 2026 12:03:56 +0200
Message-Id: <20260807100356.1083774-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix u32_change() to pass proper variable to u32_replace_hw_knode().

When trying to offload u32 cmd by adding skip_sw attributes it gets
ignored and it cannot be correctly processed by HW and tc_cls_u32_offload
struct which is then passed to driver lacks skip_sw var enabled.

u32_replace_hw_knode is fed with the TCA_ACT_* flags (bits 16+)
instead of TCA_CLS_* flags (bits 0-4) which actually stores the flags
parsed by tc, so tc_skip_sw() always returns false. This leads to
ignoring some of the attibutes which are meant to be configured on filter
setup.

None of the TCA_ACT_FLAGS_* is actually used within
u32_replace_hw_knode(), so there is no point in passing them.

Looks like commit 695176bfe5de ("net_sched: refactor TC action init API")
shadowed the local flags variable which used to be set with
nla_get_u32(tb[TCA_U32_FLAGS]) with the flags as the new function param
while not replacing for none of the u32_replace_hw_knode() calls.

Fixes: 695176bfe5de ("net_sched: refactor TC action init API")
Cc: <stable@vger.kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 net/sched/cls_u32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 8f30cc82181d..dc6e455e64ec 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -935,7 +935,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 
 		u32_bind_filter(tp, new, base, tb);
 
-		err = u32_replace_hw_knode(tp, new, flags, extack);
+		err = u32_replace_hw_knode(tp, new, userflags, extack);
 		if (err) {
 			u32_unbind_filter(tp, new, tb);
 
@@ -1161,7 +1161,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		struct tc_u_knode __rcu **ins;
 		struct tc_u_knode *pins;
 
-		err = u32_replace_hw_knode(tp, n, flags, extack);
+		err = u32_replace_hw_knode(tp, n, userflags, extack);
 		if (err)
 			goto errunbind;
 
-- 
2.31.1

