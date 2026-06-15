Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32452F12A5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556586; cv=none; b=N7Iy85a1w1comqPHHf9t1cf1qwyAPR2W0jj74rwzUTYITPmyrG9ct7Uke+ubkecEgKO82uRMcgD5vQkWkyh4w7pSQG387r3cSqU2yOtviBflE8hVTYRzaE0XzEkq5iQtHSBf0ZzDprarCHxTRzcDRII+AU+e/Vf0yoqlOgvD1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556586; c=relaxed/simple;
	bh=vU6SeFZEvesaWJgF94pHClkWILz66+P5k6YR/W6EJNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIGafLtmKDzu3AbWaS2DTRSXsfSskX/YlNtpEDrq4XdXKYI0wSxZA0XAu+tnIEbT/BfcHhgm/3ETetq6DdewlEM3B8p8PTFR4Qsfjy2giupIt83brae2nrb/LUw0xS7ZFgWlMPKeYM1XDkEpmmel2Peri1PJD+3Mlis5AO6zrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YppWFmMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YppWFmMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AF51F000E9;
	Mon, 15 Jun 2026 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781556585;
	bh=VP6r7anPOT5LZGaZ9Y4DA+x33E3XjzAn1IZ7W9UchXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YppWFmMvfBiSatZWBpy51EI48k1l+sxUR+PhT4mZVWrz7M3eC16GIExIBIuxblCMm
	 h1Aa3jdYbyONPO5UpZgwDQJmpUJvslDa4y6nE7XXJwRMc1/bqY/TCkpjyr5yCQmf+L
	 HDMclr4d/1mngBBkAaFAgBPcVSBTJX+S4YWNSl1uCdFQ7FzwLe7EIU9aHuEyQDN4dg
	 BqvPL76aanP/Mra4tGQz/V1fA+XsCHVKaRLrtCLzIQcKqt/CotT0oahKzzf5UFOQ1n
	 w15gOCVK6uX1e9KMU8NXSOvmQXgCDW5VVJ4H0Ny0ELPVzShhv9NGcrIjKLO8aoR/LJ
	 9AL1PFZkmq+mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Leontev <leontyevantony@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Mon, 15 Jun 2026 16:49:43 -0400
Message-ID: <20260615204943.2445304-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061525-bullpen-capsize-33af@gregkh>
References: <2026061525-bullpen-capsize-33af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anton Leontev <leontyevantony@gmail.com>

[ Upstream commit 004e9ecfe6c5384f9e0b2f6f6389d42ec22789af ]

netvsc_copy_to_send_buf() copies page buffer entries into the VMBus
send buffer using phys_to_virt() on the entry PFN. Entries for the
RNDIS header and the skb linear data come from kmalloc'd memory and
are always in the kernel direct map, but entries for skb fragments
reference page cache or user pages, which on 32-bit x86 with
CONFIG_HIGHMEM=y can live above the LOWMEM boundary. For such a page
phys_to_virt() returns an address outside the direct map and the
subsequent memcpy() faults on the transmit softirq path, which is
fatal.

Map the pages with kmap_local_page() instead, handling two properties
of the page buffer entries:

 - pb[i].pfn is a Hyper-V PFN at HV_HYP_PAGE_SIZE (4K) granularity,
   not a native PFN. Reconstruct the physical address first and derive
   the native page from it, so the mapping stays correct where
   PAGE_SIZE > HV_HYP_PAGE_SIZE (e.g. arm64 with 64K pages).

 - Since commit 41a6328b2c55 ("hv_netvsc: Preserve contiguous PFN
   grouping in the page buffer array"), an entry describes a full
   physically contiguous fragment and pb[i].len can exceed PAGE_SIZE,
   while kmap_local_page() maps a single page. Copy page by page,
   splitting at native page boundaries.

The copy path only handles packets smaller than the send section size
(6144 bytes by default); larger packets take the cp_partial path where
only the RNDIS header is copied. So entries here are bounded by the
section size and a copy is split at most once on 4K-page systems. On
!CONFIG_HIGHMEM configs kmap_local_page() folds to page_address() and
no mapping work is added.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
Link: https://patch.msgid.link/20260604165938.32033-1-leontyevantony@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 03333a4136bf4d..6972601820e4a5 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -889,12 +890,22 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = (pb[i].pfn << HV_HYP_PAGE_SHIFT) +
+				    pb[i].offset;
 		u32 len = pb[i].len;
 
-		memcpy(dest, (src + offset), len);
-		dest += len;
+		while (len) {
+			struct page *page = pfn_to_page(PHYS_PFN(paddr));
+			u32 off = offset_in_page(paddr);
+			u32 chunk = min_t(u32, len, PAGE_SIZE - off);
+			char *src = kmap_atomic(page);
+
+			memcpy(dest, src + off, chunk);
+			kunmap_atomic(src);
+			dest += chunk;
+			paddr += chunk;
+			len -= chunk;
+		}
 	}
 
 	if (padding)
-- 
2.53.0

