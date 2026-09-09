Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD953CA6F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954610; cv=none; b=VqBM6Cn9U38A+cCLFSB0bm2Np9qPIIO+nMgGJ9t0iFZVqfqX4VcytarVFoaklTbsLEhx8cSbzBJAWLdIi397ORG/MD7e0BzqgFzoTSjH0nrch9THUcpkohJg/l3oLDjbRsQ9snMwxdTGF6bgE9Guz5iDDkLoOaMdswKmYjPQ6uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954610; c=relaxed/simple;
	bh=pM2cK74XBm9AC36b4qB1WSBC5v+nGyqYnjmwhgPIx6c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r6PpDPk9mb13/E7ousMaRcHjnSTJx7OPNHxrZJmIvriHQ70TyGvpHYZgdE7C+zTEw8uqDdfQdJsimJosYKCuLlA97X91S0lnlki8TKJILmaHS06/PIlm4nrudzTUQLp9PcQ7T7UrJ4fZh1hJJaQtBlc2XwbJx6NXnRHaYKyTtig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ObbT6wep; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ObbT6wep"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FB61F00A3A;
	Wed,  9 Sep 2026 11:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954608;
	bh=RK6U3ED0beDlOQZghmIZP65m3o24pV+zhJcp7GfIbP0=;
	h=Subject:To:Cc:From:Date;
	b=ObbT6wepOAR34/U85ntWEnNTOrzeDJvhnRMhpWpySOe7KSnqwin7be/uBzva6Mh4b
	 ESVa0+aO9ZLDaHseIvOIX6kdrH36px4vVbPLMhWeNn9KG9Nwxu4IoNhEfe0VX/u9w/
	 fRikz/ihgU+wbfp8Oq0y6dgBIA+OetA4q+1WFs6A=
Subject: FAILED: patch "[PATCH] drm/xe/oa: (De-)whitelist OA registers on OA stream" failed to apply to 6.18-stable tree
To: ashutosh.dixit@intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:37:35 +0200
Message-ID: <2026090935-collapse-renegade-7f7f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f8e6874f46f19a6a2a0f24a81689f90641bb402a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090935-collapse-renegade-7f7f@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

