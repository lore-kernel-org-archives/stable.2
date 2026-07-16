Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102903B9608
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202221; cv=none; b=a9jd5b/q1QqpJHCrfJJMErsqUYZKmcCi5G8Pvd+jVjxISKZV1bWBswT6jYLy+NE7s2LrMhFtNvvD5zz6axSFTQlZnQXmq9nB0rndN2BFbFOI5hPnuOoFJM5rQ8s4Ev8JEV2AOZRE9wYdDrR4dIUtgLaKP/xOs/tmymAvRFG7QWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202221; c=relaxed/simple;
	bh=WR18JyVjLFWCOvi+C3gtoM0ALKlWnMm8NSiokJvL79A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=huDzROwvPCU5yGbRewPyuRK9lf34y5zQMcM4+roUMrJ4aV7YGcP5P+25enJ1OT4XDSExUpcH1/0fw044sjsVDO4JfkCL65fgE2LAlCFp5E4tTAtH4tWKFyR6Z4zK8hZvRxwa/ntXH8qIOh3DN9gQ/V7FFtXRbFm0qgyq4iVHaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E8oRhviI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E8oRhviI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363491F000E9;
	Thu, 16 Jul 2026 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202219;
	bh=7r1IF4uVlOFNP0JC+Qmv0VGuYOoWD83Iz9/cJ7Yx2aA=;
	h=Subject:To:Cc:From:Date;
	b=E8oRhviII3J99pAGZ5ih93tUT7mC5YQwuX1bpVo00JpyYrdR8rZA8IRkZpi46O3RR
	 TjP0+ILHtjcu7s+zhliyWGi+/s9YeZMOC+DGeVWdaOvJPxDt8lSaAlijLSlGImesU8
	 c4SLaq18BMo0MZ64PaD5e9Z8nvG/cgpSrfxZAXNc=
Subject: FAILED: patch "[PATCH] fpga: dfl-afu: validate DMA mapping length in" failed to apply to 5.10-stable tree
To: sebasjosue84@gmail.com,yilun.xu@intel.com,yilun.xu@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:43:20 +0200
Message-ID: <2026071620-thieving-ferret-56cb@gregkh>
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
git cherry-pick -x fc3b071a7c8dc0f5d56defddf6e6fd5aaa3e1e27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071620-thieving-ferret-56cb@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc3b071a7c8dc0f5d56defddf6e6fd5aaa3e1e27 Mon Sep 17 00:00:00 2001
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
Date: Mon, 18 May 2026 13:07:41 -0600
Subject: [PATCH] fpga: dfl-afu: validate DMA mapping length in
 afu_dma_map_region()

afu_ioctl_dma_map() accepts a 64-bit length from userspace via
DFL_FPGA_PORT_DMA_MAP ioctl without an upper bound check. The value
is passed to afu_dma_pin_pages() where npages is derived as
length >> PAGE_SHIFT and passed to pin_user_pages_fast() which takes
int nr_pages, causing implicit truncation if length is very large.

Validate map.length at the ioctl entry point before calling
afu_dma_map_region(), rejecting values whose page count exceeds
INT_MAX.

Fixes: fa8dda1edef9 ("fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20260518190742.61426-3-sebasjosue84@gmail.com
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e7338dbe..097a97eeea66 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -723,6 +723,9 @@ afu_ioctl_dma_map(struct dfl_feature_dev_data *fdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
+	if (map.length >> PAGE_SHIFT > (u64)INT_MAX)
+		return -EINVAL;
+
 	ret = afu_dma_map_region(fdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;

