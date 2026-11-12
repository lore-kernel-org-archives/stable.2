Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507406;
	b=r7pcX0imsNGjKzPdUOLqDCh1XigxwcbWrKKXpPf/A3bwtENmeCSGrTIcjF+ocMKi97P8
	 1mZyL/Ujj0fSNhQoapDboTjchglZNYeUWlWLHPh7zGZNlHDgDR3lpzP/4c4AwDUYjGkbE
	 qSMeos9bOzcbdFK/LRum6xECfoUHbd8r4c+9tY4O4tFZSdD8ZTiAGJYQRP1hKm3vmofV5
	 NSNhbPdZO+u47TBESAFE6f8sgFu3CutBXPoEHysmFk1Unp6X8kgBjE8wi6Ymf5sYRMnlm
	 36yZUKO5YCNHl3OAKjqohyUtA8MggjipB3+v7RJcf/x5r5s+bj+Or5MqjgKF5dUduzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507406;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=465nfVNrw813+ejDqY78Lb3+81kDaOyF95SuUnM1CuY=;
	b=i2BlZyFdujEomYQnFyG5TNsbjpbI4ezqjcRCLjJFCBx5kUE5M/6/zmMjjK+P1EE5VD0k
	 P+jqCmMhL7NM4irCFyvCcBZjltD5OWsVjpwdlorgdfdY6iqOWWH5x581jn0T9jL4li3Fk
	 1Zids60/4tf7W8NUSO/Ghqx5KmLVWs8zinloeMOIkiFSegeH/WBU8cKSJtEdb/tUjo9Kf
	 h/juR445XHbloR+3Z9X87e7a5zZVfcLL6JHyP4T0ZwORCkmoJt7rELTQMAyn8aOIZIhuA
	 n704dQFv1UqAIhSzuS4aaDnQUnd3WxyCJb6dvxMuKyor09EGmhrOYAHQWibF1L6MvMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h8t++8C9;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F976606A335;
	Thu, 12 Nov 2026 18:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F976606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h8t++8C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794507405; x=1826043405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ExCVOXWBqNh8ItZc8mGTqBzr8+65DBcBvVI07KTVA9I=;
  b=h8t++8C9aRXMOBmgh8Q40ldyXLoFdhXCT3Ap/zpN3UpHeOOVD9HL2ano
   yg5bbmDI7z5PlrcvHy66pxgy/IKTfroZAVQ4VYqkjg+7FdIbxiN5/vXab
   PbxPrLh7+QdY5oIK899P26iMmMngyQwtUF7IL8SHv5Py1B3wjv2TpKU4H
   CejIBvi6rmSQDc1NH0BjVAqbuGW14Wa1G8e1Eq4WXU6uGeznwQmGSRbr1
   XTac7+mUJ1jO0+4Pb6cRdmHYeNS/PmX9nH7XbwN9GtRX6ZASXftLkyZLA
   moP1FgBtNxES0tnLtRZtyjFm6Yv9dFt2Z3jmurV2Kbz3r8dcT2FZTbIU/
   g==;
X-CSE-ConnectionGUID: 6BpYDnS2RO+39DltdJ7aZw==
X-CSE-MsgGUID: gZPEpD6xRBixD+6qm6cZJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3203239"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3203239"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 10:16:44 -0800
X-CSE-ConnectionGUID: 267w8J5cS/yuIg8+R1c0aw==
X-CSE-MsgGUID: Au2wK5YVTQWYYJlD7Oti4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8898614"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa009.jf.intel.com with ESMTP; 12 Nov 2026 10:16:43 -0800
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Jemmy Wong <jemmywong512@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] sched/cache: Fix decision matrix comment above can_migrate_llc()
Date: Thu, 12 Nov 2026 10:21:47 -0800
Message-Id: <7ec95468b17ab48e4f4fd443c9c6377680e3fd84.1794507151.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1794507151.git.tim.c.chen@linux.intel.com>
References: <cover.1794507151.git.tim.c.chen@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example tables in the comment did not match what the function
computes with the default thresholds. The imbalance test is a ratio,
so 50% is noticeably busier than 40% (25% above), and several cells
were wrong: 40%->60% toward the preferred LLC is forbidden, 50%->30%
out of the preferred LLC is allowed, and 60%->40% out is allowed.

Use 45% instead of 40% so the tables also illustrate the imb_pct
hysteresis, and recompute every cell from the code.

Fixes: 23b2b5ccc45ce ("sched/cache: Introduce helper functions to enforce LLC migration policy")
Cc: stable@vger.kernel.org # v7.2.y v7.3.y
Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfc982205b98..5770ae37d1dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10837,20 +10837,20 @@ static __maybe_unused bool get_llc_stats(int cpu, unsigned long *util,
  * 1. moving towards the preferred LLC, dst is the preferred
  *    LLC, src is not.
  *
- * src \ dst      30%  40%  50%  60%
- * 30%            Y    Y    Y    N
- * 40%            Y    Y    Y    Y
+ * src \ dst      30%  45%  50%  60%
+ * 30%            Y    Y    N    N
+ * 45%            Y    Y    Y    N
  * 50%            Y    Y    G    G
  * 60%            Y    Y    G    G
  *
  * 2. moving out of the preferred LLC, src is the preferred
  *    LLC, dst is not:
  *
- * src \ dst      30%  40%  50%  60%
+ * src \ dst      30%  45%  50%  60%
  * 30%            N    N    N    N
- * 40%            N    N    N    N
- * 50%            N    N    G    G
- * 60%            Y    N    G    G
+ * 45%            N    N    N    N
+ * 50%            Y    N    G    G
+ * 60%            Y    Y    G    G
  *
  * src :      src_util
  * dst :      dst_util
-- 
2.32.0

