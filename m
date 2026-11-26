Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706798;
	b=tVKgiYcXsAlUSca+oZJw/UiRrd37XL9nEz8Q1rxc8JZTypHkIvoYsAIM7VgOaiy16xyN
	 vNzah9n0rYqDFihVyTiyfU0IMLBFX1oX23vF77fwqgx5IFU5dwjG/7224wRGH7QHYZF0g
	 W6/kgEu2Mxu08qnfGFmjt0Q41cO8fjrKWd6nxzb+4/HaKAn807xnvHa+oTSpeu8GkpPCo
	 XLAL+KFYLO5RA0YPeFUxhToe4WHk2gOIqnkIgP6Mrb7BaNbqeneX+Z6/rqgVn79PlFDBR
	 HHuFJbG7I6pRle46wmBLPUCNUIbRFDkmy11vJ3Qc+SEupAm3SdDAuraZD7jIxfYi8TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QNWoh0njKIcOYtS3SAYL1rbDgC8ypBmeTdLcdBQ7McY=;
	b=N/7n93G3VA20r+s+L5LjF7PwRvHzUqrgTW95QvjfK2wHi7cu3Y1pCYoh6sFp2z+ALbJZ
	 cOFmd7CE5Ma5A9EQOkRxfyJ4fADghZ/2cjYzCq/f2Ixhf0eC3yD3tpG3IZK3kKkro339r
	 843v/k2nMbQg4i36YHFDnQGse/+N0XEsrR+pU6Tgl2niAENsWs02WIzJdvYEtua06lIyV
	 taKKipCTgLF12+5eO+l6ylZ8YM+2myOCZL+j1G+fyCke6GIiY9X1xPLTnWNhwEyCBWYPd
	 eoJn8tfDmxcRPWgZGdFzpwAM0BC3fqaKnMqm+At+ZvuXkwy1zlViL5h5AMvPbY5gxWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NugpYrnM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F42606A329
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NugpYrnM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3921F000CA;
	Thu, 26 Nov 2026 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706798;
	bh=QNWoh0njKIcOYtS3SAYL1rbDgC8ypBmeTdLcdBQ7McY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NugpYrnMHpBFfqLuQWJ/jc9cO9OtXROQa5dMe1JpOHxXj1RXRuxqNmrMakJ0+xX9M
	 GkxjFVhdjmqvI9sO7RxTgz4AfVql4+EdoBnvAKBAFcYNArdU44xMB/y5N2WZ4Nf3la
	 vIuk23DhizkpeQw5Y08s3JUicbP5CzsjjcnBMmZ/QhHgkO9xjxRWhBDIRjjsM1Cvh1
	 p9l+t1l84fQwpxFW8WrGW0DVazwEnXVvuVE/ryPA0lstmBEJxNx2AIJqMJbk1icxlx
	 LIDMBerln1wBsKSqB5jLRQ7Z/NAKaULNVzRwu9l1Cg/vayjfOpnM6XqAMs+tYuDwsA
	 KTAwb0GYXRhUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: xhci: disable the correct slot on alloc_dev failure
Date: Thu, 26 Nov 2026 10:26:36 -0500
Message-ID: <20261126152630.2452624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112504-tradition-brigade-4312@gregkh>
References: <2026112504-tradition-brigade-4312@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Rao <raoxu@uniontech.com>

[ Upstream commit 2f2fe3201029ffc215b46ac40a0a9587715bc43a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 4d3f13bd0313b..cad6fef014970 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4134,7 +4134,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;
 
 disable_slot:
-	xhci_disable_and_free_slot(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, slot_id);
 
 	return 0;
 }
-- 
2.53.0

