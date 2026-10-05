Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95913492515
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217102; cv=none; b=d6L6ek6p3rF17iMqPQe614h0ONMFbpQSu1uJblnZkGOs8bCVhxBtA3/l9tsAN+FSFANcEybkp7+OpmNLBzUzPOgTJ05HdgAipmvHXluEMRo5h5ffoSbWdqv4L2wvq2igrKZ+Cw2ZoG4eU4OH2+sf+y+bJeU25pcHdF+8B7NcoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217102; c=relaxed/simple;
	bh=NSKBXJE1uysr4fJgA06YkJK3w64NoS8UkJnbPtNFDI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7wlryfbH+7HEEiEySenfkn48sVhtyCIgcM4Sx6A5BNYbpk4Ui80iI6i4DzEy56rOGDawurw36FHSlfzhHDIeIO6iEjQPtDzv79B+WznfmFu9OtdalcDcDwwVo2qF4JaZoXe5OkCes+18RDOlAGylmvulQGdX1MXcGCI2JSIhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTLtOef+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTLtOef+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E471F00898;
	Mon,  5 Oct 2026 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791217101;
	bh=jcw7y/bCc1Jbote5jmDv++4QE85AQyVAxf/tf8pIjHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NTLtOef+GRD6Jlz9NarCD3d+r4qz35+xm0tCAYF9nuWu9TyrbhoHUXcCrqkrWZB1b
	 Ll4Lajwsazw1m3ZkEdrWHiOwwsuEPFk+QxYPMsd93DQrCXygZVqHOVf7Q273+pUi28
	 PAbxkSH1youreia8G71g9Vn13w7gt3g5wHftG4S4d+QV681JSCYUI2nR3xmsnQ4K7p
	 xOUiLbb58ffjeGK43i3wFsh7d80lufJXU66e8D+6IiJFO6E+0L9sl/J6xds18MwHMi
	 C119ScOsxMETe0Mjh0GzHecMgmuVyqtXKjAKSqVaqX5swtVyAfTcqcucgph37UKjsm
	 cktlDBcKSq+Hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] USB: dwc2: shut down wakeup timer before freeing HCD state
Date: Mon,  5 Oct 2026 12:18:17 -0400
Message-ID: <20261005161722.3048291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100530-bubbly-straddle-1724@gregkh>
References: <2026100530-bubbly-straddle-1724@gregkh>
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
[ sashal: adapted timer_delete() removal to the existing del_timer() call ]
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

