Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608393;
	b=fpXZk/jXtd2Fo8vq0JuSgE+NnIWXc/kZzzr/lWHOO5fidUYPd+RV54iZOWhfAzNUBmLe
	 NqcENF85OJ10WIgHY8tywtSuemYNx6e5Rioqv2GGSEf9rd1yocC95mq6rh/ID8oYDDOM1
	 Kd/3Q5G9FtyrBkr+otPc77YO5swp+dCp136RERPiwLBwJR0/S/4kQDBYIv12yDRQbuBKn
	 c+TQ4BD3otsjb1nK4UQHRiA7TFFayz8EOkkomBc0PYwfffkAtCt0oliRDuG+RldbeMn6E
	 LkNPwG/6oGr5f7HeCVtXykHWtXGAPzOCk3cAfixiP9atmdL454pd1Rx1X3z4Olf5k6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608393;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AqyJCwu6zwHp7lHX7mxbMkQMqIFhTeLi29BwNeRrFzo=;
	b=gxRbbTXo96A93xBzhbP01r9152LbTDlY1pwOS+bGm3z+Xcj/op7nandjD3MBRh6RoTBb
	 cbAoV3CXcdKZIB3xLTfeHjbItkuszIWRMfeTlTi5RpHnv6yFAgBvMmykPn44UZCMO8UOt
	 lBHJm2xX6JX7smEGoUR1ymTVNSa0Fec66o3pEcgcTll6pFN4K/IsKSWhM29LwUE6KUevP
	 d7xuEZjLYxVieNTU5LF8x6hOcAxToKUfs0rH/MpcFvGp3C6HbsOxfkEy4oqyXWQ6DrnIw
	 c8w4U/8LRBzWhWW7ADGgUueDd8q0LxlvYzhwAHnByX1KG9vX+I1d6zYBjAc40G/CnEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=D5pJCo0X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98200606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=D5pJCo0X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8D71F000C0;
	Wed, 25 Nov 2026 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608393;
	bh=AqyJCwu6zwHp7lHX7mxbMkQMqIFhTeLi29BwNeRrFzo=;
	h=Subject:To:Cc:From:Date;
	b=D5pJCo0XRGCvdQoHHJg/UW4E5AtzYFibWBvSJeXvcQ3xcZqso80OKgHhdCQFnLdu5
	 Ag1Xu/MlO+fGC4e1pVVxb/CUpt9zAmeRvXhr/fqpId40t2PlowhixgJxJl6uNp88u2
	 +gbKj4B5hzCt4ylTDvrXtwTXXbLFdnt1VrHyjX2g=
Subject: FAILED: patch "[PATCH] usb: xhci: disable the correct slot on alloc_dev failure" failed to apply to 6.1-stable tree
To: raoxu@uniontech.com,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com,niklas.neronin@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:35:04 +0100
Message-ID: <2026112503-encourage-croak-8fc9@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2f2fe3201029ffc215b46ac40a0a9587715bc43a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112503-encourage-croak-8fc9@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2f2fe3201029ffc215b46ac40a0a9587715bc43a Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Thu, 5 Nov 2026 19:51:03 +0200
Subject: [PATCH] usb: xhci: disable the correct slot on alloc_dev failure

xhci_alloc_dev() stores the Slot ID returned by the Enable Slot command
in the local slot_id variable.  udev->slot_id is updated only after
xhci_alloc_virt_device() succeeds.

If endpoint resource reservation or virtual device allocation fails
before that update, the error path passes udev->slot_id to
xhci_disable_and_free_slot().  During initial enumeration this is slot 0.
When reallocating a device whose virtual device is missing or belongs to
another usb_device, udev->slot_id may contain a stale Slot ID.
The newly enabled slot can therefore remain active, or the wrong slot can
be disabled.

Pass slot_id, which identifies the slot enabled by this invocation.
xhci_disable_and_free_slot() already handles a missing xhci->devs entry.

Fixes: 3ffbba9511b4 ("USB: xhci: Allocate and address USB devices")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Reviewed-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20261105175106.241182-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index b50a582be1fb..94da0268b7b3 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4301,7 +4301,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;
 
 disable_slot:
-	xhci_disable_and_free_slot(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, slot_id);
 
 	return 0;
 }

