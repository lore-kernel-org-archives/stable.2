Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046283;
	b=WKgD508hxTJPumj9sHp7J+r7QKM1W6IRnRoLx07dNe28DFgVOV8w4Mw9jtdv4am6Ckxt
	 UDXsTyD1qqg3L830TAxexu+1vjLbi0ys4EG0U3w8daQryCFwdLORsAKgWMv0cLkllDK71
	 oc6+wXvYX8Y917W5YxcEMNZxN+M41e8+EhKEkORKD93ACmW/AjC/ne/y+xCne6JYLLHxF
	 9u7ssk7Px9ZM9ztabEPVGJArfEjTJtpOusVofQWtIXdTGMk8846UYX9H3YO1MKFq8+4Zi
	 K3sMUxlYSjTKrG+ajP/I3ErCDLW4g65d01Y+AMqNSRwkS25g8/henV1CxVuGdNlhAqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P+qYLUWZTUOEQH1Tf9esN6ZmwvKOTKUbNEjRSlCqSV4=;
	b=cxfqE4hpXgAsUCRa2cMBVX59YDpnuYZJOKj+Z6TGVQRmUfoeLRHTyYTj9iYQzlLkTM3/
	 P1lEXur9di/UKGfpTCbJI/2U9WkykCsHjKQLs/hLWJH1PRBz0M4Up+2MowZ7++NXBvZOv
	 b3wT3RYtcF4d9Ma1nlkavvIFN2KtfMAIUzhR7TVZPNWj+tGNNEiofRh2VVVpJpk5r719f
	 sSuYI5QPRjXEPUA8oopPN5vGTMnbeXo5lKc0yZrMNEpuyaAptdtXltCIYLWFD/pO82VFU
	 9aepFCUcm2MYQdtN42T4Zo7J0eNKzebFpCJouTVV8rS/uBZj8t+7IR69HigU1rL/SvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4cETfpm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FFC606A335
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4cETfpm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9287B1F008A2;
	Sat,  7 Nov 2026 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046283;
	bh=P+qYLUWZTUOEQH1Tf9esN6ZmwvKOTKUbNEjRSlCqSV4=;
	h=From:To:Cc:Subject:Date;
	b=m4cETfpmwuDyVmhRW8RUYxIlXMc4aNKh0YE7/3aD4yohP8F1ehl9zyEl2ZBhzMmJE
	 KaFCnYH0OSn/DcoeTDOOoRIQRge/DBBdOmYmEwj0Uv3g0KnByPZuZv/256YtpE9k40
	 J1Ee40+rJmG/3LGBlAfF8UljYUHoCOwVHDhx6HOWiy4SKk4HyIvtqBA3vugEzwaLlA
	 YVEd0N3Hp0wkfQLMDyePlVdi9ykvi/s7Yxxv9SggDAp+kTlAVfBqUiiD/91uO4asoW
	 bGIO3pYtvaQwWCG7ks0nLAbP8AYJUR2gzfzPQyDXo4/bju82g5DgTW8uJdAvBY3iIr
	 OGvUHOJOQpjiA==
From: Sasha Levin <sashal@kernel.org>
To: rudi@heitbaum.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	hongxing.zhu@nxp.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: imx6: Avoid dereferencing a NULL clock name" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:11:21 -0500
Message-ID: <20261107051121-failed-6.18-e60d0d4dfddf@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e60d0d4dfddfac3058753a1c2255251401c92dad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051121-failed-6.18-e60d0d4dfddf@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e60d0d4dfddfac3058753a1c2255251401c92dad Mon Sep 17 00:00:00 2001
From: Rudi Heitbaum <rudi@heitbaum.com>
Date: Mon, 14 Sep 2026 12:35:31 +0000
Subject: [PATCH] PCI: imx6: Avoid dereferencing a NULL clock name

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
---
 drivers/pci/controller/dwc/pci-imx6.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 54e104679da07..b7390da1ae35a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -584,7 +584,7 @@ static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
 		return 0;
 
 	for (i = 0; i < imx_pcie->num_clks; i++)
-		if (strncmp(clks[i].id, "pcie_phy", 8) == 0)
+		if (clks[i].id && strncmp(clks[i].id, "pcie_phy", 8) == 0)
 			phy_rate = clk_get_rate(clks[i].clk);
 
 	switch (phy_rate) {
@@ -1902,7 +1902,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
 	for (i = 0; i < imx_pcie->num_clks; i++)
-		if (strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
+		if (imx_pcie->clks[i].id &&
+		    strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
 			imx_pcie->enable_ext_refclk = true;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
-- 
2.53.0




