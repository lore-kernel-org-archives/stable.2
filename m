Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8A40A93B
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202215; cv=none; b=pqULPCt9sfgyIlyxHHMZLPUp/zL6w1wPyjEf4y8UBFIYQn+5DzppU9Da0/dd468HEiyH06cFFn9EAqR9LOvNHe0AOZF+R4Yl+CYg9t4Qp55L29yL5ANVYwgeMbiIxnhNsDgcFL+L+OH1L2SG4PaxG97cKxmod7LyZogadBVHBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202215; c=relaxed/simple;
	bh=BxgAVOd7lNHW98RT43DKiXClN3+vBqbMJmtZPJnCSlg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cd5l9jMoK6ax89grDXa828P8IWRasySZRly31PxQsjfmrqXnjgsu7NIlfReE1XNAoSPR6TSkWq9shrG+9ue3aogO/wnuOsIa2dhPiKFtUrx7XagJws2+JEovVMas7oafkd7TioRWn0256PbjW71vee7tBLeScmGenSqvfUsr79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1wNWmnsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1wNWmnsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56221F000E9;
	Thu, 16 Jul 2026 11:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784202214;
	bh=goSNsZMw4oqlC57hUlkv/oLAtMrP3xI6isWuVFx9kOU=;
	h=Subject:To:Cc:From:Date;
	b=1wNWmnsu7uGEAiuU4WAL5IKeNoDtMAJLPrQZdx1e5F8jIEC6vRf5wN3S4g4ClC+A+
	 N8sNigseukui9BOZSyMnVPtFw49SkqtT+aQeozT+JCoATwAMenyoZ7GlFe3uJKRYnX
	 ZgMym38kegCd9Q+yJ05AiZ1gYUjoUmQU5AS46fZo=
Subject: FAILED: patch "[PATCH] fpga: dfl-afu: validate DMA mapping length in" failed to apply to 6.6-stable tree
To: sebasjosue84@gmail.com,yilun.xu@intel.com,yilun.xu@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 13:43:19 +0200
Message-ID: <2026071619-cannot-evaluate-f3ca@gregkh>
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
git cherry-pick -x fc3b071a7c8dc0f5d56defddf6e6fd5aaa3e1e27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071619-cannot-evaluate-f3ca@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

