Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D436EAA4
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194557; cv=none; b=EUp0+cyblomZlBEWSKz3pZZtcf0lA6Vg1gT4tmAWXtDSwlm17rRLCFLxNmYHasVjYA2kJCUa9nd5TLtpW1Lg8tULJrvUP52lPL3VGcqmSffFjrZI87M4tz3Xcch5nJJfBAzX+EJBbpMLXz6m3A9LAzgOWESeQy8yuSgNh7AT0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194557; c=relaxed/simple;
	bh=J1sxLQc17xAurTJpFWZnVc73rx07IK1ldB3Kn1xxphY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hm/NOKJOjElbgMwcpz/HXjeDemJjXNGiEQHYC0KRfq+HvitJb/vScozgbtELPL4HxYOxUmXDDNNBjoJ4oxOgOsUhFYDvLs5TyXQJjJbzbwRKLDdMkCnf4wJ/SjPaZ+rJ9TiTScVXOP6rxp5Ntiobyx/Vm5X6xIyPFlgnIYjoDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV5TsjGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV5TsjGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4261F00A3D;
	Mon, 31 Aug 2026 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788194556;
	bh=akJvsHfE4OtjPQsuwzj9J6+j2s3s/6GPEdx10lF4oW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EV5TsjGREgbpoydMEhn/CRaMkvTEZjlCQUn85UrzeuuwVmX2GvQVVUETFMwOO86xw
	 R4NXxKcCmhD83ktIfNZeNkdrZLifXAR4zk/+w14FrtQkQFdsOQzafQuo5niwQ+lxnZ
	 tGPsP9qiey9soMqXbln8XaQ5tDxRHKTUP5dF2MsBdszI9WTQVYt3XAUCAgOpn3iOe0
	 RKphNz9Uc3ojCHmDP3jmuKI8KsQKNiJaMkA4q0NYMpB+cZ7VM5PHkgh8lDSi3mHQnZ
	 PvDtRcot0Q15CtaXi35n9hKu2d28o0EE7RntMS0tO2eXTwoyPlBv9mzX+tVcVxyrFu
	 UWTYbMSRxmTUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] usb: xhci: use cached HCSPARAMS1 value
Date: Mon, 31 Aug 2026 12:42:31 -0400
Message-ID: <20260831164233.269066-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831164233.269066-1-sashal@kernel.org>
References: <2026083120-autism-gerbil-efbb@gregkh>
 <20260831164233.269066-1-sashal@kernel.org>
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
index a50e813dda13a..70b7c97e615ff 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4040,8 +4040,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
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

