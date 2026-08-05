Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE031448B92
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931060; cv=none; b=NFzYNlVCYzHhC9yjD9IbwADGe3eGHDoUIQc/v08ypnI/B94gBraZLG9J53RQPgl1W6wANY7uQQxUh64jloivnocbfp5JDg72199vKpAo/bWPZ7WPGZXhhPvWfZPwPvhQL1PS2n69DA+CTS0jvMI8CKlKH+sr0f7Xf/CV2jbtrMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931060; c=relaxed/simple;
	bh=fho+8A9hJQvT0Opm84SysWl8ienRP/3SB2HFrHWg42A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ylws7ZTz4IRSjBrXXuCpGnljF7BaXn6oietHH6SeFamwoM6yqhodrdB1WNIJxfsaIBNDgmGiDVk71eKOTkiujQyf0BjXnG0INhX3k3e6UEu8/tVLuSmTxYfrpVJ5aPjzNzOK9tdbEyn1mCPBTmyhbyHhYsfCMLTa33cuhAdN1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dPaKWWAu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dPaKWWAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA5D1F00A3A;
	Wed,  5 Aug 2026 11:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931058;
	bh=sXSI6x2oWKc52k8cijuZQCfLwDTr/C52cQm+MUQYOEU=;
	h=Subject:To:Cc:From:Date;
	b=dPaKWWAuXEKWwoFtZrwYu5n2JjSNjfUufBZS38NyGJT79bAeAFvq6/m1kwY30QXex
	 gMOydJyX+Y+T5YH/1r1Cr65R392/vcAC7BgHVijnmprDMAViYG4VtTMB9od3vLUKVb
	 9ZArvv9dv23RW4YgqsKlfF38ibhuo7zAefE2dLBo=
Subject: FAILED: patch "[PATCH] ice: wait for reset completion in ice_resume()" failed to apply to 5.15-stable tree
To: aaron.ma@canonical.com,aleksandr.loktionov@intel.com,alexander.nowlin@intel.com,anthony.l.nguyen@intel.com,kohei@enjuk.jp,przemyslaw.kitszel@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:50:26 +0200
Message-ID: <2026080526-docile-reply-8f04@gregkh>
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
git cherry-pick -x c2816d613f388814d27bc9fd6dbd931a88056e19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080526-docile-reply-8f04@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2816d613f388814d27bc9fd6dbd931a88056e19 Mon Sep 17 00:00:00 2001
From: Aaron Ma <aaron.ma@canonical.com>
Date: Wed, 29 Apr 2026 11:48:49 +0800
Subject: [PATCH] ice: wait for reset completion in ice_resume()

ice_resume() schedules an asynchronous PF reset and returns
immediately. The reset runs later in ice_service_task(). If
userspace tries to bring up the net device before the reset
finishes, ice_open() fails with -EBUSY:

  ice_resume()
    ice_schedule_reset()          # sets ICE_PFR_REQ, returns
  ...
  ice_open()
    ice_is_reset_in_progress()    # ICE_PFR_REQ still set, -EBUSY
  ...
  ice_service_task()
    ice_do_reset()
      ice_rebuild()               # clears ICE_PFR_REQ, too late

Reproduced on E800 series NICs during suspend/resume with irdma
enabled, where the aux device probe widens the race window.

  ice 0000:81:00.0: can't open net device while reset is in progress

Add a best-effort wait (10s timeout, matching ice_devlink_info_get())
for the reset to complete before returning from ice_resume(). In
practice the reset completes in ~300ms.

Fixes: 769c500dcc1e ("ice: Add advanced power mgmt for WoL")
Cc: stable@vger.kernel.org
Reviewed-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2fd2dab03e3..d88835482d3a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5637,6 +5637,16 @@ static int ice_resume(struct device *dev)
 	/* Restart the service task */
 	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
 
+	/* Best-effort wait for the scheduled reset to finish so that the
+	 * device is operational before returning. Without this, userspace
+	 * (e.g. NetworkManager) may try to open the net device while the
+	 * asynchronous reset is still in progress, hitting -EBUSY.
+	 */
+	ret = ice_wait_for_reset(pf, secs_to_jiffies(10));
+	if (ret)
+		dev_err(dev, "Wait for reset timed out (10s) during resume: %d\n",
+			ret);
+
 	return 0;
 }
 

