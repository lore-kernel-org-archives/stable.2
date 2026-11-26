Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706674;
	b=UlhVVIDVlddngV4lH3sLHusewkE7FtrebysUkyDekVD/Yoyf8/bzIOVgjRF45Kxleiyt
	 oDA7E3xytwLyE6ExeAgvxaTGYKDd9rV7RcaUDddL2mpI4WhoyvwNWffQdybGF2FE8D8ni
	 Z+LV3T5ePAWpLyCEAkMAvpLRhgLed+RjDeHebC4TOOfhiV611BJrKxSAGGk/OpVdAD5uK
	 NkPrJHmk4w/eEiXcukfvvPN/UJ4+dGy0UguTCa+qd6y9CskQ/Rec3ShPqRNfEAoDmRJ4I
	 j4/dY/oPCkFfhq3xdqvUDzXhbPwo4zVBhRQXhqLem4E8njz4c64UB0K85deq75dTtjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706674;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y9UcaA1g/wjFXuk4eqs6og2p2EeDDYpv2Bfpt/KxEdE=;
	b=vMqEXPjCZ3jNjd4+5dtC7T1rT35HeA9IH6ZigDWGfggkrPIzvJ8YnvFfvbmBBQvewQUW
	 Wk8g+j/y6CgRANe3wp+IXkPGIX/erZHsN2G8E8DWEVC3EEj+zWxndOVlUMsOzLPUzkuJ+
	 htZ7uRXM7xCJ2tq49eM9Yvfo5R4Sd1pmkLVbjVrv0Soy3xQj82IMh4V29ngFr9zUazrxZ
	 qivyQM/v9R8egv93Vp+focMoTC0NaY76Xy5zGIYPendC/jeCrjoTostHDEoCvIAwYQPBj
	 HmQe410AIRaLGaAgCILVGUaBbRsaP7byDy+65Vh2vfTkWNiKz1XlITOipalX2Y+3fIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xo8db0R0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2EF606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xo8db0R0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2770A1F000D4;
	Thu, 26 Nov 2026 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706673;
	bh=Y9UcaA1g/wjFXuk4eqs6og2p2EeDDYpv2Bfpt/KxEdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xo8db0R0rYaAw7jtqe8UDWAVQBN5rJVaAp3xXLFq44d0QY34bldaLHVpg9fNoKLuz
	 YMLU6p7/UNGcU31VWlCXaggRnAZNDxp1MeG1Dz9tRoCV2064Hbt4k/7NQyRSuQjNxZ
	 Jen07IVS0Uxn3KN/AdQUmzW2Fs3rHAhm5Q9D57iGuy5Gaa9VVoMdvn/fLEmF0ScaVo
	 SmwN0lkBw3O/PwyE9W2nWN563K9lPBf00DQQbyAzGqZSX1FAek5+gDUtZghlRP4xkF
	 5aAE1p6YBKZWcODTZ/iCJGmICQ3WIXITOZg9IYBbgPjuH1Uh4xKpMc/ZhpQRYpH4pk
	 TJz44zxtMxQgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Rao <raoxu@uniontech.com>,
	Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: xhci: disable the correct slot on alloc_dev failure
Date: Thu, 26 Nov 2026 10:24:31 -0500
Message-ID: <20261126152425.2446726-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112504-eel-tutu-bd44@gregkh>
References: <2026112504-eel-tutu-bd44@gregkh>
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
index 36b6dc304e79e..0b9b865c734d3 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4208,7 +4208,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;
 
 disable_slot:
-	xhci_disable_and_free_slot(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, slot_id);
 
 	return 0;
 }
-- 
2.53.0

