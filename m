Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282B40A93B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202207; cv=none; b=X0oOU/CoXcUiAyYbq6xybvLHWhxDJFozeVBdO0BGB8eZxTQbeCkc9g68AQ/XfcTTKpFBa1DeFsTCg7BPaled5bqYQqtEq4zaF4memNjQYSMpfFku8IvKrltmy0GVHMDGAn6Kn1if0qAFTyLXie6YTHf5LJOAc90D0jav/jNwfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202207; c=relaxed/simple;
	bh=37hGs00ltzaHAED9vsgeilrww4l281bN2bIXVlgRde8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PUsIeyPR2YF9Klum0ywzsuSOCHkhjy49qmY0QGRFwPurSy9MpEFCzRJWbsz3JPq/2Cv5TMToDtdhhnTGGi1vrtsfQHeoYaGwaaoBXd0ofAtmeKRHoHRCEHC/9/sDUto0HbecmbXUs0QTVpd+cm0EH9BOUbUvIShcm4771fTwM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ANja9Rqb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ANja9Rqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ADA1F000E9;
	Thu, 16 Jul 2026 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202206;
	bh=66udVZc8lUcp2F3/n+WHQAI/10IwsXn/dm01u4JzFjc=;
	h=Subject:To:Cc:From:Date;
	b=ANja9RqbxzcT2W05X/fC4IJgwBSMKOsHfLokkXmokGmpbyQYfm5OMmGyYTetnq7dj
	 6FhJPNuXjeWYz+1vdA41bpZGaRkUQdChS8a53yM4UTU3ItHjk/mXEE1k44Hx01Z67A
	 qHWid3JF1WQldggG+jE1no46THOk9Fm2sayNSxoA=
Subject: FAILED: patch "[PATCH] fpga: dfl-afu: validate DMA mapping length in" failed to apply to 6.12-stable tree
To: sebasjosue84@gmail.com,yilun.xu@intel.com,yilun.xu@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:43:19 +0200
Message-ID: <2026071619-replay-composite-2348@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fc3b071a7c8dc0f5d56defddf6e6fd5aaa3e1e27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071619-replay-composite-2348@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

