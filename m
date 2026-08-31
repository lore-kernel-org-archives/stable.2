Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B0439F7F
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182838; cv=none; b=qXZEJcvdQnr9k/urv+GnbPmuq1Pmq/tKVBqdkuK0exLOY+tN5x8l3KwMbhI5rlpQgOfY2eiUlVFbKJd0Fo3TwHUCzMhbIR2rQb8BGUAOBSPnMEFgYwr2eL3OnCaAVt0IgBdhKFmWDxySkZpv8YbmcxAePKbiLcH5GUCc1C4/ICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182838; c=relaxed/simple;
	bh=7GuXJw1QFNlmWmUneIkRpjOyQ6f/YliHBxsbL+JTqfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm1BEs3IYoGTmt6VB2Ar/TU4ShSU5LJWf8Y6xs9MQTOGtN96QMOQORZxwbd/KoKX28XtUF2XtuUR9grrGIoh0dxlCkXL+w6f1F9/aTwa4a18LGn6PVQRi+ZnRiaTjNMCCL6ZVuzuPZEabxhiJ3PwQ0gYIziHmpu6UEbQEAbJG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxqgMckH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxqgMckH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9851F00ACA;
	Mon, 31 Aug 2026 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182837;
	bh=onlt37FHbPEFvWl/gEJ42nPhpCAZCQoKOxYb4wI+ayw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XxqgMckH3kH/CK1ec30CTFhxDn4YPC0gvuUAO+3aXGaG54dmBDagr9muqmM/rpQwk
	 G7ZDfMXKtesiGOSbOztynC/LEvGK3aedx51qvEionFas+63CNrfVAGbRgL1CctjsfZ
	 KHxdJmsjMA5/tNx9fkABu0MGt/f/ywMUgR0cr8b8smUVHdb3oFj9+O072HgJFo04dm
	 7GLxICAYCHxV5bweZAfyJymetXC9XGNgA35VuXp+i1RblUIYWReHAx9qzrAVPquI/1
	 WGoOZrCIiaDby28NV6lvam2eg+wvHaQWY2LM62EgmLBmV3Fw111JaZjKFEa3qKFJWA
	 3p/xBYs2ukORQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/7] usb: xhci: use cached HCSPARAMS1 value
Date: Mon, 31 Aug 2026 09:27:07 -0400
Message-ID: <20260831132711.4043116-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831132711.4043116-1-sashal@kernel.org>
References: <2026083120-hatchling-fade-cf8e@gregkh>
 <20260831132711.4043116-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

[ Upstream commit 70651cc3f5a4c7cec529f121e36ea3b45ea84778 ]

The Structural Parameters 1 (HCSPARAMS1) register is read and cached in
'xhci->hcs_params1' during host controller initialization. Since this
register is read-only and its value remains constant for the lifetime of
the controller, re-reading it later is unnecessary.

Replace subsequent register reads with the cached 'xhci->hcs_params1'
value to avoid redundant MMIO access.

Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://patch.msgid.link/20251119142417.2820519-15-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 78203d5b54a4 ("usb: xhci: bail out of setup if the controller is inaccessible")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index aab2792be76da..4947a16c054e4 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4253,8 +4253,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 		xhci_err(xhci, "Error while assigning device slot ID: %s\n",
 			 xhci_trb_comp_code_string(command->status));
 		xhci_err(xhci, "Max number of devices this xHCI host supports is %u.\n",
-				HCS_MAX_SLOTS(
-					readl(&xhci->cap_regs->hcs_params1)));
+			 HCS_MAX_SLOTS(xhci->hcs_params1));
 		xhci_free_command(xhci, command);
 		return 0;
 	}
-- 
2.53.0

