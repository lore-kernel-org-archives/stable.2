Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA726A08F
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321444; cv=none; b=bZZHokjGrotyd+2QS4Y7vp9ltJWvscO4Ts7A1FEZsqo6G8IQWl7sLaM2rUHtJLAfjOvHbOd8dKuiavx+kuygMiryjKux8Cw2JYon6k4L662yntt12r6DCCXpGgjWoQis6yUe2YkVOIhDwOYR1aK148fT9or1ps+582YrCHn+2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321444; c=relaxed/simple;
	bh=6n9MIhqkBghDtpplarraCimcBnnx7oz7eCtjmQBMUSs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F1QxDoXnNWQLWIwpynU6MyHpXMLDZrP5TdJKlodKHwTVjQ+9XN4F01UBlvYPh2sjz1+185SnPiK1keeAuAcEOgQ3F7xMuqo5LGIGiTY3ZyGDkitbiTk6ujU8lJxSCLk7ont3tcxIFMvj42q+I2bSnxnTj7TCam4xxZkAzcCCuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jdJRTaby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jdJRTaby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564671F000E9;
	Wed, 29 Jul 2026 10:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321442;
	bh=Y+a8IfSEDpqZJC7Z9rNoD+ttzBICshMrN3p8r998ojw=;
	h=Subject:To:Cc:From:Date;
	b=jdJRTaby6EEf3yV/DiRTrSJ60vFWCcrMRLds9v3kHfDrTBp7eiam/BGrnIcVAAf1q
	 HV6YF+qc5RhjOexajMfgnV5ZXYfgWd2+fWY8XOBzEScfd45Q0bIt9kl2Ub+hpmlh8F
	 hfNrEpll8c+uvcuixPoUFJd3wq43/W5xkgz15FoM=
Subject: FAILED: patch "[PATCH] drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR" failed to apply to 7.1-stable tree
To: jia.yao@intel.com,alwin.mathew@intel.com,matthew.auld@intel.com,matthew.brost@intel.com,michal.mrozek@intel.com,shuicheng.lin@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:37:09 +0200
Message-ID: <2026072909-boil-smartness-3be9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4d58d7535e826a3175527b6174502f0db319d7f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072909-boil-smartness-3be9@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4d58d7535e826a3175527b6174502f0db319d7f6 Mon Sep 17 00:00:00 2001
From: Jia Yao <jia.yao@intel.com>
Date: Fri, 17 Apr 2026 05:59:17 +0000
Subject: [PATCH] drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR

Add validation in xe_vm_bind_ioctl() to reject PAT indices
with XE_COH_NONE coherency mode when used with
DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR.

CPU address mirror mappings use system memory that is CPU
cached, which makes them incompatible with COH_NONE PAT
indices. Allowing COH_NONE with CPU cached buffers is a
security risk, as the GPU may bypass CPU caches and read
stale sensitive data from DRAM.

Although CPU_ADDR_MIRROR does not create an immediate
mapping, the backing system memory is still CPU cached.
Apply the same PAT coherency restrictions as
DRM_XE_VM_BIND_OP_MAP_USERPTR.

v2:
- Correct fix tag

v6:
- No change

v7:
- Correct fix tag

v8:
- Rebase

v9:
- Limit the restrictions to iGPU

v10:
- Just add the iGPU logic but keep dGPU logic

Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
Cc: <stable@vger.kernel.org> # v6.15+
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Mathew Alwin <alwin.mathew@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Acked-by: Michal Mrozek <michal.mrozek@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260417055917.2027459-3-jia.yao@intel.com

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 5f4220125c76..c3836f6eab35 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3658,6 +3658,8 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
 		    XE_IOCTL_DBG(xe, coh_mode == XE_COH_NONE &&
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
+		    XE_IOCTL_DBG(xe, !IS_DGFX(xe) && coh_mode == XE_COH_NONE &&
+				 is_cpu_addr_mirror) ||
 		    XE_IOCTL_DBG(xe, xe_device_is_l2_flush_optimized(xe) &&
 				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR ||
 				  is_cpu_addr_mirror) &&

