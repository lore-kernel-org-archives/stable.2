Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E355F443E54
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672211; cv=none; b=LdrITGNFgo+mj+NmTh41lkRzAB6mnBK/vXLpXzTqC3Tob9NkvIvRokcSoxVYrTDEeOTB+ekQdf8FT/wYBODu9QVD1+qKBjL3OYPvQ1cR1J2I8TMyxqg2kA3OXSOMcPODHTN56EUU3tm7giiDriypypAs5gw1FGx3ZChPM17aiVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672211; c=relaxed/simple;
	bh=hvY+dn6XLwhZQRoeH8w8PB1O6ia1683T+7uh0GOugQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tjsmm62C8uFLEvpYpjSC1W8vGNzXbBeZil3yKC8w+HN9CkB3MArTQ0gMdiDDaAfoHXgQpCyxbW+y1w24XoYhlIcuz1LxzpdTDCfz/5MyYti+QPweQxM7yE/U9g7jaY36SqprLsvlOrTws63CtGhlhRDwO6H72nacIkitxxPGXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzAx21yN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzAx21yN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784672208; x=1816208208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hvY+dn6XLwhZQRoeH8w8PB1O6ia1683T+7uh0GOugQ0=;
  b=NzAx21yNpESPP+1WuEABcsnYgiEqCvQWvnNGRJnx7ABzzt4hflnCaTbX
   0Jj6Mh/eD6Kw4xfSJexcSzpDt4JhS3WutX1oX8wjOB15kwQ88XDa1w0qS
   lYOzgi064qg2d9rG8n/XF6kxeXmkSvYuof8ZYXITSNZKc6xccmxAYyO76
   z3mgZZcVFDVMWHgZiXQcnir8XgcUqgqulmHeJaW2UmgjPOhncIzTnR6lH
   X6JEgPB9qlAdcbMQ3BOE+dhJujT+uItWKsyhdZowdbRYlailhtx99IbZE
   r2EX7vUd1qIa1bJZtRpA8wqR65Wu82eLYOeMqETb3WdBaKL9jMS/ZaGK6
   g==;
X-CSE-ConnectionGUID: kYz+V2J9R02s8r+dhop4uw==
X-CSE-MsgGUID: VWhph0H0RMqWv6/7tP/lsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85055481"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85055481"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 15:16:47 -0700
X-CSE-ConnectionGUID: 1jD0wd/SQHuAoOoZMgoMUQ==
X-CSE-MsgGUID: CK3dPk29T2iMGWRlqUjyVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261673351"
Received: from jf.intel.com (HELO jf.jf.intel.com) ([10.165.154.102])
  by orviesa004.jf.intel.com with ESMTP; 21 Jul 2026 15:16:47 -0700
From: Ehab Ababneh <ehab.ababneh@intel.com>
To: ehab.ababneh@gmail.com
Cc: EhabAbabnehehab.ababneh@gmail.com,
	stable@vger.kernel.org,
	EhabAbabneh
Subject: [PATCH] mm/vmscan: avoid false warning when aging races advance max_seq
Date: Tue, 21 Jul 2026 15:19:26 -0700
Message-ID: <20260721221928.1032688-1-ehab.ababneh@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: <Ehab Ababneh> <ehab.ababneh@gmail.com>

try_to_inc_max_seq() assumes that if an MM-list iteration finishes, the
following inc_max_seq() must succeed. That is not always true.

A concurrent aging pass can advance lrugen->max_seq after iterate_mm_list()
returns success but before the local inc_max_seq() call takes the lock. In
that case inc_max_seq() returns false because seq is stale, even though the
generation has already been advanced and the warning is spurious.

This can show up in kswapd as:

  WARNING: mm/vmscan.c:4076 at try_to_inc_max_seq+0x5d6/0x6c0

Treat an already advanced max_seq as success and keep returning false only
when the generation was not advanced at all.

Fixes: 61dd3f246b3a ("mm/mglru: add CONFIG_LRU_GEN_WALKS_MMU")
Cc: stable@vger.kernel.org
Signed-off-by: <Ehab Ababneh> <ehab.ababneh@gmail.com>
---
 mm/vmscan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0fc9373e8251..5f32f49ce115 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4073,7 +4073,9 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long seq,
 done:
 	if (success) {
 		success = inc_max_seq(lruvec, seq, swappiness);
-		WARN_ON_ONCE(!success);
+		if (!success)
+			/* A concurrent aging pass may have advanced max_seq first. */
+			success = seq < READ_ONCE(lrugen->max_seq);
 	}
 
 	return success;
-- 
2.49.0
