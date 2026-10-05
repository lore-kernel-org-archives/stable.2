Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059A4D9F98
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220557; cv=none; b=CtKo81diZ9GVSrysoLnZ0uQiyae0clSz1EDLEjTzGR1O1pk1UFT6WF1btEy7SESpjr/PRF2BNpdYUBcJFio91RJYGNTZ0Ib6EpH7ORaI1XC9pJBnwiLkAUy4YnzmgzKcJrexqJ3/yZDsABVKY+Df8aO7SB/YFQoFa6HLInNLtIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220557; c=relaxed/simple;
	bh=PYUm2W4iryswFoWs//88x+Y0nB/JvJWH+nzAA5FemE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGpqosEs8xCkEfGZTKhV3XgIsSXzXnSxwwrs8aqGSoAODnlXHdHrEUFaNWNBd5wXlFbGJ+wTf2yP00lNAWq3p3hUEvQ0JQvtPNMv0+WIK5s9pazbxIzLvmixqK77NiglKRiGE0KLPbWJbDa4CoCCaysaeAARSD3AbkaJou8DUdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm8OGDCr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm8OGDCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F091F0089D;
	Mon,  5 Oct 2026 17:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791220556;
	bh=vnInZsNq2i56hOZLPMOBq4CPqUx87O2/Q4/djY7+j78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nm8OGDCr1H5fMZgWfCalkMWlH4kKq5+92v5uhXGMs1jQkSbk9RX0fuQ1RsX8mDKUc
	 /caW8SMP5X6/vHq7sYG4tTuMJXZnfqf4VXtksMKT9OP8uMILqgCI8cZNp7BsdBdw5f
	 irItqeTgDyLY4iXtMLiwR5q2r/6/qbjaBaThyPsQKmqzhCce6cHa65J/vH2aYiP2BA
	 nVuMNMcS7HnGl5bNeVLeQrrWRsKnPnwcuimzs98WNI6VR7KWrO8qhYsl7n9Gfod8nU
	 7Iws5H9f92s0OJHvZJMSYcTeJq0Ye7DBbC0oomLW9WRVNRYj8ZVBrVOzXOjqzwJwl0
	 kDSOms/A9AC4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] USB: dwc2: shut down wakeup timer before freeing HCD state
Date: Mon,  5 Oct 2026 13:15:51 -0400
Message-ID: <20261005171430.3062975-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100531-stamp-citable-47a4@gregkh>
References: <2026100531-stamp-citable-47a4@gregkh>
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
[ sashal: Adapted the timer removal hunk to match del_timer() instead of timer_delete(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 109b02830d882..cfc02759f4921 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5115,14 +5115,13 @@ static void dwc2_hcd_free(struct dwc2_hsotg *hsotg)
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

