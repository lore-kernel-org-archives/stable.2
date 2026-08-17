Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C141E6B2
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972298; cv=none; b=X37ANjno3JZQn7g5Y73+ZOS1hSYgmdjap1G3rZ+NIBBt0drKf2sPMU5Ejp5zJ8+89mh2EP4P8yGWWLudf0lmSNE9EwkjDJY2vzbMQSNHWMgXJs4tBT7b842Evp68ixYpefWdoanLPWZPHWQ3fuzxmj0WiiUFojn+NRzrhLHtzUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972298; c=relaxed/simple;
	bh=teS2ZFl9fLvu5DyDO8rFZZYNt/zL/TTiddNC1aYmkq8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oRIWzbLphbnMH/5siyysWFc77NbGln5sUyOkM4kcLXT/4wcdVtZRkDl7RKqHV5E84cimbSz+6kd0z1JMCHXNehYA2nMlDkp3jQCi/Ba5KTYgrEVzxz9RCXVJDB0DPG3Yv0RCiPcobCKnq8uaDfQ+zVRBDg5kG52+So5RuYVEYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UUYOw9+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UUYOw9+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ECC1F00A3A;
	Mon, 17 Aug 2026 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786972295;
	bh=2IlWTiv+kB8/Eh86PQWYfzgAXL0f9+nxmF1R+QIE2kw=;
	h=Subject:To:Cc:From:Date;
	b=UUYOw9+DL55xZiVXh4TG5ebHUX7LrvsyuLaEgBPGsrqsNf1g7hoJZtWiNpItiYn2z
	 qllxlwlHcD14FXpB/z9PF1aVLF6W9ABlnfI1+X+K2PTP7ZCseBZAeXuRHlK6EWYSkd
	 NASobd11KS8rZee49p66A3qJV/hQitBIdL9Rx/PI=
Subject: FAILED: patch "[PATCH] ALSA: usx2y: bound the hwdep mmap fault offset" failed to apply to 5.10-stable tree
To: baul.lee@xbow.com,federico.kirschbaum@xbow.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:57:20 +0200
Message-ID: <2026081720-deviant-snipping-e432@gregkh>
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
git cherry-pick -x 2ca1eea3cd17930daffe9e429a7c89232036ec24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081720-deviant-snipping-e432@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2ca1eea3cd17930daffe9e429a7c89232036ec24 Mon Sep 17 00:00:00 2001
From: Baul Lee <baul.lee@xbow.com>
Date: Wed, 5 Aug 2026 10:34:45 +0900
Subject: [PATCH] ALSA: usx2y: bound the hwdep mmap fault offset

snd_us428ctls_vm_fault() turns the faulting page offset into a kernel
address with no bound of any kind:

	offset = vmf->pgoff << PAGE_SHIFT;
	vaddr = (char *)(...)->us428ctls_sharedmem + offset;
	page = virt_to_page(vaddr);
	get_page(page);
	vmf->page = page;

	return 0;

snd_us428ctls_mmap() checks only the length of the mapping, never the
offset, and us428ctls_sharedmem is a single page from
alloc_pages_exact().  For a character device file_mmap_size_max()
returns ULONG_MAX, so the mm layer imposes no ceiling either.  Every page
offset above zero resolves to a struct page outside the object, and the
handler installs it into the caller's address space read-write; the vma
is not marked read-only.

The caller picks the page frame with a single mmap() argument and gets
read-write access to a page of kernel memory it does not own; an offset
that lands in an unpopulated vmemmap region oopses instead.

A process that can open the hwdep node of an attached US-X2Y reaches
this after loading the FPGA image through the same node; no capability
check is involved.

On 7.2.0-rc5 (arm64), mmap() with a large offset:

  Unable to handle kernel paging request at virtual address fffffdffc45d5ac8
  pc : snd_us428ctls_vm_fault+0x68/0x140 [snd_usb_usx2y]
  Call trace:
   snd_us428ctls_vm_fault+0x68/0x140 [snd_usb_usx2y]
   __do_fault
   __handle_mm_fault
   handle_mm_fault
   el0_da

Reject any offset outside the shared region.  The pcm hwdep handler in
usx2yhwdeppcm.c computes its address the same way and needs the same
bound.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
Link: https://patch.msgid.link/20260805013445.38283-1-baul.lee@xbow.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 4d7925184826..7f153a2fcdd8 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -25,6 +25,8 @@ static vm_fault_t snd_us428ctls_vm_fault(struct vm_fault *vmf)
 	void *vaddr;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset >= US428_SHAREDMEM_PAGES)
+		return VM_FAULT_SIGBUS;
 	vaddr = (char *)((struct usx2ydev *)vmf->vma->vm_private_data)->us428ctls_sharedmem + offset;
 	page = virt_to_page(vaddr);
 	get_page(page);
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 7c90214485d9..f1d5b4b797ad 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -672,6 +672,8 @@ static vm_fault_t snd_usx2y_hwdep_pcm_vm_fault(struct vm_fault *vmf)
 	void *vaddr;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset >= USX2Y_HWDEP_PCM_PAGES)
+		return VM_FAULT_SIGBUS;
 	vaddr = (char *)((struct usx2ydev *)vmf->vma->vm_private_data)->hwdep_pcm_shm + offset;
 	vmf->page = virt_to_page(vaddr);
 	get_page(vmf->page);

