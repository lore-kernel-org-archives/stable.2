Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66FD485CD6
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329644; cv=none; b=Au13FT2KD06U5BLS6KE52AFauPkgFah8+ioIS2crMRZ2bgcJQ5O1l2LveAoKDTxYdhkf2J1COyOivtOYu1op/rlAHtEK9/b8d1VC44tTDkiV7/wb+RhO4ouaJlkijxGekHBVHP5HXNyx9n8e19d5qZY0zX5XLn8As+ykcBbxrK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329644; c=relaxed/simple;
	bh=f8t68v1jDRED+8HPe3FPgP7AO1Kb0QWvRkgfDnaSE4M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tav8s1uOKx3/SzpcTgRTRGWaOWRhGzXv6sZmZI8QOcrT9C4D74m0FmggtFU7dnIKbxx4PJGuOq3UGMqOzzO+qxgjoq1WwAG28OvkB/sndB0YOjennXQ1DUXOoI0BuD6365nYYgbsLblrnNLV5I22ouZTz99/HHm/KnqwqudgM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ogXQootc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ogXQootc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104131F000E9;
	Wed, 29 Jul 2026 12:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329632;
	bh=B76wxH0KsTM1j9cKan1ZnuKRbPmT2KAEBtsIMbmbRGY=;
	h=Subject:To:Cc:From:Date;
	b=ogXQootcAoP9Kn69jMW5RTwGPm2Knu8MyNDWZCYQyBVViDSIFduGZ83z01GlU6MQL
	 DY63XU9K/w0jiqv6hHwAeJciILHmu8iv5e6zwNp+ToicPeTolx5JQZkQy3xJJkyGiQ
	 PAXIt7OAIGMoi0clT5mJuSUAnxDoW0oOP8Oo9XAQ=
Subject: FAILED: patch "[PATCH] media: marvell-cam: fix missing pci_disable_device() on" failed to apply to 5.10-stable tree
To: lgs201920130244@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:53:31 +0200
Message-ID: <2026072931-shopping-hanky-ad2b@gregkh>
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
git cherry-pick -x 033ff0420e4c9c240ae5523fff39770298efa964
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072931-shopping-hanky-ad2b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 033ff0420e4c9c240ae5523fff39770298efa964 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 17 Apr 2026 14:53:30 +0800
Subject: [PATCH] media: marvell-cam: fix missing pci_disable_device() on
 remove

During manual code audit, we found that cafe_pci_probe() enables the
PCI device with pci_enable_device(), and its probe error path properly
calls pci_disable_device() on failure.

However, cafe_pci_remove() tears down the controller and frees the
driver data without disabling the PCI device, leaving the remove path
inconsistent with probe cleanup.

Add the missing pci_disable_device() call to cafe_pci_remove().

Fixes: abfa3df36c01 ("[media] marvell-cam: Separate out the Marvell camera core")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/marvell/cafe-driver.c b/drivers/media/platform/marvell/cafe-driver.c
index 632c15572aa8..22034df6cba9 100644
--- a/drivers/media/platform/marvell/cafe-driver.c
+++ b/drivers/media/platform/marvell/cafe-driver.c
@@ -609,6 +609,7 @@ static void cafe_pci_remove(struct pci_dev *pdev)
 		return;
 	}
 	cafe_shutdown(cam);
+	pci_disable_device(pdev);
 	kfree(cam);
 }
 

