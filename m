Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC2488D86
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211802; cv=none; b=DVBc/A2KnPqxsWbrG9Fwjz0QmLNfLsMsA46SXWIs/3NASZVeiV5CYROsWFkfRv3UnPM7ofySv24jvrOSs84YJI+hVevChBXC7lnVbVoFYuzHD5LqpUvMu8ttNv7rLjx4JLg1UX9HkK0BT5gueJDyWAOWNjbQ11VWXIXleQwQDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211802; c=relaxed/simple;
	bh=FAdS1BqdGETMw0wKQKPaye+/ecQMJyitZnUicR3scBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptZ+3Z4rqem2YTw3yqusdaweoISnlySs7GepL6PCwIWwyXIDShCxwh4X6/j41ZjPy8ehsyPqsn6tm1rj/rjHV7mv9+gTZCij9IA1RSqi3wLiopbCvgMoFrIgecTYyUbE8keK95mDfNBpLUcUWQiFNB4EHzh/3/HsNFZSc396dFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBWTO90I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBWTO90I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C471F00893;
	Mon,  5 Oct 2026 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791211796;
	bh=9O9gI+CK2vCW3GyPJRwSgIVAgfe4xeAwhede/PtNeYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBWTO90I4izknYnDOBR2aT7lLpj7YV6m4M4/KyY+P2sscqs5FGDT7CBroU79iNEDP
	 GqAeVz9QdTg9QbezTBHbtf1m9OBUWh/k/CJv+yuQAxvovsx7m1Fs4G8ew6+gax2csu
	 SsnMkrqQZLX/0VfxerHQzetwfRQoOaNzZ+R9sCNt7DN1SmfFAzgiQJw5FJpIJhX67C
	 Y/SE4dS7Iw2ITo7wYV6jphxj7P3u5BBJkRJw5TC0BQ8oNW38psKxAx4fxMVBt6aPU+
	 yg/KhGa/eM6AjQetJPRJ9yKPixMEraqaA5TFyLdw+ncwWLEB7Fjd6DuZRHF2aBFfQc
	 okOOdi+f93FCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] usb: ohci-spear: Remove unnecessary NULL check before clk_disable_unprepare()
Date: Mon,  5 Oct 2026 10:49:52 -0400
Message-ID: <20261005144913.3022101-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100501-compare-xerox-0894@gregkh>
References: <2026100501-compare-xerox-0894@gregkh>
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

