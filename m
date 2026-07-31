Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E85442FD8
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513022; cv=none; b=c4s5js8PUJ0vw690raFFDhdoOCqxVxYvojYT2MEBL6h6eOL4Wqm5YMpuIBIxyOXvVH3bY4S6+aZl8vZIPhmJhCt/eOU5LWkltzDzOSXgvD28LyksGkEiJfZL4cjc8VCgCYr/vFSo8qezvzYwFbC8Tosu/2MmFBvxNCmsDv1wA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513022; c=relaxed/simple;
	bh=Icz/V/RNdQe/nN3jiAy4MNO4uzOONy6Vm+qhQZS5bng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCHOFzKRcOi/PHM4QhrMMgMt/eMmDOjm5/XqCyi+Oca3bsa5X+7JNOT813M3DxxHT5Mr2e+TGj+XiFLzPGTMcL4xXCzUBK7y+ab/xFU1ertl5MgLFekla4KILXoGK0BhzQLF9dywi8vpVgW4Wyf1v3DulnkMJSCnLG1yzIg7wpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpeUb9MY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpeUb9MY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B6D1F00A3E;
	Fri, 31 Jul 2026 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513019;
	bh=Q8+1fqF9Xyp+i4+lJl2qXO1cj7PlsHBda3jimi+XPlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UpeUb9MYN9Nno5WkEvPT0Ji7Nqex6w4MlV/gWAG8cbpUUPgYKrsA/miN+TISJI+qg
	 nCp7ADJzUIzI9bSY2QgQBEdN2A2Pmx/hKxsoQk3/0Dz01Op1/fCPsNxXG4ML1bgPJF
	 vdcn1R5EH2eNf+wgfX0GbLbo8WVKYkGf+SZlN4yAwW/6iERM+A7PS0uRvjNNUfbdiK
	 abRD/moaslGI8Ta34F8y3m3F6EE13AegzA8es4uCtG+/DNRtHWdcwq0BEHtv0CwC8V
	 vUov5g74xrmqRgtKOMQcp6O7NW1bqHioKDYxAbz7KUFUti+spLoaC/19b4bUo4gLxr
	 rnBlnzX+6508w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jia Yao <jia.yao@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Mathew Alwin <alwin.mathew@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR
Date: Fri, 31 Jul 2026 11:50:15 -0400
Message-ID: <20260731155015.604147-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731155015.604147-1-sashal@kernel.org>
References: <2026051515-treble-unwieldy-f489@gregkh>
 <20260731155015.604147-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Yao <jia.yao@intel.com>

[ Upstream commit 662f9ddc8077792129440d05cbef2f944a07777a ]

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
(cherry picked from commit 4d58d7535e826a3175527b6174502f0db319d7f6)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index b31859fec555..b09cfd5a4d20 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3393,6 +3393,8 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
 		    XE_IOCTL_DBG(xe, coh_mode == XE_COH_NONE &&
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
+		    XE_IOCTL_DBG(xe, !IS_DGFX(xe) && coh_mode == XE_COH_NONE &&
+				 is_cpu_addr_mirror) ||
 		    XE_IOCTL_DBG(xe, op == DRM_XE_VM_BIND_OP_MAP_USERPTR &&
 				 !IS_ENABLED(CONFIG_DRM_GPUSVM)) ||
 		    XE_IOCTL_DBG(xe, obj &&
-- 
2.53.0

