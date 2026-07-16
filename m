Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14586222590;
	Thu, 16 Jul 2026 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238111; cv=none; b=aNrguNs4L8oKW9yOHcS2zqe8L9NdSeSGzYMledyDzImk07uViU5gE4QUwmpEKsdo06/VHxWwX32vNfAFAl/hZCTkAO8keXSlMUQvpP9VkJ3+oju/RV65hK90D20XmeoSIYU/QWKpnHrKn/b5zlrh9GwT7Co+gj4eJLlWHDSfzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238111; c=relaxed/simple;
	bh=eXq6soXBh3V0gnM/g0EjGjq5x/js9iF8I85x5ufcvfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IajCYi6/VrqG4cbMi4jnIGqaj3Pxt0ZnoeyfQpLYf7Bt7XnEppz70IoBmGxJdQvvy0hlkxFxpEF7Vf2m5XkQaqynBfu3+dc1ObE5lAyuTQr8GT/d4SOnQtA/kto0j/jz1Q1S2X4OJpzUjPWizrF3lJbRqX5T44NJ4PoDmxmxPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b=iF7dA3HL; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=smoch@web.de header.b="iF7dA3HL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784238081; x=1784842881; i=smoch@web.de;
	bh=8yF4WllWvs9Iw8iHl81Wlx3j0QzQ0MziWfuhUjP2AqQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iF7dA3HLIm3DnCt1zbbqrldSx2qZzx6SYGNmilO37PkpG5FDSzOg8sO9EA4onmaG
	 VYtPewG2nAUwhaOhIMaoIiDOd+DNiVXTPABl0oKY82yamQDrvg+Vs17ik3quSHb0K
	 V900OqR2nocrgbp8J51f0qTnaIhrFoK7Wbq/7SYnsXN4rQfLcbW1rqg0YGI5p7SfC
	 mFlwGPq2zUuH9HcKkZDoq18xiPwy0df/k6W0rU12k7iBbxBgIPsmllsa70LV4/9yE
	 wPJNXF/gMwzHJKqmlogkNcvfjlWbRrPUwPP4Zjkrjev8zk9P1ON93ACFl8cbqkkQA
	 97fj1MkkpnOb1i3EGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1wZjYJ3nNj-00HpYs; Thu, 16
 Jul 2026 23:41:21 +0200
From: Soeren Moch <smoch@web.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Soeren Moch <smoch@web.de>,
	stable@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: imx6: Keep Root Port MSI capability also for i.MX6Q
Date: Thu, 16 Jul 2026 23:40:54 +0200
Message-ID: <20260716214054.47372-1-smoch@web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wuMJ5Q9l/R81+6rIGhVsO12/EYdE7EMrGyKSOr7MoALu/MjQ+lX
 FP9IkmKiePO//uD5tcp5Ddtj9IAFK3PqwGdmZbMk8XL8Hquc159g/uflD1Ie/VlfMhXBi3l
 isgZDJkoaJ8fvJUv7oNOlQfnjFMBESGZkeCz//70vknZZ6lYhkA4ygMlFIuV/e4tvmX48Q4
 DGxV8sy4VAzgDulUF2aVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vXDL+/9DMNs=;nQ/O1rgyPbGKxsEiQHq9tUokA/F
 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
 qCFtsVqejJn3x5nwaHM0+S+S+wB8Mh8jMw==

On the NXP i.MX6Q chipset MSIs from the endpoints won't be received by
the iMSI-RX MSI controller if the Root Port MSI capability is disabled.

Even though the Root Port MSIs won't be received by the iMSI-RX controller
due to design, this chipset has some weird hardware bug that prevents
the endpoint MSIs from reaching when the Root Port MSI capability is
disabled.

Hence, always keep the Root Port MSI capability for this chipset.

Note that by keeping Root Port MSI capability, Root Port MSIs such as AER,
PME and others won't be received by default. So users need to use
workarounds such as passing 'pcie_pme=3Dnomsi' cmdline param.

Fixes: f5cd8a929c825 ("PCI: dwc: Remove MSI/MSIX capability for Root Port =
if iMSI-RX is used as MSI controller")
Cc: <stable@vger.kernel.org> # 7.0+
Signed-off-by: Soeren Moch <smoch@web.de>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
=2D--
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: imx@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

This patch is similar to
3a4e8302e72f ("PCI: imx6: Keep Root Port MSI capability with iMSI-RX to wo=
rk around hardware bug")

Tested on a tbs2910 board [1]
[1] arch/arm/boot/dts/nxp/imx/imx6q-tbs2910.dts

changes in v2:
- collect a-b and r-b tags
- use correct fixes tag (Manivannan)
  (reference commit that introduced the bug, not the incomplete fix)

Since this is a fix for a regression in linux-7.0+, can this still be merg=
ed for 7.2-rcS ?
=2D--
 drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controlle=
r/dwc/pci-imx6.c
index 98e1db751132..8130cf93c2bb 100644
=2D-- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1995,7 +1995,8 @@ static const struct imx_pcie_drvdata drvdata[] =3D {
 		.flags =3D IMX_PCIE_FLAG_IMX_PHY |
 			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
-			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
+			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX_PCIE_FLAG_KEEP_MSI_CAP,
 		.dbi_length =3D 0x200,
 		.gpr =3D "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off =3D IOMUXC_GPR12,
=2D-=20
2.43.0

