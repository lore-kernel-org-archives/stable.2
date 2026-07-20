Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE443F0747
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544930; cv=none; b=SI+nngGLiTHdGMoUnjHZDgy74Tg4tYPGrKnBJ7vNrn9s7gsgC/F9BHDhnzhRyKFbB0+EsnVVTesEsRgOIpmaUYNYjZELUTcDwOvTP3+Txo1qKfIOlajK+cta87LhdHyKiJjl/0SaLpmb8bmKWX6LU/kvRV7nX3tpFxGkqAEuYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544930; c=relaxed/simple;
	bh=Vhu49pZNznfxRENE5GXvr7U4wul6hjxFDTC60vJIVxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oua9Toykn7J1Tbev4Uw9PIPrn5GGUbeelNcdNEL4ysIxTaJ9keAva6hydqJp4y9Q6+JgShYVBl+C0uEMlkWs6CulY2scvqzc1VFd7vgWj0WGMWpBFSxhcNYeG8aqxDXm+Rj5fU3by83cIuy45S6ts/Wm50f7L9FyIwSz4zlv8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWjIE5he; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWjIE5he"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79F31F00ACF;
	Mon, 20 Jul 2026 10:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544928;
	bh=/tOfgJVEPKa1w3n8rf7wkSeCUMnnfPcfrJK3uVCmYhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QWjIE5hebmTf5TUMJga8A0TkGYLRc3uYHhDrxMzkdjpJRsVbZFpPdFVPSiR+xTVX3
	 Jd8cnZwIBMIGeaIbUBn7gdVMyrAj6jVpFZZJ/CyVNz0JNsMmXBF+KTy21bsF9ndi+q
	 QAv8ttGf8bMd1GqOhm5yTHjBrnBFFixQkRE12EUIaEVB+/Xry+72JDiI3S1jeaITk1
	 xBNRTnvC2zjUQkpLbM18IoF40O1C2gXYcDHoY07z2QRoJc3JJCnJUnCT4V2eDHAdW8
	 qzCw1Z4jkdBDn5yHG0FxK8PSkT6dlwDcD4t/Qsz/e34jUHy/WiKlN9kyTUfCFaBXVi
	 xTXtfRf4E6IdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tyler Baker <tyler.baker@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Peter Chen <peter.chen@kernel.org>,
	=?UTF-8?q?Micha=C5=82=20Nazarewicz?= <mina86@mina86.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: gadget: f_fs: initialize reset_work at allocation time
Date: Mon, 20 Jul 2026 06:55:26 -0400
Message-ID: <20260720105526.221348-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071455-slacker-valium-0309@gregkh>
References: <2026071455-slacker-valium-0309@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tyler Baker <tyler.baker@oss.qualcomm.com>

[ Upstream commit 3137b243c93982fe3460335e12f9247739766e10 ]

ffs_fs_kill_sb() unconditionally calls cancel_work_sync() on
ffs->reset_work when a functionfs instance is unmounted:

	ffs_data_reset(ffs);
	cancel_work_sync(&ffs->reset_work);

However ffs->reset_work is only ever initialized via INIT_WORK() in
ffs_func_set_alt() and ffs_func_disable(), and only on the
FFS_DEACTIVATED path. That state is reached solely by ffs_data_closed()
when the instance is mounted with the "no_disconnect" option, so for the
common case (no "no_disconnect", or mounted and unmounted without ever
being deactivated) reset_work is never initialized.

ffs_data_new() allocates the ffs_data with kzalloc_obj() and does not
initialize reset_work, and ffs_data_reset()/ffs_data_clear() do not touch
it either, so reset_work.func is left NULL. cancel_work_sync() on such a
work then trips the WARN_ON(!work->func) guard in __flush_work():

  WARNING: kernel/workqueue.c:4301 at __flush_work+0x330/0x360, CPU#3: umount
  Call trace:
   __flush_work
   cancel_work_sync
   ffs_fs_kill_sb [usb_f_fs]
   deactivate_locked_super
   deactivate_super
   cleanup_mnt
   __cleanup_mnt
   task_work_run
   exit_to_user_mode_loop
   el0_svc

On older kernels cancel_work_sync() on a zero-initialized work struct was
a silent no-op, which hid the missing initialization.

Initialize reset_work once in ffs_data_new() so it is always valid for
the lifetime of the ffs_data, and drop the now-redundant INIT_WORK()
calls from the two deactivation paths.

Fixes: 18d6b32fca38 ("usb: gadget: f_fs: add "no_disconnect" mode")
Cc: stable <stable@kernel.org>
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Reviewed-by: Peter Chen <peter.chen@kernel.org>
Acked-by: Michał Nazarewicz <mina86@mina86.com>
Link: https://patch.msgid.link/20260609193635.2284430-1-tyler.baker@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adjusted context around the removed INIT_WORK() lines since 6.12 lacks the spin_unlock_irqrestore(&ffs->eps_lock) calls from 2005aabe94eaab ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index abc1ec50933f39..431ea3058c5d0c 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -291,6 +291,7 @@ static int ffs_acquire_dev(const char *dev_name, struct ffs_data *ffs_data);
 static void ffs_release_dev(struct ffs_dev *ffs_dev);
 static int ffs_ready(struct ffs_data *ffs);
 static void ffs_closed(struct ffs_data *ffs);
+static void ffs_reset_work(struct work_struct *work);
 
 /* Misc helper functions ****************************************************/
 
@@ -2224,6 +2225,7 @@ static struct ffs_data *ffs_data_new(const char *dev_name)
 	init_waitqueue_head(&ffs->ev.waitq);
 	init_waitqueue_head(&ffs->wait);
 	init_completion(&ffs->ep0req_completion);
+	INIT_WORK(&ffs->reset_work, ffs_reset_work);
 
 	/* XXX REVISIT need to update it in some places, or do we? */
 	ffs->ev.can_stall = 1;
@@ -3770,7 +3772,6 @@ static int ffs_func_set_alt(struct usb_function *f,
 
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
-		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return -ENODEV;
 	}
@@ -3797,7 +3798,6 @@ static void ffs_func_disable(struct usb_function *f)
 
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
-		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return;
 	}
-- 
2.53.0

