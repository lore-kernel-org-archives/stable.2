Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985E353EDF
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555710; cv=none; b=cRUSfjN5kCXT2x13+xzm0xHSxJJgPX+tROG54F3KuiPbbOC8phIF1dyzSG4OKoD+StP+rNLkQMo8rycohxqvz3Rlf402yYal7rEyTE0bV6KpvI1s17n4Uok7rJNx0KsAtT9mHGjFKadKHwu/TV8fevdhQHGX01PNW6awfbvzmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555710; c=relaxed/simple;
	bh=ytwEU5RfDaDajHRevNBTG0La1pgLWtGUIqvYoSEoEK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyvYSjzrqrXKSufIZBwRE0V/3sChhBbVT40BpZDxzZr89xaHYyjwu/YlgM0A1naokGsBeKc3IYLzYSS0KxmrWKm+UB4MiveTIL59iKUY6yCoC+GjP4zlKo4de0uPMueFlu9adF2SDlSPHDn8VwBuj2N+EaNPsUJGaT5Xt0CGIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf6qBzMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf6qBzMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD731F000E9;
	Mon, 20 Jul 2026 13:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555708;
	bh=gxYggZIgioIfVNykYGuXc3nz+KPodwXE3Lud8AnkVF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jf6qBzMh6MbmJMStMj7dbtxXfNpB1pH4guAlyZpwJZLj61sJDholRZcwV7Op76PfL
	 NqaCP4l5zg5SLyHRU1CH05MEbmBhXRm3HLBwN/SKcNmV527S+91heWQ2gYND0fgHWf
	 0STB110p1TOM2pLlBIV8Ha7qSDGTp/tJeYlhXsWeZ7j1BFzvf5A0B/i2ajk9j2q6Zq
	 /70B8IunvyzilKstTKa1rmgMIIj543mxArYeKtVY2dlYOZElHRfEaCa3r5g73KVth7
	 q9X8I6EFK87ScU9kFXn8dhz8hz2QJ7MokoQNqutLy23JGlexK8EoJmKLmmsCVV5/Ol
	 FDHk5WpuRGavQ==
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
Subject: [PATCH 5.15.y] usb: gadget: f_fs: initialize reset_work at allocation time
Date: Mon, 20 Jul 2026 09:55:05 -0400
Message-ID: <20260720135505.1350249-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071457-deepness-vixen-ba68@gregkh>
References: <2026071457-deepness-vixen-ba68@gregkh>
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
index 6efa8ac71b1a08..bcf0248133cc50 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -255,6 +255,7 @@ static int ffs_acquire_dev(const char *dev_name, struct ffs_data *ffs_data);
 static void ffs_release_dev(struct ffs_dev *ffs_dev);
 static int ffs_ready(struct ffs_data *ffs);
 static void ffs_closed(struct ffs_data *ffs);
+static void ffs_reset_work(struct work_struct *work);
 
 /* Misc helper functions ****************************************************/
 
@@ -1786,6 +1787,7 @@ static struct ffs_data *ffs_data_new(const char *dev_name)
 	init_waitqueue_head(&ffs->ev.waitq);
 	init_waitqueue_head(&ffs->wait);
 	init_completion(&ffs->ep0req_completion);
+	INIT_WORK(&ffs->reset_work, ffs_reset_work);
 
 	/* XXX REVISIT need to update it in some places, or do we? */
 	ffs->ev.can_stall = 1;
@@ -3342,7 +3344,6 @@ static int ffs_func_set_alt(struct usb_function *f,
 
 	if (ffs->state == FFS_DEACTIVATED) {
 		ffs->state = FFS_CLOSING;
-		INIT_WORK(&ffs->reset_work, ffs_reset_work);
 		schedule_work(&ffs->reset_work);
 		return -ENODEV;
 	}
-- 
2.53.0

