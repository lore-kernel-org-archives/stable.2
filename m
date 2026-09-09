Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29952ED47
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951673; cv=none; b=g+n2ZF7JcYE+o9b8jBsSx0hYDSAhkJwF57NWAgBsn4MSNJ9gCUDNguKbiHnI3Vhwda0KhLxSTmefXyuQfMyrXiQ1df3kLFZYmLtfcRmPNV8ZSfiJWhuHKJZ/Ce305N0wV1yDUl6CVVP1BNKTnBB69PFA9h+lJaxKuVleFpiEM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951673; c=relaxed/simple;
	bh=Ze+Y/OgahZlS9/Jg4u9AaxG7ReysE9plGXjEAdx2srU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oPokUkPNHos2RuMphVJtYfkrnWXTh0sVhuK3YQahXNx6ybQBJy6nadHmh/eQjxWBBzTF3ojCfL87lLjxAfZg/f1Sqk5+GDBqlPcN8EcYPoBkAQxqalgoVPBhweSSDViDEI2dC8i10855HpyfP4tgRsi5wQKIzxgoGVlra/7OZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L9t/KRAT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9t/KRAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64561F00A3A;
	Wed,  9 Sep 2026 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951671;
	bh=CLGJHMLvX0/TXI0BprCfKoBgPBafrojEpKUwVmPinJ4=;
	h=Subject:To:Cc:From:Date;
	b=L9t/KRATr1jHSd07VzlmCX3RVyNyYgIXXspq69WOjFMDnstQuxt7obIeoKTG/88v+
	 CsAMso5INTEmMXU3Sxf/4NnLf4iPY/N/is25jRY5K4VbTpkiu9fsSE83U3qzhfph9q
	 Yw/fcIHgWQKqJ3PKrSw4SpCLrrvRYdGuGR1HB80E=
Subject: FAILED: patch "[PATCH] media: chips-media: wave5: Resume device before setting EOS" failed to apply to 6.18-stable tree
To: jackson.lee@chipsnmedia.com,hverkuil+cisco@kernel.org,nas.chung@chipsnmedia.com,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:54:08 +0200
Message-ID: <2026090908-entomb-gradually-7052@gregkh>
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
git cherry-pick -x a52e6f7923c17a672135b485ffd96fbd72f46267
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090908-entomb-gradually-7052@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a52e6f7923c17a672135b485ffd96fbd72f46267 Mon Sep 17 00:00:00 2001
From: Jackson Lee <jackson.lee@chipsnmedia.com>
Date: Fri, 26 Jun 2026 10:22:32 +0900
Subject: [PATCH] media: chips-media: wave5: Resume device before setting EOS
 flag

Setting the EOS flag talks to the firmware via send_firmware_command(),
which accesses VPU registers. Both the STREAMOFF path
(wave5_vpu_dec_job_abort()) and the V4L2_DEC_CMD_STOP path
(wave5_vpu_dec_stop()) can run while the device is runtime suspended, so
those register accesses hit powered-down hardware and the SoC raises an
asynchronous SError, panicking the kernel:

  SError Interrupt on CPU3, code 0x00000000bf000000 -- SError
   send_firmware_command+0x2c/0x160 [wave5]
   wave5_vpu_dec_set_bitstream_flag+0x6c/0x80 [wave5]
   wave5_vpu_dec_update_bitstream_buffer+0x80/0xec [wave5]
   wave5_vpu_dec_job_abort+0x44/0xa0 [wave5]
   v4l2_m2m_cancel_job+0x110/0x19c [v4l2_mem2mem]
   v4l2_m2m_streamoff+0x24/0x140 [v4l2_mem2mem]

Resume the device with pm_runtime_resume_and_get() around the EOS
firmware command and release it with pm_runtime_put_autosuspend(),
matching the runtime PM handling already done in
wave5_vpu_dec_device_run().

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 1817b83c5884..6564cf3ec739 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -823,7 +823,15 @@ static int wave5_vpu_dec_stop(struct vpu_instance *inst)
 		 * calls do not block on a mutex while inside this spinlock.
 		 */
 		spin_unlock_irqrestore(&inst->state_spinlock, flags);
+		/*
+		 * V4L2_DEC_CMD_STOP can arrive while the device is runtime
+		 * suspended (e.g. on pipeline teardown). Setting the EOS flag
+		 * accesses VPU registers via send_firmware_command(), so the
+		 * device must be resumed first to avoid an asynchronous SError.
+		 */
+		pm_runtime_resume_and_get(inst->dev->dev);
 		ret = wave5_vpu_dec_set_eos_on_firmware(inst);
+		pm_runtime_put_autosuspend(inst->dev->dev);
 		if (ret)
 			return ret;
 
@@ -1797,11 +1805,22 @@ static void wave5_vpu_dec_job_abort(void *priv)
 	if (ret)
 		return;
 
+	/*
+	 * job_abort() runs from the STREAMOFF path and may be called while the
+	 * device is runtime suspended. Setting the EOS flag talks to the
+	 * firmware (send_firmware_command() accesses VPU registers), so the
+	 * device must be resumed first; otherwise the register access faults
+	 * with an asynchronous SError.
+	 */
+	pm_runtime_resume_and_get(inst->dev->dev);
+
 	ret = wave5_vpu_dec_set_eos_on_firmware(inst);
 	if (ret)
 		dev_warn(inst->dev->dev,
 			 "Setting EOS for the bitstream, fail: %d\n", ret);
 
+	pm_runtime_put_autosuspend(inst->dev->dev);
+
 	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
 }
 

