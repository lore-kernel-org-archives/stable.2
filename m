Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940BD4E3227
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674719; cv=none; b=B1NN6EC4ssBkZHr0hzNOrg5gWfzU1OX+TqhhyZaxReNik+mUbjDiNbCo9XK9MhFMlOIlWvmrwENJnWFXeslEojjPd42YEElqDN+PvJn2BrS9NPtkKs9Kh84qaIo/nwL68RKKr6szs3P/QvCjGo+FrZbnskSGCzTBM/I43bLTbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674719; c=relaxed/simple;
	bh=Y/yfo9Q1mXrbIKNBHVmhERqDMEi9y0ma5U/7lSGoH8c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XfJRI8ZJ1Cbbrh3TTlbm4uISGifJnhDgFmo7AL/Eel9ETF4SqHEML8yDcXORoMZBDjvjbaa8rcwYkg7gkN5rZRuBNh1fCX5xBPdmXpLT/CtF2+CG/bCKhObAsMyLmFZlw8tNFD1DxBFht/ourD/nhkuopa2KLHi5OIGJ+kuoEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFHnEgCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFHnEgCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23951F000FF;
	Tue, 29 Sep 2026 09:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790674718;
	bh=nD+smmC4cwf5noBBhsbcNW9PPHyetgLxl6UQ2m0d97A=;
	h=Subject:To:Cc:From:Date;
	b=SFHnEgCInTyhh9V0kHoL3Qbn4dTDNovMUS1xCXv9JyYR2iwiT1PYD52WCZyQHsmNP
	 kT+CtTiCi3agoNtXPRI6a7Xxh4kovH1jnQM5qL2jgshbb7ZCtasL0uUQYN//81ZUiI
	 78zzYz5BIzQrahiOWyM/M4e+z42xD9UQmN5M5XKo=
Subject: FAILED: patch "[PATCH] net: ena: fix MMIO read buffer leak on probe failure" failed to apply to 6.6-stable tree
To: lgs201920130244@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:38:19 +0200
Message-ID: <2026092919-valid-armadillo-00ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9476b4468862927297c94c440863cd8ed1e7cc83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092919-valid-armadillo-00ba@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

