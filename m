Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933C947ACE3;
	Thu, 13 Aug 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624987; cv=none; b=VPj4MCc3aSzX+1+ZwjQXOc4sqQsr+WDPDbiBjhLXWCPNIbggeMEbHg/LdxVFjo1ogovS/zp51DjBtr57mGpd67cYJGydQtSvqnTwy5ZblYRmo2goPfpMVCILF0oOsphZm7/gsaNEm6PmddYuCAsG49jKaHUYwaxpq8fjgC+rr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624987; c=relaxed/simple;
	bh=Fjv0XXlK/v2sXYUVcKRr0/1FQ6LU5L1CN3DmJIk5v1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V2MBuS8wg2at3lJato51tFASyWOsojX7X2sNJuffScxz7MliGNIQ7ul9cw1pe++gKfwndcKeUMTYRE+9vOaKqdwaqVZa4+Ti0BalcWpvONMuMsYKJk8eEqL30mRzbo32pojUocEyZOKCnZf0ZshrwUG4GkfP9iC0VsN6s5aE5oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diMneu6w; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diMneu6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786624984; x=1818160984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fjv0XXlK/v2sXYUVcKRr0/1FQ6LU5L1CN3DmJIk5v1g=;
  b=diMneu6w3LoZUbmGIGssl94EHCTIAondWhLcPHNUlO4N14a/eze12/E3
   C/8tKFOqKvLmq4qGJxXiW7XOjHqgJ13ovNXy3tY8dSFCkmQuAWEBJyvvc
   TtympdOdIA2PWZ5Mg8Y05FfvGW6P0aQCvj9H2qhbGTGvEu4GFG/9h6fka
   PjZ7MccOUQ1SGgqvG+n01OmrVzapOa45s56moq+L3I7v6EdxwH5KhP7oz
   vzVo7Tc3tlxpDaGorOPguf9s84WwS1AmxMQlXC1yhdMTRe/Ue6jxAjNxC
   JpGGRRQ6m37Fk1cA2uSTOR/6K3mH/5VXxKSWLVUlQPDgICMg++pxi+eXK
   A==;
X-CSE-ConnectionGUID: JTuON4z6TI+rkmtg5oPqfw==
X-CSE-MsgGUID: /VBjdp+nRfK3Gw2OK98XlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="91071655"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="91071655"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 05:42:49 -0700
X-CSE-ConnectionGUID: WUM8e399SHmb/bH/RtYSHA==
X-CSE-MsgGUID: awNGtOheTq6jACrd/ctosg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="262177569"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa006.jf.intel.com with ESMTP; 13 Aug 2026 05:42:46 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	stable@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net v2 1/3] net/sched: cls_u32: feed u32_replace_hw_knode() with correct set of flags
Date: Thu, 13 Aug 2026 14:22:40 +0200
Message-Id: <20260813122242.1690024-2-jedrzej.jagielski@intel.com>
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

Cc: <stable@vger.kernel.org>
Fixes: 695176bfe5de ("net_sched: refactor TC action init API")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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

