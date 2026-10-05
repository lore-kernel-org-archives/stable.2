Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201874BEE45
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212894; cv=none; b=RBxvCEjOFLON9ViOZuegovQ6FgRQsWjNMNjpMr7N1WTMi7/n8SBMfNb4wyr6WR/yEFqtYmqYxsqh0+0XmDTG30FQ7W/DRT4OhL5dl7F1MOMocdhe0mDly9QDWL69ajUgI4KMWt5YdRPbJBi9xL+nl26AQlSt4Le3L+0H3VPQas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212894; c=relaxed/simple;
	bh=V83y5tsI9PQARVml+53sd592LknUqOZRaDmPXa2CDag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlN4IH7Klfy9/261JClpJdGY4mPjbSK00vuEiAAMH42B/tqeUu1uz3F6Zrr6/LpHjVQ8JD8u0PZCH54cATqa4mrTw5xAgPMjGELcR8hte+jdRhcBhVpkPV3z/ShzfyXnQ2SyWTRolSyF0Cq1sDhHgVKANRq7nG+8ANexGQHrTbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaS+2KFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaS+2KFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861C81F00893;
	Mon,  5 Oct 2026 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212892;
	bh=GJ41EMGwsFxBWsnZ+KWpJbcHoRG+hZjgaG4xbK6a0xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FaS+2KFN4xCywfK4g+wwU5n0MjgpGpWwhWTrg0P2wnaBM8Hp+7xWuRs1bRYT12ciq
	 GKI859wwvXamjY87oRgNFDWnczEP17yu1M0tN1wppy5IxHpokDRvWiFYc4Ta0qlTqZ
	 1tFOg7SL+GMte92SNe6yUCT36jiSSMN3397uvN3FlLucQctJKZ5rZH8/A46sORxXUm
	 aV196c5ILlmPj/Y8Hnu8r3dEQwv6C5bTIo+YaAfrWxjGR3hRUVMrFBKrh+A9NjS+j+
	 ZSAzSPLpm47WshH0zcPFXbo51+p6a1sK31v8Plpk6iu69ULCXw1PDOMq896c/HUUIu
	 YqcFL7mRQbvpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] USB: dwc2: shut down wakeup timer before freeing HCD state
Date: Mon,  5 Oct 2026 11:08:09 -0400
Message-ID: <20261005150735.3034056-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100530-judicial-cilantro-08d1@gregkh>
References: <2026100530-judicial-cilantro-08d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit fd772af9512cdecb83de34a461801533828e77fd ]

dwc2_wakeup_detected() accesses the DWC2 host state and can rearm the
wakeup timer.  dwc2_hcd_free() currently deletes the timer only after
freeing host-owned state, and timer_delete() does not synchronize a
callback or prevent it from being queued again.

Stop and shut down the timer in dwc2_hcd_release(), before the HCD
resources are freed.  This covers both the HCD initialization error path
and normal HCD removal.

Fixes: 7359d482eb4d ("staging: HCD files for the DWC2 driver")
Cc: stable <stable@kernel.org>
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260904065323.4047026-1-runyu.xiao@seu.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Adapted the timer_delete() removal to the existing del_timer() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index e0f84726f4b1d..5e71094a22b2f 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5082,14 +5082,13 @@ static void dwc2_hcd_free(struct dwc2_hsotg *hsotg)
 	}
 
 	cancel_work_sync(&hsotg->phy_reset_work);
-
-	del_timer(&hsotg->wkp_timer);
 }
 
 static void dwc2_hcd_release(struct dwc2_hsotg *hsotg)
 {
 	/* Turn off all host-specific interrupts */
 	dwc2_disable_host_interrupts(hsotg);
+	timer_shutdown_sync(&hsotg->wkp_timer);
 
 	dwc2_hcd_free(hsotg);
 }
-- 
2.53.0

