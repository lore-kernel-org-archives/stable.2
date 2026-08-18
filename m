Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAB047AF65
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787075873; cv=none; b=M0pYZTr8T5a9RqKZ0K91KEUIDAwXrYGQlqH2lKLLvhwARQy9ozB2l1DagvZINlpxao871zRLtedkaQHC9QUIZJNtrsilThoKtyGut5nIVgFqbWlRcznroRd6lQnQ2htoRNVrhSe3AqOkwJEL00n9i8BcSoGVcyUU7oObqHWhnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787075873; c=relaxed/simple;
	bh=HR7I/Rv+0Qgz8DlqLv6LWVlChV2EHKWycAqFjMyBqW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF7jk7cpvfCeLShFcjUb0EW68J+vOaE/uz6JccdDRAeypMXdM8RbfQgMnPB0m29a/Sa5NMVq1CFXEiUOObZnYVVgOvoWVnehDPWDKkssaoHySdjv1HM1DJmUExRxUz9zluIYapMRqgGq862a8N+80F3deP3EigQvpPuTPH57+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLAzgind; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLAzgind"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7798E1F00A3A;
	Tue, 18 Aug 2026 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787075872;
	bh=Ac/1VZjvsWRocdEDGsJDZs2a+ZC6CnTr9jKHO6X64Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aLAzgindGjrnUKxCuyS2O/uGBDa7Zgy6zKk4iYIX0wY13iZPV1UqwQuKnytFzfksy
	 e4q5JRJCaTpRcxwWh+ZV8dYImjZiltUmh+BuBQquWlUiLFNUTo71gLvzfhkhvezosZ
	 3pI9UDFBh7ov88TH62lWNf/AHE5u1tXwAiR0Q9vLKczBuS+pyU5BOJHHTYXSjRL2gi
	 +OpqzPPfj6aocQkuKGYSW6kLKeTul1sydABBEaW2VY6OSwM2G/Cj6SJ1AlAiRpcb+e
	 k+D66Wm4B5NmlC3UKM7VfQiOpV6Zucw8JBYzEBGDTUGnuPAoXz1sCeoJvosaJFYamq
	 ahcaxe8ggurYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baul Lee <baul.lee@xbow.com>,
	Federico Kirschbaum <federico.kirschbaum@xbow.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] ALSA: usx2y: bound the hwdep mmap fault offset
Date: Tue, 18 Aug 2026 13:57:49 -0400
Message-ID: <20260818175749.2748626-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818175749.2748626-1-sashal@kernel.org>
References: <2026081720-deviant-snipping-e432@gregkh>
 <20260818175749.2748626-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baul Lee <baul.lee@xbow.com>

[ Upstream commit 2ca1eea3cd17930daffe9e429a7c89232036ec24 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usX2Yhwdep.c    | 2 ++
 sound/usb/usx2y/usx2yhwdeppcm.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 0ed50be89271..eeafe580d038 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -29,6 +29,8 @@ static vm_fault_t snd_us428ctls_vm_fault(struct vm_fault *vmf)
 		   vmf->pgoff);
 
 	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset >= US428_SHAREDMEM_PAGES)
+		return VM_FAULT_SIGBUS;
 	vaddr = (char *)((struct usx2ydev *)vmf->vma->vm_private_data)->us428ctls_sharedmem + offset;
 	page = virt_to_page(vaddr);
 	get_page(page);
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index b988a4870de4..3f6e87f30f7e 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -674,6 +674,8 @@ static vm_fault_t snd_usx2y_hwdep_pcm_vm_fault(struct vm_fault *vmf)
 	void *vaddr;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset >= USX2Y_HWDEP_PCM_PAGES)
+		return VM_FAULT_SIGBUS;
 	vaddr = (char *)((struct usx2ydev *)vmf->vma->vm_private_data)->hwdep_pcm_shm + offset;
 	vmf->page = virt_to_page(vaddr);
 	get_page(vmf->page);
-- 
2.53.0

