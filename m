Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7BA40A924
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321452; cv=none; b=DbDSIHtjOYOp64EFEAyQb2H5J7ziSZ9XZlgoiin/ZYOHBuYa2Yk/Y34kUXwzuNMYYpa6xd9+miLpDUU7HcE8QYV/JfXHBEZCIPw0iV1s2XM/+/Cn/S9Aj6waaKRcFeg8Myjumixz1Gn6YzFkMjIv/aeU0nxmwO9Dndy1zzkd50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321452; c=relaxed/simple;
	bh=c8Ykda+HMyQJsQbTM5wHBxotouifqN3SFR755p++weU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EwMGeoBR2wyj2MPdMVOk0i01dl3DvsMJujPyp/EJvL5HPwxkY+2kFOKAYL78uaCFYFJhaQpqkXDFsT+bZa1o+eVSsxNrJcsqOci8n39bgJDXa5ukpXs2iUo9IuO9L90uYZogyhOdr+d14RVf0eUnsMgow1Ymcgq1ZkU8bzcdiHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pHmalEeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pHmalEeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7401F000E9;
	Wed, 29 Jul 2026 10:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321451;
	bh=DghgyndknaQb5GY9l8fkJURZyRoyFiYOeAIcUfe5yG0=;
	h=Subject:To:Cc:From:Date;
	b=pHmalEeE1sP8d04jAgJWWt1z2aWIUwksLxGFtqWZ56uvnu0Z2Tqj2WsoF4fkhgV9f
	 FTBXUfjUVbVJUYplrbPCCofnqkp/9r+P76mPrWhf17oIOpr9SHWKgVYJ+/nImEun2h
	 Utef9O+6lzKtOFE6xO6J/lUZpt7WvEuaLSxhNEyI=
Subject: FAILED: patch "[PATCH] drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR" failed to apply to 6.18-stable tree
To: jia.yao@intel.com,alwin.mathew@intel.com,matthew.auld@intel.com,matthew.brost@intel.com,michal.mrozek@intel.com,shuicheng.lin@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:37:10 +0200
Message-ID: <2026072910-darkroom-avenue-7ff8@gregkh>
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
git cherry-pick -x 4d58d7535e826a3175527b6174502f0db319d7f6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072910-darkroom-avenue-7ff8@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

