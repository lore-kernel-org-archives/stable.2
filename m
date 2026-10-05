Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1AA4BB269
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212487; cv=none; b=eYFH2KGYhlmq3/ZSHkZkarBowgI8eTtk6wjqFtHsgnwxe+bd4xV7w7WPVVPWL8bSlhsAaTr4/+yDIOrugEhZ11FPSDy83oXX+ONrjSydzAEU6DgoVmO+jkkPZRZ86/niOax8mU83CKTnO3f4rKxTXYEF1mnQZAkL6q6mbddw01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212487; c=relaxed/simple;
	bh=PYxDq9ZLjxExwrlGWes3Hj4p4mkLfcmtAZqZSOKR63A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKtdR4wxHDCrRxb3DokyaIM1JvukDoLHckCbwI+bCzLQVkZ9DHnprgltx8Wlo2r88N4GeOVflR21seZA0yt4gcvABeDhcXetE36xT+qLJrpbDpMj8SXCVHZQedee46ovnNixNbnlMEhnmH/1D8w0O87W2NeRpdODXA81ehhAQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNzQSJGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNzQSJGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2771F00893;
	Mon,  5 Oct 2026 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212486;
	bh=GvGys+840Ioy72hMoOoUWVXuRxL00UVDpK5RXyWB69Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JNzQSJGEwXGJvhKtvK4SKjSz5iYmME2pkJdLgvSrPUQYcuVyQSDykHCq45QuEznIu
	 VqiUV+4WGIl37JaWUF/eFgPB59g26RkEK7TuK5DkH1CgvNiBTSkEPsTOd08Ql/aRrx
	 +l7Q8qvsHMTTWsqEeEDXDyTbr4YaZVdyqVQzFlZtvH4EzWp6CNvFylKbZfnWPLDXJw
	 PkseJ8l+/sHLJ0t03HIC+CWydJTOgSIP+xLf/vue7z7FzhVW9XlMhdX49f7ERErw9r
	 k2CCoukM8q9p93xibAU3S/aWVL/d5BxthtxJtBaSbjb7xmy7qE5/L26xRkAn3bzKbr
	 q2lSTNB3umPyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] usb: ohci-spear: Remove unnecessary NULL check before clk_disable_unprepare()
Date: Mon,  5 Oct 2026 11:01:22 -0400
Message-ID: <20261005150047.3034266-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100502-tarot-unseemly-0676@gregkh>
References: <2026100502-tarot-unseemly-0676@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit a891b9aebcc7406fe2f439d184bac3948fb08645 ]

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for clk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20250617042050.1930940-1-nichen@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b1b0f8bdbbc8 ("usb: ohci-spear: disable controller wakeup on removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-spear.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 196951a27f3f2..0f646c35ca737 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -104,8 +104,7 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
-	if (sohci_p->clk)
-		clk_disable_unprepare(sohci_p->clk);
+	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
 	return 0;
-- 
2.53.0

