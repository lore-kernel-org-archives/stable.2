Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951852ED35
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951643; cv=none; b=fQQ57DxSx84OInA/ri+7VTRWggdKymAqr1PGp+mS6wU/yLC5+46W36sjvibbY0XZV68m9vwfm6nmkJ6XtgoQvXiYKKRRs4WSXTPfScxSbYWOk7AUFXHiED9WkQ4qD5hdhw6KDMlwKf4af3H3fIEZZlLg5Oryl3F12wq9RPhOauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951643; c=relaxed/simple;
	bh=qqKi/WDtOPXhzHa3hsNmIoKtLgxI7Hi8lYwh9QilOYA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eYmY0WLrUR6VE7jq993B8zNR01W8foSAF8nIT0IBqqf9LPSVEosYZJbjPBbvD80ee2SYpna5HAYZW0cC7sOGSrDwATFW0L708VwU/DCP9luMzd/j7ch1r1lTQFi1qeToPB5C2IDrWTc0b1Ikn5b/84ZVeDky5N7/TPUqTWpp91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w/mRmp8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w/mRmp8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D163D1F00A3D;
	Wed,  9 Sep 2026 11:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788951640;
	bh=nCwui7yLzY89xVNr8OjrfjC8+p1LypyRC07eaZAEcS4=;
	h=Subject:To:Cc:From:Date;
	b=w/mRmp8Bo4xPkVz6PPhYEgxIYZQbxPcO4vHq/J4c0VCiLWOB32iH45cfT56nZNiP0
	 GvjXPXP6vm+JL4xGjgBrmBbixLVoRJWs6aDmUp6d2TJh3B54e+8iV4r2X/QGE99dAm
	 LqFcs1dpQ3mzjwp1B16qgD4E1hmDOig+tuNpwt7M=
Subject: FAILED: patch "[PATCH] media: saa7164: fix cleanup on resource allocation failure" failed to apply to 5.10-stable tree
To: lgs201920130244@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:50:52 +0200
Message-ID: <2026090952-skeletal-related-3a42@gregkh>
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
git cherry-pick -x 28e84c6e2e6753ed238ea097b2842a32a6a6879b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090952-skeletal-related-3a42@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 28e84c6e2e6753ed238ea097b2842a32a6a6879b Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 18 Jul 2026 14:10:11 +0800
Subject: [PATCH] media: saa7164: fix cleanup on resource allocation failure

saa7164_dev_setup() adds the device to the global saa7164_devlist before
requesting the PCI BAR memory regions.

If get_resources() fails, saa7164_dev_setup() decrements the device count
and returns an error, but leaves the device on saa7164_devlist. The probe
error path then frees the device, leaving a dangling entry on the global
list.

Reuse the existing MMIO mapping error path to remove the device from
saa7164_devlist and decrement the device count before returning.

Also release BAR0 if it was successfully requested but the BAR2 request
fails.

Fixes: 443c1228d505 ("V4L/DVB (12923): SAA7164: Add support for the NXP SAA7164 silicon")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index 683bd78288b3..ac5eb6b923e2 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -878,6 +878,9 @@ static int get_resources(struct saa7164_dev *dev)
 		if (request_mem_region(pci_resource_start(dev->pci, 2),
 			pci_resource_len(dev->pci, 2), dev->name))
 			return 0;
+
+		release_mem_region(pci_resource_start(dev->pci, 0),
+				   pci_resource_len(dev->pci, 0));
 	}
 
 	printk(KERN_ERR "%s: can't get MMIO memory @ 0x%llx or 0x%llx\n",
@@ -1000,8 +1003,7 @@ static int saa7164_dev_setup(struct saa7164_dev *dev)
 		       dev->name, dev->pci->subsystem_vendor,
 		       dev->pci->subsystem_device);
 
-		saa7164_devcount--;
-		return -ENODEV;
+		goto err_devlist;
 	}
 
 	/* PCI/e allocations */
@@ -1039,7 +1041,7 @@ static int saa7164_dev_setup(struct saa7164_dev *dev)
 	iounmap(dev->lmmio);
 err_ioremap_bar0:
 	release_resources(dev);
-
+err_devlist:
 	scoped_guard(mutex, &devlist) {
 		list_del(&dev->devlist);
 	}

