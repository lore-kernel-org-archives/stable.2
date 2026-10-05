Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC84A261C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210677; cv=none; b=VwJmVb84oungJvmBtovWyVxhEynA7NseX5WDFS13Ewc9dnjvKOjapVRqYiJObfSnCQB0ylUint3lviHZKT/k6DxcTa8HiHXMs5w9bzrn3nxzt0SYnrDmyxwOY46jnjDW3NNULaaBZTGy/CGzpu5liMMPA0R/0OWBUbIMfnPlnGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210677; c=relaxed/simple;
	bh=iMMAGd6WzKfxfcRImv6iw5UtI9iUEckmGpxTfwY1y9k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JWW7/flK/zv8sublk2cMG1Vaae9m6jm2Vw1Xe4SUt7YzQLHmPUgPWYgY5g8KauPXV3N2ZzvebZvvjfI4DAjFYGRuAEXYCS8lBF5Nmljrblkir8MvBP0I3da7hUAU7HQ73Qs+TuZMRqm+rII/47Zvyltf+p8W72c1UzOn0qpJpoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aZfiBxPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aZfiBxPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEE81F000FF;
	Mon,  5 Oct 2026 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210668;
	bh=JGiF87N4CTFd1ydjNU0OmSHIhR8lS5eb6y7wCJF9Wx0=;
	h=Subject:To:Cc:From:Date;
	b=aZfiBxPV084RUV3MBdUfJXR4XKKtH7wLqd/7e/T1HD6mUDg719wJS3HQFv08bKm9y
	 tFqDoOpejMrVG2ql4fDDcUkYZg6D8hXxnrp/9PuANJw44Wp3cn5J+Z/HFN11cBnEuJ
	 0WNNcg1YSzxp/GIS9hPjKsD17enegNzLGKq3bYnQ=
Subject: FAILED: patch "[PATCH] nvme-multipath: set BLK_FEAT_ZONED only after the zone info" failed to apply to 6.18-stable tree
To: kanie@linux.alibaba.com,kbusch@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:31:05 +0200
Message-ID: <2026100505-trimester-quilt-e671@gregkh>
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
git cherry-pick -x 4a5e49ba0abb8b4328d6318c9aef0c0121f95507
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100505-trimester-quilt-e671@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a5e49ba0abb8b4328d6318c9aef0c0121f95507 Mon Sep 17 00:00:00 2001
From: Guixin Liu <kanie@linux.alibaba.com>
Date: Mon, 14 Sep 2026 18:57:13 +0800
Subject: [PATCH] nvme-multipath: set BLK_FEAT_ZONED only after the zone info
 is known

The namespace head is marked zoned at allocation time based only on the
command set identifier.  If the zone info query reports a zero zone size,
the path namespace is registered without zoned limits while the head
still advertises the zoned capability with a zone size of zero, and
reporting zones or writing to the head then shifts by ilog2(0).

Drop the zoned feature from the head allocation and let the head limits
refresh stack it in from the path namespace instead.

Fixes: 28982ad73d6a ("nvme: set BLK_FEAT_ZONED for ZNS multipath disks")
Fixes: 3838e80fcfb3 ("nvme: skip the zoned limits update if the zone info query failed")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7db6850f98d4..99ecc73393e5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -761,8 +761,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	lim.dma_alignment = 3;
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
 		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES | BLK_FEAT_PCI_P2PDMA;
-	if (head->ids.csi == NVME_CSI_ZNS)
-		lim.features |= BLK_FEAT_ZONED;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
 	if (IS_ERR(head->disk))

