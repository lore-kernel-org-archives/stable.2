Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700849;
	b=VF5SRwgHV/Ky5vya/e2BKWPbirbGgVOqq6qrHAM/vvSZKzOwvwgtpPyyC+/sY9FcqSkW
	 dNvRcZMww7I45PYglgfoxkUHoXILwbmynn+P/Nf+GFlquBVqSp5F8mmesNjrU6wbRo7dx
	 fyuHlPCXwXFqdl8bwssBLAw5GPA2PkKLAiGI3s4HGIC2/5bgQpfh5lXdJKWfip8UqxHO4
	 +130OtS0BBUGpka5pLAfemYJRygLrxtCe/wwNnlhFd0jNoOzBZkL9P6AUZDp6W/SNJl5Z
	 Z2BmxgPMd/iMJNqgw4rJlr3GG5prQF4vTrWLzmhFTGiY+bqpd8oqWsdowTkJXWROWTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700849;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zgs3ez4oWdlPOKxBAU1zEZKSBi65gASkM8gU6unTdew=;
	b=ULwo6f8m32xGunJVFRHmRIPLC0m0CI+985sud/wVv8JcYftQnNS7EqaqShnRtufvredJ
	 mEjvV9clIEkaVkPkY6Ku0jsZzD7og8WDAItRX5ztMRcXw62XBQRFnu45KPy7uMHlw/uNk
	 /+ykOXV2GS6vfUejJo4jBglzTBbMdVPHW9fm0SGc+xCVI7ehl5x1A8LPc79OT/Q0kju5o
	 jiJVXcZNAOqnjnPkvG6628tfBxwdOPUz7MAPKi3RaCvAV1m6/EThe7Zzq24oOKBdk6Y0x
	 9zZE5rJr6T/Ard2aU2ifG9ZSNvhCF9CjXUb1Q3jxkp3at//bIsIFORDrhceijxVMhMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="QEplJmd/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA7606B129
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QEplJmd/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8702A1F00919;
	Tue,  3 Nov 2026 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700848;
	bh=zgs3ez4oWdlPOKxBAU1zEZKSBi65gASkM8gU6unTdew=;
	h=Subject:To:Cc:From:Date;
	b=QEplJmd/vq77pQTqkXL9iPOHdJcoAf03BPA1MAYQJSyc1Ct7lN2bd0TZn6/X6lUh6
	 NNuqF3oTOtR20XNe93fZWAMDf2b6jpuXaaGmtBkhqM9qZuWR3FQR4mJ9uzSPoLLJ+e
	 AitnUyyCLjP50+QlnKSpn/ArxfA/GoD21FdSLXKQ=
Subject: FAILED: patch "[PATCH] backlight: lm3630a: Cancel delayed work before destroying" failed to apply to 5.10-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,danielt@kernel.org,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:13:59 +0100
Message-ID: <2026110359-varsity-prefix-2813@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2cf184caab8b406fdd9db126ee40d62418237456
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110359-varsity-prefix-2813@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2cf184caab8b406fdd9db126ee40d62418237456 Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 2 Oct 2026 23:04:39 -0400
Subject: [PATCH] backlight: lm3630a: Cancel delayed work before destroying
 workqueue

The interrupt handler queues delayed work to read the interrupt status.
After free_irq() stops the producer, this work can still be waiting on its
timer. destroy_workqueue() cannot drain delayed work that has not yet been
queued by its timer, so the timer can outlive both the workqueue and the
devm-allocated chip containing the work.

Cancel the delayed work synchronously after freeing the IRQ and before
destroying the workqueue. This also waits for any running status read to
finish before the chip's resources are released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Link: https://patch.msgid.link/20261003030439.599330-1-mhun512@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8f49e59ce374..8ef8163c7fef 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -591,6 +591,7 @@ static void lm3630a_remove(struct i2c_client *client)
 
 	if (pchip->irq) {
 		free_irq(pchip->irq, pchip);
+		cancel_delayed_work_sync(&pchip->work);
 		destroy_workqueue(pchip->irqthread);
 	}
 }

