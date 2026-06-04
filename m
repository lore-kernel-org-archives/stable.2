Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DD1E9B35
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570107; cv=none; b=B5WEfBg+hVetUTcj/Mp2RBj49aB/D6yKyWhUhPq+NaQSpMdbMQHeLVEfYClzyLCQeVB34yD3Ib5lKTnecQYc93ckunD1m+MbVbt8W5Kb49HZBRDMJLaTrHdXBu4UKC7pYVnU5yBtPNfqoLuyTj0VGnHWarV1IAjfba14gNAKxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570107; c=relaxed/simple;
	bh=FFDVmRS1r4NLVdIgOSAU81q1/AprdYYo9zEgIs01YD8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ltD5F6E/l515vImuuw0q7Vg/MZhEhMKnuT29Ec/RUUFn7nVXyZimt92Yg5RM7Xx9qYI/w7dPv38stzYjHWJM0KxLLKlrmnxrCUjYUD3Sk9vlm+HrhL62rlfnV82BT1tc9j3/XmRIDI6/9tq+MbNhkYq0FupKx8szPpmF7W+TD8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pLUhOpd0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pLUhOpd0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248A61F00893;
	Thu,  4 Jun 2026 10:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570106;
	bh=uZhtRAbBtuq6kcgxNqeNNFwX9MaKDGya1LBKpzDFO7Y=;
	h=Subject:To:Cc:From:Date;
	b=pLUhOpd0bYPI+9mT7a+NAgXPhcU8CqcsG+oM9VVQ+k5a/1Owwldw/WPYWImPzxT75
	 NIETQ4V4VASMNSym3wsLvJ4dI/agAPJACdZJGvQkgS3hTD827EncaQhHvFhdvDiA7w
	 tmL9/PzJpx325PgEM9NtHXo1lFibSC/vMoEDEPrM=
Subject: FAILED: patch "[PATCH] usb: gadget: f_fs: copy only received bytes on short ep0 read" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:47:28 +0200
Message-ID: <2026060428-starter-stimulate-a40b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 4e036c10e7f4df5d951c69cc3697bc8e209c6d02
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060428-starter-stimulate-a40b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e036c10e7f4df5d951c69cc3697bc8e209c6d02 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sun, 19 Apr 2026 12:03:59 -0400
Subject: [PATCH] usb: gadget: f_fs: copy only received bytes on short ep0 read

ffs_ep0_read() allocates its control-OUT data buffer with
kmalloc() (not kzalloc) at the Length value from the Setup
packet, then copies that full len to userspace regardless of
how many bytes were actually received:

    data = kmalloc(len, GFP_KERNEL);
    ...
    ret = __ffs_ep0_queue_wait(ffs, data, len);
    if ((ret > 0) && (copy_to_user(buf, data, len)))
            ret = -EFAULT;

__ffs_ep0_queue_wait() returns req->actual, which on a short
control OUT transfer is strictly less than len.  The
copy_to_user() call still copies len bytes, so on a short OUT
the last (len - ret) bytes of the kmalloc() buffer --
uninitialised slab residue -- are delivered to the FunctionFS
daemon.

Short ep0 OUT completions are specified USB control-transfer
behavior and are produced by in-tree UDCs:

  * dwc2 continues on req->actual < req->length for ep0 DATA OUT
    (short-not-ok is the only ep0-OUT stall path).
  * aspeed_udc ends ep0 OUT on rx_len < ep->ep.maxpacket.
  * renesas_usbf logs "ep0 short packet" and completes the
    request.
  * dwc3 stalls on short IN but not on short OUT.

A short ep0 OUT is therefore not evidence of a broken UDC; it is
a normal condition f_fs has to cope with.  The sibling gadgetfs
implementation in drivers/usb/gadget/legacy/inode.c already does
this correctly via min(len, dev->req->actual) before
copy_to_user().  This patch brings f_fs.c to the same safe
pattern rather than trimming at a defensive layer.

The bug is reached from the FunctionFS device node, which in
real deployments is owned by the privileged gadget daemon
(adbd, UMS, composite gadget services, etc.); it is not
reachable from unprivileged userspace.  Linux host stacks
normally reject short-wLength control OUTs before they reach
the gadget, so reproducing this required a build that
bypasses that host-side check.  With the bypass in place, a
1-byte payload on a 64-byte Setup produces 63 bytes of
non-canary slab residue in the daemon's read buffer.

Fix by copying only ret (actually received) bytes to
userspace.

Fixes: ddf8abd25994 ("USB: f_fs: the FunctionFS driver")
Cc: stable <stable@kernel.org>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://patch.msgid.link/20260419160359.1577270-1-michael.bommarito@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 002c3441bea3..815639506520 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -619,7 +619,7 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 
 		/* unlocks spinlock */
 		ret = __ffs_ep0_queue_wait(ffs, data, len);
-		if ((ret > 0) && (copy_to_user(buf, data, len)))
+		if ((ret > 0) && (copy_to_user(buf, data, ret)))
 			ret = -EFAULT;
 		goto done_mutex;
 

