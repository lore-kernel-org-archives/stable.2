Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050544;
	b=hWBMeiZ0Kg0uXcnFiNXiBs3KccrzV8yqisX50Rvq6NVE90FH+EqejggoIvsMGfV5IDvH
	 bq0zvjvgH/NYlLXyU7l1JKLKemY6J5hWFbuDQTJPtE3I/qZctTr2vjbc0+uSbygL9vCMg
	 aZSLSnU297SFBKh/7Qazwf2Itv2EXb0AxEcCuTO8StJrI5kqrzXbiPf1uw2X3fbwPQWgK
	 2Cq9LSLMPLGAhhyOQRSJMhFKcFp97c9oTebfJl+lwBmUjNCjEAfdjtytlJ8NDpsplilMJ
	 cat9XHcBRtsIdU3zZtRHn0T55cABKFZt1ZuipPi5eDr+UsQmctL7ZqKje4P3c7MvWBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TuJYuyZtNSjeRebWucrA0t+gpYJlTulLPnfEwoWVm4c=;
	b=WA7DXjxQgvh7zKLFItMmVsFFERDDR5wPjr2jhqYECi9OVS5CsJTtjORGz1cg6cc+hT1J
	 fMMW5U/8cyAF551WSkIrSurk9HvBu7y/2uVuXGgGlK/71C7pdIE8qugpqOXEBCFFd68s9
	 cHNL360mv8je699WuiiZPvfF+97+GeEoPTJEeuVvtOyKoF6Fu+936MLEyDSP4KckA4zPj
	 cPQ/8Nrl+F96By4kL/4hOziu41H5PYgF0Zv4vcrtmNIcHpHzeFB80T5YdavepijILNVzr
	 84yd+mWUQSJLHOl25PRbdb0g6IqhhJ2apJPMWRk0Oq+yKeuL5LBbSXqb7cT1Oog3f/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JaRDhMFQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517BB606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JaRDhMFQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDB11F0089F;
	Sat,  7 Nov 2026 11:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050543;
	bh=TuJYuyZtNSjeRebWucrA0t+gpYJlTulLPnfEwoWVm4c=;
	h=From:To:Cc:Subject:Date;
	b=JaRDhMFQstCpBwY+aDvyKXS37JqozLHOadnOIA2vKyhkmm+1zvPwcRa2VDiivBHlj
	 /sx/xS3HN/hdm9lZ46R03ZVxsZPsKbuMHImrF0LpmdPLg0XibhSlNZOcrsIEKPFf6d
	 dwWvr9iPsalE9/Y17axs78NAnAe05ejv9JE3bEafEmyPIb/1Iz+Ax/i3PQ7EhttQbX
	 Kw+XHFpyG8t2JOFw0/aBDZoB+LeCDaMz7tz7mmsJCUpx1CtKQp61iu0ArnY5+pHAGl
	 DVNkWvqg5R3JH5tTB8EMDkHdFcL7kpS7ioqfVKMsUuSv5VGVk7HPynzWi8hBYG/J+U
	 XD+RAWPvBNPNg==
From: Sasha Levin <sashal@kernel.org>
To: geraldogabriel@gmail.com,
	dsimic@manjaro.org,
	shawn.lin@rock-chips.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: rockchip-host: Do not attempt 5.0 GT/s retraining" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:21 -0500
Message-ID: <20261107062221-failed-5.10-2a1e6c382fb7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2a1e6c382fb7567679c07bd6a7060fefc7a5edc9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062221-failed-5.10-2a1e6c382fb7@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2a1e6c382fb7567679c07bd6a7060fefc7a5edc9 Mon Sep 17 00:00:00 2001
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Tue, 16 Jun 2026 12:25:45 -0300
Subject: [PATCH] PCI: rockchip-host: Do not attempt 5.0 GT/s retraining

Drop the 5.0 GT/s Link Speed retraining from Rockchip PCIe Root Complex
Mode Operation, so-called host driver.

The reason is that Shawn Lin from Rockchip has reiterated that there may be
danger of "catastrophic failure" in using their PCIe with 5.0GT/s speeds.

While Rockchip has done so informally without issuing a proper errata, and
the particulars are thus unknown, this may cause data loss or worse.

This change is corroborated by RK3399 official datasheet [1], which states
maximum link speed for this platform is 2.5 GT/s.

[1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/68f6353e3a2ea4914de36c42b6906e41282adad3.1781622998.git.geraldogabriel@gmail.com
---
 drivers/pci/controller/pcie-rockchip-host.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index d203c4876d304..0b52f2e370f41 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -328,26 +328,6 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		goto err_power_off_phy;
 	}
 
-	if (rockchip->link_gen == 2) {
-		/*
-		 * Enable retrain for gen2. This should be configured only after
-		 * gen1 finished.
-		 */
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
-		status &= ~PCI_EXP_LNKCTL2_TLS;
-		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
-		status |= PCI_EXP_LNKCTL_RL;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
-
-		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
-					 status, PCIE_LINK_IS_GEN2(status), 20,
-					 500 * USEC_PER_MSEC);
-		if (err)
-			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
-	}
-
 	/* Check the final link width from negotiated lane counter from MGMT */
 	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
 	status = 0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
-- 
2.53.0




