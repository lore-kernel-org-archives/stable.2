Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590AB42B31C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559742; cv=none; b=YPft7WbREWyXdvlsq2GNSQaOlaNMra2BN+R9RUS+LxQVqDyouUPoy1aXoEHyaTTWhkii9rgOa3USTkiD4X98BVueGh7/KI7Jud9yXfXbmmWwLb7tj3Nx6xASPT9qa0Uu0W0Q6DQgDg45GRxACbSjTfZMdCzAddHVYzFhq2bLkEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559742; c=relaxed/simple;
	bh=+qwLrrBUV+k45EAC6jwiOFyAjwfp+irA1eZUhFM90kE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RDqH/Qstr0t+X9V7q2g0B4bN/RMmSRekvtpB573FSBPPvnH1SOuZnQ1izJBoBO0ZnADxqSyZUH6lO7K4tJDQq9kYJNRb0aDYOsHLp868ioze9iEgwz3/1os1GfJ6Rl6euhIb12pr516Jv6JAMlAa08RELX6FqVJsT5Xjw3kNGjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svbn11My; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svbn11My"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB641F000E9;
	Mon, 20 Jul 2026 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559739;
	bh=OS17Zg5Q2WAsb/g7V0UD1gM5YYqlPjoc0koVfZ6FSD8=;
	h=Subject:To:Cc:From:Date;
	b=svbn11My4+dxdQDaPU1aiVqj6+XKTzsM8uehZxcqPiKg94SxQUvpvNgzYe2GQH21Z
	 0kqOWqsObOMBpdUE4nw+ptdUxbDInbCsKhRqg1mAkxMQL+5m9V7Ll8RGE1/kgtGVwd
	 14hxVyFKs78k3IoHQYjYVT8Jg3FZmf7YK/3gsmUY=
Subject: FAILED: patch "[PATCH] dmaengine: dw-edma-pcie: Reject devices without driver data" failed to apply to 6.18-stable tree
To: den@valinux.co.jp,Frank.Li@nxp.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:02:10 +0200
Message-ID: <2026072010-latter-greyhound-42b0@gregkh>
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
git cherry-pick -x 11d7cfe0c119691b2dafbb699bbca90258c678aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072010-latter-greyhound-42b0@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

