Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98284C77A2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447865; cv=none; b=GnZD2B7yKFLOwiq04+BUqGMnD9YDMIsheDtkcSmfkWyY9HIxzdul4mxJyeVQgw6I/FlOCdl+H5csrSgx4Qn3g5p+3ofdBPKcX8NJHT58NcYMb6MTABRf2Q6mkeroPn5MQ8BABRTjCqiOhOEOwuxl5f4GdQzdJ1KvQA1KoTmW4dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447865; c=relaxed/simple;
	bh=Iqsq6mYNBdlZZg/p00S4n5/pp54OdvGFu/5cH8sl20A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Obp31nPeG8cZACyevQrnCgngciRbi5TtFJiwLWk7jCG3x+Fi6L5KSFZdIKbwzwaB/yFH5ypgsP5lCVAzgYRz7g8bQI74sw7DoGZStgUVAsTch3Ec31iBCgez3b/kF4beI1zqFssf8rGEqe92s/mjbHQZIMYTnLwA/CWO6nWjGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbkGrZ7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbkGrZ7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F91F000E9;
	Thu,  3 Sep 2026 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788447864;
	bh=xBvaZcek0VCulGIbNDCVZ1z5jexeXVn3bX49tvCMwkg=;
	h=Subject:To:Cc:From:Date;
	b=wbkGrZ7cu2Vqrqi+GrQVgLlKwAEqySuXv01yotmcVm+yyfnGbLFOP6xa2JHAhTffB
	 0OY5qtZd+noN1ZNzBuaJ36GOM9nChyNaDs+eWI30jrT4Y7bekhSiMcrYHUvDbgztFg
	 MEpHylSnrDXr91ZZFCF7y1pIpJ0xjhCzqTLkjfhE=
Subject: FAILED: patch "[PATCH] PCI: starfive: Fix resource leaks on error paths in" failed to apply to 6.18-stable tree
To: alitariq45892@gmail.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:42:19 +0200
Message-ID: <2026090319-enviably-stuck-b18b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 22877a061f81c5d58041e384b3131684bec636b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090319-enviably-stuck-b18b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 22877a061f81c5d58041e384b3131684bec636b9 Mon Sep 17 00:00:00 2001
From: Ali Tariq <alitariq45892@gmail.com>
Date: Thu, 16 Jul 2026 15:20:53 +0500
Subject: [PATCH] PCI: starfive: Fix resource leaks on error paths in
 host_init()

starfive_pcie_host_init() acquires the PHY, clocks/resets, and an
optional regulator in sequence, but does not correctly unwind these
resources when a later step fails.

If starfive_pcie_clk_rst_init() fails after the PHY has already been
successfully enabled, the function returns directly without disabling
the PHY, leaking it and leaving it powered.

If regulator_enable() fails for the optional vpcie3v3 regulator, the
failure is only logged; the function falls through and returns
success, leaving the driver believing the regulator is enabled while
continuing to configure PCIe hardware that may be unpowered. This
also leaves the clocks and PHY enabled with nothing to clean them up.

Disable the PHY on the clk/reset failure path, and disable the
clocks/resets and PHY, then return the error, if the regulator fails
to enable.

Build-tested and boot-tested on StarFive VisionFive 2 v1.2A

Fixes: 05a75df4182e ("PCI: starfive: Use regulator APIs to control the 3v3 power supply of PCIe slots")
Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260716102053.185276-1-alitariq45892@gmail.com

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f9..628f8c8d6747 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -304,12 +304,14 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 
 	ret = starfive_pcie_clk_rst_init(pcie);
 	if (ret)
-		return ret;
+		goto err_disable_phy;
 
 	if (pcie->vpcie3v3) {
 		ret = regulator_enable(pcie->vpcie3v3);
-		if (ret)
+		if (ret) {
 			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
+			goto err_clk_rst;
+		}
 	}
 
 	if (pcie->reset_gpio)
@@ -379,6 +381,13 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 		dev_info(dev, "port link down\n");
 
 	return 0;
+
+err_clk_rst:
+	starfive_pcie_clk_rst_deinit(pcie);
+err_disable_phy:
+	starfive_pcie_disable_phy(pcie);
+
+	return ret;
 }
 
 static const struct plda_pcie_host_ops sf_host_ops = {

