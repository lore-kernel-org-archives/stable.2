Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706545;
	b=e4iETF8nHvP5AGwAqS0wf4phKwZ8o+uQxpgHxJJ83z6kgYwqZFnxvn9UoHk6ipLLz44i
	 U407t2OJOeJkuV3kVJEKTeBbVWbebydNl95HnHBXQGH6egNTvCugh6Qkw53ECcThCRdhQ
	 tfj+L0DM+0k5tlsLMiX/XDveujvQIdpy83H3PdO8FP4FlZNPThj7zbA0iXpsYu2zbx8xz
	 NaToP9D5EIremIR9wRYTKVbSHJaIf9c+dOrDn6VersC4PHP0fm+Ad6Rls6CM2xOQa4hXi
	 aCucY6fr1wnV+4lunucm0PzPx99pMYVeE5Tdf1AO7XSU3PSii6isuomPc6tazkfdkzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706545;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ltvcXCD8wi0hdjVDqrs7BtjcA/G+xW1vaVlz09XJn/s=;
	b=zo0mWkBgP2ZgL2nRueKUktgbNUz8qbaz72S1aPIYu9KG2X5yn6yECZ1ebTVburhNW7EX
	 T4vYmW8XIt2PDS8yr977bO22g9zLz/CATCeYLt/2dHLoF3vmiWjDvUVcR9WuUWV6fvtaa
	 Th/dJR8XWI26mx57Qm04wO71T7jxAvXlgbG3nFvn2Wr04VDGjVOHXu3c6i8DjlTwV7M0+
	 OaCv6K4xnTlF/LXFKBXPvP4EG1iNTx9ouZxIeTqIA6RqJ6Zp7hiIo8vMjZ6cNeHMSNXYs
	 V/fZahS52mHin69GkoclNug6MLgXivJANS2L/olKR+Dz2JxkeWQ3AK5eVMKl1PW4TVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDol2RFu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AA8606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FDol2RFu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB9E1F000C6;
	Thu, 26 Nov 2026 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706545;
	bh=ltvcXCD8wi0hdjVDqrs7BtjcA/G+xW1vaVlz09XJn/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FDol2RFuVmCw0JfUW6wrlMYLSPs80neKXhlT8jarV6wVOklWy5+qjbPBj31c32knU
	 o4qZ7TAG80xwO5eRsQRA9+M9bLGpaIpSi0ZEsYoXHnX+nCo+CAFSzCfNEo3W3qK/km
	 3W6VZR3O47cnLuH7DMSMtqK1vZQXlkolLqShCgYbK+Ohb9Z2TYjtnLe7wJ+XxLjOaE
	 ckJdBy2Bw/Xc9UiBOjlwR7MHvbC4Dx9QfyI/wtKJOebjpOUT8oGrIrCyK/EL/Ux4nh
	 ZsWwTIZ51Mx6WUCQrTo3dVBPkpVMCGwpP7+1Te2tmqNHVE/Z7l4b0ogRGvVZFpPrVD
	 Asp/9Wr2CyGdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: xhci: disable the correct slot on alloc_dev failure
Date: Thu, 26 Nov 2026 10:22:23 -0500
Message-ID: <20261126151529.2356364-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112503-encourage-croak-8fc9@gregkh>
References: <2026112503-encourage-croak-8fc9@gregkh>
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
[ sashal: Replaced udev->slot_id with the local slot_id in both the xhci_disable_slot() and xhci_free_virt_device() calls, since this tree has no xhci_disable_and_free_slot() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6cfc8205d10db..7e137f671e056 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4210,8 +4210,8 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;
 
 disable_slot:
-	xhci_disable_slot(xhci, udev->slot_id);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_disable_slot(xhci, slot_id);
+	xhci_free_virt_device(xhci, slot_id);
 
 	return 0;
 }
-- 
2.53.0

