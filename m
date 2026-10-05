Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFACD4B203D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211798; cv=none; b=Fs2tvZoGRq1ICOr6l49LabgYGWWH4q0IR5nD0fZgPtZjRU50KWvFoVMOSrQG4kJC0x5UPSzyHA8d3hZtZIDDvFVTS5Ob8efRNX4tzUa+kxJQsiQiHaC0E/J8wNsdFA/7ZNRRQt/qdZ90UtOyRpA5awJQ7S5k73OnTaCjtBc+NjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211798; c=relaxed/simple;
	bh=9SAUC5VVXd45dPcOrcjEaw6vjzvcEWzb1Fzhb0LJW9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1NL0gS56wbU307no/HSsXZpBXomEuN99AdmatlNnkpfRmAgcJaeWMxjcbfdQWzecGsacDHJpBFV3/Kig/L1XlT+SkOBFHUU+0ksEvFfimzQPo6riP3rEVJmZYpp7S5BV4megdL8ssu/9Ah/tJ0coRv7PEMgOfa6KDgizhuc+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRp6kx6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRp6kx6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5F01F000FF;
	Mon,  5 Oct 2026 14:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791211790;
	bh=wZs2LfeiuxDBc8qoj8t3YWUuVdvrklZoTZPgJJAGQGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hRp6kx6AnAV/vcaZH2/ZwmimbLL98vJVLqJ2oYuZEyjTFCYEyD4RjuaHjvaayTX6P
	 bGqAdBe7kdrKRlIizBhTcCIhYESr964TlimGuhTo5vOC9XBMV/lLO5UkEJR7ZZyagf
	 FfpYFx5x9bbSArv7lVhinsldXyNUx3Fbv3vDJfV7txqjbG9t1lvs20xugEPn+IMPQ3
	 v9Yiiwqd0JxJbQJqoaczgurBmrQUp+XGd6gYSzQSaXg+9rK6U4hTSk44VO0zoPMUwr
	 uc26mZpHdp6LbUm7tv51U4D0cR7MenhUQGmXgdKPWCL9/beYyp1oDvCbnJtmXbVVA2
	 ki/CtmnC/GZ+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] USB: dwc2: shut down wakeup timer before freeing HCD state
Date: Mon,  5 Oct 2026 10:49:47 -0400
Message-ID: <20261005144911.3017046-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100529-serving-grandly-7f98@gregkh>
References: <2026100529-serving-grandly-7f98@gregkh>
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
[ sashal: Adapted timer_delete() removal to the existing del_timer() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 8e295f41fc13b..938b646c4b0f8 100644
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

