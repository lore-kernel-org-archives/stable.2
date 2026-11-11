Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414173;
	b=1GaGeB9YjXK6XHJQv7QLXFN8SkjEoq5gYeyJIbGQhuxq+zYm4UrzDCL0IMZqqhFJr2FP
	 GTO7+lz8IqHDfoRWLnXMjXAUiLtw66j81pTyS0Sz4B/wP3QBReXwv9mH6gV26BN/Jnh2S
	 6QmbOvuURabxnr17/v+EdpUwo9WTo1olx2TlIeQE2IWou8wGWOg8UM2NcHSNLyagQx6em
	 N+frLs/n1qoFVaiWqtwLUGRQbasp1o1Fd/NTC3j9Nhgg3RAyCjnvdJjVDFmWBa/ylAuIy
	 BbuK2htwHBueIhTUqBefHC2k+caML7L0NOA56SYZ/RA2ZVi60Du8nNZxnsp3XLL2V9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TV1/IUoHhrFDEWIOUfarFqeU/VdtBNUm7dphO6SR5sA=;
	b=suunAZs5BedCvbwvZu2Bf4xE61yvyg5aF3qKOKpGp+aqwjseDB7B4H8abaat+SaZ20eZ
	 fiRJ6BazfcYHKd6G6bdpeDw7gWUAJmxOWPpZvRh9ATqD+Iq9CbdWsNA30YDJXyZ9ZUWu1
	 39eL9RHDGv9c2x3hE/4xNQhhq32ywKfv6j6olvydHzokxgp+JXmEjjL3q+0hBAx9ioO5T
	 YtJEeQ2+xy+Go/Z2EA5GapsQzeN9el9Ekcc0PpOY9SD/RILN1TWRcyyvj0uDWSnCBQoOm
	 LswiZeqxHK8yPKiU5S1ypDFURioDGmtCFPGbYicboMy88raxwfJWRe7awUbiYhouUCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azNGrn1V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D85606A339
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=azNGrn1V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEFC1F00A05;
	Wed, 11 Nov 2026 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414173;
	bh=TV1/IUoHhrFDEWIOUfarFqeU/VdtBNUm7dphO6SR5sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=azNGrn1VgZOZRGAHKEHi/Xor7pS3R67bhqlGHAC+T+HIYnK1sqTwk301uN2FnF13Z
	 P/e+SNuEKLTto+EhWK/jIrE30yo0ZrhgYyVIPGw+sF2yHTpbVqirvQDlB0vuGqczZ8
	 5VJNwbgaPef11kPO4rb0LQmDF4NIQDmi1h5T6MXKy3FFRFxt55Jxbma+HjfGAlDf0V
	 siTitre4vOhoWn0qnngx5ggSJ92qwsiBkSUBz83wzAVUnXLEjz7DA1OU03OaYrl0xu
	 XqVFU8uVA9luXJ3zawmScGEJrUAb7jPkCsGBotJXhuLH8F9j2ixhVZ43G0OuikXus4
	 /sQBNShJSuWWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rudi Heitbaum <rudi@heitbaum.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] PCI: imx6: Avoid dereferencing a NULL clock name
Date: Wed, 11 Nov 2026 11:22:51 -0500
Message-ID: <20261111162238.3258975-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051121-failed-6.18-e60d0d4dfddf@kernel.org>
References: <20261107051121-failed-6.18-e60d0d4dfddf@kernel.org>
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

From: Rudi Heitbaum <rudi@heitbaum.com>

[ Upstream commit e60d0d4dfddfac3058753a1c2255251401c92dad ]

of_clk_bulk_get() leaves 'clk_bulk_data->id' as NULL for every clock that
has no matching entry in "clock-names", which is legal: a node may list
more "clocks" phandles than it names. Both scans of the bulk array
dereference that id unconditionally, so such a node oopses during probe.

The loop in imx_pcie_probe() has been wrong since it was written. The
loop in imx_setup_phy_mpll() was not: it read a fixed clks[] whose ids
came from the driver's own clk_names[] and were never NULL, and only
became wrong when the driver moved to the bulk array.

Check 'clk_bulk_data->id' before dereferencing it in both.

Fixes: f6a1fdfc78e2 ("PCI: imx6: Use devm_clk_bulk_get_all() to fetch clocks")
Fixes: d8574ce57d76 ("PCI: imx6: Add external reference clock input mode support")
Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/am8iBwJSEhYhWTqk@6cfee64030a6/
Link: https://patch.msgid.link/aqfqE4OLhnN4a1lW@b65e9c1eb12f
[ sashal: Omitted the extref clock-name guard because the corresponding scan is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index de09cc2a63112..4235f1fb7b337 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -540,7 +540,7 @@ static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
 		return 0;
 
 	for (i = 0; i < imx_pcie->num_clks; i++)
-		if (strncmp(clks[i].id, "pcie_phy", 8) == 0)
+		if (clks[i].id && strncmp(clks[i].id, "pcie_phy", 8) == 0)
 			phy_rate = clk_get_rate(clks[i].clk);
 
 	switch (phy_rate) {
-- 
2.53.0

