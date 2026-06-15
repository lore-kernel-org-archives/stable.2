Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0851FC7FB
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547420; cv=none; b=dchD80kSOPtWqImUcF/mquzjyvRxiFxjLTHRIe6kyB/NEz5qKBcHleje5Pjm4YwrKhlpgHkYiHJ/6LrQWqP6QP/+kT78u+OyDOf6YIe8RpsgUp8bVM7fO90INhiZuB19usA1L67nJU5B+xCnzh2TnpL0o7gKqUGejMB/aIOT7wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547420; c=relaxed/simple;
	bh=sEXdGPedN6uN9q5DklVj6sClgG2bCpleL0pOtLB5loY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQNf7Pix+gEBqhzQQjoCYoNdlQpMSSvO1QSYwPvG+2WXCEvRDv/2rFNPZmwkyHWSYMgjT5g/6WA275gq63pC/T6Rl2p72v5KUsxqTGi+x/crBbOG2xk6F8pnkThiAo+cKd36HgF7aFdGXQ8uA1ujpzckkCQquTEGnbSnxwTDWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9TFxH0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9TFxH0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0631F000E9;
	Mon, 15 Jun 2026 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547419;
	bh=MvuekgrwLluhq3EMFmKJmqEg4BTJCrhLfG9w9BjvU2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G9TFxH0tIiKTLM3/P5mKtabRgS5y/uOO3JLxbHqMd354sfz5sh9m3hST+vpQUlyA/
	 t++pfKExUyOnNLjsHocsgcAwggTCpu5OpqRkkHF8cO2FF2Qw3ucptq865FHrDLA+DB
	 oknvvW0990nK2xA0t5H+pOPxHDj+W6Zl6lEZtPhXi47oCfV70IyeDZrnYJW+T6HeP7
	 pRsZDmKRwsgoOBFIDRpXMrhPlRGsz7qYJFZ4alXx21pbispwJ7rdN7N7Qk+ZxsgzxP
	 Mm4eDiQlBC6ug0jMqkufYSAwCZME19cJXX9k0rIsn5XOTrPNxzbq8t6HyKpv6FrOxE
	 7CfANPRob7sZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Leontev <leontyevantony@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Mon, 15 Jun 2026 14:16:57 -0400
Message-ID: <20260615181657.2320366-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061524-eatery-geek-6a96@gregkh>
References: <2026061524-eatery-geek-6a96@gregkh>
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
index 058472f429386d..1e374de5cf8e63 100644
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
@@ -956,12 +957,22 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
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

