Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434434;
	b=1XaFVnNsJmbcGN+vy+fsLsS0tuLwshPbLk/yELuLbIXPxVj4Vf+xBlbt9KxI7on/RIP6
	 p9QhDLtGB72S0BwCBy3ONj3gRLEe27umLROnqePL0BsLcEwWdDAevDuzWsnBV8iqrSh5U
	 9/yHU4s1tGAOl0fwv2IBPRhJn1MPXgXNFYC521DtKBcqkeyiVu/WqMrNArKatsvo1RSw+
	 P2Msp06kugEMV9Sij+xhzO62RkEEgqlY4OWRDWiSARZHwxdjVG+y/1uY91S5LAJ9lqHf8
	 E4MGHEMpffiHjslRzOHvlIU32z61FQDnRAtknWiv93XAPTmkIJ5eGSBd6kTxtZEMNNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CdK5X5qCDt99MckXbdPqQb8CMjTIDVvh4joLCjTaM1A=;
	b=H0zwfYkhBhKPw4RsL28PLzOEYh6UnhAH5j4Wk997vnVIsuwUXgqgsu6Tdmzou4WSKsf4
	 x+hSELl5FxfNMnuEdlngnb3GLEDtnPvPmbaxthOpbODZQV6/BfCnc2HfxEOa87qE5kXfT
	 QYSXKUAPAtMdbi6kjr7TL4BxsSdfYscXa3+u1P+kFqxhehW8oJXsMK404k8EXIga9yEee
	 yspvzJM/b9R2Nnmna8Nl1sNxnMqMENhgEFuo26jFRimi3eQL6UAD87Ql80x+ZY1281hVQ
	 4+7fBjFeuxQ6sLvTbVhyISkZ+CQO04bNbFDK+7DQdvU43vH1iA89TJVaKNcE8u22BHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rneo3S9Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495E606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rneo3S9Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEBA1F00A05;
	Wed, 11 Nov 2026 22:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434434;
	bh=CdK5X5qCDt99MckXbdPqQb8CMjTIDVvh4joLCjTaM1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rneo3S9Ze5cNnPsAfQ2SOiFhyVgqEcPWoZhNxugTcUlhrByFileMJWZib6re882AA
	 iuXsoFsx7bRcG6GuQDcgsbiYLX4rkIXH26tMTRQmu0fJMwWyTqChAcpFHjEz9T9MHu
	 xxH83YFKSEA1/Il5FoBppRa201yNS0zpvrk8N+S44fqeek0BWydI50cV4NlcaIwk0G
	 I5XlGRhWibrxivXprZYR4zjOh9SdP7sIzNhxD3YdM6uQOwO7VZuBMlgrClfarW5Hsc
	 MrFZjejFxseVsvNAx6tjMXEwJ9VBMikS0RWIUinPvc1LnC8z3Jj35XQ6VAhN0TxIO0
	 2DKwAJ2hJGJXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Charkov <alchark@flipper.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] PCI/pwrctrl: generic: Fix leaking array from of_regulator_bulk_get_all()
Date: Wed, 11 Nov 2026 17:00:31 -0500
Message-ID: <20261111220022.4081244-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111220022.4081244-1-sashal@kernel.org>
References: <20261107051332-failed-6.18-ee450e3a2d33@kernel.org>
 <20261111220022.4081244-1-sashal@kernel.org>
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

From: Alexey Charkov <alchark@flipper.net>

[ Upstream commit ee450e3a2d334c7e6383d8a55ad2d53b3822bacc ]

of_regulator_bulk_get_all() allocates the consumers array and returns it to
the caller, who is expected to free it at an appropriate time.  PCI pwrctrl
never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260930-pci-pwrctrl-kfree-v1-1-f09bbffd8da3@flipper.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pwrctrl/slot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 51de1eecdb26b..35bbf8a380415 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -25,6 +25,7 @@ static void devm_slot_pwrctrl_power_off(void *data)
 
 	regulator_bulk_disable(slot->num_supplies, slot->supplies);
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
+	kfree(slot->supplies);
 }
 
 static int slot_pwrctrl_probe(struct platform_device *pdev)
-- 
2.53.0

