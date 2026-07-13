Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA43EB7F8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950369; cv=none; b=TgyaZQ3z+cAB0D08M/tD7A/7kkHkc2MvleHYWP+/GNAzRvDYaT/h7GIe8O/l9eTgeXSxkba6DOpof3r2rhvdphB9ycMt2WdcVXE5wG6kE/VECmMcDHObTrxFjaObD+wO05R2rVRR/bFXfbCWfsxVlZio+9WCBv9vvcTOEIZbni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950369; c=relaxed/simple;
	bh=GZAx/ZgbQklPEbA3bbcsfWTDU7xKH7Tw1CfTuKfGyiE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZJQDTNwkpupyc4eEu3WjT2XFCgSvFDYfY8eTMS0+Wx5ApVuKYEIh5byh13dVDejgCP3e+PblGPy2Z2HQmRl1QZ77PAi0eehfYj4jWrLlOn4rD/KLW/XkrPX8y3RFc8zYhTf/AXTjJ+WP6GQPURUH8gslhMyVGpYiI+K3PgAP7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GBW148mq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GBW148mq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FC21F000E9;
	Mon, 13 Jul 2026 13:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950368;
	bh=JK8ATcpZLeuW3nF4tfG1WQtnEDxLLxUHQhp6HDonFf0=;
	h=Subject:To:Cc:From:Date;
	b=GBW148mqOP3STgG+taUqKJClAvtOZoW7PQQgTsEq/JB2Khf9+6QEHN8mzAGomtVpb
	 Rbp8vqYNg7fcqdaHRZ9kEgFWXeWuOAZegkdfJoEtPYPY3YpIr4mmLaA0N92q7HXe90
	 X476WjjtwPJHT4yyVyWfCw4Nzyo8rlJzQEgC8heE=
Subject: FAILED: patch "[PATCH] coresight: etb10: restore atomic_t for shared reading state" failed to apply to 5.15-stable tree
To: runyu.xiao@seu.edu.cn,james.clark@linaro.org,suzuki.poulose@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:36:24 +0200
Message-ID: <2026071324-silt-managing-86e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fa09f08ede3db3050ae16ae1ed92c902d0cada23
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071324-silt-managing-86e8@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa09f08ede3db3050ae16ae1ed92c902d0cada23 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 29 May 2026 00:52:01 +0800
Subject: [PATCH] coresight: etb10: restore atomic_t for shared reading state

The etb10 miscdevice uses drvdata->reading as a shared exclusivity gate
for userspace buffer access. etb_open() claims that gate with
local_cmpxchg(), and etb_release() clears it with local_set().

That gate is shared per-device state rather than CPU-local state. A
running system can reach it whenever /dev/<etb> is opened, closed, and
reopened by different tasks while the device remains registered, so the
same drvdata->reading variable may be claimed on one CPU and later
cleared on another.

This code used to use atomic_t for the same gate, but commit
27b10da8fff2 ("coresight: etb10: moving to local atomic operations")
changed it to local_t even though the access pattern remained cross-task
and cross-CPU. Restore atomic_t together with atomic_cmpxchg() and
atomic_set() so the exclusivity gate again uses a primitive intended
for shared state.

The issue was found on Linux v6.18.21 by our static analysis tool while
scanning surviving local_t-on-shared-state sites, and then manually
reviewed against the live etb10 file-op path.

It was runtime-validated with a reproducible QEMU no-device KCSAN PoC
that kept the same report-local contract:

  1. use one shared struct etb_drvdata carrier and its
     drvdata->reading gate;
  2. call etb_open() and etb_release() sequentially on that gate to
     confirm the original claim/clear path;
  3. bind the open side to CPU0 and the release side to CPU1 for the
     same gate to show cross-CPU ownership;
  4. run bound workers that repeatedly race etb_open() and
     etb_release() on the same gate until KCSAN reports a target hit.

The harness recorded:

  L1 passed open=1 release=1
  reading_after_open=1 reading_after_release=0
  L2 passed open_cpu=0 release_cpu=1
  cross_cpu_release=1 reading_after=0 open_ret=0

Representative KCSAN excerpt from the no-device validation run:

  BUG: KCSAN: data-race in etb_open.constprop.0.isra.0 [vuln_msv]

  write to 0xffffffffc0003810 of 4 bytes by task 216 on cpu 1:
   etb_open.constprop.0.isra.0+0x38/0x80 [vuln_msv]
   l3_worker_thread_fn+0x4f/0xf0 [vuln_msv]
   kthread+0x17e/0x1c0
   ret_from_fork+0x22/0x30

  read to 0xffffffffc0003810 of 4 bytes by task 215 on cpu 0:
   etb_open.constprop.0.isra.0+0x18/0x80 [vuln_msv]
   l3_worker_thread_fn+0x4f/0xf0 [vuln_msv]
   kthread+0x17e/0x1c0
   ret_from_fork+0x22/0x30

  value changed: 0x00000000 -> 0x00000001

  Reported by Kernel Concurrency Sanitizer on:
  CPU: 0 PID: 215 Comm: etb10_l3_a Tainted: G           O       6.1.66 #2

This no-device harness is not a real ETB10 hardware end-to-end run, but
it preserves the same shared drvdata->reading gate and the same
etb_open()/etb_release() claim/clear contract. No real ETB10 hardware
was available for runtime testing.

Build-tested with:
  make olddefconfig
  make -j"$(nproc)" drivers/hwtracing/coresight/coresight-etb10.o

Fixes: 27b10da8fff2 ("coresight: etb10: moving to local atomic operations")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20260528165201.319452-1-runyu.xiao@seu.edu.cn

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index b952a1d47f12..a827f76b8144 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -83,7 +83,7 @@ struct etb_drvdata {
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
 	raw_spinlock_t		spinlock;
-	local_t			reading;
+	atomic_t		reading;
 	pid_t			pid;
 	u8			*buf;
 	u32			buffer_depth;
@@ -601,7 +601,7 @@ static int etb_open(struct inode *inode, struct file *file)
 	struct etb_drvdata *drvdata = container_of(file->private_data,
 						   struct etb_drvdata, miscdev);
 
-	if (local_cmpxchg(&drvdata->reading, 0, 1))
+	if (atomic_cmpxchg(&drvdata->reading, 0, 1))
 		return -EBUSY;
 
 	dev_dbg(&drvdata->csdev->dev, "%s: successfully opened\n", __func__);
@@ -639,7 +639,7 @@ static int etb_release(struct inode *inode, struct file *file)
 {
 	struct etb_drvdata *drvdata = container_of(file->private_data,
 						   struct etb_drvdata, miscdev);
-	local_set(&drvdata->reading, 0);
+	atomic_set(&drvdata->reading, 0);
 
 	dev_dbg(&drvdata->csdev->dev, "%s: released\n", __func__);
 	return 0;

