Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045747;
	b=JRxoLVr48/6OxEXCsGRsxCXwUlorewkVtaqViSjQPDSxJYFq4JJIE8DA99RvciAvFJje
	 QyPKZPYxcRdmVrjA79WIADESdAKK0sO/E+lTIRodBjILg8rv9e7DLgvVG9YgBRwQwv1XD
	 2N+9xYzDJE7T+MWfLXPA3xxz92riR+CYnjCQZyqQrM8GwuxD+cowekJVL9WPntAvjrpZO
	 /YWf0eTuJYZsVGudOs1UEpatI5EbCBPIOnEzeMWjgjDrAojYAwhvOLeRMYA/KHgKaSgg/
	 ZvzfDeRH9XWDQsZHhKpgdn6TbgJzL1xFK7qHsHyvAA7kbvuObym57zZUOjtjdwMiW0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045747;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=g8IMm0TuGwe5dJ083jQpydDj8KuBbBW9rwWtKIhftFs=;
	b=oqcmOyvvXdUrZzQ1il3NpuirHf8RI/LYG4JlnCkkHKMpGTI2kry6XcVSW4u9OHR1G28K
	 /8Y+pTQKOPCl2AZPPTiAWASE7aTH7eBUI4Z9wmggc5ZHSE0Vxqx0AT4z2fsSOK8ITG4do
	 eU5oFCurg56wsXrQHfu0t1lxrDT+1qf8RMomSH4o3D28OdC9Romy3gs/rvBYzdtyb7Z5t
	 iOWpsi/+YsqecqmHCj2vlWTPqxqNdgH1NnLZVeGcxAxEiYr25svYYPJ2NwS+ouFR6oSVv
	 XaJ67nt8R8ObG7jwnLrSN27LOOcxDSl+PlwHNrUYsmPjPjgV/HA/9P0CTNE6dOUsaCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eC3u9II3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2CA606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eC3u9II3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCF61F0089F;
	Sat,  7 Nov 2026 10:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045746;
	bh=g8IMm0TuGwe5dJ083jQpydDj8KuBbBW9rwWtKIhftFs=;
	h=From:To:Cc:Subject:Date;
	b=eC3u9II3iENsGDSdcZS4b3Ub7RhmdstChMzA8VRp+uEIkObyqqB1rQz/ahDtcUdHt
	 useMW8dp8dHUVZKhoK/ZEFxQj19PNea3G3+y0SxSTHDW9pSwTxfZxD+e2m9mVZ4ToS
	 kRvxxrc8/TjuEQGzXxi08QhnG2qon9yOt/1OmkFH2MW6eAXpsr8pDQGuINs0dl3csu
	 mM7tCHKu1P/IIZsC0sPJXflkeb2NyqJogm/C1AMbik0l9WsWCod7EsBcBiDqe2uMSC
	 xJLtSaKpOxnkgdRjlE6q9owpHM9rrxIciTZvYgY0x5Q6EHV1BwKnzlldU0tCmgrf7L
	 brOAPy9iY1WSQ==
From: Sasha Levin <sashal@kernel.org>
To: raag.jadav@intel.com,
	rodrigo.vivi@intel.com,
	matthew.d.roper@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe: Fix xe_device_probe() failure" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:24 -0500
Message-ID: <20261107050224-failed-7.3-5ce3042c67c5@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 5ce3042c67c539480882567137ff8d56118885d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050224-failed-7.3-5ce3042c67c5@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5ce3042c67c539480882567137ff8d56118885d6 Mon Sep 17 00:00:00 2001
From: Raag Jadav <raag.jadav@intel.com>
Date: Mon, 10 Aug 2026 18:08:20 +0530
Subject: [PATCH] drm/xe: Fix xe_device_probe() failure

Currently, xe_device_probe() jumps to err_unregister_display label in case
of failure except for its last call, which directly returns the error
without required cleanup handling. This results in stale drm device that
isn't cleaned up on unwind. Fix it.

[  810.194180] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:01.0/0000:03:00.0/drm/renderD128'
[  810.194183] CPU: 9 UID: 0 PID: 5616 Comm: modprobe Kdump: loaded Tainted: G S   U      E       7.2.0-rc2-xe #382 PREEMPT(full)
[  810.194185] Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER, [E]=UNSIGNED_MODULE
[  810.194186] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 1805 10/30/2024
[  810.194186] Call Trace:
[  810.194187]  <TASK>
[  810.194188]  dump_stack_lvl+0xe0/0x100
[  810.194195]  dump_stack+0x14/0x20
[  810.194197]  sysfs_warn_dup+0x5f/0x80
[  810.194204]  sysfs_create_dir_ns+0xbe/0xd0
[  810.194210]  kobject_add_internal+0xbc/0x2b0
[  810.194215]  kobject_add+0x7c/0xe0
[  810.194220]  ? get_device_parent+0xcf/0x1e0
[  810.194227]  device_add+0xe3/0x870
[  810.194231]  ? __pfx_drm_gem_name_info+0x10/0x10 [drm]
[  810.194280]  drm_minor_register+0x73/0x130 [drm]
[  810.194322]  drm_dev_register+0x76/0x2a0 [drm]

Cc: stable@vger.kernel.org
Fixes: da3799c97572 ("drm/xe: Use GuC to do GGTT invalidations for the GuC firmware")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patch.msgid.link/20260810123821.105605-1-raag.jadav@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 7ca39ce2e0a2b..71111ad324658 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -1157,7 +1157,12 @@ int xe_device_probe(struct xe_device *xe)
 	 * xe_device_wedged_fini() is registered.
 	 */
 	xe_ras_process_errors(xe);
-	return devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
+
+	err = devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
+	if (err)
+		goto err_unregister_display;
+
+	return 0;
 
 err_unregister_display:
 	xe_display_unregister(xe);
-- 
2.53.0




