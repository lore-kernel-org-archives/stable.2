Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675250;
	b=ebWA58u6X8R7Z4DcSiMYO4QebpnU/pogbfTRqnP5m+mgGMHWNNtWp9J1WbVpcHe2t9Jz
	 kKRLJYVWS1cIKhglwAGJs5ZGW6wsXtAv7MpmdjDJBUisALZmmiBtzRTBKkNIpuDPDAePW
	 im0dlYDsUef6Atu/AiYqIaHhMAjbaeDBehn6t6D6KA0GYXvDirViEBJyFy3dLRYa1bwD0
	 KB40xbR9UrpOIH8+eMBWIaFvTc7do9qwrz70jCKRxtM9zB+ORI9LMt6XA8Fw1EDp6/VxA
	 YcvXB3EKJj1dfe+SCz5MI+wQkE+keqZy8stj+bC5JHh3CLh4q24OL3ElJYrbrL2UZnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675250;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qSxrJZ8mqv3Y+H0yHIfJCiyW6kG5Ove0Pzqj0e0+3z4=;
	b=CoR1K1bKXAQRlogFERbXgT5CZGSzE9UuHFMceF1sC/0w+vxjlS7CJ69NiSZLniWGEax7
	 MgA83hP/ku2TzjwqRSfrT4h6C0YcrG7lmaJ1wChAGsv7PSdLHeHizfnlYrJFSn7nmVMIv
	 hHHAuKa+Z5W81SOp5ilTAk71ChH/t13dzEgCngVNycqsmGKOXim7ohcAEq96aMmcJDYWA
	 9R2+DagzNS6zWRfswo/EeAdHuGHQ0T7Dpp+E+Brw5FzVpldFK22H7TJO8JU6X1GdE5ur2
	 7s5DdZp9cajKqCaYfqp+3bEIvQjIHw7NOiktsQK72PaDRtxBbpvxvEimTjoh6LDRsCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsFOZ+Fw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA0606A31C;
	Thu, 26 Nov 2026 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsFOZ+Fw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795675250;
	b=oEYq/kk6JQx1ssyISUTm8fCX5Gzi6ciX4J+mM32YdT7tiCJVw1RY1oSDzvEynTVH9vJs
	 9NuI5sVnd2ttE/6f5SrwqDC2rP5wjil/qpR0acAtwa/ijQ5gkDu5yMN6zIBHBmDbCsI3y
	 rlZ1ELYYfJjt0ANFTbw1JP1g5YI5dfs9GdIcahTAPY3HUaZdb4F5qcrLQXs++QWRMU4Hf
	 3Zk84fssw2JZKaNrR6iVaKcSm8ydB0WDaOiOLapMHc6XoOKNSWJGe4crEMA3zBGl9f8JK
	 eA8pJ4U/V+JBA+lBL8Nw5WXTIdo9BsRoG1e4CbY729D3hUGOZ0HdCGmvW0vLu7EXnqw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675250;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qSxrJZ8mqv3Y+H0yHIfJCiyW6kG5Ove0Pzqj0e0+3z4=;
	b=0r9f40ZCGAKLpnvnQWTofcFnuhNLrb04Q4YW6HONYxwcbz9Ak4WkRld959aQnLj3rWAY
	 bvyuC+Mj66w664alyz8j6NSLnmi/hvSaAEzjyv7T04Qmh9uBM9Rcn5cMhYLmHbNbywdKY
	 YO7qU5qy1nbNRFz5EeBWyVsAL4171xgvZ8MCzVLuW2GV65EYavnhgtCatVQBBpo0cJ/vy
	 j2DYuT0DUYZtgnwES1BrcmwcwFgBenQ2jUGbAfc99Cy49HdjQpsejM4nbQ1fCoBjbXk3Q
	 9HkZmL686xaF8cbnr6HVBGiFqbuzSv3r4K5dkMce04PefAQw9851dOcUh3ehvPs/yyQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4B5FD1F000C4;
	Thu, 26 Nov 2026 06:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675250;
	bh=qSxrJZ8mqv3Y+H0yHIfJCiyW6kG5Ove0Pzqj0e0+3z4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=OsFOZ+Fwhz3R4fd9KddMb0TABHEvdfwrv6at5vv3JpFFi2G92KbojuPsYKtGBdISB
	 y53NMNo9Dlkp7CtqCdtAC1LJOyCMl/nYlCREaziE89BqFp6g+mRayG3xuHuMTyrdYr
	 corVpLP5mObxIYjNkGEzibFvDRsZJus+uHGAnAN35ueh9Qm9yef+N1w6I5AvdPfwMq
	 k9MicCSUsGh0lFPp0naWkCVYrQ+DLWkT0CrQZfwxSpLmVXl3O5FRTvCNsCE1OQ5q7C
	 FKA4vhWYPABTPFg0rxYGMHwFfTmzD40jtt6UHiFWWprQezEmUVcTiXu6qFVCmL8I9M
	 VgIOhZhYvr4Jw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BBF194D261;
	Thu, 26 Nov 2026 06:40:43 +0000 (UTC)
From: Jaegyun Lee via B4 Relay <devnull+dreams200260.g.skku.edu@kernel.org>
Date: Thu, 26 Nov 2026 15:40:43 +0900
Subject: [PATCH] usb: gadget: f_fs: fix UAF read in INTERFACE_REVMAP ioctl
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-ffs-revmap-v1-1-e1322f6fa290@g.skku.edu>
X-B4-Tracking: v=1; b=H4sIAGrUB2sC/y2MQQrCMBBFr1Jm7UAmYCpepXSRpJN2BGPJqAild
 2+iLt/j/7eBchFWuHYbFH6LyiNXoFMHcfF5ZpSpMlhjHZF1mJJiHd79iv3FkDk74uAM1MNaOMn
 nGxvGH+sr3Dg+W6EtglfGUHyOS1P/TrMW9v0AoERnaY0AAAA=
X-Change-ID: 20261126-ffs-revmap-78010561eb60
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jaegyun Lee <dreams200260@g.skku.edu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795675243; l=4099;
 i=dreams200260@g.skku.edu; s=20261126; h=from:subject:message-id;
 bh=lGzl9QWbGZO+/ZfDqZ6tmIIpCKGN1RaRxZQ6vywnsN8=;
 b=iR7+gtHg34TMl/noXXFkqyYklPjW6DUIXJ3MJNr8o2RdygcdSfsN34tRNkMNizYgPjQHT4CFN
 zgk0h/drSzNAf5375kXD3vaZ2/jiDjHgV8d8aia/G4Rb7avWpGQ1E8O
X-Developer-Key: i=dreams200260@g.skku.edu; a=ed25519;
 pk=vQE4ltNw5Q74mXWk3rPpCfclWKMKcHJ7J9YJ+gqaLUs=
X-Endpoint-Received: by B4 Relay for dreams200260@g.skku.edu/20261126 with
 auth_id=1649
X-Original-From: Jaegyun Lee <dreams200260@g.skku.edu>
Reply-To: dreams200260@g.skku.edu
Content-Transfer-Encoding: 7bit

From: Jaegyun Lee <dreams200260@g.skku.edu>

ffs_ep0_ioctl() snapshots ffs->func without any lock or reference:

	struct ffs_function *func = ffs->func;
	ret = func ? ffs_func_revmap_intf(func, value) : -ENODEV;

ffs_func_revmap_intf() then walks func->interfaces_nums for
interfaces_count iterations. ffs_func_unbind() first sets
ffs->func = NULL, then after drain_workqueue() kfrees func->eps --
the allocation chunk that also holds interfaces_nums -- and later
still writes func->interfaces_nums = NULL.

An ioctl that read ffs->func before the NULL write can therefore be
inside the revmap walk while the chunk is freed.
John Keeping noted this in 2021:
https://lkml.rescloud.iu.edu/2112.0/00724.html

The following is the KASAN log:

  BUG: KASAN: slab-use-after-free in ffs_ep0_ioctl+0x29b/0x300
  Read of size 2 at addr ffff888051b4925a by task park/9666
  CPU: 1 UID: 0 PID: 9666 Comm: park Not tainted 7.4.0-rc3-g666539eecdf4 #1 PREEMPT(full)
  Call Trace:
   ffs_ep0_ioctl+0x29b/0x300
   __x64_sys_ioctl+0x18f/0x210
   do_syscall_64+0x132/0x7c0
  Allocated by task 9675:
   __kmalloc_noprof+0x357/0x810
   ffs_func_bind+0xbd1/0x1b00
   usb_add_function+0x219/0x8a0
   configfs_composite_bind+0xcd5/0x17f0
   gadget_bind_driver+0x288/0xc80
  Freed by task 9675:
   kfree+0x2ca/0x6e0
   ffs_func_unbind+0x2f2/0x570
   purge_configs_funcs+0x283/0x520
   configfs_composite_unbind+0xae/0x210
   gadget_unbind_driver+0x211/0x520
   ...
   gadget_dev_desc_UDC_store+0x18a/0x2f0
  The buggy address is located 602 bytes inside of
   freed 2048-byte region (kmalloc-2k)

Take ffs->eps_lock around the REVMAP snapshot and walk, and move the
ffs->func = NULL write and the free of the eps chunk in
ffs_func_unbind() under the same lock.

Reproduced and tested in QEMU (dummy_hcd) only, not on real UDC
hardware.

Fixes: ddf8abd25994 ("USB: f_fs: the FunctionFS driver")
Cc: stable@vger.kernel.org
Assisted-by: ZCode:GLM-5.4
Signed-off-by: Jaegyun Lee <dreams200260@g.skku.edu>
---
 drivers/usb/gadget/function/f_fs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index c64a268e98a43..c824d1d5ce571 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -687,8 +687,13 @@ static long ffs_ep0_ioctl(struct file *file, unsigned code, unsigned long value)
 	long ret;
 
 	if (code == FUNCTIONFS_INTERFACE_REVMAP) {
-		struct ffs_function *func = ffs->func;
+		struct ffs_function *func;
+		unsigned long iflags;
+
+		spin_lock_irqsave(&ffs->eps_lock, iflags);
+		func = ffs->func;
 		ret = func ? ffs_func_revmap_intf(func, value) : -ENODEV;
+		spin_unlock_irqrestore(&ffs->eps_lock, iflags);
 	} else if (gadget && gadget->ops->ioctl) {
 		ret = gadget->ops->ioctl(gadget, code, value);
 	} else {
@@ -4203,10 +4208,8 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	unsigned count = ffs->eps_count;
 	unsigned long flags;
 
-	if (ffs->func == func) {
+	if (ffs->func == func)
 		ffs_func_eps_disable(func);
-		ffs->func = NULL;
-	}
 
 	/* Drain any pending AIO completions */
 	drain_workqueue(ffs->io_completion_wq);
@@ -4217,13 +4220,14 @@ static void ffs_func_unbind(struct usb_configuration *c,
 
 	/* cleanup after autoconfig */
 	spin_lock_irqsave(&func->ffs->eps_lock, flags);
+	if (ffs->func == func)
+		ffs->func = NULL;
 	while (count--) {
 		if (ep->ep && ep->req)
 			usb_ep_free_request(ep->ep, ep->req);
 		ep->req = NULL;
 		++ep;
 	}
-	spin_unlock_irqrestore(&func->ffs->eps_lock, flags);
 	kfree(func->eps);
 	func->eps = NULL;
 	/*
@@ -4235,6 +4239,7 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	func->function.ss_descriptors = NULL;
 	func->function.ssp_descriptors = NULL;
 	func->interfaces_nums = NULL;
+	spin_unlock_irqrestore(&func->ffs->eps_lock, flags);
 
 }
 

---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261126-ffs-revmap-78010561eb60

Best regards,
--  
Jaegyun Lee <dreams200260@g.skku.edu>


