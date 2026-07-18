Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9AD3451B3
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411419; cv=none; b=X12QfQvMsdkLnOCcPsRwg3dv64vGmhr18R1EGiDY3a9GB9r6CwI3o5q2cE0J8FFVQddFTnN3+6rY2wmK5lonW3gFW+ZuBQoD9DWVb+qUJvQn+dmcLo7TpMB+46uc67hVq2tYndCxYMt8fjenm7OR/R+LC8b6JxElP1+Njp59vVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411419; c=relaxed/simple;
	bh=Gg/8YmmnWeqdk2O0vZz9PrUzWfKSnnVUnfxRyDv0t5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmNMjTNdSo4KRW2xYn3xCAIJLes0f4QeVj0+251ozG4dB1j7iMqWyfdC4y5ZhSWzUPjXbfmWX3/usBW2Kwv2Yh5JxLtyNo3PW2DJYIw7eNxWt80TZT6FfKGjPfI5gXMmPki59H83JBqEvCMec0bwAK95AWVFcHevFj4tyC66k+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJwUNQzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJwUNQzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652FB1F00A3A;
	Sat, 18 Jul 2026 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784411418;
	bh=DJyVpYjy5OZy6erdw1xPn/7LB6hAA2XpxHJkRCbixVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nJwUNQzG4D8iQQr2yb7wsUTY6rU3Hitk6JCiH8lsiwQaFbVxOnIFYn2/vsOnmx5vw
	 3yCn6MXdBReqO+ouf8CRJb+zI44VV5nNEr1oMuRuQfjBanoNB+dGUbt/+wRa8pjCHZ
	 NVpejrChnLIdnTIaQ/TwKV/9puP/jYw9QgbxrbzZJTLE6FRA2mu1jUB8lJghm8kM8O
	 cZu05OFP1cUYknPMJbLnD1GDGyUg/BEQQocTtQil3HFrwoDRvSj3K1P8DNS7kmLotm
	 ieK1ph4/gR7KeCWXnWtIC8PqDrNWxkfZd4R1SbYavcVTCTCgmk35l9EjQkkP92J8bW
	 E6vYKrVVXVPAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] usb: dwc3: fix dwc3_readl() and dwc3_writel() calls in dwc3_ulpi_setup()
Date: Sat, 18 Jul 2026 17:50:15 -0400
Message-ID: <20260718215015.3447229-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718215015.3447229-1-sashal@kernel.org>
References: <2026071411-expose-starless-4335@gregkh>
 <20260718215015.3447229-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit e0f844d9d74200d311c6438a0f04270834ba5365 ]

The dwc3_ulpi_setup() calls the register read and write calls with
dwc3->regs when both these calls take the dwc3 structure directly.

Chnage these two calls to fix the following sparse warning, and
possibly a nasty bug in the dwc3_ulpi_setup() code:

drivers/usb/dwc3/core.c:796:45: warning: incorrect type in argument 1 (different address spaces)
drivers/usb/dwc3/core.c:796:45:    expected struct dwc3 *dwc
drivers/usb/dwc3/core.c:796:45:    got void [noderef] __iomem *regs
drivers/usb/dwc3/core.c:798:40: warning: incorrect type in argument 1 (different address spaces)
drivers/usb/dwc3/core.c:798:40:    expected struct dwc3 *dwc
drivers/usb/dwc3/core.c:798:40:    got void [noderef] __iomem *regs

Cc: stable <stable@kernel.org>
Fixes: 9accc68b1cf0 ("usb: dwc3: Add dwc pointer to dwc3_readl/writel")
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Link: https://patch.msgid.link/20260703162033.2847599-1-ben.dooks@codethink.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6fda6adbca18ae..f0a9bb5754a393 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -792,9 +792,9 @@ static void dwc3_ulpi_setup(struct dwc3 *dwc)
 
 	if (dwc->enable_usb2_transceiver_delay) {
 		for (index = 0; index < dwc->num_usb2_ports; index++) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
+			reg = dwc3_readl(dwc, DWC3_GUSB2PHYCFG(index));
 			reg |= DWC3_GUSB2PHYCFG_XCVRDLY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
+			dwc3_writel(dwc, DWC3_GUSB2PHYCFG(index), reg);
 		}
 	}
 }
-- 
2.53.0

