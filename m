Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2828725B
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133147; cv=none; b=QiL/W9wJloXc/vEp6k4814yLHT/coRORzGCqc6tYpqBbIhpTQXXQPHLZhPt9UHl/rwaLii8DuqMf4F92g/r4vj5sQqJopNicYo4Hfqi/b7Ehm9GAKysp9gGa5Fn10/042xh6BDo13JY3Bf7Tm5mocEDB3p8B/u1QmOQeiS1w6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133147; c=relaxed/simple;
	bh=cA7KJuejJcGfVAe1w5mbwBnFHS489fvONJusiC3FlmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nu7UfCgOcaLsd7IsEYgSQjEj88yzC2V6qq39Jwl0xW8BTylowm9WVU9H6Tlm3FZNZ1RewL0LtSkjbhfH1ERaGEtiyNyhaLuoKovSrSN5DKBKOESOvBQBDQv1I4cATZ9aBxNhH7y5nj7gBM5vsF63hBdv5KzGLVL1lcQygFYmAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvtD156p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvtD156p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4762A1F00A3D;
	Wed, 15 Jul 2026 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133146;
	bh=7/94RzFanRSTI9ta7ZjLdZR53wXHEJGdYyoaY200/1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VvtD156pUQi4lGsm+d54e57CdP4j5ZtADwiocYKYeT74UgjHyu6oBC6SszUkYeH3e
	 I4x6VUxaIIDfNs9ZC/W5lgmsr4f/dvFvOr6owa0sqd8YpI/iERGqu8q4SKy6LvGd2o
	 Vk4cjIXkUB14u+oq3Cm94skSZmKhBPkfYHp9RpWz4EDLsMrjNUXWSnzD2MgQmuTOmU
	 yx2oblD3ELea3Kv5giT17Lsdv1ZSJykdCMp3MaHgMbOEyy7ygwWtRqp9DlppFG5+Si
	 lLVi8Jxvlc2c+gT2aFVP1rIN96wIAOfxqFzZO51J9RF1hF0HU1pktaAth8wMC6D2eJ
	 Lc/v4mBFdZ3Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/6] PCI: Free saved list without holding pci_bus_sem
Date: Wed, 15 Jul 2026 12:32:19 -0400
Message-ID: <20260715163223.952417-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715163223.952417-1-sashal@kernel.org>
References: <2026071318-kettle-cringe-5d1a@gregkh>
 <20260715163223.952417-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 1d8a0506f69895b7cfd9d5c4546761c508231a8a ]

Freeing the saved list does not require holding pci_bus_sem, so the
critical section can be made shorter.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Link: https://patch.msgid.link/20251113162628.5946-6-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 92a9a0f38fa76e..5d85de5e777ddd 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2269,8 +2269,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		pci_claim_resource(bridge, i);
 		pci_setup_bridge(bridge->subordinate);
 	}
-	free_list(&saved);
 	up_read(&pci_bus_sem);
+	free_list(&saved);
 
 	return ret;
 }
-- 
2.53.0

