Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25795221C0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911376; cv=none; b=drwR3PI5q8HipPdLpa/Vy/Vrr48S1BbhoBr8F7m8xfSIfW+BOZgm5/jmon5FyD9Xkt5T+lYn5IzWslQxzrwyiyuCjBMSY54lzWWV3/docIwOBNBkw3HeDB1XWeMD43pQkGUChW3KAxmT5EC75GOE0PtUm91tiJi85kv7AL6xzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911376; c=relaxed/simple;
	bh=9xASxftw/8PJ3+NKhxfK5aiwSfxieLtALX9MvNQrmiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIs6vCOcLIVFnqpYxrrXX3b6KpK7vL0sw3e6DbRtU8436YuROO17GrlSKVU7Bo0BorqGgbYSkgJLsaeSo+0PKanT8rCnoMjHRaCE+ulZxQxdxcJOSaW6CsJP4eOwGsxSrmw9T/la9mlV9a079HTb+A6R3P4Grz5m9HKGOPgEuCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuHL2P18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuHL2P18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5D81F000FF;
	Tue, 13 Oct 2026 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791911374;
	bh=3vVxWo4LYDEG3AEizsh+1dXWNzwfN3GLDYdQEFWg74Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cuHL2P181fcibtuOvDc4U12k7VsLPlqwMVM42ZBYfO8IZD12ib/ANjaeZ0r9oh9FQ
	 07lWoLs1flQFrERkhI9Xfn1+oWxxg1krpqjLbmz+M+3trG/InpXz4F9cILwPhH7ab2
	 1muuqk0Nw2tXgOmQTH30pax4AtvuMfQP1ldBxMsUsZ5Gskw1hNy/EaFOzQ27YLWu0N
	 c5JP3b4BcGtlwag/BwFF+y5+E4JRjlqebkaucvQBopNorTtS+5Anx0Smths9530EXa
	 axlxvM1+C+ddYyjEZACMfu3EvOovxRlNYI63IAfbrLlGwxLDvzNRdXZX9kFs2H2b3z
	 DJkUZhB+6QeEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tom St Denis <tom.stdenis@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: copy debugfs register data outside the GRBM/SRBM locks
Date: Tue, 13 Oct 2026 13:09:32 -0400
Message-ID: <20261013170910.593022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101230-expedited-brewing-2f54@gregkh>
References: <2026101230-expedited-brewing-2f54@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

[ Upstream commit 16c64495859f13f75602f439588883f2a4a4d6a6 ]

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
[ sashal: omitted changes to the absent amdgpu_debugfs_regs2_op() function. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 39 ++++++++++++---------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 944ecf780781e..01320252e5e04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -73,6 +73,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	int r;
 	bool pm_pg_lock, use_bank, use_ring;
 	unsigned instance_bank, sh_bank, se_bank, me, pipe, queue, vmid;
+	u32 *data __free(kfree) = NULL;
 
 	pm_pg_lock = use_bank = use_ring = false;
 	instance_bank = sh_bank = se_bank = me = pipe = queue = vmid = 0;
@@ -110,6 +111,20 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 
 	*pos &= (1UL << 22) - 1;
 
+	if (size > PAGE_SIZE)
+		return -EINVAL;
+
+	/*
+	 * Access the user buffer only while none of the locks below are held:
+	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
+	 * inside it.
+	 */
+	data = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	if (!read && copy_from_user(data, buf, size))
+		return -EFAULT;
+
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -142,28 +157,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
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
-				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value);
-		}
-		if (r) {
-			result = r;
-			goto end;
-		}
+		if (read)
+			data[result >> 2] = RREG32(*pos >> 2);
+		else
+			amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, data[result >> 2]);
 
 		result += 4;
-		buf += 4;
 		*pos += 4;
 		size -= 4;
 	}
 
-end:
 	if (use_bank) {
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 		mutex_unlock(&adev->grbm_idx_mutex);
@@ -179,6 +182,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
 	amdgpu_virt_disable_access_debugfs(adev);
+
+	if (read && copy_to_user(buf, data, result))
+		return -EFAULT;
+
 	return result;
 }
 
-- 
2.53.0

