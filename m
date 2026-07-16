Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED3B3B9608
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202223; cv=none; b=BW4GrH7ZpDREk9M16N5XVbApaf1BFx3v+SrsBkW8w1z20KTJ4lTAbANbq/QCmI0YlwW5G/rSgMt926FdX+wIM2HRp9TzsPyNmRq+CHelVmROL2RUkVdu6j8sa2eiFD+L2QfMzefRPyKoj7jjO2rpkcPIfDm7qfHk3lYWq9EmocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202223; c=relaxed/simple;
	bh=Sn4NAgipl7DD0O3q5sIaLInb0UtiRKuS5k/eLPI0EU8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cnUZMOigUXO8+zZEMzjpRQuTosqYwWFVf3Lk7XeKI1B5pEqSEokBXFWEyJIqIPgCKvsVMOlZ+ERFmCJg1hRc6YV65y+9WMFUaa6zr5yGv8K15FXGkJjHPqXZDm3XkbDLdbEmQ6Kek3eRCIqpCAX7Oye8zJE3GxWz3dH1Gv77a9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qftHILPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qftHILPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93531F00A3A;
	Thu, 16 Jul 2026 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202222;
	bh=ONG+HZTgbBfXjaRMf20aTKicwAyOZqZTxLY4zD1AfY8=;
	h=Subject:To:Cc:From:Date;
	b=qftHILPJGuC4K9713uKvenjH+aFzlV6haeNJupPMh131IX8FnSA+AofYdF0IsXWxA
	 ALE7MoUnL5VDnWiNg8NUkDDWIt9d16wEm56JFPU6JrmyGUGcdgZg7JKZULGuPtZxJO
	 rSXKThItpSk18tE71c1am8PyciqAIbdiYGFGD8C8=
Subject: FAILED: patch "[PATCH] fpga: dfl-afu: validate DMA mapping length in" failed to apply to 5.15-stable tree
To: sebasjosue84@gmail.com,yilun.xu@intel.com,yilun.xu@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:43:20 +0200
Message-ID: <2026071620-drained-crate-54fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fc3b071a7c8dc0f5d56defddf6e6fd5aaa3e1e27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071620-drained-crate-54fa@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

