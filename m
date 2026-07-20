Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB54363C74
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555964; cv=none; b=uHjnmI+NQ7xhDGNSq2f/B8ZrDDOL67eReCqp1h/QSIxBd03c+bLr8zMjSkIWmJ2bB+9eGjy/riiz8KVOj5phgVg/F9s+nSInhKlWe0Lv6XSr8ZQGtAX+DvJqCxIJ31wHoWUXwB5nn5weF2L5A0Ijov7xmKnB28WwIdn8ogc7tsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555964; c=relaxed/simple;
	bh=x6TFhy0urTKQGffCYRTzhvZpI8y1XE+BJOp+qNxXXjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lps1fmTdq288ulyislp40GSuIdriVc/3GcoC4dPKv0NB+Y4XxPi9MPiF9jh/RjO26hX4kpveV3QeHqsRM7Tb+/D40YnImOuHrpuhznFpauFOqkdiG2OI+ZMVDTIN6+wLpFmS2fFzt+A1f7vdcnNNKNqLLnSfKgsz/adDmdX4ZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkAlbQzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkAlbQzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A3B1F000E9;
	Mon, 20 Jul 2026 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555963;
	bh=/vBXoM+L9OA7MpY96boBW6a7IKrQfhBvhpDA5/ylOw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jkAlbQzcmORHQZQk7kYLTFWT2XeDM6e0HauiaA7KCcaX6jIWQh5dBo8PczCqT62Gc
	 OYRt8RBhQeA+28kRKCiN9kYx50Y5uFR1VR8i9B4jNH+ODMXTxThu6kcr8mh6cw2Z1h
	 zl9MpmIhe/TupQM4z8xglSJISNe4XZdkalARW67LdonVQOMmQ158Us82yN/Fp84Cjq
	 Gjr3Elrkj2uPkqeLL/sRdJHa3j2BOxNvVenA+hTuqxSN5qHJaDb+XCFLBFZ+x0aQ7W
	 iTI3XOYHMcnQIYHXvullagl0TEOS8KWEl1f08P/kcV8PypfF2f8bT3DeW+qaY5lN2F
	 LL734jiCV8wSg==
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
Subject: [PATCH 5.10.y] usb: gadget: f_fs: initialize reset_work at allocation time
Date: Mon, 20 Jul 2026 09:59:20 -0400
Message-ID: <20260720135920.1408367-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071457-cornhusk-buckle-0dcb@gregkh>
References: <2026071457-cornhusk-buckle-0dcb@gregkh>
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
[ dropped the ffs_func_disable hunk since 6.6 predates the disable-body split and routes disable through ffs_func_set_alt, so removing the single lazy INIT_WORK there covers both paths ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index e6c7844b8d1c2b..b8b4ba389d2bf9 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -254,6 +254,7 @@ static int ffs_acquire_dev(const char *dev_name, struct ffs_data *ffs_data);
 static void ffs_release_dev(struct ffs_dev *ffs_dev);
 static int ffs_ready(struct ffs_data *ffs);
 static void ffs_closed(struct ffs_data *ffs);
+static void ffs_reset_work(struct work_struct *work);
 
 /* Misc helper functions ****************************************************/
 
@@ -1774,6 +1775,7 @@ static struct ffs_data *ffs_data_new(const char *dev_name)
 	init_waitqueue_head(&ffs->ev.waitq);
 	init_waitqueue_head(&ffs->wait);
 	init_completion(&ffs->ep0req_completion);
+	INIT_WORK(&ffs->reset_work, ffs_reset_work);
 
 	/* XXX REVISIT need to update it in some places, or do we? */
 	ffs->ev.can_stall = 1;
@@ -3330,7 +3332,6 @@ static int ffs_func_set_alt(struct usb_function *f,
 
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
-		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return -ENODEV;
 	}
-- 
2.53.0

