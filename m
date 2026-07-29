Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD2B44212B
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785323199; cv=none; b=mbh7m6VkaND5CDdXd0tma9aDuK+o0l0wMsx0K73y/n/VaiSfQfwh0B6/wSuk31RwZ6DF4HoQn92hON79ZBORtwTRNXOiBdZ8yuIqboeX3+QjBNh6JyU8IelFrPwOIPqQjYkFYbDSse/VOWRrXQ8uy03LawY1IFV21YOhMabN2Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785323199; c=relaxed/simple;
	bh=iHPYYHUDm7mVCa1l6hHCsVvsQxyP7dRlLHb1XqQCSD8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZZSRc5jvjcxzJHbagnvzhxymjdx5xySd0Sst1JVyIbe0XpTuc+6zBa3I6DuvpIHunVZsn25QHkohosuZKVG4aV+0X4V+q656EoWpi7BFOFpbGPB2/0gruSOKxocqgZ3xornPUEMTY++xuCudomhH0CCvefbRRJ4v16Rbt+a7XV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nJlbmfMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nJlbmfMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54111F000E9;
	Wed, 29 Jul 2026 11:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785323198;
	bh=VnZRSTWZxq5af4zSF+i043ILrH8xOs+jXCgI9FfoO2I=;
	h=Subject:To:Cc:From:Date;
	b=nJlbmfMZcXH81N6M36mw9uj7DTN/2r4X0XTPI1dRXrvxehxNdC+tBHONOI2mGH7AE
	 qT5TUAvLa/jSD9gkCinsi8+omNjU7iv4Nule7AEgNrPm5oM57gcoAzrsUPx4AvW6Xg
	 A9tUnlTWyARkHkYtdkZaL3ynpKMAq6tUxUrsv/xo=
Subject: FAILED: patch "[PATCH] drm/xe/oa: (De-)whitelist OA registers on OA stream" failed to apply to 6.12-stable tree
To: ashutosh.dixit@intel.com,thomas.hellstrom@linux.intel.com,umesh.nerlige.ramappa@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 13:06:17 +0200
Message-ID: <2026072917-headphone-enlighten-3cea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 63ddb3ad08ff4e89c108499dfec5e9be5ddc25c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072917-headphone-enlighten-3cea@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63ddb3ad08ff4e89c108499dfec5e9be5ddc25c9 Mon Sep 17 00:00:00 2001
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
Date: Mon, 15 Jun 2026 15:42:26 -0700
Subject: [PATCH] drm/xe/oa: (De-)whitelist OA registers on OA stream
 open/release
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit f8e6874f46f19a6a2a0f24a81689f90641bb402a)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 4bf4b1f65929..2dce6a47202c 100644
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
 
@@ -1885,6 +1889,9 @@ static int xe_oa_stream_open_ioctl_locked(struct xe_oa *oa,
 		goto err_disable;
 	}
 
+	if (stream->sample)
+		xe_reg_whitelist_oa_regs(stream->gt);
+
 	/* Hold a reference on the drm device till stream_fd is released */
 	drm_dev_get(&stream->oa->xe->drm);
 

