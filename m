Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21194E2366
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449996; cv=none; b=W/EPPl9I6TpfOltiSFKyJ3WNBiW+z0tbmTySB0Odh8P2VDGBOwf1ukRR4SNqWPh0UwZ5U0pCTt/wWUOKBmxOSpOz3TMxn7mTfaHWF0HoL/IrEzBC+1ArNOK2HjFn2prmtL8xOOofKXc5CxHpLOI4SB37DXVEguM1YPWZ/8yZ8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449996; c=relaxed/simple;
	bh=6KaK7yvzjmGdk30sWO6Pk7DsMcyMubnLsDbxoLYokJA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P8OVwIKGHqzSlBKyozloGDSgBYRyd48bolErzvqZ6VST7Gf6nqzXF6o2ekzNdgLkhQk50w+e93HvlQZBwAtFscYfKyk+tK1rtOFDU0fEcWnrfHAdc46ZVSqO96wSm66xB4RD+iyz/Byx/0RIpg18endBx3rEgCUsEcf9niamYT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R2t3rIKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R2t3rIKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3151F000E9;
	Thu,  3 Sep 2026 15:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449995;
	bh=YUSKe3TRh7TLO5QoYZEPbWA5HgZ+h2NRRYnN6My2R58=;
	h=Subject:To:Cc:From:Date;
	b=R2t3rIKLmTB7WaHr2GKWUMxOVIQm/BIe/Iy87x5UmNLUvS1To5YlKl/f/viFE5uVf
	 UfHD2+/p8OYARwZFZHrLvUHzsMO5O1cVNcQwYjSA8OUbJD3qXh0Cck6jz/6dcb1yNr
	 p8nQngGxo+cu6df49Wc7JYCW6DXtbUWeKOfed7Hg=
Subject: FAILED: patch "[PATCH] mfd: sm501: Fix potential memory leaks during remove" failed to apply to 5.15-stable tree
To: nihaal@cse.iitm.ac.in,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:12:52 +0200
Message-ID: <2026090352-reptile-skyline-e58f@gregkh>
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
git cherry-pick -x 83feedd9d83c0c5199f98c72df0a6196b4aefb4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090352-reptile-skyline-e58f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

