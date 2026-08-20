Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CF942A160
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225102; cv=none; b=qkaNHGcsIFIAb6Gx90/e+TbRbyuCUKvC53C7gcr7nVYfWD0AaZKRtzof7hI6xY0HjIxwwh7Uy2eoEbREYwnO0BQFvBpHJyQLwo0JsPeVM+QufnsaDHImlRStFPR9IgHTbOQrVMTBLi2gIrxuoCNiyjwMDi625+Msj12gh3xY5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225102; c=relaxed/simple;
	bh=w70Cj5YLUZp3xPncjvJnzVFoQQMLIsPud/VmYVBS2ro=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rn85ZMlLc/QH2kk8a9Md+zBJYv36qFo6XNqE0bo9lvr+26ozgwvkPidiNh7v8Z5DErt4u9kHyco7xJek+WoLlHUQqsi779c2/T+yKpysm5yIRvuu1FdVrK1vZZReZMLu7fr6D4664u1CjJpmF3uheUUiyg8lVP92KFQPcfAV75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UptppSMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UptppSMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F385A1F000E9;
	Thu, 20 Aug 2026 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225095;
	bh=dah0N/CjeQY4jq3kjkWSi4O8BEAcg2DQsd8LjniJ/R8=;
	h=Subject:To:Cc:From:Date;
	b=UptppSMpJfI1TbhwVIAYZrPzkTPDJpmBj8fownDe1KKqcMTbKgSSiT09CMBERsFA3
	 JC7m8jAX7idI1Ox002x1wYtnO/BloLFTU7KqywP07aVCaeiDpi9IXDSDlWQJ573J7q
	 vZhtU68CX5joPHjMQoQpMiAPgjp7hf4jvj7MOp3Y=
Subject: FAILED: patch "[PATCH] drm/xe: Fix xe_device_probe() failure" failed to apply to 6.12-stable tree
To: raag.jadav@intel.com,matthew.d.roper@intel.com,rodrigo.vivi@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:15:34 +0200
Message-ID: <2026082034-stopwatch-nurture-dc0d@gregkh>
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
git cherry-pick -x ef526d122b62af5afa437f095aa6661a953676c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082034-stopwatch-nurture-dc0d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef526d122b62af5afa437f095aa6661a953676c4 Mon Sep 17 00:00:00 2001
From: Raag Jadav <raag.jadav@intel.com>
Date: Mon, 10 Aug 2026 18:08:20 +0530
Subject: [PATCH] drm/xe: Fix xe_device_probe() failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index dcb48caa485d..a2b076b1dc60 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -1102,7 +1102,11 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		goto err_unregister_display;
 
-	return devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
+	err = devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
+	if (err)
+		goto err_unregister_display;
+
+	return 0;
 
 err_unregister_display:
 	xe_display_unregister(xe);

