Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050546;
	b=AZTCcPnmM+QD7ZRNoCuX3sJ3MKU6WdLE4imibpZNuXyvoq1+4oCLDJ8oSpk5lgs/fDlm
	 rTY6J8w5mAiMXF0NMO42bhMfp+I93ADLmQrbGoph7RkkSyUx/McU5doBQpeEvV5UPon5y
	 r/P4TrzxAo89UQmyHyjeHRXWt5Nuo6jv5+kyZmXBGnniofQOdp1COKz5TC5K7afOlsOO3
	 U9+Ec2QA3kv6Di0TnF7d+m97wY535L0EaQBvFg++y+4Nm+Q3N2F0kJu4iyCxN/SoxHUWI
	 ehgp+9GcfU3GCZ58YC0JrgzAOXsKq92K2/SwOEVxWBPgXx8ASuvM3hy/511ytQRYSyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050546;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=41wGSpqfc+pm6hw6YMWFSUoCtUYnfOa4/0mJXgrrm60=;
	b=uBs9YgrMuHKKZjgk4kf8uaPHGUrmaiyl1krEiegwGfe+WAIq6x0KpjJQKs93LBoXZ199
	 8SDG3mbyVfB7zNKw4ikHOee3ylwQ93efxkCiHHJBFgdOi851IPVo6nX6nYD48jEcayvzT
	 jDdh4nsU6q+TrPjKaKCQT8tebl07fIe30Mx1Cg1Ex6CaS7rnovnz0MDwdjJeUAsJdnhsR
	 zQr+joTR6djM6PK9LsgJTgMLaBlS1804Pwa/v+FFCEcfAerA6GycXSxEaDYED2RUhQJzt
	 7zwSz3+KYK6lP1s/j1+rqSSvwxVrNZrL2KL0bu5vUkblT/L3XSOPiNtNmJVPqdc+4Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geX2hdEC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96120606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geX2hdEC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7B91F0089F;
	Sat,  7 Nov 2026 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050546;
	bh=41wGSpqfc+pm6hw6YMWFSUoCtUYnfOa4/0mJXgrrm60=;
	h=From:To:Cc:Subject:Date;
	b=geX2hdECP9HuQgw6hhfGWaq31bF1qwqmeatcOjOaUxJeg3lCOo1YwQq6x39/4IABF
	 PIzhaxWkJVPHcXZ6ucHTAw3WCBi0pssyc+P2be8GuqJFafS0dx7G8/K4+gsp8jVhQB
	 jv3tIcVWXMbwpHPmTgIN4mk0qYDYqbJ/47JGlBcrcC4IRSpY8cjWYtUT62yr2RSN3S
	 uBoQZPW6sT2A8sUw9mWQM1ai5Qls0D3uzWHRBYdJSauSCZySEce1dTGe5pXu/OwHyC
	 sqF6wul1xA363c8V/1gl/bQko5akmeqvIZCe3W/pkC6jkdzIR+LTQspo6Qs8O+6MTB
	 O33Ke94ZRXedw==
From: Sasha Levin <sashal@kernel.org>
To: geraldogabriel@gmail.com,
	dsimic@manjaro.org,
	shawn.lin@rock-chips.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: rockchip: Drive at 2.5 GT/s, error other speeds" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:24 -0500
Message-ID: <20261107062224-failed-5.10-84d08ff902f1@kernel.org>
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
git cherry-pick -x 84d08ff902f1ec01177fef1a21a38934927f5aee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062224-failed-5.10-84d08ff902f1@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 84d08ff902f1ec01177fef1a21a38934927f5aee Mon Sep 17 00:00:00 2001
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Tue, 16 Jun 2026 12:26:10 -0300
Subject: [PATCH] PCI: rockchip: Drive at 2.5 GT/s, error other speeds

Configure the core to be driven at 2.5 GT/s Link Speed and ignore any other
speed with a warning. Also drop the 5.0 GT/s Link Speed defines from
Rockchip PCIe header.

The reason is that Shawn Lin from Rockchip has reiterated that there may be
danger of "catastrophic failure" in using their PCIe with 5.0 GT/s speeds.

While Rockchip has done so informally without issuing a proper errata, and
the particulars are thus unknown, this may cause data loss or worse.

This change is corroborated by RK3399 official datasheet [1], which states
maximum link speed for this platform is 2.5 GT/s.

[1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/7421df7a7b7778ee99363cccfdfabbfa8aa6ab5e.1781622998.git.geraldogabriel@gmail.com
---
 drivers/pci/controller/pcie-rockchip.c | 14 ++++++--------
 drivers/pci/controller/pcie-rockchip.h |  3 ---
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 8d78ab1b31f0f..45cc888ac5537 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -66,8 +66,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 	}
 
 	rockchip->link_gen = of_pci_get_max_link_speed(node);
-	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
-		rockchip->link_gen = 2;
+	if (rockchip->link_gen < 0 || rockchip->link_gen >= 2) {
+		rockchip->link_gen = 1;
+		dev_warn(dev, "invalid max-link-speed, limited to 2.5 GT/s\n");
+	}
 
 	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
 		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
@@ -147,12 +149,8 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		goto err_exit_phy;
 	}
 
-	if (rockchip->link_gen == 2)
-		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
-				    PCIE_CLIENT_CONFIG);
-	else
-		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
-				    PCIE_CLIENT_CONFIG);
+	rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_1,
+			    PCIE_CLIENT_CONFIG);
 
 	regs = PCIE_CLIENT_ARI_ENABLE |
 	       PCIE_CLIENT_CONF_LANE_NUM(rockchip->lanes);
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 3e82a69b9c006..b5da15601b585 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -42,7 +42,6 @@
 #define   PCIE_CLIENT_MODE_RC			HWORD_SET_BIT(0x0040)
 #define   PCIE_CLIENT_MODE_EP			HWORD_CLR_BIT(0x0040)
 #define   PCIE_CLIENT_GEN_SEL_1			HWORD_CLR_BIT(0x0080)
-#define   PCIE_CLIENT_GEN_SEL_2			HWORD_SET_BIT(0x0080)
 #define PCIE_CLIENT_LEGACY_INT_CTRL	(PCIE_CLIENT_BASE + 0x0c)
 #define   PCIE_CLIENT_INT_IN_ASSERT		HWORD_SET_BIT(0x0002)
 #define   PCIE_CLIENT_INT_IN_DEASSERT		HWORD_CLR_BIT(0x0002)
@@ -197,8 +196,6 @@
 	(((x) & PCIE_CORE_PL_CONF_LS_MASK) == PCIE_CORE_PL_CONF_LS_READY)
 #define PCIE_LINK_UP(x) \
 	(((x) & PCIE_CLIENT_LINK_STATUS_MASK) == PCIE_CLIENT_LINK_STATUS_UP)
-#define PCIE_LINK_IS_GEN2(x) \
-	(((x) & PCIE_CORE_PL_CONF_SPEED_MASK) == PCIE_CORE_PL_CONF_SPEED_5G)
 
 #define RC_REGION_0_ADDR_TRANS_H		0x00000000
 #define RC_REGION_0_ADDR_TRANS_L		0x00000000
-- 
2.53.0




