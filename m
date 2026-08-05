Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB07342A7BA
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930028; cv=none; b=FP4FyIfY9zjdn4msjw7MpM3faweH+rVH6fCeYJZBIA1nCZbNeKFlg5KBcH1aId2S8BDIS1s/59XUl75bU5Xgrdik16Br4WRWYS3JNXGzJYDswSD0O+tJbHTz90cS0wI09tv0hFEmfw7/draJ3FoxgkwLquQBcTbRNliFMcSe3RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930028; c=relaxed/simple;
	bh=hDARXPERuvTDvOFNLHtFcKA/7zsTPb+OCLS2/eYuSYA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VoWZpMP+z6reSVuq44BxnVDfA+2Vbetkybx6/wz3rl4JjtdvmcM8n5ibJG32yjcQT7Nf0sa6/5yznKdYv3SnIPz92KjyY/PxWA3oHRfrIh5ad2Y1/OOdMipTYI5VuEO/OTXojlCK4CAt0YtDPJP87/0sZ+z4NGZT7e1xlfU7eeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fdjgAO51; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fdjgAO51"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E505A1F000E9;
	Wed,  5 Aug 2026 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930026;
	bh=0//inXX7Q6/nffyXkuo+oLgzefxGGBA0D7MriJhzsfs=;
	h=Subject:To:Cc:From:Date;
	b=fdjgAO51Cozl92aC4ntrm1+4Zh+OhfMeD+Uo7loY7+fe108Y420b/z/YOtUmx8zmc
	 TzYmUeEQ3jKAL0mc0L9WTfn87KLUhRcWxIFl+iyV15bLEz8BOAb6MpatzoR6eGosRf
	 3URXNa9gwfWUdbi4RtqCSk1lEdD18/9QFC26CRPE=
Subject: FAILED: patch "[PATCH] s390/pci: Fix s390_pci_mmio_write syscall error return" failed to apply to 6.1-stable tree
To: schnelle@linux.ibm.com,alifm@linux.ibm.com,gor@linux.ibm.com,julianr@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:40:01 +0200
Message-ID: <2026080501-geology-secret-5a4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b7ab86bdc65eadcfc43a0e3faf682a3f750cfb96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080501-geology-secret-5a4d@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b7ab86bdc65eadcfc43a0e3faf682a3f750cfb96 Mon Sep 17 00:00:00 2001
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 22 Jul 2026 15:08:34 +0200
Subject: [PATCH] s390/pci: Fix s390_pci_mmio_write syscall error return
 without MIO

On a machine without PCI memory-I/O (MIO) support or when running with
pci=nomio the s390 specific PCI MMIO write syscall checks if the MMIO
cookie is above ZPCI_IOMAP_ADDR_BASE as a sanity check before even
trying to perform the MMIO. If this check fails the return value was
left unchanged and thus 0 from prior operations falsely indicating
success. This could potentially confuse user-space into falsely
believing the MMIO, on a mapping not valid for MMIO was successful.

Fix this by setting the return value to -EFAULT prior to the check
following the same pattern as elsewhere in the same function.

Cc: stable@vger.kernel.org
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Fixes: a67a88b0b8de ("s390/pci: remove races against pte updates")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 51e7a28af899..f3f79ba78410 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -188,6 +188,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 			goto out_unlock_mmap;
 	}
 
+	ret = -EFAULT;
 	io_addr = (void __iomem *)((args.pfn << PAGE_SHIFT) |
 			(mmio_addr & ~PAGE_MASK));
 

