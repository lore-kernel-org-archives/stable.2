Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048495;
	b=XsoDu8bVpDWQD8f3DkCjjc0d3sEDZVRyfV6M9brhrsPFPgp8IJXXORf6VN4G6CVUvmIk
	 dVMqFWjyb+87WXLH9dmQbXr9iZcdFJnuUVhgiPbU37eLSKsuOWpQPDSj1/KBxbhlRX7b3
	 yl3YP67Ol2ALJmIh/qyPHEafMIa0pL5hpDG5choUJiCZRiAHFhZPNpx1y+h/3Du9jrxo/
	 eCtL6bB1uncmmU6oURoxGf/cZjM/mg8NnNJuM5q+8AnT+coGLzUrxuZxpefQuyf8Zz0nk
	 T8aMgRtMm1lFUNQMxLD97YtlmC2GpuFHfnP06eT4pq9suB+PAG+dMV3DezCCPwi24gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1Q78b9FH99BhrwuhpSHgdZN9uERQqSGXGIBFjurg7So=;
	b=kb2SgNvLxcjMtlk6h6L64nu4z3kWGifcc5Qhl6wRIcpp8ngYCwVAlrKEii8jEVeqs5l4
	 d2qTKVK1Mrt9zigO5OAaq6WX44pPI3YxTY7+owML1+YlsU68b6Cy3qlVNREKGUQBSGj7K
	 NK0SroFR7kxfrtxM8VZXcAKiQLMOeDSGDo5N9V49LvBbfH0Cn1hz5z4k9f4MPKeQUJaA+
	 rAdv7bL9XHBJn3+NsC5jrmahSZ6eKLR6YVwPyqaCjLrT0FDGWVEzpfX/y7PGSl42AgWDD
	 haOJuzrJuTksA+BE0lg/pbbgXYdR2ZopBEqtF+a++KarZk5DbZnzkl1V04BSvZ6QFAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XuVKoc3r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8C2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XuVKoc3r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454A31F0089F;
	Sat,  7 Nov 2026 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048493;
	bh=1Q78b9FH99BhrwuhpSHgdZN9uERQqSGXGIBFjurg7So=;
	h=From:To:Cc:Subject:Date;
	b=XuVKoc3r3sY+Uw6E4Vo1HOH9d+rYDWqA73ld90Lj97jtwiNFUg/EwGIyKg747k9Vm
	 Ine+hLiZbJCOwemIPFx32KiOPmKIR0jEQtbYRnYd7aDg0Ke33+eLyNtmwsUPvCPkpW
	 elLSiEaxgrqQjpeuHy3SBdA1NGurBPGng7xDxjvvKRyGIYhqL5c9ACzpRDDpXoFbhw
	 ykldtXZu87+pM6psheK3ksPU09ECYW6fHxiZ5Ucu0RdxdUDyTcNxHELK3UFvksZBlP
	 Udyfo8iFO4jE92/F9N8J+wfZmoxgts0MoAtR93OhapeWTrAs+7SjkGtJ90u17cb6iw
	 mCv/mB9OnXFww==
From: Sasha Levin <sashal@kernel.org>
To: geraldogabriel@gmail.com,
	dsimic@manjaro.org,
	shawn.lin@rock-chips.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: rockchip: Drive at 2.5 GT/s, error other speeds" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:12 -0500
Message-ID: <20261107054811-failed-6.1-84d08ff902f1@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 84d08ff902f1ec01177fef1a21a38934927f5aee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054811-failed-6.1-84d08ff902f1@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




