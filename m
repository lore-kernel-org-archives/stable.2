Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795679029;
	b=Dwxm8lg+xRzJkQdzbmkQuy5c9meYut8UoHW873hsddKya5a5jbYmjhanhsVHETRr+knz
	 k6byz3gdYt1lNcMUrBXMRMKUWvkIvkVoHxafYL+mX4uNN88I1rw6+tgrFimhVdurxkwUi
	 b7BX+wROCehh4uyUJWLlF449mxzEHRE1lzoSiY/5n4Hf8+QGjtsikxmKZJPSQAlknCd5e
	 Pcl6AIl6J3P2TWK/I5cq5fEb2A/EDnzuav62QWZwKviVnaMfYocKz7pzuCk6hzKXIHM72
	 EmVokQ09LDGrpgFBOzRKAXnukq9tFD0NXSpp7l+oJM+OO8uuKBxKzVIiriXEhNm8yYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679029;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=c+zYiyWRZpFupR7qOYRD4Ip+olyf6MxmkuvrsJ11IHA=;
	b=2dqGnJmu8/UX1WyTg8+3UZgABfyh1T9hmECzTlT+4S+ebXD4hvlWTq8rMNBa0ZoJV7Xy
	 hHOpleUSuZdCXu9zAd0293WSBJH1E5LLfwM//DEpW0cd/bpUbGDErGtO4c2fBfaNK1CPB
	 1AVPsmAEzInsCjBp0tgrFlKneJs1rtc8k6W7VRQ7mysOGEbquPFzZI3Rngor7MHpDm5s3
	 bAT/yXuBg78v8NDGsRHP6iH7sNy/LbhB6HymQJgbBtasu2GlZqIOL6EhtIR9vzhOTVvJd
	 S//X0NcU0wQ6CC2+iCWCld9+cTuVZN1zYUwExYze9DbAAZijlHInJYxKqIarcN5kcnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETofzvr5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D422606A33A;
	Thu, 26 Nov 2026 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ETofzvr5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795679028;
	b=z1TlF/sINmua6+zo8TmMUzUyGdnJdS9/FoujGJdinIjyQzi48jfHpfEAT3uJlUsFw1Na
	 Pe46DqT2JQ47h9HB56/XV2umF4GNhv/oZsLyMxerHnidMNwhD96iC/trjYqbRBv7C/iL2
	 xtbWelEKjag4Ec3DoCoLCZ0rt0h9jkCZdteuo0cKTZUezghkNGjmFMHsfLLfVJuADbnqU
	 vlWQude8dtm+2IBuMX/E1gJFbYPo9PMpzKhE/lZtNRKU7Lhlo6KmkeGvz+z3XU3uPtcdl
	 k1QdXptMXJDr78CFyD9Io4Gdnem4FXCLoL0uvC37e9sL0KdwcNdMtPrGIhJUD/l7mCA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795679028;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=c+zYiyWRZpFupR7qOYRD4Ip+olyf6MxmkuvrsJ11IHA=;
	b=NHN2+TlsSIRwsVet6uXfctFBTKRcnxrEeFyX8P5qmt4HwVzOZOZUomfPw2QBD+mfWoq8
	 umZcXOVfXMhqDUnEJ8W4nhhdVBGA7hGih8dL8T1Fcvs3yYIryWzY8qwDPOndur8BFBgNt
	 H07pDag4xd0lo4RX2t9sCIwd5uxcn4uGUPZpl0UaRnVABUYDmhkLf7pGUWyur95OYQYx8
	 pklij/jeQnVbM3embth79WJGNbTd2CkOTKk4vNlPUrYR8nbTjo9n2GJxTjWz8+YmLqFwK
	 Ax7J4UcW1Hk7/9FZGf51l7CoB1haU4FnOgetFIV3Z45o5MLrKp1Gl6ZL3x/LNQIOJ/Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 86D201F000C6;
	Thu, 26 Nov 2026 07:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795679028;
	bh=c+zYiyWRZpFupR7qOYRD4Ip+olyf6MxmkuvrsJ11IHA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ETofzvr5P3vF9Af39ASotrBaM5Pn44eN5q0JB8V2Z6mHYGnW2l34HOmofcWF4TCh4
	 WGzpZAzAA/ZasR3pGn/L/ef7dJ+z97I4iexaZnreFZsrZk7o7Mcay+/eMoYYBLJ5Vz
	 G9FpY+OkNZel38IppTExEWTdwdO9HL3H9xQTenJxxkPigirz7BkOUSqvdFPUvBHRNc
	 Lea3EoZy3rPzo1dJ+E55hF3CGzK8ozjJHzRmlK2a5tkC+v8RKDA1BPz54VCnXS3sQH
	 mTXbOSZxod0s+AJXah7YPu/cYWfcuDJMid3hKSar0a3TX6dIYAw6pfU5Jb+TI6tEA3
	 SsgOaghFp4Acg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 150934D2BC;
	Thu, 26 Nov 2026 07:43:42 +0000 (UTC)
From: Jaegyun Lee via B4 Relay <devnull+dreams200260.g.skku.edu@kernel.org>
Date: Thu, 26 Nov 2026 16:43:40 +0900
Subject: [PATCH v2] usb: gadget: f_fs: fix UAF read in INTERFACE_REVMAP
 ioctl
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
Message-Id: <20261126-ffs-revmap-v2-1-445e86b561dc@g.skku.edu>
X-B4-Tracking: v=1; b=H4sIACvjB2sC/22OSw6DMAwFr4KyblDsqulnxT0qFgk4kKICigG1Q
 ty9Ce2yy3l+HnsVTMETi1u2ikCLZz/0EfCQiao1fUPS15EFKtQAqKVzLGPxaUZ5vihQJw1ktRJ
 xYQzk/GuX3csv82wfVE3JkBrWMEkbTF+1Kfp5Uopp3HqehvDen1kgaf7eXUCCJDgiOu0MXlXR5
 Nx1c071LMpt2z6zA4bZ1gAAAA==
X-Change-ID: 20261126-ffs-revmap-78010561eb60
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jaegyun Lee <dreams200260@g.skku.edu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795679021; l=3771;
 i=dreams200260@g.skku.edu; s=20261126; h=from:subject:message-id;
 bh=mGP4dJRI5dVKVVI3t6CcFy7i3MLxyMc37ZVLWnt4iuA=;
 b=krablm811VIvfZOl5mHT85JdNyqt3jcsZjyaxRN09r7gstCHL10qMqILnDC1PoStAdByJfRZ9
 itXQ8tvCthuAbfxtf/I/E6QEB00w6jPss/zOnsSI9+ySr3+u3Ku/GH6
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

Take ffs->eps_lock around the REVMAP snapshot and walk, and do the
ffs->func = NULL store in ffs_func_unbind() under the same lock. A walk
that started before the store finishes before it, and every later
ioctl sees NULL, so the walk can no longer overlap the free of the eps
chunk.

Reproduced and tested in QEMU (dummy_hcd) only, not on real UDC
hardware.

Fixes: ddf8abd25994 ("USB: f_fs: the FunctionFS driver")
Cc: stable@vger.kernel.org
Assisted-by: ZCode:GLM-5.4
Signed-off-by: Jaegyun Lee <dreams200260@g.skku.edu>
---
Changes in v2:
- Keep clearing ffs->func in its original place in ffs_func_unbind(),
  before functionfs_unbind(), and only do that store under eps_lock;
  leave the eps free path unchanged (Sashiko review).
- Link to v1: https://patch.msgid.link/20261126-ffs-revmap-v1-1-e1322f6fa290@g.skku.edu
---
 drivers/usb/gadget/function/f_fs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index c64a268e98a43..df55c2cba6101 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -687,8 +687,13 @@ static long ffs_ep0_ioctl(struct file *file, unsigned code, unsigned long value)
 	long ret;
 
 	if (code == FUNCTIONFS_INTERFACE_REVMAP) {
-		struct ffs_function *func = ffs->func;
+		struct ffs_function *func;
+		unsigned long flags;
+
+		spin_lock_irqsave(&ffs->eps_lock, flags);
+		func = ffs->func;
 		ret = func ? ffs_func_revmap_intf(func, value) : -ENODEV;
+		spin_unlock_irqrestore(&ffs->eps_lock, flags);
 	} else if (gadget && gadget->ops->ioctl) {
 		ret = gadget->ops->ioctl(gadget, code, value);
 	} else {
@@ -4205,7 +4210,9 @@ static void ffs_func_unbind(struct usb_configuration *c,
 
 	if (ffs->func == func) {
 		ffs_func_eps_disable(func);
+		spin_lock_irqsave(&ffs->eps_lock, flags);
 		ffs->func = NULL;
+		spin_unlock_irqrestore(&ffs->eps_lock, flags);
 	}
 
 	/* Drain any pending AIO completions */

---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261126-ffs-revmap-78010561eb60

Best regards,
--  
Jaegyun Lee <dreams200260@g.skku.edu>


