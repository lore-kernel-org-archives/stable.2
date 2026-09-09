Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3344F4741
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954562; cv=none; b=Oie53yUSvR4Q4byytmOp5zXPPcFH2QXL42gwWkkYVloMDRDVhAi73OddHikX4lXoaszKKzcTysCcV399Go0BGmUXtK8qNUf5pACp4nftpypMFAWJR7nZgkn1MNXcpT7EQfLEnFbAGFkKWtCz7Vs0jkOZd0V8q1dBFeLESr90i50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954562; c=relaxed/simple;
	bh=roO70FNCDPm5joG4V5D7DKVOlKTR2fNwePG3KIiVE40=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pRTc+tOe5CUBaPkk8J1RAVYPXBU4C0z0d/OE2zzhp05QhfqzImhGMlYnIZU8PmYV9NK3ucttMRx5HxM7vpL6a1qfB9RPGMdkiZAzCcoaMHEL0RwzPVwHKj5gIZpGlqxuLE58Y1fu/iFwqDAr2oibMFKzg1yQ8TV/TorOS7IP5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R1gRNPCl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R1gRNPCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FB51F00A3A;
	Wed,  9 Sep 2026 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954560;
	bh=DEN2HHaRarzMpfSgydb2B//wYy6lkYAPYmfV+lMK9iw=;
	h=Subject:To:Cc:From:Date;
	b=R1gRNPClhwy2m3CmFiQAvXD3q6Ie65sju+6qQ60X1N55J8BINbSN64+Ef0WnXAKvK
	 WBE53wmJf9gpRhKx/6JPT5UYcUma96f9TOL6EzLwyBELlYZ/yRhdPM1UALHr8NaRD1
	 0ixpwE555m5qhpGCR8I7E96ww0NnkwkkZm5FgpUA=
Subject: FAILED: patch "[PATCH] drm/xe: Fix xe_device_probe() failure" failed to apply to 6.12-stable tree
To: raag.jadav@intel.com,matthew.d.roper@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:34:06 +0200
Message-ID: <2026090906-slacker-entrench-a4b6@gregkh>
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
git cherry-pick -x f8152179882a57e62a07dbf25ec95321c44e6b23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090906-slacker-entrench-a4b6@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8152179882a57e62a07dbf25ec95321c44e6b23 Mon Sep 17 00:00:00 2001
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
(cherry picked from commit 5ce3042c67c539480882567137ff8d56118885d6)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index d25d02b24898..71ce153737ab 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -1147,7 +1147,12 @@ int xe_device_probe(struct xe_device *xe)
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

