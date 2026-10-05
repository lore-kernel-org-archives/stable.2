Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E354BB268
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212489; cv=none; b=hj+hw8zTwSS1g4rVrHRLeHsQQWV44Yl/Tg/bgiNUcwTnxvztnkQipzODaAn8pgIFNHn2uXzrSFM1nxeULyUszP6b6o3RYN38QMZHYL/HQ/7sIfUT3qn/U64POkctYuUF770NZcbBbh8xI9Rap1AArtgWDYFe4HJU4cUud4ctVKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212489; c=relaxed/simple;
	bh=3Gn4T/vG/zR98g/PBA1NKavqJEUFOb3nIQIC207rgX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVpvZy7Wk7pJ44n3D2uQwDIpIQVOp5kKyREcCDA8sPedOtDtD0A7Cm1QoKAiC2ZpTkCizSnZAGJ98lxfwSZUP5tlc6krLaCgGzECk1VeAbql+O9M//8NTMdvYIPYiiw7ZlMo0cUOOj9Jkgm1NiVHIZNro7I8TP6m68AbZhmzme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNZ3v47l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNZ3v47l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D161F00898;
	Mon,  5 Oct 2026 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212488;
	bh=js17n3Jp7cRyyEXp6yy7SNdU1EsC8UVnR4XAGt/d9/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hNZ3v47lX1EeeS6LEclQssAyRAnOQiGLokkWDdhSvZNR9JUYZetWQ/0PB4BAzauxr
	 /jkzcMLajhG6SqKVdn7bvM0kcbwTWs/AFmZT5lhUD2V0K7JvnC6CdB7ScBhrrIz7jB
	 uTqXWpSOoP4fgxhL42S28q2jhdutJCTeJ4+beprJ498ZlCCEP3YA8JE3GWgrlVdF9H
	 bIHB4FKZjFCE2QS0Orlu43dwNbIJPUoLsA9zNXYbIQE66KIR/TS7BediQM1kdf9b7t
	 zk1Cqxp7e6oDS6GyyGj+UEGSxc+a4vqrVMsQQV1jUfQQ8IwU+Qmipew3fXtPVBlDCT
	 u1DUYqUCH5i3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	stable <stable@kernel.org>,
	Ijae Kim <ae878000@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] usb: ohci-spear: disable controller wakeup on removal
Date: Mon,  5 Oct 2026 11:01:23 -0400
Message-ID: <20261005150047.3034266-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005150047.3034266-1-sashal@kernel.org>
References: <2026100502-tarot-unseemly-0676@gregkh>
 <20261005150047.3034266-1-sashal@kernel.org>
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
index 0f646c35ca737..47f590bdc1aa0 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -104,6 +104,7 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
+	device_wakeup_disable(hcd->self.controller);
 	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
-- 
2.53.0

