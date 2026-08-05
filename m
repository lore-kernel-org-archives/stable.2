Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1C743848C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930021; cv=none; b=EkT2AOLbsmEyZE8N60mS91KZFG9shFJLbQMRNvBKKo2fg96PCYbGW89J9SQ2AT7qau+eh6tcmITTTZD30oiqmjSdlqvnz51mPNgr5OlwlIDrQGUibi6GrG8LY/fJYDLiNIA+saeB59mCk215ceC4fGp+nLCMPAPYkz8WCidj9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930021; c=relaxed/simple;
	bh=5QJQA+HMlQP2PC+an9F9YzZRCeRyCr5dkDOFCgOMaIU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kHbrAUIgZlUlqtPsukmNiDDBQEEqBOoc71bx3s0NOIe2pWRzo+PceIoJha95Dk/A3A/Dkv0g8LGNpwOY+fBQTH2RGXqUVREF7ZXytR1Mf7byABE2GKfh/JH8HhEdldZd8Jy8QXbKYIpC4uYHuug/oaTIYZkkNFsyDkJmlEBLW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gvThiHX5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gvThiHX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62811F000E9;
	Wed,  5 Aug 2026 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930018;
	bh=IDJPDOAUDCr7AxP4gaHcKQW1iJt1qR7bVwdwFOz+6Ac=;
	h=Subject:To:Cc:From:Date;
	b=gvThiHX5hCEv1cH5vAggdXjN8ao9a+860YaAjYOqBfCb+blqr0IEcEtxnQCNGPx2L
	 ByH7kJQRCBc/kO0C/lAqUHoHHYmrIG0dJpEuzAFQNAh27yYhEf3rUCOnmyyxxkB28S
	 XGsqOLRa1abq6AFn3w2I3B1QAzi297Fh+SZ6goPk=
Subject: FAILED: patch "[PATCH] s390/pci: Fix s390_pci_mmio_write syscall error return" failed to apply to 6.6-stable tree
To: schnelle@linux.ibm.com,alifm@linux.ibm.com,gor@linux.ibm.com,julianr@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:40:01 +0200
Message-ID: <2026080501-police-riverboat-1b49@gregkh>
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
git cherry-pick -x b7ab86bdc65eadcfc43a0e3faf682a3f750cfb96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080501-police-riverboat-1b49@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

