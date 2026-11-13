Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599744;
	b=TRlcx5ZYH2dsVKan8qRPseicLFYLv29ZKOEX1ylKj05VFwOlGVJsFQE5kmt+pJ7/6P7n
	 QRmJvEHHUAuqWkMqJ/B7zc1ZnMfEvwpBJ7EogWti66krxnka+dVzt4QTh/ChpAbzRUI1M
	 vfqDeivTUd3sRRXbXkNniMJTkkF4INWVfaqI1GBs7/I4JC7Ic/Xe/EUz/MlvhR0XqGSvR
	 4l6EsqhBuASoG6Sssld3UXNRm02J0oIUbnHEqcJARX662knVkNVARceFCOBWcYj06Uxet
	 UYzwRjDV4kreDPa+Cc52WFCd87AD+lE1SUSPUGgTr5ezMrQYok85F5cXxr7SZd3w+uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UeGRg/WkJsGVpuyAFSuDrs2zUW/JrhTUImqKDlhPu/Q=;
	b=eTEDUzXDJx0Ah4a1U5MWGYuqncpC9ktP9Z7/7I4JIxjVX/lg5CkjUymmSJEO35j6u+Y5
	 Xpl/U+oAGG4Py5uqG55UaXU483X9C/KilgiguNWXthqG4hg3YWx2RwxoKCCfz/dNKf5/7
	 PqVfct3p9nW/0OdiHl5ZY7n+ba+R78UnsNsc+vh2/MocC3lkv1c2c4Ktd1I3AQOyHfWon
	 LpXbB9NSCShYQmQ8TXjnfI13IswZ3yZpfAq/rRdNP1tpO0tcvKcLE2I5iAWiW5oNKgdCS
	 5MnGfDGe0dIsXtGzjImAXO1y/lDV+CRHpMBC/CGdWkmC8zyiy1jifaVfW899ak1fb8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SdXigQuA;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69F606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A69F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=SdXigQuA
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-55c38cdd5b7so3150001cf.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 11:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794599743; x=1795204543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UeGRg/WkJsGVpuyAFSuDrs2zUW/JrhTUImqKDlhPu/Q=;
        b=SdXigQuA9rPRYvsQD6lB82QqbJ8PJOW0/+lBYrX7DoW1Qe9DozLFb5Gm5MXihOvhPn
         /PSboJd2ORILXHF3rAj+6g2jCpwvYK/MyvfDt78UvVwVyRdvxIlr3kCOB7k/fl8NU8a2
         3Zb7lo2khGTNEQDxWViYNqTcJ+x6SUjpBuLNe+YAgCvKQ4k8BjtKSP/bZmrqHk7KS5G0
         Cj4YIlvALfhcWWhQgl/onRylVBwzQnzPWNMXVytB6T2z/LGxtIY/Zt4YCg03HPdIYjhw
         QYZhZHCUDxVx9jh+qkOFKPiIx5GUzIxwBVP41Twzfdo4M7bYSzPxH9aUhWqwMvXGL3cc
         UU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599743; x=1795204543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UeGRg/WkJsGVpuyAFSuDrs2zUW/JrhTUImqKDlhPu/Q=;
        b=KFJPhwh1PUKPboh6k1euiY5cgfnavkyPh3DAk7+5/NU7Hi2tzKkXbw2bwnn0w+n4PS
         EOt+DKr5hIRcuNsjCmjawg+O5Iq6ngUBfVSIBaREypsmTdDpzliznD7fQEkd6EBIu3lv
         So0EZ9qvl7AJ8R0whZUJX7d+a1cq2fTzX4E79MZ/Pgc9ZZagXNCClok+X5GHckTV7H9w
         cp9HGn5O2021En6HSh2SRz1ZNynVYp7/KkbjR4kswxuBCBNPRC1W6/3ETYTTgNKAsiWl
         gqsvLXvc2WDUapc2TIHCNndO9ya3WcOlizICDVdZKviNhtD14BaepgzcZYdZE3nL3UB2
         QDjQ==
X-Forwarded-Encrypted: i=1; AL+hErHme0xqBrh/hjz1LZ+OZ6Cz6sND9WOZVDL+hzx8hw6iTv69MvD/YjwQu9ZWVQ3W2ILfUzsg1L4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Xx7sty/p1ZE2UvkTolQts7y/wsbzUMbNVqOwN3OxVdPXU125Y
	2tT9HQRmGB1iETemtnQXvXTEiewZjTAHCNu+QEPTxb58NA3NTTCTCUPuuaom4U01gqw=
X-Gm-Gg: AYBFou3DgxIVeqSkQTHSEQvtwDi8BH5o5HQ/RtvfeXpDx8OtjedXc583x8jvzYtAVIE
	NfqIRxumEybU1Bhg8JQURXo9C0gtPlro10u44NUHB+KUaV/JeTE6Utrdi1DwRoQgcvzBj6hraXe
	Kvx1r11cUcb2XhFQAFOJjeP1cXmcHS2yNQi4uTdAxBI2bLcgVggt3fAOm1uQTq/ywj+5vzhvSpQ
	+8N7C3u6MPmtay/hWo+RLoosEztnxD2wasfA52koF4ViW/q+zkiq69C2Bn0sH1r0Bd35WMzKFz3
	JiVbQ+eEdmEtKEQ4ReKnTqc1MmKeyY86ZgSXecc6fAeXGBokQK7IeGUXjLFZrmksP+Z+bnJhFLl
	CUtYgy/L3jNNWpefATEmp9FC2q9DisDEYsplKUJ+0UefbXeA4CmcT0oGoJP8bFF6gjEGBur+RaI
	E+30iRmLfEk/LQZpOfC1FY9Eio/SczGv5h9LpAXRH8oN+rT3rU2fA1dMSHYw1JjM3oiIEpoEmir
	lhUQxIailVRZfOVH9U9heBoKhCN5gPkvwNvkCg2rGJzDEZN7zUIOqlPCKbpQTfZT0Q+DRzrs+X3
	iBuG0TwMoIsY/EEmg4P+rzAdYSxrTx+FDE4vooKh9YeBhOvLsy8RrtG/CBwvUEyt2MB08N+x0Pw
	/WOSlWt/hKP/y+70=
X-Received: by 2002:a05:622a:258e:b0:533:2c5b:d668 with SMTP id d75a77b69052e-55ac8894504mr59124981cf.30.1794599743447;
        Fri, 13 Nov 2026 11:55:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad0a231dcsm25486351cf.13.2026.11.13.11.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:55:42 -0800 (PST)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	rppt@kernel.org,
	stable@vger.kernel.org,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH] mm/hmm: reject shadow-stack mappings
Date: Fri, 13 Nov 2026 14:55:36 -0500
Message-ID: <20261113195536.2660763-1-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HMM can grant ordinary device write access to a userspace shadow stack.
On x86, pte_write() is true for a shadow-stack PTE, so a populated page
can be returned with HMM_PFN_WRITE without taking a CPU write fault.

Nouveau translates that flag into a writable GPU mapping.

Reject shadow-stack VMAs in hmm_vma_walk_test(). Use the existing
unsupported-range handling: a requested fault returns -EFAULT, while a
snapshot records HMM_PFN_ERROR.

Link: https://lore.kernel.org/linux-mm/20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org/
Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
Cc: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/hmm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hmm.c b/mm/hmm.c
index 2f1e98c6b644..fa61ca59d927 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -596,6 +596,7 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 	struct vm_area_struct *vma = walk->vma;
 
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)) &&
+	    !vma_test_single_mask(vma, VMA_SHADOW_STACK) &&
 	    vma->vm_flags & VM_READ)
 		return 0;
 
@@ -607,6 +608,8 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 	 * allow write access either. HMM does not support architectures that
 	 * allow write without read.
 	 *
+	 * Devices must not gain ordinary write access to shadow stacks.
+	 *
 	 * If a fault is requested for an unsupported range then it is a hard
 	 * failure.
 	 */
-- 
2.56.0

