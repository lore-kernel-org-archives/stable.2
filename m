Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DA52B1FF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954612; cv=none; b=MTCX9aOaTw8TgegasKhUzhWTvIH2ugppFMxCQdCOZ1K6OQoGBR/SmC21HkZ3kAMbiWViM2lAp7akh3lrUiTvJxyD1RT4qrZR8MxJTQuPnlBiJCuE7Lna/YCwPKDcuq5RXjYnhdPSyfnnXaCzRI8+TiAcdztQtRf4BiKZ8NW6AYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954612; c=relaxed/simple;
	bh=YU8uiSSbPGE0M774QyJQyHJgrUh7ISDN7VpbaWh/V1U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i9VfskKEuQz+jl/dp8sattPuH0PXv5CJAp77F/LwX8146E+9bu+4vTXBqh5jXwTL0WpLYcM00wZyjCUYeW1zsGE2GMwxVx2pSaN9lyh9/UUJWzuFxImWtnwSqJhngP0m7N85BI2V9oLGv1TaYTctIaUrWbotxwrVa64o4OJZDyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FOD1xS9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FOD1xS9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063171F00A3D;
	Wed,  9 Sep 2026 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954611;
	bh=4tfUSOKznI2/DM6EnXirHP/PdXX3mZZGXJZJdq1+PAw=;
	h=Subject:To:Cc:From:Date;
	b=FOD1xS9mF8xHBTdaqhr+5TMCcLwrgNewoHQfrNZ+mW2eBn/90OE9acY1Vkd35H+Jo
	 BHVN0OPnWG3TcoiujJtSo9CALycKKhB8lfULICbq0qj2C1m4bYw0cME4PgLToOUIiX
	 Blj9U3OEf4X5mufbW+UrCGseGKg9FLcTdreXQjs4=
Subject: FAILED: patch "[PATCH] drm/xe/oa: (De-)whitelist OA registers on OA stream" failed to apply to 6.12-stable tree
To: ashutosh.dixit@intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:37:35 +0200
Message-ID: <2026090935-gilled-gradation-a6f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f8e6874f46f19a6a2a0f24a81689f90641bb402a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090935-gilled-gradation-a6f8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8e6874f46f19a6a2a0f24a81689f90641bb402a Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:26 -0700
Subject: [PATCH] drm/xe/oa: (De-)whitelist OA registers on OA stream
 open/release

Whitelist OA registers on stream open and de-whitelist on stream
close/release. Whitelisting is only done when 'stream->sample' is
true. 'stream->sample' is only true when (a) xe_observation_paranoid is set
to false by system admin, or (b) the process is perfmon_capable(). This
therefore enforces the OA register whitelisting security requirements.

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-9-ashutosh.dixit@intel.com

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 9fbd21b0ef97..b3acbcd678b7 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -37,6 +37,7 @@
 #include "xe_oa.h"
 #include "xe_observation.h"
 #include "xe_pm.h"
+#include "xe_reg_whitelist.h"
 #include "xe_sched_job.h"
 #include "xe_sriov.h"
 #include "xe_sync.h"
@@ -885,6 +886,9 @@ static void xe_oa_stream_destroy(struct xe_oa_stream *stream)
 
 	mutex_destroy(&stream->stream_lock);
 
+	if (stream->sample)
+		xe_reg_dewhitelist_oa_regs(stream->gt);
+
 	xe_oa_disable_metric_set(stream);
 	xe_exec_queue_put(stream->k_exec_q);
 
@@ -1886,6 +1890,9 @@ static int xe_oa_stream_open_ioctl_locked(struct xe_oa *oa,
 		goto err_disable;
 	}
 
+	if (stream->sample)
+		xe_reg_whitelist_oa_regs(stream->gt);
+
 	/* Hold a reference on the drm device till stream_fd is released */
 	drm_dev_get(&stream->oa->xe->drm);
 

