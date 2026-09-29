Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A9501287
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692268; cv=none; b=T62tkvvW10dMZWB1o3H1g/p5C22rS5wpgpxp6nJ1vk9sCl1p627hU9EbtLXp5xsqi+S9F+Sn+Y6apSn2zC+D42ArqIe0JosDdVflXMlTPYYQBXmGCJyGoaJIVDtXKu+SPnb9B0AEHjXi80ARDZ+QyG/AfxVlCPCjTyT/7p0Jl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692268; c=relaxed/simple;
	bh=7ldb8HOmjgXtNUqB8nPLQ9i0TZ7S1XWD7Hhe/UMCeKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTtiQa0vz/eWJsefu0yyMNaNhDhT1q99MFf7etvD3rT7vkabScxQQwREDw3WuEi/ReZ1TCrDMENQ+eAN5RozwQwgpIEM1Z3BLD0o2bZIyZxQXjn6ZAsNUGmAysOf//PjYC2eQ+uICzR4JMuwVwWAkejJnQlMu9myFe3z9vZFldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/csxjgn; arc=none smtp.client-ip=74.125.225.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/csxjgn"
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-4887dc16848so1038890f8f.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790692263; x=1791297063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fQTnQKTsS6Avi4kBaKDVGL1M647FRs0iTSqK5qxgUsQ=;
        b=D/csxjgnK9iJnOthp+PUCD4i+x0JR/wX7w2eF6ExSeBYWQOq51+cHy2KrNjnsy2jrh
         7E99RyFKU07q8rVJGKK0pi88FM2SE7MAef/zuIK5hR8MkPOw+SQ1xE1kEbZB5FQeJ9dh
         gna+q9HGWyDqg/+q2vWP3LZ2KrZcLLdfKSPVssejCoy4Uikmdc0NcE2Hw0vm4AXfSyLU
         rCF7+9m9Bx8hNnz5RPjucUTq9iS6Z9gh+0s/ZGoh1fhqpU4bFQ6TdQHiL+yqR6q5ppJS
         Why4BBqacyi8K9lnUUqPfDAglA/2C+ZCEKaiix1KyQhDR5NLmHIfg/6z+yP10q1mHXJv
         zLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790692263; x=1791297063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQTnQKTsS6Avi4kBaKDVGL1M647FRs0iTSqK5qxgUsQ=;
        b=DUjmM+seWayM58fEt8KiP9cR9o5WVK9B/pIch/aFg1IJqRIHhdcHJgxk2hJZj5/Dj0
         k7vOKFS6oKywD5faIpcEOz/MTjqTlx0Y8VbrH81gEd51HpELxovc7SZ4FEUkIJVuv8Vk
         SDmOI4hW87S4k055KGS5GAniHsToTbbLg2Zk5OgrmbsXgvTMpeFK7GTTWyKPKoKrWnfU
         hmzLkcMervnGWCDox/zriAH3UGHTVLQQzDINDeJkSy+uNHzPxNKDSjm7+bUHum4r8EZr
         tVoIFceKj4inwbA3UBz1IHPXnRMpUjWtTHanPbda9WwONos7uojYRNf1kZA6+9uy5z8S
         FoKA==
X-Gm-Message-State: AFq9FYL9uyIVFKqwrOng3PIsedGQj8h0F+r5KJyY78AMZeWnTbjlH/nC
	ZHX8jRJwJ6JW2SVmR9sNAZmFs5jAJPDkrvlFKab0nw8EENk22vsS8yMaz70memmZ/bg=
X-Gm-Gg: AYBFou1CTwsO82IptcAzsql3eWwesjUrRxCEAkn0kzXZ2acA/33nZE5UaAakRXsd3F6
	HbKlcZhW26x3eWS3i/aGFQ9StoPZQ0226jF7AX7PHtHkaqqkLov7bEbchDNRcFg/jem7qGsmOba
	AwCSIJhwr2yw9B0QMmk3hLnTp9M8kgGg7TS5xFvjWYCxmiRE/t3nB8VvuOuTWxpDkqUulvtu4N5
	1jmxn6IJGTvhnTOy6NWMtyBM/k67ArDgOCMrxCJhSmsqn78KyRE3ghCHE1nIS2nRUYJVg03xf0n
	WgZ/+VKF/ZQ5C89n2aW+W9TluV6LkLlpPR70hpHXxEenESX+ofUi095Omrqgd7CAgSp3blJ+X/l
	yf3TPM9ngjqfAmFjokEMX8N7jK+NTAbog5A1riEp2IqBWkPEgGWVa/iarL7VwuYnHVn/nM9W+zz
	L04Vqkknos93nV/YuIBdsuyGvSfgyTEea7tlIbiU6/sxL8OXo2lmRovGHaToXL78CHApQrPRSxm
	xKIZlbbPDQ/BVd1
X-Received: by 2002:a5d:64cc:0:b0:487:212:a412 with SMTP id ffacd0b85a97d-4887165f6fdmr32380213f8f.9.1790692262433;
        Tue, 29 Sep 2026 07:31:02 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af5030037sm5196243f8f.8.2026.09.29.07.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:31:01 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Betkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleinxer <tglx@linutronix.de>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yi Lai <yi1.lai@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 5.10] iommu: disable SVA when CONFIG_X86 is set
Date: Tue, 29 Sep 2026 17:30:34 +0300
Message-ID: <20260929143036.82392-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

commit 72f98ef9a4be30d2a60136dd6faee376f780d06c upstream.

Patch series "Fix stale IOTLB entries for kernel address space", v7.

This proposes a fix for a security vulnerability related to IOMMU Shared
Virtual Addressing (SVA).  In an SVA context, an IOMMU can cache kernel
page table entries.  When a kernel page table page is freed and
reallocated for another purpose, the IOMMU might still hold stale,
incorrect entries.  This can be exploited to cause a use-after-free or
write-after-free condition, potentially leading to privilege escalation or
data corruption.

This solution introduces a deferred freeing mechanism for kernel page
table pages, which provides a safe window to notify the IOMMU to
invalidate its caches before the page is reused.

This patch (of 8):

In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
shares and walks the CPU's page tables.  The x86 architecture maps the
kernel's virtual address space into the upper portion of every process's
page table.  Consequently, in an SVA context, the IOMMU hardware can walk
and cache kernel page table entries.

The Linux kernel currently lacks a notification mechanism for kernel page
table changes, specifically when page table pages are freed and reused.
The IOMMU driver is only notified of changes to user virtual address
mappings.  This can cause the IOMMU's internal caches to retain stale
entries for kernel VA.

Use-After-Free (UAF) and Write-After-Free (WAF) conditions arise when
kernel page table pages are freed and later reallocated.  The IOMMU could
misinterpret the new data as valid page table entries.  The IOMMU might
then walk into attacker-controlled memory, leading to arbitrary physical
memory DMA access or privilege escalation.  This is also a
Write-After-Free issue, as the IOMMU will potentially continue to write
Accessed and Dirty bits to the freed memory while attempting to walk the
stale page tables.

Currently, SVA contexts are unprivileged and cannot access kernel
mappings.  However, the IOMMU will still walk kernel-only page tables all
the way down to the leaf entries, where it realizes the mapping is for the
kernel and errors out.  This means the IOMMU still caches these
intermediate page table entries, making the described vulnerability a real
concern.

Disable SVA on x86 architecture until the IOMMU can receive notification
to flush the paging cache before freeing the CPU kernel page table pages.

Link: https://lkml.kernel.org/r/20251022082635.2462433-1-baolu.lu@linux.intel.com
Link: https://lkml.kernel.org/r/20251022082635.2462433-2-baolu.lu@linux.intel.com
Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Betkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robin Murohy <robin.murphy@arm.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Yi Lai <yi1.lai@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ The context change is due to the commit
  be51b1d6bbff ("iommu/sva: Refactoring iommu_sva_bind/unbind_device()")
  and the commit 757636ed2607 ("iommu: Rename iommu-sva-lib.{c,h}")
  in v6.2 which are irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2025-71089

 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9d65557dfb2c..e3f1496013b2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2988,6 +2988,9 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 
+	if (IS_ENABLED(CONFIG_X86))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (!ops || !ops->sva_bind)
 		return ERR_PTR(-ENODEV);
 
-- 
2.53.0

