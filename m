Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB283C13E6
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674722; cv=none; b=XXr+ediRJtvbLOAuFH/Uamf5bEkSxmXycZLW3qqHQVsVNgX2YtYf0USx6Dn46z/8SeQSz+szLX+jHE7duAarm8BRxbTsceqxATVt8Sf7Yb+D29GKRFsZ00+yXoiAeyCDAAVKO1U5X7GtoLcNt3E4oXa2au4Tm1E6+TcmVIQSyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674722; c=relaxed/simple;
	bh=nNUSCtrdp5SPV8dCMXQ6gyAVGe8uLLqWIKHb8OVHne8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nSMgAzzVhbSV5ajijeh2qOP54Ws4iX59vIooAnZpzN9JIR5n5lcbem/gcEUe3DEAZcgIJLGEpkYCaa5u5Csk540wq7giX3gcxgleIZVpB2Y89H3Ia8RDDBzlPZearMBbBlzse0+kMLL2XbRDSzwT4QRmJOUHHtH4T8JKj/alzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1wqMKss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1wqMKss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747BA1F000FF;
	Tue, 29 Sep 2026 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790674721;
	bh=OOvj25ZtFEBkgPR0176opbpijvOjS7racfiDk+B4cog=;
	h=Subject:To:Cc:From:Date;
	b=h1wqMKssZ6CV2J71bSawIbTqi24e40AUu8NJrTva4pljFSfIZ6ldsPdZ9gPSeAHYm
	 ELVAzqh8HwMcOP+c81UV+654K+8qwCwyqFT2qaKTbZN4sllmekPeFyEVLM4Gsj8Nz3
	 7QTcI92QvC9+S1BrGxPkUDOvav9X3BLzp8KiJ1zM=
Subject: FAILED: patch "[PATCH] net: ena: fix MMIO read buffer leak on probe failure" failed to apply to 5.10-stable tree
To: lgs201920130244@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:38:20 +0200
Message-ID: <2026092920-urgency-education-bc42@gregkh>
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
git cherry-pick -x 9476b4468862927297c94c440863cd8ed1e7cc83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092920-urgency-education-bc42@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9476b4468862927297c94c440863cd8ed1e7cc83 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 23:42:02 +0800
Subject: [PATCH] net: ena: fix MMIO read buffer leak on probe failure

ena_device_init() initializes the MMIO read mechanism with
ena_com_mmio_reg_read_request_init(), which allocates a coherent DMA
buffer for MMIO read responses.

The normal removal path releases this buffer through
ena_com_mmio_reg_read_request_destroy(). However, if ena_probe() fails
after ena_device_init() succeeds, the error path destroys the admin
resources and eventually frees ena_dev without destroying the MMIO read
request, leaving the coherent DMA buffer allocated.

Call ena_com_mmio_reg_read_request_destroy() in the probe error path
before releasing the remaining device resources.

This issue was found by manual code inspection.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Link: https://patch.msgid.link/20260921154202.471662-3-lgs201920130244@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 5f0864d16dd3..7eb6456ed0d5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -4123,6 +4123,7 @@ err_device_destroy:
 	ena_com_delete_host_info(ena_dev);
 	ena_com_admin_destroy(ena_dev);
 	ena_phc_destroy(adapter);
+	ena_com_mmio_reg_read_request_destroy(ena_dev);
 ena_devlink_destroy:
 	ena_devlink_free(devlink);
 err_metrics_destroy:

