Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91C449B26
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931063; cv=none; b=eo8+c8a/rUvb+DmiVTGS7XCKw/6WKxfeUi3VnXZkrWH1qVLfnQAOt0hZjdZ1nrznI/nEzk0eaGu6Ka8GMCGeodAEIEp2xja6jMotwsq5+ukEeL6WSiHg5ES0GjHXeldmm/FjS989nRTTTr+mNlmj9GAzdHsZDBwsxElGWwjoxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931063; c=relaxed/simple;
	bh=VhOmcLAh6v33N1Y1OcBRRtSlhNqhQAA9d4YYOX/sAUk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RCfd77eMiCVFeSEawrRv71IEgsM7ECap3aYWoABnmMIzi4fm5pAWa6/5H1XpVUL5hXD6FhoY072dBpJw9VNlYWPdrj9tGVbPxY6gM/RNpAMiZ1uhQmJNCjVpi76YCrJfdR0pqA4MKq6ordXjpWhr4WlNzzOsrml/clSBHNBEGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ieKIfDl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ieKIfDl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83201F00A3E;
	Wed,  5 Aug 2026 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931061;
	bh=5MyDDPGzHC9DJd5+Wnw8I/Xxgh1T9U7WozCHLnsWatA=;
	h=Subject:To:Cc:From:Date;
	b=ieKIfDl7EOKohUwgOLHh2v0y4rxMlt99u2MOgPIpFnsRVbcWOmwiGyRaCV5/SZ4b+
	 pEUKG/YfONk3jCPafi5u6WQQz92lrshQtTavct4qLBgkxlK4wRN0NtDkiU2ZBTIkV2
	 JoF7NROnGGKpfw0z4uY47rrAHTk+TMd630Zbxa3M=
Subject: FAILED: patch "[PATCH] ice: wait for reset completion in ice_resume()" failed to apply to 5.10-stable tree
To: aaron.ma@canonical.com,aleksandr.loktionov@intel.com,alexander.nowlin@intel.com,anthony.l.nguyen@intel.com,kohei@enjuk.jp,przemyslaw.kitszel@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:50:27 +0200
Message-ID: <2026080527-theft-guacamole-6749@gregkh>
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
git cherry-pick -x c2816d613f388814d27bc9fd6dbd931a88056e19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080527-theft-guacamole-6749@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

