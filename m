Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC5833F8A5
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 04:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787026070; cv=none; b=Q+aqUI+zraEWAP20ydV/n/N9CDFTZU/YbA81Wbq5uVn17foLik9OKM1OmKxYTU5csvfLXmRJcJfDgidRlYuaRk+3T4LIOeEsAQFeEaXpqHGMaNuXntBl0K9PCozRflzmgGAJ9qdF6x+MDy8LoiMq1/HdDD9riZZEfsd/XfLUC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787026070; c=relaxed/simple;
	bh=ie7UiFEuQgwL1qP/sNwBsUOvW06oVYujPhEeWTFwr1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gcN8sfcqEFAHqjEbW2Y2xeVBj2cg81MaupyAn78txk4FRUAjVfrUxJ6S810ih/2XoxZXYhkiBBBEaol5aeVdj+H9eigF0vygANZdHRpia4gB8hr76TWRgVWinU7ndBQyIrFlv/8hoXEBqXdeCXwWFJEJ5Rr44omxuYVlCHNLX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKZxEGeX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKZxEGeX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787026067; x=1818562067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ie7UiFEuQgwL1qP/sNwBsUOvW06oVYujPhEeWTFwr1c=;
  b=RKZxEGeXSUY1dQakYi8ICVFe1cTX11WzPVZZgxqr9ZVL/zcnJNoWMQYx
   xOvLhNaQCv1mv+dzj1gh9wbFKXRYAqNyEnuAFP6SZQcmSPdKmPih0deZh
   ao15ARJE3FAYxm6HqMIUH4K994N5n2XHPRFvCQwEZkCRT+qM8urF3dOBD
   E1AXAufX9tdTs8A1AfJQ1UdY8M5Wi6Tyu33G630rfUTAnmoRaPWt+IbIb
   HZ1NKzC1uDKrMctUoW6fOuPDwHHAc8w6EDQrs1qRreLqbBSpR20SBs4n7
   9dt5AlgoGC1Nmx148N4ecst1JxIwab4fU8YCoTV9eHea2f2yDPWSltcUO
   Q==;
X-CSE-ConnectionGUID: fdpijghTRFSib13b/2a2Zw==
X-CSE-MsgGUID: jx/gG4dsRJ2xfWxo9T5ugQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98870337"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98870337"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 21:07:46 -0700
X-CSE-ConnectionGUID: Edo7hWWbQuGrnc9IrH8w+Q==
X-CSE-MsgGUID: qXqPoZrTSKmzy8k8VnKN5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="262477149"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 21:07:45 -0700
From: Varun Gupta <varun.gupta@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: stable@vger.kernel.org,
	matthew.brost@intel.com
Subject: [PATCH] drm/xe/guc: Skip CLEANUP message when GuC is stopped
Date: Tue, 18 Aug 2026 09:37:33 +0530
Message-ID: <20260818040733.135964-1-varun.gupta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempting to enqueue a CLEANUP message while the GuC is stopped
(during a device reset or suspend) triggers a missing outer runtime
PM protection warning in xe_pm_runtime_get_noresume().

Since the GuC cannot service Command Transport (CT) requests while
stopped, skip the message and route directly to local teardown.

Fixes: d930c19fdff3 ("drm/xe: Build PM into GuC CT layer")
Cc: stable@vger.kernel.org
Signed-off-by: Varun Gupta <varun.gupta@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 9036f89dff7d..24f35b0179e1 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2180,12 +2180,14 @@ static bool guc_exec_queue_try_add_msg(struct xe_exec_queue *q,
 #define STATIC_MSG_CGP_SYNC	3
 static void guc_exec_queue_destroy(struct xe_exec_queue *q)
 {
+	struct xe_guc *guc = exec_queue_to_guc(q);
 	struct xe_sched_msg *msg = q->guc->static_msgs + STATIC_MSG_CLEANUP;
 
-	if (!(q->flags & EXEC_QUEUE_FLAG_PERMANENT) && !exec_queue_wedged(q))
+	if (!(q->flags & EXEC_QUEUE_FLAG_PERMANENT) && !exec_queue_wedged(q) &&
+	    !xe_guc_read_stopped(guc))
 		guc_exec_queue_add_msg(q, msg, CLEANUP);
 	else
-		__guc_exec_queue_destroy(exec_queue_to_guc(q), q);
+		__guc_exec_queue_destroy(guc, q);
 }
 
 static int guc_exec_queue_set_priority(struct xe_exec_queue *q,
-- 
2.43.0

