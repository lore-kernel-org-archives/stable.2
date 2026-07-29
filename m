Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A6485CF6
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329630; cv=none; b=i0QmqUdCjSZgPKbFhw1DIvXvXLmesBdSrWM0v4bhynDP1NMD/Q1/TkpU/mQ6hyqST5GA+g6KPHGdo4OCwPIz0edC0j+wwlt/zh7f6OuA5In3xqBnTBcWV7AOe1os0FcsjR9ImHn1oGdYb/Xg5J/YDPnRSwPqQb43ntqN/KQOXPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329630; c=relaxed/simple;
	bh=orpuw/qqu5z3L4K2mzsraNaCg2d8f3AgULysoVrJB3M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pv0z5lxHSRJ1J4tp8JJLLYxhIs9l4uNb20+tDC4mLdh+zFIKp8dN35bt1rQP6R8J1KPS8c9rGPASNbUCfO2A2shMmheaoySVUnDSq7SqEWaoUqtGEVIlqgnnWcygtKiScdrXujH8BjAsV6I4NAM4PcewhAlIKzEorNwmpqZ/VW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hFgVXQ4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hFgVXQ4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E121F000E9;
	Wed, 29 Jul 2026 12:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329624;
	bh=22nb8ygF16vR4oYLBG8h2hYTaSVg216977LCqcHNsHs=;
	h=Subject:To:Cc:From:Date;
	b=hFgVXQ4Y6BcPF9PQax0nkVRQGTy9+ETXvyu9PnvlCA54zRkH0T7AA+bgkZM7q0Ksp
	 SSvInnIJEDAT0Rgnv6XxqDpTQ+t3/UfU0YUloYTHFXFgb/M/BkzACzaZBRPRx5IYh9
	 bwi+YeJxRcAmp4HGHFomAI3wjVqZnMt4XgJJ81jk=
Subject: FAILED: patch "[PATCH] media: marvell-cam: fix missing pci_disable_device() on" failed to apply to 5.15-stable tree
To: lgs201920130244@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:53:30 +0200
Message-ID: <2026072930-finally-subtype-79f3@gregkh>
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
git cherry-pick -x 033ff0420e4c9c240ae5523fff39770298efa964
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072930-finally-subtype-79f3@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

