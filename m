Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71A3EEAE9;
	Tue, 14 Jul 2026 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014629; cv=none; b=QnCIVnLjHiHJgIeGQtvoV9h1rgIXAZ3WWMyUQCcv9aEjB/4Wxsc8Mg9QoT4dtn2EW6REetPe6ori3QkKbubP33j0P8UtXa6L/KN1tqgcR6p0Fl8NDIvaHPxtttkI8O3CiLcbjob6wymZcBFCqFBiqEUGKV6lyGAdiaxDi2f4YU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014629; c=relaxed/simple;
	bh=AZpAkr363l173kD7NT5NPK8deMES+Fs0IiqhugmYluk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6NXLyrY89p4H/wDzVc6vwctzlQSi3qPmZolm3S9dqngNqSaWfKQEBR6GL8KZRnUqWb99+4G5ZOB575Sf+t97pfkbyRxtFTtjeGDMZXgy+R+8Tl/oPObpxNvaDwoWTZ2RGqmpI9Fu8YgtmKkEYN0AsaTe3uB6TzC7FgiuDIOqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.100])
	by APP-05 (Coremail) with SMTP id zQCowABnw9YS51VqEZEpGA--.61964S2;
	Tue, 14 Jul 2026 15:36:51 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Alessio Belle <Alessio.Belle@imgtec.com>,
	Brajesh Gupta <Brajesh.Gupta@imgtec.com>,
	Brendan King <Brendan.King@imgtec.com>,
	Danilo Krummrich <dakr@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/imagination: acquire vm_ctx->lock before mapping memory to GPU VM
Date: Tue, 14 Jul 2026 15:36:41 +0800
Message-ID: <20260714073641.1935075-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnw9YS51VqEZEpGA--.61964S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw15Zw4fJFWDGr47ZFWUJwb_yoW5Xw1rpa
	ySqw1jkw48KrWqv3WUta4Y9rySvw4ruayxGFWkX3Z5Zwn8Gw1qyr1Fqay5ZF98Ar4xKr42
	qr4qyayag34jka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/

The drm gpuvm code doesn't protect find operation against map operation,
and the driver needs to ensure a map operation shouldn't happen when a
find operation is in progress.

In some cases a find operation will be in progress when doing map/unmap
operations, and the find operation will do a NULL pointer deference.

An example of the stack trace of such NULL deference is shown below:

```
Unable to handle kernel access to user memory without uaccess routines at
virtual address 0000000000000010

[<ffffffff01e989d4>] drm_gpuva_find+0x28/0x6c [drm_gpuvm]
[<ffffffff01ed3a40>] pvr_vm_unmap+0x34/0x68 [powervr]
[<ffffffff01ec69da>] pvr_ioctl_vm_unmap+0x2e/0x50 [powervr]
[<ffffffff8080ce0a>] drm_ioctl_kernel+0x8e/0xdc
[<ffffffff8080d016>] drm_ioctl+0x1be/0x3e0
[<ffffffff802bec3e>] __riscv_sys_ioctl+0xba/0xc4
[<ffffffff80d858b2>] do_trap_ecall_u+0x23e/0x3f4
[<ffffffff80d92288>] handle_exception+0x168/0x174
```

As all occurences of drm_gpuva_find*() are already guarded by
vm_ctx->lock, make pvr_vm_map() to acquire this lock to prevent
disturbing any find operation. This fixes the NULL deference problem in
drm_gpuva_find*().

Cc: stable@vger.kernel.org
Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Fixes: 4bc736f890ce ("drm/imagination: vm: make use of GPUVM's drm_exec helper")
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
Changes in v2:
- Dropped wrongly duplicated mutex_unlock() call and reordered it to
  before pvr_vm_bind_op_fini() (the lock is acquired after
  pvr_vm_bind_op_map_init() call). (Thanks to Brajesh)
- Added a extra Fixes pointing to the original broken code that was
  refactored by the original Fixes (but still broken). (Thanks to
  Alessio)
- Fixed some typos in commit message. (Thanks to Alessio)
- Added a stacktrace of the oops that occured on my board. (As suggested
  by Alessio)

 drivers/gpu/drm/imagination/pvr_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 396d349fb6ce4..ceb78694cd987 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -747,6 +747,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 
 	pvr_gem_object_get(pvr_obj);
 
+	mutex_lock(&vm_ctx->lock);
 	err = drm_gpuvm_exec_lock(&vm_exec);
 	if (err)
 		goto err_cleanup;
@@ -756,6 +757,7 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 	drm_gpuvm_exec_unlock(&vm_exec);
 
 err_cleanup:
+	mutex_unlock(&vm_ctx->lock);
 	pvr_vm_bind_op_fini(&bind_op);
 
 	return err;
-- 
2.52.0

