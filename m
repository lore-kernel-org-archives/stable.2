Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645162;
	b=47MppyVKdtqXUzdcFnQSHUnPMpMYfNcfv/VKz8Xl8Uba50kqxcGT+ObVn9Wdkchb0H/l
	 DhKt2J2UZAofXA8j93MXuQgbRA8DpH6MXxQGYt5rkGJf883qyWpm+Dpev8rV7knfF6skz
	 9ex2wLjy/t0Tts0BIBZA5K8NfS+8MqPnxWNaZ4l4QV1BZRWNL7ctsIfkzL9xZ1qlSKtnp
	 b+8QN7U9Uu7hfxv8MaNLFHBAyQY1yWgjjbKpcqtIvcx+dNbnd8jX/T2QdJnQJIjyABEIb
	 5n/W3H6BBNPL8Zv0RQWDLbpE3r6CcX36Vnqf0pz29x9VJnltcRIBRBgzH861op11jbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=/mM0J1a71Wn6f8VLov8bY8YKxe1QvMRR/3m9TE5bYfk=;
	b=A4gJVBCentMmlu46ZSZuHriR8dGk+VObnmkNgtsVm4YXzUBHmvZxOpCW29w3PtPyiKFv
	 vSRpvzes9s0u9qoZVHVXa9eveuhnxqukVwOshNdlav0UpE+d9XSUhkzu1klN/Qz9ZnkUy
	 cD2YTd3sjJDoG12nRfgtldch8l77qeZHJZa4s8ydI0mgRc07+Ib3FD0cemCHddIiH3LSX
	 5+dsFJS9ocP2F8hM23vVlUsCw3ng0lVdzKS75Kt1XIU0f/YEncEk22uzOchlzDy0wMlCr
	 XOmjOvONKbNB2oILE3IpZAZl1mc+ewcVQqI3lsPDqT6t9OM19rI4nHqjNBX6KcjdNFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XptYq2ly;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585C606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7585C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XptYq2ly
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3854627c1c8so8708213eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645162; x=1796249962; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/mM0J1a71Wn6f8VLov8bY8YKxe1QvMRR/3m9TE5bYfk=;
        b=XptYq2lyzTSfPHoG/56IlJIRAvm81y295rD9W2H96Omtasl9GpUA/jNFxqPQJ0aOC6
         6VAmQm9ZYh6//vPqJZ9SMdhrWgvFkWN456hvl8Qbd06efT0Hl263sPmapGYUZCl0m4/Y
         4p/y0P5mZkE2IYyHjj+Ie/0lnyOI9AuSaS9P7NmzYqIFcBqhrt3SaeARsRu60aPCDa82
         jZ8txShqP2aYVcYIOttaPOWbDLx5R+HhoifOtkWivTKvhv3VH4zIPt2DgSeCvyTmWQcc
         fKcmTfDuu2+BPXMkZcYL8nsgXazp2O+HurKTzBy9ZHkQJMPbU6Nm6WjSQCCmtzXVp6co
         HnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645162; x=1796249962;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/mM0J1a71Wn6f8VLov8bY8YKxe1QvMRR/3m9TE5bYfk=;
        b=L0alJnIEfdnqSdG+CbbH0hLP2V6bywvuJcG2LPTho+GO5cRwhsnBi4HMuCKJYM3LR6
         T0RhQYxQqsI1BXZHNmJV8tvGrnZG9do0lPUHYMsY/WpC+DnfbHMbjPfGS/zWiXbVF5PH
         sEMlg4o0QO1sU7+78gkikecXJLXAKOfRxle31qP8htVcC/Y66DdlWd0AxXEs4sXu7YiD
         DfCJTBpzs0E9DPGGz4fYLWF8GLHW/JR2OBVcz4tdYS2yrX01LjC+4mdQgSfCve7vX+Eq
         uua9dZVR+hl1hTGsUBuRq0rsHgwt6w0uA1vTl5QWKrA5eV3jmXu05WqIG1Beq9Vv0rxV
         r3lg==
X-Forwarded-Encrypted: i=1; AL+hErHoLEhouaN/ylzDaPZkvcuICjiKj2Ag40dP8pB8xqKxl/4rhEIWholkyV6UjKbJnz3aPJ4IeLw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Buskt7D7jKm2LPYdJ+rrEv30kbaUx69AGFjFDYki8IK/ze1Lq
	nS1RZKYEVakt6klOB47Oio+b1F2F8jY7VU9Kq1LpsjUkv+RzM2v8taZTFGw9IsBbVNvVXBi/+cZ
	bIA==
X-Received: from dycmb5-n2.prod.google.com ([2002:a05:693c:20c5:20b0:369:fc78:c914])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8955:10b0:386:9cae:abef
 with SMTP id 5a478bee46e88-386bf39f8b9mr6889141eec.36.1795645161387; Wed, 25
 Nov 2026 14:19:21 -0800 (PST)
Date: Wed, 25 Nov 2026 22:19:11 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125221911.1425213-1-elkin@google.com>
Subject: [PATCH] mm/huge_memory: check VMA end bounds in insert_pmd() and insert_pud()
From: Elkin Cruz <elkin@google.com>
To: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

insert_pmd() and insert_pud() only check that addr lies within
[vma->vm_start, vma->vm_end) without verifying that the full PMD or PUD
mapping fits below vma->vm_end. On a VMA whose end is not PMD- or
PUD-aligned, inserting a huge mapping at the tail straddles past
vma->vm_end.

Require vma->vm_end - addr >= HPAGE_PMD_SIZE in insert_pmd() and
vma->vm_end - addr >= HPAGE_PUD_SIZE in insert_pud().

Fixes: 5cad465d7fa6 ("mm: add vmf_insert_pfn_pmd()")
Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 mm/huge_memory.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e167c9ea4609..683f0c68d6b2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1630,7 +1630,8 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
 	spinlock_t *ptl;
 	pmd_t entry;
 
-	if (addr < vma->vm_start || addr >= vma->vm_end)
+	if (addr < vma->vm_start || addr >= vma->vm_end ||
+	    vma->vm_end - addr < HPAGE_PMD_SIZE)
 		return VM_FAULT_SIGBUS;
 
 	if (arch_needs_pgtable_deposit()) {
@@ -1771,7 +1772,8 @@ static vm_fault_t insert_pud(struct vm_area_struct *vma, unsigned long addr,
 	spinlock_t *ptl;
 	pud_t entry;
 
-	if (addr < vma->vm_start || addr >= vma->vm_end)
+	if (addr < vma->vm_start || addr >= vma->vm_end ||
+	    vma->vm_end - addr < HPAGE_PUD_SIZE)
 		return VM_FAULT_SIGBUS;
 
 	ptl = pud_lock(mm, pud);
-- 
2.56.1.839.g22a8290db9-goog

