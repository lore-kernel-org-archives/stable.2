Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D2560AC1
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873266; cv=none; b=UWQJwVeqRDeY6ubhtH5D1/IguqErjjHw2LsgPIjHSk4TJfugs0lBELUU8DjJ8epT7jd/vagkGJgHa6l6EyM/rofkb97ftp17dZULHOntr927UyOfb7JQvkFA9iwQIjrlaO42UckvVbDHv1btkHmFAlDxc+Az95V3r4L5lc0t73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873266; c=relaxed/simple;
	bh=moncKaUH5FORXC95ZtrfxZ/E/QzbHdqTWlJqwjrcHKw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QGxz0p8bFH8P1Q6P+S2GKXEafQiDG6UQaNchjjbf8EoyZjU9sL14IDNy4FBXTHIx0JJsDN3euz94ghO6yBKmbkLg9v1vmjlWeBl7D45FMi9MGom57njyk+guCVKv9u8add0+6GhCGDZVbkSHtqDYbBqr2WUXbV49tN4OKNGXA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XaSnxKuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XaSnxKuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53F41F00AC4;
	Tue,  8 Sep 2026 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788873257;
	bh=kJlghCyeAPEmcV+UtX9HVtxaqEl+QRXeD05T9xWhsLg=;
	h=Subject:To:Cc:From:Date;
	b=XaSnxKuLyOhHaRZ1NCH5LoXCRG/NhQGZozGOzdFYppXVJW2uvm9O6tUqECzU8KuSE
	 7gr+vC6L8DrQpVjVJpAS6nZOrQn5blQiVqLXLa6cKcSW0SoGo/ZstRX4CXENnHiGsr
	 c+hqjvD5x5ucyyVSYli+C0EjAJ/AAHqfld5ahSPk=
Subject: FAILED: patch "[PATCH] ublk: clear VM_MAYWRITE on read-only ublk char device mmap" failed to apply to 6.1-stable tree
To: kpskanna1915@gmail.com,axboe@kernel.dk,tom.leiming@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:13:14 +0200
Message-ID: <2026090814-theatrics-moonrise-113b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6e2b571b0a54755b06e092501913e1dfefe75d6c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090814-theatrics-moonrise-113b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6e2b571b0a54755b06e092501913e1dfefe75d6c Mon Sep 17 00:00:00 2001
From: Kanishka De Silva <kpskanna1915@gmail.com>
Date: Sun, 30 Aug 2026 12:31:33 +0530
Subject: [PATCH] ublk: clear VM_MAYWRITE on read-only ublk char device mmap

ublk_ch_mmap() rejects mmap requests with VM_WRITE set, but never
clears VM_MAYWRITE on the resulting read-only mapping. This allows
a userspace daemon to mmap the per-queue command buffer PROT_READ,
then upgrade it to PROT_WRITE via mprotect(), since VM_MAYWRITE was
never cleared.

The command buffer holds struct ublksrv_io_desc entries that are
kernel-written ABI; a writable mapping lets an unprivileged daemon
process corrupt fields such as addr, op_flags, nr_sectors, and
start_sector.

Same bug class as the drm/panthor and drm/vc4 VM_MAYWRITE fixes, and
the 2026-08-13 ptp/vmclock fix (a5edadbae57e).

Verified via mprotect() PoC: before the fix, a PROT_READ mapping can
be upgraded to PROT_READ|PROT_WRITE and a write into the command
buffer corrupts io_desc fields (confirmed under KASAN). After the
fix, mprotect() returns -EACCES.

Fixes: 3fee8d7599e1 ("ublk_drv: add io_uring based userspace block driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kanishka De Silva <kpskanna1915@gmail.com>
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
Link: https://patch.msgid.link/20260830070133.559-1-kpskanna1915@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6c5bec7da97c..e5ba07d8d281 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2653,6 +2653,12 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (vma->vm_flags & VM_WRITE)
 		return -EPERM;
 
+	/*
+	 * The per-queue command buffer is kernel-written ABI; prevent
+	 * the daemon from upgrading to writable via mprotect().
+	 */
+	vm_flags_clear(vma, VM_MAYWRITE);
+
 	end = UBLKSRV_CMD_BUF_OFFSET + ub->dev_info.nr_hw_queues * max_sz;
 	if (phys_off < UBLKSRV_CMD_BUF_OFFSET || phys_off >= end)
 		return -EINVAL;

