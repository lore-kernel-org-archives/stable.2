Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291EF4E56DB
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449991; cv=none; b=pUQvBR2Byh5ig8i4Cw2Frd91S6vlCz6DXyUYU1hvXeP7X7ROVc9ONfUO/+AHaq7V3ah3A64ITgp4ICZ+f2HVH1blRoT182cDR5iKUE6L2Sdpd6g5+b3W6SHOBx9Dk7P/tBQT3aPTOjAze7CJF//bzzi1Y/xx8Rb83h2+bmcjtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449991; c=relaxed/simple;
	bh=EdgobFxrg1P65Qnr5elE80ruHcdtNIH/NSktOOzx6qs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sWdqTSUkKnhVAr8OVegDJCeKFQQkaLr6XEGXOpP2tJBHpW2nlAINtphRhfwL6WWtLPXUltOPjPqILHlSf3KdLYfTBRdN5iYj+SxAENaU5IxWNSlSenfVwEOnUogxSaUAiQG8DV5J8mj8afE2lHb2bRbc43JK+ElXUcgDhmDHLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XSVa3fYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XSVa3fYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F8E1F000E9;
	Thu,  3 Sep 2026 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449990;
	bh=M1G+zKYJkFGfktI4aoc0KDDoVtP5oaaJ3LYnVtTb1b0=;
	h=Subject:To:Cc:From:Date;
	b=XSVa3fYCLEKHA0IZuPR/nuKbeVCY4+8i3VZFx2cgoxYQaMnMAqFNEtMlCJ3fXCWO5
	 mmsZkM2l1W2SJeur/t+KBDary7zdBBRR4pohQQOH2gp+cH6+LIV2UWZ14lc8w+7p7v
	 2PrdSwoTdH/nNPwuEVjtDoC6YR1oeo7YJq6jepE8=
Subject: FAILED: patch "[PATCH] mfd: sm501: Fix potential memory leaks during remove" failed to apply to 6.6-stable tree
To: nihaal@cse.iitm.ac.in,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:12:51 +0200
Message-ID: <2026090351-moistness-unmoral-5211@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 83feedd9d83c0c5199f98c72df0a6196b4aefb4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090351-moistness-unmoral-5211@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83feedd9d83c0c5199f98c72df0a6196b4aefb4d Mon Sep 17 00:00:00 2001
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Mon, 20 Jul 2026 17:08:32 +0530
Subject: [PATCH] mfd: sm501: Fix potential memory leaks during remove

The memory allocated for struct sm501_devdata in sm501_pci_probe() and
sm501_plat_probe() is not freed by the corresponding remove functions
sm501_pci_remove() and sm501_plat_remove(). Fix that by adding a call to
kfree().

Fixes: b6d6454fdb66 ("[PATCH] mfd: SM501 core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Link: https://patch.msgid.link/20260720113836.73133-1-nihaal@cse.iitm.ac.in
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index b5bda477ebfc..77888965d91e 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1627,6 +1627,7 @@ static void sm501_pci_remove(struct pci_dev *dev)
 	release_mem_region(sm->io_res->start, 0x100);
 
 	pci_disable_device(dev);
+	kfree(sm);
 }
 
 static void sm501_plat_remove(struct platform_device *dev)
@@ -1637,6 +1638,7 @@ static void sm501_plat_remove(struct platform_device *dev)
 	iounmap(sm->regs);
 
 	release_mem_region(sm->io_res->start, 0x100);
+	kfree(sm);
 }
 
 static const struct pci_device_id sm501_pci_tbl[] = {

