Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E814AA1FB
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210633; cv=none; b=C6qOsfIX4ETRKHiU6OQBzDNSMc8ZuhsdVViFTznqBADoEkoEeDi8YuHvaPmXsuY2AsZQ0wcW9efbzHhu+MiY26HHTXdrdh0V3my8D3vDtsgtcMM1f0UyzaYTgXuJVoAqGRfQBLd2KlJ30E/74KqVgAiW06SvAWGsKFjAzpmPDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210633; c=relaxed/simple;
	bh=5ttNpD9vcXowxHc4V3ptpisb/kJaGu0xPA2Q/8ciHxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkaRtBeK31i+1dWuFYfuv3pcoSe27/N/uOtd8nJf2NEoIRjbhs3RpJufKZZEvgoajExPEsnVwhsCxkMJg7DyyC3KeFhtCd6igKkHLbLlT7lAOIhmubiW8yjRI+K/QD7aXAjlL8Q/xDrk+DojekgEhZ0dKZvgWQ3LW17Ll/KDqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEmzui+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEmzui+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801A41F00898;
	Mon,  5 Oct 2026 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210626;
	bh=W/xzKfsIJntIxrOi0QBw6qLddQ0SJREOpqUSFyrQ7UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nEmzui+DnuoHWn1NYfkJ5If5iisNfzV59GL+/AuUxdyNKdpfBntcan59CJ755ukEO
	 tl2AZLNJ416RMRD5dX5cibeRf3dKlbsZhNgo7HCZtepOLnisZ/HTr1tXvtxcxrafDm
	 tV7zpJJwp4vr12j7RC/h1K1tDHmMlHJtHSoaXHJjeY/ng6wo42cwxilDsenP6idNSB
	 sSwKUChovJhL63v72AAu6r0W1P6LxJIWYzpyM9Mw7t/rrOYrhn/M7tn2hkGkyLKemo
	 b0thYQlKZHde1EA9S85jQR5Kfv6w4xlDohRdnB/nGWgrBlnaZ8Q9qc6Cl5N2chOfSa
	 81Aij4LMCXqog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] usb: ohci-spear: disable controller wakeup on removal
Date: Mon,  5 Oct 2026 10:30:20 -0400
Message-ID: <20261005142941.3012624-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005142941.3012624-1-sashal@kernel.org>
References: <2026100500-embezzle-severity-ad71@gregkh>
 <20261005142941.3012624-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit b1b0f8bdbbc891a4ee7f3b1a878c633e02b7bbeb ]

Probe enables controller wakeup after the OHCI core marks controllers with
RemoteWakeupConnected as wakeup-capable. Removal does not undo this, so the
wakeup source can remain attached after driver unbind.

Disable controller wakeup after removing the HCD.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: a6eeeb9f45b5 ("USB: Update USB default wakeup settings")
Cc: stable <stable@kernel.org>
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://patch.msgid.link/20260915012011.61874-4-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-spear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 3192d7ce04fec..f9414b2de65b8 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -103,6 +103,7 @@ static void spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
-- 
2.53.0

