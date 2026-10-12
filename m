Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DCA48F856
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819205; cv=none; b=NLIOy0ExvPMHJPsXrA0XczFCrPdCDYUHwo56hFEmQIZp3jlGeIE9UaIwar8YSnij3M3SAndGp6VZ33MC4vxMlybQHMTndFnxugqQ7rVjnG22+TXAHqej7c+UU/D9FBDnvVDamuoPz7YtXmvA7pj37Wt/ZAh4kD02ceNn3WRbGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819205; c=relaxed/simple;
	bh=KcGWyRJ36nGlMIBDTDjRixTolDK+Y4T99n0X98/2zRc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KphuOlUaDtddBT5eHb0DOpz8T4BolGcDsDwQX18vXRbtuk14gjBdkD+orvI/iTUzoUTm7Hzou1jowKxns10y3Nj3LBgH15rUvlhBA3ajqy9YtQWsStBURRVGMhCjpGSOVIwe+drbjBaltzr9I/Y3XyYIiq/PBzJTt6IGIf1MRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vxd+NHtN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vxd+NHtN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1AB1F0089C;
	Mon, 12 Oct 2026 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819204;
	bh=LuuywW7BxKTWW9dkROatSJDgSij+rlVvNjexvRTVr2Y=;
	h=Subject:To:Cc:From:Date;
	b=Vxd+NHtN3/0oIbkHKBDU5focnR7kqEg5SqLo5RMek/0sWGZX5BzkGcI6G+g/NhUPm
	 Vnx1n/vK7UfHEUvRMpzcjqLSeiO2mWo8DF5595m1bC6E7r4z7ijCZnSy4cg1JGK863
	 kE1MqLhGnK5+G3TaaPz1G6E5AZw1xC4njuEy8Jyg=
Subject: FAILED: patch "[PATCH] drm/amdgpu: copy debugfs register data outside the GRBM/SRBM" failed to apply to 6.1-stable tree
To: mikhail.v.gavrilov@gmail.com,alexander.deucher@amd.com,christian.koenig@amd.com,tom.stdenis@amd.com,vitaly.prosyak@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:33:29 +0200
Message-ID: <2026101229-prize-machinist-e35b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 16c64495859f13f75602f439588883f2a4a4d6a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101229-prize-machinist-e35b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 16c64495859f13f75602f439588883f2a4a4d6a6 Mon Sep 17 00:00:00 2001
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 1 Oct 2026 21:13:07 +0500
Subject: [PATCH] drm/amdgpu: copy debugfs register data outside the GRBM/SRBM
 locks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reading or writing a register through the amdgpu_regs2 debugfs file
with GRBM bank selection, which umr does for every banked access (a
single "umr -b x x x -r <reg>" is enough, as is the wave dump with
"-O halt_waves"), makes lockdep report a circular locking dependency,
after which lockdep stays off until reboot:

  WARNING: possible circular locking dependency detected
  umr/63306 is trying to acquire lock:
  ffff8882cf4b8350 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x9b/0x140
  but task is already holding lock:
  ffff8881aec010d0 (&amdgpu_grbm_lock_key){+.+.}-{4:4}, at: amdgpu_debugfs_regs2_op.isra.0+0x20d/0xd00 [amdgpu]
  ...
  Chain exists of:
    &mm->mmap_lock --> &amdgpu_srbm_lock_key --> &amdgpu_grbm_lock_key
  ...
   __might_fault+0xc5/0x140
   amdgpu_debugfs_regs2_op.isra.0+0x441/0xd00 [amdgpu]
   full_proxy_write+0x10e/0x1d0
   vfs_write+0x1d0/0xf50
   ksys_write+0x116/0x250

amdgpu_debugfs_regs2_op() and amdgpu_debugfs_process_reg_op() call
get_user()/put_user() for every dword while holding grbm_idx_mutex or
srbm_mutex, and pm.mutex if requested, so a fault there takes mmap_lock
inside those locks. The lock hierarchy in amdgpu_lockdep.c puts
srbm_mutex and grbm_idx_mutex below notifier_lock, which
amdgpu_cs_submit() takes with the BO reservations held, and
dma_resv_lockdep() orders the reservations inside mmap_lock. So
mmap_lock is outside grbm_idx_mutex and srbm_mutex, and these two
debugfs paths nest it the other way round. The copies under the locks
are as old as the bank selection in both files; commit 1d0f5838b126
("drm/amdgpu: Add lockdep annotations for lock ordering validation")
only made them visible to lockdep.

Copy the user buffer in before any of the locks is taken and the result
out after all of them are dropped, as amdgpu_debugfs_wave_read(),
amdgpu_debugfs_gpr_read() and amdgpu_debugfs_gprwave_read() already do.
The buffer is sized by the count passed to read() or write(), so an
access larger than PAGE_SIZE is now rejected with -EINVAL; umr reads and
writes one register at a time. A fault on the user buffer of a write now
fails with -EFAULT before any register is written, instead of after a
partial write.

Fixes: 566281595037 ("drm/amd/amdgpu: Add bank selection for MMIO debugfs (v3)")
Fixes: 37df9560cd3e ("drm/amd/amdgpu: New debugfs interface for MMIO registers (v5)")
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Tom St Denis <tom.stdenis@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ccf9e35ed6811f2c25ba6368e7dc6481da17159d)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aca1a8045afa..ab7ccfaea22a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -121,6 +121,20 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 
 	*pos &= (1UL << 22) - 1;
 
+	if (size > PAGE_SIZE)
+		return -EINVAL;
+
+	/*
+	 * Access the user buffer only while none of the locks below are held:
+	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
+	 * inside it.
+	 */
+	u32 *data __free(kfree) = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	if (!read && copy_from_user(data, buf, size))
+		return -EFAULT;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -152,28 +166,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 		mutex_lock(&adev->pm.mutex);
 
 	while (size) {
-		uint32_t value;
-
-		if (read) {
-			value = RREG32(*pos >> 2);
-			r = put_user(value, (uint32_t *)buf);
-		} else {
-			r = get_user(value, (uint32_t *)buf);
-			if (!r)
-				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value, 0);
-		}
-		if (r) {
-			result = r;
-			goto end;
-		}
+		if (read)
+			data[result >> 2] = RREG32(*pos >> 2);
+		else
+			amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, data[result >> 2], 0);
 
 		result += 4;
-		buf += 4;
 		*pos += 4;
 		size -= 4;
 	}
 
-end:
 	if (use_bank) {
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
 		mutex_unlock(&adev->grbm_idx_mutex);
@@ -188,6 +190,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	amdgpu_virt_disable_access_debugfs(adev);
+
+	if (read && copy_to_user(buf, data, result))
+		return -EFAULT;
+
 	return result;
 }
 
@@ -238,11 +244,24 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	struct amdgpu_device *adev = rd->adev;
 	ssize_t result = 0;
 	int r;
-	uint32_t value;
 
 	if (size & 0x3 || offset & 0x3)
 		return -EINVAL;
 
+	if (size > PAGE_SIZE)
+		return -EINVAL;
+
+	/*
+	 * Access the user buffer only while none of the locks below are held:
+	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
+	 * inside it.
+	 */
+	u32 *data __free(kfree) = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	if (write_en && copy_from_user(data, buf, size))
+		return -EFAULT;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -281,24 +300,16 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 		mutex_lock(&adev->pm.mutex);
 
 	while (size) {
-		if (!write_en) {
-			value = RREG32(offset >> 2);
-			r = put_user(value, (uint32_t *)buf);
-		} else {
-			r = get_user(value, (uint32_t *)buf);
-			if (!r)
-				amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value, rd->id.xcc_id);
-		}
-		if (r) {
-			result = r;
-			goto end;
-		}
+		if (!write_en)
+			data[result >> 2] = RREG32(offset >> 2);
+		else
+			amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, data[result >> 2],
+						rd->id.xcc_id);
 		offset += 4;
 		size -= 4;
 		result += 4;
-		buf += 4;
 	}
-end:
+
 	if (rd->id.use_grbm) {
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, rd->id.xcc_id);
 		mutex_unlock(&adev->grbm_idx_mutex);
@@ -317,6 +328,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	amdgpu_virt_disable_access_debugfs(adev);
+
+	if (!write_en && copy_to_user(buf, data, result))
+		return -EFAULT;
+
 	return result;
 }
 

