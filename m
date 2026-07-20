Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DB432BF2
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559757; cv=none; b=psxULpTLdl7brMfidhg7GUxlzz82TmpKqvpvT6z7wyxyyAW96YTnk/23VwDGeLA6EoH6vZ3hNBYxjrWSLMltLNqEQMlK1E7U/NAhSkSZEVVhcUcR/bbr2i/JpQsgoeQoy7ck0nMoRMmbjvTkCYK4dirjNVMYU7gcV/eUCl9wrjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559757; c=relaxed/simple;
	bh=gLpT/5MoC2XSn1EH0fNkc6NduJgpqoSjh5Br+RwNE9Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X/YFNW3KmB1vBnmpt91PNHNODlPHgWp9urt93TAUAUbt5lZaDNgpeLEYkQOHnSWdeXnzK0H+y6SuRhZlPAFSSFJlijMpJZZ2cj0xyySdOTixNijNFgt5FYZiGKWzBbAgoD/n6IxUmwEFBDUxBkAUtM4D/b0/Q4An2f7pNJ8b1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=shTRr1WH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="shTRr1WH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798501F00A3A;
	Mon, 20 Jul 2026 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559756;
	bh=PtC813qEr/RcfvEbOLcBepkpmQxdE3FtQ+jrtYtNX0o=;
	h=Subject:To:Cc:From:Date;
	b=shTRr1WHbsnd0EjIKe8phqc+N+lY99L0aS+G5X3oM+Sx1PmmtwKg2nsi9/cZUrrcv
	 7sVCUEn551Ceei9FZfJyCB6ozI8Lo33w1U6Q/Ldqha6WBQWxyJmHdcmRNpRm0hf6IJ
	 FdJE+CHRjUtwxrh0vue/sYvLvNXwS3UC7xpbhHGc=
Subject: FAILED: patch "[PATCH] dmaengine: dw-edma-pcie: Reject devices without driver data" failed to apply to 5.10-stable tree
To: den@valinux.co.jp,Frank.Li@nxp.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:02:12 +0200
Message-ID: <2026072012-reload-scenic-95a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 11d7cfe0c119691b2dafbb699bbca90258c678aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072012-reload-scenic-95a5@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11d7cfe0c119691b2dafbb699bbca90258c678aa Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Thu, 21 May 2026 23:21:51 +0900
Subject: [PATCH] dmaengine: dw-edma-pcie: Reject devices without driver data

dw_edma_pcie_probe() treats the PCI device ID driver_data as the
template for the controller layout and copies it unconditionally. A
device bound dynamically via sysfs can match the driver without that
data, which leads to a NULL pointer dereference.

Reject such matches before enabling the device.

Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260521142153.2957432-3-den@valinux.co.jp
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 2082d0021a8d..791c46e8ae4c 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -328,6 +328,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	int i, mask;
 	bool non_ll = false;
 
+	if (!pdata)
+		return -ENODEV;
+
 	struct dw_edma_pcie_data *vsec_data __free(kfree) =
 		kmalloc_obj(*vsec_data);
 	if (!vsec_data)

