Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59582429CC5
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930030; cv=none; b=rHTTaWE6vtxIFOf5kBxQ23aQG5dl732wdPxA3bv5HEzqva3BsJNmMfuUzuQWcuIS8j4FUjNElzS77+C9D++jwhYSjub13v9GbPBzJP2yujqdpr85wvBm9ho43xh1fOzOggpZpXwy50qEqtUBRj2YnKIqns8Aa9JvvaNixanBPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930030; c=relaxed/simple;
	bh=ist0MthdNtpeuNb0lB1xbiciFVRF5zKn6JUzzqCjJKM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M9gwAZ60kmrum0/JgH7gRP0ZbOTiD5kBv306camFZnA58cbOfdoG2tfk2kla2kaX6SAnzKelKhZAyg+NJBahq2l5bGTyifXtd72lqiJB5N/a9a1HR68fbg1k6J7uDtFbBzS43SUgaLwBkF3E15sFK6zBDasN1m5i63PgdciJhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZH1WZ6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZH1WZ6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5211F000E9;
	Wed,  5 Aug 2026 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785930029;
	bh=ypkGY7D9n+p1HKhltVE3bGNW/yfMTgDJjAj+vckRu5E=;
	h=Subject:To:Cc:From:Date;
	b=DZH1WZ6rqGQbHDIw2Y8y+qs5T19/6uWnUSgQTRubxQlGckNrdmqJ/AG1sjz1Eh7Fq
	 /z14CBNqzbH4wma7puE8eaAKFMhETKCUXcHSzlpfcUPToRA5WEfFhUT9TWtb94htqe
	 3VDi6fmuDfvHiHl3HQTOLu1QDwd31CIF2eUBPViY=
Subject: FAILED: patch "[PATCH] s390/pci: Fix s390_pci_mmio_write syscall error return" failed to apply to 5.15-stable tree
To: schnelle@linux.ibm.com,alifm@linux.ibm.com,gor@linux.ibm.com,julianr@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:40:02 +0200
Message-ID: <2026080501-glitch-overcome-a5b8@gregkh>
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
git cherry-pick -x b7ab86bdc65eadcfc43a0e3faf682a3f750cfb96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080501-glitch-overcome-a5b8@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

