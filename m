Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5500F41931E
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551184; cv=none; b=Qu3nk7nsGO6PvPsXSE/Ly/WX0XTL3peF4wmI61QUi2jD6eDeENXmv471YgvM6WdmhSBOlt76ssIFVeFtz7BM3kfoHcdmSZEJVmvLB7caOUG/FMs0U/okI24ksRT6qq1vtwbhmQeGDb8x7vCHSdSnKIc3XppqZpi9XoZQTX5ZN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551184; c=relaxed/simple;
	bh=zPelzoOOq3maiDroPjlw1AtXZeQuuTUVP7uEKi9TAHE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JWaiQSDVh0T56OWPnPisj9LqYXlYwr4BHyhefxZsV/ouvOo7/Jbu+7DQT/13W/VLisoJaf8lbARrrCqi7kDcFlrmNF109JDBjGaaAFv3LFHFdcPAmei3y02hV3Tze5NS6Mh2c5su6Do3U5kX050kRm6ElOBSujv9WAOfPs8uC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BoripcGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BoripcGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2301F000E9;
	Mon, 20 Jul 2026 12:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784551183;
	bh=I5SzyvE6nvDpDFyiwlkbC46lzYD8gF9zEJ09/+D1EWU=;
	h=Subject:To:Cc:From:Date;
	b=BoripcGJQe8iZLAoDxgPx1YSjUEpTlcj+vEoYZKDYFyTB7EBGsh0s8IK4ReWKf7O6
	 RVoL9dRVPDiNNjJjNGtQrutmnXxJSbmBNUlLv9x/bnyO8m2EmlNOmpECneP02R7/0s
	 PmjD8FU52EObwLpoHX0ZZqq2TfTMe9JROVSzUMgY=
Subject: FAILED: patch "[PATCH] s390/perf_cpum_cf: Add missing array_index_nospec() to" failed to apply to 5.15-stable tree
To: sumanthk@linux.ibm.com,gor@linux.ibm.com,iii@linux.ibm.com,tmricht@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:39:26 +0200
Message-ID: <2026072026-culminate-iguana-8700@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 49145bce539117db4b6e9e83c0e5ef528e361050
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072026-culminate-iguana-8700@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 49145bce539117db4b6e9e83c0e5ef528e361050 Mon Sep 17 00:00:00 2001
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
Date: Mon, 6 Jul 2026 12:46:31 +0200
Subject: [PATCH] s390/perf_cpum_cf: Add missing array_index_nospec() to
 __hw_perf_event_init()

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

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 7aa655664ecc..2076ac22e2c4 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 
 #include <asm/cpu_mf.h>
 #include <asm/hwctrset.h>
@@ -768,6 +769,7 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 			if (!is_userspace_event(ev)) {
 				if (ev >= ARRAY_SIZE(cpumf_generic_events_user))
 					return -EOPNOTSUPP;
+				ev = array_index_nospec(ev, ARRAY_SIZE(cpumf_generic_events_user));
 				ev = cpumf_generic_events_user[ev];
 			}
 		} else if (!attr->exclude_kernel && attr->exclude_user) {
@@ -778,6 +780,7 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 			if (!is_userspace_event(ev)) {
 				if (ev >= ARRAY_SIZE(cpumf_generic_events_basic))
 					return -EOPNOTSUPP;
+				ev = array_index_nospec(ev, ARRAY_SIZE(cpumf_generic_events_basic));
 				ev = cpumf_generic_events_basic[ev];
 			}
 		}

