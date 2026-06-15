Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C62EA171
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547184; cv=none; b=IEOK3IUpt5llBslaCIhzYVnuvIAdPaS/gSYB8OzaGcwuOH8AG6ZN/751X0LydDPxTZntDWWKjyMRpyL+DpC5QHUhP1au5yQklVzCYv2Rf3z9fSvSWfA2WSmh0gqI54ZoqS5tMB04xtmzSVVwI7VhF8PVz3JVpSRWTVEzu6AK6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547184; c=relaxed/simple;
	bh=xzCgYMjpgAmReXW/sSLU+gYIo700v43ypLqcCd85EQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGCOqP8vKAOxwPMyhzvUTwJEgOJWIJTFBmp63b1upCa1X+e4SqIJA/F+ySFNmDHp0ZwzqT/ecU/Ka6vDF2ajft/C/9N2nccTos3RpHCAhU082akOg2g7KjhpKWU+vOk5azS0dMIcpCUcgEPp42rbu45as3cy3+Vk8pKBqDXlR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7zsDVLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7zsDVLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80561F000E9;
	Mon, 15 Jun 2026 18:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547183;
	bh=n2s3pbYmQnmxSsDcm8pHeqiI96srv2pR6iW+DTFIvw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U7zsDVLtPQMDT0dskfO6WoP55trJl9Ur5gFFrjaiDNfenZ7/Jk1lhdxt8ul8KX5qs
	 nQClzExIn+MOWWdGNRSH2Gq8lAi0P7dIY7+L1H9m16CE7ji6Td71+t1Pk6I6d3nwUp
	 30YlZBSp/xxllrGddQuuWe8IitzrL3A7RWGszYAYycEURtVflHu8OyozJVcRjWVZ1t
	 Ey6WWPr/ScLtxwRdehYr5fVCbMFqcZvCAUlpqLBR/K3XO3hd8bpt5KQIbNUr/mlXa5
	 XS8WGKy4cc/3VttXXji8gcfPQpdfPEdg+Xy+UjJAeb6Adfri5XHSaquM36qc3FPBd4
	 WIDHpr9LUVsIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Leontev <leontyevantony@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Mon, 15 Jun 2026 14:13:00 -0400
Message-ID: <20260615181300.2319407-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061524-importer-bogged-4a5f@gregkh>
References: <2026061524-importer-bogged-4a5f@gregkh>
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
[ adapted `phys_to_page(paddr)` to `pfn_to_page(PHYS_PFN(paddr))` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index ac2d706ef2d0ef..077595b42d4a77 100644
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
@@ -992,12 +993,22 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
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
+			char *src = kmap_local_page(page);
+
+			memcpy(dest, src + off, chunk);
+			kunmap_local(src);
+			dest += chunk;
+			paddr += chunk;
+			len -= chunk;
+		}
 	}
 
 	if (padding)
-- 
2.53.0

