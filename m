Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F374A3F00
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210636; cv=none; b=BMgUj40LuxYha/Nae5saOrs0vgjcHwT1bgFiCe79dHJLS0TZyzxxx4YB88IAXnfP2OZJwi7XbmRqgs9h7SQ87nno2rSrmkzABmN0HPQaxLrIOH4/BBG55Ou0/EGzZEx6A7M8FmvyP3XHPO8wZGrLYNUIX7UupzF8SaFbZUDSeF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210636; c=relaxed/simple;
	bh=FAdS1BqdGETMw0wKQKPaye+/ecQMJyitZnUicR3scBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo9fw+Of6BWbCERgg/Yj8B2N5E7SUnbgazTWxAzvUbGI+bSQZfLhWgeyVklKmG/lx+ek1PWobU8n2Ukflo3hUXwwtTZe1eUWSjPvZnFx3KDZ/Rb9fwyv6oWoRZgceL7ZV+swB9DIZ9aaB8pn9KbMH1o6WankR122aOI/OHg36g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxDu9lBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxDu9lBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840691F00893;
	Mon,  5 Oct 2026 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210623;
	bh=9O9gI+CK2vCW3GyPJRwSgIVAgfe4xeAwhede/PtNeYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxDu9lBp3lzVBCBBu+wCfRgT9+612zFBCWP4jlu8WRCCQTojXMHoIf/rXSqpN/Jd5
	 Zhr8Ft2zvqZWPzl5/qCIBBPffOS1OklNWugt13yTKD1RQkkAqeRiQHFq6Ti1L6QQDE
	 S70Aby/6jjf4yOfJSNvKIIiNELLkBFG968GWh0rvjN+JgvGl3vv+IdGD3zRrXN+Ha7
	 oG25Qjc42Q5o1PBy8Pwg64oOGJaZeLd5EofIepW4fMX/6uiUafsWf5obIEzdaC7KFu
	 YCoCvTN8scrCoRZWZCR9sUYkliEBTkIYDLWiFDaQfSTK1JKHqvftCBpj2z8DajmGtG
	 KZQyLq1ePc5hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] usb: ohci-spear: Remove unnecessary NULL check before clk_disable_unprepare()
Date: Mon,  5 Oct 2026 10:30:19 -0400
Message-ID: <20261005142941.3012624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100500-embezzle-severity-ad71@gregkh>
References: <2026100500-embezzle-severity-ad71@gregkh>
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
index 993f347c5c288..3192d7ce04fec 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -103,8 +103,7 @@ static void spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
-	if (sohci_p->clk)
-		clk_disable_unprepare(sohci_p->clk);
+	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
 }
-- 
2.53.0

