Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E5255F28
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893692; cv=none; b=jG3LeruOjF8nBLGsT68kZJaNuvNufLFigf41n8EyW2j2kHi9UUkfffYB+uJYwqnoftriReQCbEIx37qXLNpEZRAMDxHQg5pyOTtV6yxmKHFObPbqfak4hVjlZMhF5DWPeaBKqF/VfaD0omSb/N13QsJk9Hy99+AG8oKY8VfsTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893692; c=relaxed/simple;
	bh=AJuzXvTVkuXVly2Y8ZK0t17Th3ASi5G8hg6K20mj+/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFJJdIeV2+9nSQgYACElttq1tRge8wsWCXcvn/y4Roy2exDABt6GUByb5eLfbjsPYOteOUlPg9PMG2RDwu3yeBK3tdPX9Rg1KPLPunKQXoFX9oLyeFlO/YCWNsabaKoprTn7P3keonOuIxbySV5g+S1IdBOseL4fdXJ+bi5PjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=Xh721U6Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="Xh721U6Q"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce7d2adef4so7119735ad.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 18:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785893690; x=1786498490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M89P75fJt691dQNC6UtNzIeiGuPM9Yb1WIZo+b/oH0A=;
        b=Xh721U6QTkDYXqkQYdBEn/9y6371RZZ/S+iVtFl6oVmQqoDwgEwDqZ7fV+Dx2W/9Ha
         QTGOLKBdpFRzoavZdnvPoifYWSqAS2VPulTkNUDvogs8TPfgcGQSJpdoDd8HaEuoUN8s
         TKpaZhJMY417qvTe3GxtTyxXLxli69btVL6yPHknLqfqkrHhYbOieN2sUz5W7Dd2h6Ds
         9DfJ0VIqsgQ8C2CVHMMYyetSmOs4P4REiEni31rqwdRv8JbbJmRx29S0Wa0T4YraQjRj
         CdlDWJIrURgV/hTxSWmb0HuMvZn6VCOug2YNsNdtYwvHFPJW50lKIf2SQcBFe3OJCCbb
         OZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785893690; x=1786498490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M89P75fJt691dQNC6UtNzIeiGuPM9Yb1WIZo+b/oH0A=;
        b=UoC9X/iJU6SQqVtxXnIFu1uoUArQ5heV3k9E/wFSXodzNWF61rkpGWUnkweC/FL/dV
         Sl9voWgw3dwK1WfvwtoBNt7tWaIXinbTB/6IKL05yMFcKbvWi2GY2W3UttAoe9Kr1jJl
         ph8VC5XQMcph+qQZODKlzUHsilLoPUqvetZ/Nu8u7/AqpXwWhhSsUsF036zUb4547KtO
         C4L4kRlCgRfATb0IXqXkaXzIoIknVn9oLKEILGzccbUP2ZC5+JceTvAD8kPHUlGqIODF
         DsE2Ji0h3kolbLu/scZH1XwzmvCyD7Qfoa7BL1QtCcvdmb63Yxw4DUiA1BSnDT5YuFIQ
         t4iQ==
X-Forwarded-Encrypted: i=1; AHgh+Roh46JBpidOXZymtCmNK0BrWxyGnqb6G4LlXcrDZ0gMfcJFZ68wtWW7cBrmMBpmkriEgFCp6V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQVzd6i2V8IcE4LkVmaJEDx2LTdbf39sxdI3p2uOzTcHwLU/+
	ieZO7E4HOVRHYe5BhY6rK9OP4+4VZkN1UBpe39Ma8laOuiVcK5/JNg0Vwp7n2eEEQL8=
X-Gm-Gg: AR+sD12lIVZDymAI0dDHCKyFOupI/ETLgnQEeCdqXTFGbeJ4E1fEI1WRNn7QVPJcYa/
	AzN+K8PuoXjhrANAECnKUnFOzBbSQsyumXrNmgqnApqtzBTuyeRtdZDEdlloAsQWIPT4UPwn1+f
	6V/RFwB52XZdD1BbrGw4OdUgPbHlYc4IDtOY+qYPq+BjwLSu0Mk4Py6yumDNd7PPURpZdg8wq1R
	/GLpC0OZWHEW4XXGVYd8uepfoN/IdR6R/MxqLhN3y1swX1QccMeRMgy14IbBnXqDri5s0btP2vS
	Sfin7Q0yUpJAUAnKZ7Ql+5LHgrntw1n2DJUty05rNKk5sEQkr+wDXTto2afr0ZI/eJlH6XC8N9j
	oTyLlPVLBaN1opiImXEWTq/DRPtiucB46uuO3va7O6IF7tKRqTfYCfqKRJt6QAygAolW0kRgtED
	CPz+h8tQpT+qmqILPo3yP0pAPMKjHe3s948FpgdQNPpRD2Mu0f2CenioLY0uztNXDLFKf/mIBXv
	MJb93Qj9gJE288PLJBXHMiFS966
X-Received: by 2002:a17:903:19e6:b0:2cf:b23d:77f with SMTP id d9443c01a7336-2d0ca984ba6mr36054965ad.20.1785893689963;
        Tue, 04 Aug 2026 18:34:49 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4b9bbasm13275535ad.60.2026.08.04.18.34.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 18:34:49 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] ALSA: usx2y: bound the hwdep mmap fault offset
Date: Wed,  5 Aug 2026 10:34:45 +0900
Message-ID: <20260805013445.38283-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 sound/usb/usx2y/usX2Yhwdep.c   | 2 ++
 sound/usb/usx2y/usx2yhwdeppcm.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 4d7925184826..7f153a2fcdd8 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -22,12 +22,14 @@ static vm_fault_t snd_us428ctls_vm_fault(struct vm_fault *vmf)
 {
 	unsigned long offset;
 	struct page *page;
 	void *vaddr;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset >= US428_SHAREDMEM_PAGES)
+		return VM_FAULT_SIGBUS;
 	vaddr = (char *)((struct usx2ydev *)vmf->vma->vm_private_data)->us428ctls_sharedmem + offset;
 	page = virt_to_page(vaddr);
 	get_page(page);
 	vmf->page = page;
 
 	return 0;
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 7c90214485d9..f1d5b4b797ad 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -669,12 +669,14 @@ static void snd_usx2y_hwdep_pcm_vm_close(struct vm_area_struct *area)
 static vm_fault_t snd_usx2y_hwdep_pcm_vm_fault(struct vm_fault *vmf)
 {
 	unsigned long offset;
 	void *vaddr;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
+	if (offset >= USX2Y_HWDEP_PCM_PAGES)
+		return VM_FAULT_SIGBUS;
 	vaddr = (char *)((struct usx2ydev *)vmf->vma->vm_private_data)->hwdep_pcm_shm + offset;
 	vmf->page = virt_to_page(vaddr);
 	get_page(vmf->page);
 	return 0;
 }
 
-- 
2.50.1 (Apple Git-155)

