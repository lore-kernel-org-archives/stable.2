Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com [74.125.229.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A50381E9D
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970552; cv=none; b=HzYFuDZvlrihm/7usu7w7diU/+zfruI88Y0HaojKMXlNLRh4EqVzvGz0uydphTAGG6laWf3Sx0kTOCY5DUVoFErurMD8M1Dxo2tlnvffnHoCcyOCWwsuAnPpRYZwDEayCnvei2aUxrVDj+mupT3Qv+c8Y8/DtmN0Be7MEnA2PJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970552; c=relaxed/simple;
	bh=BA1c0FkHJccaJp4mZY2Xa5/jpWSQsLFKfIsyjBoOSVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMGZpLG2V06MNfitwnD9GoAeuhDyvdEfMWF9FdQFtX887d33wUPQ600l2JplLSSHqzKBtj9JAqOv6RhjLFFvGJvU8fWLO/28cexZ3QWgR9kiTOKVVH2QPDrTRey2jpKd6nlHPQ0DUtRHEOuCHva2Y7N3bFnILMdu21n35Ga0Ug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=QsejfObb; arc=none smtp.client-ip=74.125.229.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="QsejfObb"
Received: by mail-dl2-f39.google.com with SMTP id a92af1059eb24-1438cb9b3a3so7100611c88.2
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790970548; x=1791575348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Jk2g6BtdlmGdKtgGPAbggZvehqRrTlA+cJG1wv2zZM=;
        b=QsejfObb/wmxhikAczTsark7ZpSrYCvIQl5XPSnMm/hGeLmkfX4dgBuSqy5CgGEo2b
         fSZYLKo3Y0o9HWu2edVzj5GnPMsWOxTqDccXNCwmT/tZHdDu/Jr8eWsXFPojIkLYJVfE
         iH1++2yXRyQjDl11Edeto+CvX2m+DJMtlYNxSIcgKjpRZUlOSd61XyvkXuObjjoOQbjK
         OSofm00Jkxapfea2E+mJ08H8mF7QSWZ3rh1wqW3N9w0JfxS88eLQAB3dpYsX4ZmaW71y
         wFPWNX1hzTIXoJVQPFvzY+IcsE1Mq8OQ4LMzvxhvguDf59ezkJxL89PtZyEgSifzPxJa
         H/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970548; x=1791575348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Jk2g6BtdlmGdKtgGPAbggZvehqRrTlA+cJG1wv2zZM=;
        b=PXsq4Aos+U53stM02avnNCdsizdCymXyvZocdtLilu42C0IdHkYTdkHG9GRcVIXVUw
         SkHd/j5rKJ0waTRu1HWuYzYhRKlD3UHGDeHR+0PEt+JvZ0qRnWc9CoEZiWTpFicHDaD6
         4UnkJMGsnhd0VeTnROZLGZGH+OX1f/RBYLKaV7/9jjjk61jse0/h2/ojAVsWniL1vrc1
         +SjOfxFo2KgHferk5tG1Yhfk6Xb4RUEZA2cBUgI7mc3W0VGJPXPH7FRtsfv4/8YmXvO0
         LWdURVrbGvGs0xsIvaWXG1lhwSnGopHQl6mZL+traEe7lYblIXqLIAGlQ0EXvCNCi/3c
         Bg4A==
X-Gm-Message-State: AFuF++ndxjMu3tVu7KVnbZsz9+/w5BESCTg6ycKickDVkx9lSiOOo2Y1
	0GOGqC2Bqt84Rj5FSLVe3LMUG/OCnnoIAGGK9IbLv/L0pCgIFyk+9s9rwMWbPgGXABsVLjBU7ha
	HAwf3oFZueA==
X-Gm-Gg: AYBFou2uGAfJ5gjI5vmARkrXFhN1KyZRHOeV+YHVeCOvhFwN8tRMITGGuI/tc7VQnCU
	6uMDcxkxaw93CKANuYr/oMtzDvhSRVdY3pF+RqPjXxUancSFk0q4Sww3jBW5XnzJfBNKDmfvV4U
	YQPvesCmWDHSnGH4vrmKsX18BvuLn8yM63V/5aIHhkO0irSG2PwCiZQw7GN6ca+Vem1t25cc/Rk
	HaU5dKHzUsnNjCa/eF93xcGIAjJGzGJTnRVbQr0m1tefmoNEqG663xhznPAQRWxCYmM/aAMzG1q
	RhlKtNEv1FF20l5Kgo+gIMFICMaBylRVOdCQ7OfgtTLnrMEjy4E/EfckdijxuADonbBGWpEP3Dl
	c1PkYoq5HmNFaHDXo3Kq5/ncSjCuNDr5wD0XwLNEiU2XERK5RGAj0hecLgYcQvDfcUit+qqKPts
	BBx4YCXVaTDQaSpF698MH2JFyx2ka2ZEowE/WWxPieiJXui68+TYwQAetOUqtwJRbdcO8pIy8aU
	yISta+11LrPT60NI+k0FqdFWFfcGl7vxWEfP04c/oR47w5LqAPYTdZXg/gPNaW5eisBrUWdLx+V
	cN/0nw==
X-Received: by 2002:a05:701b:42c9:10b0:14f:b80a:33a5 with SMTP id a92af1059eb24-14fb8197636mr2873373c88.28.1790970548456;
        Fri, 02 Oct 2026 12:49:08 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14fae9b3dfesm6697431c88.11.2026.10.02.12.49.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:49:07 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Christoph Schlameuss <schlameuss@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	avi@redhat.com,
	cotte@de.ibm.com,
	david@redhat.com,
	mtosatti@redhat.com
Subject: [PATCH 6.1.y] kvm: s390: Reject memory region operations for ucontrol VMs
Date: Fri,  2 Oct 2026 15:49:03 -0400
Message-ID: <20261002194904.21236-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Schlameuss <schlameuss@linux.ibm.com>

[ Upstream commit 7816e58967d0e6cadce05c8540b47ed027dc2499 ]

This change rejects the KVM_SET_USER_MEMORY_REGION and
KVM_SET_USER_MEMORY_REGION2 ioctls when called on a ucontrol VM.
This is necessary since ucontrol VMs have kvm->arch.gmap set to 0 and
would thus result in a null pointer dereference further in.
Memory management needs to be performed in userspace and using the
ioctls KVM_S390_UCAS_MAP and KVM_S390_UCAS_UNMAP.

Also improve s390 specific documentation for KVM_SET_USER_MEMORY_REGION
and KVM_SET_USER_MEMORY_REGION2.

[ Backport to 6.1.y: omitted KVM_SET_USER_MEMORY_REGION2 documentation
  because that ioctl is absent from 6.1. ]

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Fixes: 27e0393f15fc ("KVM: s390: ucontrol: per vcpu address spaces")
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Link: https://lore.kernel.org/r/20240624095902.29375-1-schlameuss@linux.ibm.com
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
[frankja@linux.ibm.com: commit message spelling fix, subject prefix fix]
Message-ID: <20240624095902.29375-1-schlameuss@linux.ibm.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and kvm s390 maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-43819. It rejects memory-region ioctls before a
ucontrol VM can dereference its NULL gmap.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-43819
Upstream: 7816e58967d0e6cadce05c8540b47ed027dc2499

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 Documentation/virt/kvm/api.rst | 6 ++++++
 arch/s390/kvm/kvm-s390.c       | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1bc61bf804f1f8..1f0f84501e59c8 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1382,6 +1382,12 @@ The KVM_SET_MEMORY_REGION does not allow fine grained control over memory
 allocation and is deprecated.
 
 
+S390:
+^^^^^
+
+Returns -EINVAL if the VM has the KVM_VM_S390_UCONTROL flag set.
+Returns -EINVAL if called on a protected VM.
+
 4.36 KVM_SET_TSS_ADDR
 ---------------------
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c7b4c0d37c87b0..0caaa462baf6f8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5587,6 +5587,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
 {
 	gpa_t size;
 
+	if (kvm_is_ucontrol(kvm))
+		return -EINVAL;
+
 	/* When we are protected, we should not change the memory slots */
 	if (kvm_s390_pv_get_handle(kvm))
 		return -EINVAL;
-- 
2.39.5

