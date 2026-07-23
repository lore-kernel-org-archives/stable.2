Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E842AF93
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816369; cv=none; b=sbrRR8hhLXlxHarSWBF7Eop6K9aHb/poKvXxnEzTGQiJcT34o8bKtteAIJ72lQsgtAd9MnyJGHNfWEa9VfybzEOv2RQ4XQznAD/4fSeRKqmTXT2dPJv4rTCmzTFhnXIM+BjfRMJ323SpbQRwbGWuodkCU19i8syuurFmfFCmy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816369; c=relaxed/simple;
	bh=G25JaZSeJ4gwj7e5EM6pclqrgrBmSxXkqzK7catsc9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtL20MJUcu6P31aKCZ0cVt5wF8YTxXgEw9rTGKYbWVwI7ezMjT7XlHGeuZ1c3t/jz4dERYam2NS/8LROIoCCwanX/7UqFPOwiFwEXH5UXDCOHEgQnjQBjiWgCWJSlkP3vVGfIshWswf9TMfOPY8lCmxO7157JKJWx5hVZosFNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC5E1F00ADB;
	Thu, 23 Jul 2026 14:19:23 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] s390/perf_cpum_cf: Add missing array_index_nospec() to __hw_perf_event_init()
Date: Thu, 23 Jul 2026 10:19:04 -0400
Message-ID: <20260723141904.3218096-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723141904.3218096-1-sashal@kernel.org>
References: <2026072026-chess-imitate-9c14@gregkh>
 <20260723141904.3218096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sumanth Korikkar <sumanthk@linux.ibm.com>

[ Upstream commit 49145bce539117db4b6e9e83c0e5ef528e361050 ]

ev variable is userspace controlled via event->attr.config and used
as an array index after bounds checking, but without speculation
barriers.

Add the missing array_index_nospec() call to prevent speculative
execution.

Cc: stable@vger.kernel.org
Fixes: 212188a596d1 ("[S390] perf: add support for s390x CPU counters")
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_cf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 3e5e88536aa27a..4a2cd39ed38e7f 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/miscdevice.h>
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 
 #include <asm/cpu_mf.h>
 #include <asm/hwctrset.h>
@@ -633,6 +634,7 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 			if (!is_userspace_event(ev)) {
 				if (ev >= ARRAY_SIZE(cpumf_generic_events_user))
 					return -EOPNOTSUPP;
+				ev = array_index_nospec(ev, ARRAY_SIZE(cpumf_generic_events_user));
 				ev = cpumf_generic_events_user[ev];
 			}
 		} else if (!attr->exclude_kernel && attr->exclude_user) {
@@ -643,6 +645,7 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 			if (!is_userspace_event(ev)) {
 				if (ev >= ARRAY_SIZE(cpumf_generic_events_basic))
 					return -EOPNOTSUPP;
+				ev = array_index_nospec(ev, ARRAY_SIZE(cpumf_generic_events_basic));
 				ev = cpumf_generic_events_basic[ev];
 			}
 		}
-- 
2.53.0

